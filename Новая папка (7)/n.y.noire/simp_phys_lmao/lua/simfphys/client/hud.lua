--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/simfphys/client/hud.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local smHider = 0

local semi_col = Color(255, 255, 255, 55)

local realBands = {}
for i = 1, 35 do
	realBands[i] = 0
end

local HUD = DarkRP.Hud
HUD.VehBarSize = 0
HUD.VehBars = {}
local FirstTime_enter = false
local Speed_lockdoor = false
local Shift_press = true
local s_xpos, s_ypos = 0, 0
local n_loop = 0
local scw, sch = ScrW(), ScrH()
local shift = GetConVar("noire_car_keywot"):GetInt() or 0

local clrs = {
	m = Color(255, 255, 255, 200),
	s = Color(127, 127, 127, 150),
	d = Color(0, 0, 0, 20),
	r = Color(255, 0, 0),
}

function HUD.VehAddAnimatedBar(tbl)
	table.insert(HUD.VehBars, tbl)
end

function HUD.VehAddTextBar(tbl)
	tbl.type = "text"
	table.insert(HUD.VehBars, tbl)
end

HUD.VehAddTextBar({
	icon = MSD.Icons48.speedometer,
	text = function(veh)
		local spd = math.Round(veh:GetVelocity():Length() * 0.083 / 5280 * 3600, 0)
		return (spd < 10 and "0" or "") .. spd .. " м/ч"
	end
})

local grs = {
	[2] = "N",
	[1] = "R"
}

HUD.VehAddAnimatedBar({
	icon_bg = MSD.Icons48.engine_rpm,
	icon = MSD.Icons48.engine_rpm,
	smooth = 0,
	no_text = true,
	d_text = function(veh)
		local rpm = string.Explode(".", math.Round(veh:GetRPM() / 1000, 1))
		return rpm[1] .. "." .. (rpm[2] or 0) .. " rpm"
	end,
	value = function(veh)
		return veh:GetRPM() / veh:GetLimitRPM()
	end
})

HUD.VehAddTextBar({
	check = function(veh)
		return veh:GetEngineHP() < 30
	end,
	icon = MSD.Icons48.engine_outline
})

HUD.VehAddTextBar({
	check = function(veh)
		return veh:GetBattery() < 30
	end,
	icon = MSD.Icons48.car_battery
})

HUD.VehAddTextBar({
	check = function(veh)
		return veh:GetEngineTemp() > 70
	end,
	icon = MSD.Icons48.thermometer_alert
})

HUD.VehAddTextBar({
	icon = MSD.Icons48.car_shift_pattern,
	text = function(veh)
		return veh:GetGear() > 2 and veh:GetGear() - 2 or (grs[veh:GetGear()] or "N")
	end
})

HUD.VehAddAnimatedBar({
	icon_bg = MSD.Icons48.gas_station_outline,
	icon = MSD.Icons48.gas_station,
	no_icon = MSD.Icons48.gas_station_off_outline,
	no_text = true,
	value = function(veh)
		return veh:GetFuel() / veh:GetMaxFuel()
	end
})

local carligths = {
	[1] = MSD.Icons48.car_light_dimmed,
	[2] = MSD.Icons48.car_light_high,
}

HUD.VehAddTextBar({
	check = function(veh)
		return veh:GetLightsEnabled()
	end,
	icon = function(veh)
		if carligths[veh:GetLampsEnabled()] then
			return carligths[veh:GetLampsEnabled()]
		end

		return MSD.Icons48.car_parking_lights
	end,
})

HUD.VehAddTextBar({
	check = function(veh)
		return veh:GetHandBrakeEnabled()
	end,
	icon = MSD.Icons48.car_brake_parking
})

HUD.VehAddTextBar({
	check = function(veh)
		return input.IsKeyDown(GetConVar("noire_car_keyclutch"):GetInt() or 1)
	end,
	icon = MSD.Icons48.car_clutch
})

