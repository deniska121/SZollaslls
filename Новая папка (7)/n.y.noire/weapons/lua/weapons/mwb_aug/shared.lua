--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_aug/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
PrecacheParticleSystem("AC_muzzle_rifle")
PrecacheParticleSystem("AC_muzzle_pistol_suppressed")
PrecacheParticleSystem("AC_muzzle_pistol_ejection")
PrecacheParticleSystem("AC_muzzle_pistol_smoke_barrel")
include("animations.lua")
include("customization.lua")

if CLIENT then
	killicon.Add("mg_augolf", "VGUI/entities/mg_augolf", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_sm_augolf")
end

SWEP.Base = "mg_base"
SWEP.ShellsId = "cases556"
SWEP.AmmoId = "box556"

SWEP.GripPoseParameters = {"grip_vert_offset"}

SWEP.PrintName = "AUG A1"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.VModel = Model("models/easy/cw/weapons/v_sm_t9powerburst.mdl")
SWEP.WorldModel = Model("models/easy/cw/weapons/w_sm_t9powerburst.mdl")
SWEP.Slot = 3
SWEP.HoldType = "RifleWithVerticalGrip"
SWEP.Resource = .0022
SWEP.DistSound = "Reflection_AR.Distance"
SWEP.Trigger = {
	PressedSound = Sound("mw19.augolf.prefire"),
	ReleasedSound = Sound("mw19.augolf.disconnector"),
	Time = 0.025
}

SWEP.Primary.Sound = Sound("mw19.augolf.fire")

SWEP.Reverb = {
	RoomScale = 50000,
	Sounds = {
		Outside = {
			Layer = Sound("Atmo_AR.Outside"),
			Reflection = Sound("Reflection_AR.Outside")
		},
		Inside = {
			Layer = Sound("Atmo_AR.Inside"),
			Reflection = Sound("Reflection_AR.Inside")
		}
	}
}

SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = true
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 810
SWEP.CanChamberRound = true

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_rifle",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0.1,
	["anim"] = "Equip",
	["next"] = 1,
}

SWEP.UseMags = {
	["aug_30"] = {1, 2}
}

SWEP.Unloader = {
	["mag_remove"] = 1,
	["skip_cycle"] = 0.65,
	["anim"] = "Reload_Empty",
	["load_cycle"] = 0.3,
}

SWEP.Firemodes = {
	[1] = {
		Name = "Full Auto",
		OnSet = function() return "Firemode_Auto" end
	},
	[2] = {
		Name = "Semi Auto",
		OnSet = function(self)
			self.Primary.Automatic = false
			return "Firemode_Semi"
		end
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
	Hip = 0.23, --accuracy while hip
	Ads = 0.055, --accuracy while aiming
	Shake = 0.3,
	Increase = 0.025, --increase cone size by this amount every time we shoot
	AdsMultiplier = 0.9, --multiply the increase value by this amount while aiming
	Max = 1.3, --the cone size will not go beyond this size
	Decrease = 0.75, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 4156 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {0.6, 0.8}, --random value between the 2
	Horizontal = {-1.4, 1.4}, --random value between the 2
	Shake = 1, --camera shake
	AdsMultiplier = 0.9, --multiply the values by this amount while aiming
	Seed = 124455 --give this a random number until you like the current recoil pattern
}

SWEP.Bullet = {
	Damage = {55, 23}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	DropOffStartRange = 65, --in meters, damage will start dropping off after this range
	EffectiveRange = 150, --in meters, damage scales within this distance
	Range = 250, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.7, --how much damaged is multipled by when leaving a surface.
		MaxCount = 3, --how many times the bullet can penetrate.
		Thickness = 12, --in hu, how thick an obstacle has to be to stop the bullet.
	}
}

SWEP.Zoom = {
	FovMultiplier = 0.95,
	ViewModelFovMultiplier = 1,
	Blur = {
		EyeFocusDistance = 7.5
	}
}

SWEP.WorldModelOffsets = {
	Bone = "tag_sling",
	Angles = Angle(-5, 95, -90),
	Pos = Vector(-11, -3, 13)
}

SWEP.ViewBoneOffsets = {
	{
		Bone = "tag_scope",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	}
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 3, 0)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Inspection = {
		Bone = "tag_sling",
		X = {
			[0] = {
				Pos = Vector(0, -2, 2),
				Angles = Angle(30, 0, -30)
			},
			[1] = {
				Pos = Vector(0, 2, 0),
				Angles = Angle(-10, 0, 0)
			}
		},
		Y = {
			[0] = {
				Pos = Vector(0, 0, -2),
				Angles = Angle(-10, 20, 0)
			},
			[1] = {
				Pos = Vector(3, 0, 5),
				Angles = Angle(10, -20, 0)
			}
		}
	},
	RecoilMultiplier = 0.25,
	KickMultiplier = 0.2,
	AimKickMultiplier = 0.75
}

SWEP.Shell = "mwb_shelleject_556"
DEFINE_BASECLASS("mg_base")