--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mike/mags/attachment_vm_pi_mike_drummag.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "80 Round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike_drummag.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike/icon_attachment_pi_mike_drummag.vmt")

ATTACHMENT.BulletList = {
	[1] = {"j_bullet1"},
	[2] = {"j_bullet2"},
	[3] = {"j_bullet3"},
	[4] = {"j_bullet4"},
	[5] = {"j_bullet5"},
	[6] = {"j_bullet6"},
	[7] = {"j_bullet7"},
	[8] = {"j_bullet8"},
	[9] = {"j_bullet9"},
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.ClipSize = 80
	weapon.Animations.Reload = weapon.Animations.Reload_XmagLrg
	weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_XmagLrg
	weapon.Animations.Reload_Fast = weapon.Animations.Reload_XmagLrg_Fast
	weapon.Animations.Reload_Empty_Fast = weapon.Animations.Reload_Empty_XmagLrg_Fast
	weapon.Animations.Inspect = weapon.Animations.Inspect_Drum
	weapon.Animations.Equip = weapon.Animations.Equip_Drum
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.65
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.65
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.7
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.7
	weapon.Animations.Reload_XmagLrg.Fps = weapon.Animations.Reload_XmagLrg.Fps * 0.9
	weapon.Animations.Reload_Empty_XmagLrg.Fps = weapon.Animations.Reload_Empty_XmagLrg.Fps * 0.8
	weapon.Animations.Reload_XmagLrg_Fast.Fps = weapon.Animations.Reload_XmagLrg.Fps * 0.9
	weapon.Animations.Reload_Empty_XmagLrg_Fast.Fps = weapon.Animations.Reload_Empty_XmagLrg.Fps * 0.8
	weapon.DontHide = true
end