HUD.VehAddAnimatedBar({
	check = function(veh)
		return veh:GetIsBraking()
	end,
	icon_bg = MSD.Icons48.car_brake_idle,
	icon = MSD.Icons48.car_brake_idle,
	no_icon = MSD.Icons48.car_brake_idle,
	no_text = true,
	smooth = 0,
	value = function(veh)
		return input.IsKeyDown(shift) and 1 or 0.5
	end
})


local function drawsimfphysHUD(vehicle, SeatCount)

	local x, y = 0, 0

	if GetConVar("noire_hints"):GetInt() > 0 then
		if not FirstTime_enter then
			x, y = scw * 0.5, sch * 0.8
			local sp = draw.SimpleTextOutlined("Завести машину можно кнопкой", "MSDRoboto.20", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
			MSD.DrawKey(x + sp / 2 + 10, y - 3, input.GetKeyName(GetConVar("noire_car_keyengine"):GetInt()))

			if input.IsKeyDown(GetConVar("noire_car_keyengine"):GetInt()) and not FirstTime_enter then
				FirstTime_enter = true
				Shift_press = false
			end
		end

		if not Shift_press and vehicle:GetVelocity():Length() > 50 then
			x, y = scw * 0.5, sch * 0.8
			local sp = draw.SimpleTextOutlined("Для увеличения тяги зажмите кнопку", "MSDRoboto.20", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
			MSD.DrawKey(x + sp / 2 + 10, y - 3, input.GetKeyName(GetConVar("noire_car_keywot"):GetInt()))

			if input.IsKeyDown(GetConVar("noire_car_keywot"):GetInt()) and not Shift_press then
				Shift_press = true
			end
		end

		if not Speed_lockdoor and vehicle:GetVelocity():Length() > 200 then
			x, y = scw * 0.5, sch * 0.85
			local sp = draw.SimpleTextOutlined("Для большей безопасности вы можете закрыть двери кнопкой", "MSDRoboto.20", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
			MSD.DrawKey(x + sp / 2 + 10, y - 3, input.GetKeyName(KEY_1))

			if input.IsKeyDown(KEY_1) and not Speed_lockdoor then
				Speed_lockdoor = true
			end
		end
	end

	x, y = scw - 10, sch - (20 + HUD.IconSize)

	local rb = math.max(MSD.Config.Rounded, 5)
	local b = rb + 10
	local iy = y + 5

	HUD.DrawBG(x - HUD.VehBarSize, y, HUD.VehBarSize, HUD.IconSize + 10)
	MSDX.Draw(math.min(MSD.Config.Rounded, rb / 2), x - rb , y, rb, HUD.IconSize + 10, MSD.Config.TeamColor and team.GetColor(LocalPlayer():Team()) or MSD.Config.MainColor["p"], MSDX.NO_TL + MSDX.NO_BL)

	for id, e in pairs(HUD.VehBars) do
		if e.check and not e.check(vehicle) then continue end

		if e.type == "text" then
			if e.text then
				b = b + 5 + draw.SimpleText( e.text(vehicle), "MSDFont." .. HUD.FondSize, x - b - 5, y + 5 + HUD.IconSize / 2, MSD.Text["l"], 2, 1)
			end

			if e.icon then
				MSD.DrawTexturedRect(x - b - HUD.IconSize - 5, iy, HUD.IconSize, HUD.IconSize, isfunction(e.icon) and e.icon(vehicle) or e.icon, color_white)
				b = b + HUD.IconSize + 5
			else
				b = b + 5
			end
			continue
		end

		local value = e.value(vehicle)
		if e.smooth then
			e.smooth = math.Approach(e.smooth, value, FrameTime() * 2)
			value = e.smooth
		end

		if ( e.no_icon or value > 0 ) then
			if not e.no_text then
				b = b + 5 + math.max( draw.SimpleText( math.max(math.Round(value * 100), 0) .. ( not e.no_per and "%" or ""), "MSDFont." .. HUD.FondSize, x - b - 5, y + 5 + HUD.IconSize / 2, MSD.Text["l"], 0, 1), 35)
			end

			if e.d_text then
				b = b + 5 + math.max( draw.SimpleText( e.d_text(vehicle), "MSDFont." .. HUD.FondSize, x - b - 5, y + 5 + HUD.IconSize / 2, MSD.Text["l"], 2, 1), 35)
			end

			b = b + HUD.IconSize + 5
		end

		if value <= 1 and value > 0 then
			MSD.DrawTexturedRect(x - b, iy, HUD.IconSize, HUD.IconSize, e.icon_bg, MSD.Text["n"])

			local ip = math.Clamp(HUD.IconSize - HUD.IconSize * value, 0, HUD.IconSize)

			render.SetScissorRect(x - b, iy + ip, x - b + HUD.IconSize, iy + HUD.IconSize, true )
				MSD.DrawTexturedRect(x - b, iy, HUD.IconSize, HUD.IconSize, e.icon, color_white)
			render.SetScissorRect(0, 0, 0, 0, false )
		elseif value > 1 then
			MSD.DrawTexturedRect(x - b, iy, HUD.IconSize, HUD.IconSize, e.max_icon or e.icon, color_white)
		elseif e.no_icon and value <= 0 then
			MSD.DrawTexturedRect(x - b, iy, HUD.IconSize, HUD.IconSize, e.no_icon, MSD.Text["a"])
		end
	end

	HUD.VehBarSize = b + 10

	HUD.VehBarSize = b + 10

	s_xpos, s_ypos = x - HUD.VehBarSize + 205, y

	if not vehicle:GetNWBool("MccD.Radio") then return end
	HUD.DrawBG(s_xpos - 410, s_ypos, 200, HUD.IconSize + 10)

	if IsValid(vehicle.WCR_Player) then
		if not IsValid(RadioUI) and RadKeyHOLD then
			MSDX.Draw(0, s_xpos - 410, s_ypos - 30, 200, 25, MSD.Theme["d"])
			MSDX.Draw(0, s_xpos - 407, s_ypos - 26, math.max(190 * ((RadKeyHOLD - CurTime()) / 1), 0), 15, DarkRP.Hud.Patern["main_l"])
		end

		local bands = {}
		local bandMaxHeight = HUD.IconSize + 10
		local amp = 5000
		local offset = 0
		vehicle.WCR_Player:FFT(bands, FFT_8192)

		for i = 1, 15 do
			if not bands[i + offset] then break end
			if bands[i + offset] * amp > bandMaxHeight then
				bands[i + offset] = bandMaxHeight / amp
			end

			if bands[i + offset] * amp < 2 then
				bands[i + offset] = 2
			else
				bands[i + offset] = bands[i + offset] * amp
			end

			realBands[i] = Lerp(30 * FrameTime(), realBands[i], bands[i + offset])

			if i < 14 and i > 2 then
				local a = realBands[i]
				local f = realBands[i + 1]
				local c = realBands[i - 1]
				realBands[i] = (a + f + c) / 3
			elseif i < 3 then
				local a = realBands[i]
				local f = realBands[i + 1]
				local c = 0
				realBands[i] = (a + f + c) / 3
			end
		end

		local xPos = s_xpos - 405

		for i = 1, 15 do
			MSDX.Draw(0, xPos, math.ceil(s_ypos + bandMaxHeight) - realBands[i], 8, realBands[i], MSD.Config.MainColor["p"])
			MSDX.Draw(0, xPos, math.ceil(s_ypos + bandMaxHeight) - realBands[i], 8, realBands[i], MSD.ColorAlpha(MSD.ColorPresets[1], realBands[i] * 5))
			xPos = xPos + 13
		end
	else
		if not IsValid(RadioUI) then
			if RadKeyHOLD then
				local kh = math.max((RadKeyHOLD - CurTime()) / 1, 0)
				MSDX.Draw(0, s_xpos - 410, s_ypos - HUD.IconSize * kh + HUD.IconSize + 10, 200, HUD.IconSize * kh, MSD.Theme["d"])
				MSDX.Draw(0, s_xpos - 410, s_ypos - HUD.IconSize * kh + HUD.IconSize + 10, 200, HUD.IconSize * kh, MSD.ColorAlpha(DarkRP.Hud.Patern["main_l"], kh * 255))
			end

			draw.SimpleText("Открыть радио [ " .. input.GetKeyName(GetConVar("noire_car_keyradio"):GetInt()) .. " ]", "MSDFont.22", s_xpos - 310, s_ypos + 18, MSD.Text["d"], TEXT_ALIGN_CENTER, 1)
		end
	end

	if n_loop < CurTime() and not IsValid(RadioUI) then
		if input.IsKeyDown(GetConVar("noire_car_keyradio"):GetInt()) then
			if not RadKeyHOLD then
				RadKeyHOLD = CurTime() + 1
			elseif RadKeyHOLD < CurTime() then
				RadKeyHOLD = nil
				n_loop = vehicle.WCR_Player and CurTime() + 0.5 or CurTime() + 2
				RadioUIOpen(vehicle)
			end
		else
			RadKeyHOLD = nil
		end
	end
end

local function RadioBut(parent, xd, yd, wd, hd, text, func, val, hovered, check)
	local a = 0
	if check and check() then return end

	if not val then
		val = 0
	end

	local buton = vgui.Create("DButton", parent)
	buton:SetSize(wd, hd)
	buton:SetPos(xd, yd)
	buton:SetText("")
	buton.text = math.Round(val * 100)

	buton.DoClick = function(self)
		local w = self:GetWide(), self:GetTall()
		local mx, my = gui.MousePos()
		local x = self:ScreenToLocal(mx, my)

		if x < w / 2 then
			val = 0
		elseif x > w - 10 then
			val = 1
		else
			x = x - w / 2
			x = x / (w / 2 - 10)
			val = x
		end

		buton.text = math.Round(val * 100)
		func(self, val)
	end

	if istable(text) then
		buton.text = text[2]
		text = text[1]
	end

	buton.Paint = function(self, w, h)
		MSDX.Draw(0, w / 2, 0, val * (w / 2 - 10), h, McCD.Patern["main"])

		if self.hover or (hovered and hovered()) then
			a = 1
			local mx, my = gui.MousePos()
			local x = self:ScreenToLocal(mx, my)
			local val2

			if x < w / 2 then
				val2 = 0
			elseif x > w - 10 then
				val2 = 1
			else
				x = x - w / 2
				val2 = x
			end

			MSDX.Draw(0, w / 2, 0, val2, h, Color(255, 255, 255, 55))
		else
			a = 0
		end

		MSDX.Draw(0, 0, 0, w, h, Color(0, 0, 0, 100))
		MSDX.Draw(0, 0, 0, w / 2, h, Color(255, 255, 255, a * 155))
		MSDX.Draw(0, w - 10, 0, 10, h, Color(255, 255, 255, a * 155))
		draw.SimpleText(text, "MSDFont.20", 15, 3, Color(0, 0, 0, a * 255), TEXT_ALIGN_LEFT, 2)
		draw.SimpleText(text, "MSDFont.20", 15, 3, Color(255, 255, 255, 255 - a * 255), TEXT_ALIGN_LEFT, 2)
		draw.SimpleText(self.text, "MSDFont.20", w - 15, 3, Color(255, 255, 255, 255), TEXT_ALIGN_RIGHT, 2)
	end

	buton.OnCursorEntered = function(self)
		self.hover = true
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end
end

RadioUIOpen = function(veh, station)
	if IsValid(RadioUI) then
		RadioUI:Remove()
		RadioUI = nil
	end

	local posw = ScrW() / 2 - 300
	local cur_station
	local stereochan
	RadioUI = vgui.Create("DPanel")
	RadioUI:SetSize(600, 200)
	RadioUI:SetPos(posw,  ScrH())
	RadioUI.Paint = function(self, w, h)
		if not IsValid(veh) or (not station and LocalPlayer():GetSimfphys() ~= veh) then
			self:Remove()
			return
		end

		if station and not DarkRP.InRange(veh, LocalPlayer(), 100) then
			self:Remove()
			return
		end

		MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
		MSDX.Draw(0, 0, 25, w, 50, MSD.Theme["d"])
		MSDX.Draw(0, 0, 0, w, 20, MSD.Theme["d"])

		if IsValid(veh.WCR_Player) then
			local bands = {}
			local bandMaxHeight = HUD.IconSize + 10
			local amp = 5000
			local offset = 0
			veh.WCR_Player:FFT(bands, FFT_8192)

			for i = 1, 35 do
				if not bands[i + offset] then break end
				if bands[i + offset] * amp > bandMaxHeight then
					bands[i + offset] = bandMaxHeight / amp
				end
				if bands[i + offset] * amp < 2 then
					bands[i + offset] = 2
				else
					bands[i + offset] = bands[i + offset] * amp
				end
				realBands[i] = Lerp(30 * FrameTime(), realBands[i], bands[i + offset])
				if i < 34 and i > 2 then
					local a = realBands[i]
					local f = realBands[i + 1]
					local c = realBands[i - 1]
					realBands[i] = (a + f + c) / 3
				elseif i < 3 then
					local a = realBands[i]
					local f = realBands[i + 1]
					local c = 0
					realBands[i] = (a + f + c) / 3
				end
			end
			local xPos = 10
			for i = 1, 33 do
				MSDX.Draw(0, xPos, math.ceil(30 + bandMaxHeight) - realBands[i], 8, realBands[i], MSD.Config.MainColor["p"])
				MSDX.Draw(0, xPos, math.ceil(30 + bandMaxHeight) - realBands[i], 8, realBands[i], MSD.ColorAlpha(MSD.ColorPresets[1], realBands[i] * 5))
				xPos = xPos + 13
			end
			if IsValid(RadioUI.play) and RadioUI.play.mat ~= MSD.Icons48.stop_circle_outline then
				RadioUI.play.mat = MSD.Icons48.stop_circle_outline
			end
		else
			if IsValid(RadioUI.play) and RadioUI.play.mat ~= MSD.Icons48.play_circle_outline then
				RadioUI.play.mat = MSD.Icons48.play_circle_outline
			end
		end
		cur_station = veh:WCR_GetChannel()

		stereochan = wyozicr.AllStations[cur_station]

		if stereochan and stereochan.Icon then
			MSD.DrawTexturedRect(5, 107, 595, 90, MSD.ImgLib.GetMaterial(stereochan.Icon), color_white)
		end
	end

	RadioUI:MoveTo(posw, ScrH() - 210, 0.3, 0, 1)

	RadioUI.clsBut = MSD.IconButton(RadioUI, MSD.Icons48.cross, RadioUI:GetWide() - 25, 0, 20, MSD.Patern.MainColor["p"], MSD.Patern.MainColor["8"], function()
		if RadioUI.OnPress then
			RadioUI.OnPress()

			return
		end

		RadioUI:MoveTo(posw, ScrH(), 0.4, 0, 1, function()
			RadioUI:Remove()
			RadioUI = nil
		end)
	end)

	MSD.IconButton(RadioUI, MSD.Icons48.arrow_right, RadioUI:GetWide() - 50, 25, 48, MSD.Patern.MainColor["9"], MSD.Patern.MainColor["2"], function()
		net.Start("wyozicr_cradio")
		if station then net.WriteEntity(veh) end
		net.WriteInt(1, 8)
		net.WriteBool(false)
		net.SendToServer()
	end)

	MSD.IconButton(RadioUI, MSD.Icons48.arrow_left, RadioUI:GetWide() - 100, 25, 48, MSD.Patern.MainColor["9"], MSD.Patern.MainColor["2"], function()
		net.Start("wyozicr_cradio")
		if station then net.WriteEntity(veh) end
		net.WriteInt(-1, 8)
		net.WriteBool(false)
		net.SendToServer()
	end)

	RadioUI.play = MSD.IconButton(RadioUI, MSD.Icons48.play_circle_outline, RadioUI:GetWide() - 150, 25, 48, MSD.Patern.MainColor["9"], MSD.Patern.MainColor["2"], function()
		net.Start("wyozicr_cradio")
		if station then net.WriteEntity(veh) end
		net.WriteInt(0, 8)
		net.WriteBool(false)
		net.SendToServer()
	end)

	RadioBut(RadioUI, 5, 80, 590, 25, "Звук", function(self, val)
		net.Start("wyozicr_cradio")
		if station then net.WriteEntity(veh) end
		net.WriteInt(val * 100, 8)
		net.WriteBool(true)
		net.SendToServer()
	end, veh:GetNW2Float("radio_vol", 0.3))
end

local LockText = Material("lfs_locked.png", "smooth")

local function PaintSeatSwitcher(ent, pSeats, SeatCount)
	local X = ScrW()
	local Y = ScrH()
	local me = LocalPlayer()
	if SeatCount <= 0 then return end
	pSeats[0] = ent:GetDriverSeat()
	draw.NoTexture()
	local MySeat = me:GetVehicle():GetNW2Int("pPodIndex", -1)
	local Passengers = {}

	for _, ply in pairs(player.GetAll()) do
		if ply:GetSimfphys() == ent then
			local Pod = ply:GetVehicle()
			Passengers[Pod:GetNW2Int("pPodIndex", -1)] = ply:Name()
		end
	end

	me.SwitcherTime = me.SwitcherTime or 0
	me.oldPassengersmf = me.oldPassengersmf or {}
	local Time = CurTime()

	for k, v in pairs(Passengers) do
		if me.oldPassengersmf[k] ~= v then
			me.oldPassengersmf[k] = v
			me.SwitcherTime = Time + 2
		end
	end

	for k, v in pairs(me.oldPassengersmf) do
		if not Passengers[k] then
			me.oldPassengersmf[k] = nil
			me.SwitcherTime = Time + 2
		end
	end

	for _, v in pairs(simfphys.pSwitchKeysInv) do
		if input.IsKeyDown(v) then
			me.SwitcherTime = Time + 2
		end
	end

	local Hide = me.SwitcherTime > Time
	smHider = smHider + ((Hide and 1 or 0) - smHider) * RealFrameTime() * 15
	local Alpha1 = 200 + 55 * smHider
	local HiderOffset = 300 * smHider
	local Offset = -35
	local yPos = Y - (SeatCount + 1) * 24 - 25

	if MySeat == 1 then
		yPos = yPos - 50
	end

	for _, Pod in pairs(pSeats) do
		local I = Pod:GetNW2Int("pPodIndex", -1)

		if I >= 0 then
			local textcolor = Color(255, 255, 255, Alpha1)

			if I == MySeat then
				textcolor = MSD.ColorAlpha(MSD.Patern.MainColor["p"], Alpha1)
			end

			MSDX.Draw(0, X + Offset - HiderOffset, yPos + I * 26, 24 + HiderOffset, 24, MSD.Theme["d"])

			if I == SeatCount then
				MSDX.Draw(0, X + Offset - HiderOffset - 25, yPos + I * 26, 24, 24, MSD.Theme["d"])

				if ent:GetIsVehicleLocked() then
					surface.SetDrawColor(255, 255, 255, 255)
				else
					surface.SetDrawColor(100, 100, 100, 255)
				end

				surface.SetMaterial(LockText)
				surface.DrawTexturedRect(X + Offset - HiderOffset - 22, yPos + I * 26 + 3, 18, 18)
			end

			if Hide then
				if Passengers[I] then
					draw.DrawText(Passengers[I], "MSDFont.20", X + 40 + Offset - HiderOffset, yPos + I * 26 + 2.5, textcolor, TEXT_ALIGN_LEFT)
				else
					draw.DrawText("пусто", "MSDFont.20", X + 40 + Offset - HiderOffset, yPos + I * 26 + 2.5, semi_col, TEXT_ALIGN_LEFT)
				end

				draw.DrawText(I, "MSDFont.20", X + 12 + Offset - HiderOffset, yPos + I * 26 + 2.5, textcolor, TEXT_ALIGN_CENTER)
			else
				if Passengers[I] then
					draw.DrawText(I, "MSDFont.20", X + 12 + Offset - HiderOffset, yPos + I * 26 + 2.5, textcolor, TEXT_ALIGN_CENTER)
				else
					draw.DrawText(I, "MSDFont.20", X + 12 + Offset - HiderOffset, yPos + I * 26 + 2.5, semi_col, TEXT_ALIGN_CENTER)
				end
			end
		end
	end
end
local ply, vehicle, vehiclebase

function VehicleHUD()
	if not IsValid(LocalPlayer()) or GetConVar("cl_drawhud"):GetInt() == 0 or LocalPlayer():Team() == 0 then return end
	ply = LocalPlayer()
	vehicle = ply:GetVehicle()
	vehiclebase = ply:GetSimfphys()

	if not IsValid(vehicle) or not IsValid(vehiclebase) then
		if smHider ~= 0 then
			ply.oldPassengersmf = {}
			smHider = 0
		end
		return
	end

	for _, ent in ipairs(ents.FindByClass("mcarspawn")) do
		local pos = ent:GetPos()
		if pos:DistToSqr(ply:GetPos()) > 300000 then continue end
		local alpha = math.Clamp(1 - (ply:GetPos():DistToSqr(pos) / 150000), 0, 1)
		pos.z = pos.z + 40
		local screenpos = pos:ToScreen()
		local x, y = screenpos.x, screenpos.y - 50
		local shadow = MSD.ColorAlpha(color_black, alpha * 255)
		local white = MSD.ColorAlpha(color_white, alpha * 255)

		MSD.DrawTexturedOutlined(x - 16, y - 32, 32, 32, MSD.PinPoints[66], white, 1, shadow)
		draw.SimpleTextOutlined("Стоянка для хранения машин", "MSDFont.22", x, y, white, TEXT_ALIGN_CENTER, 0, 1, shadow)
	end

	local pSeats = vehiclebase:GetPassengerSeats()
	local SeatCount = table.Count(pSeats)
	PaintSeatSwitcher(vehiclebase, pSeats, SeatCount)

	if LocalPlayer() ~= vehiclebase:GetDriver() then return end
	drawsimfphysHUD(vehiclebase, SeatCount)
end

local RadialMenu

hook.Add("PlayerButtonDown", "DarkRP.TurnMenu", function( pl, button )
	local vb = pl:GetSimfphys()

	if not IsValid(vb) or LocalPlayer() ~= vb:GetDriver() or not LocalPlayer():IsFreeman() then return end
	local turnmenu = GetConVar("noire_car_key_turnmenu"):GetInt()
	local ems = GetConVar("noire_car_keyems"):GetInt()
	if button == turnmenu then
		if IsValid(RadialMenu) then return end

		RadialMenu = vgui.Create("MSD.RadialMenu")
		local panel = RadialMenu
		panel:SetSize(600, 600)
		gui.EnableScreenClicker(true)
		panel:Center()
		panel.KeyThink = function()
			if not input.IsKeyDown(turnmenu) or not IsValid(pl:GetSimfphys()) then
				panel.Close()
			end
		end
		panel.Close = function()
			if IsValid(vb) then
				vb:EmitSound("simulated_vehicles/sfx/turnsignal_end.ogg")
				local selection = panel:GetCurrentSelection()
				local action = panel.m_tblButtons[selection]

				if action then
					action.Cmd()
				end
			end
			gui.EnableScreenClicker(false)
			RadialMenu:Remove()
			RadialMenu = nil
		end

		panel.Page = {}
		panel.OpenPage = function(id)
			page = panel.Page[id]
			if not page then return end
			panel.actions = page
			panel:Build()
		end

		local function turnmodePress(tm)
			net.Start("simfphys_turnsignal")
			net.WriteEntity(vb)
			net.WriteUInt(tm, 3)
			net.SendToServer()
		end

		panel.Page["main"] = {
			{"Право", function() turnmodePress(3) end, MSD.Icons48.arrow_right},
			{"Отключить", function() turnmodePress(0) end, MSD.Icons48.close_thick},
			{"Лево", function() turnmodePress(2) end, MSD.Icons48.arrow_left},
			{"Аварийный", function() turnmodePress(1) end, MSD.Icons48.hazard},
		}

		panel.OpenPage("main")
	elseif button == ems then
		if IsValid(RadialMenu) then return end

		local lt = list.Get("simfphys_lights")[vb.VHL.LightsTable] or false

		if not lt then return end

		RadialMenu = vgui.Create("MSD.RadialMenu")
		local panel = RadialMenu
		panel:SetSize(600, 600)
		gui.EnableScreenClicker(true)
		panel:Center()
		panel.KeyThink = function()
			if not input.IsKeyDown(ems) or not IsValid(pl:GetSimfphys()) then
				panel.Close()
			end
		end
		panel.Close = function()
			gui.EnableScreenClicker(false)
			RadialMenu:Remove()
			RadialMenu = nil
		end

		panel.Page = {}
		panel.OpenPage = function(id)
			page = panel.Page[id]
			if not page then return end
			-- if IsValid(vb) then
			--  	vb:EmitSound("vcmod/clk_els.wav")
			-- end
			panel.actions = page
			panel:Build()
		end

		local function turnmodePress(tm, cm)
			net.Start("simfphys_ems")
			net.WriteEntity(vb)
			net.WriteUInt(tm, 2)
			if cm then
				net.WriteUInt(cm, 3)
			end
			net.SendToServer()
		end

		panel.Page["main"] = {
			{"Свет", function() if lt.ems_codes then panel.OpenPage("lights") else turnmodePress(1, 1) end end, MSD.PinPoints[8]},
			{"Отключить", function() turnmodePress(0) end, MSD.Icons48.close_thick},
		}

		panel.Page["lights"] = {
			{"Отключить", function() turnmodePress(1,0) end, MSD.Icons48.close_thick},
		}

		panel.Page["horn"] = {
			{"Отключить", function() turnmodePress(2,0) end, MSD.Icons48.close_thick},
		}

		if lt.ems_codes then
			for i = 1,lt.ems_codes do
				table.insert(panel.Page["lights"], {"Код " .. i, function() turnmodePress(1,i) end, MSD.PinPoints[8]})
			end
		end

		if lt.ems_sounds and #lt.ems_sounds > 1 then
			panel.Page["main"][3] = {"Сигнал", function() if #lt.ems_sounds > 1 then panel.OpenPage("horn") else turnmodePress(2, 1) end end, MSD.Icons48.bullhorn}

			for i = 1,#lt.ems_sounds do
				table.insert(panel.Page["horn"], {"Сигнал " .. i, function() turnmodePress(2,i) end, MSD.PinPoints[8]})
			end
		end

		panel.OpenPage("main")
	end
end)