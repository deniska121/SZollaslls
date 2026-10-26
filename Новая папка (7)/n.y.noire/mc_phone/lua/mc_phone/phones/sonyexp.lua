--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/phones/sonyexp.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local Theme = {}
Theme.ent = "mc_phone_se"

Theme.Themes = {
	["Black"] = {
		["menu"] = Color(156, 156, 156),
		["buttons"] = Color(115, 115, 115),
		["phone"] = Color(39, 39, 39),
		["def_wp"] = "Default",
	},
	["White"] = {
		["menu"] = Color(226, 226, 226),
		["buttons"] = Color(172, 172, 172),
		["phone"] = Color(255, 255, 255),
		["def_wp"] = "Default",
	},
	["Green"] = {
		["menu"] = Color(0, 120, 0),
		["buttons"] = Color(50, 200, 50),
		["phone"] = Color(63, 127, 79),
		["def_wp"] = "Default",
	},
	["Orange"] = {
		["menu"] = Color(240, 90, 0),
		["buttons"] = Color(255, 145, 40),
		["phone"] = Color(255, 95, 0),
		["def_wp"] = "Default",
	},
	["Blue"] = {
		["menu"] = Color(134, 172, 234),
		["buttons"] = Color(0, 175, 240),
		["phone"] = Color(45, 55, 100),
		["def_wp"] = "Default",
	},
	["Red"] = {
		["menu"] = Color(170, 0, 0),
		["buttons"] = Color(130, 0, 0),
		["phone"] = Color(161, 32, 32),
		["def_wp"] = "Default",
	},
	["Grey"] = {
		["menu"] = Color(110, 110, 110),
		["buttons"] = Color(115, 115, 115),
		["phone"] = Color(100, 100, 100),
		["def_wp"] = "Default",
	},
	["Purple"] = {
		["menu"] = Color(50, 0, 110),
		["buttons"] = Color(190, 115, 235),
		["phone"] = Color(65, 35, 105),
		["def_wp"] = "Default",
	},
	["Pink"] = {
		["menu"] = Color(196, 74, 141),
		["buttons"] = Color(240, 99, 123),
		["phone"] = Color(179, 96, 96),
		["def_wp"] = "Default",
	},
}

Theme.WallPapers = {
	["Заставка 1"] = "wp_1.png",
	["Заставка 2"] = "wp_2.png",
	["Заставка 3"] = "wp_3.png",
	["Заставка 4"] = "wp_4.png",
	["Заставка 5"] = "wp_5.png",
	["Заставка 6"] = "wp_6.png",
	["Заставка 7"] = "wp_7.png",
	["Default"] = "phone_wallpaper_badgerdefault.png",
	["Заставка 8"] = "phone_wallpaper_bittersweet_b.png",
	["None"] = "",
}

Theme.Ringtone = {
	[1] = "cell/tone_1.wav",
	[2] = "cell/tone_2.wav",
	[3] = "cell/tone_3.wav",
	[4] = "cell/tone_4.wav",
	[5] = "cell/tone_5.wav",
	[6] = "cell/tone_6.wav",
	[7] = "cell/tone_7.wav",
	[8] = "cell/tone_8.wav",
	[9] = "cell/tone_v.wav",
	["Silent"] = "",
}

McPhone.Exp = Theme

McPhone.PhoneTypes.Exp = {
	main_mat = Material("mc_phone/phone/se/p.png", "smooth"),
	frame_mat = Material("mc_phone/phone/se/f.png", "smooth"),
	size = {225, 518},
	spos = {24, 34},
	top_align = TEXT_ALIGN_LEFT,
	text_color = color_white,
	text_bg = color_black,
	sctoffset = 20,
	r_snd = {
		["toggle"] = "mc_phone/notify/cell/Press.mp3",
		["open"] = "mc_phone/notify/cell/Open.mp3",
		["click"] = "mc_phone/notify/cell/Button.mp3",
	}
}

local text_pos = 0
local text_dir
local ScrW, ScrH = ScrW, ScrH
local colors = McPhone.MainColors

local sub_clrs = {
	black_50 = Color(0, 0, 0, 50),
	red = Color(255, 0, 0),
	green_55 = Color(155, 255, 155),
	white_250 = Color(250, 250, 250),
	white_202 = Color(202, 202, 202),
	white_50a = Color(255, 255, 255, 50),
	white_107 = Color(107, 107, 107),
}

local x1, y1, w1, w2

McPhone.PhoneTypes.Exp.PaintTop = function(w, h)
	if McPhone.UserCfg.WallPaper and not McPhone.UI.Menu.List and McPhone.UserCfg.WallPaper ~= "" then
		McPhone.DrawTexturedRect(0, 0, w, h, "mc_phone/wp/" .. McPhone.UserCfg.WallPaper, McPhone.UserCfg.Theme["buttons"])
	else
		MSDX.Draw(0, 0, 0, w, h, color_black)
	end

	MSD.ShadowText(McPhone.GetCurTime(), "McPhone.Main16", w - 5, 2, color_white, TEXT_ALIGN_RIGHT)
	McPhone.DrawTexturedRect(5, 2, 20, 12, "mc_phone/icons/icons_other/baterry.png", color_white)

	if McPhone.Signal < 1 then
		MSD.ShadowText("x", "McPhone.Main16", 35, 2, color_white, TEXT_ALIGN_RIGHT)
	else
		for i = 0, McPhone.Signal - 1 do
			x1, y1, w1, w2 = 30 + (i * 4 + i * 2), 9 - (i * 3), 4, 4 + (i * 3)
			MSDX.Draw(0, x1, y1, w1, w2, color_white)
			surface.SetDrawColor(sub_clrs.white_107)
			surface.DrawLine(x1, y1, x1, y1 + w2)
			surface.SetDrawColor(color_black)
			surface.DrawLine(x1 + w1, y1, x1 + w1, y1 + w2)
		end
	end

	local text = McPhone.UI.OpenedMenu
	surface.SetFont("McPhone.Main16")
	local tw = surface.GetTextSize(text)

	if tw > w then
		if text_dir and isnumber(text_dir) and text_dir < CurTime() then
			text_dir = nil
		end

		if text_pos > w - tw - 50 and not text_dir then
			text_pos = math.Approach(text_pos, w - tw - 50, FrameTime() * 70)
		else
			if text_pos >= 10 and not isnumber(text_dir) then
				text_dir = CurTime() + 2
			else
				text_pos = math.Approach(text_pos, 10, FrameTime() * 70)
			end

			if not text_dir then
				text_dir = true
			end
		end

		MSD.ShadowText(McPhone.UI.OpenedMenu, "McPhone.Main20", text_pos, 16, color_white, TEXT_ALIGN_LEFT)
	else
		MSD.ShadowText(McPhone.UI.OpenedMenu, "McPhone.Main20", 5, 16, color_white, TEXT_ALIGN_LEFT)
	end
