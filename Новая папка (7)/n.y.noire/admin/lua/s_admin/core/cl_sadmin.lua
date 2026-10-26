--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/core/cl_sadmin.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin = sAdmin or {}
sAdmin.usergroups = sAdmin.usergroups or {}
sAdmin.playerData = sAdmin.playerData or {}
sAdmin.requests = sAdmin.requests or {}

sAdmin.mcTime = function(ply)
	local t1 = ply:getDarkRPVar("playtime") or 0
	local t2 = ply:getDarkRPVar("synctime") or 0

	return math.max(0, math.Round(t1 + (CurTime() - t2)))
end

sAdmin.warnsData = sAdmin.warnsData or {
	warnsThisWeek = 0,
	warnsChart = {},
	totalWarns = 0,
	punishmentsThisWeek = 0,
	totalPunishments = 0
}

sAdmin.stats = sAdmin.stats or {
	totalPlaytime = 0,
	totalPlayers = 0,
	totalStaffOnline = 0,
	staff_playtimeLeaderboard = {}
}

sAdmin.offlinePlayers = sAdmin.offlinePlayers or {
	refresh = true
}

sAdmin.onlineWarns = sAdmin.onlineWarns or {
	refresh = true
}

sAdmin.offlineWarns = sAdmin.offlineWarns or {
	refresh = true
}

local categorySorting = {
	["Fun"] = 1,
	["Chat"] = 2,
	["Management"] = 3,
	["Teleport"] = 4,
	["Utility"] = 5,
	["Warns"] = 6,
	["DarkRP"] = 7,
	["CAMI"] = 8
}

local isConsole = {
	["0"] = true,
	["[NULL Entity]"] = true
}

local permissionNameToBox, offlineSid64ToPanel = {}, {}

local function networkRank(rank, create)
	net.Start("sA:Networking")
	net.WriteUInt(1, 3)
	net.WriteString(rank)
	net.WriteBool(create)
	net.SendToServer()
end


local function getUsergroupsSorted()
	local result = {}
	local tbl = {}

	for k, v in pairs(sAdmin.usergroups) do
		tbl[k] = v.permissions and tonumber(v.permissions.immunity) or 0
	end

	for k, v in SortedPairsByValue(tbl, true) do
		table.insert(result, k)
	end

	return result
end

local requestPage = function(type, page, search_str)
	net.Start("sA:Networking")
	net.WriteUInt(5, 3)
	net.WriteUInt(type, 3)
	net.WriteUInt(page, 15)
	net.WriteString(search_str or "")
	net.SendToServer()
end


local netMenuState = function(state)
	net.Start("sA:Networking")
	net.WriteUInt(2, 3)
	net.WriteBool(state)
	net.SendToServer()
end

local requestCD = {}
local requestQ = {}
local lastrq = 0

local requestData = function(id)
	if requestCD[id] and requestCD[id] > CurTime() then return end

	if lastrq and lastrq > CurTime() then
		requestQ[id] = true

		return
	end

	lastrq = CurTime() + 3
	requestCD[id] = CurTime() + 1
	net.Start("sA:Networking")
	net.WriteUInt(3, 3)
	net.WriteUInt(id, 2)
	net.SendToServer()
end

timer.Create("sadminQue", 1, 0, function()
	for id, _ in pairs(requestQ) do
		if id then
			print(id)
			requestQ[id] = nil
			requestData(id)
		end
	end
end)

function sAdmin.ButtonWarn(parent, x, y, w, h, warn, func)
	local active = warn.active == "1" or warn.active == 1

	if (os.time() - (warn.date_given or 0)) >= sAdmin.getTime(sAdmin.config["warns"]["active_time"]) then
		active = false
	end

	local admin_name = isConsole[warn.admin_sid64] and "CONSOLE" or (slib.findName(warn.admin_sid64, true) or warn.admin_sid64)
	local text = (warn.reason or "")
	local icon = active and MSD.PinPoints[43] or MSD.PinPoints[44]
	local color = active and MSD.Patern.MainColor["9"] or MSD.Text["n"]
	local note
	if warn.reason and string.StartsWith(warn.reason, "[NOTE]") then
		icon = MSD.Icons48.book_outline
		color = MSD.Patern.MainColor["5"]
		note = true
		text = string.Replace(text, "[NOTE]", "")
	end

	local button = vgui.Create("DButton")
	button:SetText("")

	if x and y then
		button:SetParent(parent)
		button:SetPos(x, y)
	end

	if x == "static" then
		button.StaticScale = {
			w = w,
			fixed_h = h,
			minw = 50,
			minh = h
		}
	else
		button:SetSize(w, h)
	end

	button.alpha = 0

	button.Paint = function(self, wd, hd)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, hd, MSD.Theme["l"])

		if drawf then drawf(self, wd, hd) end

		if (self.hover or self.hovered) and not self.disabled then
			self.alpha = 1
		else
			self.alpha = 0
		end

		local sp = draw.SimpleText("#" .. warn.id .. " ", "MSDFont.22", 48, hd / 2 - 11, MSD.Text["n"], TEXT_ALIGN_LEFT)
		draw.DrawText(text, "MSDFont.22", sp + 48, hd / 2 - 11, note and MSD.Patern.MainColor["1"] or MSD.Text["s"], TEXT_ALIGN_LEFT)
		draw.DrawText(warn.admin_sid64, "MSDFont.16", wd - 5, 5, MSD.ColorAlpha(MSD.Text["d"], self.alpha * 255), TEXT_ALIGN_RIGHT)
		draw.DrawText(admin_name, "MSDFont.16", wd - 5, 5, MSD.ColorAlpha(MSD.Text["d"], 255 - self.alpha * 255), TEXT_ALIGN_RIGHT)
		draw.DrawText(os.date("%H:%M %d/%m/%Y", warn.date_given or 0), "MSDFont.16", wd - 5, hd - 20, MSD.Text["d"], TEXT_ALIGN_RIGHT)
		MSDX.Draw(0, MSD.Config.Rounded, hd - 1, wd - MSD.Config.Rounded * 2, 1, MSD.ColorAlpha(MSD.Text["n"], 255 - self.alpha * 255))
		MSDX.Draw(0, MSD.Config.Rounded, hd - 1, wd - MSD.Config.Rounded * 2, 1, MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 255))
		MSD.DrawTexturedRect(12, hd / 2 - 12, 24, 24, icon, MSD.ColorAlpha(color, 255 - self.alpha * 255))
		MSD.DrawTexturedRect(12, hd / 2 - 12, 24, 24, icon, MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 255))

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

		button.DoRightClick = function(...)
			MSD.UISnd("msd/ui/click.wav")
			local menu = MSD.MenuOpen(false)

			menu:AddOption("Копировать ID администратора", function()
				SetClipboardText(warn.admin_sid64)
			end, MSD.Icons48.copy)

			menu:AddOption("Копировать ID варна", function()
				SetClipboardText(warn.id)
			end, MSD.Icons48.copy)

			menu:Open(gui.MouseX(), gui.MouseY())
		end
	end

	if not x or not y then
		parent:AddItem(button)
	end

	return button
end

local sadmin_menu

if IsValid(sadmin_menu) then
	sadmin_menu:Remove()
end

-- Resolves a legacy icon path ("msd/icons/menu.png", "mqs/map_markers/r5.png")
-- to a Material. Falls back to a generic Material() so non-MSD icons still load.
local function resolveTabIcon(pathOrMat)
	if type(pathOrMat) == "IMaterial" then return pathOrMat end

	if isstring(pathOrMat) then
		local key = string.match(pathOrMat, "msd/icons/(.+)%.png")

		if key then
			key = string.Replace(key, "-", "_")
			if MSD.Icons48 and MSD.Icons48[key] then return MSD.Icons48[key] end
		end

		return Material(pathOrMat, "smooth")
	end

	return MSD.Icons48 and MSD.Icons48.dot or Material("msd/icons/menu.png", "smooth")
end

-- Builds an MSDSimpleFrame container that mimics the old SFrame tabbed API
-- used by openMenu: :addTab(name, icon), :setActiveTab(name), .tab[name] panels,
-- .tabmenu (left side menu), .changedTab, .onClose, .onlyHide, .seltab.
-- Each tab panel also exposes its own .addTab(name) for nested sub-tabs
-- (used by the Warns tab in the legacy menu).
--
-- Layout matches the per-module side menu used in MSD.OpenAdminMenu:
--   [top bar with title + close]
--   [side menu 250 wide][content canvas filling the rest]
local SIDE_MENU_WIDE = 250
local SIDE_MENU_GAP = 2
local TOP_BAR_TALL = 50
local TOP_BAR_GAP = 2

