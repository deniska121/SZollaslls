--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mpapa5/barrels/attachment_vm_sm_mpapa5_barrel_suppressor.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Интегрированный глушитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mpapa5/attachment_vm_sm_mpapa5_barrel_suppressor.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mpapa5/icon_attachment_sm_mpapa5_barrel_suppressor.vmt")

ATTACHMENT.ExcludedCategories = {"Дуло"}

ATTACHMENT.AttachmentBodygroups = {
	["tag_grip_hide"] = 0,
	["tag_grip_attach"] = 0
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.94
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.94
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.9
	weapon.Bullet.Penetration.Thickness = weapon.Bullet.Penetration.Thickness * 0.8
	weapon.Bullet.Penetration.MaxCount = 2
	weapon.DistSound = ""
	weapon:doSuppressorStats()

	if weapon:HasAttachment("attachment_vm_sm_mpapa5_stock_fullstock") then
		weapon.PrintName = "MP5SDA2"
	else
		weapon.PrintName = "MP5SDA3"
	end
end