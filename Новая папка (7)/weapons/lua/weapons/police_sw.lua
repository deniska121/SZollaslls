-- "addons\\weapons\\lua\\weapons\\police_sw.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mwb_m1911"
SWEP.PrintName = "S&W 4506"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true

SWEP.Customization = {
	{"att_ammo", "sw4506_mag", "sw4506_mag"},
	{"sw4506_receiver", "none1"},
	{"sw4506_slide", "none2"},
	{"att_muzzle", "none3"},
}