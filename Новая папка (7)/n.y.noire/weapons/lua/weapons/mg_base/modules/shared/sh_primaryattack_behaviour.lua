--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_primaryattack_behaviour.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

--wall lower: true when the muzzle is up against a wall. Deterministic trace, run each Think so both
--the server (fire block) and client (viewmodel lower) agree. Skipped while reloading/drawing/etc.
function SWEP:UpdateWallBlock()
	local owner = self:GetOwner()

	if (not self.WallLower or not IsValid(owner) or self:GetIsReloading() or self:IsDrawing() or self:GetIsHolstering() or self:IsCustomizing()) then
		self.m_bWallBlock = false

		return
	end

	local src = owner:GetShootPos()
	local tr = util.TraceLine({
		start = src,
		endpos = src + owner:GetAimVector() * (self.WallLowerDistance or 40),
		filter = owner,
		mask = MASK_SHOT
	})

	--walls and props lower the gun; living things (players/NPCs) do not
	self.m_bWallBlock = tr.Hit
end

function SWEP:CanAttack()
	if self:GetOwner():IsBot() then return true end
	if (self.Animations["Rechamber"] ~= nil and self:GetIsReloading() and not self:IsCustomizing()) then return true end
	if (self.Animations["Rechamber"] ~= nil and not self:GetHasPumped()) then return false end
	if (self:Clip1() <= 0) then return false end
	if (self:IsCustomizing()) then return false end
	if (self.m_bWallBlock) then return false end
	if (self:GetSafety()) then return false end
	if (CurTime() < self:GetNextPrimaryFire()) then return false end
	if (CurTime() < self:GetNextFiremodeTime()) then return false end
	if (self:GetOwner():KeyDown(IN_USE)) then return false end
	if (self:GetIsReloading() or self:GetIsHolstering() or self:IsDrawing() or self:GetIsSprinting()) then return false end
	if (CurTime() < self:GetNextMeleeTime()) then return false end
	if (CurTime() < self:GetNextSprintTime()) then return false end
	if (CurTime() < self:GetNextReloadTime() and self:GetHasFilledMag()) then return false end --avoid people from shooting after they canceled their reloads
	if (self.Trigger and self:GetTriggerDelta() < 1) then return false end
	if not self:GetOwner():IsOnGround() then return false end
	--if self:GetMalfunction() then return false end

	return true
end

function SWEP:CalculateRecoil()
	--math.randomseed(self.Recoil.Seed + self:GetSprayRounds())
	local verticalRecoil = math.min(self:GetSprayRounds(), math.min(self:GetMaxClip1() * 0.33, 20)) * 0.1 + math.Rand(self.Recoil.Vertical[1], self.Recoil.Vertical[2]) * ((self:GetOwner():getDarkRPVar("fracturearm") and not self:GetOwner():getDarkRPVar("morph")) and 3 or 1)
	local horizontalRecoil = math.Rand(self.Recoil.Horizontal[1], self.Recoil.Horizontal[2]) * ((self:GetOwner():getDarkRPVar("fracturearm") and not self:GetOwner():getDarkRPVar("morph")) and 3 or 1)
	local angles = Angle(-verticalRecoil, horizontalRecoil, horizontalRecoil * -0.3)

	return angles * math.min(Lerp(self:GetAimDelta(), 1, self.Recoil.AdsMultiplier * (MCR.HasTatoo(self:GetOwner(), "g2") and 0.6 or 1)), 1)
end

--free aim: nudge the actual aim (EyeAngles) upward each shot, on top of the view punch. Deterministic
--(no random) so it predicts cleanly, and it is NOT recovered - the player pulls back down themselves.
function SWEP:AddAimRecoil()
	local cfg = self:GetFreeAimConfig()
	local mul = (cfg.Enabled and cfg.AimRecoil) or 0

	if (mul <= 0) then return end
	if (not ((game.SinglePlayer() and SERVER) or (not game.SinglePlayer() and IsFirstTimePredicted()))) then return end

	local ply = self:GetOwner()
	if (not IsValid(ply)) then return end

	local vert = (self.Recoil.Vertical[1] + self.Recoil.Vertical[2]) * 0.5
	local climb = vert * mul * Lerp(self:GetAimDelta(), 1, self.Recoil.AdsMultiplier) --less climb while aimed
	ply:SetEyeAngles(ply:EyeAngles() - Angle(climb, 0, 0)) --negative pitch tilts the aim up
end

function SWEP:CalculateCone()
	--math.randomseed(self.Cone.Seed + self:Clip1() + self:Ammo1())

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

	-- if SERVER then
	-- 	DarkRP.UIEffect(nil, "debug", {tr.HitPos, -1, self:GetOwner():GetShootPos()})
	-- end

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

	--if we are penetrating something again (bad coz we apply double damage this way)
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

	--math.randomseed(self:Clip1() + self:Ammo1())

	if (damage <= 1.9 or tr.HitTexture == "**displacement**" or bInWater or tr.bFromRicochet) then return end

	if (bCanPenetrate and self:GetPenetrationCount() > 0) then
		if (tr.HitNoDraw or tr.HitSky) then return end
		local output = {}
		if (IsFirstTimePredicted()) then
			--debugoverlay.Axis(tr.HitPos, tr.HitNormal:Angle(), 5, 5, true)
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
			--debugoverlay.Line(tr.HitPos, output.HitPos, 5, Color(255, 0, 0, 255), true)
		end

		if (output ~= nil and not output.StartSolid and not output.HitNoDraw and not output.HitSky) then
			self:SetPenetrationCount(self:GetPenetrationCount() - 1)

			if IsValid(tr.Entity) and not tr.Entity:IsPlayer() then
				--fire back to the wall to make hole
				self:FireBullets({
					Attacker = self:GetOwner(),
					Src = output.StartPos,
					Dir = -tr.Normal,
					Num = 1,
					Tracer = 0,
					Damage = 0
				})
			end

			--fire forward
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

