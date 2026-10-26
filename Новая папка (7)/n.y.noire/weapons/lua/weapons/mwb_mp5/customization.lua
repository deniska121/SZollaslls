--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_mp5/customization.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:doSuppressorStats()
	self.Primary.Sound = Sound("mw19.mpapa5.fire.9mm.s")
	local bSup1 = self:HasAttachment("attachment_vm_silencer_east01")
	local bSup2 = self:HasAttachment("attachment_vm_silencer02")
	local bSup3 = self:HasAttachment("attachment_vm_silencer03")
	local bSup4 = self:HasAttachment("attachment_vm_silencer04")

	if (not bSup1 and not bSup2 and not bSup3 and not bSup4 and not bSup5 and not bSup6) then
		self.Primary.Sound = Sound("mw19.mpapa5.fire.s")
	end

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

	if (not bSup1 and not bSup2 and not bSup3 and not bSup4 and not bSup5 and not bSup6) then
		self.Primary.Sound = Sound("mw19.mpapa5.fire")

		self.Reverb = {
			RoomScale = 50000,
			Sounds = {
				Outside = {
					Layer = Sound("Atmo_AR.Outside"),
					Reflection = Sound("Reflection_AR.Outside")
				},
				Inside = {
					Layer = Sound("Atmo_AR.Inside"),
					Reflection = Sound("Reflection_AR.Inside")
				}
			}
		}

		self.Primary.Ammo = "AR2"
	end
end

SWEP.Customization = {
	{"att_ammo", "attachment_vm_sm_mpapa5_mag", "attachment_vm_sm_mpapa5_mag_xmag"},
	{"attachment_vm_sm_mpapa5_stock", "attachment_vm_sm_mpapa5_stock_fullstock", "attachment_vm_sm_mpapa5_stock_nostock"},
	{"attachment_vm_sm_mpapa5_receiver", "attachment_vm_sm_mpapa5_receiver_v2"},
	{"norail", "rail_mount_mp5"},
	{"attachment_vm_sm_mpapa5_barrel", "attachment_vm_sm_mpapa5_barrel_suppressor"},
	{"att_sight", "att_vm_minireddot01",  "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
}


