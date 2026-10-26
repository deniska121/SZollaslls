--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/simfphys/client/seatcontrols.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function lockControls( bLock )
	net.Start("simfphys_blockcontrols")
		net.WriteBool( bLock )
	net.SendToServer()
end

hook.Add( "OnContextMenuOpen", "simfphys_seatswitching_cmenuopen", function()
	contextmenuopen = true
	lockControls( true )
end)

hook.Add( "OnContextMenuClose", "simfphys_seatswitching_cmenuclose", function()
	contextmenuopen = false
	lockControls( false )
end)

hook.Add( "OnSpawnMenuOpen", "simfphys_seatswitching_menuopen", function()
	spawnmenuopen = true
	lockControls( true )
end)

hook.Add( "OnSpawnMenuClose", "simfphys_seatswitching_menuclose", function()
	spawnmenuopen = false
	lockControls( false )
end)

hook.Add( "FinishChat", "simfphys_seatswitching_chatend", function()
	chatopen = false
	lockControls( false )
end)

hook.Add( "StartChat", "simfphys_seatswitching_chatstart", function()
	chatopen = true
	lockControls( true )
end)
