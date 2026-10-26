--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/client/vgui/elements/editablepanel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}

AccessorFunc(PANEL, "m_intHeaderTall", "HeaderTall", FORCE_NUMBER)
AccessorFunc(PANEL, "m_strHeaderText", "HeaderText", FORCE_STRING)

function PANEL:Init()
	self.btnClose = vgui.Create("DImageButton", self)
	self.btnClose:SetSize(48, 48)
	self.btnClose:SetImage(Win98.IconPath("shut_down_cool-5"))
	function self.btnClose:DoClick()
		surface.PlaySound("win/click.wav")
		self:GetParent():Remove()
		Slawer.Mayor.LookingTo = nil
		gui.EnableScreenClicker(false)
	end

	self.bstart = vgui.Create("Button", self)
	self.bstart:SetSize(56, 22)
	self.bstart:SetText("")
	self.bstart:SetSkin("GMod98")

	self.list = vgui.Create("WINPanelList", self)
	self.list:SetPos(10, 20)
	self.list:SetSize(64, 64)
	self.list:EnableVerticalScrollbar()
	self.list:EnableHorizontal(true)
	self.list:SetSpacing(0)
	self.list:SetSpacing(0)

	self.taskbar = vgui.Create("DPanel", self)
	self.taskbar:SetSize(600, 26)
	function self.taskbar:Paint() end
	function self.taskbar:PerformLayout(w,h)
		local count = #self:GetChildren()
		local x, y = math.Clamp(w / count, 25, 120), h
		for i, v in ipairs( self:GetChildren() ) do
			v:SetSize(x,y)
			v:SetPos((i - 1) * x + 5, 0)
		end
	end

	self.bstart.DoClick = function(s)
		surface.PlaySound("win/click.wav")

		if IsValid(self.astart) then
			self.astart:Remove()
			return
		end

		self.astart = vgui.Create("DPanel", self)
		self.astart:SetSize(156, 50)
		self.astart:SetZPos(2)
		self.astart:SetPos(0, self:GetTall() - 76)
		self.astart:SetSkin("GMod98")

		local alist = vgui.Create("WINPanelList", self.astart)
		alist:SetPos(0, 0)
		alist:SetSize(156, 100)
		alist:EnableVerticalScrollbar()
		alist:EnableHorizontal(true)
		alist:SetSpacing(0)
		alist:SetSpacing(0)
		alist.sliderColor = Color(0, 0, 0, 0)
		alist.IgnoreVbar = true

		local bstart = vgui.Create("DButton")
		bstart.StaticScale = {w = 1,fixed_h = 50,minw = 11,minh = 50}
		bstart:SetText("Отключить")
		bstart:SetSkin("GMod98")
		bstart:SetMaterial(Win98.Icon("shut_down_cool-5"))
		function bstart:DoClick()
			surface.PlaySound("win/click.wav")
			self:Remove()
			Slawer.Mayor.LookingTo = nil
			gui.EnableScreenClicker(false)
		end

		alist:AddItem(bstart)

	end

	function self.bstart:PaintOver(w,h)
		MSD.DrawTexturedRect(4, 4, 14, 14, Win98.IconPath("windows-3"), color_white)
		draw.SimpleText("Start", "Tahoma.B", 21, 1, color_black, 0, 3)
	end

	self:SetHeaderTall(70)
	self:SetHeaderText("Default")
end

function PANEL:Delete()
	self:SetAlpha(255)
	self:AlphaTo(0, 0.25, 0, function()
		self:Remove()
		Slawer.Mayor.LookingTo = nil
		gui.EnableScreenClicker(false)
	end)
end

function PANEL:Paint(intW, intH)
	Derma_DrawBackgroundBlur(self, self.startTime)

	if self.NYPD then
		surface.SetDrawColor(Win98.Cls.nypd)
		surface.DrawRect(0, 0, intW, intH)
		surface.SetMaterial(MSD.ImgLib.GetMaterial("https://i.imgur.com/r4IGT5a.png"))
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectRotated(intW * 0.5, intH * 0.5, 400, 400, 0)
	else
		surface.SetDrawColor(Win98.Cls.bg)
		surface.DrawRect(0, 0, intW, intH)
	end

	surface.SetDrawColor(Win98.Cls.gray)
	surface.DrawRect(0, intH-28, intW, 28)

	surface.SetDrawColor(Win98.Cls.white)
	surface.DrawLine(0, intH-28, intW, intH-28)
	surface.SetDrawColor(color_white)
	surface.DrawLine(0, intH-27, intW, intH-27)

	draw.SimpleText(McPhone.GetCurTime(), "Tahoma.16", intW - 11, intH-21, color_black, 2, 3)
	Win98.InnerRec(intW - 75, intH-24, 70, 20)
	-- surface.SetDrawColor(Slawer.Mayor.Colors.Black)
	-- surface.DrawRect(0, 70 - 1, intW, 1)

	-- draw.SimpleText(self:GetHeaderText(), "MSDFont.30", intW / 2, 35, color_white, 1, 1)
end

function PANEL:Think(intW, intH)
	if input.IsKeyDown(KEY_ESCAPE) then
		self:Remove()
		Slawer.Mayor.LookingTo = nil
		gui.EnableScreenClicker(false)
	end
end

function PANEL:PerformLayout(intW, intH)
	if !IsValid(self.btnClose) then return end

	self.btnClose:SetPos(intW - self.btnClose:GetWide() - 5, 5)
	self.bstart:SetPos(2, intH - 24)
	self.list:SetSize(120, intH - 44)
	self.taskbar:SetSize(intW - 160, 22)
	self.taskbar:SetPos(60, intH - 24)
end

vgui.Register("Slawer.Mayor:EditablePanel", PANEL, "EditablePanel")