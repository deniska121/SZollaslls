--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/grips/att_vm_angledgrip02.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_grip"
ATTACHMENT.Name = "Облегчённая тактическая рукоятка"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_angledgrip02.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/grips/icon_attachment_angledgrip02.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.08
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.08
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.08
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.08
	weapon.Recoil.Horizontal[1] = self:ChangeRecoil(weapon.Recoil.Horizontal[1], 1.02)
	weapon.Recoil.Horizontal[2] = self:ChangeRecoil(weapon.Recoil.Horizontal[2], 1.02)
	weapon.Recoil.Vertical[1] = self:ChangeRecoil(weapon.Recoil.Vertical[1], 1.02)
	weapon.Recoil.Vertical[2] = self:ChangeRecoil(weapon.Recoil.Vertical[2], 1.02)
end