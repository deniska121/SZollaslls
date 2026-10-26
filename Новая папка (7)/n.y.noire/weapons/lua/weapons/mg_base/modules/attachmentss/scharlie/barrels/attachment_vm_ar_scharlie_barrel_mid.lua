--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/scharlie/barrels/attachment_vm_ar_scharlie_barrel_mid.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол (172 мм)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_ar_scharlie_barrel_mid.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/scharlie/icon_attachment_ar_scharlie_barrel_mid.vmt")

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 1.05
	weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 1.05
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
end

function ATTACHMENT:OverrideWeaponMaterial(path, mat, weapon)
	if weapon:HasAttachment("att_bolt") and mat == "weapon_vm_ar_scharlie_body" then
		mat = "weapon_vm_ar_scharlie_body_sar"
	end

	return path, mat
end