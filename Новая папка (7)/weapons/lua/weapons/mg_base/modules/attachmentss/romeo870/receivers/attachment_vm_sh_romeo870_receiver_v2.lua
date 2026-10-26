-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo870\\receivers\\attachment_vm_sh_romeo870_receiver_v2.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Подавитель"
ATTACHMENT.Model = Model("models/viper/mw/attachments/romeo870/attachment_vm_sh_romeo870_receiver_v2.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/romeo870/icon_attachment_sh_romeo870_receiver_v2.vmt")
ATTACHMENT.ExcludedAttachments = {"attachment_vm_sh_romeo870_stock_pistolgrip", "attachment_vm_sh_romeo870_stock", "attachment_vm_sh_romeo870_stock_wood"}

ATTACHMENT.CosmeticChange = true
ATTACHMENT.AttachmentBodygroups ={
    ["tag_stock"] = 1,
}
