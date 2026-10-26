--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/sights/optics/att_vm_optics_vision.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_optic_3x"
ATTACHMENT.Name = "Оптика 'Окуляр'"
ATTACHMENT.Model = Model("models/zeron/atts/attachment_vm_acog_t901.mdl")
ATTACHMENT.Icon = Material("easy/cw/attachments/icons/nato/icon_attachment_optic_acog_t9.vmt")

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 2,
	["tag_rail"] = 1,
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 2,
	["tag_rail"] = 1,
}

ATTACHMENT.Optic = {
	LensHideMaterial = Material("viper/MW/attachments/attachment_vm_4x_west_lens.vmt"),
	HideModel = Model("models/zeron/atts/attachment_vm_acog_t901_hide.mdl"),
	LensBodygroup = "lens",
	FOV = 1,
	ParallaxSize = 600, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Reticle = {
	Material = Material("zeron/reticles/visiontech2x.vmt"),
	Size = 1800,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	Parallaxing = 700,
	Offset = Vector(-0.02, -1, 0)
}

ATTACHMENT.ReticleHybrid = {
	Material = Material("null"),
	Size = 1500,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	Offsets = {
		pos = Vector(0, 0, -0.82),
		ang = Angle(),
	}
}