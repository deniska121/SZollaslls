--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/client/cl_calcviewmodelview.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
local CalcVMViewHookBypass = false

function SWEP:GetViewModelPosition(pos, ang)
	if (CalcVMViewHookBypass == true) then return pos, ang end
	if (self:GetOwner() == NULL) then return pos, ang end

	if (self:GetOwner():InVehicle()) then
		self.m_ViewModel:SetPos(pos)
		self.m_ViewModel:SetAngles(ang)
	end

	if (IsValid(self.m_ViewModel)) then return self.m_ViewModel:GetPos(), self.m_ViewModel:GetAngles() end

	return pos, ang
end

SWEP.CrouchVector = Vector(-1, -1, -1)
SWEP.interAD = 0

function SWEP:GetAD()
	--self.interAD = math.Round(self:SafeLerp(FrameTime() * 2, self.interAD, self:GetAimDelta()), 5)
	return self.interAD
end

local function SafeLerpOther(rate, current, target)
	if (math.abs(current - target) < 0.001) then return target end
	if (current > 1) then return target end

	return Lerp(rate, current, target)
end

function SWEP:CalcViewModel(ViewModel, EyePos, EyeAng)
	if (not IsValid(self:GetOwner())) then return end
	self.interAD = math.Round(SafeLerpOther(FrameTime() * 10, self.interAD, self:GetAimDelta()), 5)
	--anims
	self:AnimThinkModule()
	--if (GetConVar("mgbase_debug_freeview"):GetInt() > 0) then return end
	local vars = self.ViewModelVars
	vars.LerpAimDelta = self:SafeLerp(10 * FrameTime(), vars.LerpAimDelta, self:GetAD())

	--jump
	self:CalcViewModelJump()
	--movement sway
	self:CalcMovementSway()
	--fake recoil
	self:CalcRecoil()
	local recoilPos, recoilAng = vars.Recoil.Translation, vars.Recoil.Rotation
	--sway
	self:CalcSway(EyeAng)
	--idle and aim offsets
	local aimPos, aimAng = self:GetAvailableAimOffsets()
	aimAng = aimAng * 1
	aimAng:Mul(self:SafeLerp(self:GetAD(), 0, 1))
	local idleAng = self.ViewModelOffsets.Idle.Angles * self:SafeLerp(self:GetAD(), 1, 0)
	self:SafeLerpAngle(50 * FrameTime(), vars.LerpAimAngles, aimAng)
	EyeAng:Add(vars.LerpAimAngles)
	EyeAng:Add(idleAng)
	--end idle and aim offsets
	--free aim: tilt the gun down as we aim so the sights/optic line up with the lowered aim point
	EyeAng.p = EyeAng.p + self:GetAimPitchOffsetCL() * self:GetAD()
	--viewpunch
	local vpAngles = self:GetOwner():GetViewPunchAngles()
	vpAngles.y = 0
	vpAngles.r = 0
	vpAngles:Mul(self:SafeLerp(self:GetAD(), 0.2, 0.01))
	EyeAng:Add(vpAngles)
	--end viewpunch
	--jump
	local jumpAngles = Angle(vars.Jump.Lerp, 0, 0)
	jumpAngles:Mul(self:SafeLerp(vars.LerpAimDelta, 1, 0.1))
	EyeAng:Add(jumpAngles)
	--end jump
	--sway
	local swayAngles = Angle(vars.Sway.Y.Lerp, vars.Sway.X.Lerp, 0)
	swayAngles:Mul(self:SafeLerp(vars.LerpAimDelta, 1, 0.1))
	EyeAng:Add(swayAngles)
	--end sway
	--fake recoil
	EyeAng:Add(recoilAng)
	--end fake recoil
	local forward = EyeAng:Forward()
	local right = EyeAng:Right()
	local up = EyeAng:Up()
	--wall lower: smoothly drop the muzzle when it is up against a wall (state from UpdateWallBlock)
	self.m_WallLowerDelta = self:SafeLerp(10 * FrameTime(), self.m_WallLowerDelta or 0, self.m_bWallBlock and 1 or 0)

	if (self.m_WallLowerDelta > 0.001) then
		local d = self.m_WallLowerDelta
		self:VectorAddAndMul(EyePos, up, -3 * d)
		self:VectorAddAndMul(EyePos, forward, -2 * d)
		EyeAng.p = EyeAng.p + (self.WallLowerAngle or 35) * d
	end
	--end wall lower
	--recoil
	local intensity = (math.Clamp(self:GetOwner():GetViewPunchAngles().p / 90, -1, 1) * 20) * self:SafeLerp(self:GetAD(), 0.3 * self.ViewModelOffsets.RecoilMultiplier, 0.01 * self.ViewModelOffsets.RecoilMultiplier)
	self:VectorAddAndMul(EyePos, up, intensity * 0.3)
	self:VectorAddAndMul(EyePos, forward, intensity)
	self:VectorAddAndMul(EyePos, forward, -self.Camera.Shake * self:SafeLerp(self:GetAD(), 0.7, 1.3) * self:SafeLerp(self:GetAD(), self.ViewModelOffsets.KickMultiplier or 1, self.ViewModelOffsets.AimKickMultiplier or 1))
	--end recoil
	--movement
	self:VectorAddAndMul(EyePos, up, vars.Jump.LerpZ * -0.05 * self:SafeLerp(vars.LerpAimDelta, 1, 0.1))
	self:VectorAddAndMul(EyePos, forward, -vars.LerpForward * self:SafeLerp(vars.LerpAimDelta, 2, 0.3))
	self:VectorAddAndMul(EyePos, right, -vars.LerpRight * self:SafeLerp(vars.LerpAimDelta, 1, 0.05))
	--end movement
	--idle
	self:VectorAddAndMul(EyePos, up, math.cos(CurTime() * 2) * math.cos(CurTime()) * 0.1 * self:SafeLerp(vars.LerpAimDelta, 1, 0))
	self:VectorAddAndMul(EyePos, right, math.cos(CurTime() * 2) * math.sin(CurTime()) * 0.1 * self:SafeLerp(vars.LerpAimDelta, 1, 0))
	-- end of idle
	--sway
	self:VectorAddAndMul(EyePos, up, (vars.Sway.PosY.Lerp * 0.25) * self:SafeLerp(vars.LerpAimDelta, 1, 0.5))
	self:VectorAddAndMul(EyePos, forward, (vars.Sway.PosForward.Lerp * 0.1) * self:SafeLerp(vars.LerpAimDelta, 1, 0.5))
	self:VectorAddAndMul(EyePos, right, (vars.Sway.PosX.Lerp * 0.25) * self:SafeLerp(vars.LerpAimDelta, 1, 0.5))
	--end sway
	--offsets
	self:SafeLerpVector(10 * FrameTime(), vars.LerpAimPos, aimPos)
	local aimOffset = self:CalcOffset(vars.LerpAimPos, EyeAng * 1)
	aimOffset:Mul(self:SafeLerp(self:GetAD(), 0, 1))
	local idleOffset = self:CalcOffset(self.ViewModelOffsets.Idle.Pos, EyeAng * 1)
	idleOffset:Mul(self:SafeLerp(self:GetAD(), 1, 0))
	EyePos:Add(aimOffset)
	EyePos:Add(idleOffset)
	--end offsets
	--crouch
	self:SafeLerpVector(1 * FrameTime(), vars.LerpCrouch, self:CalcCrouchOffset())
	vars.LerpCrouch:Mul(1 - self:GetAD())
	self:VectorAddAndMul(EyePos, up, vars.LerpCrouch.z)
	self:VectorAddAndMul(EyePos, forward, vars.LerpCrouch.y)
	self:VectorAddAndMul(EyePos, right, vars.LerpCrouch.x)
	--end crouch
	--fake recoil
	self:VectorAddAndMul(EyePos, up, recoilPos.z)
	self:VectorAddAndMul(EyePos, forward, recoilPos.y)
	self:VectorAddAndMul(EyePos, right, recoilPos.x)
	--end fake recoil
	CalcVMViewHookBypass = true
	--EyeAng.p = EyeAng.p * 0.97
	EyePos, EyeAng = hook.Run("CalcViewModelView", self, self.m_ViewModel, self.m_ViewModel:GetPos(), self.m_ViewModel:GetAngles(), EyePos * 1, EyeAng * 1)
	CalcVMViewHookBypass = false
	self.m_ViewModel:SetPos(EyePos)
	self.m_ViewModel:SetAngles(EyeAng)
	local aimLerpFinal = Lerp(self.Camera.FovAimDelta, self.Zoom.ViewModelFovMultiplier, 0.9)
	self.ViewModelFOV = self:SafeLerp(self.Camera.Fov, self.m_OriginalViewModelFOV, self.m_OriginalViewModelFOV * aimLerpFinal) * math.max(Lerp(self:GetAD(), 1, 1), 0.1)
