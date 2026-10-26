-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike1911\\receivers\\sw4506_receiver.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Model = Model("models/viper/mw/attachments/sw4506_receiver.mdl")
ATTACHMENT.Name = "S&W 4506"

ATTACHMENT.ExcludedAttachments = {"attachment_vm_pi_mike1911_v1_slide"}

ATTACHMENT.Bodygroups = {
    ["receiver"] = 1
}