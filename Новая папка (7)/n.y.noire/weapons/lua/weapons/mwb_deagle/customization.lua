--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_deagle/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("MW19_Deagle.Fire_S")

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
	{"att_ammo", "attachment_vm_pi_decho_mag", "attachment_vm_pi_decho_xmags", "attachment_vm_pi_decho_xmags2"},
	{"attachment_vm_pi_decho_grip", "attachment_vm_pi_decho_cust_grip"},
	{"att_muzzle", "attachment_vm_pi_decho_muzzlebrake"},
	{"att_sight", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision", "att_vm_minireddot01", "att_vm_reflex_east01", "att_vm_holo_east01", "att_vm_holo_west01", "att_vm_reflex_west02"},
	{"attachment_vm_pi_decho_slide", "attachment_vm_pi_decho_slide_extended", "attachment_vm_pi_decho_slide_extended02"},
	{"att_laser", "att_vm_pi_decho_laser01", "att_vm_pi_decho_laser03"}
}