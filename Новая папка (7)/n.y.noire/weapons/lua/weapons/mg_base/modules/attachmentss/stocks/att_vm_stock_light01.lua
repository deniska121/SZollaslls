--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/stocks/att_vm_stock_light01.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Скелетный приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_stock_light01.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/stock/icon_attachment_stock_light01.vmt")

ATTACHMENT.Bodygroups = {
	["tag_stock"] = 1,
	["stock_hide"] = 1
}

ATTACHMENT.AttachmentBodygroups = {
	["tag_stock"] = 1,
	["stock_hide"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.15
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.15
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.1
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.1
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 1.1
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.1
	weapon.Cone.Shake =  weapon.Cone.Shake * 1.4
end