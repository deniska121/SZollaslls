--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/modules/web.lua
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
--if !GlorifiedBanking then return end
local module_id = 7
McPhone.Modules[module_id] = {}
McPhone.Modules[module_id].name = "Интернет"
McPhone.Modules[module_id].icon = "mc_phone/icons/main_menu/web.png"
McPhone.Modules[module_id].number = 0

McPhone.Modules[module_id].openMenu = function()
	McPhone.OpenPhoneWebmenu()
end

local cashed_ics = {}

local function DWebButtonIcons(par, x, y, icon, func, exfunc)

	if not cashed_ics[icon] then
		cashed_ics[icon] = Material(icon, "smooth")
	end

	icon = cashed_ics[icon]

	local buton = vgui.Create("DButton", par)
	buton:SetSize(36, 36)
	buton:SetText("")
	buton:SetPos(x, y)
	buton.DoClick = func

	if exfunc then
		buton.Think = exfunc
	end

	buton.Paint = function(self, w, h)
		MSDX.Draw(6, 0, 0, w, h, Color(100, 100, 100))
		MSDX.Draw(6, 1, 1, w - 2, h - 2, Color(200, 200, 200))
		surface.SetMaterial(icon)

		if self.hover then
			surface.SetDrawColor(0, 0, 0, 250)
		else
			surface.SetDrawColor(0, 0, 0, 180)
		end

		surface.DrawTexturedRect(2, 2, 32, 32)
	end

	buton.OnCursorEntered = function(self)
		self.hover = true
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end
end

local module_icons = {
	["propertie"] = Material("gmodla/f4/skyline.png", "smooth"),
	["shop"] = Material("gmodla/f4/shop.png", "smooth"),
	["gov"] = Material("gmodla/f4/gov.png", "smooth")
}

local paled = {
	["black_a100"] = Color(0, 0, 0, 185),
	["grey100"] = Color(100, 100, 100),
	["grey200"] = Color(200, 200, 200),
	["white250"] = Color(250, 250, 250),
	["green"] = Color(149, 240, 193),
	["blue"] = Color(75, 140, 195),
	["orange"] = Color(255, 190, 0),
}

local logo = Material("mc_phone/web/mac_finder.png", "smooth")
local bg = Material("mc_phone/web/bg_mf.png", "noclamp")
local loadm = Material("vgui/loading-rotate", "noclamp")
local bg_c = Color(255, 255, 255, 100)

function McPhone.NoSignal(parent, w, h)
	local main = vgui.Create("DPanel", parent)
	main:Dock(FILL)
	main.Paint = function(self, wd, ht)
		local r = h / 10
		MSD.DrawTexturedRectRotated(math.sin(CurTime()) * 360, w / 2, h / 2, r, r, loadm, color_black)
	end
end

local function labelText(parent, text, cl)
	local button = vgui.Create("DPanel")
	button.StaticScale = { w = 1, fixed_h = 60, minw = 256, minh = 60}
	button.Paint = function(self, wd, hd)
		draw.SimpleText(text, "Banff.H1", 6, 6, color_black, TEXT_ALIGN_LEFT)
		draw.SimpleText(text, "Banff.H1", 5, 5, cl or paled["blue"], TEXT_ALIGN_LEFT)
	end

	parent:AddItem(button)
end

