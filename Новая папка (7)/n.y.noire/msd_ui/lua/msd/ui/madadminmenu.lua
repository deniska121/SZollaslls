--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/madadminmenu.lua
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
local Ln = MSD.GetPhrase
local INVPANEL

local sesp, show = false, {
	["spawned_junk"] = true,
	["spawned_ammo"] = true,
	["spawned_food"] = true,
	["spawned_storage"] = true,
	["planter_base"] = true,
	["workstation_drugs"] = true,
	["func_movelinear"] = true,
	["static_storage"] = true,
	["spawned_weapon"] = true,
	["spawned_money"] = true,
	["workstation_guns"] = true,
	["player"] = true,
	["gmod_sent_vehicle_fphysics_base"] = false,
}

local sespshow = {
	weps = true,
	money = true,
	misc = true,
	players = true,
	icons = true,
	showdetails = true,
	details = 700,
}

local epos, spos, cl, dst

local defc = Color(192, 118, 68)
local shadow = Color(0, 0, 0)
local iconm = Material("vgui/col-alpha", "smooth")
local classcls = {
	["player"] = Color(252, 221, 221),
	["spawned_weapon"] = Color(163, 50, 255),
	["spawned_money"] = Color(255, 166, 0),
	["spawned_junk"] = Color(214, 211, 46),
	["spawned_ammo"] = Color(0, 17, 255),
	["spawned_food"] = Color(175, 245, 94),
}

local classicn = {
	["player"] = MSD.Icons48.account,
	["spawned_weapon"] = MSD.Icons48.pistol,
	["spawned_money"] = MSD.Icons48.cash,
	["spawned_junk"] = MSD.Icons48.box,
	["spawned_ammo"] = MSD.Icons48.ammo,
	["spawned_food"] = MSD.Icons48.food,
}

function MSD.LoadAdminTool()
	if not sAdmin.hasPermission(LocalPlayer(), "silent") then return end

	if sesp then
		hook.Remove("HUDPaint", "MSD.SESP")
		return
	end

	hook.Add("HUDPaint", "MSD.SESP", function()
		--if not sAdmin.hasPermission(LocalPlayer(), "silent") then return end

		for k, v in pairs(ents.GetAll()) do
			if not show[v:GetClass()] or v == LocalPlayer() then continue end

			dst = LocalPlayer():GetPos():DistToSqr(v:GetPos())

			epos = v:GetPos():ToScreen()
			cl = classcls[v:GetClass()] or defc
			shadow = MSD.ColorAlpha(shadow, 100)

			if not DarkRP.InRange(v, LocalPlayer(), sespshow.details) and not showdetails then
				if sespshow.icons and classicn[v:GetClass()] then
					surface.SetMaterial(classicn[v:GetClass()])
					surface.SetDrawColor(color_black)
					surface.DrawTexturedRectRotated(epos.x + 1, epos.y + 1, 16, 16, 0)
				else
					surface.SetMaterial(iconm)
				end

				surface.SetDrawColor(cl)
				surface.DrawTexturedRectRotated(epos.x, epos.y, 16, 16, 0)
				continue
			end

			cl = MSD.ColorAlpha(cl or defc, 255 - 255 * (dst / (sespshow.details ^ 2)))

			if sespshow.players and v:IsPlayer() then
				epos = v:GetShootPos():ToScreen()
				draw.SimpleTextOutlined(v:SteamName(), "MSDFont.24", epos.x, epos.y + 35, cl, 1, 1, 1, shadow)

				if not DarkRP.InRange(v, LocalPlayer(), sespshow.details / 3) then continue end
				spos = v:GetEyeTrace().HitPos:ToScreen()
				draw.SimpleTextOutlined(v:FullName(), "MSDFont.20", epos.x, epos.y + 60, cl, 1, 1, 1, shadow)
				draw.SimpleTextOutlined("H: " .. v:Health() .. " | " .. v:Armor() .. " S: " .. (v:getDarkRPVar("karma") or "nil"), "MSDFont.16", epos.x, epos.y + 80, cl, 1, 1, 1, shadow)
				surface.SetDrawColor(cl)
				surface.DrawLine(epos.x, epos.y, spos.x, spos.y)
			elseif sespshow.weps and v:GetClass() == "spawned_weapon" then
				draw.SimpleTextOutlined(v:Geteclass() .. " [" .. v:EntIndex() .. "]", "MSDFont.20", epos.x, epos.y, cl, 1, 1, 1, shadow)
			elseif sespshow.misc and show[v:GetClass()] then
				draw.SimpleTextOutlined(v, "MSDFont.20", epos.x, epos.y, cl, 1, 1, 1, shadow)
			elseif sespshow.money and v:GetClass() == "spawned_money" then
				draw.SimpleTextOutlined(v:Getamount() .. "$" .. " [" .. v:EntIndex() .. "]", "MSDFont.20", epos.x, epos.y, cl, 1, 1, 1, shadow)
			end
		end
	end)
end

