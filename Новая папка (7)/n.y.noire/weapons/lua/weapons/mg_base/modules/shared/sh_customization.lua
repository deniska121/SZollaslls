--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

if (CLIENT) then
	concommand.Add("mgbase_customize", function(ply, cmd, args, argStr)
		net.Start("mgbase_customize", true)
		net.SendToServer()
	end)
end

function SWEP:StopCustomizing()
	if (self:IsCustomizing()) then
		self.bCustomize = false
		self:SetIsCustomizing(false)
		self:Customize()
	end
end

function SWEP:GetCustomizationCount()
	if (not self.Customization) then return 0 end

	return #self.Customization
end

function SWEP:GetAttachmentCount(slot)
	if (not self.Customization) then return 0 end

	return #self.Customization[slot]
end

function SWEP:CanCustomize()
	if (self:CanPump() and not self:GetHasPumped()) then return false end
	--&& self:Clip1() > 0

	return not self:GetIsReloading() and not self:IsDrawing() and not self:GetIsHolstering() and CurTime() > self:GetNextPrimaryFire() and self.Customization ~= nil and self:GetAimDelta() <= 0 and not self:GetIsSprinting()
end

--people lagging could still be playing draws
function SWEP:CanPlayInspectAfterCustomization()
	return not string.find(string.lower(self.m_seqIndex), "init") and not string.find(string.lower(self.m_seqIndex), "draw") and not string.find(string.lower(self.m_seqIndex), "equip")
end

function SWEP:Customize(fromFallback)
	fromFallback = fromFallback or false
	local state = self:IsCustomizing()

	if (CLIENT and IsFirstTimePredicted()) then
		self:CustomizationMenu()
	end

	if (game.SinglePlayer() and IsValid(self:GetOwner())) then
		self:CallOnClient("CustomizationMenu")
	end

	if (CLIENT and game.SinglePlayer()) then return end

	if (state) then
		self:PlayViewModelAnimation("Inspect", fromFallback)
	end
end

function SWEP:Attach(slot, attIndex, reset_ign)
	if (self.Customization[slot] == nil) then return end
	local attachmentClass = self.Customization[slot][attIndex]
	self:CreateAttachmentForUse(attachmentClass)
	--BUILD:
	self:BuildCustomizedGun()
	--reset inspect animation
	if not IsValid(self.m_ViewModel) then return end

	if CLIENT and not reset_ign then
		if (self:CanPlayInspectAfterCustomization()) then
			local cycle = self.m_ViewModel:GetCycle()
			self:PlayViewModelAnimation("Inspect", false, cycle)
		else
			local cycle = self.m_ViewModel:GetCycle()
			self:PlayViewModelAnimation(self.m_seqIndex, false, cycle)
		end
	end
end

local noOwnerPos = Vector()
local noOwnerAng = Angle()

local function doAttBoneOffsets(wep, att, mdl)
	if not att.BoneOffsets then return end

	for _,data in ipairs(att.BoneOffsets) do
		local bone = wep:LookupBoneCached(mdl, data.Bone)
		if (bone ~= nil and bone > 0) then
			if (IsValid(wep:GetOwner())) then
				mdl:ManipulateBoneAngles(bone, data.Angles)
				mdl:ManipulateBonePosition(bone, data.Pos)
			else
				mdl:ManipulateBoneAngles(bone, noOwnerAng)
				mdl:ManipulateBonePosition(bone, noOwnerPos)
			end
		end
	end
end

local function doAttBodygroups(wep, model)
	for i = 0, model:GetNumBodyGroups() do
		model:SetBodygroup(i, 0)
	end

	for slot, att in pairs(wep:GetAllAttachmentsInUse()) do
		if (att.AttachmentBodygroups ~= nil) then
			for bodyGroupName, value in pairs(att.AttachmentBodygroups) do
				local id = model:FindBodygroupByName(bodyGroupName)

				if (id ~= -1) then
					model:SetBodygroup(id, value)
				end
			end
		end
	end
end

