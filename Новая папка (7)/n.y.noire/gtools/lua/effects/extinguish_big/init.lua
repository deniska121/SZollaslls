--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/extinguish_big/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function EFFECT:Init( data )
	local target = data:GetEntity()
	if not target or not IsValid(target) or not target:IsPlayer() or not target:Alive() then return end

	local pos = self:GetTracerShootPos( data:GetOrigin(), data:GetEntity():GetActiveWeapon(), 1 )

	if not target.hookah_ef then
		target.hookah_ef = ParticleEmitter(target:GetPos())
	end

	--particle\water\waterdrop_001a_additive.vmt
	--particle\particle_glow_03.vmt
	local scale = data:GetScale()

	for i = -3, 7 do
		local effect = target.hookah_ef:Add("particle/water/waterdrop_001a_additive", pos + data:GetNormal() * i * math.random(5, 3) + VectorRand())
		effect:SetVelocity(target:GetAimVector() * 1000)
		effect:SetDieTime(1)
		effect:SetStartAlpha(math.random(50,150))
		effect:SetEndAlpha(0)
		effect:SetStartSize(8)
		effect:SetEndSize(math.random(25, 50))
		effect:SetRoll( math.random(0, 360) )
		effect:SetRollDelta(math.Rand(-1, 1))
		effect:SetStartLength(15)
		effect:SetEndLength(15)
		effect:SetGravity(Vector(0,0,-50 - (5000 - 5000 * scale)))
		effect:SetCollide(true)
		effect:SetBounce(0.1)
		effect:SetAirResistance(20)
		effect:SetCollideCallback( function( particleC, HitPos, normal )
			particleC:SetDieTime( 0 )
		end)
	end

	for i = 1, 5 do
		local effect = target.hookah_ef:Add("particle/particle_glow_03", pos + VectorRand() * i)
		effect:SetVelocity(target:GetAimVector() * 400)
		effect:SetDieTime(1.1)
		effect:SetStartAlpha(math.Rand(1, 4))
		effect:SetEndAlpha(0)
		effect:SetStartSize(math.random(13, 16))
		effect:SetEndSize(math.random(15, 17))
		effect:SetRoll( math.random(0, 360) )
		effect:SetRollDelta(math.Rand(-1, 1))
		effect:SetGravity(VectorRand() + Vector(0,0,-10 - (1000 - 1000 * scale)))
		effect:SetCollide(true)
		effect:SetBounce(0.1)
		effect:SetAirResistance(20)
		effect:SetCollideCallback( function( particleC, HitPos, normal )
			local angles = normal:Angle()
			angles:RotateAroundAxis( normal, particleC:GetAngles().y )
			particleC:SetAngles( angles )

			particleC:SetLifeTime( 0 )
			particleC:SetDieTime( 1 )
			particleC:SetStartSize( math.random(15, 17) )
			particleC:SetEndSize( math.random(25, 32) )
			particleC:SetStartAlpha( 2 )
			particleC:SetEndAlpha( 0 )
		end )
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end