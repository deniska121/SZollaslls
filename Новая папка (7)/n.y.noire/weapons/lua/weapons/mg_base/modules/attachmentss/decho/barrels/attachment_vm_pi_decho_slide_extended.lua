--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/decho/barrels/attachment_vm_pi_decho_slide_extended.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_decho_slide_extended.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/decho/icon_attachment_pi_decho_slide_extended.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
ATTACHMENT.UseJunk = "parts_deagle"
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.5
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.85
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.85
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.85
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.85
	weapon.DontHide = true
end