--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/reports/cl.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local clrs = {
	nypd = Color(27, 39, 150),
	fdny = Color(83, 0, 0),
}

local function recipientName(strKey)
	local tblRec = Slawer.Mayor.CFG.Reports.Recipients[strKey]

	return tblRec and tblRec.name or strKey or "?"
end

-- Read / unread state is tracked locally per player and persisted to the client's
-- data folder. Each player gets their own file (named by SteamID64) holding a flat
-- map of reportId -> true, so reading progress survives reconnects. (SteamID64 is
-- kept in the filename, never as a JSON key, where its precision would be lost.)
local strReadDir = "slawer_mayor_reports_read"

if not file.Exists(strReadDir, "DATA") then
	file.CreateDir(strReadDir)
end

local tblReadCache
local strReadSID

local function readStatePath()
	return strReadDir .. "/" .. (LocalPlayer():SteamID64() or "unknown") .. ".json"
end

local function loadReadState()
	local strSID = LocalPlayer():SteamID64() or "unknown"

	-- (Re)load on first access or if the local player changed.
	if not tblReadCache or strReadSID ~= strSID then
		strReadSID = strSID
		tblReadCache = {}

		local strPath = readStatePath()

		if file.Exists(strPath, "DATA") then
			tblReadCache = util.JSONToTable(file.Read(strPath, "DATA") or "") or {}
		end
	end

	return tblReadCache
end

local function isReportRead(strID)
	return loadReadState()[strID] == true
end

local function markReportRead(strID)
	local tblState = loadReadState()

	if not strID or tblState[strID] then return end

	tblState[strID] = true
	file.Write(readStatePath(), util.TableToJSON(tblState))
end

