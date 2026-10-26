--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/creationmenu/content/contenttypes/postprocess.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


hook.Add( "PopulatePostProcess", "AddPostProcess", function( pnlContent, tree, node )

	-- Get a list of postproceess effects
	-- and organise them into categories
	local Categorised = {}
	local PostProcess = list.Get( "PostProcess" )

	if ( PostProcess ) then

		for k, v in pairs( PostProcess ) do

			local Category = v.category or "Other"
			if ( !isstring( Category ) ) then Category = tostring( Category ) end
			Categorised[ Category ] = Categorised[ Category ] or {}

			v.name = k
			table.insert( Categorised[ Category ], v )

		end

	end

	--
	-- Create an entry for each category
	--
	for CategoryName, v in SortedPairs( Categorised ) do

		-- Add a node to the tree
		local node = tree:AddNode( CategoryName, "icon16/picture.png" )

		-- When we click on the node - populate it using this function
		node.DoPopulate = function( self )

			-- If we've already populated it - forget it.
			if ( self.PropPanel ) then return end

			-- Create the container panel
			self.PropPanel = vgui.Create( "ContentContainer", pnlContent )
			self.PropPanel:SetVisible( false )
			self.PropPanel:SetTriggerSpawnlistChange( false )

			for k, pp in SortedPairsByMemberValue( v, "PrintName" ) do

				if ( pp.func ) then
					pp.func( self.PropPanel )
					continue
				end

				spawnmenu.CreateContentIcon( "postprocess", self.PropPanel, {
					name	= pp.name,
					icon	= pp.icon
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

spawnmenu.AddCreationTab( "#spawnmenu.category.postprocess", function()

	local ctrl = vgui.Create( "SpawnmenuContentPanel" )
	ctrl:CallPopulateHook( "PopulatePostProcess" )
	return ctrl

end, "icon16/picture.png", 100 )
