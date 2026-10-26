--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/msdf4menu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local last = 0
local help_text = {
	[1] = [[На сервере, в отличие от классического выбора профессий через меню, устройство на работу происходит через NPC в бизнес-центре. Также существует временная подработка - её выдают разные персонажи в городе, такие как продавцы на заправках.

Нажмите на кнопку ниже, чтобы показать расположение бизнес-центра.]],
	[2] = [[На сервере, в отличие от классического выбора профессий через меню, устройство на работу происходит через NPC.

Нажмите на кнопку ниже, чтобы показать расположение NPC для устройства на гос службу.]],
	[3] = [[Нелегалу, в отличие от остальных типов персонажей, нельзя брать официальную и легальную работу. Зато они могут свободно выбирать между незаконной деятельностью, без привязки к профессиям: кого-нибудь грабить, выращивать наркотики, синтезировать их на лабораторном столе и так далее. Для помощи в этом, нелегалам доступны уникальные предметы для покупки в магазине хоз. товаров.

Нажмите на кнопку ниже, чтобы показать расположение этого магазина.]],
	[4] = [[На сервере, в отличие от классической покупки предметов через меню, их приобретение происходит через NPC в магазинах. Часть магазинов расположена в городе и на заправках, а часть - в интернете. Интернет и GPS доступны через телефон.

Телефон достаётся на стрелку вверх. Дополнительно о телефоне можно узнать в меню F1.]]
}

local donate_text = "Наш проект, как и любые другие проекты, нуждается в материальной поддержке! Благодаря вашей помощи, мы можем спокойно арендовать оборудование для игровых серверов и совершенствовать проект в целом.\nВ качестве благодарности, мы готовы предоставить вам особые услуги и привилегии.\n \nЧтобы получить кредиты, нажмите на кнопку 'Пожертвовать проекту', и на зелёную кнопку возле баланса сразу после пополнения.\n \nКредиты зачисляются на баланс в течение 5 минут. Если по истечении времени они не пришли - нажмите на зелёную кнопку возле баланса ещё раз.\nВ противном случае, обратитесь к администратору."
local star = Material("gmodla/star2.png", "smooth")
local glass = Material("gmodla/glass.png", "smooth")

function MSD.AdminRequest()
	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 3, SH - SH / 5

	local type = 1
	local reason = ""

	local pframe = vgui.Create("MSDSimpleFrame")
	pframe:SetSize(SW, SH)
	pframe:SetDraggable(false)
	pframe:Center()
	pframe:MakePopup()
	pframe:SetAlpha(1)
	pframe:AlphaTo(255, 0.3)
	pframe.Think = function(self)
		if input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end

	pframe.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Связь с администрацией", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	MSD.CloseButtonIcon(pframe, SW - 160, 5, 150, 40, "Закрыть", function()
		pframe:Close()
	end)

	local plist = vgui.Create("MSDPanelList", pframe)
	plist:SetSize(SW - 10, SH - 55)
	plist:SetPos(5, 55)
	plist:EnableVerticalScrollbar()
	plist:EnableHorizontal(true)
	plist:SetSpacing(2)
	plist.sliderColor = Color(252, 81, 1, 70)
	plist.IgnoreVbar = true

	local totalStaffOnline = 0

	for k, v in ipairs(player.GetAll()) do
		if sAdmin.hasPermission(v, "is_staff") then
			totalStaffOnline = totalStaffOnline + 1
		end
	end

	if totalStaffOnline < 2 then
		MSD.InfoTextIcon(plist, "Загруженная администрация", "В данный момент мало свободных администраторов. Ответ на заявки может занимать продолжительное время. Ради гарантированного ответа на вашу заявку, оставьте её у нас на сайте.", MSD.PinPoints[43], MSD.Config.MainColor["p"])
		MSD.Button(plist, "static", nil, 1, 45, "Перейти на сайт", function()
			gui.OpenURL("https://gmodla.ru/help")
		end)
	end

	MSD.InfoTextF1(plist, "Выберите категорию обращения и подробно опишите вашу проблему/вопрос. Вопросы и проблемы нужно описывать полностью в поле ниже. Вопросы с содержанием \"У меня вопрос\" будут сразу отклоняться.", plist:GetWide() - 5)

	local note = MSD.InfoTextIcon(plist, "Внимание!", "Ситуации, требующие длительного разбирательства, разбираются только через раздел помощи на сайте проекта.", MSD.PinPoints[43], MSD.Config.MainColor["p"])
	note.hidden = true

	local combo = MSD.ComboBox(plist, "static", nil, 1, 50, "Тема вызова:", MSD.AdminReasons[1])
	combo.OnSelect = function(_, id, _, data)
		type = data

		if id == 4 or id == 5 then
			note.hidden = false
		else
			note.hidden = true
		end

		timer.Simple(0.01, function() if IsValid(plist) then plist:InvalidateLayout() end end)
	end

	for k, v in pairs(MSD.AdminReasons) do
		combo:AddChoice(v, k)
	end

	local te = MSD.TextEntry(plist, "static", nil, 1, SH / 3, "Опишите причину вызова", "", "", function(s, val)
		reason = val or ""
	end, true, nil, true)

	MSD.InfoTextF1(plist, "В случае неадекватно заполненного обращения, вы можете быть наказаны.", plist:GetWide() - 5)

	MSD.Button(plist, "static", nil, 1, 45, "Отправить запрос", function()
		if utf8.len(reason) < 10 then
			te.error = ""
			return
		end

		net.Start("sA:ApplyToAdmin")
			net.WriteUInt(type, 3)
			net.WriteString(reason)
		net.SendToServer()
		pframe:Remove()
	end)
end

local karmastates = {
	{"Крепкий", 170},
	{"Стабильный", 130},
	{"В норме", 80},
	{"Расшатанный", 50},
	{"Сломанный", 20},
	{"Разбитый", 0},
}

local showstats = {
	["bleeding"] = {"Кровотечение", MSD.Icons48.heart_broken},
	["fracture"] = {"Перелом ноги", MSD.Icons48.heart_broken},
	["fracturearm"] = {"Перелом руки", MSD.Icons48.heart_broken},
	["alcohol"] = {"Опьянение", MSD.Icons48.beer},
	["stamina"] = {"Энергичность", MSD.Icons48.lightning},
	["hunger"] = {"Сытость", MSD.Icons48.silverware},
	["meds3"] = {"Лечение", MSD.Icons48.bottle_tonic_plus},
	["relax"] = {"Под воздействием", MSD.Icons48.hand_okay},
	["focus"] = {"Концентрация", MSD.Icons48.meditation},
	["addict"] = {"Зависимость", MSD.PinPoints[42], function()
		return not LocalPlayer():getDarkRPVar("relax")
	end},
	["cold"] = {"Обморожение", MSD.Icons48.snowflake, function()
		return LocalPlayer():getDarkRPVar("cold") > 0
	end},
	["nausea"] = {"Тошнота", MSD.Icons48.food_off},
	["shock"] = {"Дезориентация", MSD.Icons48.alert},
	["toxity"] = {"Отравление", MSD.Icons48.biohazard, function()
		return LocalPlayer():getDarkRPVar("toxity") > 0
	end},
}

local function getCosmetic(id, el)
	if MCR.Cosmetics[el] and MCR.Cosmetics[el][id] then
		return MCR.Cosmetics[el][id].name
	end

	if DarkRP.Junk[id] then
		return DarkRP.Junk[id].name
	end

	return id
end

local function getCosmeticIcon(id, el)
	if MCR.Cosmetics[el] and MCR.Cosmetics[el][id] and MCR.Cosmetics[el][id].icon then
		return MCR.Cosmetics[el][id].icon
	end

	if DarkRP.Junk[id] then
		local item = DarkRP.Junk[id]
		return MSD.IconRender.Get(item.model or "models/props_junk/CinderBlock01a.mdl", item.material, item.submat, item.color)
	end

	return MSD.Icons48.drama_masks_custom
end

function MSD.CosmeticItem(parent, item, icon, icon2, func, order, nobut)
	local button = vgui.Create("DPanel")
	button:SetSize(100, 60)

	button.StaticScale = {
		w = 1,
		fixed_h = 60,
		minw = 250,
		minh = 60
	}

	button.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
		MSDX.Draw(0, 0, 0, 5, h, MSD.Patern.MainColor["p"])
		draw.DrawText(item, "MSDFont.22", h + 15, 5, MSD.Text.s, TEXT_ALIGN_LEFT)

		MSD.DrawTexturedRect(10, 5, h - 10, h - 10, icon2, color_white)

		if not icon or nobut then
			MSD.DrawTexturedRect(0, 0, w, h, glass, color_white)
			return
		end
	end

	if not nobut then
		local but_main = MSD.IconButton(button, icon or MSD.Icons48.menu, 5, 5, 46, nil, nil, func)
		but_main:DockMargin(14, 14, 14, 14)
		but_main:DockPadding(14, 14, 14, 14)
		but_main:Dock(RIGHT)
		but_main:SetSize(32, 32)
	end

	if order then
		parent:InsertAfter(order, button)
	else
		parent:AddItem(button)
	end

	return button
end

