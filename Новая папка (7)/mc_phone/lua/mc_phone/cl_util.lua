-- "addons\\mc_phone\\lua\\mc_phone\\cl_util.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- DO NOT EDIT ANYTHING HERE, UNLESS YOU KNOW WHAT YOU ARE DOING
local render = render
local surface = surface
local ScrW, ScrH = ScrW, ScrH
local math = math
local NewFont = surface.CreateFont
local ply = LocalPlayer()

NewFont("McPhone.Main38", {
	font = "Calibri",
	extended = true,
	size = 38,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Main32", {
	font = "Calibri",
	extended = true,
	size = 32,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Main28", {
	font = "Calibri",
	extended = true,
	size = 28,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Main24", {
	font = "Calibri",
	extended = true,
	size = 24,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Main22", {
	font = "Calibri",
	extended = true,
	size = 22,
	antialias = true,
	weight = 800
})

NewFont("McPhone.Main20", {
	font = "Calibri",
	extended = true,
	size = 20,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Main18", {
	font = "Calibri",
	extended = true,
	size = 18,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Main16", {
	font = "Calibri",
	extended = true,
	size = 16,
	antialias = true,
	weight = 800
})


NewFont("McPhone.Main12", {
	font = "Calibri",
	extended = true,
	size = 12,
	antialias = true,
	weight = 800
})

function McPhone.Alpha(c, a)
	if a < 1 then
		a = 1
	end

	return Color(c.r, c.g, c.b, a)
end

function McPhone.SetKey(key, hover)
	if not McPhone.UI or not McPhone.UI.Menu then return end
	local but = McPhone.UI.Menu:GetItems()[key]

	if IsValid(but) and not but.unused then
		McPhone.key = key
		McPhone.UI.Menu:ScrollToChild(but)

		if hover then
			but:OnCursorEntered()
		end
	end
end

-- ───────── Contacts ─────────--
McPhone.Contacts = {}

function McPhone.UpdateContacts()
	json_table = util.TableToJSON(McPhone.Contacts, true)
	file.Write(McPhone.ServerID .. "/cnt_" .. LocalPlayer():CharID() .. ".txt", json_table)
end

function McPhone.GetContacts()
	McPhone.Contacts = {}

	if not file.Exists(McPhone.ServerID .. "/cnt_" .. LocalPlayer():CharID() .. ".txt", "DATA") then
		McPhone.UpdateContacts()
	else
		local config = util.JSONToTable(file.Read(McPhone.ServerID .. "/cnt_" .. LocalPlayer():CharID() .. ".txt", "DATA"))
		McPhone.Contacts = config
	end
end

function McPhone.RemoveContacts(number)
	if not number then return end
	if not McPhone.Contacts[number] then return end
	McPhone.Contacts[number] = nil
	McPhone.Notify(McPhone.GetPhrase("cont_removed"))
	McPhone.UpdateContacts()
end

McPhone.GetContacts()

-- ────── Notifications ───────--

