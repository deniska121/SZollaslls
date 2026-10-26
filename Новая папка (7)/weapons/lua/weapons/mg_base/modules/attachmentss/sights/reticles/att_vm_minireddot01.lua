-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\sights\\reticles\\att_vm_minireddot01.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_sight_1x"
ATTACHMENT.Name = "Коллиматор 'Вертекс'"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_reflex_02.mdl")

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "reticle_ui_stencil" then return "", "null" end

	return path, mat
end

ATTACHMENT.Reticle = {
	Material = Material("viper/mw/reticles/reticle_reflex_default2.vmt"),
	Size = 950,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle"
}

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 1
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 1
}