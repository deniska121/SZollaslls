--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/creationmenu/content/contenttypes/weapons.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


hook.Add( "PopulateWeapons", "AddWeaponContent", function( pnlContent, tree, node )

	-- Loop through the weapons and add them to the menu
	local Weapons = list.Get( "Weapon" )
	local Categorised = {}

	-- Build into categories
	for k, weapon in pairs( Weapons ) do

		if ( !weapon.Spawnable ) then continue end

		local Category = weapon.Category or "Other2"
		if ( !isstring( Category ) ) then Category = tostring( Category ) end

		Categorised[ Category ] = Categorised[ Category ] or {}
		table.insert( Categorised[ Category ], weapon )

	end

	Weapons = nil

	-- Loop through each category
	for CategoryName, v in SortedPairs( Categorised ) do

		-- Add a node to the tree
		local node = tree:AddNode( CategoryName, "icon16/gun.png" )

		-- When we click on the node - populate it using this function
		node.DoPopulate = function( self )

			-- If we've already populated it - forget it.
			if ( self.PropPanel ) then return end

			-- Create the container panel
			self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
			self.PropPanel:SetVisible( false )
			self.PropPanel:SetTriggerSpawnlistChange( false )

			for k, ent in SortedPairsByMemberValue( v, "PrintName" ) do

				spawnmenu.CreateContentIcon( ent.ScriptedEntityType or "weapon", self.PropPanel, {
					nicename	= ent.PrintName or ent.ClassName,
					spawnname	= ent.ClassName,
					material	= ent.IconOverride or "entities/" .. ent.ClassName .. ".png",
					admin		= ent.AdminOnly
				} )

			end

		end

		-- If we click on the node populate it and switch to it.
		node.DoClick = function( self )

			self:DoPopulate()
			pnlContent:SwitchPanel( self.PropPanel )

		end

	end

	-- Select the first node
	local FirstNode = tree:Root():GetChildNode( 0 )
	if ( IsValid( FirstNode ) ) then
		FirstNode:InternalDoClick()
	end

end )

spawnmenu.AddCreationTab( "#spawnmenu.category.weapons", function()

	local ctrl = vgui.Create( "SpawnmenuContentPanel" )
	ctrl:EnableSearch( "weapons", "PopulateWeapons" )
	ctrl:CallPopulateHook( "PopulateWeapons" )
	return ctrl

end, "icon16/gun.png", 10 )
