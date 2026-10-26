--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/msdcontext.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local ScrW, ScrH = ScrW, ScrH
local Ln = MSD.GetPhrase
local logo = Material("msd/macnco.png", "smooth")
CreateClientConVar("mmd_lastscr", 0, true, false)

function MSD.AdminAccess(ply)
	return sAdmin.hasPermission(ply, "menu")
end

local module_perms = {
	["Управление"] = "all_perm",
	["Запросы"] = "is_staff",
	["Возвраты"] = {"restore_create", "restore_approve"},
	["Администрирование"] = "menu",
}

local function hasModulePerm(ply, perm)
	if isstring(perm) then return sAdmin.hasPermission(ply, perm) end
	if istable(perm) then
		for _, p in ipairs(perm) do
			if sAdmin.hasPermission(ply, p) then return true end
		end
		return false
	end
	return sAdmin.hasPermission(ply, "all_perms")
end

function MSD.OpenMenuManager(parrent, mod_open)
	if not MSD.AdminAccess(LocalPlayer()) then return end

	if IsValid(MSD.SetupMenu) then
		if not MSD.SetupMenu:IsVisible() then
			MSD.SetupMenu:AlphaTo(255, 0.4)
			MSD.SetupMenu:Show()
			MSD.SetupMenu:Center()

			return
		end

		if parrent then
			MSD.SetupMenu:Center()

			return
		else
			MSD.SetupMenu:Close()
		end
	end

	local pnl_w, pnl_h = ScrW(), ScrH()
	pnl_w, pnl_h = pnl_w - pnl_w / 4, pnl_h - pnl_h / 6
	local panel, setbut

	if parrent then
		panel = parrent:Add("MSDSimpleFrame")
	else
		panel = vgui.Create("MSDSimpleFrame")
		panel:MakePopup()
	end

	panel:SetSize(pnl_w, pnl_h)
	panel:Center()
	panel:SetAlpha(0)
	panel:AlphaTo(255, 0.3)

	panel.Paint = function(self, w, h)
		MSD.DrawBG(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, 50, MSD.Theme["d"])
		MSDX.Draw(MSD.Config.Rounded, 0, 52, w, h - 52, MSD.Theme["l"])
	end

	panel.clsBut = MSD.IconButton(panel, MSD.Icons48.cross, panel:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
		if panel.OnPress then
			panel.OnPress()

			return
		end

		panel:AlphaTo(0, 0.4, 0, function()
			panel:Close()
		end)
	end)

	function panel:OnClose()
		if panel.ModuleSwitch then
			panel.ModuleSwitch()
			panel.ModuleSwitch = nil
		end

		MSD.SetupMenu = nil
	end

	if not parrent then
		panel.clsHide = MSD.IconButton(panel, MSD.Icons48.dot, panel:GetWide() - 64, 10, 25, nil, MSD.Config.MainColor.p, function()
			if panel.OnPress then
				panel.OnPress()

				return
			end

			panel:AlphaTo(0, .4, 0, function()
				MSD.SetupMenu:Hide()
			end)
		end)
	end

	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(panel:GetWide() / 2, 50)
	panel.Menu:SetPos(0, 0)
	--panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(true)
	panel.Menu:SetSpacing(2)
	panel.Menu.IgnoreVbar = true
	panel.Menu.Paint = function() end

	panel.Menu.Deselect = function(but)
		if not but then return end
		but.hovered = true

		for k, v in pairs(panel.Menu:GetItems()) do
			if v and v:IsValid() and v ~= but then
				v.hovered = false
			end
		end
	end

	function panel.ReOpenCanvas()
		if IsValid(panel.Canvas) then
			panel.Canvas:Remove()
		end

		panel.Canvas = vgui.Create("DPanel", panel)
		panel.Canvas:SetSize(panel:GetWide(), panel:GetTall() - 52)
		panel.Canvas:SetPos(0, 52)
		panel.Canvas.Paint = function() end
	end

	local cnv = GetConVar("mmd_lastscr")

	function panel.OpenSettings()
		cnv:SetInt(-1)
		panel.ReOpenCanvas()
		panel.Menu.Deselect(setbut)
		MSD.OpenSettingsMenu(panel.Canvas, panel)
	end

	for id, mod in ipairs(MSD.Modules) do
		if not hasModulePerm(LocalPlayer(), module_perms[mod.name] or "all_perms") then continue end

		local button = MSD.MenuButtonTop(panel.Menu, mod.icon, nil, nil, "auto", 50, mod.name, function(self)
			if panel.ModuleSwitch then
				panel.ModuleSwitch()
				panel.ModuleSwitch = nil
			end

			cnv:SetInt(id)
			panel.ReOpenCanvas()
			panel.Menu.Deselect(self)
			mod.menu(panel.Canvas, panel)
		end)

		if (mod_open and id == mod_open) or (cnv:GetInt() == 0 and id == 1) or cnv:GetInt() == id then
			panel.ReOpenCanvas()
			panel.Menu.Deselect(button)
			mod.menu(panel.Canvas, panel)
		end
	end

	setbut = MSD.MenuButtonTop(panel.Menu, MSD.Icons48.cog, nil, nil, "auto", 50, "", function(self)
		panel.OpenSettings()
	end)

	if cnv:GetInt() == -1 and not mod_open then
		panel.OpenSettings()
	end

	MSD.SetupMenu = panel

	return panel
