--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/persistence.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


if ( CLIENT ) then return end

hook.Add( "ShutDown", "SavePersistenceOnShutdown", function() hook.Run( "PersistenceSave" ) end )

hook.Add( "PersistenceSave", "PersistenceSave", function( name )

	local PersistPage = ( name or GetConVarString( "sbox_persist" ) ):Trim()
	if ( PersistPage == "" ) then return end

	local Ents = ents.GetAll()

	for k, v in pairs( Ents ) do

		if ( !v:GetPersistent() ) then
			Ents[ k ] = nil
		end

	end

	local tab = duplicator.CopyEnts( Ents )
	if ( !tab ) then return end

	local out = util.TableToJSON( tab )

	file.CreateDir( "persist" )
	file.Write( "persist/" .. game.GetMap() .. "_" .. PersistPage .. ".txt", out )

end )

hook.Add( "PersistenceLoad", "PersistenceLoad", function( name )

	local file = file.Read( "persist/" .. game.GetMap() .. "_" .. name .. ".txt" )
	if ( !file ) then return end

	local tab = util.JSONToTable( file )
	if ( !tab ) then return end
	if ( !tab.Entities ) then return end
	if ( !tab.Constraints ) then return end

	local Ents, Constraints = duplicator.Paste( nil, tab.Entities, tab.Constraints )

	for k, v in pairs( Ents ) do
		v:SetPersistent( true )
	end

end )

cvars.AddChangeCallback( "sbox_persist", function( name, old, new )

	-- A timer in case someone tries to rapily change the convar, such as addons with "live typing" or whatever
	timer.Create( "sbox_persist_change_timer", 1, 1, function()
		if ( old:Trim() == new:Trim() ) then return end

		hook.Run( "PersistenceSave", old:Trim() )

		game.CleanUpMap() -- Maybe this should be moved to PersistenceLoad?

		if ( new:Trim() == "" ) then return end

		hook.Run( "PersistenceLoad", new:Trim() )
	end )

end, "sbox_persist_load" )

hook.Add( "InitPostEntity", "PersistenceInit", function()

	local PersistPage = GetConVarString( "sbox_persist" ):Trim()
	if ( PersistPage == "" ) then return end

	hook.Run( "PersistenceLoad", PersistPage )

end )
