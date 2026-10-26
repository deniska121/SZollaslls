--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/golf17/mags/att_vm_pi_golf17_mag_xmags.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "24 Round Mags"
ATTACHMENT.Model = Model("models/kyo/attachment_vm_pi_golf17_xmag.mdl")
ATTACHMENT.Icon = Material("models/kyo/icon/golf/icon_golf_xmag.vmt")

ATTACHMENT.BulletList = {
	[1] = {"j_ammo_01"},
	[2] = {"j_ammo_02"},
	[3] = {"j_ammo_03"},
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 24
	weapon.Animations.Reload = weapon.Animations.Reload_Xmag
	weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Xmag
	weapon.Animations.Reload_Fast = weapon.Animations.Reload_Xmag_Fast
	weapon.Animations.Reload_Empty_Fast = weapon.Animations.Reload_Empty_Xmag_Fast
	weapon.Animations.Inspect = weapon.Animations.Inspect_xmag
	weapon.Animations.Inspect_empty = weapon.Animations.Inspect_empty_xmag
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.95
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.95
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.96
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.96
	weapon.Animations.Reload.Fps = weapon.Animations.Reload.Fps * 0.9
	weapon.Animations.Reload_Empty.Fps = weapon.Animations.Reload_Empty.Fps * 0.9
	weapon.DontHide = true
end