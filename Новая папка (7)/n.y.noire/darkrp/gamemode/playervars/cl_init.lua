--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/playervars/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if DarkRPLoaded then return end

local DarkRPVars = {}

local pmeta = FindMetaTable("Player")

function pmeta:getDarkRPVar(var)
	local vars = DarkRPVars[self:UserID()]

	return vars and vars[var] or nil
end

function pmeta:checkDarkRPVar(var, arg)
	local vars = DarkRPVars[self:UserID()]

	return (vars and vars[var] and vars[var] == arg) or nil
end

local function RetrievePlayerVar(userID, var, value)
	local ply = Player(userID)
	DarkRPVars[userID] = DarkRPVars[userID] or {}
	DarkRPVars[userID][var] = value

	if IsValid(ply) then
		ply.DarkRPVars = DarkRPVars[userID]
	end
end

local function doRetrieve()
	local userID = net.ReadUInt(16)
	local var, value = DarkRP.readNetDarkRPVar()
	RetrievePlayerVar(userID, var, value)
end

net.Receive("DarkRP_PlayerVar", doRetrieve)

local function doRetrieveRemoval()
	local userID = net.ReadUInt(16)
	local vars = DarkRPVars[userID] or {}
	local var = DarkRP.readNetDarkRPVarRemoval()
	vars[var] = nil
end

net.Receive("DarkRP_PlayerVarRemoval", doRetrieveRemoval)

local function InitializeDarkRPVars(len)
	local plyCount = net.ReadUInt(8)

	for i = 1, plyCount do
		local userID = net.ReadUInt(16)
		local varCount = net.ReadUInt(DarkRP.DARKRP_ID_BITS + 2)

		for j = 1, varCount do
			local var, value = DarkRP.readNetDarkRPVar()
			RetrievePlayerVar(userID, var, value)
		end
	end
end

net.Receive("DarkRP_InitializeVars", InitializeDarkRPVars)