local blacklistzone = {
	Vector(8664.3076171875,7632.7495117188,-439.96875)
}

function SWEP:EjectDataCases(data, num)
	if not data then return end

	for _,v in pairs(blacklistzone) do
		if DarkRP.InRangeVector(v, self:GetOwner():GetPos(), 800) then return end
	end

	if self.lastEject and self.lastEject > CurTime() then
		self.lastEject = CurTime() + 0.3

		if self.lastEjectId and MW_CASES[self.lastEjectId] then
			local found = MW_CASES[self.lastEjectId]
			found.last = CurTime()
			found.cases[data] = found.cases[data] and found.cases[data] + num or num
		end

		return
	end

	self.lastEject = CurTime() + 0.3

	local found, id

	for i,p in pairs(MW_CASES) do
		if DarkRP.InRangeVector(p.pos, self:GetOwner():GetPos(), 120) then
			found = p
			id = i
			break
		end
	end

	if found then
		found.last = CurTime()
		found.cases[data] = found.cases[data] and found.cases[data] + num or num
	else
		id = table.insert(MW_CASES, {pos = self:GetOwner():GetPos(), last = CurTime(), cases = {[data] = num}})
	end

	self.lastEjectId = id
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

	local dirAng = self:GetOwner():EyeAngles() + self:GetOwner():GetViewPunchAngles() + self:GetBreathingAngle() * (104 - 102 * self:GetAimDelta())
	dirAng.p = dirAng.p + self:GetAimPitchOffset() --free aim: gun rests below the view centre
	local dir = dirAng:Forward()

	--local aim = (Vector(0,0,0.007) * dist * 3) * math.Clamp(1 - self:GetAimDelta(), 1 - math.Clamp(self.Bullet.EffectiveRange / 200, 0, 1) , 1)


	self:GetOwner():FireBullets({
		Attacker = self:GetOwner(),
		Src = self:GetOwner():EyePos(),
		Dir = dir,
		Spread = spread,
		Num = self.Bullet.NumBullets,
		Damage = self.Bullet.Damage[1],
		HullSize = 0,
		Force = (self.Bullet.Damage[1] * self.Bullet.PhysicsMultiplier) * 0.01,
		Distance = flydist,
		Tracer = 0,
		Callback = function(attacker, tr, dmgInfo)
			self:BulletCallback(attacker, tr, dmgInfo, bFromServer)
		end
	})

	if CLIENT then return end

	if self.RevolveRounds then
		if not self.CurRevolve then
			self:ResetRevolv(self:Clip1())
		end

		self.RevolveData[self.CurRevolve] = false
		self:RevolvProgress(1)

		if not self.RevolveData[self.CurRevolve] then
			self:SetMalfunction(true)
		end
	end

	self.gunstate = self.gunstate and math.max(self.gunstate - self.Resource, 0) or 1

	if self.gunstate < 0.5 and math.Rand(0, 0.5) > self.gunstate then

		if not self.rfactor or self.rfactor < 1 and self:Clip1() > 1 then
			self:SetMalfunction(true)
			self.rfactor = math.floor(self.gunstate * 10)
		else
			self.rfactor = self.rfactor - 1
		end
	end

	if self.EjectOnReload then
		self.EjectCaseNum = self.EjectCaseNum and self.EjectCaseNum + 1 or 1
		return
	end
	self:EjectDataCases(self.ShellsId, 1)
end

function SWEP:PrimaryAttack()
	if (not self:CanAttack()) then return end

	if self:GetMalfunction() then
		if CLIENT then self.missfire = CurTime() + 2 return false end

		if not self.MalfunctionAnimation then
			self:SetMalfunction(false)
			self:SetNextPrimaryFire(CurTime() + 0.1)
			if self.RevolveRounds then
				self:RevolvProgress(1)
				if not self.RevolveData[self.CurRevolve] then
					self:SetMalfunction(true)
				end
			end
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
	--self:GetOwner():DoCustomAnimEvent(PLAYERANIMEVENT_ATTACK_PRIMARY, 0)
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

	self:GetOwner():ViewPunch(self:CalculateRecoil())
	self:HandleReverb()

	if (self.Primary.TrailingSound ~= nil) then
		self:EmitSound(self.Primary.TrailingSound, 35)
	end

	--bullets
	self.lastHitEntity = NULL
	if SERVER then
		DarkRP.FirePen(self:GetOwner(), 600)
	end

	if IsFirstTimePredicted() then
		self:Bullets()
	end

	--free aim: climb the aim position (on top of the view punch above), no recovery
	self:AddAimRecoil()

	self:SetLastShootTime(CurTime())
	--cone
	self:SetCone(math.min(self:GetCone() + self.Cone.Increase * 10 * Lerp(self:GetAimDelta(), 1, self.Cone.AdsMultiplier / GetConVar("mgbase_sv_accuracy"):GetFloat()), self.Cone.Max / GetConVar("mgbase_sv_accuracy"):GetFloat()))

	if (CLIENT and IsFirstTimePredicted()) then
		self.Camera.Shake = self.Recoil.Shake --* Lerp(self:GetAimDelta(), 1, self.Recoil.AdsMultiplier)
	end

	--smoke
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
	--math.randomseed(self:Clip1() + self:Ammo1() + CurTime() + self.Cone.Seed)
	local spreadRight = math.Rand(-self:GetCone(), self:GetCone()) * 5
	--math.randomseed(-self:Clip1() * 0.5 + self:Ammo1() * 2 - CurTime() + self.Cone.Seed)
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