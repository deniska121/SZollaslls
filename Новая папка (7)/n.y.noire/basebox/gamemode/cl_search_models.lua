--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/cl_search_models.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


local sbox_search_maxresults = CreateClientConVar( "sbox_search_maxresults", "1024", true, false, "The maximum amount of results the spawnmenu search should show. Model amount limited to 1/2 of this value, entities are limited to 1/4", 1024 )

local totalCalls = 0
local expectedCalls = 1

local queuedSearch = {}

local function GetAllFiles( tab, folder, extension, path )

	totalCalls = totalCalls + 1

	local files, folders = file.Find( folder .. "*", path )

	if ( !files ) then
		MsgN( "Warning! Ignoring '" .. folder .. "' because we cannot search in it!" )
		return
	end

	for k, v in pairs( files ) do

		if ( v:EndsWith( extension ) ) then
			table.insert( tab, ( folder .. v ):lower() )
		end

	end

	for k, v in pairs( folders ) do
		expectedCalls = expectedCalls + 1
		table.insert( queuedSearch, { tab, folder .. v .. "/", extension, path } )
	end

	notification.AddProgress( "SandboxSearchIndexing", "#spawnmenu.searchindex", totalCalls / expectedCalls )
	if ( totalCalls >= expectedCalls ) then notification.Kill( "SandboxSearchIndexing" ) end

end

hook.Add( "Think", "sandbox_queued_search", function()

	if ( #queuedSearch < 1 ) then return end

	local call = queuedSearch[ 1 ]
	GetAllFiles( unpack( call ) )
	table.remove( queuedSearch, 1 )

	if ( !timer.Exists( "search_models_update" ) || #queuedSearch < 1 ) then
		timer.Create( "search_models_update", 1, 1, function() hook.Run( "SearchUpdate" ) end )
	end

end )

--
-- Model Search
--
local model_list = nil
search.AddProvider( function( str )

	if ( model_list == nil ) then

		model_list = {}
		GetAllFiles( model_list, "models/", ".mdl", "GAME" )

	end

	local models = {}

	for k, v in pairs( model_list ) do

		-- Don't search in the models/ and .mdl bit of every model, because every model has this bit, unless they are looking for direct model path
		local modelpath = v
		if ( modelpath:StartWith( "models/" ) && modelpath:EndsWith( ".mdl" ) && !str:EndsWith( ".mdl" ) ) then modelpath = modelpath:sub( 8, modelpath:len() - 4 ) end

		if ( modelpath:find( str, nil, true ) ) then

			if ( IsUselessModel( v ) ) then continue end

			local entry = {
				text = v:GetFileFromFilename(),
				func = function() RunConsoleCommand( "gm_spawn", v ) end,
				icon = spawnmenu.CreateContentIcon( "model", g_SpawnMenu.SearchPropPanel, { model = v } ),
				words = { v }
			}

			table.insert( models, entry )

		end

		if ( #models >= sbox_search_maxresults:GetInt() / 2 ) then break end

	end

	return models

end, "props" )

--
-- Entity, vehicles
--
local function AddSearchProvider( listname, ctype, stype )
	search.AddProvider( function( str )

		local results = {}
		local entities = {}

		for k, v in pairs( list.Get( listname ) ) do
			if ( listname == "Weapon" && !v.Spawnable ) then continue end
			v.ClassName = k
			v.PrintName = v.PrintName or v.Name
			v.ScriptedEntityType = ctype
			table.insert( entities, v )
		end

		for k, v in pairs( entities ) do

			local name = v.PrintName
			local name_c = v.ClassName
			if ( !name && !name_c ) then continue end

			if ( ( name && name:lower():find( str, nil, true ) ) || ( name_c && name_c:lower():find( str, nil, true ) ) ) then

				local entry = {
					text = v.PrintName or v.ClassName,
					icon = spawnmenu.CreateContentIcon( v.ScriptedEntityType or "entity", nil, {
						nicename = v.PrintName or v.ClassName,
						spawnname = v.ClassName,
						material = "entities/" .. v.ClassName .. ".png",

						admin = v.AdminOnly
					} ),
					words = { v }
				}

				table.insert( results, entry )

			end

			if ( #results >= sbox_search_maxresults:GetInt() / 4 ) then break end

		end

		table.SortByMember( results, "text", true )
		return results

	end, stype )
end

AddSearchProvider( "SpawnableEntities", "entity", "entities" )
AddSearchProvider( "Vehicles", "vehicle", "vehicles" )
AddSearchProvider( "NPC", "npc", "npcs" )
AddSearchProvider( "Weapon", "weapon", "weapons" )
