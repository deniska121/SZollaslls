--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- DO NOT EDIT ANYTHING HERE, UNLESS YOU KNOW WHAT YOU ARE DOING
local ScrW, ScrH = ScrW, ScrH
local ply = LocalPlayer()
local colors = McPhone.MainColors

local sub_clrs = {
	black_50 = Color(0, 0, 0, 50),
	red = Color(255, 0, 0),
	green_55 = Color(155, 255, 155),
	white_250 = Color(250, 250, 250),
	white_50a = Color(255, 255, 255, 50),
}

local function ColorMatch(c1, c2)
	if c1.r ~= c2.r or c1.g ~= c2.g or c1.b ~= c2.b then
		return false
	end

	return true
end

local phone_data

function McPhone.Open(type)
	if not McPhone.CanUsePhone(ply) then return end

	net.Start("McPhone.PhoneStatus")
		net.WriteUInt(1, 3)
	net.SendToServer()

	local _, phone = McINV.GetPhone(ply)
	if phone and phone.ud then
		McPhone.UserCfg.Profile = phone.ud
		McPhone.UserCfg.PhoneType = phone.ud.PhoneType
		McPhone.UserCfg.WallPaper = phone.ud.WallPaper
		for k, v in pairs(McPhone[phone.ud.PhoneType].Themes) do
			if ColorMatch(v["phone"], phone.ud.PhoneColor) then
				McPhone.UserCfg.Theme = v
				McPhone.UserCfg.Profile.PhoneColor = phone.ud.PhoneColor
			end
		end

		if not phone_data or phone_data ~= phone then
			phone_data = phone
			McPhone.SaveUserConfig()
		end
	end

	local theme = McPhone.PhoneTypes[McPhone.UserCfg.PhoneType]

	if not theme then
		theme = McPhone.PhoneTypes.McPhone
	end

	if McPhone.UI and IsValid(McPhone.UI) and type == 1 then return end

	if theme.OpenPhone then
		theme.OpenPhone(type)
		return
	end

	McPhone.UI = vgui.Create("DPanel")
	McPhone.UI:SetSize(theme.size[1], theme.size[2])
	McPhone.UI:SetPos(ScrW() - (theme.size[1] + 25), ScrH())
	McPhone.UI.OriginalPos = {McPhone.UI:GetPos(), ScrH() - (theme.size[2] - 30)}
	McPhone.UI:MoveTo(McPhone.UI:GetPos(), McPhone.UI.OriginalPos[2], 0.2)
	McPhone.UI.Theme = theme
	McPhone.UI.OpenedMenu = ""
	McPhone.UI.Select = function(id, panel)
		if panel then
			for k, v in pairs(McPhone.UI.Menu:GetItems()) do
				if v == panel then
					id = k
				end
			end
		end

		local hover = McPhone.UI.Menu:GetItems()[id]

		if hover then
			McPhone.key = id
			hover:OnCursorEntered(true)
			McPhone.UI.Menu:ScrollToChild(hover)
		end
	end

	local clp

	McPhone.UI.Paint = function(self, w, h)
		clp = DisableClipping( false )
		McPhone.DrawTexturedRect(0, 0, w, h, theme.main_mat, color_white)
		McPhone.DrawTexturedRect(0, 0, w, h, theme.frame_mat, McPhone.UserCfg.Theme["phone"])
		DisableClipping( clp )
	end

	McPhone.UI.Think = function(self)
		if McPhone.UI.Closing and McPhone.UI.Closing < CurTime() then
			McPhone.UI.Closing = false
			McPhone.UI:Remove()
			McPhone.UI = nil
			net.Start("McPhone.PhoneStatus")
				net.WriteUInt(0, 3)
			net.SendToServer()
		end
	end

	function McPhone.UI:OnRemove()
		if McPhone.Sound then
			McPhone.Sound:Stop()
			McPhone.Sound = nil
		end

		if McPhone.UserCfg.CursorOnPopUp then
			local mx, my = gui.MousePos()

			if mx > 0 and my > 0 then
				if GAMEMODE.ShowSpare1 then
					GAMEMODE:ShowSpare1()
				else
					gui.EnableScreenClicker(false)
				end
			end
		end
	end

	McPhone.UI.Buttons = {
		Left = {nil, nil, nil},
		Middle = {nil, nil, nil},
		Right = {nil, nil, nil},
	}

	if McPhone.UserCfg.CursorOnPopUp then
		if GAMEMODE.ShowSpare1 then
			GAMEMODE:ShowSpare1()
		else
			gui.EnableScreenClicker(true)
		end

		gui.SetMousePos((ScrW() - 320) + McPhone.UI:GetWide() / 2, (ScrH() - 480) + McPhone.UI:GetTall() / 2)
	end

	local o_battery = system.BatteryPower()

	McPhone.UI.Scr = vgui.Create("DPanel", McPhone.UI)
	McPhone.UI.Scr:SetPos(theme.spos[1], theme.spos[2])
	McPhone.UI.Scr:SetSize(256, 370)

	McPhone.UI.Scr.Paint = function(self, w, h)
		if theme.button_bg then
			McPhone.DrawTexturedRect(0, h - 45, 256, 45, theme.button_bg, color_white)
		end

		theme.PaintTop(w, h, o_battery, sub_clrs.green_55)

		if McPhone.Notification then
			McPhone.Notification(self, w, h)
		end
	end

	McPhone.UI.Menu = vgui.Create("MSDPanelList", McPhone.UI)
	McPhone.UI.Menu:SetPos(theme.spos[1], theme.spos[2] + 69)
	McPhone.UI.Menu:SetSize(270, 256)
	McPhone.UI.Menu:EnableHorizontal(true)
	McPhone.UI.Menu:EnableVerticalScrollbar(true)
	McPhone.UI.Menu:SetSpacing(0)
	McPhone.UI.Menu.List = false

	McPhone.UI.Menu.Paint = function(self, w, h)
		if McPhone.UI.Menu.List or w > 256 then
			MSDX.Draw(0, 0, 0, 256, h, sub_clrs.white_250)
		end
	end

	McPhone.UI.Menu.VBar.Paint = function() end
	McPhone.UI.Menu.VBar.btnUp.Paint = function() end
	McPhone.UI.Menu.VBar.btnDown.Paint = function() end
	McPhone.UI.Menu.VBar.btnGrip.Paint = function() end

	McPhone.UI.Menu.ConvertToList = function()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.Menu:SetPos(theme.spos[1], theme.spos[2] + 69)
		McPhone.UI.Menu:SetSize(270, 256)
		McPhone.UI.Menu.List = true
	end

	McPhone.UI.Menu.ConvertToMenu = function()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.Menu:SetPos(theme.spos[1] + 8, theme.spos[2] + 77)
		McPhone.UI.Menu:SetSize(256, 240)
		McPhone.UI.Menu.List = false
	end

	local buton = vgui.Create("DButton", McPhone.UI.Scr)
	buton:SetSize(85, 45)
	buton:SetPos(0, McPhone.UI.Scr:GetTall() - 45)
	buton:SetText("")
	buton.DoClick = function(self)
		if McPhone.UI.Buttons.Left[3] then
			McPhone.UI.Buttons.Left[3]()
		end
	end
	buton.Paint = function(self, w, h)
		if McPhone.UI.Buttons.Left[1] then
			surface.SetMaterial(McPhone.GetMat(McPhone.UI.Buttons.Left[1]))
			surface.SetDrawColor(McPhone.UI.Buttons.Left[2])
			surface.DrawTexturedRect(20, 0, 45, 45)
		end
	end

	local buton2 = vgui.Create("DButton", McPhone.UI.Scr)
	buton2:SetSize(85, 45)
	buton2:SetPos(85, McPhone.UI.Scr:GetTall() - 45)
	buton2:SetText("")
	buton2.DoClick = function(self)
		if McPhone.UI.Buttons.Middle[3] then
			McPhone.UI.Buttons.Middle[3]()
		else
			McPhone.EnterPress()
		end
	end
	buton2.Paint = function(self, w, h)
		if McPhone.UI.Buttons.Middle[1] then
			surface.SetMaterial(McPhone.GetMat(McPhone.UI.Buttons.Middle[1]))
			surface.SetDrawColor(McPhone.UI.Buttons.Middle[2])
			surface.DrawTexturedRect(20, 0, 45, 45)
		end
	end

	local buton3 = vgui.Create("DButton", McPhone.UI.Scr)
	buton3:SetSize(85, 45)
	buton3:SetPos(170, McPhone.UI.Scr:GetTall() - 45)
	buton3:SetText("")
	buton3.DoClick = function(self)
		if McPhone.UI.Buttons.Right[3] then
			McPhone.UI.Buttons.Right[3]()
		else
			McPhone.GoBack()
		end
	end
	buton3.Paint = function(self, w, h)
		if McPhone.UI.Buttons.Right[1] then
			surface.SetMaterial(McPhone.GetMat(McPhone.UI.Buttons.Right[1]))
			surface.SetDrawColor(McPhone.UI.Buttons.Right[2])
			surface.DrawTexturedRect(20, 0, 45, 45)
		end
	end

	McPhone.UI.MainMenuOpen = function()
		McPhone.UI.Menu.ConvertToMenu()

		for id, mod in SortedPairs(McPhone.Modules) do
			if mod.CheckFunction and not mod.CheckFunction() then continue end

			theme.MainIcons(McPhone.UI.Menu, mod.icon, mod.name, function()
				McPhone.UI.GoBack = function()
					McPhone.UI.MainMenuOpen()
				end

				mod.openMenu()
			end, mod.number)
		end

		McPhone.UI.GoBack = false

		McPhone.UI.Buttons.Left = {nil, nil, nil}

		McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id4.png", colors["green"], nil}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", colors["red"], nil}

		McPhone.UI.Select(5)
	end

	if type == 1 then
		McPhone.PlaySoundUI("toggle")
		McPhone.UI.MainMenuOpen()
		McPhone.UI.Select(5)

		if McPhone.PreCache then
			McPhone.OpenCallMenu(McPhone.PreCache[1], McPhone.PreCache[2], McPhone.PreCache[3])
			McPhone.PreCache = nil
		end
	else
		McPhone.UI.Menu.ConvertToList()
		McPhone.UI.GoBack = function()
			McPhone.UI.MainMenuOpen()
		end
	end
