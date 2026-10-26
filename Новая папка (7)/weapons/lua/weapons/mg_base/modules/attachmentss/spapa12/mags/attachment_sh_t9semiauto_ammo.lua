-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\spapa12\\mags\\attachment_sh_t9semiauto_ammo.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "Default Mags"
ATTACHMENT.Model = Model("models/zeron/attachment_vm_sh_t9semiauto_ammo_LOD0.mdl")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
    BaseClass.Stats(self, weapon)

end

-- function ATTACHMENT:PostProcess(weapon)
    -- BaseClass.PostProcess(self, weapon)
    -- weapon.Animations.Reload_Start = nil
    -- weapon.Animations.Reload_Loop = nil
    -- weapon.Animations.Reload_End = nil
    -- weapon.Animations.Reload_EndEmpty = nil
-- end 