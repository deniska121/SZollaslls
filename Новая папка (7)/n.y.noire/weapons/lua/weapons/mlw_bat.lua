--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mlw_bat.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "mlw_base"
SWEP.PrintName = "Бита"
SWEP.Category = "Melee"
SWEP.Slot = 2
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_bat_metal.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 50

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "melee2",
	[3] = "melee",
}

SWEP.ShowWorldModel = false

SWEP.Skins = {
	["wood"] = {
		vm_submaterials = {
			[2] = "models/weapons/tfa_nmrih/me_bat_metal/v_me_metalbat_s1"
		},
		vm_material = nil,
		wm_material = "models/weapons/tfa_nmrih/me_bat_metal/v_me_metalbat_s1",
		wm_submaterials = nil,
	}
}

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3, 1, -5),
		angle = Angle(180, 90, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}