local function doAttMaterialOverride(att, model, wep)
	for i, mat in pairs(model:GetMaterials()) do
		local originalPath, originalName = string.GetPathFromFilename(mat), string.GetFileFromFilename(mat)
		local path, name = att:OverrideMaterial(originalPath, originalName, wep)

		if path ~= originalPath or name ~= originalName then
			model:SetSubMaterial(i - 1, path .. name)
		end
	end
end

local function doWeaponMaterialOverride(att, model, wep)
	if not IsValid(model) then return end
	for i, mat in pairs(model:GetMaterials()) do
		local originalPath, originalName = string.GetPathFromFilename(mat), string.GetFileFromFilename(mat)
		local path, name = att:OverrideWeaponMaterial(originalPath, originalName, wep)

		if path ~= originalPath or name ~= originalName then
			model:SetSubMaterial(i - 1, path .. name)
		end
	end
end

function SWEP:CreateAttachmentModel(attachment)
	if (SERVER) then return end
	if (attachment.Model == nil) then return end
	if not IsValid(self.m_ViewModel) or not IsValid(self.m_WorldModel) then return end

	if (not IsValid(attachment.m_Model)) then
		attachment.m_Model = ClientsideModel(attachment.Model, self.RenderGroup)
		attachment.m_Model:SetRenderMode(self.RenderMode)
		attachment.m_Model:SetMoveType(MOVETYPE_NONE)
		attachment.m_Model:SetOwner(self.m_ViewModel)
		attachment.m_Model.bAttachmentRenderOverride = attachment.RenderOverride

		if (attachment.VElement == nil) then
			attachment.m_Model:AddEffects(EF_BONEMERGE)
			attachment.m_Model:AddEffects(EF_BONEMERGE_FASTCULL)
			attachment.m_Model:AddEffects(EF_PARENT_ANIMATES)
			attachment.m_Model:AddEffects(EF_NOINTERP)

			if (attachment.BonemergeToAttachment == nil and attachment.BonemergeToCategory == nil) then
				attachment.m_Model:SetParent(self.m_ViewModel)
			end
		else
			attachment.m_Model:FollowBone(self.m_ViewModel, self:LookupBoneCached(self.m_ViewModel, attachment.VElement.Bone))
		end

		if attachment.IsRig then
			self.UseRig = attachment.m_Model
		end
	end

	if (attachment.VElement ~= nil) then
		attachment.m_Model:SetPredictable(false)
		self:MoveVElement(self.m_ViewModel, attachment)
		attachment.m_Model:SetPredictable(true)
	end

	--GENERATED AIM OFFSET (do this every time because it can have changed viewmodel model)
	if (attachment == self.reticle) then
		self.m_ViewModel:SetPoseParameter("hybrid_offset", 0)
		self.m_ViewModel:InvalidateBoneCache()
		self.m_ViewModel:SetupBones()
		local alignAttachmentId = self.m_ViewModel:LookupAttachment(self.ViewModelOffsets.Aim.AlignAttachment or "align")

		if (alignAttachmentId > 0) then
			attachment.m_Model:SetupBones() --shaky otherwise
			local data = self.m_ViewModel:GetAttachment(alignAttachmentId)
			local reticleData = attachment.m_Model:GetAttachment(attachment.m_Model:LookupAttachment(attachment.Reticle.Attachment))
			local localPos, localAng = WorldToLocal(data.Pos, data.Ang, reticleData.Pos, reticleData.Ang)
			attachment.AimPos = Vector(-localPos.y, localPos.x + 4, localPos.z) --converted from stupid cod forward
			attachment.AimAng = Angle() --Angle(localAng.p, localAng.y, -localAng.r) --shouldnt need to change aim angles

			if (attachment.ReticleHybrid) then
				local reticle2Data = attachment.m_Model:GetAttachment(attachment.m_Model:LookupAttachment(attachment.ReticleHybrid.Attachment))
				localPos, localAng = WorldToLocal(reticle2Data.Pos, reticle2Data.Ang, reticleData.Pos, reticleData.Ang)
				attachment.HybridAimPos = attachment.AimPos + Vector(localPos.y, -localPos.x - 2, -localPos.z)
				attachment.HybridAimAng = attachment.AimAng + Angle(localAng.p, localAng.y, -localAng.r)

				if attachment.ReticleHybrid.Offsets then
					attachment.HybridAimPos = attachment.HybridAimPos + attachment.ReticleHybrid.Offsets.pos
					attachment.HybridAimAng = attachment.HybridAimAng + attachment.ReticleHybrid.Offsets.ang
				end
			end
		end
	end

	if (not IsValid(attachment.m_TpModel)) then
		attachment.m_TpModel = ClientsideModel(attachment.Model, self.RenderGroup)
		attachment.m_TpModel:SetRenderMode(self.RenderMode)
		attachment.m_TpModel:SetMoveType(MOVETYPE_NONE)
		attachment.m_TpModel:SetOwner(self.m_WorldModel)
		attachment.m_TpModel.ShowOnWorldModel = attachment.ShowOnWorldModel

		if (attachment.VElement == nil) then
			attachment.m_TpModel:AddEffects(EF_BONEMERGE)
			attachment.m_TpModel:AddEffects(EF_BONEMERGE_FASTCULL)
			attachment.m_TpModel:AddEffects(EF_PARENT_ANIMATES)
			attachment.m_TpModel:AddEffects(EF_NOINTERP)
			if (attachment.BonemergeToAttachment == nil and attachment.BonemergeToCategory == nil) then
				attachment.m_TpModel:SetParent(self.m_WorldModel)
			end
		else
			attachment.m_TpModel:FollowBone(self.m_WorldModel, self:LookupBoneCached(self.m_WorldModel, attachment.VElement.Bone))
		end

		attachment:PostInitModels(self)
	end

	if (attachment.VElement ~= nil) then
		attachment.m_TpModel:SetPredictable(false)
		self:MoveVElement(self.m_WorldModel, attachment)
		attachment.m_TpModel:SetPredictable(true)
	end

	doAttBodygroups(self, attachment.m_Model)
	doAttBodygroups(self, attachment.m_TpModel)
	doAttMaterialOverride(attachment, attachment.m_Model, self)
	doWeaponMaterialOverride(attachment, self.m_ViewModel, self)
	doAttMaterialOverride(attachment, attachment.m_TpModel, self)
	doWeaponMaterialOverride(attachment, self.m_WorldModel, self)

	doAttBoneOffsets(self, attachment, attachment.m_Model)
	doAttBoneOffsets(self, attachment, attachment.m_TpModel)
