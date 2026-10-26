-- "addons\\weapons\\lua\\weapons\\police_beanbag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mwb_m590"
SWEP.PrintName = "Mossberg 590 Bean Bag"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.IconOverride = "entities/weapon_beanbag.png"

SWEP.Customization = {
	{"590_mwii_pump_lgt", "590_eft_pump_590def", "590_eft_pump_870def", "590_eft_pump_590_wood", "590_mwii_pump_def", "590_mwii_pump_tac", "590_mwii_pump_lgt"},
	{"590_eft_pump_receiver"},
	{"590_eft_barrel", "590_eft_barrel_v1", "590_eft_barrel_v3", "590_eft_barrel_v4", "590_mwii_barrel_v1", "590_mwii_barrel_v2", "590_mwii_barrel_v3", "590_eft_barrel_fg", "590_eft_barrel_1897"},
	{"590_f1", "magpul_sga_stock", "mwii_590_no_stock", "590_f1", "590_f1s"},
	{"590_no_rail", "590_base_iro", "590_no_rail"},
}

SWEP.UseMags = nil

SWEP.UseINV = {
	["beanbag"] = true,
	["buckshot"] = false
}

SWEP.Bullet = {
	Damage = {7, 1}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 3, --in meters, damage scales within this distance
	Range = 16, --in meters, after this distance the bullet stops existing
	Spread = 0.075,
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 2.36, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.86, --how much damaged is multipled by when leaving a surface.
		MaxCount = 13, --how many times the bullet can penetrate.
		Thickness = 18, --in hu, how thick an obstacle has to be to stop the bullet.
	}
}

function SWEP:Bullets()
	self.lastHitEntity = NULL
	self:SetPenetrationCount(self.Bullet.Penetration ~= nil and self.Bullet.Penetration.MaxCount or 0)
	local spread = Vector(self:CalculateCone(), -self:CalculateCone()) * (self.Bullet.Spread or 0.1)
	local aim = Vector()
	local flydist = self:MetersToHU(self.Bullet.Range + 10)
	local dist = math.min(self:GetOwner():EyePos():DistToSqr(self:GetOwner():GetEyeTrace().HitPos) / (flydist / 3) ^ 2, 1.5)

	if (self.Bullet.NumBullets == 1) then
		spread = LerpVector(self:GetAimDelta(), Vector(self:CalculateCone(), -self:CalculateCone()) * 0.1, Vector(0, 0)) * dist
	end

	local dir = (self:GetOwner():EyeAngles() + self:GetOwner():GetViewPunchAngles() + self:GetBreathingAngle()):Forward()

	aim = Vector(0,0,math.Rand(0.007, 0.01)) * dist * 4

	self:GetOwner():FireBullets({
		Attacker = self:GetOwner(),
		Src = self:GetOwner():EyePos(),
		Dir = dir - aim,
		Spread = spread,
		Num = self.Bullet.NumBullets,
		Damage = self.Bullet.Damage[1], --for some fucking bullet mod or something idk
		HullSize = 0,
		Force = (self.Bullet.Damage[1] * self.Bullet.PhysicsMultiplier) * 0.01,
		Distance = flydist,
		Tracer = 0,
		Callback = function(attacker, tr, dmgInfo)
			self:BulletCallback(attacker, tr, dmgInfo, bFromServer)
			dmgInfo:SetDamageType(DMG_PARALYZE)
		end
	})
end