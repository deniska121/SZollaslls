--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/effects/inflator_magic.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


function EFFECT:Init( data )

	if ( GetConVarNumber( "gmod_drawtooleffects" ) == 0 ) then return end

	local vOffset = data:GetOrigin()

	local NumParticles = 16

	local emitter = ParticleEmitter( vOffset )

	for i = 0, NumParticles do

		local particle = emitter:Add( "effects/spark", vOffset )
		if ( particle ) then

			particle:SetDieTime( 0.5 )

			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 0 )

			particle:SetStartSize( 1 )
			particle:SetEndSize( 0 )

			particle:SetRoll( math.Rand( 0, 360 ) )
			particle:SetRollDelta( math.Rand( -200, 200 ) )

			particle:SetAirResistance( 400 )

			particle:SetVelocity( VectorRand() * 50 )
			particle:SetGravity( Vector( 0, 0, 100 ) )

		end

	end

	emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
