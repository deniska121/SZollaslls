--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mac10/grips/mac_grip_mac10.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_grip_mac10"
ATTACHMENT.Name = "Ремень"
ATTACHMENT.Model = Model("models/mac_10_fg.mdl")
ATTACHMENT.Icon = Material("icon/mac_sling.vmt")

ATTACHMENT.VElement = {
	Bone = "tag_grip_attach",
	Position = Vector(0, -0.24, 0),
	Angles = Angle(0, 0, 0),
	Offsets = {}
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetGripPoseParameter("grip_vert_offset")
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.2
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.3
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.3
end