local armorIcons = {
	[1] = Material("gmodla/icons/armor1.png", "smooth"),
	[2] = Material("gmodla/icons/armor2.png", "smooth"),
	[3] = MSD.Icons48.dot
}

local armorName = {
	[1] = "Бронежилет",
	[2] = "Бронежилет",
	[3] = "Спецкостюм"
}

function MSD.OpenF4Menu(start)
	if IsValid(DarkRP.Scoreboard) then return end

	if IsValid(MSD.F4Menu) then
		MSD.F4Menu:Remove()
		return
	end

	local ply = LocalPlayer()
	local SW, SH = ScrW(), ScrH()
	local hs = 440
	local openPage
	local pages = {}
	local buttons = {
		{"Профиль персонажа", MSD.Icons48.account, function() openPage("player", 3, nil, true) end},
		{"Действия", MSD.Icons48.hand_right, function() openPage("commands", 3, nil, true) end},
		{"Инвентарь", MSD.Icons48.briefcase, function() openPage("inventory", 3, nil, true) end},
		{"Внешний вид", MSD.Icons48.redhat_custom, function() openPage("hats", 3, nil, true) end},
		{"Работы", MSD.Icons48.file_document, function() openPage("job", 3, nil, true) end},
		{"Магазин", MSD.Icons48.basket, function() openPage("shop", 3, nil, true) end}
	}

	MSD.F4Menu = vgui.Create("MSDSimpleFrame")
	MSD.F4Menu:SetSize(SW - 20, SH - SH / 6)
	MSD.F4Menu:SetPos(15, 15)
	MSD.F4Menu:SetAlpha(1)
	MSD.F4Menu:AlphaTo(255, 0.5)
	MSD.F4Menu:MakePopup()
	MSD.F4Menu.Paint = function(s, w, h)
		MSD.Blur(s, 2, 2, 255, 0, hs, h)
		MSDX.Draw(0, 0, 0, hs, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, hs, 120, MSD.Theme.d)
		MSD.DrawTexturedRect(hs / 2 - 146, 0, 293, 118, MSD.Materials.logo, color_white)
	end
	MSD.F4Menu.Think = function(self)
		if not ply:IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) or (input.IsKeyDown(KEY_F4) and self:GetAlpha() > 250) then
			self:Remove()
		end
	end

	local menu = MSD.F4Menu

	menu.ClearPage = function(ss, popup, canvas)
		if IsValid(menu.page) then
			menu.page:Remove()
		end

		menu.page = vgui.Create("DPanel", menu)
		menu.page:SetSize(math.Clamp((SW - 30 - hs) / ss, 480, 600), menu:GetTall())
		menu.page:SetPos(hs + 15, 0)
		menu.page:SetAlpha(1)
		menu.page:AlphaTo(255, 0.5)
		menu.page.Paint = function(s, w, h)
			MSD.Blur(s, 2, 2, 255, 0, w, h)
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		end
		if canvas then
			menu.canvas = vgui.Create("MSDPanelList", menu.page)
			menu.canvas:SetSize(menu.page:GetWide(), menu.page:GetTall())
			menu.canvas:SetPos(0, 0)
			menu.canvas:SetSpacing(2)
			menu.canvas:SetPadding(0)
			menu.canvas:EnableVerticalScrollbar()
			menu.canvas:EnableHorizontal(true)
		end
	end

	function openPage(id, ss, popup, canvas, ...)
		menu.ClearPage(ss, popup, canvas)
		back_page = cur_page
		pages[id](...)
		cur_page = id
	end

	menu.list = vgui.Create("MSDPanelList", menu)
	menu.list:SetSize(hs, menu:GetTall() - 125)
	menu.list:SetPos(0, 120)
	menu.list:EnableVerticalScrollbar()
	menu.list:SetSpacing(2)
	menu.list:SetPadding(0)
	menu.list.IgnoreVbar = true
	menu.list.Deselect = function(but)
		if not but then return end
		but.hovered = true

		for k, v in pairs(menu.list:GetItems()) do
			if v and v:IsValid() and v ~= but then
				v.hovered = false
			end
		end
	end

	local cur_char = ply:getDarkRPVar("character") or 1

	pages["player"] = function()
		local karma = LocalPlayer():getDarkRPVar("karma") or 0
		local sanity = ""
		for _, v in ipairs(karmastates) do
			if karma >= v[2] then
				sanity = v[1]
				break
			end
		end

		local panel = vgui.Create("DPanel")
		panel.StaticScale = { w = 1, fixed_h = 95, minw = 250, minh = 95 }
		panel.Paint = function(self, w, h)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
			local s = draw.SimpleText(ply:FullName(), "MSDFont.32", 10, 5, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(MCR.Config.Texts[cur_char].name, "MSDFont.26", 15 + s, 9, MSD.Text["l"], TEXT_ALIGN_LEFT)
			if cur_char == 3 then
				draw.SimpleText("Нет контрактов", "MSDFont.24", 10, 38, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			else
				s = draw.SimpleText("Контракт: ", "MSDFont.24", 10, 38, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
				draw.DrawText(ply:getDarkRPVar("job"), "MSDFont.24", 10 + s, 38, MSD.Text["l"], TEXT_ALIGN_LEFT)
			end

			s = draw.SimpleText("Рассудок: ", "MSDFont.24", 10, 62, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(sanity, "MSDFont.24", s + 10, 62, MSD.Text["l"], TEXT_ALIGN_LEFT)
		end
		menu.canvas:AddItem(panel)

		if not McPhone.HasPhone(LocalPlayer()) then
			MSD.InfoTextF1(menu.canvas, "У вас нет телефона. Для доступа к основному функционалу связи, вам нужно купить телефон в магазине.", menu.canvas:GetWide() - 5)
		end

		MSD.InfoHeader(menu.canvas, "Здоровье")

		MSD.PanelIcon(menu.canvas, "", MSD.Icons48.heart, function(s, w, h)
			s.text = "Общее здоровье: " .. LocalPlayer():Health() .. "%"
		end)

		MSD.PanelIcon(menu.canvas, "", MSD.Icons48.cup, function(s, w, h)
			s.text = "Уровень воды: " .. LocalPlayer():getDarkRPVar("thirst")
		end)

		MSD.PanelIcon(menu.canvas, "", MSD.Icons48.apple, function(s, w, h)
			s.text = "Калории: " .. LocalPlayer():getDarkRPVar("energy")
		end)

		for k,v in pairs(showstats) do
			if not LocalPlayer():getDarkRPVar(k) or (v[3] and not v[3]()) then continue end
			MSD.PanelIcon(menu.canvas, v[1], v[2])
		end

		local tattoos = MCR.GetTatoos(LocalPlayer())

		if tattoos then
			MSD.InfoHeader(menu.canvas, "Татуировки (навыки)")

			for k,_ in pairs(tattoos) do
				if not MCR.Tatoo[k] then continue end
				MSD.PanelIcon(menu.canvas, MCR.Tatoo[k][1], MSD.Icons48.dot)
			end
		end
	end

	local listcheck = {
		"face",
		"head",
		"vest",
	}

	pages["hats"] = function()
		local stats = {
			["head"] = LocalPlayer():getDarkRPVar("head"),
			["face"] = LocalPlayer():getDarkRPVar("face"),
			["armorVest"] = LocalPlayer():getDarkRPVar("armorVest"),
			["vest"] = LocalPlayer():getDarkRPVar("vest"),
		}

		local item1, item2, item3
		local items = {}
		local function insert(element, order)
			if items[element] then
				for _, v in pairs(items[element]) do
					menu.canvas:RemoveItem(v)
				end

				items[element] = nil
				return
			end

			items[element] = {}

			for k,v in pairs(MCR.Cosmetics[element]) do
				if not v.check(LocalPlayer()) or not MCR.CanEquipCosmetics(LocalPlayer(), element, k) then continue end

				local item = MSD.CosmeticItem(menu.canvas, v.name, MSD.Icons48.download, getCosmeticIcon(k, element), function()
					RunConsoleCommand("mcr_puton", element, k)
				end, order)

				table.insert(items[element], item)
			end
		end

		MSD.Header(menu.canvas, "Внешний вид", nil, nil, nil, function(s, w, h)
			if s.next and s.next > CurTime() then return end
			s.next = CurTime() + 0.3
			for _,v in ipairs(listcheck) do
				if stats[v] ~= LocalPlayer():getDarkRPVar(v) then openPage("hats", 3, nil, true) end
			end
		end)

		MSD.InfoHeader(menu.canvas, "Голова")
		item1 = MSD.CosmeticItem(menu.canvas, stats["head"] and getCosmetic(stats["head"], "head") or "Пусто", stats["head"] and MSD.Icons48.hand_extended, stats["head"] and getCosmeticIcon(stats["head"], "head") or MSD.Icons48.redhat_custom, function()
			if stats["head"] then
				RunConsoleCommand("remove_vest", "2")
				return
			else
				insert("head", item1)
			end
		end)

		MSD.InfoHeader(menu.canvas, "Лицо")
		item2 = MSD.CosmeticItem(menu.canvas, stats["face"] and getCosmetic(stats["face"], "face") or "Пусто", stats["face"] and MSD.Icons48.hand_extended, stats["face"] and getCosmeticIcon(stats["face"], "face") or MSD.Icons48.glasses, function()
			if stats["face"] then
				RunConsoleCommand("remove_vest", "3")
				return
			else
				insert("face", item2)
			end
		end)

		MSD.InfoHeader(menu.canvas, "Торс")
		item3 = MSD.CosmeticItem(menu.canvas, (stats["armorVest"] and armorName[stats["armorVest"]]) or (stats["vest"] and getCosmetic(stats["vest"], "vest")) or "Пусто", (stats["armorVest"] or stats["vest"]) and MSD.Icons48.hand_extended, (stats["armorVest"] and armorIcons[stats["armorVest"]]) or (stats["vest"] and getCosmeticIcon(stats["vest"], "vest")) or MSD.Icons48.tshirt_crew_custom, function()
			if stats["armorVest"] or stats["vest"] then
				RunConsoleCommand("remove_vest", "1")
				return
			else
				insert("vest", item3)
			end
		end)
	end

	pages["commands"] = function()
		local panel = vgui.Create("DPanel")
		panel.StaticScale = { w = 1, fixed_h = 35, minw = 250, minh = 35 }
		panel.Paint = function(self, w, h)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
			local money = LocalPlayer():getDarkRPVar("money") or 0
			local sal = LocalPlayer():getDarkRPVar("salary") or 0
			local s = draw.SimpleText("Деньги: ", "MSDFont.24", 5, 5, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(string.Comma(money) .. "$" .. (sal > 0 and " + " .. string.Comma(sal) .. "$" or ""), "MSDFont.24", s + 5, 5, MSD.Text["l"], TEXT_ALIGN_LEFT)
		end
		menu.canvas:AddItem(panel)

		MSD.InfoHeader(menu.canvas, "Деньги")

		if sAdmin.mcTime(LocalPlayer()) < MCR.Config.TimeNeed[3] then
			MSD.InfoTextIcon(menu.canvas, "Внимание", "При ограблении, вы не обязаны давать деньги грабителю - он может забрать кошелёк самостоятельно.", MSD.PinPoints[43], MSD.Config.MainColor["p"])
		end

		local me = MSD.TextEntry(menu.canvas, "static", nil, 1, 45, "Введите сумму", "", "", function(s, val)
			val = tonumber(val) or 0
			RunConsoleCommand("say", "/dropmoney " .. val)
			menu:Remove()
		end, nil, nil, nil, true)

		MSD.ButtonIcon(menu.canvas, "static", nil, 2, 45, "Бросить", MSD.Icons48.cash, function() RunConsoleCommand("say", "/dropmoney " .. (tonumber(me:GetValue()) or 0)) menu:Remove() end)
		MSD.ButtonIcon(menu.canvas, "static", nil, 2, 45, "Передать", MSD.Icons48.hand_coin, function() RunConsoleCommand("say", "/givemoney " .. (tonumber(me:GetValue()) or 0)) menu:Remove() end)

		MSD.InfoHeader(menu.canvas, "Оружие")
		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Выбросить оружие из рук", MSD.Icons48.pistol_remove, function() RunConsoleCommand("say", "/drop") menu:Remove() end)

		local hasHidden = false
		for _, wep in ipairs(LocalPlayer():GetWeapons()) do
			if wep:GetNWBool("HiddenWep") then hasHidden = true break end
		end

		if hasHidden or (not MCR.HasTatoo(LocalPlayer(), "a1") and not DarkRP.IsUniformPolice(LocalPlayer())) then
			MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, hasHidden and "Достать оружие" or "Скрыть оружие", hasHidden and MSD.Icons48.eye or MSD.Icons48.eye_off_custom, function() RunConsoleCommand("hide_weapon") menu:Remove() end)
		end

		MSD.InfoHeader(menu.canvas, "Документы")

		local docs = {
			{"Паспорт", function() RunConsoleCommand("show_pass", "passport") menu:Remove() end, function() DarkRP.OpenPassport(LocalPlayer()) menu:Remove() end},
		}

		for k,v in pairs(McINV.inv["junk"]) do
			if v.class ~= "doc" or not v.docid then continue end
			table.insert(docs, {v.name, function()
				RunConsoleCommand("show_pass", "inv", k) menu:Remove() end,
			function()
				DarkRP.LoadDock(v.docid)
				menu:Remove()
			end})
		end

		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Показать документ", MSD.Icons48.badge_account_horizontal, function(s)
			if (IsValid(s.Menu)) then
				s.Menu:Remove()
				s.Menu = nil
			end
			s.Menu = MSD.MenuOpen(true, s)
			for k,v in pairs(docs) do
				s.Menu:AddOption(v[1], v[2])
			end
			local x, y = s:LocalToScreen(0, s:GetTall())
			s.Menu:SetMinimumWidth(s:GetWide())
			s.Menu:Open(x, y, false, s)
		end)
		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Просмотреть документ", MSD.PinPoints[17], function(s)
			if (IsValid(s.Menu)) then
				s.Menu:Remove()
				s.Menu = nil
			end
			s.Menu = MSD.MenuOpen(true, s)
			for k,v in pairs(docs) do
				s.Menu:AddOption(v[1], v[3])
			end
			local x, y = s:LocalToScreen(0, s:GetTall())
			s.Menu:SetMinimumWidth(s:GetWide())
			s.Menu:Open(x, y, false, s)
		end)

		if MRS.GetNWdata(LocalPlayer(), "Group") then
			table.insert(docs, {"Удостоверение " .. MRS.GetNWdata(LocalPlayer(), "Group"), function() RunConsoleCommand("show_pass", "mrs") menu:Remove() end, function() DarkRP.OpenPDid(LocalPlayer()) menu:Remove() end})
			MSD.InfoHeader(menu.canvas, "Профессия")
			MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, LocalPlayer():getDarkRPVar("showrank") and "Показать свой ранг" or "Скрыть свой ранг", LocalPlayer():getDarkRPVar("showrank") and MSD.Icons48.eye or MSD.Icons48.eye_off_custom, function() RunConsoleCommand("show_rank") menu:Remove() end)
			MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Управление рангами", MSD.Icons48.playlist_edit, function() RunConsoleCommand("mrs_rankmenu") menu:Remove() end)
		end

		MSD.InfoHeader(menu.canvas, "Другое")
		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, IsValid(DarkRP.LocalMM) and "Выключить мини-карту" or "Включить мини-карту", MSD.PinPoints[21], function() RunConsoleCommand("minimap") menu:Remove() end)
		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Передать свой номер игроку", MSD.Icons48.cellphone_text, function() RunConsoleCommand("say", "/givenumber") menu:Remove() end)
		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Меню действий", MSD.Icons48.menu, function() openPage("f2cmd", 3, nil, true) end)

		MSD.InfoHeader(menu.canvas, "Мир")
		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Осмотреться", MSD.PinPoints[17], function() chat.AddText( DarkRP.Hud.Patern["red"], "[!] ", DarkRP.Hud.Patern["main_l"], "Осмотр у вас на клавишу - ", DarkRP.Hud.Patern["red"], input.LookupBinding( "+zoom" ) ) menu:Remove() end)
		MSD.TextEntry(menu.canvas, "static", nil, 1, 45, "", "Описание предмета", "", function(s, val)
			RunConsoleCommand("say", "/it " .. val)
		end)
	end

	pages["f2cmd"] = function()
		menu.canvas.Page = {}

		menu.canvas.Close = function()
			menu.canvas.OpenPage("main")
		end

		menu.canvas.OpenPage = function(id)
			menu.canvas:Clear()
			MSD.Header(menu.canvas, "Меню действий")

			MSD.ButtonIcon(menu.canvas, "static", nil, 1, 60, "Назад", MSD.Icons48.arrow_left, function()
				if id ~= "main" then
					menu.canvas.OpenPage("main")
				else
					openPage("commands", 3, nil, true)
				end
			end)

			page = menu.canvas.Page[id]
			if not page then return end

			for _, p in ipairs(page) do
				MSD.ButtonIcon(menu.canvas, "static", nil, 1, 60, p[1], p[3] or MSD.Icons48.dot, function()
					p[2]()
				end)
			end
		end

		MSD.SetUpF2Pages(menu.canvas)

		menu.canvas.OpenPage("main")
	end
	local sort = true
	pages["inventory"] = function()
		McINV.InventoryUI = menu.canvas
		menu.canvas.Update = function()
			menu.canvas.stacks = {}
			menu.canvas:Clear()
			MSD.Header(menu.canvas, "Ваш инвентарь - " .. McINV.GetSpace(McINV.inv) .. " / " .. LocalPlayer():GetDefaultSpace() .. " кг", function()
				sort = not sort
				openPage("inventory", 3, nil, true)
			end, sort and MSD.Icons48.card_multiple_outline or MSD.Icons48.card_multiple, nil, function(s, w, h)
				local pr = McINV.GetSpace(McINV.inv) / LocalPlayer():GetDefaultSpace()
				MSDX.Draw(0, 0, h - 5, w, 5, MSD.Patern.MainColor["9"])
				MSDX.Draw(0, 0, h - 5, w * pr, 5, MSD.Patern.MainColor.p)
			end)
			for type,ilist in pairs(McINV.inv) do
				for id, item in pairs(ilist) do
					local ent = McINV.GetItem(type, item.class, item)

					if sort and type ~= INV_WEAPON and item.dt and item.name and menu.canvas.stacks[item.name] then
						menu.canvas.stacks[item.name].count = menu.canvas.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
						continue
					end

					local pickup = function(self)
						RunConsoleCommand("Inventory.Drop", type, id, "1")
					end
					local combine

					if item.dt and item.dt.Ammo and item.ammo and item.dt.Ammo < item.ammo then
						combine = function(self)
							RunConsoleCommand("Inventory.SwapMag", item.class, id)
						end
					end

					local btn = McINV.InventoryItem(menu.canvas, ent, type, item, function(self)
						RunConsoleCommand("Inventory.Drop", type, id)
					end, type ~= INV_AMMO and pickup or combine, nil, type == INV_AMMO and MSD.Icons48.reload or MSD.Icons48.hand_right, function()
						RunConsoleCommand("Inventory.Drop", type, id, " ", 1)
					end)

					if sort and type ~= INV_WEAPON and item.name then
						menu.canvas.stacks[item.name] = btn
					end
				end
			end
		end

		menu.canvas:Update()
	end

	pages["job"] = function()
		MSD.Header(menu.canvas, "Где можно получить работу?")
		MSD.InfoTextF1(menu.canvas, help_text[cur_char], menu.canvas:GetWide() - 5)

		if cur_char == 1 then
			MSD.Button(menu.canvas, "static", nil, 1, 50, "Устроиться на работу", function()
				McPhone.ToggleGPS("Бизнес-центер", Vector(-1355.96875,5047.5419921875,-103.96875))
				menu:Remove()
			end)
		end

		if cur_char == 2 then
			MSD.Button(menu.canvas, "static", nil, 1, 50, "Встать на смену за полицию", function()
				McPhone.ToggleGPS("Встать на смену", Vector(8750.96875,7603.8540039063,-439.96875))
				menu:Remove()
			end)
		end

		if cur_char == 3 then
			MSD.Button(menu.canvas, "static", nil, 1, 50, "Магазин хоз. товаров", function()
				McPhone.ToggleGPS("Магазин хоз. товаров", Vector(1343.0473632813,-1487.96875,-95.96875))
				menu:Remove()
			end)
		end
	end

	pages["shop"] = function()
		MSD.Header(menu.canvas, "Где можно купить предметы?")
		MSD.InfoTextF1(menu.canvas, help_text[4], menu.canvas:GetWide() - 5)

		MSD.Button(menu.canvas, "static", nil, 1, 50, "Заправка - порт", function()
			McPhone.ToggleGPS("Заправка", Vector(-5920.5034179688,1410.6290283203,-22.96875))
			menu:Remove()
		end)

		MSD.Button(menu.canvas, "static", nil, 1, 50, "Заправка 7/12", function()
			McPhone.ToggleGPS("Заправка 7/12", Vector(532.03125,14005.717773438,128.03125))
			menu:Remove()
		end)

		MSD.Button(menu.canvas, "static", nil, 1, 50, "Магазин хоз. товаров", function()
			McPhone.ToggleGPS("Магазин хоз. товаров", Vector(1343.0473632813,-1487.96875,-95.96875))
			menu:Remove()
		end)

		if McPhone.HasPhone(LocalPlayer()) then
			MSD.Button(menu.canvas, "static", nil, 1, 50, "Открыть телефон", function()
				if not IsValid(McPhone.UI) then
					McPhone.LoadAddons()
					McPhone.Open(1)
				end
				menu:Remove()
			end)
		else
			MSD.InfoTextF1(menu.canvas, "Телефон предварительно нужно купить в одном из магазинов на заправке.", menu.canvas:GetWide() - 5)
		end
	end

	for k, v in pairs(buttons) do
		local button = MSD.MenuButton(menu.list, v[2], nil, nil, 250, 50, v[1], function(self)
			menu.list.Deselect(not v[5] and self or false)
			v[3]()
			last = k
		end)

		if v[4] or last == k then
			menu.list.Deselect(button)
			v[3]()
		end
	end

	MSD.MenuButton(menu.list, MSD.PinPoints[55], nil, nil, 250, 50, "Особые услуги", function(self)
		menu:Remove()
		MSD.OpenDonate()
	end)

	MSD.MenuButton(menu.list, MSD.Icons48.account_convert, nil, nil, 250, 50, "Сменить персонажа", function(self)
		RunConsoleCommand("mcr_change")
		menu:Remove()
	end)

	MSD.MenuButton(menu.list, MSD.PinPoints[45], nil, nil, 250, 50, "Позвать администратора", function(self)
		menu:Remove()
		MSD.AdminRequest()
	end)
