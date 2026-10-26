--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/modules/web_shop_gun.lua
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

McPhone.WebModules["rdm"] = {}
McPhone.WebModules["rdm"].name = "RDM Ready"
McPhone.WebModules["rdm"].url = "https://rhodedefencemanufacturer.com"

McPhone.WebModules["knownweapons"] = {}
McPhone.WebModules["knownweapons"].name = "KnownWeapons.com"
McPhone.WebModules["knownweapons"].url = "https://knownweapons.com"


if SERVER then return end

local bg = Material("mc_phone/web/bg_gs.png", "noclamp smooth")
local bg2 = Material("mc_phone/web/bg2.png", "noclamp smooth")
local si = Material("mc_phone/icons/search.png", "smooth")

local paled = {
	["black_a200"] = Color(0, 0, 0, 200),
	["black_a100"] = Color(0, 0, 0, 100),
	["grey"] = Color(112, 112, 112),
	["dark"] = Color(20, 20, 20),
	["dark_l"] = Color(48, 48, 48),
	["orange"] = Color(255, 200, 0),
	["red"] = Color(255, 8, 0),
	["blue"] = Color(0, 132, 255),
	["other1"] = Color(98, 148, 4),
	["other2"] = Color(45, 68, 2),
}

McPhone.WebModules["rdm"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["rdm"].url)
	McPhone.UpdateWeb(McPhone.WebModules["rdm"].Build)

	net.Start("DarkRP.ShareDataReq")
		net.WriteUInt(0,3)
	net.SendToServer()
end

McPhone.WebModules["knownweapons"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["knownweapons"].url)
	McPhone.UpdateWeb(McPhone.WebModules["knownweapons"].Build)
end

local function ItemButton(parent, k, v, am, spec)
	local body = vgui.Create("DPanel")
	body.StaticScale = {
		w = 1,
		fixed_h = 120,
		minw = 300,
		minh = 48
	}

	local price = 0

	if v.sell_empty then
		v.dt = {
			Ammo = 0
		}

		price = McINV.Tax(v.price, INV_AMMO, v)
	else
		price = McINV.Tax(v.price)
	end

	local nobuy = v.xp and LocalPlayer():JobXP(v.xp[1]) < v.xp[2]

	body.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, ht - 2, wd, 2, paled.grey)
		MSDX.Draw(0, 0, 0, 2, ht, paled.orange)
		self.nsp = draw.SimpleText(v.name, "McPhone.Main28", 64, 0, color_white, TEXT_ALIGN_LEFT)

		if am and not v.sell_empty and v.ammo_box then
			draw.SimpleText("снаряжённый", "McPhone.Main28", 74 + self.nsp, 0, paled.orange, TEXT_ALIGN_LEFT)
		end

		local sps = draw.SimpleText("$" .. price, "McPhone.Main24", 64, 28, paled.orange, TEXT_ALIGN_LEFT)

		if v.xp then
			sps = draw.SimpleText("Оч. опыта оружейного мастера ", "McPhone.Main24", 80 + sps, 28, color_white, TEXT_ALIGN_LEFT) + sps
			draw.SimpleText(v.xp[2], "McPhone.Main24", 80 + sps, 28, paled.orange, TEXT_ALIGN_LEFT)
		end
		MSD.DrawTexturedRect(8, 8, 48, 48, am and MSD.Icons48.ammo or MSD.Icons48.box, MSD.Text["d"])

		if nobuy then
			draw.SimpleText("Нет в наличии", "McPhone.Main32", 10, 70, color_white, TEXT_ALIGN_LEFT)
		end
	end

	if not nobuy then
		MSD.Button(body, 5, 64, 250, 48, "Купить $" .. price, function()
			DarkRP.PlayerBuyItem(nil, am and "Ammo" or "Junk", k, 1, true)
		end)
	end

	if not spec then
		MSD.Button(body, 260, 64, 250, 48, "5 штук $" .. price * 5, function()
			DarkRP.PlayerBuyItem(nil, am and "Ammo" or "Junk", k, 5, true)
		end)
	end

	parent:AddItem(body)
end

