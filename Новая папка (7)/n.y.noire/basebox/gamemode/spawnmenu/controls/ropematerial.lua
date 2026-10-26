--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/controls/ropematerial.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


list.Set( "RopeMaterials", "#ropematerial.rope",		"cable/rope" )
list.Set( "RopeMaterials", "#ropematerial.cable",		"cable/cable2" )
list.Set( "RopeMaterials", "#ropematerial.xbeam",		"cable/xbeam" )
list.Set( "RopeMaterials", "#ropematerial.laser",		"cable/redlaser" )
list.Set( "RopeMaterials", "#ropematerial.electric",	"cable/blue_elec" )
list.Set( "RopeMaterials", "#ropematerial.physbeam",	"cable/physbeam" )
list.Set( "RopeMaterials", "#ropematerial.hydra",		"cable/hydra" )

local PANEL = {}

--[[---------------------------------------------------------
	Name: Paint
-----------------------------------------------------------]]
function PANEL:Init()

	self:SetItemWidth( 0.14 )
	self:SetItemHeight( 0.3 )
	self:SetAutoHeight( true )

	local mats = list.Get( "RopeMaterials" )
	for k, v in pairs( mats ) do

		self:AddMaterial( k, v )

	end

end

function PANEL:Paint( w, h )

	draw.RoundedBox( 4, 0, 0, w, h, Color( 128, 128, 128, 255 ) )

end

vgui.Register( "RopeMaterial", PANEL, "MatSelect" )
