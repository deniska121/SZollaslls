--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/m590/barrels/590_eft_barrel_v4.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Name = "Спортивный ствол"
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/590_dqr/870_bg_5.mdl")
ATTACHMENT.Icon = Material("icon/bg5.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 6
	weapon.Bullet.Spread = 0.065
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.2
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.2
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
end