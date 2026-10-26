--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/client/cl_worldmodel_render.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
local noOwnerPos = Vector()
local noOwnerAng = Angle()

function SWEP:DrawWorldModel(flags)
	if self:GetOwner():GetMoveType() == MOVETYPE_NOCLIP or self:GetOwner():GetMoveType() == MOVETYPE_NONE then return end

	if (not IsValid(self.m_WorldModel)) then
		self:RecreateClientsideModels(true)
	end

	render.SetBlend(0)
	self:DrawModel()
	render.SetBlend(1)
	local pos, ang = self:GetBonePosition(0)

	if self.WMRotate then
		ang:RotateAroundAxis(ang:Right(), self.WMRotate.x)
		ang:RotateAroundAxis(ang:Forward(), self.WMRotate.y)
		ang:RotateAroundAxis(ang:Up(), self.WMRotate.z)
	end

	local wPos = self:GetPos()
	self.m_WorldModel:SetPos(wPos + (pos - wPos))
	local wAng = self:GetAngles()
	self.m_WorldModel:SetAngles(wAng + (ang - wAng))
	self.m_WorldModel:SetRenderOrigin(wPos + (pos - wPos))
	self.m_WorldModel:SetRenderAngles(wAng + (ang - wAng))
	local bone = self:LookupBoneCached(self.m_WorldModel, self.WorldModelOffsets.Bone)

	if (bone ~= nil and bone > 0) then
		if (IsValid(self:GetOwner())) then
			self.m_WorldModel:ManipulateBoneAngles(bone, self.WorldModelOffsets.Angles)
			self.m_WorldModel:ManipulateBonePosition(bone, self.WorldModelOffsets.Pos)
		else
			self.m_WorldModel:ManipulateBoneAngles(bone, noOwnerAng)
			self.m_WorldModel:ManipulateBonePosition(bone, noOwnerPos)
		end
	end

	if self.WorldBoneOffsets then
		for _,data in ipairs(self.WorldBoneOffsets) do
			bone = self:LookupBoneCached(self.m_WorldModel, data.Bone)
			if (bone ~= nil and bone > 0) then
				if (IsValid(self:GetOwner())) then
					self.m_WorldModel:ManipulateBoneAngles(bone, data.Angles)
					self.m_WorldModel:ManipulateBonePosition(bone, data.Pos)
				else
					self.m_WorldModel:ManipulateBoneAngles(bone, noOwnerAng)
					self.m_WorldModel:ManipulateBonePosition(bone, noOwnerPos)
				end
			end
		end
	end

	--particles
	self:RenderParticles(self.TpParticles)
	self:SetupBones()
	self.m_WorldModel:SetupBones()

	--customization
	if (self.Customization) then
		self:RenderCustomization(self.m_WorldModel)
	end

	--anims
	self.m_ViewModel:FrameAdvance()
	self:AnimationEvents()
	self:RenderWModels(self.m_WorldModel)
	self.m_WorldModel.fixed = true
	--attachments
	if (self:GetLaser() ~= nil) and self:GetLaser().Render then
		self:GetLaser():Render(self, self:GetLaser().m_TpModel)
	end
end

function SWEP:DrawWorldModelTranslucent(flags)
	self:DrawWorldModel(flags)
end

function SWEP:RenderWModels(ent)
	if (ent == self.m_WorldModel or (#ent:GetChildren() <= 0 and ent.ShowOnWorldModel)) then
		ent:DrawModel()
	end

	for i, child in pairs(ent:GetChildren()) do
		self:RenderWModels(child)
	end
end