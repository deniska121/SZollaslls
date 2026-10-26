-- "addons\\mc_phone\\lua\\mc_phone\\modules\\web_shop.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--

McPhone.WebModules["shop"] = {}
McPhone.WebModules["shop"].name = "PackRat"
McPhone.WebModules["shop"].url = "https://packrat.shop"

if SERVER then return end

McPhone.WebModules["shop"].OpenWebmenu = function()
	if not McPhone.ActiveWeb then return end
	McPhone.ActiveWeb.WebAdress:SetValue(McPhone.WebModules["shop"].url)

	McPhone.UpdateWeb(McPhone.WebModules["shop"].Build)
end

local bgcl = Color(57,57,57)

local mcl = Color(255,188,4)
local scl = Color(255,217,134)
local ltext = [[Оптом и дёшево - как смысл жизни.

Еда тоже нужна на протяжении всей жизни. Любые случаи также легко улучшить едой. У нас она есть, очень много и с хорошими вкусами. Главное не смотрите на срок годности, и вы сами в этом убедитесь!

WANK™ CO.]]

local function WankHeader(parent, text, back, icon, align)
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 50,
		minw = 250,
		minh = 50
	}

	panel.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, h - 5, w, 5, mcl)
		draw.DrawText(text, "MSDFontB.32", align and 50 or w / 2, 12, color_white, align and TEXT_ALIGN_LEFT or TEXT_ALIGN_CENTER)
	end

	parent:AddItem(panel)

	if back then
		MSD.IconButton(panel, icon or MSD.Icons48.back, 13, 13, 24, color_black, scl, back)
	end

	return panel
end

local function WankButton(parent, text, func, spr)
	local button = vgui.Create("DButton")
	button.StaticScale = {
		w = spr or 2,
		fixed_h = 64,
		minw = 64,
		minh = 48
	}

	button:SetText("")
	button.Paint = function(self, w, h)
		draw.RoundedBox(0, 0, 3, w, h - 3, mcl)

		if self.hover then
			draw.RoundedBox(0, 0, 3, w, h - 3, scl)
			draw.SimpleText(text, "McPhone.Main28", 10, 16, color_black, TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(text, "McPhone.Main28", 10, 16, color_black, TEXT_ALIGN_LEFT)
		end
	end
	button.DoClick = function(self)
		func(self)
	end
	button.OnCursorEntered = function(self) self.hover = true end
	button.OnCursorExited = function(self) self.hover = false end
	parent:AddItem(button)
end

local function WankInfoText(parent, text, font)
	font = font or "MSDFont.18"
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 25,
		minw = 250,
		minh = 25
	}

	panel.Paint = function(self, w, h)
		local ts, _, th = MSD.TextWrap(text, font, w - 10)
		draw.DrawText(ts, font, 5, 5, color_white, TEXT_ALIGN_LEFT)

		if th > h then
			self.StaticScale.fixed_h = th + 10
		end
	end

	parent:AddItem(panel)

	return panel
end

