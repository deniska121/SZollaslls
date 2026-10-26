-- "addons\\weapons\\lua\\weapons\\mwb_tec9\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
PrecacheParticleSystem("AC_muzzle_pistol")
PrecacheParticleSystem("AC_muzzle_pistol_suppressed")
PrecacheParticleSystem("AC_muzzle_pistol_ejection")
PrecacheParticleSystem("AC_muzzle_pistol_smoke_barrel")
include("animations.lua")
include("customization.lua")

if CLIENT then
	killicon.Add("mg_tec9", "VGUI/entities/mg_tec9", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_pi_tec9")
end

SWEP.Base = "mg_base"
SWEP.PrintName = "Tec-9"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Pistols"
SWEP.Spawnable = true
SWEP.DontHide = true
SWEP.VModel = Model("models/weapons/cs2/tec9/v_tec9.mdl")
SWEP.WorldModel = Model("models/weapons/cs2/tec9/w_tec9.mdl")

SWEP.Trigger = {
	PressedSound = Sound(""),
	ReleasedSound = Sound(""),
	Time = 0.025
}

SWEP.Slot = 2
SWEP.HoldType = "TinyGun2"

SWEP.ParticleEffects = {
	["MuzzleFlash"] = "AC_muzzle_pistol",
	["MuzzleFlash_Suppressed"] = "AC_muzzle_pistol_suppressed",
	["Ejection"] = "AC_muzzle_pistol_ejection",
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0,
	["anim"] = "Equip",
	["next"] = 1,
}

SWEP.Primary.Sound = Sound("CS2_Tec9_Fire")
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.ClipSize = 32
SWEP.Primary.Automatic = false
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 600
SWEP.CanChamberRound = false
SWEP.Resource = .002

SWEP.ShellsId = "cases9"
SWEP.AmmoId = "box919"

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

SWEP.UseMags = {
	["tec_32"] = {1, 2}
}

SWEP.Unloader = {
	["mag_remove"] = 1.1,
	["skip_cycle"] = 0,
	["anim"] = "Reload",
	["anim_swap"] = "Equip",
	["load_cycle"] = 0.22,
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
	Hip = 0.25, --accuracy while hip
	Ads = 0.4, --accuracy while aiming
	Increase = 0.1, --increase cone size by this amount every time we shoot
	Shake = 1.1,
	AdsMultiplier = 0.14, --multiply the increase value by this amount while aiming
	Max = 1.16, --the cone size will not go beyond this size
	Decrease = 0.54, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 85327 --just give this a random number 
}

SWEP.Recoil = {
	Vertical = {0.83, 1.14}, --random value between the 2
	Horizontal = {-0.167, 0.98}, --random value between the 2
	Shake = 1.36, --camera shake
	AdsMultiplier = 1, --multiply the values by this amount while aiming
	Seed = 7512335 --give this a random number until you like the current recoil pattern
}

SWEP.Bullet = {
	Damage = {32, 8}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 30, --in meters, damage scales within this distance
	DropOffStartRange = 19, --in meters, damage scales within this distance
	Range = 120, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.75, --how much damaged is multipled by when leaving a surface.
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
	Bone = "tag_sling",
	Angles = Angle(0, 90, -90),
	Pos = Vector(1, -4, -3.5)
}

SWEP.WorldBoneOffsets = {
	{
		Bone = "j_mag1",
		Angles = Angle(-10, 0, 0),
		Pos = Vector(-0.5, 0, -2.194)
	},
	{
		Bone = "j_mag2",
		Angles = Angle(-10, 0, 0),
		Pos = Vector(-0.5, 0, -2.194)
	}
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(-0.090, -0.190, 0),
		Pos = Vector(-0.040, 7, 0.340)
	},
	Idle = {
		Angles = Angle(-2, 1, 6),
		Pos = Vector(0, 2, -0.4)
	},
	Sprint = {
		Angles = Angle(0, 30, 30),
		Pos = Vector(10, -5, 1)
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