end

function SWEP:GetAttachmentInUseForSlot(slot)
	return self.m_CustomizationInUse[slot]
end

function SWEP:GetAttachmentInUseByCategory(cat)
	for _, att in pairs(self:GetAllAttachmentsInUse()) do
		if (att.Category == cat) then return att end
	end

	return nil
end

function SWEP:GetAllAttachmentsInUse()
	return self.m_CustomizationInUse
end

local bDoingStats = false

function SWEP:BuildCustomizedGun()
	--this resets gun to defaults, but keeps the internal variables
	self:DeepObjectCopy(weapons.Get(self:GetClass()), self)
	self:ResetBodygroups()
	--apply firemode first while resetting defaults:
	self:ApplyFiremodeStats()
	self:SetBurstRounds(0)
	self:SetCamo("")
	self.reticle = nil
	self.flashlight = nil
	self.laser = nil
	if (self.Customization == nil) then return end
	clearBaseClass(self.Customization)
	clearBaseClass(self.Animations)

	if (CLIENT) then
		if IsValid(self.m_ViewModel) then
			self.m_ViewModel:SetSubMaterial()
		end
		if IsValid(self.m_WorldModel) then
			self.m_WorldModel:SetSubMaterial()
		end
		self:SetViewModel(self.VModel)
		self:SetWorldModel(self.WorldModel)
		self.GripPoseParameter.PoseParameter = nil
		self.GripPoseParameter2.PoseParameter = nil
	end

	--check if atts are allowed
	for slot, att in pairs(self:GetAllAttachmentsInUse()) do
		if (att == nil or not self:IsAttachmentAllowed(att)) then
			self:CreateAttachmentForUse(self.Customization[slot][1])
		end
	end

	--this is needed for level transitions
	for slot, att in pairs(self:GetAllAttachmentsInUse()) do
		table.Inherit(att, self:GetStoredAttachment(att.ClassName))
	end

	self.ValuesToRemove = {}
	bDoingStats = true
	--making sure people dont access them while doing stats
	local vmodel = self.m_ViewModel
	local wmodel = self.m_WorldModel
	self.m_ViewModel = nil
	self.m_WorldModel = nil
	local stats = {}
	self:DeepObjectCopy(self:GetTable(), stats)

	for slot, attachment in pairs(self:GetAllAttachmentsInUse()) do
		if (attachment.Flashlight ~= nil) then
			self.flashlight = attachment
		end

		if (attachment.Laser ~= nil) then
			self.laser = attachment
		end

		if (attachment.Reticle ~= nil) then
			self.reticle = attachment
		end

		attachment:Stats(stats)

		if (attachment.Index > 1) then
			self:MakeBreadcrumbsForAttachment(attachment)
		end
	end

	clearBaseClass(stats)
	self:DeepObjectCopy(stats, self)
	bDoingStats = false
	self.m_ViewModel = vmodel
	self.m_WorldModel = wmodel

	for slot, att in pairs(self:GetAllAttachmentsInUse()) do
		att:PostProcess(self)
	end

	for slot, att in pairs(self:GetAllAttachmentsInUse()) do
		self:PostAttachment(att) --letting all atts do their thing and then run ours
	end

	if (not self:CanChangeAimMode()) then
		self:SetAimMode(0)
	end

	for slot, att in pairs(self:GetAllAttachmentsInUse()) do
		self:CreateAttachmentModel(att)
		att:Init(self)
	end

	for slot, att in pairs(self:GetAllAttachmentsInUse()) do
		if (att.Bodygroups ~= nil) then
			for bg, v in pairs(att.Bodygroups) do
				self:DoBodygroup(bg, v)
			end
		end
	end

	if (CLIENT) then
		for slot, att in pairs(self:GetAllAttachmentsInUse()) do
			att:Appearance(self.m_ViewModel, "Weapon")
			att:Appearance(self.m_WorldModel, "Weapon")

			for _, att2 in pairs(self:GetAllAttachmentsInUse()) do
				if (att2.Model ~= nil) then
					att:Appearance(att2.m_Model, att2.Category)
					att:Appearance(att2.m_TpModel, att2.Category)
				end
			end
		end
	end

	self:SetHoldType("slam")

	timer.Simple(1, function()
		if not IsValid(self) then return end
		self:SetShouldHoldType(true)
	end)

	self.Firemodes[self:GetFiremode()].OnSet(self)
	hook.Call("OnBuildCustomizedGun", nil, self)
