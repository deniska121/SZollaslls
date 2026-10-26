--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/client/cl_spawnmenu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
if (SERVER) then return end

local function createSpawnIcon(w, propPanel)
	return spawnmenu.CreateContentIcon(w.ScriptedEntityType or "weapon", propPanel, {
		nicename = w.PrintName or w.ClassName,
		spawnname = w.ClassName,
		material = w.IconOverride or "entities/" .. w.ClassName .. ".png",
		admin = w.AdminOnly
	})
end

hook.Add("PopulateWeapons", "AddWeaponContentMW19", function(pnlContent, tree, node)
	local weaponsList = list.Get("Weapon")
	local mgbaseWeapons = {}

	--look into every weapon and see if they're from mgbase
	for _, weapon in pairs(weaponsList) do
		if (weapons.IsBasedOn(weapon.ClassName, "mg_base") or weapon.ClassName == "mw_infil_flare") then
			if (mgbaseWeapons[weapon.Category] == nil) then
				mgbaseWeapons[weapon.Category] = {}
			end

			--keep them for later if so
			table.insert(mgbaseWeapons[weapon.Category], weapon)
		end
	end

	--loop through all weapon categories
	for _, categoryNode in pairs(tree:Root():GetChildNodes()) do
		--if the text matches the categories we saved before we replace DoPopulate
		if (mgbaseWeapons[categoryNode:GetText()] ~= nil) then
			local manifest = {
				["Other"] = {} --default header
			}

			--order them by subcategory
			for _, weapon in pairs(mgbaseWeapons[categoryNode:GetText()]) do
				--get weapon from storeds
				local actualWeapon = weapons.Get(weapon.ClassName)

				if (actualWeapon.SubCategory == nil) then
					table.insert(manifest["Other"], weapon)
				else
					if (manifest[actualWeapon.SubCategory] == nil) then
						manifest[actualWeapon.SubCategory] = {}
					end

					table.insert(manifest[actualWeapon.SubCategory], weapon)
				end
			end

			categoryNode.DoPopulate = function(self)
				if (self.PropPanel) then return end

				self.PropPanel = vgui.Create("ContentContainer", pnlContent)
				self.PropPanel:SetVisible(false)
				self.PropPanel:SetTriggerSpawnlistChange(false)

				for categoryName, weps in SortedPairs(manifest) do
					if (#weps <= 0) then continue end
					--create header
					local label = vgui.Create("ContentHeader", container)
					label:SetText(categoryName)
					self.PropPanel:Add(label)

					--this is copy from gmod
					for _, ent in SortedPairsByMemberValue(weps, "PrintName") do
						local icon = createSpawnIcon(ent, self.PropPanel)

						local oldMenuExtra = icon.OpenMenuExtra

						icon.OpenMenuExtra = function(icon, menu)
							oldMenuExtra(icon, menu)
							local weaponsBasedOnMe = {}

							--blueprints
							for _, w in pairs(weaponsList) do
								if (weapons.IsBasedOn(w.ClassName, ent.ClassName)) then
									weaponsBasedOnMe[#weaponsBasedOnMe + 1] = w
								end
							end

							if (#weaponsBasedOnMe > 0) then
								menu:AddSpacer()
								local grid = vgui.Create("DGrid")
								grid:SetCols(math.min(#weaponsBasedOnMe, 3))
								grid:SetColWide(icon:GetWide())
								grid:SetRowHeight(icon:GetTall())

								for _, w in pairs(weaponsBasedOnMe) do
									local subIcon = createSpawnIcon(w, menu)

									subIcon.DoRightClick = function() end
									grid:AddItem(subIcon)
								end

								menu:AddPanel(grid)
							end
						end
					end
				end
			end
		end
	end
end)