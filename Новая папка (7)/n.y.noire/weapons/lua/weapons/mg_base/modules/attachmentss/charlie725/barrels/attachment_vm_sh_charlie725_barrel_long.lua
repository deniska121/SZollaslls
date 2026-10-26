--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/charlie725/barrels/attachment_vm_sh_charlie725_barrel_long.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Name = "Увеличенный ствол"
ATTACHMENT.Model = Model("models/viper/mw/attachments/charlie725/attachment_vm_sh_charlie725_barrel_long.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/charlie725/icon_attachment_sh_charlie725_barrel_long.vmt")

ATTACHMENT.Bodygroups = {
	["tag_grip_rail"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Ads_In.Fps = weapon.Animations.Ads_In.Fps * 0.8
	weapon.Animations.Ads_Out.Fps = weapon.Animations.Ads_Out.Fps * 0.8
	weapon.Animations.Holster.Fps = weapon.Animations.Holster.Fps * 0.7
	weapon.Animations.Draw.Fps = weapon.Animations.Draw.Fps * 0.8
	weapon.Animations.Reload.Fps = weapon.Animations.Reload.Fps * 0.8
	weapon.Animations.Reload_Empty.Fps = weapon.Animations.Reload_Empty.Fps * 0.8
	weapon.Bullet.EffectiveRange = weapon.Bullet.EffectiveRange * 7
	weapon.Bullet.Range = weapon.Bullet.Range * 2
	weapon.Bullet.Spread = 0.08
	weapon.Cone.Hip = weapon.Cone.Hip * 0.5
	weapon.Cone.Ads = weapon.Cone.Ads * 0.5
	weapon.HolsterData = weapon.HolsterDataBack
	weapon.SlotType = 1
end

function ATTACHMENT:PostProcess(weapon)
	BaseClass.PostProcess(self, weapon)
end