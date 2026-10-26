--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_free_aim_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

-- Free Aim configuration.
-- This is the Lua equivalent of the ConVars used by the standalone cl_free_aim.lua example.
-- Tweak the values here instead of using console commands. Every weapon can also override
-- any of these by defining its own SWEP.FreeAim = { ... } table in its shared.lua (only the
-- keys it wants to change), see SWEP:GetFreeAimConfig() further down this file.
MW_FREEAIM = {
	Enabled = true, --master switch for the free aim (decoupled camera) behaviour
	--Deadzone: how far the gun can point away from the camera before the camera starts to follow.
	DeadzoneYaw = 10, --horizontal deadzone in degrees (lower = more realistic)
	DeadzonePitch = 10, --vertical deadzone in degrees
	AimScale = 0.5, --scales the deadzone down so the offset is less exaggerated (0.1 - 1.0)
	SmoothSpeed = 30, --how fast the camera catches up to the aim (lower = heavier, higher = snappier)
	RecenterSpeed = 3, --camera gently drifts back toward the aim direction (0 = disabled)
	Sensitivity = 1, --free aim look sensitivity while hip firing (1 = normal, lower = slower/finer aim, higher = twitchier). Eases back to the normal zoom sensitivity as you aim down sights.
	AimRecoil = 0.6, --per shot, climb the actual aim (EyeAngles) upward by this fraction of the weapon's vertical recoil, ON TOP of the view punch. Not recovered - you pull back down yourself. 0 = off.
	--Rest the aim point below the view centre by this many degrees. The gun points slightly down, --so the crosshair AND the bullets sit lower on the screen while the view itself stays level. --Rough guide: ~10 deg is about 15% of the screen height at the default FOV. 0 = disabled.
	AimPitchOffset = 5,
	AimPitchOffsetFadeOnAim = false, --straighten the aim back to centre while aiming down sights
	--The deadzone is faded out while aiming down sights so the gun lines up with the camera. --This uses the weapon's own aim delta (0 hip .. 1 fully aimed).
	AdsFadesDeadzone = false,
}

-- Resolve the config (shared), letting a weapon override any key through SWEP.FreeAim = { ... }.
function SWEP:GetFreeAimConfig()
	local base = MW_FREEAIM
	if (self.FreeAim == nil) then return base end

	if (self.m_FreeAimConfig == nil) then
		self.m_FreeAimConfig = table.Copy(base)
		table.Merge(self.m_FreeAimConfig, self.FreeAim)
	end

	return self.m_FreeAimConfig
end

function SWEP:IsFreeAimEnabled()
	return self:GetFreeAimConfig().Enabled == true
end

-- Degrees the aim (crosshair + bullets) is pitched DOWN from the view centre. Shared so the client
-- crosshair and the server-side FireBullets agree on where the gun points. Fades out on ADS.
function SWEP:GetAimPitchOffset()
	local cfg = self:GetFreeAimConfig()
	if (not cfg.Enabled) then return 0 end
	local deg = cfg.AimPitchOffset or 0
	if (deg == 0) then return 0 end

	if cfg.AimPitchOffsetFadeOnAim or self.opticZoom then
		deg = deg * (1 - self:GetAimDelta())
	end
	deg = deg * self.Zoom.FovMultiplier
	return deg
end

function SWEP:GetAimPitchOffsetCL()
	return self:GetAimPitchOffset() / 2
	--return self:GetAimPitchOffset() * (self._fov and (self._fov / 90) or 1)
end