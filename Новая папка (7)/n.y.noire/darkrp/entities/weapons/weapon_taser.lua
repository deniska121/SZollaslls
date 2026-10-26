--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/weapon_taser.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.PrintName = "Тайзер"
SWEP.Author = "MacTavish"
SWEP.Purpose = "Да"
SWEP.Slot = 4
SWEP.SlotPos = 4
SWEP.Spawnable = true
SWEP.ViewModel = "models/realistic_police/taser/c_taser.mdl"
SWEP.WorldModel = "models/realistic_police/taser/w_taser.mdl"
SWEP.ViewModelFOV = 60
SWEP.UseHands = true
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.lastchek = 0
SWEP.TobleIron = false
SWEP.ChargeShoot = 10
SWEP.DrawCrosshair = false
SWEP.HitDistance = 100
SWEP.AimPos = Vector(-4.252, -0.784, 2.234)
SWEP.AimAng = Vector(-1.341, -4.08, 0)
SWEP.SprintPos = Vector(0.2, -7.967, -5.489)
SWEP.SprintAng = Vector(45.972, -3.537, -0)
SWEP.CrouchPos = Vector(-2.941, -1.583, 0.004)
SWEP.CrouchAng = Vector(-0.355, -3.554, 0)
SWEP.BlendPos = Vector(0, 0, 0)
SWEP.BlendAng = Vector(0, 0, 0)
SWEP.OldDelta = Angle(0, 0, 0)
SWEP.AngleDelta = Angle(0, 0, 0)

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "NextIdle")
	self:NetworkVar("Float", 2, "NextReload")
	self:NetworkVar("Int", 1, "Charge")
	self:NetworkVar("Int", 2, "State")
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:PrimaryAttack()
	if self:GetOwner():KeyDown(IN_SPEED) then return end
	if self:Clip1() < self.ChargeShoot then return end
	self:SetNextPrimaryFire(CurTime() + 1)
	if self:GetCharge() > 0 then return end
	self:SetCharge(1)
	self.lastchek = CurTime() + 2

	return
end

function SWEP:SecondaryAttack()
	--if SERVER then return end
	if not IsFirstTimePredicted() then return end
	if self:GetOwner():KeyDown(IN_SPEED) then return end
	self.TobleIron = not self.TobleIron
	self:SetNextSecondaryFire(CurTime() + 0.1)

	return
end

function SWEP:Reload()
	if self:GetNextReload() > CurTime() then return end
	if self:GetCharge() ~= 2 then return end
	if self:Clip1() < self.ChargeShoot then return end
	self:SetNextReload(CurTime() + 2)
	self:SetNextPrimaryFire(CurTime() + 2)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("reload"))
	vm:SetPlaybackRate(1)
	self:UpdateNextIdle()
	self:SetHoldType("pistol")

	timer.Simple(0.1, function()
		if not IsValid(self) then return end
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
		self:EmitSound("viper/weapons/mike4/wpfoly_mike4_reload_end_v2.ogg")
	end)

	timer.Simple(1.25, function()
		if not IsValid(self) then return end
		self:EmitSound("viper/weapons/mike4/wpfoly_mike4_reload_magin_v2_01.ogg")
		self:SetCharge(0)
		self:SetHoldType("revolver")
	end)
end

local armors = {
	[1] = {
		[2] = true,
		[3] = true
	},
	[2] = {
		[2] = true
	},
}