end

local menu_replace = {
	["mc_phone/icons/main_menu/cam.png"] = "mc_phone/icons/icons_other/cam.png",
	["mc_phone/icons/main_menu/cont.png"] = "mc_phone/icons/icons_other/cont.png",
	["mc_phone/icons/main_menu/gps.png"] = "mc_phone/icons/icons_other/gps.png",
	["mc_phone/icons/main_menu/mail.png"] = "mc_phone/icons/icons_other/mail.png",
	["mc_phone/icons/main_menu/sets.png"] = "mc_phone/icons/icons_other/sets.png",
	["mc_phone/icons/main_menu/sms.png"] = "mc_phone/icons/icons_other/sms.png",
	["mc_phone/icons/main_menu/web.png"] = "mc_phone/icons/icons_other/web.png",
}

function McPhone.PhoneTypes.Exp.MainIcons(parent, icon, text, func, label)
	if menu_replace[icon] then
		icon = menu_replace[icon]
	end

	if isstring(icon) then
		icon = McPhone.GetMat(icon)
	end

	local buton = vgui.Create("DButton")
	buton:SetSize(56, 56)
	buton:SetText("")

	buton.DoClick = function(self)
		McPhone.PlaySoundUI("open")

		if func then
			func(self)
		end
	end

	buton.hs = 0

	buton.Paint = function(s, w, h)
		s.hs = s.hover and 0 or 8
		surface.SetMaterial(icon)
		surface.SetDrawColor(s.hover and color_white or sub_clrs.white_202)
		surface.DrawTexturedRect(s.hs, s.hs, w - s.hs * 2, w - s.hs * 2)
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute then
			McPhone.PlaySoundUI("click")
		end

		self.hover = true

		if McPhone.UI then
			McPhone.UI.OpenedMenu = text
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
end

function McPhone.PhoneTypes.Exp.OpenPhone(type)
	local theme = McPhone.PhoneTypes[McPhone.UserCfg.PhoneType]

	if not theme then
		theme = McPhone.PhoneTypes.McPhone
	end

	colors = McPhone.MainColors

	McPhone.UI = vgui.Create("DFrame")
	McPhone.UI:SetSize(theme.size[1], theme.size[2])
	McPhone.UI:SetPos(ScrW() - (theme.size[1] + 25), ScrH())

	McPhone.UI.OriginalPos = {McPhone.UI:GetPos(), ScrH() - (theme.size[2] - 130)}

	McPhone.UI:SetTitle("")
	McPhone.UI.Theme = theme
	McPhone.UI:SetDraggable(true)
	McPhone.UI:ShowCloseButton(false)
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

	McPhone.UI.Paint = function(self, w, h)
		McPhone.DrawTexturedRect(0, 0, w, h, theme.main_mat, color_white)
		McPhone.DrawTexturedRect(0, 0, w, h, theme.frame_mat, McPhone.UserCfg.Theme["phone"])
	end

	McPhone.UI:MoveTo(McPhone.UI:GetPos(), McPhone.UI.OriginalPos[2], 0.2)

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

	McPhone.UI.Scr = vgui.Create("DPanel", McPhone.UI)
	McPhone.UI.Scr:SetPos(theme.spos[1], theme.spos[2])
	McPhone.UI.Scr:SetSize(175, 260)

	McPhone.UI.Scr.Paint = function(self, w, h)
		theme.PaintTop(w, h, system.BatteryPower(), color_white)

		if McPhone.Notification then
			McPhone.Notification(self, w, h)
		end
	end

	McPhone.UI.Menu = vgui.Create("MSDPanelList", McPhone.UI)
	McPhone.UI.Menu:SetPos(theme.spos[1] + 4, theme.spos[2] + 45)
	McPhone.UI.Menu:SetSize(175, 215)
	McPhone.UI.Menu:EnableHorizontal(true)
	McPhone.UI.Menu:EnableVerticalScrollbar(true)
	McPhone.UI.Menu:SetSpacing(0)
	McPhone.UI.Menu.List = false
	McPhone.UI.Menu.Paint = function(self, w, h)
		if self.CustomPaint then
			self.CustomPaint(self, w, h)
		end
	end
	McPhone.UI.Menu.VBar.Paint = function() end
	McPhone.UI.Menu.VBar.btnUp.Paint = function() end
	McPhone.UI.Menu.VBar.btnDown.Paint = function() end
	McPhone.UI.Menu.VBar.btnGrip.Paint = function() end

	McPhone.UI.Menu.ConvertToList = function()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.Menu:SetPos(theme.spos[1], theme.spos[2] + 45)
		McPhone.UI.Menu:SetSize(175, 215)
		McPhone.UI.Menu.List = true
		McPhone.UI.Menu.CustomPaint = nil
	end

	McPhone.UI.Menu.ConvertToMenu = function()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.Menu:SetPos(theme.spos[1] + 4, theme.spos[2] + 45)
		McPhone.UI.Menu:SetSize(175, 215)
		McPhone.UI.Menu.List = false
		McPhone.UI.Menu.CustomPaint = nil
	end

	local buton = vgui.Create("DButton", McPhone.UI)
	buton:SetSize(55, 50)
	buton:SetPos(16, 312)
	buton:SetText("")

	buton.DoClick = function(self)
		if McPhone.UI.Buttons.Left[3] then
			McPhone.UI.Buttons.Left[3]()
		end
	end

	buton.Paint = function(self, w, h)
		surface.SetDrawColor(color_white)
		if McPhone.UI.Buttons.Left[1] then
			surface.SetMaterial(McPhone.GetMat("mc_phone/icons/icons_other/but_l.png"))
		else
			surface.SetMaterial(McPhone.GetMat("mc_phone/icons/icons_other/but_d.png"))
		end

		surface.DrawTexturedRect(0, 0, w, 25)
	end

	local buton2 = vgui.Create("DButton", McPhone.UI)
	buton2:SetSize(32, 30)
	buton2:SetPos(96, 332)
	buton2:SetText("")
	buton2.DoClick = function(self)
		if McPhone.UI.Buttons.Middle[3] then
			McPhone.UI.Buttons.Middle[3]()
		else
			McPhone.EnterPress()
		end
	end
	buton2.Paint = function() end

	local buton3 = vgui.Create("DButton", McPhone.UI)
	buton3:SetSize(55, 25)
	buton3:SetPos(153, 312)
	buton3:SetText("")
	buton3.DoClick = function(self)
		if McPhone.UI.Buttons.Right[3] then
			McPhone.UI.Buttons.Right[3]()
		else
			McPhone.GoBack()
		end
	end
	buton3.Paint = function(self, w, h)
		surface.SetDrawColor(color_white)
		if McPhone.UI.Buttons.Right[1] then
			surface.SetMaterial(McPhone.GetMat("mc_phone/icons/icons_other/but_l.png"))
		else
			surface.SetMaterial(McPhone.GetMat("mc_phone/icons/icons_other/but_d.png"))
		end

		surface.DrawTexturedRect(0, 0, w, h)
	end

	local bb = vgui.Create("DButton", McPhone.UI)
	bb:SetSize(55, 25)
	bb:SetPos(153, 337)
	bb:SetText("")
	bb.DoClick = function(self)
		McPhone.GoBack()
	end
	bb.Paint = function() end

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

