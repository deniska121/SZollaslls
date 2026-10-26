--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/client/tabui.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local ply_cur
TabUI = TabUI or {}

local getnicename = {
	["no"] = "Нет",
	["user"] = "Игрок",
	["citizen"] = "Сообщник",
	["helper"] = "Помощник",
	["admin"] = "Исполнитель",
	["moderator"] = "Модератор",
	["superadmin"] = "Администратор",
	["owner"] = "Управление",
}

local idnames = {
	["STEAM_0:1:474840600"] = "Куратор",
	["STEAM_0:1:38316541"] = "Разработчик",
}

local friend = Color(165, 165, 165, 35)

function TabUI.PlayerControll(parent, ply, func)
	local button = vgui.Create("DButton")
	button:SetText("")
	local all = sAdmin.hasPermission(LocalPlayer(), "is_staff")
	local size = all and 50 or 32

	button.StaticScale = {
		w = 1,
		fixed_h = size,
		minw = 150,
		minh = size
	}

	button.alpha = 0
	local sstat = ply:GetFriendStatus() == "friend" or ply == LocalPlayer()

	button.Paint = function(self, w, h)
		if not IsValid(ply) then
			if parent.Update and not self.upd then
				self.upd = true
				parent.Update()
			end

			return true
		end

		MSDX.Draw(0, 0, 0, w, h, MSD.Theme["l"])

		if sstat then
			MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.gradient, friend, 180)
		end

		if self.hover or ply_cur == ply then
			self.alpha = Lerp(FrameTime() * 7, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 7, self.alpha, 0)
		end

		surface.SetDrawColor(MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 150))
		surface.DrawOutlinedRect(0, 0, w, h, 1)
		local sp = draw.SimpleText(ply:SteamName() or "", "MSDFont.22", size + 5, 1, MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 255), TEXT_ALIGN_LEFT)
		draw.DrawText(ply:SteamName() or "", "MSDFont.22", size + 5, 1, MSD.ColorAlpha(MSD.Text["s"], 255 - self.alpha * 255), TEXT_ALIGN_LEFT)

		if all then
			draw.DrawText("| " .. (ply:FullName() or ""), "MSDFont.20", size + 10 + sp, 2, MSD.Text["n"], TEXT_ALIGN_LEFT)
			draw.DrawText(ply:getDarkRPVar("job") or "", "MSDFont.22", size + 5, 22, MSD.Text["n"], TEXT_ALIGN_LEFT)
			draw.DrawText(ply:Ping() or -1, "MSDFont.20", w - 5, h - 25, MSD.Text["d"], TEXT_ALIGN_RIGHT)
			draw.DrawText(sAdmin.formatTime(sAdmin.mcTime(ply)), "MSDFont.20", w - 5, 2, MSD.Text["d"], TEXT_ALIGN_RIGHT)
		elseif ply == LocalPlayer() then
			draw.DrawText(sAdmin.formatTime(sAdmin.mcTime(ply)), "MSDFont.20", w - 5, 2, MSD.Text["d"], TEXT_ALIGN_RIGHT)
		end

		return true
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
	local avatar = vgui.Create("AvatarImage", button)
	avatar:SetSize(size - 2, size - 2)
	avatar:SetPos(1, 1)
	avatar:SetPlayer(ply, size - 2)

	return button
end

