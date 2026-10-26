--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/gamemode/cl_targetid.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


--[[---------------------------------------------------------
   Name: gamemode:HUDDrawTargetID( )
   Desc: Draw the target id (the name of the player you're currently looking at)
-----------------------------------------------------------]]
function GM:HUDDrawTargetID()

	local trace = LocalPlayer():GetEyeTrace()
	if ( !trace.Hit ) then return end
	if ( !trace.HitNonWorld ) then return end

	local text = "ERROR"
	local font = "TargetID"

	if ( trace.Entity:IsPlayer() ) then
		text = trace.Entity:Nick()
	else
		--text = trace.Entity:GetClass()
		return
	end

	surface.SetFont( font )
	local w, h = surface.GetTextSize( text )

	local MouseX, MouseY = input.GetCursorPos()

	if ( MouseX == 0 && MouseY == 0 || !vgui.CursorVisible() ) then

		MouseX = ScrW() / 2
		MouseY = ScrH() / 2

	end

	local x = MouseX
	local y = MouseY

	x = x - w / 2
	y = y + 30

	-- The fonts internal drop shadow looks lousy with AA on
	draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
	draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )

	y = y + h + 5

	-- Draw the health
	text = trace.Entity:Health() .. "%"
	font = "TargetIDSmall"

	surface.SetFont( font )
	w, h = surface.GetTextSize( text )
	x = MouseX - w / 2

	draw.SimpleText( text, font, x + 1, y + 1, Color( 0, 0, 0, 120 ) )
	draw.SimpleText( text, font, x + 2, y + 2, Color( 0, 0, 0, 50 ) )
	draw.SimpleText( text, font, x, y, self:GetTeamColor( trace.Entity ) )

end