function McPhone.MacFinder(parent, w, h)
	local top = vgui.Create("DPanel", parent)
	top:SetSize(0, h / 6)
	top:Dock(TOP)

	local name = string.Explode(" ", LocalPlayer():FullName())
	local mail = string.lower(name[1] .. name[2] .. string.sub(LocalPlayer():AccountID(), 3, 5) .. "@macfinder.info")
	top.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, paled.blue)
		MSDX.Draw(0, 0, ht - 8, wd, 8, paled.orange)
		MSD.DrawTexturedRect(23, 3, 300, 164, logo, color_black)
		MSD.DrawTexturedRect(20, 0, 300, 164, logo, color_white)

		draw.SimpleText(mail, "MSDFontB.24", w - 13, 7, color_black, TEXT_ALIGN_RIGHT)
		draw.SimpleText(mail, "MSDFontB.24", w - 15, 5, color_white, TEXT_ALIGN_RIGHT)
	end

	local buton = vgui.Create("DButton", top)
	buton:SetSize(250, h / 6)
	buton:SetText("")
	buton:Dock(RIGHT)
	buton.DoClick = function(self)
		McPhone.PlaySoundUI("click")
		McPhone.UpdateWeb(McPhone.MacFinderMail)
	end
	buton.Paint = function(self, wd, hd)
		draw.SimpleText("✉ Перейти в почту", "MSDFontB.24", wd - 13, 37, color_black, TEXT_ALIGN_RIGHT)
		draw.SimpleText("✉ Перейти в почту", "MSDFontB.24", wd - 15, 35, self.hover and paled["green"] or paled["orange"], TEXT_ALIGN_RIGHT)
	end
	buton.OnCursorEntered = function(self) self.hover = true end
	buton.OnCursorExited = function(self) self.hover = false end

	local main = vgui.Create("DPanel", parent)
	main:Dock(FILL)
	main.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, color_white)
		surface.SetMaterial(bg)
		surface.SetDrawColor(bg_c)
		surface.DrawTexturedRectUV(0, 0, wd, ht, 0, 0, wd / 450, ht / 390)
	end

	local body = vgui.Create("DPanel", main)
	body:Dock(FILL)
	body:DockMargin(25, 0,25, 0)
	body:DockPadding(25, 0, 25, 0)
	body.Paint = function(self, wd, ht) end

	local blist = vgui.Create("MSDPanelList", body)
	blist:SetSize(w - 100, h - h / 6)
	blist:SetPos(25, 0)
	blist:EnableVerticalScrollbar()
	blist:EnableHorizontal(true)
	blist:SetPadding(5)
	blist:SetSpacing(5)
	blist.IgnoreVbar = true
	blist.Paint = function() end
	local othersites = {}

	labelText(blist, "Самые популярные веб сайты", paled["orange"])

	for id, mod in pairs(McPhone.WebModules) do

		if not module_icons[id] then
			module_icons[id] = Material("mc_phone/web/presets/" .. id .. ".png", "smooth")
		end

		local mat = module_icons[id]

		if mat:IsError() then
			othersites[id] = mod
			continue
		end

		local button = vgui.Create("DButton")
		button.StaticScale = { w = 3, fixed_h = 190, minw = 256, minh = 100}
		button:SetText("")
		button.alpha = 0
		button.Paint = function(self, wd, hd)
			local iw = self.hover and wd + 30 or wd
			local ih = iw * 0.562

			MSD.DrawTexturedRectRotated(0, wd / 2, ih / 2, iw, ih, mat, color_white)
			MSDX.Draw(0, 0, hd - 40, wd, 40, paled.blue)
			--draw.RoundedBox(0, 0, 0, wd, 15, paled.orange)
			surface.SetDrawColor( paled.blue )
			surface.DrawOutlinedRect(0, 0, wd, hd, 3)

			draw.SimpleText(mod.url, "McPhone.Main18", 5, hd - 30, color_white, TEXT_ALIGN_LEFT)
		end

		button.DoClick = function(self)
			mod.OpenWebmenu()
			McPhone.PlaySoundUI("click")
		end

		button.OnCursorEntered = function(self)
			self.hover = true
		end

		button.OnCursorExited = function(self)
			self.hover = false
		end

		blist:AddItem(button)
	end

	labelText(blist, "Другие популярные веб сайты")

	for id, mod in pairs(othersites) do

		local button = vgui.Create("DButton")
		button.StaticScale = { w = 1, fixed_h = 45, minw = 90, minh = 45}
		button:SetText("")
		button.alpha = 0
		button.Paint = function(self, wd, hd)
			draw.SimpleText(mod.url, "SlideR.H1", 6, 6, color_black, TEXT_ALIGN_LEFT)
			draw.SimpleText(mod.url, "SlideR.H1", 5, 5, self.hover and paled["blue"] or paled["orange"], TEXT_ALIGN_LEFT)
		end

		button.DoClick = function(self)
			mod.OpenWebmenu()
			McPhone.PlaySoundUI("click")
		end

		button.OnCursorEntered = function(self)
			self.hover = true
		end

		button.OnCursorExited = function(self)
			self.hover = false
		end

		blist:AddItem(button)
	end
