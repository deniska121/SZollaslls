--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/keys/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.PrintName = "Руки"
SWEP.Author = "MacTavish"
SWEP.Purpose = "Yes"
SWEP.Slot = 1
SWEP.SlotPos = 4
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
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
SWEP.HitDistance = 65
SWEP.ObjDistance = 25

SWEP.HoldSelect = 1

SWEP.HoldTables = {
	"pistol",
	"slam",
}

local disallowed_class = {}

function SWEP:Initialize()
	self:SetHoldType("normal")
	self:SetState(1)
	self:SetNextReload(0)
	self:SetPickState(0)
	self.ShowHint = CurTime() + 10
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "NextIdle")
	self:NetworkVar("Float", 2, "NextReload")
	self:NetworkVar("Float", 3, "PickState")
	self:NetworkVar("Int", 4, "Combo")
	self:NetworkVar("Int", 5, "State")
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:SwingHands(right, slowed)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	local anim = "fists_left"
	local punch = math.random(3)

	if right then
		anim = "fists_right"
	end

	if self:GetCombo() >= 2 and self:GetOwner():HasStamina(20) and not slowed then
		anim = "fists_uppercut"
		punch = 5
	end

	self:GetOwner():ViewPunch(Angle(punch, math.random(-1, 1), math.random(-1, 1)))
	self:EmitSound("weapons/melee/fists/fist_holster.wav", 65, slowed and 75 or math.random(80, 120))
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	vm:SetPlaybackRate(slowed and 0.7 or 1)

	self:UpdateNextIdle()
	self:SetNextMeleeAttack(CurTime() + (slowed and 0.25 or 0.2))
	self:SetNextPrimaryFire(CurTime() + (slowed and 1.2 or 0.7) + math.Rand(-0.15, 0.15))
	self:SetNextSecondaryFire(CurTime() + (slowed and 1.2 or 0.7) + math.Rand(-0.15, 0.15))

	if SERVER then
		self:GetOwner():TakeStamina(punch * 3, 3)
	end
end

local blockent = {
	["gmod_sent_vehicle_fphysics_wheel"] = true,
	["gmod_sent_vehicle_fphysics_gib"] = true,
	["mcs_npc"] = true,
	["police_station"] = true,
	["weapon_thow"] = true,
	["prop_effect"] = true,
}

function SWEP:InvCheck(ent)
	if not IsValid(ent) then return false end
	local class = ent:GetClass()

	if disallowed_class[class] then
		if SERVER then DarkRP.notify(self:GetOwner(), 1, 4, "Предмет поврежден") end
		return false
	end
	if McINV.pickups[class] then return true end
	return DarkRP.Entities[class] and true
end

function SWEP:PrimaryAttack()
	if self:GetState() > 1 then
		if self:GetOwner():HasStamina(3) and not self:GetOwner():getDarkRPVar("fracturearm") and self:GetOwner():Health() > 22 then
			self:SwingHands(false)
		else
			self:SwingHands(false, true)
		end
		return
	end

	self:SetNextPrimaryFire(CurTime() + 0.5)
	self:DoPick(true)
end

local PushSound = {"physics/body/body_medium_impact_hard1.wav", "physics/body/body_medium_impact_hard2.wav", "physics/body/body_medium_impact_hard3.wav", "physics/body/body_medium_impact_hard5.wav", "physics/body/body_medium_impact_hard6.wav", "physics/body/body_medium_impact_soft5.wav", "physics/body/body_medium_impact_soft6.wav", "physics/body/body_medium_impact_soft7.wav",}

