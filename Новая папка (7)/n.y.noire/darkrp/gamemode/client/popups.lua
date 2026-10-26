--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/client/popups.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local ProgressBar

net.Receive("DrawProgressBar", function()
	if ProgressBar and ProgressBar:IsValid() then
		ProgressBar:Remove()
	end

	ProgressBar = vgui.Create("MSDProgressBar")
	ProgressBar:SetMin(0)
	ProgressBar:SetMax(net.ReadFloat())
	ProgressBar:SetSize(250, 20)
	ProgressBar:SetPos(ScrW() / 2 - 125, ScrH() / 2 + 50)
	ProgressBar.lastTime = CurTime()

	ProgressBar.Think = function(self)
		self:SetValue(self:GetValue() + CurTime() - self.lastTime)
		self.lastTime = CurTime()

		if self:GetValue() > self:GetMax() and not self.Closing then
			self.Closing = true

			self:AlphaTo(0, 0.3, 0, function()
				if IsValid(self) then
					self:Remove()
				end
			end)
		end
	end

	ProgressBar:SetAlpha(1)
	ProgressBar:AlphaTo(255, 0.2)
end)

net.Receive("RemovePropgressBar", function()
	if ProgressBar and ProgressBar:IsValid() then
		ProgressBar.Think = function() end

		ProgressBar:AlphaTo(0, 0.3, 0, function()
			if IsValid(ProgressBar) then
				ProgressBar:Remove()
			end
		end)
	end
end)

local mats = {
	["player"] = Material("gmodla/hud/waypoint.png", "smooth"),
	["hudarrow"] = Material("msd/arrows.png", "smooth"),
	["home"] = Material("gmodla/hud/home.png", "smooth"),
}

local mapcl = Color(40, 40, 40)
local icon_color = Color(241, 200, 0)
local icon_green = Color(41, 143, 15)

local showquests = {
	["Move to point"] = true,
	["Collect quest ents"] = true,
	["Talk to NPC"] = true,
}