end

function McPhone.OpenPhoneWebmenu()
	if McPhone.ActiveWeb then
		McPhone.ActiveWeb:Close()
		McPhone.ActiveWeb = nil
	end

	local pw, ph = McPhone.UI.Scr:GetSize()
	local px, py = McPhone.UI:LocalToScreen(McPhone.UI.Scr:GetPos())

	McPhone.ActiveWeb = vgui.Create("DFrame")
	McPhone.ActiveWeb:SetSize(pw, ph)
	McPhone.ActiveWeb:SetPos(px, py)
	McPhone.ActiveWeb:SetTitle("")
	McPhone.ActiveWeb:SetDraggable(false)
	McPhone.ActiveWeb:MakePopup()
	McPhone.ActiveWeb:ShowCloseButton(false)

	function McPhone.ActiveWeb:OnClose()
		McPhone.ActiveWeb = nil
	end

	local phone_table = McPhone.PhoneTypes[McPhone.UserCfg.PhoneType]

	if not phone_table then
		phone_table = McPhone.PhoneTypes.McPhone
	end

	McPhone.ActiveWeb.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self)

		phone_table.PaintTop(w, h, 1, color_white)

		MSDX.Draw(0, 0, 0, w, 25, color_black)
		MSDX.Draw(0, 0, 25, w, 95, paled.grey200)
		MSDX.Draw(0, 0, 120, w, h - 120, paled.white250)
		MSD.DrawTexturedRect(0, 25, w, 95, "gui/gradient_up", paled.black_a100)
		draw.SimpleText(McPhone.GetCurTime(), "McPhone.Main22", w / 2 - 1, 2, color_white, TEXT_ALIGN_CENTER)

		MSDX.Draw(0, 0, 117, w, 3, color_black)

		if not self.loaded then
			local r = h / 10
			MSD.DrawTexturedRectRotated(math.sin(CurTime()) * 360, w / 2, h / 2, r, r, loadm, color_black)
		end
	end

	McPhone.ActiveWeb.Think = function(self)
		if input.IsKeyDown(KEY_ESCAPE) or not IsValid(McPhone.UI) then
			self:Remove()
			McPhone.ActiveWeb.WebAdress = nil
			McPhone.ActiveWeb = nil
		end
	end

	local tes = ScrW() / 2

	local drme = vgui.Create("DTextEntry", McPhone.ActiveWeb)
	drme:SetText("")
	drme:SetFont("McPhone.Main32")
	drme:SetPos(88, 52)
	drme:SetValue("https://www.macfinder.info")
	drme:SetEditable(false)
	drme:SetSize(tes - 96, 36)
	drme.Paint = function(self, w, h)
		MSDX.Draw(6, 0, 0, w, h, paled.grey100)
		MSDX.Draw(6, 1, 1, w - 2, h - 2, paled.grey200)
		self:DrawTextEntryText(color_black, paled.green, color_black)
	end

	DWebButtonIcons(McPhone.ActiveWeb, 48, 52, "mc_phone/icons/home.png", function()
		if McPhone.SignalStrength == 0 then
			return
		end

		McPhone.ActiveWeb.WebAdress:SetValue("https://www.macfinder.info")
		McPhone.UpdateWeb(McPhone.MacFinder)
		McPhone.PlaySoundUI("click")
	end)

	DWebButtonIcons(McPhone.ActiveWeb, 8, 52, "mc_phone/icons/buttons/id9.png", function()
		McPhone.ActiveWeb:Remove()
		McPhone.ActiveWeb.WebAdress = nil
		McPhone.ActiveWeb = nil
		McPhone.PlaySoundUI("click")
	end)

	McPhone.ActiveWeb.WebAdress = drme

	McPhone.ActiveWeb:MoveTo(tes, 0, 1)
	McPhone.ActiveWeb:SizeTo(tes, ScrH(), 1, 0, -1, function()
		McPhone.ActiveWeb.loaded = true
		McPhone.UpdateWeb(McPhone.MacFinder)
	end)