end

function McPhone.OpenCallMenu(status, contact, icon, payphone, call_bg)
	if payphone and McPhone.PayPhone and McPhone.PayPhone.UI then
		McPhone.PayPhone.UI.Update(status, contact)
		return
	end

	if not McPhone.UI then
		if McPhone.UserCfg.PopUp then
			McPhone.Open(2)
		else
			McPhone.PreCache = {status, contact, icon}

			return
		end
	end

	if not McPhone.UI then return end

	if not contact then
		contact = "Unknown"
	end

	if McPhone.ExtraNumbers[contact] and McPhone.ExtraNumbers[contact].nicename then
		contact = McPhone.ExtraNumbers[contact].nicename
	end

	if not icon or (isstring(icon) and Material(icon):IsError()) then
		icon = "mc_phone/icons/contact.png"
	end

	if not isstring(icon) then
		icon = "mc_phone/icons/contact.png"
	end

	if not status then
		status = "Connected"
	end

	if status == "Incoming" then
		McPhone.EndTime = CurTime() + 15

		McPhone.AcceptCall = function()
			if McPhone.CallDelay and McPhone.CallDelay < CurTime() then
				net.Start("McPhone.Accept")
				net.SendToServer()
				McPhone.AcceptCall = nil
			end
		end
	end

	McPhone.UI.Menu:Clear(true)
	McPhone.UI.Menu.ConvertToList()

	if McPhone.UI.NScr then
		McPhone.UI.NScr:Remove()
	end

	local theme = McPhone.PhoneTypes[McPhone.UserCfg.PhoneType]

	if not theme then
		theme = McPhone.PhoneTypes.McPhone
	end

	McPhone.UI.NScr = vgui.Create("DPanel", McPhone.UI)
	McPhone.UI.NScr:SetPos(theme.spos[1], theme.spos[2] + (theme.sctoffset or 25))
	McPhone.UI.NScr:SetSize(McPhone.UI.Scr:GetWide(), McPhone.UI.Scr:GetTall())

	McPhone.UI.NScr.Think = function()
		if McPhone.EndTime and McPhone.EndTime < CurTime() and status == "Incoming" then
			McPhone.EndTime = nil
			McPhone.GoBack()
		end
	end

	McPhone.UI.NScr.Paint = function(self, w, h)
		if theme.CallSct then
			theme.CallSct(self, w, h, status, contact, icon, payphone, call_bg)
			return
		end

		McPhone.DrawTexturedRect(0, 44, 256, 256, "mc_phone/wp/McPhone_logo_background.png", color_white)
		if call_bg then
			McPhone.DrawTexturedRect(0, 44, 256, 256, McPhone.GetUrlIcon(call_bg[1], call_bg[2]), color_white)
		end
		MSDX.Draw(0, 0, 0, w, 118, color_black)
		McPhone.DrawTexturedRect(0, 0, 256, 118, "mc_phone/phone/grad.png", sub_clrs.white_50a)
		draw.SimpleTextOutlined(contact, "McPhone.Main28", 5, 15, color_white, TEXT_ALIGN_LEFT, 1, 2, sub_clrs.black_50)
		draw.SimpleTextOutlined(string.upper(McPhone.GetPhrase(status)), "McPhone.Main32", 78, 50, color_white, TEXT_ALIGN_LEFT, 1, 1, sub_clrs.black_50)

		if McPhone.AcceptedTime and status == "Connected" then
			draw.SimpleTextOutlined(string.FormattedTime(CurTime() - McPhone.AcceptedTime, "%02i:%02i"), "McPhone.Main32", 78, 80, color_white, TEXT_ALIGN_LEFT, 1, 1, sub_clrs.black_50)
		end

		if isstring(icon) then
			McPhone.DrawTexturedRect(5, 35, 64, 64, icon, color_white)
		end
	end

	McPhone.UI.NScr.Update = function(type)
		status = type

		McPhone.UI.Buttons.Left = {nil, nil, nil}

		if status == "Connecting" or status == "Busy" or status == "Connected" or status == "Not available" or status == "No Signal" then
			McPhone.UI.Buttons.Middle = {nil, nil, nil}

			McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id11.png", colors["red"], nil}
		elseif status == "Incoming" then
			McPhone.UI.Buttons.Middle = {"mc_phone/icons/buttons/id17.png", colors["green"], nil}

			McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id11.png", colors["red"], nil}
		end
	end

	McPhone.UI.NScr.Update(status)