local function createMSDAdminFrame(parent, title, w, h, embedded)
	local frame

	if embedded then
		-- Embedded mode: use the passed parent (the canvas of
		-- MSD.OpenAdminMenu) directly as the container. No wrapper layer.
		--
		-- This matches the pattern OpenRequestMenu / OpenRestoreMenu use,
		-- where they build straight inside panel.Canvas and their text
		-- entries receive keystrokes correctly when opened via the context
		-- menu. An extra EditablePanel wrapper here broke the focus chain.
		frame = parent
		frame.embedded = true
	else
		-- Standalone popup.
		frame = vgui.Create("MSDSimpleFrame", parent)
		frame:SetSize(w, h)
		frame:Center()
		frame:SetAlpha(0)
		frame:AlphaTo(255, 0.3)

		frame.Paint = function(self, ww, hh)
			MSD.DrawBG(self, ww, hh)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, ww, TOP_BAR_TALL, MSD.Theme["d"])
			MSDX.Draw(MSD.Config.Rounded, 0, TOP_BAR_TALL + TOP_BAR_GAP, ww, hh - TOP_BAR_TALL - TOP_BAR_GAP, MSD.Theme["l"])
			draw.DrawText(self.title, "MSDFont.25", 15, 12, color_white, TEXT_ALIGN_LEFT)
		end
	end

	frame.title = title or ""
	frame.tab = {}
	frame.seltab = nil

	-- Close button mirrors MSD.OpenAdminMenu (top-right cross). Only the
	-- standalone popup gets one — the embedded host already has its own.
	if not embedded then
		frame.clsBut = MSD.IconButton(frame, MSD.Icons48.cross, frame:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor["r"], function()
			if frame.onlyHide then
				if isfunction(frame.onClose) then
					frame.onClose()
				end

				frame:SetVisible(false)
			else
				frame:Close()
			end
		end)
	end

	local body_y = embedded and 0 or (TOP_BAR_TALL + TOP_BAR_GAP)
	local body_tall = frame:GetTall() - body_y
	-- Vertical side menu (MSDPanelList) — same pattern as the per-module side
	-- bar in MSD.OpenAdminMenu.
	frame.tabmenu = vgui.Create("MSDPanelList", frame)
	frame.tabmenu:SetSize(SIDE_MENU_WIDE, body_tall)
	frame.tabmenu:SetPos(0, body_y)
	frame.tabmenu:EnableVerticalScrollbar()
	frame.tabmenu:EnableHorizontal(true)
	frame.tabmenu:SetSpacing(0)
	frame.tabmenu.IgnoreVbar = false

	frame.tabmenu.Paint = function(self, ww, hh)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, ww, hh, MSD.Theme["l"])
	end

	frame.tabmenu.Deselect = function(but)
		if not but then return end
		but.hovered = true

		for _, v in pairs(frame.tabmenu:GetItems()) do
			if v and v:IsValid() and v ~= but then
				v.hovered = false
			end
		end
	end

	-- Content area sits to the right of the side menu, same pattern as
	-- panel.Canvas in MSD.OpenAdminMenu.
	frame.canvas = vgui.Create("DPanel", frame)
	frame.canvas:SetSize(frame:GetWide() - SIDE_MENU_WIDE - SIDE_MENU_GAP, body_tall)
	frame.canvas:SetPos(SIDE_MENU_WIDE + SIDE_MENU_GAP, body_y)
	frame.canvas.Paint = function() end

	function frame:addTab(name, micon)
		if self.tab[name] then return self end
		local pnl = vgui.Create("DPanel", self.canvas)
		pnl:SetSize(self.canvas:GetWide(), self.canvas:GetTall())
		pnl:SetPos(0, 0)
		pnl:SetVisible(false)
		pnl.Paint = function() end
		pnl.name = name
		-- Nested tab support (used by the Warns panel in the legacy menu).
		pnl.tabs = {}
		pnl.sub_initialized = false

		function pnl.addTab(subname, icon)
			if not pnl.sub_initialized then
				pnl.sub_menu = vgui.Create("MSDPanelList", pnl)
				pnl.sub_menu:SetSize(pnl:GetWide(), 40)
				pnl.sub_menu:SetPos(0, 0)
				pnl.sub_menu:EnableHorizontal(true)
				pnl.sub_menu:SetSpacing(2)
				pnl.sub_menu.IgnoreVbar = false

				pnl.sub_menu.Paint = function(_, w2, h2)
					MSDX.Draw(MSD.Config.Rounded, 0, 0, w2, h2, MSD.Theme["d"])
				end

				pnl.sub_menu.Deselect = function(but)
					if not but then return end
					but.hovered = true

					for _, v in pairs(pnl.sub_menu:GetItems()) do
						if v and v:IsValid() and v ~= but then
							v.hovered = false
						end
					end
				end

				pnl.sub_canvas = vgui.Create("DPanel", pnl)
				pnl.sub_canvas:SetPos(0, 42)
				pnl.sub_canvas:SetSize(pnl:GetWide(), pnl:GetTall() - 42)
				pnl.sub_canvas.Paint = function() end
				pnl.sub_initialized = true
				pnl.activeSub = nil
			end

			local sub_pnl = vgui.Create("DPanel", pnl.sub_canvas)
			sub_pnl:SetSize(pnl.sub_canvas:GetWide(), pnl.sub_canvas:GetTall())
			sub_pnl:SetPos(0, 0)
			sub_pnl:SetVisible(false)
			sub_pnl.Paint = function() end
			pnl.tabs[subname] = sub_pnl

			local sub_btn = MSD.MenuButtonTop(pnl.sub_menu, icon or MSD.Icons48.dot, nil, nil, "auto", 40, subname, function(s)
				for k, v in pairs(pnl.tabs) do
					v:SetVisible(k == subname)
				end

				pnl.sub_menu.Deselect(s)
				pnl.activeSub = subname
			end)

			sub_pnl.tabbttn = sub_btn

			if not pnl.activeSub then
				pnl.activeSub = subname
				sub_pnl:SetVisible(true)
				pnl.sub_menu.Deselect(sub_btn)
			end

			return sub_pnl
		end

		self.tab[name] = pnl

		local button = MSD.MenuButton(self.tabmenu, resolveTabIcon(micon), nil, nil, SIDE_MENU_WIDE, 50, name, function(self_btn)
			frame:setActiveTab(name)
		end)

		pnl.tabbttn = button

		return self
	end

	function frame:setActiveTab(name)
		if not self.tab[name] then return self end
		self.seltab = name

		for tname, p in pairs(self.tab) do
			p:SetVisible(tname == name)
		end

		self.tabmenu.Deselect(self.tab[name].tabbttn)

		if isfunction(self.changedTab) then
			self.changedTab(name)
		end

		return self
	end

	-- No-op shims so the existing SFrame-style chained calls keep working.
	function frame:setTitle(t)
		self.title = t or ""

		return self
	end

	function frame:addCloseButton()
		return self
	end

	function frame:setBlur()
		return self
	end

	-- Only the standalone popup forwards OnClose -> onClose; in embedded
	-- mode `frame` is the host MSD canvas, whose lifecycle is managed by
	-- the MSD admin menu, so we don't want to override its OnClose.
	if not embedded then
		function frame:OnClose()
			if isfunction(self.onClose) then
				self.onClose()
			end
		end
	end

	return frame
end