end

--old way was just overcomplicated for no reason
function SWEP:MakeBreadcrumbsForAttachment(attachment)
	if (attachment.Breadcrumbs == nil) then
		--make breadcrumbs
		--make another copy of swep
		local breadcrumbs = {}
		self:DeepObjectCopy(weapons.Get(self:GetClass()), breadcrumbs)
		attachment:Stats(breadcrumbs) --run stats (lol he doesnt know its actually not a gun!!)
		--make bcs
		local holder = {}
		self:MakeBreadcrumbs(holder, weapons.Get(self:GetClass()), breadcrumbs) --looks at differences in numbers only
		attachment.Breadcrumbs = {}

		for statInfo, crumb in pairs(holder) do
			crumb.statInfo = statInfo
			table.insert(attachment.Breadcrumbs, crumb)
		end

		local sort = function(a, b)
			local aStat = self.StatInfo[a.statInfo]
			local bStat = self.StatInfo[b.statInfo]
			local baPositive = a.Current <= a.Original

			if (aStat.ProIfMore) then
				baPositive = not baPositive
			end

			local bbPositive = b.Current <= b.Original

			if (bStat.ProIfMore) then
				bbPositive = not bbPositive
			end

			if (baPositive and not bbPositive) then
				return true
			elseif (not baPositive and bbPositive) then
				return false
			elseif ((baPositive and bbPositive) or (not baPositive and not bbPositive)) then
				local aName = aStat.Name
				local bName = bStat.Name

				return aName < bName
			end
		end

		table.sort(attachment.Breadcrumbs, sort)
	end
