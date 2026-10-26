--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/controls/ctrllistbox.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


local PANEL = {}

--AccessorFunc( PANEL, "m_ConVarR", "ConVarR" )

--[[---------------------------------------------------------
	Name: Init
-----------------------------------------------------------]]
function PANEL:Init()

	self.ConVars = {}
	self.Options = {}

end

--[[---------------------------------------------------------
	Name: AddOption
-----------------------------------------------------------]]
function PANEL:AddOption( strName, tabConVars )

	self:AddChoice( strName, tabConVars )

	for k, v in pairs( tabConVars ) do
		self.ConVars[ k ] = 1
	end

end

--[[---------------------------------------------------------
	Name: OnSelect
-----------------------------------------------------------]]
function PANEL:OnSelect( index, value, data )

	for k, v in pairs( data ) do

		RunConsoleCommand( k, tostring( v ) )

	end

end

--[[---------------------------------------------------------
	Name: Think
-----------------------------------------------------------]]
function PANEL:Think( CheckConvarChanges )

	self:CheckConVarChanges()

end

--[[---------------------------------------------------------
	Name: ConVarsChanged
-----------------------------------------------------------]]
function PANEL:ConVarsChanged()

	for k, v in pairs( self.ConVars ) do

		if ( self[ k ] == nil ) then return true end
		if ( self[ k ] != GetConVarString( k ) ) then return true end

	end

	return false

end

--[[---------------------------------------------------------
	Name: CheckForMatch
-----------------------------------------------------------]]
function PANEL:CheckForMatch( cvars )

	if ( table.IsEmpty( cvars ) ) then return false end

	for k, v in pairs( cvars ) do

		if ( tostring(v) != GetConVarString( k ) ) then
			return false
		end

	end

	return true

end

--[[---------------------------------------------------------
	Name: CheckConVarChanges
-----------------------------------------------------------]]
function PANEL:CheckConVarChanges()

	if (!self:ConVarsChanged()) then return end

	for k, v in pairs( self.ConVars ) do
		self[ k ] = GetConVarString( k )
	end

	for k, v in pairs( self.Data ) do

		if ( self:CheckForMatch( v ) ) then
			self:SetText( self:GetOptionText(k) )
			return
		end

	end

end

vgui.Register( "CtrlListBox", PANEL, "DComboBox" )