end

function MSD.OpenSettingsMenu(panel)
	oldcfg = MSD.Config
	if not sAdmin.hasPermission(LocalPlayer(), "all_perms") then return end
	panel.Canvas = vgui.Create("MSDPanelList", panel)
	panel.Canvas:SetSize(panel:GetWide() / 2 - 5, panel:GetTall())
	panel.Canvas:SetPos(panel:GetWide() / 2 + 5, 0)
	panel.Canvas:EnableVerticalScrollbar()
	panel.Canvas:EnableHorizontal(true)
	panel.Canvas:SetSpacing(2)
	panel.Canvas.IgnoreVbar = true
	panel.Canvas.Paint = function() end
	panel.Settings = vgui.Create("MSDPanelList", panel)
	panel.Settings:SetSize(panel:GetWide() / 2, panel:GetTall() - 80)
	panel.Settings:SetPos(0, 0)
	panel.Settings:EnableVerticalScrollbar()
	panel.Settings:EnableHorizontal(true)
	panel.Settings:SetSpacing(2)
	panel.Settings.IgnoreVbar = true
	panel.Settings.Paint = function() end

	panel.Settings.Update = function()
		panel.Settings:Clear()
		MSD.Header(panel.Settings, Ln("set_ui"))
		local combo = MSD.ComboBox(panel.Settings, "static", nil, 1, 50, "Language:", Ln("none"))

		combo.OnSelect = function(self, index, text, data)
			MSD.Config.Language = data
			panel.Settings.Update()
		end

		for k, v in pairs(MSD.Language) do
			combo:AddChoice(v.lang_name, k)
		end

		combo:SetValue(Ln("lang_name"))
		local sld1

		local function sliderCL(cl)
			local c = math.Clamp(math.Round(cl * 255), 30, 250)
			MSD.Config.BgrColor = Color(c, c, c)
		end

		MSD.DTextSlider(panel.Settings, "static", nil, 1, 50, Ln("set_ui_blur"), Ln("set_ui_mono"), MSD.Config.Blur, function(self, value)
			MSD.Config.Blur = value

			if value then
				sld1.value = 1
				sliderCL(sld1.value)
			else
				sld1.value = 0.18
				sliderCL(sld1.value)
			end
		end)

		sld1 = MSD.VolumeSlider(panel.Settings, "static", nil, 1, 50, Ln("set_ui_brightness"), MSD.Config.BgrColor.r / 255, function(self, var)
			sliderCL(var)
		end)

		MSD.ColorSelector(panel.Settings, "static", nil, 1, 50, Ln("set_ui_color"), MSD.Config.MainColor.p, function(self, color)
			MSD.Config.MainColor.p = color
		end)

		MSD.DTextSlider(panel.Settings, "static", nil, 1, 50, Ln("border_rounded"), Ln("border_square"), MSD.Config.Rounded == 8, function(self, value)
			if value then
				MSD.Config.Rounded = 8
			else
				MSD.Config.Rounded = 0
			end
		end)

		if not MSD.HUD then return end
		MSD.Header(panel.Settings, Ln("set_hud"))

		MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, Ln("custom_icon"), MSD.Config.HUD.ShowIcon, function(self, value)
			MSD.Config.HUD.ShowIcon = value
		end)

		MSD.TextEntry(panel.Settings, "static", nil, 1, 50, Ln("q_icon68"), Ln("e_url") .. ":", MSD.Config.HUD.Icon, function(self, value)
			MSD.Config.HUD.Icon = value
		end)

		MSD.TextEntry(panel.Settings, "static", nil, 1, 50, Ln("e_text"), Ln("e_text") .. ":", MSD.Config.HUD.Text, function(self, value)
			MSD.Config.HUD.Text = value
		end)

		local acombo = MSD.ComboBox(panel.Settings, "static", nil, 1, 50, "", "")

		local algm = {Ln("set_ui_align_left"), Ln("set_ui_align_center"), Ln("set_ui_align_right")}

		for i, t in pairs(algm) do
			acombo:AddChoice(t, i - 1)
			acombo:SetValue(t)
		end

		acombo.OnSelect = function(self, index, text, data)
			MSD.Config.HUD.AlignX = data
		end

		local sld0, txt1, sld2, txt2

		sld0 = MSD.VolumeSlider(panel.Settings, "static", nil, 1.2, 50, Ln("set_ui_offset_h"), MSD.Config.HUD.X, function(self, var)
			var = math.Round(var, 3)
			MSD.Config.HUD.X = var
			txt1:SetText(var * 100)
		end)

		txt1 = MSD.TextEntry(panel.Settings, "static", nil, 6, 50, "", "", MSD.Config.HUD.X * 100, function(self, value)
			value = math.Clamp((tonumber(value) or 0) / 100, 0, 1)
			sld0.value = value
			MSD.Config.HUD.X = value
		end, true, nil, nil, true)

		sld2 = MSD.VolumeSlider(panel.Settings, "static", nil, 1.2, 50, Ln("set_ui_offset_v"), MSD.Config.HUD.Y, function(self, var)
			var = math.Round(var, 3)
			MSD.Config.HUD.Y = var
			txt2:SetText(var * 100)
		end)

		txt2 = MSD.TextEntry(panel.Settings, "static", nil, 6, 50, "", "", MSD.Config.HUD.Y * 100, function(self, value)
			value = math.Clamp((tonumber(value) or 0) / 100, 0, 1)
			sld2.value = value
			MSD.Config.HUD.Y = value
		end, true, nil, nil, true)

		MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, Ln("show_team"), MSD.Config.HUD.ShowGroup, function(self, value)
			MSD.Config.HUD.ShowGroup = value
		end)

		MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, Ln("mrs_hud_follow"), MSD.Config.HUD.Follow, function(self, value)
			MSD.Config.HUD.Follow = value
		end)

		MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, Ln("use_team_colors"), MSD.Config.HUD.TeamColor, function(self, value)
			MSD.Config.TeamColor = value
		end)

		MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, Ln("icon_right"), MSD.Config.HUD.IconRight, function(self, value)
			MSD.Config.HUD.IconRight = value
		end)

		MSD.VolumeSlider(panel.Settings, "static", nil, 1, 50, Ln("icon_size"), (MSD.Config.HUD.IconSize - 24) / 40, function(self, var)
			var = math.Round(var, 3)
			MSD.Config.HUD.IconSize = math.Clamp(24 + math.Round(var * 40), 24, 64)
		end)

		MSD.VolumeSlider(panel.Settings, "static", nil, 1, 50, Ln("font_size"), (MSD.Config.HUD.FontSize - 16) / 30, function(self, var)
			var = math.Round(var, 3)
			MSD.Config.HUD.FontSize = math.Clamp(16 + math.Round(var * 30), 16, 46)
		end)
	end

	panel.Settings.Update()

	if LocalPlayer():IsSuperAdmin() then
		MSD.BigButton(panel, 0, panel:GetTall() - 80, panel:GetWide() / 4, 80, Ln("upl_changes"), MSD.Icons48.save, function()
			MSD.SaveConfig()
			panel.Settings.Update()
		end)

		MSD.BigButton(panel, panel:GetWide() / 4, panel:GetTall() - 80, panel:GetWide() / 4, 80, Ln("res_changes"), MSD.Icons48.cross, function()
			MSD.Config = oldcfg
			panel.Settings.Update()
		end)
	end

	local pnl = vgui.Create("DPanel")

	pnl.StaticScale = {
		w = 1,
		h = 4,
		minw = 150,
		minh = 150
	}

	pnl.Paint = function(self, w, h)
		MSD.DrawTexturedRect(w / 2 - 64, h / 2 - 64, 128, 128, logo, MSD.Text["l"])
		draw.DrawText("MSD UI version - " .. MSD.Version, "MSDFont.25", w / 2, h / 2 + 70, MSD.Text["l"], TEXT_ALIGN_CENTER)
	end

	panel.Canvas:AddItem(pnl)
	MSD.InfoHeader(panel.Canvas, "MSD Icons 48")

	for k, v in SortedPairs(MSD.Icons48) do
		MSD.IconButton(panel.Canvas, v, "static", nil, 32, nil, nil, function()
			SetClipboardText("MSD.Icons48." .. k)
		end)
	end

	MSD.InfoHeader(panel.Canvas, "MQS Markers")

	for k, v in SortedPairs(MSD.PinPoints) do
		MSD.IconButton(panel.Canvas, v, "static", nil, 32, nil, nil, function()
			SetClipboardText("MSD.PinPoints[" .. k .. "]")
		end)
	end
