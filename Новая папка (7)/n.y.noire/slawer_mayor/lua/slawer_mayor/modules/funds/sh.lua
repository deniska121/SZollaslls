--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/funds/sh.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Slawer.Mayor.Upgrades = Slawer.Mayor.Upgrades or {}

function Slawer.Mayor:GetFunds()
	return GetGlobalInt("Slawer.Mayor:Funds")
end

function Slawer.Mayor:GetMaxFunds()
	return GetGlobalInt("Slawer.Mayor:MaxFunds")
end

function Slawer.Mayor:GetUpgradeLevel(intID)
	return Slawer.Mayor.Upgrades[intID] or 0
end

function Slawer.Mayor:GetUpgradeTable(intID)
	return Slawer.Mayor.CFG.Upgrades[intID]
end

function Slawer.Mayor:GetUpgradeMaxLevel(intID)
	return #Slawer.Mayor.CFG.Upgrades[intID].Levels or 0
end

hook.Add("lockpickTime", "Slawer.Mayor:lockpickTime", function(p, e)
	if e:GetClass() == "slawer_mayor_safe" then return Slawer.Mayor.CFG.LockpickTime end
end)