local function openMenu(panel, mainPanel)
	local embedded = IsValid(panel)

	-- If we're switching modes (embedded <-> popup), drop the old instance.
	-- In embedded mode sadmin_menu IS the host's MSD canvas — never call
	-- Remove() on it; the MSD admin menu manages its lifecycle. Just drop
	-- the reference so we rebuild fresh below.
	if IsValid(sadmin_menu) and ((embedded and not sadmin_menu.embedded) or (not embedded and sadmin_menu.embedded)) then
		if not sadmin_menu.embedded then
			sadmin_menu:Remove()
		end

		sadmin_menu = nil
	end

	-- Standalone (chat/concommand) toggles an existing popup; embedded mode
	-- always rebuilds since the host canvas is recreated on every tab switch.
	if not embedded and IsValid(sadmin_menu) then
		local todo = not sadmin_menu:IsVisible()
		sadmin_menu:SetVisible(todo)
		netMenuState(todo)

		return
	end

	if embedded and IsValid(sadmin_menu) then
		-- Same reasoning as above: don't Remove the host canvas.
		sadmin_menu = nil
	end

	sAdmin.stats.totalStaffOnline = 0

	for k, v in ipairs(player.GetAll()) do
		if sAdmin.hasPermission(v, "is_staff") then
			sAdmin.stats.totalStaffOnline = sAdmin.stats.totalStaffOnline + 1
		end
	end

	netMenuState(true)
	requestData(0)
	--requestData(1)
	sadmin_menu = createMSDAdminFrame(panel, slib.getLang("sadmin", sAdmin.config["language"], "title"), slib.getScaledSize(1400, "x"), slib.getScaledSize(900, "y"), embedded)

	-- Only the standalone popup needs MakePopup; in embedded mode sadmin_menu
	-- IS the host's MSD canvas, and we must not change its popup status.
	if not embedded then
		sadmin_menu:MakePopup()
	else
		sadmin_menu.par = sadmin_menu:GetParent()
	end

	sadmin_menu:addTab(slib.getLang("sadmin", sAdmin.config["language"], "commands"), "msd/icons/console.png")
	sadmin_menu:addTab(slib.getLang("sadmin", sAdmin.config["language"], "players"), "msd/icons/account-multiple.png")

	if not sAdmin.config["disabled_modules"]["Warns"] then
		sadmin_menu:addTab(slib.getLang("sadmin", sAdmin.config["language"], "warns"), "mqs/map_markers/r5.png")
	end

	sadmin_menu:addTab(slib.getLang("sadmin", sAdmin.config["language"], "offline_players"), "msd/icons/account-cancel.png")
	sadmin_menu:addTab(slib.getLang("sadmin", sAdmin.config["language"], "ranks"), "msd/icons/seal.png")
	sadmin_menu:setActiveTab(slib.getLang("sadmin", sAdmin.config["language"], "commands"))
	sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "ranks")].perm = "manage_perms"
	sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "players")].perm = "is_staff"
	sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "offline_players")].perm = "is_staff"
	sadmin_menu.onlyHide = true

	sadmin_menu.onClose = function()
		netMenuState(false)
	end

	sadmin_menu.changedTab = function(name)
		if name == slib.getLang("sadmin", sAdmin.config["language"], "warns") then
			requestData(3)
		end
	end

	sadmin_menu.nameToPanel = {}
	-- =====================================================================
	-- Commands Tab (rebuilt with MSD UI)
	-- Layout: left column = commands grouped by category + search,
	--         middle column = online players + search,
	--         right column = selected info + dynamic input fields + execute.
	-- =====================================================================
	local cmd_tab = sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "commands")]

	local function laycols(parent, count)
		local cols = {}
		local total_w = parent:GetWide()
		local gap = 2
		local col_w = math.floor((total_w - gap * (count - 1)) / count)

		for i = 1, count do
			local pnl = vgui.Create("DPanel", parent)
			pnl:SetPos((col_w + gap) * (i - 1), 0)
			pnl:SetSize(col_w, parent:GetTall())

			pnl.Paint = function(s, w, h)
				MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
			end

			cols[i] = pnl
		end

		return cols
	end

	local cmd_cols = laycols(cmd_tab, 3)
	local cmd_col_left, cmd_col_mid, cmd_col_right = cmd_cols[1], cmd_cols[2], cmd_cols[3]
	-- Selection state shared by the three columns.
	local commands_selected, players_selected
	local cmd_filter, ply_filter = "", ""
	local input_widgets = {}
	local silent_state = false
	local input_list, cmd_list, ply_list

	-- ---- Left column: commands list with search ----
	MSD.TextEntry(cmd_col_left, 5, 5, cmd_col_left:GetWide() - 10, 45, "", "Поиск команды", "", function(self, value)
		cmd_filter = string.lower(value or "")

		if cmd_list and cmd_list.Repopulate then
			cmd_list.Repopulate()
		end
	end, true)

	cmd_list = vgui.Create("MSDPanelList", cmd_col_left)
	cmd_list:SetPos(5, 55)
	cmd_list:SetSize(cmd_col_left:GetWide() - 10, cmd_col_left:GetTall() - 50)
	cmd_list:EnableVerticalScrollbar()
	cmd_list:EnableHorizontal(true)
	cmd_list:SetSpacing(2)
	cmd_list:SetPadding(0)
	cmd_list.IgnoreVbar = false
	cmd_list.Paint = function() end

	function cmd_list.Repopulate()
		cmd_list:Clear()
		local by_cat = {}

		for name, data in pairs(sAdmin.commands) do
			if not data.category then continue end
			if cmd_filter ~= "" and not string.find(string.lower(name), cmd_filter, 1, true) then continue end
			by_cat[data.category] = by_cat[data.category] or {}
			table.insert(by_cat[data.category], name)
		end

		local cats = {}

		for cat in pairs(by_cat) do
			table.insert(cats, cat)
		end

		table.sort(cats, function(a, b)
			local sa = categorySorting[a] or 999
			local sb = categorySorting[b] or 999
			if sa == sb then return a < b end

			return sa < sb
		end)

		for _, cat in ipairs(cats) do
			MSD.InfoHeader(cmd_list, cat)
			table.sort(by_cat[cat])

			for _, name in ipairs(by_cat[cat]) do
				local btn = MSD.ButtonIcon(cmd_list, "static", nil, 1, 45, name, TabUI.CustomIcons[name] or MSD.Icons48.console, function(self)
					commands_selected = (commands_selected == name) and nil or name
					input_list.RebuildPan()
				end)

				btn.PaintOver = function(s, w, h)
					s.disabled = not sAdmin.hasPermission(LocalPlayer(), name)

					if commands_selected == name then
						MSDX.Draw(0, 0, h - 2, w, 2, MSD.Config.MainColor.p)
					end
				end
			end
		end
	end

	-- ---- Middle column: online players with search ----
	MSD.TextEntry(cmd_col_mid, 5, 5, cmd_col_mid:GetWide() - 10, 45, "", "Поиск игрока", "", function(self, value)
		ply_filter = string.lower(value or "")

		if ply_list and ply_list.Repopulate then
			ply_list.Repopulate()
		end
	end, true)

	ply_list = vgui.Create("MSDPanelList", cmd_col_mid)
	ply_list:SetPos(5, 55)
	ply_list:SetSize(cmd_col_mid:GetWide() - 10, cmd_col_mid:GetTall() - 50)
	ply_list:EnableVerticalScrollbar()
	ply_list:EnableHorizontal(true)
	ply_list:SetSpacing(2)
	ply_list:SetPadding(0)
	ply_list.IgnoreVbar = false
	ply_list.Paint = function() end

	function ply_list.Repopulate()
		ply_list:Clear()

		for _, ply in ipairs(player.GetAll()) do
			if not IsValid(ply) or ply:IsBot() then continue end
			local name = ply:SteamName()
			if ply_filter ~= "" and not string.find(string.lower(name), ply_filter, 1, true) then continue end

			local btn = MSD.ButtonIcon(ply_list, "static", nil, 1, 45, name, sAdmin.hasPermission(ply, "is_staff") and MSD.PinPoints[49] or MSD.Icons48.account, function(self)
				players_selected = (players_selected == ply) and nil or ply
				ply_list.Repopulate()
				input_list.RebuildPan()
			end)

			local pinned = ply

			btn.PaintOver = function(s, w, h)
				if players_selected == pinned then
					MSDX.Draw(0, 0, h - 2, w, 2, MSD.Config.MainColor.p)
				end
			end

			local avatar = vgui.Create("AvatarImage", btn)
			avatar:SetSize(41, 41)
			avatar:SetPos(2, 2)
			avatar:SetPlayer(ply, 41)
		end
	end

	-- ---- Right column: selection summary + dynamic inputs + execute ----
	local right_list = vgui.Create("MSDPanelList", cmd_col_right)
	right_list:SetPos(5, 5)
	right_list:SetSize(cmd_col_right:GetWide() - 10, cmd_col_right:GetTall() - 100)
	right_list:EnableVerticalScrollbar()
	right_list:EnableHorizontal(true)
	right_list:SetSpacing(4)
	right_list:SetPadding(0)
	right_list.IgnoreVbar = true
	right_list.Paint = function() end
	input_list = right_list

	input_list.RebuildPan = function()
		input_widgets = {}
		right_list:Clear()
		MSD.InfoHeader(right_list, "Игрок: " .. (IsValid(players_selected) and players_selected:SteamName() or "не выбран"))
		MSD.InfoHeader(right_list, "Команда: " .. (commands_selected or "не выбрана"))
		if not commands_selected then return end
		local cmd_data = sAdmin.commands[commands_selected]
		if not cmd_data or not cmd_data.inputs then return end
		MSD.InfoHeader(right_list, "Параметры")

		for k, inp in ipairs(cmd_data.inputs) do
			if inp[1] == "player" and k == 1 then continue end
			local label = slib.getLang("sadmin", sAdmin.config["language"], inp[2] or inp[1])

			if inp[1] == "dropdown" and isfunction(inp[3]) then
				local combo = MSD.ComboBox(right_list, "static", nil, 1, 50, "", label)
				local choices = inp[3]() or {}

				for _, choice in ipairs(choices) do
					combo:AddChoice(choice, choice)
				end

				combo._value = ""

				combo.OnSelect = function(self, idx, text, data)
					self._value = data or text
				end

				table.insert(input_widgets, {
					kind = "combo",
					el = combo
				})
			else
				local entry = MSD.TextEntry(right_list, "static", nil, 1, 50, "", label, "", function(self, value)
					self._value = value
				end, true, nil, nil, inp[1] == "numeric")

				entry._value = ""

				table.insert(input_widgets, {
					kind = "entry",
					el = entry
				})
			end
		end
	end

	input_list.RebuildPan()

	MSD.BoolSlider(cmd_col_right, 5, cmd_col_right:GetTall() - 110, cmd_col_right:GetWide() - 10, 30, "Тихий режим", silent_state, function(self, value)
		silent_state = value
	end)

	MSD.BigButton(cmd_col_right, 5, cmd_col_right:GetTall() - 75, cmd_col_right:GetWide() - 10, 70, "Выполнить", MSD.Icons48.check_all, function()
		if not commands_selected then return end
		local cmd_data = sAdmin.commands[commands_selected]
		if not cmd_data then return end
		local args = commands_selected
		local needs_player = cmd_data.inputs and cmd_data.inputs[1] and cmd_data.inputs[1][1] == "player"

		if needs_player then
			if not IsValid(players_selected) then return end
			args = args .. " \"" .. (players_selected:SteamID64() or players_selected:SteamName()) .. "\""
		end

		for _, w in ipairs(input_widgets) do
			local v = w.el._value or ""
			args = args .. " \"" .. tostring(v) .. "\""
		end

		LocalPlayer():ConCommand((silent_state and "sa_silent" or "sa") .. " " .. args)
	end)

	cmd_list.Repopulate()
	ply_list.Repopulate()
	-- Players Tab    ​​  0​  ​    
	-- =====================================================================
	-- Players Tab (rebuilt with MSD UI)
	-- =====================================================================
	local players_tab = sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "players")]
	local players_filter = ""
	local players_list

	MSD.TextEntry(players_tab, 5, 5, players_tab:GetWide() - 10, 45, "", "Поиск по имени или SteamID", "", function(self, value)
		players_filter = string.lower(value or "")

		if players_list and players_list.Repopulate then
			players_list.Repopulate()
		end
	end, true)

	players_list = vgui.Create("MSDPanelList", players_tab)
	players_list:SetPos(5, 55)
	players_list:SetSize(players_tab:GetWide() - 10, players_tab:GetTall() - 50)
	players_list:EnableVerticalScrollbar()
	players_list:EnableHorizontal(true)
	players_list:SetSpacing(2)
	players_list:SetPadding(0)
	players_list.IgnoreVbar = false
	players_list.Paint = function() end

	local function showPlayerActions(ply, sid64)
		local menu = MSD.MenuOpen(false, players_list)

		menu:AddOption("Открыть профиль Steam", function()
			gui.OpenURL("https://steamcommunity.com/profiles/" .. sid64)
		end, MSD.Icons48.steam)

		menu:AddOption("Скопировать имя", function()
			SetClipboardText(IsValid(ply) and ply:SteamName() or "")
		end, MSD.Icons48.badge_account)

		menu:AddOption("Скопировать SteamID", function()
			SetClipboardText(IsValid(ply) and ply:SteamID() or "")
		end, MSD.Icons48.copy)

		menu:AddOption("Скопировать SteamID64", function()
			SetClipboardText(sid64)
		end, MSD.Icons48.card_multiple_outline)

		menu:AddOption("Скопировать ранг", function()
			SetClipboardText(IsValid(ply) and ply:GetUserGroup() or "")
		end, MSD.Icons48.rank)

		menu:AddOption("Установить ранг", function()
			if not IsValid(ply) then return end
			local pl, child = MSD.WorkSpacePanel(sadmin_menu.par or sadmin_menu, "Назначить ранг — " .. ply:SteamName(), 2.5, 2)
			local combo = MSD.ComboBox(child, 10, 50, child:GetWide() - 20, 35, "Ранг:", "")

			for _, r in ipairs(getUsergroupsSorted()) do
				combo:AddChoice(r, r)
			end

			local sel_rank = ""

			combo.OnSelect = function(self, idx, text, data)
				sel_rank = data or text
			end

			local time_val = ""

			MSD.TextEntry(child, 10, 95, child:GetWide() - 20, 35, "", "Срок (пусто = навсегда)", "", function(self, v)
				time_val = v
			end, true)

			MSD.BigButton(child, 10, 145, child:GetWide() - 20, 45, "Назначить", MSD.Icons48.check_all, function()
				if sel_rank == "" then return end
				RunConsoleCommand("sa", "setrank", ply:SteamName(), sel_rank, time_val)
				pl:Close()
			end)
		end, MSD.Icons48.rank_sup)

		menu:Open(gui.MouseX(), gui.MouseY())
	end

	function players_list.Repopulate()
		players_list:Clear()

		for _, ply in ipairs(player.GetAll()) do
			if not IsValid(ply) or ply:IsBot() then continue end
			local sid64 = ply:SteamID64()
			if not sid64 then continue end
			local name = ply:SteamName()
			local lname = string.lower(name)
			if players_filter ~= "" and not string.find(lname, players_filter, 1, true) and not string.find(sid64, players_filter, 1, true) and not string.find(ply:SteamID(), players_filter, 1, true) then continue end
			local rank = ply:GetUserGroup()
			local playtime = sAdmin.formatTime(sAdmin.getTotalPlaytime(ply))
			local label = name .. "  —  " .. rank .. "  —  " .. playtime
			local pinned_ply, pinned_sid = ply, sid64

			local btn = MSD.ButtonIcon(players_list, "static", nil, 1, 50, label, MSD.Icons48.account, function()
				showPlayerActions(pinned_ply, pinned_sid)
			end)

			local avatar = vgui.Create("AvatarImage", btn)
			avatar:SetSize(41, 41)
			avatar:SetPos(2, 2)
			avatar:SetPlayer(ply, 41)
		end
	end

	players_list.Repopulate()
	sadmin_menu.players_list = players_list
	-- =====================================================================
	-- Warns Tab (rebuilt with MSD UI). Has 4 nested sub-tabs:
	--   Statistics / Punishment Logs / Online Players / Offline Players
	-- =====================================================================
	local warns_tab = sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "warns")]

	if IsValid(warns_tab) then
		-- ---- Helper for the action menu on player rows ----
		local function showWarnPlayerActions(parent, info)
			local sid64 = info.sid64
			local menu = MSD.MenuOpen(false, parent)

			menu:AddOption("Посмотреть варны", function()
				requestPage(4, 0, sid64)
			end, MSD.Icons48.alert)

			menu:AddOption("Открыть профиль Steam", function()
				gui.OpenURL("https://steamcommunity.com/profiles/" .. sid64)
			end, MSD.Icons48.arrow_right)

			menu:AddOption("Скопировать SteamID", function()
				SetClipboardText(util.SteamIDFrom64(sid64))
			end, MSD.Icons48.dot)

			menu:AddOption("Скопировать SteamID64", function()
				SetClipboardText(sid64)
			end, MSD.Icons48.dot)

			menu:AddOption("Установить ранг", function()
				local pl, child = MSD.WorkSpacePanel(sadmin_menu.par or sadmin_menu, "Назначить ранг", 2.5, 2)
				local combo = MSD.ComboBox(child, 10, 50, child:GetWide() - 20, 35, "Ранг:", "")

				for _, r in ipairs(getUsergroupsSorted()) do
					combo:AddChoice(r, r)
				end

				local sel_rank = ""

				combo.OnSelect = function(self, idx, text, data)
					sel_rank = data or text
				end

				local time_val = ""

				MSD.TextEntry(child, 10, 95, child:GetWide() - 20, 35, "", "Срок (пусто = навсегда)", "", function(self, v)
					time_val = v
				end, true)

				MSD.BigButton(child, 10, 145, child:GetWide() - 20, 45, "Назначить", MSD.Icons48.check_all, function()
					if sel_rank == "" then return end
					RunConsoleCommand("sa", "setrankid", sid64, sel_rank, time_val)
					pl:Close()
				end)
			end, MSD.Icons48.seal)

			menu:Open(gui.MouseX(), gui.MouseY())
		end

		-- ---- A simple paginator helper using MSD buttons ----
		local function buildPaginator(parent, onPageChange)
			local row = vgui.Create("DPanel", parent)
			row:SetSize(parent:GetWide(), 35)
			row:SetPos(0, parent:GetTall() - 35)
			row.page = 1
			row.maxpage = 1

			row.Paint = function(s, w, h)
				MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
				draw.DrawText("Страница " .. s.page .. " / " .. s.maxpage, "MSDFont.20", w / 2, 8, color_white, TEXT_ALIGN_CENTER)
			end

			MSD.IconButton(row, MSD.Icons48.arrow_left, 5, 5, 25, nil, MSD.Config.MainColor.p, function()
				if row.page <= 1 then return end
				row.page = row.page - 1
				onPageChange(row.page)
			end)

			MSD.IconButton(row, MSD.Icons48.arrow_right, row:GetWide() - 30, 5, 25, nil, MSD.Config.MainColor.p, function()
				if row.page >= row.maxpage then return end
				row.page = row.page + 1
				onPageChange(row.page)
			end)

			return row
		end

		-- ---- Statistics sub-tab ----
		local statsz = warns_tab.addTab(slib.getLang("sadmin", sAdmin.config["language"], "statistics"), MSD.Icons48.badge_account_horizontal)
		local stats_list = vgui.Create("MSDPanelList", statsz)
		stats_list:SetSize(statsz:GetWide(), statsz:GetTall())
		stats_list:SetPos(0, 0)
		stats_list:EnableVerticalScrollbar()
		stats_list:EnableHorizontal(true)
		stats_list:SetSpacing(4)
		stats_list:SetPadding(5)
		stats_list.IgnoreVbar = true
		stats_list.Paint = function() end
		MSD.InfoHeader(stats_list, "Общая статистика")

		local function statBox(label, getter)
			local pn = vgui.Create("DPanel")

			pn.StaticScale = {
				w = 2,
				fixed_h = 70,
				minw = 200,
				minh = 70
			}

			pn.Paint = function(s, w, h)
				MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["d"])
				draw.DrawText(tostring(getter()), "MSDFont.25", w / 2, 10, MSD.Config.MainColor.p, TEXT_ALIGN_CENTER)
				draw.DrawText(label, "MSDFont.18", w / 2, 42, MSD.Text.l, TEXT_ALIGN_CENTER)
			end

			stats_list:AddItem(pn)
		end

		statBox(slib.getLang("sadmin", sAdmin.config["language"], "total_warns"), function() return string.Comma(sAdmin.warnsData.totalWarns or 0) end)
		statBox(slib.getLang("sadmin", sAdmin.config["language"], "total_punishments"), function() return string.Comma(sAdmin.warnsData.totalPunishments or 0) end)
		statBox(slib.getLang("sadmin", sAdmin.config["language"], "warns_this_week"), function() return string.Comma(sAdmin.warnsData.warnsThisWeek or 0) end)
		statBox(slib.getLang("sadmin", sAdmin.config["language"], "punishments_this_week"), function() return string.Comma(sAdmin.warnsData.punishmentsThisWeek or 0) end)
		-- ---- Punishment logs sub-tab ----
		local logs = warns_tab.addTab(slib.getLang("sadmin", sAdmin.config["language"], "punishment_logs"), MSD.Icons48.book)
		local logs_filter = ""
		local logs_list = vgui.Create("MSDPanelList", logs)
		logs_list:SetSize(logs:GetWide(), logs:GetTall() - 85)
		logs_list:SetPos(0, 45)
		logs_list:EnableVerticalScrollbar()
		logs_list:EnableHorizontal(true)
		logs_list:SetSpacing(2)
		logs_list.IgnoreVbar = false
		logs_list.Paint = function() end

		MSD.TextEntry(logs, 5, 5, logs:GetWide() - 10, 45, "", "Поиск", "", function(self, v)
			logs_filter = v or ""
			requestPage(1, 1, logs_filter)
		end, true)

		local logs_paginator = buildPaginator(logs, function(page)
			requestPage(1, page, logs_filter)
		end)

		local actionToLang = {
			[1] = "kick",
			[2] = "ban"
		}

		local function logs_addLine(v)
			local sid64 = v.sid64
			local label = (slib.findName(sid64, true) or sid64) .. "  —  " .. (v.active_warns or 0) .. " активных  —  " .. os.date("%H:%M:%S %d/%m/%Y", v.date_given) .. "  —  " .. slib.getLang("sadmin", sAdmin.config["language"], actionToLang[tonumber(v.action)] or "n/a")

			MSD.ButtonIcon(logs_list, "static", nil, 1, 50, label, MSD.Icons48.file_document, function()
				showWarnPlayerActions(logs_list, {
					sid64 = sid64
				})
			end)
		end

		sadmin_menu.punishmentLogs = {
			paginator = logs_paginator,
			clearChilds = function()
				logs_list:Clear()
			end,
			addLne = logs_addLine,
		}

		requestPage(1, 1, "")
		-- ---- Online players sub-tab ----
		local online_players = warns_tab.addTab(slib.getLang("sadmin", sAdmin.config["language"], "online_players"), MSD.Icons48.account)
		local on_filter = ""
		local on_list = vgui.Create("MSDPanelList", online_players)
		on_list:SetSize(online_players:GetWide(), online_players:GetTall() - 85)
		on_list:SetPos(0, 45)
		on_list:EnableVerticalScrollbar()
		on_list:EnableHorizontal(true)
		on_list:SetSpacing(2)
		on_list.IgnoreVbar = false
		on_list.Paint = function() end

		MSD.TextEntry(online_players, 5, 5, online_players:GetWide() - 10, 45, "", "Поиск", "", function(self, v)
			on_filter = v or ""
			requestPage(3, 1, on_filter)
		end, true)

		local on_paginator = buildPaginator(online_players, function(page)
			requestPage(3, page, on_filter)
		end)

		local function on_addLine(v)
			local label = (v.name or slib.findName(v.sid64, true) or v.sid64) .. "  —  " .. (v.total_warns or 0) .. " варнов"

			MSD.ButtonIcon(on_list, "static", nil, 1, 50, label, MSD.Icons48.account, function()
				showWarnPlayerActions(on_list, v)
			end)
		end

		sadmin_menu.onlineWarns = {
			paginator = on_paginator,
			refreshPage = function()
				requestPage(3, on_paginator.page, on_filter)
			end,
			clearChilds = function()
				on_list:Clear()
			end,
			addLne = on_addLine,
			IsVisible = function() return online_players:IsVisible() end,
		}

		-- ---- Offline players sub-tab (warns context) ----
		local offline_players = warns_tab.addTab(slib.getLang("sadmin", sAdmin.config["language"], "offline_players"), MSD.Icons48.account_cancel)
		local off_filter_w = ""
		local off_list_w = vgui.Create("MSDPanelList", offline_players)
		off_list_w:SetSize(offline_players:GetWide(), offline_players:GetTall() - 85)
		off_list_w:SetPos(0, 45)
		off_list_w:EnableVerticalScrollbar()
		off_list_w:EnableHorizontal(true)
		off_list_w:SetSpacing(2)
		off_list_w.IgnoreVbar = false
		off_list_w.Paint = function() end

		MSD.TextEntry(offline_players, 5, 5, offline_players:GetWide() - 10, 45, "", "Поиск", "", function(self, v)
			off_filter_w = v or ""
			requestPage(2, 1, off_filter_w)
		end, true)

		local off_paginator_w = buildPaginator(offline_players, function(page)
			requestPage(2, page, off_filter_w)
		end)

		local function off_addLine_w(v)
			local label = (v.name or slib.findName(v.sid64, true) or v.sid64) .. "  —  " .. (v.total_warns or 0) .. " варнов"

			MSD.ButtonIcon(off_list_w, "static", nil, 1, 50, label, MSD.Icons48.account_edit, function()
				showWarnPlayerActions(off_list_w, v)
			end)
		end

		sadmin_menu.offlineWarns = {
			paginator = off_paginator_w,
			refreshPage = function()
				requestPage(2, off_paginator_w.page, off_filter_w)
			end,
			clearChilds = function()
				off_list_w:Clear()
			end,
			addLne = off_addLine_w,
			IsVisible = function() return offline_players:IsVisible() end,
		}
	end

	-- =====================================================================
	-- Offline Players Tab (rebuilt with MSD UI). Paginated list of every
	-- player ever recorded by sAdmin. Click row -> action menu.
	-- =====================================================================
	local off_tab = sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "offline_players")]

	if IsValid(off_tab) then
		local off_filter = ""
		local off_list = vgui.Create("MSDPanelList", off_tab)
		off_list:SetSize(off_tab:GetWide(), off_tab:GetTall() - 85)
		off_list:SetPos(0, 45)
		off_list:EnableVerticalScrollbar()
		off_list:EnableHorizontal(true)
		off_list:SetSpacing(2)
		off_list.IgnoreVbar = false
		off_list.Paint = function() end

		MSD.TextEntry(off_tab, 5, 5, off_tab:GetWide() - 10, 45, "", "Поиск по имени или SteamID", "", function(self, v)
			off_filter = v or ""
			requestPage(0, 1, off_filter)
		end, true)

		local op_row = vgui.Create("DPanel", off_tab)
		op_row:SetSize(off_tab:GetWide(), 35)
		op_row:SetPos(0, off_tab:GetTall() - 35)
		op_row.page = 1
		op_row.maxpage = 1

		op_row.Paint = function(s, w, h)
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
			draw.DrawText("Страница " .. s.page .. " / " .. s.maxpage, "MSDFont.20", w / 2, 8, color_white, TEXT_ALIGN_CENTER)
		end

		MSD.IconButton(op_row, MSD.Icons48.arrow_left, 5, 5, 25, nil, MSD.Config.MainColor.p, function()
			if op_row.page <= 1 then return end
			op_row.page = op_row.page - 1
			requestPage(0, op_row.page, off_filter)
		end)

		MSD.IconButton(op_row, MSD.Icons48.arrow_right, op_row:GetWide() - 30, 5, 25, nil, MSD.Config.MainColor.p, function()
			if op_row.page >= op_row.maxpage then return end
			op_row.page = op_row.page + 1
			requestPage(0, op_row.page, off_filter)
		end)

		local function off_actions(info)
			local sid64 = info.sid64
			local menu = MSD.MenuOpen(false, off_list)

			menu:AddOption("Открыть профиль Steam", function()
				gui.OpenURL("https://steamcommunity.com/profiles/" .. sid64)
			end, MSD.Icons48.arrow_right)

			menu:AddOption("Скопировать имя", function()
				SetClipboardText(slib.findName(sid64) or "")
			end, MSD.Icons48.account)

			menu:AddOption("Скопировать SteamID", function()
				SetClipboardText(util.SteamIDFrom64(sid64))
			end, MSD.Icons48.dot)

			menu:AddOption("Скопировать SteamID64", function()
				SetClipboardText(sid64)
			end, MSD.Icons48.dot)

			menu:AddOption("Скопировать ранг", function()
				SetClipboardText(info.rank or "")
			end, MSD.Icons48.seal)

			menu:AddOption("Установить ранг", function()
				local pl, child = MSD.WorkSpacePanel(sadmin_menu.par or sadmin_menu, "Назначить ранг", 2.5, 2)
				local combo = MSD.ComboBox(child, 10, 50, child:GetWide() - 20, 35, "Ранг:", "")

				for _, r in ipairs(getUsergroupsSorted()) do
					combo:AddChoice(r, r)
				end

				local sel_rank = ""

				combo.OnSelect = function(self, idx, text, data)
					sel_rank = data or text
				end

				local time_val = ""

				MSD.TextEntry(child, 10, 95, child:GetWide() - 20, 35, "", "Срок (пусто = навсегда)", "", function(self, v)
					time_val = v
				end, true)

				MSD.BigButton(child, 10, 145, child:GetWide() - 20, 45, "Назначить", MSD.Icons48.check_all, function()
					if sel_rank == "" then return end
					RunConsoleCommand("sa", "setrankid", sid64, sel_rank, time_val)
					pl:Close()
				end)
			end, MSD.Icons48.seal)

			menu:Open(gui.MouseX(), gui.MouseY())
		end

		local function off_addLine(v)
			local timeLeft = math.max((tonumber(v.rank_expire) or 0) - os.time(), 0)
			local rank_str = v.rank .. (timeLeft > 0 and " (" .. sAdmin.formatTime(timeLeft) .. ")" or (tonumber(v.rank_expire) or 0) > 0 and " (просрочен)" or "")
			local label = (v.name or slib.findName(v.sid64, true) or v.sid64) .. "  —  " .. rank_str .. "  —  " .. sAdmin.formatTime(v.playtime, true)

			local pn = MSD.ButtonIcon(off_list, "static", nil, 1, 50, label, MSD.Icons48.account_edit, function()
				off_actions(v)
			end)

			offlineSid64ToPanel[v.sid64] = pn
		end

		sadmin_menu.offlinePlayers = {
			paginator = op_row,
			refreshPage = function()
				requestPage(0, op_row.page, off_filter)
			end,
			clearChilds = function()
				off_list:Clear()
			end,
			addLne = off_addLine,
			IsVisible = function() return off_tab:IsVisible() end,
		}

		requestPage(0, 1, "")
	end

	-- =====================================================================
	-- Ranks Tab (rebuilt with MSD UI)
	-- Left: rank list + search + add. Right: selected rank's permissions
	-- (base perms, command perms, sandbox limits) edited as MSD.BoolSlider.
	-- =====================================================================
	local ranks_tab = sadmin_menu.tab[slib.getLang("sadmin", sAdmin.config["language"], "ranks")]

	if IsValid(ranks_tab) then
		local rank_cols = laycols(ranks_tab, 2)
		local r_left, r_right = rank_cols[1], rank_cols[2]
		local selected_rank
		local rank_filter, perm_filter = "", ""
		local left_list, r_list
		local refreshLeft, refreshRight

		-- Networking the toggle of one permission for one rank.
		local function setPermVal(perm, val)
			if not selected_rank then return end
			net.Start("sA:Networking")
			net.WriteUInt(0, 3)
			net.WriteString(selected_rank)
			net.WriteString(perm)

			if isnumber(val) then
				net.WriteUInt(math.Clamp(val, 0, 511), 9)
			else
				net.WriteBool(tobool(val))
			end

			net.SendToServer()
		end

		refreshLeft = function()
			left_list:Clear()

			MSD.TextEntry(left_list, "static", nil, 1, 50, "", "Поиск ранга", rank_filter, function(self, v)
				rank_filter = string.lower(v or "")
				refreshLeft()
			end, true)

			MSD.ButtonIcon(left_list, "static", nil, 1, 50, "Создать ранг", MSD.Icons48.plus, function()
				local pl, child = MSD.WorkSpacePanel(sadmin_menu.par or sadmin_menu, "Создать ранг", 2.5, 2.5)
				local rn = ""

				MSD.TextEntry(child, 10, 55, child:GetWide() - 20, 45, "", "Название", "", function(self, v)
					rn = v
				end, true)

				MSD.BigButton(child, 10, 100, child:GetWide() - 20, 79, "Создать", MSD.Icons48.check_all, function()
					if rn == "" then return end
					networkRank(rn, true)
					pl:Close()
				end)
			end)

			MSD.InfoHeader(left_list, "Ранги")
			local list = getUsergroupsSorted()

			for _, rn in ipairs(list) do
				if rank_filter ~= "" and not string.find(string.lower(rn), rank_filter, 1, true) then continue end
				local pinned = rn
				local data = sAdmin.usergroups[rn] and sAdmin.usergroups[rn].permissions or {}
				local icon = MSD.Icons48.rank_low

				if data["is_staff"] then
					icon = MSD.Icons48.rank

					if tonumber(data["immunity"] or 0) > 50 then
						icon = MSD.Icons48.rank_sup
					end
				end

				if data["all_perms"] then
					icon = MSD.Icons48.seal
				end

				local btn = MSD.ButtonIcon(left_list, "static", nil, 1, 50, rn, icon, function()
					selected_rank = (selected_rank == pinned) and nil or pinned
					refreshRight()
					refreshLeft()
				end, function()
					local menu = MSD.MenuOpen(false, left_list)

					menu:AddOption("Удалить ранг", function()
						networkRank(pinned, false)
					end, MSD.Icons48.close_thick)

					menu:Open(gui.MouseX(), gui.MouseY())
				end)

				btn.PaintOver = function(s, w, h)
					if selected_rank == pinned then
						MSDX.Draw(0, 0, h - 2, w, 2, MSD.Config.MainColor.p)
					end
				end
			end
		end

		refreshRight = function()
			r_list:Clear()
			MSD.InfoHeader(r_list, "Выбран ранг: " .. (selected_rank or "—"))
			if not selected_rank then return end

			MSD.TextEntry(r_list, "static", nil, 1, 50, "", "Поиск прав", perm_filter, function(self, v)
				perm_filter = string.lower(v or "")
				refreshRight()
			end, true)

			local function permsRow(name, base, is_limit)
				if perm_filter ~= "" and not string.find(string.lower(name), perm_filter, 1, true) then return end
				local data = sAdmin.usergroups[selected_rank] and sAdmin.usergroups[selected_rank].permissions or {}
				local cur = data[name]

				if cur == nil and not base then
					cur = data["all_perms"]
				end

				local pd = sAdmin.getPermissiondata(name)

				-- Sandbox limits are always numeric, as are any perm registered
				-- with type == 0 (e.g. immunity).
				if is_limit or (pd and pd.type == 0) then
					local entry = MSD.TextEntry(r_list, "static", nil, 3, 50, "", name, tostring(tonumber(cur) or 0), function(self, v)
						setPermVal(name, tonumber(v) or 0)
					end, true, nil, nil, true)

					permissionNameToBox[name] = entry
				else
					local sw = MSD.BoolSlider(r_list, "static", nil, 1, 50, name, tobool(cur), function(self, val)
						setPermVal(name, val)
					end)

					permissionNameToBox[name] = sw
				end
			end

			MSD.InfoHeader(r_list, "Базовые права")

			for _, p in ipairs(sAdmin.base_Perms) do
				permsRow(p.name, true)
			end

			if sAdmin.limits and not table.IsEmpty(sAdmin.limits) then
				MSD.InfoHeader(r_list, "Лимиты Sandbox")

				for _, name in ipairs(sAdmin.limits) do
					permsRow(name, true, true)
				end
			end

			MSD.InfoHeader(r_list, "Права команд")
			-- Group by category
			local by_cat = {}

			for _, p in ipairs(sAdmin.permissions) do
				by_cat[p.category] = by_cat[p.category] or {}
				table.insert(by_cat[p.category], p.name)
			end

			local cats = {}

			for c in pairs(by_cat) do
				table.insert(cats, c)
			end

			table.sort(cats, function(a, b)
				local sa = categorySorting[a] or 999
				local sb = categorySorting[b] or 999
				if sa == sb then return a < b end

				return sa < sb
			end)

			for _, c in ipairs(cats) do
				MSD.InfoHeader(r_list, c)
				table.sort(by_cat[c])

				for _, name in ipairs(by_cat[c]) do
					permsRow(name, false)
				end
			end
		end

		left_list = vgui.Create("MSDPanelList", r_left)
		left_list:SetSize(r_left:GetWide() - 10, r_left:GetTall() - 10)
		left_list:SetPos(5, 5)
		left_list:EnableVerticalScrollbar()
		left_list:EnableHorizontal(true)
		left_list:SetSpacing(2)
		left_list:SetPadding(0)
		left_list.IgnoreVbar = true
		left_list.Paint = function() end
		r_list = vgui.Create("MSDPanelList", r_right)
		r_list:SetSize(r_right:GetWide() - 10, r_right:GetTall() - 10)
		r_list:SetPos(5, 5)
		r_list:EnableVerticalScrollbar()
		r_list:EnableHorizontal(true)
		r_list:SetSpacing(2)
		r_list:SetPadding(0)
		r_list.IgnoreVbar = false
		r_list.Paint = function() end

		sadmin_menu.nameToPanel["ranks_canvas"] = {
			refreshValues = refreshRight,
			refreshLeft = refreshLeft,
		}

		refreshLeft()
		refreshRight()
	end
