--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_elections/lua/slawer_elections/client/vgui/registration.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}

function PANEL:Init()
	local iW, iH = ScrW() * 0.5, ScrH() * 0.8
	self:SetSize(iW, iH)
	self:Center()
	self:MakePopup()

	self.clsBut = MSD.IconButton(self, MSD.Icons48.cross, self:GetWide() - 38, 5, 32, nil, nil, function()
		self:Close()
	end)

	self.plist = vgui.Create("MSDPanelList", self)
	self.plist:SetSize(iW - 10, iH - 70)
	self.plist:SetPos(5, 70)
	self.plist:EnableVerticalScrollbar()
	self.plist:EnableHorizontal(true)
	self.plist:SetSpacing(2)
	self.plist.sliderColor = Color(252, 81, 1, 70)
	self.plist.IgnoreVbar = true

	local mainansw = {}
	local subansw = {}
	local getRnd

	function getRnd()
		local rnd = math.random(#Slawer.Elections.OtherQuestions)

		if subansw[rnd] then return getRnd() end
		return rnd
	end

	for i = 1,3 do
		local get = getRnd()
		subansw[get] = true
	end

	for id,test in ipairs(Slawer.Elections.MainQuestions) do
		mainansw[id] = false
		MSD.InfoTextF1(self.plist, "\n" .. test.q, iW - 10, "MSDFont.26")

		local c = MSD.ComboBox(self.plist, "static", nil, 1, 30, "", "Ваш ответ")
		for a, b in ipairs(test.a) do
			c:AddChoice(b[1], a)
		end
		c.OnSelect = function (_,_,_,dd)
			mainansw[id] = dd
		end
	end

	for id,test in ipairs(Slawer.Elections.OtherQuestions) do
		if not subansw[id] then continue end
		subansw[id] = false

		MSD.InfoTextF1(self.plist, "\n" .. test.q, iW - 10, "MSDFont.26")

		local c = MSD.ComboBox(self.plist, "static", nil, 1, 30, "", "Ваш ответ")
		for a, b in ipairs(test.a) do
			c:AddChoice(b[1], a)
		end
		c.OnSelect = function (_,_,_,dd)
			subansw[id] = dd
		end
	end

	MSD.InfoText(self.plist, "")
	MSD.InfoText(self.plist, "Пошлина за регистрацию: $" .. Slawer.Elections.PriceToRegister)

	MSD.Button(self.plist, "static", nil, 1, 55, "Отправить заявку", function()
		for _, a in pairs(mainansw) do
			if not a then return end
		end

		for _, a in pairs(subansw) do
			if not a then return end
		end

		Slawer.Elections:NetStart("register", {
			mainansw = mainansw,
			subansw = subansw
		})
		self:Close()
	end)
end

function PANEL:Paint(w, h)
	Derma_DrawBackgroundBlur(self, self.startTime)
	MSD.Blur(self, 5, 5, 255, 50, w, h)
	MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
	draw.DrawText("Регистрация", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
end

function PANEL:Think()
	if GetGlobalInt("Slawer.Elections:CurrentState") > 1 then return self:Remove() end
end

vgui.Register("Slawer.Elections:Registration", PANEL, "MSDSimpleFrame")