local desc = {
	["seed_weed"] = "Наш товар прошёл все проверки, инстанции и сертификации - и может легально продаваться, к тому же с прибылью! Мы любим прибыль. Мы любим, когда вы даёте нам деньги. Запретный плод сладок – и дорог – купите сейчас, пока предложение неограниченно! Успокойтесь, как вы того заслуживаете!",
	["seed_coca"] = "Уберите от экрана беременных женщин и детей – они будут завидовать! Именно наша кока добавлялась в красную газировку, какую нельзя называть без рекламы! Именно нашу коку жевали индейцы, когда вы прогоняли их с их же родных земель! Именно эту коку жуют наши фермеры, чтобы работать за троих! Наша кока лучшая в мире – она продаётся!",
	["seed_opium"] = "Правительство пользуется этим причудливым растением, а чем вы хуже? Будьте, как правительство! Забудьте про снотворное – повторяйте прямо за президентом! Забудьте про боль с этим цветком – будьте, как спецслужбы и медики с шприцами-ручками! И что, что легко развивается зависимость, и передозировать одним уколом даже мамонта элементарно? Зато военный стандарт!",
	["sack_herb"] = "Все любят травы! А кто говорит что не любит – тот любит больше всех! У них больше миллиона использований! Вы можете их жевать, смотреть, настаивать, добавлять в еду и жевать её.. Миллионы возможностей! Это точно не обман и не обычная трава с вашего газона!",
	["sack_sugar"] = "Казалось бы, продукт древности – и мы сохранили его специально для того, чтобы продать вам! Местные жители жарких регионов ничего не делали, когда мы присваивали себе их ресурсы, и теперь они рады платить нам за их пользование! Заплатите и вы! Купите то, что по праву уже принадлежит вам!",
	["sack_flour"] = "Какая выпечка может существовать без муки? Вопрос риторический. Вы просто обязаны использовать нашу муку для своих пекарных проектов! Почему нельзя просто купить наше зерно и перемолоть его самим? Потому что мы так сказали. Иначе мы вас засудим. А зачем тратить время на суды, даже если вы выиграете их с вероятностью в 99%? Это стресс, это вам не надо. Вам надо муки!",
	["sack_grape"] = "Наш виноград – самый настоящий из ненастоящих! Лучше не пытайтесь его есть – покупайте исключительно для брожения! Не верите в вымирание культур? Ваши проблемы. Это факт! Вы же будете верить всему, что имеет слово ‘факт’, не так ли?",
	["sack_grain"] = "Зерно – основа жизни! Какой жизни? Всей! Покупая его у нас, вы создаёте жизнь! Откуда происхождение этого зерна? ..Откуда столько вопросов? Просто купите его и вы останетесь довольны! Все любят сюрприз-механики, и вы полюбите!",
	["sack_yeast"] = "Дрожжи! Что может быть прекраснее, чем совместить наши откормленные дрожжи с одним из наших продуктов, для создания изумительного алкоголя по нашей рецептуре? Только совмещение наших дрожжей с одним из наших продуктов, для создания закуски по нашей рецептуре для нашего алкоголя!"
}

