-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\mags\\attachment_vm_romeo870_sus.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Category = "Системы"
ATTACHMENT.Name = "Cock N bols"

function ATTACHMENT:PostProcess(weapon)
	weapon.UseINV = weapon.UseINV or weapon.UsedINV
	weapon.UsedINV = nil
	weapon.UseMags = nil
end 