-- sh_primaryattack_behaviour.lua
AddCSLuaFile()

function SWEP:CanAttack()
	if self:GetOwner():IsBot() then return true end
	if (self.Animations["Rechamber"] ~= nil and self:GetIsReloading() and not self:IsCustomizing()) then return true end
	if (self.Animations["Rechamber"] ~= nil and not self:GetHasPumped()) then return false end
	if (self:Clip1() <= 0) then return false end
	if (self:IsCustomizing()) then return false end
	if (self:GetSafety()) then return false end
	if (CurTime() < self:GetNextPrimaryFire()) then return false end
	if (CurTime() < self:GetNextFiremodeTime()) then return false end
	if (self:GetOwner():KeyDown(IN_USE)) then return false end
	if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
	if (CurTime() < self:GetNextMeleeTime()) then return false end
	if (CurTime() < self:GetNextSprintTime()) then return false end
	if (CurTime() < self:GetNextReloadTime() and self:GetHasFilledMag()) then return false end
	if (self.Trigger and self:GetTriggerDelta() < 1) then return false end
	if not self:GetOwner():IsOnGround() then return false end

	return true
end

function SWEP:CalculateRecoil()
	local sprayRounds = math.min(self:GetSprayRounds(), 6)
	local sprayMul = 1 + (sprayRounds * 0.15)
	
	local verticalRecoil = math.Rand(self.Recoil.Vertical[1], self.Recoil.Vertical[2]) * sprayMul
	local horizontalRecoil = math.Rand(self.Recoil.Horizontal[1], self.Recoil.Horizontal[2]) * sprayMul
	
	local angles = Angle(-verticalRecoil, horizontalRecoil * (0.5 + math.random() * 0.5), horizontalRecoil * -0.3)
	
	local aimMul = self:GetAimDelta() > 0.5 and (self.Recoil.AdsMultiplier * 0.5) or 1
	return angles * math.max(aimMul, 0.3)
end

function SWEP:CalculateCone()
	return math.Clamp(math.Rand(-self:GetCone(), self:GetCone()) * 1000, -self:GetCone(), self:GetCone())
end

function SWEP:MetersToHU(meters)
	return (meters * 100) / 2.54
end

SWEP.FireSurfaces = {MAT_ANTLION, MAT_BLOODYFLESH, MAT_EGGSHELL, MAT_FLESH, MAT_ALIENFLESH, MAT_PLASTIC, MAT_FOLIAGE, MAT_SLOSH, MAT_GRASS, MAT_WOOD, MAT_DIRT}

function SWEP:MakeLight(pos, color, brightness, dieTime)
end

