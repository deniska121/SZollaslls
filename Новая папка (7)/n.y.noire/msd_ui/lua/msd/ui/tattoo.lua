--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/tattoo.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- local center_gradient = Material("gui/center_gradient.vtf", "smooth")
-- local color_red = Color(231, 0, 0)
-- local star = Material("gmodla/star2.png", "smooth")
local color_b50 = Color(0,0,0,220)
local color_w50 = Color(255,255,255,150)

local gmodla2 = Material("gmodla/logo_c1.png", "smooth")
local glass = Material("gmodla/glass.png", "smooth")

local function CreateDLight()
	if MCR.dlight then
		MCR.dlight.DieTime = CurTime() + FrameTime()
	end

	MCR.dlight = DynamicLight(LocalPlayer():EntIndex())
	MCR.dlight.r = 255
	MCR.dlight.g = 255
	MCR.dlight.b = 255
	MCR.dlight.Brightness = 1
	MCR.dlight.Pos = Vector(1472.5306396484,-1891.0314941406,-1.5589141845703)
	MCR.dlight.Size = 800
	MCR.dlight.DieTime = CurTime() + 12000
end

MSD.fovus_board = {
	["a1"] = {Vector(-25,-10,15), -20},
	["a2"] = {Vector(20,20,7), -35},
	["a3"] = {Vector(20,0,-7), -35},
	["a4"] =  {Vector(-10,0,5), -20},
	["a5"] = {Vector(30,0,12), -40, Angle(0,15,0)},
	["a6"] = {Vector(0,0,-5), -40, Angle(0,50,0)},
	["a7"] = {Vector(-5,0,23), -30},
	["a8"] = {Vector(15,0,15), -40, Angle(0,15,0)},
	["a9"] = {Vector(5,0,15), -40, Angle(0,15,0)},
	["b1"] = {Vector(0,0,-5), -40, Angle(0,50,0)},
	["b2"] = {Vector(-22,0,37), -35},
	["b3"] = {Vector(7,0,30), -45, Angle(0,5,0)},
	["b4"] = {Vector(7,0,30), -45, Angle(0,5,0)},
	["b5"] = {Vector(7,0,30), -45, Angle(0,5,0)},
	["b6"] = {Vector(12,0,50), -30, Angle(0,-65,0)},
	["b7"] = {Vector(12,-44,45), -30, Angle(0,-67,0)},
	["b8"] = {Vector(12,-22,50), -30, Angle(0,-65,0)},
	["b9"] = {Vector(8,0,25), -55, Angle(0,50,0)},
	["g1"] = {Vector(12,0,50), -30, Angle(-10,-65,0)},
	["g2"] = {Vector(40,0,12), -40, Angle(0,15,0)},
	["g3"] = {Vector(40,0,3), -40, Angle(5,22,0)},
	["g4"] = {Vector(20,0,-7), -40, Angle(0,6,0)},
	["g5"] = {Vector(20,0,1), -40, Angle(0,6,0)},
	["g6"] = {Vector(12,-44,45), -30, Angle(13,-57,0)},
	["g7"] = {Vector(7,0,30), -45, Angle(0,5,0)},
	["d1"] = {Vector(12,-44,55), -42, Angle(-10,-67,0)},
}

