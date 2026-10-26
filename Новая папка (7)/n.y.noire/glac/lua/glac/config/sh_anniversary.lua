--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/config/sh_anniversary.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- 4th anniversary gift: free item, claimable once per account on 2026-10-08 (server time)
-- by players with more than a month of playtime. 1000 credits + 50 per full week of playtime.
-- Pops up once per session on the first character select; also listed under "Другое" in the donate menu.

local KEY = "anniversary_4y"
local START = os.time({year = 2026, month = 10, day = 8, hour = 0})
local FINISH = os.time({year = 2026, month = 10, day = 9, hour = 0})
local MONTH = 2628000
local WEEK = 604800

local function Playtime(ply)
	if SERVER and sAdmin and sAdmin.getTotalPlaytime then
		return sAdmin.getTotalPlaytime(ply)
	end

	return tonumber(ply:getDarkRPVar("playtime")) or 0
end

function Glac.AnniversaryReward(ply)
	return 1000 + 50 * math.floor(Playtime(ply) / WEEK)
end

Glac.RegisterConfig("anniversary", function()
	Glac.AddItem(KEY, {
		Name = "Нам уже 4 года!",
		icon = Material("gmodla/logo_c2.png", "smooth"),
		desc = "",
		details = "Подарок в честь дня рождения проекта.",
		Category = "Other",
		Price = 0,
		check = function(ply)
			local now = os.time()

			return now >= START and now < FINISH and not MQS.GetDataStored(ply, KEY) and Playtime(ply) > MONTH
		end,
		OnPurFunction = function(ply)
			MQS.SetNWStoredData(ply, KEY, true)
			ply:AddCredits(Glac.AnniversaryReward(ply))
		end,
	})
end)

if SERVER then return end

local TITLE = "Нам уже 4 года!"
local TEXT = "Спасибо, что вы с нами всё это время! Мы безмерно благодарны вам за ваше участие в жизни проекта!\n\nВ качестве презента, мы начислили вам донат-баллов. Мы всегда рады вашему присутствию здесь!"
local gmodla2 = Material("gmodla/logo_c1.png", "smooth")

function Glac.OpenAnniversary()
	if IsValid(Glac.AnniversaryMenu) then return end

	local sw, sh = ScrW(), ScrH()
	local w = math.min(sw * 0.3, 1100)
	local logoH = 140
	local logoW = logoH * 1.91
	local body, _, bodyH = MSD.TextWrap(TEXT, "MSDFont.32", w - 80)
	surface.SetFont("MSDFont.32")
	local _, titleH = surface.GetTextSize(TITLE)
	local h = 30 + logoH + 15 + titleH + 20 + bodyH + 30 + 60 + 130

	local frame = vgui.Create("MSDSimpleFrame")
	frame:SetDraggable(false)
	frame:SetSize(sw, sh)
	frame:SetAlpha(0)
	frame:AlphaTo(255, 0.4)
	frame:MakePopup()
	Glac.AnniversaryMenu = frame

	local x, y = (sw - w) / 2, (sh - h) / 2

	frame.Paint = function(self, fw, fh)
		MSD.Blur(self, 2, 2, 255, 150, fw, fh)
		MSDX.Draw(16, x, y, w, h, MSD.Theme.d)
		MSD.DrawTexturedRect(fw / 2 - logoW / 2, y + 30, logoW, logoH, gmodla2, color_white)
		draw.DrawText(TITLE, "GmodLA.Hand", fw / 2, y + 45 + logoH, MSD.Config.MainColor.p, TEXT_ALIGN_CENTER)
		draw.DrawText(body, "MSDFont.32", fw / 2, y + 65 + logoH + titleH, color_white, TEXT_ALIGN_CENTER)
	end

	local function Close()
		frame:AlphaTo(0, 0.3, 0, function()
			frame:Remove()
		end)
	end

	local bt = MSD.Button(frame, x + 40, y + h - 90, w - 80, 60, "Забрать", function()
		Glac.Buy(KEY, 50)
		Close()
	end)
	bt:SetFont("Noire.32")
end

local shown = false

hook.Add("MCR.OnSelect", "Glac.Anniversary", function()
	if shown then return end
	shown = true

	-- Let the character menu close first
	timer.Simple(1, function()
		local item = Glac.Items[KEY]

		if item and item.check(LocalPlayer()) then
			Glac.OpenAnniversary()
		end
	end)
end)

hook.Add("Glac.Result", "Glac.Anniversary", function(res)
	if res.success ~= Glac.RESULT_ITEM or res.item ~= KEY then return end

	notification.AddLegacy("Спасибо, что вы с нами! Донат-баллы начислены", NOTIFY_GENERIC, 6)
end)
