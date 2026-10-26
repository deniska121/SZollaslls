--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/romeo870/barrels/attachment_vm_sh_romeo870_barrel_long.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол (300 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/romeo870/attachment_vm_sh_romeo870_barrel_long.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_barrel_long.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Cone.Hip =  weapon.Cone.Hip * 0.9
	weapon.Cone.Ads =  weapon.Cone.Ads * 0.9
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.85
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.85
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.8
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.8
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.1
	weapon.Primary.ClipSize = 6
	weapon.Bullet.Spread = 0.06
end