end

function SWEP:MakeBreadcrumbs(holder, original, changed, currentPath)
	currentPath = currentPath or "SWEP"

	for k, v in pairs(original) do
		if (tostring(k) == "BaseClass" or tostring(k) == "m_Index") then continue end

		if (isnumber(v)) then
			if (changed[k] ~= v) then
				local path = currentPath .. "." .. tostring(k)
				if (self.StatDefinitions[path] == nil) then continue end
				holder[self.StatDefinitions[path]] = holder[self.StatDefinitions[path]] or {}

				table.Merge(holder[self.StatDefinitions[path]], {
					Original = v,
					Current = changed[k]
				})
			end
		elseif (istable(v) and changed[k] ~= nil) then
			self:MakeBreadcrumbs(holder, v, changed[k], currentPath .. "." .. tostring(k))
		end
	end
end

function SWEP:VectorAddAndMul(current, add, mul)
	current.x = current.x + (add.x * mul)
	current.y = current.y + (add.y * mul)
	current.z = current.z + (add.z * mul)
end

function SWEP:RenderCustomization(model, outsource)
	for slot, attachment in pairs(self:GetAllAttachmentsInUse()) do
		local attModel = model == self.m_ViewModel and attachment.m_Model or attachment.m_TpModel
		if (attModel == nil) then continue end
		if (attachment.VElement ~= nil) then continue end

		if (attachment.BonemergeToAttachment ~= nil or attachment.BonemergeToCategory ~= nil) then
			if (IsValid(attModel:GetParent())) then continue end

			for _, attParent in pairs(self:GetAllAttachmentsInUse()) do
				if (attParent == attachment) then continue end

				if (attachment.BonemergeToCategory ~= nil and table.HasValue(attachment.BonemergeToCategory, attParent.Category)) then
					attModel:SetParent(model == self.m_ViewModel and attParent.m_Model or attParent.m_TpModel)
					break
				end

				if (attachment.BonemergeToAttachment ~= nil and table.HasValue(attachment.BonemergeToAttachment, attParent.ClassName)) then
					attModel:SetParent(model == self.m_ViewModel and attParent.m_Model or attParent.m_TpModel)
					break
				end

				if outsource then
					attModel:DrawModel()
				end
			end
		end
	end
end

function SWEP:MoveVElement(model, attachment)
	local attModel = model == self.m_ViewModel and attachment.m_Model or attachment.m_TpModel
	local ve = attachment.VElement
	local bone = self:LookupBoneCached(model, ve.Bone)

	if (bone == nil) then
		error("VElement can't find bone " .. ve.Bone .. " on model " .. model:GetModel())
	end

	--[[local matrix = model:GetBoneMatrix(bone)

	if (matrix == nil) then
		return
	end]]
	local oPos, oAng = self:GetTotalAttachmentOffset(attachment)
	local ang = Angle()
	ang:RotateAroundAxis(ang:Forward(), ve.Angles.r + oAng.r)
	ang:RotateAroundAxis(ang:Right(), ve.Angles.y + oAng.y)
	ang:RotateAroundAxis(ang:Up(), ve.Angles.p + oAng.p)
	--ang:Sub(matrix:GetAngles())
	local pos = Vector() --matrix:GetTranslation()
	self:VectorAddAndMul(pos, ang:Forward(), ve.Position.y + oPos.y)
	self:VectorAddAndMul(pos, ang:Right(), ve.Position.x + oPos.x)
	self:VectorAddAndMul(pos, ang:Up(), ve.Position.z + oPos.z)
	--pos:Sub(matrix:GetTranslation())
	attModel:SetLocalPos(pos)
	attModel:SetLocalAngles(ang)
end

function SWEP:GetTotalAttachmentOffset(currentAttachment)
	local pos = Vector()
	local ang = Angle()
	local offsets = currentAttachment.VElement.Offsets

	if offsets ~= nil then
		for slot, attachment in pairs(self:GetAllAttachmentsInUse()) do
			if (offsets[attachment.ClassName] ~= nil) then
				pos:Add(offsets[attachment.ClassName][1])
				ang:Add(offsets[attachment.ClassName][2])
			end
		end
	end

	return pos, ang
