-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\akilo47\\mags\\attachment_vm_ar_akilo47_smgmag.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "5.45x39mm 30-Round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_ar_akilo47_smgmag.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_smgmag_akilo47.vmt")

ATTACHMENT.BulletList = {
    [1] = {"j_ammo1_secondary"},
    [2] = {"j_ammo2_secondary"},
    [3] = {"j_ammo3_secondary"},
    [4] = {"j_ammo4_secondary"}
}

ATTACHMENT.ReserveBulletList = {
    [1] = {"j_ammo1"},
    [2] = {"j_ammo2"},
    [3] = {"j_ammo3"},
    [4] = {"j_ammo4"}
}