local function MainButton(parent, text, func, nar)
	local body = vgui.Create("DButton")
	body:SetText(text)
	body.StaticScale = {
		w = nar and 1 or 2,
		fixed_h = nar and 75 or 250,
		minw = 300,
		minh = 48
	}
	body.alpha = 0
	body.Paint = function(self, wd, ht)
		if (self.hover or self.hovered) and not self.disabled then
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 0)
		end

		MSDX.Draw(0, 0, 0, 2, ht, paled.orange)
		local tw = draw.SimpleText(self:GetText(), "McPhone.Main38", wd / 2, ht / 2 - 10, color_white, TEXT_ALIGN_CENTER) + 50
		MSDX.Draw(0, wd / 2 - (tw / 2) * self.alpha, ht / 2 + 30, tw * self.alpha, 5, paled.orange)
		return true
	end

	body.OnCursorEntered = function(self)
		self.hover = true
	end

	body.OnCursorExited = function(self)
		self.hover = false
	end

	body.DoClick = function(self)
		func(self)
	end

	parent:AddItem(body)
end

local welcome = "Добро пожаловать на официальный сайт Rhode Defence Manufacturer! Для просмотра нашего ассортимента воспользуйтесь соответствующими кнопками или поисковой строкой вверху.\n\nЧасто используемые поисковые запросы (с учётом регистра): “Маг”, “Коробка”, “Запчасти”."
local nogun = "Раздел недоступен.\n\nЧтобы заказывать запчасти и детали для оружия, вам необходима лицензия на продажу оружия. Сайт автоматически синхронизирует изменения в городской базе данных."

