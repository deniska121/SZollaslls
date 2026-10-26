--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/creationmenu/content/contenttypes/addonprops.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function AddRecursive(pnl, folder, path, wildcard)
	local files, folders = file.Find(folder .. "*", path)

	if (not files) then
		MsgN("Warning! Not opening '" .. folder .. "' because we cannot search in it!")

		return false
	end

	local added = false

	for k, v in pairs(files) do
		if (not string.EndsWith(v, ".mdl")) then continue end
		local cp = spawnmenu.GetContentType("model")

		if (cp) then
			cp(pnl, {
				model = folder .. v
			})

			added = true
		end
	end

	for k, v in pairs(folders) do
		local added_rec = AddRecursive(pnl, folder .. v .. "/", path, wildcard)
		added = added or added_rec
	end

	return added
end

local function AddonsRightClick(self)
	if (not IsValid(self) or not self.wsid or self.wsid == "0") then return end
	local menu = DermaMenu()

	menu:AddOption("#spawnmenu.openaddononworkshop", function()
		steamworks.ViewFile(self.wsid)
	end):SetIcon("icon16/link_go.png")

	menu:Open()
end

local function RefreshAddons(MyNode)
	local ViewPanel = MyNode.ViewPanel

	local models = MyNode:AddNode("AAA unioncity2", "icon16/bricks.png")
	models.DoClick = function()
		ViewPanel:Clear(true)
		local anyAdded = AddRecursive(ViewPanel, "models/unioncity2/", "GAME", "*.mdl")
		MyNode.pnlContent:SwitchPanel(ViewPanel)
	end

	local models = MyNode:AddNode("AAA uc", "icon16/bricks.png")
	models.DoClick = function()
		ViewPanel:Clear(true)
		local anyAdded = AddRecursive(ViewPanel, "models/uc/", "GAME", "*.mdl")
		MyNode.pnlContent:SwitchPanel(ViewPanel)
	end

	for _, addon in SortedPairsByMemberValue(engine.GetAddons(), "title") do
		if (not addon.downloaded or not addon.mounted) then continue end
		if (addon.models <= 0) then continue end
		local models = MyNode:AddNode(addon.title .. " (" .. addon.models .. ")", "icon16/bricks.png")

		models.DoClick = function()
			ViewPanel:Clear(true)
			local anyAdded = AddRecursive(ViewPanel, "models/", addon.title, "*.mdl")

			if (not anyAdded) then
				local cp = spawnmenu.GetContentType("header")

				if (cp) then
					cp(ViewPanel, {
						text = "#spawnmenu.failedtofindmodels"
					})
				end

				-- For debugging
				local cp = spawnmenu.GetContentType("header")

				if (cp) then
					cp(ViewPanel, {
						text = tostring(addon.title) .. " (ID: " .. tostring(addon.wsid) .. ")"
					})
				end
			end

			MyNode.pnlContent:SwitchPanel(ViewPanel)
		end

		models.DoRightClick = AddonsRightClick
		models.wsid = addon.wsid
	end
end

local myAddonsNode

hook.Add("PopulateContent", "AddonProps", function(pnlContent, tree, node)
	if not sAdmin.hasPermission(LocalPlayer(), "propspawn") then return end
	local myViewPanel = vgui.Create("ContentContainer", pnlContent)
	myViewPanel:SetVisible(false)
	myViewPanel.IconList:SetReadOnly(true)
	myAddonsNode = node:AddNode("#spawnmenu.category.addons", "icon16/folder_database.png")
	myAddonsNode.ViewPanel = myViewPanel
	myAddonsNode.pnlContent = pnlContent
	RefreshAddons(myAddonsNode)
end)

hook.Add("GameContentChanged", "RefreshSpawnmenuAddons", function()
	if not sAdmin.hasPermission(LocalPlayer(), "propspawn") then return end
	if (not IsValid(myAddonsNode)) then return end
	-- TODO: Maybe be more advaced and do not delete => recreate all the nodes, only delete nodes for addons that were removed, add only the new ones?
	myAddonsNode:Clear()
	myAddonsNode.ViewPanel:Clear(true)
	RefreshAddons(myAddonsNode)
end)