end

-- Public alias so other addons (e.g. the MSD admin menu module) can open the
-- sAdmin menu directly without going through a chat command.
sAdmin.OpenMenu = openMenu

concommand.Add("sadmin_menu", function()
	RunConsoleCommand("say", "!menu")
end)

concommand.Add("xgui", function()
	RunConsoleCommand("say", "!menu")
end)

hook.Add("sA:NetworkReceived", "sA:UpdateData", function(args, data)
	if IsValid(sadmin_menu) then
		sAdmin.stats.totalStaffOnline = 0

		for k, v in ipairs(player.GetAll()) do
			if sAdmin.hasPermission(v, "is_staff") then
				sAdmin.stats.totalStaffOnline = sAdmin.stats.totalStaffOnline + 1
			end
		end

		local ply = LocalPlayer()

		if not sAdmin.hasPermission(ply, "menu") then
			sadmin_menu:SetVisible(false)
			sadmin_menu:setActiveTab(slib.getLang("sadmin", sAdmin.config["language"], "commands"))

			return
		end

		for name, pnl in pairs(sadmin_menu.tab) do
			if pnl.perm then
				local hasPerm = sAdmin.hasPermission(ply, pnl.perm)
				pnl.tabbttn:SetVisible(hasPerm)

				if sadmin_menu.seltab == name and not hasPerm then
					sadmin_menu:setActiveTab(slib.getLang("sadmin", sAdmin.config["language"], "commands"))
				end
			end
		end

		sadmin_menu.tabmenu:InvalidateChildren(true)
	end

	if args[1] == "usergroups" and args[3] == "permissions" and args[4] then
		local checkbox = permissionNameToBox[args[4]]
		if not IsValid(checkbox) then return end
		local usergroup = args[2]
		local newval = sAdmin.usergroups[usergroup] and sAdmin.usergroups[usergroup].permissions and sAdmin.usergroups[usergroup].permissions[args[4]] or false

		-- Push the new value into the MSD widget so it visually reflects state.
		if checkbox.var ~= nil then
			checkbox.var = tobool(newval)
		elseif isfunction(checkbox.SetValue) then
			checkbox:SetValue(tostring(newval or ""))
		end

		if args[4] == "all_perms" then
			for name, panel in pairs(permissionNameToBox) do
				if not IsValid(panel) then continue end
				local v = sAdmin.usergroups[usergroup] and sAdmin.usergroups[usergroup].permissions and sAdmin.usergroups[usergroup].permissions[name]

				if panel.var ~= nil then
					panel.var = tobool(v) or tobool(newval)
				end
			end
		end

		if args[4] == "immunity" and CAMI and CAMI.UnregisterUsergroup then
			CAMI.UnregisterUsergroup(args[2])
			sAdmin.registerCAMIGroup(args[2])
		end
	end

	if args[1] == "usergroups" then
		if #args == 1 and data then
			for k, v in pairs(data) do
				sAdmin.registerCAMIGroup(k)
			end
		elseif #args == 2 then
			if data then
				if not IsValid(sadmin_menu) then return end
				local ranks_canvas = sadmin_menu.nameToPanel and sadmin_menu.nameToPanel["ranks_canvas"]

				if ranks_canvas and isfunction(ranks_canvas.refreshLeft) then
					ranks_canvas.refreshLeft()
				end

				sAdmin.registerCAMIGroup(args[2])
			else
				local ranks_canvas = sadmin_menu and sadmin_menu.nameToPanel and sadmin_menu.nameToPanel["ranks_canvas"]

				if ranks_canvas and isfunction(ranks_canvas.refreshLeft) then
					ranks_canvas.refreshLeft()
				end

				if CAMI and CAMI.UnregisterUsergroup then
					CAMI.UnregisterUsergroup(args[2])
				end
			end
		end
	end

	if args[1] == "playerData" and #args == 1 then
		for k, v in pairs(sAdmin.playerData) do
			if not v.sid64 then continue end
			sAdmin.playerData[v.sid64] = v
			sAdmin.playerData[v.sid64].sid64 = nil
			sAdmin.playerData[k] = nil
		end
	end

	-- Warns popup viewer (MSD).
	if args[1] == "playerWarns" then
		local title = "Варны — " .. (data.name or "?")
		local pl = vgui.Create("MSDSimpleFrame")
		pl:SetSize(ScrW() * 0.5, ScrH() * 0.6)
		pl:Center()
		pl:MakePopup()

		pl.Paint = function(self, w, h)
			MSD.DrawBG(self, w, h)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, w, 50, MSD.Theme["d"])
			MSDX.Draw(MSD.Config.Rounded, 0, 52, w, h - 52, MSD.Theme["l"])
			draw.DrawText(title, "MSDFont.25", 15, 12, color_white, TEXT_ALIGN_LEFT)
		end

		MSD.IconButton(pl, MSD.Icons48.cross, pl:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor["r"], function()
			pl:Close()
		end)

		local lst = vgui.Create("MSDPanelList", pl)
		lst:SetPos(5, 55)
		lst:SetSize(pl:GetWide() - 10, pl:GetTall() - 60)
		lst:EnableVerticalScrollbar()
		lst:EnableHorizontal(true)
		lst:SetSpacing(2)
		lst.IgnoreVbar = false
		lst.Paint = function() end

		for _, v in ipairs(data) do
			local active = v.active == "1" or v.active == 1

			if (os.time() - (v.date_given or 0)) >= sAdmin.getTime(sAdmin.config["warns"]["active_time"]) then
				active = false
			end
			local pinned_v = v

			sAdmin.ButtonWarn(lst, "static", nil, 1, 50, v, function(s)
				local menu = MSD.MenuOpen(false, lst)

				menu:AddOption("Удалить варн", function()
					s:Remove()
					RunConsoleCommand("sa", "warn_remove", pinned_v.id)
				end, MSD.Icons48.close_thick)

				if active then
					menu:AddOption("Сделать неактивным", function()
						RunConsoleCommand("sa", "warn_setinactive", pinned_v.id)
					end, MSD.Icons48.lightbulb_outline)
				end

				menu:Open(gui.MouseX(), gui.MouseY())
			end)
		end
	end

	-- Helper to apply paginated data to one of the table-shaped list endpoints.
	local function applyPaged(endpoint, st)
		if not endpoint then return end
		endpoint.paginator.maxpage = math.max(st.total_pages or 0, 1)
		endpoint.paginator.page = tonumber(st.cur_page) or 1

		if endpoint.paginator.maxpage < endpoint.paginator.page then
			endpoint.paginator.page = 1
		end

		endpoint.clearChilds()

		for _, row in ipairs(st) do
			endpoint.addLne(row)
		end
	end

	if args[1] == "offlinePlayers" and #args == 1 and sadmin_menu and sadmin_menu.offlinePlayers then
		applyPaged(sadmin_menu.offlinePlayers, data)
	end

	if args[1] == "offlineWarns" and istable(data) and sadmin_menu and sadmin_menu.offlineWarns then
		applyPaged(sadmin_menu.offlineWarns, data)
	end

	if args[1] == "onlineWarns" and istable(data) and sadmin_menu and sadmin_menu.onlineWarns then
		applyPaged(sadmin_menu.onlineWarns, data)
	end

	if args[1] == "punishmentLogs" and sadmin_menu and sadmin_menu.punishmentLogs then
		applyPaged(sadmin_menu.punishmentLogs, data)
	end
