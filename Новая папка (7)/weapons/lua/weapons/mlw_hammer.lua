-- "addons\\weapons\\lua\\weapons\\mlw_hammer.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mlw_base"
SWEP.PrintName = "Молоток"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_tool_barricade.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_tool_barricade.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 50

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "melee",
	[3] = "melee2",
}

SWEP.AttackAnim = {
	[1] = "Attack_Quick_1",
	[2] = "Attack_Charge_Begin",
	[3] = "Attack_Charge_End",
}

SWEP.ShowWorldModel = false

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_tool_barricade.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(4, 1, 0),
		angle = Angle(180, 180, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}