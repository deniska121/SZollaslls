--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/client/vgui/menu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}

local tblSidebar = {}

if not Slawer.Mayor.CFG.DisabledModules["funds"] then
	table.insert(tblSidebar, {
		text = Slawer.Mayor:L("Funds"),
		icon = Win98.Icon("briefcase-2"),
		callback = function(pnl)
			Slawer.Mayor:ShowFunds(pnl)
		end,
		check = function()
			return Slawer.Mayor:HasAccess(LocalPlayer())
		end
	})

	table.insert(tblSidebar, {
		text = Slawer.Mayor:L("Licenses"),
		icon = Win98.Icon("winrep-1"),
		callback = function(pnl)
			Slawer.Mayor:ShowLicenses(pnl)
		end,
		check = function()
			return Slawer.Mayor:HasAccess(LocalPlayer())
		end
	})
end

if not Slawer.Mayor.CFG.DisabledModules["taxs"] then
	table.insert(tblSidebar, {
		text = "Сапер",
		icon = Win98.Icon("game_mine_1-0"),
		callback = function(pnl)
			Slawer.Mayor:Miner(pnl)
		end,
		check = function()
			return Slawer.Mayor:HasAccess(LocalPlayer())
		end
	})

	table.insert(tblSidebar, {
		text = "Паук",
		icon = Win98.Icon("game_spider-0"),
		callback = function(pnl)
			Slawer.Mayor:Spider(pnl)
		end,
		check = function()
			return Slawer.Mayor:HasAccess(LocalPlayer())
		end
	})
end

if not Slawer.Mayor.CFG.DisabledModules["policemen"] then
	table.insert(tblSidebar, {
		text = "NYPD P.I.S.S.",
		icon = Win98.Icon("nypd"),
		callback = function(pnl)
			Slawer.Mayor:ShowNYPD(pnl)
		end,
		check = function()
			return LocalPlayer():isCP()
		end
	})

	table.insert(tblSidebar, {
		text = "FDNY P.M.S.",
		icon = Win98.Icon("fdny"),
		callback = function(pnl)
			Slawer.Mayor:ShowFDNY(pnl)
		end,
		check = function()
			return LocalPlayer():isEMS()
		end
	})
end

if not Slawer.Mayor.CFG.DisabledModules["reports"] then
	table.insert(tblSidebar, {
		text = Slawer.Mayor:L("Reports"),
		icon = Win98.Icon("directory_open_file_mydocs_small-4"),
		callback = function(pnl)
			Slawer.Mayor:ShowReports(pnl)
		end,
		check = function()
			return Slawer.Mayor:CanAccessReports(LocalPlayer())
		end
	})
end

--if not Slawer.Mayor.CFG.DisabledModules["licenses"] then

	-- table.insert(tblSidebar, {
	-- 	text = "Оружие",
	-- 	icon = Win98.Icon("winrep_mag_glass"),
	-- 	callback = function(pnl)
	-- 		Slawer.Mayor:ShowFireArms(pnl)
	-- 	end,
	-- })

	-- table.insert(tblSidebar, {
	-- 	text = "Автотранспорт",
	-- 	icon = Win98.Icon("certificate_gear"),
	-- 	callback = function(pnl)
	-- 		Slawer.Mayor:ShowLicensesPlates(pnl)
	-- 	end,
	-- })

--end

-- if not Slawer.Mayor.CFG.DisabledModules["warrants"] then
-- 	table.insert(tblSidebar, {
-- 		text = Slawer.Mayor:L("Warrants"),
-- 		icon = Win98.Icon("homepage-0"),
-- 		callback = function(pnl)
-- 			Slawer.Mayor:ShowWarrants(pnl)
-- 		end,
-- 		check = function()
-- 			return LocalPlayer():isCP()
-- 		end,
-- 	})
-- end

-- if not Slawer.Mayor.CFG.DisabledModules["wanted"] then
-- 	table.insert(tblSidebar, {
-- 		text = Slawer.Mayor:L("Wanted"),
-- 		icon = Win98.Icon("address_book_card_users"),
-- 		callback = function(pnl)
-- 			Slawer.Mayor:ShowWanted(pnl)
-- 		end,
-- 	})
-- end

-- if not Slawer.Mayor.CFG.DisabledModules["arrested"] then
-- 	table.insert(tblSidebar, {
-- 		text = "Заключённые",
-- 		icon = Win98.Icon("keys-4"),
-- 		callback = function(pnl)
-- 			Slawer.Mayor:ShowArrested(pnl)
-- 		end,
-- 		check = function()
-- 			return LocalPlayer():isCP()
-- 		end
-- 	})
-- end