function SWEP:DealDamage()
	if self:Clip1() < self.ChargeShoot then return end
	self:TakePrimaryAmmo(self.ChargeShoot)
	self.lastchek = CurTime() + 2
	self:SetCharge(2)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)
	self:GetOwner():ViewPunch(Angle(math.random(3), math.random(-1, 1), math.random(-1, 1)))
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fire"))
	self:EmitSound("csgo/taser/taser_shoot.wav")
	self:UpdateNextIdle()
	self:SetNextPrimaryFire(CurTime() + 1)
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

	if CLIENT and (tr.Hit and not (game.SinglePlayer() and CLIENT) and tr.HitPos:DistToSqr(self:GetOwner():GetShootPos()) < self.HitDistance ^ 2) then
		local effect = EffectData()
		effect:SetOrigin(tr.HitPos)
		effect:SetStart(self:GetOwner():GetShootPos())
		effect:SetAttachment(1)
		effect:SetEntity(self)
		util.Effect("ToolTracer", effect)
	end

	if (SERVER and IsValid(tr.Entity) and (tr.Entity:IsPlayer() or tr.Entity:Health() > 0)) then
		if tr.Entity:IsPlayer() and tr.Entity:getDarkRPVar("armorVest") and tr.Entity:Armor() > 0 and armors[tr.Entity:getDarkRPVar("armorVest")] and armors[tr.Entity:getDarkRPVar("armorVest")][tr.HitGroup] then
			self:GetOwner():LagCompensation(false)

			return
		end

		local dmginfo = DamageInfo()
		local attacker = self:GetOwner()

		if (not IsValid(attacker)) then
			attacker = self
		end

		dmginfo:SetAttacker(attacker)
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(math.random(5))
		dmginfo:SetDamageType(DMG_SHOCK)
		SuppressHostEvents(NULL)
		tr.Entity:TakeDamageInfo(dmginfo)
		SuppressHostEvents(self:GetOwner())

		if tr.Entity:IsPlayer() and not tr.Entity:getDarkRPVar("heroin") and not tr.Entity:InVehicle() then
			local rtm = math.random(1, 9)
			if rtm > 4 then
				self.ragdoll = tr.Entity:Ragdollize(rtm, true, nil, nil, 10)
				self.ragtimer = CurTime() + rtm - 1
			end
			tr.Entity:AddTempStat("shock", math.random(17, 28))
		end
	end

	self:GetOwner():LagCompensation(false)
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("draw"))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	self:UpdateNextIdle()
	self:EmitSound("viper/weapons/mike4/wfoly_ar_mike4_inspect_01.ogg")

	return true
end

function SWEP:Think()
	local vm = self:GetOwner():GetViewModel()
	local CT = CurTime()
	local idletime = self:GetNextIdle()
	local meleetime = self:GetNextMeleeAttack()

	if self:GetCharge() == 1 and self:GetOwner():KeyDown(IN_ATTACK) and meleetime < CT then
		self:SetNextMeleeAttack(CT + 0.1)
	elseif self:GetCharge() == 1 and (not self:GetOwner():KeyDown(IN_ATTACK) or self:GetOwner():KeyDown(IN_SPEED)) then
		self:SetNextPrimaryFire(CT + 0.1)
		self:SetCharge(0)
		self:SetNextMeleeAttack(0)
	end

	if (idletime > 0 and CT > idletime) then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("idle"))
		self:UpdateNextIdle()
	end

	if (meleetime > 0 and CT > meleetime) then
		self:DealDamage()
		self:SetNextMeleeAttack(0)
		self:SetNextReload(CurTime() + 1)
	end

	if SERVER and self.ragtimer and self.ragtimer > CurTime() and IsValid(self.ragdoll) then
		local phys = self.ragdoll:GetPhysicsObjectNum(0)

		if phys:IsValid() then
			phys:AddAngleVelocity(Vector(math.sin(CurTime()) * 1250, math.sin(CurTime()) * 850, 0))
		end
	end

	if SERVER and self.lastchek + 2 < CT then
		self.lastchek = CT
		self:SetClip1(math.min(self:Clip1() + 1, 50))
	end
end

function SWEP:Initialize()
	self:SetHoldType("revolver")
	self:SetNextReload(0)
	self:SetCharge(0)

	if CLIENT then
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy(self.VElements)
		self.WElements = table.FullCopy(self.WElements)
		self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels

		-- init view model bone build function
		if IsValid(self:GetOwner()) then
			local vm = self:GetOwner():GetViewModel()

			if IsValid(vm) then
				self:ResetBonePositions(vm)

				-- Init viewmodel visibility
				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255, 255, 255, 255))
				else
					-- we set the alpha to 1 instead of 0 because else ViewModelDrawn stops being called
					vm:SetColor(Color(255, 255, 255, 1))
					-- ^ stopped working in GMod 13 because you have to do Entity:SetRenderMode(1) for translucency to kick in
					-- however for some reason the view model resets to render mode 0 every frame so we just apply a debug material to prevent it from drawing
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
	end
end

function SWEP:Holster()
	self:SetNextMeleeAttack(0)

	if CLIENT and IsValid(self:GetOwner()) then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end

SWEP.VElements = {
	-- ["display"] = {
	-- 	type = "Quad",
	-- 	bone = "t.base",
	-- 	rel = "",
	-- 	pos = Vector(3.282, 0.737, 0.412),
	-- 	angle = Angle(-90, -90, 0),
	-- 	size = 0.02,
	-- 	draw_func = function(self)
	-- 		self:Display()
	-- 	end
	-- }
}

