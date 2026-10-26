--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/entities/entities/base_point.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


ENT.Base = "base_entity"
ENT.Type = "point"

--[[---------------------------------------------------------
	Name: Initialize
	Desc: First function called. Use to set up your entity
-----------------------------------------------------------]]
function ENT:Initialize()
end

--[[---------------------------------------------------------
	Name: KeyValue
	Desc: Called when a keyvalue is added to us
-----------------------------------------------------------]]
function ENT:KeyValue( key, value )
end

--[[---------------------------------------------------------
	Name: Think
	Desc: Entity's think function.
-----------------------------------------------------------]]
function ENT:Think()
end

--
--	Name: OnRemove
--	Desc: Called just before entity is deleted
--
function ENT:OnRemove()
end

--
--	UpdateTransmitState
--
function ENT:UpdateTransmitState()

	--
	-- The default behaviour for point entities is to not be networked.
	-- If you're deriving an entity and want it to appear clientside, override this
	-- TRANSMIT_ALWAYS = always send, TRANSMIT_PVS = send if in PVS
	--
	return TRANSMIT_NEVER

end
