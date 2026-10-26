--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/entities/effects/base.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


--[[---------------------------------------------------------
	Returns the right shoot start position for a tracer - based on 'data'.
-----------------------------------------------------------]]
function EFFECT:GetTracerShootPos( Position, Ent, Attachment )

	self.ViewModelTracer = false

	if ( !IsValid( Ent ) ) then return Position end
	if ( !Ent:IsWeapon() ) then return Position end

	-- Shoot from the viewmodel
	if ( Ent:IsCarriedByLocalPlayer() && !LocalPlayer():ShouldDrawLocalPlayer() ) then

		local ViewModel = LocalPlayer():GetViewModel()

		if ( ViewModel:IsValid() ) then

			local att = ViewModel:GetAttachment( Attachment )
			if ( att ) then
				Position = att.Pos
				self.ViewModelTracer = true
			end

		end

	-- Shoot from the world model
	else

		local att = Ent:GetAttachment( Attachment )
		if ( att ) then
			Position = att.Pos
		end

	end

	return Position

end
