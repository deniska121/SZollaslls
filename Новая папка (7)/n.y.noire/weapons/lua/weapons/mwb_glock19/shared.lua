--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_glock19/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mwb_glock17"
SWEP.PrintName = "Glock 19"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Pistols"

SWEP.Customization = {
	{"att_ammo", "att_vm_pi_golf17_mag", "att_vm_pi_golf17_mag_xmags", "att_vm_pi_golf17_mag_xmagslrg"},
	{"att_vm_pi_golf18_slide_light", "att_vm_pi_golf18_slide", "null"},
	{"att_laser", "att_vm_laser01_pstl", "att_vm_laser03_pstl"},
	{"att_vm_pi_golf18def"},
	{"att_miscellaneous", "att_reargrip_golf"},
	{"att_muzzle", "null"},
}

SWEP.ViewBoneOffsets = {
	{
		Bone = "tag_mag_attach",
		Angles = Angle(0, 0, 0),
		Pos = Vector(-0.3, 0, 0)
	},
	{
		Bone = "tag_laser_attach",
		Angles = Angle(0, 0, 0),
		Pos = Vector(-0.5, 0, 0.1)
	},
	{
		Bone = "j_ammo_07",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0.3, 0, 0)
	}
}

SWEP.WorldBoneOffsets = {
	{
		Bone = "tag_laser_attach",
		Angles = Angle(0, 0, 180),
		Pos = Vector(-0.5, 0, 0.1)
	},
	{
		Bone = "tag_reflex",
		Angles = Angle(180, 90, 0),
		Pos = Vector(-5.3, 9.2, -64.1),
		OnlyWM = true
	},
	{
		Bone = "tag_mag_attach",
		Angles = Angle(0, 0, 0),
		Pos = Vector(-0.3, 0, 0)
	},
	{
		Bone = "j_ammo_07",
		Angles = Angle(0, 0, 0),
		Pos = Vector(0.5, 0, 0)
	}
}

SWEP.Animations = SWEP.Animations or {}

SWEP.Animations["Draw"] = {
	Sequences = {"draw"},
	Length = 0.3,
	Fps = 16,
	NextSequence = "Idle",
	Events = {
		{
			Time = 0,
			Callback = function(self) end
		}
	}
}