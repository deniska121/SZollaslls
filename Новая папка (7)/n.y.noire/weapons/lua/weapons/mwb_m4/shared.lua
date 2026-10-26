--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_m4/shared.lua
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
	killicon.Add("mg_mike4", "VGUI/entities/mg_mike4", Color(255, 0, 0, 255))
	SWEP.WepSelectIcon = surface.GetTextureID("VGUI/spawnicons/icon_cac_weapon_ar_mike4")
end

SWEP.Base = "mg_base"

SWEP.GripPoseParameters = {"grip_gripvert_offset", "grip_gripvertpro_offset", "grip_barshort_gripang_offset", "grip_barshort_gripvert_offset", "grip_gripang_offset", "grip_barlong_gripvert_offset", "grip_barlong_gripang_offset", "grip_m203_offset", "grip_m203_gripvert_offset", "grip_m203_gripang_offset"}

SWEP.UseMags = {
	["stanag_20"] = {1, 6},
	["stanag_30"] = {1, 7},
	["stanag_50"] = {1, 3},
	["stanag_60"] = {1, 4},
	["stanag_30c"] = {1, 2}
}

SWEP.ShellsId = "cases556"
SWEP.AmmoId = "box556"

SWEP.Unloader = {
	["mag_remove"] = 1,
	["skip_cycle"] = 0,
	["anim"] = "Reload_Empty",
	["anim_swap"] = "Equip",
	["load_cycle"] = 0.3,
}

SWEP.MalfunctionAnimation = {
	["skip_cycle"] = 0,
	["anim"] = "Equip",
	["next"] = 1,
}

SWEP.PrintName = "Colt AR-15 Sporter"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Assault Rifles"
SWEP.Spawnable = true
SWEP.VModel = Model("models/viper/mw/weapons/v_mike4.mdl")
SWEP.WorldModel = Model("models/viper/mw/weapons/w_mike4.mdl")
SWEP.Resource = .0019

SWEP.Trigger = {
	PressedSound = Sound("mw19.mike4.fire.first"),
	ReleasedSound = Sound("mw19.mike4.fire.disconnector"),
	Time = 0.025
}
SWEP.DistSound = "Reflection_AR.Distance"
SWEP.Slot = 3
SWEP.HoldType = "Rifle"
SWEP.AlternateGrips = false
SWEP.Primary.Sound = Sound("mw19.mike4.fire")
SWEP.Primary.Ammo = "Ar2"
SWEP.Primary.ClipSize = 30
SWEP.Primary.Automatic = false
SWEP.Primary.BurstRounds = 1
SWEP.Primary.BurstDelay = 0
SWEP.Primary.RPM = 810
SWEP.CanChamberRound = true

-- SWEP.Primary.Automatic = true
-- SWEP.Primary.BurstRounds = 1
-- SWEP.Primary.BurstDelay = 0
-- SWEP.Primary.RPM = 810

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
			Layer = Sound("Atmo_AR2.Outside"),
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
		Name = "Semi Auto",
		OnSet = function(self)
			self.Primary.Automatic = false

			--self.Primary.RPM = 450
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
	Hip = 0.3, --accuracy while hip
	Ads = 0.07, --accuracy while aiming
	Shake = 0.3,
	Increase = 0.07, --increase cone size by this amount every time we shoot
	AdsMultiplier = 1, --multiply the increase value by this amount while aiming
	Max = 1.4, --the cone size will not go beyond this size
	Decrease = 0.3, -- amount (in seconds) for the cone to completely reset (from max)
	Seed = 3265187 --just give this a random number
}

SWEP.Recoil = {
	Vertical = {0.8, 1.2}, --random value between the 2
	Horizontal = {-1.3, 1.3}, --random value between the 2
	Shake = 1, --camera shake
	AdsMultiplier = 1, --multiply the values by this amount while aiming
	Seed = 2548715, --give this a random number until you like the current recoil pattern
	ViewModelMultiplier = 1
}

SWEP.Bullet = {
	Damage = {55, 23}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	DropOffStartRange = 50, --in meters, damage will start dropping off after this range
	EffectiveRange = 120, --in meters, damage scales within this distance
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
		EyeFocusDistance = 6.5
	}
}

SWEP.WorldModelOffsets = {
	Bone = "tag_sling",
	Angles = Angle(0, 95, -90),
	Pos = Vector(3, -5, -3.5)
}

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 5, 0)
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
	RecoilMultiplier = 0.4,
	KickMultiplier = 1,
	AimKickMultiplier = 1
}


-- SWEP.ViewModelBoneMods = {
-- 	["tag_scope"] = { scale = Vector(1, 1, 1), pos = Vector(1, 1, 1.62), angle = Angle(0, 0, 0) }
-- }

SWEP.ViewBoneOffsets = {
	{
		Bone = "tag_holo",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 1.98)
	},
	{
		Bone = "tag_reflex",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 1.98)
	},
	{
		Bone = "tag_acog_2",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0, 0, 1.98)
	},
}

SWEP.WorldBoneOffsets = table.Copy(SWEP.ViewBoneOffsets)

SWEP.Shell = "mwb_shelleject_556"
DEFINE_BASECLASS("mg_base")
SWEP.bEnableMagPoseParam = true

function SWEP:PostDrawViewModel(vm, weapon, ply)
	BaseClass.PostDrawViewModel(self, vm, weapon, ply)

	if (self.bEnableMagPoseParam) then
		self:UpdateMagPoseParam(1 - self:Clip1() / self:GetMaxClip1())
	end
end

function SWEP:AllowRuntimeMagPoseParam(allow)
	self.bEnableMagPoseParam = allow
end

function SWEP:UpdateMagPoseParam(val)
	local mag = self:GetAttachmentInUseForSlot(4).m_Model

	if (IsValid(mag) and mag ~= nil) then
		mag:SetPoseParameter("bullets_offset", val)
	end
end