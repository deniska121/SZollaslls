-- "addons\\mc_phone\\lua\\mc_phone\\modules\\sms.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
local module_id = 2
McPhone.Modules[module_id] = {}
McPhone.Modules[module_id].name = "Сообщения"
McPhone.Modules[module_id].icon = "mc_phone/icons/main_menu/sms.png"
McPhone.Modules[module_id].number = 0
McPhone.SMS = {}

McPhone.Modules[module_id].openMenu = function()
	if not McPhone.UI or not McPhone.UI.Menu then return end
	local back = McPhone.UI.GoBack
	local m_list, m_numbers, m_send, m_reed, m_edit

	function m_list()
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("texts")

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/buttons/id5.png", "Написать СМС", nil, function()
			m_numbers()
			McPhone.UI.GoBack = function()
				m_list()
			end
		end, true)

		for k, v in SortedPairs(McPhone.SMS, true) do
			McPhone.ListTexts(McPhone.UI.Menu, k, v.Name, v.Text, v.Time, false, function()
				McPhone.UI.GoBack = function()
					m_list()
				end

				m_reed(v.Name, v.Text, k)
			end, false, true)
		end

		McPhone.UI.Buttons.Left = {
			"mc_phone/icons/buttons/id5.png", McPhone.MainColors["blue"], function()
				m_numbers()

				McPhone.UI.GoBack = function()
					m_list()
				end
			end
		}

		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id4.png", McPhone.MainColors["green"], nil}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}

		McPhone.UI.GoBack = back
	end

	function m_reed(name, text, sms)
		McPhone.SMS[sms].New = false
		McPhone.UpdateSMS()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.OpenedMenu = name

		local drme = McPhone.InfoText(McPhone.UI.Menu, text, "McPhone.Main22", McPhone.UI.Menu:GetWide(), McPhone.UI.Theme.text_color or color_white)
		drme.unused = true

		McPhone.UI.Buttons.Left = {
			"mc_phone/icons/buttons/id13.png", McPhone.MainColors["blue"], function()
				m_edit(sms)
			end
		}

		if McPhone.SMS[sms].GPS then
			McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/lm_menu/gps.png", "Локация из СМС", nil, function()
				McPhone.ToggleGPS("Локация из СМС", McPhone.SMS[sms].GPS)
			end, true)
		end

		McPhone.UI.Buttons.Middle = {nil, nil, nil}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	function m_edit(sms)
		McPhone.UI.Menu:Clear(true)
		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/buttons/id13.png", "Удалить СМС", nil, function()
			table.remove(McPhone.SMS, sms)
			McPhone.UpdateSMS()
			McPhone.UI.GoBack()
			McPhone.Notify(McPhone.GetPhrase("mail_removed"))
		end, true)

		McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/icons_other/flag.png", "Непрочитанное", nil, function()
			McPhone.SMS[sms].New = true
			McPhone.UpdateSMS()
			McPhone.UI.GoBack()
		end, true)

		McPhone.UI.Buttons.Left = {nil, nil, nil}
		McPhone.UI.Buttons.Middle = {nil, nil, nil}
		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	function m_numbers()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.OpenedMenu = McPhone.GetPhrase("texts")


		for k, v in pairs(McPhone.Contacts) do
			local pl = McPhone.GetByNumber(k)
			McPhone.ListIcons(McPhone.UI.Menu, "mc_phone/icons/contact.png", v or k, false, function()
				m_send(pl, k, v)
				McPhone.UI.GoBack = m_numbers
			end)
		end

		McPhone.UI.GoBack = function()
			m_list()
		end

		McPhone.UI.Buttons.Left = {nil, nil, nil}
		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id4.png", McPhone.MainColors["green"], nil}
		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	function m_send(pl, k, v)
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.OpenedMenu = v
		local frame = vgui.Create("DPanel")
		frame:SetSize(256, 256)
		frame.unused = true
		frame.Chasher = true
		McPhone.UI.Menu:AddItem(frame)
		local x, y = frame:LocalToScreen(0, 0)
		local panel = vgui.Create("DFrame")
		panel:SetPos(x, y)
		panel:SetSize(256, 256)
		panel:SetTitle("")
		panel:SetDraggable(false)
		panel:ShowCloseButton(false)
		panel:MakePopup()
		panel.Paint = function() end

		panel.Think = function()
			if not McPhone.UI or not McPhone.UI.Menu:GetItems()[1] or not McPhone.UI.Menu:GetItems()[1].Chasher then
				panel:Remove()
			end

			if x < 1 then
				x, y = frame:LocalToScreen(0, 0)
				panel:SetPos(x, y)
			end
		end

		local drme = vgui.Create("DTextEntry", panel)
		drme:SetText("")
		drme:SetFont("McPhone.Main22")
		drme:SetValue("")
		drme:SetMultiline(true)
		drme:SetSize(McPhone.UI.Menu:GetWide(), McPhone.UI.Menu:GetTall())
		drme:SetPos(0, 0)
		drme:RequestFocus()
		local cl1, cl2 = Color(149, 240, 193), Color(0, 0, 0)
		drme.Paint = function(self, w, h)
			draw.RoundedBox(0,0,0,w,h,McPhone.UI.Theme.text_bg or color_black)
			self:DrawTextEntryText(McPhone.UI.Theme.text_color or color_white, cl1, cl2)
		end

		McPhone.UI.Buttons.Left = {
			"mc_phone/icons/lm_menu/gps.png", McPhone.MainColors["blue"], function()
				if drme:GetValue() ~= "" and IsValid(pl) then
					local str = drme:GetValue()
					net.Start("McPhone.SendSMS")
					net.WriteEntity(pl)
					net.WriteString(str)
					net.WriteBool(true)
					net.SendToServer()
				end

				McPhone.GoBack()
			end
		}
		McPhone.UI.Buttons.Middle = {
			"mc_phone/icons/buttons/id5.png", McPhone.MainColors["green"], function()
				if drme:GetValue() ~= "" and IsValid(pl) then
					local str = drme:GetValue()
					net.Start("McPhone.SendSMS")
					net.WriteEntity(pl)
					net.WriteString(str)
					net.WriteBool(false)
					net.SendToServer()
				end
				McPhone.Notify("СМС отправлено")
				McPhone.GoBack()
			end
		}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	m_list()
