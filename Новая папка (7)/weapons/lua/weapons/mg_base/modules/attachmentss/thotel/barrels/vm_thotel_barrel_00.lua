-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\thotel\\barrels\\vm_thotel_barrel_00.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/easy/vg/attachments/thotel/vm_thotel_barrel_00.mdl")
--[[ATTACHMENT.Flashlight = {
    FlashlightMaterial = Material("effects/flashlight001.vmt"),
    Color = Color(255, 255, 255, 255),
    Attachment = "flashlight"
}
ATTACHMENT.Laser = {} --needed for base to know its a laser

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:DoLaserRender(weapon, laserModel)
end

function ATTACHMENT:DrawFlashlight(weapon, model)
    local grip = weapon:GetAttachmentInUseByCategory("Grips")
    local tacLaser = weapon:HasAttachment("attachment_vm_sm_mpapa5_laser01")

    if ((grip != nil && grip.Index > 1) || tacLaser) then
        self:RemoveFlashlightStuffFromModel(model)
        return
    end

    BaseClass.DrawFlashlight(self, weapon, model)
end]]