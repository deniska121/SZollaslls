--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/playervars/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local maxId = 0
local DarkRPVars = {}
local DarkRPVarById = {}
-- the amount of bits assigned to the value that determines which DarkRPVar we're sending/receiving
local DARKRP_ID_BITS = 8
local UNKNOWN_DARKRPVAR = 255 -- Should be equal to 2^DARKRP_ID_BITS - 1
DarkRP.DARKRP_ID_BITS = DARKRP_ID_BITS

function DarkRP.registerDarkRPVar(name, writeFn, readFn)
	maxId = maxId + 1

	-- UNKNOWN_DARKRPVAR is reserved for unknown values
	if maxId >= UNKNOWN_DARKRPVAR then
		DarkRP.error(string.format("Too many DarkRPVar registrations! DarkRPVar '%s' triggered this error", name), 2)
	end

	DarkRPVars[name] = {
		id = maxId,
		name = name,
		writeFn = writeFn,
		readFn = readFn
	}

	DarkRPVarById[maxId] = DarkRPVars[name]
end

-- Unknown values have unknown types and unknown identifiers, so this is sent inefficiently
local function writeUnknown(name, value)
	net.WriteUInt(UNKNOWN_DARKRPVAR, 8)
	net.WriteString(name)
	net.WriteType(value)
end

-- Read the value of a DarkRPVar that was not registered
local function readUnknown()
	return net.ReadString(), net.ReadType(net.ReadUInt(8))
end

local warningsShown = {}

