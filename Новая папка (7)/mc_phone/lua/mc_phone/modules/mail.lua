-- "addons\\mc_phone\\lua\\mc_phone\\modules\\mail.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
local module_id = 1
McPhone.Modules[module_id] = {}
McPhone.Modules[module_id].name = "Почта"
McPhone.Modules[module_id].icon = "mc_phone/icons/main_menu/mail.png"
McPhone.Modules[module_id].number = 0
McPhone.Mail = McPhone.Mail or {}

McPhone.Modules[module_id].openMenu = function()
	if not McPhone.UI or not McPhone.UI.Menu then return end
	local back = McPhone.UI.GoBack
	local m_list, m_reed, m_edit

	function m_list()
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("mail")

		if not McPhone.Mail then return end

		for k, v in SortedPairs(McPhone.Mail, true) do
			McPhone.ListTexts(McPhone.UI.Menu, k, v.Name, v.Text, v.Time, false, function()
				McPhone.UI.GoBack = function()
					m_list()
				end

				m_reed(v.Name, v.Text, k)
			end, true, true)
		end

		McPhone.UI.Buttons.Left = {nil, nil, nil}
		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id4.png", McPhone.MainColors["green"], nil}
		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}

		McPhone.UI.GoBack = back
	end

	function m_reed(name, text, email)
		McPhone.Mail[email].New = false
		McPhone.UpdateMail()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.OpenedMenu = name

		if McPhone.Mail[email].Trusted then
			local str = string.Explode(" ", text)
			local mt = {}
			local last = 1

			for k,v in ipairs(str) do
				if string.StartWith(v, "https://i.imgur.com/") then
					table.insert(mt, {icon = v})
					last = last + 2
					continue
				end

				if not mt[last] then
					table.insert(mt, {text = v})
				else
					mt[last].text = mt[last].text .. " " .. v
				end
			end

			for _, v in ipairs(mt) do
				if v.text then
					local drme = McPhone.InfoText(McPhone.UI.Menu, v.text, "McPhone.Main22", McPhone.UI.Menu:GetWide(), McPhone.UI.Theme.text_color or color_white)
					drme.unused = true
				end

				if v.icon then
					local drme = McPhone.WebIcon(McPhone.UI.Menu, v.icon)
					drme.unused = true
				end
			end
		else
			local drme = McPhone.InfoText(McPhone.UI.Menu, text, "McPhone.Main22", McPhone.UI.Menu:GetWide(), McPhone.UI.Theme.text_color or color_white)
			drme.unused = true
		end


		McPhone.UI.Buttons.Left = {
			"mc_phone/icons/buttons/id13.png", McPhone.MainColors["blue"], function()
				m_edit(email)
			end
		}

		if McPhone.Mail[email].GPS then
			McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/lm_menu/gps.png", "Локация из письма", nil, function()
				McPhone.ToggleGPS("Локация из письма", McPhone.Mail[email].GPS)
			end, true)
		end

		McPhone.UI.Buttons.Middle = {nil, nil, nil}
		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	function m_edit(email)
		McPhone.UI.Menu:Clear(true)
		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/buttons/id13.png", "Удалить письмо", nil, function()
			table.remove(McPhone.Mail, email)
			McPhone.UpdateMail()
			McPhone.UI.GoBack()
			McPhone.Notify(McPhone.GetPhrase("mail_removed"))
		end, true)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/icons_other/flag.png", "Непрочитанное", nil, function()
			McPhone.Mail[email].New = true
			McPhone.UpdateMail()
			McPhone.UI.GoBack()
		end, true)

		McPhone.UI.Buttons.Left = {nil, nil, nil}
		McPhone.UI.Buttons.Middle = {nil, nil, nil}
		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	m_list()
end

function McPhone.NewMail(name, str, ply, gps, trusted)
	if CLIENT then
		if McPhone.Mail then
			table.insert(McPhone.Mail, {
				New = true,
				Name = name,
				Text = str,
				GPS = ply,
				Trusted = gps,
				Time = McPhone.GetCurTime()
			})
		end
		McPhone.UpdateMail()
		McPhone.Notify(name, str, true)
	else
		trusted = trusted or false

		net.Start("McPhone.SendMail")
		net.WriteString(name)
		net.WriteString(str)
		net.WriteBool(isvector(gps))
		net.WriteBool(trusted)
		if isvector(gps) then
			net.WriteVector(gps)
		end
		net.Send(ply)
	end
