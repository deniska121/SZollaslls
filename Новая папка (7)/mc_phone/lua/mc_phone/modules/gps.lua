-- "addons\\mc_phone\\lua\\mc_phone\\modules\\gps.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
local module_id = 3
McPhone.Modules[module_id] = {}
McPhone.Modules[module_id].name = McPhone.GetPhrase("GPS")
McPhone.Modules[module_id].icon = "mc_phone/icons/main_menu/gps.png"

McPhone.Modules[module_id].openMenu = function()
	if not McPhone.UI or not McPhone.UI.Menu then return end
	local m_list, m_active

	function m_list()
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("GPS")

		for k,v in pairs(Territories.list) do
			if not v.buyable then continue end
			local data = McPhone.ter_list[k]
			if not data then continue end
			if data.masterOwner ~= LocalPlayer() then continue end

			local point = v.gps_point or v.coords[1]
			McPhone.ListNoIcons(McPhone.UI.Menu, v.printName, function()
				McPhone.ToggleGPS(v.printName, point)

				McPhone.GPSMenuRebuild = function()
					m_list()
				end

				m_active()
			end, true)
		end

		if McPhone.Config.GPSList[game.GetMap()] then
			for k, v in SortedPairs(McPhone.Config.GPSList[game.GetMap()], false) do
				McPhone.ListNoIcons(McPhone.UI.Menu, k, function()
					McPhone.ToggleGPS(k, v)

					McPhone.GPSMenuRebuild = function()
						m_list()
					end

					m_active()
				end, true)
			end
		end

		McPhone.UI.Buttons.Left = {nil, nil, nil}

		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id4.png", McPhone.MainColors["green"], nil}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	function m_active()
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.OpenedMenu = McPhone.IsGPSOn

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/buttons/id15.png", McPhone.GetPhrase("stop_gps"), false, function()
			McPhone.ToggleGPS()
		end, true)
	end

	if McPhone.IsGPSOn then
		m_active()
	else
		m_list()
	end
end