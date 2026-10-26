-- "addons\\weapons\\lua\\weapons\\mlw_base\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.PrintName = "Base Melee"
SWEP.Base = "base_swb"
SWEP.Author = "MacTavish"
SWEP.Purpose = ""
SWEP.Category = "Melee"
SWEP.Slot = 0
SWEP.SlotPos = 0
SWEP.Weight = 0
SWEP.Spawnable = false
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_crowbar.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_crowbar.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.UseHands = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.HitDistance = 50
SWEP.BluntDamage = true
SWEP.SharpDamage = false
SWEP.RagdollizeTH = 40
SWEP.RagdollizeMP = 10

SWEP.ChargeAttackDelay = 0.2
SWEP.SimpleAttackDelay = 0.4

SWEP.ChargeAttackCD = 0.9
SWEP.SimpleAttackCD = 0.9

SWEP.DamageTypes = {
	[1] = {8,21},
	[2] = {21,45}
}

SWEP.LightSwing = {"weapons/melee/swing_light_sharp_01.wav", "weapons/melee/swing_light_sharp_02.wav", "weapons/melee/swing_light_sharp_03.wav"}
SWEP.HeavySwing = {"weapons/melee/swing_heavy_sharp_01.wav", "weapons/melee/swing_heavy_sharp_02.wav", "weapons/melee/swing_heavy_sharp_03.wav"}
SWEP.DrawSounds = {"weapons/melee/melee_draw_temp2.wav"}
SWEP.HolsterSounds = {"weapons/melee/melee_holster_temp1.wav", "weapons/melee/melee_holster_temp2.wav"}


SWEP.HitSounds = {
	["brick"] = {"nmrihimpact/brick/brick_impact_bullet%s.wav", 1, 5},
	["cardboard"] = {"nmrihimpact/cardboard/ammo_box_impact_0%s.wav", 1, 5},
	["concrete"] = {"nmrihimpact/concrete/old/concrete_impact_bullet%s.wav", 1, 5},
	["metal"] = {"nmrihimpact/metal/metal_solid_impact_bullet%s.wav", 1, 5},
	["fence"] = {"physics/metal/metal_chainlink_impact_hard%s.wav", 1, 3},
	["sand"] = {"nmrihimpact/surfaces/sand_impact_bullet%s.wav", 1, 5},
	["wood"] = {"nmrihimpact/wood/wood_solid_impact_bullet%s.wav", 1, 5},
	["heavy"] = {"nmrihimpact/blunt_heavy%s.wav", 1, 6},
	["light"] = {"nmrihimpact/blunt_light%s.wav", 1, 8},
	["glass"] = {"physics/glass/glass_impact_bullet%s.wav", 1, 4},
	["plastic"] = {"physics/plastic/plastic_box_impact_bullet%s.wav", 1, 5},
}

SWEP.PickSound = {
	[MAT_ANTLION] = "flesh",
	[MAT_ALIENFLESH] = "flesh",
	[MAT_BLOODYFLESH] = "flesh",
	[MAT_FLESH] = "flesh",
	[MAT_EGGSHELL] = "flesh",
	[MAT_CONCRETE] = "concrete",
	[MAT_DIRT] = "sand",
	[MAT_SNOW] = "sand",
	[MAT_SAND] = "sand",
	[MAT_GRASS] = "sand",
	[MAT_GRATE] = "fence",
	[MAT_CLIP] = "metal",
	[MAT_METAL] = "metal",
	[MAT_VENT] = "metal",
	[MAT_PLASTIC] = "plastic",
	[MAT_FOLIAGE] = "sand",
	[MAT_COMPUTER] = "cardboard",
	[MAT_TILE] = "brick",
	[MAT_WOOD] = "wood",
	[MAT_GLASS] = "wood",
}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "melee",
	[3] = "melee2",
}

SWEP.Stamina = {
	[1] = 3,
	[2] = 5,
	[3] = 3,
}

SWEP.StaminaMaxPen = 7
SWEP.StaminaCD = 5

SWEP.IdleAnim = {
	[1] = nil,
	[2] = "Idle",
	[3] = "Attack_Charge_Idle",
}

SWEP.AttackAnim = {
	[1] = "Attack_Quick",
	[2] = "Attack_Charge_Begin",
	[3] = "Attack_Charge_End",
}

SWEP.HoldIdels = {
	[1] = "Holster",
	[2] = "Draw",
	[3] = "Idle",
}

SWEP.RunIdle = "Sprint"
SWEP.WalkIdle = "Walk"

