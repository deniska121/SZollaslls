--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/grips/att_vm_vertgrip01.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_grip"
ATTACHMENT.Name = "Вертикальная рукоятка"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_vertgrip02_lod0.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/grips/icon_attachment_vertgrip02.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.98
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.98
    weapon.Recoil.Vertical[1] = self:ChangeRecoil(weapon.Recoil.Vertical[1], 0.95)
    weapon.Recoil.Vertical[2] = self:ChangeRecoil(weapon.Recoil.Vertical[2], 0.95)
    weapon.HoldType = "RifleWithVerticalGrip"
end