end

function McPhone.UpdateWeb(func)
	if not McPhone.ActiveWeb then return end

	if McPhone.ActiveWeb.Sub then
		McPhone.ActiveWeb.Sub:Remove()
		McPhone.ActiveWeb.Sub = nil
	end

	McPhone.ActiveWeb.loaded = nil

	timer.Simple(math.Rand(0.3, 1.8), function()
		if not IsValid(McPhone.ActiveWeb) then return end
		McPhone.ActiveWeb.loaded = true
		McPhone.ActiveWeb.Sub:SetPos(0, 120)
	end)

	McPhone.ActiveWeb.Sub = vgui.Create("DPanel", McPhone.ActiveWeb)
	McPhone.ActiveWeb.Sub:SetSize(ScrW() / 2, ScrH() - 120)
	McPhone.ActiveWeb.Sub:SetPos(ScrW(), 120)

	McPhone.ActiveWeb.Sub.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, Color(100, 100, 100))
	end

	if McPhone.SignalStrength == 0 then
		McPhone.NoSignal(McPhone.ActiveWeb.Sub, McPhone.ActiveWeb.Sub:GetWide(), McPhone.ActiveWeb.Sub:GetTall())
		return
	end

	if func then
		func(McPhone.ActiveWeb.Sub, McPhone.ActiveWeb.Sub:GetWide(), McPhone.ActiveWeb.Sub:GetTall())
	end
end

local function WebInfoHeader(parent, text, wd)
	local panel = vgui.Create("DPanel")
	wd = wd or 1
	panel.StaticScale = {
		w = wd,
		fixed_h = 65,
		minw = 250,
		minh = 65
	}

	panel.Paint = function(self, w, h)
		draw.SimpleText(text, "MSDFontB.32", 5, h / 2 - 11, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end

	parent:AddItem(panel)

	return panel
end

local function WebInfoText(parent, text, font)
	font = font or "MSDFont.32"
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 25,
		minw = 250,
		minh = 25
	}

	panel.Paint = function(self, w, h)
		draw.DrawText(self.txt or "", font, 5, 5, color_black, TEXT_ALIGN_LEFT)

		if not self.txt or (self.sh and self.sh ~= h) or (self.sw and self.sw ~= w) then
			local ts, _, th = MSD.TextWrap(text, font, w - 10)
			self.txt = ts
			self.sw = w
			self.sh = h
			self.StaticScale.fixed_h = th + 10
		end
	end

	parent:AddItem(panel)

	return panel
end

function McPhone.WebIcon(parent, text)
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 256,
		minw = 25,
		minh = 25
	}

	panel.IsJpeg = string.find(text, ".jpeg") or string.find(text, ".jpg")
	panel.Paint = function(self, w, h)
		self.mat = MSD.ImgLib.GetMaterial(text, self.IsJpeg)
		MSD.DrawTexturedRect(0, 0, w, h, self.mat, color_white)

		if self.mat ~= MSD.ImgLib.NoMaterial and not self.texture then
			self.texture = self.mat:GetTexture("$basetexture")
			self.th = self.texture:Height()
			self.tw = self.texture:Width()

			self.ar = self.tw / self.th
			self.StaticScale.fixed_h = w / self.ar
		end
	end

	parent:AddItem(panel)

	return panel
end

