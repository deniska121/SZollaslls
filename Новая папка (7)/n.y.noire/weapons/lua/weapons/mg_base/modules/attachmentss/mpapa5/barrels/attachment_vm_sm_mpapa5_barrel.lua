--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mpapa5/barrels/attachment_vm_sm_mpapa5_barrel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_laser"
ATTACHMENT.Category = "Стволы"
ATTACHMENT.Model = Model("models/viper/mw/attachments/mpapa5/attachment_vm_sm_mpapa5_barrel.mdl")

ATTACHMENT.Flashlight = {
	FlashlightMaterial = Material("effects/flashlight001.vmt"),
	Color = Color(255, 255, 255, 255),
	Attachment = "flashlight"
}

ATTACHMENT.Laser = {} --needed for base to know its a laser
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:DoLaserRender(weapon, laserModel)
end

function ATTACHMENT:DrawFlashlight(weapon, model)
	local grip = weapon:GetAttachmentInUseByCategory("Рукоятки")
	local tacLaser = weapon:HasAttachment("attachment_vm_sm_mpapa5_laser01")

	if ((grip ~= nil and grip.Index > 1) or tacLaser) then
		self:RemoveFlashlightStuffFromModel(model)

		return
	end

	BaseClass.DrawFlashlight(self, weapon, model)
end

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)

	if weapon:HasAttachment("attachment_vm_sm_mpapa5_stock_fullstock") then
		weapon.PrintName = "MP5A2"
	else
		weapon.PrintName = "MP5A3"
	end
end