function SWEP:BulletCallbackInternal(attacker, tr, dmgInfo)
	if not IsValid(self:GetOwner()) then return end
	local dist = tr.HitPos:DistToSqr(self:GetOwner():GetShootPos())
	local effectiveRange = self:MetersToHU(self.Bullet.EffectiveRange + 10)
	local dropoffStart = self.Bullet.DropOffStartRange and self:MetersToHU(self.Bullet.DropOffStartRange + 10) or 0
	local damage = Lerp(math.Clamp((dist - dropoffStart ^ 2) / effectiveRange ^ 2, 0, 1), self.Bullet.Damage[1], self.Bullet.Damage[2])
	damage = math.max(damage / self.Bullet.NumBullets, 1)

	local pen = self.Bullet.Penetration
	local bCanPenetrate = (GetConVar("mgbase_sv_full_penetration"):GetBool() or (self:GetMaxClip1() <= 10 or self:Clip1() % 2 == 0)) and self.Bullet.NumBullets <= 1 and (self.Projectile == nil or self.Projectile.Penetrate)

	if bCanPenetrate and self:GetPenetrationCount() < pen.MaxCount then
		local mul = pen.DamageMultiplier
		local c = pen.MaxCount - self:GetPenetrationCount()

		while (c > 0) do
			mul = mul * pen.DamageMultiplier
			c = c - 1
		end

		damage = damage * mul
	end

	if (tr.Entity == self.lastHitEntity and (tr.Entity:IsPlayer() or tr.Entity:IsNPC())) then
		dmgInfo:SetDamage(0)
		return
	end

	dmgInfo:SetDamage(damage)

	if (bCanPenetrate) then
		self.lastHitEntity = tr.Entity
	end

	if (self.Projectile == nil) then
		dmgInfo:SetDamageType(DMG_BULLET)
	end

	dmgInfo:SetDamageForce(tr.Normal * (self.Bullet.Damage[2] * self.Bullet.PhysicsMultiplier * 200) / self.Bullet.NumBullets)
	local bInWater = bit.band(util.PointContents(tr.HitPos), CONTENTS_WATER) == CONTENTS_WATER

	if (not bInWater) then
		for _, att in pairs(self:GetAllAttachmentsInUse()) do
			if (att.OnImpact ~= nil) then
				att:OnImpact(self, dmgInfo, tr)
			end
		end
	end

	if (damage <= 1.9 or tr.HitTexture == "**displacement**" or bInWater or tr.bFromRicochet) then return end

	if (bCanPenetrate and self:GetPenetrationCount() > 0) then
		if (tr.HitNoDraw or tr.HitSky) then return end
		local output = {}
		if (IsFirstTimePredicted()) then
			util.TraceLine({
				start = tr.HitPos + tr.Normal,
				endpos = tr.HitPos + tr.Normal * pen.Thickness,
				mask = MASK_SHOT,
				filter = {tr.Entity},
				ignoreworld = not IsValid(tr.Entity),
				output = output
			})

			util.TraceLine({
				start = output.HitPos,
				endpos = tr.HitPos,
				mask = MASK_SHOT,
				output = output
			})
		end

		if (output ~= nil and not output.StartSolid and not output.HitNoDraw and not output.HitSky) then
			self:SetPenetrationCount(self:GetPenetrationCount() - 1)

			if IsValid(tr.Entity) and not tr.Entity:IsPlayer() then
				self:FireBullets({
					Attacker = self:GetOwner(),
					Src = output.StartPos,
					Dir = -tr.Normal,
					Num = 1,
					Tracer = 0,
					Damage = 0
				})
			end

			self:FireBullets({
				Attacker = self:GetOwner(),
				Src = output.HitPos,
				Dir = tr.Normal,
				Num = 1,
				Tracer = 0,
				Callback = function(a, b, d)
					self:BulletCallback(a, b, d)
				end
			})
		end
	end
end

function SWEP:BulletCallback(attacker, tr, dmgInfo)
	self:BulletCallbackInternal(attacker, tr, dmgInfo)
end

function SWEP:Bullets()
	local block = hook.Call("MW19FireBullet", nil, self, self:GetOwner())

	if block then return end

	self.lastHitEntity = NULL
	self:SetPenetrationCount(self.Bullet.Penetration ~= nil and self.Bullet.Penetration.MaxCount or 0)
	local spread = Vector(self:CalculateCone(), -self:CalculateCone()) * (self.Bullet.Spread or 0.1)

	local flydist = self:MetersToHU(self.Bullet.Range + 10)
	local dist = math.min(self:GetOwner():EyePos():DistToSqr(self:GetOwner():GetEyeTrace().HitPos) / (flydist / 3) ^ 2, 1.5)

	if (self.Bullet.NumBullets == 1) then
		spread = LerpVector(self:GetAimDelta(), Vector(self:CalculateCone(), -self:CalculateCone()) * 0.1, Vector(0, 0)) * dist
	end

	local dir = (self:GetOwner():EyeAngles() + self:GetOwner():GetViewPunchAngles() + self:GetBreathingAngle() * (104 - 102 * self:GetAimDelta())):Forward()

	local aim = (Vector(0,0,0.007) * dist * 3) * math.Clamp(1 - self:GetAimDelta(), 1 - math.Clamp(self.Bullet.EffectiveRange / 200, 0, 1) , 1)

	self:GetOwner():FireBullets({
		Attacker = self:GetOwner(),
		Src = self:GetOwner():EyePos(),
		Dir = dir - aim,
		Spread = spread,
		Num = self.Bullet.NumBullets,
		Damage = self.Bullet.Damage[1],
		HullSize = 0,
		Force = (self.Bullet.Damage[1] * self.Bullet.PhysicsMultiplier) * 0.01,
		Distance = flydist,
		Tracer = 0,
		Callback = function(attacker, tr, dmgInfo)
			self:BulletCallback(attacker, tr, dmgInfo)
		end
	})

	if CLIENT then return end

	self.gunstate = self.gunstate and math.max(self.gunstate - self.Resource, 0) or 1

	if self.gunstate < 0.5 and math.Rand(0, 0.5) > self.gunstate then
		if not self.rfactor or self.rfactor < 1 and self:Clip1() > 1 then
			self:SetMalfunction(true)
			self.rfactor = math.floor(self.gunstate * 10)
		else
			self.rfactor = self.rfactor - 1
		end
	end
