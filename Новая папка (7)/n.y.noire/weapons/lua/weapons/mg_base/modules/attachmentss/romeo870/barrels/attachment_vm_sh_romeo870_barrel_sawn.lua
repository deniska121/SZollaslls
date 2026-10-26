--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/romeo870/barrels/attachment_vm_sh_romeo870_barrel_sawn.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Укороченный ствол (140 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/romeo870/attachment_vm_sh_romeo870_barrel_sawn.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_barrel_sawn.vmt")

ATTACHMENT.AttachmentBodygroups = {
	["sight"] = 0
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Cone.Hip = weapon.Cone.Hip * 1.5
	weapon.Cone.Ads = weapon.Cone.Ads * 1.5
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.15
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.15
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.2
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.2
	weapon.Primary.ClipSize = 4
	weapon.Bullet.Spread = 0.09
end