function SWEP:Push(trace)
	if trace and IsValid(trace) and trace:IsPlayer() and trace:Alive() and DarkRP.InRange(trace, self:GetOwner(), 60) and trace:GetMoveType() == MOVETYPE_WALK then
		if trace:IsOnGround() and trace:GetPos().z < self:GetOwner():GetPos().z + 20 and (trace:getDarkRPVar("heroin") or (trace:getDarkRPVar("alcohol") or 0) <= 20) and (trace.lastPickup or 0) < CurTime() then
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
	if self:GetState() > 1 then
		if self:GetOwner():HasStamina(3) and not self:GetOwner():getDarkRPVar("fracturearm") and self:GetOwner():Health() > 22 then
			self:SwingHands(true)
		else
			self:SwingHands(true, true)
		end
		return
	end

	if IsValid(self.EntHolding) and not self.CarryHack.dragFixed and not self.dt.carried_rag then
		self.HoldSelect = self.HoldSelect + 1
		if self.HoldSelect > #self.HoldTables then
			self.HoldSelect = 1
		end
		self:SetHoldType(self.HoldTables[self.HoldSelect])
		self:SetNextSecondaryFire(CurTime() + 0.1)
		return
	end

	self:SetNextSecondaryFire(CurTime() + 0.3)

	if self:GetOwner():isArrested() then return end

	if CLIENT or self.InProgress then return end

	local trace = self:GetOwner():GetEyeTrace().Entity

	if trace and IsValid(trace) and trace:IsPlayer() and trace:Alive() and DarkRP.InRange(trace, self:GetOwner(), 60) and trace:GetMoveType() == MOVETYPE_WALK then
		if not self:GetOwner():HasStamina(10) or self:GetOwner():getDarkRPVar("fracturearm") then return end
		if self:GetOwner():Health() < 20 then return end

		timer.Simple(0.3, function()
			if not IsValid(self) then return end
			self:Push(trace)
		end)
		self:GetOwner():TakeStamina(9)
		self:SetNextSecondaryFire(CurTime() + 2.2)
		DarkRP.ForceAnimation(self:GetOwner(), "", 1.6)
		DarkRP.UIEffect(nil, "anim_keys", {type = "shove", ply = self:GetOwner():UserID()})
	end

	if self:InvCheck(trace) and trace:GetPos():DistToSqr(self:GetOwner():GetPos()) < 4500 then
		self.InProgress = true
		self.Entity = trace

		time = tonumber(trace.weight or 1)
		-- local time = 5
		if McINV.picktime[trace:GetClass()] then
			time = time + McINV.picktime[trace:GetClass()]
		end

		local classtimer = (McINV.picktime_class[trace:GetClass()] or (trace:GetClass() == "spawned_weapon" and McINV.picktime_class[trace:Geteclass()]))
		if classtimer and not trace.att_precache then
			time = time + classtimer
		end

		if MCR.HasTatoo(self:GetOwner(), "a3") and time > 0.1 then
			time = math.max(time * 0.6, 0.1)
		end

		if MCR.HasTatoo(self:GetOwner(), "b6") then
			time = time * 2
		end

		if time > 0.6 then
			self:GetOwner():EmitSound("locker-equip-001.wav")
		end

		if time > 2 then
			self:GetOwner():EmitSound("ambient/animal/horse_eat_1.wav")
		end

		self.EndCheck = CurTime() + (time or 1)

		net.Start("DrawProgressBar", self:GetOwner())
			net.WriteFloat(time)
		net.Send(self:GetOwner())
		return
	end

	if not IsValid(trace) or self:GetOwner():EyePos():DistToSqr(trace:NearestPoint(self:GetOwner():EyePos())) > 2500 then return end

	--not trace:isKeysOwnable() or (trace:isDoor() and self:GetOwner():EyePos():DistToSqr(trace:GetPos()) > 8300) or (trace:IsVehicle() and  then return end

	if self:GetOwner():canKeysLock(trace) then

		if trace.IsSimfphyscar then
			local _, dist = trace:GetDriverSeatPos(self:GetOwner())
			if (not dist or dist > (trace.EnterDist or 4000)) then return end
		end

		self:GetOwner():EmitSound("gb_sfx/door3.wav", 70, math.random(90, 100))

		timer.Simple(0.9, function()
			if IsValid(self) and IsValid(self:GetOwner()) and IsValid(trace) then
				if trace.IsUnLocked then
					trace:keysLock()
					DarkRP.UIEffect(self:GetOwner(), "DoorLock", {"Закрыто"})
					if trace.IsSimfphyscar then return end
					self:GetOwner():EmitSound("gb_sfx/door2.wav", 70, math.random(90, 110))
				else
					trace:keysUnLock()
					DarkRP.UIEffect(self:GetOwner(), "DoorLock", {"Открыто"})
					if trace.IsSimfphyscar then return end
					self:GetOwner():EmitSound("gb_sfx/door1.wav", 70, math.random(90, 110))
				end
			end
		end)

		DarkRP.ForceAnimation(self:GetOwner(), nil, 1.5)
		DarkRP.UIEffect(nil, "anim_keys", {type = "usekeys", ply = self:GetOwner():UserID()})
		self:GetOwner():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)

		self:SetNextSecondaryFire(CurTime() + 1)
	else
		if (not trace:isKeysOwnable() and trace:GetClass() ~= "prop_physics") or trace.PermaProps then return end
		if not self:GetOwner():HasStamina(1) then return end
		self:GetOwner():EmitSound("knock.wav", 75, math.random(90, 110))
		DarkRP.UIEffect(nil, "anim_keys", {type = "knocking", ply = self:GetOwner():UserID()})
		self:GetOwner():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
		self:GetOwner():TakeStamina(1)
	end
end

