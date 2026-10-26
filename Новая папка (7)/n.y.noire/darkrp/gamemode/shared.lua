--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--[[--------------------------------------------------------
Default teams. If you make a team above the citizen team, people will spawn with that team!
--------------------------------------------------------]]
team.SetUp(0, "Подключается...", Color(150, 150, 150))

TEAM_CITIZEN = DarkRP.createJob("Без контракта", {
	model = "models/player/group01/male_07.mdl",
	description = [[]],
	command = "char1",
	weapons = {},
	max = 0,
	char = 1,
	salary = 0,
})

if SERVER then AddCSLuaFile("jobs.lua") end
include("jobs.lua")

AddDoorGroup("NYPD", TEAM_POLICESV, TEAM_WARDEN, TEAM_TRAFFIC, TEAM_DETECTIVE, TEAM_POLICE, TEAM_SWAT, TEAM_FBI, TEAM_FBISWAT)
AddDoorGroup("FDNY", TEAM_FIREFIGHTER, TEAM_REF, TEAM_INS)
AddDoorGroup("Город",TEAM_ADMIN)

GM.DefaultTeam = TEAM_CITIZEN

GM.CivilProtection = {
	[TEAM_POLICE] = true,
	[TEAM_POLICESV] = true,
	[TEAM_WARDEN] = true,
	[TEAM_TRAFFIC] = true,
	[TEAM_DETECTIVE] = true,
	[TEAM_SWAT] = true,
	[TEAM_FBI] = true,
	[TEAM_FBISWAT] = true,
}

GM.EMSTeams = {
	[TEAM_FIREFIGHTER] = true,
	[TEAM_REF] = true,
	[TEAM_INS] = true,
}

GM.RadioTeams = {
	[TEAM_POLICE] = true,
	[TEAM_POLICESV] = true,
	[TEAM_WARDEN] = true,
	[TEAM_TRAFFIC] = true,
	[TEAM_DETECTIVE] = true,
	[TEAM_SWAT] = true,
	[TEAM_FIREFIGHTER] = true,
	[TEAM_REF] = true,
	[TEAM_INS] = true,
	[TEAM_FBI] = true,
	[TEAM_FBISWAT] = true
}

GM.KarmaTeam = {
	[TEAM_OFFDUTY] = true,
	[TEAM_WARDEN] = true,
	[TEAM_TRAFFIC] = true,
	[TEAM_DETECTIVE] = true,
	[TEAM_CITIZEN] = true,
	[TEAM_FIREFIGHTER] = true,
	[TEAM_REF] = true,
	[TEAM_INS] = true,
	[TEAM_GUN] = true,
	[TEAM_COOK] = true,
	[TEAM_HOBO] = true,
	[TEAM_CAR] = true,
	[TEAM_DOC] = true,
	[TEAM_MED] = true,
}

MCR = MCR or {}

MCR.DefTeams = {
	[1] = TEAM_CITIZEN,
	[2] = TEAM_OFFDUTY,
	[3] = TEAM_GANG
}

function DarkRP.UseDelay(ent, delay)
	local CT = CurTime()
	if ent.UseDelay and ent.UseDelay + delay > CT then return true end
	ent.UseDelay = CT
	return false
end

function DarkRP.TableCompress(data)
	local json_data = util.TableToJSON(data, false)
	local compressed_data = util.Compress(json_data)
	local bytes_number = string.len(compressed_data)

	return compressed_data, bytes_number
end

function DarkRP.TableDecompress(compressed_data)
	local json_data = util.Decompress(compressed_data)
	local data = util.JSONToTable(json_data)

	return data
end

function DarkRP.findPlayer(info)
	if not info or info == "" then return nil end
	local pls = player.GetAll()

	for k = 1, #pls do -- Proven to be faster than pairs loop.
		local v = pls[k]
		if tonumber(info) == v:UserID() then
			return v
		end

		if info == v:SteamID() then
			return v
		end

		if string.find(string.lower(v:SteamName()), string.lower(tostring(info)), 1, true) ~= nil then
			return v
		end

		if string.find(string.lower(v:FullName()), string.lower(tostring(info)), 1, true) ~= nil then
			return v
		end
	end
	return nil
end

local UNIT_TO_INCH = .75
local INCH_TO_CM = 2.54

function util.HUtoInch(units)
	return units * UNIT_TO_INCH
end

function util.HUtoCM(units)
	return util.HUtoInch(units) * INCH_TO_CM
end

function util.NiceMetric(cm)
	local m = cm / 100
	return string.format("%.1f%s", m >= 1 and m or cm, m >= 1 and "m" or "cm")
end

Discord = {}