local function WebButtonIconText(parent, text, icon, func, fond, h)
	local button = vgui.Create("DButton")
	button:SetText(text)
	button.icon = icon

	button.StaticScale = {
		w = 1,
		fixed_h = h or 50,
		minw = 50,
		minh = h or 50
	}

	button.Paint = function(self, wd, hd)
		draw.SimpleText(self:GetText(), fond or "MSDFontB.32", icon and 34 or 6, 6, color_black, TEXT_ALIGN_LEFT)
		draw.SimpleText(self:GetText(), fond or "MSDFontB.32", icon and 32 or 5, 5, self.hover and paled["blue"] or paled["orange"], TEXT_ALIGN_LEFT)
		if self.icon then
			MSD.DrawTexturedRect(6, hd / 2 - 10, 24, 24, self.icon, color_black)
			MSD.DrawTexturedRect(5, hd / 2 - 12, 24, 24, self.icon, self.hover and paled["blue"] or paled["orange"])
		end
		return true
	end

	if func then
		button.OnCursorEntered = function(self)
			self.hover = true
		end

		button.OnCursorExited = function(self)
			self.hover = false
		end

		button.DoClick = function(...)
			MSD.UISnd("msd/ui/click.wav")
			func(...)
		end
	end

	parent:AddItem(button)

	return button
end

local e_topic, e_text, e_gps = "", "", false