function SWEP:ChangeState(state)
	local deploy = "fists_holster"
	self:SetState(state)

	if state == 2 then
		deploy = "fists_draw"
		self:SetHoldType("fist")
	else
		self:SetHoldType("normal")
	end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(deploy))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	self:UpdateNextIdle()

	self:SetNextReload(CurTime() + 0.3 + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:Reload()
	if IsValid(self.EntHolding) or CLIENT then return end

	if self:GetOwner():isArrested() then self:SetState(1) self:SetHoldType("normal") return end

	local CT = CurTime()
	if self:GetNextReload() > CT or self.Running then return end

	self:ChangeState(self:GetState() == 1 and 2 or 1)
end

function SWEP:DealDamage()
	if self:GetOwner():isArrested() then return end

	local anim = self:GetSequenceName(self:GetOwner():GetViewModel():GetSequence())
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
		self:EmitSound("nmrihimpact/blunt_light" .. math.random(1,7) .. ".wav")
	end

	if SERVER and tr.Hit and self:GetOwner():getDarkRPVar("fracturearm") then
		self:GetOwner():AddTempStat("shock", math.random(3))
	end

	local hit = false
	local scale = 0.2

	if (SERVER and IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer() or tr.Entity:Health() > 0)) then
		local dmginfo = DamageInfo()
		local attacker = self:GetOwner()

		if (not IsValid(attacker)) then
			attacker = self
		end

		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(1)

		if (anim == "fists_left") then
			dmginfo:SetDamageForce(self:GetOwner():GetRight() * 4912 * scale + self:GetOwner():GetForward() * 9998 * scale) -- Yes we need those specific numbers
		elseif (anim == "fists_right") then
			dmginfo:SetDamageForce(self:GetOwner():GetRight() * -4912 * scale + self:GetOwner():GetForward() * 9989 * scale)
		elseif (anim == "fists_uppercut") then
			dmginfo:SetDamageForce(self:GetOwner():GetUp() * 5158 * scale + self:GetOwner():GetForward() * 10012 * scale)
			dmginfo:SetDamage(math.random(3))
		end

		if math.random(2) == 2 then
			SuppressHostEvents(NULL)
			tr.Entity:TakeDamageInfo(dmginfo)
			SuppressHostEvents(self:GetOwner())

			tr.Entity:EmitSound("weapons/melee/fists/fist_hit" .. math.random(1,3) .. ".wav")
			if tr.Entity:IsPlayer() and tr.Entity:Health() > 0 and tr.Entity:Health() < 40 then
				tr.Entity:Ragdollize(45 - tr.Entity:Health(), true)
				sAdmin.Grab(attacker, tr.Entity, true)
			end
		else
			if tr.Entity:IsPlayer() then
				tr.Entity:AddTempStat("shock", 5)
			end
		end

		hit = true
	end

	if (IsValid(tr.Entity)) and SERVER then
		local phys = tr.Entity:GetPhysicsObject()

		if (IsValid(phys)) then
			phys:ApplyForceOffset(self:GetOwner():GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos)
		end
	end

	if SERVER and tr.Hit and (not IsValid(tr.Entity) or not tr.Entity:IsPlayer()) and (self:GetOwner():Health() <= 22 or math.random(2) == 2) then
		if self:GetOwner():Health() > 22 then
			self:GetOwner():TakeDamage(math.Rand(0.1, 1.1), self:GetOwner(), self)
		end
		self:GetOwner():AddTempStat("shock", 0.1)
	end

	if SERVER then
		if (hit and anim ~= "fists_uppercut") and not self:GetOwner():getDarkRPVar("fracturearm") then
			self:SetCombo(self:GetCombo() + 1)
		else
			self:SetCombo(0)
		end
	end

	self:GetOwner():LagCompensation(false)
end

function SWEP:OnDrop()
	if CLIENT then return end
	self:Reset()
	self:Remove()
end

function SWEP:Deploy()
	--self:GetOwner():SetCanZoom(true)
	self:Reset()

	local deploy = "reference"
	if self:GetState() == 2 then
		deploy = "fists_draw"
	end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(deploy))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	self:UpdateNextIdle()
	self.Switch = 1
	if (SERVER) then
		self:SetCombo(0)
	end

	return true
end

function SWEP:Holster()
	self:Reset()
	self:SetNextMeleeAttack(0)
	if self.InProgress then net.SendSingleMessage("RemovePropgressBar", self:GetOwner()) end
	self.InProgress = false
	return true
end

function SWEP:FindStoreEnt(ent)
	for _,a in ipairs(ents.FindInSphere(ent:GetPos(), 30)) do
		if not a:IsPlayer() and McINV.CanLoot(self:GetOwner(), a) and a ~= ent and (a.GetSpace and a:GetSpace() > 0) then
			return a
		end
	end

	return nil
end

