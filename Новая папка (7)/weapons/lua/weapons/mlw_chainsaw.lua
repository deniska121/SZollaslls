-- "addons\\weapons\\lua\\weapons\\mlw_chainsaw.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Пиздец"
SWEP.Category = "Melee"
SWEP.BluntDamage = false
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_chainsaw.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_chainsaw.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 35
SWEP.ShowWorldModel = false

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if ((ent:Health() > 0 and ent:Health() < self.RagdollizeTH) or (tr.HitGroup == 1 and dtype == 2)) then
		ent:Ragdollize(math.max(5, (ent:GetMaxHealth() - ent:Health()) * 0.5 + self.LastDamage + (tr.HitGroup == 1 and self.RagdollizeMP * 3 or self.RagdollizeMP)))
	end

	if dtype == 2 and math.random(5) > 3 then
		ent:AddTempStat("bleeding", math.random(5, 8))
	end
end

SWEP.HoldTypes = {
	[1] = "passive",
	[2] = "physgun",
	[3] = "physgun",
	[4] = "physgun",
	[5] = "physgun",
}

SWEP.DamageTypes = {
	[1] = {20, 21},
	[2] = {31, 45}
}

SWEP.Stamina = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
}

SWEP.StaminaMaxPen = 0
SWEP.StaminaCD = 0

SWEP.IdleAnim = {
	[1] = nil,
	[2] = "Idle",
	[3] = "Attack_Charge_Idle",
	[4] = "idleOn",
	[5] = "Attack_On",
}

SWEP.AttackAnim = {
	[1] = "Attack_Quick2",
	[2] = "Attack_Charge_Begin",
	[3] = "Attack_Charge_End",
	[4] = "idle_to_attack",
	[5] = "attack_to_idle",
	[6] = "turnoff",
	[7] = "turnon",
	[8] = "Idle",
}

SWEP.HoldIdels = {
	[1] = "Holster",
	[2] = "Draw",
	[3] = "Idle",
	[5] = "Idle",
}

SWEP.RunIdle = "Sprint"
SWEP.WalkIdle = "Walk"

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_chainsaw.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(-4, 1, -1),
		angle = Angle(180, 180, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

function SWEP:SecondaryAttack()
	if self:GetState() < 2 then
		local trace = self:GetOwner():GetEyeTrace().Entity

		if SERVER and trace and IsValid(trace) and trace:IsPlayer() and trace:Alive() and NoireSandbox.InRange(trace, self:GetOwner(), 60) and trace:GetMoveType() == MOVETYPE_WALK then
			if not self:GetOwner():HasStamina(10) or self:GetOwner():GetNWBool("fracturearm", false) then return end
			if self:GetOwner():Health() < 20 then return end

			timer.Simple(0.3, function()
				if not IsValid(self) then return end
				self:Push(trace)
			end)
			self:GetOwner():TakeStamina(9)
			self:SetNextSecondaryFire(CurTime() + 2.2)
			self:GetOwner():SetCycle(0)
			self:GetOwner():SetNWString("rice_anim_n", "")
			self:GetOwner():SetNWFloat("rice_anim", CurTime() + 1.6)
			NoireSandbox.UIEffect(nil, "plyAnimSetCycle", {self:GetOwner():UserID()})
			NoireSandbox.UIEffect(nil, "anim_keys", {type = "shove", ply = self:GetOwner():UserID()})
		end

		return
	end

	if self.Running then return end

	self.idleto = self:GetState() >= 4 and 2 or 4

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(self.AttackAnim[self:GetState() >= 4 and 6 or 7]))
	self:UpdateNextIdle()

	self:SetHoldType(self.HoldTypes[3])
	self:GetOwner():ViewPunch(Angle(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)))

	self:SetNextCharge(CurTime() + vm:SequenceDuration())
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration() + 0.5)
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration() + 0.5)
	self.runpenalty = self.idleto == 4

	if CLIENT then return end

	if self.idleto == 4 then
		timer.Simple(0.5, function()
			if not IsValid(self) then return end
			self:GetOwner():EmitSound("Weapon_Chainsaw.StartupFailed")
		end)
		timer.Simple(1, function()
			if not IsValid(self) then return end
			self:GetOwner():EmitSound("Weapon_Chainsaw.StartupSuccess")
		end)
	else
		self:StopIdleSND()
	end
end

function SWEP:PrimaryAttack()
	if self:GetState() < 2 then return end
	if self.Running then return end


	if self:GetState() == 4 then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence("idle_to_attack"))
		self:UpdateNextIdle()
		self:StopIdleSND()
		self:SetState(5)
		self:SetNextPrimaryFire(CurTime() + 1)
		return
	end

	if self:GetState() == 5 then
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence("attack_to_idle"))
		self:UpdateNextIdle()
		self:StopIdleSND()
		self:SetState(4)
		self:SetNextPrimaryFire(CurTime() + 1)
		return
	end

	if (self:GetOwner():GetNWBool("NoireTattoo_a7", false) or self:CanUseStamina(self.Stamina[1] + self:GetPenalty())) and not self:GetOwner():GetNWBool("fracturearm", false) then
		self:SwingHands(1)
	else
		self:SetNextPrimaryFire(CurTime() + 1)
		self:SetNextSecondaryFire(CurTime() + 1)
		if SERVER then NoireSandbox.Notify(self:GetOwner(), 0, 5, "Вы устали или у вас сломана рука") end
		self:Reload()
	end
