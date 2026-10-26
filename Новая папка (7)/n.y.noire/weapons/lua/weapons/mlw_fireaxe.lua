--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mlw_fireaxe.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Пожарный топор"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_axe_fire.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 55
SWEP.ShowWorldModel = false

SWEP.StaminaMaxPen = 25
SWEP.StaminaCD = 10
SWEP.BluntDamage = false
SWEP.Stamina = {
	[1] = 5,
	[2] = 10,
	[3] = 10,
}

SWEP.DamageTypes = {
	[1] = {17,31},
	[2] = {31,75}
}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "melee2",
	[3] = "melee",
}

SWEP.Skins = {
	["salamanca"] = {
		vm_submaterials = {
			[2] = "models/weapons/tfa_nmrih/me_axe_fire/v_me_fireaxe_s1"
		},
		vm_material = nil,
		wm_material = "models/weapons/tfa_nmrih/me_axe_fire/v_me_fireaxe_s1",
		wm_submaterials = nil,
	}
}

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if ((ent:Health() > 0 and ent:Health() < self.RagdollizeTH) or tr.HitGroup == 1) then
		ent:Ragdollize(math.max(5, (ent:GetMaxHealth() - ent:Health()) * 0.5 + self.LastDamage + (tr.HitGroup == 1 and self.RagdollizeMP * 3 or self.RagdollizeMP)))
	end

	ent:AddTempStat("bleeding", dtype and math.random(18,38) or math.random(8,18))
end

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 1, -5),
		angle = Angle(180, 180, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}