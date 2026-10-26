--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/effects/wheel_indicator.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


EFFECT.Mat = Material( "effects/wheel_ring" )

function EFFECT:Init( data )

	self.Wheel = data:GetEntity()
	if ( !IsValid( self.Wheel ) ) then return end

	self.Axis = data:GetOrigin() / 100 -- see gmod_wheel.lua
	self.Direction = data:GetScale()

	-- This 0.01 is a hack.. to prevent the angle being weird and messing up when we change it back to a normal
	-- Removed, we are never even setting the normal on effect data
	--self:SetAngles( data:GetNormal():Angle() + Angle( 0.01, 0.01, 0.01 ) )

	self.Alpha = 1

	self.Size = self.Wheel:BoundingRadius() + 8

	self:SetPos( self.Wheel:LocalToWorld( self.Axis ) )
	self:SetParent( self.Wheel )

	local size = 64
	self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )
end

function EFFECT:Think()

	if ( !IsValid( self.Wheel ) ) then return false end

	local speed = FrameTime()

	self.Alpha = self.Alpha - speed * 0.8
	self.Size = self.Size + speed * 5

	if ( self.Alpha < 0 ) then return false end

	return true

end

function EFFECT:Render()

	if ( !IsValid( self.Wheel ) ) then return end
	if ( self.Alpha < 0 ) then return end

	render.SetMaterial( self.Mat )

	local offset = self.Wheel:LocalToWorld( self.Axis ) - self.Wheel:GetPos()

	render.DrawQuadEasy( self.Wheel:GetPos() + offset,
						 offset:GetNormalized() * self.Direction,
						 self.Size, self.Size,
						 Color( 255, 255, 255, ( self.Alpha ^ 1.1 ) * 255 ),
						 self.Alpha * 200 )

end
