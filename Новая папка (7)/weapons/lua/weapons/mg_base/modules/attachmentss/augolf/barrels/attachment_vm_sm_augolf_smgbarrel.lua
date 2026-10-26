-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\augolf\\barrels\\attachment_vm_sm_augolf_smgbarrel.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/easy/cw/attachments/sm_t9powerburst/attachment_vm_sm_t9powerburst_barrel_02.mdl")
ATTACHMENT.Name = "Укороченный ствол (325 мм)"

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)
    weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.1
    weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.1
    weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.2
    weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.2
    weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 0.9
    weapon.Bullet.DropOffStartRange = weapon.Bullet.DropOffStartRange * 0.95
    weapon.Cone.Hip = weapon.Cone.Hip * 1.08
end

function ATTACHMENT:PostProcess(weapon)
    BaseClass.PostProcess(self, weapon)
    -- weapon:SetGripPoseParameter("grip_smg_pose_offset")
end 