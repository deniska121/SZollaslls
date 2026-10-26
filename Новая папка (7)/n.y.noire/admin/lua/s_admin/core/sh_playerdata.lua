--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/core/sh_playerdata.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin = sAdmin or {}
local lastRequest, requestedPeople = {}, {}

local function cooldownHandeler(identifier, identifier2, time)
	lastRequest[identifier] = lastRequest[identifier] or {}
	if lastRequest[identifier][identifier2] and lastRequest[identifier][identifier2] - CurTime() < time then return false end
	lastRequest[identifier][identifier2] = CurTime() + time

	return true
end

local function requestData(ply)
	local sid64 = ply:SteamID64()
	if SERVER or not cooldownHandeler("playtime", sid64, 1) then return end
	requestedPeople[sid64] = true
	net.Start("sA:Networking")
	net.WriteUInt(6, 3)
	net.WriteEntity(ply)
	net.SendToServer()
end

sAdmin.getTotalPlaytime = function(ply)
	if not IsValid(ply) or not ply:IsPlayer() or ply:IsBot() then return 0 end
	local sid64 = ply:SteamID64()
	local playtime = sAdmin.playerData and sAdmin.playerData[sid64] and sAdmin.playerData[sid64].playtime or 0

	return math.max(0, math.Round(playtime + sAdmin.getSessionPlaytime(ply)))
end

sAdmin.getSessionPlaytime = function(ply)
	if not IsValid(ply) or not ply:IsPlayer() or ply:IsBot() then return 0 end
	local sid64 = ply:SteamID64()
	local session = sAdmin.playerData and sAdmin.playerData[sid64] and sAdmin.playerData[sid64].synctime or 0

	if session == 0 then
		requestData(ply)
	end

	return math.max(0, math.Round(CurTime() - session))
end