end

function SWEP:DoBodygroup(name, value)
	if (SERVER) then return end
	if not IsValid(self.m_ViewModel) then return end
	local ind = self.m_ViewModel:FindBodygroupByName(name)

	if (ind ~= -1) then
		self.m_ViewModel:SetBodygroup(ind, value)
	end
	if not IsValid(self.m_WorldModel) then return end
	ind = self.m_WorldModel:FindBodygroupByName(name)

	if (ind ~= -1) then
		self.m_WorldModel:SetBodygroup(ind, value)
	end
end

function SWEP:ResetBodygroups()
	if (SERVER) then return end
	if not IsValid(self.m_ViewModel) then return end
	if (IsValid(self.m_ViewModel)) then
		self.m_ViewModel:SetSkin(0)

		for b = 0, self.m_ViewModel:GetNumBodyGroups() do
			self.m_ViewModel:SetBodygroup(b, 0)
		end
	end
	if not IsValid(self.m_WorldModel) then return end
	if (IsValid(self.m_WorldModel)) then
		self.m_WorldModel:SetSkin(0)

		for b = 0, self.m_WorldModel:GetNumBodyGroups() do
			self.m_WorldModel:SetBodygroup(b, 0)
		end
	end

	if self.RevolveRounds and self.ReloadBulletBG then
		self.m_ViewModel:SetBodygroup(3, self:Clip1())
		self.m_ViewModel:SetBodygroup(4, self:Clip1())
	end
end

function SWEP:GetAttachmentModels(slot)
	return self.m_CustomizationInUse[slot].m_Model, self.m_CustomizationInUse[slot].m_TpModel
end

function SWEP:GetSight()
	if (self.reticle == nil) then return nil end

	return self.reticle
end

function SWEP:GetLaser()
	if (self.laser == nil) then return nil end

	return self.laser
end

function SWEP:GetFlashlightAttachment()
	if (not self.flashlight) then return nil end

	return self.flashlight
end

function SWEP:HasAttachment(class)
	if (self.Customization == nil) then return false end
	if (self.m_CustomizationInUse == nil) then return false end

	for slot, att in pairs(self:GetAllAttachmentsInUse()) do
		if (att.ClassName == class) then return true end
	end

	return false
end

function SWEP:GetBlockerAttachment(attachment)
	for slot, attachmentInUseInSlot in pairs(self:GetAllAttachmentsInUse()) do

		if (attachmentInUseInSlot.ExcludedAttachments ~= nil) and table.HasValue(attachmentInUseInSlot.ExcludedAttachments, attachment.ClassName) then return attachmentInUseInSlot end

		if (attachmentInUseInSlot.ExcludedCategories ~= nil) and table.HasValue(attachmentInUseInSlot.ExcludedCategories, attachment.Category) then return attachmentInUseInSlot end


		if (attachment.ExcludedByAttachments ~= nil and table.HasValue(attachment.ExcludedByAttachments, attachmentInUseInSlot.ClassName)) then return attachmentInUseInSlot end
		if (attachment.ExcludedByCategories ~= nil and table.HasValue(attachment.ExcludedByCategories, attachmentInUseInSlot.Category) and attachmentInUseInSlot.Index > 1) then return attachmentInUseInSlot end
	end

	return nil
end

function SWEP:IsAttachmentAllowed(attachment)
	if (attachment.Index == nil or attachment.Index > 1) then
		if (not attachment.CosmeticChange) then
			local attLimit = GetConVar("mgbase_sv_customization_limit"):GetInt()
			local currentCount = 0

			for slot, attachmentInUseInSlot in pairs(self:GetAllAttachmentsInUse()) do
				if (attachment ~= attachmentInUseInSlot and attachmentInUseInSlot.Index > 1 and not attachmentInUseInSlot.CosmeticChange) then
					currentCount = currentCount + 1
				end
			end

			if (attLimit > 0 and currentCount >= attLimit) then return false end
		end

		if (hook.Run("MW19_AllowAttachment", self, attachment) == false) then return false end
		if (self:GetBlockerAttachment(attachment) ~= nil) then return false end
	end

	return true