McPhone.WebModules["rdm"].Build = function(parent, w, h)

	local ammo = {}
	local parts = {}
	local other = {}

	for k,v in pairs(DarkRP.Ammo) do
		if v.shop ~= "rdm" then continue end
		ammo[k] = v
	end

	if LocalPlayer():Team() == TEAM_GUN then
		for k,v in pairs(DarkRP.Junk) do
			if v.shop ~= "rdm" then continue end
			parts[k] = v
		end
	end

	for k,v in pairs(DarkRP.Junk) do
		if v.shop ~= "rdm_o" then continue end
		other[k] = v
	end

	local top = vgui.Create("DPanel", parent)
	top:SetSize(0, h / 4)
	top:Dock(TOP)

	top.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, paled.dark)
		MSDX.Draw(0, 0, ht - 8, wd, 8, paled.orange)
		McPhone.DrawTexturedRect(15, ht / 2 - 140, 500, 280, MSD.ImgLib.GetMaterial("http://cityrp.macnco.one/assets/rdm.png"), color_white)
		draw.SimpleText("Ваш баланс: $" .. string.Comma(LocalPlayer():getDarkRPVar("money")), "McPhone.Main38", 540, h / 4 - 150, color_white, TEXT_ALIGN_LEFT)
	end

	local main = vgui.Create("DPanel", parent)
	main:Dock(FILL)

	main.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, color_black)
		surface.SetMaterial(bg)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectUV(0, 0, wd, ht, 0, 0, wd / 400, ht / 400)
	end

	local body = vgui.Create("DPanel", main)
	body:Dock(FILL)
	body:DockMargin(20, 0, 20, 0)
	body:DockPadding(20, 0, 20, 0)

	body.Paint = function(self, wd, ht)
		MSDX.Draw(0, 0, 0, wd, ht, paled.black_a100)
		MSDX.Draw(0, 2, 0, wd - 4, ht, paled.dark)
		--draw.SimpleText("Список", "McPhone.Main38", 30, 15, color_white, TEXT_ALIGN_LEFT)
	end

	local blist = vgui.Create("MSDPanelList", body)
	blist:SetSize(w - 100, h - h / 4)
	blist:SetPos(30, 10)
	blist:EnableVerticalScrollbar()
	blist:EnableHorizontal(true)
	blist:SetPadding(5)
	blist:SetSpacing(5)
	blist.IgnoreVbar = false
	blist.Paint = function() end
	blist.Update = function(filter, am)
		blist:Clear()

		MainButton(blist, "Назад в меню", function()
			blist.MainMenu()
		end, true)

		if not am or am == 1 then
			for k,v in SortedPairsByMemberValue(ammo, "price") do
				if filter and not string.find(utf8.search(v.name), utf8.search(filter), 1, true) then continue end
				ItemButton(blist, k, v, true)
			end
		end

		if am and am == 4 then

			if not McPhone.RDMGunz then
				local pn = vgui.Create("DPanel")
				pn.StaticScale = {
					w = 1,
					fixed_h = 42,
					minw = 300,
					minh = 42
				}
				pn.Paint = function(self, wd, ht)
					MSDX.Draw(0, 0, 0, 2, ht, paled.red)
					draw.DrawText(MSD.TextWrap("Мы не нашли подходящий контракт для вас", "McPhone.Main28", wd - 15), "McPhone.Main28" , 10, 5, color_white, TEXT_ALIGN_LEFT)
				end
				blist:AddItem(pn)
				return
			end

			local pn = vgui.Create("DPanel")
			pn.StaticScale = {
				w = 1,
				h = 1.5,
				minw = 300,
				minh = 42
			}

			local wp = DarkRP.Weapons[McPhone.RDMGunz.weapon.class]
			pn.text = "Активный контракт от: " .. McPhone.RDMGunz.name .. "\n\nЗаказ на: " .. (wp and wp.name or "") .. "\nПодходящие варианты:\n"

			if GunNamesGlobal[McPhone.RDMGunz.weapon.class] then
				for k,v in pairs(GunNamesGlobal[McPhone.RDMGunz.weapon.class]) do
					pn.text = pn.text .. k .. "\n"
				end
			end

			pn.text = pn.text .. "\nКоличество: мин. " .. McPhone.RDMGunz.weapon.ammount .. " шт.\nПремия: " .. McPhone.RDMGunz.price .. "%\n\nКонтракт открытый; действует до выполнения общей квоты. Приём заказа осуществляется в любой ближайшей точке сбыта. Оружие с изменённым или отсутствующим серийным номером не допускаются к продаже."
			pn.Paint = function(self, wd, ht)
				MSDX.Draw(0, 0, 0, 2, ht, paled.other1)
				draw.DrawText(MSD.TextWrap(self.text, "McPhone.Main24", wd - 15), "McPhone.Main24" , 10, 5, color_white, TEXT_ALIGN_LEFT)
			end
			blist:AddItem(pn)

			MainButton(blist, "Точка сбыта (GPS)", function()
				McPhone.ToggleGPS("Точка сбыта", Vector(679.37750244141,-5573.2475585938,-319.62677001953))
			end, true)
		end

		if not am or am == 2 then
			if am and table.IsEmpty(parts) then
				local pn = vgui.Create("DPanel")
				pn.StaticScale = {
					w = 1,
					fixed_h = 120,
					minw = 300,
					minh = 48
				}
				pn.Paint = function(self, wd, ht)
					MSDX.Draw(0, 0, 0, 2, ht, paled.red)
					draw.DrawText(MSD.TextWrap(nogun, "McPhone.Main24", wd - 15), "McPhone.Main24" , 10, 5, color_white, TEXT_ALIGN_LEFT)
				end
				blist:AddItem(pn)
				return
			end

			for k,v in SortedPairsByMemberValue(parts, "price") do
				if filter and not string.find(utf8.search(v.name), utf8.search(filter), 1, true) then continue end
				ItemButton(blist, k, v, false)
			end
		end

		if am and am == 3 then
			for k,v in SortedPairsByMemberValue(other, "price") do
				if filter and not string.find(utf8.search(v.name), utf8.search(filter), 1, true) then continue end
				ItemButton(blist, k, v, false, true)
			end
		end
	end

	blist.MainMenu = function()
		blist:Clear()

		local pn = vgui.Create("DPanel")
		pn.StaticScale = {
			w = 1,
			fixed_h = 120,
			minw = 500,
			minh = 48
		}
		pn.Paint = function(self, wd, ht)
			MSDX.Draw(0, 0, 0, 2, ht, paled.blue)
			draw.DrawText(MSD.TextWrap(welcome, "McPhone.Main24", wd - 15), "McPhone.Main24" , 10, 5, color_white, TEXT_ALIGN_LEFT)
		end
		blist:AddItem(pn)

		MainButton(blist, "Запчасти и расходники", function()
			blist.Update(nil, 2)
		end)

		MainButton(blist, "Амуниция", function()
			blist.Update(nil, 1)
		end)

		MainButton(blist, "Особые предложения", function()
			blist.Update(nil, 3)
		end)

		MainButton(blist, "Контракты", function()
			blist.Update(nil, 4)
		end)
	end

	blist.MainMenu()

	local src = vgui.Create("DTextEntry", top)
	src:SetSize(w / 2.6, 50)
	src:SetPos(540, h / 4 - 100)
	src:SetText("")
	src:SetFont("McPhone.Main32")
	src:SetValue("")
	src:SetEditable(true)
	src:SetUpdateOnType(true)
	function src:OnValueChange(vl)
		blist.Update(vl)
	end
	src.Paint = function(self, wd, ht)
		MSDX.Draw(6, 0, 0, wd, ht, paled.dark)
		MSDX.Draw(6, 1, 1, wd - 2, ht - 2, paled.dark_l)
		self:DrawTextEntryText(color_white, paled.orange, color_white)

		if self:GetValue() == "" then
			McPhone.DrawTexturedRect(9, 9, 32, 32, si, paled.orange)
			draw.SimpleText("Поиск по сайту...", "McPhone.Main32", 50, 9, paled.grey, TEXT_ALIGN_LEFT)
		end
	end