local function OpenAdminMenu(panel, mainPanel)
	if not panel then return end
	local ply = LocalPlayer()

	panel.Canvas = vgui.Create("MSDPanelList", panel)
	panel.Canvas:SetSize(panel:GetWide() - 252, panel:GetTall())
	panel.Canvas:SetPos(252, 0)
	panel.Canvas:EnableVerticalScrollbar()
	panel.Canvas:EnableHorizontal(true)
	panel.Canvas:SetSpacing(2)
	panel.Canvas.IgnoreVbar = true
	panel.Canvas.Paint = function() end
	local pages = {}
	local cur_page = nil

	local function openPage(id, animate, ...)
		panel.Canvas:Clear()
		back_page = cur_page
		pages[id](...)
		cur_page = id

		if animate then
			panel.Canvas:SetAlpha(1)
			panel.Canvas:AlphaTo(255, 0.2)
		end
	end

	local buttons = {}

	buttons[1] = {
		"Главная панель", MSD.Icons48.menu, function()
			openPage("dash", true)
		end,
		true
	}

	buttons[2] = {Ln("user_data"), MSD.Icons48.account_edit, function() openPage("data", true) end}

	--openPage("user_data", true)
	if sAdmin.hasPermission(ply, "silent") then
		buttons[3] = {
			"SESP", MSD.Icons48.biohazard, function()
				openPage("sesp", true)
			end
		}
	end

	buttons[4] = {Ln("settings"), MSD.Icons48.cog, function() end}

	--openPage("settings", true)
	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(250, panel:GetTall())
	panel.Menu:SetPos(0, 0)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(false)
	panel.Menu:SetSpacing(0)
	panel.Menu.IgnoreVbar = true

	panel.Menu.Paint = function(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
	end

	panel.Menu.Deselect = function(but)
		if not but then return end
		but.hovered = true

		for k, v in pairs(panel.Menu:GetItems()) do
			if v and v:IsValid() and v ~= but then
				v.hovered = false
			end
		end
	end

	local function PopupMenu(text, x, y, w, dwd)
		local pl, child = MSD.WorkSpacePanel(mainPanel, text, x, y, false)
		local sub_list = vgui.Create("MSDPanelList", child)
		sub_list:SetSize(dwd and child:GetWide() / dwd or child:GetWide() - 10, child:GetTall() - w)
		sub_list:SetPos(5, w)
		sub_list:EnableVerticalScrollbar()
		sub_list:EnableHorizontal(true)
		sub_list:SetSpacing(2)
		sub_list.IgnoreVbar = true
		return sub_list, child, pl
	end

	pages["dash"] = function() end -- MSD.Header(panel.Canvas, Ln("group_list"), function() -- end, MSD.Icons48.search)

	pages["data"] = function()
		panel.Canvas:Clear()

		MSD.Header(panel.Canvas, Ln("user_data"))
		local sel_ply, list_right, list_left
		local ops_panel = vgui.Create("DPanel")
		ops_panel:SetSize(panel.Canvas:GetWide(), panel.Canvas:GetTall() - 55)

		ops_panel.Paint = function(self, w, h)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, w / 2 - 2, h, MSD.Theme["l"])
			MSDX.Draw(MSD.Config.Rounded, w / 2, 0, w / 2 - 2, h, MSD.Theme["l"])

			if sel_ply and not IsValid(sel_ply) then
				sel_ply = nil
				list_left.Populate()
				list_right:Clear()
			end
		end

		MSD.TextEntry(ops_panel, 0, 0, ops_panel:GetWide() / 3 - 2, 50, "SteamID/Name", Ln("Search") .. ":", "", function(self, value)
			list_left.Populate(value)
		end, true)

		MSD.Button(ops_panel, ops_panel:GetWide() / 3, 0, ops_panel:GetWide() / 2 - ops_panel:GetWide() / 3 - 2, 50, Ln("offline_users"), function()
			local sub_list, _, plm = PopupMenu("Поиск по SteamID3", 2, 4, 50)
			local bank = false
			MSD.BoolSlider(sub_list, "static", nil, 1, 50, "Bank", bank, function(self, value)
				bank = value
			end)

			MSD.TextEntry(sub_list, "static", nil, 1, 50, "0000000", Ln("find_player_accountid"), "", function(self, value)
				net.Start("McINV.RequestINVOffline")
					net.WriteString(value)
					net.WriteBool(bank)
				net.SendToServer()
				plm:Close()
			end)
			if MRS.IsCharSystemOn() then
				MSD.InfoText(sub_list, "Your server has a character system enabled! Type a character ID after the steamid like this:\nSTEAM_0:0:00001 - 'STEAM_0:0:0000' is a player steamid and '1' is the character id")
			end
		end)

		list_left = vgui.Create("MSDPanelList", ops_panel)
		list_left:SetSize(ops_panel:GetWide() / 2, ops_panel:GetTall() - 54)
		list_left:SetPos(0, 52)
		list_left:EnableVerticalScrollbar()
		list_left:EnableHorizontal(true)
		list_left:SetSpacing(2)
		list_left:SetPadding(0)
		list_left.IgnoreVbar = true

		list_right = vgui.Create("MSDPanelList", ops_panel)
		list_right:SetSize(ops_panel:GetWide() / 2 - 2, ops_panel:GetTall() - 2)
		list_right:SetPos(ops_panel:GetWide() / 2, 0)
		list_right:EnableVerticalScrollbar()
		list_right:EnableHorizontal(true)
		list_right:SetSpacing(2)
		list_right:SetPadding(0)
		list_right.IgnoreVbar = true

		list_left.Populate = function(info)
			list_left:Clear()
			for _, p in ipairs(player.GetAll()) do
				if info then
					local found = false
					if string.find(string.lower(p:FullName()), string.lower(info)) then
						found = true
					end

					if p.SteamName and string.find(string.lower(p:SteamName()), string.lower(info)) then
						found = true
					end

					if string.find(string.lower(p:SteamID()), string.lower(info)) then
						found = true
					end

					if not p:IsBot() and string.find(tostring(p:SteamID64()), info) then
						found = true
					end

					if tonumber(info) == p:UserID() then
						found = true
					end

					if not found then
						continue
					end
				end

				MSD.ButtonIcon(list_left, "static", nil, 1, 50, p:FullName(), MSD.Icons48.account, function()
					if IsValid(p) then
						net.Start("McINV.RequestINV")
							net.WriteEntity(p)
							net.WriteBool(false)
						net.SendToServer()
					end
				end, function()
					if IsValid(p) then
						net.Start("McINV.RequestINV")
							net.WriteEntity(p)
							net.WriteBool(true)
						net.SendToServer()
					end
				end)
			end
		end

		list_right.Populate = function(pl, inv, bank, offline)
			pl = pl or LocalPlayer()
			inv = inv or {}
			list_right:Clear()

			if offline then
				MSD.BigButton(list_right, "static", nil, 1, 80, Ln("upl_changes"), MSD.Icons48.save, function()
					net.Start("McINV.DeleteItemOffline")
						net.WriteString(pl)
						net.WriteBool(bank)
						local cd, bn = DarkRP.TableCompress(inv)
						net.WriteInt(bn, 32)
						net.WriteData(cd, bn)
					net.SendToServer()
				end)
				MSD.BigButton(list_right, "static", nil, 1, 80, "Добавить предмет", MSD.Icons48.hand_coin, function()
					local sub_list = PopupMenu("Поиск по SteamID3", 2, 1, 50)

					for type,ilist in pairs(McINV.inv) do
						for id, item in pairs(ilist) do
							local ent = McINV.GetItem(type, item.class, item)

							McINV.InventoryItem(sub_list, ent, type, item, function(self)
								table.insert(inv[type], item)
								list_right.Populate(pl, inv, bank, offline)
							end)
						end
					end
				end)
			end

			for type,ilist in pairs(inv) do
				for id, item in pairs(ilist) do
					local ent = McINV.GetItem(type, item.class, item)
					local btn

					btn = McINV.InventoryItem(list_right, ent, type, item, function(self)
						if offline then
							inv[type][id] = nil
							btn:Remove()
							return
						end
						net.Start("McINV.DeleteItem")
							net.WriteEntity(pl)
							net.WriteBool(bank)
							net.WriteString(type)
							net.WriteUInt(id, 32)
						net.SendToServer()
						btn:Remove()
					end)
				end
			end
		end

		list_left.Populate()

		INVPANEL = list_right

		panel.Canvas:AddItem(ops_panel)
	end

	pages["sesp"] = function()
		panel.Canvas:Clear()

		panel.Slist = vgui.Create("MSDPanelList")
		panel.Slist:SetSize(panel.Canvas:GetWide() / 2 - 5, panel.Canvas:GetTall())
		panel.Slist:SetPos(panel.Canvas:GetWide() / 2 + 5, 0)
		panel.Slist:EnableVerticalScrollbar()
		panel.Slist:EnableHorizontal(true)
		panel.Slist:SetSpacing(2)
		panel.Slist.IgnoreVbar = true
		panel.Slist.Paint = function() end
		panel.Slist.Update = function()
			panel.Slist:Clear()
			MSD.Header(panel.Slist, "SESP Настройки")

			for k,v in pairs(show) do
				MSD.BoolSlider(panel.Slist, "static", nil, 1, 45, k, show[k], function(self, value)
					show[k] = value
				end)
			end
		end

		panel.Settings = vgui.Create("MSDPanelList")
		panel.Settings:SetSize(panel.Canvas:GetWide() / 2, panel.Canvas:GetTall() - 80)
		panel.Settings:SetPos(0, 0)
		panel.Settings:EnableVerticalScrollbar()
		panel.Settings:EnableHorizontal(true)
		panel.Settings:SetSpacing(2)
		panel.Settings.IgnoreVbar = true
		panel.Settings.Paint = function() end

		panel.Settings.Update = function()
			panel.Settings:Clear()
			MSD.Header(panel.Settings, "SESP Настройки")

			MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, "Включить SESP", sesp, function(self, value)
				MSD.LoadAdminTool()
				sesp = value
			end)

			MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, "Показывать информацию о предметах", sespshow.showdetails, function(self, value)
				sespshow.misc = value
			end)

			MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, "Показывать детальную информацию игроков", sespshow.players, function(self, value)
				sespshow.players = value
			end)
			MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, "Иконки классов предметов", sespshow.icons, function(self, value)
				sespshow.icons = value
			end)
			MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, "Показывать класс оружия", sespshow.weps, function(self, value)
				sespshow.weps = value
			end)
			MSD.BoolSlider(panel.Settings, "static", nil, 1, 50, "Показывать кол. денег", sespshow.money, function(self, value)
				sespshow.money = value
			end)

			MSD.TextEntry(panel.Settings, "static", nil, 1, 45, "", "Дистанция до детальной информации", sespshow.details, function(s, value)
				sespshow.details = tonumber(value) or 700
			end, true, nil, nil, true)

			MSD.TextEntry(panel.Settings, "static", nil, 1, 45, "Добавить класс предмета в список", "", "", function(s, val)
				show[val] = true
				panel.Slist.Update()
			end)

			MSD.TextEntry(panel.Settings, "static", nil, 1, 45, "Телепортировать айди предмета к себе", "", "", function(s, val)
				RunConsoleCommand("sa", "enttp", val)
			end)
		end

		panel.Settings.Update()
		panel.Slist.Update()

		panel.Canvas:AddItem(panel.Settings)
		panel.Canvas:AddItem(panel.Slist)
	end

	for k, v in pairs(buttons) do
		local button = MSD.MenuButton(panel.Menu, v[2], nil, nil, 250, 50, v[1], function(self)
			panel.Menu.Deselect(not v[5] and self or false)
			v[3]()
		end)

		if v[4] then
			panel.Menu.Deselect(button)
			v[3]()
		end
	end