end

function McPhone.SendSMS(name, msg, gps, ply)
	if CLIENT then
		table.insert(McPhone.SMS, {
			New = true,
			Name = name,
			Text = msg,
			GPS = gps,
			Time = McPhone.GetCurTime()
		})

		McPhone.UpdateSMS()
		McPhone.Notify(name, msg, "tone_3")
	else
		net.Start("McPhone.SendSMS")
		net.WriteString(msg)
		net.WriteString(name)
		net.WriteBool(isvector(gps))
		if isvector(gps) then
			net.WriteVector(gps)
		end
		net.Send(ply)
	end
end

if SERVER then
	util.AddNetworkString("McPhone.SendSMS")

	net.Receive("McPhone.SendSMS", function(l, ply)
		if ply.McPhoneLastSMS and ply.McPhoneLastSMS + 5 > CurTime() then
			McPhone.Notify(ply, "Spam Alert!", "", false)

			return
		end

		if McPhone.EP1 and ply.McPhoneSignal < 1 then
			McPhone.Notify(ply, McPhone.GetPhrase("No Signal"), "", true)

			return
		end

		ply.McPhoneLastSMS = CurTime()
		local pl = net.ReadEntity()
		local str = net.ReadString()
		local gps = net.ReadBool()

		timer.Simple(math.random(1,10), function()
			if not IsValid(pl) or not IsValid(ply) then return end
			if McPhone.EP1 and pl.McPhoneSignal < 1 then
				McPhone.Notify(ply, McPhone.GetPhrase("No Signal"), "", true)

				return
			end

			net.Start("McPhone.SendSMS")
			net.WriteString(str)
			net.WriteString(ply:Name())
			net.WriteBool(gps)
			if gps then
				net.WriteVector(ply:GetPos())
			end
			net.Send(pl)
		end)

		if McPhone.Config.DarkRPLog and DarkRP then
			DarkRP.log("other", ply,  pl, "отправил сообщение " .. str)
		end

		hook.Call("McPhone.Hook.SendSMS", nil, ply, pl, str)
	end)
else
	net.Receive("McPhone.SendSMS", function(l)
		local msg = net.ReadString()
		local name = net.ReadString()
		local attachment = net.ReadBool()
		local gps

		if attachment then
			gps = net.ReadVector()
		end

		McPhone.SendSMS(name, msg, gps)
	end)

	function McPhone.UpdateSMS()
		local num = 0

		for k, v in pairs(McPhone.SMS) do
			if v.New then
				num = num + 1
			end
		end

		McPhone.Modules[module_id].number = num
		json_table = util.TableToJSON(McPhone.SMS, true)
		file.Write(McPhone.ServerID .. "/sms_" .. LocalPlayer():CharID() .. ".txt", json_table)
	end

	function McPhone.GetSMS()
		McPhone.SMS = {}

		if not file.Exists(McPhone.ServerID .. "/sms_" .. LocalPlayer():CharID() .. ".txt", "DATA") then
			McPhone.UpdateSMS()
		else
			local sms = util.JSONToTable(file.Read(McPhone.ServerID .. "/sms_" .. LocalPlayer():CharID() .. ".txt", "DATA"))
			McPhone.SMS = sms
		end
	end

	McPhone.GetSMS()
end