function MSD.OpenTattooMenu()
	if MCR.LocadingMenu then
		MCR.LocadingMenu:Close()
		return
	end

	local SW, SH = ScrW(), ScrH()
	local gp = Vector(0, 0, 0)
	local cc = {
		pos = Vector(1454.17578125,-1892.3649902344,-32.501991271973),
		ang = Angle(-6.7912621498108,-105.1842880249,0)
	}
	local showpoints
	local origin, angles, fov = cc.pos + gp, cc.ang, 75

	local cur_cc = {
		pos = origin,
		ang = angles,
		ang_change = 0.1
	}

	local pages = {}
	local nextchange = 0
	local changeangl = Angle(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3))
	local focus_v = Vector(0, 0, 0)
	local focus_a = Angle(0, 0, 0)
	local focus_al = Angle(0, 0, 0)
	local focus_fov = 0

	local Main = vgui.Create("DFrame")
	Main:SetSize(SW, SH)
	Main:SetTitle("")
	Main:SetVisible(true)
	Main:SetDraggable(false)
	Main:ShowCloseButton(false)
	Main:Center()
	Main:MakePopup()
	Main.Outfit = true
	Main.Allow = true
	MCR.LocadingMenu = Main

	Main.OnClose = function(self)
		if MCR.Sound then
			MCR.Sound:Stop()
			MCR.Sound = nil
		end

		if MCR.dlight then
			MCR.dlight.DieTime = CurTime() + FrameTime()
			MCR.dlight = nil
		end

		MCR.LocadingMenu = nil
		DarkRP.UIEffects["blackScreen"]({false, true})
	end

	Main.Paint = function(self, w, h)
		local money = LocalPlayer():getDarkRPVar("money") or 0
		draw.SimpleTextOutlined("$" .. string.Comma(money), "MSDFontB.32", w - 15, 45, color_white, TEXT_ALIGN_RIGHT, 2, 2, color_black)

		if showpoints then
			draw.SimpleTextOutlined(string.Comma(math.Round(Glac.Credits)) .. " ¤", "MSDFontB.32", w - 15, 77, color_white, TEXT_ALIGN_RIGHT, 2, 2, color_black)
		end

		MSD.DrawTexturedRectOfRot(180, -9, 0, w + 10, 41, MSD.Materials.gradient, color_black)
	end
	CreateDLight()
	Main.Think = function(self, w, h)
		if not LocalPlayer():IsFreeman() or not DarkRP.InRangeVector(GAMEMODE.Config.TattooSalon, LocalPlayer():GetPos(), 30) then
			self:Close()
			return
		end

		if MCR.Sound and MCR.Sound:GetState() == GMOD_CHANNEL_STOPPED and MCR.Loaded then
			MCR.Sound:SetTime(0)
			MCR.Sound:Play()
		end

		if nextchange < CurTime() and not cur_cc.ang_changed then
			changeangl = Angle(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3))
			nextchange = CurTime() + math.random(2)
		end

		if cur_cc.ang_changed and cur_cc.ang_changed < CurTime() then
			cur_cc.ang_change = 0.1
			cur_cc.ang_changed = nil
		end

		focus_al = LerpAngle(FrameTime() * 2, focus_al, focus_a)
		angles = LerpAngle(FrameTime() * cur_cc.ang_change, angles, cur_cc.ang + changeangl)
		origin = LerpVector(FrameTime() * 2, origin, cur_cc.pos + focus_v)
		fov = Lerp(FrameTime() * 2, fov, 75 + focus_fov)

		self.camd = {
			o = origin,
			a = angles + focus_al,
			f = fov,
		}
	end

	local panel = vgui.Create("DPanel", Main)
	panel:SetSize(SW / 4.5, SH - SH / 4)
	panel:SetPos(50, 50)
	panel.text = "Тату Салон"
	panel.inuse = 0

	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, 120, color_black)
		local logo_h = 120
		MSD.DrawTexturedRect(5, 0, logo_h * 1.91, logo_h, gmodla2, color_white)
		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 71, color_black, TEXT_ALIGN_RIGHT)
		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 70, color_white, TEXT_ALIGN_RIGHT)
		MSD.DrawTexturedRect(0, 0, w, 120, glass, color_w50)
	end

	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(panel:GetWide(), panel:GetTall() - 120)
	panel.Menu:SetPos(0, 120)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(true)
	panel.Menu:SetPadding(5)
	panel.Menu:SetSpacing(5)
	panel.Menu.IgnoreVbar = true

	panel.Menu.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd)
		MSDX.Draw(0, 0, 0, w, hd, color_b50)
	end

	panel.Sub = vgui.Create("MSDPanelList", Main)
	panel.Sub:SetSize(panel:GetWide(), 150)
	panel.Sub:SetPos(50, 60 + panel:GetTall())
	panel.Sub:EnableVerticalScrollbar()
	panel.Sub:EnableHorizontal(true)
	panel.Sub:SetPadding(5)
	panel.Sub:SetSpacing(5)
	panel.Sub.IgnoreVbar = true

	panel.Sub.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd)
		MSDX.Draw(0, 0, 0, w, hd, color_b50)
	end

	MSD.CloseButtonIcon(Main, ScrW() - 220, 0, 210, 37, "Закрыть", function()
		Main:Close()
	end)

	local token = vgui.Create("DPanel")
	token.StaticScale = { w = 1, fixed_h = 50, minw = 150, minh = 50}
	token.Paint = function(self, w, h)
		local s = MCR.GetSkillPoints(LocalPlayer())
		for i = 0, math.max(5, s-1) do
			local su = i + 1 > s
			MSD.DrawTexturedRect(i * (w / (s > 6 and s or 6)) + 24, 2, 24, 24, (panel.inuse >= i + 1 and MSD.Icons48.layers) or (su and MSD.Icons48.lock) or MSD.Icons48.dot, (panel.inuse >= i + 1 and MSD.Patern.MainColor["p"]) or (su and MSD.Text.n) or MSD.Text.l)
		end

		draw.SimpleText("Вам доступно " .. s .. " из " .. math.max(6, s) .. " слотов навыков", "MSDFont.22", w / 2, 27, color_white, TEXT_ALIGN_CENTER)
	end
	panel.Sub:AddItem(token)

	MSD.InfoText(panel.Sub, "Слоты разблокируются сами со временем - и только на вашего текущего персонажа. Вы теряете все навыки и открытые слоты, когда умираете.", "MSDFont.22")

	pages["main"] = function()
		focus_v = Vector(0,0,0)
		focus_a = Angle(0,0,0)
		focus_fov = 0
		panel.text = "Тату Салон"

		panel.Menu:Clear()
		panel.inuse = 0
		for k, t in SortedPairsByMemberValue(MCR.Tatoo, 3) do
			local ht = MCR.HasTatoo(LocalPlayer(), k)

			if ht then
				panel.inuse = panel.inuse + t[2]
			end

			local block = t[5] and MCR.HasTatoo(LocalPlayer(), t[5])
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, t[1], "$" .. t[3], (block and MSD.Icons48.lock) or (ht and MSD.Icons48.submit) or MSD.Icons48.dot, function(sf)
				if block then return end
				pages["tattoo"](k,t)
			end)
		end

	end

	pages["tattoo"] = function(id, t)
		focus_v = Vector(0,0,7)
		focus_a = Angle(0,15,0)
		focus_fov = 10

		if MSD.fovus_board[id] then
			focus_v = MSD.fovus_board[id][1]
			focus_fov = MSD.fovus_board[id][2]
			focus_a = MSD.fovus_board[id][3] or Angle(0,0,0)
		end

		panel.Menu:Clear()
		local txt = t[4] .. "\n\nТребуется свободных очков навыка: " .. t[2]

		if t[5] and MCR.Tatoo[t[5]] then
			txt = txt .. "\n\nНе совместим с: " .. MCR.Tatoo[t[5]][1]
		end

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Назад", MSD.Icons48.arrow_left, function()
			pages["main"]()
		end)

		MSD.Header(panel.Menu, t[1])
		MSD.InfoText(panel.Menu, txt, "MSDFont.22")

		if MCR.HasTatoo(LocalPlayer(), id) or MCR.GetSkillPoints(LocalPlayer()) - panel.inuse < t[2] then return end

		MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, "Набить тату", "$" .. t[3], MSD.Icons48.pencil, function(sf)
			net.Start("MCR.Tattoo")
			net.WriteString(id)
			net.SendToServer()
		end)
	end

	pages["main"]()

	MCR.LocadingMenu.Update = function()
		pages["main"]()
	end
end

net.Receive("MCR.Tattoo", function()
	if MCR.LocadingMenu and MCR.LocadingMenu.Update then MCR.LocadingMenu.Update() end
	MSD.PlaySnd("simulated_vehicles/valve_noise.wav", 1)
end)
