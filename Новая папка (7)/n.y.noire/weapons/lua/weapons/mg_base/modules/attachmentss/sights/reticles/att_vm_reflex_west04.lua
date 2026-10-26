--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/sights/reticles/att_vm_reflex_west04.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_sight_1x"
ATTACHMENT.Name = "Прицел 'Кронен'"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_reflex_west05.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/reticles/icon_attachment_ar_tango21_reflex.vmt")

ATTACHMENT.Reticle = {
	Material = Material("viper/shared/reticles/aimpoint_reticle.vmt"),
	Size = 150,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle"
}

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 1
}

ATTACHMENT.AttachmentBodygroups = {
	--["tag_sight"] = 1, -- test
	["tag_rail"] = 1,
	--["sight"] = 1
}