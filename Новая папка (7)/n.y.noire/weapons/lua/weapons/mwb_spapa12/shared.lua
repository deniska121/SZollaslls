--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_spapa12/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.BulletList = {"j_shell_12ga_01", "j_shell_12ga_02"}

include("animations.lua")
include("customization.lua")

if CLIENT then
	killicon.Add("mg_spapa12", "VGUI/entities/mg_spapa12", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("alias/weapons/spapa12/mg_spapa12")
end

SWEP.Base = "mg_base"

SWEP.GripPoseParameters = {"grip_ang_offset", "grip_vert_offset", "grip_wood_offset"}

SWEP.GripPoseParameters2 = {"grip_stockh_offset"}

SWEP.UseMags = nil
SWEP.UseINV = {
	["buckshot"] = true
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0,
	["anim"] = "Rechamber",
	["next"] = 1,
}

SWEP.DistSound = "Reflection_Shotgun.Distance"
SWEP.PrintName = "SPAS-12"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Shotguns"
SWEP.Spawnable = true
SWEP.VModel = Model("models/alias/weapons/v_spapa12.mdl")
SWEP.WorldModel = Model("models/w_spapa12.mdl")
SWEP.DisableCantedReload = false
SWEP.Slot = 3
SWEP.HoldType = "Rifle"
SWEP.Primary.Sound = Sound("weap_sh_semiauto_start")
SWEP.Primary.Ammo = "Buckshot"
SWEP.Primary.ClipSize = 6
SWEP.Primary.Automatic = false
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 300
SWEP.CanChamberRound = true
SWEP.CanDisableAimReload = false
SWEP.EmptyReloadRechambers = false
SWEP.ReloadRechambers = false
SWEP.ReloadUnchamber = true

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_shotgun",
	["MuzzleFlash_DB"] = "AC_muzzle_shotgun_db",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
	["Overheating"] = "AC_muzzle_pistol_smoke_barrel",
}

SWEP.Reverb = {
	RoomScale = 50000, --(cubic hu)
	--how big should an area be before it is categorized as 'outside'?
	Sounds = {
		Outside = {
			Layer = Sound("Atmo_Shotgun.Outside"),
			Reflection = Sound("Reflection_Shotgun.Outside")
		},
		Inside = {
			Layer = Sound("Atmo_Shotgun.Inside"),
			Reflection = Sound("Reflection_Shotgun.Inside")
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
	ShotTemperatureIncrease = 65,
	TemperatureThreshold = 100, --temperature that triggers smoke
	TemperatureCooldown = 65 --degrees per second
}

SWEP.Cone = {
	Hip = 0.8, --accuracy while hip
	Ads = 0.8, --accuracy while aiming
	Increase = 0.085, --increase cone size by this amount every time we shoot
	Shake = 0.5,
	AdsMultiplier = 1, --multiply the increase value by this amount while aiming
	Max = 2.5, --the cone size will not go beyond this size
	Decrease = 0.24, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 3658 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {6, 7.5}, --random value between the 2
	Horizontal = {-1.75, 2.75}, --random value between the 2
	Shake = 4, --camera shake
	AdsMultiplier = 1, --multiply the values by this amount while aiming
	Seed = 65947, --give this a random number until you like the current recoil pattern
	ViewModelMultiplier = 0.56
}

SWEP.Bullet = {
	Damage = {300, 30}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 15, --in meters, damage scales within this distance
	Range = 37, --in meters, after this distance the bullet stops existing
	Spread = 0.075,
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

SWEP.ShellsId = "cases_buckshot"
SWEP.AmmoId = "buckshot"

SWEP.NoPumpSycle = true

SWEP.WorldModelOffsets = {
	Bone = "tag_sling",
	Angles = Angle(0, 100, -90),
	Pos = Vector(10, -1, -5)
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(-4.23, 2.35, -0.63)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Sprint = {
		Angles = Angle(-13, 20, 30),
		Pos = Vector(8, -6, -4)
	},
	-- Sprint = { -- Angles = Angle(0, 0, 0), -- Pos = Vector(0, 0, 0) -- },
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