if SERVER then return end
SWEP.ApproachSpeed = 10
SWEP.FireMove = 0
SWEP.ViewModelMovementScale = 1
SWEP.Sequence = ""
SWEP.Cycle = 0
local Vec0 = Vector(0, 0, 0)
local TargetPos, TargetAng, cos1, sin1, tan, ws, rs, mod, EA, delta, mul, tr, FT
local td = {}
local PosMod, AngMod = Vector(0, 0, 0), Vector(0, 0, 0)
local CurPosMod, CurAngMod = Vector(0, 0, 0), Vector(0, 0, 0)

local veldepend = {
	pitch = 0,
	yaw = 0,
	roll = 0
}

local mod2 = 0

function SWEP:PreDrawViewModel()
	CT = UnPredictedCurTime()
	local vm = self:GetOwner():GetViewModel()
	self.Sequence = vm:GetSequenceName(vm:GetSequence())
	self.IsReloading = self.Sequence:find("reload")

	if not self.IsReloading then
		self.IsReloading = self.Sequence:find("insert")
	end

	self.Cycle = vm:GetCycle()
	EA = EyeAngles()
	FT = FrameTime()
	delta = Angle(EA.p, EA.y, 0) - self.OldDelta
	delta.p = math.Clamp(delta.p, -10, 10)
	self.OldDelta = Angle(EA.p, EA.y, 0)
	self.AngleDelta = LerpAngle(math.Clamp(FT * 10, 0, 1), self.AngleDelta, delta)
	self.AngleDelta.y = math.Clamp(self.AngleDelta.y, -10, 10)
	vel = self:GetOwner():GetVelocity()
	len = vel:Length()
	ws = self:GetOwner():GetWalkSpeed()
	PosMod, AngMod = Vec0 * 1, Vec0 * 1
	mod2 = 1
	veldepend.roll = math.Clamp((vel:Dot(EA:Right()) * 0.04) * len / ws, -5, 5)

	if (((len > ws * 1.2 and self:GetOwner():KeyDown(IN_SPEED)) or len > ws * 3 or (self.ForceRunStateVelocity and len > self.ForceRunStateVelocity)) and self:GetOwner():OnGround()) then
		if self.IsReloading and self.Cycle < 0.9 then
			TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
		else
			TargetPos, TargetAng = self.SprintPos * 1, self.SprintAng * 1
		end

		rs = self:GetOwner():GetRunSpeed()
		mod = 7 + math.Clamp(rs / 100, 0, 6)
		mul = math.Clamp(len / rs, 0, 1)
		sin1 = math.sin(CT * mod) * mul
		cos1 = math.cos(CT * mod) * mul
		tan1 = math.tan(sin1 * cos1) * mul

		if self.IsReloading and self.Cycle <= 0.9 then
			AngMod.x = AngMod.x + tan1 * 0.2 * self.ViewModelMovementScale * mul
			AngMod.y = AngMod.y - cos1 * 1.5 * self.ViewModelMovementScale * mul
			AngMod.z = AngMod.z + cos1 * 3 * self.ViewModelMovementScale * mul
			PosMod.x = PosMod.x - sin1 * 1.2 * self.ViewModelMovementScale * mul
			PosMod.y = PosMod.y + tan1 * 3 * self.ViewModelMovementScale * mul
			PosMod.z = PosMod.z + tan1 * 1.5 * self.ViewModelMovementScale * mul
			self.ApproachSpeed = math.Approach(self.ApproachSpeed, 4, FT * 100)
		else
			AngMod.x = AngMod.x + tan1 * 0.2 * self.ViewModelMovementScale * mul
			AngMod.y = AngMod.y - cos1 * 1.5 * self.ViewModelMovementScale * mul
			AngMod.z = AngMod.z + cos1 * 3 * self.ViewModelMovementScale * mul
			PosMod.x = PosMod.x - sin1 * 1.2 * self.ViewModelMovementScale * mul
			PosMod.y = PosMod.y + tan1 * 3 * self.ViewModelMovementScale * mul
			PosMod.z = PosMod.z + tan1 * 1.5 * self.ViewModelMovementScale * mul
			self.ApproachSpeed = math.Approach(self.ApproachSpeed, 6, FT * 100)
		end
	elseif self.TobleIron and not self.IsReloading then
		mod2 = 0.2
		TargetPos, TargetAng = self.AimPos * 1, self.AimAng * 1
		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 8, FT * 30)
	else
		if self.dt.Safe then
			TargetPos, TargetAng = self.SprintPos * 1, self.SprintAng * 1
		else
			TargetPos, TargetAng = Vec0 * 1, Vec0 * 1
		end

		self.ApproachSpeed = math.Approach(self.ApproachSpeed, 10, FT * 100)
		td.start = self:GetOwner():GetShootPos()
		td.endpos = td.start + self:GetOwner():EyeAngles():Forward() * 30
		td.filter = self:GetOwner()
		tr = util.TraceLine(td)

		if self:GetOwner():Crouching() and self.FireMode ~= "safe" then
			TargetPos, TargetAng = self.CrouchPos * 1, self.CrouchAng * 1
			self.ApproachSpeed = math.Approach(self.ApproachSpeed, 5, FT * 30)
		end

		if tr.Hit then
			self.NearWall = true
			TargetPos.y = TargetPos.y - math.Clamp(30 * (1 - tr.Fraction), 0, 30)
		end
	end

	if self:GetOwner().Supression == nil then
		self:GetOwner().Supression = 0
	end

	if (len < 10 or not self:GetOwner():OnGround()) or self:GetOwner().Supression > 1 then
		if self.HolingBr == false or self:GetOwner().Supression > 1 then
			cos1, sin1 = math.cos(CT), math.sin(CT)
			tan = math.atan(cos1 * sin1, cos1 * sin1)
			AngMod.x = AngMod.x + tan * (1.15 + math.Clamp(self:GetOwner().Supression * 2, 0, 10))
			AngMod.y = AngMod.y + cos1 * (0.4 + math.Clamp(self:GetOwner().Supression * 1.5, 0, 7))
			AngMod.z = AngMod.z + tan
			PosMod.y = PosMod.y + tan * 0.2 * mod2
		end
	elseif len > 10 and len < ws * 1.2 and self:GetOwner().Supression <= 1 then
		mod = 6 + ws / 130
		mul = math.Clamp(len / ws, 0, 1)
		sin1 = math.sin(CT * mod) * mul
		cos1 = math.cos(CT * mod) * mul
		tan1 = math.tan(sin1 * cos1) * mul
		AngMod.x = AngMod.x + tan1 * self.ViewModelMovementScale * mod2
		AngMod.y = AngMod.y - cos1 * self.ViewModelMovementScale * mod2
		AngMod.z = AngMod.z + cos1 * self.ViewModelMovementScale * mod2
		PosMod.x = PosMod.x - sin1 * 0.4 * self.ViewModelMovementScale * mod2
		PosMod.y = PosMod.y + tan1 * 1 * self.ViewModelMovementScale * mod2
		PosMod.z = PosMod.z + tan1 * 0.5 * self.ViewModelMovementScale * mod2
	end

	FT = FrameTime()
	TargetAng.z = TargetAng.z + veldepend.roll
	self.BlendPos = LerpVector(FT * self.ApproachSpeed, self.BlendPos, TargetPos)
	self.BlendAng = LerpVector(FT * self.ApproachSpeed, self.BlendAng, TargetAng)
	CurPosMod = LerpVector(FT * 10, CurPosMod, PosMod)
	CurAngMod = LerpVector(FT * 10, CurAngMod, AngMod)