end

function SWEP:PrimaryAttack()
	if (not self:CanAttack()) then return end

	if self:GetMalfunction() then
		if CLIENT then self.missfire = CurTime() + 2 return false end

		if not self.MalfunctionAnimation then
			self:SetMalfunction(false)
			self:SetNextPrimaryFire(CurTime() + 0.1)
		else
			self:PlayViewModelAnimation("Jog_Out", nil, nil, true)
			self:SetNextPrimaryFire(CurTime() + 1)
			self:SetBurstRounds(0)
		end

		return false
	end

	if (self:GetIsReloading()) then
		self:EndReload()
		return
	end

	if (self.Animations.Rechamber or self:Clip1() <= 1) then
		if not self.NoPumpSycle or self:Clip1() <= 1 then self:SetHasPumped(false) end

		if (self:Clip1() <= 1 and self.ReloadRechambers) then
			self:SetHasPumped(true)
		end
	end

	self:SetClip1(self:Clip1() - 1)
	self:SetSprayRounds(self:GetSprayRounds() + 1)
	self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.HoldTypes[self.HoldType].Attack)
	
	local seqIndex = "Fire"

	if (self:Clip1() <= 0 and self.Animations["Fire_Last"] ~= nil) then
		seqIndex = "Fire_Last"
	end

	if (IsFirstTimePredicted()) then
		self:PlayViewModelAnimation(seqIndex)
	end

	self:SetNextPrimaryFire(CurTime() + (60 / self.Primary.RPM))
	self:SetBurstRounds(self:GetBurstRounds() + 1)

	if (self:GetBurstRounds() >= self.Primary.BurstRounds and self.Primary.BurstRounds > 1) then
		self:SetNextPrimaryFire(CurTime() + self.Primary.BurstDelay)
		self:SetBurstRounds(0)
	end

	local punch = self:CalculateRecoil()
	punch.p = punch.p * 1.8
	punch.y = punch.y * 1.3
	self:GetOwner():ViewPunch(punch)
	
	self:HandleReverb()

	if (self.Primary.TrailingSound ~= nil) then
		self:EmitSound(self.Primary.TrailingSound, 35)
	end

	self.lastHitEntity = NULL
	
	if IsFirstTimePredicted() then
		self:Bullets()
	end

	self:SetLastShootTime(CurTime())
	self:SetCone(math.min(self:GetCone() + self.Cone.Increase * 10 * Lerp(self:GetAimDelta(), 1, self.Cone.AdsMultiplier / GetConVar("mgbase_sv_accuracy"):GetFloat()), self.Cone.Max / GetConVar("mgbase_sv_accuracy"):GetFloat()))

	if (CLIENT and IsFirstTimePredicted()) then
		self.Camera.Shake = self.Recoil.Shake
	end

	if (self.BarrelSmoke ~= nil) and CLIENT and IsFirstTimePredicted() then
		self.m_SmokeData.Current = math.min(self.m_SmokeData.Current + self.BarrelSmoke.ShotTemperatureIncrease, self.BarrelSmoke.TemperatureThreshold)
	end
end

function SWEP:Projectiles()
	if (CLIENT) then return end
	self:SetPenetrationCount(self.Bullet.Penetration ~= nil and self.Bullet.Penetration.MaxCount or 0)
	local proj = ents.Create(self.Projectile.Class)
	local angles = self:GetOwner():EyeAngles() + self:GetOwner():GetViewPunchAngles()
	local src = LerpVector(self:GetAimDelta(), self:GetOwner():EyePos() + angles:Up() * -3 + angles:Right() * 3, self:GetOwner():EyePos())
	local spreadRight = math.Rand(-self:GetCone(), self:GetCone()) * 5
	local spreadUp = math.Rand(-self:GetCone(), self:GetCone()) * 5
	local spread = LerpVector(self:GetAimDelta(), Vector(spreadRight, spreadUp), Vector(0, 0))
	angles:RotateAroundAxis(angles:Right(), spread.x)
	angles:RotateAroundAxis(angles:Up(), spread.y)
	proj.Weapon = self
	proj:SetPos(src)
	proj:SetAngles(angles)
	proj:SetOwner(self:GetOwner())
	proj:Spawn()

	if (self.Projectile.Velocity ~= nil) then
		proj:SetVelocity(angles:Forward() * self.Projectile.Velocity)
	end
end