concommand.Add("minimap", function()
	if IsValid(DarkRP.LocalMM) then
		DarkRP.LocalMM:Remove()

		return
	end

	local w, h = 500, 500
	local ply = LocalPlayer()
	local panel = vgui.Create("DFrame")
	panel:SetSize(w, h)
	panel:SetPos(0, 0)
	panel:SetTitle("")
	panel:SetDraggable(false)
	panel:ShowCloseButton(false)
	panel:SetPaintedManually(true)
	DarkRP.LocalMM = panel
	local mmw, mmh = 1024, 1024
	local senter = -(mmw / 2) + w / 2
	local senterh = -(mmw / 2) + h / 2
	local mapmin, mapmax = game.GetWorld():GetModelBounds()
	local sx = (mapmax.x - mapmin.x) / mmw + 1
	local sy = (mapmax.y - mapmin.y) / mmh + 1.256

	panel.Paint = function(self, wd, hd)
		if not hook.Call("HUDShouldDraw", GAMEMODE, "Minimap") then return end
		if not LocalPlayer():Alive() then return end
		MSDX.Draw(0, 0, 0, wd, hd, MSD.ColorAlpha(mapcl, 100))
		local pp = ply:GetPos() - DarkRP.MiniMap.Translate
		local pa = ply:EyeAngles().y
		pa = pa - 90

		if ply:InVehicle() and IsValid(ply:GetVehicle()) then
			pa = ply:GetVehicle():GetAngles().y
		end

		if ply:GetPos().z < -4500 then
			MSD.DrawTexturedRect(0, 0, wd, hd, MSD.Materials.vignette, color_black)
			MSD.DrawTexturedRectRotated(pa, wd / 2, hd / 2, 24, 24, mats.hudarrow, color_white)

			return
		end

		local lx, ly = senter - (pp.x / sx), senterh + (pp.y / sy)
		MSD.DrawTexturedRect(lx, ly, mmw, mmh, DarkRP.MiniMap.Material_sm, MSD.ColorAlpha(color_white, 100))
		MSD.DrawTexturedRect(0, 0, wd, hd, MSD.Materials.vignette, color_black)

		for k, v in pairs(DarkRP.MiniMap.Blips) do
			MSD.DrawTexturedRect(lx + mmw / 2 + (v[1] / sx) - 24, ly + mmw / 2 - (v[2] / sy) - 24, 48, 48, MSD.Materials.icon_bg, color_white)
			MSD.DrawTexturedRect(lx + mmw / 2 + (v[1] / sx) - 12, ly + mmw / 2 - (v[2] / sy) - 12, 24, 24, v[3], color_white)
		end

		if DarkRP.MiniMap.Marker then
			local v = DarkRP.MiniMap.Marker
			MSD.DrawTexturedRect(lx + mmw / 2 + (v[1] / sx) - 24, ly + mmw / 2 - (v[2] / sy) - 24, 48, 48, MSD.Materials.icon_bg, color_white)
			MSD.DrawTexturedRect(lx + mmw / 2 + (v[1] / sx) - 12, ly + mmw / 2 - (v[2] / sy) - 12, 24, 24, mats.player, color_white)
		end

		local q = MQS.HasQuest()
		local obj = MQS.GetNWdata(ply, "quest_objective")

		if q and IsValid(ply) and obj then
			obj = MQS.Quests[q.quest].objects[obj]

			if obj.point and showquests[obj.type] then
				local icon = obj.marker and MSD.PinPoints[obj.marker]
				local bx, by = lx + mmw / 2 + (obj.point.x / sx) - 15, ly + mmw / 2 - (obj.point.y / sy) - 15
				bx = math.Clamp(bx, 0, wd - 30)
				by = math.Clamp(by, 0, hd - 30)
				MSD.DrawTexturedRect(bx + 1, by + 1, 30, 30, icon or MSD.PinPoints[0], color_black)
				MSD.DrawTexturedRect(bx, by, 30, 30, icon or MSD.PinPoints[0], icon_color)
			end
		end

		for k, v in pairs(Territories.list) do
			if not v.buyable then continue end
			local data = McPhone.ter_list[k]
			if not data then continue end
			if data.masterOwner ~= LocalPlayer() and not data.propetytype then continue end
			local point = v.gps_point or v.coords[1]
			local bx, by = lx + mmw / 2 + (point.x / sx) - 15, ly + mmw / 2 - (point.y / sy) - 15
			MSD.DrawTexturedRect(bx + 1, by + 1, 30, 30,data.propetytype and MSD.Icons48[data.propetytype] or mats["home"], color_black)
			MSD.DrawTexturedRect(bx, by, 30, 30, data.propetytype and MSD.Icons48[data.propetytype] or mats["home"], (data.masterOwner == LocalPlayer() and icon_green) or icon_color)
		end

		MSD.DrawTexturedRectRotated(pa, wd / 2, hd / 2, 30, 30, mats.hudarrow, color_white)
	end
end)

local quest_list = {
	["food1"] = {
		salary = 600,
	},
	["taxi1"] = {
		salary = 1800,
	},
	["bus1"] = {
		salary = 1100,
	},
	["delivery1"] = {
		salary = 890,
	},
	["worker1"] = {
		salary = 1100,
	},
	["worker2"] = {
		salary = 1100,
	},
	["elevator1"] = {
		onetime = 100,
	},
	["cleaner1"] = {
		salary = 850,
	},
	["loader1"] = {
		salary = 900,
	},
	["fisherman1"] = {
		onetime = 190,
	},
	["cleaner3"] = {
		salary = 120,
	},
	["newsman1"] = {
		onetime = 80,
	},
	["postman1"] = {
		salary = 820,
	},
	["postman1"] = {
		salary = 820,
	},
	["postman1"] = {
		salary = 820,
	},
	["postman1"] = {
		salary = 820,
	},
	["care_way"] = {
		salary = 0,
	},
}

