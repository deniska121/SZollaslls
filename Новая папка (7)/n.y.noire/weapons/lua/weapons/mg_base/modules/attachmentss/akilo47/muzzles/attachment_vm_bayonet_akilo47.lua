--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/akilo47/muzzles/attachment_vm_bayonet_akilo47.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_muzzle"
ATTACHMENT.Name = "Штык-нож"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_bayonet_akilo47.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_bayonet_akilo47.vmt")

ATTACHMENT.BonemergeToCategory = {"Стволы"}

ATTACHMENT.ExcludedAttachments = {"attachment_vm_ar_akilo47_smgbarrel", "attachment_vm_ar_akilo47_smgbarcust"}

ATTACHMENT.AttachmentBodygroups = {
	["tag_tip"] = 1,
	["tip"] = 1
}

local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Animations.Melee = weapon.Animations.Melee_Bayonet
	weapon.Animations.Melee_Hit = weapon.Animations.Melee_Hit_Bayonet
	weapon.Animations.Melee_Hit_Bayonet.Damage = 100
end