function SWEP:PlayImpactSound(surf, hard)

	local stype = self.PickSound[surf]

	if not stype then return end

	if stype == "flesh" then
		stype = hard and "heavy" or "light"
	end

	local snd = self.HitSounds[stype]

	self:EmitSound(string.format(snd[1], math.random(snd[2], snd[3])))
end

function SWEP:Initialize()
	self:InitializeModels()

	self:SetHoldType("normal")
	self:SetState(1)
	self:SetPenalty(0)
	self.ShowHint = CurTime() + 10
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextAttack")
	self:NetworkVar("Float", 1, "NextCharge")
	self:NetworkVar("Float", 2, "NextIdle")
	self:NetworkVar("Float", 3, "NextReload")
	self:NetworkVar("Float", 4, "Penalty")
	self:NetworkVar("Int", 0, "State")
end

function SWEP:UpdateNextIdle(stime)
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate() - (stime or 0))
end

function SWEP:ChangeAnim(anim)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	self:UpdateNextIdle()

	return vm
end

function SWEP:Deploy()
	if self:GetState(1) then self:SetState(1) end

	--self:GetOwner():SetCanZoom(true)
	self.runpenalty = nil
	self:ChangeAnim(self.HoldIdels[self:GetState()])
	return true
end

function SWEP:Reload()
	local CT = CurTime()
	if self:GetNextReload() > CT then return end

	self:SetState(self:GetState() == 1 and 2 or 1)
	local vm = self:ChangeAnim(self.HoldIdels[self:GetState()])
	self:SetHoldType(self.HoldTypes[self:GetState()])

	self:SetNextReload(CurTime() + 0.3 + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:CanUseStamina(num)
	return self:GetOwner():HasStamina(num)
end

function SWEP:UseStamina(type)
	if CLIENT then return end
end

function SWEP:SwingHands(dtype)

	if SERVER then
		if self.LastAttack and self.LastAttack + self.StaminaCD > CurTime() then
			self:SetPenalty(math.min(self:GetPenalty() + 1, self.StaminaMaxPen))
		else
			self:SetPenalty(0)
		end
	end

	if dtype == 0 then
		dtype = 1
		local vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence(self.AttackAnim[dtype]))
		vm:SetPlaybackRate(0.75)
		self:UpdateNextIdle()
		self.runpenalty = true

		self.AttackType = 3
		self:GetOwner():ViewPunch(Angle(math.random(-1, 1), 2, math.random(-1, 1)))
		self:EmitSound(self.LightSwing[math.random(#self.LightSwing)])
		self:SetNextAttack(CurTime() + self.SimpleAttackDelay * 1.5)
		self:SetNextPrimaryFire(CurTime() + self.SimpleAttackCD)
		self:SetNextSecondaryFire(CurTime() + self.SimpleAttackCD)
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
		self.LastAttack = CurTime()

		if SERVER then self:GetOwner():TakeStamina(6 + self:GetPenalty(), 10) end
		return
	end

	if not self:CanUseStamina(self.Stamina[dtype] + self:GetPenalty()) and not self:GetOwner():GetNWBool("NoireTattoo_a7", false) then return end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(self.AttackAnim[dtype]))
	self:UpdateNextIdle()
	self.runpenalty = true

	if dtype == 1 then
		self.AttackType = 1
		self:GetOwner():ViewPunch(Angle(math.random(-1, 1), 2, math.random(-1, 1)))
		self:EmitSound(self.LightSwing[math.random(#self.LightSwing)])
		self:SetNextAttack(CurTime() + self.SimpleAttackDelay)
		self:SetNextPrimaryFire(CurTime() + self.SimpleAttackCD)
		self:SetNextSecondaryFire(CurTime() + self.SimpleAttackCD)
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	else
		self:SetHoldType(self.HoldTypes[3])
		self:GetOwner():ViewPunch(Angle(math.random(-1, 1), math.random(-1, 1), math.random(-1, 1)))
		self:EmitSound(self.DrawSounds[math.random(#self.DrawSounds)])
		self:SetNextCharge(CurTime() + vm:SequenceDuration())
		self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration() + 0.5)
		self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration() + 0.5)
	end

	if SERVER then
		self:GetOwner():TakeStamina(self.Stamina[dtype] + self:GetPenalty())
		self.LastAttack = CurTime()
	end
end

function SWEP:PrimaryAttack()
	if self:GetState() < 2 then return end
	if self.Running then return end

	if (self:GetOwner():GetNWBool("NoireTattoo_a7", false) or self:CanUseStamina(self.Stamina[1] + self:GetPenalty())) and not self:GetOwner():GetNWBool("fracturearm", false) then
		self:SwingHands(1)
	else
		self:SwingHands(0)
		-- self:SetNextPrimaryFire(CurTime() + 1)
		-- self:SetNextSecondaryFire(CurTime() + 1)
		-- if SERVER then DarkRP.notify(self:GetOwner(), 0, 5, "Вы устали или у вас сломана рука") end
		-- self:Reload()
	end
end

local PushSound = {"physics/body/body_medium_impact_hard1.wav", "physics/body/body_medium_impact_hard2.wav", "physics/body/body_medium_impact_hard3.wav", "physics/body/body_medium_impact_hard5.wav", "physics/body/body_medium_impact_hard6.wav", "physics/body/body_medium_impact_soft5.wav", "physics/body/body_medium_impact_soft6.wav", "physics/body/body_medium_impact_soft7.wav",}

function SWEP:Push(trace)
	if trace and IsValid(trace) and trace:IsPlayer() and trace:Alive() and NoireSandbox.InRange(trace, self:GetOwner(), 60) and trace:GetMoveType() == MOVETYPE_WALK then
		if trace:IsOnGround() and trace:GetPos().z < self:GetOwner():GetPos().z + 20 and (trace:GetNWBool("heroin", false) or trace:GetNWFloat("alcohol", 0) <= 20) and (trace.lastPickup or 0) < CurTime() then
			local dir = self:GetOwner():EyeAngles():Forward()
			dir.z = 0
			trace:EmitSound(PushSound[math.random(#PushSound)])
			trace:SetVelocity(dir * 400)
			trace:ViewPunch(Angle(math.random(-30), math.random(-30), 0))
		else
			trace:Ragdollize(3)
		end
	end
end

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

	if (self:GetOwner():GetNWBool("NoireTattoo_a7", false) or self:CanUseStamina(self.Stamina[2] + self:GetPenalty())) and not self:GetOwner():GetNWBool("fracturearm", false) then
		self:SwingHands(2)
	else
		self:SwingHands(0)
		-- self:SetNextPrimaryFire(CurTime() + 1)
		-- self:SetNextSecondaryFire(CurTime() + 1)
		-- if SERVER then DarkRP.notify(self:GetOwner(), 0, 5, "Вы устали или у вас сломана рука") end
		-- self:Reload()
	end
end

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if ent:IsPlayer() and ((ent:Health() > 0 and ent:Health() < self.RagdollizeTH) or (tr.HitGroup == 1 and self.BluntDamage and dtype == 2) or (dtype == 2 and self:GetOwner():GetNWBool("NoireTattoo_b7", false) and self.BluntDamage)) then
		ent:Ragdollize(math.max(5, (ent:GetMaxHealth() - ent:Health()) * 0.5 + self.LastDamage + (tr.HitGroup == 1 and self.RagdollizeMP * 3 or self.RagdollizeMP)))
	end
end

function SWEP:DealDamage(dtype)
	if self:GetOwner():isArrested() then return end
	local mod
	if dtype == 3 then
		mod = true
		dtype = 1
	end
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

	if (tr.Hit and not (game.SinglePlayer() and CLIENT)) then
		self:PlayImpactSound(tr.MatType, dtype == 2)
	end

	local scale = 0.2

	self.LastDamage = mod and self.DamageTypes[dtype][1] / 2 or math.random(self.DamageTypes[dtype][1], self.DamageTypes[dtype][2])

	if SERVER and IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer()) and tr.Entity:Health() > 0 then
		local dmginfo = DamageInfo()
		local attacker = self:GetOwner()

		if (not IsValid(attacker)) then
			attacker = self
		end

		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(self.LastDamage)
		dmginfo:SetDamageForce(self:GetOwner():GetRight() * 4912 * scale + self:GetOwner():GetForward() * 9998 * scale) -- Yes we need those specific numbers

		SuppressHostEvents(NULL) -- Let the breakable gibs spawn in multiplayer on client
		tr.Entity:TakeDamageInfo(dmginfo)
		SuppressHostEvents(self:GetOwner())

		if tr.Entity:IsPlayer() and tr.Entity:Health() - self.LastDamage < 1 then
			self:GetOwner():LagCompensation(false)
			return
		end

		if not mod then self:ExtraDamageFunction(dtype, tr.Entity, tr) end

		if tr.Entity:IsPlayer() and self:GetOwner():GetNWBool("NoireTattoo_b3", false) and not mod then
			tr.Entity:AddTempStat("shock", math.random(3))
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

	if SERVER and self:GetOwner():GetNWBool("fracturearm", false) then
		self:GetOwner():AddTempStat("shock", math.random(3))
	end

	if (IsValid(tr.Entity)) then
		local phys = tr.Entity:GetPhysicsObject()

		if (IsValid(phys)) then
			phys:ApplyForceOffset(self:GetOwner():GetAimVector() * self.LastDamage * 6 * phys:GetMass() * scale, tr.HitPos)
		end
	end

	self:GetOwner():LagCompensation(false)
end

function SWEP:Holster()
	self:UnloadSWB()

	self:SetNextAttack(0)
	self:SetNextCharge(0)
	if self.InProgress then net.SendSingleMessage("RemovePropgressBar", self:GetOwner()) end
	self.InProgress = false
	return true
end

SWEP.Running = false

function SWEP:Think()
	local vm = self:GetOwner():GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	self.Running = self:GetOwner():KeyDown(IN_SPEED) and self:GetOwner():GetVelocity():Length2DSqr() > 20000

	if self.Running and not self.OldState or self.OldState ~= self.Running then
		self.OldState = self.Running
		idletime = 1
		if self:GetState() > 1 then
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
		self.AttackType = 2
		vm:SendViewModelMatchingSequence(vm:LookupSequence(self.AttackAnim[3]))
		self:GetOwner():ViewPunch(Angle(math.random(-1, 1), 2, math.random(-1, 1)))
		self:EmitSound(self.HeavySwing[math.random(#self.HeavySwing)])
		self:SetNextAttack(CurTime() + self.ChargeAttackDelay)
		self:SetNextPrimaryFire(CurTime() + self.ChargeAttackCD)
		self:SetNextSecondaryFire(CurTime() + self.ChargeAttackCD)
		self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	end
end

if CLIENT then

	SWEP.Time = 0
	SWEP.Switch = 1

	local clrs = {
		m = Color(255, 255, 255, 200),
		s = Color(127, 127, 127, 150),
		d = Color(0, 0, 0, 20),
		r = Color(255, 0, 0),
	}

	local mats = {
		[1] = Material("msd/icons/hand-right.png", "smooth"),
		[2] = Material("msd/icons/hand-okay.png", "smooth"),
		[3] = Material("msd/icons/key-variant.png", "smooth"),
		[4] = Material("msd/icons/cross.png", "smooth"),
		[5] = Material("msd/icons/lock.png", "smooth")
	}

	local scw, sch = ScrW(), ScrH()
	local x, y = scw / 2, sch / 2

	function SWEP:DrawHUD()
		if self:GetOwner():InVehicle() or GetConVar("cl_drawhud"):GetInt() == 0 then return end
		local Pos = self:GetOwner():GetShootPos()
		local Aim = self:GetOwner():GetAimVector()
		local index = self:GetState()

		local Tr = util.TraceLine({start = Pos, endpos = Pos + Aim * self.HitDistance, filter = LocalPlayer()})
		local HitEnt = Tr.Entity

		if IsValid(HitEnt) and HitEnt:IsPlayer() and index == 1 then
			self.Time = math.min(1, self.Time + 2 * FrameTime())
		else
			self.Time = math.max(0, self.Time - 2 * FrameTime())
			x, y = scw / 2, sch / 2
			MSD.DrawTexturedRect(x - 10, y - 10, 24, 24, MSD.Icons48.dot, MSD.ColorAlpha(color_white, 60 - 60 * self.Time))
		end

		if self.Time > 0 and IsValid(HitEnt) and HitEnt:IsPlayer() and LocalPlayer():Health() > 20 and index == 1 then
			x, y = scw / 2, sch / 2
			MSD.DrawTexturedRect(x - 10, y - 10, 24, 24, mats[1], MSD.ColorAlpha(color_black, 200 * self.Time))
			MSD.DrawTexturedRect(x - 12, y - 12, 24, 24, mats[1], MSD.ColorAlpha(color_white, 200 * self.Time))

			x, y = scw * 0.52, sch * 0.5 - 8
			local sp = MSD.DrawKey(x, y - 3, "ПКМ", self.Time * 150)
			draw.SimpleTextOutlined("Толкнуть", "M_Roboto", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))
		end

		if GetConVar("sbox_noire_hints"):GetInt() > 0 and self.ShowHint and self.ShowHint < CurTime() then
			x, y = scw * 0.5, sch * 0.8
			local sp = draw.SimpleTextOutlined("Для переключения режимов нажмите", "M_Roboto", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
			MSD.DrawKey(x + sp / 2 + 10, y - 3, input.LookupBinding("+reload"))
		end

		if self.ExtraHint then
			self:ExtraHint(x, y, scw, sch, clrs)
		end
	end
end
