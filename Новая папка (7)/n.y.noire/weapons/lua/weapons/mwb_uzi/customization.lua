--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_uzi/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.uzulu.fire.s")

	self.Reverb = {
		RoomScale = 50000,
		Sounds = {
			Outside = {
				Layer = Sound("Atmo_SMG_Sup.Outside"),
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

function SWEP:doCalConversionStats()
	local bSup1 = self:HasAttachment("attachment_vm_silencer_east01")
	local bSup2 = self:HasAttachment("attachment_vm_silencer02")
	local bSup3 = self:HasAttachment("attachment_vm_silencer03")
	local bSup4 = self:HasAttachment("attachment_vm_silencer04")
	local bSup5 = self:HasAttachment("attachment_vm_sm_uzulu_suppressor")

	if (not bSup1 and not bSup2 and not bSup3 and not bSup4 and not bSup5) then
		self.Primary.Sound = Sound("mw19.uzulu.fire.9mm")
	end
end

SWEP.Customization = {
	{"att_ammo", "attachment_vm_sm_uzulu_mag", "attachment_vm_sm_uzulu_xmags", "attachment_vm_sm_uzulu_xmag2", "attachment_vm_sm_uzulu_magcalcust", "attachment_vm_sm_uzulu_magcalcust9mm"},
	{"attachment_vm_sm_uzulu_stock", "attachment_vm_sm_uzulu_stock_folded", "attachment_vm_sm_uzulu_stockh"},
	{"norail", "rail_mount_uzi"},
	{"attachment_vm_sm_uzulu_barrel", "attachment_vm_sm_uzulu_barshort", "attachment_vm_sm_uzulu_barmid", "attachment_vm_sm_uzulu_barlong", "attachment_vm_sm_uzulu_barcust"},
	{"att_muzzle", "att_vm_silencer04_pstl"},
	{"att_sight", "att_vm_minireddot01", "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
	{"attachment_vm_sm_uzulu_receiver"},
}