end)

hook.Add("OnEntityCreated", "sA:DetectConnect", function(ent)
	if ent:IsPlayer() then
		local sid64 = ent:SteamID64()
		local panel = offlineSid64ToPanel[sid64]

		if IsValid(panel) then
			panel:SetVisible(false)
		end

		if IsValid(sadmin_menu) and sadmin_menu.players_list and sadmin_menu.players_list.Repopulate then
			sadmin_menu.players_list.Repopulate()
		end

		if sadmin_menu and sadmin_menu.onlineWarns then
			sAdmin.onlineWarns.refresh = true
		end

		if sadmin_menu and sadmin_menu.offlineWarns then
			sAdmin.offlineWarns.refresh = true
		end

		if sadmin_menu and sadmin_menu.offlinePlayers then
			sAdmin.offlinePlayers.refresh = true
		end
	end
end)

hook.Add("OnRemove", "sA:DetectDisconnect", function(ent)
	if ent:IsPlayer() then
		local sid64 = ent:SteamID64()
		local panel = offlineSid64ToPanel[sid64]

		if IsValid(panel) then
			panel:SetVisible(true)
		end
	end
end)

hook.Add("PlayerNoClip", "sA:FixVisualBug", function() return false end) -- We check it only on serverside.

net.Receive("sA:Networking", function()
	local action = net.ReadUInt(3)

	if action == 0 then
		if GetConVar("FPP_PrivateSettings_HideOwner"):GetInt() == 1 then return end
		local var = net.ReadString()
		local info = util.JSONToTable(net.ReadString())
		local final = sAdmin.niceDisplayText(var, info)
		chat.AddText(sAdmin.config["chat_prefix"][1], sAdmin.config["chat_prefix"][2], unpack(final))

		if not sAdmin.hasPermission(LocalPlayer(), "is_staff") then
			MSD.PlaySnd("mqs/notify/1_1.mp3", 2)
		end
	elseif action == 1 then
		local compressed = net.ReadBool()
		local json

		if compressed then
			local len = net.ReadUInt(32)
			json = util.Decompress(net.ReadData(len))
		else
			json = net.ReadString()
		end

		local data = util.JSONToTable(json)
		local args = data.args
		local destination = sAdmin

		for k, v in ipairs(args) do
			destination[v] = #args > k and (destination[v] or {}) or data.data
			destination = destination[v]
		end

		hook.Run("sA:NetworkReceived", args, data.data)
	elseif action == 2 then
		openMenu()
	end
end)