function SWEP:Succeed()
	self.InProgress = false
	net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
	local class = self.Entity:GetClass()

	if self.Entity.Draged then
		DarkRP.notify(self:GetOwner(), 1, 4, "Объект окупирован")
		return
	end

	if self.Entity:IsOnFire() then
		DarkRP.notify(self:GetOwner(), 1, 4, "Предмет горит")
		return
	end

	if self.Entity.NonPickeble then
		DarkRP.notify(self:GetOwner(), 1, 4, "Предмет поврежден")
		return
	end
	local type = INV_ENTITY
	if McINV.pickups[class] then
		type = McINV.pickups[class]
		class = self.Entity:Geteclass()
	end

	DarkRP.UIEffect(nil, "anim_keys", {type = "knocking", ply = self:GetOwner():UserID()})

	if self:GetOwner():KeyDown(IN_SPEED) and self:FindStoreEnt(self.Entity) then
		local target = self:FindStoreEnt(self.Entity)
		McINV.PutInEntity(self:GetOwner(), target, self.Entity, type, class)
	else
		self:GetOwner():Pickup(self.Entity, type, class)
	end
end

function SWEP:Fail()
	self.InProgress = false
	net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
	self:GetOwner():StopSound("ambient/animal/horse_eat_1.wav")
end

SWEP.Running = false

local function SetSubPhysMotionEnabled(ent, enable)
	if not IsValid(ent) then return end

	for i = 0, ent:GetPhysicsObjectCount() - 1 do
		local subphys = ent:GetPhysicsObjectNum(i)

		if IsValid(subphys) then
			subphys:EnableMotion(enable)

			if enable then
				subphys:Wake()
			end
		end
	end
end

local function KillVelocity(ent)
	ent:SetVelocity(vector_origin)
	SetSubPhysMotionEnabled(ent, false)

	timer.Simple(0, function()
		SetSubPhysMotionEnabled(ent, true)
	end)
end

function SWEP:Reset(keep_velocity)
	if IsValid(self.CarryHack) then
		self.CarryHack:Remove()
	end

	if IsValid(self.Constr) then
		self.Constr:Remove()
	end

	if IsValid(self.EntHolding) then
		if not self.EntHolding:IsWeapon() then
			if not IsValid(self.PrevOwner) then
				self.EntHolding:SetOwner(nil)
			else
				self.EntHolding:SetOwner(self.PrevOwner)
			end
		end

		local phys = self.EntHolding:GetPhysicsObject()
		self.EntHolding.Draged = nil

		if self.EntHolding.oldcollision then
			self.EntHolding:SetCollisionGroup(self.EntHolding.oldcollision)
			self.EntHolding.oldcollision = nil
		end

		if IsValid(phys) then
			phys:ClearGameFlag(FVPHYSICS_PLAYER_HELD)
			phys:AddGameFlag(FVPHYSICS_WAS_THROWN)
			phys:EnableCollisions(true)
			phys:EnableGravity(true)
			phys:EnableDrag(true)
			phys:EnableMotion(true)
		end

		if self.EntHolding:GetClass() == "prop_ragdoll" then
			KillVelocity(self.EntHolding)
		end
	end

	self.dt.carried_rag = nil
	self.EntHolding = nil
	self.CarryHack = nil
	self.Constr = nil
	self:SetPickState(0)
	self:SetHoldType("normal")
	if IsValid(self:GetOwner()) and SERVER then
		self:GetOwner():SetSelfDarkRPVar("dragging", nil)
		self:GetOwner():SetSelfDarkRPVar("dragFixed", nil)
	end
end

function SWEP:CheckValidity()
	if (not IsValid(self.EntHolding)) or (not IsValid(self.CarryHack)) or (not IsValid(self.Constr)) then
		if (self.EntHolding or self.CarryHack or self.Constr) then
			self:Reset()
		end

		return false
	else
		return true
	end
end

function SWEP:GetRange(target)
	return 75
end

function SWEP:AllowPickup(target)
	local phys = target:GetPhysicsObject()
	local ply = self:GetOwner()

	return IsValid(phys) and IsValid(ply) and not blockent[target:GetClass()] and not target:IsOnFire() and not IsValid(target:GetParent()) and phys:IsMoveable() and (not phys:HasGameFlag(FVPHYSICS_NO_PLAYER_PICKUP)) and phys:GetMass() < 61 and (target.CanPickup ~= false) and target:GetPos().z > ply:GetPos().z
end

function SWEP:DoPick(pickup)
	self:SetNextPrimaryFire(CurTime() + 0.1)
	self:SetNextSecondaryFire(CurTime() + 0.1)

	if IsValid(self.EntHolding) then
		if (not pickup) and self.EntHolding:GetClass() == "prop_ragdoll" then
			self:Drop()
		else
			self:Drop()
		end

		self:SetNextSecondaryFire(CurTime() + 0.3)

		return
	end

	local ply = self:GetOwner()
	local trace = ply:GetEyeTrace(MASK_SHOT)

	if IsValid(trace.Entity) then
		local ent = trace.Entity
		local phys = trace.Entity:GetPhysicsObject()
		if not IsValid(phys) or not phys:IsMoveable() or phys:HasGameFlag(FVPHYSICS_PLAYER_HELD) then return end
		if CLIENT then return end

		if (ply:EyePos() - trace.HitPos):Length() < self:GetRange(ent) and self:AllowPickup(ent) then
			self:Pickup()
			self:SendWeaponAnim(ACT_VM_HITCENTER)
			local delay = (ent:GetClass() == "prop_ragdoll") and 0.8 or 0.5
			self:SetNextSecondaryFire(CurTime() + delay)
		end
	end