function TabUI.AdminButton(parent, name, v, id, vi)
	MSD.ButtonIcon(parent, "static", nil, 3, 45, name, TabUI.CustomIcons[name] or MSD.Icons48.dot, function()
		if v.inputs[2] then
			local inpt = vgui.Create("MSDSimpleFrame")
			inpt:SetSize(500, 85 + (#v.inputs - 1) * 45)
			inpt:Center()
			inpt:MakePopup()

			inpt.Paint = function(s, w, h)
				MSD.Blur(s, 2, 2, 255, 0, w, h)
				MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
				draw.DrawText(name, "MSDFont.25", 10, 0, color_white, TEXT_ALIGN_LEFT)
			end

			MSD.IconButton(inpt, MSD.Icons48.cross, inpt:GetWide() - 30, 5, 25, nil, MSD.Config.MainColor["r"], function()
				inpt:Close()
			end)
			local entries = {}

			for i = 2, #v.inputs do
				local entry = MSD.TextEntry(inpt, 2, 30 + (i - 2) * 45, 496, 45, "", v.inputs[i][2] and slib.getLang("sadmin", sAdmin.config["language"], v.inputs[i][2]) .. " (" .. slib.getLang("sadmin", sAdmin.config["language"], v.inputs[i][1]) .. ")" or slib.getLang("sadmin", sAdmin.config["language"], v.inputs[i][1]), "", function() end)
				table.insert(entries, entry)
			end

			MSD.ButtonIcon(inpt, 2, inpt:GetTall() - 50, 496, 45, "Выполнить", MSD.Icons48.check_bold, function(self)
				inpt:Close()
				local values = ""

				for _, d in ipairs(entries) do
					values = values .. " \"" .. d:GetValue() .. "\""
				end

				if ply_cur:IsBot() then
					LocalPlayer():ConCommand("sa " .. name .. " " .. ply_cur:Name() .. " " .. values)

					return
				end

				LocalPlayer():ConCommand("sa " .. name .. " " .. ply_cur:SteamID64() .. " " .. values)
			end)
		else
			if ply_cur:IsBot() then
				LocalPlayer():ConCommand("sa " .. name .. " " .. ply_cur:Name())

				return
			end

			LocalPlayer():ConCommand("sa " .. name .. " " .. ply_cur:SteamID64())
		end
	end)
end

local hidepls = {
	--["76561198016218248"] = true
}

function DarkRP.OpenAdminMenu(op)
	if IsValid(DarkRP.AdminMenu) then
		DarkRP.AdminMenu.updatePlayer()

		return
	end

	if op then
		ply_cur = op
	end

	if not ply_cur then
		ply_cur = LocalPlayer()
	end

	local ply_cur_cache
	local all = sAdmin.hasPermission(LocalPlayer(), "is_staff")
	--SW - 550
	local SH = ScrH()
	DarkRP.AdminMenu = vgui.Create("MSDSimpleFrame")
	DarkRP.AdminMenu:SetSize(550, SH - SH / 6)
	DarkRP.AdminMenu:SetPos(540, 15)
	DarkRP.AdminMenu:MakePopup()
	DarkRP.AdminMenu:SetAlpha(1)
	DarkRP.AdminMenu:AlphaTo(255, 0.5)

	DarkRP.AdminMenu.DoPlayerError = function()
		local chachedply = ply_cur_cache
		ply_cur = LocalPlayer()
		DarkRP.AdminMenu.updatePlayer()

		if chachedply and chachedply.sid64 then
			local _, child = MSD.WorkSpacePanel(DarkRP.AdminMenu, "Игрока " .. chachedply.name .. " больше нет на сервере", 1, 1, false)
			local sub_list = vgui.Create("MSDPanelList", child)
			sub_list:SetSize(child:GetWide() - 10, child:GetTall() - 55)
			sub_list:SetPos(5, 55)
			sub_list:EnableVerticalScrollbar()
			sub_list:EnableHorizontal(true)
			sub_list:SetSpacing(2)
			sub_list.IgnoreVbar = true

			MSD.Button(sub_list, "static", nil, 2, 35, "Открыть профиль", function()
				gui.OpenURL("http://steamcommunity.com/profiles/" .. chachedply.sid64)
			end)

			MSD.Button(sub_list, "static", nil, 2, 35, chachedply.sid64, function()
				chat.AddText(MSD.Config.MainColor.p, "")
				SetClipboardText(chachedply.sid64)
			end)

			MSD.Button(sub_list, "static", nil, 2, 35, chachedply.sid, function()
				SetClipboardText(chachedply.sid)
			end)

			MSD.Button(sub_list, "static", nil, 2, 35, "U:1:" .. chachedply.aid, function()
				SetClipboardText(chachedply.aid)
			end)
		end
	end

	local group = getnicename[ply_cur:GetUserGroup()] or ply_cur:GetUserGroup()

	if idnames[ply_cur:SteamID()] then
		group = idnames[ply_cur:SteamID()]
	end

	local char = MCR.Config.Texts[ply_cur:getDarkRPVar("character") or 1]

	DarkRP.AdminMenu.Paint = function(s, w, h)
		MSD.Blur(s, 2, 2, 255, 0, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 118, MSD.Theme.d)

		if not IsValid(ply_cur) then
			s.DoPlayerError()

			return
		end

		local nw = draw.SimpleText(ply_cur:SteamName(), "MSDFont.25", 118, 5, color_white, TEXT_ALIGN_LEFT)
		if ply_cur:IsBot() then return end

		if all then
			draw.DrawText(" | " .. ply_cur:FullName() .. " [" .. ply_cur:UserID() .. "]", "MSDFont.25", 118 + nw, 5, MSD.Text.n, TEXT_ALIGN_LEFT)
			draw.DrawText(ply_cur:getDarkRPVar("job") .. " [" .. ply_cur:Team() .. "]" .. " Рас: " .. (ply_cur:getDarkRPVar("karma") or 0), "MSDFont.22", 118, 30, MSD.Text.l, TEXT_ALIGN_LEFT)
			local money = ply_cur:getDarkRPVar("money") or 0
			local sal = ply_cur:getDarkRPVar("salary") or 0
			draw.DrawText(string.Comma(money) .. "$" .. (sal > 0 and " + " .. string.Comma(sal) .. "$" or ""), "MSDFont.22", 118, 50, MSD.Text.l, TEXT_ALIGN_LEFT)
			draw.DrawText((char and char.name or "none") .. " | " .. group, "MSDFont.22", 118, 70, MSD.Text.d, TEXT_ALIGN_LEFT)
		end
	end

	DarkRP.AdminMenu.OnClose = function()
		ply_cur = nil
	end

	local menu = DarkRP.AdminMenu

	menu.clsBut = MSD.IconButton(menu, MSD.Icons48.cross, menu:GetWide() - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
		if menu.OnPress then
			menu.OnPress()

			return
		end

		if IsValid(DarkRP.Scoreboard) then
			DarkRP.Scoreboard:AlphaTo(1, 0.3, 0, function()
				DarkRP.Scoreboard:Remove()
			end)
		end

		menu:AlphaTo(0, 0.4, 0, function()
			menu:Close()
		end)
	end)

	menu.updatePlayer = function()
		ply_cur_cache = {
			name = ply_cur:FullName(),
			sid = ply_cur:SteamID(),
			sid64 = ply_cur:SteamID64(),
			aid = ply_cur:AccountID(),
		}

		if IsValid(menu.avatar) then
			menu.avatar:Remove()
		end

		if IsValid(menu.avlist) then
			menu.avlist:Remove()
		end

		if not IsValid(ply_cur) then return end
		menu.avatar = vgui.Create("AvatarImage", menu)
		menu.avatar:SetSize(110, 110)
		menu.avatar:SetPos(4, 4)
		menu.avatar:SetPlayer(ply_cur, 110)
		menu.avlist = vgui.Create("MSDPanelList", menu)
		menu.avlist:SetSize(menu:GetWide() - 10, menu:GetTall() - 130)
		menu.avlist:SetPos(5, 125)
		menu.avlist:EnableVerticalScrollbar()
		menu.avlist:EnableHorizontal(true)
		menu.avlist:SetSpacing(2)
		menu.avlist:SetPadding(0)
		menu.avlist.IgnoreVbar = false

		if all then
			MSD.TextEntry(menu.avlist, "static", nil, 1, 45, "Поиск игроков", "", "", function(s, value)
				if not IsValid(DarkRP.Scoreboard) then return end
				DarkRP.Scoreboard.list.Update(value)
			end, true)
		end

		if not ply_cur:IsBot() then
			MSD.InfoHeader(menu.avlist, "Профиль игрока")

			MSD.ButtonIcon(menu.avlist, "static", nil, 2, 45, "Открыть профиль", MSD.Icons48.steam, function()
				gui.OpenURL("http://steamcommunity.com/profiles/" .. ply_cur:SteamID64())
			end)

			MSD.ButtonIcon(menu.avlist, "static", nil, 2, 45, "U:1:" .. ply_cur:AccountID(), MSD.Icons48.copy, function()
				SetClipboardText(ply_cur:AccountID())
			end)

			MSD.ButtonIcon(menu.avlist, "static", nil, 2, 45, ply_cur:SteamID64(), MSD.Icons48.copy, function()
				chat.AddText(MSD.Config.MainColor.p, "")
				SetClipboardText(ply_cur:SteamID64())
			end)

			MSD.ButtonIcon(menu.avlist, "static", nil, 2, 45, ply_cur:SteamID(), MSD.Icons48.copy, function()
				SetClipboardText(ply_cur:SteamID())
			end)

			if all then
				MSD.ButtonIcon(menu.avlist, "static", nil, 2, 45, McPhone.NumberChar(ply_cur), MSD.Icons48.copy, function()
					SetClipboardText(McPhone.NumberChar(ply_cur))
				end)

				MSD.ButtonIcon(menu.avlist, "static", nil, 2, 45, DarkRP.PassId(ply_cur), MSD.Icons48.copy, function()
					SetClipboardText(DarkRP.PassId(ply_cur))
				end)

				MSD.ButtonIcon(menu.avlist, "static", nil, 1, 45, "Проверить варны", MSD.Icons48.badge_account_alert, function()
					net.Start("sA:Networking")
					net.WriteUInt(5, 3)
					net.WriteUInt(4, 3)
					net.WriteUInt(0, 15)
					net.WriteString(tostring(ply_cur:SteamID64()))
					net.SendToServer()
				end)
			end
		end

		if not all then return end
		local categories = {}
		local names = {}
		local catid = {}

		for name, v in pairs(sAdmin.commands) do
			if not v.category then continue end
			local cat = TabUI.custom_cats[v.category]
			v.name = name

			if not catid[v.category] then
				local id = cat and cat[2] or 10
				categories[id] = {}
				names[id] = cat and cat[1] or v.category
				catid[v.category] = id
			end

			categories[catid[v.category]][v.index] = v
		end

		for id, vi in SortedPairs(categories) do
			local sname = names[id]
			MSD.InfoHeader(menu.avlist, sname)

			for _, v in SortedPairs(vi) do
				local name = v.name
				if not sAdmin.hasPermission(LocalPlayer(), name) or not v.inputs or not v.inputs[1] or v.inputs[1][1] ~= "player" then continue end
				TabUI.AdminButton(menu.avlist, name, v, id, vi)
			end
		end
	end

	menu.updatePlayer()
end

function GM:ScoreboardShow()
	if IsValid(DarkRP.Scoreboard) then
		DarkRP.Scoreboard:Remove()
	end

	if SChat and SChat.chatBox then
		SChat.chatBox:ClearTempMessages()
	end

	gui.EnableScreenClicker(true)
	local SH = ScrH()
	local all = sAdmin.hasPermission(LocalPlayer(), "is_staff")
	DarkRP.Scoreboard = vgui.Create("DPanel")
	DarkRP.Scoreboard:SetSize(520, SH - SH / 6)
	DarkRP.Scoreboard:SetPos(15, 15)
	DarkRP.Scoreboard:SetAlpha(1)
	DarkRP.Scoreboard:AlphaTo(255, 0.5)

	DarkRP.Scoreboard.Paint = function(s, w, h)
		MSD.Blur(s, 2, 2, 255, 0, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 118, MSD.Theme.d)
		MSD.DrawTexturedRect(w / 2 - 146, 0, 293, 118, MSD.Materials.logo, color_white)
		draw.DrawText("Онлайн: " .. #player.GetAll(), "MSDFont.22", 10, 95, MSD.Text.d, TEXT_ALIGN_LEFT)
	end

	local menu = DarkRP.Scoreboard
	menu.list = vgui.Create("MSDPanelList", menu)
	menu.list:SetSize(menu:GetWide() - 10, menu:GetTall() - 125)
	menu.list:SetPos(5, 120)
	menu.list:EnableVerticalScrollbar()
	menu.list:EnableHorizontal(true)
	menu.list:SetSpacing(2)
	menu.list:SetPadding(2)
	menu.list.IgnoreVbar = true

	menu.list.Update = function(info)
		menu.list:Clear()

		local function DoPlyPress(ply)
			ply_cur = ply
			DarkRP.OpenAdminMenu()
		end

		local admins = {}
		local joining = {}
		local rest = {}

		for _, ply in pairs(player.GetAll()) do
			if not IsValid(ply) then continue end
			if hidepls[ply:SteamID64()] and not hidepls[LocalPlayer():SteamID64()] then continue end
			if info and info ~= "" then
				local found = false

				if string.find(utf8.search(ply:FullName()), utf8.search(info)) then
					found = true
				end

				if ply.SteamName and string.find(utf8.search(ply:SteamName()), utf8.search(info)) then
					found = true
				end

				if string.find(string.lower(ply:SteamID()), string.lower(info)) then
					found = true
				end

				if not ply:IsBot() and string.find(tostring(ply:SteamID64()), info) then
					found = true
				end

				if tonumber(info) == ply:UserID() then
					found = true
				end

				if string.find(utf8.search(ply:getDarkRPVar("job")), utf8.search(info)) then
					found = true
				end

				if not found then continue end
			end

			if all and sAdmin.hasPermission(ply, "is_staff") then
				table.insert(admins, ply)
				continue
			end

			if ply:Team() == 0 then
				table.insert(joining, ply)
				continue
			end

			table.insert(rest, ply)
		end

		if #admins > 0 then
			MSD.InfoHeader(menu.list, "Администрация онлайн")

			for _, ply in pairs(admins) do
				TabUI.PlayerControll(menu.list, ply, function()
					DoPlyPress(ply)
				end)
			end
		end

		if #rest > 0 then
			table.sort(rest, function(a, b)
				return sAdmin.mcTime(a) < sAdmin.mcTime(b)
			end)
			MSD.InfoHeader(menu.list, "Игроки онлайн")

			for _, ply in pairs(rest) do
				TabUI.PlayerControll(menu.list, ply, function()
					DoPlyPress(ply)
				end)
			end
		end

		if #joining > 0 then
			MSD.InfoHeader(menu.list, "Подключаются")

			for _, ply in pairs(joining) do
				TabUI.PlayerControll(menu.list, ply, function()
					DoPlyPress(ply)
				end)
			end
		end
	end

	menu.list.Update()
end

function GM:ScoreboardHide()
	gui.EnableScreenClicker(false)

	if IsValid(DarkRP.Scoreboard) and not IsValid(DarkRP.AdminMenu) then
		DarkRP.Scoreboard:AlphaTo(1, 0.3, 0, function()
			DarkRP.Scoreboard:Remove()
		end)
	end
end

properties.Add("playermenu", {
	MenuLabel = "Управление",
	Order = 1,
	PrependSpacer = true,
	MenuIcon = "icon16/user_edit.png",
	Filter = function(self, ent, ply)
		if not IsValid(ent) or not ent:IsPlayer() then return false end
		if not sAdmin.hasPermission(ply, "is_staff") then return false end
		return true
	end,
	Action = function(self, ent)
		GAMEMODE:ScoreboardShow()
		DarkRP.OpenAdminMenu(ent)
	end
})	