function McPhone.PhoneTypes.Exp.ListIcons(parent, icon, text, check, func, ignore, snd, supress)
	if istable(icon) then
		icon_nohover = icon[2]
		icon = icon[1]
	end

	local buton = vgui.Create("DButton")
	buton.icon = icon
	buton.check = check
	buton:SetSize(256, 26)
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
			MSDX.Draw(0, 0, 0, w, h, McPhone.UserCfg.Theme["buttons"])
		else
			surface.SetDrawColor(sub_clrs.white_50a)
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		draw.SimpleText(text, "McPhone.Main16", h + 5, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		if isstring(icon) then
			McPhone.DrawTexturedRect(1, 1, h - 2, h - 2, McPhone.GetUrlIcon(icon, icon_url), color_white)
		end
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

function McPhone.PhoneTypes.Exp.ListNoIcons(parent, text, func, ignore, snd, supress)
	local buton = vgui.Create("DButton")
	buton:SetSize(256, 26)
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
			MSDX.Draw(0, 0, 0, w, h, McPhone.UserCfg.Theme["buttons"])
		else
			surface.SetDrawColor(sub_clrs.white_50a)
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		draw.SimpleText(text, "McPhone.Main16", 2, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		MSDX.Draw(0, 0, h - 3, w, 3, McPhone.MainColors.shadow_100)
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

function McPhone.PhoneTypes.Exp.ListSimple(parent, name, text, icon, func, ignore, snd, supress)
	local buton = vgui.Create("DButton")
	buton:SetSize(256, 32)
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

	buton.Paint = function(self, w, h)
		if self.hover then
			MSDX.Draw(0, 0, 0, w, h, McPhone.UserCfg.Theme["buttons"])
		else
			surface.SetDrawColor(sub_clrs.white_50a)
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		if icon then
			McPhone.DrawTexturedRect(1, h / 2 - 12, 24, 24, icon, color_white)
			self.spaser = 25
		end

		draw.SimpleText(name, "McPhone.Main16", 2 + self.spaser,  h / 4, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.SimpleText(text, "McPhone.Main16", 2 + self.spaser, h / 2 + h / 4, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		MSDX.Draw(0, 0, h - 3, w, 3, McPhone.MainColors.shadow_100)
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

function McPhone.PhoneTypes.Exp.ListTexts(parent, sms, name, text, time, check, func, ismail, ignore, snd, supress)
	if sms then
		if ismail then
			sms = McPhone.Mail[sms]
		else
			sms = McPhone.SMS[sms]
		end
	end

	local buton = vgui.Create("DButton")
	buton:SetSize(256, 32)
	buton:SetText("")
	buton.spaser = 0
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

	buton.Paint = function(self, w, h)
		if self.hover then
			MSDX.Draw(0, 0, 0, w, h, McPhone.UserCfg.Theme["buttons"])
		else
			surface.SetDrawColor(sub_clrs.white_50a)
			surface.DrawLine(0, h - 1, w, h - 1)
		end

		if sms and sms.New then
			McPhone.DrawTexturedRect(1, h / 2 - 8, 16, 16, "mc_phone/icons/icons_other/flag.png", color_white)
			self.spaser = 16
		end

		draw.DrawText(name, "McPhone.Main16", 5 + self.spaser, 0, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		draw.DrawText(text, "McPhone.Main16", 5 + self.spaser, 16, self.hover and color_white or sub_clrs.white_202, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		MSDX.Draw(0, 0, h - 3, w, 3, McPhone.MainColors.shadow_100)
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

function McPhone.PhoneTypes.Exp.Notify(title, text, snd, icon)
	if snd then
		local tone = isstring(snd) and snd or "tone_2"
		McPhone.PlaySound("mc_phone/sms/" .. tone .. ".wav")
	end

	if McPhone.UI and McPhone.UI.Scr and not IsValid(McPhone.ActiveWeb) then
		local stimer = CurTime() + 3
		local tall = 18

		if text then
			text = MSD.TextWrap(string.subUTF8(text, 0, 100), "McPhone.Main24", 270)
			tall = 32
			text = string.Explode("\n", text)
			text = text[1] .. (text[2] and ".." or "")
		end

		McPhone.Notification = function(self, w, h)
			MSDX.Draw(0, 0, 0, w, tall / 2, color_white)
			MSDX.Draw(0, 0, tall / 2, w, tall / 2, sub_clrs.white_202)

			McPhone.DrawTexturedRect(2, tall / 2 - 6, 16, 16, "mc_phone/icons/icons_other/flag.png", color_white)
			draw.DrawText(title, "McPhone.Main16", 20, 0, color_black, TEXT_ALIGN_LEFT)

			if text then
				draw.DrawText(text, "McPhone.Main16", 20, 16, color_black, TEXT_ALIGN_LEFT)
			end

			if stimer < CurTime() then
				McPhone.Notification = nil
			end
		end
	else
		local stimer = CurTime() + 5
		local alpha = 0
		local tall = 30

		if text then
			text = MSD.TextWrap(string.subUTF8(text, 0, 100), "McPhone.Main24", 270)
			tall = 60
			text = string.Explode("\n", text)
			text = text[1] .. (text[2] and ".." or "")
		end

		local x, y = ScrW() - 320, ScrH()
		local p1, p2, p3, p4
		title = string.subUTF8(title, 0, 12)

		McPhone.HudNotification = function()
			p1, p2, p3, p4 = x, y - alpha, 300, tall
			MSDX.Draw(8, p1 - 1, p2 - 1, p3 + 4, p4 + 4, color_black)
			MSDX.Draw(8, p1, p2, p3, p4 / 2, McPhone.UserCfg.Theme["phone"], MSDX.NO_BL + MSDX.NO_BR)
			MSDX.Draw(8, p1, p2 + p4 / 2, p3, p4 / 2, Color(244, 236, 218), MSDX.NO_TL + MSDX.NO_TR)
			draw.DrawText(title, "McPhone.Main28", x + 10, y - alpha, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)

			if text then
				draw.DrawText(text, "McPhone.Main24", x + 10, y - alpha + 30, color_black, TEXT_ALIGN_LEFT)
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

function McPhone.PhoneTypes.Exp.CallSct(self, w, h, status, contact, icon, payphone, call_bg)
	if not self.fixtimer then
		McPhone.AcceptedTime = CurTime()
		self.fixtimer = true
	end
	MSDX.Draw(0, 0, 0, w, 118, color_black)
	McPhone.DrawTexturedRect(0, 0, w, h, "mc_phone/phone/grad.png", sub_clrs.white_50a)
	draw.SimpleTextOutlined(contact, "McPhone.Main18", 5, 15, color_white, TEXT_ALIGN_LEFT, 1, 2, sub_clrs.black_50)
	draw.SimpleTextOutlined(string.upper(McPhone.GetPhrase(status)), "McPhone.Main18", 45, 35, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, sub_clrs.black_50)

	if McPhone.AcceptedTime then
		draw.SimpleTextOutlined(string.FormattedTime(CurTime() - McPhone.AcceptedTime, "%02i:%02i"), "McPhone.Main18", 45, 60, color_white, TEXT_ALIGN_LEFT, 1, 1, sub_clrs.black_50)
	end

	if isstring(icon) then
		McPhone.DrawTexturedRect(5, 35, 32, 32, icon, color_white)
	end
end

function McPhone.PhoneTypes.Exp.NumberMenu(back)
	McPhone.UI.Focus = {McPhone.UI:GetX(), McPhone.UI:GetY()}
	McPhone.UI:MoveTo(McPhone.UI:GetPos(), McPhone.UI.OriginalPos[2] - 120, 0.2)
	McPhone.UI.Menu:Clear()

	McPhone.UI.Menu.CustomPaint = function(s, w, h)
		MSDX.Draw(0, 0, 0, w, 118, color_black)
		McPhone.DrawTexturedRect(0, 0, w, h, "mc_phone/phone/grad.png", sub_clrs.white_50a)

		draw.SimpleTextOutlined(McPhone.UI.OpenedMenu == "" and "Введите номер" or McPhone.UI.OpenedMenu, "McPhone.Main24", w / 2, 15, color_white, TEXT_ALIGN_CENTER, 1, 2, sub_clrs.black_50)

		if McPhone.UI.Buttons.Left[1] then
			McPhone.DrawTexturedRect(5, h - 30, 26, 26, McPhone.UI.Buttons.Left[1], McPhone.UI.Buttons.Left[2])
		end

		if McPhone.UI.Buttons.Middle[1] then
			McPhone.DrawTexturedRect(w / 2 - 12, h - 30, 26, 26, McPhone.UI.Buttons.Middle[1], McPhone.UI.Buttons.Middle[2])
		end

		if McPhone.UI.Buttons.Right[1] then
			McPhone.DrawTexturedRect(w - 30, h - 30, 26, 26, McPhone.UI.Buttons.Right[1], McPhone.UI.Buttons.Right[2])
		end
	end

	McPhone.UI.Buts = vgui.Create("MSDPanelList", McPhone.UI)
	McPhone.UI.Buts:SetPos(16, 385)
	McPhone.UI.Buts:SetSize(192, 106)
	McPhone.UI.Buts:EnableHorizontal(true)
	McPhone.UI.Buts:EnableVerticalScrollbar(true)
	McPhone.UI.Buts:SetSpacing(1)
	McPhone.UI.Buts.List = false
	McPhone.UI.Buts.Paint = function(self, w, h) end
	McPhone.UI.Buts.VBar.Paint = function() end
	McPhone.UI.Buts.VBar.btnUp.Paint = function() end
	McPhone.UI.Buts.VBar.btnDown.Paint = function() end
	McPhone.UI.Buts.VBar.btnGrip.Paint = function() end

	McPhone.NumberIcons(McPhone.UI.Buts, 63, "1", nil, KEY_PAD_1)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "2", "ABC", KEY_PAD_2)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "3", "DEF", KEY_PAD_3)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "4", "GHI", KEY_PAD_4)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "5", "JKL", KEY_PAD_5)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "6", "MNO", KEY_PAD_6)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "7", "PQRS", KEY_PAD_7)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "8", "TUV", KEY_PAD_8)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "9", "WXYZ", KEY_PAD_9)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "*", nil, KEY_PAD_MULTIPLY)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "0", nil, KEY_PAD_0)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "#", nil, KEY_PAD_DIVIDE)

	McPhone.UI.Focus[3] = function()
		if IsValid(McPhone.UI.Buts) then McPhone.UI.Buts:Remove() end
	end

	McPhone.UI.Buttons.Left = {
		"mc_phone/icons/buttons/id17.png", McPhone.MainColors["blue"], function()
			local number = McPhone.UI.OpenedMenu
			if number == "" then return end
			McPhone.LastNumber = number
			local lastcall = McPhone.GetByNumber(number)

			if IsValid(lastcall) and lastcall ~= ply then
				McPhone.LastNumber = lastcall
				McPhone.AddContacts(number, lastcall:Name())
			end

			net.Start("McPhone.CallStart")
			net.WriteString(number)
			net.WriteBool(false)
			net.SendToServer()
			McPhone.GoBack()
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

function McPhone.PhoneTypes.Exp.NumberIcons(parent, size, text, text2, presscode)
	local buton = vgui.Create("DButton")
	buton:SetSize(size, 25)
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
		-- surface.SetDrawColor(0, 0, 0, 120)
		-- surface.DrawOutlinedRect(0, 0, w, h)

		if text2 then
			draw.SimpleText(text, "McPhone.Main16", w / 2, 2,  MSD.Text.d, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
			draw.SimpleText(text2, "McPhone.Main12", w / 2, h, MSD.Text.n, TEXT_ALIGN_CENTER, TEXT_ALIGN_BOTTOM)
		else
			draw.SimpleText(text, "McPhone.Main22", w / 2, h / 2, MSD.Text.d, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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

local Theme2 = {}
Theme2.ent = "phone_bj"

Theme2.Themes = {
	["Red"] = {
		["menu"] = Color(170, 0, 0),
		["buttons"] = Color(130, 0, 0),
		["phone"] = color_white,
		["def_wp"] = "Default",
	},
	["Green"] = {
		["menu"] = Color(0, 120, 0),
		["buttons"] = Color(50, 200, 50),
		["phone"] = color_white,
		["def_wp"] = "Default",
	},
	["Orange"] = {
		["menu"] = Color(240, 90, 0),
		["buttons"] = Color(255, 145, 40),
		["phone"] = color_white,
		["def_wp"] = "Default",
	},
	["Blue"] = {
		["menu"] = Color(134, 172, 234),
		["buttons"] = Color(0, 175, 240),
		["phone"] = color_white,
		["def_wp"] = "Default",
	},
	["Purple"] = {
		["menu"] = Color(50, 0, 110),
		["buttons"] = Color(190, 115, 235),
		["phone"] = color_white,
		["def_wp"] = "Default",
	},
	["Pink"] = {
		["menu"] = Color(196, 74, 141),
		["buttons"] = Color(240, 99, 123),
		["phone"] = color_white,
		["def_wp"] = "Default",
	},
}

Theme2.WallPapers = {
	["Заставка 1"] = "n/2.png",
	["Заставка 2"] = "n/3.png",
	["Default"] = "n/1.png",
}

Theme2.Ringtone = {
	[1] = "cell/tone_1.wav",
	[2] = "cell/tone_8.wav",
	[3] = "cell/nocla.mp3",
	["Silent"] = "",
}

McPhone.Nocla = Theme2

McPhone.PhoneTypes.Nocla = table.Copy(McPhone.PhoneTypes.Exp)
McPhone.PhoneTypes.Nocla.main_mat = Material("mc_phone/phone/se/n.png", "smooth")
McPhone.PhoneTypes.Nocla.ssize = {130, 166}
McPhone.PhoneTypes.Nocla.size = {225, 518}
McPhone.PhoneTypes.Nocla.spos = {47, 95}

local ScrW, ScrH = ScrW, ScrH

McPhone.PhoneTypes.Nocla.PaintTop = function(w, h)
	if McPhone.UserCfg.WallPaper and not McPhone.UI.Menu.List and McPhone.UserCfg.WallPaper ~= "" then
		McPhone.DrawTexturedRect(0, 0, w, h, "mc_phone/wp/" .. McPhone.UserCfg.WallPaper, McPhone.UserCfg.Theme["buttons"])
	else
		MSDX.Draw(0, 0, 0, w, h, color_black)
	end

	MSD.ShadowText(McPhone.GetCurTime(), "McPhone.Main16", w - 5, 2, color_white, TEXT_ALIGN_RIGHT)
	McPhone.DrawTexturedRect(5, 2, 20, 12, "mc_phone/icons/icons_other/baterry.png", color_white)

	if McPhone.Signal < 1 then
		MSD.ShadowText("x", "McPhone.Main16", 35, 2, color_white, TEXT_ALIGN_RIGHT)
	else
		for i = 0, McPhone.Signal - 1 do
			x1, y1, w1, w2 = 30 + (i * 4 + i * 2), 9 - (i * 3), 4, 4 + (i * 3)
			MSDX.Draw(0, x1, y1, w1, w2, color_white)
			surface.SetDrawColor(sub_clrs.white_107)
			surface.DrawLine(x1, y1, x1, y1 + w2)
			surface.SetDrawColor(color_black)
			surface.DrawLine(x1 + w1, y1, x1 + w1, y1 + w2)
		end
	end

	local text = McPhone.UI.OpenedMenu
	surface.SetFont("McPhone.Main16")
	local tw = surface.GetTextSize(text)

	if tw > w then
		if text_dir and isnumber(text_dir) and text_dir < CurTime() then
			text_dir = nil
		end

		if text_pos > w - tw - 50 and not text_dir then
			text_pos = math.Approach(text_pos, w - tw - 50, FrameTime() * 70)
		else
			if text_pos >= 10 and not isnumber(text_dir) then
				text_dir = CurTime() + 2
			else
				text_pos = math.Approach(text_pos, 10, FrameTime() * 70)
			end

			if not text_dir then
				text_dir = true
			end
		end

		MSD.ShadowText(McPhone.UI.OpenedMenu, "McPhone.Main20", text_pos, 16, color_white, TEXT_ALIGN_LEFT)
	else
		MSD.ShadowText(McPhone.UI.OpenedMenu, "McPhone.Main20", 5, 16, color_white, TEXT_ALIGN_LEFT)
	end
end

local menu_replace2 = {
	["mc_phone/icons/main_menu/cam.png"] = "mc_phone/icons/icons_old/cam.png",
	["mc_phone/icons/main_menu/cont.png"] = "mc_phone/icons/icons_old/cont.png",
	["mc_phone/icons/main_menu/gps.png"] = "mc_phone/icons/icons_old/gps.png",
	["mc_phone/icons/main_menu/mail.png"] = "mc_phone/icons/icons_old/mail.png",
	["mc_phone/icons/main_menu/sets.png"] = "mc_phone/icons/icons_old/sets.png",
	["mc_phone/icons/main_menu/sms.png"] = "mc_phone/icons/icons_old/sms.png",
	["mc_phone/icons/main_menu/web.png"] = "mc_phone/icons/icons_old/web.png",
}

function McPhone.PhoneTypes.Nocla.MainIcons(parent, icon, text, func, label)
	if menu_replace2[icon] then
		icon = menu_replace2[icon]
	end

	if isstring(icon) then
		icon = McPhone.GetMat(icon)
	end

	local buton = vgui.Create("DButton")
	buton:SetSize(42, 42)
	buton:SetText("")

	buton.DoClick = function(self)
		McPhone.PlaySoundUI("open")

		if func then
			func(self)
		end
	end

	buton.hs = 0

	buton.Paint = function(s, w, h)
		s.hs = s.hover and 0 or 8
		surface.SetMaterial(icon)
		surface.SetDrawColor(s.hover and color_white or sub_clrs.white_202)
		surface.DrawTexturedRect(s.hs, s.hs, w - s.hs * 2, w - s.hs * 2)
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute then
			McPhone.PlaySoundUI("click")
		end

		self.hover = true

		if McPhone.UI then
			McPhone.UI.OpenedMenu = text
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
end

function McPhone.PhoneTypes.Nocla.OpenPhone(type)
	local theme = McPhone.PhoneTypes[McPhone.UserCfg.PhoneType]

	if not theme then
		theme = McPhone.PhoneTypes.McPhone
	end

	colors = McPhone.MainColors

	McPhone.UI = vgui.Create("DFrame")
	McPhone.UI:SetSize(theme.size[1], theme.size[2])
	McPhone.UI:SetPos(ScrW() - (theme.size[1] + 25), ScrH())

	McPhone.UI.OriginalPos = {McPhone.UI:GetPos(), ScrH() - (theme.size[2] - 130)}

	McPhone.UI:SetTitle("")
	McPhone.UI.Theme = theme
	McPhone.UI:SetDraggable(true)
	McPhone.UI:ShowCloseButton(false)
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

	McPhone.UI.Paint = function(self, w, h)
		McPhone.DrawTexturedRect(0, 0, w, h, theme.main_mat, color_white)
	end

	McPhone.UI:MoveTo(McPhone.UI:GetPos(), McPhone.UI.OriginalPos[2], 0.2)

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

	McPhone.UI.Scr = vgui.Create("DPanel", McPhone.UI)
	McPhone.UI.Scr:SetPos(theme.spos[1], theme.spos[2])
	McPhone.UI.Scr:SetSize(theme.ssize[1], theme.ssize[2])

	McPhone.UI.Scr.Paint = function(self, w, h)
		theme.PaintTop(w, h, system.BatteryPower(), color_white)

		if McPhone.Notification then
			McPhone.Notification(self, w, h)
		end
	end

	McPhone.UI.Menu = vgui.Create("MSDPanelList", McPhone.UI)
	McPhone.UI.Menu:SetPos(theme.spos[1], theme.spos[2] + 45)
	McPhone.UI.Menu:SetSize(theme.ssize[1], theme.ssize[2] - 45)
	McPhone.UI.Menu:EnableHorizontal(true)
	McPhone.UI.Menu:EnableVerticalScrollbar(true)
	McPhone.UI.Menu:SetSpacing(0)
	McPhone.UI.Menu.List = false
	McPhone.UI.Menu.Paint = function(self, w, h)
		if self.CustomPaint then
			self.CustomPaint(self, w, h)
		end
	end
	McPhone.UI.Menu.VBar.Paint = function() end
	McPhone.UI.Menu.VBar.btnUp.Paint = function() end
	McPhone.UI.Menu.VBar.btnDown.Paint = function() end
	McPhone.UI.Menu.VBar.btnGrip.Paint = function() end

	McPhone.UI.Menu.ConvertToList = function()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.Menu:SetPos(theme.spos[1], theme.spos[2] + 45)
		McPhone.UI.Menu:SetSize(theme.ssize[1], theme.ssize[2] - 45)
		McPhone.UI.Menu.List = true
		McPhone.UI.Menu.CustomPaint = nil
	end

	McPhone.UI.Menu.ConvertToMenu = function()
		McPhone.UI.Menu:Clear(true)
		McPhone.UI.Menu:SetPos(theme.spos[1], theme.spos[2] + 45)
		McPhone.UI.Menu:SetSize(theme.ssize[1], theme.ssize[2] - 45)
		McPhone.UI.Menu.List = false
		McPhone.UI.Menu.CustomPaint = nil
	end

	local buton = vgui.Create("DButton", McPhone.UI)
	buton:SetSize(55, 50)
	buton:SetPos(16, 312)
	buton:SetText("")

	buton.DoClick = function(self)
		if McPhone.UI.Buttons.Left[3] then
			McPhone.UI.Buttons.Left[3]()
		end
	end

	buton.Paint = function() end

	local buton2 = vgui.Create("DButton", McPhone.UI)
	buton2:SetSize(32, 30)
	buton2:SetPos(96, 332)
	buton2:SetText("")
	buton2.DoClick = function(self)
		if McPhone.UI.Buttons.Middle[3] then
			McPhone.UI.Buttons.Middle[3]()
		else
			McPhone.EnterPress()
		end
	end
	buton2.Paint = function() end

	local buton3 = vgui.Create("DButton", McPhone.UI)
	buton3:SetSize(55, 25)
	buton3:SetPos(153, 312)
	buton3:SetText("")
	buton3.DoClick = function(self)
		if McPhone.UI.Buttons.Right[3] then
			McPhone.UI.Buttons.Right[3]()
		else
			McPhone.GoBack()
		end
	end
	buton3.Paint = function() end

	local bb = vgui.Create("DButton", McPhone.UI)
	bb:SetSize(55, 25)
	bb:SetPos(153, 337)
	bb:SetText("")
	bb.DoClick = function(self)
		McPhone.GoBack()
	end
	bb.Paint = function() end

	McPhone.UI.MainMenuOpen = function()
		McPhone.UI.Menu.ConvertToMenu()

		for id, mod in SortedPairs(McPhone.Modules) do
			if id == 1 then continue end
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

function McPhone.PhoneTypes.Nocla.NumberMenu(back)
	McPhone.UI.Focus = {McPhone.UI:GetX(), McPhone.UI:GetY()}
	McPhone.UI:MoveTo(McPhone.UI:GetPos(), McPhone.UI.OriginalPos[2] - 120, 0.2)
	McPhone.UI.Menu:Clear()

	McPhone.UI.Menu.CustomPaint = function(s, w, h)
		MSDX.Draw(0, 0, 0, w, 118, color_black)
		McPhone.DrawTexturedRect(0, 0, w, h, "mc_phone/phone/grad.png", sub_clrs.white_50a)

		draw.SimpleTextOutlined(McPhone.UI.OpenedMenu == "" and "Введите номер" or McPhone.UI.OpenedMenu, "McPhone.Main24", w / 2, 15, color_white, TEXT_ALIGN_CENTER, 1, 2, sub_clrs.black_50)

		if McPhone.UI.Buttons.Left[1] then
			McPhone.DrawTexturedRect(5, h - 30, 26, 26, McPhone.UI.Buttons.Left[1], McPhone.UI.Buttons.Left[2])
		end

		if McPhone.UI.Buttons.Middle[1] then
			McPhone.DrawTexturedRect(w / 2 - 12, h - 30, 26, 26, McPhone.UI.Buttons.Middle[1], McPhone.UI.Buttons.Middle[2])
		end

		if McPhone.UI.Buttons.Right[1] then
			McPhone.DrawTexturedRect(w - 30, h - 30, 26, 26, McPhone.UI.Buttons.Right[1], McPhone.UI.Buttons.Right[2])
		end
	end

	McPhone.UI.Buts = vgui.Create("MSDPanelList", McPhone.UI)
	McPhone.UI.Buts:SetPos(16, 405)
	McPhone.UI.Buts:SetSize(192, 106)
	McPhone.UI.Buts:EnableHorizontal(true)
	McPhone.UI.Buts:EnableVerticalScrollbar(true)
	McPhone.UI.Buts:SetSpacing(1)
	McPhone.UI.Buts.List = false
	McPhone.UI.Buts.Paint = function(self, w, h) end
	McPhone.UI.Buts.VBar.Paint = function() end
	McPhone.UI.Buts.VBar.btnUp.Paint = function() end
	McPhone.UI.Buts.VBar.btnDown.Paint = function() end
	McPhone.UI.Buts.VBar.btnGrip.Paint = function() end

	McPhone.NumberIcons(McPhone.UI.Buts, 63, "1", nil, KEY_PAD_1)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "2", nil, KEY_PAD_2)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "3", nil, KEY_PAD_3)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "4", nil, KEY_PAD_4)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "5", nil, KEY_PAD_5)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "6", nil, KEY_PAD_6)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "7", nil, KEY_PAD_7)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "8", nil, KEY_PAD_8)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "9", nil, KEY_PAD_9)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "*", nil, KEY_PAD_MULTIPLY)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "0", nil, KEY_PAD_0)
	McPhone.NumberIcons(McPhone.UI.Buts, 63, "#", nil, KEY_PAD_DIVIDE)

	McPhone.UI.Focus[3] = function()
		if IsValid(McPhone.UI.Buts) then McPhone.UI.Buts:Remove() end
	end

	McPhone.UI.Buttons.Left = {
		"mc_phone/icons/buttons/id17.png", McPhone.MainColors["blue"], function()
			local number = McPhone.UI.OpenedMenu
			if number == "" then return end
			McPhone.LastNumber = number
			local lastcall = McPhone.GetByNumber(number)

			if IsValid(lastcall) and lastcall ~= ply then
				McPhone.LastNumber = lastcall
				McPhone.AddContacts(number, lastcall:Name())
			end

			net.Start("McPhone.CallStart")
			net.WriteString(number)
			net.WriteBool(false)
			net.SendToServer()
			McPhone.GoBack()
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

function McPhone.PhoneTypes.Nocla.NumberIcons(parent, size, text, text2, presscode)
	local buton = vgui.Create("DButton")
	buton:SetSize(size, 25)
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

local Theme3 = {}
Theme3.ent = "phone_bj"

Theme3.Themes = {
	["北京市"] = {
		["menu"] = Color(170, 0, 0),
		["buttons"] = Color(130, 0, 0),
		["phone"] = color_white,
		["def_wp"] = "Default",
	},
}

Theme3.WallPapers = {
	["北京市"] = "bch/1.png",
	["淇淋"] = "bch/2.png",
	["冰淇淋"] = "bch/3.png",
	["Default"] = "bch/1.png",
}

Theme3.Ringtone = {
	[1] = "cell/redsun.mp3",
}

McPhone.Beijing = Theme3

McPhone.PhoneTypes.Beijing = table.Copy(McPhone.PhoneTypes.Nocla)
McPhone.PhoneTypes.Beijing.main_mat = Material("mc_phone/phone/se/c.png", "smooth")
McPhone.PhoneTypes.Beijing.ssize = {180, 250}
McPhone.PhoneTypes.Beijing.size = {225, 518}
McPhone.PhoneTypes.Beijing.spos = {22, 27}

McPhone.PhoneTypes.Beijing.PaintTop = function(w, h)
	if McPhone.UserCfg.WallPaper and McPhone.UserCfg.WallPaper ~= "" then
		McPhone.DrawTexturedRect(0, 0, w, h, "mc_phone/wp/" .. McPhone.UserCfg.WallPaper, color_white)
	else
		MSDX.Draw(0, 0, 0, w, h, color_black)
	end

	if McPhone.UI.Menu.List then
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
	end

	MSD.ShadowText(McPhone.GetCurTime(), "McPhone.Main16", w - 5, 2, color_white, TEXT_ALIGN_RIGHT)
	McPhone.DrawTexturedRect(5, 2, 20, 12, "mc_phone/icons/icons_other/baterry.png", color_white)

	if McPhone.Signal < 1 then
		MSD.ShadowText("x", "McPhone.Main16", 35, 2, color_white, TEXT_ALIGN_RIGHT)
	else
		for i = 0, McPhone.Signal - 1 do
			x1, y1, w1, w2 = 30 + (i * 4 + i * 2), 9 - (i * 3), 4, 4 + (i * 3)
			MSDX.Draw(0, x1, y1, w1, w2, color_white)
			surface.SetDrawColor(sub_clrs.white_107)
			surface.DrawLine(x1, y1, x1, y1 + w2)
			surface.SetDrawColor(color_black)
			surface.DrawLine(x1 + w1, y1, x1 + w1, y1 + w2)
		end
	end

	local text = McPhone.UI.OpenedMenu
	surface.SetFont("McPhone.Main16")
	local tw = surface.GetTextSize(text)

	if tw > w then
		if text_dir and isnumber(text_dir) and text_dir < CurTime() then
			text_dir = nil
		end

		if text_pos > w - tw - 50 and not text_dir then
			text_pos = math.Approach(text_pos, w - tw - 50, FrameTime() * 70)
		else
			if text_pos >= 10 and not isnumber(text_dir) then
				text_dir = CurTime() + 2
			else
				text_pos = math.Approach(text_pos, 10, FrameTime() * 70)
			end

			if not text_dir then
				text_dir = true
			end
		end

		MSD.ShadowText(McPhone.UI.OpenedMenu, "McPhone.Main20", text_pos, 16, color_white, TEXT_ALIGN_LEFT)
	else
		MSD.ShadowText(McPhone.UI.OpenedMenu, "McPhone.Main20", 5, 16, color_white, TEXT_ALIGN_LEFT)
	end
end

local menu_replace3 = {
	["mc_phone/icons/main_menu/cam.png"] = 0,
	["mc_phone/icons/main_menu/cont.png"] = "mc_phone/icons/icons_bch/cont.png",
	["mc_phone/icons/main_menu/gps.png"] = "mc_phone/icons/icons_bch/gps.png",
	["mc_phone/icons/main_menu/mail.png"] = "mc_phone/icons/icons_bch/mail.png",
	["mc_phone/icons/main_menu/sets.png"] = "mc_phone/icons/icons_bch/sets.png",
	["mc_phone/icons/main_menu/sms.png"] = "mc_phone/icons/icons_bch/sms.png",
	["mc_phone/icons/main_menu/web.png"] = "mc_phone/icons/icons_bch/web.png",
}

function McPhone.PhoneTypes.Beijing.MainIcons(parent, icon, text, func, label)
	if menu_replace3[icon] then
		if menu_replace3[icon] == 0 then
			return
		end
		icon = menu_replace3[icon]
	end

	if isstring(icon) then
		icon = McPhone.GetMat(icon)
	end

	local buton = vgui.Create("DButton")
	buton:SetSize(55, 55)
	buton:SetText("")

	buton.DoClick = function(self)
		McPhone.PlaySoundUI("open")

		if func then
			func(self)
		end
	end

	buton.hs = 0

	buton.Paint = function(s, w, h)
		s.hs = s.hover and 0 or 8
		surface.SetMaterial(icon)
		surface.SetDrawColor(s.hover and color_white or sub_clrs.white_202)
		surface.DrawTexturedRect(s.hs, s.hs, w - s.hs * 2, w - s.hs * 2)
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute then
			McPhone.PlaySoundUI("click")
		end

		self.hover = true

		if McPhone.UI then
			McPhone.UI.OpenedMenu = text
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
end