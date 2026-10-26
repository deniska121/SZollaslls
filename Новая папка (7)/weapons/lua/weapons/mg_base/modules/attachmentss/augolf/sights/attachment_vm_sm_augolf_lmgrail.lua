-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\augolf\\sights\\attachment_vm_sm_augolf_lmgrail.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_optic_3x"
ATTACHMENT.Name = "Интегрированный прицел (3.0x)"
ATTACHMENT.Model = Model("models/easy/cw/attachments/sm_t9powerburst/weapon_vm_sm_t9powerburst_scope.mdl")

ATTACHMENT.Bodygroups = {
	["tag_rail_upper"] = 1,
	["tag_sight"] = 2
}

ATTACHMENT.Optic = {
	HideModel = Model("models/easy/cw/attachments/sm_t9powerburst/weapon_vm_sm_t9powerburst_scope_hide.mdl"),
	LensHideMaterial = Material("viper/mw/weapons/augolf/weapon_vm_sm_augolf_scope_lens.vmt"),
	LensBodygroup = "lens",
	FOV = 7,
	ParallaxSize = 20, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Reticle = {
	Material = Material("easy/cw/weapons/reticles/reticle_scope_powerburstt9.vmt"),
	Size = 1500,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
}

ATTACHMENT.ReticleHybrid = {
	Material = Material("easy/cw/weapons/reticles/reticle_scope_powerburstt9.vmt"),
	Size = 1500,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	Offsets = {
		pos = Vector(-0.1, 0, -0.75),
		ang = Angle(),
	}
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.PrintName = "AUG A1"
end