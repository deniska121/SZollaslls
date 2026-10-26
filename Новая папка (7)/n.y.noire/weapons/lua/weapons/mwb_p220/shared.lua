--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_p220/shared.lua
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
	killicon.Add("mg_vm_pl_papa220", "VGUI/entities/mg_vm_pl_papa220", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/entities/mg_p220_icon")
end

SWEP.Base = "mg_base"
SWEP.PrintName = "P220"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Pistols"
SWEP.Spawnable = true
SWEP.VModel = Model("models/kyo/v_papa220.mdl")
SWEP.WorldModel = Model("models/kyo/w_papa220.mdl")
SWEP.NoMagCheck = "Equip"
SWEP.ShellsId = "cases10"
SWEP.AmmoId = "box10"

SWEP.UseMags = {
	["p220_8"] = {1, 2},
}

SWEP.Unloader = {
	["mag_remove"] = 0.85,
	["skip_cycle"] = 0,
	["anim"] = "Reload",
	["anim_swap"] = "Equip",
	["load_cycle"] = 0.3,
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0,
	["anim"] = "Equip",
	["next"] = 1,
}

SWEP.Trigger = {
	PressedSound = Sound("weap_papa320_fire_first"),
	ReleasedSound = Sound("p27_pi_papa220_fire_disconnector"),
	Time = 0.015
}

SWEP.Slot = 2
SWEP.Resource = .0035
SWEP.HoldType = "Pistol"

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_pistol",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
}

SWEP.Primary.Sound = Sound("p27_pi_papa220_fire_plr")
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 8
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
			Layer = Sound("p27_pi_papa220_fire_atmo_out"),
			Reflection = Sound("Reflection_Pistol.Outside")
		},
		Inside = {
			Layer = Sound("p27_pi_papa220_fire_atmo_in"),
			Reflection = Sound("Reflection_Pistol.Inside")
		}
	}
}

SWEP.Firemodes = {
	[1] = {
		Name = "Semi Auto",
		OnSet = function() return nil end
	}
}

SWEP.BarrelSmoke = {
	Particle = "AC_muzzle_pistol_smoke_barrel",
	Attachment = "muzzle",
	ShotTemperatureIncrease = 20,
	TemperatureThreshold = 100, --temperature that triggers smoke
	TemperatureCooldown = 40 --degrees per second
}

SWEP.Cone = {
	Hip = 0.15, --accuracy while hip
	Ads = 0.13, --accuracy while aiming
	Increase = 0.06, --increase cone size by this amount every time we shoot
	AdsMultiplier = 0.14, --multiply the increase value by this amount while aiming
	Max = 1.16, --the cone size will not go beyond this size
	Decrease = 0.54, -- amount (in seconds) for the cone to completely reset (from max)
		Shake = 1.1,
	Seed = 85327 --just give this a random number 
}

SWEP.Recoil = {
	Vertical = {0.8, 1.3}, --random value between the 2
	Horizontal = {-1.26, 1.33}, --random value between the 2
	Shake = 2.7, --camera shake
	AdsMultiplier = 1, --multiply the values by this amount while aiming
	Seed = 610312 --give this a random number until you like the current recoil pattern
}

SWEP.Bullet = {
	Damage = {38, 9}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	DropOffStartRange = 13,
	EffectiveRange = 20, --in meters, damage scales within this distance
	Range = 100, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.6, --how much damaged is multipled by when leaving a surface.
		MaxCount = 3, --how many times the bullet can penetrate.
		Thickness = 7, --in hu, how thick an obstacle has to be to stop the bullet.
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
	Angles = Angle(0, -90, 180),
	Pos = Vector(3, 9.5, -4)
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
	Sprint = {
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
				Pos = Vector(-1, 0, 0),
				Angles = Angle(-10, -30, 0)
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