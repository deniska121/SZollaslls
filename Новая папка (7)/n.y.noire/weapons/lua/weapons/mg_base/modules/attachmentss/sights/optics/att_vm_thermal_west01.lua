--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/sights/optics/att_vm_thermal_west01.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_optic_10x"
ATTACHMENT.Name = "Прицел ночного видения"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_thermal_west_01.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/optics/icon_attachment_thermal_west01.vmt")

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
	HideModel = Model("models/viper/mw/attachments/attachment_vm_thermal_west_01_hide.mdl"),
	LensHideMaterial = Material("viper/MW/attachments/attachment_vm_thermal_west01_lens.vmt"),
	LensBodygroup = "lens",
	FOV = 7,
	ParallaxSize = 600, --a value of zero means 1:1 size with the end of the optic
	Thermal = true,
	ThermalBackgroundColor = Color(50, 100, 75, 223),
	ThermalBodiesColor = Color(250, 250, 0, 150)
}

ATTACHMENT.Reticle = {
	Material = Material("viper/mw/reticles/reticle_thermal_default.vmt"),
	Size = 750,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle"
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Zoom.ViewModelFovMultiplier = weapon.Zoom.ViewModelFovMultiplier * 0.9
end