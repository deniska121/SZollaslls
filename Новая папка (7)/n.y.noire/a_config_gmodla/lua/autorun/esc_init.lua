--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/a_config_gmodla/lua/autorun/esc_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if SERVER then return end
esc = esc or {}
local openPage

CreateClientConVar("hud_time", 1, true, false)

local mats = {
	["player"] = Material("gmodla/hud/waypoint.png", "smooth"),
	["hudarrow"] = Material("msd/arrows.png", "smooth"),
	["home"] = Material("gmodla/hud/home.png", "smooth"),
}

local color_red = Color(255, 0, 0)

local scrchangeing = false

function esc.Spacer(parent)
	local button = vgui.Create("DPanel")
	button:SetSize(250, 30)
	button.Paint = function() end

	if parent then
		parent:AddItem(button)
	end
end

local k_fwd = CreateClientConVar("noire_car_keyforward", KEY_W, true, true)
local k_rad = CreateClientConVar("noire_car_keyradio", KEY_I, true, true)
local k_bck = CreateClientConVar("noire_car_keyreverse", KEY_S, true, true)
local k_left = CreateClientConVar("noire_car_keyleft", KEY_A, true, true)
local k_right = CreateClientConVar("noire_car_keyright", KEY_D, true, true)
local k_wot = CreateClientConVar("noire_car_keywot", KEY_LSHIFT, true, true)
local k_hbrk = CreateClientConVar("noire_car_keyhandbrake", KEY_SPACE, true, true)
local k_cc = CreateClientConVar("noire_car_cruisecontrol", KEY_SLASH, true, true)
local k_lgts = CreateClientConVar("noire_car_lights", KEY_F, true, true)
local k_horn = CreateClientConVar("noire_car_keyhorn", KEY_H, true, true)
local k_ems = CreateClientConVar("noire_car_keyems", KEY_G, true, true)
local k_engine = CreateClientConVar("noire_car_keyengine", KEY_R, true, true)
local k_lock = CreateClientConVar("noire_car_key_lock", KEY_T, true, true)
local k_turnmenu = CreateClientConVar("noire_car_key_turnmenu", KEY_V, true, true)
local k_clutch = CreateClientConVar("noire_car_keyclutch", KEY_LALT, true, true)
CreateClientConVar("noire_car_keygearup", MOUSE_LEFT, true, true)
CreateClientConVar("noire_car_keygeardown", MOUSE_RIGHT, true, true)
CreateClientConVar("noire_car_key_air_forward", KEY_PAD_8, true, true)
CreateClientConVar("noire_car_key_air_reverse", KEY_PAD_2, true, true)
CreateClientConVar("noire_car_key_air_left", k_left:GetInt(), true, true)
CreateClientConVar("noire_car_key_air_right", k_right:GetInt(), true, true)
CreateClientConVar("noire_car_automatic", 1, true, true)
local k_foglights = CreateClientConVar("noire_car_foglights", KEY_B, true, true)

local k_list = {
	{k_engine, KEY_R, "Запуск / остановка двигателя"},
	{k_fwd, KEY_W, "Газ (вперед)"},
	{k_wot, KEY_LSHIFT, "Увеличение газа (разгон)"},
	{k_bck, KEY_S, "Тормоз (Задний ход)"},
	{k_hbrk, KEY_SPACE, "Ручной тормоз"},
	{k_left, KEY_A, "Поворот налево"},
	{k_turnmenu, KEY_V, "Поворотники (Меню)"},
	{k_right, KEY_D, "Поворот направо"},
	{k_lgts, KEY_F, "Фары"},
	{k_cc, KEY_SLASH, "Круиз контроль"},
	{k_horn, KEY_H, "Звуковой сигнал"},
	{k_rad, KEY_I, "Радио"},
	{k_ems, KEY_G, "СГУ (Сирена)"},
	{k_lock, KEY_T, "Спец. действие (закрепить предметы и т.п.)"},
	{k_foglights, KEY_B, "Подсветка / Противотуманные"},
	{k_clutch, KEY_LALT, "Сцепление"},
}

