--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/effects/phys_freeze.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


local effects_freeze = CreateClientConVar( "effects_freeze", "1", true, false )

function EFFECT:Init( data )

	if ( effects_freeze:GetBool() == false ) then return end

	self.Target = data:GetEntity()
	self.StartTime = CurTime()
	self.Length = 0.3

end

function EFFECT:Think()

	if ( effects_freeze:GetBool() == false ) then return false end
	return self.StartTime + self.Length > CurTime()

end

function EFFECT:Render()

	if ( !IsValid( self.Target ) ) then return end

	local delta = ( ( CurTime() - self.StartTime ) / self.Length ) ^ 0.5
	local idelta = 1 - delta

	local size = 1
	--halo.Add( { self.Target }, Color( 0, 255, 0, 255 * idelta ), size, size, 1, true, false )

end