end

local names = {
	"ZoneTec-9",
	"Mac&Mac",
	"StAdams",
	"clockwork",
	"SpecialWeapon",
	"DMT",
	"DeityREYZEN",
	"Babuz",
	"BH",
	"Mccollum",
	"Demolitia",
	"GarandThumb",
	"KentuckyFriedCartridges",
	"FPSrussia",
	"LTalionis",
	"AUGist",
	"CHESNOKOV",
	"coxtucker",
	"2A",
}
local user = {}

-- ╔══════════════════════════════════════════════════════════╗ --
-- ║   KnownWeapons.com — 1990s online firearms catalog       ║ --
-- ║   Reuses SkyLine.* fonts registered by web_properly.lua. ║ --
-- ╚══════════════════════════════════════════════════════════╝ --

-- Commercial firearms retailer palette (red banner / navy promo / yellow accents)
local kw = {
	-- Page surfaces
	body        = Color(252, 250, 245),
	bodyAlt     = Color(244, 240, 230),
	sidebar     = Color(228, 220, 205),
	sidebarAlt  = Color(216, 208, 192),
	sidebarRow  = Color(244, 238, 222),

	-- Brand
	redHead     = Color(168, 32, 32),
	redHeadDk   = Color(115, 18, 18),
	navyPromo   = Color(20, 38, 78),
	navyPromoDk = Color(12, 24, 56),
	yellow      = Color(252, 196, 25),
	yellowDk    = Color(200, 152, 18),
	buy         = Color(48, 110, 60),
	buyDk       = Color(28, 78, 42),
	priceRed    = Color(180, 30, 30),
	link        = Color(20, 50, 165),

	-- Text
	ink         = Color(30, 30, 30),
	inkSub      = Color(95, 88, 78),
	cream       = Color(248, 244, 234),

	-- Legacy aliases kept so existing references still resolve
	paper       = Color(252, 250, 245),
	paperAlt    = Color(244, 240, 230),
	paperDark   = Color(224, 216, 200),
	olive       = Color(54, 80, 30),
	oliveDark   = Color(30, 50, 18),
	oliveLight  = Color(95, 130, 55),
	brass       = Color(178, 140, 50),
	brassDark   = Color(120, 92, 28),
	blood       = Color(168, 32, 32),
	bloodDark   = Color(115, 18, 18),
	jet         = Color(24, 22, 18),
	subtle      = Color(95, 88, 78),
}

local kwBvlLight = Color(255, 255, 250)
local kwBvlDark  = Color(60, 60, 55)

local function kwDrawBevel(x, y, w, h, light, dark)
	surface.SetDrawColor(light)
	surface.DrawRect(x, y, w, 2)
	surface.DrawRect(x, y, 2, h)
	surface.SetDrawColor(dark)
	surface.DrawRect(x, y + h - 2, w, 2)
	surface.DrawRect(x + w - 2, y, 2, h)
end

local function kwBevelRaised(x, y, w, h)
	kwDrawBevel(x, y, w, h, kwBvlLight, kwBvlDark)
end

local function kwBevelSunken(x, y, w, h)
	kwDrawBevel(x, y, w, h, kwBvlDark, kwBvlLight)
end

local function kwParchment(w, h)
	surface.SetDrawColor(kw.paper)
	surface.DrawRect(0, 0, w, h)
	surface.SetDrawColor(kw.paperAlt)
	for yy = 0, h, 30 do
		surface.DrawRect(0, yy, w, 1)
	end
end

