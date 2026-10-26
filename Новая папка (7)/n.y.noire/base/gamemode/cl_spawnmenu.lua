--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/gamemode/cl_spawnmenu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--[[---------------------------------------------------------
	Spawn Menu
-----------------------------------------------------------]]
function GM:OnSpawnMenuOpen()
end

function GM:OnSpawnMenuClose()
end

concommand.Add( "+menu", function()
	hook.Run( "OnSpawnMenuOpen" )
end, nil, "Opens the spawnmenu", FCVAR_DONTRECORD )

concommand.Add( "-menu", function()
	if ( input.IsKeyTrapping() ) then return end
	hook.Run( "OnSpawnMenuClose" )
end, nil, "Closes the spawnmenu", FCVAR_DONTRECORD )


--[[---------------------------------------------------------
	Context Menu
-----------------------------------------------------------]]
function GM:OnContextMenuOpen()
end

function GM:OnContextMenuClose()
end

concommand.Add( "+menu_context", function()
	hook.Run( "OnContextMenuOpen" )
end, nil, "Opens the context menu", FCVAR_DONTRECORD )

concommand.Add( "-menu_context", function()
	if ( input.IsKeyTrapping() ) then return end
	hook.Run( "OnContextMenuClose" )
end, nil, "Closes the context menu", FCVAR_DONTRECORD )
