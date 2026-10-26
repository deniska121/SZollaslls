--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/romeo870/perks/attachment_vm_sh_romeo870_perk_slamfire.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_perk"
ATTACHMENT.Name = "Slamfire"
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/perks/perk_icon_slamfire.vmt")
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	-- weapon.Animations.Rechamber = weapon.Animations.rechamber_slam
	-- weapon.Animations.Fire = weapon.Animations.fire_slam
	-- weapon.Animations.Fire_Last = weapon.Animations.fire_last_slam
	weapon.Primary.RPM = 450
	weapon.Animations.Rechamber.Length = 0.3
	weapon.Cone.Hip = 1.3
	weapon.Cone.Max = 7.5
	weapon.Primary.Automatic = true
end