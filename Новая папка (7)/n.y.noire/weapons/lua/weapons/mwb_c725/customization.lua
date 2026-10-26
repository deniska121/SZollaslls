--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_c725/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.charlie725.fire.s")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_Shotgun2.Outside"),
				Reflection = Sound("Reflection_ARSUP.Outside")
			},
			Inside = {
				Layer = Sound("Reflection_ARSUP.Inside"),
				Reflection = Sound("Reflection_ShotgunSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

function SWEP:doDBStats()
	self.Primary.TrailingSound = Sound("wpn_shotgun_fire_lyr")
	self.ParticleEffects.MuzzleFlash = "AC_muzzle_shotgun_db"
end

SWEP.Customization = {
	{"attachment_vm_sh_charlie725_barrel", "attachment_vm_sh_charlie725_barrel_sawnoff", "attachment_vm_sh_charlie725_barrel_mid", "attachment_vm_sh_charlie725_barrel_long"},
	{"attachment_vm_sh_charlie725_guard"},
	{"attachment_vm_sh_charlie725_stock", "attachment_vm_sh_charlie725_stocklight", "attachment_vm_sh_charlie725_stock_sawnoff", "attachment_vm_sh_charlie725_stocktactical"},
}