function McPhone.MacFinderMail(parent, w, h)
	local top = vgui.Create("DPanel", parent)
	top:SetSize(0, h / 6)
	top:Dock(TOP)

	local name = string.Explode(" ", LocalPlayer():FullName())
	local mail = string.lower(name[1] .. name[2] .. string.sub(LocalPlayer():AccountID(), 3, 5) .. "@macfinder.info")
	top.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, paled.blue)
		MSDX.Draw(0, 0, ht - 8, wd, 8, paled.orange)
		MSD.DrawTexturedRect(23, 3, 300, 164, logo, color_black)
		MSD.DrawTexturedRect(20, 0, 300, 164, logo, color_white)

		draw.SimpleText(mail, "MSDFontB.32", w - 13, 7, color_black, TEXT_ALIGN_RIGHT)
		draw.SimpleText(mail, "MSDFontB.32", w - 15, 5, color_white, TEXT_ALIGN_RIGHT)
	end

	local main = vgui.Create("DPanel", parent)
	main:Dock(FILL)
	main.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, paled["grey200"])
	end

	local body = vgui.Create("DPanel", main)
	body:Dock(FILL)
	body:DockMargin(0, 0,0, 0)
	body:DockPadding(0, 0, 0, 0)
	body.Paint = function(self, wd, ht) end

	local mlist = vgui.Create("MSDPanelList", body)
	mlist:SetSize(w - 275, h - h / 6)
	mlist:SetPos(268, 0)
	mlist:EnableVerticalScrollbar()
	mlist:EnableHorizontal(true)
	mlist:SetPadding(0)
	mlist:SetSpacing(0)
	mlist.IgnoreVbar = true
	mlist.Paint = function() end
	mlist.Update = function(func)
		mlist:Clear()
		if func then func() end
	end

	local blist = vgui.Create("MSDPanelList", body)
	blist:SetSize(256, h - h / 6)
	blist:SetPos(0, 0)
	blist:EnableVerticalScrollbar()
	blist:EnableHorizontal(true)
	blist:SetPadding(0)
	blist:SetSpacing(0)
	blist.IgnoreVbar = true
	blist.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, color_white)
	end

	local email
	local mail_open = function()
		WebInfoHeader(mlist, McPhone.Mail[email].Name)

		if McPhone.Mail[email].Trusted then
			local str = string.Explode(" ", McPhone.Mail[email].Text)
			local text = {}
			local last = 1

			for k,v in ipairs(str) do
				if string.StartWith(v, "https://i.imgur.com/") then
					table.insert(text, {icon = v})
					last = last + 2
					continue
				end

				if not text[last] then
					table.insert(text, {text = v})
				else
					text[last].text = text[last].text .. " " .. v
				end
			end

			for _, v in ipairs(text) do
				if v.text then
					WebInfoText(mlist, v.text, "MSDFont.26")
				end

				if v.icon then
					McPhone.WebIcon(mlist, v.icon)
				end
			end
		else
			WebInfoText(mlist, McPhone.Mail[email].Text, "MSDFont.26")
		end

		if McPhone.Mail[email].GPS then
			WebButtonIconText(mlist, "Открыть GPS локацию из письма", nil, function()
				McPhone.ToggleGPS("Локация из письма", McPhone.Mail[email].GPS)
			end, "MSDFontB.22" , 30)
		end

		WebButtonIconText(mlist, "Отметить как непрочитанное", nil, function()
			McPhone.Mail[email].New = true
			McPhone.UpdateMail()
		end, "MSDFontB.22" , 30)

		WebButtonIconText(mlist, "Удалить письмо", nil, function()
			table.remove(McPhone.Mail, email)
			McPhone.UpdateMail()
			mlist.Update()
			blist.Update()
		end, "MSDFontB.22" , 30)
	end

	local m_feescr
	local function m_new()
		mlist:Clear()

		WebInfoHeader(mlist, "Тема")
		local drme = vgui.Create("DTextEntry")
		drme:SetText("")
		drme:SetFont("McPhone.Main28")
		drme:SetValue(e_topic)
		drme:SetMultiline(false)
		drme.StaticScale = {w = 1, fixed_h = 51, minw = 100, minh = 51 }
		drme.Paint = function(s, wd, hd)
			surface.SetDrawColor(color_black)
			surface.DrawOutlinedRect(0,0,wd,hd,2)
			s:DrawTextEntryText(Color(30, 30, 30), Color(149, 240, 193), Color(0, 0, 0))
		end
		mlist:AddItem(drme)

		WebInfoHeader(mlist, "Сообщение")
		local drte = vgui.Create("DTextEntry")
		drte:SetText("")
		drte:SetFont("McPhone.Main28")
		drte:SetValue(e_text)
		drte:SetMultiline(true)
		drte.StaticScale = {w = 1, fixed_h = 256, minw = 100, minh = 51 }
		drte.Paint = function(s, wd, hd)
			surface.SetDrawColor(color_black)
			surface.DrawOutlinedRect(0,0,wd,hd,2)
			s:DrawTextEntryText(Color(30, 30, 30), Color(149, 240, 193), Color(0, 0, 0))
		end
		mlist:AddItem(drte)

		WebInfoText(mlist, "Добавить ваше текущее местоположение как приложение к письму? Стоимость услуги 150$")

		WebButtonIconText(mlist, "Добавить GPS", e_gps and MSD.Icons48.check_bold or MSD.Icons48.close_thick, function(s)
			e_gps = not e_gps
			s.icon = e_gps and MSD.Icons48.check_bold or MSD.Icons48.close_thick
		end, "MSDFontB.20", 32)

		WebButtonIconText(mlist, "Отправить сообщение", nil, function(s)
			e_topic = drme:GetValue()
			e_text = drte:GetValue()
			m_feescr()
		end, "MSDFontB.26", 32)
	end

	function m_feescr()
		mlist:Clear(true)
		WebInfoHeader(mlist, "Готовы отправить рекламу?")

		WebInfoText(mlist, McPhone.GetPhrase("email_fee", e_gps and McPhone.Config.EmailFeeSize + 150 or McPhone.Config.EmailFeeSize, McPhone.Config.Curensy))

		WebButtonIconText(mlist, "Да! Отправить сообщение", nil, function(s)
			net.Start("McPhone.SendMail")
			net.WriteString(e_topic)
			net.WriteString(e_text)
			net.WriteBool(e_gps)
			net.SendToServer()

			mlist.Update()
			blist.Update()
		end)

		WebButtonIconText(mlist, "Нет, закрыть", nil, function(s)
			mlist.Update()
			blist.Update()
		end)

		mlist:AddItem(drme)
	end


	blist.Update = function()
		blist:Clear()

		WebButtonIconText(blist, "Рассылка рекламы", nil, function()
			m_new()
		end, "MSDFontB.28", 51)

		for k, v in SortedPairs(McPhone.Mail, true) do
			McPhone.ListTexts(blist, k, v.Name, v.Text, v.Time, false, function()
				email = k
				v.New = false
				McPhone.UpdateMail()
				mlist.Update(mail_open)
				blist.Update()
			end, true, true, "", nil, true)
		end
	end

	blist.Update()
end