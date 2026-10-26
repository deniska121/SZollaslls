-- "addons\\weapons\\lua\\weapons\\mwb_deagle\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
PrecacheParticleSystem("AC_muzzle_desert")
PrecacheParticleSystem("AC_muzzle_pistol_suppressed")
PrecacheParticleSystem("AC_muzzle_pistol_ejection")
PrecacheParticleSystem("AC_muzzle_pistol_smoke_barrel")
include("animations.lua")
include("customization.lua")

if CLIENT then
	killicon.Add("mg_deagle", "VGUI/entities/mg_deagle", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_pi_decho")
end

SWEP.Base = "mg_base"

SWEP.UseMags = {
	["deagle_7"] = {1, 2},
	["deagle_10"] = {1, 3},
	["deagle_13"] = {1, 4}
}

SWEP.ShellsId = "cases50"
SWEP.AmmoId = "box50"

SWEP.Unloader = {
	["mag_remove"] = 0.95,
	["skip_cycle"] = 0.5,
	["anim"] = "Reload",
	["anim_swap"] = "Reload_Empty",
	["load_cycle"] = 0.1,
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0.5,
	["anim"] = "Reload_Empty",
	["next"] = 1,
}

SWEP.PrintName = "Deagle .50"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Pistols"
SWEP.Spawnable = true
SWEP.VModel = Model("models/viper/mw/weapons/v_deagle.mdl")
SWEP.WorldModel = Model("models/viper/mw/weapons/w_deagle.mdl")
SWEP.Resource = .006
SWEP.DistSound = "Reflection_Shotgun.Distance"
SWEP.Trigger = {
	PressedSound = Sound("MW19_Deagle.Fire.First"),
	ReleasedSound = Sound("MW19_M1911.Fire.Disconnector"),
	Time = 0.05
}

SWEP.Slot = 2
SWEP.HoldType = "Pistol"
SWEP.Primary.Sound = Sound("MW19_DEAGLE.Fire")
SWEP.Primary.Ammo = "357"
SWEP.Primary.ClipSize = 7
SWEP.Primary.Automatic = false
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 200
SWEP.CanChamberRound = true

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_desert",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
}

SWEP.Reverb = {
	RoomScale = 50000, --(cubic hu)
	--how big should an area be before it is categorized as 'outside'?
	Sounds = {
		Outside = {
			Layer = Sound("Atmo_Pistol_Mag.Outside"),
			Reflection = Sound("Reflection_Pistol.Outside")
		},
		Inside = {
			Layer = Sound("Atmo_Shotgun.Inside"),
			Reflection = Sound("Reflection_Shotgun.Inside")
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
	ShotTemperatureIncrease = 10,
	TemperatureThreshold = 200, --temperature that triggers smoke
	TemperatureCooldown = 8 --degrees per second
}

SWEP.Cone = {
	Hip = 0.7, --accuracy while hip
	Ads = 0.5, --accuracy while aiming
	Shake = 1.3,
	Increase = 0.3, --increase cone size by this amount every time we shoot
	AdsMultiplier = 1, --multiply the increase value by this amount while aiming
	Max = 1.23, --the cone size will not go beyond this size
	Decrease = 0.6, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 54892 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {3, 7}, --random value between the 2
	Horizontal = {-1, 2}, --random value between the 2
	Shake = 3.5, --camera shake
	AdsMultiplier = 1, --multiply the values by this amount while aiming
	Seed = 4445523 --give this a random number until you like the current recoil pattern
}

SWEP.Bullet = {
	Damage = {110, 35}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 20, --in meters, damage scales within this distance
	DropOffStartRange = 10, --in meters, damage scales within this distance
	Range = 75, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1.5, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.875, --how much damaged is multipled by when leaving a surface.
		MaxCount = 6, --how many times the bullet can penetrate.
		Thickness = 16, --in hu, how thick an obstacle has to be to stop the bullet.
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
	Pos = Vector(3, -3, -1.75)
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0.15, 0, 0)
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
	RecoilMultiplier = 5,
	KickMultiplier = 1.5
}

SWEP.Shell = "mwb_shelleject_50bmg"