end

function SWEP:CalcViewModelJump()
	local vars = self.ViewModelVars
	if (self:GetOwner() == NULL) then return end

	if (vars.Jump.bWasOnGround ~= self:GetOwner():OnGround()) then
		if (self:GetOwner():OnGround()) then
			vars.Jump.Force = math.min(vars.Jump.Velocity * -0.075, 30)
			vars.Jump.ForceZ = vars.Jump.Force
			vars.Jump.Time = 0
			vars.Jump.Shake = vars.Jump.Force * 0.3
		else
			timer.Simple(0, function()
				if (not IsValid(self) or not IsValid(self:GetOwner())) then return end
				vars.Jump.Force = self:GetOwner():GetVelocity().z * 0.15
				vars.Jump.ForceZ = vars.Jump.Force
				vars.Jump.Time = 0
			end)
		end

		vars.Jump.bWasOnGround = self:GetOwner():IsOnGround()
	end

	vars.Jump.Velocity = self:GetOwner():GetVelocity().z
	vars.Jump.Time = vars.Jump.Time + FrameTime()
	vars.Jump.Force = self:SafeLerp(6 * FrameTime(), vars.Jump.Force, 0)
	vars.Jump.ForceZ = self:SafeLerp(3 * FrameTime(), vars.Jump.ForceZ, 0)
	vars.Jump.Lerp = self:SafeLerp(10 * FrameTime(), vars.Jump.Lerp, math.sin(vars.Jump.Time * 10) * vars.Jump.Force)
	vars.Jump.LerpZ = self:SafeLerp(6 * FrameTime(), vars.Jump.LerpZ, math.sin(vars.Jump.Time * 7) * vars.Jump.ForceZ)
