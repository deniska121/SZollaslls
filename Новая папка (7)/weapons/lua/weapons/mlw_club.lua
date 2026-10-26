-- "addons\\weapons\\lua\\weapons\\mlw_club.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mlw_base"
SWEP.PrintName = "Клюшка"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_bat_metal.mdl"
SWEP.WorldModel = "models/weapons/melee/w_golfclub.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 50

SWEP.DamageTypes = {
	[1] = {8,15},
	[2] = {15,30}
}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "melee2",
	[3] = "melee",
}

SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["BaseBall_Bat"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.VElements = {
	["vmodel"] = { type = "Model", model = "models/weapons/melee/w_golfclub.mdl", bone = "BaseBall_Bat", rel = "", pos = Vector(13.048, 0.985, 8.272), angle = Angle(90, -0.868, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["wmodel"] = { type = "Model", model = "models/weapons/melee/w_golfclub.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-8.129, 1.906, 4.018), angle = Angle(-160.64, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}