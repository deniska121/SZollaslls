--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_mac10/shared.lua
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

sound.Add({
	name = "bb5",
	channel = CHAN_WPNFOLEY + 2,
	volume = 1,
	sound = {"viper/weapons/uzulu/wfoly_plr_sm_uzulu_reload_empty_xmag_magout_01.ogg"}
})

SWEP.UseMags = {
	["mac_30"] = {1, 2},
}

SWEP.Unloader = {
	["mag_remove"] = 1.2,
	["skip_cycle"] = 0.8,
	["anim"] = "Reload_Empty",
	["load_cycle"] = 0.2,
}

SWEP.ShellsId = "cases45"
SWEP.AmmoId = "box45"

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0.6,
	["anim"] = "Reload_Empty",
	["next"] = 1,
}

if CLIENT then
	killicon.Add("mg_mac10_mw19", "VGUI/entities/mg_mac10_mw19", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/mg_mac10_mw19")
	MAC10_LangLib_FireMode_Full_Auto = language.GetPhrase("#MAC10_LangLib_FireMode.Full_Auto")
end

SWEP.Base = "mg_base"

SWEP.GripPoseParameters = {"grip_ang_offset", "grip_vert_offset"}

SWEP.PrintName = "MAC-10"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Submachine Guns"
SWEP.Spawnable = true
SWEP.VModel = Model("models/mac10_mw19_ver.mdl")
SWEP.WorldModel = Model("models/viper/mw/weapons/w_mac10.mdl")
SWEP.Slot = 3
SWEP.HoldType = "Pistol"

SWEP.Trigger = {
	PressedSound = Sound("mw19.uzulu.prefire"),
	ReleasedSound = Sound("mw19.uzulu.disconnector"),
	Time = 0.1
}

SWEP.Primary.Sound = Sound("weap_uzulu_fire_plr")
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = true
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 1090
SWEP.CanChamberRound = false
SWEP.Resource = .002

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
			Layer = Sound("Atmo_SMG.Outside"),
			Reflection = Sound("Reflection_Pistol.Outside")
		},
		Inside = {
			Layer = Sound("Atmo_SMG.Inside"),
			Reflection = Sound("Reflection_Pistol.Inside")
		}
	}
}

SWEP.Firemodes = {
	[1] = {
		Name = MAC10_LangLib_FireMode_Full_Auto,
		OnSet = function() return "Firemode_Auto" end
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
	Ads = 0.1, --accuracy while aiming
	Shake = 0.6,
	Increase = 0.02, --increase cone size by this amount every time we shoot
	AdsMultiplier = 1, --multiply the increase value by this amount while aiming
	Max = 2, --the cone size will not go beyond this size
	Decrease = 0.75, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 6215 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {0.5, 0.75}, --random value between the 2
	Horizontal = {-1, 1}, --random value between the 2
	Shake = 0.7, --camera shake
	AdsMultiplier = 1, --multiply the values by this amount while aiming
	Seed = 66666, --give this a random number until you like the current recoil pattern
	ViewModelMultiplier = 1.3
}

SWEP.Bullet = {
	Damage = {41, 9}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 18, --in meters, damage scales within this distance
	DropOffStartRange = 9,
	Range = 85, --in meters, after this distance the bullet stops existing
	Tracer = false, --show tracer
	NumBullets = 1, --the amount of bullets to fire
	PhysicsMultiplier = 1, --damage is multiplied by this amount when pushing objects
	HeadshotMultiplier = 1,
	Penetration = {
		DamageMultiplier = 0.6, --how much damaged is multipled by when leaving a surface.
		MaxCount = 2, --how many times the bullet can penetrate.
		Thickness = 7, --in hu, how thick an obstacle has to be to stop the bullet.
	}
}

SWEP.Zoom = {
	FovMultiplier = 0.95,
	ViewModelFovMultiplier = 0.9,
	Blur = {
		EyeFocusDistance = 7.5
	}
}

SWEP.WMRotate = Angle(0,0,-90)

SWEP.applyonwmd = true

SWEP.WMDBonelOffsets = {
	Bone = "ValveBiped.Anim_Attachment_RH",
	Angles = Angle(0,-90,0),
	Pos = Vector(-2,0,0)
}
SWEP.WorldModelOffsets = {
	Bone = "tag_sling",
	Angles = Angle(0, 0, 0),
	Pos = Vector(2, 0, 0)
}

SWEP.HolsterDataBack = {"ValveBiped.Bip01_Spine2", Vector(6, 3.7, -2), Angle(0, 0, -90)}
SWEP.HolsterDataLow = {"ValveBiped.Bip01_R_Thigh", Vector(3, -1, -4.1), Angle(60, 0, -90)}

SWEP.HolsterData = table.Copy(SWEP.HolsterDataBack)

SWEP.DontHide = true
SWEP.SlotType = 1

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 3, 0.13)
	},
	Idle = {
		Angles = Angle(0, 0, -6),
		Pos = Vector(0.5, 2, -0.4)
	},
	Sprint = {
		Angles = Angle(0, 0, -0),
		Pos = Vector(1.75, 0, -0)
	},
	Inspection = {
		Bone = "tag_sling",
		X = {
			[0] = {
				Pos = Vector(0, 4, 0),
				Angles = Angle(30, 0, -30)
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
				Pos = Vector(0, 0, 0),
				Angles = Angle(10, -20, 0)
			}
		}
	},
	RecoilMultiplier = 0.4,
	KickMultiplier = 1,
	AimKickMultiplier = 3
}

SWEP.Shell = "mwb_shelleject_9mm"
DEFINE_BASECLASS("mg_base")