end

concommand.Add("check_admin", function()
	if not sAdmin.hasPermission(LocalPlayer(), "silent") then return end
	MSD.LoadAdminTool()
	sesp = not sesp
end)
MSD.AddAdminModule("Управление", OpenAdminMenu, MSD.PinPoints[6])

local function OpenSAdminEmbedded(panel, mainPanel)
	if not panel then return end
	if not sAdmin or not isfunction(sAdmin.OpenMenu) then return end

	sAdmin.OpenMenu(panel, mainPanel)

	-- Switching to another module: notify the server we're closing so its
	-- queued networking pauses for us, the same way Close() would.
	if mainPanel then
		mainPanel.AModuleSwitch = function()
			net.Start("sA:Networking")
				net.WriteUInt(2, 3)
				net.WriteBool(false)
			net.SendToServer()
		end
	end
end

MSD.AddAdminModule("Администрирование", OpenSAdminEmbedded, MSD.Icons48.cog)

net.Receive("McINV.RequestINV", function(len, ply)
	if not IsValid(INVPANEL) then return end

	local user = net.ReadEntity()
	local bank = net.ReadBool()
	local inv = net.ReadTable()

	INVPANEL.Populate(user, inv, bank)
end)

net.Receive("McINV.RequestINVOffline", function(len, ply)
	if not IsValid(INVPANEL) then return end

	local user = net.ReadString()
	local bank = net.ReadBool()
	local inv = net.ReadTable()

	INVPANEL.Populate(user, inv, bank, true)
end)