end

function MSD.OpenAdminMenu(parrent, mod_open)
	if not MSD.AdminAccess(LocalPlayer()) then return end

	if IsValid(MSD.AdminMenu) then
		if not MSD.AdminMenu:IsVisible() then
			MSD.AdminMenu:AlphaTo(255, 0.4)
			MSD.AdminMenu:Show()
			MSD.AdminMenu:Center()

			return
		end

		if parrent then
			MSD.AdminMenu:Center()

			return
		else
			MSD.AdminMenu:Close()
		end
	end

	local pnl_w, pnl_h = ScrW(), ScrH()
	pnl_w, pnl_h = pnl_w - pnl_w / 4, pnl_h - pnl_h / 6
	local panel

	if parrent then
		panel = parrent:Add("MSDSimpleFrame")
	else
		panel = vgui.Create("MSDSimpleFrame")
		panel:MakePopup()
	end

	panel:SetSize(pnl_w, pnl_h)
	panel:Center()
	panel:SetAlpha(0)
	panel:AlphaTo(255, 0.3)

	panel.Paint = function(self, w, h)
		MSD.DrawBG(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, 50, MSD.Theme["d"])
		MSDX.Draw(MSD.Config.Rounded, 0, 52, w, h - 52, MSD.Theme["l"])
	end

	panel.clsBut = MSD.IconButton(panel, MSD.Icons48.cross, panel:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
		if panel.OnPress then
			panel.OnPress()

			return
		end

		panel:AlphaTo(0, 0.4, 0, function()
			panel:Close()
		end)
	end)

	function panel:OnClose()
		if panel.AModuleSwitch then
			panel.AModuleSwitch()
			panel.AModuleSwitch = nil
		end

		MSD.AdminMenu = nil
	end

	if not parrent then
		panel.clsHide = MSD.IconButton(panel, MSD.Icons48.dot, panel:GetWide() - 64, 10, 25, nil, MSD.Config.MainColor.p, function()
			if panel.OnPress then
				panel.OnPress()

				return
			end

			panel:AlphaTo(0, .4, 0, function()
				MSD.AdminMenu:Hide()
			end)
		end)
	end

	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(panel:GetWide() / 2, 50)
	panel.Menu:SetPos(0, 0)
	panel.Menu:EnableHorizontal(true)
	panel.Menu:SetSpacing(2)
	panel.Menu.IgnoreVbar = true
	panel.Menu.Paint = function() end

	panel.Menu.Deselect = function(but)
		if not but then return end
		but.hovered = true

		for k, v in pairs(panel.Menu:GetItems()) do
			if v and v:IsValid() and v ~= but then
				v.hovered = false
			end
		end
	end

	local cnv = GetConVar("mmd_lastscr")

	function panel.ReOpenCanvas()
		if IsValid(panel.Canvas) then
			panel.Canvas:Remove()
		end

		panel.Canvas = vgui.Create("DPanel", panel)
		panel.Canvas:SetSize(panel:GetWide(), panel:GetTall() - 52)
		panel.Canvas:SetPos(0, 52)
		panel.Canvas.Paint = function() end
	end

	for id, mod in ipairs(MSD.AdminModules) do
		if not hasModulePerm(LocalPlayer(), module_perms[mod.name] or "all_perms") then continue end

		local button = MSD.MenuButtonTop(panel.Menu, mod.icon, nil, nil, "auto", 50, mod.name, function(self)
			if panel.AModuleSwitch then
				panel.AModuleSwitch()
				panel.AModuleSwitch = nil
			end

			cnv:SetInt(id)
			panel.ReOpenCanvas()
			panel.Menu.Deselect(self)
			mod.menu(panel.Canvas, panel)
		end)

		if (mod_open and id == mod_open) or (cnv:GetInt() == 0 and id == 1) or cnv:GetInt() == id then
			panel.ReOpenCanvas()
			panel.Menu.Deselect(button)
			mod.menu(panel.Canvas, panel)
		end
	end

	MSD.AdminMenu = panel

	return panel
