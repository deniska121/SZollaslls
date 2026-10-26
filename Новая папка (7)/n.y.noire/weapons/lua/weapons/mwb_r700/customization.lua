--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_r700/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("weap_romeo700_sup_plr")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_DMR_Sup.Outside"),
				Reflection = Sound("Reflection_Sniper.Outside")
			},
			Inside = {
				Layer = Sound("Atmo_DMR_Sup.Inside"),
				Reflection = Sound("Reflection_Sniper.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "mwb_suppressor_0"
end

SWEP.Customization = {
	{"att_ammo", "romeo700_mag"},
	{"romeo700_stock"},
	{"romeo700_bolt"},
	{"att_sight", "weapon_vm_scope_kilo98", "romeo700_scope"},
}