end

function SWEP:OnRemove()
	self:Reset()
end

function SWEP:Pickup()
	if CLIENT or IsValid(self.EntHolding) then return end
	local ply = self:GetOwner()
	local trace = ply:GetEyeTrace(MASK_SHOT)
	local ent = trace.Entity
	self.EntHolding = ent
	local entphys = ent:GetPhysicsObject()

	if IsValid(ent) and IsValid(entphys) then
		self:GetOwner():ConCommand( "gm_keys_y 0" )
		self:GetOwner():ConCommand( "gm_keys_x 0" )
		self.HoldSelect = 1
		self:SetHoldType(self.HoldTables[self.HoldSelect])
		self.CarryHack = ents.Create("prop_physics")
		self.MassCarry = entphys:GetMass()
		if IsValid(self.CarryHack) then
			self.CarryHack:SetPos(self.EntHolding:GetPos())
			self.CarryHack:SetPos(trace.HitPos)
			self.CarryHack:SetModel("models/weapons/w_bugbait.mdl")
			self.CarryHack:SetNoDraw(true)
			self.CarryHack:DrawShadow(false)
			self.CarryHack:SetOwner(ply)
			self.CarryHack:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
			self.CarryHack:SetSolid(SOLID_NONE)
			self.CarryHack.dragFixed = self.EntHolding.dragFixed
			self.CarryHack:SetAngles(self:GetOwner():GetAngles())
			self.CarryHack:Spawn()
			self:SetPickState(self.EntHolding:EntIndex())

			if not self.EntHolding:IsWeapon() then
				self.PrevOwner = self.EntHolding:GetOwner()
				self.EntHolding:SetOwner(ply)
			end

			local phys = self.CarryHack:GetPhysicsObject()

			if IsValid(phys) then
				phys:SetMass(200)
				phys:SetDamping(0, 1000)
				phys:EnableGravity(false)
				phys:EnableCollisions(false)
				phys:EnableMotion(false)
				phys:AddGameFlag(FVPHYSICS_PLAYER_HELD)
			end
			self.EntHolding.Draged = self
			self.EntHolding.oldcollision = ent:GetCollisionGroup()
			self.EntHolding:SetCollisionGroup(COLLISION_GROUP_PASSABLE_DOOR)
			entphys:AddGameFlag(FVPHYSICS_PLAYER_HELD)
			local bone = math.Clamp(trace.PhysicsBone, 0, 1)
			local max_force = self.EntHolding.dragMaxForce or 10000
			local drag_pen = math.Clamp(ent.weight and ent.weight - 8 or self.MassCarry, 1, 12)
			drag_pen = math.Clamp(7 - math.Round((drag_pen / 12) * 7), 1, 7)
			if ent:GetClass() == "prop_ragdoll" then
				self.dt.carried_rag = ent
				bone = trace.PhysicsBone
				drag_pen = 1
				self:SetHoldType("physgun")
				self:GetOwner():SetSelfDarkRPVar("dragFixed", true)
			else
				self.dt.carried_rag = nil
			end

			self.Constr = constraint.Weld(self.CarryHack, self.EntHolding, 0, bone, max_force, true)

			if not ent.nodragpen then
				self:GetOwner():SetSelfDarkRPVar("dragging", ent.drag_pen or drag_pen)
				if ent.dragFixed then
					self:GetOwner():SetSelfDarkRPVar("dragFixed", true)
					self:SetHoldType("duel")
				end
			end
		end
	end
end

local down = Vector(0, 0, -1)

function SWEP:AllowEntityDrop()
	local ply = self:GetOwner()
	local ent = self.CarryHack
	if (not IsValid(ply)) or (not IsValid(ent)) then return false end
	local ground = ply:GetGroundEntity()
	if ground and (ground:IsWorld() or IsValid(ground)) then return true end
	local diff = (ent:GetPos() - ply:GetShootPos()):GetNormalized()

	return down:Dot(diff) <= 0.75
end