local function warnRegistration(name)
	if warningsShown[name] then return end
	warningsShown[name] = true
	print(string.format([[Warning! DarkRPVar '%s' wasn't registered!
		Please contact the author of the DarkRP Addon to fix this.
		Until this is fixed you don't need to worry about anything. Everything will keep working.
		It's just that registering DarkRPVars would make DarkRP faster.]], name), 4)
end

function DarkRP.writeNetDarkRPVar(name, value)
	local DarkRPVar = DarkRPVars[name]

	if not DarkRPVar then
		warnRegistration(name)

		return writeUnknown(name, value)
	end

	net.WriteUInt(DarkRPVar.id, DARKRP_ID_BITS)

	return DarkRPVar.writeFn(value)
end

function DarkRP.writeNetDarkRPVarRemoval(name)
	local DarkRPVar = DarkRPVars[name]

	if not DarkRPVar then
		warnRegistration(name)
		net.WriteUInt(UNKNOWN_DARKRPVAR, 8)
		net.WriteString(name)

		return
	end

	net.WriteUInt(DarkRPVar.id, DARKRP_ID_BITS)
end

function DarkRP.readNetDarkRPVar()
	local DarkRPVarId = net.ReadUInt(DARKRP_ID_BITS)
	local DarkRPVar = DarkRPVarById[DarkRPVarId]

	if DarkRPVarId == UNKNOWN_DARKRPVAR then
		local name, value = readUnknown()

		return name, value
	end

	local val = DarkRPVar.readFn(value)

	return DarkRPVar.name, val
end

function DarkRP.readNetDarkRPVarRemoval()
	local id = net.ReadUInt(DARKRP_ID_BITS)

	return id == 255 and net.ReadString() or DarkRPVarById[id].name
end

-- Big Values
DarkRP.registerDarkRPVar("money", net.WriteDouble, net.ReadDouble)

DarkRP.registerDarkRPVar("salary", fp{fn.Flip(net.WriteInt), 32}, fp{net.ReadInt, 32})
DarkRP.registerDarkRPVar("payday", fp{fn.Flip(net.WriteInt), 32}, fp{net.ReadInt, 32})
DarkRP.registerDarkRPVar("unconscious", fp{fn.Flip(net.WriteInt), 32}, fp{net.ReadInt, 32})
DarkRP.registerDarkRPVar("karma", fp{fn.Flip(net.WriteInt), 32}, fp{net.ReadInt, 32})
DarkRP.registerDarkRPVar("invspace", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("bankspace", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("fanim", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("afk", fp{fn.Flip(net.WriteInt), 32}, fp{net.ReadInt, 32})
DarkRP.registerDarkRPVar("playtime", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("synctime", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("Arrested", fp{fn.Flip(net.WriteInt), 32}, fp{net.ReadInt, 32})
DarkRP.registerDarkRPVar("gosban", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("ganban", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("BANNED", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("KT", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})

-- Float
DarkRP.registerDarkRPVar("fanim_r", net.WriteFloat, net.ReadFloat)

-- String
DarkRP.registerDarkRPVar("fanim_n", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("wantedReason", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("rpname", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("dsname", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("job", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("gender", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("wantedReason", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("agenda", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("face", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("mouth", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("head", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("vest", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("Extralicense", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("tatoo", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("medals", net.WriteString, net.ReadString)
DarkRP.registerDarkRPVar("age", net.WriteString, net.ReadString)
--DarkRP.registerDarkRPVar("narc", net.WriteString, net.ReadString)

DarkRP.registerDarkRPVar("wanted", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("rc_on", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("Player.Drag", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("showrank", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("hidename", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("sit_x", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("dragFixed", net.WriteBit, fc{tobool, net.ReadBit})

-- Integer
DarkRP.registerDarkRPVar("hunger", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("stamina", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("bleeding", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("fracture", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("fracturearm", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("smoke", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("relax", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("nausea", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("morph", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("meth", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("heroin", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("coca", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("cough", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("shock", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("overdose", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("narcan", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("nark", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("adren", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("jailed", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("rc_speek", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("on_call", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("overs", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("meds1", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("meds2", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("meds3", net.WriteBit, fc{tobool, net.ReadBit})
DarkRP.registerDarkRPVar("focus", net.WriteBit, fc{tobool, net.ReadBit})

DarkRP.registerDarkRPVar("cold", fp{fn.Flip(net.WriteUInt), 10}, fp{net.ReadUInt, 10})
DarkRP.registerDarkRPVar("alcohol", fp{fn.Flip(net.WriteUInt), 10}, fp{net.ReadUInt, 10})
DarkRP.registerDarkRPVar("addict", fp{fn.Flip(net.WriteUInt), 10}, fp{net.ReadUInt, 10})
DarkRP.registerDarkRPVar("blood", fp{fn.Flip(net.WriteInt), 10}, fp{net.ReadInt, 10})
DarkRP.registerDarkRPVar("toxity", fp{fn.Flip(net.WriteUInt), 10}, fp{net.ReadUInt, 10})
DarkRP.registerDarkRPVar("bag", fp{fn.Flip(net.WriteUInt), 8}, fp{net.ReadUInt, 8})
DarkRP.registerDarkRPVar("dragging", fp{fn.Flip(net.WriteUInt), 3}, fp{net.ReadUInt, 3})

DarkRP.registerDarkRPVar("deoxygen", fp{fn.Flip(net.WriteUInt), 7}, fp{net.ReadUInt, 7})
DarkRP.registerDarkRPVar("thirst", fp{fn.Flip(net.WriteUInt), 11}, fp{net.ReadUInt, 11})
DarkRP.registerDarkRPVar("energy", fp{fn.Flip(net.WriteUInt), 11}, fp{net.ReadUInt, 11})

DarkRP.registerDarkRPVar("character", fp{fn.Flip(net.WriteUInt), 2}, fp{net.ReadUInt, 2})
DarkRP.registerDarkRPVar("voicedist", fp{fn.Flip(net.WriteUInt), 2}, fp{net.ReadUInt, 2})
DarkRP.registerDarkRPVar("scba", fp{fn.Flip(net.WriteUInt), 3}, fp{net.ReadUInt, 3})
DarkRP.registerDarkRPVar("skillpoint", fp{fn.Flip(net.WriteUInt), 5}, fp{net.ReadUInt, 5})

DarkRP.registerDarkRPVar("model", fp{fn.Flip(net.WriteUInt), 4}, fp{net.ReadUInt, 4})
DarkRP.registerDarkRPVar("rc", fp{fn.Flip(net.WriteUInt), 8}, fp{net.ReadUInt, 8})
DarkRP.registerDarkRPVar("sa", fp{fn.Flip(net.WriteUInt), 8}, fp{net.ReadUInt, 8})
DarkRP.registerDarkRPVar("ia", fp{fn.Flip(net.WriteUInt), 8}, fp{net.ReadUInt, 8})

DarkRP.registerDarkRPVar("armorVest", fp{fn.Flip(net.WriteUInt), 3}, fp{net.ReadUInt, 3})

DarkRP.registerDarkRPVar("McPhone.Active", fp{fn.Flip(net.WriteUInt), 3}, fp{net.ReadUInt, 3})
DarkRP.registerDarkRPVar("McPhone.HasPhone", fp{fn.Flip(net.WriteUInt), 32}, fp{net.ReadUInt, 32})
DarkRP.registerDarkRPVar("McPhone.Type", fp{fn.Flip(net.WriteUInt), 3}, fp{net.ReadUInt, 3})
DarkRP.registerDarkRPVar("HandCuffed", fp{fn.Flip(net.WriteUInt), 1}, fp{net.ReadUInt, 1})