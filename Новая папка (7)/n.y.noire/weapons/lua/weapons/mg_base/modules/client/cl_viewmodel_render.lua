--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/client/cl_viewmodel_render.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:PostDrawViewModel(vm, weapon, ply)
	if (ply == NULL) then return end

	if (not IsValid(self.m_ViewModel)) then
		self:RecreateClientsideModels(true)
	end

	if (ply:InVehicle() and not ply:GetAllowWeaponsInVehicle()) then return end
	--if (self.m_seqIndex == "INIT") then end --    return

	if (self.m_drawWorkaround) then
		self.m_ViewModel:FrameAdvance()
		self.m_ViewModel:SetCycle(0)
		self.m_drawWorkaround = false

		return
	end

	if self.ViewBoneOffsets then
		for _,data in ipairs(self.ViewBoneOffsets) do
			bone = self:LookupBoneCached(self.m_ViewModel, data.Bone)
			if (bone ~= nil and bone > 0) then
				if (IsValid(self:GetOwner())) then
					self.m_ViewModel:ManipulateBoneAngles(bone, data.Angles)
					self.m_ViewModel:ManipulateBonePosition(bone, data.Pos)
				else
					self.m_ViewModel:ManipulateBoneAngles(bone, noOwnerAng)
					self.m_ViewModel:ManipulateBonePosition(bone, noOwnerPos)
				end
			end
		end
	end

	--customization
	if (self.Customization) then
		self:RenderCustomization(self.m_ViewModel)
	end

	--rigs
	self:RenderRigs()
	--particles
	self:RenderParticles(self.Particles)
	self:RenderModels(self.m_ViewModel)
	--weapon sounds
	self:AnimationEvents()
	--blur
	self:ViewModelBlurModule()
	--attachments
	local atts = self:GetAllAttachmentsInUse()

	for slot = #atts, 1, -1 do
		if (IsValid(atts[slot].m_Model) and atts[slot].Render ~= nil) then
			atts[slot]:Render(self, atts[slot].m_Model)
		end
	end

	self:RenderInspection()

	self.m_ViewModel:FrameAdvance()
end

local lerpedInspectionDelta = 0

local function decayInspection(target, lerp, vel, springConstant, wobbleConstant)
	local currentToTarget = target
	currentToTarget:Sub(lerp)
	currentToTarget.y = currentToTarget.y * springConstant * 0.5
	currentToTarget.x = currentToTarget.x * springConstant * 0.5
	currentToTarget.z = currentToTarget.z * springConstant * 0.5
	local sqrt = math.sqrt(springConstant)
	local dampingForce = -vel * (wobbleConstant)
	dampingForce.y = dampingForce.y * (sqrt * 0.65)
	dampingForce.x = dampingForce.x * sqrt
	dampingForce.z = dampingForce.z * sqrt
	local force = currentToTarget + (dampingForce)
	vel:Add(force * math.min(FrameTime(), 0.01))
	lerp:Add(vel * math.min(FrameTime(), 0.01))
end

SWEP.m_InspectVertical = Vector()
SWEP.m_InspectVerticalLerp = Vector()
SWEP.m_InspectHorizontal = Vector()
SWEP.m_InspectHorizontalLerp = Vector()
SWEP.m_InspectVerticalAng = Angle()
SWEP.m_InspectVerticalLerpAng = Angle()
SWEP.m_InspectHorizontalAng = Angle()
SWEP.m_InspectHorizontalLerpAng = Angle()
local noAng = Angle()
local noVec = Vector()