function Slawer.Mayor:ShowReports(pnlContent)
	local strDept, tblDept = Slawer.Mayor:GetReportDept(LocalPlayer())
	if not tblDept then return end

	local main = vgui.Create("WINPanelList", pnlContent)
	main:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 35)
	main:SetPos(2, 30)
	function main:Paint(w, h)
		MSDX.Draw(0, 0, 0, w, h, clrs[strDept] or clrs.nypd)
		MSDX.Draw(0, 0, 0, w, 65, color_black)

		draw.SimpleText("Служебная почта", "Roman.25", 5, 16, color_white, TEXT_ALIGN_LEFT, 1)
	end

	local scroll = vgui.Create("WINPanelList", pnlContent)
	scroll:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 110)
	scroll:SetPos(2, 105)
	scroll:EnableVerticalScrollbar()
	scroll:EnableHorizontal(true)
	scroll:SetSpacing(5)
	scroll:SetPadding(5)
	scroll.IgnoreVbar = true

	main.pages = {}
	Slawer.Mayor.UPD = scroll

	local fw = pnlContent:GetWide() - 4
	local btnW = fw * 0.25 - 2

	local inboxBtn = Win98.ButtonBlack(main, "Входящие", "Roman.22", "homepage_alt", btnW, 34, function()
		Slawer.Mayor:NetStart("Reports.Get")
		main.pages["list"]()
	end)
	inboxBtn:SetPos(fw * 0.5, 2)
	inboxBtn.tc = color_black
	inboxBtn.pbg = function(s, w, h)
		surface.SetDrawColor(Win98.Cls.gray)
		surface.DrawRect(0, 0, w, h)
		Win98.InnerRec(1, 1, w - 2, h - 2)
	end

	local composeBtn = Win98.ButtonBlack(main, "Новый", "Roman.22", "envelope_closed-0", btnW, 34, function()
		main.pages["compose"]()
	end)
	composeBtn:SetPos(fw * 0.75, 2)
	composeBtn.tc = color_black
	composeBtn.pbg = function(s, w, h)
		surface.SetDrawColor(Win98.Cls.gray)
		surface.DrawRect(0, 0, w, h)
		Win98.InnerRec(1, 1, w - 2, h - 2)
	end

	-- Filter / grouping state (persists across list rebuilds).
	local strSearch, strThemeFilter, bGroupByCreator = "", nil, false
	local filterBar

	local function rebuildList()
		if scroll["list"] then scroll["list"]() end
	end

	-- The filter bar lives outside the scroll, so rebuilding the list never
	-- steals focus from the search box.
	local function buildFilterBar()
		if IsValid(filterBar) then return end

		filterBar = vgui.Create("DPanel", pnlContent)
		filterBar:SetPos(2, 68)
		filterBar:SetSize(fw, 34)
		filterBar.Paint = nil

		Win98.TextEntry(filterBar, 0, 0, fw * 0.5 - 4, 34, "Поиск по рапортам...", "", strSearch, function(s)
			strSearch = string.Trim((IsValid(s) and s:GetValue()) or "")
			rebuildList()
		end, true, nil, false)

		local themeBtn = vgui.Create("DButton", filterBar)
		themeBtn:SetPos(fw * 0.5, 0)
		themeBtn:SetSize(btnW, 34)
		themeBtn:SetText("")
		function themeBtn:Paint(w, h)
			surface.SetDrawColor(Win98.Cls.gray)
			surface.DrawRect(0, 0, w, h)
			Win98.InnerRec(1, 1, w - 2, h - 2)
			draw.SimpleText("Тема: " .. (strThemeFilter or "все"), "Roman.20", w / 2, h / 2, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function themeBtn:DoClick()
			surface.PlaySound("win/click.wav")

			local Menu = DermaMenu(self)
			Menu:SetSkin("GMod98")
			Menu:AddOption("Все темы", function()
				strThemeFilter = nil
				rebuildList()
			end)

			local seen = {}
			for _, r in ipairs(Slawer.Mayor.Reports.Cache or {}) do
				local strTheme = r.theme or r.title
				if strTheme and strTheme ~= "" and not seen[strTheme] then
					seen[strTheme] = true
					Menu:AddOption(strTheme, function()
						strThemeFilter = strTheme
						rebuildList()
					end)
				end
			end

			local mx, my = self:LocalToScreen(0, self:GetTall())
			Menu:SetMinimumWidth(self:GetWide())
			Menu:Open(mx, my, false, self)
		end

		local groupBtn = vgui.Create("DButton", filterBar)
		groupBtn:SetPos(fw * 0.75, 0)
		groupBtn:SetSize(btnW, 34)
		groupBtn:SetText("")
		function groupBtn:Paint(w, h)
			surface.SetDrawColor(Win98.Cls.gray)
			surface.DrawRect(0, 0, w, h)
			Win98.InnerRec(1, 1, w - 2, h - 2)
			draw.SimpleText(bGroupByCreator and "Группа: отправитель" or "Группа: статус", "Roman.20", w / 2, h / 2, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function groupBtn:DoClick()
			surface.PlaySound("win/click.wav")
			bGroupByCreator = not bGroupByCreator
			rebuildList()
		end
	end

	main.pages["list"] = function()
		buildFilterBar()
		if IsValid(filterBar) then filterBar:SetVisible(true) end
		scroll:Clear()

		local tblAll = Slawer.Mayor.Reports.Cache or {}
		-- utf8.search normalises case (incl. Cyrillic) and lookalike characters.
		local strQuery = utf8.search(strSearch)
		local tblFiltered = {}

		for _, tblReport in ipairs(tblAll) do
			local strTheme = tblReport.theme or tblReport.title

			-- Theme filter.
			if strThemeFilter and strTheme ~= strThemeFilter then continue end

			-- Search: any similar text across the report's fields.
			if strQuery ~= "" then
				local strHay = utf8.search(table.concat({
					tblReport.title or "",
					tblReport.body or "",
					tblReport.fromname or "",
					strTheme or "",
					recipientName(tblReport.to),
				}, "\n"))

				if not string.find(strHay, strQuery, 1, true) then continue end
			end

			tblFiltered[#tblFiltered + 1] = tblReport
		end

		if #tblFiltered == 0 then
			Win98.InfoTextF1(scroll, #tblAll == 0 and "Нет доступных рапортов" or "Ничего не найдено", scroll:GetWide() - 10, "Roman.32", color_white, color_black)

			return
		end

		local function addReportRow(tblReport)
			local bRead = isReportRead(tblReport.id)

			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 90)
			function pnl:Paint(w, h)
				surface.SetDrawColor(color_black)
				surface.DrawRect(0, 0, w, h)

				if not bRead then
					surface.SetDrawColor(Slawer.Mayor.Colors.Green)
					surface.DrawRect(0, 0, 6, h)
				end

				draw.DrawText(tblReport.title or "", "Roman.28", 14, 8, bRead and Slawer.Mayor.Colors.LightGrey or color_white, TEXT_ALIGN_LEFT)
				draw.DrawText("От: " .. (tblReport.fromname or "?") .. "   Кому: " .. recipientName(tblReport.to), "Roman.18", 14, 38, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText(os.date("%d %B %H:%M", tblReport.time or 0), "Roman.18", 14, 62, Slawer.Mayor.Colors.LightGrey, TEXT_ALIGN_LEFT)
			end

			local viewBtn = Win98.ButtonBlack(pnl, bRead and "Открыть" or "Прочитать", "Roman.22", "directory_open_file_mydocs_small-4", 200, 40, function()
				main.pages["view"](tblReport)
			end)
			viewBtn:SetPos(pnl:GetWide() - 200, 40)

			scroll:AddItem(pnl)
		end

		if bGroupByCreator then
			-- Group by report creator.
			table.sort(tblFiltered, function(a, b)
				local strA, strB = a.fromname or "", b.fromname or ""
				if strA ~= strB then return strA < strB end

				return (a.time or 0) > (b.time or 0)
			end)

			local strLastFrom

			for _, tblReport in ipairs(tblFiltered) do
				if strLastFrom ~= tblReport.from then
					strLastFrom = tblReport.from
					Win98.InfoTextF1(scroll, "Отправитель: " .. (tblReport.fromname or "?"), scroll:GetWide() - 10, "Roman.30", color_white, color_black)
				end

				addReportRow(tblReport)
			end
		else
			-- Group by read status: unread first, newest first within each group.
			table.sort(tblFiltered, function(a, b)
				local bReadA, bReadB = isReportRead(a.id), isReportRead(b.id)
				if bReadA ~= bReadB then return not bReadA end

				return (a.time or 0) > (b.time or 0)
			end)

			local bLastGroup

			for _, tblReport in ipairs(tblFiltered) do
				local bRead = isReportRead(tblReport.id)

				if bLastGroup ~= bRead then
					bLastGroup = bRead
					Win98.InfoTextF1(scroll, bRead and "Прочитанные" or "Непрочитанные", scroll:GetWide() - 10, "Roman.30", color_white, color_black)
				end

				addReportRow(tblReport)
			end
		end
	end
	scroll["list"] = main.pages["list"]

	-- Single report view.
	main.pages["view"] = function(tblReport)
		if IsValid(filterBar) then filterBar:SetVisible(false) end
		markReportRead(tblReport.id)
		scroll:Clear()

		Win98.InfoTextF1(scroll, tblReport.title or "", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
		Win98.InfoTextF1(scroll, "От: " .. (tblReport.fromname or "?"), scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		Win98.InfoTextF1(scroll, "Кому: " .. recipientName(tblReport.to), scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		Win98.InfoTextF1(scroll, "Дата: " .. os.date("%d %B %H:%M", tblReport.time or 0), scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		Win98.InfoTextF1(scroll, tblReport.body or "", scroll:GetWide() - 10, "Roman.24", color_white, color_black)

		if Slawer.Mayor:CanDeleteReport(LocalPlayer(), tblReport) then
			local deleteBtn = Win98.ButtonBlack(scroll, "Удалить рапорт", "Roman.22", "msg_error-0", scroll:GetWide() - 10, 45, function()
				Slawer.Mayor:NetStart("Reports.Delete", { id = tblReport.id })
				main.pages["list"]()
			end)
			scroll:AddItem(deleteBtn)
		end

		local backBtn = Win98.ButtonBlack(scroll, "Назад", "Roman.22", "homepage_alt", scroll:GetWide() - 10, 45, function()
			main.pages["list"]()
		end)
		scroll:AddItem(backBtn)
	end

	-- Compose a new report.
	main.pages["compose"] = function()
		if IsValid(filterBar) then filterBar:SetVisible(false) end
		scroll:Clear()

		local tblRecipients = Slawer.Mayor:GetReportRecipients(strDept)

		if table.IsEmpty(tblRecipients) then
			Win98.InfoTextF1(scroll, "Для вашего ведомства не настроены получатели рапортов", scroll:GetWide() - 10, "Roman.32", color_white, color_black)

			return
		end

		local strSelectedRec
		local strSelectedTheme
		local strCustom, strBody = "", ""
		local customEntry

		-- Recipient
		Win98.InfoTextF1(scroll, "Кому адресован рапорт:", scroll:GetWide() - 10, "Roman.28", color_white, color_black)

		local recPick = vgui.Create("DButton", scroll)
		recPick:SetSize(scroll:GetWide() - 10, 45)
		recPick:SetText("")
		function recPick:Paint(w, h)
			surface.SetDrawColor(Win98.Cls.gray)
			surface.DrawRect(0, 0, w, h)
			Win98.InnerRec(1, 1, w - 2, h - 2)

			local strLabel = strSelectedRec and recipientName(strSelectedRec) or "— выберите получателя —"
			draw.SimpleText(strLabel, "Roman.26", w / 2, h / 2, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function recPick:DoClick()
			surface.PlaySound("win/click.wav")

			local Menu = DermaMenu(self)
			Menu:SetSkin("GMod98")

			for strID, tblRec in SortedPairsByMemberValue(tblRecipients, "name") do
				Menu:AddOption(tblRec.name, function()
					strSelectedRec = strID

					-- Reset the theme whenever the recipient changes.
					strSelectedTheme = nil
					if IsValid(customEntry) then customEntry:SetVisible(false) end
					scroll:InvalidateLayout()
				end)
			end

			local mx, my = self:LocalToScreen(0, self:GetTall())
			Menu:SetMinimumWidth(self:GetWide())
			Menu:Open(mx, my, false, self)
		end
		scroll:AddItem(recPick)

		-- Theme (options come from the chosen recipient)
		Win98.InfoTextF1(scroll, "Тема рапорта:", scroll:GetWide() - 10, "Roman.28", color_white, color_black)

		local themePick = vgui.Create("DButton", scroll)
		themePick:SetSize(scroll:GetWide() - 10, 45)
		themePick:SetText("")
		function themePick:Paint(w, h)
			surface.SetDrawColor(Win98.Cls.gray)
			surface.DrawRect(0, 0, w, h)
			Win98.InnerRec(1, 1, w - 2, h - 2)

			local strLabel = strSelectedTheme or (strSelectedRec and "— выберите тему —" or "— сначала выберите получателя —")
			draw.SimpleText(strLabel, "Roman.26", w / 2, h / 2, color_black, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
		end
		function themePick:DoClick()
			if not strSelectedRec then
				surface.PlaySound("buttons/button10.wav")
				notification.AddLegacy("Сначала выберите получателя", NOTIFY_ERROR, 4)

				return
			end

			surface.PlaySound("win/click.wav")

			local Menu = DermaMenu(self)
			Menu:SetSkin("GMod98")

			for _, strTheme in ipairs(tblRecipients[strSelectedRec].themes or {}) do
				Menu:AddOption(strTheme, function()
					strSelectedTheme = strTheme

					-- The custom subject box only matters for the free theme.
					if IsValid(customEntry) then
						customEntry:SetVisible(strTheme == Slawer.Mayor.CFG.Reports.FreeTheme)
					end
					scroll:InvalidateLayout()
				end)
			end

			local mx, my = self:LocalToScreen(0, self:GetTall())
			Menu:SetMinimumWidth(self:GetWide())
			Menu:Open(mx, my, false, self)
		end
		scroll:AddItem(themePick)

		-- Custom subject (hidden unless the free theme is picked)
		customEntry = Win98.TextEntry(scroll, "static", nil, 1, 40, "Своя тема...", "", "", function(s, value)
			strCustom = value
		end, true, nil, false)
		customEntry:SetVisible(false)

		-- Body
		Win98.InfoTextF1(scroll, "Текст рапорта:", scroll:GetWide() - 10, "Roman.28", color_white, color_black)
		Win98.TextEntry(scroll, "static", nil, 1, 220, "Текст рапорта...", "", "", function(s, value)
			strBody = value
		end, true, nil, true)

		local sendBtn = Win98.ButtonBlack(scroll, "Отправить рапорт", "Roman.28", "envelope_closed-0", scroll:GetWide() - 10, 50, function()
			if not strSelectedRec then
				surface.PlaySound("buttons/button10.wav")
				notification.AddLegacy("Выберите получателя рапорта", NOTIFY_ERROR, 4)

				return
			end

			if not strSelectedTheme then
				surface.PlaySound("buttons/button10.wav")
				notification.AddLegacy("Выберите тему рапорта", NOTIFY_ERROR, 4)

				return
			end

			local bFree = strSelectedTheme == Slawer.Mayor.CFG.Reports.FreeTheme

			if bFree and strCustom == "" then
				surface.PlaySound("buttons/button10.wav")
				notification.AddLegacy("Укажите свою тему рапорта", NOTIFY_ERROR, 4)

				return
			end

			if strBody == "" then
				surface.PlaySound("buttons/button10.wav")
				notification.AddLegacy("Заполните текст рапорта", NOTIFY_ERROR, 4)

				return
			end

			Slawer.Mayor:NetStart("Reports.Send", {
				to = strSelectedRec,
				theme = strSelectedTheme,
				custom = bFree and strCustom or nil,
				body = strBody,
			})
		end)
		scroll:AddItem(sendBtn)
	end

	main.pages["list"]()

	-- Pull the readable reports for this player.
	Slawer.Mayor:NetStart("Reports.Get")
end

Slawer.Mayor:NetReceive("Reports.Get", function(data)
	Slawer.Mayor.Reports = Slawer.Mayor.Reports or {}
	Slawer.Mayor.Reports.Cache = data

	Slawer.Mayor:updatePanel("list")
end)
