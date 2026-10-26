-- "addons\\weapons\\lua\\weapons\\mlw_fisting.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Fisting"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_fists.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_kitknife.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 43
SWEP.ShowWorldModel = false
SWEP.RagdollizeTH = 30
SWEP.RagdollizeMP = 2
SWEP.BluntDamage = true
SWEP.DamageTypes = {
	[1] = {6,12},
	[2] = {12,30}
}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "fist",
	[3] = "fist",
}

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	ent:Ragdollize(120)
end

SWEP.WElements = {}