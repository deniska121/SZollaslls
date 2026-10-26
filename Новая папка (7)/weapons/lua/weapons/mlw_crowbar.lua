-- "addons\\weapons\\lua\\weapons\\mlw_crowbar.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Монтировка"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_crowbar.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 55
SWEP.ShowWorldModel = false
SWEP.BluntDamage = false

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if ((ent:Health() > 0 and ent:Health() < self.RagdollizeTH) or (tr.HitGroup == 1 and dtype == 2)) then
		ent:Ragdollize(math.max(5, (ent:GetMaxHealth() - ent:Health()) * 0.5 + self.LastDamage + (tr.HitGroup == 1 and self.RagdollizeMP * 3 or self.RagdollizeMP)))
	end

	if dtype == 2 and math.random(5) > 3 then
		ent:AddTempStat("bleeding", math.random(5,8))
	end
end

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_crowbar.mdl",
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