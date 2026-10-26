--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/entities/effects/dof_node.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


EFFECT.Mat = Material( "pp/dof" )

function EFFECT:Init( data )

	table.insert( DOF_Ents, self )
	self.Scale = data:GetScale()

	local size = 32
	self:SetCollisionBounds( Vector( -size, -size, -size ), Vector( size, size, size ) )

end

function EFFECT:Think()

	-- If the spacing or offset has changed we need to reconfigure our positions
	local ply = LocalPlayer()

	self.spacing = DOF_SPACING * self.Scale
	self.offset = DOF_OFFSET

	-- Just return if it hasn't
	--if ( spacing == self.spacing && offset == self.offset ) then return true end

	local pos = ply:EyePos()
	local fwd = ply:EyeAngles():Forward()

	if ( ply:GetViewEntity() != ply ) then
		pos = ply:GetViewEntity():GetPos()
		fwd = ply:GetViewEntity():GetForward()
	end

	pos = pos + ( fwd * self.spacing ) + ( fwd * self.offset )

	self:SetParent( nil )
	self:SetPos( pos )
	self:SetParent( ply )

	-- We don't kill this, the pp effect should
	return true

end

function EFFECT:Render()

	-- Note: UpdateScreenEffectTexture fucks up the water, RefractTexture is lower quality
	render.UpdateRefractTexture()
	--render.UpdateScreenEffectTexture()

	local SpriteSize = ( self.spacing + self.offset ) * 8

	render.SetMaterial( self.Mat )
	render.DrawSprite( self:GetPos(), SpriteSize, SpriteSize, color_white )

end
