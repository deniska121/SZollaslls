--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/doorsystem/sh_doors.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local meta = FindMetaTable("Entity")
local plyMeta = FindMetaTable("Player")

function meta:isKeysOwnable()
	if not IsValid(self) then return false end
	local class = self:GetClass()

	if ((class == "func_door" or class == "func_door_rotating" or class == "prop_door_rotating" or class == "func_movelinear") or
			(self:IsVehicle() and (not IsValid(self:GetParent()) or not self:GetParent():IsVehicle()))) then
			return true
		end
	return false
end

function meta:isDoor()
	if not IsValid(self) then return false end
	local class = self:GetClass()

	if class == "func_door" or
		class == "func_door_rotating" or
		class == "prop_door_rotating" or
		class == "func_movelinear" or
		class == "prop_dynamic" then
		return true
	end
	return false
end

function meta:isKeysOwned()
	if IsValid(self:getDoorOwner()) then return true end

	return false
end

function meta:getDoorOwner()
	local doorData = self:getDoorData()
	if not doorData then return nil end

	return doorData.owner and Player(doorData.owner) or nil
end

function meta:isMasterOwner(ply)
	return ply == self:getDoorOwner()
end

function meta:isKeysOwnedBy(ply)
	if self:isMasterOwner(ply) then return true end

	local coOwners = self:getKeysCoOwners()
	return coOwners and coOwners[ply:UserID()] or false
end

function meta:isKeysAllowedToOwn(ply)
	local doorData = self:getDoorData()
	if not doorData then return false end

	return doorData.allowedToOwn and doorData.allowedToOwn[ply:UserID()] or false
end

function meta:getKeysNonOwnable()
	local doorData = self:getDoorData()
	if not doorData then return nil end

	return doorData.nonOwnable
end

function meta:getKeysTitle()
	local doorData = self:getDoorData()
	if not doorData then return nil end

	return doorData.title
end

function meta:getKeysDoorGroup()
	local doorData = self:getDoorData()
	if not doorData then return nil end

	return doorData.groupOwn
end

function meta:getKeysDoorTeams()
	local doorData = self:getDoorData()
	if not doorData or table.Count(doorData.teamOwn or {}) == 0 then return nil end

	return doorData.teamOwn
end

function meta:getKeysAllowedToOwn()
	local doorData = self:getDoorData()
	if not doorData then return nil end

	return doorData.allowedToOwn
end

function meta:getKeysCoOwners()
	local doorData = self:getDoorData()
	if not doorData then return nil end

	return doorData.extraOwners
end

local function canLockUnlock(ply, ent)
	local Team = ply:Team()
	local group = ent:getKeysDoorGroup()
	local teamOwn = ent:getKeysDoorTeams()

	return ent:isKeysOwnedBy(ply) or (group and RPExtraTeamDoors[group] and RPExtraTeamDoors[group][Team]) or (teamOwn and teamOwn[Team])
end

function plyMeta:canKeysLock(ent)
	if ent.ramed then return false end
	local canLock = hook.Run("canKeysLock", self, ent)

	if canLock ~= nil then return canLock end
	return canLockUnlock(self, ent)
end

function plyMeta:canKeysUnlock(ent)
	local canUnlock = hook.Run("canKeysUnlock", self, ent)

	if canUnlock ~= nil then return canUnlock end
	return canLockUnlock(self, ent)
end

local netDoorVars = {}
local netDoorVarsByName = {}

DarkRP.getDoorVars = fp{fn.Id, netDoorVars}
DarkRP.getDoorVarsByName = fp{fn.Id, netDoorVarsByName}

function DarkRP.registerDoorVar(name, writeFn, readFn)
	netDoorVarsByName[name] = {name = name, write = writeFn, read = readFn}

	netDoorVarsByName[name].id = table.insert(netDoorVars, netDoorVarsByName[name])
end

if SERVER then
	function DarkRP.writeNetDoorVar(name, value)
		local var = netDoorVarsByName[name]

		-- Not registered, send inefficiently
		if not var then
			net.WriteUInt(0, 8) -- indicate unregistered
			net.WriteString(name)
			net.WriteType(value)

			return
		end

		net.WriteUInt(var.id, 8)
		var.write(value)
	end
end

if CLIENT then
	function DarkRP.readNetDoorVar()
		local id = net.ReadUInt(8)

		-- unregistered var
		if id == 0 then
			return net.ReadString(), net.ReadType(net.ReadUInt(8))
		end

		if not netDoorVars[id] then
			DarkRP.error("Unregistered DarkRP Doorvar clientside: " .. id, 2, {"Some addon is registering some DoorVar serverside, but not clientside."})
		end

		return netDoorVars[id].name, netDoorVars[id].read()
	end
end

DarkRP.registerDoorVar("groupOwn",
	function(val)
		net.WriteUInt(RPExtraTeamDoorIDs[val], 16)
	end,
	function()
		local id = net.ReadUInt(16)
		for name, id2 in pairs(RPExtraTeamDoorIDs) do
			if id == id2 then return name end
		end
	end
)

-- Net helper function for writing tables with numbers as keys and bools as values
local function writeNumBoolTbl(tbl)
	net.WriteUInt(table.Count(tbl), 10)

	for num, _ in pairs(tbl) do
		net.WriteUInt(num, 16)
	end
end

-- Net helper function for reading tables with numbers as keys and bools as values
local function readNumBoolTbl(tbl)
	local res = {}
	local count = net.ReadUInt(10)

	for i = 1, count do
		res[net.ReadUInt(16)] = true
	end

	return res
end

DarkRP.registerDoorVar("owner", fp{fn.Flip(net.WriteInt), 16}, fp{net.ReadUInt, 16})
DarkRP.registerDoorVar("nonOwnable", net.WriteBool, net.ReadBool)
DarkRP.registerDoorVar("teamOwn", writeNumBoolTbl, readNumBoolTbl)
DarkRP.registerDoorVar("allowedToOwn", writeNumBoolTbl, readNumBoolTbl)
DarkRP.registerDoorVar("extraOwners", writeNumBoolTbl, readNumBoolTbl)
DarkRP.registerDoorVar("title", net.WriteString, net.ReadString)