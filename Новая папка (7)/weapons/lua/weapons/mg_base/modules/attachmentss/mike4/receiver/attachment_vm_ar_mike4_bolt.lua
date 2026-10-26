-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\receiver\\attachment_vm_ar_mike4_bolt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_bolt"
ATTACHMENT.Name = "УСМ М4 (автомат)"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/perks/perk_icon_hipaim.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	weapon.Primary.Automatic = true
	weapon.Firemodes = {
		[1] = {
			Name = "Full Auto",
			OnSet = function() return "Firemode_Auto" end
		},
		[2] = {
			Name = "Semi Auto",
			OnSet = function(s)
				s.Primary.Automatic = false
				return "Firemode_Semi"
			end
		},
	}

	if weapon:HasAttachment("attachment_vm_ar_mike4_barrel") then
		weapon.PrintName = "M16A1"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_mike203barrel") or weapon:HasAttachment("attachment_vm_ar_mike4_barsil") then
		weapon.PrintName = "M16A2"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_custombarrel") then
		weapon.PrintName = "M16A3"
		if weapon:HasAttachment("attachment_vm_ar_mike4_receiver") then
			weapon.PrintName = "M16A4"
		end
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_barrel_v2") then
		weapon.PrintName = "Colt M4A1 RIS"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_shortbarrel") then
		weapon.PrintName = "Mk 18 Mod 0"
		if weapon:HasAttachment("attachment_vm_ar_mike4_receiver") then
			weapon.PrintName = "Mk 18 Mod 1"
		end
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_barrel_v3_alt") then
		weapon.PrintName = "XM177E2"
	else
		weapon.PrintName = "Colt M4A1"
	end
end