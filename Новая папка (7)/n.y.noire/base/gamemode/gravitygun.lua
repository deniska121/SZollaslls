--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/gamemode/gravitygun.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


--[[---------------------------------------------------------
   Name: gamemode:GravGunPunt()
   Desc: We're about to punt an entity (primary fire).
		 Return true if we're allowed to.
-----------------------------------------------------------]]
function GM:GravGunPunt( ply, ent )
	return true
end

--[[---------------------------------------------------------
	Name: gamemode:GravGunPickupAllowed()
	Desc: Return true if we're allowed to pickup entity
-----------------------------------------------------------]]
function GM:GravGunPickupAllowed( ply, ent )
	return true
end

if ( SERVER ) then

	--[[---------------------------------------------------------
	   Name: gamemode:GravGunOnPickedUp()
	   Desc: The entity has been picked up
	-----------------------------------------------------------]]
	function GM:GravGunOnPickedUp( ply, ent )
	end


	--[[---------------------------------------------------------
	   Name: gamemode:GravGunOnDropped()
	   Desc: The entity has been dropped
	-----------------------------------------------------------]]
	function GM:GravGunOnDropped( ply, ent )
	end

end
