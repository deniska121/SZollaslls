--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/weapon_fish.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Рыба"
SWEP.Category = "Melee"
SWEP.Slot = 2
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_wrench.mdl"
SWEP.WorldModel = "models/fish/w_crowbar.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 55
SWEP.ShowWorldModel = false
SWEP.RagdollizeTH = 70

SWEP.ChargeAttackDelay = 0.2
SWEP.SimpleAttackDelay = 0.2

SWEP.ChargeAttackCD = 0.9
SWEP.SimpleAttackCD = 0.9

SWEP.DamageTypes = {
	[1] = {1,5},
	[2] = {5,8}
}

function SWEP:PlayImpactSound(surf, hard)
	self:EmitSound("nmrihimpact/sharp_heavy3.wav")
	if hard and SERVER then
		self:GetOwner():EmitSound(Sound("fish.wav"))
	end
end

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if dtype == 2 then
		ent:Ragdollize(self.LastDamage * 10)
	end

	if ent:IsOnGround() and ent:GetPos().z < self:GetOwner():GetPos().z + 20 and (ent:getDarkRPVar("heroin") or (ent:getDarkRPVar("alcohol") or 0) <= 20) and (ent.lastPickup or 0) < CurTime() then
		local dir = self:GetOwner():EyeAngles():Forward()
		dir.z = 0
		ent:SetVelocity(dir * 600)
		ent:ViewPunch(Angle(math.random(-30), math.random(-30), 0))
	else
		ent:Ragdollize(3)
	end
end

SWEP.ViewModelBoneMods = {
	["v_me_hammer"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["vmodel"] = { type = "Model", model = "models/fish/w_crowbar.mdl", bone = "v_me_hammer", rel = "", pos = Vector(0, 0, -2.427), angle = Angle(0, 0, -90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["wmodel"] = { type = "Model", model = "models/fish/w_crowbar.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4, 1, 0), angle = Angle(0, 0, 90), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}