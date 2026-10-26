--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/cpapa/sights/attachment_vm_pi_cpapa_scope.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_optic_4x"
ATTACHMENT.Name = "Оптика"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_cpapa_scope.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/cpapa/icon_attachment_pi_cpapa_scope.vmt")

ATTACHMENT.Bodygroups = {
    ["rail"] = 1,
    --["tag_sight"] = 1, -- test
    ["sight"] = 1
}

ATTACHMENT.Optic = {
    LensHideMaterial = Material("viper/MW/weapons/357/weapon_vm_pi_cpapa_scope_lens.vmt"),
    HideModel = Model("models/viper/mw/attachments/attachment_vm_pi_cpapa_scope_hide.mdl"),
    LensBodygroup = "lens",
    FOV = 4,
    ParallaxSize = 400, --a value of zero means 1:1 size with the end of the optic
    Thermal = false
}

ATTACHMENT.Reticle = {
    Material = Material("viper/mw/reticles/reticle_sniper_new.vmt"),
    Size = 2500,
    Color = Color(255, 255, 255, 255),
    Attachment = "reticle",
    Parallaxing = 700,
}