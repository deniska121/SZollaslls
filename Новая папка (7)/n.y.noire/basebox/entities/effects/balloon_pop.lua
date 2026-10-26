--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/effects/balloon_pop.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


function EFFECT:Init( data )

	local vOffset = data:GetOrigin()
	local Color = data:GetStart()

	sound.Play( "garrysmod/balloon_pop_cute.wav", vOffset, 90, math.random( 90, 120 ) )

	local NumParticles = 32

	local emitter = ParticleEmitter( vOffset, true )

	for i = 0, NumParticles do

		local Pos = Vector( math.Rand( -1, 1 ), math.Rand( -1, 1 ), math.Rand( -1, 1 ) )

		local particle = emitter:Add( "particles/balloon_bit", vOffset + Pos * 8 )
		if ( particle ) then

			particle:SetVelocity( Pos * 500 )

			particle:SetLifeTime( 0 )
			particle:SetDieTime( 10 )

			particle:SetStartAlpha( 255 )
			particle:SetEndAlpha( 255 )

			local Size = math.Rand( 1, 3 )
			particle:SetStartSize( Size )
			particle:SetEndSize( 0 )

			particle:SetRoll( math.Rand( 0, 360 ) )
			particle:SetRollDelta( math.Rand( -2, 2 ) )

			particle:SetAirResistance( 100 )
			particle:SetGravity( Vector( 0, 0, -300 ) )

			local RandDarkness = math.Rand( 0.8, 1.0 )
			particle:SetColor( Color.r * RandDarkness, Color.g * RandDarkness, Color.b * RandDarkness )

			particle:SetCollide( true )

			particle:SetAngleVelocity( Angle( math.Rand( -160, 160 ), math.Rand( -160, 160 ), math.Rand( -160, 160 ) ) )

			particle:SetBounce( 1 )
			particle:SetLighting( true )

		end

	end

	emitter:Finish()

end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end
