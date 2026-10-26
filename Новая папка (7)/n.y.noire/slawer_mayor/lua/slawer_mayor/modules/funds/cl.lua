--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/funds/cl.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local clrs = {
	Color(12,10,122),
	Color(38,4,66),
	Color(17,0,255),
	Color(255,0,0),
	Color(255,217,0)
}

local TaxtDesc = {
	gov = "Государственные служащие",
	citizens = "Гражданские",
	shops = "Магазины",
}

local grades = {}
grades["Полицейские бронежилеты"] = {
	name = "Органы порядка",
	icon = "address_book_user",
	id = 1
}
grades["Оптимизация логистики"] = {
	name = "Логистика",
	icon = "netmeeting-1",
	id = 2
}
grades["Влияние (мэрия)"] = {
	name = "Влияние (мэрия)",
	icon = "modem-1",
	id = 3
}
grades["Налоги"] = {
	name = "Налоги",
	icon = "overlay_share_cool-2",
	id = 4
}
grades["Влияние (район)"] = {
	name = "Влияние (район)",
	icon = "users-0",
	id = 5
}
grades["Локализация бюджета"] = {
	name = "Локализация",
	icon = "key_padlock-1",
	id = 6
}
grades["Программа спонсирования"] = {
	name = "Спонсирование",
	icon = "registration-0",
	id = 7
}
grades["Программа трудоустройства"] = {
	name = "Трудоустройство",
	icon = "user_card",
	id = 8
}
grades["Программа субсидирования"] = {
	name = "Субсидирование",
	icon = "outlook_express_tack-0",
	id = 9
}
grades["Обучение специалистов"] = {
	name = "Обучение",
	icon = "help_book_cool_small-1",
	id = 10
}

