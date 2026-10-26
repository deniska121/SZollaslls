-- "addons\\mc_phone\\lua\\mc_phone\\modules\\web_properly.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--

McPhone.WebModules["propertie"] = {}
McPhone.WebModules["propertie"].name = "SkyLine"
McPhone.WebModules["propertie"].url = "https://skyline.net"

if SERVER then return end

McPhone.ter_list = McPhone.ter_list or {}

McPhone.WebModules["propertie"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["propertie"].url)

	net.Start("territorySendInfo")
	net.SendToServer()

	McPhone.UpdateWeb(McPhone.WebModules["propertie"].Build)
end

local NewFont = surface.CreateFont

NewFont("SkyLine.Title", {
	font = "Times New Roman",
	extended = true,
	size = 40,
	antialias = true,
	weight = 900
})

NewFont("SkyLine.Sub", {
	font = "Times New Roman",
	extended = true,
	size = 18,
	italic = true,
	antialias = true,
	weight = 500
})

NewFont("SkyLine.Header", {
	font = "Times New Roman",
	extended = true,
	size = 24,
	antialias = true,
	weight = 900
})

NewFont("SkyLine.Body", {
	font = "Times New Roman",
	extended = true,
	size = 19,
	antialias = true,
	weight = 500
})

NewFont("SkyLine.BodyB", {
	font = "Times New Roman",
	extended = true,
	size = 19,
	antialias = true,
	weight = 900
})

NewFont("SkyLine.Small", {
	font = "Times New Roman",
	extended = true,
	size = 15,
	antialias = true,
	weight = 500
})

NewFont("SkyLine.SmallB", {
	font = "Times New Roman",
	extended = true,
	size = 15,
	antialias = true,
	weight = 900
})

NewFont("SkyLine.Price", {
	font = "Times New Roman",
	extended = true,
	size = 28,
	antialias = true,
	weight = 900
})

NewFont("SkyLine.Button", {
	font = "Times New Roman",
	extended = true,
	size = 20,
	antialias = true,
	weight = 900
})

local logo = Material("gmodla/f4/sky_logo.png", "smooth")
-- Placeholder corner-map image. Replace this file later to swap the artwork.
local cornerMap = Material("gmodla/f4/sector.png", "smooth")
local bigMap = Material("gmodla/skyline_map.png", "smooth")

local mats = {
	["player"]    = Material("gmodla/hud/waypoint.png", "smooth"),
	["home"]      = Material("gmodla/hud/home.png", "smooth"),
	["apartment"] = Material("gmodla/hud/apartment.png", "smooth"),
	["store"]     = Material("gmodla/hud/store.png", "smooth"),
	["workshop"]  = Material("gmodla/hud/workshop.png", "smooth"),
	["house"]     = Material("gmodla/hud/house.png", "smooth"),
	["big_house"] = Material("gmodla/hud/big_house.png", "smooth"),
	["warehouse"] = Material("gmodla/hud/warehouse.png", "smooth"),
	["factory"]   = Material("gmodla/hud/factory.png", "smooth"),
}

-- New York palette: ivory paper, jet headers, NYC navy, brick red, taxi yellow
local nyc = {
	jet        = Color(18, 18, 18),
	charcoal   = Color(40, 40, 44),
	cream      = Color(248, 244, 230),
	creamAlt   = Color(238, 230, 200),
	tan        = Color(220, 200, 158),
	navy       = Color(14, 40, 102),
	navyDark   = Color(8, 24, 64),
	close      = Color(190, 60, 60),
	brick      = Color(152, 36, 36),
	brickDark  = Color(105, 22, 22),
	taxi       = Color(252, 196, 25),
	taxiDark   = Color(200, 152, 18),
	gold       = Color(188, 152, 56),
	green      = Color(48, 110, 60),
	greenDark  = Color(28, 78, 42),
	greenLight  = Color(14, 197, 66),
	linkBlue   = Color(20, 50, 165),
	subtle     = Color(95, 80, 60),
	rule       = Color(120, 100, 60),
	owned      = Color(120, 60, 140),
	mapBg      = Color(180, 200, 180),
}

local grop_names = {
	["UnionSqure"] = {
		name = "Union Squre Апартаменты",
		pos = Vector(1506.3898925781, 2667.0278320313, -113.96875),
	},
	["Мотель"] = {
		name = "Мотель",
		pos = Vector(-4244.4697265625, 744.939453125, -103.96875),
	},
	["LeGrande"] = {
		name = "Отель LeGrande",
		pos = Vector(6885.6870117188, 1345.2312011719, -94.96875),
	},
	["apartment13"] = {
		name = "Апартаменты 13",
		pos = Vector(1309.6708984375, 5052.9213867188, 370.59185791016),
	},
	["garage_unit"] = {
		name = "Self Storage",
		pos = Vector(-6673.3173828125, -3110.0417480469, -319.96875),
	}
}

local reviews = {}
local interest = Vector(4435,4281,0)

local badpls = {
	Vector(1345,5030,0),
	Vector(-4203,1113,0),
}

local df = 300000000
local bdf = 4000000

