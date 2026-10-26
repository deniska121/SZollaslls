-- "addons\\mc_phone\\lua\\mc_phone\\modules\\settings.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
local module_id = 6
McPhone.Modules[module_id] = {}
McPhone.Modules[module_id].name = "Настройки"
McPhone.Modules[module_id].icon = "mc_phone/icons/main_menu/sets.png"

McPhone.Modules[module_id].openMenu = function()
	if not McPhone.UI or not McPhone.UI.Menu then return end
	local back = McPhone.UI.GoBack
	McPhone.UI.Menu.ConvertToList()
	local theme = McPhone[McPhone.UserCfg.PhoneType]
	local m_sets, m_themes, m_bgs, m_profile, m_tones, m_notif

	local function UpdatePanels(panel)
		panel.check = true

		for _, p in pairs(McPhone.UI.Menu:GetItems()) do
			if p == panel or not p.check then continue end
			p.check = false
		end
	end

	function m_sets()
		McPhone.UI.Menu:Clear(true)
		McPhone.StopSound()
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("settings")

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_5.png", McPhone.GetPhrase("background"), false, function()
			m_bgs()
			McPhone.UI.GoBack = m_sets
		end)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_3.png", McPhone.GetPhrase("profile"), false, function()
			m_profile()
			McPhone.UI.GoBack = m_sets
		end)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_1.png", McPhone.GetPhrase("ringtone"), false, function()
			m_tones()
			McPhone.UI.GoBack = m_sets
		end)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_2.png", "Уведомления", false, function()
			m_notif()
			McPhone.UI.GoBack = m_sets
		end)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_5.png", McPhone.GetPhrase("theme"), false, function()
			m_themes()
			McPhone.SetKey(1)
			McPhone.UI.GoBack = m_sets
		end)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_11.png", McPhone.GetPhrase("advanced"), false, function()
			McPhone.ClosePhone()
			McPhone.OpenConfigManager()
		end)

		McPhone.UI.GoBack = back
	end

	function m_themes()
		McPhone.UI.Menu:Clear(true)

		for name, th in SortedPairs(theme.Themes) do
			McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_5.png", McPhone.GetPhrase("Theme " .. name), McPhone.UserCfg.Theme == th or false, function(self)
				McPhone.UserCfg.Theme = th
				McPhone.UserCfg.Profile.PhoneColor = th["phone"]
				McPhone.UserCfg.WallPaper = theme.WallPapers[th["def_wp"]]
				McPhone.UserCfg.Profile.WallPaper = theme.WallPapers[th["def_wp"]]
				UpdatePanels(self)
				McPhone.SaveUserConfig()
			end, true, nil, true)
		end
	end

	function m_bgs()
		McPhone.UI.Menu:Clear(true)

		for name, bg in SortedPairs(theme.WallPapers) do
			McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_5.png", McPhone.GetPhrase(name), McPhone.UserCfg.WallPaper == bg or false, function(self)
				McPhone.UserCfg.WallPaper = bg
				McPhone.UserCfg.Profile.WallPaper = bg
				UpdatePanels(self)
				McPhone.SaveUserConfig()
			end, true, nil, true)
		end
	end

	function m_tones()
		McPhone.UI.Menu:Clear(true)

		for name, tone in pairs(theme.Ringtone) do
			local icon = "mc_phone/icons/settings/id_6.png"

			if not tone then
				icon = "mc_phone/icons/settings/id_7.png"
			end

			local t_name = McPhone.GetPhrase("ringtone") .. " " .. name

			if name == "Silent" then
				t_name = McPhone.GetPhrase("silent")
			end

			McPhone.ListIcons(McPhone.UI.Menu, icon, t_name, McPhone.UserCfg.Profile.Ringtone == tone or false, function(self)
				McPhone.UserCfg.Profile.Ringtone = tone
				UpdatePanels(self)
				McPhone.SaveUserConfig()
			end, true, tone and "mc_phone/ring/" .. tone or "stop", true)
		end
	end

	function m_profile()
		McPhone.UI.Menu:Clear(true)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_3.png", McPhone.GetPhrase("normal_mode"), not McPhone.UserCfg.Profile.Sleep, function(self)
			McPhone.UserCfg.Profile.Sleep = false
			UpdatePanels(self)
			McPhone.SaveUserConfig()
		end, true, nil, true)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_4.png", McPhone.GetPhrase("sleep_mode"), McPhone.UserCfg.Profile.Sleep, function(self)
			McPhone.UserCfg.Profile.Sleep = true
			UpdatePanels(self)
			McPhone.SaveUserConfig()
		end, true, nil, true)
	end

	function m_notif()
		McPhone.UI.Menu:Clear(true)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_6.png", "Включить", not McPhone.UserCfg.Profile.NoNotf, function(self)
			McPhone.UserCfg.Profile.NoNotf = false
			UpdatePanels(self)
			McPhone.SaveUserConfig()
		end, true, nil, true)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/settings/id_7.png", "Отключить", McPhone.UserCfg.Profile.NoNotf, function(self)
			McPhone.UserCfg.Profile.NoNotf = true
			UpdatePanels(self)
			McPhone.SaveUserConfig()
		end, true, nil, true)
	end

	m_sets()
end