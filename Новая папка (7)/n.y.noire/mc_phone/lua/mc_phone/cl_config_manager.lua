--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/cl_config_manager.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- DO NOT EDIT ANYTHING HERE, UNLESS YOU KNOW WHAT YOU ARE DOING
local ply = LocalPlayer()
local LocalCFG
local numberpreset = {
	name = "Emergency service",
	teams = {},
}

local function MCDrawBackgroundBlur(panel)
	panel.Atime = Lerp(FrameTime() * 5, panel.Atime, 1)
	local x, y = panel:LocalToScreen(0, 0)
	DisableClipping(true)
	surface.SetDrawColor(McPhone.UserCfg.Theme["buttons"].r, McPhone.UserCfg.Theme["buttons"].g, McPhone.UserCfg.Theme["buttons"].b, 25 * panel.Atime)
	surface.DrawRect(x * -1, y * -1, ScrW(), ScrH())

	MSD.DrawBlur(x * -1, y * -1, ScrW(), ScrH(), panel.Atime * 5)

	surface.SetDrawColor(0, 0, 0, 200 * panel.Atime)
	surface.DrawRect(x * -1, y * -1, ScrW(), ScrH())
	DisableClipping(false)
end

local function McUpperButton(parent, text, func, hovered)
	local buton = vgui.Create("DButton")
	buton:SetSize(300, 50)
	buton:SetText("")

	if hovered then
		buton.hovered = hovered
	end

	buton.DoClick = function(self)
		func(self)
	end

	buton.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 3, w, h - 3, Color(0, 0, 0, 200))

		if self.hover or self.hovered then
			MSDX.Draw(0, 0, 0, w, 3, McPhone.UserCfg.Theme["buttons"])
			MSDX.Draw(0, 0, 3, w, h - 3, Color(255, 255, 255, 200))
			draw.SimpleText(string.upper(text), "McPhone.Main28", w / 2, 12, color_black, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(string.upper(text), "McPhone.Main28", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
		end
	end

	buton.OnCursorEntered = function(self)
		self.hover = true
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(buton)

	return buton
end

local function McTButton(parent, text, func)
	local button = vgui.Create("DButton")
	button:SetSize(300, 50)
	button:SetText("")

	button.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 3, w, h - 3, Color(0, 0, 0, 200))

		if self.hover then
			MSDX.Draw(0, 0, 3, w, h - 3, Color(255, 255, 255, 200))
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_black, TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
		end
	end

	button.DoClick = function(self)
		func(self)
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(button)
end

local function McTextPanel(parent, text, etc)
	local panel = vgui.Create("DPanel")
	panel:SetSize(300, 50)

	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 3, w, h - 3, Color(0, 0, 0, 200))
		MSDX.Draw(0, 0, 3, w, h - 3, McPhone.Alpha(McPhone.UserCfg.Theme["buttons"], 100))

		if etc then
			draw.SimpleText(text, "McPhone.Main28", 10, 5, color_white, TEXT_ALIGN_LEFT)
			draw.SimpleText(etc, "McPhone.Main22", 12, 30, Color(255, 0, 0, 255), TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
		end
	end

	parent:AddItem(panel)
end

local function McBinder(parent, text, var, func)
	local binder = vgui.Create("DBinder")
	binder:SetSize(200, 50)
	binder:SetValue(var)

	binder.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(0, 0, 0, 200))
		MSDX.Draw(0, w - w / 4, 0, w / 4, h, Color(0, 0, 0, 200))

		if self.hover or self.Trapping then
			MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(255, 255, 255, 200))
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_black, TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
		end

		if self.Trapping then
			MSDX.Draw(0, w - w / 4, 0, w / 4, h, Color(255, 255, 255, 200))
			draw.SimpleText(binder:GetText(), "McPhone.Main28", w - w / 8, 12, McPhone.UserCfg.Theme["buttons"], TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(binder:GetText(), "McPhone.Main28", w - w / 8, 12, color_white, TEXT_ALIGN_CENTER)
		end

		return true
	end

	binder.OnCursorEntered = function(self)
		self.hover = true
	end

	binder.OnCursorExited = function(self)
		self.hover = false
	end

	function binder:OnChange(num)
		if num > 106 and num < 114 then
			binder:SetValue(var)
		else
			func(num)
		end
	end

	parent:AddItem(binder)
end

local function McBinderM(parent, text, var, func)
	local binder = vgui.Create("DBinder")
	binder:SetSize(200, 50)
	binder:SetValue(var)

	binder.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(0, 0, 0, 200))
		MSDX.Draw(0, w - w / 4, 0, w / 4, h, Color(0, 0, 0, 200))

		if self.hover or self.Trapping then
			MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(255, 255, 255, 200))
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_black, TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
		end

		if self.Trapping then
			MSDX.Draw(0, w - w / 4, 0, w / 4, h, Color(255, 255, 255, 200))
			draw.SimpleText(binder:GetText(), "McPhone.Main28", w - w / 8, 12, McPhone.UserCfg.Theme["buttons"], TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(binder:GetText(), "McPhone.Main28", w - w / 8, 12, color_white, TEXT_ALIGN_CENTER)
		end

		return true
	end

	binder.OnCursorEntered = function(self)
		self.hover = true
	end

	binder.OnCursorExited = function(self)
		self.hover = false
	end

	function binder:OnChange(num)
		if num >= 109 and num <= 111 then
			func(num)
		else
			binder:SetValue(var)
		end
	end

	parent:AddItem(binder)
end

local function McButton(parent, text, var, func)
	local status
	local button = vgui.Create("DButton")
	button:SetSize(200, 50)
	button:SetText("")

	button.Paint = function(self, w, h)
		if var then
			status = McPhone.GetPhrase("on")
		else
			status = McPhone.GetPhrase("off")
		end

		MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(0, 0, 0, 200))
		MSDX.Draw(0, w - w / 4, 0, w / 4, h, Color(0, 0, 0, 200))

		if self.hover then
			MSDX.Draw(0, w - w / 4, 0, w / 4, h, Color(255, 255, 255, 200))
			MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(255, 255, 255, 200))
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_black, TEXT_ALIGN_LEFT)
			draw.SimpleText(status, "McPhone.Main28", w - w / 8, 12, McPhone.UserCfg.Theme["buttons"], TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(status, "McPhone.Main28", w - w / 8, 12, color_white, TEXT_ALIGN_CENTER)
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
		end

		return true
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	function button:DoClick()
		var = not var
		func(var)
	end

	parent:AddItem(button)
end

local function McButtonVolume(parent, text, var, func)

	local button = vgui.Create("DButton")
	button:SetSize(200, 50)
	button:SetText("")
	button.var = var

	button.Paint = function(self, w, h)
		button.var = Lerp(FrameTime() * 7, button.var, var)
		MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(0, 0, 0, 200))
		MSDX.Draw(0, w - w / 4, 0, w / 4, h, Color(0, 0, 0, 200))

		if self.hover then
			MSDX.Draw(0, w - w / 4, 0, 10, h, Color(255, 255, 255, 200))
			MSDX.Draw(0, w - 10, 0, 10, h, Color(255, 255, 255, 200))
			MSDX.Draw(0, 0, 0, w - w / 4 - 5, h, Color(255, 255, 255, 200))
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_black, TEXT_ALIGN_LEFT)
		else
			MSDX.Draw(0, w - w / 4, 0, 10, h, Color(255, 255, 255, 155))
			MSDX.Draw(0, w - 10, 0, 10, h, Color(255, 255, 255, 155))
			draw.SimpleText(text, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
		end

		MSDX.Draw(0, w - w / 4 + 10, 0, (w / 4 - 19) * button.var, h, McPhone.UserCfg.Theme["buttons"])
		draw.SimpleTextOutlined(var * 100 .. "%", "McPhone.Main28", w - w / 8, 12, color_white, TEXT_ALIGN_CENTER, 2, 1, color_black)

		return true
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	function button:DoClick()
		local w = self:GetWide()
		local mx, my = gui.MousePos()
		local x = self:ScreenToLocal(mx, my)

		if x < w - w / 4 + 10 then
			var = 0
		elseif x > w - 10 then
			var = 1
		else
			x = x - ((w - w / 4) + 10)
			x = x / ((w / 4) - 20)
			var = x
		end

		var = math.Round(var, 2)
		func(var)
	end

	parent:AddItem(button)
end

local function Sets_TextBox(name, upd)
	local menu = vgui.Create("DFrame")
	menu:SetSize(550, 150)
	menu:Center()
	menu:SetDraggable(false)
	menu:ShowCloseButton(false)
	menu:SetTitle("")
	menu:MakePopup()
	menu.Alpha = 0

	menu.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self)
		MSDX.Draw(0, 0, 0, w, h, Color(0, 0, 0, 200))

		if self.hover then
			draw.SimpleText(McPhone.GetPhrase("sets_gps_set_name"), "McPhone.Main28", 5, 12, color_black, TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(McPhone.GetPhrase("sets_gps_set_name"), "McPhone.Main28", 5, 12, color_white, TEXT_ALIGN_LEFT)
		end
	end

	local cb = vgui.Create("DButton", menu)
	cb:SetSize(75, 25)
	cb:SetPos(menu:GetWide() - 100, 25)
	cb:SetText("")
	cb.Paint = function(self, w, h)
		if self.hover then
			draw.SimpleText(McPhone.GetPhrase("close"), "McPhone.Main28", 5, 0, McPhone.UserCfg.Theme["buttons"], TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(McPhone.GetPhrase("close"), "McPhone.Main28", 5, 0, color_white, TEXT_ALIGN_LEFT)
		end
	end
	cb.DoClick = function()
		menu:Close()
	end
	cb.OnCursorEntered = function(self)
		self.hover = true
	end
	cb.OnCursorExited = function(self)
		self.hover = false
	end

	local drme = vgui.Create("DTextEntry", menu)
	drme:SetText("")
	drme:SetFont("McPhone.Main28")
	drme:SetValue(name)
	drme:SetMultiline(false)
	drme:SetSize(menu:GetWide() - 50, 25)
	drme:SetPos(25, 60)
	drme:RequestFocus()
	drme.Paint = function(self, w, h)
		self:DrawTextEntryText(color_white, McPhone.UserCfg.Theme["buttons"], color_white)
	end
	drme.OnEnter = function(self)
		menu:Close()

		if name ~= drme:GetValue() then
			LocalCFG.GPSList[game.GetMap()][drme:GetValue()] = LocalCFG.GPSList[game.GetMap()][name]
			LocalCFG.GPSList[game.GetMap()][name] = nil
		end

		upd()
	end

	local cp = vgui.Create("DButton", menu)
	cp:SetSize(75, 25)
	cp:SetPos(menu:GetWide() - 100, menu:GetTall() - 50)
	cp:SetText("")
	cp.Paint = function(self, w, h)
		if self.hover then
			draw.SimpleText("OK", "McPhone.Main28", 5, 0, McPhone.UserCfg.Theme["buttons"], TEXT_ALIGN_LEFT)
		else
			draw.SimpleText("OK", "McPhone.Main28", 5, 0, color_white, TEXT_ALIGN_LEFT)
		end
	end
	cp.DoClick = function()
		menu:Close()

		if name ~= drme:GetValue() then
			LocalCFG.GPSList[game.GetMap()][drme:GetValue()] = LocalCFG.GPSList[game.GetMap()][name]
			LocalCFG.GPSList[game.GetMap()][name] = nil
		end

		upd()
	end
	cp.OnCursorEntered = function(self)
		self.hover = true
	end
	cp.OnCursorExited = function(self)
		self.hover = false
	end

end

local function Normal_TextBox(name, text, upd)
	local menu = vgui.Create("DFrame")
	menu:SetSize(550, 150)
	menu:Center()
	menu:SetDraggable(false)
	menu:ShowCloseButton(false)
	menu:SetTitle("")
	menu:MakePopup()
	menu.Alpha = 0

	menu.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self)
		MSDX.Draw(0, 0, 0, w, h, Color(0, 0, 0, 200))

		if self.hover then
			draw.SimpleText(name, "McPhone.Main28", 5, 12, color_black, TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(name, "McPhone.Main28", 5, 12, color_white, TEXT_ALIGN_LEFT)
		end
	end

	local cb = vgui.Create("DButton", menu)
	cb:SetSize(75, 25)
	cb:SetPos(menu:GetWide() - 100, 25)
	cb:SetText("")

	cb.Paint = function(self, w, h)
		if self.hover then
			draw.SimpleText(McPhone.GetPhrase("close"), "McPhone.Main28", 5, 0, McPhone.UserCfg.Theme["buttons"], TEXT_ALIGN_LEFT)
		else
			draw.SimpleText(McPhone.GetPhrase("close"), "McPhone.Main28", 5, 0, color_white, TEXT_ALIGN_LEFT)
		end
	end

	cb.DoClick = function()
		menu:Close()
	end

	cb.OnCursorEntered = function(self)
		self.hover = true
	end

	cb.OnCursorExited = function(self)
		self.hover = false
	end

	local drme = vgui.Create("DTextEntry", menu)
	drme:SetText("")
	drme:SetFont("McPhone.Main28")
	drme:SetValue(text)
	drme:SetMultiline(false)
	drme:SetSize(menu:GetWide() - 50, 25)
	drme:SetPos(25, 60)
	drme:RequestFocus()

	drme.Paint = function(self, w, h)
		self:DrawTextEntryText(color_white, McPhone.UserCfg.Theme["buttons"], color_white)
	end

	drme.OnEnter = function(self)
		menu:Close()
		upd(drme:GetValue())
	end

	local ct = vgui.Create("DButton", menu)
	ct:SetSize(75, 25)
	ct:SetPos(menu:GetWide() - 100, menu:GetTall() - 50)
	ct:SetText("")
	ct.Paint = function(self, w, h)
		if self.hover then
			draw.SimpleText("OK", "McPhone.Main28", 5, 0, McPhone.UserCfg.Theme["buttons"], TEXT_ALIGN_LEFT)
		else
			draw.SimpleText("OK", "McPhone.Main28", 5, 0, color_white, TEXT_ALIGN_LEFT)
		end
	end
	ct.DoClick = function()
		menu:Close()
		upd(drme:GetValue())
	end
	ct.OnCursorEntered = function(self)
		self.hover = true
	end
	ct.OnCursorExited = function(self)
		self.hover = false
	end

end

local function McButtonGPS(parent, gps, x, upd)
	local panel = vgui.Create("DPanel")
	panel:SetSize(x, 50)

	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w - (w / 6) * 3 - 15, h, Color(0, 0, 0, 200))
		draw.SimpleText(gps, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
	end

	local button = vgui.Create("DButton", panel)
	button:SetSize(panel:GetWide() / 6, 50)
	button:SetPos(panel:GetWide() - (panel:GetWide() / 6) * 3 - 10, 0)
	button:SetText("")

	button.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, Color(0, 0, 0, 200))

		if self.hover then
			MSDX.Draw(0, 0, 0, w, h, Color(255, 255, 255, 200))
			draw.SimpleText(McPhone.GetPhrase("sets_gps_set_name"), "McPhone.Main28", w / 2, 12, color_black, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(McPhone.GetPhrase("sets_gps_set_name"), "McPhone.Main28", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
		end

		return true
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	function button:DoClick()
		Sets_TextBox(gps, upd)
	end

	local button2 = vgui.Create("DButton", panel)
	button2:SetSize(panel:GetWide() / 6, 50)
	button2:SetPos(panel:GetWide() - (panel:GetWide() / 6) * 2 - 5, 0)
	button2:SetText("")
	button2.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, Color(0, 0, 0, 200))

		if self.hover then
			MSDX.Draw(0, 0, 0, w, h, Color(255, 255, 255, 200))
			draw.SimpleText(McPhone.GetPhrase("sets_gps_upd"), "McPhone.Main28", w / 2, 12, color_black, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(McPhone.GetPhrase("sets_gps_upd"), "McPhone.Main28", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
		end

		return true
	end
	button2.OnCursorEntered = function(self)
		self.hover = true
	end
	button2.OnCursorExited = function(self)
		self.hover = false
	end
	function button2:DoClick()
		LocalCFG.GPSList[game.GetMap()][gps] = ply:GetPos()
		upd()
	end

	local button3 = vgui.Create("DButton", panel)
	button3:SetSize(panel:GetWide() / 6, 50)
	button3:SetPos(panel:GetWide() - (panel:GetWide() / 6), 0)
	button3:SetText("")
	button3.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, Color(0, 0, 0, 200))

		if self.hover then
			MSDX.Draw(0, 0, 0, w, h, Color(255, 255, 255, 200))
			draw.SimpleText(McPhone.GetPhrase("sets_gps_rmv"), "McPhone.Main28", w / 2, 12, color_black, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(McPhone.GetPhrase("sets_gps_rmv"), "McPhone.Main28", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
		end

		return true
	end
	button3.OnCursorEntered = function(self)
		self.hover = true
	end
	button3.OnCursorExited = function(self)
		self.hover = false
	end
	function button3:DoClick()
		LocalCFG.GPSList[game.GetMap()][gps] = nil
		upd()
	end

	parent:AddItem(panel)
end

-- local function McButtonCustomNumbers(parent, gps, x, upd)
-- 	local panel = vgui.Create("DPanel")
-- 	panel:SetSize(x, 50)

-- 	panel.Paint = function(self, w, h)
-- 		draw.RoundedBox(0, 0, 0, w - (w / 6) * 3 - 15, h, Color(0, 0, 0, 200))
-- 		draw.SimpleText(gps, "McPhone.Main28", 10, 12, color_white, TEXT_ALIGN_LEFT)
-- 	end

-- 	local button = vgui.Create("DButton", panel)
-- 	button:SetSize(panel:GetWide() / 6, 50)
-- 	button:SetPos(panel:GetWide() - (panel:GetWide() / 6) * 3 - 10, 0)
-- 	button:SetText("")

-- 	button.Paint = function(self, w, h)
-- 		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

-- 		if self.hover then
-- 			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 200))
-- 			draw.SimpleText(McPhone.GetPhrase("sets_gps_set_name"), "McPhone.Main28", w / 2, 12, color_black, TEXT_ALIGN_CENTER)
-- 		else
-- 			draw.SimpleText(McPhone.GetPhrase("sets_gps_set_name"), "McPhone.Main28", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
-- 		end

-- 		return true
-- 	end

-- 	button.OnCursorEntered = function(self)
-- 		self.hover = true
-- 	end

-- 	button.OnCursorExited = function(self)
-- 		self.hover = false
-- 	end

-- 	function button:DoClick()
-- 		Sets_TextBox(gps, upd)
-- 	end

-- 	local button2 = vgui.Create("DButton", panel)
-- 	button2:SetSize(panel:GetWide() / 6, 50)
-- 	button2:SetPos(panel:GetWide() - (panel:GetWide() / 6) * 2 - 5, 0)
-- 	button2:SetText("")
-- 	button2.Paint = function(self, w, h)
-- 		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

-- 		if self.hover then
-- 			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 200))
-- 			draw.SimpleText(McPhone.GetPhrase("sets_gps_upd"), "McPhone.Main28", w / 2, 12, color_black, TEXT_ALIGN_CENTER)
-- 		else
-- 			draw.SimpleText(McPhone.GetPhrase("sets_gps_upd"), "McPhone.Main28", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
-- 		end

-- 		return true
-- 	end
-- 	button2.OnCursorEntered = function(self)
-- 		self.hover = true
-- 	end
-- 	button2.OnCursorExited = function(self)
-- 		self.hover = false
-- 	end
-- 	function button2:DoClick()
-- 		LocalCFG.GPSList[game.GetMap()][gps] = ply:GetPos()
-- 		upd()
-- 	end

-- 	local button3 = vgui.Create("DButton", panel)
-- 	button3:SetSize(panel:GetWide() / 6, 50)
-- 	button3:SetPos(panel:GetWide() - (panel:GetWide() / 6), 0)
-- 	button3:SetText("")
-- 	button3.Paint = function(self, w, h)
-- 		draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 200))

-- 		if self.hover then
-- 			draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 200))
-- 			draw.SimpleText(McPhone.GetPhrase("sets_gps_rmv"), "McPhone.Main28", w / 2, 12, color_black, TEXT_ALIGN_CENTER)
-- 		else
-- 			draw.SimpleText(McPhone.GetPhrase("sets_gps_rmv"), "McPhone.Main28", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
-- 		end

-- 		return true
-- 	end
-- 	button3.OnCursorEntered = function(self)
-- 		self.hover = true
-- 	end
-- 	button3.OnCursorExited = function(self)
-- 		self.hover = false
-- 	end
-- 	function button3:DoClick()
-- 		LocalCFG.GPSList[game.GetMap()][gps] = nil
-- 		upd()
-- 	end

-- 	parent:AddItem(panel)
-- end


function McPhone.OpenConfigManager(osm)
	local sW, sH = ScrW(), ScrH()
	local CloseMenu
	local LocalBinds = table.Copy(McPhone.UserCfg.Binds)
	LocalCFG = table.Copy(McPhone.Config)
	local frame = vgui.Create("DFrame")
	frame:SetSize(sW - sW / 8, sH - sH / 6)
	frame:Center()
	frame:SetTitle("")
	frame:SetDraggable(false)
	frame:ShowCloseButton(false)
	frame:MakePopup()
	frame.Atime = 0

	frame.Paint = function(self, w, h)
		MCDrawBackgroundBlur(self)
		draw.SimpleTextOutlined("McPhone", "McPhone.Main38", 0, 0, color_white, TEXT_ALIGN_LEFT, 0, 1, color_black)
	end

	local x, y = frame:GetWide(), frame:GetTall()
	local f_list = vgui.Create("MSDPanelList", frame)
	f_list:SetPos(0, 40)
	f_list:SetSize(x, 50)
	f_list:EnableHorizontal(true)
	f_list:EnableVerticalScrollbar(false)
	f_list:SetSpacing(2)
	f_list.Paint = function() end
	f_list.VBar.Paint = function() end
	f_list.VBar.btnUp.Paint = function() end
	f_list.VBar.btnDown.Paint = function() end
	f_list.VBar.btnGrip.Paint = function() end
	local sets_m, open_bm, open_sm

	local bind_m = McUpperButton(f_list, McPhone.GetPhrase("key_binds"), function()
		open_bm()
	end)

	if ply:IsSuperAdmin() then
		sets_m = McUpperButton(f_list, McPhone.GetPhrase("server_setts"), function()
			open_sm()
		end)
	end

	McUpperButton(f_list, McPhone.GetPhrase("close"), function()
		CloseMenu()
	end)

	local s_list = vgui.Create("MSDPanelList", frame)
	s_list:SetPos(0, 100)
	s_list:SetSize(x, y - 100)
	s_list:EnableHorizontal(false)
	s_list:EnableVerticalScrollbar(true)
	s_list:SetSpacing(5)
	s_list.Paint = function() end
	s_list.VBar.Paint = function() end
	s_list.VBar.btnUp.Paint = function() end
	s_list.VBar.btnDown.Paint = function() end
	s_list.VBar.btnGrip.Paint = function() end

	function open_bm()
		bind_m.hovered = true

		if sets_m then
			sets_m.hovered = false
		end

		s_list:Clear(true)

		if ply:IsSuperAdmin() then
			McTextPanel(s_list, McPhone.GetPhrase("sa_notification"))
		end

		McTButton(s_list, McPhone.GetPhrase("sets_reset"), function()
			McPhone.UserCfg.Binds = McPhone.Binds
			McPhone.SaveUserConfig()
			frame:Close()
		end)

		local panel = vgui.Create("DPanel")
		panel:SetSize(300, 175)

		panel.Paint = function(self, w, h)
			MSDX.Draw(0, 0, 3, w, h - 3, Color(0, 0, 0, 200))
			McPhone.DrawTexturedRect(w - 500, 0, 500, 174, "mc_phone/icons/binds.png", color_white)
			draw.SimpleText(McPhone.GetPhrase("sets_mkb"), "McPhone.Main28", 10, 10, color_white, TEXT_ALIGN_LEFT)
			draw.SimpleText(McPhone.GetPhrase("sets_lmb"), "McPhone.Main28", 10, 40, color_white, TEXT_ALIGN_LEFT)
			draw.SimpleText(McPhone.GetPhrase("sets_rmb"), "McPhone.Main28", 10, 70, color_white, TEXT_ALIGN_LEFT)
			draw.SimpleText(McPhone.GetPhrase("sets_mmb"), "McPhone.Main28", 10, 100, color_white, TEXT_ALIGN_LEFT)
			draw.SimpleText(McPhone.GetPhrase("sets_wscr"), "McPhone.Main28", 10, 130, color_white, TEXT_ALIGN_LEFT)
		end

		s_list:AddItem(panel)

		McButton(s_list, McPhone.GetPhrase("sets_umb"), McPhone.UserCfg.UseMouse, function(var)
			McPhone.UserCfg.UseMouse = var
		end)

		McButton(s_list, McPhone.GetPhrase("sets_popup"), McPhone.UserCfg.PopUp, function(var)
			McPhone.UserCfg.PopUp = var
		end)

		McButton(s_list, McPhone.GetPhrase("sets_ply_cursor"), McPhone.UserCfg.CursorOnPopUp, function(var)
			McPhone.UserCfg.CursorOnPopUp = var
		end)

		McButtonVolume(s_list, McPhone.GetPhrase("sets_ply_volume"), McPhone.UserCfg.UISoundVolume, function(var)
			McPhone.UserCfg.UISoundVolume = var
		end)

		McTextPanel(s_list, McPhone.GetPhrase("ui_binds"))

		McBinder(s_list, McPhone.GetPhrase("sets_kupb"), LocalBinds.up, function(num)
			LocalBinds.up = num
		end)

		McBinderM(s_list, McPhone.GetPhrase("sets_kopen"), McPhone.UserCfg.MiddlePress, function(num)
			McPhone.UserCfg.MiddlePress = num
		end)

		McBinder(s_list, McPhone.GetPhrase("sets_kdwnb"), LocalBinds.down, function(num)
			LocalBinds.down = num
		end)

		McBinder(s_list, McPhone.GetPhrase("sets_klfb"), LocalBinds.left, function(num)
			LocalBinds.left = num
		end)

		McBinder(s_list, McPhone.GetPhrase("sets_krtb"), LocalBinds.right, function(num)
			LocalBinds.right = num
		end)

		McBinder(s_list, McPhone.GetPhrase("sets_kcls"), LocalBinds.close, function(num)
			LocalBinds.close = num
		end)

		McBinder(s_list, McPhone.GetPhrase("sets_kbkb"), LocalBinds.back, function(num)
			LocalBinds.back = num
		end)

		McBinder(s_list, McPhone.GetPhrase("sets_kent"), LocalBinds.click, function(num)
			LocalBinds.click = num
		end)

		McBinder(s_list, McPhone.GetPhrase("sets_kopt"), LocalBinds.click2, function(num)
			LocalBinds.click2 = num
		end)
	end

	function open_sm()
		bind_m.hovered = false
		sets_m.hovered = true
		local sm_main, sm_gps, sm_ep1

		function sm_main()
			s_list:Clear(true)

			McTButton(s_list, McPhone.GetPhrase("sets_manage_gps"), function()
				sm_gps()
			end)

			McTButton(s_list, "Language: " .. McPhone.GetPhrase("lang_name"), function()
				s_list:Clear(true)

				McTButton(s_list, McPhone.GetPhrase("go_back"), function()
					sm_main()
				end)

				for k, v in pairs(McPhone.Language) do
					McTButton(s_list, v.lang_name, function()
						LocalCFG.Language = k
						McPhone.Config = LocalCFG
						McPhone.SaveConfig()
						frame:Close()
						McPhone.ModuleLoader()
						McPhone.OpenConfigManager(true)
					end)
				end
			end)

			McButton(s_list, McPhone.GetPhrase("GlobalContacts"), LocalCFG.GlobalContacts, function(var)
				LocalCFG.GlobalContacts = var
			end)

			if DarkRP then
				McButton(s_list, McPhone.GetPhrase("DarkRPLog"), LocalCFG.DarkRPLog, function(var)
					LocalCFG.DarkRPLog = var
				end)
			end

			McButton(s_list, McPhone.GetPhrase("Draw3DModel"), LocalCFG.Draw3DModel, function(var)
				LocalCFG.Draw3DModel = var
			end)

			if StormFox then
				McButton(s_list, McPhone.GetPhrase("StormFoxTime"), LocalCFG.StormFoxTime, function(var)
					LocalCFG.StormFoxTime = var
				end)
			end

			if DarkRP then
				McButton(s_list, McPhone.GetPhrase("EmailFee"), LocalCFG.EmailFee, function(var)
					LocalCFG.EmailFee = var
				end)

				McTButton(s_list, McPhone.GetPhrase("EmailFeeSize") .. ": " .. LocalCFG.EmailFeeSize, function()
					Normal_TextBox(McPhone.GetPhrase("NumberOnly"), LocalCFG.EmailFeeSize, function(var)
						if isnumber(tonumber(var)) then
							LocalCFG.EmailFeeSize = tonumber(var) sm_main()
						end
					end)
				end)
			else
				McTextPanel(s_list, McPhone.GetPhrase("drp_support_ef"))
			end

			McTButton(s_list, McPhone.GetPhrase("CameraWaterMark") .. ": " .. LocalCFG.CameraWaterMark, function()
				Normal_TextBox(McPhone.GetPhrase("Watermark"), LocalCFG.CameraWaterMark, function(var)
					LocalCFG.CameraWaterMark = var
					sm_main()
				end)
			end)

			McTButton(s_list, McPhone.GetPhrase("ServerCurensy") .. ": " .. LocalCFG.Curensy, function()
				Normal_TextBox(McPhone.GetPhrase("Currency"), LocalCFG.Curensy, function(var)
					LocalCFG.Curensy = var
					sm_main()
				end)
			end)

			McButton(s_list, McPhone.GetPhrase("sets_dropphone"), LocalCFG.AllowPhoneDrop, function(var)
				LocalCFG.AllowPhoneDrop = var
				sm_main()
			end)

			if LocalCFG.AllowPhoneDrop then
				McTButton(s_list, McPhone.GetPhrase("sets_dropphone_command") .. ": " .. LocalCFG.DropCommand, function()
					Normal_TextBox(McPhone.GetPhrase("Command"), LocalCFG.DropCommand, function(var)
						LocalCFG.DropCommand = var
						sm_main()
					end)
				end)

				McButton(s_list, McPhone.GetPhrase("sets_givephone"), LocalCFG.GivePhoneOnSpawn, function(var)
					LocalCFG.GivePhoneOnSpawn = var
					sm_main()
				end)

				if not LocalCFG.GivePhoneOnSpawn then
					McButton(s_list, McPhone.GetPhrase("sets_phone_death"), LocalCFG.PhoneLoseDeath, function(var)
						LocalCFG.PhoneLoseDeath = var
					end)

					McButton(s_list, McPhone.GetPhrase("sets_phone_disconnect"), LocalCFG.PhoneLoseDisconnect, function(var)
						LocalCFG.PhoneLoseDisconnect = var
					end)
				end
			end

			if McPhone.EP1 then
				McTextPanel(s_list, "DLC")

				McTButton(s_list, McPhone.GetPhrase("sets_ep1"), function()
					sm_ep1()
				end)
			end
		end

		function sm_gps()
			s_list:Clear(true)
			McTextPanel(s_list, McPhone.GetPhrase("sets_gps_info"))

			McTButton(s_list, McPhone.GetPhrase("go_back"), function()
				sm_main()
			end)

			McTButton(s_list, McPhone.GetPhrase("sets_new_gps"), function()
				if not LocalCFG.GPSList[game.GetMap()] then
					LocalCFG.GPSList[game.GetMap()] = {}
				end

				LocalCFG.GPSList[game.GetMap()]["New marker"] = ply:GetPos()
				sm_gps()
			end)

			if LocalCFG.GPSList[game.GetMap()] then
				for k, v in pairs(LocalCFG.GPSList[game.GetMap()]) do
					McButtonGPS(s_list, k, x, function()
						sm_gps()
					end)
				end
			end
		end

		function sm_cn()
			s_list:Clear(true)
			McTextPanel(s_list, McPhone.GetPhrase("sets_gps_info"))

			McTButton(s_list, McPhone.GetPhrase("go_back"), function()
				sm_main()
			end)

			McTButton(s_list, McPhone.GetPhrase("sets_new_gps"), function()
				if not LocalCFG.GPSList[game.GetMap()] then
					LocalCFG.GPSList[game.GetMap()] = {}
				end

				LocalCFG.GPSList["000"] = numberpreset
				sm_gps()
			end)

			-- for k, v in pairs(LocalCFG.CustomNumbers) do
			-- 	-- McButtonGPS(s_list, k, x, function()
			-- 	-- 	sm_gps()
			-- 	-- end)
			-- end
		end

		function sm_ep1()
			s_list:Clear(true)

			McTButton(s_list, McPhone.GetPhrase("go_back"), function()
				sm_main()
			end)

			McButton(s_list, McPhone.GetPhrase("ShowZones"), LocalCFG.ShowZones, function(var)
				LocalCFG.ShowZones = var
			end)

			McButton(s_list, McPhone.GetPhrase("TowerRangebasedNet"), LocalCFG.TowerRangebasedNet, function(var)
				LocalCFG.TowerRangebasedNet = var
				sm_ep1()
			end)

			if LocalCFG.TowerRangebasedNet then
				McTButton(s_list, McPhone.GetPhrase("TowerMaxRange") .. ": " .. LocalCFG.TowerMaxRange, function()
					Normal_TextBox(McPhone.GetPhrase("InUnits"), LocalCFG.TowerMaxRange, function(var)
						if isnumber(tonumber(var)) then
							LocalCFG.TowerMaxRange = tonumber(var)
							sm_ep1()
						end
					end)
				end)
			end

			McButton(s_list, McPhone.GetPhrase("DestructibleTowers"), LocalCFG.DestructibleTowers, function(var)
				LocalCFG.DestructibleTowers = var
				sm_ep1()
			end)

			if LocalCFG.DestructibleTowers then
				McTButton(s_list, McPhone.GetPhrase("TowerHealth") .. ": " .. LocalCFG.TowerHealth, function()
					Normal_TextBox(McPhone.GetPhrase("HP"), LocalCFG.TowerHealth, function(var)
						if isnumber(tonumber(var)) then
							LocalCFG.TowerHealth = tonumber(var)
							sm_ep1()
						end
					end)
				end)

				McTButton(s_list, McPhone.GetPhrase("TowerRepairTime") .. ": " .. LocalCFG.TowerRepairTime, function()
					Normal_TextBox(McPhone.GetPhrase("InSeconds"), LocalCFG.TowerRepairTime, function(var)
						if isnumber(tonumber(var)) then
							LocalCFG.TowerRepairTime = tonumber(var)
							sm_ep1()
						end
					end)
				end)
			end

			McTButton(s_list, McPhone.GetPhrase("JammerRange") .. ": " .. LocalCFG.JammerRange, function()
				Normal_TextBox(McPhone.GetPhrase("InUnits"), LocalCFG.JammerRange, function(var)
					if isnumber(tonumber(var)) then
						LocalCFG.JammerRange = tonumber(var)
						sm_ep1()
					end
				end)
			end)

			McTButton(s_list, McPhone.GetPhrase("JammerLiveTime") .. ": " .. LocalCFG.JammerLiveTime, function()
				Normal_TextBox(McPhone.GetPhrase("InSeconds"), LocalCFG.JammerLiveTime, function(var)
					if isnumber(tonumber(var)) then
						LocalCFG.JammerLiveTime = tonumber(var)
						sm_ep1()
					end
				end)
			end)

			McButton(s_list, McPhone.GetPhrase("DestructibleJammer"), LocalCFG.DestructibleJammer, function(var)
				LocalCFG.DestructibleJammer = var
				sm_ep1()
			end)

			if LocalCFG.DestructibleJammer then
				McTButton(s_list, McPhone.GetPhrase("JammerHealth") .. ": " .. LocalCFG.JammerHealth, function()
					Normal_TextBox(McPhone.GetPhrase("HP"), LocalCFG.JammerHealth, function(var)
						if isnumber(tonumber(var)) then
							LocalCFG.JammerHealth = tonumber(var)
							sm_ep1()
						end
					end)
				end)
			end

			McTButton(s_list, McPhone.GetPhrase("SaveTower"), function()
				net.Start("McPhone.SaveTowers")
				net.SendToServer()
			end)

			McTButton(s_list, McPhone.GetPhrase("SpawnTower"), function()
				net.Start("McPhone.SpawnTower")
				net.SendToServer()
			end)

			McTButton(s_list, McPhone.GetPhrase("RemoveTowers"), function()
				net.Start("McPhone.RemoveTowers")
				net.SendToServer()
			end)
		end

		sm_main()
	end

	function CloseMenu()
		local close = vgui.Create("DFrame")
		close:SetSize(sW, sH)
		close:Center()
		close:SetTitle("")
		close:SetDraggable(false)
		close:ShowCloseButton(false)
		close:MakePopup()
		close.Atime = 0

		close.Paint = function(self, w, h)
			MCDrawBackgroundBlur(self)
		end

		local sf_list = vgui.Create("MSDPanelList", close)
		sf_list:SetSize(sW - sW / 3, 154)
		sf_list:Center()
		sf_list:EnableHorizontal(false)
		sf_list:EnableVerticalScrollbar(true)
		sf_list:SetSpacing(2)

		sf_list.Paint = function(self, w, h)
			MSDX.Draw(0, 0, 3, w, h, McPhone.Alpha(McPhone.UserCfg.Theme["buttons"], 100))
		end

		sf_list.VBar.Paint = function() end
		sf_list.VBar.btnUp.Paint = function() end
		sf_list.VBar.btnDown.Paint = function() end
		sf_list.VBar.btnGrip.Paint = function() end

		McUpperButton(sf_list, McPhone.GetPhrase("sets_save"), function()
			if ply:IsSuperAdmin() then
				McPhone.Config = LocalCFG
				McPhone.SaveConfig()
			end

			McPhone.UserCfg.Binds = LocalBinds
			McPhone.SaveUserConfig()
			close:Close()
			frame:Close()
		end)

		McUpperButton(sf_list, McPhone.GetPhrase("close_nosave"), function()
			close:Close()
			frame:Close()
		end)

		McUpperButton(sf_list, McPhone.GetPhrase("cancel"), function()
			close:Close()
		end)
	end

	if osm then
		open_sm()
	else
		open_bm()
	end
end