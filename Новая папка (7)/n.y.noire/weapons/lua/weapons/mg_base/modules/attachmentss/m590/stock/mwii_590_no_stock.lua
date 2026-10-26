--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/m590/stock/mwii_590_no_stock.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Без приклада"
ATTACHMENT.Model = Model("models/590_dqr/att_vm_p13_sh_mbravo_stockpstlno_v0_lod0.mdl")
ATTACHMENT.Icon = Material("icon/mwii_psg.vmt")

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

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Recoil.Shake = 5
	weapon.Recoil.Punch = 0.7
	weapon.Recoil.AdsShakeMultiplier = 2
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.4
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.4
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 0.5
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 0.5
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.4
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.4
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 1.3
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 1.3
	weapon.Cone.Shake = weapon.Cone.Shake * 5

	if weapon:HasAttachment("590_eft_barrel_v1") or weapon:HasAttachment("590_mwii_barrel_v2") then
		weapon.PrintName = "Mossberg 590 Compact Cruiser"
	elseif weapon:HasAttachment("590_eft_barrel_fg") then
		weapon.PrintName = "Mossberg 500 Compact Cruiser"
	elseif weapon:HasAttachment("590_eft_barrel_1897") then
		weapon.PrintName = "Mossberg 500 Cruiser"
	else
		weapon.PrintName = "Mossberg 590 Cruiser"
	end


	weapon.Animations.Reload_Start = weapon.Animations.reload_start_fast
	weapon.Animations.Reload_Loop = weapon.Animations.reload_loop_fast
	weapon.Animations.Reload_End = weapon.Animations.reload_end_fast
	weapon.Animations.Reload_End_Empty = weapon.Animations.reload_end_empty_fast
	weapon.Animations.Reload = weapon.Animations.reload_fast
	weapon.Animations.Reload_Empty = weapon.Animations.reload_empty_fast
	weapon.DisableCantedReload = true
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
	weapon:SetGripPoseParameter2("grip_back_offset")
end