local function OpenRequestMenu(panel, mainPanel)
	if not panel then return end

	panel.Canvas = vgui.Create("MSDPanelList", panel)
	panel.Canvas:SetSize(panel:GetWide() - 252, panel:GetTall())
	panel.Canvas:SetPos(252, 0)
	panel.Canvas:EnableVerticalScrollbar()
	panel.Canvas:EnableHorizontal(true)
	panel.Canvas:SetSpacing(2)
	panel.Canvas.IgnoreVbar = true
	panel.Canvas.Paint = function() end
	local pages = {}
	local cur_page = nil

	local function openPage(id, animate, ...)
		panel.Canvas:Clear()
		back_page = cur_page
		pages[id](...)
		cur_page = id

		if animate then
			panel.Canvas:SetAlpha(1)
			panel.Canvas:AlphaTo(255, 0.2)
		end
	end

	local buttons = {}

	buttons[1] = {
		"Список запросов", MSD.Icons48.card_multiple, function()
			openPage("data", true)
		end,
		true
	}

	--openPage("settings", true)
	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(250, panel:GetTall())
	panel.Menu:SetPos(0, 0)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(false)
	panel.Menu:SetSpacing(0)
	panel.Menu.IgnoreVbar = true

	panel.Menu.Paint = function(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
	end

	panel.Menu.Deselect = function(but)
		if not but then return end
		but.hovered = true

		for k, v in pairs(panel.Menu:GetItems()) do
			if v and v:IsValid() and v ~= but then
				v.hovered = false
			end
		end
	end

	pages["data"] = function(updated)
		MSD.ReqeustMenu = panel.Canvas
		panel.Canvas.UpdateRM = function() openPage("data", true, true) end

		if not updated then
			net.Start("sA:GetAdminData")
			net.SendToServer()
		end

		MSD.Header(panel.Canvas, "Список активных запросов", function()
			net.Start("sA:GetAdminData")
			net.SendToServer()
		end, MSD.Icons48.reload)

		local function OpenRequest(id, req)
			local plm, child = MSD.WorkSpacePanel(mainPanel, MSD.AdminReasons[req.type], 1, 1.2, false, true)

			plm.Think = function(self, w, h)
				if not IsValid(MSD.ReqeustMenu) then
					plm:Remove()
				end
			end

			local p1 = vgui.Create("MSDPanelList", child)
			p1:SetSize(child:GetWide() / 2, child:GetTall() - 55)
			p1:SetPos(5, 55)
			p1:EnableVerticalScrollbar()
			p1:EnableHorizontal(true)
			p1:SetSpacing(2)
			p1.IgnoreVbar = false

			local pl = vgui.Create("MSDPanelList", child)
			pl:SetSize(child:GetWide() / 2 - 10, child:GetTall() - 55)
			pl:SetPos(child:GetWide() / 2 + 5, 55)
			pl:EnableVerticalScrollbar()
			pl:EnableHorizontal(true)
			pl:SetSpacing(2)
			pl.IgnoreVbar = true

			MSD.InfoText(p1, "Сообщение от игрока:")
			local ent = MSD.TextEntry(p1, "static", nil, 1, 200, "", "", req.text, function() end, false, false, true, false)
			ent:SetDisabled(true)
			if not IsValid(player.GetBySteamID64(req.sid64)) then
				MSD.Header(pl, "Игрок ОФЛАЙН!")
			end
			timer.Simple(0, function() ent.StaticScale.fixed_h = ent:GetNumLines() * (draw.GetFontHeight("MSDFont.22") + 1) + 10 p1:PerformLayout() print(ent:GetLineHeight()) end)

			local chatb = MSD.TextEntry(p1, "static", nil, 1, 385, "Чат:", "", "", function() end, false, false, true, false)
			chatb:SetDisabled(true)
			chatb:SetFont("MSDFont.18")
			MSD.ActiveChat = chatb
			chatb.id = id
			chatb.UpdateChat = function(rn)
				if rn.chatlog then
					local textlog = ""
					for k, v in ipairs(rn.chatlog) do
						textlog = "[" .. k .. "] " .. v .. "\n" .. textlog
					end
					chatb:SetValue(textlog)
				end
			end

			if not req.accepted then
				MSD.TextEntry(p1, "static", nil, 1, 50, "Сообщение", "Отправить сообщение игроку:", "", function(self, value)
					RunConsoleCommand("sa", "dm", id, value)
					self:SetText("")
				end)
			end

			chatb.UpdateChat(req)

			MSD.ButtonIcon(pl, "static", nil, 2, 50, req.steamname, MSD.Icons48.steam, function()
				SetClipboardText(req.steamname)
			end)

			MSD.ButtonIcon(pl, "static", nil, 2, 50, req.name, MSD.Icons48.account, function()
				SetClipboardText(req.name)
			end)

			MSD.InfoText(pl, "Steam ID:")

			MSD.ButtonIcon(pl, "static", nil, 2, 45, req.sid64, MSD.Icons48.copy, function()
				SetClipboardText(req.sid64)
			end)

			MSD.ButtonIcon(pl, "static", nil, 2, 45, util.SteamIDFrom64(req.sid64), MSD.Icons48.copy, function()
				SetClipboardText(util.SteamIDFrom64(req.sid64))
			end)

			if req.accepted then
				MSD.Button(pl, "static", nil, 1, 50, "Жалобу принял " .. req.admin_name, function()
					SetClipboardText(req.admin)
				end)
			end

			MSD.InfoText(pl, "Действия с игроком:")

			MSD.ButtonIcon(pl, "static", nil, 2, 45, "К игроку", MSD.Icons48.arrow_right, function()
				RunConsoleCommand("sa", "goto", req.sid64)
			end)
			MSD.ButtonIcon(pl, "static", nil, 2, 45, "Призвать игрока", MSD.Icons48.arrow_down, function()
				RunConsoleCommand("sa", "bring", req.sid64)
			end)
			MSD.ButtonIcon(pl, "static", nil, 2, 45, "К телу", MSD.Icons48.human_male, function()
				RunConsoleCommand("sa", "gotobody", req.sid64)
			end)
			MSD.ButtonIcon(pl, "static", nil, 2, 45, "К машине", MSD.PinPoints[65], function()
				RunConsoleCommand("sa", "gotocar", req.sid64)
			end)
			MSD.ButtonIcon(pl, "static", nil, 2, 45, "Вернуть игрока", MSD.Icons48.account_convert, function()
				RunConsoleCommand("sa", "return", req.sid64)
			end)
			MSD.ButtonIcon(pl, "static", nil, 2, 45, "Вернуть себя", MSD.PinPoints[20], function()
				RunConsoleCommand("sa", "return", LocalPlayer():SteamID64())
			end)

			MSD.ButtonIcon(pl, "static", nil, 1, 45, "Другие действия", MSD.Icons48.console, function()
				local categories = {}
				local names = {}
				local catid = {}

				for name, v in pairs(sAdmin.commands) do
					if not v.category then continue end
					local cat = TabUI.custom_cats[v.category]
					v.name = name

					if not catid[v.category] then
						local bid = cat and cat[2] or 10
						categories[bid] = {}
						names[bid] = cat and cat[1] or v.category
						catid[v.category] = bid
					end

					categories[catid[v.category]][v.index] = v
				end

				local menu = MSD.MenuOpen(false)

				for aid, vi in SortedPairs(categories) do
					local sname = names[aid]
					local ctm = menu:AddSubMenu(sname, nil, MSD.Icons48.dot)
					for _, v in SortedPairs(vi) do
						local name = v.name
						if not sAdmin.hasPermission(LocalPlayer(), name) or not v.inputs or not v.inputs[1] or v.inputs[1][1] ~= "player" then continue end
						ctm:AddOption(name, function()
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

									LocalPlayer():ConCommand("sa " .. name .. " " .. req.sid64 .. " " .. values)
								end)
							else

								LocalPlayer():ConCommand("sa " .. name .. " " .. req.sid64)
							end
						end, TabUI.CustomIcons[name] or MSD.Icons48.dot)
					end
				end

				menu:Open()
			end)

			if not req.accepted then
				MSD.InfoText(pl, "Действия с тикетом:")
				MSD.ButtonIcon(pl, "static", nil, 1, 50, "Принять и закрыть жалобу", MSD.Icons48.check_all, function(self)
					if self.pressed then return end
					self.pressed = true
					net.Start("sA:CloseRequest")
						net.WriteUInt(id, 32)
						net.WriteBool(false)
					net.SendToServer()

					self:SetText("Жалоба принята ВАМИ")
				end)

				MSD.ButtonIcon(pl, "static", nil, 1, 50, "Пометить как неприемлемую", MSD.Icons48.close_thick, function(self)
					if self.pressed then return end
					self.pressed = true
					net.Start("sA:CloseRequest")
						net.WriteUInt(id, 32)
						net.WriteBool(true)
					net.SendToServer()

					plm.Close()
				end)
			end
			return
		end

		for k, v in pairs(sAdmin.requests) do
			if v.accepted then continue end
			local online = IsValid(player.GetBySteamID64(v.sid64))
			local pn = vgui.Create("DPanel")
			pn.StaticScale = {
				w = 4,
				fixed_h = 120,
				minw = 200,
				minh = 120
			}
			pn.Paint = function(self, wd, hd)
				MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, hd, MSD.Theme["d"])
				draw.DrawText("[" .. k .. "] " .. v.steamname, "MSDFont.24", 10, 10, online and (v.chat and MSD.Patern.MainColor["9"] or MSD.Config.MainColor.p) or MSD.Text.n, TEXT_ALIGN_LEFT)
				draw.DrawText(MSD.AdminReasons[v.type], "MSDFont.18", 10, 34, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText("Подано " ..  MSD.NiceTime(os.time() - v.time) .. " назад", "MSDFont.18", 10, 50, MSD.Text.n, TEXT_ALIGN_LEFT)
			end

			local bn = MSD.IconButtonBG(pn, MSD.PinPoints[10], 0, 0, 36, nil, MSD.Config.MainColor.p, function()
				OpenRequest(k, v)
			end)
			bn:SetSize(36, 36)
			bn:DockMargin(5, 5, 5, 5)
			bn:Dock(BOTTOM)

			panel.Canvas:AddItem(pn)

			if IsValid(MSD.ActiveChat) and MSD.ActiveChat.id == k then
				MSD.ActiveChat.UpdateChat(v)
			end
		end

		MSD.Header(panel.Canvas, "Закрытые запросы")

		for k, v in pairs(sAdmin.requests) do
			if not v.accepted then continue end
			local pn = vgui.Create("DPanel")
			pn.StaticScale = {
				w = 4,
				fixed_h = 120,
				minw = 200,
				minh = 120
			}
			pn.Paint = function(self, wd, hd)
				MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, hd, MSD.Theme["d"])
				draw.DrawText("[" .. k .. "] " .. v.steamname, "MSDFont.24", 10, 10, v.bad and MSD.Config.MainColor.rd or MSD.Config.MainColor.p, TEXT_ALIGN_LEFT)
				draw.DrawText(MSD.AdminReasons[v.type], "MSDFont.18", 10, 34, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText("Подано: " ..  os.date("%H:%M:%S", v.time) , "MSDFont.18", 10, 50, MSD.Text.n, TEXT_ALIGN_LEFT)
			end

			local bn = MSD.IconButtonBG(pn, MSD.Icons48.file_document, 0, 0, 36, nil, MSD.Config.MainColor.p, function()
				OpenRequest(k, v)
			end)
			bn:DockMargin(5, 5, 5, 5)
			bn:Dock(BOTTOM)

			panel.Canvas:AddItem(pn)
		end
	end

	for k, v in pairs(buttons) do
		local button = MSD.MenuButton(panel.Menu, v[2], nil, nil, 250, 50, v[1], function(self)
			panel.Menu.Deselect(not v[5] and self or false)
			v[3]()
		end)

		if v[4] then
			panel.Menu.Deselect(button)
			v[3]()
		end
	end
end

MSD.AddAdminModule("Запросы", OpenRequestMenu, MSD.PinPoints[8])

local function OpenRestoreMenu(panel, mainPanel)
	if not panel then return end

	panel.Canvas = vgui.Create("MSDPanelList", panel)
	panel.Canvas:SetSize(panel:GetWide() - 252, panel:GetTall())
	panel.Canvas:SetPos(252, 0)
	panel.Canvas:EnableVerticalScrollbar()
	panel.Canvas:EnableHorizontal(true)
	panel.Canvas:SetSpacing(2)
	panel.Canvas.IgnoreVbar = true
	panel.Canvas.Paint = function() end
	local pages = {}
	local cur_page = nil

	local function openPage(id, animate, ...)
		panel.Canvas:Clear()
		back_page = cur_page
		pages[id](...)
		cur_page = id

		if animate then
			panel.Canvas:SetAlpha(1)
			panel.Canvas:AlphaTo(255, 0.2)
		end
	end

	local function PopupMenu(text, x, y, w, dwd)
		local pl, child = MSD.WorkSpacePanel(mainPanel, text, x, y, false, true)
		local sub_list = vgui.Create("MSDPanelList", child)
		sub_list:SetSize(dwd and child:GetWide() / dwd or child:GetWide() - 10, child:GetTall() - w)
		sub_list:SetPos(5, w)
		sub_list:EnableVerticalScrollbar()
		sub_list:EnableHorizontal(true)
		sub_list:SetSpacing(2)
		sub_list.IgnoreVbar = true
		return sub_list, child, pl
	end

	local buttons = {}
	local canCreate = sAdmin.hasPermission(LocalPlayer(), "restore_create")
	local canApprove = sAdmin.hasPermission(LocalPlayer(), "restore_approve")

	buttons[1] = {
		"Список возвратов", MSD.Icons48.card_multiple, function()
			openPage("data", true)
		end,
		true
	}

	if canCreate then
		buttons[2] = {
			"Создать запрос", MSD.Icons48.clipboard_arrow_up, function()
				openPage("save", true)
			end,
		}
	end

	sAdmin.RestoreTickets = sAdmin.RestoreTickets or { tickets = {} }
	sAdmin.RestoreTickets.tickets = sAdmin.RestoreTickets.tickets or {}

	local search_sid = ""

	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(250, panel:GetTall())
	panel.Menu:SetPos(0, 0)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(false)
	panel.Menu:SetSpacing(0)
	panel.Menu.IgnoreVbar = true

	panel.Menu.Paint = function(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
	end

	panel.Menu.Deselect = function(but)
		if not but then return end
		but.hovered = true

		for k, v in pairs(panel.Menu:GetItems()) do
			if v and v:IsValid() and v ~= but then
				v.hovered = false
			end
		end
	end

	local function ticketStatus(t)
		if t.delivered then return "Выдано" end
		if t.approved then return "Одобрено" end
		return "Ожидает"
	end

	local function ticketColor(t)
		if t.delivered then return MSD.Text.n end
		if t.approved then return MSD.Config.MainColor.p end
		return MSD.Config.MainColor.r
	end

	local function ticketItemCount(t)
		local n = 0
		for _, list in pairs(t.items or {}) do n = n + #list end
		return n
	end

	local function OpenTicket(id, ticket)
		local pl, _, plm = PopupMenu("Заявка №" .. id, 2.5, 1, 55)

		MSD.InfoText(pl, "SteamID игрока:")
		MSD.Button(pl, "static", nil, 1, 45, ticket.sid, function()
			SetClipboardText(ticket.sid)
		end)

		MSD.InfoText(pl, "Создал: " .. (ticket.creator_name or "?"))
		MSD.Button(pl, "static", nil, 1, 45, ticket.creator_sid64 or "0", function()
			SetClipboardText(ticket.creator_sid64 or "0")
		end)

		MSD.InfoText(pl, "Создано: " .. os.date("%H:%M:%S - %d/%m/%Y", ticket.created_time or 0))
		MSD.InfoText(pl, "Статус: " .. ticketStatus(ticket))

		if ticket.reason and ticket.reason ~= "" then
			MSD.InfoHeader(pl, "Причина")
			MSD.InfoText(pl, ticket.reason)
		end

		if ticket.approved then
			MSD.InfoText(pl, "Одобрил: " .. (ticket.approver_name or "?") .. " (" .. os.date("%H:%M:%S - %d/%m/%Y", ticket.approved_time or 0) .. ")")
		end

		if ticket.delivered then
			MSD.InfoText(pl, "Выдано: " .. os.date("%H:%M:%S - %d/%m/%Y", ticket.delivered_time or 0))
		end

		MSD.InfoHeader(pl, "Деньги: " .. (ticket.money or 0) .. "$")
		MSD.InfoHeader(pl, "Предметов: " .. ticketItemCount(ticket))

		for cat, list in pairs(ticket.items or {}) do
			if not DarkRP[cat] then continue end
			MSD.InfoHeader(pl, cat)
			for _, class in ipairs(list) do
				local data = DarkRP[cat][class]
				if not data then continue end
				MSD.InfoText(pl, "- " .. (data.name or class))
			end
		end

		if not ticket.approved and canApprove then
			MSD.ButtonIcon(pl, "static", nil, 1, 50, "Одобрить заявку", MSD.Icons48.check_all, function(self)
				if self.pressed then return end
				self.pressed = true
				net.Start("sA:RestoreAction")
					net.WriteUInt(0, 2)
					net.WriteUInt(id, 32)
				net.SendToServer()
				plm.Close()
			end)
		end

		if not ticket.delivered and canApprove then
			MSD.ButtonIcon(pl, "static", nil, 1, 50, "Удалить заявку", MSD.Icons48.close_thick, function(self)
				if self.pressed then return end
				self.pressed = true
				net.Start("sA:RestoreAction")
					net.WriteUInt(1, 2)
					net.WriteUInt(id, 32)
				net.SendToServer()
				plm.Close()
			end)
		end
	end

	local function refreshList()
		net.Start("sA:RestoreSync")
		net.SendToServer()
	end

	pages["data"] = function()
		MSD.RestoreMenu = panel.Canvas
		panel.Canvas.UpdateRM = function() openPage("data", true) end

		MSD.Header(panel.Canvas, "Список заявок на возврат", refreshList, MSD.Icons48.reload)

		MSD.TextEntry(panel.Canvas, "static", nil, 1, 50, "STEAM_0:0:000 или SteamID64", "Поиск по SteamID", search_sid, function(self, value)
			search_sid = value or ""
			openPage("data", true)
		end, true)

		local pending = {}
		local approved = {}
		local delivered = {}
		local filter = string.lower(search_sid or "")

		for id, t in pairs(sAdmin.RestoreTickets.tickets or {}) do
			if filter ~= "" then
				local sid = string.lower(t.sid or "")
				if not string.find(sid, filter, 1, true) then continue end
			end
			if t.delivered then
				table.insert(delivered, {id = id, t = t})
			elseif t.approved then
				table.insert(approved, {id = id, t = t})
			else
				table.insert(pending, {id = id, t = t})
			end
		end

		local function drawTicketCard(entry)
			local id, t = entry.id, entry.t
			local pn = vgui.Create("DPanel")
			pn.StaticScale = {
				w = 4,
				fixed_h = 120,
				minw = 200,
				minh = 120
			}

			pn.Paint = function(self, wd, hd)
				MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, hd, MSD.Theme["d"])
				draw.DrawText("[" .. id .. "] " .. (t.creator_name or "?"), "MSDFont.24", 10, 10, ticketColor(t), TEXT_ALIGN_LEFT)
				draw.DrawText(t.sid .. "  " .. (t.money or 0) .. "$  " .. ticketItemCount(t) .. " предм.", "MSDFont.18", 10, 34, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText(ticketStatus(t) .. " (создано " .. MSD.NiceTime(os.time() - (t.created_time or os.time())) .. " назад)", "MSDFont.18", 10, 50, MSD.Text.n, TEXT_ALIGN_LEFT)
			end

			local bn = MSD.IconButtonBG(pn, MSD.PinPoints[10], 0, 0, 36, nil, MSD.Config.MainColor.p, function()
				OpenTicket(id, t)
			end)
			bn:SetSize(36, 36)
			bn:DockMargin(5, 5, 5, 5)
			bn:Dock(BOTTOM)

			panel.Canvas:AddItem(pn)
		end

		MSD.InfoHeader(panel.Canvas, "Ожидают одобрения (" .. #pending .. ")")
		for _, e in ipairs(pending) do drawTicketCard(e) end

		MSD.InfoHeader(panel.Canvas, "Одобрены, ждут выдачи (" .. #approved .. ")")
		for _, e in ipairs(approved) do drawTicketCard(e) end

		MSD.InfoHeader(panel.Canvas, "Выданы (" .. #delivered .. ")")
		for _, e in ipairs(delivered) do drawTicketCard(e) end
	end

	pages["save"] = function()
		if not canCreate then
			MSD.Header(panel.Canvas, "Нет прав на создание заявки")
			return
		end

		MSD.Header(panel.Canvas, "Создать заявку на возврат")

		local ops_panel = vgui.Create("DPanel")
		ops_panel:SetSize(panel.Canvas:GetWide(), panel.Canvas:GetTall() - 52)
		ops_panel.Paint = function(self, w, h)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, w / 2 - 2, h, MSD.Theme["l"])
			MSDX.Draw(MSD.Config.Rounded, w / 2, 0, w / 2 - 2, h, MSD.Theme["l"])
		end

		local target_sid = ""
		local money = 0
		local restore_list = {}
		local filter = ""
		local reason = ""

		local l_list = vgui.Create("MSDPanelList", ops_panel)
		l_list:SetSize(ops_panel:GetWide() / 2 - 2, ops_panel:GetTall())
		l_list:SetPos(0, 0)
		l_list:EnableVerticalScrollbar()
		l_list:EnableHorizontal(true)
		l_list:SetSpacing(2)
		l_list:SetPadding(0)
		l_list.IgnoreVbar = true

		local r_list = vgui.Create("MSDPanelList", ops_panel)
		r_list:SetSize(ops_panel:GetWide() / 2 - 2, ops_panel:GetTall())
		r_list:SetPos(ops_panel:GetWide() / 2, 0)
		r_list:EnableVerticalScrollbar()
		r_list:EnableHorizontal(true)
		r_list:SetSpacing(2)
		r_list:SetPadding(0)
		r_list.IgnoreVbar = true

		function r_list:Update()
			r_list:Clear()
			MSD.InfoHeader(r_list, "Содержимое заявки")
			MSD.InfoText(r_list, "Деньги: " .. money .. "$")

			for cat, tab in pairs(restore_list) do
				if #tab == 0 then continue end
				MSD.InfoHeader(r_list, cat)
				local ls = DarkRP[cat]
				if not ls then continue end

				for k, v in pairs(tab) do
					local it = ls[v]
					if not it then continue end
					local _, i = MSD.IconRender.Get(it.model or "models/props_junk/CinderBlock01a.mdl", it.material, it.submat)

					local icon = vgui.Create("ContentIcon")
					icon:SetMaterial(cat == "Weapons" and "entities/" .. v .. ".png" or "data/msd_render/" .. (i or ""))
					icon:SetName(it.name or v)
					icon.DoClick = function()
						table.remove(restore_list[cat], k)
						r_list:Update()
					end

					r_list:AddItem(icon)
				end
			end

			MSD.BigButton(r_list, "static", nil, 1, 80, "Отправить заявку", MSD.Icons48.clipboard_arrow_up, function(s)
				if s.pressed then return end

				if not target_sid or target_sid == "" then
					notification.AddLegacy("Укажите SteamID игрока", NOTIFY_ERROR, 3)
					return
				end

				local has_items = false
				for _, list in pairs(restore_list) do
					if #list > 0 then has_items = true break end
				end

				if money <= 0 and not has_items then
					notification.AddLegacy("Заявка не может быть пустой", NOTIFY_ERROR, 3)
					return
				end

				if not reason or reason == "" then
					notification.AddLegacy("Укажите причину возврата", NOTIFY_ERROR, 3)
					return
				end

				s.pressed = true

				net.Start("sA:RestoreCreate")
					net.WriteString(target_sid)
					net.WriteUInt(math.max(0, math.floor(money)), 32)
					net.WriteString(util.TableToJSON(restore_list))
					net.WriteString(reason)
				net.SendToServer()

				timer.Simple(0.3, function()
					if not IsValid(panel.Canvas) then return end
					openPage("data", true)
				end)
			end)
		end

		local function openMenu(get)
			if not DarkRP[get] then return end

			local pl, _, plm = PopupMenu(get, 1, 1.1, 55)

			for k, v in pairs(DarkRP[get]) do
				if filter and filter ~= "" and not (string.find(string.lower(k), string.lower(filter)) or string.find(utf8.lower(v.name or ""), utf8.lower(filter))) then continue end
				local _, i = MSD.IconRender.Get(v.model or "models/props_junk/CinderBlock01a.mdl", v.material, v.submat)

				local icon = vgui.Create("ContentIcon")
				icon:SetMaterial(get == "Weapons" and "entities/" .. k .. ".png" or "data/msd_render/" .. (i or ""))
				icon:SetName(v.name or k)
				icon.DoClick = function()
					restore_list[get] = restore_list[get] or {}
					table.insert(restore_list[get], k)
					r_list:Update()
					plm.Close()
				end

				pl:AddItem(icon)
			end
		end

		panel.Canvas:AddItem(ops_panel)

		MSD.TextEntry(l_list, "static", nil, 1, 50, "STEAM_0:0:000", "SteamID игрока", "", function(self, value)
			target_sid = value or ""
		end, true)

		MSD.TextEntry(l_list, "static", nil, 1, 50, "Оставьте 0 если не нужно", "Игровая валюта", "0", function(self, value)
			money = tonumber(value) or 0
			r_list:Update()
		end, true, nil, nil, true)

		MSD.TextEntry(l_list, "static", nil, 1, 50, "Кратко опишите ситуацию", "Причина возврата", "", function(self, value)
			reason = value or ""
		end, true)

		MSD.TextEntry(l_list, "static", nil, 1, 50, "", "Поиск по предметам", "", function(self, value)
			filter = value or ""
		end, true)

		MSD.ButtonIcon(l_list, "static", nil, 1, 45, "Оружие", MSD.Icons48.pistol, function()
			openMenu("Weapons")
		end)
		MSD.ButtonIcon(l_list, "static", nil, 1, 45, "Предмет", MSD.Icons48.box, function()
			openMenu("Junk")
		end)
		MSD.ButtonIcon(l_list, "static", nil, 1, 45, "Еда", MSD.Icons48.food, function()
			openMenu("Food")
		end)
		MSD.ButtonIcon(l_list, "static", nil, 1, 45, "Боеприпасы", MSD.Icons48.ammo, function()
			openMenu("Ammo")
		end)
		MSD.ButtonIcon(l_list, "static", nil, 1, 45, "Особый предмет", MSD.Icons48.box_open_star, function()
			openMenu("Entities")
		end)

		r_list:Update()
	end

	refreshList()

	for k, v in pairs(buttons) do
		local button = MSD.MenuButton(panel.Menu, v[2], nil, nil, 250, 50, v[1], function(self)
			panel.Menu.Deselect(not v[5] and self or false)
			v[3]()
		end)

		if v[4] then
			panel.Menu.Deselect(button)
			v[3]()
		end
	end
end
MSD.AddAdminModule("Возвраты", OpenRestoreMenu, MSD.Icons48.cached)

net.Receive("sA:RestoreSync", function()
	sAdmin.RestoreTickets = sAdmin.RestoreTickets or { tickets = {} }

	local mode = net.ReadUInt(2)

	if mode == 0 then
		local bn = net.ReadUInt(32)
		local cd = net.ReadData(bn)
		local data = DarkRP.TableDecompress(cd)
		sAdmin.RestoreTickets.tickets = data or {}
	elseif mode == 1 then
		local payload = util.JSONToTable(net.ReadString() or "") or {}
		local id = tonumber(payload.id)
		if id then
			sAdmin.RestoreTickets.tickets[id] = payload.ticket
		end
	end

	if IsValid(MSD.RestoreMenu) and MSD.RestoreMenu.UpdateRM then
		MSD.RestoreMenu.UpdateRM()
	end
end)