end

net.Receive("McPhone.CallStart", function()
	McPhone.StopSound()

	if McPhone.UI and McPhone.UI.Closing then
		if McPhone.UI.anim then
			McPhone.UI.anim:Stop()
		end
		McPhone.UI.Closing = nil
		McPhone.UI:SetPos(McPhone.UI.OriginalPos[1], McPhone.UI.OriginalPos[2])
	end

	local type = net.ReadString()

	if type == "ExtraNumber" then
		if (McPhone.PayPhone and IsValid(McPhone.PayPhone.UI) and McPhone.PayPhone.UI) then
			McPhone.PayPhone.UI:Remove()
		end

		local num = net.ReadString()
		McPhone.OnCall = McPhone.ExtraNumbers[num]
		type = "Incoming"
		McPhone.LastNumber = num
		McPhone.CallDelay = CurTime() + 0.5
		McPhone.OpenCallMenu(type, num, num, true)
		return
	end

	local pl = net.ReadEntity()
	local c_type = net.ReadUInt(2)
	McPhone.OnCall = pl

	if type == "Connecting" then
		McPhone.PlaySound("mc_phone/tone.wav")
		McPhone.CallDelay = CurTime() + 0.2
	end

	if type == "Incoming" then
		if c_type >= 2 then
			McPhone.LastNumber = McPhone.GetPhrase("Public phone")
		else
			McPhone.LastNumber = pl
			table.insert(McPhone.CallLog, {McPhone.NumberChar(pl), os.time(), "in"})
			--McPhone.AddContacts(McPhone.NumberChar(pl), pl:Name())
		end
		McPhone.CallDelay = CurTime() + 0.5
	end

	if c_type == 3 then
		McPhone.LastNumber = net.ReadString()
		table.insert(McPhone.CallLog, {McPhone.LastNumber, os.time(), "in"})
	end

	if c_type == 2 then
		McPhone.OpenCallMenu(type, McPhone.GetPhrase("Public phone"))
		table.insert(McPhone.CallLog, {McPhone.LastNumber, os.time(), "in"})
	else
		McPhone.OpenCallMenu(type, c_type == 3 and McPhone.LastNumber or (McPhone.Contacts[McPhone.NumberChar(pl)] or McPhone.NumberChar(pl)), pl, c_type == 1 and true)
	end
end)