net.Receive("sA:GetAdminData", function()
	local bn = net.ReadUInt(32)
	local tb = DarkRP.TableDecompress(net.ReadData(bn))
	if not tb then return end
	sAdmin.requests = tb

	timer.Simple(0.1, function()
		if IsValid(MSD.ReqeustMenu) and MSD.ReqeustMenu.UpdateRM then
			MSD.ReqeustMenu.UpdateRM()
		end
	end)
end)

FSpectate = {}
local stopSpectating, startFreeRoam
local isSpectating = false
local specEnt
local thirdperson = true
local isRoaming = false
local roamPos -- the position when roaming free
local roamVelocity = Vector(0)
local thirdPersonDistance = 100

--[[---------------------------------------------------------------------------
Retrieve the current spectated player
---------------------------------------------------------------------------]]
function FSpectate.getSpecEnt()
	if isSpectating and not isRoaming then
		return IsValid(specEnt) and specEnt or nil
	else
		return nil
	end
end

--[[---------------------------------------------------------------------------
startHooks
FAdmin tab buttons
---------------------------------------------------------------------------]]
hook.Add("Initialize", "FSpectate", function()
	surface.CreateFont("UiBold", {
		size = 16,
		weight = 800,
		antialias = true,
		shadow = false,
		font = "Default"
	})

	if not FAdmin then return end

	FAdmin.StartHooks["zzSpectate"] = function()
		FAdmin.Commands.AddCommand("Spectate", nil, "<Player>")

		-- Right click option
		FAdmin.ScoreBoard.Main.AddPlayerRightClick("Spectate", function(ply)
			if not IsValid(ply) then return end
			RunConsoleCommand("rp_spec", ply:UserID())
		end)

		local canSpectate = false

		local function calcAccess()
			CAMI.PlayerHasAccess(LocalPlayer(), "FSpectate", function(b, _)
				canSpectate = b
			end)
		end

		calcAccess()

		-- Spectate option in player menu
		FAdmin.ScoreBoard.Player:AddActionButton("Spectate", "fadmin/icons/spectate", Color(0, 200, 0, 255), function(ply)
			calcAccess()

			return canSpectate and ply ~= LocalPlayer()
		end, function(ply)
			if not IsValid(ply) then return end
			RunConsoleCommand("rp_spec", ply:UserID())
		end)
	end
end)

