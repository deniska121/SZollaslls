--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mpapa5/mags/attachment_vm_sm_mpapa5_mag_xmag2.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "10mm Auto 30-Round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mpapa5/attachment_vm_sm_mpapa5_mag_xmag2.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mpapa5/icon_attachment_sm_mpapa5_mag_xmag2.vmt")


local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon:doCalConversionStats()
    weapon.Animations.Reload = weapon.Animations.Reload
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty
    --[[weapon.Animations.Reload = weapon.Animations.Reload_Xmag
    weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Xmag]]
    weapon.Bullet.Damage[1] = weapon.Bullet.Damage[1] * 1.19
    weapon.Bullet.Damage[2] = weapon.Bullet.Damage[2] * 1.1
    weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.15
    weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.15
    weapon.Bullet.Range = weapon.Bullet.Range * 1.25
    weapon.Cone.Increase = weapon.Cone.Increase * 1.35
    weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 1.2
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.99
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.99
end