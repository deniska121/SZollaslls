--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_melee_behaviour.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:CanMelee()
	return not self:GetIsSprinting() and not self:GetIsHolstering() and not self:IsDrawing() and CurTime() > self:GetNextPrimaryFire() and CurTime() > self:GetNextSprintTime() and not self:IsCustomizing()
end

function SWEP:DoMelee()
	-- if (self:GetOwner():getDarkRPVar("fracturearm") and not self:GetOwner():getDarkRPVar("morph")) then
	-- 	return false
	-- end
	-- self:GetOwner():HasStamina(18)
	if SERVER then self:GetOwner():TakeStamina(self.Animations["Melee_Hit"].Damage / 6) end

	self:SetIsReloading(false)
	--self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.HoldTypes[self.HoldType].Melee)
	local range = self.Animations["Melee"].Range

	local hit = false

	local tr = util.TraceLine({
		start = self:GetOwner():GetShootPos(),
		endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * range,
		filter = self:GetOwner(),
		mask = MASK_SHOT_HULL
	})

	if (not IsValid(tr.Entity)) then
		tr = util.TraceHull({
			start = self:GetOwner():GetShootPos(),
			endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * range,
			filter = self:GetOwner(),
			mins = Vector(-10, -10, -8),
			maxs = Vector(10, 10, 8),
			mask = MASK_SHOT_HULL
		})
	end

	local scale = 0.2

	if SERVER then
		if IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer()) and tr.Entity:Health() > 0 then
			local dmginfo = DamageInfo()
			local attacker = self:GetOwner()

			if (not IsValid(attacker)) then
				attacker = self
			end

			dmginfo:SetAttacker(attacker)
			dmginfo:SetInflictor(self)
			dmginfo:SetDamage(self.Animations["Melee_Hit"].Damage / 2)
			dmginfo:SetDamageForce(self:GetOwner():GetUp() * 5158 * scale + self:GetOwner():GetForward() * 10012 * scale)

			SuppressHostEvents(NULL) -- Let the breakable gibs spawn in multiplayer on client
			tr.Entity:TakeDamageInfo(dmginfo)
			SuppressHostEvents(self:GetOwner())

			if tr.Entity:IsPlayer() and tr.Entity:Health() > 0 and (tr.Entity:Health() < 30 or tr.HitGroup == 1) then
				tr.Entity:Ragdollize(25 + self.Animations["Melee_Hit"].Damage)
			end

			hit = true
		else
			self:FireBullets({
			Src = self:GetOwner():EyePos(),
			Dir = self:GetOwner():EyeAngles():Forward(),
			Distance = range,
			HullSize = 0,
			Tracer = 0,
			Callback = function(attacker, btr, dmgInfo)
					dmgInfo:SetDamage(self.Animations["Melee_Hit"].Damage / 4)
					dmgInfo:SetInflictor(self)
					dmgInfo:SetAttacker(self:GetOwner())
					dmgInfo:SetDamagePosition(btr.HitPos)
					dmgInfo:SetDamageForce(self:GetOwner():EyeAngles():Forward() * (self.Animations["Melee_Hit"].Damage * 50))
					dmgInfo:SetDamageType(DMG_CLUB)
					hit = true
				end
			})
		end

		if (IsValid(tr.Entity)) then
			local phys = tr.Entity:GetPhysicsObject()
			if (IsValid(phys)) then
				phys:ApplyForceOffset(self:GetOwner():GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos)
			end
		end
	end

	if hit then
		self:SetNextMeleeTime(CurTime() + self:GetAnimLength("Melee_Hit", self.Animations["Melee_Hit"].Length) + 1.3)

		if (IsFirstTimePredicted()) then
			self:PlayViewModelAnimation("Melee_Hit")
		end

		if SERVER and tr.Hit and self:GetOwner():getDarkRPVar("fracturearm") then
			self:GetOwner():AddTempStat("shock", math.random(3))
		end
	else
		self:SetNextMeleeTime(CurTime() + self:GetAnimLength("Melee", self.Animations["Melee"].Length + 1.3))

		if (IsFirstTimePredicted()) then
			self:PlayViewModelAnimation("Melee")
		end
	end

	if SERVER then
		DarkRP.ForceAnimation(self:GetOwner(), "meleeattack01", 1.3)
	end
end

function SWEP:MeleeBehaviourModule()
	if (game.SinglePlayer() and CLIENT) then return end

	if ((self:GetOwner():KeyDown(IN_USE) or self.Melee) and self:GetOwner():KeyPressed(IN_ATTACK)) then
		self:SetSafety(false)
		self:SetShouldHoldType(true)
		if (self:CanMelee()) and CurTime() > self:GetNextMeleeTime() then self:DoMelee() end
	end
end