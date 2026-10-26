-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike4\\receiver\\ar15_bolt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_bolt"
ATTACHMENT.Name = "УСМ"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	if weapon:HasAttachment("attachment_vm_ar_mike4_barrel") then
		weapon.PrintName = "Colt AR-15 Sporter-1"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_mike203barrel") or weapon:HasAttachment("attachment_vm_ar_mike4_barsil") then
		weapon.PrintName = "Colt AR-15 Sporter-2"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_custombarrel") then
		weapon.PrintName = "Colt AR-15 Sporter-3"
		if weapon:HasAttachment("attachment_vm_ar_mike4_receiver") then
			weapon.PrintName = "Colt AR-15 Sporter-4"
		end
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_barrel_v2") then
		weapon.PrintName = "Colt AR-15 Sporter Carbine"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_shortbarrel") then
		weapon.PrintName = "Colt Model 933"
	elseif weapon:HasAttachment("attachment_vm_ar_mike4_barrel_v3_alt") then
		weapon.PrintName = "CAR-15"
	else
		weapon.PrintName = "Colt Model 723"
	end
end