--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/carradio/lua/wcarradio/sh_wcr_util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function isTracked(cls, ent)
	return cls == "prop_vehicle_jeep" or cls == "prop_vehicle_jeep_old" or (cls == "spawned_junk" and ent.Geteclass and ent:Geteclass() == "radio")
end

local carents = setmetatable({}, {
	__mode = "v"
})

for _, e in pairs(ents.GetAll()) do
	if isTracked(e:GetClass(), e) then
		table.insert(carents, e)
	end
end

hook.Add(SERVER and "OnEntityCreated" or "NetworkEntityCreated", "CarRadio_CarTracker", function(e)
	if isTracked(e:GetClass(), e) then
		table.insert(carents, e)
	end
end)

hook.Add("EntityRemoved", "CarRadio_CarTracker", function(e)
	if isTracked(e:GetClass(), e) then
		table.RemoveByValue(carents, e)
	end
end)

function wyozicr.GetCarEnts()
	return carents
end