local function GetRev(id, ter)
	if reviews[id] then return reviews end

	local cd = Vector(ter.coords[1].x, ter.coords[1].y, 0)
	local ff = cd:DistToSqr(interest)
	local b1 = math.Clamp(cd:DistToSqr(badpls[1]) / bdf,0,1)
	local b2 = math.Clamp(cd:DistToSqr(badpls[2]) / bdf,0,1)
	local af = (df - ff) / df
	local pf = (5000 - ter.price) / 5000
	local dm = (pf + af + math.min(b1, b2)) / 3

	reviews[id] = {
		visitors = math.Round(dm * 100 + math.random(dm * 20)),
		interest = math.Round(math.random(dm * 10)),
		demand = dm
	}

	return reviews[id]
end

-- ─── Bevel / 3D helpers ───
local function DrawBevel(x, y, w, h, light, dark)
	surface.SetDrawColor(light)
	surface.DrawRect(x, y, w, 2)
	surface.DrawRect(x, y, 2, h)
	surface.SetDrawColor(dark)
	surface.DrawRect(x, y + h - 2, w, 2)
	surface.DrawRect(x + w - 2, y, 2, h)
end

local grbvl = Color(70, 70, 70)

local function DrawBevelRaised(x, y, w, h)
	DrawBevel(x, y, w, h, color_white, grbvl)
end

local function DrawBevelSunken(x, y, w, h)
	DrawBevel(x, y, w, h, grbvl, color_white)
end

local function DrawTaxiStripe(x, y, w, h)
	local cell = h
	surface.SetDrawColor(nyc.taxi)
	surface.DrawRect(x, y, w, h)
	surface.SetDrawColor(nyc.jet)
	local n = math.ceil(w / cell)
	for i = 0, n do
		if i % 2 == 0 then
			surface.DrawRect(x + i * cell, y, cell, h)
		end
	end
end

local function DrawPaper(w, h)
	surface.SetDrawColor(nyc.cream)
	surface.DrawRect(0, 0, w, h)
	surface.SetDrawColor(nyc.creamAlt)
	for yy = 0, h, 34 do
		surface.DrawRect(0, yy, w, 1)
	end
end

-- ─── List item helpers (parent must be MSDPanelList for AddItem path) ───
local function LMasthead(parent, text, sub)
	local panel = vgui.Create("DPanel")
	panel.StaticScale = { w = 1, fixed_h = 60, minw = 250, minh = 60 }
	panel.Paint = function(self, w, h)
		surface.SetDrawColor(nyc.cream)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(nyc.jet)
		surface.DrawRect(0, 0, w, 3)
		surface.DrawRect(0, h - 3, w, 3)
		draw.SimpleText(text, "SkyLine.Header", 6, 6, nyc.jet, TEXT_ALIGN_LEFT)
		if sub then
			draw.SimpleText(sub, "SkyLine.Sub", 6, 36, nyc.subtle, TEXT_ALIGN_LEFT)
		end
	end
	parent:AddItem(panel)
	return panel
end

