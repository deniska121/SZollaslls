--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/sights/optics/att_vm_optics_axial.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_optic_3x"
ATTACHMENT.Name = "Оптика 'Ось'"
ATTACHMENT.Model = Model("models/easy/cw/attachments/optics/attachment_vm_acog_t904.mdl")
ATTACHMENT.Icon = Material("easy/cw/attachments/icons/nato/icon_attachment_optic_scope3x_t9.vmt")

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 2,
	["tag_rail"] = 1,
	--["tag_top_rail"] = 1,
	--["sight"] = 2
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 2,
	["tag_rail"] = 1,
	--["sight"] = 2
}

ATTACHMENT.Optic = {
	LensHideMaterial = Material("easy/cw/attachments/optics/ads_scope_lens_t9acog04.vmt"),
	HideModel = Model("models/easy/cw/attachments/optics/attachment_vm_acog_t904_hide.mdl"),
	LensBodygroup = "lens",
	FOV = 3,
	ParallaxSize = 600, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Reticle = {
	Material = Material("easy/cw/attachments/optics/reticles/i_attach_t9_optic_3x_reticle_c.vmt"),
	Size = 2500,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	Parallaxing = 700,
	Offset = Vector(-0.0, 0.0, 0)
}