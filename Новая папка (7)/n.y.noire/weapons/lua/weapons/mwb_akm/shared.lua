--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_akm/shared.lua
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
	killicon.Add("mg_akilo47", "VGUI/entities/mg_akilo47", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_ar_akilo47")
end

SWEP.Base = "mg_base"

SWEP.GripPoseParameters = {"grip_ang_offset", "grip_smg_pose_offset", "grip_vert_offset", "grip_vert_smg_offset", "grip_vert_pro_offset", "grip_vert_pro_smg_offset", "grip_smg_anggrip_offset"}

SWEP.PrintName = "AKM"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.VModel = Model("models/viper/mw/weapons/v_akilo47.mdl")
SWEP.WorldModel = Model("models/viper/mw/weapons/w_akilo47.mdl")
SWEP.Slot = 3
SWEP.HoldType = "Rifle"
SWEP.Resource = .001
SWEP.DistSound = "Reflection_AR.Distance"
SWEP.Trigger = {
	PressedSound = Sound("mw19.akilo47.fire.first"),
	ReleasedSound = Sound("mw19.akilo47.fire.disconnector"),
	Time = 0.025
}

SWEP.ShellsId = "cases762"
SWEP.AmmoId = "box762"

SWEP.UseMags = {
	["ak762_30"] = {1, 2},
	["ak762_40"] = {1, 4},
	["ak762_75"] = {1, 6},
}

SWEP.Unloader = {
	["mag_remove"] = 1.1,
	["skip_cycle"] = 0.5,
	["anim"] = "Reload_Empty",
	["load_cycle"] = 0.29,
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0,
	["anim"] = "Equip",
	["next"] = 1,
}

SWEP.Primary.Sound = Sound("mw19.akilo47.fire")
SWEP.Primary.Ammo = "Ar2"
SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = false
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 561
SWEP.CanChamberRound = true

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_rifle",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
}

SWEP.Reverb = {
	RoomScale = 50000, --(cubic hu)
	--how big should an area be before it is categorized as 'outside'?
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

SWEP.Firemodes = {
	[1] = {
		Name = "Semi Automatic",
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
	Hip = 0.45, --accuracy while hip
	Ads = 0.13, --accuracy while aiming
	Shake = 0.3,
	Increase = 0.093, --increase cone size by this amount every time we shoot
	AdsMultiplier = 0.9, --multiply the increase value by this amount while aiming
	Max = 1.75, --the cone size will not go beyond this size
	Decrease = 0.6, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 76676 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {2, 2.5}, --random value between the 2
	Horizontal = {-1.75, 1.75}, --random value between the 2
	Shake = 1.5, --camera shake
	AdsMultiplier = 0.9, --multiply the values by this amount while aiming
	Seed = 24366 --give this a random number until you like the current recoil pattern
}

SWEP.Bullet = {
	Damage = {65, 20}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	DropOffStartRange = 50, --in meters, damage will start dropping off after this range
	EffectiveRange = 100, --in meters, damage scales within this distance
	Range = 170, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.8, --how much damaged is multipled by when leaving a surface.
		MaxCount = 3, --how many times the bullet can penetrate.
		Thickness = 12, --in hu, how thick an obstacle has to be to stop the bullet.
	}
}

SWEP.Zoom = {
	FovMultiplier = 0.95,
	ViewModelFovMultiplier = 1,
	Blur = {
		EyeFocusDistance = 8
	}
}

SWEP.WorldModelOffsets = {
	Bone = "tag_sling",
	Angles = Angle(0, 90, -90),
	Pos = Vector(-5, 0, 9)
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Inspection = {
		Bone = "tag_sling",
		X = {
			[0] = {
				Pos = Vector(0, -4, 3),
				Angles = Angle(40, 0, -30)
			},
			[1] = {
				Pos = Vector(0, 0, 0),
				Angles = Angle(-10, 0, 0)
			}
		},
		Y = {
			[0] = {
				Pos = Vector(3, 0, -2),
				Angles = Angle(-10, 20, 0)
			},
			[1] = {
				Pos = Vector(4, 0, 3),
				Angles = Angle(10, -20, 0)
			}
		}
	},
	RecoilMultiplier = 0.45,
	KickMultiplier = 2,
	AimKickMultiplier = 1
}

SWEP.Shell = "mwb_shelleject_762"