-- "addons\\weapons\\lua\\weapons\\mlw_drill.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mlw_base"
SWEP.PrintName = "Melee 3"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_pipe_lead.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 50

SWEP.VElements = {}
SWEP.ViewModelBoneMods = {
	["Maglite"] = { scale = Vector(0.001, 0.001, 0.001), pos = Vector(-30, 0, 0), angle = Angle(0, 0, 0) }
}

SWEP.DamageTypes = {
	[1] = {7,17},
	[2] = {13,35}
}

SWEP.ShowWorldModel = false
SWEP.BluntDamage = false
SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl",
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

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if ent:Health() > 0 then
		ent:Ragdollize(120)
	end

	if dtype == 2 and math.random(5) > 3 then
		ent:AddTempStat("bleeding", math.random(5,8))
	end
end