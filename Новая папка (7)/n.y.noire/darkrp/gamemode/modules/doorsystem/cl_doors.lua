--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/doorsystem/cl_doors.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local meta = FindMetaTable("Entity")

--[[---------------------------------------------------------------------------
Door data
---------------------------------------------------------------------------]]
DarkRP.doorData = DarkRP.doorData or {}

--[[---------------------------------------------------------------------------
Interface functions
---------------------------------------------------------------------------]]
function meta:getDoorData()
	local doorData = DarkRP.doorData[self:EntIndex()] or {}
	self.doorData = doorData -- Backwards compatibility

	return doorData
end

hook.Add("EntityRemoved", "DarkRp.DoorSystem", function(ent)
	if not IsValid(ent) or not ent:EntIndex() or not DarkRP.doorData[ent:EntIndex()] then return end
	DarkRP.doorData[ent:EntIndex()] = nil
end)

--[[---------------------------------------------------------------------------
Networking
---------------------------------------------------------------------------]]
--[[---------------------------------------------------------------------------
Retrieve all the data for all doors
---------------------------------------------------------------------------]]
local function retrieveAllDoorData(len)
	local count = net.ReadUInt(16)

	for i = 1, count do
		local ix = net.ReadUInt(16)
		local varCount = net.ReadUInt(8)
		DarkRP.doorData[ix] = DarkRP.doorData[ix] or {}
		for vc = 1, varCount do
			local name, value = DarkRP.readNetDoorVar()
			DarkRP.doorData[ix][name] = value
		end
	end
end

net.Receive("DarkRP_AllDoorData", retrieveAllDoorData)

--[[---------------------------------------------------------------------------
Update changed variables
---------------------------------------------------------------------------]]
local function updateDoorData()
	local door = net.ReadUInt(32)
	DarkRP.doorData[door] = DarkRP.doorData[door] or {}
	local var, value = DarkRP.readNetDoorVar()
	DarkRP.doorData[door][var] = value
end

net.Receive("DarkRP_UpdateDoorData", updateDoorData)

--[[---------------------------------------------------------------------------
Set a value of a single doorvar to nil
---------------------------------------------------------------------------]]
local function removeDoorVar()
	local door = net.ReadUInt(16)
	local id = net.ReadUInt(8)
	local name = id == 0 and net.ReadString() or DarkRP.getDoorVars()[id].name
	if not DarkRP.doorData[door] then return end
	DarkRP.doorData[door][name] = nil
end

net.Receive("DarkRP_RemoveDoorVar", removeDoorVar)

--[[---------------------------------------------------------------------------
Remove doordata of removed entity
---------------------------------------------------------------------------]]
local function removeDoorData()
	local door = net.ReadUInt(32)
	DarkRP.doorData[door] = nil
end

net.Receive("DarkRP_RemoveDoorData", removeDoorData)