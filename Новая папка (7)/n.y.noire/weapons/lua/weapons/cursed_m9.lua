--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/cursed_m9.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "mwb_m9"
SWEP.PrintName = "Beretta M9"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Cursed"
SWEP.NoUserAttachs = true
SWEP.Primary.ClipSize = 17
SWEP.CanFireAgain = 0
SWEP.Cursed = true
SWEP.IconOverride = "entities/mwb_m9.png"

SWEP.UseMags = {
	["m9c_15"] = {1, 1},
	["m9c_21"] = {1, 2},
	["m9c_27"] = {1, 3},
	["m9c_27b"] = {1, 4},
	["m9c_20"] = {1, 5},
}

SWEP.Customization = {
	{"att_vm_pi_golf17_mag", "attachment_vm_pi_mike9_mag", "attachment_vm_pi_mike9_mag_diamatti"},
	{"attachment_vm_pi_mike9_receiver_v2",},
	{"att_stock", "attachment_vm_pi_mike9_pstlgrpcust"},
	{"attachment_vm_pi_mike9_barauto", "attachment_vm_pi_mike9_barlong", "attachment_vm_pi_mike9_barrel_black", "attachment_vm_pi_mike9_barauto"},
	{"att_muzzle", "att_vm_silencer04_pstl"},
}

function SWEP:PostInit()
	self:SetClip1(17)
end

function SWEP:Reload()

end

function SWEP:PrimaryAttack()
	if (self.Primary.TrailingSound ~= nil) then
		self:EmitSound(self.Primary.TrailingSound)
	end

	if (CLIENT and IsFirstTimePredicted()) then
		self.Camera.Shake = 0.7
	end

	self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.HoldTypes[self.HoldType].Attack)
	local seqIndex = "Jog_Out"

	if (IsFirstTimePredicted()) then
		self:PlayViewModelAnimation(seqIndex)
	end

	self:SetLastShootTime(CurTime())
	self:SetNextPrimaryFire(CurTime())

	if SERVER and self.CanFireAgain < CurTime() and IsValid(self:GetOwner()) then
		local ply = self:GetOwner()
		local q = MQS.HasQuest(ply)

		if not q then return end

		if q.quest ~= "season1_criminal_1" or MQS.GetNWdata(ply, "quest_objective") ~= 10 then
			return
		end

		MQS.UpdateObjective(ply)
	end

	self.CanFireAgain = CurTime() + 1
end

function SWEP:CanMelee()
	return false
end


SWEP.ViewBoneOffsets = {
	{
		Bone = "j_mag1",
		Angles = Angle(5, 0, 0),
		Pos = Vector(-0.5, 0, 0.5)
	}
}