if not Slawer.Mayor.CFG.DisabledModules["news"] then
	table.insert(tblSidebar, {
		text = Slawer.Mayor:L("News"),
		icon = Win98.Icon("mailbox_world-2"),
		callback = function(pnl)
			Slawer.Mayor:ShowNews(pnl)
		end,
		check = function()
			return Slawer.Mayor:HasAccess(LocalPlayer())
		end
	})
end

table.insert(tblSidebar, {
	text = "Руководство",
	icon = Win98.Icon("help_book_cool-4"),
	callback = function(pnl)
		Slawer.Mayor:ShowCodex(pnl)
	end,
})

function PANEL:Init()
	Slawer.Mayor.IsTooLowResolution = true

	if ScrW() > 1920 then
		self:SetSize(1200, 900)
	else
		self:SetSize(800, 600)
	end

	self:Center()
	self:SetSkin("GMod98")
	self:MakePopup()
	self:SetAlpha(0)
	self:AlphaTo(255, 0.2, 0.7, function()
	end)

	self.pnlContent = vgui.Create("DPanel", self)
	self.pnlContent:SetSize(self:GetWide() - 200, self:GetTall() - 70)
	self.pnlContent:SetPos(200, 70)
	self.pnlContent.Paint = nil


	for id, tbl in pairs(tblSidebar) do
		if tbl.check and not tbl.check() then continue end
		MSD.IconButtonText(self.list, tbl.text, tbl.icon, "static", nil, 48, MSD.Text.d, MSD.Text.l, function(sl)
			surface.PlaySound("win/click.wav")

			if not self.popup then self.popup = {} end
			if not self.task then self.task = {} end

			if IsValid(self.popup[id]) then
				self.popup[id]:Close()
			end

			if IsValid(self.task[id]) then
				self.task[id]:Remove()
			end

			for k,v in pairs(self.popup) do
				if not IsValid(v) then continue end
				v:SetZPos(0)
			end

			Slawer.Mayor.pnlActive = sl
			sl.strLinked = tbl.text

			self.popup[id] = vgui.Create("DFrame", self)
			self.popup[id]:SetSize(self:GetWide(), self:GetTall() - 26)
			self.popup[id]:SetTitle(tbl.text)
			self.popup[id]:SetPos(0,0)
			self.popup[id]:SetMinWidth( 500 )
			self.popup[id]:SetMinHeight( 500 )
			self.popup[id]:SetSizable(false)
			self.popup[id]:SetDraggable(false)
			self.popup[id]:SetSkin("GMod98")
			self.popup[id]:SetZPos(1)
			self.popup[id].OnClose = function(s)
				surface.PlaySound("win/click.wav")
				if IsValid(self.task[id]) then
					self.task[id]:Remove()
				end
			end

			self.task[id] = vgui.Create("Button", self.taskbar)
			self.task[id]:SetSize(56, 22)
			self.task[id]:SetText(tbl.text)
			self.task[id]:SetSkin("GMod98")
			self.task[id].DoClick = function(s)
				for k,v in pairs(self.popup) do
					if not IsValid(v) then continue end
					v:SetZPos(0)
				end
				self.popup[id]:SetZPos(1)
			end
			self.task[id].PaintOver = function (s,w,h)
				if self.popup[id]:GetZPos() == 1 then s.Depressed = true else s.Depressed = false end
				MSD.DrawTexturedRect(4, 4, 14, 14, tbl.icon, color_white)
			end

			tbl.callback(self.popup[id], self)
		end)
	end

	self:LoadLockScreen()
end

