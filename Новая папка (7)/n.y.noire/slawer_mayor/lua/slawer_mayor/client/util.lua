--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/client/util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function Slawer.Mayor:WrapText(strText, strFont, intMaxSize)
	local tblWords = string.Explode(" ", strText)
	local intSize = 0

	local tblLines = {""}

	local intLine = 1
	surface.SetFont(strFont)

	for k, v in pairs(tblWords) do
		intSize = intSize + surface.GetTextSize(v .. " ")

		if intSize <= intMaxSize then
			tblLines[intLine] = tblLines[intLine] .. (k == 1 and "" or " ") .. v
		else
			intSize = 0
			intLine = intLine + 1
			tblLines[intLine] = v
		end
	end

	return tblLines
end

function Slawer.Mayor:DrawCard(x, y, w, h, title, desc)
	surface.SetDrawColor(Slawer.Mayor.Colors.DarkGrey)
	surface.DrawRect(x, y, w, h)
	draw.SimpleText(title, "MSDFont.50", x + w * 0.5, h * 0.5 - 15, color_white, 1, 1)
	draw.SimpleText(desc, "MSDFont.20", x + w * 0.5, h * 0.5 + 25, color_white, 1, 1)
end

function Slawer.Mayor:DrawBigCard(x, y, w, h, title, desc)
	surface.SetDrawColor(Slawer.Mayor.Colors.DarkGrey)
	surface.DrawRect(x, y, w, h)
	draw.SimpleText(title, "MSDFont.50", x + w * 0.5, y + h * 0.5 - 40, color_white, 1, 1)
	draw.SimpleText(desc, "MSDFont.50", x + w * 0.5, y + h * 0.5 + 60, Slawer.Mayor.Colors.LightGrey, 1, 1)
end

function Slawer.Mayor:RefreshPanel(strPanel)
	if IsValid(Slawer.Mayor.Menu) and IsValid(Slawer.Mayor.pnlActive) and Slawer.Mayor.pnlActive.strLinked == Slawer.Mayor:L(strPanel) then
		Slawer.Mayor.pnlActive:DoClick()
	end
end

function Slawer.Mayor:updatePanel(strPanel)
	if IsValid(Slawer.Mayor.UPD) and Slawer.Mayor.UPD[strPanel] then
		Slawer.Mayor.UPD[strPanel]()
	end
end

function Slawer.Mayor:CanUseComp(ent)
	return LocalPlayer():EyePos():DistToSqr(ent:GetPos() + ent:GetForward() * 30) < 1350
end

if not Slawer.Mayor.CFG.DisabledModules["funds"] then
	function Slawer.Mayor:ShowSafeMenu(ent)
		if IsValid(Slawer.Mayor.SafeMenu) then
			Slawer.Mayor.SafeMenu:Remove()
		end

		local Base = vgui.Create("MSDSimpleFrame")
		Base:SetSize(500, 350)
		Base:Center()
		Base:MakePopup()
		Base:SetDraggable(false)


		function Base:Paint(w, h)
			Derma_DrawBackgroundBlur(self, self.startTime)
			MSD.Blur(self, 5, 5, 255, 50, w, h)
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
			draw.DrawText("Районный сейф", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
			draw.DrawText("Капитал района: $" .. string.Comma(math.Round(Slawer.Mayor:GetFunds())), "MSDFont.28", 12, 55, color_white, TEXT_ALIGN_LEFT)
			draw.DrawText("Локальный бюджет: $" .. string.Comma(math.Round(math.max(Slawer.Mayor:GetFunds() - 5000, 0))), "MSDFont.26", 12, 95, color_white, TEXT_ALIGN_LEFT)
		end

		Base.clsBut = MSD.IconButton(Base, MSD.Icons48.cross, Base:GetWide() - 38, 5, 32, nil, nil, function()
			Base:Close()
		end)

		local amount = nil

		MSD.TextEntry(Base, 10, 130, 480, 50, "Введите сумму..", "Сумма", amount, function(s, value)
			amount = tonumber(value) or 0
		end, true, nil, nil, true)

		MSD.Button(Base, 10, 185, 480, 50, "Внести средства", function()
			Slawer.Mayor:NetStart("WithdrawSafe", {
				ent = ent:EntIndex(),
				amount = amount or 0,
				deposit = true
			})
			Base:Close()
		end)

		MSD.Button(Base, 10, 240, 480, 50, "Забрать средства", function()
			Slawer.Mayor:NetStart("WithdrawSafe", {
				ent = ent:EntIndex(),
				amount = amount or 0,
			})
			Base:Close()
		end)

		MSD.Button(Base, 10, 295, 480, 50, "Закрыть сейф", function()
			Slawer.Mayor:NetStart("CloseSafe", {
				ent = ent:EntIndex()
			})
			Base:Close()
		end)

		Slawer.Mayor.SafeMenu = Base
	end

	Slawer.Mayor:NetReceive("OpenSafeMenu", function(tbl)
		Slawer.Mayor:ShowSafeMenu(Entity(tbl.ent))
	end)
end

Slawer.Mayor:NetReceive("AllReset", function()
	Slawer.Mayor.Upgrades = {}

	for intID, _ in pairs(Slawer.Mayor.JobTaxs) do
		Slawer.Mayor.JobTaxs[intID] = 5
	end
end)

surface.CreateFont("InfoRUS2", {
	font = "Enhanced Dot Digital-7",
	extended = true,
	size = 90,
	weight = 800,
	antialias = true
})

surface.CreateFont("InfoRUS3", {
	font = "Enhanced Dot Digital-7",
	extended = true,
	size = 50,
	weight = 800,
	antialias = true
})

surface.CreateFont("InfoRUS4", {
	font = "Enhanced Dot Digital-7",
	extended = true,
	size = 32,
	weight = 800,
	antialias = true
})

surface.CreateFont("InfoRUS5", {
	font = "Enhanced Dot Digital-7",
	extended = true,
	size = 22,
	weight = 800,
	antialias = true
})