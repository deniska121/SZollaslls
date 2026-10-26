-- "addons\\weapons\\lua\\weapons\\police_mp5.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Base = "mwb_mp5"
SWEP.PrintName = "MP5"
SWEP.Category = "Modern Warfare"
SWEP.SubCategory = "Police"
SWEP.NoUserAttachs = true
SWEP.IconOverride = "entities/mwb_mp5.png"

SWEP.Customization = {
	{"att_ammo", "attachment_vm_sm_mpapa5_mag", "attachment_vm_sm_mpapa5_mag_xmag"},
	{"attachment_vm_sm_mpapa5_stock", "attachment_vm_sm_mpapa5_stock_fullstock", "attachment_vm_sm_mpapa5_stock_nostock"},
	{"attachment_vm_sm_mpapa5_receiver_v2", "attachment_vm_sm_mpapa5_receiver"},
	{"norail", "rail_mount_mp5"},
	{"attachment_vm_sm_mpapa5_barrel", "attachment_vm_sm_mpapa5_barrel_suppressor"},
	{"att_sight", "att_vm_minireddot01",  "att_vm_holo_west01", "att_vm_holo_east01", "att_vm_reflex_east01", "att_vm_reflex_west02", "att_vm_4x_west02", "att_vm_optics_axial", "att_vm_optics_vision"},
}
