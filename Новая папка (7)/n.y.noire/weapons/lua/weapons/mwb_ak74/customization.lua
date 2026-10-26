--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_ak74/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.akilo47.fire.suppressed")
	self.DistSound = "Reflection_AR.Sup.Distance"
	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_AR_Sup.Outside"),
				Reflection = Sound("Reflection_ARSUP.Outside")
			},
			Inside = {
				Layer = Sound("Atmo_AR_Sup.Inside"),
				Reflection = Sound("Reflection_ARSUP.Inside")
			}
		}
	}

	self.ParticleEffects.MuzzleFlash = "AC_muzzle_pistol_suppressed"
end

function SWEP:doSmgStats()
end

SWEP.Customization = {
	{"att_ammo", "attachment_vm_ar_akilo47_smgmag", "att_vm_45rnd_mag_eastern"},
	{"attachment_vm_ar_akilo74_stock", "attachment_vm_ar_akilo47_lmgstock", "attachment_vm_ar_akilo47_smgstock_unfolded", "attachment_vm_ar_akilo47_smgstock", "attachment_vm_ar_akilo47_stockno"},
	{"attachment_vm_ar_akilo74", "attachment_vm_ar_akilo47_custombarrel", "attachment_vm_ar_akilo47_lmgbarrel_grip", "attachment_vm_ar_akilo47_lmgbarrel", "attachment_vm_ar_akilo47_smgbarcust"},
	{"att_bolt", "attachment_vm_ar_akilo47_bolt"},
	{"attachment_vm_ar_akilo47_receiver_v6"},
	{"att_vm_muzzlebrake_ak74", "att_vm_silencer05",},
	{"norail", "rail_mount_ak"},
	{"att_sight", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
	{"att_grip", "attachment_vm_ar_akilo47_angledgrip01", "attachment_vm_ar_akilo47_stubbygrip01", "attachment_vm_ar_akilo47_vertgrip01", "attachment_vm_ar_akilo47_vertgrip03"},
}

--{"att_receiver", "attachment_vm_ar_akilo47_receiver_v2", "attachment_vm_ar_akilo47_receiver_v21", "attachment_vm_ar_akilo47_receiver_v12", "attachment_vm_ar_akilo47_receiver_v6"},