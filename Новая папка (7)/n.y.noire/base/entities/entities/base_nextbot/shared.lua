--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/entities/entities/base_nextbot/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


AddCSLuaFile()

ENT.Base 			= "base_entity"
ENT.PrintName		= ""
ENT.Author			= ""
ENT.Contact			= ""
ENT.Purpose			= ""
ENT.Instructions	= ""

ENT.Type = "nextbot"

function ENT:Initialize()
end

if ( SERVER ) then

	--
	-- All of the AI logic is serverside - so we derive it from a
	-- specialized class on the server.
	--
	include( "sv_nextbot.lua" )

else

	--[[---------------------------------------------------------
		Name: Draw
		Desc: Draw it!
	-----------------------------------------------------------]]
	function ENT:Draw( flags )
		self:DrawModel( flags )
	end

	--[[---------------------------------------------------------
		Name: DrawTranslucent
		Desc: Draw translucent
	-----------------------------------------------------------]]
	function ENT:DrawTranslucent( flags )

		-- This is here just to make it backwards compatible.
		-- You shouldn't really be drawing your model here unless it's translucent

		self:Draw( flags )

	end

	--[[---------------------------------------------------------
		Name: FireAnimationEvent
		Desc: Called when an animation event is fired. Return true to suppress
	-----------------------------------------------------------]]
	function ENT:FireAnimationEvent( pos, ang, event, options )
	end

end
