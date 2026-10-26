-- "addons\\weapons\\lua\\weapons\\mlw_pickaxe.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Кирка"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_pickaxe.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_pickaxe.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 60
SWEP.ShowWorldModel = false
SWEP.BluntDamage = false
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

	if math.random(3) > 1 then
		ent:AddTempStat("bleeding", dtype == 2 and 17 or math.random(5,8))
	end
end

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_pickaxe.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(0, 0, 0),
		angle = Angle(180, 180, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}