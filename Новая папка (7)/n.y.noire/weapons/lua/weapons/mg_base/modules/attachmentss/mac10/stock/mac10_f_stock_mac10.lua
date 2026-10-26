--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mac10/stock/mac10_f_stock_mac10.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_stock"
ATTACHMENT.Name = "Сложенный приклад"
ATTACHMENT.Model = Model("models/mac_stock_zd.mdl")
ATTACHMENT.Icon = Material("icon/mac_fs.vmt")

ATTACHMENT.Bodygroups = {
	["stock"] = 1
}

ATTACHMENT.VElement = {
	Bone = "tag_stock_attach",
	Position = Vector(0, 0, 0),
	Angles = Angle(0, 0, 0),
	Offsets = {}
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 1.5
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 1.1
	weapon.Recoil.Vertical[1] = weapon.Recoil.Vertical[1] * 1.25
	weapon.Recoil.Vertical[2] = weapon.Recoil.Vertical[2] * 1.25
	weapon.Recoil.Horizontal[1] = weapon.Recoil.Horizontal[1] * 1.25
	weapon.Recoil.Horizontal[2] = weapon.Recoil.Horizontal[2] * 1.25
	weapon.ViewModelOffsets.AimKickMultiplier = 2.4
	weapon.ViewModelOffsets.RecoilMultiplier = 1.2
	weapon.Cone.Shake =  weapon.Cone.Shake * 2

	if weapon:HasAttachment("mac_longmuz_mac10") or weapon:HasAttachment("mac_sup_mac10") then return end

	weapon.HolsterData = weapon.HolsterDataLow
	weapon.SlotType = 2


	weapon.ViewModelOffsets.Aim.Pos = Vector(0, 9, 0.13)
end