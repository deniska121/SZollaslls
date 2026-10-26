--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/fpp/lua/fpp/client/ownability.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

FPP = FPP or {}

FPP.entOwners       = FPP.entOwners or {}
FPP.entTouchability = FPP.entTouchability or {}
FPP.entTouchReasons = FPP.entTouchReasons or {}

local touchTypes = {
	Physgun = 1,
	Gravgun = 2,
	Toolgun = 4,
	PlayerUse = 8,
	EntityDamage = 16
}

local reasonSize = 4 -- bits
local reasons = {
	[1] = "Владелец", -- you can't touch other people's props
	[2] = "Мир",
	[3] = "Отключен",
	[4] = "Нет доступа",
	[5] = "Ограниченный",
	[6] = "Друг",
	[7] = "Общий",
	[8] = "Игрок", -- you can't pick up players
}

local function receiveTouchData(len)
	repeat
		local entIndex = net.ReadUInt(32)
		local ownerIndex = net.ReadUInt(32)
		local touchability = net.ReadUInt(5)
		local reason = net.ReadUInt(20)

		FPP.entOwners[entIndex] = ownerIndex
		FPP.entTouchability[entIndex] = touchability
		FPP.entTouchReasons[entIndex] = reason
	until net.ReadBit() == 1
end
net.Receive("FPP_TouchabilityData", receiveTouchData)

function FPP.entGetOwner(ent)
	local idx = FPP.entOwners[ent:EntIndex()]
	ent.FPPOwner = idx and Entity(idx) or nil

	return ent.FPPOwner
end

function FPP.canTouchEnt(ent, touchType)
	ent.FPPCanTouch = FPP.entTouchability[ent:EntIndex()]
	if not touchType or not ent.FPPCanTouch then
		return ent.FPPCanTouch
	end

	return bit.bor(ent.FPPCanTouch, touchTypes[touchType]) == ent.FPPCanTouch
end

local touchTypeMultiplier = {
	["Physgun"] = 0,
	["Gravgun"] = 1,
	["Toolgun"] = 2,
	["PlayerUse"] = 3,
	["EntityDamage"] = 4
}

function FPP.entGetTouchReason(ent, touchType)
	local idx = FPP.entTouchReasons[ent:EntIndex()] or 0
	ent.FPPCanTouchWhy = idx

	if not touchType then return idx end

	local maxReasonValue = 15
	-- 1111 shifted to the right touch type
	local touchTypeMask = bit.lshift(maxReasonValue, reasonSize * touchTypeMultiplier[touchType])
	-- Extract reason for touch type from reason number
	local touchTypeReason = bit.band(idx, touchTypeMask)
	-- Shift it back to the right
	local reasonNr = bit.rshift(touchTypeReason, reasonSize * touchTypeMultiplier[touchType])

	local reason = reasons[reasonNr]
	local owner = ent:CPPIGetOwner()

	if reasonNr == 1 or reasonNr == 4 then -- convert owner to the actual player
		return not isnumber(owner) and IsValid(owner) and owner:SteamName() or "???"
	elseif reasonNr == 6 then
		return "Друг (" .. (IsValid(owner) and owner:SteamName() or "???") .. ")"
	end

	return reason
end

function FPP.CheckTool(ply, tool)
	local ignoreGeneralRestrictTool = false
	local SteamID = ply:SteamID()
	FPP.RestrictedToolsPlayers = FPP.RestrictedToolsPlayers or {}

	--Player specific
	if FPP.RestrictedToolsPlayers[tool] and FPP.RestrictedToolsPlayers[tool][SteamID] ~= nil then
		if FPP.RestrictedToolsPlayers[tool][SteamID] == false then
			FPP.Notify(ply, "Toolgun restricted for you!", false)

			return false
		elseif FPP.RestrictedToolsPlayers[tool][SteamID] == true then
			ignoreGeneralRestrictTool = true --If someone is allowed, then he's allowed even though he's not admin, so don't check for further restrictions
		end
	end

	if not ignoreGeneralRestrictTool then
		local Group = FPP.Groups[FPP.GroupMembers[SteamID]] or FPP.Groups[ply:GetUserGroup()] or FPP.Groups.default -- What group is the player in. If not in a special group, then he's in default group
		local CanGroup = true

		-- If the tool is on the BLACKLIST or
		if Group and ((Group.allowdefault and table.HasValue(Group.tools, tool)) or (not Group.allowdefault and not table.HasValue(Group.tools, tool))) then
			-- If the tool is NOT on the WHITELIST
			CanGroup = false
		end

		if FPP.RestrictedTools[tool] then
			if tonumber(FPP.RestrictedTools[tool].admin) == 1 and not ply:IsSuperAdmin() then
				return false
			elseif tonumber(FPP.RestrictedTools[tool].admin) == 2 and not ply:IsSuperAdmin() then
				return false
			elseif (tonumber(FPP.RestrictedTools[tool].admin) == 1 and ply:IsSuperAdmin()) or (tonumber(FPP.RestrictedTools[tool].admin) == 2 and ply:IsSuperAdmin()) then
				CanGroup = true -- If the person is not in the BUT has admin access, he should be able to use the tool
			end

			if FPP.RestrictedTools[tool]["team"] and #FPP.RestrictedTools[tool]["team"] > 0 and not table.HasValue(FPP.RestrictedTools[tool]["team"], ply:Team()) then return false end
		end

		if not CanGroup then return false end
	end

	return true
end