net.Receive("McPhone.CallExtraNumber", function()
	McPhone.StopSound()

	if McPhone.UI and McPhone.UI.Closing then
		McPhone.UI.anim:Stop()
		McPhone.UI.Closing = nil
		McPhone.UI:SetPos(McPhone.UI.OriginalPos[1], McPhone.UI.OriginalPos[2])
	end

	local tab = net.ReadString()
	local public_phone = net.ReadBool()
	local delay = net.ReadFloat() or 5

	if McPhone.ExtraNumbers[tab] then
		tab = McPhone.ExtraNumbers[tab]
	else
		return
	end

	McPhone.OnCall = tab

	if delay > 0 then
		McPhone.OpenCallMenu("Connecting", tab.nicename, tab.icon_call, public_phone, tab.call_bg)
		McPhone.PlaySound("mc_phone/tone.wav")
	end

	timer.Create("McPhone.CallExtraNumber1", delay, 1, function()
		if McPhone.OnCall and istable(McPhone.OnCall) then
			if McPhone.UI and IsValid(McPhone.UI.NScr) then
				McPhone.UI.NScr.Update("Connected")
			end
			if delay == 0 and tab.incoming then
				McPhone.PlaySound(tab.incoming[1], tab.incoming[2])
			else
				McPhone.PlaySound(tab.sound[1], tab.sound[2])
			end
		end
	end)

	timer.Create("McPhone.CallExtraNumber2", delay + tab.delay, 1, function()
		if McPhone.OnCall and istable(McPhone.OnCall) then
			if tab.func then
				McPhone.StopCall()
				local close = McPhone.ExtraNumbersFunc[tab.func]()

				if close then
					McPhone.ClosePhone()
				end
			else
				McPhone.CallBusy()
			end
		end
	end)
end)

