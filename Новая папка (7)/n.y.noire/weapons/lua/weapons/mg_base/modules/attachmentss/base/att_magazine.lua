--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/base/att_magazine.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_base"
ATTACHMENT.Name = "Default Magazine"
ATTACHMENT.Category = "Magazines"
--for gameplay mag
ATTACHMENT.BulletList = {}
--for animation mag (offhand)
ATTACHMENT.ReserveBulletList = {}
ATTACHMENT.PoseParameter = "bullets_offset" --the spring
local small = Vector()
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:SetMagFollowerPoseParam(weapon, val)
	local ppid = self.m_Model:LookupPoseParameter(self.PoseParameter)
	local min, max = self.m_Model:GetPoseParameterRange(ppid)
	min = min or 0
	max = max or 1
	self.m_Model:SetPoseParameter(self.PoseParameter, math.Clamp(val, min, max))
	--self.m_Model:InvalidateBoneCache()
end

function ATTACHMENT:Render(weapon)
	if (not weapon:IsCarriedByLocalPlayer()) then return end

	self.m_Model._clip = weapon:Clip1()
	self.m_Model._ammo = weapon:Ammo1()
	self:SetMagFollowerPoseParam(weapon, weapon:GetMaxClip1() - weapon:Clip1())
end

local function cacheBones(model, bones)
	for _, name in pairs(bones) do
		model.cachedBones[name] = {
			id = model:LookupBone(name),
			remove = false
		}
	end
end

function ATTACHMENT:PostInitModels(weapon)
	BaseClass.PostInitModels(self, weapon)
	if (SERVER) then return end
	if (table.IsEmpty(self.BulletList) and table.IsEmpty(self.ReserveBulletList)) then return end
	self.m_Model._requestedReset = false
	self.m_Model._clip = -1
	self.m_Model._lastClip = -1
	self.m_Model._ammo = -1
	self.m_Model._lastAmmo = -1
	self.m_Model.BulletList = table.Copy(self.BulletList)
	self.m_Model.ReserveBulletList = table.Copy(self.ReserveBulletList)
	self.m_Model:SetupBones()
	self.m_Model.cachedBones = {}

	for _, bones in pairs(self.m_Model.BulletList) do
		cacheBones(self.m_Model, bones)
	end

	for _, bones in pairs(self.m_Model.ReserveBulletList) do
		cacheBones(self.m_Model, bones)
	end

	self.m_Model:AddCallback("BuildBonePositions", function(ent, numbones)
		local function scaleBones(e, bones, bRemove)
			for i, bone in pairs(bones) do
				e.cachedBones[bone].remove = bRemove
			end
		end

		if (ent._lastClip ~= ent._clip) then
			for i, bones in pairs(ent.BulletList) do
				scaleBones(ent, bones, ent._clip <= i)
			end

			ent._lastClip = ent._clip
		end

		if (ent._lastAmmo ~= ent._ammo + ent._clip) then
			for i, bones in pairs(ent.ReserveBulletList) do
				scaleBones(ent, bones, weapon:Clip1() + weapon:Ammo1() < i)
			end

			ent._lastAmmo = ent._ammo + ent._clip
		end

		if (ent._requestedReset) then
			for i, bones in pairs(ent.BulletList) do
				scaleBones(ent, bones, weapon:Clip1() + weapon:Ammo1() < i)
			end

			ent._requestedReset = false
		end

		for name, boneStuff in pairs(ent.cachedBones) do
			if (not boneStuff.remove) then continue end
			local mat = ent:GetBoneMatrix(boneStuff.id)
			if (mat == nil) then continue end
			mat:SetScale(small)
			ent:SetBoneMatrix(boneStuff.id, mat)
		end
	end)
end

function ATTACHMENT:ResetBullets(weapon)
	self.m_Model._requestedReset = true
	self:SetMagFollowerPoseParam(weapon, weapon:GetMaxClip1() - (weapon:Clip1() + weapon:Ammo1()))
end