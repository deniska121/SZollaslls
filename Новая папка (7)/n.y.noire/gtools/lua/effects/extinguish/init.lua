--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/extinguish/init.lua
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

	local scale = data:GetScale()

	for i = 1, 10 do
		local effect = target.hookah_ef:Add("effects/splash4", pos)
		effect:SetVelocity(target:GetAimVector() * 400)
		effect:SetDieTime(math.Rand(scale / 2, scale))
		effect:SetStartAlpha(0)
		effect:SetEndAlpha(math.Rand(50,150))
		effect:SetStartSize(math.Rand(5, 9))
		effect:SetEndSize(math.Rand(35, 40))
		effect:SetRoll( math.Rand(0, 360) )
		effect:SetRollDelta(math.Rand(-1, 1))
		effect:SetGravity(VectorRand() * 100)
		effect:SetCollide(true)
		effect:SetBounce(0.1)
		effect:SetAirResistance(20)
		effect:SetCollideCallback( function( particleC, HitPos, normal )
			particleC:SetAngleVelocity( Angle( 0, 0, 0 ) )
			particleC:SetVelocity( Vector( 0, 0, 0 ) )
			particleC:SetPos( HitPos + normal * 0.1 )
			particleC:SetGravity( Vector( 0, 0, 0 ) )

			local angles = normal:Angle()
			angles:RotateAroundAxis( normal, particleC:GetAngles().y )
			particleC:SetAngles( angles )

			particleC:SetLifeTime( 0 )
			particleC:SetDieTime( 10 )
			particleC:SetStartSize( 8 )
			particleC:SetEndSize( 0 )
			particleC:SetStartAlpha( 128 )
			particleC:SetEndAlpha( 0 )
		end )
	end
end

function EFFECT:Think()
	return false
end

function EFFECT:Render()
end