end

--https://stackoverflow.com/questions/5100811/algorithm-to-control-acceleration-until-a-position-is-reached
function SWEP:DecayLaserAim()
	local springConstant = 500
	local wobbleConstant = 1.2
	local currentToTarget = Vector(self:GetAimModeDelta(), self:GetAimModeDelta(), 0)
	currentToTarget:Sub(self.m_AimModeDeltaLerp)
	currentToTarget.y = currentToTarget.y * springConstant
	currentToTarget.x = currentToTarget.x * springConstant * 0.5
	local dampingForce = -self.m_AimModeDeltaVelocity * wobbleConstant
	local sqrt = math.sqrt(springConstant)
	dampingForce.y = dampingForce.y * sqrt
	dampingForce.x = dampingForce.x * (sqrt * 0.8)
	local force = currentToTarget + dampingForce
	self.m_AimModeDeltaVelocity:Add(force * math.min(FrameTime(), 0.03))
	self.m_AimModeDeltaLerp:Add(self.m_AimModeDeltaVelocity * math.min(FrameTime(), 0.03))
end

local noAimPos = Vector()
local noAimAng = Angle()

function SWEP:GetAvailableAimOffsets()
	local originalPos, originalAng = self.ViewModelOffsets.Aim.Pos, self.ViewModelOffsets.Aim.Angles
	local pos, ang = self.ViewModelOffsets.Aim.Pos, self.ViewModelOffsets.Aim.Angles

	if (self:GetSight() ~= nil) then
		originalPos = originalPos + (self:GetSight().AimPos or noAimPos)
		originalAng = originalAng + (self:GetSight().AimAng or noAimAng)
	end

	if (self.DisableCantedReload and self:GetIsReloading()) then
		self.CantedReloadDisableDelta = math.Approach(self.CantedReloadDisableDelta, 0, 5 * FrameTime())
	else
		self.CantedReloadDisableDelta = math.Approach(self.CantedReloadDisableDelta, 1, 5 * FrameTime())
	end

	if (self.LaserAimPos ~= nil and self.LaserAimAngles ~= nil and self:GetLaser() ~= nil) then
		pos = self.LaserAimPos * self.CantedReloadDisableDelta
		ang = self.LaserAimAngles * self.CantedReloadDisableDelta
	end

	if (self:GetSight() ~= nil and self:GetSight().ReticleHybrid ~= nil) then
		pos = (self:GetSight().HybridAimPos or self.HybridAimPos or noAimPos) * self.CantedReloadDisableDelta
		ang = (self:GetSight().HybridAimAng or self.HybridAimAngles or noAimAng) * self.CantedReloadDisableDelta
	end

	if (self:GetAD() > 0.5) then
		self:DecayLaserAim()
	end

	return LerpVector(self.m_AimModeDeltaLerp.x, originalPos, pos), LerpAngle(self.m_AimModeDeltaLerp.y, originalAng, ang)
