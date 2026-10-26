--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/uzulu/perks/attachment_vm_sm_uzulu_perk_soh.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_perk_soh"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Reload = weapon.Animations.Reload_Fast
	weapon.Animations.Reload_Empty = weapon.Animations.Reload_Empty_Fast
	weapon.Animations.Reload_Empty_Scope = weapon.Animations.Reload_Empty_Fast_Scope
	weapon.Animations.Reload_XmagLrg = weapon.Animations.Reload_XmagLrg_Fast
	weapon.Animations.Reload_Empty_XmagLrg = weapon.Animations.Reload_Empty_XmagLrg_Fast
	weapon.Animations.Reload_Xmag = weapon.Animations.Reload_Xmag_Fast
	weapon.Animations.Reload_Empty_Xmag = weapon.Animations.Reload_Empty_Xmag_Fast
end