end

QCMenu = QCMenu or {}
QCMenu.List = {}

if IsValid(QCMenu.Menu) then QCMenu.Menu:Remove() end

local color_b50 = Color(0,0,0,150)

if not file.Exists("binders.txt", "DATA") then
	file.Write("binders.txt", "[]")
else
	QCMenu.List = util.JSONToTable(file.Read("binders.txt", "DATA"))
end

local bg = Color(61,61,61)

local function updateList()
	file.Write("binders.txt", util.TableToJSON(QCMenu.List))
	if IsValid(QCMenu.Menu) then
		QCMenu.Menu.Update()
	end
end

local function AskPopup(cat, lst, edit)
	if IsValid(QCMenu.Ask) then return end

	if not lst then
		lst = QCMenu.List
	end

	local panel = vgui.Create("MSDSimpleFrame")
	panel:SetSize(ScrW(), ScrH())
	panel:MakePopup()

	local tbl

	if edit then
		tbl = table.Copy(lst[edit])
	else
		tbl = {
			name = "",
			text = ""
		}
	end

	QCMenu.Ask = panel
	panel.Paint = function(self, w, h)
		MSD.Blur(self, 5, 5, 255, 50, w, h)
	end

	panel.Close = function()
		panel:AlphaTo(0, 0.3, 0, function()
			panel:Remove()
		end)
	end

	local child = vgui.Create("DPanel", panel)
	child:SetSize(panel:GetWide() / 3, cat and 155 or 220)
	child:Center()

	child.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, bg)
		MSDX.Draw(0, 0, 0, w, 40, MSD.Theme["d"])
		draw.DrawText("Добавить " .. (cat and "категорию" or "команду") .. " в биндер", "MSDFont.20", 10, 10, color_white, TEXT_ALIGN_LEFT)
	end

	child.PerformLayout = function(self)
		child:Center()

		if child.clsBut then
			child.clsBut:SetPos(child:GetWide() - 38, 5)
		end
	end

	child.clsBut = MSD.IconButton(child, MSD.Icons48.cross, child:GetWide() - 38, 5, 32, nil, nil, function()
		panel:Close()
	end)

	local rlist = vgui.Create("MSDPanelList", child)
	rlist:SetSize(panel:GetWide() / 3, 180)
	rlist:SetPos(0, 40)
	rlist:EnableVerticalScrollbar()
	rlist:EnableHorizontal(true)
	rlist:SetPadding(5)
	rlist:SetSpacing(5)

	MSD.TextEntry(rlist, "static", nil, 1, 50, "", "Название:", tbl.name, function(self, value)
		tbl.name = value
	end, true)

	if not cat then
		MSD.TextEntry(rlist, "static", nil, 1, 50, "", "Команда:", tbl.text, function(self, value)
			tbl.text = value
		end, true)
	end

	MSD.Button(rlist, "static", nil, 1, 50, "Добавить", function(self)
		if #lst > 50 then return end
		if cat and not edit then tbl.text = nil tbl.cat = {} end

		if edit then
			lst[edit] = tbl
		else
			table.insert(lst, tbl)
		end

		updateList()
		panel:Close()
	end)
