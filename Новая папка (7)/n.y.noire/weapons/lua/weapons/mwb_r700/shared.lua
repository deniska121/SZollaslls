--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_r700/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
include("animations.lua")
include("customization.lua")

SWEP.GripPoseParameters = {"grip_ang_offset", "grip_vert_offset", "grip_vertpro_offset", "grip_stockhvy_offset", "grip_stocktac_offset", "grip_stockskel_offset", "grip_stocksn_offset"}

SWEP.GripPoseParameters2 = {"grip_pistolgrip_offset"}

SWEP.Base = "mg_base"
SWEP.PrintName = "Remington 700"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Marksman Rifles"
SWEP.Spawnable = true
SWEP.VModel = Model("models/viper/mw/weapons/v_romeo700.mdl")
SWEP.WorldModel = Model("models/viper/mw/weapons/w_romeo700.mdl")

SWEP.ShellsId = "cases308"
SWEP.AmmoId = "box308"

SWEP.UseMags = {
	["rem_5"] = {1, 2},
}

SWEP.Trigger = {
	PressedSound = Sound("mw19.sksierra.fire.first"),
	ReleasedSound = Sound("mw19.sksierra.disconnector"),
	Time = 0
}

SWEP.Slot = 3
SWEP.HoldType = "Rifle"
SWEP.Primary.Sound = Sound("weap_romeo700_fire_plr")
SWEP.Primary.Ammo = "357"
SWEP.Primary.ClipSize = 5
SWEP.Primary.Automatic = true
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 328
SWEP.CanChamberRound = true
SWEP.CanDisableAimReload = false
SWEP.EmptyReloadRechambers = true

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
			Layer = Sound("Atmo_Sniper.Outside"),
			Reflection = Sound("Reflection_Sniper.Outside")
		},
		Inside = {
			Layer = Sound("Atmo_Shotgun.Inside"),
			Reflection = Sound("Reflection_Shotgun.Inside")
		}
	}
}

SWEP.Firemodes = {
	[1] = {
		Name = "Bolt-Action",
		OnSet = function(self)
			self.Primary.Automatic = false

			return "Firemode_Semi"
		end
	},
}

SWEP.BarrelSmoke = {
	Particle = "AC_muzzle_pistol_smoke_barrel",
	Attachment = "muzzle",
	ShotTemperatureIncrease = 75,
	TemperatureThreshold = 100, --temperature that triggers smoke
	TemperatureCooldown = 65
}

SWEP.Cone = {
	Hip = 1, --accuracy while hip
	TacStance = 0.2, --accuracy in tac-stance
	Shake = 0.25,
	Ads = 0, --accuracy while aiming
	Increase = 0.1, --increase cone size by this amount every time we shoot
	TacStanceMultiplier = 1, --multiply the increase value by this while in tac-stance
	AdsMultiplier = 0, --multiply the increase value by this amount while aiming
	Max = 2.5,
}

SWEP.Recoil = {
	Vertical = {7, 10}, --random value between the 2
	Horizontal = {-1.75, 2.75}, --random value between the 2
	Shake = 3, --camera shake
	AdsMultiplier = 0.05, --multiply the values by this amount while aiming
	Seed = 3584,
}

SWEP.Bullet = {
	Damage = {102, 85}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 250, --in meters, damage scales within this distance
	DropOffStartRange = 30,
	Range = 300, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1.25, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 2,
	Penetration = {
		DamageMultiplier = 0.85, --how much damaged is multipled by when leaving a surface.
		MaxCount = 6, --how many times the bullet can penetrate.
		Thickness = 25,
	}
}

SWEP.Zoom = {
	IdleSway = 0.2,
	FovMultiplier = 0.95,
	ViewModelFovMultiplier = 1,
	Blur = {
		EyeFocusDistance = 10
	}
}

SWEP.WorldModelOffsets = {
	Bone = "tag_sling",
	Angles = Angle(15, 0, -180),
	Pos = Vector(9, -1, -1.5)
}

SWEP.ViewBoneOffsets = {
	{
		Bone = "tag_holo",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	{
		Bone = "tag_reflex",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	{
		Bone = "tag_acog_2",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	{
		Bone = "tag_scope",
		Angles = Angle(0, 0, 0),
		Pos = Vector(5.5, 0, -0.1)
	},
	{
		Bone = "j_follower",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 1.1)
	}
}

SWEP.WorldBoneOffsets = table.Copy(SWEP.ViewBoneOffsets)

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(-0.1, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	TacStance = {
		Angles = Angle(-0.3, 0.05, -45),
		Pos = Vector(-2, 2, -1)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 0)
	},
	Inspection = {
		Bone = "tag_sling",
		X = {
			[0] = {
				Pos = Vector(0, 3, 3),
				Angles = Angle(40, 0, -30)
			},
			[1] = {
				Pos = Vector(0, 0, 0),
				Angles = Angle(-10, 0, 0)
			}
		},
		Y = {
			[0] = {
				Pos = Vector(0, 0, 0),
				Angles = Angle(-10, 20, 0)
			},
			[1] = {
				Pos = Vector(4, 0, 1.5),
				Angles = Angle(10, -20, 0)
			}
		}
	},
	RecoilMultiplier = 1,
	KickMultiplier = 1,
	AimKickMultiplier = 0.75
}

SWEP.Shell = "mwb_shelleject_7625x"