function SWEP:Drop()
	if not self:CheckValidity() then return end
	if not self:AllowEntityDrop() then return end

	if SERVER then
		self.Constr:Remove()
		self.CarryHack:Remove()
		local ent = self.EntHolding
		local phys = ent:GetPhysicsObject()

		if ent.oldcollision then
			ent:SetCollisionGroup(ent.oldcollision)
			ent.oldcollision = nil
		end

		if IsValid(phys) then
			phys:EnableCollisions(true)
			phys:EnableGravity(true)
			phys:EnableDrag(true)
			phys:EnableMotion(true)
			phys:Wake()
			phys:ApplyForceCenter(self:GetOwner():GetAimVector() * 500)
			phys:ClearGameFlag(FVPHYSICS_PLAYER_HELD)
			phys:AddGameFlag(FVPHYSICS_WAS_THROWN)
		end

		if ent:GetClass() == "prop_ragdoll" then
			KillVelocity(ent)
		end

		ent:SetPhysicsAttacker(self:GetOwner())
	end

	self:Reset()

	self:GetOwner():ConCommand( "gm_keys_y 0" )
	self:GetOwner():ConCommand( "gm_keys_x 0" )
	self:SetNextReload(CurTime() + 1)
end

CreateClientConVar("gm_keys_x", "0", false, true)
CreateClientConVar("gm_keys_y", "0", false, true)

local function MouseControl(cmd)
	local X = -cmd:GetMouseX() / -20
	local Y = cmd:GetMouseY() / -20
	local X2 = 0
	local Y2 = 0

	if (X ~= 0) then
		X2 = tonumber(LocalPlayer():GetInfo("gm_keys_x"))

		X2 = X2 + X

		if (X2 < -180) then
			X2 = X2 + 360
		elseif (X2 > 180) then
			X2 = X2 - 360
		end

		RunConsoleCommand("gm_keys_x", X2)
	end

	if (Y ~= 0) then
		Y2 = tonumber(LocalPlayer():GetInfo("gm_keys_y"))

		Y2 = Y2 + Y

		if (Y2 < -180) then
			Y2 = Y2 + 360
		elseif (Y2 > 180) then
			Y2 = Y2 - 360
		end

		RunConsoleCommand("gm_keys_y", Y2)
	end
end

function SWEP:FreezeMovement()
	return self.Rotation
end

