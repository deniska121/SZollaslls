--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/uzulu/mags/attachment_vm_sm_uzulu_magcalcust9mm.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "9x19mm 32-Round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/uzulu/attachment_vm_sm_uzulu_mag.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/uzulu/icon_attachment_sm_uzulu_mag.vmt")


local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
        weapon.Bullet.Damage[1] = weapon.Bullet.Damage[1] * 0.89
        weapon.Bullet.Damage[2] = weapon.Bullet.Damage[2] * 0.99
        weapon.Primary.ClipSize = 32
        weapon.Primary.RPM = 960
        weapon:doCalConversionStats()
end