function McPhone.Notify(title, text, snd, icon)
	if not McPhone.HasPhone(LocalPlayer()) then return end
	if McPhone.UserCfg.Profile.NoNotf then return end

	if snd then
		local tone = isstring(snd) and snd or "tone_2"
		McPhone.PlaySound("mc_phone/sms/" .. tone .. ".wav")
	end

	if McPhone.UI and McPhone.UI.Scr and not IsValid(McPhone.ActiveWeb) then
		local theme = McPhone.PhoneTypes[McPhone.UserCfg.PhoneType]

		if not theme then
			theme = McPhone.PhoneTypes.McPhone
		end

		if theme.Notify then
			theme.Notify(title, text, snd, icon)

			return
		end

		local stimer = CurTime() + 3
		local pos = -255
		local tall = 23

		if text then
			tall = 52
			surface.SetFont("McPhone.Main28")
			local wh = surface.GetTextSize(text)

			if wh > 200 then
				text = string.subUTF8(text, 0, 10) .. "..."
			end
		end

		McPhone.Notification = function(self, w, h)
			if stimer > CurTime() then
				pos = Lerp(FrameTime() * 7, pos, 1)
			end

			draw.RoundedBox(2, pos, 0, 254, tall + 4, color_black)
			draw.RoundedBox(4, pos + 2, 2, 250, tall, color_white)
			draw.RoundedBoxEx(2, pos + 2, 2 + (tall / 2), 250, tall / 2, McPhone.MainColors.shadow_100, false, false, true, true)
			draw.SimpleTextOutlined(title, "McPhone.Main22", pos + 10, 2, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)

			if text then
				draw.SimpleTextOutlined(text, "McPhone.Main28", pos + 10, 25, color_black, TEXT_ALIGN_LEFT, 0, 1, color_white)
			end

			if stimer < CurTime() then
				pos = Lerp(FrameTime() * 7, pos, 256)

				if pos > 255 then
					McPhone.Notification = nil
				end
			end
		end
	else
		local stimer = CurTime() + 5
		local alpha = 0
		local tall = DarkRP.Hud.IconSize + 10

		if GetConVar("FPP_PrivateSettings_HideOwner"):GetInt() == 1 then text = nil end

		if text then
			text = MSD.TextWrap(string.subUTF8(text, 0, 100), "MSDFont.26", 280)
			tall = tall + tall
			text = string.Explode("\n", text)
			text = text[1] .. (text[2] and ".." or "")
		end

		local x, y = ScrW() - 410, ScrH()
		local p1, p2, p3, p4

		title = MSD.TextWrap(string.subUTF8(title, 0, 100), "MSDFontB.26", 270 - DarkRP.Hud.IconSize)
		title = string.Explode("\n", title)
		title = title[1] .. (title[2] and ".." or "")

		McPhone.HudNotification = function()
			p1, p2, p3, p4 = x, y - alpha, 300, tall
			DarkRP.Hud.DrawBG(p1, p2, p3, p4)

			MSD.DrawTexturedRect(p1 + 5, p2 + 5, DarkRP.Hud.IconSize, DarkRP.Hud.IconSize, MSD.Icons48.cellphone_basic, color_white)

			draw.DrawText(title, "MSDFontB.26", p1 + 10 + DarkRP.Hud.IconSize, p2 + 4, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT, 0, 1, color_black)

			if text then
				draw.DrawText(text, "MSDFont.26", x + 10, p2 + DarkRP.Hud.IconSize + 10, color_white, TEXT_ALIGN_LEFT)
			end

			if stimer < CurTime() or IsValid(McPhone.UI) then
				alpha = Lerp(FrameTime() * 7, alpha, 0)

				if alpha < 0.01 or IsValid(McPhone.UI) then
					McPhone.HudNotification = function() end
				end
			else
				alpha = Lerp(FrameTime() * 7, alpha, tall + 10)
			end
		end
	end
end

net.Receive("McPhone.Notify", function()
	local title = net.ReadString()
	local text = net.ReadString()
	local snd = net.ReadBool()
	McPhone.Notify(title, text, snd)
end)

