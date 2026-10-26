--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/gb_rp_sign_big/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "SignUrl"
ENT.Author = "Mac"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "T1", { KeyName = "text1", Edit = { type = "String", order = 1 } })
	self:NetworkVar("String", 1, "T2", { KeyName = "text2", Edit = { type = "String", order = 2 } })
	self:NetworkVar("Int", 0, "C1", { KeyName = "color1", Edit = { type = "Int", order = 3, min = 1, max = 10 } })
	self:NetworkVar("Int", 1, "C2", { KeyName = "color2", Edit = { type = "Int", order = 4, min = 1, max = 10 } })
	self:NetworkVar("Int", 2, "F1", { KeyName = "font1", Edit = { type = "Int", order = 5, min = 1, max = 6 } })
	self:NetworkVar("Int", 3, "F2", { KeyName = "font2", Edit = { type = "Int", order = 6, min = 1, max = 6 } })
	self:NetworkVar("Int", 4, "ST", { KeyName = "type", Edit = { type = "Int", order = 7, min = 1, max = 5 } })
	self:NetworkVar("Int", 5, "O1", { KeyName = "outline1", Edit = { type = "Int", order = 8, min = 0, max = 8 } })
	self:NetworkVar("Int", 6, "O2", { KeyName = "outline2", Edit = { type = "Int", order = 9, min = 0, max = 8 } })
	self:NetworkVar("Int", 7, "S1", { KeyName = "shadow1", Edit = { type = "Int", order = 10, min = 0, max = 8 } })
	self:NetworkVar("Int", 8, "S2", { KeyName = "shadow2", Edit = { type = "Int", order = 11, min = 0, max = 8 } })
end