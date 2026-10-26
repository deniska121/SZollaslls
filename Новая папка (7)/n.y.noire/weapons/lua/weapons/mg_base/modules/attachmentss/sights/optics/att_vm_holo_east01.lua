--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/sights/optics/att_vm_holo_east01.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_optic_1point5x"
ATTACHMENT.Name = "Голограф 'Восток'"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_holo_east.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/optics/icon_attachment_holo_east.vmt")

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 2
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 2
}

ATTACHMENT.Optic = {
	LensHideMaterial = Material("viper/MW/attachments/attachment_vm_holo_east_lens.vmt"),
	HideModel = Model("models/viper/mw/attachments/attachment_vm_holo_east_hide.mdl"),
	LensBodygroup = "lens",
	ParallaxSize = 450, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Reticle = {
	Material = Material("viper/mw/reticles/reticle_holo_default2.vmt"),
	Size = 400,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	Parallaxing = 700,
}