end

function SWEP:GetViewModelPosition(pos, ang)
	CT = UnPredictedCurTime()
	ang:RotateAroundAxis(ang:Right(), CurAngMod.x + self.BlendAng.x + self.AngleDelta.p * mod2)

	if not self.ViewModelFlip then
		ang:RotateAroundAxis(ang:Up(), CurAngMod.y + self.BlendAng.y + self.AngleDelta.y * 0.3 * mod2)
		ang:RotateAroundAxis(ang:Forward(), CurAngMod.z + self.BlendAng.z + self.AngleDelta.y * 0.3 * mod2)
	else
		ang:RotateAroundAxis(ang:Up(), CurAngMod.y + self.BlendAng.y - self.AngleDelta.y * 0.3 * mod2)
		ang:RotateAroundAxis(ang:Forward(), CurAngMod.z - self.BlendAng.z - self.AngleDelta.y * 0.3 * mod2)
	end

	if not self.ViewModelFlip then
		pos = pos + (CurPosMod.x + self.BlendPos.x + self.AngleDelta.y * 0.1 * mod2) * ang:Right()
	else
		pos = pos + (CurPosMod.x + self.BlendPos.x - self.AngleDelta.y * 0.1 * mod2) * ang:Right()
	end

	pos = pos + (CurPosMod.y + self.BlendPos.y) * ang:Forward()
	pos = pos + (CurPosMod.z + self.BlendPos.z - self.AngleDelta.p * 0.1) * ang:Up()
	--pos, ang = self:Sway(pos, ang, true)

	return pos, ang
