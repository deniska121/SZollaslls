--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/cpapa/mags/attachment_vm_pi_cpapa_loader_snake.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_ammo"
ATTACHMENT.Name = "Snake Shot"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_cpapa_loader_snake.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/cpapa/icon_attachment_pi_cpapa_loader_snake.vmt")
ATTACHMENT.ExcludedAttachments = {"att_perk_ricochet"}
ATTACHMENT.ShowOnWorldModel = false

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

    weapon.Bullet.NumBullets = 6
    weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.5
    weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.5
    weapon.Bullet.Range = weapon.Bullet.Range * 0.25
    weapon.Bullet.Ricochet = false
end