local camPos = Vector(4045.5480957031, -7956.0170898438, 829.79779052734)
local camAngles = Angle(-0.9215390086174, -121.24108886719, 0)

local restrinct = {
	["pill"] = "Аптека",
	["pistol"] = "Магазин оружия",
	["beer"] = "Бар",
	["food"] = "Кафе/Ресторан",
	["car_wrench"] = "Автомастерская",
}

function esc.openMenu()
	if IsValid(esc.Menu) then
		esc.Menu:Close()

		return
	end

	if not esc.MenuButs then
		esc.MenuButs = {
			{
				"Вернуться в игру", MSD.Icons48.arrow_left, function()
					esc.Menu:Close()
				end
			},
			{"spacer"},
			{
				"Настройки сервера", MSD.Icons48.cog, function(f)
					f("settings", 3, nil, true)
				end
			},
			{
				"Настройки игры", MSD.Icons48.playlist_edit, function()
					gui.ActivateGameUI()
					RunConsoleCommand("gamemenucommand", "openoptionsdialog")
				end
			},
			{
				"Карта города", MSD.Icons48.compass_rose, function(f)
					f("map", 1, nil, true)
				end,
				true
			},
			{"spacer"},
			{
				"Контент", MSD.Icons48.box, function()
					gui.OpenURL("https://steamcommunity.com/workshop/filedetails/?id=456384788")
				end
			},
			{
				"Правила", MSD.Icons48.file_document, function()
					gui.OpenURL("https://gmodla.ru/rules/noire")
				end
			},
			{
				"Пожертвования", MSD.PinPoints[55], function()
					MSD.OpenDonate()
					esc.Menu:Close()
				end
			},
			{
				"Сайт проекта", MSD.Icons48.lacoin, function()
					gui.OpenURL("https://gmodla.ru/")
				end
			},
			{
				"Discord сервер", MSD.Icons48.discord, function()
					gui.OpenURL("https://discord.gg/mb4ppSaPva")
				end
			},
			{"spacer"},
			{
				"Меню игры", MSD.Icons48.menu, function()
					esc.Menu:Close()
					gui.ActivateGameUI()
				end
			},
			{
				"Отключиться", MSD.Icons48.exit_to_app, function()
					MSD.AskConfirmPopup(nil, "Вы уверены что хотите отключиться от сервера?\nПри выходе в бессознательном состоянии, во время задержания или активной ролевой игры с кем-то - вы можете получить блокировку!", "Да, отключиться", "Отмена", function()
						RunConsoleCommand("disconnect")
					end)
				end
			},
		}
	end

	scrchangeing = true
	local al1 = 0
	local timer_pass = CurTime() + 15
	local SW, SH = ScrW(), ScrH()
	local SWdw = 0
	local hs = 440
	esc.Menu = vgui.Create("MSDSimpleFrame")
	esc.Menu:SetSize(SW, SH)
	esc.Menu:SetDraggable(false)
	esc.Menu:MakePopup()
	esc.Menu:SetAlpha(1)
	esc.Menu:AlphaTo(255, 0.3)

	esc.Menu.Paint = function(self, w, h)
		if gui.IsGameUIVisible() and timer_pass ~= 0 and scrchangeing then
			timer_pass = 0
			SWdw = 1
			scrchangeing = false
		end

		if timer_pass == 0 or timer_pass < CurTime() then
			if scrchangeing then
				SWdw = Lerp(FrameTime() * 1, SWdw, 2)

				if SWdw > 1 then
					scrchangeing = false
				end
			else
				cam.Start2D()

				render.RenderView({
					origin = camPos,
					angles = camAngles,
					fov = 50,
					drawviewmodel = false,
					drawhud = false,
					x = 0,
					y = 0,
					w = w,
					h = h
				})

				cam.End2D()
				SWdw = Lerp(FrameTime() * 1, SWdw, 0)
			end

			if SWdw > 0.001 then
				MSDX.Draw(0, 0, 0, w, h, MSD.ColorAlpha(color_black, SWdw * 255))
			end
		end

		Derma_DrawBackgroundBlur(self, self.startTime)
		al1 = Lerp(FrameTime() * 5, al1, 1)
	end

	esc.Menu.OnClose = function()
		esc.Menu = nil
	end

	local menu = vgui.Create("DPanel", esc.Menu)
	menu:SetSize(SW - 20, SH - 30)
	menu:SetPos(15, 15)
	menu:SetAlpha(1)
	menu:AlphaTo(255, 0.5)

	menu.Paint = function(s, w, h)
		MSD.Blur(s, 2, 2, 255, 0, hs, h)
		MSDX.Draw(0, 0, 0, hs, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, hs, 120, MSD.Theme.d)
		MSD.DrawTexturedRect(hs / 2 - 146, 0, 293, 118, MSD.Materials.logo, color_white)
	end

	esc.Menu.Panel = menu

	menu.ClearPage = function(ss, popup, canvas)
		if IsValid(menu.page) then
			menu.page:Remove()
		end

		menu.page = vgui.Create("DPanel", menu)
		menu.page:SetSize((SW - 45 - hs) / ss, menu:GetTall())
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

	local pages = {}

	local icon_color = Color(241, 200, 0)
	local icon_green = Color(41, 143, 15)

	pages["map"] = function()
		if IsValid(esc.cp2) then
			esc.cp2:Remove()
		end

		esc.cp2 = vgui.Create("DPanel", esc.Menu)
		esc.cp2.wt = 0
		esc.cp2.wc = 0

		esc.cp2.StaticScale = {
			w = 1,
			h = 1,
			minw = 250,
			minh = 50
		}

		local mmw, mmh = ScrH() - 56, ScrH() - 56
		local senter = mmw / 2
		local mapmin, mapmax = game.GetWorld():GetModelBounds()
		local scale = (mapmax.x - mapmin.x) / mmw
		local pp = LocalPlayer():GetPos()
		local shop_list = {}

		local tf = "MSDFont.25"

		if ScrH() < 1080 then
			tf = "MSDFont.18"
		end

		function esc.cp2:OnMousePressed(mousecode)
			if (mousecode == MOUSE_LEFT) then
				if (self.LastClickTime and SysTime() - self.LastClickTime < 0.2) then
					local x,y = self:LocalCursorPos()
					DarkRP.MiniMap.Marker = Vector(-(senter - x) * scale, (senter - y) * scale, 0)
					if sAdmin.hasPermission(LocalPlayer(), "is_staff") then
						RunConsoleCommand("sa", "tptm", DarkRP.MiniMap.Marker.x, DarkRP.MiniMap.Marker.y)
					end
					return
				end

				self.LastClickTime = SysTime()
			end

			if (mousecode == MOUSE_RIGHT) then
				DarkRP.MiniMap.Marker = nil
			end
		end
		esc.cp2.Paint = function(self, w, h)
			local is = 0
			MSD.DrawTexturedRect(0, 0, mmw, mmh, DarkRP.MiniMap.Material_sm, color_white, 100)
			surface.SetMaterial(DarkRP.MiniMap.Material_sm)
			surface.SetDrawColor(color_white)
			surface.DrawTexturedRectUV(0, 0, w, h, 0, 0, w / mmw, h / mmh)

			for k, v in pairs(DarkRP.MiniMap.Blips) do
				MSD.DrawTexturedRect(senter + (v[1] / scale) - 24, senter - (v[2] / scale) - 24, 48, 48, MSD.Materials.icon_bg, color_white)
				MSD.DrawTexturedRect(senter + (v[1] / scale) - 12, senter - (v[2] / scale) - 12, 24, 24, v[3], color_white)

				if v[4] and isstring(v[4]) then
					MSD.DrawTexturedRect(self.wc + mmw + 25, 55 + is, 30, 30, v[3], color_white)
					local wt = draw.SimpleText(" - " .. v[4], tf, self.wc + mmw + 60, 70 + is, MSD.Text["l"], 0, 1)
					if self.wt < wt then self.wt = wt end
					is = is + 35
				end
			end

			for k,v in pairs(shop_list) do
				MSD.DrawTexturedRect(self.wc + mmw + 25, 55 + is, 30, 30, MSD.Icons48[k], icon_color)
				local wt = draw.SimpleText(" - " .. restrinct[k], tf, self.wc + mmw + 60, 70 + is, MSD.Text["l"], 0, 1)
				if self.wt < wt then self.wt = wt end
				is = is + 35
			end

			if self.wc + self.wt + mmw + 60 > w then
				self.wc = self.wc - 5
			end

			if pp.z < -4500 then return end
			local q = MQS.HasQuest()
			local obj = MQS.GetNWdata(LocalPlayer(), "quest_objective")

			if q and obj then
				obj = MQS.Quests[q.quest].objects[obj]

				if obj.point then
					local icon = obj.marker and MSD.PinPoints[obj.marker]
					local bx, by = senter + (obj.point.x / scale) - 15, senter - (obj.point.y / scale) - 15
					MSD.DrawTexturedRect(bx - 9, by - 9, 48, 48, MSD.Materials.icon_bg, color_black)
					MSD.DrawTexturedRect(bx, by, 30, 30, icon or MSD.PinPoints[0], icon_color)
				end
			end

			for k, v in pairs(Territories.list) do
				if not v.buyable then continue end
				local data = McPhone.ter_list[k]
				if not data then continue end
				if data.masterOwner ~= LocalPlayer() and not data.propetytype then continue end
				local point = v.gps_point or v.coords[1]
				local bx, by = senter + (point.x / scale) - 15, senter - (point.y / scale) - 15
				MSD.DrawTexturedRect(bx - 9, by - 9, 48, 48, MSD.Materials.icon_bg, color_black)
				MSD.DrawTexturedRect(bx, by, 30, 30, data.propetytype and MSD.Icons48[data.propetytype] or mats["home"], (data.masterOwner == LocalPlayer() and icon_green) or icon_color)
				if data.propetytype and not shop_list[data.propetytype] then
					shop_list[data.propetytype] = true
				end
			end

			if DarkRP.MiniMap.Marker then
				local v = DarkRP.MiniMap.Marker
				MSD.DrawTexturedRect(senter + (v[1] / scale) - 24, senter - (v[2] / scale) - 24, 48, 48, MSD.Materials.icon_bg, color_white)
				MSD.DrawTexturedRect(senter + (v[1] / scale) - 12, senter - (v[2] / scale) - 12, 24, 24, mats.player, MSD.Patern.MainColor["9"])
			end

			MSD.DrawTexturedRect(senter + (pp.x / scale) - 15, senter - (pp.y / scale) - 15, 30, 30, mats.player, color_red)
		end

		menu.canvas:AddItem(esc.cp2)
	end

	pages["settings"] = function()
		MSD.Header(menu.canvas, "Основные")

		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Показывать подсказки", GetConVar("noire_hints"):GetBool(), function(self, value)
			GetConVar("noire_hints"):SetBool(value)
		end)

		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Показывать время на панели HUD", GetConVar("hud_time"):GetBool(), function(self, value)
			GetConVar("hud_time"):SetBool(value)
		end)

		MSD.Binder(menu.canvas, "static", nil, 1, 50, "Кнопка включения рации", GetConVar("pradio_key"):GetInt(), function(value)
			GetConVar("pradio_key"):SetInt(value)
		end)

		MSD.Button(menu.canvas, "static", nil, 1, 45, "Управление транспортом", function()
			openPage("car", 1.5, nil, true)
		end)

		MSD.Header(menu.canvas, "Производительность")

		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Скрывать фары", GetConVar("noire_car_hidesprites"):GetBool(), function(self, value)
			GetConVar("noire_car_hidesprites"):SetBool(value)
		end)

		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Отображать тень от фар", GetConVar("noire_car_shadows"):GetBool(), function(self, value)
			GetConVar("noire_car_shadows"):SetBool(value)
		end)

		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Отображать следы от шин", GetConVar("noire_car_skidmarks"):GetBool(), function(self, value)
			GetConVar("noire_car_skidmarks"):SetBool(value)
		end)

		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Отображать дым прокрутки колёс", GetConVar("noire_car_smokeon"):GetBool(), function(self, value)
			GetConVar("noire_car_smokeon"):SetBool(value)
		end)

		MSD.NumberWang(menu.canvas, "static", nil, 2, 50, 0, 10, GetConVar("fall_maxleaves"):GetInt(), "Макс. источников листопада", function(self)
			GetConVar("fall_maxleaves"):SetInt(tonumber(self:GetValue()) or 1)
		end)

		MSD.NumberWang(menu.canvas, "static", nil, 2, 50, 1, 10, GetConVar("fall_timer"):GetInt(), "Скорость обновления листопада", function(self)
			GetConVar("fall_timer"):SetInt(tonumber(self:GetValue()) or 1)
		end)
		local msg
		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Отображать партиклы дождя", GetConVar("fall_rain"):GetBool(), function(self, value)
			GetConVar("fall_rain"):SetBool(value)
			if not msg then
				MSD.InfoHeader(menu.canvas, "Для применения настроек дождя вам нужно перезайти на сервер")
				msg = true
			end
		end)
		MSD.Header(menu.canvas, "Оружие")
		MSD.NumberWang(menu.canvas, "static", nil, 2, 50, 1, 10, GetConVar("noire_swep_sense"):GetFloat() * 10, "Чувствительность оружия", function(self)
			GetConVar("noire_swep_sense"):SetFloat((tonumber(self:GetValue()) or 10) / 10)
		end)

		MSD.NumberWang(menu.canvas, "static", nil, 2, 50, 1, 5, GetConVar("noire_swep_aimsense"):GetFloat() * 10, "Чувствительность прицела", function(self)
			GetConVar("noire_swep_aimsense"):SetFloat((tonumber(self:GetValue()) or 10) / 10)
		end)
	end

	pages["car"] = function()
		MSD.Header(menu.canvas, "Управление транспортом", function()
			openPage("settings", 3, nil, true)
		end)

		for _, v in pairs(k_list) do
			MSD.Binder(menu.canvas, "static", nil, 2, 50, v[3], v[1]:GetInt(), function(value)
				v[1]:SetInt(value)
			end)
		end

		MSD.Button(menu.canvas, "static", nil, 1, 45, "Сбросить все настройки", function()
			for i = 1, table.Count(k_list) do
				local kentry = k_list[i]
				kentry[1]:SetInt(kentry[2])
			end

			openPage("car", 1.5, nil, true)
		end)

		MSD.BoolSlider(menu.canvas, "static", nil, 1, 50, "Автоматическая коробка передач", GetConVar("noire_car_automatic"):GetBool(), function(self, value)
			GetConVar("noire_car_automatic"):SetBool(value)
		end)
	end

	openPage = function(id, ss, popup, canvas, ...)
		menu.ClearPage(ss, popup, canvas)
		back_page = cur_page
		pages[id](...)
		cur_page = id
	end

	for k, v in pairs(esc.MenuButs) do
		if v[1] == "spacer" then
			esc.Spacer(menu.list)
			continue
		end

		local button = MSD.MenuButton(menu.list, v[2], nil, nil, 250, 50, v[1], function(self)
			menu.list.Deselect(not v[5] and self or false)
			v[3](openPage)
		end)

		if v[4] then
			menu.list.Deselect(button)
			v[3](openPage)
		end
	end
end

function esc.HideHUD()
	if esc.Menu and esc.Menu:IsValid() then return false end
end

hook.Add("HUDShouldDraw", "GmodLA.ESCHideHUD", esc.HideHUD)

hook.Add("OnPauseMenuShow", "esc.PreRender", function()
	esc.openMenu()
	return false
end)

hook.Remove("PreRender", "esc.PreRender", function()
	if input.IsKeyDown(KEY_ESCAPE) and gui.IsGameUIVisible() then
		gui.HideGameUI()
		cam.Start2D()

		local CamData = {
			angles = EyeAngles(),
			origin = LocalPlayer():GetShootPos(),
			x = 0,
			y = 0,
			drawviewmodel = true,
			drawhud = true,
			dopostprocess = true,
			w = ScrW(),
			h = ScrH(),
		}

		render.RenderView(CamData)
		cam.End2D()
		esc.openMenu()

		return true
	end
end)