end

function SWEP:Display()
	draw.RoundedBox(0, 0, 0, 45, 20, color_black)

	if self:GetCharge() ~= 2 and not self:GetOwner():KeyDown(IN_SPEED) and self:Clip1() >= self.ChargeShoot then
		MSD.DrawTexturedRect(15, 0, 15, 15, MSD:Icon("lightning"), MSD.Config.MainColor.p)
	else
		MSD.DrawTexturedRect(15, 0, 15, 15, MSD:Icon("cancel"), MSD.Config.MainColor.r)
	end

	if self:GetCharge() == 1 then
		local pg = self:GetNextMeleeAttack() - CurTime() / 1

		if pg < 0 or pg >= 1 then
			pg = 1
		end

		draw.RoundedBox(0, 0, 0, 45 - math.Clamp(45 * pg, 0, 45), 20, MSD.Config.MainColor.p)
	end
end

SWEP.vRenderOrder = nil

function SWEP:SafeLerp(rate, current, target)
	if (math.abs(current - target) < 0.001) then return target end

	return Lerp(rate, current, target)
end

function SWEP:SafeLerpVector(rate, current, target)
	current.x = self:SafeLerp(rate, current.x, target.x)
	current.y = self:SafeLerp(rate, current.y, target.y)
	current.z = self:SafeLerp(rate, current.z, target.z)
end

function SWEP:SafeLerpAngle(rate, current, target)
	current.p = self:SafeLerp(rate, current.p, target.p)
	current.y = self:SafeLerp(rate, current.y, target.y)
	current.r = self:SafeLerp(rate, current.r, target.r)
end

