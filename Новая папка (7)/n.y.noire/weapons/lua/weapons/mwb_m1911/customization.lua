--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_m1911/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("MW19_M1911.Fire_S")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_Pistol_Mag_Sup.Outside"),
				Reflection = Sound("Reflection_ARSUP.Outside")
			},
			Inside = {
				Layer = Sound("Atmo_Pistol_Sup.Inside"),
				Reflection = Sound("Reflection_ARSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

SWEP.Customization = {
	{"att_ammo", "attachment_vm_pi_mike1911_v1_mag", "sw4506_mag"},
	{"attachment_vm_pi_mike1911_v21_receiver", "sw4506_receiver"},
	{"attachment_vm_pi_mike1911_v1_slide", "sw4506_slide"},
	{"att_muzzle", "att_vm_silencer02_pstl"},
}