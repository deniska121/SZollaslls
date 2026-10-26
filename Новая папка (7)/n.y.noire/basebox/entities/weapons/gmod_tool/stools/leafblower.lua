--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/weapons/gmod_tool/stools/leafblower.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


TOOL.AddToMenu = false

--
-- This tool is the most important aspect of Garry's Mod
--

TOOL.LeftClickAutomatic = true

function TOOL:LeftClick( trace )

	if ( CLIENT ) then return end

	util.PrecacheSound( "ambient/wind/wind_hit2.wav" )
	self:GetOwner():EmitSound( "ambient/wind/wind_hit2.wav" )

	if ( IsValid( trace.Entity ) && IsValid( trace.Entity:GetPhysicsObject() ) ) then

		local phys = trace.Entity:GetPhysicsObject()	-- The physics object
		local direction = trace.StartPos - trace.HitPos	-- The direction of the force
		local force = 32								-- The ideal amount of force
		local distance = direction:Length()				-- The distance the phys object is from the gun
		local maxdistance = 512							-- The max distance the gun should reach

		-- Lessen the force from a distance
		local ratio = math.Clamp( ( 1 - ( distance / maxdistance ) ), 0, 1 )

		-- Set up the 'real' force and the offset of the force
		local vForce = -direction * ( force * ratio )
		local vOffset = trace.HitPos

		-- Apply it!
		phys:ApplyForceOffset( vForce, vOffset )

	end

end