function SWEP:ViewModelDrawn()
	local vm = self:GetOwner():GetViewModel()
	if not IsValid(vm) then return end
	if (not self.VElements) then return end
	self:UpdateBonePositions(vm)

	if (not self.vRenderOrder) then
		-- we build a render order because sprites need to be drawn after models
		self.vRenderOrder = {}

		for k, v in pairs(self.VElements) do
			if (v.type == "Model") then
				table.insert(self.vRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.vRenderOrder, k)
			end
		end
	end

	for k, name in ipairs(self.vRenderOrder) do
		local v = self.VElements[name]

		if (not v) then
			self.vRenderOrder = nil
			break
		end

		if (v.hide) then continue end
		local model = v.modelEnt
		local sprite = v.spriteMaterial
		if (not v.bone) then continue end
		local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
		if (not pos) then continue end

		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			--model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix("RenderMultiply", matrix)

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial(v.material)
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for i, o in pairs(v.bodygroup) do
					if (model:GetBodygroup(i) ~= o) then
						model:SetBodygroup(i, o)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
			render.SetBlend(v.color.a / 255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		elseif (v.type == "Sprite" and sprite) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
		elseif (v.type == "Quad" and v.draw_func) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			cam.Start3D2D(drawpos, ang, v.size)
			v.draw_func(self)
			cam.End3D2D()
		end
	end
end

SWEP.wRenderOrder = nil

function SWEP:DrawWorldModel()
	if (self.ShowWorldModel == nil or self.ShowWorldModel) then
		self:DrawModel()
	end

	if (not self.WElements) then return end

	if (not self.wRenderOrder) then
		self.wRenderOrder = {}

		for k, v in pairs(self.WElements) do
			if (v.type == "Model") then
				table.insert(self.wRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.wRenderOrder, k)
			end
		end
	end

	if (IsValid(self:GetOwner())) then
		bone_ent = self:GetOwner()
	else
		-- when the weapon is dropped
		bone_ent = self
	end

	for k, name in pairs(self.wRenderOrder) do
		local v = self.WElements[name]

		if (not v) then
			self.wRenderOrder = nil
			break
		end

		if (v.hide) then continue end
		local pos, ang

		if (v.bone) then
			pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent)
		else
			pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand")
		end

		if (not pos) then continue end
		local model = v.modelEnt
		local sprite = v.spriteMaterial

		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			--model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix("RenderMultiply", matrix)

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial(v.material)
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for i, o in pairs(v.bodygroup) do
					if (model:GetBodygroup(i) ~= o) then
						model:SetBodygroup(i, o)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
			render.SetBlend(v.color.a / 255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		elseif (v.type == "Sprite" and sprite) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
		elseif (v.type == "Quad" and v.draw_func) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			cam.Start3D2D(drawpos, ang, v.size)
			v.draw_func(self)
			cam.End3D2D()
		end
	end
end

function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
	local bone, pos, ang

	if (tab.rel and tab.rel ~= "") then
		local v = basetab[tab.rel]
		if (not v) then return end
		-- Technically, if there exists an element with the same name as a bone
		-- you can get in an infinite loop. Let's just hope nobody's that stupid.
		pos, ang = self:GetBoneOrientation(basetab, v, ent)
		if (not pos) then return end
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
	else
		bone = ent:LookupBone(bone_override or tab.bone)
		if (not bone) then return end
		pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
		local m = ent:GetBoneMatrix(bone)

		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		if (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and ent == self:GetOwner():GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r -- Fixes mirrored models
		end
	end

	return pos, ang
end

function SWEP:CreateModels(tab)
	if (not tab) then return end

	-- Create the clientside models here because Garry says we can't do it in the render hook
	for k, v in pairs(tab) do
		if (v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME")) then
			v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)

			if (IsValid(v.modelEnt)) then
				v.modelEnt:SetPos(self:GetPos())
				v.modelEnt:SetAngles(self:GetAngles())
				v.modelEnt:SetParent(self)
				v.modelEnt:SetNoDraw(true)
				v.createdModel = v.model
			else
				v.modelEnt = nil
			end
		elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME")) then
			local name = v.sprite .. "-"

			local params = {
				["$basetexture"] = v.sprite
			}

			-- make sure we create a unique name based on the selected options
			local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

			for i, j in pairs(tocheck) do
				if (v[j]) then
					params["$" .. j] = 1
					name = name .. "1"
				else
					name = name .. "0"
				end
			end

			v.createdSprite = v.sprite
			v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
		end
	end
end

local allbones
local hasGarryFixedBoneScalingYet = false

function SWEP:UpdateBonePositions(vm)
	if self.ViewModelBoneMods then
		if (not vm:GetBoneCount()) then return end
		local loopthrough = self.ViewModelBoneMods

		if (not hasGarryFixedBoneScalingYet) then
			allbones = {}

			for i = 0, vm:GetBoneCount() do
				local bonename = vm:GetBoneName(i)

				if (self.ViewModelBoneMods[bonename]) then
					allbones[bonename] = self.ViewModelBoneMods[bonename]
				else
					allbones[bonename] = {
						scale = Vector(1, 1, 1),
						pos = Vector(0, 0, 0),
						angle = Angle(0, 0, 0)
					}
				end
			end

			loopthrough = allbones
		end

		-- !! ----------- !! //
		for k, v in pairs(loopthrough) do
			local bone = vm:LookupBone(k)
			if (not bone) then continue end
			-- !! WORKAROUND !! //
			local s = Vector(v.scale.x, v.scale.y, v.scale.z)
			local p = Vector(v.pos.x, v.pos.y, v.pos.z)
			local ms = Vector(1, 1, 1)

			if (not hasGarryFixedBoneScalingYet) then
				local cur = vm:GetBoneParent(bone)

				while (cur >= 0) do
					local pscale = loopthrough[vm:GetBoneName(cur)].scale
					ms = ms * pscale
					cur = vm:GetBoneParent(cur)
				end
			end

			s = s * ms

			-- !! ----------- !! //
			if vm:GetManipulateBoneScale(bone) ~= s then
				vm:ManipulateBoneScale(bone, s)
			end

			if vm:GetManipulateBoneAngles(bone) ~= v.angle then
				vm:ManipulateBoneAngles(bone, v.angle)
			end

			if vm:GetManipulateBonePosition(bone) ~= p then
				vm:ManipulateBonePosition(bone, p)
			end
		end
	else
		self:ResetBonePositions(vm)
	end
end

function SWEP:ResetBonePositions(vm)
	if (not vm:GetBoneCount()) then return end

	for i = 0, vm:GetBoneCount() do
		vm:ManipulateBoneScale(i, Vector(1, 1, 1))
		vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
		vm:ManipulateBonePosition(i, Vector(0, 0, 0))
	end
end