--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/shared/util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Win98 = Win98 or {}

Win98.Cls = {
	bg = Color(0, 128, 128),
	dgray = Color(128, 128, 128),
	gray = Color(192, 192, 192),
	white = Color(223, 223, 223),
	nypd = Color(35, 36, 42),
}

Win98.Text = {
	["a"] = Color(150, 150, 150, 200),
	["n"] = Color(150, 150, 150),
	["d"] = Color(56, 56, 56),
	["s"] = Color(39, 39, 39),
	["m"] = Color(31, 31, 31),
	["l"] = Color(12, 12, 12),
	["b"] = Color(17,0,255),
}


Win98.Icons = Win98.Icons or {}

function Win98.Icon(name)
	if Win98.Icons[name] then
		return Win98.Icons[name]
	end

	local path = "vgui/win98/" .. name .. ".png"

	-- if not file.Exists( path, "GAME" ) then
	-- 	path = "vgui/win98/file_gears-2.png"
	-- end

	Win98.Icons[name] = Material(path, "smooth")

	return Win98.Icons[name]
end

function Win98.IconPath(name)
	local path = "vgui/win98/" .. name .. ".png"

	-- if not file.Exists( path, "GAME" ) then
	-- 	path = "vgui/win98/file_gears-2.png"
	-- end

	return path
end

function Win98.InnerRec(x, y, w, h)

	surface.SetDrawColor(Win98.Cls.dgray)
	surface.DrawLine( x, y, x + w, y)
	surface.DrawLine( x, y, x, y + h)

	surface.SetDrawColor(Win98.Cls.white)
	surface.DrawLine( x, y + h, x + w, y + h)
	surface.DrawLine( x + w, y, x + w, y + h)

end

Slawer.Mayor.Colors = {
	Blue = Color(40, 116, 166),
	LightGrey = Color(125, 125, 125),
	Grey = Color(44, 47, 51),
	DarkGrey = Color(35, 36, 42),
	Red = Color(192, 57, 43),
	Green = Color(39, 174, 96),
	Black = Color(25, 25, 25),
}

function Slawer.Mayor:HasAccess(pPlayer, tp)
	if pPlayer:isMayor() then
		return true
	end

	if tp and tp == "kick" then
		local rank = MRS.GetNWdata(pPlayer, "Rank") or 1

		if pPlayer:isCP() and rank > 5 then
			return true
		end

		if pPlayer:isEMS() and rank > 6 then
			return true
		end
	end

	return false
end

if SERVER then return end

local NewFont = surface.CreateFont
for i = 0, 30 do
	NewFont("Roman." .. 12 + i, {
		font = "Times New Roman",
		extended = true,
		size = 12 + i,
		weight = 500
	})
end

function Win98.Header(parent, text, align, cl, hd, f)
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = hd or 50,
		minw = 250,
		minh = hd or 50
	}

	panel.Paint = function(self, w, h)
		draw.SimpleText(text, f or "Roman.26", align == 0 and 10 or w / 2, h  / 2, cl or Win98.Text.l, align, TEXT_ALIGN_CENTER)
	end

	parent:AddItem(panel)

	return panel
end

function Win98.InfoHeader(parent, text, wd)
	local panel = vgui.Create("DPanel")
	wd = wd or 1
	panel.StaticScale = {
		w = wd,
		fixed_h = 25,
		minw = 250,
		minh = 25
	}

	panel.Paint = function(self, w, h)
		draw.DrawText(text, "Roman.18", 5, h / 2 - 11, Win98.Text.l, TEXT_ALIGN_LEFT)
	end

	parent:AddItem(panel)

	return panel
end

function Win98.InfoText(parent, text, font)
	font = font or "Roman.22"
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 25,
		minw = 250,
		minh = 25
	}

	panel.Paint = function(self, w, h)
		draw.DrawText(self.txt or "", font, 5, 5, Win98.Text.d, TEXT_ALIGN_LEFT)

		if not self.txt or (self.sh and self.sh ~= h) or (self.sw and self.sw ~= w) then
			local ts, _, th = MSD.TextWrap(text, font, w - 10)
			self.txt = ts
			self.sw = w
			self.sh = h
			self.StaticScale.fixed_h = th + 10
		end
	end

	parent:AddItem(panel)

	return panel
end