end

function SWEP:CalcMovementSway()
	local velVector = Vector(self:GetOwner():GetVelocity().x, self:GetOwner():GetVelocity().y, 0)
	local ang = Angle(0, self:GetOwner():EyeAngles().yaw, 0)
	local forward = ang:Forward():Dot(velVector) / self:GetOwner():GetWalkSpeed()
	local right = ang:Right():Dot(velVector) / self:GetOwner():GetWalkSpeed()

	if (self:GetIsSprinting()) then
		forward = 0
		right = 0
	end

	forward = math.Clamp(forward, -1, 1)
	right = math.Clamp(right, -1, 1)
	local vars = self.ViewModelVars
	vars.LerpForward = self:SafeLerp(10 * FrameTime(), vars.LerpForward, math.max(forward, 0))

	local br = self:GetBreathingAngle()
	vars.LerpRight = self:SafeLerp(10 * FrameTime(), vars.LerpRight, right + math.Clamp(br.y, -2, 2) * 20)
	vars.Jump.LerpZ = self:SafeLerp(10 * FrameTime(), vars.Jump.LerpZ, math.Clamp(br.x, -2, 2) * 200)
end

function SWEP:CalcSway(ang)
	if (self.DisableSway) then return end
	local x = ang.yaw
	local y = ang.pitch
	local vars = self.ViewModelVars.Sway
	local vel = self:GetOwner():GetVelocity():Length()
	self:CalcSwayAxis(vars.X, x, 10, 0.035, vel)
	self:CalcSwayAxis(vars.Y, y, 10, 0.035, vel)
	self:CalcSwayAxis(vars.PosX, x, 7.5, 0.035, vel)
	self:CalcSwayAxis(vars.PosY, y, 7.5, 0.035, vel)
	self:CalcSwayAxis(vars.PosForward, x, 10, 0.1, vel)
end

function SWEP:CalcSwayAxis(swayObject, angle, speed, bounce, vel)
	local limit = 10 + (vel * 0.015)

	if (swayObject.Ang ~= angle) then
		swayObject.Sway = math.Clamp(swayObject.Sway + math.AngleDifference(angle, swayObject.Ang) * 0.3, -limit, limit)
	end

	swayObject.Ang = angle
	swayObject.Direction = self:SafeLerp(math.min(speed * FrameTime(), speed), swayObject.Direction, (0 - swayObject.Sway) * bounce)
	swayObject.Sway = swayObject.Sway + (swayObject.Direction * math.min(FrameTime() * 250, speed))
	swayObject.Lerp = self:SafeLerp(math.min(speed * 2 * FrameTime(), speed), swayObject.Lerp, swayObject.Sway)
