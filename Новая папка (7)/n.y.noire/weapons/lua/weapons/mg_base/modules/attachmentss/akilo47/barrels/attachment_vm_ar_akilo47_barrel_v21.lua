--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/akilo47/barrels/attachment_vm_ar_akilo47_barrel_v21.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "attachment_vm_ar_akilo47_lmgbarrel_grip"
ATTACHMENT.Name = "Резонанс"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_ar_akilo47_custombarrel_v21.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_custombarrel_akilo47_v21.vmt")

ATTACHMENT.CosmeticChange = true
ATTACHMENT.ExcludedCategories = {"Рукоятки"}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    -- weapon.PrintName = ""
    -- if (weapon:HasAttachment("attachment_vm_ar_akilo47_smgbarrel") || weapon:HasAttachment("attachment_vm_ar_akilo47_smgbarcust")) then 
    --     weapon.PrintName = "AKS-74U"
    -- end
    weapon.Customization[8][2] = "attachment_vm_ar_akilo47_laser01"
    weapon.Customization[8][3] = "attachment_vm_ar_akilo47_laser02"
    weapon.Customization[8][4] = "attachment_vm_ar_akilo47_laser03"
end