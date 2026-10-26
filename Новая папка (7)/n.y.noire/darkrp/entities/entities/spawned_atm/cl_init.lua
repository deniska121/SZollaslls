--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/spawned_atm/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local clrs = {
	Color(5,62,95),
	Color(19,96,141),
	Color(18,155,109),
	Color(70,187,255),
	Color(0,199,133),
}

local intW, intH = 700, 500

function ENT:Draw()
	self:DrawModel()

	if not DarkRP.ViewFocus or DarkRP.ViewFocus.ent ~= self then return end

	local Pos = self:GetPos() + self:GetUp() * 65.9 + self:GetForward() * 9 + self:GetRight() * 19
	local Ang = self:GetAngles()
	Ang:RotateAroundAxis(Ang:Up(), 90)
	Ang:RotateAroundAxis(Ang:Forward(), 83)
	cam.Start3D2D(Pos, Ang, 0.025)
		draw.RoundedBox(0, 0, 0, intW, intH, clrs[1])
		if DarkRP.ViewFocus.sg then
			MSD.DrawTexturedRect(intW / 2 - 24, intH / 2 - 33, 48, 66, Win98.Icon("sandglass/" .. DarkRP.ViewFocus.sg), color_white)
		end
	cam.End3D2D()
end

function ENT:OpenMenu()
	DarkRP.ViewFocus = {
		ent = self,
		ang = Angle(0,-15,180),
		point = Vector(14.14,-10.3,50.6),
		cfov = 17,
		fade = false,
		sg = 1
	}

	self:EmitSound("noire/atm/cardinsert.wav")

	local main = vgui.Create("MSDSimpleFrame")
	main:SetSize(ScrW() - ScrW() / 3, ScrH() - ScrH() / 8 + 50)
	main:SetDraggable(false)
	main:Center()
	main:MakePopup()

	local menu = vgui.Create("Panel", main)
	menu:SetSize(ScrW() - ScrW() / 3, ScrH() - ScrH() / 8)
	menu:SetPos(0, 50)
	menu:SetAlpha(0)
	menu:AlphaTo(255, 0, 3.8, function()
		self:EmitSound("noire/atm/beep_short.wav")
		if DarkRP.ViewFocus then DarkRP.ViewFocus.sg = nil end
	end)
	menu.name = "Выберите сервис"
	menu.Paint = function(s, w, h)
		if DarkRP.ViewFocus and DarkRP.ViewFocus.sg and (not s.ptime or s.ptime < CurTime()) then
			DarkRP.ViewFocus.sg = DarkRP.ViewFocus.sg + 1
			s.ptime = CurTime() + 0.1
			if DarkRP.ViewFocus.sg > 7 then
				DarkRP.ViewFocus.sg = 1
			end
		end

		s.walet = "Баланс: $" .. string.Comma(LocalPlayer():getDarkRPVar("money") or 0)
		MSD.ShadowText(menu.walet, "Pixel.M", 20, 20, color_white, TEXT_ALIGN_LEFT, 2)

		MSD.ShadowText(menu.name, "Pixel.M", w / 2, 120, color_white, TEXT_ALIGN_CENTER, 2)
	end

	main.OnClose = function(s, w, h)
		if DarkRP.ViewFocus then
			DarkRP.ViewFocus.fade = true
		end

		self:EmitSound("noire/atm/close.wav")
	end

	MSD.IconButton(main, Win98.Icon("exit"), main:GetWide() - 78, 20, 48, nil, clrs[4], function()
		main:Close()
		surface.PlaySound("mcphone/but_press.wav")
	end)

	local plist = vgui.Create("MSDPanelList", menu)
	plist:SetSize(menu:GetWide(), menu:GetTall() - 300)
	plist:SetPos(0, 300)
	plist:EnableVerticalScrollbar()
	plist:EnableHorizontal(true)
	plist:SetSpacing(10)
	plist:SetPadding(10)
	Slawer.Mayor.TicketsMenu = plist

	local buts = {
		{
			name = "Зарплатный счет",
			func = function()
				if menu:GetAlpha(0) < 1 then return end
				plist.payday()
				DarkRP.ViewFocus.sg = 1
				self:EmitSound("noire/atm/press1.wav")
			end
		},
		{
			name = "Штрафы",
			func = function()
				if menu:GetAlpha(0) < 1 then return end
				Slawer.Mayor:NetStart("GetTickets", {
					self = true
				})
				DarkRP.ViewFocus.sg = 1
				self:EmitSound("noire/atm/press1.wav")
			end
		},
	}
	plist.main = function()
		menu.name = "Выберите сервис"
		plist:Clear()

		for k,v in pairs(buts) do
			local btnStart = vgui.Create("DButton")
			btnStart:SetSize(menu:GetWide(), 170)
			btnStart:SetText(v.name)
			btnStart.Paint = function(s, w, h)
				MSD.ShadowText(s:GetText(), "Pixel.M", 15, h / 2, s.hover and clrs[3] or color_white, TEXT_ALIGN_LEFT, 2)
				return true
			end
			btnStart.DoClick = v.func
			btnStart.OnCursorEntered = function(s) s.hover = true end
			btnStart.OnCursorExited = function(s) s.hover = false end

			plist:AddItem(btnStart)
		end
	end

	plist.payday = function()
		menu.name = "Зарплатный счет"
		plist:Clear()
		menu:SetAlpha(0)
		DarkRP.ViewFocus.sg = 1
		menu:AlphaTo(255, 0, 1, function()
			self:EmitSound("noire/atm/beep_short.wav")
			if DarkRP.ViewFocus then DarkRP.ViewFocus.sg = nil end
		end)

		local pnl = vgui.Create("DPanel")
		pnl:SetSize(menu:GetWide(), 170)
		pnl:SetText("Вывести средства")
		pnl.text = "У вас на счету $" .. (LocalPlayer():getDarkRPVar("payday") or 0)
		pnl.Paint = function(s, w, h)
			MSD.ShadowText(s.text, "Pixel.M", 15, h / 2, s.hover and clrs[3] or color_white, TEXT_ALIGN_LEFT, 2)
			return true
		end
		plist:AddItem(pnl)

		local btnStart = vgui.Create("DButton")
		btnStart:SetSize(menu:GetWide(), 170)
		btnStart:SetText("Вывести средства")
		btnStart.Paint = function(s, w, h)
			MSD.ShadowText(s:GetText(), "Pixel.M", 15, h / 2, s.hover and clrs[3] or color_white, TEXT_ALIGN_LEFT, 2)
			return true
		end
		btnStart.DoClick = function()
			Slawer.Mayor:NetStart("GetSalary", {
				ent = self:EntIndex()
			})
			DarkRP.ViewFocus.sg = 1
			menu:Remove()
			surface.PlaySound("mcphone/but_press.wav")
		end
		btnStart.OnCursorEntered = function(s) s.hover = true end
		btnStart.OnCursorExited = function(s) s.hover = false end
		plist:AddItem(btnStart)
	end

	plist.update = function(tbl)
		menu:SetAlpha(0)
		DarkRP.ViewFocus.sg = 1
		menu:AlphaTo(255, 0, 2, function()
			self:EmitSound("noire/atm/beep_short.wav")
			if DarkRP.ViewFocus then DarkRP.ViewFocus.sg = nil end
		end)

		menu.name = "Штрафы"
		plist:Clear()

		if not tbl.tickets then return end

		for k, v in pairs(tbl.tickets) do
			local text = MSD.TextWrap("Штраф за: " .. v.name  .. "\nСумма: $" .. v.fee, "Pixel.S", menu:GetWide() - 20)
			local pnl = vgui.Create("DPanel")
			pnl:SetSize(menu:GetWide() - 20, 220)
			function pnl:Paint(w, h)
				MSD.ShadowText(text, "Pixel.S", 18, 8, color_white, TEXT_ALIGN_LEFT, 2)
				MSD.DrawTexturedRect(0, 0, w, 5, MSD.Materials.gradient_center, color_white)
			end

			pnl.pay = vgui.Create("DButton", pnl)
			pnl.pay:SetSize(300, 80)
			pnl.pay:SetPos(pnl:GetWide() - 300, pnl:GetTall() - 90)
			pnl.pay:SetText("Оплатить")
			pnl.pay.Paint = function(s, w, h)
				draw.DrawText(s:GetText(), "Pixel.M", w - 5, 7, color_black, TEXT_ALIGN_RIGHT)
				draw.DrawText(s:GetText(), "Pixel.M", w - 5, 5, s.hover and clrs[3] or color_white, TEXT_ALIGN_RIGHT)
				return true
			end
			pnl.pay.DoClick = function()
				Slawer.Mayor:NetStart("PayTicket", {
					ticket = k
				})
				DarkRP.ViewFocus.sg = 1
				self:EmitSound("noire/atm/press1.wav")
				menu:SetAlpha(0)
			end
			pnl.pay.OnCursorEntered = function(s) s.hover = true end
			pnl.pay.OnCursorExited = function(s) s.hover = false end

			plist:AddItem(pnl)
		end
	end

	plist.main()
end