end
concommand.Add("gmodla_f4", MSD.OpenF4Menu)

local function MakeGBUpdateButton(parent, x, y, func)
	local bgfade = 0
	local rotate = 0
	local rot_timer = 0
	local button = vgui.Create("DButton", parent)
	button:SetPos(x, y)
	button:SetSize(32, 32)
	button:SetText("")
	button.rotate = false

	button.Paint = function(self, w, h)
		if self.hover then
			bgfade = Lerp(FrameTime() * 5, bgfade, 150)
		else
			bgfade = Lerp(FrameTime() * 5, bgfade, 0)
		end

		if self.rotate and rot_timer < CurTime() then
			self.rotate = false
		end

		rotate = Lerp(FrameTime() * 0.1, rotate, 530)

		if self.rotate then
			surface.SetMaterial(MSD.Icons48.cached)
			surface.SetDrawColor(100, 200, 0, 255)
			surface.DrawTexturedRectRotated(16, 16, 32, 32, (rotate * 3) % 360)
		else
			surface.SetMaterial(MSD.Icons48.cached)
			surface.SetDrawColor(100, 200, 0, 255 - (150 - bgfade))
			surface.DrawTexturedRectRotated(16, 16, 32, 32, 0)
		end
	end

	button.DoClick = function(self)
		if self.rotate then return end
		func(self)
		rot_timer = CurTime() + 6
		self.rotate = true
		rotate = 0
	end

	button.DoRightClick = function(self)
		if self.rotate then return end
		func(self)
		rot_timer = CurTime() + 6
		self.rotate = true
		rotate = 0
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	return button
end

