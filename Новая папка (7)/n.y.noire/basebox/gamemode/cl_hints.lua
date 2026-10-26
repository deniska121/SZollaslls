--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/cl_hints.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]



CreateClientConVar( "cl_showhints", "1", true, false )

-- A list of hints we've already done so we don't repeat ourselves`
local ProcessedHints = {}

--
-- Throw's a Hint to the screen
--
local function ThrowHint( name )

	local show = GetConVarNumber( "cl_showhints" )
	if ( show == 0 ) then return end

	if ( engine.IsPlayingDemo() ) then return end

	local text = language.GetPhrase( "Hint_" .. name )

	local s, e, group = string.find( text, "%%([^%%]+)%%" )
	while ( s ) do
		local key = input.LookupBinding( group )
		if ( !key ) then key = "<NOT BOUND>" end

		text = string.gsub( text, "%%([^%%]+)%%", "'" .. key:upper() .. "'" )
		s, e, group = string.find( text, "%%([^%%]+)%%" )
	end

	GAMEMODE:AddNotify( text, NOTIFY_HINT, 20 )

	surface.PlaySound( "ambient/water/drip" .. math.random( 1, 4 ) .. ".wav" )

end


--
-- Adds a hint to the queue
--
function GM:AddHint( name, delay )

	if ( ProcessedHints[ name ] ) then return end

	timer.Create( "HintSystem_" .. name, delay, 1, function() ThrowHint( name ) end )
	ProcessedHints[ name ] = true

end

--
-- Removes a hint from the queue
--
function GM:SuppressHint( name )

	timer.Remove( "HintSystem_" .. name )

end

-- Show opening menu hint if they haven't opened the menu within 30 seconds
-- GM:AddHint( "OpeningMenu", 30 )

-- -- Tell them how to turn the hints off after 1 minute
-- GM:AddHint( "Annoy1", 5 )
-- GM:AddHint( "Annoy2", 7 )
