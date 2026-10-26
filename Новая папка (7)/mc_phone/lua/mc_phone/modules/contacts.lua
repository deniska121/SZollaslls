-- "addons\\mc_phone\\lua\\mc_phone\\modules\\contacts.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
local module_id = 5
McPhone.Modules[module_id] = {}
McPhone.Modules[module_id].name = "Контакты"
McPhone.Modules[module_id].icon = "mc_phone/icons/main_menu/cont.png"

McPhone.CallLog = McPhone.CallLog or {}

McPhone.Modules[module_id].openMenu = function()
	local ply = LocalPlayer()
	if not McPhone.UI or not McPhone.UI.Menu then return end
	local back = McPhone.UI.GoBack
	local m_list, m_number, m_manage, m_logs

	function m_list()
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("contacts")
		local num = McPhone.NumberChar(ply)

		McPhone.ListSimple(McPhone.UI.Menu, McPhone.GetPhrase("my_num"), string.sub(num, 1, 3) .. "-" .. string.sub(num, 4, 7), "mc_phone/icons/buttons/id14.png", function()
			SetClipboardText(num)
			McPhone.Notify(McPhone.GetPhrase("text_copy"))
		end, true)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/buttons/id17.png", "Недавние звонки", false, function()
			m_logs()
			McPhone.UI.GoBack = m_list
		end)

		if not McPhone.Config.GlobalContacts then
			McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/buttons/id3.png", McPhone.GetPhrase("manage_conts"), false, function()
				m_manage()
				McPhone.UI.GoBack = m_list
			end)
		end

		if McPhone.ExtraNumbers then
			for k, v in pairs(McPhone.ExtraNumbers) do
				if not v.addtocontacts then continue end
				if v.checkNumber and v.checkNumber(LocalPlayer()) then continue end
				McPhone.ListIcons(McPhone.UI.Menu, v.icon, v.nicename, false, function()
					local number = k
					McPhone.LastNumber = number
					local lastcall = number

					if lastcall then
						McPhone.LastNumber = lastcall
					end
					table.insert(McPhone.CallLog, {number, os.time(), "out"})
					net.Start("McPhone.CallStart")
					net.WriteString(number)
					net.WriteBool(false)
					net.SendToServer()
				end)
			end
		end

		for k, v in pairs(McPhone.Contacts) do
			local pl = McPhone.GetByNumber(k)

			if not IsValid(pl) then
				McPhone.ListIcons(McPhone.UI.Menu, {"mc_phone/icons/contact.png", true}, v, false, function()
					local number = k
					McPhone.LastNumber = number
					table.insert(McPhone.CallLog, {number, os.time(), "out"})
					net.Start("McPhone.CallStart")
					net.WriteString(number)
					net.WriteBool(false)
					net.SendToServer()
				end)
				continue
			end

			McPhone.ListIcons(McPhone.UI.Menu, {"mc_phone/icons/contact.png", true}, pl:Name(), false, function()
				local number = k

				McPhone.LastNumber = number
				local lastcall = McPhone.GetByNumber(number)

				if lastcall then
					McPhone.LastNumber = lastcall
				end
				table.insert(McPhone.CallLog, {number, os.time(), "out"})
				net.Start("McPhone.CallStart")
				net.WriteString(number)
				net.WriteBool(false)
				net.SendToServer()
			end)
		end


		McPhone.UI.Buttons.Left = {
			"mc_phone/icons/buttons/id10.png", McPhone.MainColors["blue"], function()
				McPhone.UI.OpenedMenu = ""
				m_number()
				McPhone.UI.GoBack = m_list
			end
		}

		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id17.png", McPhone.MainColors["green"], nil}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}

		McPhone.UI.GoBack = back
	end

	function m_logs()
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("manage_conts")

		for k, v in SortedPairs(McPhone.CallLog, true) do
			--local pl = McPhone.GetByNumber(v[1])

			McPhone.ListSimple(McPhone.UI.Menu, McPhone.Contacts[v[1]] or v[1], os.date("%H:%M", v[2]), v[3] == "in" and MSD.Icons48.arrow_down or MSD.Icons48.arrow_up, function()
				local number = v[1]
				McPhone.LastNumber = number
				table.insert(McPhone.CallLog, {number, os.time(), "out"})
				net.Start("McPhone.CallStart")
				net.WriteString(number)
				net.WriteBool(false)
				net.SendToServer()
			end, true)
			-- if not IsValid(pl) then
			-- 	McPhone.ListIcons(McPhone.UI.Menu, {"mc_phone/icons/contact.png", true}, v[1], false, function()
			-- 		local number = v[1]
			-- 		McPhone.LastNumber = number
			-- 		table.insert(McPhone.CallLog, {number, os.time, "out"})
			-- 		net.Start("McPhone.CallStart")
			-- 		net.WriteString(number)
			-- 		net.WriteBool(false)
			-- 		net.SendToServer()
			-- 	end)
			-- 	continue
			-- end

			-- McPhone.ListIcons(McPhone.UI.Menu, {"mc_phone/icons/contact.png", true}, v[1], false, function()
			-- 	local number = k

			-- 	McPhone.LastNumber = number
			-- 	local lastcall = McPhone.GetByNumber(number)

			-- 	if lastcall then
			-- 		McPhone.LastNumber = lastcall
			-- 	end
			-- 	table.insert(McPhone.CallLog, {number, os.time, "out"})
			-- 	net.Start("McPhone.CallStart")
			-- 	net.WriteString(number)
			-- 	net.WriteBool(false)
			-- 	net.SendToServer()
			-- end)
		end

		McPhone.UI.Buttons.Left = {nil, nil, nil}

		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id13.png", McPhone.MainColors["green"], nil}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}

		McPhone.UI.GoBack = back
	end

	function m_manage()
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("manage_conts")

		for k, v in pairs(McPhone.Contacts) do
			local pl = McPhone.GetByNumber(k)

			if pl and IsValid(pl) then
				McPhone.ListIcons(McPhone.UI.Menu, {"mc_phone/icons/contact.png", true}, pl:Name(), false, function()
					McPhone.RemoveContacts(k)
					McPhone.GetContacts()
					m_manage()
				end)
			else
				McPhone.ListIcons(McPhone.UI.Menu, {"mc_phone/icons/contact.png", true}, v, false, function()
					McPhone.RemoveContacts(k)
					McPhone.GetContacts()
					m_manage()
				end)
			end
		end

		McPhone.UI.Buttons.Left = {nil, nil, nil}

		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id13.png", McPhone.MainColors["green"], nil}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}

		McPhone.UI.GoBack = back
	end

	function m_number()
		local phone_table = McPhone.PhoneTypes[McPhone.UserCfg.PhoneType]

		if not phone_table then
			phone_table = McPhone.PhoneTypes.McPhone
		end

		if phone_table.NumberMenu then
			phone_table.NumberMenu(back)
			return
		end

		McPhone.UI.Menu.ConvertToMenu()
		McPhone.UI.Menu:SetSize(270, 256)
		McPhone.UI.Menu:SetPos(phone_table.spos[1], phone_table.spos[2] + 69)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "1", nil, KEY_PAD_1)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "2", "ABC", KEY_PAD_2)
		McPhone.NumberIcons(McPhone.UI.Menu, 86, "3", "DEF", KEY_PAD_3)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "4", "GHI", KEY_PAD_4)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "5", "JKL", KEY_PAD_5)
		McPhone.NumberIcons(McPhone.UI.Menu, 86, "6", "MNO", KEY_PAD_6)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "7", "PQRS", KEY_PAD_7)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "8", "TUV", KEY_PAD_8)
		McPhone.NumberIcons(McPhone.UI.Menu, 86, "9", "WXYZ", KEY_PAD_9)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "*", nil, KEY_PAD_MULTIPLY)
		McPhone.NumberIcons(McPhone.UI.Menu, 85, "0", nil, KEY_PAD_0)
		McPhone.NumberIcons(McPhone.UI.Menu, 86, "#", nil, KEY_PAD_DIVIDE)

		McPhone.UI.Buttons.Left = {
			"mc_phone/icons/buttons/id17.png", McPhone.MainColors["blue"], function()
				local number = McPhone.UI.OpenedMenu
				if number == "" then return end
				McPhone.LastNumber = number
				local lastcall = McPhone.GetByNumber(number)

				if IsValid(lastcall) and lastcall ~= ply then
					McPhone.LastNumber = lastcall
					--McPhone.AddContacts(number, lastcall:Name())
				end
				table.insert(McPhone.CallLog, {number, os.time(), "out"})
				net.Start("McPhone.CallStart")
				net.WriteString(number)
				net.WriteBool(false)
				net.SendToServer()
			end
		}

		McPhone.UI.Buttons.Middle = {
			"mc_phone/icons/buttons/id4.png", McPhone.MainColors["green"], function()
				local number = McPhone.UI.OpenedMenu
				if number == "" then return false end
				if McPhone.ExtraNumbers[number] then return false end
				if McPhone.Contacts[number] then return false end
				local lastcall = McPhone.GetByNumber(number)

				if IsValid(lastcall) and lastcall ~= ply then
					lastcall = lastcall:Name()
				else
					lastcall = number
				end

				McPhone.AddContacts(number, lastcall, true)

				return false
			end,
			true
		}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], function()
			if McPhone.UI.OpenedMenu == "" then
				McPhone.UI.GoBack()
				return
			end
			local num = McPhone.UI.OpenedMenu
			McPhone.UI.OpenedMenu = utf8.sub(num, 1, utf8.len(num) - 1)
			return false
		end}
	end

	m_list()
end