local quest_list2 = {
	["garbage1"] = {
		onetime = 260,
	},
}

function DarkRP.OpenJobMenu()
	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 2, SH - SH / 5
	local pframe = vgui.Create("MSDSimpleFrame")
	pframe:SetSize(SW, SH)
	pframe:SetDraggable(false)
	pframe:Center()
	pframe:MakePopup()
	pframe:SetAlpha(1)
	pframe:AlphaTo(255, 0.3)

	pframe.Think = function(self)
		if not LocalPlayer():IsFreeman() or input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end

	pframe.Paint = function(self, w, h)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Вакансии", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	MSD.CloseButtonIcon(pframe, SW - 160, 5, 150, 40, "Закрыть", function()
		pframe:Close()
	end)

	local plist = vgui.Create("MSDPanelList", pframe)
	plist:SetSize(SW - 10, SH - 55)
	plist:SetPos(5, 55)
	plist:EnableVerticalScrollbar()
	plist:EnableHorizontal(true)
	plist:SetSpacing(2)
	plist.sliderColor = Color(252, 81, 1, 70)
	plist.IgnoreVbar = true

	if LocalPlayer():Team() ~= TEAM_CITIZEN or MQS.HasQuest(LocalPlayer()) then
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			h = 1.2,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			draw.DrawText(MSD.TextWrap("У вас уже есть активная работа или задание", "MSDFont.36", wd - 55), "MSDFont.36", wd / 2, ht / 2 - 22, color_white, TEXT_ALIGN_CENTER)
		end

		plist:AddItem(pn)

		if LocalPlayer():Team() ~= TEAM_CITIZEN then
			MSD.BigButton(plist, "static", nil, 1, 100, "Уйти с работы", MSD.Icons48.briefcase_remove, function()
				RunConsoleCommand("rp_job", 1)
				pframe:Close()
			end)
		end

		return
	end

	for id, job in pairs(DarkRP.Teams) do
		if id == 1 or not job.char or job.char ~= 1 or job.npc then continue end
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			fixed_h = 200,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, ht, MSD.Theme["l"])
			draw.DrawText(job.name, "MSDFont.32", 5, 0, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(MSD.TextWrap(job.description, "MSDFont.22", wd - 10), "MSDFont.22", 5, 64, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(5, 32, 32, 32, MSD.Icons48.cash, color_white)
			draw.DrawText("$" .. (job.salary_ds and job.salary_ds * 6 or job.salary * 6) .. " / ч. ~ примерный доход", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
		end

		MSD.Button(pn, 5, 130, 250, 48, "Взять контракт", function()
			RunConsoleCommand("rp_job", id)
			pframe:Close()
		end)

		plist:AddItem(pn)
	end

	for id, job in pairs(quest_list) do
		local quest = MQS.Quests[id]
		if not MQS.CanStartTask(id) then continue end
		if not quest then continue end
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			fixed_h = 200,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, ht, MSD.Theme["l"])
			draw.DrawText(quest.name, "MSDFont.32", 5, 0, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(MSD.TextWrap(quest.desc, "MSDFont.22", wd - 10), "MSDFont.22", 5, 64, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(5, 32, 32, 32, MSD.Icons48.cash, color_white)

			if job.salary then
				draw.DrawText("$" .. job.salary .. " / ч. ~ примерный доход", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
			end

			if job.onetime then
				draw.DrawText("$" .. job.onetime .. " за задание", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
			end
		end

		MSD.Button(pn, 5, 130, 250, 48, "Взять контракт", function()
			net.Start("MQS.StartTask")
			net.WriteString(id)
			net.SendToServer()
			pframe:Close()
		end)

		plist:AddItem(pn)
	end
end

function DarkRP.OpenJobMenuRamon()
	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 2, SH - SH / 5
	local pframe = vgui.Create("MSDSimpleFrame")
	pframe:SetSize(SW, SH)
	pframe:SetDraggable(false)
	pframe:Center()
	pframe:MakePopup()
	pframe:SetAlpha(1)
	pframe:AlphaTo(255, 0.3)

	pframe.Think = function(self)
		if not LocalPlayer():IsFreeman() or input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end

	pframe.Paint = function(self, w, h)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Вакансии", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	MSD.CloseButtonIcon(pframe, SW - 160, 5, 150, 40, "Закрыть", function()
		pframe:Close()
	end)

	local plist = vgui.Create("MSDPanelList", pframe)
	plist:SetSize(SW - 10, SH - 55)
	plist:SetPos(5, 55)
	plist:EnableVerticalScrollbar()
	plist:EnableHorizontal(true)
	plist:SetSpacing(2)
	plist.sliderColor = Color(252, 81, 1, 70)
	plist.IgnoreVbar = true

	if LocalPlayer():Team() ~= TEAM_CITIZEN or MQS.HasQuest(LocalPlayer()) then
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			h = 1.2,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			draw.DrawText(MSD.TextWrap("У вас уже есть активная работа или задание", "MSDFont.36", wd - 55), "MSDFont.36", wd / 2, ht / 2 - 22, color_white, TEXT_ALIGN_CENTER)
		end

		plist:AddItem(pn)

		if LocalPlayer():Team() ~= TEAM_CITIZEN then
			MSD.BigButton(plist, "static", nil, 1, 100, "Уйти с работы", MSD.Icons48.briefcase_remove, function()
				RunConsoleCommand("rp_job", 1)
				pframe:Close()
			end)
		end

		return
	end

	for id, job in pairs(DarkRP.Teams) do
		if id == 1 or not job.char or job.char ~= 1 or not job.npc or job.npc ~= "ramon" then continue end
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			fixed_h = 200,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, ht, MSD.Theme["l"])
			draw.DrawText(job.name, "MSDFont.32", 5, 0, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(MSD.TextWrap(job.description, "MSDFont.22", wd - 10), "MSDFont.22", 5, 64, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(5, 32, 32, 32, MSD.Icons48.cash, color_white)
			draw.DrawText("$" .. job.salary * 8 .. " / ч. ~ примерный доход", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
		end

		MSD.Button(pn, 5, 130, 250, 48, "Взять контракт", function()
			RunConsoleCommand("rp_job", id)
			pframe:Close()
		end)

		plist:AddItem(pn)
	end

	for id, job in pairs(quest_list2) do
		local quest = MQS.Quests[id]
		if not MQS.CanStartTask(id) then continue end
		if not quest then continue end
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			fixed_h = 200,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, ht, MSD.Theme["l"])
			draw.DrawText(quest.name, "MSDFont.32", 5, 0, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(MSD.TextWrap(quest.desc, "MSDFont.22", wd - 10), "MSDFont.22", 5, 64, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(5, 32, 32, 32, MSD.Icons48.cash, color_white)

			if job.salary then
				draw.DrawText("$" .. job.salary .. " / ч. ~ примерный доход", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
			end

			if job.onetime then
				draw.DrawText("$" .. job.onetime .. " за задание", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
			end
		end

		MSD.Button(pn, 5, 130, 250, 48, "Взять контракт", function()
			net.Start("MQS.StartTask")
			net.WriteString(id)
			net.SendToServer()
			pframe:Close()
		end)

		plist:AddItem(pn)
	end
end

function DarkRP.OpenJobMenuPolice()
	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 2, SH - SH / 5
	local pframe = vgui.Create("MSDSimpleFrame")
	pframe:SetSize(SW, SH)
	pframe:SetDraggable(false)
	pframe:Center()
	pframe:MakePopup()
	pframe:SetAlpha(1)
	pframe:AlphaTo(255, 0.3)

	pframe.Think = function(self)
		if not LocalPlayer():IsFreeman() or input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end

	pframe.Paint = function(self, w, h)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Смены", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	MSD.CloseButtonIcon(pframe, SW - 160, 5, 150, 40, "Закрыть", function()
		pframe:Close()
	end)

	local plist = vgui.Create("MSDPanelList", pframe)
	plist:SetSize(SW - 10, SH - 55)
	plist:SetPos(5, 55)
	plist:EnableVerticalScrollbar()
	plist:EnableHorizontal(true)
	plist:SetSpacing(2)
	plist.sliderColor = Color(252, 81, 1, 70)
	plist.IgnoreVbar = true

	for id, job in pairs(DarkRP.Teams) do
		if id == 3 or not job.char or job.char ~= 2 or job.npc then continue end
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			fixed_h = 200,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, ht, MSD.Theme["l"])
			draw.DrawText(job.name, "MSDFont.32", 5, 0, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(MSD.TextWrap(job.description, "MSDFont.22", wd - 10), "MSDFont.22", 5, 64, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(5, 32, 32, 32, MSD.Icons48.cash, color_white)
			draw.DrawText("$" .. job.salary * 6 .. " / ч. + бонус от звания", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
		end

		MSD.Button(pn, 5, 130, 250, 48, "Встать на смену", function()
			RunConsoleCommand("rp_job", id)
			pframe:Close()
		end)

		plist:AddItem(pn)
	end
end

function DarkRP.OpenJobMenuEMS()
	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 2, SH - SH / 4
	local pframe = vgui.Create("MSDSimpleFrame")
	pframe:SetSize(SW, SH)
	pframe:SetDraggable(false)
	pframe:Center()
	pframe:MakePopup()
	pframe:SetAlpha(1)
	pframe:AlphaTo(255, 0.3)

	pframe.Think = function(self)
		if not LocalPlayer():IsFreeman() or input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end

	pframe.Paint = function(self, w, h)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Смены", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	MSD.CloseButtonIcon(pframe, SW - 160, 5, 150, 40, "Закрыть", function()
		pframe:Close()
	end)

	local plist = vgui.Create("MSDPanelList", pframe)
	plist:SetSize(SW - 10, SH - 55)
	plist:SetPos(5, 55)
	plist:EnableVerticalScrollbar()
	plist:EnableHorizontal(true)
	plist:SetSpacing(2)
	plist.sliderColor = Color(252, 81, 1, 70)
	plist.IgnoreVbar = true

	for id, job in pairs(DarkRP.Teams) do
		if id == 3 or not job.char or job.char ~= 2 or job.npc ~= "ems" then continue end
		local pn = vgui.Create("DPanel")

		pn.StaticScale = {
			w = 1,
			fixed_h = 200,
			minw = 500,
			minh = 48
		}

		pn.Paint = function(self, wd, ht)
			MSDX.Draw(MSD.Config.Rounded, 0, 0, wd, ht, MSD.Theme["l"])
			draw.DrawText(job.name, "MSDFont.32", 5, 0, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
			draw.DrawText(MSD.TextWrap(job.description, "MSDFont.22", wd - 10), "MSDFont.22", 5, 64, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(5, 32, 32, 32, MSD.Icons48.cash, color_white)
			draw.DrawText("$" .. job.salary * 6 .. " / ч. + бонус от звания", "MSDFont.22", 40, 37, MSD.Text.l, TEXT_ALIGN_LEFT)
		end

		MSD.Button(pn, 5, 130, 250, 48, "Встать на смену", function()
			RunConsoleCommand("rp_job", id)
			pframe:Close()
		end)

		plist:AddItem(pn)
	end
end

local red = Color(228, 17, 17)
local colors = {
	[1] = Color(0, 0, 0, 200),
	[2] = Color(0, 0, 0, 180),
	[3] = Color(0, 0, 0, 225),
}

local files = {
	[1] = Material("vgui/file.png", "smooth"),
	[2] = Material("vgui/booking.png", "smooth"),
}

function DarkRP.OpenBooking(ply)
	if IsValid(DarkRP.Booking) then DarkRP.Booking:Remove() end
	local license = vgui.Create("MSDSimpleFrame")
	license:SetSize(400, 600)
	license:MakePopup()
	license:Center()
	DarkRP.Booking = license

	local group = MRS.GetNWdata(LocalPlayer(), "Group")
	local rank = MRS.GetNWdata(LocalPlayer(), "Rank")
	local ri = ""
	if MRS.Ranks[group] and MRS.Ranks[group].ranks[rank] then ri = MRS.Ranks[group].ranks[rank].name end

	local f_data = {
		name = ply:Name(),
		sname = "",
		gen = ply:getDarkRPVar("gender") == "female" and "ЖЕН." or "МУЖ.",
		date = "",
		passid = "",
		type = "",
		cpassid = DarkRP.PassId(ply),
		aresster = LocalPlayer():FullName(),
		rank = ri,
		reason = "",
	}

	local text = "Причина задержания..."

	license.Paint = function(self, wd, hd)
		Derma_DrawBackgroundBlur(self, self.startTime)
		MSD.DrawTexturedRect(0, 0, wd, hd, files[1], color_white)
		MSD.DrawTexturedRect(0, 0, wd, hd, files[2], color_white)

		draw.DrawText(f_data.name, "Moster.24", 55, 105, colors[3], TEXT_ALIGN_LEFT)
		draw.DrawText(f_data.sname, "Moster.24", 55, 140, colors[3], TEXT_ALIGN_LEFT)
		draw.DrawText(f_data.date, "Moster.24", 55, 175, colors[3], TEXT_ALIGN_LEFT)
		draw.DrawText(f_data.gen, "Moster.24", 290, 175, colors[3], TEXT_ALIGN_LEFT)
		draw.DrawText(f_data.type, "Moster.24", 290, 210, colors[3], TEXT_ALIGN_LEFT)

		draw.DrawText(f_data.rank, "Moster.24", 35, 55, colors[3], TEXT_ALIGN_LEFT)
		draw.DrawText(f_data.aresster, "Moster.24", 35, 80, colors[3], TEXT_ALIGN_LEFT)

		local ts = MSD.TextWrap(text, "Moster.24", wd - 30)
		draw.DrawText(ts, "Moster.24", 26, 240, colors[3], TEXT_ALIGN_LEFT)
	end

	Win98.TextEntryAlt(license, 24, 210, 238, 22, f_data.passid, function(s, val)
		f_data.passid = tostring(val)

		if f_data.cpassid == f_data.passid then
			f_data.type = string.sub(ply:AccountID(), 3, 4)
			local pn = string.Explode(" ", ply:FullName())
			f_data.name = pn[1]
			f_data.sname = pn[2]
			f_data.date = ply:getDarkRPVar("age")
		end
	end, true, nil, false, true)

	local combo = Win98.AltComboBox(license, 24, 232, 360, 35, "Причина задержания...")
	combo.OnSelect = function(_, data, value)
		text = value
		f_data.reason = data
	end

	for k,v in pairs(DarkRP.Police.TicketTypes) do
		combo:AddChoice(v[1], k)
	end

	Win98.AltButton(license, "Подтвердить", 25, 395, 175, 194, icon_green, function()
		if f_data.reason == "" then
			surface.PlaySound("win/dings.wav")
			return
		end
		surface.PlaySound("noire/stamp.mp3")
		license:Remove()
		net.Start("Police.Arrest")
		net.WriteUInt(1, 2)
		net.WriteTable(f_data)
		net.SendToServer()
	end)

	Win98.AltButton(license, "Отменить", 200, 395, 175, 194, red, function()
		surface.PlaySound("physics/cardboard/cardboard_box_strain" .. math.random(3) .. ".wav")
		license:Remove()
	end)
end