--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_m590/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
PrecacheParticleSystem("AC_muzzle_shotgun")
PrecacheParticleSystem("AC_muzzle_shotgun_db")
PrecacheParticleSystem("AC_muzzle_pistol_suppressed")
PrecacheParticleSystem("AC_muzzle_pistol_ejection")
PrecacheParticleSystem("AC_muzzle_pistol_smoke_barrel")
PrecacheParticleSystem("AC_muzzle_minigun_smoke_barrel")

SWEP.BulletList = {"j_shell_12ga_01", "j_shell_12ga_02"}

include("animations.lua")
include("customization.lua")

if CLIENT then
	killicon.Add("mg_romeo870", "VGUI/entities/mg_romeo870", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_sh_romeo870")
end

SWEP.Base = "mg_base"

SWEP.WMFixpos = {
	Vector(-2,6.5,-12),
	Angle(97,-3,-90)
}

SWEP.GripPoseParameters = {"grip_ang_offset", "grip_vert_offset", "grip_wood_offset", "grip_front_offset"}

SWEP.GripPoseParameters2 = {"grip_stockh_offset", "grip_back_offset"}

SWEP.PrintName = "Mossberg 590"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Shotguns"
SWEP.Spawnable = true
SWEP.VModel = Model("models/m590_eft_cc1.mdl")
SWEP.WorldModel = Model("models/viper/mw/weapons/w_romeo870.mdl")
SWEP.DistSound = "Reflection_Shotgun.Distance"
SWEP.UseMags = nil
SWEP.UseINV = {
	["buckshot"] = true
}

SWEP.DisableCantedReload = false
SWEP.Slot = 3
SWEP.HoldType = "Rifle"
SWEP.Primary.Sound = Sound("m590_f_2")
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.ClipSize = 7
SWEP.Primary.Automatic = false
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 230
SWEP.CanChamberRound = true
SWEP.CanDisableAimReload = false
SWEP.EmptyReloadRechambers = false
SWEP.Resource = .0028

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_shotgun",
	["MuzzleFlash_DB"] = "AC_muzzle_shotgun_db",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
	["Overheating"] = "AC_muzzle_pistol_smoke_barrel",
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0,
	["anim"] = "Rechamber",
	["next"] = 1,
}

SWEP.ShellsId = "cases_buckshot"
SWEP.AmmoId = "buckshot"

SWEP.Reverb = {
	RoomScale = 50000, --(cubic hu)
	--how big should an area be before it is categorized as 'outside'?
	Sounds = {
		Outside = {
			Layer = Sound("Atmo_Shotgun2.Outside"),
			Reflection = Sound("Reflection_Shotgun.Outside")
		},
		Inside = {
			Layer = Sound("Atmo_Shotgun2.Inside"),
			Reflection = Sound("Reflection_Sniper.Inside")
		}
	}
}

SWEP.Firemodes = {
	[1] = {
		Name = "Pump-Action",
		OnSet = function(self)
			self.Primary.Automatic = false

			return "Firemode_Semi"
		end
	},
}

SWEP.BarrelSmoke = {
	Particle = "AC_muzzle_minigun_smoke_barrel",
	Attachment = "muzzle",
	ShotTemperatureIncrease = 30,
	TemperatureThreshold = 200, --temperature that triggers smoke
	TemperatureCooldown = 8 --degrees per second
}

SWEP.Cone = {
	Hip = 0.8, --accuracy while hip
	Ads = 0.65, --accuracy while aiming
	Shake = 0.25,
	Increase = 0.3, --increase cone size by this amount every time we shoot
	AdsMultiplier = 0.7, --multiply the increase value by this amount while aiming
	Max = 2.5, --the cone size will not go beyond this size
	Decrease = 0.24, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 3658 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {5, 6.5}, --random value between the 2
	Horizontal = {-1.75, 2.75}, --random value between the 2
	Shake = 4, --camera shake
	Punch = 1.2,
	AdsMultiplier = 0.7, --multiply the values by this amount while aiming
	Seed = 65947, --give this a random number until you like the current recoil pattern
	ViewModelMultiplier = 0.56
}

SWEP.Bullet = {
	Damage = {300, 30}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 18, --in meters, damage scales within this distance
	Range = 35, --in meters, after this distance the bullet stops existing
	Spread = 0.07,
	Tracer = false, --show tracer
	NumBullets = 6, --the amount of bullets to fire
	PhysicsMultiplier = 2.36, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.86, --how much damaged is multipled by when leaving a surface.
		MaxCount = 13, --how many times the bullet can penetrate.
		Thickness = 18, --in hu, how thick an obstacle has to be to stop the bullet.
	}
}

SWEP.Zoom = {
	FovMultiplier = 0.95,
	ViewModelFovMultiplier = 1,
	Blur = {
		EyeFocusDistance = 10
	}
}

SWEP.WorldModelOffsets = {
	Bone = "tag_sling",
	Angles = Angle(0, 100, -90),
	Pos = Vector(10, -1, -5)
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0.03, 0, 0)
	},
	Idle = {
		Angles = Angle(0, 0, -10),
		Pos = Vector(-0.5, 0, -1)
	},
	Sprint = {
		Angles = Angle(-10, 10, 0),
		Pos = Vector(0, 0, -3)
	},
	Inspection = {
		Bone = "tag_sling",
		X = {
			[0] = {
				Pos = Vector(0, 3, 3),
				Angles = Angle(40, 0, -30)
			},
			[1] = {
				Pos = Vector(-3, -1, 0),
				Angles = Angle(-10, 0, 0)
			}
		},
		Y = {
			[0] = {
				Pos = Vector(0, 0, 0),
				Angles = Angle(-10, 20, 0)
			},
			[1] = {
				Pos = Vector(4, -2, 1.5),
				Angles = Angle(10, -10, 0)
			}
		}
	},
	RecoilMultiplier = 6.75,
	KickMultiplier = 1,
	AimKickMultiplier = 0.5
}

SWEP.Shell = "mwb_shelleject_12g"
DEFINE_BASECLASS("mg_base")