function SWEP:RenderInspection()
	if (self.ViewModelOffsets == nil or self.ViewModelOffsets.Inspection == nil) then return end
	local insp = self.ViewModelOffsets.Inspection

	if (self:IsCustomizing() and self:GetOwner():KeyDown(IN_USE)) then
		self.ViewModelMouseX = self:SafeLerp(FrameTime() * 5, self.ViewModelMouseX, gui.MouseX())
		self.ViewModelMouseY = self:SafeLerp(FrameTime() * 5, self.ViewModelMouseY, gui.MouseY())
		lerpedInspectionDelta = Lerp(FrameTime() * 10, lerpedInspectionDelta, 1)
	else
		self.ViewModelMouseX = self:SafeLerp(FrameTime() * 5, self.ViewModelMouseX, ScrW() * 0.5)
		self.ViewModelMouseY = self:SafeLerp(FrameTime() * 5, self.ViewModelMouseY, ScrH() * 0.5)
		lerpedInspectionDelta = Lerp(FrameTime() * 10, lerpedInspectionDelta, 0)
	end

	local deltaX = math.Clamp(self.ViewModelMouseX / ScrW(), 0, 1)
	local deltaY = math.Clamp(self.ViewModelMouseY / ScrH(), 0, 1)
	local bId = self:LookupBoneCached(self.m_ViewModel, insp.Bone)

	if bId then
		--local halfYDelta = math.abs(math.cos(math.pi * deltaY))
		--local halfXDelta = math.abs(math.cos(math.pi * deltaX))
		if (self:IsCustomizing()) then
			local inspAngleVertical = LerpAngle(deltaY, insp.Y[0].Angles, insp.Y[1].Angles) --[[* halfYDelta]] --[[* halfYDelta]]
			local inspAngleHorizontal = LerpAngle(deltaX, insp.X[0].Angles, insp.X[1].Angles) --[[* halfXDelta]] --[[* halfXDelta]]
			local inspPosVertical = LerpVector(deltaY, insp.Y[0].Pos, insp.Y[1].Pos) --[[* halfYDelta]] --[[* halfYDelta]]
			local inspPosHorizontal = LerpVector(deltaX, insp.X[0].Pos, insp.X[1].Pos) --[[* halfXDelta]] --[[* halfXDelta]]
			decayInspection(inspAngleVertical * lerpedInspectionDelta, self.m_InspectVerticalLerpAng, self.m_InspectVerticalAng, 190, 0.8)
			decayInspection(inspAngleHorizontal * lerpedInspectionDelta, self.m_InspectHorizontalLerpAng, self.m_InspectHorizontalAng, 150, 0.84)
			decayInspection(inspPosVertical * lerpedInspectionDelta, self.m_InspectVerticalLerp, self.m_InspectVertical, 250, 1.3)
			decayInspection(inspPosHorizontal * lerpedInspectionDelta, self.m_InspectHorizontalLerp, self.m_InspectHorizontal, 240, 1.3)
		else
			self.m_InspectVerticalLerpAng = LerpAngle(10 * FrameTime(), self.m_InspectVerticalLerpAng, noAng)
			self.m_InspectHorizontalLerpAng = LerpAngle(10 * FrameTime(), self.m_InspectHorizontalLerpAng, noAng)
			self.m_InspectVerticalLerp = LerpVector(10 * FrameTime(), self.m_InspectVerticalLerp, noVec)
			self.m_InspectHorizontalLerp = LerpVector(10 * FrameTime(), self.m_InspectHorizontalLerp, noVec)
		end

		self.m_ViewModel:ManipulateBoneAngles(bId, self.m_InspectVerticalLerpAng + self.m_InspectHorizontalLerpAng)
		self.m_ViewModel:ManipulateBonePosition(bId, self.m_InspectVerticalLerp + self.m_InspectHorizontalLerp)
	end
end

function SWEP:RenderRigs()
	if (not IsValid(self:GetOwner())) then return end

	if self.UseRig then
		self:GetOwner():GetHands():SetParent(self.UseRig)
	else
		self:GetOwner():GetHands():SetParent(self.m_ViewModel)
	end

	self:GetOwner():GetHands():AddEffects(EF_BONEMERGE)
	self.UseHands = true
end

function SWEP:RenderModels(ent)
	if (ent ~= self.m_ViewModel and ent ~= self:GetOwner():GetHands() and ent:IsEffectActive(EF_BONEMERGE)) then
		ent:SetRenderOrigin(self.m_ViewModel:GetPos()) --this fixes lighting origin
	end

	if (ent == self.m_ViewModel or #ent:GetChildren() <= 0) and not ent.bAttachmentRenderOverride then
		ent:DrawModel()
	end

	for i, child in pairs(ent:GetChildren()) do
		self:RenderModels(child)
	end
end

function SWEP:RenderModelsForCustomization(ent)
	if (ent == self.m_ViewModel or #ent:GetChildren() <= 0) then
		ent:DrawModel()
	end

	for i, child in pairs(ent:GetChildren()) do
		self:RenderModelsForCustomization(child)
	end
end

--this is for bullets in mag
function SWEP:AttachmentFunction(funcname)
	for slot, attachment in pairs(self:GetAllAttachmentsInUse()) do
		if (attachment[funcname] and isfunction(attachment[funcname])) then
			attachment[funcname](attachment, self)
		end
	end
end

function SWEP:RenderCustomizationHighlightForModel(model)
	for i, c in pairs(model:GetChildren()) do
		self:RenderCustomizationHighlightForModel(c)
	end
end