function Slawer.Mayor:ShowFunds(pnlContent)
	local main = vgui.Create("WINPanelList", pnlContent)
	main:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 35)
	main:SetPos(2, 30)
	function main:Paint(w,h)
		MSDX.Draw(0,0,0,w,h,clrs[1])
		MSDX.Draw(0,0,0,w,55,color_black)
		MSDX.Draw(0,0,0,200,h,color_black)
		MSD.DrawTexturedRect(50, 3, 48, 48, Win98.Icon("briefcase-4"), color_white)
		draw.SimpleText("Капитальный учёт", "Roman.38", 130, 25, color_white, TEXT_ALIGN_LEFT, 1)
	end

	local smenu = vgui.Create("WINPanelList", pnlContent)
	smenu:SetSize(200, pnlContent:GetTall() - 100)
	smenu:SetPos(2, 95)
	smenu:EnableVerticalScrollbar()
	smenu:EnableHorizontal(true)
	smenu:SetSpacing(2)
	smenu.IgnoreVbar = false

	local scroll = vgui.Create("WINPanelList", pnlContent)
	scroll:SetSize(pnlContent:GetWide() - 204, pnlContent:GetTall() - 100)
	scroll:SetPos(202, 95)
	scroll:EnableVerticalScrollbar()
	scroll:EnableHorizontal(true)
	scroll:SetSpacing(2)
	scroll.IgnoreVbar = false

	local buts = {
		{
			name = "Капитал",
			icon = "chart1-2",
			func = function()
				scroll:Clear()
				Win98.Header(scroll, Slawer.Mayor:L("CityFunds")  ..  ": $" .. string.Comma(math.Round(Slawer.Mayor:GetFunds())), TEXT_ALIGN_LEFT, color_white, 45)
				Win98.Header(scroll, "Лимит бюджета: $" .. string.Comma(Slawer.Mayor:GetMaxFunds()), TEXT_ALIGN_LEFT, color_white, 40, "Roman.22")
				Win98.Header(scroll, "Пополнение бюджета через налоговый сбор:", TEXT_ALIGN_LEFT, color_white, 40, "Roman.22")

				local tblTaxs = table.Copy(Slawer.Mayor.JobTaxs)

				for intID, tblJob in pairs(Slawer.Mayor.JobTaxs) do
					if Slawer.Mayor.CFG.TaxesBlacklist[intID] then continue end
					local pnl = vgui.Create("DPanel")
					pnl:SetSize(scroll:GetWide() - 10, 64)

					function pnl:Paint(intW, intH)
						surface.SetDrawColor(clrs[2])
						surface.DrawRect(0, 0, intW, intH)

						draw.SimpleText(TaxtDesc[intID], "Roman.30", 10, intH * 0.5, color_white, 0, TEXT_ALIGN_CENTER)
						draw.SimpleText("%", "Roman.30", intW - 20, intH * 0.5, color_white, 2, TEXT_ALIGN_CENTER)
					end

					local maxtax = (Slawer.Mayor.CFG.MaxTax + Slawer.Mayor:GetUpgradeLevel(4) * 2) or 100

					MSD.NumberWang(pnl, pnl:GetWide() - 100, pnl:GetTall() / 2 - 20, 50, 40, 0, maxtax, Slawer.Mayor.JobTaxs[intID] or 0, "", function(s, txt)
						tblTaxs[intID] = math.Clamp(tonumber(txt) or 0, 0, maxtax or 100)
					end)

					scroll:AddItem(pnl)
				end

				local pnl = vgui.Create("DPanel")
				pnl:SetSize(scroll:GetWide() - 10, 64)
				function pnl:Paint(intW, intH)
					surface.SetDrawColor(clrs[2])
					surface.DrawRect(0, 0, intW, intH)
				end
				scroll:AddItem(pnl)

				local btnSave = Win98.ButtonBlack(pnl, "Отправить запрос", "Roman.38", "outlook_express-4", scroll:GetWide() - 30, 44, function()
					Slawer.Mayor:NetStart("UpdateTaxs", tblTaxs)
				end)
				btnSave:SetPos(10, 10)

			end
		},
	}

	for k,v in ipairs(Slawer.Mayor.CFG.Upgrades) do
		if not grades[v.Name] then return end
		table.insert(buts, {
			name = grades[v.Name].name,
			icon = grades[v.Name].icon,
			func = function()
				scroll:Clear()
				Win98.Header(scroll, v.Name, TEXT_ALIGN_LEFT, color_white)
				Win98.InfoTextF1(scroll, v.Description, scroll:GetWide() - 20, "Roman.22")

				if v.Check and not v.Check(LocalPlayer(), v, k) then
					Win98.InfoTextF1(scroll, v.CheckMsg, scroll:GetWide() - 20, "Roman.24", clrs[4], color_black)
					return
				end

				if Slawer.Mayor:GetUpgradeLevel(k) >= Slawer.Mayor:GetUpgradeMaxLevel(k) then
					Win98.InfoTextF1(scroll, "Достигнут предел вложений", scroll:GetWide() - 20, "Roman.24", clrs[5], color_black)
					return
				end

				local pnl = vgui.Create("DPanel")
				pnl:SetSize(scroll:GetWide() - 10, 64)
				function pnl:Paint(intW, intH)
					surface.SetDrawColor(clrs[2])
					surface.DrawRect(0, 0, intW, intH)
				end
				scroll:AddItem(pnl)

				local btnSave = Win98.ButtonBlack(pnl, "Вложить $" .. string.Comma(v.Levels[Slawer.Mayor:GetUpgradeLevel(k) + 1].Price), "Roman.38", "briefcase-4", scroll:GetWide() - 30, 44, function()
					Slawer.Mayor:NetStart("Upgrade", {
						id = k
					})
				end)
				btnSave:SetPos(10, 10)

			end
		})
	end

	for k,v in ipairs(buts) do
		local btn = vgui.Create("DButton", pnl)
		btn:SetSize(200, 35)
		btn:SetText("")

		function btn:Paint(w,h)
			MSD.DrawTexturedRect(18, 7, 18, 18, Win98.Icon(v.icon), color_white)
			draw.SimpleText(v.name, "Roman.18", 50, h / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end

		function btn:DoClick()
			surface.PlaySound("win/click.wav")
			if v.func then
				v.func()
			end
		end

		smenu:AddItem(btn)
	end

	buts[1].func()
end

Slawer.Mayor:NetReceive("SyncUpgrades", function(tbl)
	Slawer.Mayor.Upgrades = tbl
	Slawer.Mayor:RefreshPanel("Funds")
end)