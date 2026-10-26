--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/mike9/receivers/attachment_vm_pi_mike9_receiver_diamatti.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_receiver"
ATTACHMENT.Name = "Забытая классика"
ATTACHMENT.Model = Model("models/viper/mw/attachments/attachment_vm_pi_mike9_receiver_diamatti.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/mike9/icon_attachment_pi_mike9_receiver.vmt")

ATTACHMENT.ExcludedCategories = {"ЛЦУ", "Прицелы", "Рукоятки"}

ATTACHMENT.Bodygroups = {
	["receiver"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.Sound = Sound("bocw.pi_burst.fire")
	weapon.PrintName = "Beretta 93R"
end


ATTACHMENT.CosmeticChange = true