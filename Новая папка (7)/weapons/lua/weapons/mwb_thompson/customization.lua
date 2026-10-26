-- "addons\\weapons\\lua\\weapons\\mwb_thompson\\customization.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:doSuppressorStats()
end

function SWEP:doCalConversionStats()
	local bSup1 = self:HasAttachment("attachment_vm_silencer_east01")
	local bSup2 = self:HasAttachment("attachment_vm_silencer02")
	local bSup3 = self:HasAttachment("attachment_vm_silencer03")
	local bSup4 = self:HasAttachment("attachment_vm_silencer04")

	if (not bSup1 and not bSup2 and not bSup3 and not bSup4 and not bSup5 and not bSup6) then
		self.Primary.Sound = Sound("weap_mpapa5_sup_fire_plr_lfe")

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
	{"att_ammo", "vm_thotel_mag_00", "vm_thotel_mag_f_00"},
	{"vm_thotel_stock_00", "vm_thotel_stock_hv_00"},
	{"vm_thotel_fg_00", "vm_sm_thotel_angled_00"},
	{"vm_thotel_barrel_00", "vm_thotel_barrel_l_00"},
	{"vm_thotel_irons_s_00"},
}