net.Receive("McPhone.End", function()
	McPhone.GoBack()
end)

net.Receive("McPhone.CallBuisy", function()
	McPhone.CallBusy()
end)

net.Receive("McPhone.CallAccept", function()
	local lastcall = McPhone.LastNumber
	local number = McPhone.LastNumber
	local public_phone = net.ReadBool()
	McPhone.AcceptedTime = CurTime()

	if lastcall and not isnumber(lastcall) and not isstring(lastcall) then
		number = McPhone.NumberChar(lastcall)
		lastcall = lastcall:Name()
	end

	McPhone.OpenCallMenu("Connected", number, nil, public_phone)
	McPhone.StopSound()
end)

net.Receive("McPhone.CallNotAv", function()
	McPhone.OnCall = CurTime() + 15

	local public_phone = net.ReadBool()

	McPhone.OpenCallMenu("Connecting", "Соединение...", nil, public_phone)
	McPhone.PlaySound("mc_phone/tone.wav")

	timer.Simple(6, function()
		if McPhone.OnCall and isnumber(McPhone.OnCall) then
			if McPhone.UI then
				McPhone.UI.NScr.Update("Not available")
			elseif McPhone.PreCache then
				McPhone.PreCache[1] = "Not available"
			end
			McPhone.PlaySound("mc_phone/bussy.wav")
			if McPhone.PayPhone and McPhone.PayPhone.UI then
				McPhone.PayPhone.UI.Update("Not available")
			end
		end
	end)
end)

net.Receive("McPhone.ToggleGPS", function()
	local name = net.ReadString()
	local point = net.ReadVector()
	McPhone.ToggleGPS(name, point)
end)