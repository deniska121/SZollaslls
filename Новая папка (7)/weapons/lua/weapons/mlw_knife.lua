-- "addons\\weapons\\lua\\weapons\\mlw_knife.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Нож"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_kitknife.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_kitknife.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 43
SWEP.ShowWorldModel = false
SWEP.RagdollizeTH = 30
SWEP.RagdollizeMP = 2
SWEP.BluntDamage = false
SWEP.DamageTypes = {
	[1] = {6,12},
	[2] = {12,30}
}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "knife",
	[3] = "melee",
}

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if dtype == 2 and ((ent:Health() > 0 and ent:Health() < self.RagdollizeTH) or (tr.HitGroup == 1 and dtype == 2)) then
		ent:Ragdollize(math.max(5, (ent:GetMaxHealth() - ent:Health()) * 0.5 + self.LastDamage + (tr.HitGroup == 1 and self.RagdollizeMP * 3 or self.RagdollizeMP)))
	end

	ent:AddTempStat("bleeding", dtype == 2 and math.random(10,28) or math.random(3,8))
end

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_kitknife.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(4, 1, -2),
		angle = Angle(180, 180, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}