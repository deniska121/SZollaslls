--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/akilo47/mags/attachment_vm_ar_akilo47_smgmag.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_magazine"
ATTACHMENT.Name = "5.45x39mm 30-Round Mags"
ATTACHMENT.Model = Model("models/viper/mw/attachments/akilo47/attachment_vm_ar_akilo47_smgmag.mdl")
ATTACHMENT.Icon = Material("viper/mw/attachments/icons/akilo47/icon_attachment_smgmag_akilo47.vmt")

ATTACHMENT.BulletList = {
    [1] = {"j_ammo1_secondary"},
    [2] = {"j_ammo2_secondary"},
    [3] = {"j_ammo3_secondary"},
    [4] = {"j_ammo4_secondary"}
}

ATTACHMENT.ReserveBulletList = {
    [1] = {"j_ammo1"},
    [2] = {"j_ammo2"},
    [3] = {"j_ammo3"},
    [4] = {"j_ammo4"}
}