function Win98.ButtonBlack(pnl, text, f, icon, w, h, func)
	local btnSave = vgui.Create("DButton", pnl)
	btnSave:SetSize(w, h)
	btnSave:SetText("")
	btnSave.bgc = color_black
	btnSave.tc = color_white
	btnSave.htc = Win98.Text.b
	function btnSave:Paint(intW, intH)
		if self.pbg then
			self.pbg(self, intW, intH)
		else
			surface.SetDrawColor(self.bgc)
			surface.DrawRect(0, 0, intW, intH)
		end

		MSD.DrawTexturedRect(20, 10, intH - 20, intH - 20, Win98.Icon(icon), color_white)
		draw.SimpleText(text, f, intW / 2, intH / 2, self.hover and self.htc or self.tc, TEXT_ALIGN_CENTER, 1)
	end
	btnSave.OnCursorEntered = function(s) s.hover = true end
	btnSave.OnCursorExited = function(s) s.hover = false end

	function btnSave:DoClick()
		surface.PlaySound("win/click.wav")
		func(self)
	end

	return btnSave
end

function Win98.InfoTextF1(parent, text, wide, font, color, bg)
	font = font or "Roman.20"
	local panel = vgui.Create("DPanel")
	local ts, _, th = MSD.TextWrap(text, font, wide - 20)

	panel.StaticScale = {
		w = 1,
		fixed_h = th + 10,
		minw = 250,
		minh = th
	}
	panel.text = ts
	panel.Paint = function(self, w, h)
		if bg then
			MSDX.Draw(0, 0, 0, w, h, bg)
		end

		draw.DrawText(self.text, font, 10, 5, color or color_white, TEXT_ALIGN_LEFT)
	end

	panel.OnRemove = function()
		if IsValid(voiceover) then
			voiceover:Stop()
			voiceover = nil
		end
	end

	parent:AddItem(panel)


	return panel
end

function Win98.TextEntry(parent, x, y, w, h, text, label, value, func, auto_update, focuse_update, multi, num)
	local Entry = vgui.Create("DTextEntry")

	if x and y then
		Entry:SetParent(parent)
		Entry:SetPos(x, y)
	end

	if x == "static" then
		Entry.StaticScale = {
			w = w,
			fixed_h = h,
			minw = 50,
			minh = h
		}
	else
		Entry:SetSize(w, h)
	end

	Entry:SetNumeric(num or false)
	Entry:SetText("")
	Entry:SetFont("Roman.22")
	Entry:SetMultiline(multi or false)
	Entry.alpha = 0
	Entry:SetDrawLanguageID(false)

	Entry.Paint = function(self, wd, hd)
		if self:HasFocus() then
			MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.white)
		else
			MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.gray)
		end
		Win98.InnerRec(0, 0, wd, hd)

		if self:GetValue() == "" then
			draw.DrawText(text, "Roman.22", 3, multi and 1 or hd / 2 - 10, MSD.ColorAlpha(color_black, 120), TEXT_ALIGN_LEFT)
		end

		if label and not self.error then
			draw.SimpleText(label, "Roman.16", 3, 0, MSD.ColorAlpha(color_black, 120), TEXT_ALIGN_LEFT)
		end

		if self.error then
			draw.SimpleText(self.error, "Roman.16", 3, 0, MSD.Config.MainColor["r"], TEXT_ALIGN_LEFT)
		end

		self:DrawTextEntryText(color_black, color_black, color_black)
	end

	Entry.OnEnter = function(...)
		MSD.UISnd("msd/ui/enter.wav")
		func(...)
	end

	if focuse_update then
		Entry.OnFocusChanged = function(self, gained)
			if not gained then
				MSD.UISnd("msd/ui/enter.wav")
				func(self, self:GetValue())
			end
		end
	end

	Entry:SetText(value or "")

	if auto_update then
		Entry:SetUpdateOnType(true)

		function Entry:OnValueChange(vl)
			if func then
				func(self, vl)
			end
		end
	end

	if not x or not y then
		parent:AddItem(Entry)
	end

	return Entry
end

local clc = Color(0, 0, 0, 225)