local function LSubBar(parent, text)
	local panel = vgui.Create("DPanel")
	panel.StaticScale = { w = 1, fixed_h = 26, minw = 250, minh = 26 }
	panel.Paint = function(self, w, h)
		surface.SetDrawColor(nyc.brick)
		surface.DrawRect(0, 0, w, h)
		DrawBevelRaised(0, 0, w, h)
		draw.SimpleText(text, "SkyLine.BodyB", 8, h / 2, nyc.cream, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	parent:AddItem(panel)
	return panel
end

local function LTextBlock(parent, text, font, cl)
	font = font or "SkyLine.Body"
	cl = cl or nyc.jet
	local panel = vgui.Create("DPanel")
	panel.StaticScale = { w = 1, fixed_h = 22, minw = 250, minh = 22 }
	panel.Paint = function(self, w, h)
		draw.DrawText(self.txt or "", font, 8, 4, cl, TEXT_ALIGN_LEFT)
		if not self.txt or self.sw ~= w then
			local ts, _, th = MSD.TextWrap(text, font, w - 16)
			self.txt = ts
			self.sw = w
			self.StaticScale.fixed_h = th + 8
		end
	end
	parent:AddItem(panel)
	return panel
end

local function LRule(parent)
	local panel = vgui.Create("DPanel")
	panel.StaticScale = { w = 1, fixed_h = 6, minw = 250, minh = 6 }
	panel.Paint = function(self, w, h)
		surface.SetDrawColor(nyc.rule)
		surface.DrawRect(2, 2, w - 4, 1)
		surface.SetDrawColor(color_white)
		surface.DrawRect(2, 3, w - 4, 1)
	end
	parent:AddItem(panel)
	return panel
end

local function LWebButton(parent, text, cl, func, wd)
	wd = wd or 1
	local but = vgui.Create("DButton")
	but:SetText("")
	but.StaticScale = { w = wd, fixed_h = 34, minw = 80, minh = 34 }
	but.Paint = function(self, w, h)
		local bg = self.hover and Color(math.min(cl.r + 25, 255), math.min(cl.g + 25, 255), math.min(cl.b + 25, 255)) or cl
		surface.SetDrawColor(bg)
		surface.DrawRect(0, 0, w, h)
		if self.pressed then
			DrawBevelSunken(0, 0, w, h)
		else
			DrawBevelRaised(0, 0, w, h)
		end
		local off = self.pressed and 1 or 0
		draw.SimpleText(text, "SkyLine.Button", w / 2 + off + 1, h / 2 + off + 1, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(text, "SkyLine.Button", w / 2 + off, h / 2 + off, nyc.cream, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	but.OnCursorEntered = function(self) self.hover = true end
	but.OnCursorExited  = function(self) self.hover = false; self.pressed = false end
	but.OnMousePressed  = function(self, k) self.pressed = true; DButton.OnMousePressed(self, k) end
	but.OnMouseReleased = function(self, k) self.pressed = false; DButton.OnMouseReleased(self, k) end
	but.DoClick = func
	parent:AddItem(but)
	return but
end

-- ─── Catalog property card (buy view) ───
local function LInfoProperty(parent, property, id, rowIndex, short)
	local panel = vgui.Create("DButton")
	panel:SetText("")
	panel.StaticScale = { w = 1, fixed_h = 110, minw = 260, minh = 110 }
	panel.hover_a = 0
	panel.descrCache = nil
	panel.descrW = 0
	panel.descr = property.terDescr

	local afford = LocalPlayer():canAfford(property.price)
	local rowCl = (rowIndex % 2 == 0) and nyc.cream or nyc.creamAlt
	local price = property.price
	local labelCl = afford and nyc.green or nyc.subtle
	local hasDescr = panel.descr and panel.descr ~= ""

	if short and hasDescr then
		panel.descr = string.Explode("\n", panel.descr)[1]
	end

	panel.Paint = function(self, w, h)
		if (self.hover or self.hovered) and not self.disabled then
			self.hover_a = Lerp(FrameTime() * 6, self.hover_a, 1)
		else
			self.hover_a = Lerp(FrameTime() * 6, self.hover_a, 0)
		end

		surface.SetDrawColor(rowCl)
		surface.DrawRect(0, 0, w, h)
		DrawBevelRaised(0, 0, w, h)

		if self.hover_a > 0.01 then
			surface.SetDrawColor(nyc.taxi.r, nyc.taxi.g, nyc.taxi.b, 50 * self.hover_a)
			surface.DrawRect(2, 2, w - 4, h - 4)
		end

		surface.SetDrawColor(nyc.brick)
		surface.DrawRect(2, 2, 4, h - 4)

		draw.SimpleText(property.printName, "SkyLine.BodyB", 14, 8, nyc.linkBlue, TEXT_ALIGN_LEFT)
		surface.SetFont("SkyLine.BodyB")
		local tw, _ = surface.GetTextSize(property.printName)
		surface.SetDrawColor(nyc.linkBlue)
		surface.DrawRect(14, 28, tw, 1)

		if property.printStr and property.printStr ~= "" then
			draw.SimpleText("◦ " .. property.printStr, "SkyLine.Small", 14, 32, nyc.subtle, TEXT_ALIGN_LEFT)
		end

		if hasDescr then
			if not self.descrCache or self.descrW ~= w then
				local ts, _, th = MSD.TextWrap(self.descr, "SkyLine.Small", w - 24)
				self.descrCache = ts
				self.descrW = w
				local needed = 80 + th + 14
				if self.StaticScale.fixed_h ~= needed then
					self.StaticScale.fixed_h = needed
					if self:GetParent().InvalidateLayout then
						self:GetParent():InvalidateLayout(true)
					end
				end
			end
			draw.DrawText(self.descrCache, "SkyLine.Small", 14, 52, nyc.jet, TEXT_ALIGN_LEFT)
		end

		local stripY = h - 36
		surface.SetDrawColor(nyc.jet)
		surface.DrawRect(2, stripY, w - 4, 34)
		DrawBevelSunken(2, stripY, w - 4, 34)

		draw.SimpleText("$" .. string.Comma(price), "SkyLine.Price", 14, stripY + 17, nyc.taxi, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		if afford then
			surface.SetDrawColor(labelCl)
			surface.DrawRect(w - 124, stripY + 4, 118, 26)
			DrawBevelRaised(w - 124, stripY + 4, 118, 26)
			draw.SimpleText("Аренда »", "SkyLine.Button", w - 65, stripY + 17, nyc.cream, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText("Недоступно", "SkyLine.Body", w - 10, stripY + 17, Color(210, 210, 210), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		end
	end

	panel.OnCursorEntered = function(self) self.hover = true end
	panel.OnCursorExited  = function(self) self.hover = false end
	panel.DoClick = function(self)
		if not afford then return end
		MSD.AskPopup(nil, "Вы точно хотите арендовать \"" .. property.printName .. "\"?", nil,
		{"Да, арендовать за " .. string.Comma(property.price) .. "$", function()
			net.Start("territoryBuy") net.WriteString(id) net.SendToServer()
		end},
		{"Нет, закрыть", function() end})
	end
	parent:AddItem(panel)
	return panel
end

-- ─── Manage list row (simple list of owned properties) ───
local function LManageRow(parent, property, id, rowIndex, onClick)
	local panel = vgui.Create("DButton")
	panel:SetText("")
	panel.StaticScale = { w = 1, fixed_h = 56, minw = 260, minh = 56 }
	panel.hover_a = 0
	local rowCl = (rowIndex % 2 == 0) and nyc.cream or nyc.creamAlt

	panel.Paint = function(self, w, h)
		if self.hover then
			self.hover_a = Lerp(FrameTime() * 6, self.hover_a, 1)
		else
			self.hover_a = Lerp(FrameTime() * 6, self.hover_a, 0)
		end

		surface.SetDrawColor(rowCl)
		surface.DrawRect(0, 0, w, h)
		DrawBevelRaised(0, 0, w, h)

		if self.hover_a > 0.01 then
			surface.SetDrawColor(nyc.taxi.r, nyc.taxi.g, nyc.taxi.b, 50 * self.hover_a)
			surface.DrawRect(2, 2, w - 4, h - 4)
		end

		-- Purple ribbon (owned)
		surface.SetDrawColor(nyc.owned)
		surface.DrawRect(2, 2, 4, h - 4)

		draw.SimpleText(property.printName, "SkyLine.BodyB", 14, 6, nyc.linkBlue, TEXT_ALIGN_LEFT)
		surface.SetFont("SkyLine.BodyB")
		local tw, _ = surface.GetTextSize(property.printName)
		surface.SetDrawColor(nyc.linkBlue)
		surface.DrawRect(14, 26, tw, 1)

		if property.printStr and property.printStr ~= "" then
			draw.SimpleText("◦ " .. property.printStr, "SkyLine.Small", 14, 32, nyc.subtle, TEXT_ALIGN_LEFT)
		end

		draw.SimpleText("Управлять »", "SkyLine.Button", w - 12, h / 2, nyc.brick, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end
	panel.OnCursorEntered = function(self) self.hover = true end
	panel.OnCursorExited  = function(self) self.hover = false end
	panel.DoClick = onClick
	parent:AddItem(panel)
	return panel
end

McPhone.WebModules["propertie"].Build = function(parent, w, h)
	local base = vgui.Create("DPanel", parent)
	base:SetSize(w, h)
	base.mode = "catalog"
	base.Paint = function(self, wd, hd)
		DrawPaper(wd, hd)
	end

	-- ── Top masthead banner ──
	local bannerH = 100
	local banner = vgui.Create("DPanel", base)
	banner:SetSize(w, bannerH)
	banner:SetPos(0, 0)
	banner.vist = math.random(50, 100) + 1700
	banner.Paint = function(self, wd, hd)
		surface.SetDrawColor(nyc.jet)
		surface.DrawRect(0, 0, wd, hd)
		surface.SetDrawColor(nyc.charcoal)
		for xx = 0, wd, 6 do
			surface.DrawRect(xx, 0, 1, hd - 12)
		end
		DrawTaxiStripe(0, hd - 12, wd, 12)
		DrawBevelRaised(0, 0, wd, hd)

		MSD.DrawTexturedRect(12, 10, 70, 70, logo, nyc.brick)

		draw.SimpleText("SkyLine Real Estate", "SkyLine.Title", 92, 8, nyc.cream, TEXT_ALIGN_LEFT)
		draw.SimpleText("• New York •", "SkyLine.Sub", 92, 50, nyc.taxi, TEXT_ALIGN_LEFT)
		draw.SimpleText("Manhattan · Brooklyn · Queens · The Bronx · Staten Island", "SkyLine.Small", 92, 70, nyc.cream, TEXT_ALIGN_LEFT)

		draw.SimpleText("Trusted Since 1989", "SkyLine.SmallB", wd - 12, 10, nyc.taxi, TEXT_ALIGN_RIGHT)
		draw.SimpleText("Посетители сайта: " .. self.vist, "SkyLine.Small", wd - 12, 28, nyc.cream, TEXT_ALIGN_RIGHT)
	end

	-- Header navigation button (toggles Catalog ↔ Manage)
	local hdrBtn = vgui.Create("DButton", banner)
	hdrBtn:SetText("")
	hdrBtn:SetSize(270, 30)
	hdrBtn:SetPos(w - 282, 50)
	hdrBtn.Paint = function(self, wd, hd)
		local isManage = base.mode == "manage"
		local cl = isManage and nyc.cream or nyc.taxi
		local hcl = self.hover and Color(math.min(cl.r + 15, 255), math.min(cl.g + 15, 255), math.min(cl.b + 15, 255)) or cl
		surface.SetDrawColor(hcl)
		surface.DrawRect(0, 0, wd, hd)
		if self.pressed then
			DrawBevelSunken(0, 0, wd, hd)
		else
			DrawBevelRaised(0, 0, wd, hd)
		end
		local label = isManage and "« Каталог недвижимости" or "Управление недвижимостью »"
		local off = self.pressed and 1 or 0
		draw.SimpleText(label, "SkyLine.Button", wd / 2 + off, hd / 2 + off, nyc.jet, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end
	hdrBtn.OnCursorEntered = function(self) self.hover = true end
	hdrBtn.OnCursorExited  = function(self) self.hover = false; self.pressed = false end
	hdrBtn.OnMousePressed  = function(self, k) self.pressed = true; DButton.OnMousePressed(self, k) end
	hdrBtn.OnMouseReleased = function(self, k) self.pressed = false; DButton.OnMouseReleased(self, k) end
	hdrBtn.DoClick = function()
		if base.mode == "manage" then
			base.Update()
		else
			base.ManageList()
		end
	end

	-- ── Layout ──
	local contentY = bannerH + 4
	local contentH = h - contentY - 4

	local leftW = 230
	local leftPanel = vgui.Create("DPanel", base)
	leftPanel:SetPos(6, contentY)
	leftPanel:SetSize(leftW, contentH - 6)

	local rightX = leftW + 12
	local rightW = w - rightX - 6
	local rightPanel = vgui.Create("DPanel", base)
	rightPanel:SetPos(rightX, contentY)
	rightPanel:SetSize(rightW, contentH - 6)

	-- ── Left sidebar ──
	local thumbX, thumbY, thumbSz = 8, 50, leftW - 16
	leftPanel.Paint = function(self, wd, hd)
		surface.SetDrawColor(nyc.tan)
		surface.DrawRect(0, 0, wd, hd)
		DrawBevelRaised(0, 0, wd, hd)

		surface.SetDrawColor(nyc.jet)
		surface.DrawRect(2, 2, wd - 4, 38)
		surface.SetDrawColor(nyc.taxi)
		surface.DrawRect(2, 36, wd - 4, 4)
		draw.SimpleText("» Карта района", "SkyLine.Header", 10, 6, nyc.cream, TEXT_ALIGN_LEFT)
	end

	local thumb = vgui.Create("DButton", leftPanel)
	thumb:SetText("")
	thumb:SetPos(thumbX, thumbY)
	thumb:SetSize(thumbSz, thumbSz)
	thumb.Paint = function(self, wd, hd)
		surface.SetDrawColor(color_white)
		surface.DrawRect(0, 0, wd, hd)
		DrawBevelSunken(0, 0, wd, hd)

		if cornerMap and not cornerMap:IsError() then
			MSD.DrawTexturedRect(3, 3, wd - 6, hd - 6, cornerMap, color_white)
		else
			surface.SetDrawColor(nyc.mapBg)
			surface.DrawRect(3, 3, wd - 6, hd - 6)
			draw.SimpleText("[ Карта SkyLine ]", "SkyLine.BodyB", wd / 2, hd / 2 - 8, nyc.jet, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			draw.SimpleText("замените файл изображения", "SkyLine.Small", wd / 2, hd / 2 + 12, nyc.subtle, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end

		if self.hover then
			surface.SetDrawColor(0, 0, 0, 110)
			surface.DrawRect(3, 3, wd - 6, hd - 6)
			draw.SimpleText("Открыть карту »", "SkyLine.Button", wd / 2, hd / 2, nyc.jet, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
	end
	thumb.OnCursorEntered = function(self) self.hover = true end
	thumb.OnCursorExited  = function(self) self.hover = false end
	thumb.DoClick = function()
		if base.openMap then base.openMap() end
	end

	local footY = thumbY + thumbSz + 8
	local foot = vgui.Create("DPanel", leftPanel)
	foot:SetPos(8, footY)
	foot:SetSize(leftW - 16, (contentH - 6) - footY - 8)
	foot.Paint = function(self, wd, hd)
		surface.SetDrawColor(nyc.cream)
		surface.DrawRect(0, 0, wd, hd)
		DrawBevelSunken(0, 0, wd, hd)
		draw.SimpleText("★ Лучший выбор недвижимости", "SkyLine.Small", 8, 8, nyc.jet, TEXT_ALIGN_LEFT)
		draw.SimpleText("★ Безопасные сделки",            "SkyLine.Small", 8, 26, nyc.jet, TEXT_ALIGN_LEFT)
		draw.SimpleText("★ Поддержка 24/7",               "SkyLine.Small", 8, 44, nyc.jet, TEXT_ALIGN_LEFT)

		surface.SetDrawColor(nyc.rule)
		surface.DrawRect(6, 70, wd - 12, 1)

		draw.SimpleText("SkyLine Real Estate Co.", "SkyLine.BodyB", 8, 80, nyc.brick, TEXT_ALIGN_LEFT)
		draw.SimpleText("123 Liberty Ave., NY", "SkyLine.Small", 8, 102, nyc.subtle, TEXT_ALIGN_LEFT)
		--draw.SimpleText("1-800-SKYLINE", "SkyLine.Small", 8, 120, nyc.subtle, TEXT_ALIGN_LEFT)
		draw.SimpleText("[ Powered by SkyLine.NET ]", "SkyLine.Small", wd / 2, hd - 16, nyc.subtle, TEXT_ALIGN_CENTER)
	end

	-- ── Right pane host ──
	rightPanel.Paint = function(self, wd, hd)
		surface.SetDrawColor(color_white)
		surface.DrawRect(0, 0, wd, hd)
		DrawBevelRaised(0, 0, wd, hd)
	end

	local listingsX, listingsY = 8, 8
	local listingsW = rightW - 16
	local listingsH = contentH - 22

	local function makeList()
		if IsValid(rightPanel.list) then rightPanel.list:Remove() end
		local list = vgui.Create("MSDPanelList", rightPanel)
		list:SetPos(listingsX, listingsY)
		list:SetSize(listingsW, listingsH)
		list:EnableVerticalScrollbar()
		list:EnableHorizontal(true)
		list:SetSpacing(4)
		list:SetPadding(2)
		list.IgnoreVbar = false
		list.Paint = function() end
		rightPanel.list = list
		return list
	end

	-- ── Catalog group/listing (used when map icon or group row is clicked) ──
	base.openHouse = function(slist, lname)
		if IsValid(base.mapOverlay) then base.mapOverlay:Remove() end
		base.mode = "catalog"

		local list = makeList()

		LMasthead(list, lname or "Объект недвижимости", "Подробности и характеристики")
		LSubBar(list, "Доступно для аренды прямо сейчас")
		LRule(list)

		local first = true
		local idx = 0

		for k, v in SortedPairs(slist, true) do
			local ter = Territories.list[k]
			if not ter then continue end
			local rev = GetRev(k, ter)

			if first then
				first = false
				local photo = vgui.Create("DPanel")
				photo.StaticScale = { w = 1, fixed_h = 240, minw = 250, minh = 240 }
				photo.Paint = function(self, wd, hd)
					surface.SetDrawColor(nyc.jet)
					local ah = hd - 8
					local aw = ah * 1.33
					surface.DrawRect(0, 0, aw + 8, ah + 8)
					DrawBevelSunken(0, 0, aw + 8, ah + 8)

					draw.SimpleText(ter.printName, "SkyLine.Header", aw + 15, 3, nyc.jet, TEXT_ALIGN_LEFT)
					draw.SimpleText(ter.printStr or "", "SkyLine.Header", aw + 15, 28, nyc.jet, TEXT_ALIGN_LEFT)

					if rev.visitors then
						draw.SimpleText("Просмотров: " .. rev.visitors, "SkyLine.Body", aw + 15, 58, nyc.jet, TEXT_ALIGN_LEFT)
						draw.SimpleText("Заинтересовано: " .. rev.interest, "SkyLine.Body", aw + 15, 78, nyc.jet, TEXT_ALIGN_LEFT)

						draw.SimpleText("Рейтинг SkyLine", "SkyLine.Body", aw + 15, 98, nyc.jet, TEXT_ALIGN_LEFT)
						DrawBevel(aw + 15, 124, 150, 9, nyc.jet, nyc.charcoal)
						surface.SetDrawColor(nyc.brick)
						surface.DrawRect(aw + 17, 126, 146, 5)
						surface.SetDrawColor(nyc.greenLight)
						surface.DrawRect(aw + 17, 126, rev.demand * 146, 5)
					end

					McPhone.DrawTexturedRect(4, 4, aw, ah, MSD.RenderView.Get(k, ter.camPos, ter.camAng), color_white)
				end
				list:AddItem(photo)
			end

			idx = idx + 1
			LInfoProperty(list, ter, k, idx)
		end

		LRule(list)
		LWebButton(list, "« Вернуться к каталогу", nyc.navy, function()
			base.Update()
		end, 1)
	end

	-- ── Main catalog (browse + buy) ──
	base.Update = function()
		if IsValid(base.mapOverlay) then base.mapOverlay:Remove() end
		base.mode = "catalog"
		local list = makeList()

		LMasthead(list, "Каталог недвижимости", "Эксклюзивные предложения от SkyLine")
		LSubBar(list, "Открыто для просмотра ежедневно")
		LRule(list)
		LTextBlock(list,
			"Ниже представлены доступные объекты недвижимости. Откройте карту слева, чтобы выбрать район, либо просмотрите весь каталог ниже.",
			"SkyLine.Body")
		LRule(list)

		local groups = {}
		local solos = {}

		for k, v in pairs(Territories.list) do
			if not v.buyable then continue end
			local data = McPhone.ter_list[k]
			if not data then continue end

			if v.group then
				groups[v.group] = groups[v.group] or { name = (grop_names[v.group] and grop_names[v.group].name) or v.group, items = {} }
				groups[v.group].items[k] = true
			else
				solos[k] = v
			end
		end

		local idx = 0
		for k, ter in SortedPairsByMemberValue(solos, "printName") do
			idx = idx + 1
			local b = LInfoProperty(list, ter, k, idx, true)
			b.DoClick = function(self)
				base.openHouse({[k] = true})
			end
		end

		for gname, gdata in SortedPairsByMemberValue(groups, "name") do
			local count = table.Count(gdata.items)
			LWebButton(list, ("» %s  [%d объект(ов)]"):format(gdata.name, count), nyc.brick, function()
				base.openHouse(gdata.items, gdata.name)
			end, 1)
		end
	end

	-- ── Manage: flat list of every owned property (groups expanded) ──
	base.ManageList = function()
		if IsValid(base.mapOverlay) then base.mapOverlay:Remove() end
		base.mode = "manage"
		local list = makeList()

		LMasthead(list, "Управление недвижимостью", "Ваши приобретённые объекты")
		LSubBar(list, "Выберите объект для управления")
		LRule(list)

		local owned = {}
		for k, v in pairs(Territories.list) do
			if not v.buyable then continue end
			local data = McPhone.ter_list[k]
			if not data then continue end
			if data.masterOwner ~= LocalPlayer() then continue end
			owned[k] = v
		end

		if next(owned) == nil then
			LTextBlock(list,
				"У вас пока нет недвижимости. Перейдите в каталог, чтобы выбрать и приобрести первый объект.",
				"SkyLine.Body")
			LRule(list)
			LWebButton(list, "« Перейти к каталогу", nyc.navy, function()
				base.Update()
			end, 1)
			return
		end

		local idx = 0
		for k, ter in SortedPairsByMemberValue(owned, "printName") do
			idx = idx + 1
			local terId = k
			LManageRow(list, ter, terId, idx, function()
				base.ManageProperty(terId)
			end)
		end
	end

	-- ── Manage: single-property page (sell, photo, co-owners) ──
	base.ManageProperty = function(id)
		local ter = Territories.list[id]
		if not ter then return end
		if IsValid(base.mapOverlay) then base.mapOverlay:Remove() end
		base.mode = "manage"
		local list = makeList()

		LMasthead(list, ter.printName, ter.printStr or "")
		LSubBar(list, "Управление объектом")

		local photo = vgui.Create("DPanel")
		photo.StaticScale = { w = 1, fixed_h = 240, minw = 250, minh = 240 }
		photo.Paint = function(self, wd, hd)
			surface.SetDrawColor(nyc.jet)
			local ah = hd - 8
			local aw = ah * 1.33
			surface.DrawRect(0, 0, aw + 8, ah + 8)

			DrawBevelSunken(0, 0, aw + 8, ah + 8)
			McPhone.DrawTexturedRect(4, 4, aw, ah, MSD.RenderView.Get(id, ter.camPos, ter.camAng), color_white)
		end
		list:AddItem(photo)

		if ter.terDescr and ter.terDescr ~= "" then
			LTextBlock(list, ter.terDescr, "SkyLine.Body")
		end

		LRule(list)
		LSubBar(list, "Действия с объектом")

		local sellPrice = math.floor(ter.price * 0.5)
		LWebButton(list, ("Сдать за $%s"):format(string.Comma(sellPrice)), nyc.brick, function()
			MSD.AskPopup(nil, "Вы точно хотите сдать объект \"" .. ter.printName .. "\"?", nil,
				{"Да, сдать объект за " .. string.Comma(sellPrice) .. "$", function()
					net.Start("territorySell") net.WriteString(id) net.SendToServer()
					timer.Simple(0.4, function()
						if IsValid(base) then base.ManageList() end
					end)
				end},
				{"Нет, закрыть", function() end})
		end, 1)

		LRule(list)
		LSubBar(list, "Управление совладельцами")

		local mcd = MSD.ComboBox(list, nil, nil, list:GetWide(), 36, nil, "Выберите игрока")
		function mcd:ChooseOption(value, index)
			if self.Menu then self.Menu:Remove(); self.Menu = nil end
			if value == "Друзья:" or value == "Другие:" then return end
			self:SetText(value)
			self.selected = index
			self:OnSelect(index, value, self.Data[index])
		end
		mcd.Paint = function(self, wd, hd)
			surface.SetDrawColor(color_white)
			surface.DrawRect(0, 0, wd, hd)
			DrawBevelSunken(0, 0, wd, hd)
			draw.SimpleText(self:GetText(), "SkyLine.Body", 8, hd / 2, nyc.jet, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			return true
		end

		for k, v in pairs(McPhone.Contacts) do
			local pl = McPhone.GetByCharNumber(k)
			mcd:AddChoice(v, pl)
		end

		local halfW = list:GetWide() / 2 - 4
		local btnAdd = LWebButton(list, "+ Добавить совладельца", nyc.green, function()
			local ab, data = mcd:GetSelected()
			MSD.AskPopup(nil, "Вы точно хотите добавить владельца \"" .. (ab or "NIL") .. "\"?", nil,
				{"Да, добавить", function()
					if not IsValid(data) then return end
					net.Start("territoryAddOwner") net.WriteString(id) net.WriteEntity(data) net.SendToServer()
				end},
				{"Нет, закрыть", function() end})
		end)
		btnAdd:SetWide(halfW)

		local btnRem = LWebButton(list, "× Удалить совладельца", nyc.brick, function()
			local ab, data = mcd:GetSelected()
			MSD.AskPopup(nil, "Вы точно хотите удалить владельца \"" .. (ab or "NIL") .. "\"?", nil,
				{"Да, удалить", function()
					if not IsValid(data) then return end
					net.Start("territoryRemoveOwner") net.WriteString(id) net.WriteEntity(data) net.SendToServer()
				end},
				{"Нет, закрыть", function() end})
		end)
		btnRem:SetWide(halfW)

		LRule(list)
		LWebButton(list, "« Назад к списку моих объектов", nyc.navy, function()
			base.ManageList()
		end, 1)
	end

	-- ── Full-size map overlay (catalog browsing only) ──
	base.openMap = function()
		if IsValid(base.mapOverlay) then base.mapOverlay:Remove() end

		local ov = vgui.Create("DPanel", rightPanel)
		ov:SetPos(0, 0)
		ov:SetSize(rightPanel:GetWide(), rightPanel:GetTall())
		base.mapOverlay = ov

		local mapMargin = 14
		local headerH = 38
		local mw = ov:GetWide() - mapMargin * 2
		local mh = ov:GetTall() - mapMargin * 2 - headerH - 14
		local msz = math.min(mw, mh)
		local mx = (ov:GetWide() - msz) / 2
		local my = mapMargin + headerH + 4

		ov.Paint = function(self, wd, hd)
			surface.SetDrawColor(nyc.cream)
			surface.DrawRect(0, 0, wd, hd)
			DrawBevelRaised(0, 0, wd, hd)

			surface.SetDrawColor(nyc.jet)
			surface.DrawRect(2, 2, wd - 4, headerH)
			DrawTaxiStripe(2, headerH, wd - 4, 4)
			draw.SimpleText("» Карта недвижимости — выберите объект",
				"SkyLine.Header", 12, 4, nyc.cream, TEXT_ALIGN_LEFT)

			surface.SetDrawColor(color_white)
			surface.DrawRect(mx - 3, my - 3, msz + 6, msz + 6)
			DrawBevelSunken(mx - 3, my - 3, msz + 6, msz + 6)
			McPhone.DrawTexturedRect(mx, my, msz, msz, bigMap, color_white)
		--	McPhone.DrawTexturedRect(mx, my, msz, msz, MSD.Materials.vignette, color_black)

			local mapmin, mapmax = game.GetWorld():GetModelBounds()
			local scale = (mapmax.x - mapmin.x) / msz
			local pp = LocalPlayer():GetPos()
			if pp.z >= -4500 then
				local senter = msz / 2
				McPhone.DrawTexturedRect(mx + senter + (pp.x / scale) - 14, my + senter - (pp.y / scale) - 14, 28, 28, mats.player, nyc.brick)
			end
		end

		local closeBtn = vgui.Create("DButton", ov)
		closeBtn:SetText("")
		closeBtn:SetSize(150, 28)
		closeBtn:SetPos(ov:GetWide() - 160, 7)
		closeBtn.Paint = function(self, wd, hd)
			local bg = self.hover and nyc.close or nyc.brick
			surface.SetDrawColor(bg)
			surface.DrawRect(0, 0, wd, hd)
			DrawBevelRaised(0, 0, wd, hd)
			draw.SimpleText("× Закрыть карту", "SkyLine.Button", wd / 2, hd / 2, nyc.cream, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		closeBtn.OnCursorEntered = function(self) self.hover = true end
		closeBtn.OnCursorExited  = function(self) self.hover = false end
		closeBtn.DoClick = function() ov:Remove() end

		local mapmin, mapmax = game.GetWorld():GetModelBounds()
		local scale = (mapmax.x - mapmin.x) / msz
		local senter = msz / 2

		local ter_onmap = {}
		for k, v in pairs(Territories.list) do
			if not v.buyable then continue end
			local data = McPhone.ter_list[k]
			if not data then continue end

			local point = v.gps_point or v.coords[1]
			ter_onmap[k] = v
			ter_onmap[k].cord = { x = point.x / scale, y = point.y / scale }
		end

		local icon_group = {}
		for k, v in pairs(ter_onmap) do
			if v.group and icon_group[v.group] then
				icon_group[v.group].terlist[k] = true
				continue
			end

			local ix = mx + senter + v.cord.x - 12
			local iy = my + senter - v.cord.y - 12

			local but = MSD.IconButton(ov, mats[v.type], ix, iy, 24, nyc.taxi, nyc.close,
				function(self)
					if self.terlist then
						base.openHouse(self.terlist, self.listname)
					end
				end)
			but.noanim = true
			but.terlist = { [k] = true }

			if v.group then
				icon_group[v.group] = but
				if grop_names[v.group] then
					but.listname = grop_names[v.group].name
					local gx = mx + senter + (grop_names[v.group].pos.x / scale) - 12
					local gy = my + senter - (grop_names[v.group].pos.y / scale) - 12
					but:SetPos(gx, gy)
				end
			end
		end
	end

	base.Update()
end

net.Receive("territorySendInfo", function()
	McPhone.ter_list = net.ReadTable()
	if not McPhone.ActiveWeb then return end

	if not McPhone.ActiveWeb.WebAdress or McPhone.ActiveWeb.WebAdress:GetValue() ~= McPhone.WebModules["propertie"].url then return end

	McPhone.UpdateWeb(McPhone.WebModules["propertie"].Build)
end)

timer.Simple(10, function()
	net.Start("territorySendInfo")
	net.SendToServer()
end)
