--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/spawned_food/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local cutlist = {
	["america"] = { ang = Angle(-180, -90, 0), mat = Material("models/antlion/antlion_innards"), min = -10, max = 20},
	["pizza"] = { ang = Angle(-180, 0, 0), mat = Material("models/antlion/antlion_innards"), min = -10, max = 20},
	["french_pancake"] = { ang = Angle(-180, 90, 0), mat = Material("models/antlion/antlion_innards"), min = -10, max = 20},
	["ribs"] = { ang = Angle(-180, -90, 0), mat = Material("models/antlion/antlion_innards"), min = -10, max = 20},
	["german_chicken"] = { ang = Angle(180, 0, 0), mat = Material("models/antlion/antlion_innards"), min = -7, max = 15},
	["chicken_row"] = { ang = Angle(180, 0, 0), mat = Material("models/antlion/antlion_innards"), min = -7, max = 15},
	["pie"] = { ang = Angle(-180, 0, 0), mat = Material("models/antlion/antlion_innards"), min = -5, max = 15},
	["french_cake"] = { ang = Angle(-180, 0, 0), mat = Material("models/antlion/antlion_innards"), min = -7, max = 15},
	["ananas"] = { ang = Angle(-90, 0, 0), mat = Material("models/antlion/antlion_innards"), min = -10, max = 15},
	["french_baget"] = { ang = Angle(-180, 90, 0), mat = Material("models/antlion/antlion_innards"), min = -20, max = 40},
	["europan_pancake"] = { ang = Angle(-90, 0, 0), mat = Material("models/antlion/antlion_innards"), min = 1, max = 2},
}

function ENT:Draw()
	self:DrawModel()
end