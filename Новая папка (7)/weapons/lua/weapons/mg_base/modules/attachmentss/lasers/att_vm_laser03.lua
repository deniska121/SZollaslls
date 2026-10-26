-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\lasers\\att_vm_laser03.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_laser"
ATTACHMENT.Name = "Лазерный целеуказатель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_laser03.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/laser/icon_attachment_laser03.vmt")

ATTACHMENT.Laser = {
	BeamMaterial = Material("mw19_laserbeam.vmt"),
	DotMaterial = Material("sprites/light_glow02_add.vmt"),
	BeamSize = 15,
	BeamWidth = 0.5,
	DotSize = 5,
	Color = Color(235, 51, 51),
	Attachment = "laser"
}