--[[---------------------------------------------------------------------------
Get the thirdperson position
---------------------------------------------------------------------------]]
local function getThirdPersonPos(ent)
	local aimvector = LocalPlayer():GetAimVector()
	local startPos = ent:IsPlayer() and ent:GetShootPos() or ent:LocalToWorld(ent:OBBCenter())
	local endpos = startPos - aimvector * thirdPersonDistance

	local tracer = {
		start = startPos,
		endpos = endpos,
		filter = specEnt
	}

	local trace = util.TraceLine(tracer)

	return trace.HitPos + trace.HitNormal * 10
end

--[[---------------------------------------------------------------------------
Get the CalcView table
---------------------------------------------------------------------------]]
local view = {}

local function getCalcView()
	if not isRoaming then
		if thirdperson then
			view.origin = getThirdPersonPos(specEnt)
			view.angles = LocalPlayer():EyeAngles()
		else
			view.origin = specEnt:IsPlayer() and specEnt:GetShootPos() or specEnt:LocalToWorld(specEnt:OBBCenter())
			view.angles = specEnt:IsPlayer() and specEnt:EyeAngles() or specEnt:GetAngles()
		end

		roamPos = view.origin
		view.drawviewer = false

		return view
	end

	view.origin = roamPos
	view.angles = LocalPlayer():EyeAngles()
	view.drawviewer = true

	return view
end

--[[---------------------------------------------------------------------------
specCalcView
Override the view for the player to look through the spectated player's eyes
---------------------------------------------------------------------------]]
local function specCalcView(ply, origin, angles, fov)
	if not IsValid(specEnt) and not isRoaming then
		startFreeRoam()

		return
	end

	view = getCalcView()

	if IsValid(specEnt) then
		specEnt:SetNoDraw(not thirdperson)
	end

	return view
end

