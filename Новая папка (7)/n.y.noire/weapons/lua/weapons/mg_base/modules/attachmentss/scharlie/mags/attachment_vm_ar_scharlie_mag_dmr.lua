--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/scharlie/mags/attachment_vm_ar_scharlie_mag_dmr.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "10 round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_mag_dmr.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/scharlie/icon_attachment_ar_scharlie_mag_dmr.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Primary.ClipSize = 10

    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.07
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.07
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1

    weapon.Animations.Reload = weapon.Animations.Reload_DMR
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_DMR

    weapon.Animations.Reload.Fps = weapon.Animations.Reload.Fps * 1.1
    weapon.Animations.Reload_Empty.Fps = weapon.Animations.Reload_Empty.Fps * 1.1
end