McPhone.WebModules["shop"].Build = function(parent, w, h)
	local base = vgui.Create("DPanel", parent)
	base:SetSize(w, h)
	local hdr = (w + 100) / 1.777
	base.Paint = function(self, wd, hd)
		surface.SetMaterial(MSD.ImgLib.GetMaterial("http://cityrp.macnco.one/assets/pakrat_bg.png"))
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(- 50, - wd / 3, wd + 100, hdr)

		surface.SetMaterial(MSD.ImgLib.GetMaterial("http://cityrp.macnco.one/assets/pakrat_logo.png"))
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(wd / 2 - 220, 50, 440, 90)

		draw.RoundedBox(0, 0, 190, wd, 10, color_black)
	end

	local panel = vgui.Create("DPanel", parent)
	panel:SetPos(0, 200)
	panel:SetSize(w, h - 200)
	panel.Paint = function(self, wd, hd)
		draw.RoundedBox(0, 0, 0, wd, hd, bgcl)
		draw.RoundedBox(0, 0, 0, wd, 55, mcl)

		draw.DrawText("Товары оптом и дёшево!", "MSDFontB.32", 12, 12, bgcl, TEXT_ALIGN_LEFT)
	end

	panel.cw = vgui.Create("MSDPanelList", panel)
	panel.cw:SetSize(340, h - 265)
	panel.cw:SetPos(w - 340, 90)
	panel.cw:EnableVerticalScrollbar()
	panel.cw:EnableHorizontal(true)
	panel.cw:SetSpacing(10)
	panel.cw.IgnoreVbar = true

	WankButton(panel.cw, "Все товары", function()
		panel.Canvas.Update()
	end, 1)

	WankButton(panel.cw, "О нас", function()
		panel.Canvas.UsHere()
	end, 1)

	panel.Canvas = vgui.Create("MSDPanelList", panel)
	panel.Canvas:SetSize(w - 355, h - 265)
	panel.Canvas:SetPos(5, 60)
	panel.Canvas:EnableVerticalScrollbar()
	panel.Canvas:EnableHorizontal(true)
	panel.Canvas:SetSpacing(1)
	panel.Canvas.IgnoreVbar = true

	panel.Canvas.Update = function()
		panel.Canvas:Clear()

		if LocalPlayer():Team() ~= 10 then
			local pn = vgui.Create("DPanel")
			pn.StaticScale = {
				w = 1,
				fixed_h = 120,
				minw = 300,
				minh = 48
			}
			pn.Paint = function(self, wd, ht)
				draw.DrawText(MSD.TextWrap("Раздел недоступен.\n\nВ данный момент, все интервалы доставки заняты. Попробуйте заказать в другое время..", "MSDFontB.28", wd - 15), "MSDFontB.28" , 10, 5, color_white, TEXT_ALIGN_LEFT)
			end
			panel.Canvas:AddItem(pn)
			return
		end

		WankHeader(panel.Canvas, "Товары")

		for k, v in SortedPairsByMemberValue(DarkRP.Food, "name") do
			if v.shop ~= "shop" then continue end
			if v.noweb then continue end

			local icon = vgui.Create("DButton")
			icon.StaticScale = {
				w = 1,
				fixed_h = 64,
				minw = 64,
				minh = 48
			}
			icon:SetSize(w, h)
			icon.Paint = function(self, wd, hd)
				draw.RoundedBox(0, 0, 0, wd, hd, mcl)
				draw.RoundedBox(0, 0, 0, 64, hd, scl)
				draw.DrawText(v.name, self.hover and "MSDFontB.28" or "MSDFont.28", 80, 16, color_black, TEXT_ALIGN_LEFT)
				MSD.DrawTexturedRect(8, 8, 48, 48, McINV.Icons[v.class] or MSD.IconRender.Get(v.model or "models/props_junk/CinderBlock01a.mdl", v.material, v.submat), color_white)
				return true
			end
			icon.DoClick = function(s)
				panel.Canvas.BuyItem(k,v)
			end
			icon.OnCursorEntered = function(self) self.hover = true end
			icon.OnCursorExited = function(self) self.hover = false end

			panel.Canvas:AddItem(icon)
		end
	end

	panel.Canvas.UsHere = function()
		panel.Canvas:Clear()

		WankInfoText(panel.Canvas, ltext, "MSDFontB.25")
	end

	panel.Canvas.BuyItem = function(k, v)
		panel.Canvas:Clear()
		WankHeader(panel.Canvas, v.name, function()
			panel.Canvas.Update()
		end)
		local icon = vgui.Create("DPanel")
		icon.StaticScale = {
			w = 1,
			fixed_h = 200,
			minw = 200,
			minh = 48
		}
		icon:SetSize(w, h)
		icon.Paint = function(self, wd, hd)
			draw.DrawText(v.name, "MSDFontB.28", 64, 4, color_white, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(8, 8, 48, 48, McINV.Icons[v.class] or MSD.IconRender.Get(v.model or "models/props_junk/CinderBlock01a.mdl", v.material, v.submat), color_white)
			if desc[k] then
				draw.DrawText(MSD.TextWrap(desc[k], "MSDFont.24", wd - 64), "MSDFont.24", 64, 32, color_white, TEXT_ALIGN_LEFT)
			end
		end
		panel.Canvas:AddItem(icon)

		local price = McINV.Tax(v.price)
		WankButton(panel.Canvas, "Купить 5 штук $" .. price * 5, function()
			DarkRP.PlayerBuyItem(nil, "Food", k, 5, true)
			panel.Canvas.Update()
		end)
		WankButton(panel.Canvas, "Купить 20 штук $" .. price * 20, function()
			DarkRP.PlayerBuyItem(nil, "Food", k, 20, true)
			panel.Canvas.Update()
		end)
	end

	panel.Canvas.Update()
end