end

function SWEP:SetGripPoseParameter(value)
	if (CLIENT) then
		if (self.GripPoseParameters == nil) then return error("you haven't defined any grip pose parameters") end
		if (not table.HasValue(self.GripPoseParameters, value)) then return error("pose parameter " .. value .. " was not defined in GripPoseParameters!") end
		self.GripPoseParameter.PoseParameter = value
	end
end

function SWEP:SetGripPoseParameter2(value)
	if (CLIENT) then
		if (self.GripPoseParameters2 == nil) then return error("you haven't defined any grip pose parameters 2") end
		if (not table.HasValue(self.GripPoseParameters2, value)) then return error("pose parameter " .. value .. " was not defined in GripPoseParameters2!") end
		self.GripPoseParameter2.PoseParameter = value
	end
end

function SWEP:DisableGrip(instant)
	if (instant) then
		self.GripPoseParameter.Lerp = 0
	end

	self.GripPoseParameter.Target = 0
end

function SWEP:EnableGrip(instant)
	if (instant) then
		self.GripPoseParameter.Lerp = 1
	end

	self.GripPoseParameter.Target = 1
end

function SWEP:DisableGrip2(instant)
	if (instant) then
		self.GripPoseParameter2.Lerp = 0
	end

	self.GripPoseParameter2.Target = 0
end

function SWEP:EnableGrip2(instant)
	if (instant) then
		self.GripPoseParameter2.Lerp = 1
	end

	self.GripPoseParameter2.Target = 1
end

local blocked = {
	["Perks"] = true,
	["Magazines"] = true,
}

local blocked_by = {
	["Крепление"] = "Прицелы"
}

local blocked_att = {
	["att_vm_thermal_east_tall"] = true,
	["att_vm_thermal_hybrid"] = true,
	["att_vm_hybrid_west02_thermal"] = true,
	["att_vm_oil_filter_suppressor"] = true,
	["att_vm_thermal_west_01"] = true,
}

function SWEP:inUseBySlot(slot)
	if isnumber(slot) then
		return self:GetAttachmentInUseForSlot(slot)
	end

	return self:GetAttachmentInUseByCategory(slot)
end

local function convetTable(tbl)
	local tbl2 = {}
	for k,v in ipairs(tbl) do
		tbl2[v] = k
	end

	return tbl2
end

local function IsDarkRPItem(att)
	if DarkRP.Junk[att] then return true end
	if DarkRP.SameAtts[att] and DarkRP.Junk[DarkRP.SameAtts[att]] then return true end
	return false
end

local function GetDarkRPItem(att)
	if DarkRP.Junk[att] then return att end
	if DarkRP.SameAtts[att] and DarkRP.Junk[DarkRP.SameAtts[att]] then return DarkRP.SameAtts[att] end
	return
end

local donate_prom = {
	["vm_thotel_stock_hv_00"] = "d_packrat7",
	["vm_sm_thotel_angled_00"] = "d_packrat7",
	["vm_thotel_barrel_l_00"] = "d_packrat7",
	["att_reargrip_golf"] = "d_blueblood",
	["sw4506_receiver"] = "extra_stuff",
	["sw4506_slide"] = "extra_stuff",
}

