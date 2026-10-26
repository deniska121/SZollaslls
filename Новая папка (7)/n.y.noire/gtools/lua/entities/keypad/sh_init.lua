--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/keypad/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type			= "anim"
ENT.Base			= "base_gmodentity"

ENT.PrintName		= "Keypad"
ENT.Author			= "Willox"
ENT.Contact			= "Willox"
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Spawnable		= false
ENT.AdminSpawnable	= false -- Spawned via STool

ENT.Status_None = 0
ENT.Status_Granted = 1
ENT.Status_Denied = 2

ENT.Command_Enter = 0
ENT.Command_Reset = 1
ENT.Command_Accept = 2

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "DisplayText")

	self:NetworkVar("Int", 0, "Status")
end