end

function SWEP:CalcOffset(offset, ang)
	return (ang:Forward() * offset.y) + (ang:Right() * offset.x) + (ang:Up() * offset.z)
end

function SWEP:CalcCrouchOffset()
	if (self:GetOwner():Crouching() and self:GetOwner():IsOnGround()) then return self.CrouchVector end

	return self.ZeroVector
end

local function decayRecoil(target, lerp, vel, springConstant, wobbleConstant)
	local currentToTarget = target
	currentToTarget:Sub(lerp)
	currentToTarget.y = currentToTarget.y * springConstant * 0.5
	currentToTarget.x = currentToTarget.x * springConstant * 0.5
	currentToTarget.z = currentToTarget.z * springConstant * 0.5
	local sqrt = math.sqrt(springConstant)
	local dampingForce = -vel * wobbleConstant
	dampingForce.y = dampingForce.y * (sqrt * 0.65)
	dampingForce.x = dampingForce.x * sqrt
	dampingForce.z = dampingForce.z * sqrt
	local force = currentToTarget + dampingForce
	vel:Add(force * math.min(FrameTime(), 0.01))
	lerp:Add(vel * math.min(FrameTime(), 0.01))
end

SWEP.m_RecoilVelocity = Vector()
SWEP.m_RecoilLerp = Vector()
SWEP.m_RecoilAngVelocity = Vector()
SWEP.m_RecoilAngLerp = Vector()
SWEP.m_RecoilAimVelocity = Vector()
SWEP.m_RecoilAimLerp = Vector()
SWEP.m_RecoilAimAngVelocity = Vector()
SWEP.m_RecoilAimAngLerp = Vector()

function SWEP:CalcRecoil()
	if (not self.Primary.Automatic) then
		self.ViewModelVars.Recoil.Rotation:Zero()
		self.ViewModelVars.Recoil.Translation:Zero()

		return
	end

	local target = VectorRand() * (math.Clamp(self:GetSprayRounds(), 0, 5) * Lerp(self:GetAD(), 0.5, 1))
	target.y = -math.Clamp(self:GetSprayRounds(), 0, 2)

	if (self:GetAD() <= 0.5) then
		decayRecoil(target, self.m_RecoilLerp, self.m_RecoilVelocity, 150, 0.9)
		decayRecoil(target, self.m_RecoilAngLerp, self.m_RecoilAngVelocity, 60, 0.8)

		if (self:GetSprayRounds() <= 0) then
			self.m_RecoilAimLerp:Zero()
			self.m_RecoilAimAngLerp:Zero()
			self.m_RecoilAimAngVelocity:Zero()
			self.m_RecoilAimVelocity:Zero()
		end
	else
		decayRecoil(target, self.m_RecoilAimLerp, self.m_RecoilAimVelocity, 150, 1.9)
		decayRecoil(target, self.m_RecoilAimAngLerp, self.m_RecoilAimAngVelocity, 300, 1.2)

		if (self:GetSprayRounds() <= 0) then
			self.m_RecoilLerp:Zero()
			self.m_RecoilAngLerp:Zero()
			self.m_RecoilAngVelocity:Zero()
			self.m_RecoilVelocity:Zero()
		end
	end

	local aimLerp = Lerp(self:GetAD(), 1, 0.1) * (self.Recoil.ViewModelMultiplier or 1)
	self.ViewModelVars.Recoil.Translation = LerpVector(self:GetAD(), self.m_RecoilLerp, self.m_RecoilAimLerp) * aimLerp
	aimLerp = Lerp(self:GetAD(), 1, 0.025) * (self.Recoil.ViewModelMultiplier or 1)
	self.ViewModelVars.Recoil.Rotation = LerpAngle(self:GetAD(), Angle(self.m_RecoilAngLerp.z, self.m_RecoilAngLerp.x, self.m_RecoilAngLerp.z * 0.5), Angle(self.m_RecoilAimAngLerp.z, self.m_RecoilAimAngLerp.x, self.m_RecoilAimAngLerp.z * 0.5)) * 0.1 * aimLerp
end