function SWEP:AllowedToAttach(index, att, slot, buy)
	if index > 1 and (hook.Run("MW19_AllowedToAttach", self, att) == false) then return false end

	if self.NoUserAttachs then return false end

	if self.GivenByTeam then return false end

	if sAdmin.hasPermission(self:GetOwner(), "weapon_upgrade") then return true end

	if CLIENT and blocked_by[slot] then
		local att_slot = self:GetAttachmentInUseByCategory(blocked_by[slot])
		if att_slot and att_slot.Index > 1 then return false end
	end

	if MW_ATTS[att].ExcludedCategories then
		for _,cur in pairs(MW_ATTS[att].ExcludedCategories) do
			if self:inUseBySlot(cur) and self:inUseBySlot(cur).Index > 1 then
				return false
			end
		end
	end

	if MW_ATTS[att].ExcludedAttachments then
		local compare = convetTable(MW_ATTS[att].ExcludedAttachments)
		for _,cur in pairs(self:GetAllAttachmentsInUse()) do
			if self:inUseBySlot(cur) and compare[self:inUseBySlot(cur).ClassName] then
				return false
			end
		end
	end

	if DarkRP.DonationAT and DarkRP.DonationAT[att] then
		if not self:GetOwner().MQSdata or not self:GetOwner().MQSdata.Stored then return false end

		if not self:GetOwner().MQSdata.Stored[donate_prom[att]] then
			return false
		end

		return true
	end

	if DarkRP.InterCAT[att] and DarkRP.InterCAT[att] == self:inUseBySlot(slot).ClassName then return true end

	if MW_FACATTS[att] then return false end

	if MW_ATTS[att].UseJunk and self:GetOwner():HaveItem(INV_JUNK, MW_ATTS[att].UseJunk) < 1 then
		return false
	end

	if IsDarkRPItem(att) and (self:GetOwner():HaveItem(INV_JUNK, att) < 1 and self:GetOwner():HaveItem(INV_JUNK, DarkRP.SameAtts[att]) < 1) and self:inUseBySlot(slot).ClassName ~= att then
		return false
	end

	if blocked[slot] or blocked_att[att] then return false end

	if DarkRP.RestrictedCT and DarkRP.RestrictedCT[slot] then return false end

	if not IsValid(self:GetOwner()) or not self:GetOwner():Alive() then return false end

	if self:GetOwner():Team() ~= 9 then return false end

	local trace = self:GetOwner():GetEyeTrace().Entity

	if not IsValid(trace) or trace:GetClass() ~= "workstation_guns" or trace:GetPos():DistToSqr(self:GetOwner():GetPos()) > 2000 then return false end


	if SERVER and buy then
		local curat = self:GetAttachmentInUseForSlot(slot).ClassName

		self:GetOwner():RemoveItemByClass(INV_JUNK, GetDarkRPItem(att))

		if IsDarkRPItem(curat) then
			McINV.AddCustomItem(self:GetOwner(), INV_JUNK, GetDarkRPItem(curat), DarkRP.Junk[GetDarkRPItem(curat)])
		end

		if MW_ATTS[att].UseJunk then
			local com = ""
			for id,en in pairs(self:GetOwner().inv[INV_JUNK]) do
				if en.class ~= MW_ATTS[att].UseJunk then continue end
				local data = DarkRP.Junk[en.class]
				com = en.name
				if data and en.dt and en.dt.uses and (0 < en.dt.uses) then
					en.dt.uses = en.dt.uses - 1
					if en.dt.uses < 1 then
						self:GetOwner():RemoveItem(INV_JUNK, id)
					else
						en.weight = en.dt.uses * data.weight + (data.conwht or 0)
						self:GetOwner():UpdateInventory()
					end
					break
				else
					self:GetOwner():RemoveItem(INV_JUNK, id)
				end
			end
			DarkRP.notify(self:GetOwner(), 0, 5, "Вы потратили '" .. com .. "' на модификацию оружия")
		end
	end

	return true
end

-- function SWEP:CanCustomize()

-- 	if not IsValid(self:GetOwner()) or not self:GetOwner():Alive() then return false end

-- 	if sAdmin.hasPermission(self:GetOwner(), "weapon_upgrade") then return true end

-- 	local trace = self:GetOwner():GetEyeTrace().Entity

-- 	if not IsValid(trace) or trace:GetClass() ~= "workstation_guns" or trace:GetPos():DistToSqr(self:GetOwner():GetPos()) > 10000 then return false end

-- 	return true
-- end

function SWEP:SetViewModel(path)
	if (bDoingStats) then
		print("Do not use this while building stats!")
		return
	end

	if SERVER or not IsValid(self.m_ViewModel) then return end
	self.m_ViewModel:SetModel(path)
	self.m_ViewModel.cachedBones = nil
end

function SWEP:SetWorldModel(path)
	if (bDoingStats) then
		print("Do not use this while building stats!")
		return
	end

	if SERVER or not IsValid(self.m_WorldModel) then return end
	self.m_WorldModel:SetModel(path)
	self.m_WorldModel.cachedBones = nil
end

if (SERVER) then return end