-- ───────── Sound fx ─────────--
function McPhone.PlaySound(snd, url)
	if McPhone.Sound then
		McPhone.Sound:Stop()
		McPhone.Sound = nil
	end

	if istable(snd) then
		snd = snd[math.random(#snd)]
	end

	if url then
		sound.PlayURL(snd, "mono", function(station)
			if (IsValid(station)) then
				McPhone.Sound = station
				McPhone.Sound:Play()
			end
		end)
	else
		McPhone.Sound = CreateSound(ply, snd)
		McPhone.Sound:PlayEx(1, 100)
	end
end

local sound_list = {
	["toggle"] = "mc_phone/toggle.wav",
	["open"] = "mc_phone/open_1.wav",
	["click"] = "mc_phone/click.wav",
}

function McPhone.PlaySoundUI(snd)
	if McPhone.SoundUI then
		McPhone.SoundUI:Stop()
		McPhone.SoundUI = nil
	end

	if McPhone.UI and McPhone.UI.Theme and McPhone.UI.Theme.r_snd and McPhone.UI.Theme.r_snd[snd] then
		snd = McPhone.UI.Theme.r_snd[snd]
	elseif sound_list[snd] then
		snd = sound_list[snd]
	end

	McPhone.SoundUI = CreateSound(ply, snd)
	McPhone.SoundUI:PlayEx(McPhone.UserCfg.UISoundVolume, 100)
end

function McPhone.StopSound()
	if McPhone.Sound then
		McPhone.Sound:Stop()
		McPhone.Sound = nil
	end

	if McPhone.SoundUI then
		McPhone.SoundUI:Stop()
		McPhone.SoundUI = nil
	end
end

function McPhone.StopCall()
	if McPhone.OnCall then
		if istable(McPhone.OnCall) then
			net.Start("McPhone.CallExtraNumber")
				net.WriteUInt(0, 2)
			net.SendToServer()

			if timer.Exists("McPhone.CallExtraNumber1") then
				timer.Remove("McPhone.CallExtraNumber1")
			end

			if timer.Exists("McPhone.CallExtraNumber2") then
				timer.Remove("McPhone.CallExtraNumber2")
			end
		end

		McPhone.OnCall = nil

		if McPhone.UI then
			if McPhone.UI.NScr then
				McPhone.UI.NScr:Remove()
			end
		else
			McPhone.PreCache = nil
		end

		net.Start("McPhone.CallDeny")
		net.SendToServer()
		McPhone.StopSound()
	end
end

-- ─────────── Calls ──────────--
function McPhone.CallBusy()
	McPhone.OnCall = CurTime() + 2.3
	local lastcall = McPhone.LastNumber
	local number = McPhone.LastNumber

	if not isnumber(lastcall) and not isstring(lastcall) then
		number = McPhone.NumberChar(lastcall)
		lastcall = lastcall:Name()
	end

	McPhone.OpenCallMenu("Busy", number, nil, McPhone.PayPhone and IsValid(McPhone.PayPhone.UI))
	McPhone.PlaySound("mc_phone/bs.wav")
end

function McPhone.CallNoSignal()
	McPhone.OnCall = CurTime() + 3
	McPhone.OpenCallMenu("No Signal", "", nil, McPhone.PayPhone and IsValid(McPhone.PayPhone.UI))
	McPhone.PlaySound("mc_phone/nosg.wav")
end

-- ──────────── UI ────────────--
function McPhone.DrawTexturedRect(x, y, w, h, mat, color)
	MSD.DrawTexturedRect(x, y, w, h, mat, color)
end

McPhone.Signal = 3

function McPhone.DrawSignal(x, y, align)
	if McPhone.Signal < 1 then
		if align then
			draw.SimpleText("No signal", "McPhone.Main16", x + 26, y + 5, color_white, TEXT_ALIGN_RIGHT)
		else
			draw.SimpleText("No signal", "McPhone.Main16", x + 5, y + 5, color_white, TEXT_ALIGN_LEFT)
		end
	else
		for i = 0, McPhone.Signal - 1 do
			draw.RoundedBox(0, x + 5 + (i * 5 + i * 2), y + 13 - (i * 5), 5, 8 + (i * 5), color_white)
		end

		for i = 0, 2 do
			draw.RoundedBox(0, x + 5 + (i * 5 + i * 2), y + 19, 5, 2, color_white)
		end
	end
end

timer.Create("McPhone.SignalChange", 10, 0, function()
	McPhone.Signal = math.random(1, 3)
end)

function McPhone.NumberIcons(parent, size, text, text2, presscode)
	if McPhone.UI.Theme and McPhone.UI.Theme.NumberIcons then
		McPhone.UI.Theme.NumberIcons(parent, size, text, text2, presscode)

		return
	end

	local buton = vgui.Create("DButton")
	buton:SetSize(size, 64)
	buton:SetText("")

	buton.DoClick = function(self)
		McPhone.PlaySoundUI("open")

		if McPhone.UI.OpenedMenu == McPhone.GetPhrase("enter_number") then
			McPhone.UI.OpenedMenu = text
		else
			McPhone.UI.OpenedMenu = McPhone.UI.OpenedMenu .. text
		end

		return true
	end

	buton.Paint = function(self, w, h)
		if self.hover then
			draw.RoundedBox(0, 0, 0, w, h, McPhone.UserCfg.Theme["buttons"])
		else
			draw.RoundedBox(0, 0, 0, w, h, McPhone.MainColors.number)
		end

		surface.SetDrawColor(0, 0, 0, 120)
		surface.DrawOutlinedRect(0, 0, w, h)
		draw.SimpleText(text, "McPhone.Main38", w / 2, 7, color_white, TEXT_ALIGN_CENTER)

		if text2 then
			draw.SimpleText(text2, "McPhone.Main22", w / 2, h - 25, McPhone.MainColors.white_220, TEXT_ALIGN_CENTER)
		end
	end

	buton.Think = function(self, w, h)
		if not presscode then return end
		if self.lastpress and self.lastpress > CurTime() then return end

		if input.IsKeyDown(presscode) then
			self.lastpress = CurTime() + 0.3
			self:DoClick()
		end
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute then
			McPhone.PlaySoundUI("click")
		end

		self.hover = true

		for k, v in pairs(parent:GetItems()) do
			if v == self then continue end
			if v.unused then continue end
			v:OnCursorExited()
		end
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(buton)
end

local function drawScrSpaceText(text, x, y, mx, color, parent)
	local font = "McPhone.Main28"
	surface.SetFont(font)
	local w = surface.GetTextSize(text)

	if w + x > mx then
		if parent then
			if parent.text_dir and isnumber(parent.text_dir) and parent.text_dir < CurTime() then
				parent.text_dir = nil
			end

			if parent.text_pos > mx - w - (10 + x) and not parent.text_dir then
				parent.text_pos = math.Approach(parent.text_pos, mx - w - (10 + x), FrameTime() * 50)
			else
				if parent.text_pos >= 0 and not isnumber(parent.text_dir) then
					parent.text_dir = CurTime() + 2
				else
					parent.text_pos = math.Approach(parent.text_pos, 0, FrameTime() * 50)
				end

				if not parent.text_dir then
					parent.text_dir = true
				end
			end

			local sx, sy = parent:LocalToScreen(x, 0)
			render.SetScissorRect(sx, sy, sx + (mx - x), sy + parent:GetTall(), true)
			draw.SimpleText(text, font, x + parent.text_pos, y, color, TEXT_ALIGN_LEFT)
			render.SetScissorRect(0, 0, 0, 0, false)

			return
		else
			font = "McPhone.Main20"
			y = y + 3
		end
	end

	draw.SimpleText(text, font, x, y, color, TEXT_ALIGN_LEFT)
end

function McPhone.ListIcons(parent, icon, text, check, func, ignore, snd, supress)
	if McPhone.UI.Theme and McPhone.UI.Theme.ListIcons then
		McPhone.UI.Theme.ListIcons(parent, icon, text, check, func, ignore, snd, supress)

		return
	end

	local icon_nohover, icon_url

	if istable(icon) then
		icon_nohover = icon[2]
		icon_url = icon[3]
		icon = icon[1]
	end

	local buton = vgui.Create("DButton")
	buton.icon = icon
	buton.check = check
	buton:SetSize(256, 51)
	buton:SetText("")
	buton.text_pos = 0
	buton.text_dir = CurTime() + 2

	buton.DoClick = function(self)
		if not snd then
			McPhone.PlaySoundUI("open")
		end

		if func then
			func(self)
		end

		if McPhone.UI and not ignore then
			McPhone.UI.OpenedMenu = text
		end

		return supress
	end

	buton.Paint = function(self, w, h)
		if self.check then
			icon = "mc_phone/icons/settings/id_9.png"
		elseif icon ~= buton.icon then
			icon = buton.icon
		end

		if self.hover then
			draw.RoundedBox(0, 0, 0, w, h, McPhone.UserCfg.Theme["buttons"])

			if isstring(icon) and not icon_nohover then
				McPhone.DrawTexturedRect(5, 10, 32, 32, McPhone.GetUrlIcon(icon, icon_url), color_white)
			end

			drawScrSpaceText(text, 45, 7, w, color_white, self)
		else
			if isstring(icon) and not icon_nohover then
				McPhone.DrawTexturedRect(5, 10, 32, 32, McPhone.GetUrlIcon(icon, icon_url), color_black)
			end

			drawScrSpaceText(text, 45, 7, w, color_black, self)
		end

		if icon_nohover then
			McPhone.DrawTexturedRect(5, 10, 32, 32, McPhone.GetUrlIcon(icon, icon_url), color_white)
		end

		draw.RoundedBox(0, 0, h - 3, w, 3, McPhone.MainColors.shadow_100)
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute and not snd then
			McPhone.PlaySoundUI("click")
		end

		if snd then
			if snd == "snd" then
				McPhone.StopSound()
			else
				McPhone.PlaySound(snd)
			end
		end

		self.hover = true

		for k, v in pairs(parent:GetItems()) do
			if v == self then continue end
			if v.unused then continue end
			v:OnCursorExited()
		end
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	if not isstring(icon) then
		local avatar = vgui.Create("AvatarImage", buton)
		avatar:SetSize(32, 32)
		avatar:SetPos(5, 10)
		avatar:SetPlayer(icon, 32)
	end

	parent:AddItem(buton)

	return buton
end

function McPhone.ListSimple(parent, name, text, icon, func, ignore, snd, supress)
	if McPhone.UI and McPhone.UI.Theme and McPhone.UI.Theme.ListSimple then
		McPhone.UI.Theme.ListSimple(parent, name, text, icon, func, ignore, snd, supress)

		return
	end

	surface.SetFont("McPhone.Main24")
	local w = surface.GetTextSize(name)

	if w > 230 then
		name = string.subUTF8(name, 0, 10) .. "..."
	end

	surface.SetFont("McPhone.Main22")
	w = surface.GetTextSize(text)

	if w > 200 then
		text = string.subUTF8(text, 0, 10) .. "..."
	end

	local hcolor = color_black
	local buton = vgui.Create("DButton")
	buton:SetSize(256, 51)
	buton:SetText("")

	buton.DoClick = function(self)
		if not snd then
			McPhone.PlaySoundUI("open")
		end

		if func then
			func(self)
		end

		if McPhone.UI and not ignore then
			McPhone.UI.OpenedMenu = name
		end

		return supress
	end

	buton.spaser = 0

	buton.Paint = function(self, wd, h)
		if self.hover then
			draw.RoundedBox(0, 0, 0, wd, h, McPhone.UserCfg.Theme["buttons"])
			hcolor = color_white
		else
			hcolor = color_black
		end

		if icon then
			McPhone.DrawTexturedRect(5, 10, 32, 32, icon, hcolor)
			self.spaser = 15
		end

		draw.SimpleText(name, "McPhone.Main24", 30 + self.spaser, 0, hcolor, TEXT_ALIGN_LEFT)
		draw.SimpleText(text, "McPhone.Main22", 30 + self.spaser, 25, hcolor, TEXT_ALIGN_LEFT)
		draw.RoundedBox(0, 0, h - 3, wd, 3, McPhone.MainColors.shadow_100)
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute and not snd then
			McPhone.PlaySoundUI("click")
		end

		if snd then
			if snd == "snd" then
				McPhone.StopSound()
			else
				McPhone.PlaySound(snd)
			end
		end

		self.hover = true

		for k, v in pairs(parent:GetItems()) do
			if v == self then continue end
			if v.unused then continue end
			v:OnCursorExited()
		end
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(buton)

	return buton
end

function McPhone.ListTexts(parent, sms, name, text, time, check, func, ismail, ignore, snd, supress, ignoretheme)
	if not ignoretheme and McPhone.UI and McPhone.UI.Theme and McPhone.UI.Theme.ListTexts then
		McPhone.UI.Theme.ListTexts(parent, sms, name, text, time, check, func, ismail, ignore, snd, supress)

		return
	end

	if sms then
		if ismail then
			sms = McPhone.Mail[sms]
		else
			sms = McPhone.SMS[sms]
		end
	end

	surface.SetFont("McPhone.Main32")
	local w = surface.GetTextSize(name)

	if w > 230 then
		name = string.subUTF8(name, 0, 10) .. "..."
	end

	surface.SetFont("McPhone.Main22")
	w = surface.GetTextSize(text)

	if w > 200 then
		text = string.subUTF8(text, 0, 10) .. "..."
	end

	local hcolor = color_black
	local buton = vgui.Create("DButton")
	buton:SetSize(256, 51)
	buton:SetText("")

	buton.DoClick = function(self)
		if not snd then
			McPhone.PlaySoundUI("open")
		end

		if func then
			func(self)
		end

		if McPhone.UI and not ignore then
			McPhone.UI.OpenedMenu = name
		end

		return supress
	end

	buton.Paint = function(self, wd, h)
		if self.hover then
			draw.RoundedBox(0, 0, 0, wd, h, McPhone.UserCfg.Theme["buttons"])

			if sms and sms.New then
				McPhone.DrawTexturedRect(5, h / 2 - 8, 16, 16, "mc_phone/icons/round.png", color_white)
			end

			hcolor = color_white
		else
			if sms and sms.New then
				McPhone.DrawTexturedRect(5, h / 2 - 8, 16, 16, "mc_phone/icons/round.png", McPhone.UserCfg.Theme["buttons"])
			end

			hcolor = color_black
		end

		draw.SimpleText(name, "McPhone.Main20", 30, 0, hcolor, TEXT_ALIGN_LEFT)
		draw.SimpleText(time, "McPhone.Main20", wd - 2, 0, hcolor, TEXT_ALIGN_RIGHT)
		draw.SimpleText(text, "McPhone.Main20", 30, 25, hcolor, TEXT_ALIGN_LEFT)
		draw.RoundedBox(0, 0, h - 3, wd, 3, McPhone.MainColors.shadow_100)
	end

	buton.OnCursorEntered = function(self, mute)
		self.hover = true

		if ignoretheme then return end

		if not mute and not snd then
			McPhone.PlaySoundUI("click")
		end

		if snd then
			if snd == "snd" then
				McPhone.StopSound()
			else
				McPhone.PlaySound(snd)
			end
		end

		for k, v in pairs(parent:GetItems()) do
			if v == self then continue end
			if v.unused then continue end
			v:OnCursorExited()
		end
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(buton)

	return buton
end

function McPhone.ListNoIcons(parent, text, func, ignore, snd, supress)
	if McPhone.UI and McPhone.UI.Theme and McPhone.UI.Theme.ListNoIcons then
		McPhone.UI.Theme.ListNoIcons(parent, text, func, ignore, snd, supress)

		return
	end

	local buton = vgui.Create("DButton")
	buton:SetSize(256, 51)
	buton:SetText("")

	buton.DoClick = function(self)
		if not snd then
			McPhone.PlaySoundUI("open")
		end

		if func then
			func(self)
		end

		if McPhone.UI and not ignore then
			McPhone.UI.OpenedMenu = text
		end

		return supress
	end

	buton.Paint = function(self, w, h)
		if self.hover then
			draw.RoundedBox(0, 0, 0, w, h, McPhone.UserCfg.Theme["buttons"])
			drawScrSpaceText(text, 5, 7, w, color_white)
		else
			drawScrSpaceText(text, 5, 7, w, color_black)
		end

		draw.RoundedBox(0, 0, h - 3, w, 3, McPhone.MainColors.shadow_100)
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute and not snd then
			McPhone.PlaySoundUI("click")
		end

		if snd then
			if snd == "snd" then
				McPhone.StopSound()
			else
				McPhone.PlaySound(snd)
			end
		end

		self.hover = true

		for k, v in pairs(parent:GetItems()) do
			if v == self then continue end
			if v.unused then continue end
			v:OnCursorExited()
		end
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(buton)

	return buton
end

local function SubStringGetByteCount(str, index)
	local curByte = string.byte(str, index)
	local byteCount = 1

	if curByte == nil then
		byteCount = 0
	elseif curByte > 0 and curByte <= 127 then
		byteCount = 1
	elseif curByte >= 192 and curByte <= 223 then
		byteCount = 2
	elseif curByte >= 224 and curByte <= 239 then
		byteCount = 3
	elseif curByte >= 240 and curByte <= 247 then
		byteCount = 4
	end

	return byteCount
end

local function SubStringGetTotalIndex(str)
	local curIndex = 0
	local i = 1
	local lastCount = 1
	repeat
		lastCount = SubStringGetByteCount(str, i)
		i = i + lastCount
		curIndex = curIndex + 1
	until (lastCount == 0)

	return curIndex - 1
end

local function SubStringGetTrueIndex(str, index)
	local curIndex = 0
	local i = 1
	local lastCount = 1
	repeat
		lastCount = SubStringGetByteCount(str, i)
		i = i + lastCount
		curIndex = curIndex + 1
	until (curIndex >= index)

	return i - lastCount
end

function string.subUTF8(str, startIndex, endIndex)
	if startIndex < 0 then
		startIndex = SubStringGetTotalIndex(str) + startIndex + 1
	end

	if endIndex ~= nil and endIndex < 0 then
		endIndex = SubStringGetTotalIndex(str) + endIndex + 1
	end

	if endIndex == nil then
		return string.sub(str, SubStringGetTrueIndex(str, startIndex))
	else
		return string.sub(str, SubStringGetTrueIndex(str, startIndex), SubStringGetTrueIndex(str, endIndex + 1) - 1)
	end
end

function McPhone.GetUrlIcon(path, url)
	if url then
		return McPhone.ImgLib.GetMaterial(path)
	else
		return Material(path, "smooth noclamp")
	end
end

McPhone.MatList = {}

function McPhone.GetMat(path)
	if McPhone.MatList[path] then return McPhone.MatList[path] end
	McPhone.MatList[path] = Material(path, "smooth")

	return McPhone.MatList[path]
end

McPhone.ImgLib = {}
McPhone.ImgLib.Images = {}
McPhone.ImgLib.PreCacheStarted = {}
McPhone.ImgLib.NoMaterial = Material("mc_phone/web/presets/none.png", "smooth noclamp")

function McPhone.ImgLib.GetMaterial(url)
	local crc = util.CRC(url) .. ".png"
	if McPhone.ImgLib.Images[crc] then return McPhone.ImgLib.Images[crc] end

	if (file.Exists("mmd_imgs/" .. crc, "DATA")) then
		McPhone.ImgLib.Images[crc] = Material("data/mmd_imgs/" .. crc, "smooth noclamp")

		return McPhone.ImgLib.Images[crc]
	else
		return McPhone.ImgLib.PreCacheMaterial(url, crc)
	end
end

function McPhone.ImgLib.PreCacheMaterial(url, crc)
	if not crc then
		crc = util.CRC(url) .. ".png"
	end

	if not file.Exists("mmd_imgs", "DATA") then
		file.CreateDir("mmd_imgs")
	end

	if not McPhone.ImgLib.PreCacheStarted[crc] then
		McPhone.ImgLib.PreCacheStarted[crc] = true

		http.Fetch(url, function(body, size, headers, code)
			if (body:find("^.PNG")) then
				file.Write("mmd_imgs/" .. crc, body)
				McPhone.ImgLib.Images[crc] = Material("data/mmd_imgs/" .. crc, "smooth noclamp")

				return McPhone.ImgLib.Images[crc]
			else
				print("Image is not a PNG, url - " .. url)
			end
		end, function()
			print("Failed to get image, url - " .. url)
		end)
	end

	return McPhone.ImgLib.NoMaterial
end

function McPhone.InfoText(parent, text, font, minw, color)
	font = font or "MSDFont.18"
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 25,
		minw = minw or 100,
		minh = 25
	}

	panel.Paint = function(self, w, h)
		draw.DrawText(self.txt or "", font, 5, 5, color or MSD.Text.d, TEXT_ALIGN_LEFT)

		if not self.txt or (self.sh and self.sh ~= h) or (self.sw and self.sw ~= w) then
			local ts, _, th = MSD.TextWrap(text, font, w - 10)
			self.txt = ts
			self.sw = w
			self.sh = h
			self.StaticScale.fixed_h = th + 10
		end
		return true
	end

	parent:AddItem(panel)

	return panel
end

net.Receive("McPhone.Comtact", function()
	McPhone.AddContacts(net.ReadString(), net.ReadString(), true)
end)