--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mike4/mags/attachment_vm_ar_mike4_calsmg.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "9mm Para 32-Round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mike4/attachment_vm_ar_mike4_calsmg.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike4/icon_attachment_ar_mike4_calsmg.vmt")

ATTACHMENT.Bodygroups = {
    ["ejection_cover"] = 1,
    ["tag_mag_show"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Primary.ClipSize = 32
    weapon.Animations.Reload = weapon.Animations.Reload_Calsmg
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Calsmg
    weapon.Bullet.Damage[1] = weapon.Bullet.Damage[1] * 0.7
    weapon.Bullet.Damage[2] = weapon.Bullet.Damage[2] * 0.8
    weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.6
    weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.6
    weapon.Primary.RPM = weapon.Primary.RPM * 1.25
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
    weapon.Cone.Increase = weapon.Cone.Increase * 0.5
    weapon:doCalConversionStats()
    weapon.PrintName = "Colt 9mm SMG"
end