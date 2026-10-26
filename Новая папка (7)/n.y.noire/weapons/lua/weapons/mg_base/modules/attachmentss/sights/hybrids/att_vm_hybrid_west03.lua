--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/sights/hybrids/att_vm_hybrid_west03.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_hybrid_4x"
ATTACHMENT.Name = "Гибридная оптика (4.0x)"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_hybrid_west03.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/optics/icon_attachment_4x_west02.vmt")

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 2, -- test
	["tag_rail"] = 1,
	["sight"] = 2
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 2, -- test
	["tag_rail"] = 1,
	["sight"] = 2
}

ATTACHMENT.Optic = {
	LensHideMaterial = Material("viper/MW/attachments/reticle_ui_stencil.vmt"),
	LensBodygroup = "lens",
	HideModel = Model("models/viper/mw/attachments/attachment_vm_hybrid_west03_hide.mdl"),
	FOV = 7,
	ParallaxSize = 800, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Reticle = {
	Material = Material("viper/mw/reticles/reticle_acog_default3.vmt"),
	Size = 500,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle"
}

ATTACHMENT.ReticleHybrid = {
	Material = Material("viper/shared/reticles/aimpoint_reticle.vmt"),
	Size = 150,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle2"
}