--[[---------------------------------------------------------------------------
Find the right player to spectate
---------------------------------------------------------------------------]]
local function findNearestObject()
	local aimvec = LocalPlayer():GetAimVector()
	local fromPos = not isRoaming and IsValid(specEnt) and specEnt:EyePos() or roamPos
	local lookingAt = util.QuickTrace(fromPos, aimvec * 5000, LocalPlayer())
	local ent = lookingAt.Entity
	if IsValid(ent) then return ent end
	local foundPly, foundDot = nil, 0

	for _, ply in ipairs(player.GetAll()) do
		if not IsValid(ply) or ply == LocalPlayer() then continue end
		local pos = ply:GetShootPos()
		local dot = (pos - fromPos):GetNormalized():Dot(aimvec)
		-- Discard players you're not looking at
		if dot < 0.97 then continue end
		-- not a better alternative
		if dot < foundDot then continue end
		local trace = util.QuickTrace(fromPos, pos - fromPos, ply)
		if trace.Hit then continue end
		foundPly, foundDot = ply, dot
	end

	return foundPly
end

--[[---------------------------------------------------------------------------
Spectate the person you're looking at while you're roaming
---------------------------------------------------------------------------]]
local function spectateLookingAt()
	local obj = findNearestObject()
	if not IsValid(obj) then return end
	isRoaming = false
	specEnt = obj
	net.Start("FSpectateTarget")
	net.WriteEntity(obj)
	net.SendToServer()
end

--[[---------------------------------------------------------------------------
specBinds
Change binds to perform spectate specific tasks
---------------------------------------------------------------------------]]
-- Manual keysDown table, so I can return true in plyBindPress and still detect key presses
local keysDown = {}

local function specBinds(ply, bind, pressed)
	local key = input.LookupBinding(bind)

	if bind == "+jump" then
		stopSpectating()

		return true
	elseif bind == "+attack" and pressed then
		if not isRoaming then
			startFreeRoam()
		else
			spectateLookingAt()
		end

		return true
	elseif bind == "+attack2" and pressed then
		if isRoaming then
			roamPos = roamPos + LocalPlayer():GetAimVector() * 500

			return true
		end

		thirdperson = not thirdperson

		return true
	elseif isRoaming and not LocalPlayer():KeyDown(IN_USE) then
		local keybind = string.lower(string.match(bind, "+([a-z A-Z 0-9]+)") or "")
		if not keybind or keybind == "use" or keybind == "showscores" or string.find(bind, "messagemode") then return end
		keysDown[keybind:upper()] = pressed

		return true
	elseif not isRoaming and thirdperson and (key == "MWHEELDOWN" or key == "MWHEELUP") then
		thirdPersonDistance = thirdPersonDistance + 10 * (key == "MWHEELDOWN" and 1 or -1)
	end
	-- Do not return otherwise, spectating admins should be able to move to avoid getting detected
end

--[[---------------------------------------------------------------------------
RenderScreenspaceEffects
Draws the lines from players' eyes to where they are looking
---------------------------------------------------------------------------]]
local LineMat = Material("cable/new_cable_lit")
local linesToDraw = {}

local function lookingLines()
	if not linesToDraw[0] then return end
	render.SetMaterial(LineMat)
	cam.Start3D(view.origin, view.angles)

	for i = 0, #linesToDraw, 3 do
		render.DrawBeam(linesToDraw[i], linesToDraw[i + 1], 4, 0.01, 10, linesToDraw[i + 2])
	end

	cam.End3D()
end

--[[---------------------------------------------------------------------------
gunpos
Gets the position of a player's gun
---------------------------------------------------------------------------]]
local function gunpos(ply)
	local wep = ply:GetActiveWeapon()
	if not IsValid(wep) then return ply:EyePos() end
	local att = wep:GetAttachment(1)
	if not att then return ply:EyePos() end

	return att.Pos
end

--[[---------------------------------------------------------------------------
Spectate think
Free roaming position updates
---------------------------------------------------------------------------]]
local function specThink()
	local ply = LocalPlayer()
	-- Update linesToDraw
	local pls = player.GetAll()
	local lastPly = 0
	local skip = 0

	for i = 0, #pls - 1 do
		local p = pls[i + 1]
		if not IsValid(p) then continue end

		if not isRoaming and p == specEnt and not thirdperson then
			skip = skip + 3
			continue
		end

		local tr = p:GetEyeTrace()
		local sp = gunpos(p)
		local pos = i * 3 - skip
		linesToDraw[pos] = tr.HitPos
		linesToDraw[pos + 1] = sp
		linesToDraw[pos + 2] = team.GetColor(p:Team())
		lastPly = i
	end

	-- Remove entries from linesToDraw that don't match with a player anymore
	for i = #linesToDraw, lastPly * 3 + 3, -1 do
		linesToDraw[i] = nil
	end

	if not isRoaming or keysDown["USE"] then return end
	local roamSpeed = 1000
	local aimVec = ply:GetAimVector()
	local direction
	local frametime = RealFrameTime()

	if keysDown["FORWARD"] then
		direction = aimVec
	elseif keysDown["BACK"] then
		direction = -aimVec
	end

	if keysDown["MOVELEFT"] then
		local right = aimVec:Angle():Right()
		direction = direction and (direction - right):GetNormalized() or -right
	elseif keysDown["MOVERIGHT"] then
		local right = aimVec:Angle():Right()
		direction = direction and (direction + right):GetNormalized() or right
	end

	if keysDown["SPEED"] then
		roamSpeed = 2500
	elseif keysDown["WALK"] or keysDown["DUCK"] then
		roamSpeed = 300
	end

	roamVelocity = (direction or Vector(0, 0, 0)) * roamSpeed
	roamPos = roamPos + roamVelocity * frametime
end

--[[---------------------------------------------------------------------------
Draw help on the screen
---------------------------------------------------------------------------]]
local uiForeground, uiBackground = Color(240, 240, 255, 255), Color(20, 20, 20, 120)
local red = Color(255, 0, 0, 255)

local function drawHelp()
	local scrHalfH = math.floor(ScrH() / 2)
	draw.WordBox(2, 10, scrHalfH, "ЛКМ - переключить наблюдение", "UiBold", uiBackground, uiForeground)
	draw.WordBox(2, 10, scrHalfH + 20, isRoaming and "ПКМ - телепорт вперед" or "ПКМ - переключить вид", "UiBold", uiBackground, uiForeground)
	draw.WordBox(2, 10, scrHalfH + 40, "Пробел - закрыть", "UiBold", uiBackground, uiForeground)
	local target = findNearestObject()
	local pls = player.GetAll()

	for i = 1, #pls do
		local ply = pls[i]
		if not IsValid(ply) then continue end
		if not isRoaming and ply == specEnt then continue end
		local pos = ply:GetShootPos():ToScreen()
		if not pos.visible then continue end
		local x, y = pos.x, pos.y
		MSDX.Draw(2, x, y - 6, 12, 12, team.GetColor(ply:Team()))
		draw.WordBox(2, x, y - 66, ply:SteamName(), "MSDFont.18", uiBackground, uiForeground)
		draw.WordBox(2, x, y - 46, ply:FullName() .. " | Hp: " .. ply:Health(), "MSDFont.16", uiBackground, uiForeground)
	end

	if not isRoaming then return end
	if not IsValid(target) then return end
	local center = target:LocalToWorld(target:OBBCenter())
	local eyeAng = EyeAngles()
	local rightUp = eyeAng:Right() * 16 + eyeAng:Up() * 36
	local topRight = (center + rightUp):ToScreen()
	local bottomLeft = (center - rightUp):ToScreen()
	MSDX.Draw(12, bottomLeft.x, bottomLeft.y, math.max(20, topRight.x - bottomLeft.x), topRight.y - bottomLeft.y, red)
	draw.WordBox(2, bottomLeft.x, bottomLeft.y + 12, "ЛКМ - наблюдать", "UiBold", uiBackground, uiForeground)
end

--[[---------------------------------------------------------------------------
Start roaming free, rather than spectating a given player
---------------------------------------------------------------------------]]
startFreeRoam = function()
	if IsValid(specEnt) and specEnt:IsPlayer() then
		roamPos = thirdperson and getThirdPersonPos(specEnt) or specEnt:GetShootPos()
		specEnt:SetNoDraw(false)
	else
		roamPos = isSpectating and roamPos or LocalPlayer():GetShootPos()
	end

	specEnt = nil
	isRoaming = true
	keysDown = {}
end

--[[---------------------------------------------------------------------------
specEnt
Spectate a player
---------------------------------------------------------------------------]]
local function startSpectate(um)
	isRoaming = net.ReadBool()
	specEnt = net.ReadEntity()
	specEnt = IsValid(specEnt) and specEnt or nil

	if isRoaming then
		startFreeRoam()
	end

	isSpectating = true
	keysDown = {}
	hook.Add("CalcView", "FSpectate", specCalcView)
	hook.Add("PlayerBindPress", "FSpectate", specBinds)
	hook.Add("ShouldDrawLocalPlayer", "FSpectate", function() return isRoaming or thirdperson end)
	hook.Add("Think", "FSpectate", specThink)
	hook.Add("HUDPaint", "FSpectate", drawHelp)
	hook.Add("RenderScreenspaceEffects", "FSpectate", lookingLines)

	timer.Create("FSpectatePosUpdate", 0.5, 0, function()
		if not isRoaming then return end
		RunConsoleCommand("_specupd", roamPos.x, roamPos.y, roamPos.z)
	end)
end

net.Receive("FSpectate", startSpectate)

--[[---------------------------------------------------------------------------
stopSpectating
Stop spectating a player
---------------------------------------------------------------------------]]
stopSpectating = function()
	hook.Remove("CalcView", "FSpectate")
	hook.Remove("PlayerBindPress", "FSpectate")
	hook.Remove("ShouldDrawLocalPlayer", "FSpectate")
	hook.Remove("Think", "FSpectate")
	hook.Remove("HUDPaint", "FSpectate")
	hook.Remove("RenderScreenspaceEffects", "FSpectate")
	timer.Remove("FSpectatePosUpdate")

	if IsValid(specEnt) then
		specEnt:SetNoDraw(false)
	end

	RunConsoleCommand("end_spect")
	isSpectating = false
end