end

local gesturs = {
	male = {
		["Указать "] = "point",
		["Кивок нет"] = "no",
		["Кивок да"] = "yes",
		["Палец вверх"] = "thumbsup",
		["Умолять"] = "plead",
		["Что?"] = "what",
		["Успокойся"] = "palmout",
		["Позвони мне"] = "call",
		["Кивок влево"] = "left",
		["Кивок вправо"] = "right",
		["Кулак, бодрящий"] = "fist",
		["Кулак, успех"] = "fist_swing",
		["Не может быть!"] = "noway",
		["Исключено!"] = "now",
		["Откуда мне знать?"] = "shrug",
		["Потише"] = "ease",
		["И что?"] = "urgent",
	},
	female = {
		["Указать влево"] = "point",
		["Кивок нет"] = "no",
		["Кивок да"] = "yes",
		["Палец вверх"] = "thumbsup",
		["Умолять"] = "plead",
		["Указать вправо"] = "what",
		["Кивок влево"] = "left",
		["Кивок вправо"] = "right",
		["Кулаки, успех"] = "fist_swing",
		["Не может быть!"] = "noway",
		["Исключено!"] = "now",
		["Потише"] = "ease",
		["И что?"] = "urgent",
	}
}

hook.Add("OnContextMenuOpen", "CMenuOnContextMenuOpen", function()
	if g_ContextMenu:IsVisible() then return end

	if IsValid(QCMenu.Menu) then return end
	QCMenu.Menu = vgui.Create("MSDPanelList", g_ContextMenu)
	local ht = ScrH() - ScrH() / 3
	QCMenu.Menu:SetSize(350, ht)
	QCMenu.Menu:SetPos(10, ScrH() - ht - 60)
	QCMenu.Menu:EnableVerticalScrollbar()
	QCMenu.Menu:EnableHorizontal(true)
	QCMenu.Menu:SetPadding(5)
	QCMenu.Menu:SetSpacing(5)
	QCMenu.Menu.Page = 1

	QCMenu.Menu.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSDX.Draw(0, 0, 0, w, hd, color_b50)
	end
	local men = QCMenu.Menu

	men.Update = function(lst, back)
		if not lst then
			lst = QCMenu.List
		end

		men:Clear()

		MSD.InfoHeader(men, "Биндер | ПКМ - Опции")

		if back then
			MSD.ButtonIcon(men, "static", nil, 1, 30, "Назад", MSD.Icons48.arrow_left, function() men.Update() end)
		else
			MSD.ButtonIcon(men, "static", nil, 1, 30, "Жесты", MSD.Icons48.human_greeting_variant, function(s)
				men:Clear()
				MSD.ButtonIcon(men, "static", nil, 1, 30, "Назад", MSD.Icons48.arrow_left, function() men.Update() end)

				for k,v in SortedPairs(gesturs[LocalPlayer():getDarkRPVar("gender")]) do
					MSD.ButtonIcon(men, "static", nil, 1, 30, k, MSD.Icons48.dot, function() RunConsoleCommand("say", "/gesture " .. v) end)
				end

			end)
		end

		if not back and GetConVar("noire_hints"):GetInt() > 0 then
			MSD.ButtonIcon(men, "static", nil, 1, 30, "Меню помощи", MSD.Icons48.layers, function() RunConsoleCommand("gmodla_f1") end)
			MSD.ButtonIcon(men, "static", nil, 1, 30, "Основное игровое меню", MSD.Icons48.layers, function() RunConsoleCommand("gmodla_f4") end)
		end

		for k,v in pairs(lst) do
			MSD.ButtonIcon(men, "static", nil, 1, 30, v.name, v.cat and MSD.Icons48.menu or MSD.Icons48.dot, function()
				if v.cat then
					men.Update(v.cat, true)
					return
				end
				RunConsoleCommand("say", v.text)
			end, function(s)
				local menu = MSD.MenuOpen(false, men)

				if k > 1 then
					menu:AddOption("Передвинуть вверх", function()
						local lv = v
						lst[k] = lst[k - 1]
						lst[k - 1] = lv
						updateList()
					end, MSD.Icons48.arrow_up)
				end

				if k ~= #lst then
					menu:AddOption("Передвинуть вниз", function()
						local lv = v
						lst[k] = lst[k + 1]
						lst[k + 1] = lv
						updateList()
					end, MSD.Icons48.arrow_down)
				end

				menu:AddOption("Изменить", function()
					AskPopup(v.cat, lst, k)
				end, MSD.Icons48.pencil)

				menu:AddOption("Удалить", function()
					table.remove(lst, k)
					updateList()
				end, MSD.Icons48.close_thick)

				local x, y = s:LocalToScreen(0, s:GetTall())
				menu:SetMinimumWidth(s:GetWide())
				menu:Open(x, y, false, s)
			end)
		end

		MSD.ButtonIcon(men, "static", nil, 1, 30, "Добавить", MSD.Icons48.plus, function(s)
			local menu = MSD.MenuOpen(false, men)

			menu:AddOption("Команда", function()
				AskPopup(nil, lst)
			end, MSD.Icons48.console)

			if not back then
				menu:AddOption("Категория", function()
					AskPopup(true, lst)
				end, MSD.Icons48.playlist_edit)
			end

			local x, y = s:LocalToScreen(0, s:GetTall())
			menu:SetMinimumWidth(s:GetWide())
			menu:Open(x, y, false, s)
		end)
	end

	men.Update(QCMenu.List)
end)

hook.Remove("OnContextMenuClose", "CMenuOnContextMenuClose", function()
	QCMenu.Menu:Remove()
end)