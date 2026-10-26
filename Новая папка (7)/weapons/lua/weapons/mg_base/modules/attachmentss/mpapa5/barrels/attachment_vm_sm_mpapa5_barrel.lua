-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mpapa5\\barrels\\attachment_vm_sm_mpapa5_barrel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
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