function SWEP:Think()
	local vm = self:GetOwner():GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	self.Running = self:GetOwner():KeyDown(IN_SPEED) and self:GetOwner():GetVelocity():Length2DSqr() > 20000

	if self.Running and not self.OldState or self.OldState ~= self.Running then
		self.OldState = self.Running
		if self:GetState() ~= 1 then
			self:ChangeState(1)
		end
	end

	if self:GetState() > 1 and (idletime > 0 and curtime > idletime) then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("fists_idle_0" .. math.random(1, 2)))
		self:UpdateNextIdle()
		self.Idled = nil
	end

	if self:GetState() == 1 and not self.Idled then
		self.Idled = true
		vm:SendViewModelMatchingSequence(vm:LookupSequence("reference"))
	end

	local meleetime = self:GetNextMeleeAttack()

	if (meleetime > 0 and curtime > meleetime) then
		self:DealDamage()
		self:SetNextMeleeAttack(0)
	end

	if CLIENT then
		if self:GetPickState() > 0 and IsValid(Entity(self:GetPickState())) and LocalPlayer():KeyDown(IN_RELOAD) then
			if (not self.Rotation) then
				hook.Add("CreateMove", "AdvDupe2_MouseControl", MouseControl)
				self.Rotation = true
			end
		else
			if (self.Rotation) then
				self.Rotation = false
				hook.Remove("CreateMove", "AdvDupe2_MouseControl")
			end
		end

		return
	end

	if self.InProgress then
		local trace = self:GetOwner():GetEyeTrace().Entity

		if self.Entity ~= trace then
			self:Fail()
		elseif self.EndCheck <= curtime then
			self:Succeed()
		end
	end

	if curtime > self:GetNextPrimaryFire() + 0.1 then
		self:SetCombo(0)
	end

	if not self:CheckValidity() then return end

	if not self.pcheck or self.pcheck < CurTime() then
		local Tr = util.TraceLine{start = self:GetOwner():GetShootPos(), endpos = self.CarryHack:GetPos(), filter = {self, self:GetOwner(), self.CarryHack, self.EntHolding}}
		if (Tr.Entity ~= self.EntHolding and Tr.Entity ~= self.CarryHack and Tr.Entity ~= NULL) or (self:GetOwner():GetShootPos():DistToSqr(self.EntHolding:GetPos()) > 10000) then
			self:Reset()
			return
		end
		self.pcheck = CurTime() + 1
	end

	local ea = self:GetOwner():GetAngles()
	if self.CarryHack.dragFixed then
		self.CarryHack:SetPos(LerpVector(1 - self.MassCarry / 65,  self.CarryHack:GetPos(), self:GetOwner():EyePos() + self:GetOwner():GetAimVector() * 50) )
		local ang = self.CarryHack:GetAngles()
		ang.y = ea.y
		self.CarryHack:SetAngles(ang)
	else
		self.CarryHack:SetPos(LerpVector(1 - self.MassCarry / 65,  self.CarryHack:GetPos(), self:GetOwner():GetBonePosition(self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand"))) )
		if not self.dt.carried_rag then
			self.CarryHack:SetAngles(ea + Angle(tonumber(self:GetOwner():GetInfo("gm_keys_y")) or 0, tonumber(self:GetOwner():GetInfo("gm_keys_x")) or 0, 0))
		end
	end

	self.EntHolding:PhysWake()
end

if CLIENT then

	SWEP.Time = 0
	SWEP.Switch = 1

	local ctp = 0
	local scale = ScrH() / 1080
	local lastIndex = 1
	local transitionAnimation = 1
	local stages = {
		[1] = "КЛЮЧИ",
		[2] = "КУЛАКИ",
	}
	local hint = 0

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

	local function CheckTracerMove(HitEnt)
		return HitEnt:GetMoveType() == MOVETYPE_VPHYSICS and not HitEnt:IsVehicle() and not blockent[HitEnt:GetClass()] and IsValid(HitEnt:GetParent())
	end

	local function CheckTracerDoor(HitEnt)
		return IsValid(HitEnt) and (HitEnt:getDoorData() and HitEnt:GetClass() ~= "func_movelinear" and (HitEnt:isDoor() or HitEnt:IsVehicle()) and not HitEnt:getKeysNonOwnable()) and HitEnt:GetClass() ~= "prop_dynamic"
	end

	local oldhint

	local function DoorHints(self, ent)
		local hints = {}
		local sicon

		if not IsValid(ent) then
			return oldhint, mats[5]
		end

		if self:GetOwner():IsAdmin() and ent:isKeysOwned() and GetConVar("FPP_PrivateSettings_HideOwner"):GetInt() == 0 then
			table.insert(hints, {ent:getDoorOwner():FullName(), "Владелец:"})
		end

		if self:GetOwner():canKeysLock(ent) then
			table.insert(hints, {"Чтобы открыть/закрыть", "ПКМ"})
			oldhint = hints
			return hints
		elseif not ent:IsVehicle() then
			table.insert(hints, {"Постучать", "ПКМ"})
			sicon = mats[5]
		end
		local dch = fn.Null(ent:getKeysDoorTeams() or {})

		if ent:getKeysDoorGroup() then
			table.insert(hints, {ent:getKeysDoorGroup(), ""})
		end

		if not dch then
			table.insert(hints, {"", "Разрешено:"})
			for k, v in pairs(ent:getKeysDoorTeams() or {}) do
				table.insert(hints, {DarkRP.Teams[k] and DarkRP.Teams[k].name or "", ""})
			end
		end

		oldhint = hints

		return hints, sicon
	end

	local scw, sch = ScrW(), ScrH()
	local x, y = scw / 2, sch / 2

	hook.Add( "OnScreenSizeChanged", "ChangeKeysStats", function( oldWidth, oldHeight )
		scw, sch = ScrW(), ScrH()
		scale = ScrH() / 1080
	end)

	local function getName(ent)
		local name = ent.PrintName
		if ent.GetStorageName then
			name = ent:GetStorageName()
		end

		if ent.VehicleName then
			name = ent.VehicleName
		end

		if not name then
			return "контейнер"
		end

		return name
	end

	function SWEP:DrawHUD()
		if self:GetOwner():InVehicle() or GetConVar("cl_drawhud"):GetInt() == 0 then return end
		local Pos = self:GetOwner():GetShootPos()
		local Aim = self:GetOwner():GetAimVector()
		local index = self:GetState()
		local p = LocalPlayer():GetEyeTrace().HitPos:ToScreen()

		local Tr = util.TraceLine({start = Pos, endpos = Pos + Aim * self.HitDistance, filter = LocalPlayer()})

		local HitEnt = Tr.Entity
		if (IsValid(HitEnt) and (HitEnt:IsPlayer() or CheckTracerMove(HitEnt) or CheckTracerDoor(HitEnt) or self:InvCheck(HitEnt) or HitEnt.ShowOnHud)) or index == 2 or self:GetPickState() > 0 then
			self.Time = math.min(1, self.Time + 2 * FrameTime())
		else
			self.Time = math.max(0, self.Time - 2 * FrameTime())
			x, y = p.x, p.y
			MSD.DrawTexturedRect(x - 10, y - 10, 24, 24, MSD:Icon("dot"), MSD.ColorAlpha(color_white, 60 - 60 * self.Time))
		end

		local icon = (self:GetPickState() < 1 and hint > 0 ) and mats[3] or mats[self:GetPickState() > 0 and 2 or 1]
		local piked = self:GetPickState() > 0 and IsValid(Entity(self:GetPickState()))

		if CheckTracerDoor(HitEnt) and index ~= 2 then
			hint = math.min(1, hint + 2 * FrameTime())
		else
			hint = math.max(0, hint - 2 * FrameTime())
		end

		if hint > 0 then
			x, y = scw * 0.52, sch * 0.5 - 8

			local hints, sicon = DoorHints(self, HitEnt)
			icon = sicon or icon
			for i,o in pairs(hints) do
				local sp = 0
				if o[2] ~= "" then sp = MSD.DrawKey(x, y - 3 + ((i - 1) * 30), o[2], hint * 150) end
				draw.SimpleTextOutlined(o[1], "MSDFont.20", x + sp + 10, y + ((i - 1) * 30), MSD.ColorAlpha(clrs.m, 220 * hint), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * hint))
			end
		end

		if self.Time > 0 then
			x, y = scw / 2, sch / 2
			MSD.DrawTexturedRect(x - 10, y - 10, 24, 24, index == 2 and mats[4] or icon, MSD.ColorAlpha(color_black, 200 * self.Time))
			MSD.DrawTexturedRect(x - 12, y - 12, 24, 24, index == 2 and mats[4] or icon, MSD.ColorAlpha((index == 2 and IsValid(HitEnt)) and clrs.r or color_white, 200 * self.Time))
			if HitEnt and self:InvCheck(HitEnt) and not CheckTracerDoor(HitEnt) and self:GetPickState() < 1 and not self:GetOwner():isArrested() then
				x, y = scw * 0.52, sch * 0.5 - 8
				local sp = MSD.DrawKey(x, y - 3, "ПКМ", self.Time * 150)
				draw.SimpleTextOutlined("Положить в инвентарь", "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))

				if ctp < CurTime() then
					self.puttarget = self:FindStoreEnt(HitEnt)
					ctp = CurTime() + 1
				end

				if IsValid(self.puttarget) then
					y = sch * 0.5 + 20
					sp = MSD.DrawKey(x, y - 3, input.LookupBinding("+speed") .. " ПКМ", self.Time * 150)
					draw.SimpleTextOutlined("Поместить в '" .. getName(self.puttarget) .. "'", "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))
				end
			end

			if IsValid(HitEnt) and HitEnt:IsPlayer() and LocalPlayer():Health() > 20 and not piked then
				x, y = scw * 0.52, sch * 0.5 - 8
				local sp = MSD.DrawKey(x, y - 3, "ПКМ", self.Time * 150)
				draw.SimpleTextOutlined("Толкнуть", "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))
			end
		end

		if IsValid(HitEnt) and HitEnt.ShowOnHud then
			x, y = scw * 0.52, sch * 0.5 - 8
			local sp = MSD.DrawKey(x, y - 3, "E", self.Time * 150)
			draw.SimpleTextOutlined(HitEnt.PrintName, "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))

			if HitEnt.GunTable and self:GetOwner():Team() == TEAM_GUN then
				draw.SimpleTextOutlined("Используйте с оружием в руках для его модифицикации", "MSDFont.16", x + sp + 10, y + 22, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))
			end

			return
		end

		if piked then
			local pos = Entity(self:GetPickState()):GetPos():ToScreen()
			surface.SetDrawColor(color_white)
			x, y = scw / 2, sch / 2
			surface.DrawLine( pos.x, pos.y, x, y )
			x, y = scw * 0.52, sch * 0.5 - 8
			local sp = MSD.DrawKey(x, y - 3, "ПКМ", self.Time * 150)
			draw.SimpleTextOutlined("Отдалить", "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))
			y = sch * 0.5 + 22
			sp = MSD.DrawKey(x, y - 3, "R", self.Time * 150)
			draw.SimpleTextOutlined("Вращать", "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))
		end

		if self:GetOwner():isArrested() then return end

		self.Switch = math.Clamp(self.Switch - 0.5 * FrameTime(), 0, 1)

		transitionAnimation = math.min(transitionAnimation + 10 * FrameTime(), 1)

		if (lastIndex ~= index) then
			transitionAnimation = 0
			lastIndex = index
			self.Switch = 1
			self.ShowHint = nil
		end

		if self.Switch > 0 then
			x, y = scw * 0.6, sch * 0.6

			draw.SimpleTextOutlined(stages[index], "MSDFont.28", x, y + (24 * (1 - transitionAnimation) * scale), MSD.ColorAlpha(clrs.m, 200 * self.Switch), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, MSD.ColorAlpha(clrs.d, 20 * self.Switch))

			if (stages[index + 1]) then
				index = index + 1
			else
				index = 1
			end

			draw.SimpleText(stages[index], "MSDFont.20", x, y + (24 * transitionAnimation * scale), MSD.ColorAlpha(clrs.s, 150 * self.Switch), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if GetConVar("noire_hints"):GetInt() > 0 and self.ShowHint and self.ShowHint < CurTime() then
			x, y = scw * 0.5, sch * 0.8
			local sp = draw.SimpleTextOutlined("Для переключения режимов нажмите", "MSDFont.20", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
			MSD.DrawKey(x + sp / 2 + 10, y - 3, input.LookupBinding("+reload"))
		end
	end
end