--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_m9/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
PrecacheParticleSystem("AC_muzzle_pistol")
PrecacheParticleSystem("AC_muzzle_pistol_suppressed")
PrecacheParticleSystem("AC_muzzle_pistol_ejection")
PrecacheParticleSystem("AC_muzzle_pistol_smoke_barrel")
include("animations.lua")
include("customization.lua")

if CLIENT then
	killicon.Add("mg_m9", "VGUI/entities/mg_m9", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_pi_mike9")
end

SWEP.Base = "mg_base"

SWEP.ShellsId = "cases9"
SWEP.AmmoId = "cases9"

SWEP.UseMags = {
	["m9_15"] = {1, 2},
	["m9_20"] = {1, 3},
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0.43,
	["anim"] = "Reload_Empty",
	["next"] = 1,
}

SWEP.Unloader = {
	["mag_remove"] = 0.75,
	["skip_cycle"] = 0.5,
	["anim"] = "Reload",
	["anim_swap"] = "Reload_Empty",
	["load_cycle"] = 0.15,
}

SWEP.PrintName = "Beretta M9"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Pistols"
SWEP.Spawnable = true
SWEP.VModel = Model("models/viper/mw/weapons/v_m9.mdl")
SWEP.WorldModel = Model("models/viper/mw/weapons/w_m9.mdl")
SWEP.Resource = .0033
SWEP.DontHide = false
SWEP.Trigger = {
	PressedSound = Sound("MW19_M9.Fire.First"),
	ReleasedSound = Sound("MW19_M9.Fire.Disconnector"),
	Time = 0.025
}

SWEP.Slot = 2
SWEP.HoldType = "Pistol"

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_pistol",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
}

SWEP.HolsterDataBack = {"ValveBiped.Bip01_Spine2", Vector(3, 2.8, -2), Angle(0, 0, 180)}
SWEP.HolsterDataLow = {"ValveBiped.Bip01_Pelvis", Vector(-8, -5, -3), Angle(180, 90, 0)}

SWEP.HolsterData = table.Copy(SWEP.HolsterDataLow)


SWEP.Primary.Sound = Sound("MW19_M9.Fire")
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 15
SWEP.Primary.Automatic = false
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 600
SWEP.CanChamberRound = true

SWEP.Reverb = {
	RoomScale = 50000, --(cubic hu)
	--how big should an area be before it is categorized as 'outside'?
	Sounds = {
		Outside = {
			Layer = Sound("Atmo_Pistol.Outside"),
			Reflection = Sound("Reflection_Pistol.Outside")
		},
		Inside = {
			Layer = Sound("Atmo_Pistol.Inside"),
			Reflection = Sound("Reflection_Pistol.Inside")
		}
	}
}

SWEP.Firemodes = {
	[1] = {
		Name = "Semi Auto",
		OnSet = function() return nil end
	},
}

SWEP.BarrelSmoke = {
	Particle = "AC_muzzle_pistol_smoke_barrel",
	Attachment = "muzzle",
	ShotTemperatureIncrease = 10,
	TemperatureThreshold = 200, --temperature that triggers smoke
	TemperatureCooldown = 8 --degrees per second
}

SWEP.Cone = {
	Hip = 0.2, --accuracy while hip
	Ads = 0.15, --accuracy while aiming
	Shake = 1.1,
	Increase = 0.1, --increase cone size by this amount every time we shoot
	AdsMultiplier = 1, --multiply the increase value by this amount while aiming
	Max = 1.3, --the cone size will not go beyond this size
	Decrease = 0.9, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 61543 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {0.8, 1.3}, --random value between the 2
	Horizontal = {-1.16, 1.23}, --random value between the 2
	Shake = 2, --camera shake 
	AdsMultiplier = 1, --multiply the values by this amount while aiming
	Seed = 610312 --give this a random number until you like the current recoil pattern
}

SWEP.Bullet = {
	Damage = {32, 10}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 27, --in meters, damage scales within this distance
	DropOffStartRange = 18, --in meters, damage scales within this distance
	Range = 120, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.75, --how much damaged is multipled by when leaving a surface.
		MaxCount = 4, --how many times the bullet can penetrate.
		Thickness = 8, --in hu, how thick an obstacle has to be to stop the bullet.
	}
}

SWEP.Zoom = {
	FovMultiplier = 0.95,
	ViewModelFovMultiplier = 1,
	Blur = {
		EyeFocusDistance = 15
	}
}

SWEP.WorldModelOffsets = {
	Bone = "tag_pistol_offset",
	Angles = Angle(0, 90, -90),
	Pos = Vector(7.5, 3, -2)
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0.15, -2, -0.05)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Inspection = {
		Bone = "tag_pistol_offset",
		X = {
			[0] = {
				Pos = Vector(0, 2, -2),
				Angles = Angle(30, 0, -30)
			},
			[1] = {
				Pos = Vector(0, 0, 0),
				Angles = Angle(0, 0, 0)
			}
		},
		Y = {
			[0] = {
				Pos = Vector(2, 0, 0),
				Angles = Angle(-30, -30, 0)
			},
			[1] = {
				Pos = Vector(-4, 0, 0),
				Angles = Angle(0, 30, 0)
			}
		}
	},
	RecoilMultiplier = 1,
	KickMultiplier = 1
}

SWEP.Shell = "mwb_shelleject_9mm"

SWEP.GripPoseParameters = {"grip_offset"}

SWEP.ViewBoneOffsets = {
	{
		Bone = "tag_silencer",
		Angles = Angle(0, 0, 0),
		Pos = Vector(2, 0, 0)
	}
}


-- SWEP.WorldBoneOffsets = {
-- 	{
-- 		Bone = "tag_laser_attach",
-- 		Angles = Angle(0, 0, 180),
-- 		Pos = Vector(0, 0, 0)
-- 	},
-- 	{
-- 		Bone = "tag_reflex",
-- 		Angles = Angle(180, 90, 0),
-- 		Pos = Vector(-5.3, 9.2, -64.1),
-- 		OnlyWM = true
-- 	}
-- }