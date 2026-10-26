--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_ranks/lua/mc_ranks/ui/rank_panel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╦═══╗───────────────────────
-- ║║╚╝║║╔═╗║╔═╗║───────────────────────
-- ║╔╗╔╗║╚═╝║╚══╗──By MacTavish <3──────
-- ║║║║║║╔╗╔╩══╗║───────────────────────
-- ║║║║║║║║╚╣╚═╝║───────────────────────
-- ╚╝╚╝╚╩╝╚═╩═══╝───────────────────────

local RankMenu
local Ln = MSD.GetPhrase
local ranks_1 = Material("ranks_ui/rank_low.png", "smooth")
local ranks_2 = Material("ranks_ui/rank.png", "smooth")
local ranks_3 = Material("ranks_ui/rank_sup.png", "smooth")

function MRS.OpenRankMenu()

	if IsValid(RankMenu) then return end

	local sw, sh = ScrW(), ScrH()

	sw, sh = sw / 2, sh - sh / 3

	RankMenu = vgui.Create("MSDSimpleFrame")
	RankMenu:SetSize(sw, sh)
	RankMenu:SetDraggable(false)
	RankMenu:Center()
	RankMenu:MakePopup()
	RankMenu.OnClose = function()
		RankMenu = nil
	end
	RankMenu:SetAlpha(1)
	RankMenu:AlphaTo(255, 0.4)

	local update = 0
	local group = MRS.GetNWdata(LocalPlayer(), "Group")
	local rank = MRS.GetNWdata(LocalPlayer(), "Rank")

	RankMenu.Paint = function(self, w, h)

		if update < CurTime() then
			update = CurTime() + 1
			group = MRS.GetNWdata(LocalPlayer(), "Group")
			rank = MRS.GetNWdata(LocalPlayer(), "Rank")
		end

		MSD.DrawBG(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h - 0, MSD.Theme["l"])

		if not group or not rank then
			draw.DrawText(Ln("mrs_noranks"), "MSDFont.25", w / 2, h / 2 - 12, color_white, TEXT_ALIGN_CENTER)
			return
		end

		if not MRS.Ranks[group] or not MRS.Ranks[group].ranks[rank] then return end

		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, 128, MSD.Theme["l"])

		local rank_t = MRS.Ranks[group].ranks[rank]

		if rank_t.icon[1] and rank_t.icon[1] ~= "" then
			local icon = MRS.GetRankIcon(rank_t.icon)
			MSD.DrawTexturedRect(32, 32, 64, 64, icon, color_white)
		end
		draw.SimpleTextOutlined(rank_t.name, "MSDFont.36", 128, 32, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
		draw.SimpleTextOutlined(group, "MSDFont.22", 130, 72, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)

		if not rank_t.can_promote and not rank_t.can_demote then
			draw.DrawText(Ln("mrs_nopower"), "MSDFont.25", w / 2, h / 2 - 12, color_white, TEXT_ALIGN_CENTER)
			return
		end

		MSDX.Draw(MSD.Config.Rounded, 0, 130, w / 2, h - 130, MSD.Theme["l"])
		MSDX.Draw(MSD.Config.Rounded, w / 2 + 2, 130, w / 2 - 2, h - 130, MSD.Theme["l"])
	end

	RankMenu.clsBut = MSD.IconButton(RankMenu, MSD.Icons48.cross, RankMenu:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
		if RankMenu.OnPress then
			RankMenu.OnPress()

			return
		end

		RankMenu:AlphaTo(0, 0.4, 0, function()
			RankMenu:Close()
		end)
	end)

	if not MRS.Ranks[group] or not MRS.Ranks[group].ranks[rank] then return end

	local rank_t = MRS.Ranks[group].ranks[rank]

	if rank_t.models and #rank_t.models > 0 then
		MSD.ButtonIcon(RankMenu, RankMenu:GetWide() - 125, 65, 120, 50, Ln("model"), MSD.Icons48.account_edit, function(self)
			local pn, child = MSD.WorkSpacePanel(RankMenu, Ln("model"), 2, 1, false)
			local sub_list = vgui.Create("MSDPanelList", child)
			sub_list:SetSize(child:GetWide() - 10, child:GetTall() - 50)
			sub_list:SetPos(5, 50)
			sub_list:EnableVerticalScrollbar()
			sub_list:EnableHorizontal(true)
			sub_list:SetSpacing(2)
			sub_list.IgnoreVbar = true

			for k,v in pairs(rank_t.models) do
				local pnl = MSD.BigModelButton(sub_list, "static", nil, 1, 150, Ln("model") .. " #" .. k, MSD.Icons48.swap, function()
					RunConsoleCommand("mrs_playermodel", k)
					pn:Close()
				end)
				pnl.SetCustomModel(v.model)
				for i,b in pairs(v.bgrs) do
					pnl.Icon.Entity:SetBodygroup(i, b)
				end
				pnl.Icon.Entity:SetSkin(v.skin)
			end

		end)
	end

	if not rank_t.can_promote and not rank_t.can_demote then return end

	local list_right, list_left
	list_left = vgui.Create("MSDPanelList", RankMenu)
	list_left:SetSize(RankMenu:GetWide() / 2, RankMenu:GetTall() - 130)
	list_left:SetPos(0, 130)
	list_left:EnableVerticalScrollbar()
	list_left:EnableHorizontal(true)
	list_left:SetSpacing(2)
	list_left:SetPadding(0)
	list_left.IgnoreVbar = true

	list_right = vgui.Create("MSDPanelList", RankMenu)
	list_right:SetSize(RankMenu:GetWide() / 2 - 2, RankMenu:GetTall() - 130)
	list_right:SetPos(RankMenu:GetWide() / 2 + 2, 130)
	list_right:EnableVerticalScrollbar()
	list_right:EnableHorizontal(true)
	list_right:SetSpacing(2)
	list_right:SetPadding(0)
	list_right.IgnoreVbar = true

	list_left.Populate = function()
		list_left:Clear()

		local others = {}

		local hdr =	MSD.Header(list_left, Ln("on_duty"))
		local delh = true
		for _,p in ipairs(player.GetAll()) do
			if p == LocalPlayer() then continue end
			if MRS.GetNWdata(p, "Group") ~= group then
				table.insert(others,p)
				continue
			end
			if MRS.GetNWdata(p, "Rank") >= rank then continue end
			MSD.ButtonIcon(list_left, "static", nil, 1, 50, p:FullName(), ranks_2, function()
				list_right.Populate(p)
			end)
			delh = false
		end

		if delh then hdr:Remove() end
		MSD.Header(list_left, Ln("other_players"))

		for _,p in ipairs(others) do
			MSD.ButtonIcon(list_left, "static", nil, 1, 50, p:FullName(), MSD.Icons48.account, function()
				list_right.Populate(p)
			end)
		end
	end

	list_right.Populate = function(ply)
		list_right:Clear()

		local hdr = MSD.Header(list_right, ply:FullName() .. " | " .. (ply.SteamName and ply:SteamName() or ""))

		local grp = MRS.Ranks[group]
		local p_group, p_rank

		hdr.Think = function()
			p_group = MRS.GetNWdata(ply, "Group")
			p_rank = MRS.GetNWdata(ply, "Rank")
		end

		for k,v in SortedPairs(grp.ranks, true) do
			if k >= rank then continue end
			local rankicon = ranks_2

			if k == 1 then rankicon = ranks_1 end
			if k == #grp.ranks or v.can_promote or v.can_demote then rankicon = ranks_3 end

			if v.icon and v.icon ~= "" then
				if string.StartWith(v.icon, "http") then
					rankicon = MSD.ImgLib.GetMaterial(v.icon)
				else
					rankicon = v.icon
				end
			end

			MSD.ButtonIcon(list_right, "static", nil, 1, 50, v.name, rankicon, function(self)
				RunConsoleCommand("mrs_setrank", ply:UserID(), group, k)
			end, nil, nil, color_white, function(self, w, h)
				if p_group ~= group or p_rank ~= k then return end
				MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
				draw.DrawText(Ln("active"), "MSDFont.22", w - 20, h / 2 - 11, MSD.Config.MainColor["p"], TEXT_ALIGN_RIGHT)
			end)

		end

		MSD.ButtonIcon(list_right, "static", nil, 1, 50, "Открыть данные экзамена", MSD.Icons48.file_document, function(self)
			net.Start("MRS.Exam")
				net.WriteUInt(3, 3)
				net.WriteString(tostring(ply:SteamID64() or 1))
			net.SendToServer()
		end)

	end

	list_left.Populate()
end

function MRS.OpenExamMenu(exam, id)

	if not MRS.Exam.Test[exam] or not MRS.Exam.Test[exam][id] then return end

	local test = MRS.Exam.Test[exam][id]

	local info = MRS.Exam.Info[exam]

	if IsValid(RankMenu) then
		RankMenu:Close()
	end

	local sw, sh = ScrW(), ScrH()

	sw, sh = sw / 2, sh - sh / 3

	RankMenu = vgui.Create("MSDSimpleFrame")
	RankMenu:SetSize(sw, sh)
	RankMenu:SetDraggable(false)
	RankMenu:Center()
	RankMenu:MakePopup()
	RankMenu.OnClose = function()
		RankMenu = nil
	end
	RankMenu:SetAlpha(1)
	RankMenu:AlphaTo(255, 0.4)

	RankMenu.Paint = function(self, w, h)
		MSD.DrawBG(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h - 0, MSD.Theme["l"])

		if not info then return end

		MSD.DrawTexturedRect(32, 32, 64, 64, MSD.ImgLib.GetMaterial(info.icon), color_white)

		draw.SimpleTextOutlined(info.name, "MSDFont.32", 128, 32, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
		draw.SimpleTextOutlined(info.group, "MSDFont.22", 130, 72, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)

		--MSD.DrawTexturedRect(-64, -10, 128, 128, MSD.ImgLib.GetMaterial(ict[name]), tc)
		--draw.DrawText(MSD.TextWrap(test.q, "MSDFont.25", w - 10), "MSDFont.25", 5, 25, color_white, TEXT_ALIGN_LEFT)
	end

	local list_left = vgui.Create("MSDPanelList", RankMenu)
	list_left:SetSize(RankMenu:GetWide() - 10, RankMenu:GetTall() - 130)
	list_left:SetPos(5, 130)
	list_left:EnableVerticalScrollbar()
	list_left:EnableHorizontal(true)
	list_left:SetSpacing(5)
	list_left:SetPadding(0)
	list_left.IgnoreVbar = true

	MSD.InfoTextF1(list_left, test.q, list_left:GetWide() - 5, "MSDFont.26")

	for k,v in RandomPairs(test.a) do
		MSD.InfoTextButton(list_left, v, list_left:GetWide() - 5, function()
			net.Start("MRS.Exam")
				net.WriteUInt(2, 3)
				net.WriteUInt(k, 3)
			net.SendToServer()
			RankMenu:Close()
		end, "MSDFont.26")
	end
end

local color_red = Color(145,12,12)
local color_green = Color(60,133,11)

local function addpns(par, color)
	local panel = vgui.Create("DPanel")
	panel.StaticScale = {
		w = 1,
		fixed_h = 2,
		minw = 250,
		minh = 2
	}

	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, color)
	end

	par:AddItem(panel)
end

function MRS.OpenExamstats(exam, answa)

	if IsValid(RankMenu) then
		RankMenu:Close()
	end

	local sw, sh = ScrW(), ScrH()

	sw, sh = sw / 2, sh - sh / 4

	RankMenu = vgui.Create("MSDSimpleFrame")
	RankMenu:SetSize(sw, sh)
	RankMenu:SetDraggable(false)
	RankMenu:Center()
	RankMenu:MakePopup()
	RankMenu.OnClose = function()
		RankMenu = nil
	end
	RankMenu:SetAlpha(1)
	RankMenu:AlphaTo(255, 0.4)

	RankMenu.Paint = function(self, w, h)
		MSD.DrawBG(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h - 0, MSD.Theme["l"])

		-- if not info then return end

		MSD.DrawTexturedRect(32, 32, 64, 64, MSD.ImgLib.GetMaterial("https://macnco.one/rankup/nypd.png"), color_white)

		draw.SimpleTextOutlined("Отчеты", "MSDFont.36", 128, 32, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
		draw.SimpleTextOutlined("NYPD", "MSDFont.22", 130, 72, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)

		-- MSD.DrawTexturedRect(-64, -10, 128, 128, MSD.ImgLib.GetMaterial(ict[name]), tc)
		-- draw.DrawText(MSD.TextWrap(test.q, "MSDFont.25", w - 10), "MSDFont.25", 5, 25, color_white, TEXT_ALIGN_LEFT)
	end

	RankMenu.clsBut = MSD.IconButton(RankMenu, MSD.Icons48.cross, RankMenu:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
		RankMenu:AlphaTo(0, 0.4, 0, function()
			RankMenu:Close()
		end)
	end)

	local list_left = vgui.Create("MSDPanelList", RankMenu)
	list_left:SetSize(RankMenu:GetWide() - 10, RankMenu:GetTall() - 130)
	list_left:SetPos(5, 130)
	list_left:EnableVerticalScrollbar()
	list_left:EnableHorizontal(true)
	list_left:SetSpacing(5)
	list_left:SetPadding(0)
	list_left.IgnoreVbar = true

	local openAll

	local function openPageTest(ex, pass)
		list_left:Clear()
		MSD.Header(list_left, "Детали", function() openAll(e) end)
		local i = 1
		for k,v in pairs(pass) do
			local test = MRS.Exam.Test[ex][k]
			local anw = answa[ex][k]
			if not test then continue end
			MSD.InfoTextF1(list_left, i .. " Вопрос: " .. test.q, list_left:GetWide() - 5, "MSDFont.16", true)
			MSD.InfoTextF1(list_left, "Ответ:" .. test.a[v], list_left:GetWide() - 5, "MSDFont.16", true)
			if v ~= anw then
				MSD.InfoTextF1(list_left, "Правльный ответ:" .. test.a[anw], list_left:GetWide() - 5, "MSDFont.16", true)
				addpns(list_left, color_red)
			else
				addpns(list_left, color_green)
			end

			i = i + 1
		end
	end

	function openAll()
		list_left:Clear()
		for id,ex in SortedPairs(exam, true) do

			local info = MRS.Exam.Info[ex.exam]

			local button = vgui.Create("DButton")
			button:SetText("")
			button.StaticScale = {
				w = 1,
				fixed_h = 120,
				minw = 200,
				minh = 120
			}

			ex.status = ex.status or 0

			button.Paint = function(self, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, MSD.Theme["d"])
				draw.DrawText(info.name, "MSDFont.22", 5, 5, self.hover and MSD.Config.MainColor["p"] or color_white, TEXT_ALIGN_LEFT)
				draw.DrawText(os.date("%H:%M   %d-%m-%Y", ex.stamp), "MSDFont.22", 5, 27, MSD.Text.n, TEXT_ALIGN_LEFT)
				draw.DrawText("Ошибок: " .. ex.fails, "MSDFont.22", 5, 49, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText("Статус: " .. (ex.status == 1 and "Пройден" or "Провален"), "MSDFont.22", 5, 71, ex.status == 1 and color_green or color_red, TEXT_ALIGN_LEFT)
			end
			button.OnCursorEntered = function(self) self.hover = true end
			button.OnCursorExited = function(self) self.hover = false end
			button.DoClick = function(self)
				openPageTest(ex.exam, ex.passed)
			end
			list_left:AddItem(button)
		end
	end

	openAll()
end

net.Receive("MRS.Exam", function(l, ply)
	local tp = net.ReadUInt(3)

	if not tp then return end

	if tp == 1 then
		local exam = net.ReadString()
		local id = net.ReadUInt(32)
		MRS.OpenExamMenu(exam, id)
	elseif tp == 2 then
		local bn = net.ReadUInt(32)
		local vars = DarkRP.TableDecompress(net.ReadData(bn))
		MRS.OpenExamstats(vars[1], vars[2])
	end
end)

-- function MRS.OpenExams()

-- 	if IsValid(RankMenu) then
-- 		RankMenu:Close()
-- 		return
-- 	end

-- 	local sw, sh = ScrW(), ScrH()

-- 	sw, sh = sw * 0.8, sh - sh / 8

-- 	RankMenu = vgui.Create("MSDSimpleFrame")
-- 	RankMenu:SetSize(sw, sh)
-- 	RankMenu:SetDraggable(false)
-- 	RankMenu:Center()
-- 	RankMenu:MakePopup()
-- 	RankMenu.OnClose = function()
-- 		RankMenu = nil
-- 	end
-- 	RankMenu:SetAlpha(1)
-- 	RankMenu:AlphaTo(255, 0.4)

-- 	RankMenu.Paint = function(self, w, h)
-- 		MSD.DrawBG(self, w, h)
-- 		draw.RoundedBox(MSD.Config.Rounded, 0, 0, w, h - 0, MSD.Theme["l"])
-- 		MSD.DrawTexturedRect(32, 32, 64, 64, MSD.ImgLib.GetMaterial("https://macnco.one/rankup/nypd.png"), color_white)

-- 		draw.SimpleTextOutlined("Экзамены", "MSDFont.36", 128, 32, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
-- 		draw.SimpleTextOutlined("NYPD", "MSDFont.22", 130, 72, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
-- 	end

-- 	RankMenu.clsBut = MSD.IconButton(RankMenu, MSD.Icons48.cross, RankMenu:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
-- 		RankMenu:AlphaTo(0, 0.4, 0, function()
-- 			RankMenu:Close()
-- 		end)
-- 	end)

-- 	local list_left = vgui.Create("MSDPanelList", RankMenu)
-- 	list_left:SetSize(RankMenu:GetWide() - 10, RankMenu:GetTall() - 130)
-- 	list_left:SetPos(5, 130)
-- 	list_left:EnableVerticalScrollbar()
-- 	list_left:EnableHorizontal(true)
-- 	list_left:SetSpacing(5)
-- 	list_left:SetPadding(0)
-- 	list_left.IgnoreVbar = true

-- 	local function openPageTest(id, ex, info)
-- 		list_left:Clear()
-- 		MSD.Header(list_left, id .. " - " .. info.name)

-- 		local answa = MRS.Exam.Answers[id]

-- 		for ida,test in ipairs(ex) do
-- 			local anw = answa[ida]

-- 			MSD.InfoTextF1(list_left, "[" .. ida .. "] " .. test.q, list_left:GetWide() - 5, "MSDFont.22", true)

-- 			for k,v in ipairs(test.a) do
-- 				MSD.InfoTextF1(list_left, "	[" .. k .. "] " .. v, list_left:GetWide() - 5, "MSDFont.22", true)
-- 				if k ~= anw then
-- 					addpns(list_left, color_red)
-- 				else
-- 					addpns(list_left, color_green)
-- 				end
-- 			end
-- 		end
-- 	end

-- 	local function loadexams()
-- 		list_left:Clear()

-- 		for id,ex in SortedPairs(MRS.Exam.Test, true) do

-- 			local info = MRS.Exam.Info[id]

-- 			local button = vgui.Create("DButton")
-- 			button:SetText("")
-- 			button.StaticScale = {
-- 				w = 1,
-- 				fixed_h = 120,
-- 				minw = 200,
-- 				minh = 120
-- 			}

-- 			--ex.status = ex.status or 0

-- 			button.Paint = function(self, wd, hd)
-- 				draw.RoundedBox(0, 0, 0, wd, hd, MSD.Theme["d"])

-- 				if info.icon[1] and info.icon[1] ~= "" then
-- 					local icon = MRS.GetRankIcon(info.icon)
-- 					MSD.DrawTexturedRect(32, 32, 64, 64, icon, color_white)
-- 				end
-- 				draw.SimpleTextOutlined(id .. " - " .. info.name, "MSDFont.36", 128, 32, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
-- 				draw.SimpleTextOutlined(info.group, "MSDFont.22", 130, 72, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)

-- 				--draw.DrawText(info.name, "MSDFontB.32", 75, 5, self.hover and MSD.Config.MainColor["p"] or color_white, TEXT_ALIGN_LEFT)
-- 				--draw.DrawText(os.date("%H:%M   %d-%m-%Y", ex.stamp), "MSDFont.22", 5, 27, MSD.Text.n, TEXT_ALIGN_LEFT)
-- 				--draw.DrawText("Ошибок: " .. ex.fails, "MSDFont.22", 5, 49, color_white, TEXT_ALIGN_LEFT)
-- 				--draw.DrawText("Статус: " .. (ex.status == 1 and "Пройден" or "Провален"), "MSDFont.22", 5, 71, ex.status == 1 and color_green or color_red, TEXT_ALIGN_LEFT)
-- 			end
-- 			button.OnCursorEntered = function(self) self.hover = true end
-- 			button.OnCursorExited = function(self) self.hover = false end
-- 			button.DoClick = function(self)
-- 				openPageTest(id, ex, info)
-- 			end
-- 			list_left:AddItem(button)
-- 		end
-- 	end

-- 	MSD.IconButton(RankMenu, MSD.Icons48.menu, RankMenu:GetWide() - 34, 55, 25, nil, MSD.Config.MainColor.p, function()
-- 		list_left:AlphaTo(0, 0.1, 0)

-- 		list_left:AlphaTo(255, 0.2, 0.1, function()
-- 			loadexams()
-- 		end)
-- 	end)

-- 	loadexams()
-- end