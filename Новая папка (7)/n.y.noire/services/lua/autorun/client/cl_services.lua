--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/services/lua/autorun/client/cl_services.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("sh_services_config.lua")

Dispatcher = Dispatcher or {}
Dispatcher.Log = Dispatcher.Log or {}

net.Receive("services_update", function()
	local grp = net.ReadString()
	local bn = net.ReadUInt(32)
	local tb = DarkRP.TableDecompress(net.ReadData(bn))
	print(2)
	if not tb then return end

	Dispatcher.Log[grp] = tb
	print(1)
	PrintTable(Dispatcher.Log)
	timer.Simple(0.1, function()
		if IsValid(Dispatcher.Menu) and Dispatcher.Menu.UpdateLog then
			Dispatcher.Menu.UpdateLog()
		end
	end)
end)

local ict = {
	["NYPD"] = "https://macnco.one/rankup/nypd.png",
	["FDNY"] = "https://macnco.one/rankup/nyfd.png",
}

local logo1 = Material("gmodla/cd_2.png", "smooth")

Dispatcher.OpenMenu = function()
	if IsValid(Dispatcher.Menu) then
		Dispatcher.Menu:Remove()
		return
	end

	local grp = ""
	local ply = LocalPlayer()

	for k,v in pairs(Dispatcher.Config.Grps) do
		if v.Teams[ply:Team()] then
			grp = k
			break
		end
	end

	net.Start("services_update")
		net.WriteString(grp)
	net.SendToServer()

	local SW, SH = ScrW(), ScrH()
	local hs = 440

	Dispatcher.Menu = vgui.Create("MSDSimpleFrame")
	Dispatcher.Menu:SetSize(SW - 20, SH - SH / 6)
	Dispatcher.Menu:SetPos(15, 15)
	Dispatcher.Menu:SetAlpha(1)
	Dispatcher.Menu:AlphaTo(255, 0.5)
	Dispatcher.Menu:MakePopup()
	Dispatcher.Menu.Paint = function(s, w, h)
		MSD.Blur(s, 2, 2, 255, 0, hs, h)
		MSDX.Draw(0, 0, 0, hs, h, MSD.Theme.d)
		MSD.DrawTexturedRect(0, 0, hs, 120, logo1, color_white)
		if ict[grp] then
			MSD.DrawTexturedRect(24, 24, 64, 64, MSD.ImgLib.GetMaterial(ict[grp]), color_white)
		end

		draw.SimpleText("Вызовы", "MSDFontB.32", 100, 38, tc, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
	end
	Dispatcher.Menu.Think = function(self)
		if not ply:IsFreeman() or input.IsKeyDown(KEY_ESCAPE) or (input.IsKeyDown(KEY_F4) and self:GetAlpha() > 250) then
			self:Remove()
		end
	end

	local menu = Dispatcher.Menu

	menu.clsBut = MSD.IconButton(menu, MSD.Icons48.cross, hs - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
		if menu.OnPress then
			menu.OnPress()

			return
		end

		menu:AlphaTo(0, 0.4, 0, function()
			menu:Close()
		end)
	end)

	menu.OpenCall = function(k, v)
		if IsValid(menu.page) then
			menu.page:Remove()
		end

		menu.page = vgui.Create("DPanel", menu)
		menu.page:SetSize((SW - 30 - hs) / 3, menu:GetTall())
		menu.page:SetPos(hs + 15, 0)
		menu.page:SetAlpha(1)
		menu.page:AlphaTo(255, 0.5)
		menu.page.Paint = function(s, w, h)
			MSD.Blur(s, 2, 2, 255, 0, w, h)
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		end

		menu.canvas = vgui.Create("MSDPanelList", menu.page)
		menu.canvas:SetSize(menu.page:GetWide(), menu.page:GetTall())
		menu.canvas:SetPos(0, 0)
		menu.canvas:SetSpacing(2)
		menu.canvas:SetPadding(0)
		menu.canvas:EnableVerticalScrollbar()
		menu.canvas:EnableHorizontal(true)
		menu.canvas.IgnoreVbar = true

		MSD.Header(menu.canvas, "Вызов № " .. k)

		local panel = vgui.Create("DPanel")
		panel.StaticScale = { w = 1, fixed_h = 85, minw = 250, minh = 70 }
		panel.Paint = function(self, w, h)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])

			local s = draw.SimpleText("Заявитель: ", "MSDFont.24", 5, 5, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(v.name, "MSDFont.24", s + 5, 5, MSD.Text["l"], TEXT_ALIGN_LEFT)

			s = draw.SimpleText("Причина: ", "MSDFont.24", 5, 35, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(v.reason, "MSDFont.24", s + 5, 35, MSD.Text["l"], TEXT_ALIGN_LEFT)

			draw.DrawText("Вызов поступил " ..  MSD.NiceTime(os.time() - v.time) .. " назад", "MSDFont.18", 5, h - 20, MSD.Text.n, TEXT_ALIGN_LEFT)
		end

		menu.canvas:AddItem(panel)

		if v.number then
			MSD.ButtonIcon(menu.canvas, "static", nil, 1, 60, "Связаться с заявителем", MSD.Icons48.cellphone_basic, function()
				net.Start("McPhone.CallStart")
				net.WriteString(v.number)
				net.WriteBool(true)
				net.WriteString("911")
				net.SendToServer()
			end)
		end

		MSD.ButtonIcon(menu.canvas, "static", nil, 1, 60, "Место вызова", MSD.PinPoints[30], function()
			McPhone.ToggleGPS("Вызов", v.pos)
		end)

		if v.status == 1 then
			if table.IsEmpty(v.responders) then
				MSD.Header(menu.canvas, "Нет активных юнитов")
			else
				MSD.Header(menu.canvas, "Юниты на вызове:")
				for a, b in pairs(v.responders) do
					local p = player.GetBySteamID(a)
					if IsValid(p) then
						MSD.InfoHeader(menu.canvas, DarkRP.Police.Units[p:UserID()])
					end
				end
			end

			if v.responders[ply:SteamID()] then
				MSD.ButtonIcon(menu.canvas, "static", nil, 1, 60, "Открепиться с вызова", MSD.Icons48.clipboard_arrow_up, function()
					net.Start("services_respond")
						net.WriteString(grp)
						net.WriteUInt(k, 32)
						net.WriteUInt(2, 3)
					net.SendToServer()
					menu:Close()
				end)

				MSD.ButtonIcon(menu.canvas, "static", nil, 1, 60, "Отметить вызов как завершенный", MSD.Icons48.check_all, function()
					net.Start("services_respond")
						net.WriteString(grp)
						net.WriteUInt(k, 32)
						net.WriteUInt(3, 3)
					net.SendToServer()
					menu:Close()
				end)
			else
				MSD.ButtonIcon(menu.canvas, "static", nil, 1, 60, "Принять вызов", MSD.Icons48.check_bold, function()
					net.Start("services_respond")
						net.WriteString(grp)
						net.WriteUInt(k, 32)
						net.WriteUInt(1, 3)
					net.SendToServer()
					McPhone.SetGPS("Вызов", v.pos)
					menu:Close()
				end)
			end
		else

			MSD.Header(menu.canvas, "Прикреплённые юниты")
			for a, b in pairs(v.responders) do
				local p = player.GetBySteamID(a)
				if IsValid(p) then
					MSD.InfoHeader(menu.canvas, b.unit .. " " .. b.name)
				end
			end

			if v.closedby and v.closed then
				MSD.InfoHeader(menu.canvas, "Вызов завершил: " .. v.closedby)
				MSD.InfoHeader(menu.canvas, "Вызов завершен " .. MSD.NiceTime(os.time() - v.closed) .. " назад")
			end
		end
	end
	--
	menu.list = vgui.Create("MSDPanelList", menu)
	menu.list:SetSize(hs, menu:GetTall() - 125)
	menu.list:SetPos(0, 120)
	menu.list:EnableVerticalScrollbar()
	menu.list:EnableHorizontal(true)
	menu.list:SetSpacing(2)
	menu.list:SetPadding(0)

	local function addToList(k, v)
		local pn = vgui.Create("DPanel")
		pn.StaticScale = {
			w = 1,
			fixed_h = 64,
			minw = 200,
			minh = 64
		}
		pn.Paint = function(self, wd, hd)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, hd, MSD.Theme["d"])
			draw.DrawText("[" .. k .. "] " .. v.reason, "MSDFont.24", 10, 10, v.status == 1 and (v.responders[ply:SteamID()] and MSD.Config.MainColor.p or MSD.Patern.MainColor["1"]) or MSD.Text["n"], TEXT_ALIGN_LEFT)
			draw.DrawText("Подано " ..  MSD.NiceTime(os.time() - v.time) .. " назад", "MSDFont.18", 10, 40, MSD.Text.n, TEXT_ALIGN_LEFT)
		end

		local bn = MSD.IconButtonBG(pn, MSD.Icons48.folder_open, 0, 0, 36, nil, MSD.Config.MainColor.p, function()
			menu.OpenCall(k, v)
		end)
		bn:SetSize(36, 36)
		bn:DockMargin(5, 5, 5, 5)
		bn:Dock(RIGHT)

		menu.list:AddItem(pn)
	end

	Dispatcher.Menu.UpdateLog = function()
		menu.list:Clear()

		if not Dispatcher.Log[grp] then
			MSD.Header(menu.list, "Пусто", function()
				net.Start("services_update")
				net.WriteString(grp)
				net.SendToServer()
			end, MSD.Icons48.reload)
			return
		end

		MSD.Header(menu.list, "Активные вызовы", function()
			net.Start("services_update")
			net.WriteString(grp)
			net.SendToServer()
		end, MSD.Icons48.reload)

		for k, v in pairs(Dispatcher.Log[grp]) do
			if v.status ~= 1 then continue end
			addToList(k, v)
		end

		MSD.Header(menu.list, "Завершенные вызовы")

		for k, v in pairs(Dispatcher.Log[grp]) do
			if v.status == 1 then continue end
			addToList(k, v)
		end
	end
end