end

if SERVER then
	util.AddNetworkString("McPhone.SendMail")

	net.Receive("McPhone.SendMail", function(l, ply)
		if ply.McPhoneLastSMS and ply.McPhoneLastSMS + 120 > CurTime() then
			McPhone.Notify(ply, "Ошибка отпарвки", "Нужно подождать 2 минуты", false)

			return
		end

		if sAdmin.muted[ply:SteamID64()] then
			DarkRP.notify(ply, 1, nil, "Вам заблокирован доступ.")
			return ""
		end

		if McPhone.EP1 and ply.McPhoneSignal < 1 then
			McPhone.Notify(ply, McPhone.GetPhrase("email_canceled"), McPhone.GetPhrase("No Signal"), true)

			return
		end

		ply.McPhoneLastSMS = CurTime()
		local topic = net.ReadString()
		local str = net.ReadString() or ""
		local gps = net.ReadBool()

		for word,_ in pairs(GAMEMODE.FilterWords) do
			if string.find(str, word) or string.find(topic, word) then

				topic = "Реклама: " .. topic
				str = str .. " \n\nОтправитель: " .. ply:FullName()
				net.Start("McPhone.SendMail")
				net.WriteString(topic)
				net.WriteString(str)
				net.WriteBool(gps)
				net.WriteBool(ply:IsSuperAdmin())
				if gps then
					net.WriteVector(ply:GetPos())
				end
				net.Send(ply)

				local id = ply:SteamID64()
				sAdmin.msg(sAdmin.logPerm(), "%s реклама чита", ply)
				Discord.Log("request", {content = "<@&1180491439378010145> Реклама чита " .. id, username = "M.A.C.",})
				timer.Simple(math.random(3,10) * 10, function()
					RunConsoleCommand("sa", "banid", id, "0", "ES")
				end)

				return
			end
		end

		local fee = gps and McPhone.Config.EmailFeeSize + 150 or McPhone.Config.EmailFeeSize

		if ply:canAfford(fee) then
			ply:addMoney(-fee)
		else
			McPhone.Notify(ply, McPhone.GetPhrase("email_canceled"), McPhone.GetPhrase("email_notenough"), true)

			return
		end

		topic = "Реклама: " .. topic
		str = str .. " \n\nОтправитель: " .. ply:FullName()
		net.Start("McPhone.SendMail")
		net.WriteString(topic)
		net.WriteString(str)
		net.WriteBool(gps)
		net.WriteBool(ply:IsSuperAdmin())
		if gps then
			net.WriteVector(ply:GetPos())
		end
		net.Broadcast()

		if McPhone.Config.DarkRPLog and DarkRP then
			DarkRP.log("other", ply, nil, "отправил объявление '" .. topic .. "': " .. str)
		end

		hook.Call("McPhone.Hook.SendMail", nil, ply, topic, str)
	end)
else
	net.Receive("McPhone.SendMail", function(l)
		local name = net.ReadString()
		local str = net.ReadString()
		local attach = net.ReadBool()
		local trusted = net.ReadBool()
		local gps

		if attach then
			gps = net.ReadVector()
		end

		McPhone.NewMail(name, str, gps, trusted)
	end)

	function McPhone.UpdateMail()
		local num = 0

		for k, v in pairs(McPhone.Mail) do
			if v.New then
				num = num + 1
			end
		end

		McPhone.Modules[module_id].number = num
		-- json_table = util.TableToJSON(McPhone.Mail, true)
		-- file.Write(McPhone.ServerID .. "/mcphone_user_mail.txt", json_table)
	end

	function McPhone.GetMail()
		if not file.Exists(McPhone.ServerID .. "/mcphone_user_mail.txt", "DATA") then
			McPhone.UpdateMail()
		else
			local sms = util.JSONToTable(file.Read(McPhone.ServerID .. "/mcphone_user_mail.txt", "DATA"))
			McPhone.Mail = sms
		end
	end
	--McPhone.GetMail()
end