--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mike/stocks/attachment_vm_pi_mike_stockh.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Деревянный приклад"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_stockh.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_stockh.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Equip = weapon.Animations.Equip_Stock
	weapon.ViewModelOffsets.Aim.Pos = weapon.ViewModelOffsets.Aim.Pos + Vector(-0.15, 0, 0)
	weapon.Recoil.Shake = weapon.Recoil.Shake * 0.74
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.9
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.9
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.85
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.85
	weapon.Recoil.AdsMultiplier = weapon.Recoil.AdsMultiplier * 0.5
	weapon.Zoom.Blur.EyeFocusDistance = 7
	weapon.Cone.Shake = weapon.Cone.Shake * 0.3
	weapon.DontHide = true
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetViewModel("models/viper/mw/weapons/v_makarov_stock.mdl")
end