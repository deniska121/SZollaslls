--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/entities/gmod_ghost.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


AddCSLuaFile()
DEFINE_BASECLASS( "base_gmodentity" )

ENT.Type = "anim"
ENT.PrintName = "Tool Ghost"

function ENT:Initialize()

	if ( SERVER ) then
		self:PhysicsInitBox( Vector( -4, -4, -4 ), Vector( 4, 4, 4 ) )
	end

end

function ENT:SetNetworkedBonePosition( i, Pos, Angle )

	self:SetNWVector( "Vector" .. i, Pos )
	self:SetNWAngle( "Angle" .. i, Angle )

end

function ENT:Draw( flags )

	-- Don't draw it if we're a ragdoll and haven't
	-- received all of the bone positions yet.
	if ( self:GetModelPhysBoneCount() > 1 and !self:GetNWVector( "Vector0", false ) ) then
		return
	end

	BaseClass.Draw( self, flags )

end
