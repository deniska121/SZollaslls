--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/m590/psg/590_f1.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Training"
ATTACHMENT.Model = Model("models/590_dqr/stock_590_magpul_sga_lod0.mdl")
ATTACHMENT.Icon = Material("icon/sga.vmt")

ATTACHMENT.AttachmentBodygroups = {
	["tag_psg"] = 1,
	["tag_stock"] = 1
}

ATTACHMENT.VElement = {
	Bone = "tag_sling",
	Position = Vector(0, 0, 0),
	Angles = Angle(0, 0, 0),
	Offsets = {}
}

-- local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

-- function ATTACHMENT:PostProcess(weapon)
-- 	BaseClass.PostProcess(self, weapon)
-- 	weapon:SetGripPoseParameter2("grip_stockh_offset")
-- end

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "stock_590_magpul_sga_lod0" then return "m590_dqr/", "stock_590_magpul_sga_lod0_green" end

	return path, mat
end