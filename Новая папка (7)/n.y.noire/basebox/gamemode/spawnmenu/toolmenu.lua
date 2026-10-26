--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/toolmenu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


include( "toolpanel.lua" )

local PANEL = {}

--[[---------------------------------------------------------
	Name: Paint
-----------------------------------------------------------]]
function PANEL:Init()

	self.ToolPanels = {}

	self:LoadTools()

	self:SetFadeTime( 0 )

end

--[[---------------------------------------------------------
	LoadTools
-----------------------------------------------------------]]
function PANEL:LoadTools()

	local tools = spawnmenu.GetTools()

	for strName, pTable in pairs( tools ) do

		self:AddToolPanel( strName, pTable )

	end

end

--[[---------------------------------------------------------
	LoadTools
-----------------------------------------------------------]]
function PANEL:AddToolPanel( Name, ToolTable )

	-- I hate relying on a table's internal structure
	-- but this isn't really that avoidable.

	local Panel = vgui.Create( "ToolPanel" )
	Panel:SetTabID( Name )
	Panel:LoadToolsFromTable( ToolTable.Items )

	self:AddSheet( ToolTable.Label, Panel, ToolTable.Icon )
	self.ToolPanels[ Name ] = Panel

end

--[[---------------------------------------------------------
	Name: Paint
-----------------------------------------------------------]]
function PANEL:Paint( w, h )

	DPropertySheet.Paint( self, w, h )

end

--[[---------------------------------------------------------
	Name: GetToolPanel
-----------------------------------------------------------]]
function PANEL:GetToolPanel( id )

	return self.ToolPanels[ id ]

end

vgui.Register( "ToolMenu", PANEL, "DPropertySheet" )
