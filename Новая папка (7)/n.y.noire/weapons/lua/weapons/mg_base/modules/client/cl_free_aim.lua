--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/client/cl_free_aim.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
if (SERVER) then return end

function SWEP:FreeAimModule(aimAng)
	local cfg = self:GetFreeAimConfig()

	if (not cfg.Enabled) then
		self.m_FreeAimReady = false

		return 0, 0
	end

	local state = self.m_FreeAim

	if (state == nil) then
		state = {
			Head = EyeAngles(),
			Smooth = EyeAngles(),
			DynamicGap = 0
		}

		self.m_FreeAim = state
	end

	-- (Re)sync to the current aim when we just spawned or were just toggled on, to avoid a snap.
	if (not self.m_FreeAimReady) then
		state.Head:Set(aimAng)
		state.Smooth:Set(aimAng)
		self.m_FreeAimReady = true
	end

	local head = state.Head
	local deadzoneYaw = cfg.DeadzoneYaw
	local deadzonePitch = cfg.DeadzonePitch

	-- Shrink the deadzone toward 0 while aiming down sights so the gun aligns with the camera.
	if (cfg.AdsFadesDeadzone) then
		local ads = self:GetAimDelta()

		if (ads > 0) then
			deadzoneYaw = Lerp(ads, deadzoneYaw, 0)
			deadzonePitch = Lerp(ads, deadzonePitch, 0)
		end
	end

	local aimScale = math.Clamp(cfg.AimScale, 0.1, 1)
	local scaledYaw = deadzoneYaw * aimScale
	local scaledPitch = deadzonePitch * aimScale

	local diffP = math.AngleDifference(aimAng.p, head.p)
	local diffY = math.AngleDifference(aimAng.y, head.y)

	-- Pitch deadzone.
	if (diffP > scaledPitch) then
		head.p = math.NormalizeAngle(aimAng.p - scaledPitch)
	elseif (diffP < -scaledPitch) then
		head.p = math.NormalizeAngle(aimAng.p + scaledPitch)
	end

	-- Yaw deadzone.
	if (diffY > scaledYaw) then
		head.y = math.NormalizeAngle(aimAng.y - scaledYaw)
	elseif (diffY < -scaledYaw) then
		head.y = math.NormalizeAngle(aimAng.y + scaledYaw)
	end

	head.r = aimAng.r

	local ft = FrameTime()

	-- Soft recentering: the camera gently drifts toward the aim so it never sits at the very edge.
	-- Uses AngleDifference so it takes the short way across the -180/180 yaw seam (plain Lerp would
	-- sweep the long way around there and make the camera spin / stop recentering).
	if (self:GetAimDelta() > 0 and scaledYaw > 0) then
		local blend = math.min(ft * (self:GetAimDelta() * cfg.RecenterSpeed), 1)
		head.p = math.NormalizeAngle(head.p + math.AngleDifference(aimAng.p, head.p) * blend)
		head.y = math.NormalizeAngle(head.y + math.AngleDifference(aimAng.y, head.y) * blend)
	end

	-- Smooth the camera movement (inertia / delay).
	state.Smooth = LerpAngle(math.min(ft * cfg.SmoothSpeed, 1), state.Smooth, head)
	local smooth = state.Smooth

	return math.AngleDifference(smooth.p, aimAng.p), math.AngleDifference(smooth.y, aimAng.y)
end