function Win98.TextEntryAlt(parent, x, y, w, h, value, func, auto_update, focuse_update, multi, num, cl, bg)
	local Entry = vgui.Create("DTextEntry")
	cl = cl or clc
	if x and y then
		Entry:SetParent(parent)
		Entry:SetPos(x, y)
	end

	if x == "static" then
		Entry.StaticScale = {
			w = w,
			fixed_h = h,
			minw = 50,
			minh = h
		}
	else
		Entry:SetSize(w, h)
	end

	Entry:SetNumeric(num or false)
	Entry:SetText("")
	Entry:SetFont("Moster.24")
	Entry:SetMultiline(multi or false)
	Entry.alpha = 0
	Entry:SetDrawLanguageID(false)

	Entry.Paint = function(self, wd, hd)
		if bg then
			bg(self, wd, hd)
		end

		self:DrawTextEntryText(cl, cl, cl)
	end

	Entry.OnEnter = function(...)
		MSD.UISnd("msd/ui/enter.wav")
		func(...)
	end

	if focuse_update then
		Entry.OnFocusChanged = function(self, gained)
			if not gained then
				MSD.UISnd("msd/ui/enter.wav")
				func(self, self:GetValue())
			end
		end
	end

	Entry:SetText(value or "")

	if auto_update then
		Entry:SetUpdateOnType(true)

		function Entry:OnValueChange(vl)
			if func then
				func(self, vl)
			end
		end
	end

	if not x or not y then
		parent:AddItem(Entry)
	end

	return Entry
end

function Win98.AltButton(parent, text, x, y, wd, hd, color, func, bg)
	local button = vgui.Create("DButton")

	if x and y then
		button:SetParent(parent)
		button:SetPos(x, y)
	end

	if x == "static" then
		button.StaticScale = {
			w = wd,
			fixed_h = hd,
			minw = wd,
			minh = hd
		}
	end

	button:SetSize(wd, hd)
	button:SetText(text)
	button.hovered = false
	button.alpha = 0
	button.font = "Moster.24"
	button.bgpaint = bg

	button.Paint = function(self, w, h)
		if self.hover or self.hovered then
			self.alpha = 1
		else
			self.alpha = 0
		end

		if self.bgpaint then
			self.bgpaint(self, w, h)
		end

		draw.SimpleText(self:GetText(), self.font, w / 2, h / 2, MSD.ColorAlpha(color, 200 + self.alpha * 55), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		return true
	end

	button.DoClick = function(...)
		func(...)
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	button.DoRightClick = function(...)
		func(...)
	end

	if not x or not y then
		parent:AddItem(button)
	end

	return button
end

function Win98.AltComboBox(parent, x, y, w, h, val)
	local ComboBox = vgui.Create("DComboBox")

	if x and y then
		ComboBox:SetParent(parent)
		ComboBox:SetPos(x, y)
	end

	if x == "static" then
		ComboBox.StaticScale = {
			w = w,
			fixed_h = h,
			minw = 50,
			minh = h
		}
	else
		ComboBox:SetSize(w, h)
	end

	ComboBox:SetValue(val)
	ComboBox:SetFont("Moster.24")
	ComboBox.alpha = 0
	ComboBox.disabled = false
	ComboBox:SetTextColor(MSD.Text["s"])

	ComboBox.Paint = function(self, wd, hd)
		if ( self:IsMenuOpen() or self.pressed ) and not self.disabled then
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 255)
		else
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 0)
		end

		--draw.SimpleText(self:GetText(), "Moster.24", 3, hd / 2 - 10, clc, TEXT_ALIGN_LEFT)

		-- if label and not self.error then
		-- 	draw.SimpleText(label, "Moster.24", 3, 0, MSD.ColorAlpha(clc, 120), TEXT_ALIGN_LEFT)
		-- end

		return true
	end

	ComboBox.OnCursorEntered = function(self)
		self.pressed = true
	end

	ComboBox.OnCursorExited = function(self)
		self.pressed = false
	end

	function ComboBox:OpenMenu(pControlOpener)
		if (pControlOpener and pControlOpener == self.TextEntry) then return end
		if (self.disabled) then return end
		if (#self.Choices == 0) then return end

		if (IsValid(self.Menu)) then
			self.Menu:Remove()
			self.Menu = nil
		end

		self.Menu = MSD.MenuOpen(false, self)

		for k, v in pairs(self.Choices) do
			self.Menu:AddOption(v, function()
				self:ChooseOption(v, k)
			end)
		end

		local mx, my = self:LocalToScreen(0, self:GetTall())
		self.Menu:SetMinimumWidth(self:GetWide())
		self.Menu:Open(mx, my, false, self)

		MSD.UISnd("msd/ui/toggle.wav")
	end

	if not x or not y then
		parent:AddItem(ComboBox)
	end

	return ComboBox
end