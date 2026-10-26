--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/thotel/grips/vm_sm_thotel_angled_00.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_vm_vertgrip01"
ATTACHMENT.Name = "M1928"
ATTACHMENT.Model = Model("models/easy/vg/attachments/thotel/vm_sm_thotel_angled_00.mdl")
ATTACHMENT.Icon = Material("easy/vg/attachments/icons/thotel/sm_thotel_angled_00_lod0.vmt")

ATTACHMENT.AttachmentBodygroups = {
	["tag_grip_hide"] = 1,
	["tag_grip_attach"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Reload = weapon.Animations.Reload_Grip
	weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Grip
	weapon.Animations.Reload_Ext = weapon.Animations.Reload_Ext_Grip
	weapon.Animations.Reload_Empty_Ext = weapon.Animations.Reload_Empty_Ext_Grip

	weapon.PrintName = "M1928 Thompson"
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetGripPoseParameter("grip_ang_offset")
end
--theres probably a cleaner and more optimized way to do this i just dont know how :ujel: