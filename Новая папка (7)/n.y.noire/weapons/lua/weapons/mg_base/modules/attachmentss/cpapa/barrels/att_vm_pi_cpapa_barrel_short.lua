--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/cpapa/barrels/att_vm_pi_cpapa_barrel_short.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_cpapa_shortbarrel.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/cpapa/icon_attachment_pi_cpapa_shortbarrel.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.1
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.13
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.13
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.9
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
	weapon.Bullet.Penetration.MaxCount = 3
end