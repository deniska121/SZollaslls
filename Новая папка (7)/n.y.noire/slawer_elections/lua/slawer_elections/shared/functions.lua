--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_elections/lua/slawer_elections/shared/functions.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function Slawer.Elections:Compress(tTable)
	local sJson = util.TableToJSON(tTable or {})

	return sJson, sJson:len()
end

function Slawer.Elections:Decompress(dData)
	local tTable = util.JSONToTable(dData or "")

	return tTable
end

function Slawer.Elections:FromPlayerToID(tTable)
	local tOut = {}

	for k, v in pairs(tTable) do
		if not IsValid(k) then continue end
		tOut[k:UserID()] = v
	end

	return tOut
end

function Slawer.Elections:FromIDToPlayer(tTable)
	local tOut = {}

	for k, v in pairs(tTable) do
		if not IsValid(Player(k)) then continue end
		tOut[Player(k)] = v
	end

	return tOut
end