local function ItemPanel(parent, icon, name, rotate, color, func, ics, block, fs)
	local button = vgui.Create("DButton")
	button:SetText("")
	button.StaticScale = {
		w = 1,
		h = 5,
		minw = 200,
		minh = 150
	}
	button.alpha = 0
	button.priceIcon = " ¤"
	button.color_idle = color_white
	local icons = 150
	button.Paint = function(self, wd, hd)
		if self.hover and not self.disable then
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 0)
		end

		MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, hd, MSD.Theme["d"])

		if block then
			MSD.DrawTexturedRect(0, 0, wd, hd, glass, color_white)
			draw.DrawText(self.blocktext or "Предмет был разблокирован вами или временно недоступен", "MSDFont.22", 20 + icons, 40, MSD.Text.d, TEXT_ALIGN_LEFT)
		end

		if self.alpha > 0.01 then
			MSDX.Draw(MSD.Config.Rounded, 0, 0, self.alpha * (15 + icons), hd, MSD.Theme["d"])
			draw.DrawText(name, "MSDFont.36", 20 + icons, 5, MSD.ColorAlpha(color or MSD.Config.MainColor["p"], self.alpha * 255), TEXT_ALIGN_LEFT)
		end

		local isz = ics and 80 or 48

		if fs then
			isz = hd
		end

		MSD.DrawTexturedRectRotated(rotate and CurTime() * 25 % 360 or 0, hd / 2 + 5, hd / 2, hd - 10, hd - 10, star, MSD.ColorAlpha(color, 55))
		MSD.DrawTexturedRectRotated(rotate and -(CurTime() * 25 % 360) or 0, hd / 2 + 5, hd / 2, hd - 50, hd - 50, star, MSD.ColorAlpha(color, 55))

		if type(icon) == "IMaterial" then
			MSD.DrawTexturedOutlined(hd / 2 + 5 - isz / 2, hd / 2 - isz / 2, isz, isz, icon, ics and color_white or color, 1, color_black)
		end
		local sp = draw.SimpleText(name, "MSDFont.36", 20 + icons, 5, MSD.ColorAlpha(self.color_idle, 255 - self.alpha * 255), TEXT_ALIGN_LEFT)

		if block then
			return
		end

		if self.Price then
			local sps = draw.SimpleText(string.Comma(math.Round(self.Price)) .. self.priceIcon, "MSDFontB.24", wd - 5, hd - 30, color, TEXT_ALIGN_RIGHT)
			if self.Old_Price then
				local line = draw.SimpleText(string.Comma(math.Round(self.Old_Price)), "MSDFontB.22", wd - 15 - sps, hd - 30, MSD.ColorAlpha(color, 155), TEXT_ALIGN_RIGHT)
				surface.SetDrawColor(MSD.ColorAlpha(color, 155))
				surface.DrawLine(wd - 15 - sps - line, hd - 17 ,wd - 15 - sps, hd - 17)
				surface.DrawLine(wd - 15 - sps - line, hd - 18 ,wd - 15 - sps, hd - 18)
			end
		end

		if self.desc then
			draw.DrawText(self.desc, "MSDFont.24", 25 + icons + sp, 14, MSD.Text.d, TEXT_ALIGN_LEFT)
		end

		if self.details then
			draw.DrawText(MSD.TextWrap(self.details, "MSDFont.22", wd - 35 - icons), "MSDFont.22", 20 + icons, 40, MSD.Text.n, TEXT_ALIGN_LEFT)
		end
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end
	button.OnCursorExited = function(self)
		self.hover = false
	end

	button.DoClick = function(self)
		func(self)
	end
	parent:AddItem(button)

	return button
