--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_ithaca.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "mwb_m590"
SWEP.PrintName = "Ithaca 37"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Shotguns"
SWEP.NoUserAttachs = true
SWEP.Primary.Automatic = true
SWEP.Customization = {
	{"attachment_vm_sh_pump_pump", "nulp", "nulp1", "nulp2", "nulp3"},
	{"attachment_vm_sh_pump_receiver_norail"},
	{"attachment_vm_sh_pump_barrel", "nulb", "nulb1", "nulb2", "nulb3", "nulb4", "nulb5", "nulb6", "nulb7"},
	{"att_stock", "nil", "nil2"},
	{"590_base", "null"},
}

SWEP.Firemodes = {
	[1] = {
		Name = "Pump-Action",
		OnSet = function(self)
			self.Primary.Automatic = true
			self.Animations.Rechamber.Length = 0.3
			return "Firemode_Semi"
		end
	},
}

SWEP.Bullet = {
	Damage = {300, 30}, --first value is damage at 0 meters from impact, second value is damage at furthest point in effective range
	EffectiveRange = 12, --in meters, damage scales within this distance
	Range = 30, --in meters, after this distance the bullet stops existing
	Spread = 0.05,
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

SWEP.ViewModelOffsets = {
	Aim = {
		Angles = Angle(0, 0, -10),
		Pos = Vector(0, 3, 0.6)
	},
	Idle = {
		Angles = Angle(0, 0, 0),
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

SWEP.UseMags = nil