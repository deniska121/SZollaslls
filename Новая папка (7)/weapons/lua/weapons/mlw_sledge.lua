-- "addons\\weapons\\lua\\weapons\\mlw_sledge.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Кувалда"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_sledge.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_sledge.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 55
SWEP.ShowWorldModel = false

SWEP.StaminaMaxPen = 25
SWEP.StaminaCD = 10
SWEP.RagdollizeTH = 50
SWEP.RagdollizeMP = 30

SWEP.Stamina = {
	[1] = 5,
	[2] = 10,
	[3] = 10,
}

SWEP.DamageTypes = {
	[1] = {17,31},
	[2] = {55,100}
}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "melee2",
	[3] = "melee",
}

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if ((ent:Health() > 0 and ent:Health() < self.RagdollizeTH) or (tr.HitGroup == 1 and dtype == 2)) then
		ent:Ragdollize(math.max(5, (ent:GetMaxHealth() - ent:Health()) * 0.5 + self.LastDamage + (tr.HitGroup == 1 and self.RagdollizeMP * 3 or self.RagdollizeMP)))
	end

	if tr.HitGroup == 4 or tr.HitGroup == 5 then
		ent:AddTempStat("fracturearm", self.LastDamage)
	end

	if tr.HitGroup == 6 or tr.HitGroup == 7 then
		ent:AddTempStat("fracture", self.LastDamage * 2)
	end
end

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_sledge.mdl",
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