end

local filler = {
	[1] = "Гражданский",
	[6] = "Гос. служащий",
	[11] = "Нелегал",
}

local repeatq = {
	[2] = true,
	[4] = true,
	[7] = true,
	[10] = true,
	[12] = true,
	[15] = true,
}

local donate_cat_price = {
	{"win/error.wav", 200},
	{"win/error.wav", 500},
	{"win/error.wav", 1000},
	{"noire/ss2.mp3", 2000},
	{"noire/ss1.mp3", 3100}
}

local CASE_SPIN_TIME = 6
local CASE_TIMEOUT = 20

local dropIcons = {}

local function getDropIcon(key)
	if dropIcons[key] then return dropIcons[key] end

	local item = Glac.Items[key]
	local mat

	if item and type(item.icon) == "IMaterial" then
		mat = item.icon
	elseif item and istable(item.icon) then
		mat = Material("entities/" .. (item.icon[3] or key) .. ".png", "smooth")
	end

	if not mat or mat:IsError() then
		mat = MSD.Icons48.dice
	end

	dropIcons[key] = mat
	return mat
end

local function CreateWheel(ent, tbl, index, attachmentpos, fw)
	local fAng = ent:GetAngles()

	if fw then
		if index == 1 or index == 3 then
			fAng.p = 180
		end
	else
		if index == 2 or index == 4 then
			fAng.r = 180
		end
	end

	if not ent.Weals then
		ent.Weals = {}
	end

	ent.Weals[index] = ClientsideModel((tbl.CustomWheelModel_R and (index == 3 or index == 4 or index == 5 or index == 6)) and tbl.CustomWheelModel_R or tbl.CustomWheelModel, RENDERGROUP_OTHER)
	ent.Weals[index]:SetPos(attachmentpos)
	ent.Weals[index]:SetAngles(fAng)
	ent.Weals[index]:SetNoDraw( true )
	ent.Weals[index]:SetIK( false )
end

local function CarModel(parent, item)
	local icon = vgui.Create("DModelPanel", parent)
	icon:SetModel(item.icon[1])
	icon:SetColor(color_white)
	icon:SetAnimated(true)

	local mn, mx = icon.Entity:GetRenderBounds()
	local size = 0
	size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
	size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
	size = math.max(size, math.abs(mn.z) + math.abs(mx.z))

	icon:SetFOV(50)
	icon:SetCamPos(Vector(size, size + 5, 120))
	icon:SetLookAt((mn + mx) * 0.5)

	function icon:LayoutEntity(ent)
		if (self.bAnimated) then
			self:RunAnimation()
		end
	end

	local veh = list.Get("simfphys_vehicles")[item.icon[3]]
	local tbl = veh and veh.Members

	if tbl and tbl.CustomWheelModel then
		CreateWheel(icon.Entity, tbl, 1, tbl.CustomWheelPosFL, item.icon[4])
		CreateWheel(icon.Entity, tbl, 2, tbl.CustomWheelPosFR, item.icon[4])
		CreateWheel(icon.Entity, tbl, 3, tbl.CustomWheelPosRL, item.icon[4])
		CreateWheel(icon.Entity, tbl, 4, tbl.CustomWheelPosRR, item.icon[4])
	end

	function icon:PostDrawModel(ent)
		if not ent.Weals then return end
		for k, v in pairs(ent.Weals) do
			v:DrawModel()
		end
	end

	function icon:OnRemove()
		if IsValid(self.Entity) then
			local weals = self.Entity.Weals
			self.Entity:Remove()
			if not weals then return end
			for k, v in pairs(weals) do
				if not IsValid(v) then continue end
				v:Remove()
			end
		end
	end

	return icon
end

local part_focus = {
	["top"] = {0.65, 30},
	["coat"] = {0.25, 35, 2, 2},
	["pants"] = {0.25, 35},
	["wboots"] = {0.1, 20, 2, 2},
	["boots"] = {0.05, 16},
	["suit"] = {0.65, 30, 1, 3},
}

local function SuitModel(parent, item, part)
	local gender = LocalPlayer():getDarkRPVar("gender")
	local icon = vgui.Create("DModelPanel", parent)
	icon:SetAnimated(false)
	icon:SetModel(LocalPlayer():GetModel())

	local mn, mx = icon.Entity:GetRenderBounds()
	local size = 0
	size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
	size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
	size = math.max(size, math.abs(mn.z) + math.abs(mx.z))

	local focus = part_focus[part] or {0.65, 30}

	icon:SetFOV(focus[2])
	icon:SetCamPos(Vector(size, size - 12, 70))
	icon:SetLookAt((mn + mx) * focus[1])

	if focus[3] then
		icon.Entity:SetBodygroup(focus[3], focus[4])
	end

	MCR.SetMatID(icon.Entity, gender, part, item.id)

	if part == "suit" then
		MCR.SetMatID(icon.Entity, gender, "shirt", item.id)
	end

	icon.Entity:ResetSequence("pose_standing_02")
	icon.Entity:SetAngles(Angle(0, 30, 0))
	function icon:LayoutEntity(ent)
	end

	return icon
end

-- Turns a server result ({success, item, hsl} or {suit, item, part, hsl}) into display data
local function ResolveResult(res)
	if not res then return end
	local color = HSLToColor(res.hsl or 180, 0.89, 0.57)

	if res.suit then
		local item = MCR.shop[res.part] and MCR.shop[res.part][res.item]
		if not item then return end

		return {
			name = item.name,
			color = color,
			sound = "win/error.wav",
			icon = MSD.Icons48.tshirt_crew_custom,
			model = function(parent) return SuitModel(parent, item, res.part) end,
		}
	end

	if res.success == Glac.RESULT_REWARD then
		local ep = Glac.Episodes[res.episode or 1]
		local item = ep and ep.Rewards[res.item]
		if not item then return end

		return {
			name = item.name,
			color = color,
			sound = "win/error.wav",
			icon = type(item.icon) == "IMaterial" and item.icon or nil,
			iconHue = item.icon_hue,
		}
	end

	if res.success ~= Glac.RESULT_ITEM then return end

	local item = Glac.Items[res.item]
	if not item then return end

	local snd = "win/error.wav"
	for _, v in ipairs(donate_cat_price) do
		if (item.Price or 0) >= v[2] then
			snd = v[1]
		end
	end

	local data = {
		name = item.Name or item.name,
		color = color,
		sound = snd,
		iconHue = item.icon_hue,
		icon_size = item.icon_size,
	}

	if istable(item.icon) then
		data.icon = getDropIcon(item.key)
		data.model = function(parent) return CarModel(parent, item) end
	elseif type(item.icon) == "IMaterial" then
		data.icon = item.icon
	end

	return data
end

