--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/entities/gmod_anchor.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


AddCSLuaFile()

ENT.Type = "anim"
ENT.PrintName = "World Anchor"

if ( CLIENT ) then return end

function ENT:Initialize()


	self:SetModel( "models/Combine_Helicopter/helicopter_bomb01.mdl" )
	self:PhysicsInit( SOLID_VPHYSICS )

	self:SetNotSolid( true )
	self:SetNoDraw( true )
	self:DrawShadow( false )

	local phys = self:GetPhysicsObject()
	if ( IsValid( phys ) ) then

		phys:EnableMotion( false )
		phys:EnableCollisions( false )

	end

	self:SetUnFreezable( true )

end
