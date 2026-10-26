--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_glock21/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("MW19_GLOCK.Fire_S")
	self.Reverb.Sounds.Outside.Layer = Sound("Atmo_Pistol_Mag_Sup.Outside")
	self.Reverb.Sounds.Outside.Reflection = Sound("Reflection_ARSUP.Outside")
	self.Reverb.Sounds.Inside.Layer = Sound("Atmo_Pistol_Sup.Inside")
	self.Reverb.Sounds.Inside.Reflection = Sound("Reflection_ARSUP.Inside")
	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

SWEP.Customization = {
	{"att_ammo", "att_vm_pi_golf21_mag", "att_vm_pi_golf21_mag_v2", "att_vm_pi_golf21_mag_xmags", "att_vm_pi_golf21_mag_xxmags"},
	{"att_vm_pi_golf21_receiver_v1", "att_vm_pi_golf21_slide_long"},
	{"att_laser", "att_vm_laser01_pstl", "att_vm_laser03_pstl"}
}