function PANEL:Unlock()
	if IsValid(self.Lock) then
		self.Lock.sizeTo = 0
		self.Lock:SizeTo(self.Lock:GetWide(), 0, 0)
		surface.PlaySound("ambient/machines/keyboard2_clicks.wav")
		self.pnlContent:SetVisible(true)
	end

	if GetGlobalInt("Mayor_Sit") ~= 0 and LocalPlayer():Team() == 15 then
		local sit = Slawer.Situations[GetGlobalInt("Mayor_Sit")]

		if IsValid(self.situ) then
			self.situ:Remove()
		end

		if not sit then return end

		local press = CurTime() + 2

		self.situ = vgui.Create("DFrame", self)
		self.situ:SetSize(self:GetWide(), self:GetTall())
		self.situ:SetPos(0, 0)
		self.situ:SetTitle("Входящие - MessageGenie")
		self.situ:SetSkin("GMod98")
		self.situ:SetSizable(false)
		self.situ:SetDraggable(false)
		self.situ:ShowCloseButton(false)

		local dp = self:GetWide() - 4

		local rlist = vgui.Create("WINPanelList", self.situ)
		rlist:SetSize(dp, self:GetTall() - 32)
		rlist:SetPos(2, 35)
		rlist:EnableVerticalScrollbar()
		rlist:EnableHorizontal(true)
		rlist:SetSpacing(2)
		rlist.IgnoreVbar = true

		Win98.Header(rlist, sit.name, TEXT_ALIGN_CENTER, color_black, nil, "Roman.36")
		Win98.InfoTextF1(rlist, sit.text, dp, "Roman.26", color_black, Win98.Cls.gray)
		Win98.Header(rlist, "Варианты действий", TEXT_ALIGN_CENTER, color_black, nil, "Roman.30")

		for k,v in ipairs(sit.answ) do
			local btnSave = Win98.ButtonBlack(rlist, v, "Roman.24", "trust0-0", dp, 44, function()
				if press > CurTime() then return end
				net.Start("MayourAnsw")
					net.WriteUInt(k, 4)
				net.SendToServer()
				self.situ:Remove()
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			btnSave.pbg = function(s, w, h)
				surface.SetDrawColor(s.bgc)
				surface.DrawRect(0, 0, w, h)
				Win98.InnerRec(1, 1, w-2, h-2)
			end
			rlist:AddItem(btnSave)
		end
	end
end

function PANEL:LoadLockScreen()
	if IsValid(Slawer.Mayor.FakeTextEntry) then
		Slawer.Mayor.FakeTextEntry:Remove()
	end

	LocalPlayer():SetNoDraw(false)
	self.pnlContent:SetVisible(false)

	if IsValid(self.Lock) then
		self.Lock:SizeTo(self:GetWide(), self:GetTall(), 0.5)
		self.Lock.sizeTo = 400
		Slawer.Mayor.LookingTo = nil
		gui.EnableScreenClicker(false)

		return
	end

	self.Lock = vgui.Create("DPanel", self)
	self.Lock:SetSize(self:GetWide(), self:GetTall())
	self.Lock.defH = self.Lock:GetTall()
	self.Lock.sizeTo = 400
	self.Lock.size = 400
	self.Lock.bg = Slawer.Mayor.Colors.DarkGrey

	function self.Lock:Paint(intW, intH)
		if self.size ~= self.sizeTo then
			self.size = Lerp(RealFrameTime() * 3, self.size, self.sizeTo)
		end

		surface.SetDrawColor(self.bg)
		surface.DrawRect(0, 0, intW, intH)
		surface.SetMaterial(MSD.ImgLib.GetMaterial("https://i.imgur.com/r4IGT5a.png"))
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRectRotated(intW * 0.5, self.defH * 0.5, self.size, self.size, 0)
	end

	function self.Lock:OnFail()
		self.bg = Slawer.Mayor.Colors.Red
		MSD.PlaySnd("msd/ui/click.wav")

		timer.Simple(0.5, function()
			if IsValid(self) then
				self.bg = Slawer.Mayor.Colors.DarkGrey
			end
		end)
	end
end

vgui.Register("Slawer.Mayor:Menu", PANEL, "Slawer.Mayor:EditablePanel")

net.Receive("MayourAnsw", function()
	if not IsValid(Slawer.Mayor.Menu) then return end

	local text = net.ReadString()
	local con = net.ReadString()

	local situ = vgui.Create("DFrame", Slawer.Mayor.Menu)
	situ:SetSize(Slawer.Mayor.Menu:GetWide(), Slawer.Mayor.Menu:GetTall())
	situ:SetPos(0, 0)
	situ:SetTitle("Входящие - MessageGenie")
	situ:SetSkin("GMod98")
	situ:SetSizable(false)
	situ:SetDraggable(false)
	situ:ShowCloseButton(false)

	local dp = Slawer.Mayor.Menu:GetWide() - 4

	local rlist = vgui.Create("WINPanelList", situ)
	rlist:SetSize(dp, Slawer.Mayor.Menu:GetTall() - 32)
	rlist:SetPos(2, 35)
	rlist:EnableVerticalScrollbar()
	rlist:EnableHorizontal(true)
	rlist:SetSpacing(2)
	rlist.IgnoreVbar = true

	Win98.Header(rlist, "Результат", TEXT_ALIGN_CENTER, color_black, nil, "Roman.36")
	Win98.InfoTextF1(rlist, text, dp, "Roman.26", color_black, Win98.Cls.gray)
	Win98.Header(rlist, con, TEXT_ALIGN_CENTER, color_black, nil, "Roman.30")

	local btnSave = Win98.ButtonBlack(rlist, "Закрыть", "Roman.26", "trust0-0", dp, 44, function()
		situ:Remove()
	end)
	btnSave.bgc = Win98.Cls.gray
	btnSave.tc = color_black
	btnSave.htc = Win98.Text.b
	btnSave.pbg = function(s, w, h)
		surface.SetDrawColor(s.bgc)
		surface.DrawRect(0, 0, w, h)
		Win98.InnerRec(1, 1, w-2, h-2)
	end
	rlist:AddItem(btnSave)
end)