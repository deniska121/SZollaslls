--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/romeo700/sights/romeo700_scope.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_optic_10x"
ATTACHMENT.Name = "Снайперский прицел"
ATTACHMENT.Model = Model("models/viper/mw/attachments/kilo98/weapon_vm_scope_kilo98.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/kilo98/icon_attachment_scope_kilo98.vmt")

ATTACHMENT.Optic = {
	HideModel = Model("models/viper/mw/attachments/kilo98/weapon_vm_scope_kilo98_lens_hide.mdl"),
	LensHideMaterial = Material("viper/mw/weapons/kilo98/weapon_vm_sn_kilo98_scopeglass.vmt"),
	LensBodygroup = "lens",
	FOV = 12,
	ParallaxSize = 750, --a value of zero means 1:1 size with the end of the optic
	Thermal = false
}

ATTACHMENT.Bodygroups = {
	--["tag_sight"] = 2, -- test
	["tag_rail"] = 0,
}

ATTACHMENT.Reticle = {
	Material = Material("easy/cw/attachments/optics/reticles/i_attach_t9_optic_3x_reticle_c.vmt"),
	Size = 2500,
	Color = Color(255, 255, 255, 255),
	Attachment = "reticle",
	Offset = Vector(-0.09, 0.01, 0),
	Parallaxing = 1200,
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Reload_Start = weapon.Animations.reload_start_scope
	weapon.Animations.Reload_Loop = weapon.Animations.reload_loop_scope
	weapon.Animations.Reload_End = weapon.Animations.reload_end_scope
	weapon.Animations.Rechamber = weapon.Animations.rechamber_scope
end