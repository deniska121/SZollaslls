--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/effects/sw_rainsplash/init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function EFFECT:Init( data )
	
	if( SW.Emitter2D ) then
		
		local p = SW.Emitter2D:Add( "simpleweather/snow", data:GetOrigin() );
		
		p:SetDieTime( 0.5 );
		p:SetStartAlpha( 15 );
		p:SetEndAlpha( 0 );
		p:SetStartSize( 2 );
		p:SetEndSize( 2 );
		p:SetColor( 255, 255, 255 );
		
	end
	
end

function EFFECT:Think()
	
	return false;
	
end

function EFFECT:Render()
	
	
	
end
