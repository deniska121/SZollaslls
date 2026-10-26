--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/client/vgui/elements/dtextentry.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}
AccessorFunc(PANEL, "m_strPlaceholder", "Placeholder", FORCE_STRING)
local intNext = 0

function PANEL:Init()
	self:SetText("")
	self:SetFont("MSDFont.22")
	self:SetPlaceholder("")
	self:SetTextColor(color_white)
end

function PANEL:SetMaxChars(i)
	self.MaxChars = i
end

function PANEL:Paint(intW, intH)
	surface.SetDrawColor(Slawer.Mayor.Colors.DarkGrey)
	surface.DrawRect(0, 0, intW, intH)
	surface.SetDrawColor(Slawer.Mayor.Colors.LightGrey)
	surface.DrawLine(0, intH - 1, intW, intH - 1)

	if Slawer.Mayor.FocusEntry == self and IsValid(Slawer.Mayor.FakeTextEntry) then
		surface.SetDrawColor(Slawer.Mayor.Colors.LightGrey)
		surface.DrawOutlinedRect(0, 0, intW, intH)
		surface.SetFont(self:GetFont())
		local intOffset, h = surface.GetTextSize(utf8.sub(self:GetText(), 1, Slawer.Mayor.FakeTextEntry:GetCaretPos()))
		intOffset = math.Clamp(intOffset, 0, intW - 8)
		surface.SetDrawColor(MSD.ColorAlpha(Slawer.Mayor.Colors.LightGrey, math.abs(math.sin(CurTime() * 2) * 255)))
		surface.DrawLine(intOffset + 3, intH * 0.5 - h * 0.5, intOffset + 3, intH * 0.5 + h * 0.5)
	end

	if self:GetPlaceholder() ~= "" and self:GetText() == "" then
		draw.SimpleText(self:GetPlaceholder(), self:GetFont(), 2, intH * 0.5, self:GetTextColor(), 0, 1)
	else
		self:DrawTextEntryText(color_white, Color(100, 100, 255), color_white)
	end
end

function PANEL:OnMousePressed()
	if intNext > CurTime() then return end

	if IsValid(Slawer.Mayor.FocusEntry) and Slawer.Mayor.FocusEntry == self then
		Slawer.Mayor.FocusEntry = nil

		if IsValid(Slawer.Mayor.FakeTextEntry) then
			Slawer.Mayor.FakeTextEntry:Remove()
		end
	else
		Slawer.Mayor.FocusEntry = self
		Slawer.Mayor.FakeTextEntry = vgui.Create("DTextEntry")
		Slawer.Mayor.FakeTextEntry:MakePopup()
		Slawer.Mayor.FakeTextEntry:SetText(self:GetText())
		Slawer.Mayor.FakeTextEntry:SetCaretPos(utf8.len(self:GetText()))
		Slawer.Mayor.FakeTextEntry:SetSize(0, 0)
		Slawer.Mayor.FakeTextEntry:SetUpdateOnType(true)
		Slawer.Mayor.FakeTextEntry.MaxChars = self.MaxChars or 150

		function Slawer.Mayor.FakeTextEntry:Think()
			if not IsValid(Slawer.Mayor.FocusEntry) or not LocalPlayer():Alive() then
				self:Remove()

				return
			end

			if IsValid(Slawer.Mayor.Menu) and Slawer.Mayor.Menu.Lock.sizeTo ~= 0 then
				self:Remove()

				return
			end

			self:RequestFocus()
			Slawer.Mayor.FocusEntry:SetText(self:GetText())
			Slawer.Mayor.FocusEntry:SetCaretPos(self:GetCaretPos())
		end

		function Slawer.Mayor.FakeTextEntry:OnEnter()
			self:Remove()

			if Slawer.Mayor.FocusEntry.OnEnter then
				Slawer.Mayor.FocusEntry:OnEnter()
			end

			Slawer.Mayor.FocusEntry = nil
		end

		function Slawer.Mayor.FakeTextEntry:OnChange()
			local txt = self:GetText()
			local amt = utf8.len(txt)

			if amt > self.MaxChars then
				self:SetText(self.OldText or "")
				self:SetValue(self.OldText or "")
			else
				self.OldText = txt
			end

			if Slawer.Mayor.FocusEntry.OnValueChange then
				Slawer.Mayor.FocusEntry:OnValueChange(self:GetText())
			end
		end
	end

	intNext = CurTime() + 0.4
end

vgui.Register("Slawer.Mayor:DTextEntry", PANEL, "DTextEntry")