--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/effects/entity_remove.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


function EFFECT:Init( data )

	if ( GetConVarNumber( "gmod_drawtooleffects" ) == 0 ) then return end

	local TargetEntity = data:GetEntity()
	if ( !IsValid( TargetEntity ) ) then return end

	local vOffset = TargetEntity:GetPos()
	local Low, High = TargetEntity:WorldSpaceAABB()

	local NumParticles = TargetEntity:BoundingRadius()
	NumParticles = NumParticles * 4

	NumParticles = math.Clamp( NumParticles, 32, 256 )

	local emitter = ParticleEmitter( vOffset )

	for i = 0, NumParticles do

		local vPos = Vector( math.Rand( Low.x, High.x ), math.Rand( Low.y, High.y ), math.Rand( Low.z, High.z ) )
		local particle = emitter:Add( "effects/spark", vPos )
		if ( particle ) then

			particle:SetVelocity( ( vPos - vOffset ) * 5 )
			particle:SetLifeTime( 0 )
			particle:SetDieTime( math.Rand( 0.5, 1.0 ) )
			particle:SetStartAlpha( math.Rand( 200, 255 ) )
			particle:SetEndAlpha( 0 )
			particle:SetStartSize( 2 )
			particle:SetEndSize( 0 )
			particle:SetRoll( math.Rand(0, 360) )
			particle:SetRollDelta( 0 )

			particle:SetAirResistance( 100 )
			particle:SetGravity( Vector( 0, 0, -700 ) )
			particle:SetCollide( true )
			particle:SetBounce( 0.3 )

		end

	end

	emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