end

function SWEP:StopIdleSND()
	if self.idlesnd then
		self.idlesnd:Stop()
		self.idlesnd = nil
	end
end

function SWEP:DealSlashDamage()
	if self.lastslash and self.lastslash > CurTime() then return end
	if self:GetOwner():isArrested() then return end
	self.lastslash = CurTime() + 0.1
	self:GetOwner():LagCompensation(true)

	local tr = util.TraceLine({
		start = self:GetOwner():GetShootPos(),
		endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * self.HitDistance,
		filter = self:GetOwner(),
		mask = MASK_SHOT_HULL
	})

	if (not IsValid(tr.Entity)) then
		tr = util.TraceHull({
			start = self:GetOwner():GetShootPos(),
			endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * self.HitDistance,
			filter = self:GetOwner(),
			mins = Vector(-10, -10, -8),
			maxs = Vector(10, 10, 8),
			mask = MASK_SHOT_HULL
		})
	end

	self.LastDamage = math.random(6, 8)

	if SERVER and IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer()) and tr.Entity:Health() > 0 then
		local dmginfo = DamageInfo()
		local attacker = self:GetOwner()

		if (not IsValid(attacker)) then
			attacker = self
		end

		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(self.LastDamage)
		dmginfo:SetDamageForce(self:GetOwner():GetRight() * 5 + self:GetOwner():GetForward() * 5) -- Yes we need those specific numbers

		SuppressHostEvents(NULL)
		tr.Entity:TakeDamageInfo(dmginfo)
		SuppressHostEvents(self:GetOwner())

		if tr.Entity:IsPlayer() and tr.Entity:Health() - self.LastDamage < 1 then
			self:GetOwner():LagCompensation(false)
			return
		end

		if tr.Entity:IsPlayer() then
			tr.Entity:AddTempStat("shock", math.random(7))
		end

		hit = true
	elseif SERVER then
		self:GetOwner():FireBullets({
		Src = tr.StartPos,
		Dir = self:GetOwner():EyeAngles():Forward(),
		Distance = self.HitDistance,
		HullSize = 0,
		Tracer = 0,
		Callback = function(attacker, btr, dmgInfo)
				dmgInfo:SetDamage(self.LastDamage / 2)
				dmgInfo:SetInflictor(self)
				dmgInfo:SetAttacker(self:GetOwner())
				dmgInfo:SetDamagePosition(btr.HitPos)
				dmgInfo:SetDamageForce(self:GetOwner():EyeAngles():Forward() * self.LastDamage * 0.3)
				dmgInfo:SetDamageType(DMG_CLUB)
				hit = true
			end
		})
	end

	-- if (IsValid(tr.Entity)) then
	-- 	local phys = tr.Entity:GetPhysicsObject()

	-- 	if (IsValid(phys)) then
	-- 		phys:ApplyForceOffset(self:GetOwner():GetAimVector() * self.LastDamage * 6 * phys:GetMass() * scale, tr.HitPos)
	-- 	end
	-- end

	self:GetOwner():LagCompensation(false)
end

function SWEP:Think()
	local vm = self:GetOwner():GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	self.Running = self:GetOwner():KeyDown(IN_SPEED) and self:GetOwner():GetVelocity():Length2DSqr() > 20000

	if self.Running and not self.OldState or self.OldState ~= self.Running then
		self.OldState = self.Running
		idletime = 1
		if self:GetState() ~= 1 then
			self:SetHoldType(self.Running and self.HoldTypes[1] or self.HoldTypes[self:GetState()])
		end
	end

	if (idletime > 0 and curtime > idletime) then
		local idle = self.IdleAnim[self:GetState()]

		if self:GetState() == 2 and self.Running then
			idle = self.RunIdle
			self.idleDelay = 0.2
		else
			self.idleDelay = 0
		end

		if idle then
			vm:SendViewModelMatchingSequence(vm:LookupSequence(idle))
			self:UpdateNextIdle(self.idleDelay)
		end
	end

	local melee = self:GetNextAttack()
	local charge = self:GetNextCharge()

	if (melee > 0 and curtime > melee) then
		self:DealDamage(self.AttackType or 1)
		self:SetNextAttack(0)
		self:SetHoldType(self.HoldTypes[self:GetState()])
		self.runpenalty = nil
	end

	if (charge > 0 and curtime > charge) then
		self:SetNextCharge(0)
		if SERVER then
			self:SetState(self.idleto)
			self.idleto = nil
			self:SetNextIdle(CurTime())
		end
	end

	if CLIENT then return end

	if self:GetState() == 5 then
		self:DealSlashDamage()
	end

	if self:GetState() >= 4 then
		if not self.idlesnd then
			self.idlesnd = CreateSound( self, self:GetState() == 4 and "weapons/melee/chainsaw/chainsaw_idleloop.wav" or "weapons/melee/chainsaw/chainsaw_sawloop.wav")
			self.idlesnd:PlayEx(self:GetState() == 4 and 0.4 or 0.6, 100)
		end
	else
		if self.idlesnd then
			self:StopIdleSND()
		end
	end
end

function SWEP:Holster()
	self:UnloadSWB()
	self:StopIdleSND()
	self:SetNextAttack(0)
	self:SetNextCharge(0)
	if self.InProgress then net.SendSingleMessage("RemovePropgressBar", self:GetOwner()) end
	self.InProgress = false
	return true
end

function SWEP:OnRemove()
	self:StopIdleSND()
end