-- Section header rendered inside the listings MSDPanelList
local function kwSectionHeader(parent, text)
	local panel = vgui.Create("DPanel")
	panel.StaticScale = { w = 1, fixed_h = 34, minw = 250, minh = 34 }
	panel.Paint = function(self, w, h)
		surface.SetDrawColor(kw.redHead)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(kw.yellow)
		surface.DrawRect(0, h - 3, w, 3)
		kwBevelRaised(0, 0, w, h)
		draw.SimpleText("» " .. text, "SkyLine.Header", 10, h / 2 - 1, kw.cream, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	end
	parent:AddItem(panel)
	return panel
end

-- Compact sidebar row for the "Most Popular" list (cheapest = most popular)
local function KWPopularRow(parent, rank, k, v, am, price)
	local btn = vgui.Create("DButton")
	btn:SetText("")
	btn.StaticScale = { w = 1, fixed_h = 42, minw = 150, minh = 42 }

	btn.Paint = function(self, wd, hd)
		surface.SetDrawColor(self.hover and kw.sidebarRow or kw.body)
		surface.DrawRect(0, 0, wd, hd)
		kwBevelRaised(0, 0, wd, hd)

		-- Rank badge
		surface.SetDrawColor(kw.redHead)
		surface.DrawRect(2, 2, 26, hd - 4)
		draw.SimpleText("#" .. rank, "SkyLine.BodyB", 15, hd / 2, kw.cream, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		-- Item name (truncated if it overflows)
		local maxW = wd - 32 - 56
		surface.SetFont("SkyLine.SmallB")
		local name = v.name
		if surface.GetTextSize(name) > maxW then
			while #name > 3 and surface.GetTextSize(name .. "...") > maxW do
				name = string.sub(name, 1, #name - 1)
			end
			name = name .. "..."
		end
		draw.SimpleText(name, "SkyLine.SmallB", 32, 4, kw.ink, TEXT_ALIGN_LEFT)
		draw.SimpleText(am and "(боеприпасы)" or "(запчасть)", "SkyLine.Small", 32, 22, kw.inkSub, TEXT_ALIGN_LEFT)

		-- Price (right side, red)
		draw.SimpleText("$" .. price, "SkyLine.BodyB", wd - 6, hd / 2, kw.priceRed, TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
	end
	btn.OnCursorEntered = function(self) self.hover = true end
	btn.OnCursorExited  = function(self) self.hover = false end
	btn.DoClick = function()
		DarkRP.PlayerBuyItem(nil, am and "Ammo" or "Junk", k, 1, true)
	end

	parent:AddItem(btn)
	return btn
end

-- 3D olive "Buy" button (replaces the old gradient OldButton helper)
local function KWButton(parent, x, y, wd, hd, text, func, cl)
	cl = cl or kw.olive
	local buton = vgui.Create("DButton", parent)
	buton:SetPos(x, y)
	buton:SetSize(wd, hd)
	buton:SetText("")

	buton.Paint = function(self, w, h)
		local bg = self.hover and Color(math.min(cl.r + 28, 255), math.min(cl.g + 28, 255), math.min(cl.b + 28, 255)) or cl
		surface.SetDrawColor(bg)
		surface.DrawRect(0, 0, w, h)
		if self.pressed then
			kwBevelSunken(0, 0, w, h)
		else
			kwBevelRaised(0, 0, w, h)
		end
		local off = self.pressed and 1 or 0
		draw.SimpleText(text, "SkyLine.Button", w / 2 + off + 1, h / 2 + off + 1, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		draw.SimpleText(text, "SkyLine.Button", w / 2 + off, h / 2 + off, kw.cream, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		return true
	end

	buton.OnCursorEntered = function(self) self.hover = true end
	buton.OnCursorExited  = function(self) self.hover = false; self.pressed = false end
	buton.OnMousePressed  = function(self, k) self.pressed = true; DButton.OnMousePressed(self, k) end
	buton.OnMouseReleased = function(self, k) self.pressed = false; DButton.OnMouseReleased(self, k) end
	buton.DoClick = function(self) func(self) end

	return buton
end

-- Catalog row: parchment card with olive ribbon, sunken icon frame, review stars + reviewer, big "Buy" button
local function ItemButtonKWPNS(parent, k, v, am)
	local nobuy = v.xp and LocalPlayer():JobXP(v.xp[1]) < v.xp[2]

	if nobuy then return end

	local body = vgui.Create("DPanel")
	body.StaticScale = {
		w = 1,
		fixed_h = 140,
		minw = 300,
		minh = 140
	}

	local price = 0

	if v.sell_empty then
		v.dt = {
			Ammo = 0
		}
		price = McINV.Tax(v.price, INV_AMMO, v)
	else
		price = McINV.Tax(v.price)
	end

	body.Paint = function(self, wd, ht)
		-- White card with raised 3D bevel
		surface.SetDrawColor(kw.body)
		surface.DrawRect(0, 0, wd, ht)
		kwBevelRaised(0, 0, wd, ht)

		-- Yellow ribbon on left
		surface.SetDrawColor(kw.yellow)
		surface.DrawRect(2, 2, 6, ht - 4)

		-- Icon frame (sunken)
		surface.SetDrawColor(kw.bodyAlt)
		surface.DrawRect(16, 14, 92, 92)
		kwBevelSunken(16, 14, 92, 92)
		McPhone.DrawTexturedRect(20, 18, 84, 84, MSD.ImgLib.GetMaterial("http://cityrp.macnco.one/assets/bg_icon.png"), color_white)

		-- Item name (Times New Roman serif, blue underlined link)
		draw.SimpleText(v.name, "SkyLine.Header", 124, 14, kw.link, TEXT_ALIGN_LEFT)
		surface.SetFont("SkyLine.Header")
		local nw, _ = surface.GetTextSize(v.name)
		surface.SetDrawColor(kw.link)
		surface.DrawRect(124, 42, nw, 1)

		-- Type chip
		local chipText = am and "[ Боеприпасы ]" or "[ Запчасть · Аксессуар ]"
		draw.SimpleText(chipText, "SkyLine.SmallB", 124, 48, kw.inkSub, TEXT_ALIGN_LEFT)

		-- Reviewer + 5-star rating
		if user[k] then
			draw.SimpleText("Listed by " .. user[k][1], "SkyLine.SmallB", 124, ht - 56, kw.inkSub, TEXT_ALIGN_LEFT)
			for i = 1, 5 do
				MSD.DrawTexturedOutlined(124 + (i - 1) * 22, ht - 32, 18, 18, MSD.PinPoints[49], i <= user[k][2] and kw.yellow or kw.bodyAlt, 1, kw.ink)
			end
			draw.SimpleText("(" .. user[k][2] .. "/5)", "SkyLine.Small", 124 + 5 * 22 + 8, ht - 28, kw.ink, TEXT_ALIGN_LEFT)
		end
	end

	-- Big green "Buy Now" button on the right
	body.bb = KWButton(body, 0, 0, 210, 52, "$" .. price .. " · Купить", function()
		DarkRP.PlayerBuyItem(nil, am and "Ammo" or "Junk", k, 1, true)
	end, kw.buy)

	function body:PerformLayout()
		if not self.bb then return end
		self.bb:SetPos(self:GetWide() - 226, self:GetTall() - 72)
	end

	parent:AddItem(body)
end

McPhone.WebModules["knownweapons"].Build = function(parent, w, h)
	-- Build catalog data from DarkRP entries + fake-listing reviewer names/ratings.
	-- "popular" rows below are simply the cheapest items first.
	local ammo = {}
	local parts = {}
	local allByPrice = {}

	local function pushItem(k, v, am)
		local price
		if v.sell_empty then
			v.dt = { Ammo = 0 }
			price = McINV.Tax(v.price, INV_AMMO, v)
		else
			price = McINV.Tax(v.price)
		end
		if v.xp and LocalPlayer():JobXP(v.xp[1]) < v.xp[2] then return end
		allByPrice[#allByPrice + 1] = { k = k, v = v, am = am, price = price }
	end

	for k, v in pairs(DarkRP.Ammo) do
		if v.shop ~= "kwpns" then continue end
		ammo[k] = v
		if not user[k] then
			user[k] = { names[math.random(#names)], math.random(3, 5) }
		end
		pushItem(k, v, true)
	end

	for k, v in pairs(DarkRP.Junk) do
		if v.shop ~= "kwpns" then continue end
		parts[k] = v
		if not user[k] then
			user[k] = { names[math.random(#names)], math.random(3, 5) }
		end
		pushItem(k, v, false)
	end

	table.sort(allByPrice, function(a, b) return a.price < b.price end)

	-- ── Page base ──
	local base = vgui.Create("DPanel", parent)
	base:SetSize(w, h)
	base.Paint = function(self, wd, ht)
		surface.SetDrawColor(kw.body)
		surface.DrawRect(0, 0, wd, ht)
	end

	-- ── Top red header bar ──
	local bannerH = 64
	local banner = vgui.Create("DPanel", base)
	banner:SetSize(w, bannerH)
	banner:SetPos(0, 0)
	banner.Paint = function(self, wd, ht)
		-- Flat red with subtle vertical fade
		surface.SetDrawColor(kw.redHead)
		surface.DrawRect(0, 0, wd, ht)
		for yy = 0, ht, 2 do
			local f = yy / ht
			surface.SetDrawColor(kw.redHead.r - f * 28, kw.redHead.g - f * 6, kw.redHead.b - f * 6)
			surface.DrawRect(0, yy, wd, 2)
		end
		-- Yellow strip at bottom
		surface.SetDrawColor(kw.yellow)
		surface.DrawRect(0, ht - 3, wd, 3)
		kwBevelRaised(0, 0, wd, ht)

		-- Title
		McPhone.DrawTexturedRect(5, -10, 159, 80, MSD.ImgLib.GetMaterial("http://cityrp.macnco.one/assets/weapons2.png"), color_white)
		-- draw.SimpleText("KNOWNWEAPONS", "SkyLine.Title", 12, 4, kw.cream, TEXT_ALIGN_LEFT)
		-- surface.SetFont("SkyLine.Title")
		-- local tw, _ = surface.GetTextSize("KNOWNWEAPONS")
		-- draw.SimpleText(".com", "SkyLine.Sub", 14 + tw, 28, kw.yellow, TEXT_ALIGN_LEFT)

		-- Balance on the right
		draw.SimpleText("ВАШ БАЛАНС", "SkyLine.SmallB", wd - 14, 4, kw.yellow, TEXT_ALIGN_RIGHT)
		draw.SimpleText("$" .. string.Comma(LocalPlayer():getDarkRPVar("money")), "SkyLine.Header", wd - 14, 22, kw.cream, TEXT_ALIGN_RIGHT)
	end

	-- ── Navy promo strip below banner ──
	local promoY = bannerH
	local promoH = 28
	local promo = vgui.Create("DPanel", base)
	promo:SetSize(w, promoH)
	promo:SetPos(0, promoY)
	promo.Paint = function(self, wd, ht)
		surface.SetDrawColor(kw.navyPromo)
		surface.DrawRect(0, 0, wd, ht)
		kwBevelSunken(0, 0, wd, ht)
		draw.SimpleText(
			"★ SECURE ORDERING  ·  FAST DELIVERY  ·  EST. 1998 ★",
			"SkyLine.SmallB", wd / 2, ht / 2, kw.cream, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
	end

	-- ── 2-column layout: popular sidebar (left), catalog (right) ──
	local contentY = promoY + promoH + 4
	local contentH = h - contentY - 4

	local sidebarW = 230
	local sidebar = vgui.Create("DPanel", base)
	sidebar:SetPos(6, contentY)
	sidebar:SetSize(sidebarW, contentH - 6)

	local mainX = sidebarW + 12
	local mainW = w - mainX - 6
	local mainPanel = vgui.Create("DPanel", base)
	mainPanel:SetPos(mainX, contentY)
	mainPanel:SetSize(mainW, contentH - 6)

	-- ── Sidebar paint + content ──
	local promoBoxH = 96

	sidebar.Paint = function(self, wd, ht)
		surface.SetDrawColor(kw.sidebar)
		surface.DrawRect(0, 0, wd, ht)
		kwBevelRaised(0, 0, wd, ht)

		-- Sidebar title strip
		surface.SetDrawColor(kw.redHead)
		surface.DrawRect(2, 2, wd - 4, 34)
		surface.SetDrawColor(kw.yellow)
		surface.DrawRect(2, 32, wd - 4, 4)
		draw.SimpleText("» ПОПУЛЯРНОЕ", "SkyLine.Header", 10, 6, kw.cream, TEXT_ALIGN_LEFT)
	end

	-- "Most Popular" list (sorted ascending by price)
	local popList = vgui.Create("MSDPanelList", sidebar)
	popList:SetPos(6, 42)
	popList:SetSize(sidebarW - 12, contentH - 6 - 42 - promoBoxH - 8)
	popList:EnableVerticalScrollbar()
	popList:SetSpacing(3)
	popList:SetPadding(0)
	popList.Paint = function() end

	local ic = 0
	for i, item in ipairs(allByPrice) do
		if item.price < 50 then continue end
		if ic > 15 then break end
		ic = ic + 1
		KWPopularRow(popList, ic, item.k, item.v, item.am, item.price)
	end

	-- Sidebar promo box (bottom)
	local promoBox = vgui.Create("DPanel", sidebar)
	promoBox:SetPos(6, contentH - 6 - promoBoxH - 4)
	promoBox:SetSize(sidebarW - 12, promoBoxH)
	promoBox.Paint = function(self, wd, ht)
		surface.SetDrawColor(kw.yellow)
		surface.DrawRect(0, 0, wd, ht)
		kwBevelRaised(0, 0, wd, ht)
		-- Inner dashed-cream block
		surface.SetDrawColor(kw.cream)
		surface.DrawRect(6, 6, wd - 12, ht - 12)
		draw.SimpleText("★                                      ★", "SkyLine.BodyB", wd / 2, 24, kw.redHeadDk, TEXT_ALIGN_CENTER)
		draw.SimpleText("БЕСПЛАТНАЯ", "SkyLine.BodyB", wd / 2, 14, kw.redHeadDk, TEXT_ALIGN_CENTER)
		draw.SimpleText("ДОСТАВКА", "SkyLine.BodyB", wd / 2, 32, kw.redHeadDk, TEXT_ALIGN_CENTER)
		draw.SimpleText("на заказы от $50", "SkyLine.Small", wd / 2, 48, kw.inkSub, TEXT_ALIGN_CENTER)
		draw.SimpleText("Заказывайте прямо сейчас!", "SkyLine.Small", wd / 2, 64, kw.inkSub, TEXT_ALIGN_CENTER)
	end

	-- ── Main pane: search bar on top, catalog below ──
	mainPanel.Paint = function(self, wd, ht)
		surface.SetDrawColor(kw.body)
		surface.DrawRect(0, 0, wd, ht)
		kwBevelSunken(0, 0, wd, ht)
	end

	local searchH = 32
	local search = vgui.Create("DTextEntry", mainPanel)
	search:SetPos(8, 8)
	search:SetSize(mainW - 16, searchH)
	search:SetText("")
	search:SetFont("SkyLine.Body")
	search:SetEditable(true)
	search:SetUpdateOnType(true)

	local catalog = vgui.Create("MSDPanelList", mainPanel)
	catalog:SetPos(8, 8 + searchH + 6)
	catalog:SetSize(mainW - 16, contentH - 6 - 16 - searchH - 6)
	catalog:EnableVerticalScrollbar()
	catalog:EnableHorizontal(true)
	catalog:SetSpacing(4)
	catalog:SetPadding(0)
	catalog.Paint = function() end

	catalog.Update = function(filter)
		catalog:Clear()

		kwSectionHeader(catalog, "Каталог · все объявления")

		local total = 0
		for k, v in SortedPairsByMemberValue(ammo, "price") do
			if filter and not string.find(utf8.search(v.name), utf8.search(filter), 1, true) then continue end
			ItemButtonKWPNS(catalog, k, v, true)
			total = total + 1
		end

		for k, v in SortedPairsByMemberValue(parts, "price") do
			if filter and not string.find(utf8.search(v.name), utf8.search(filter), 1, true) then continue end
			ItemButtonKWPNS(catalog, k, v, false)
			total = total + 1
		end

		if total == 0 then
			local pn = vgui.Create("DPanel")
			pn.StaticScale = { w = 1, fixed_h = 80, minw = 300, minh = 80 }
			pn.Paint = function(self, wd, ht)
				surface.SetDrawColor(kw.bodyAlt)
				surface.DrawRect(0, 0, wd, ht)
				kwBevelRaised(0, 0, wd, ht)
				draw.SimpleText("⚠ Объявлений не найдено", "SkyLine.Header", wd / 2, ht / 2 - 12, kw.redHeadDk, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
				draw.SimpleText("Попробуйте изменить поисковый запрос", "SkyLine.Small", wd / 2, ht / 2 + 14, kw.inkSub, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
			catalog:AddItem(pn)
		end
	end

	catalog.Update()

	function search:OnValueChange(vl)
		catalog.Update(vl)
	end
	search.Paint = function(self, wd, ht)
		surface.SetDrawColor(color_white)
		surface.DrawRect(0, 0, wd, ht)
		kwBevelSunken(0, 0, wd, ht)
		self:DrawTextEntryText(kw.ink, kw.priceRed, kw.ink)
		if self:GetValue() == "" then
			McPhone.DrawTexturedRect(8, 6, 20, 20, si, kw.inkSub)
			draw.SimpleText("Поиск по сайту...", "SkyLine.Body", 36, ht / 2, kw.inkSub, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end
end

net.Receive("DarkRP.ShareDataReq", function(l, ply)
	local data = net.ReadUInt(3)
	if data == 0 then
		local has = net.ReadBool()
		if has then
			McPhone.RDMGunz = net.ReadTable()
		else
			McPhone.RDMGunz = nil
		end
	end
end)