--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/scharlie/stock/attachment_vm_ar_scharlie_stock_light.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Компактный приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_stock_light.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/scharlie/icon_attachment_ar_scharlie_stock_light.vmt")

ATTACHMENT.Bodygroups = {
	["tag_stock"] = 0
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.19
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.19
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.12
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.12
	weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 1.75
	weapon.Cone.Shake = weapon.Cone.Shake * 3

	if (weapon:HasAttachment("attachment_vm_ar_scharlie_barrel_pdw")) then
		weapon.PrintName = "FN SCAR-SC"
	end
end