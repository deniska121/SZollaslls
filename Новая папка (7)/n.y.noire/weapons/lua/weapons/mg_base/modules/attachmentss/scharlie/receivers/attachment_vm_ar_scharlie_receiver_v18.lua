--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/scharlie/receivers/attachment_vm_ar_scharlie_receiver_v18.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Гадюка"

ATTACHMENT.CosmeticChange = true
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_receiver_v18.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/scharlie/icon_attachment_ar_scharlie_receiver.vmt")
ATTACHMENT.Bodygroups = {
    ["receiver"] = 1
}
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    -- weapon.Animations.Reload = weapon.Animations.Reload_Railcrust
    -- weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Railcrust
    -- weapon.Animations.Reload_Fast = weapon.Animations.Reload_Fast_Railcrust
    -- weapon.Animations.Reload_Empty_Fast = weapon.Animations.Reload_Empty_Fast_Railcrust
    -- weapon.Animations.Equip = weapon.Animations.Equip_Railcrust
    -- weapon.ViewModelOffsets.Aim.Pos = weapon.ViewModelOffsets.Aim.Pos + Vector(0, 0, 1.65)
    -- weapon.ViewModelOffsets.Aim.Angles = weapon.ViewModelOffsets.Aim.Angles + Angle(0, 0, 0)
end