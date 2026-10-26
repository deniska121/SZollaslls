--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/police_m590.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "mwb_m590"
SWEP.PrintName = "Mossberg 590"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.IconOverride = "entities/weapon_m590.png"

SWEP.Customization = {
	{"590_eft_pump_590def", "590_eft_pump_590def", "590_eft_pump_870def", "590_eft_pump_590_wood", "590_mwii_pump_def", "590_mwii_pump_tac", "590_mwii_pump_lgt"},
	{"590_eft_pump_receiver"},
	{"590_eft_barrel", "590_eft_barrel_v1", "590_eft_barrel_v3", "590_eft_barrel_v4", "590_mwii_barrel_v1", "590_mwii_barrel_v2", "590_mwii_barrel_v3", "590_eft_barrel_fg", "590_eft_barrel_1897"},
	{"magpul_sga_stock", "magpul_sga_stock", "mwii_590_no_stock", "590_f1", "590_f1s"},
	{"590_no_rail", "590_base_iro", "590_no_rail"},
}