-- Promo poster on the left, title on top, spinning star with an icon on the right.
-- With opt.pool it rolls random icons, slowing down until opt.getResult() returns the drop.
local function ShowcasePanel(parent, height, opt)
	local panel = vgui.Create("DPanel")
	panel.StaticScale = {
		w = 1,
		fixed_h = height,
		minw = 200,
		minh = 150
	}
	panel.ang = 0
	panel.pop = 0
	panel.flash = 0
	panel.posterW = 0
	panel.ssize = 0
	panel.color = opt.color or MSD.Config.MainColor["p"]
	panel.start = CurTime()
	panel.nextTick = 0
	panel.rolling = opt.pool and #opt.pool > 0

	if panel.rolling then
		panel.cur = opt.pool[math.random(#opt.pool)]
	end

	function panel:SetResult(result)
		self.result = result
		self.rolling = false
		self.cur = result.icon
		self.color = result.color
		self.pop = 1
		self.flash = 1

		if result.model then
			self.model = result.model(self)
			self:InvalidateLayout(true)
		end

		surface.PlaySound(result.sound)
	end

	panel.PerformLayout = function(self, wd, hd)
		if opt.poster and opt.poster.icon_size then
			self.posterW = math.Round(hd * opt.poster.icon_size[1] / opt.poster.icon_size[2])
		end

		local tw = wd - self.posterW - 15
		local label, _, lh = MSD.TextWrap(opt.title or "", "SF3S6", tw)
		self.label, self.lh = label, lh

		local top = lh + (opt.subtitle and 40 or 5)
		local bottom = hd - (opt.poster and 50 or 5)
		self.sx = self.posterW + (wd - self.posterW) / 2
		self.sy = top + (bottom - top) / 2
		self.ssize = math.max(math.min(wd - self.posterW - 20, bottom - top), 50)

		if IsValid(self.model) then
			local mw, mh = wd - self.posterW - 10, self.ssize
			self.model:SetSize(mw, mh)
			self.model:SetPos(self.sx - mw / 2, self.sy - mh / 2)
		end
	end

	panel.Think = function(self)
		if not self.rolling then return end

		local now = CurTime()
		if now < self.nextTick then return end

		-- The drop is already shown as the last rolled icon, reveal it after a short hold
		if self.landed then
			opt.onFinish(self, self.landed)
			return
		end

		local t = math.min((now - self.start) / CASE_SPIN_TIME, 1)
		local res = opt.getResult()
		local dropIcon = res and opt.resultIcon and opt.resultIcon(res)

		if t >= 1 then
			if res then
				if dropIcon then
					self.cur = dropIcon
					self.pop = 1
					surface.PlaySound("piemenu_select.wav")
				end

				self.landed = res
				self.nextTick = now + 0.8
				return
			end

			if now - self.start > CASE_TIMEOUT then
				opt.onTimeout()
				return
			end
		end

		local interval = 0.05 + t ^ 3 * 0.5
		local beforeLast = now + interval >= self.start + CASE_SPIN_TIME

		local pool = opt.pool
		local nxt = pool[math.random(#pool)]
		local tries = 0

		while #pool > 1 and (nxt == self.cur or (beforeLast and nxt == dropIcon)) and tries < 10 do
			nxt = pool[math.random(#pool)]
			tries = tries + 1
		end

		self.cur = nxt
		self.pop = 1
		surface.PlaySound("piemenu_selectionchange.wav")
		self.nextTick = now + interval
	end

	panel.Paint = function(self, wd, hd)
		local ft = FrameTime()
		self.pop = Lerp(ft * 10, self.pop, 0)
		self.flash = Lerp(ft * 3, self.flash, 0)

		local speed = 25
		if self.rolling then
			speed = 25 + 300 * (1 - math.min((CurTime() - self.start) / CASE_SPIN_TIME, 1))
		end
		self.ang = (self.ang + ft * speed) % 360

		local px = self.posterW
		if px > 0 then
			MSD.DrawTexturedRect(0, 0, px, hd, opt.poster.icon, color_white)
		end

		if self.label then
			MSD.ShadowText(self.label, "SF3S6", px + 5, 0, MSD.Text.d, TEXT_ALIGN_LEFT, 4)

			if opt.subtitle then
				draw.SimpleText(opt.subtitle, "MSDFont.32", px + 7, self.lh + 2, color_black, TEXT_ALIGN_LEFT)
				draw.SimpleText(opt.subtitle, "MSDFont.32", px + 5, self.lh, MSD.Text.n, TEXT_ALIGN_LEFT)
			end
		end

		local size = self.ssize
		MSD.DrawTexturedRectRotated(self.ang, self.sx, self.sy, size, size, star, MSD.ColorAlpha(self.color, 55 + self.flash * 150))
		MSD.DrawTexturedRectRotated(-self.ang, self.sx, self.sy, size * 0.8, size * 0.8, star, MSD.ColorAlpha(self.color, 155 + self.flash * 100))

		local res = self.result

		if self.cur and not IsValid(self.model) then
			local scale = 1 + self.pop * 0.15
			local iw, ih = size * 0.42 * scale, size * 0.42 * scale

			if res and res.icon_size then
				ih = size * 0.7 * scale
				iw = ih * res.icon_size[1] / res.icon_size[2]
			end

			MSD.DrawTexturedRect(self.sx - iw / 2, self.sy - ih / 2, iw, ih, self.cur, (res and res.iconHue) and self.color or color_white)
		end

		if res and opt.poster then
			draw.SimpleTextOutlined(res.name, "MSDFontB.32", self.sx, hd - 25, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
		end
	end

	parent:AddItem(panel)

	if opt.result then
		panel:SetResult(opt.result)
	end

	return panel
end

function MSD.OpenDonate()
	if IsValid(MSD.Donate) then
		if MSD.Donate.locked then return end
		MSD.Donate:Remove()
		return
	end

	local ply = LocalPlayer()
	local SW, SH = ScrW(), ScrH()
	local hs = 400

	MSD.Donate = vgui.Create("MSDSimpleFrame")
	MSD.Donate:SetSize(SW - SW / 4, SH - SH / 8)
	MSD.Donate:Center()
	MSD.Donate:SetAlpha(1)
	MSD.Donate:AlphaTo(255, 0.5)
	MSD.Donate:MakePopup()
	MSD.Donate.Paint = function(s, w, h)
		MSD.Blur(s, 2, 2, 255, 0, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, w - hs, 120, hs, h - 120, MSD.Theme.l)
		MSDX.Draw(0, 0, 0, w, 120, MSD.Theme.d)
		MSD.DrawTexturedRect(15, 50, 174, 70, MSD.Materials.logo, color_white)

		local sp = draw.SimpleText("ОСОБЫЕ ", "McCD.Sub1", 15, 5, MSD.Config.MainColor.p, TEXT_ALIGN_LEFT)
		draw.DrawText("УСЛУГИ", "McCD.Sub1", 15 + sp, 5, MSD.ColorAlpha(MSD.Patern.MainColor["8"], math.random(150,255)), TEXT_ALIGN_LEFT)

		sp = draw.SimpleText("Баланс: ", "MSDFont.24", w - hs + 45, 128, MSD.Text.s, TEXT_ALIGN_LEFT)
		draw.DrawText(string.Comma(math.Round(Glac.Credits)) .. " ¤", "MSDFontB.24", w - hs + 45 + sp, 128, MSD.Text.s, TEXT_ALIGN_LEFT)

		draw.DrawText(MSD.TextWrap(donate_text, "MSDFont.22", hs - 10), "MSDFont.22", w - hs + 5, 160, MSD.Text.s, TEXT_ALIGN_LEFT)
	end

	MSD.Donate.Think = function(self)
		if self.locked then return end
		if input.IsKeyDown(KEY_ESCAPE) or (input.IsKeyDown(KEY_F4) and self:GetAlpha() > 250) then
			self:Remove()
		end
	end

	local menu = MSD.Donate

	MSD.IconButton(menu, MSD.Icons48.cross, menu:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
		if menu.locked then return end
		menu:AlphaTo(0, 0.4, 0, function()
			menu:Close()
		end)
	end)

	MakeGBUpdateButton(menu, menu:GetWide() - hs + 5, 125, function()
		Glac.CheckDonations()
	end)

	MSD.ButtonIcon(menu, menu:GetWide() - hs + 5, menu:GetTall() - 65, hs - 10, 60, "Пожертвовать проекту", MSD.PinPoints[49], function()
		gui.OpenURL("https://gmodla.ru/donate/?steam_id=" .. ply:SteamID64() .. "&server_name=noire")
	end)

	menu.canvas = vgui.Create("MSDPanelList", menu)
	menu.canvas:SetSize(menu:GetWide() - hs - 10, menu:GetTall() - 130)
	menu.canvas:SetPos(5, 125)
	menu.canvas:SetSpacing(2)
	menu.canvas:SetPadding(0)
	menu.canvas:EnableVerticalScrollbar()
	menu.canvas:EnableHorizontal(true)
	menu.canvas.IgnoreVbar = true

	local pages = {}

	function menu.openPage(id, animate, ...)
		menu.canvas:Clear()
		back_page = cur_page
		pages[id](...)
		cur_page = id

		if animate then
			menu.canvas:SetAlpha(1)
			menu.canvas:AlphaTo(255, 0.2)
		end
	end

	local function BuyItem(k, v, hsl, back)
		MSD.AskConfirmPopup(nil, "Вы уверены что хотите разблокировать '" .. v.Name .. "' за ¤" .. v.Price .. "?", "Да, разблокировать", "Отмена", function()
			menu.lastBuy = {k = k, v = v, hsl = hsl, back = back}
			Glac.Buy(v.key, hsl)
		end)
	end

	local function BuyEventItem(k, v)
		MSD.AskConfirmPopup(nil, "Вы уверены что хотите разблокировать '" .. v.name .. "?", "Да, разблокировать", "Отмена", function()
			menu.lastBuy = {k = k, v = v, back = "items1"}
			Glac.BuyReward(1, k)
		end)
	end

	pages["main"] = function()
		local pn = ItemPanel(menu.canvas, MSD.Icons48.vhs, "Истории", false, Color(255,150,2), function() menu.openPage("episodes", true) end)
		--pn.details = "✦ Скидки"
		pn = ItemPanel(menu.canvas, MSD.Icons48.diamond, "Наборы", true, Color(243,46,56), function() menu.openPage("page1", true) end)
		pn.details = "✦ Новинка"
		ItemPanel(menu.canvas, MSD.Icons48.cash, "Игровая валюта", false, Color(177,236,100), function() menu.openPage("page2", true) end)
		ItemPanel(menu.canvas, MSD.Icons48.dice, "Бинго наборы", true, Color(33,151,248), function() menu.openPage("page3", true) end)
		pn = ItemPanel(menu.canvas, MSD.Icons48.hand_coin, "Другое", false, Color(214,2,119), function() menu.openPage("page5", true) end)
	end

	local isPremium = MQS.GetDataStored(LocalPlayer(), "episode_1_premium")

	pages["episodes"] = function()
		MSD.Header(menu.canvas, "Истории", function()
			menu.openPage("main", true)
		end)

		local pn = ItemPanel(menu.canvas, MSD.Icons48.spider_web, "Эпизод первый", true, Color(200,255,50), function() menu.openPage("episode1", true) end)
		pn.details = "Даже когда кажется что вы на вершине, осмотритесь - всегда найдётся рыбка покрупнее."

		pn = ItemPanel(menu.canvas, MSD.Icons48.lock, "", false, Color(75,75,75), function() end, nil, true)
		pn.blocktext = ""

		pn = ItemPanel(menu.canvas, MSD.Icons48.lock, "", false, Color(75,75,75), function() end, nil, true)
		pn.blocktext = ""
	end

	pages["episode1"] = function()
		MSD.Header(menu.canvas, "Эпизод первый", function()
			menu.openPage("episodes", true)
		end)

		if not isPremium then
			local pn = ItemPanel(menu.canvas, MSD.PinPoints[49], "Премиум допуск", true, Color(200,255,50), function()
				BuyItem("episode_1_premium", Glac.Items["episode_1_premium"], 50, "episodes")
			end)
			pn.Price = 1000
			pn.details = "Открывает больше возможностей истории: разблокирует все задания сразу, повышает накопление очков прогресса, и открывает доступ к уникальным наградам."
		end

		local panel = vgui.Create("DPanel")
		panel.StaticScale = {
			w = 1,
			h = 5,
			minw = 200,
			minh = 150
		}
		local tokens = MQS.GetDataStored(LocalPlayer(), "episode_1_tokens") or 0

		panel.Paint = function(self, wd, hd)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, hd, MSD.Theme["d"])
			draw.DrawText("Очки прогресса: ", "MSDFont.36", 20, 5, MSD.Text["l"], TEXT_ALIGN_LEFT)
			draw.DrawText(" " .. tokens .. " ✫", "MSDFontB.36", 236, 5, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)

			draw.DrawText(MSD.TextWrap("Очки прогресса зарабатываются прохождением заданий из историй. Приобретение премиум допуска увеличивает зарабатываемые очки в 1.5 раза.", "MSDFont.22", wd - 35), "MSDFont.22", 20, 40, MSD.Text.n, TEXT_ALIGN_LEFT)

			draw.SimpleText(isPremium and "У вас премиум допуск" or "У вас обычный допуск", "MSDFontB.24", wd - 5, hd - 30, isPremium and MSD.Config.MainColor["p"] or MSD.Text["d"], TEXT_ALIGN_RIGHT)
		end

		menu.canvas:AddItem(panel)

		ItemPanel(menu.canvas, MSD.Icons48.vhs, "Список заданий", false, MSD.Config.MainColor["p"], function() menu.openPage("quests1", true) end)
		ItemPanel(menu.canvas, MSD.Icons48.diamond, "Награды", true, MSD.Config.MainColor["p"], function() menu.openPage("items1", true) end)
	end

	pages["quests1"] = function()
		MSD.Header(menu.canvas, "Список заданий", function()
			menu.openPage("episode1", true)
		end)

		local invalid_map = string.lower(game.GetMap()) == "rp_southside"
		local filled = {}
		local char = invalid_map and 1 or (LocalPlayer():getDarkRPVar("character") or 1)
		for k,v in ipairs(Glac.Episodes[1].EpisodesSorted[char]) do
			filled[v] = true
			local unlocked, breason = MQS.CanStartTask(v)

			local locked = MQS.QuestFinished(v) and MSD.Icons48.submit or MSD.Icons48.lock

			local pn = ItemPanel(menu.canvas, unlocked and MSD.Icons48.vhs or locked, MQS.Quests[v].name, unlocked, unlocked and MSD.Config.MainColor["p"] or MSD.Text["n"], function() if not unlocked then return end RunConsoleCommand("mqs_start", v) menu:Remove() end, nil, not unlocked)
			pn.StaticScale = {
				w = 1,
				h = 6,
				minw = 200,
				minh = 80
			}
			pn.blocktext = breason
			pn.details = repeatq[k] and "Рутинное задание, можно переигрывать раз в сутки" or "Сюжетное задание, можно выполнить только один раз"
		end

		if invalid_map then
			MSD.InfoTextIcon(menu.canvas, "Внимание", "На ночной карте доступны задания только для гражданского персонажа", MSD.PinPoints[43], MSD.Config.MainColor["p"])
			return
		end

		for k,v in ipairs(Glac.Episodes[1].Episodes) do
			if filled[v] then continue end
			if filler[k] then
				MSD.Header(menu.canvas, filler[k])
			end

			local pn = ItemPanel(menu.canvas, MSD.Icons48.lock, MQS.Quests[v].name, false, MSD.Text["n"], function() end, nil, true)
			pn.StaticScale = {
				w = 1,
				h = 10,
				minw = 200,
				minh = 80
			}
			pn.blocktext = "Задание доступно на другом персонаже"
		end
	end

	pages["items1"] = function()
		MSD.Header(menu.canvas, "Награды", function()
			menu.openPage("episode1", true)
		end)

		local unlocks = MQS.GetDataStored(ply, "episode_1_unlocks") or {}
		local tokens = MQS.GetDataStored(LocalPlayer(), "episode_1_tokens") or 0
		local notall = table.Count(unlocks) < #Glac.Episodes[1].Rewards - 1

		for k,v in ipairs(Glac.Episodes[1].Rewards) do
			local blocked = (v.premium and not isPremium) or tokens < v.cost or unlocks[k] or (v.oncomplete and notall)
			local pn = ItemPanel(menu.canvas, v.icon, v.name, not unlocks[k], v.cost > 1000 and Color(255,0,0) or HSLToColor(50 + (v.cost / 500) * 200, 0.89, 0.57), function()
				if blocked then return end
				BuyEventItem(k,v)
			end, true, blocked)
			pn.blocktext = (v.premium and not isPremium) and "Доступно только с премиум допуском" or "Нужно больше очков прогресса чтобы открыть предмет"
			if unlocks[k] then
				pn.blocktext = "Вы уже разблокировали этот предмет"
			end
			pn.priceIcon = " ✫"
			pn.Price = v.cost
			pn.details = v.dec or "Можно разблокировать за очки прогресса"

			if v.oncomplete and notall then
				pn.blocktext = "Эту награду можно забирать неограниченное количество раз, после разблокировки всех остальных наград"
			end
		end
	end

	pages["packopen"] = function(k, v, cl)
		MSD.Header(menu.canvas, "Набор - " .. v.Name, function()
			menu.openPage("page1", true)
		end)

		local panel = vgui.Create("DButton")
		panel.oldhd = 0
		panel.StaticScale = {
			w = 1,
			h = 1.1,
			minw = 200,
			minh = 150
		}
		local x, y = v.icon_size[1], v.icon_size[2]
		local color = HSLToColor(cl, 0.89, 0.57)
		local size = 200
		panel.Paint = function(self, wd, hd)
			local ar = x / y
			x, y = hd * ar, hd
			if not self.text and hd ~= self.oldhd then
				self.text = MSD.TextWrap(v.details .. "\n\nНажмите чтобы перейти к покупке", "MSDFont.28", x - 10)
				local a, _, b = MSD.TextWrap(v.Name, "SF3S6", x - 10)
				self.label = a
				self.lh = b
				self.oldhd = hd
				return true
			end
			MSD.DrawTexturedRect(0, 0, x, y, v.icon, color_white)
			MSD.ShadowText(self.label, "SF3S6", x + 5, 0, MSD.Text.d, TEXT_ALIGN_LEFT, 4)
			draw.SimpleText(v.desc, "MSDFont.32", x + 7, self.lh + 2, color_black, TEXT_ALIGN_LEFT)
			draw.SimpleText(v.desc, "MSDFont.32", x + 5, self.lh, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.ShadowText(self.text, "MSDFont.28", x + 5, self.lh + 32, MSD.Text.d, TEXT_ALIGN_LEFT, 2)
			MSD.DrawTexturedRectRotated(CurTime() * 25 % 360, wd - size / 2, hd - size / 2, size, size, star, MSD.ColorAlpha(color, 55))
			MSD.DrawTexturedRectRotated(-CurTime() * 25 % 360, wd - size / 2, hd - size / 2, size * 0.8, size * 0.8, star, MSD.ColorAlpha(color, 155))
			draw.SimpleTextOutlined(v.Price .. " ¤", "MSDFontB.32", wd - size / 2, hd - size / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
			return true
		end

		panel.DoClick = function()
			if v.check and not v.check(ply) then return end
			BuyItem(k, v, cl, "page1")
		end

		menu.canvas:AddItem(panel)
	end

	pages["page1"] = function()
		MSD.Header(menu.canvas, "Наборы", function()
			menu.openPage("main", true)
		end)

		local i = 0

		for _, v in ipairs(Glac.ItemList) do
			local k = v.key
			if v.Category ~= "Pack" then continue end
			--if v.check and not v.check(ply) then continue end
			local cl = 280 + i
			local pn = ItemPanel(menu.canvas, MSD.PinPoints[13], v.Name, true, HSLToColor(cl, 0.89, 0.57), function()
				menu.openPage("packopen", true, k, v, cl)
				-- if v.check and not v.check(ply) then return end
				-- BuyItem(k, v, cl, "page1")
			end, nil, v.check and not v.check(ply) or false)
			pn.Price = v.priceUpdater and v.priceUpdater(LocalPlayer()) or v.Price
			if v.Old_Price then
				pn.Old_Price = v.Old_Price
			end
			pn.desc = v.desc
			pn.details = v.details

			i = i + 30
		end
	end

	pages["page2"] = function()
		MSD.Header(menu.canvas, "Игровая валюта", function()
			menu.openPage("main", true)
		end)

		local i = 0

		for _, v in ipairs(Glac.ItemList) do
			local k = v.key
			if v.Category ~= "Money" then continue end
			if v.check and not v.check(ply) then continue end
			local cl = 50 + i
			local pn = ItemPanel(menu.canvas, v.icon, v.Name, true, HSLToColor(cl, 0.89, 0.57), function()
				BuyItem(k, v, cl, "page2")
			end, true)
			pn.Price = v.priceUpdater and v.priceUpdater(LocalPlayer()) or v.Price
			pn.desc = v.desc
			pn.details = v.details

			i = i + 10
		end
	end

	pages["page3"] = function()
		MSD.Header(menu.canvas, "Бинго наборы", function()
			menu.openPage("main", true)
		end)

		local i = 0

		for _, v in ipairs(Glac.ItemList) do
			local k = v.key
			if v.Category ~= "Cases" then continue end
			if v.check and not v.check(ply) then continue end
			local cl = 100 + i
			local pn = ItemPanel(menu.canvas, MSD.Icons48.dice, v.Name, true, HSLToColor(cl, 0.89, 0.57), function()
				--BuyItem(k, v, cl, "page3")
				menu.openPage("caseinfo", true, k, v, cl)
			end)
			pn.Price = v.priceUpdater and v.priceUpdater(LocalPlayer()) or v.Price
			pn.desc = v.desc
			pn.details = v.details

			i = i + 50
		end
	end

	pages["caseinfo"] = function(k, v, cl)
		MSD.Header(menu.canvas, v.Name, function()
			menu.openPage("page3", true)
		end)

		local panel = vgui.Create("DButton")
		panel.oldhd = 0
		panel.StaticScale = {
			w = 1,
			h = v.DropSort and 2 or 1.1,
			minw = 200,
			minh = 150
		}
		local x, y = v.icon_size[1], v.icon_size[2]
		local color = HSLToColor(cl, 0.89, 0.57)
		local size = 200
		panel.Paint = function(self, wd, hd)
			local ar = x / y
			x, y = hd * ar, hd
			if not self.text and hd ~= self.oldhd then
				self.text = MSD.TextWrap(v.details .. "\n\nНажмите чтобы открыть", "MSDFont.28", wd - x - 10)
				local a, _, b = MSD.TextWrap(v.Name, "SF3S6", wd - x - 10)
				self.label = a
				self.lh = b
				self.oldhd = hd
				return true
			end
			MSD.DrawTexturedRect(0, 0, x, y, v.icon, color_white)
			MSD.ShadowText(self.label, "SF3S6", x + 5, 0, MSD.Text.d, TEXT_ALIGN_LEFT, 4)
			draw.SimpleText(v.desc, "MSDFont.32", x + 7, self.lh + 2, color_black, TEXT_ALIGN_LEFT)
			draw.SimpleText(v.desc, "MSDFont.32", x + 5, self.lh, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.ShadowText(self.text, "MSDFont.28", x + 5, self.lh + 32, MSD.Text.d, TEXT_ALIGN_LEFT, 2)
			MSD.DrawTexturedRectRotated(CurTime() * 25 % 360, wd - size / 2, hd - size / 2, size, size, star, MSD.ColorAlpha(color, 55))
			MSD.DrawTexturedRectRotated(-CurTime() * 25 % 360, wd - size / 2, hd - size / 2, size * 0.8, size * 0.8, star, MSD.ColorAlpha(color, 155))
			draw.SimpleTextOutlined(v.Price .. " ¤", "MSDFontB.32", wd - size / 2, hd - size / 2, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
			return true
		end

		panel.DoClick = function()
			if v.check and not v.check(ply) then return end
			BuyItem(k, v, cl, "page3")
		end

		menu.canvas:AddItem(panel)

		if v.DropSort then
			local drop = table.Copy(Glac.Cases[v.is_case])
			v.DropSort(menu, k, v, drop)
		end
	end

	local showcaseHeight = menu.canvas:GetTall() - 105

	pages["caseroll"] = function(k, v, cl)
		menu.locked = true
		menu.rolling = true
		menu.caseResult = nil

		local header = MSD.Header(menu.canvas, v.Name)

		local pool = {}
		for _, d in ipairs(Glac.Cases[v.is_case] or {}) do
			table.insert(pool, getDropIcon(d.item))
		end
		if #pool == 0 then pool[1] = MSD.Icons48.dice end

		local function unlock()
			menu.rolling = false
			menu.locked = false
			menu.caseResult = nil
		end

		local function back()
			menu.openPage("caseinfo", true, k, v, cl)
		end

		surface.PlaySound("mw/user_interface/mp/mp_ui_splash_notify_01.wav")

		ShowcasePanel(menu.canvas, showcaseHeight, {
			poster = v,
			title = v.Name,
			subtitle = v.desc,
			color = HSLToColor(cl or 100, 0.89, 0.57),
			pool = pool,
			getResult = function() return menu.caseResult end,
			resultIcon = function(res)
				local data = ResolveResult(res)
				return data and data.icon
			end,
			onFinish = function(self, res)
				unlock()
				local data = ResolveResult(res)
				if not data then
					menu.openPage("unlocked", true, res)
					return
				end

				self:SetResult(data)
				MSD.IconButton(header, MSD.Icons48.back, 13, 13, 24, nil, nil, back)
				MSD.ButtonIcon(menu.canvas, "static", nil, 2, 45, "Открыть ещё раз", MSD.Icons48.dice, function()
					if v.check and not v.check(ply) then return end
					BuyItem(k, v, cl, "page3")
				end)
				MSD.ButtonIcon(menu.canvas, "static", nil, 2, 45, "Назад", MSD.Icons48.arrow_left, back)
			end,
			onTimeout = function()
				unlock()
				back()
			end,
		})
	end

	pages["unlocked"] = function(res)
		local back = function()
			local pg = menu.lastBuy and menu.lastBuy.back or "main"
			menu.openPage(pages[pg] and pg or "main", true)
		end

		local data = ResolveResult(res)

		if not data then
			MSD.Header(menu.canvas, "Операция прервана", back)
			MSD.InfoText(menu.canvas, "У вас недостаточно кредитов, пожалуйста, повторите снова после пополнения баланса", "MSDFont.24")
			MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Назад", MSD.Icons48.arrow_left, back)
			return
		end

		MSD.Header(menu.canvas, "Успешно", back)

		ShowcasePanel(menu.canvas, showcaseHeight, {
			title = data.name,
			subtitle = "Вы успешно разблокировали этот предмет",
			color = data.color,
			result = data,
		})

		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 45, "Назад", MSD.Icons48.arrow_left, back)
	end

	pages["page5"] = function()
		MSD.Header(menu.canvas, "Другое", function()
			menu.openPage("main", true)
		end)

		local i = 0

		for _, v in ipairs(Glac.ItemList) do
			local k = v.key
			if v.Category ~= "Other" then continue end
			if v.check and not v.check(ply) then continue end
			local cl = 50 + i
			local pn = ItemPanel(menu.canvas, v.icon, v.Name, true, HSLToColor(cl, 0.89, 0.57), function()
				BuyItem(k, v, cl, "page5")
			end, true)
			pn.Price = v.priceUpdater and v.priceUpdater(LocalPlayer()) or v.Price
			if v.Old_Price then
				pn.Old_Price = v.Old_Price
			end
			pn.desc = v.desc
			pn.details = v.details

			i = i + 10
		end
	end

	menu.openPage("main", true)
end
concommand.Add("donate", MSD.OpenDonate)

local function ShowDonateResult(res)
	local menu = MSD.Donate
	if not IsValid(menu) then return end

	-- The case page is still rolling: it will stop on this item by itself
	if menu.rolling then
		menu.caseResult = res
		return
	end

	menu.openPage("unlocked", true, res)
end

hook.Add("Glac.Result", "MSD.Donate", function(res)
	if not IsValid(MSD.Donate) then return end

	ShowDonateResult(res)
end)

hook.Add("Glac.CaseOpen", "MSD.Donate", function(hsl)
	local menu = MSD.Donate
	if not IsValid(menu) then return end

	local buy = menu.lastBuy
	if not buy or not buy.v or not buy.v.is_case then return end

	menu.openPage("caseroll", true, buy.k, buy.v, hsl)
end)
