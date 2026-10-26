--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/licenses/cl.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


local buslic, crrlic, lawlic, gunlic

function Slawer.Mayor:ShowLicenses(pnlContent)
	local main = vgui.Create("WINPanelList", pnlContent)
	main:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 35)
	main:SetPos(2, 30)
	function main:Paint(w,h)
		MSDX.Draw(0,0,0,w,h,color_white)
		MSD.DrawTexturedRect(0,0,w,h, Win98.Icon("bg2"), color_white)
	end

	local scroll = vgui.Create("WINPanelList", pnlContent)
	scroll:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 30)
	scroll:SetPos(2, 30)
	scroll:EnableVerticalScrollbar()
	scroll:EnableHorizontal(true)
	scroll:SetSpacing(5)
	scroll:SetPadding(5)
	scroll.IgnoreVbar = true

	scroll.page = {}
	Slawer.Mayor.UPD = scroll

	local stabs = {
		{
			text = "Лицензия на бизнес",
			icon = "certificate_seal",
			callback = function()
				scroll.page["business"]()
			end,
		},
		{
			text = "Разрешение на ношение",
			icon = "certificate-0",
			callback = function()
				scroll.page["carry"]()
			end,
		},
		{
			text = "Временное удостоверение правового советника",
			icon = "certificate_2-0",
			callback = function()
				scroll.page["law"]()
			end,
		},
		{
			text = "Печать повторной лицензии на оружие",
			icon = "certificate_excl-1",
			callback = function()
				scroll.page["gun"]()
			end,
		},
	}

	scroll.page["main"] = function()
		scroll:Clear()
		Win98.Header(scroll, "Оформление лицензии", TEXT_ALIGN_CENTER, color_black, nil, "Roman.42")

		for k,v in ipairs(stabs) do
			local btnSave = Win98.ButtonBlack(scroll, v.text, "Roman.38", v.icon, scroll:GetWide() - 10, 60, function()
				scroll:Clear()
				v.callback()
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			btnSave.pbg = function(s, w, h)
				surface.SetDrawColor(s.bgc)
				surface.DrawRect(0, 0, w, h)
				Win98.InnerRec(1, 1, w-2, h-2)
			end
			scroll:AddItem(btnSave)
		end
	end

	scroll.page["business"] = function()
		scroll:Clear()
		Win98.Header(scroll, "Оформление лицензии на бизнес", TEXT_ALIGN_CENTER, color_black, nil, "Roman.42")

		if not buslic then
			Win98.InfoText(scroll, "Для оформления лицензии на бизнес укажите данные лицензиата. Данные лицензиата можно найти по номеру паспорта в базе данных N.L.R.", "Roman.21")

			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, "", function() end, false, nil, false, true, color_black, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.gray)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Поиск по ID паспорта", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск", "Roman.38", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "business", passid = tostring(Entry:GetValue())})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
			return
		end

		if buslic.searching and buslic.searching + buslic.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(buslic.seardelay, "InSine")
			ld:Start()
			ld.S = buslic.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				scroll.page["business"]()
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(Win98.Cls.gray)
				surface.DrawRect(0, 0, w, h)
				Win98.InnerRec(1, 1, w-2, h-2)

				surface.SetDrawColor(Win98.Text.b)
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				if buslic.printed then
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("file_lines-0"), MSD.ColorAlpha(color_white, 255 - 255 * ja.Value))
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("printer-0"), color_white)
				else
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
					MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
					MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				end

				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if buslic.printed then
			Win98.InfoText(scroll, "Готово!", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Готово", "Roman.38", "trust0-0", scroll:GetWide() - 10, 55, function()
				buslic = nil
				scroll.page["business"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		if buslic and not buslic.userid then
			Win98.InfoText(scroll, "Ничего не найдено", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Отменить запрос", "Roman.38", "certificate_no-1", scroll:GetWide() - 10, 55, function()
				buslic = nil
				scroll.page["business"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		Win98.InfoText(scroll, "Лицензиат:", "Roman.34")

		Win98.InfoTextF1(scroll, buslic.name .. " " .. buslic.sname , scroll:GetWide() - 10, "Roman.32", color_black)
		Win98.InfoTextF1(scroll, "Дата рождения: " .. buslic.date .. "   ID паспорта: " .. buslic.passid .. " " .. buslic.idtype, scroll:GetWide() - 10, "Roman.22", color_black)

		Win98.InfoText(scroll, "Разрешения:", "Roman.34")

		if buslic.medcom then
			Win98.InfoText(scroll, "Получено разрешение от санитарного надзора", "Roman.21")
		else
			Win98.InfoText(scroll, "Нет разрешения от санитарного надзора", "Roman.21")
			local btnSave = Win98.ButtonBlack(scroll, "Получить разрешение (Пошлина 10$)", "Roman.21", "certificate_checklist-1", scroll:GetWide() - 10, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "business", medcom = true, passid = buslic.passid})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
		end

		if buslic.registr then
			Win98.InfoText(scroll, "Бизнес зарегистрирован", "Roman.21")
		else
			local btnSave = Win98.ButtonBlack(scroll, "Локальная регистрация бизнеса (Пошлина 15$)", "Roman.21", "certificate_checklist-1", scroll:GetWide() - 10, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "business", registr = true, passid = buslic.passid})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
		end

		Win98.InfoText(scroll, "Действия:", "Roman.34")

		if buslic.registr and buslic.medcom then
			local btnSave = Win98.ButtonBlack(scroll, "Печать документа", "Roman.21", "printer-0", scroll:GetWide() - 10, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "business", print = true, passid = buslic.passid})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
		end

		local btnSave = Win98.ButtonBlack(scroll, "Отменить", "Roman.21", "msg_error-0", scroll:GetWide() - 10, 45, function()
			buslic = nil
			scroll.page["business"]()
		end)
		btnSave.bgc = Win98.Cls.gray
		btnSave.tc = color_black
		btnSave.htc = Win98.Text.b
		scroll:AddItem(btnSave)
	end
	scroll["business"] = scroll.page["business"]

	scroll.page["carry"] = function()
		scroll:Clear()
		Win98.Header(scroll, "Оформление разрешение на ношение оружия", TEXT_ALIGN_CENTER, color_black, nil, "Roman.42")

		if not crrlic then
			Win98.InfoText(scroll, "Для оформления разрешения на ношение оружия укажите данные лицензиата. Данные лицензиата можно найти по номеру паспорта в базе данных N.L.R.", "Roman.21")

			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, "", function() end, false, nil, false, true, color_black, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.gray)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Поиск по ID паспорта", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск", "Roman.38", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "carry", passid = tostring(Entry:GetValue())})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
			return
		end

		if crrlic.searching and crrlic.searching + crrlic.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(crrlic.seardelay, "InSine")
			ld:Start()
			ld.S = crrlic.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				scroll.page["carry"]()
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(Win98.Cls.gray)
				surface.DrawRect(0, 0, w, h)
				Win98.InnerRec(1, 1, w-2, h-2)

				surface.SetDrawColor(Win98.Text.b)
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				if crrlic.printed then
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("file_lines-0"), MSD.ColorAlpha(color_white, 255 - 255 * ja.Value))
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("printer-0"), color_white)
				else
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
					MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
					MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				end

				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if crrlic.printed then
			Win98.InfoText(scroll, "Готово!", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Готово", "Roman.38", "trust0-0", scroll:GetWide() - 10, 55, function()
				crrlic = nil
				scroll.page["carry"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		if crrlic and not crrlic.userid then
			Win98.InfoText(scroll, "Ничего не найдено", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Отменить запрос", "Roman.38", "certificate_no-1", scroll:GetWide() - 10, 55, function()
				crrlic = nil
				scroll.page["carry"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		Win98.InfoText(scroll, "Лицензиат:", "Roman.34")

		Win98.InfoTextF1(scroll, crrlic.name .. " " .. crrlic.sname , scroll:GetWide() - 10, "Roman.32", color_black)
		Win98.InfoTextF1(scroll, "Дата рождения: " .. crrlic.date .. "   ID паспорта: " .. crrlic.passid .. " " .. crrlic.idtype, scroll:GetWide() - 10, "Roman.22", color_black)

		Win98.InfoText(scroll, "Разрешения:", "Roman.34")

		if crrlic.medcom then
			Win98.InfoText(scroll, "Получено разрешение от санитарного надзора", "Roman.21")
		else
			Win98.InfoText(scroll, "Нет разрешения от санитарного надзора!", "Roman.21")
			local btnSave = Win98.ButtonBlack(scroll, "Получить разрешение от санитарного надзора (Пошлина 10$)", "Roman.21", "certificate_checklist-1", scroll:GetWide() - 10, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "carry", medcom = true, passid = crrlic.passid})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
		end

		if crrlic.registr then
			Win98.InfoText(scroll, "Федеральных ограничений нет", "Roman.21")
		else
			if not crrlic.nofed then
				local btnSave = Win98.ButtonBlack(scroll, "Проверка федеральных ограничений (Пошлина 35$)", "Roman.21", "certificate_checklist-1", scroll:GetWide() - 10, 45, function()
					Slawer.Mayor:NetStart("LicenseProcess", {type = "carry", registr = true, passid = crrlic.passid})
				end)
				btnSave.bgc = Win98.Cls.gray
				btnSave.tc = color_black
				btnSave.htc = Win98.Text.b
				scroll:AddItem(btnSave)
			else
				Win98.InfoText(scroll, "Есть федеральный запрет!", "Roman.21")
			end
		end

		Win98.InfoText(scroll, "Действия:", "Roman.34")

		if crrlic.registr and crrlic.medcom then
			local btnSave = Win98.ButtonBlack(scroll, "Печать документа", "Roman.21", "printer-0", scroll:GetWide() - 10, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "carry", print = true, passid = crrlic.passid})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
		end

		local btnSave = Win98.ButtonBlack(scroll, "Отменить", "Roman.21", "msg_error-0", scroll:GetWide() - 10, 45, function()
			crrlic = nil
			scroll.page["carry"]()
		end)
		btnSave.bgc = Win98.Cls.gray
		btnSave.tc = color_black
		btnSave.htc = Win98.Text.b
		scroll:AddItem(btnSave)
	end
	scroll["carry"] = scroll.page["carry"]

	scroll.page["law"] = function()
		scroll:Clear()
		Win98.Header(scroll, "Временное удостоверение правового советника", TEXT_ALIGN_CENTER, color_black, nil, "Roman.42")

		if not lawlic then
			Win98.InfoText(scroll, "Для оформления временного удостоверения правового советника укажите данные лицензиата. Данные лицензиата можно найти по номеру паспорта в базе данных N.L.R.", "Roman.21")

			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, "", function() end, false, nil, false, true, color_black, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.gray)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Поиск по ID паспорта", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск", "Roman.38", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "law", passid = tostring(Entry:GetValue())})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
			return
		end

		if lawlic.searching and lawlic.searching + lawlic.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(lawlic.seardelay, "InSine")
			ld:Start()
			ld.S = lawlic.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				scroll.page["law"]()
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(Win98.Cls.gray)
				surface.DrawRect(0, 0, w, h)
				Win98.InnerRec(1, 1, w-2, h-2)

				surface.SetDrawColor(Win98.Text.b)
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				if lawlic.printed then
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("file_lines-0"), MSD.ColorAlpha(color_white, 255 - 255 * ja.Value))
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("printer-0"), color_white)
				else
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
					MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
					MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				end

				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if lawlic.printed then
			Win98.InfoText(scroll, "Готово!", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Готово", "Roman.38", "trust0-0", scroll:GetWide() - 10, 55, function()
				lawlic = nil
				scroll.page["law"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		if lawlic and not lawlic.userid then
			Win98.InfoText(scroll, "Ничего не найдено", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Отменить запрос", "Roman.38", "certificate_no-1", scroll:GetWide() - 10, 55, function()
				lawlic = nil
				scroll.page["law"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		Win98.InfoText(scroll, "Лицензиат:", "Roman.34")

		Win98.InfoTextF1(scroll, lawlic.name .. " " .. lawlic.sname , scroll:GetWide() - 10, "Roman.32", color_black)
		Win98.InfoTextF1(scroll, "Дата рождения: " .. lawlic.date .. "   ID паспорта: " .. lawlic.passid .. " " .. lawlic.idtype, scroll:GetWide() - 10, "Roman.22", color_black)

		Win98.InfoText(scroll, "Разрешения:", "Roman.34")

		if lawlic.medcom then
			Win98.InfoText(scroll, "Получено разрешение от адвокатской палаты", "Roman.21")
		else
			Win98.InfoText(scroll, "Нет разрешения от адвокатской палаты!", "Roman.21")
			if not lawlic.nomed then
				local btnSave = Win98.ButtonBlack(scroll, "Получить разрешение от адвокатской палаты (Пошлина 100$)", "Roman.21", "certificate_checklist-1", scroll:GetWide() - 10, 45, function()
					Slawer.Mayor:NetStart("LicenseProcess", {type = "law", medcom = true, passid = lawlic.passid})
				end)
				btnSave.bgc = Win98.Cls.gray
				btnSave.tc = color_black
				btnSave.htc = Win98.Text.b
				scroll:AddItem(btnSave)
			else
				Win98.InfoText(scroll, "Есть запрет от адвокатской палаты!", "Roman.21")
			end
		end

		if lawlic.registr then
			Win98.InfoText(scroll, "Федеральных ограничений нет", "Roman.21")
		else
			if not lawlic.nofed then
				local btnSave = Win98.ButtonBlack(scroll, "Проверка федеральных ограничений (Пошлина 35$)", "Roman.21", "certificate_checklist-1", scroll:GetWide() - 10, 45, function()
					Slawer.Mayor:NetStart("LicenseProcess", {type = "law", registr = true, passid = lawlic.passid})
				end)
				btnSave.bgc = Win98.Cls.gray
				btnSave.tc = color_black
				btnSave.htc = Win98.Text.b
				scroll:AddItem(btnSave)
			else
				Win98.InfoText(scroll, "Есть федеральный запрет!", "Roman.21")
			end
		end

		Win98.InfoText(scroll, "Действия:", "Roman.34")

		if lawlic.registr and lawlic.medcom then
			local btnSave = Win98.ButtonBlack(scroll, "Печать документа", "Roman.21", "printer-0", scroll:GetWide() - 10, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "law", print = true, passid = lawlic.passid})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
		end

		local btnSave = Win98.ButtonBlack(scroll, "Отменить", "Roman.21", "msg_error-0", scroll:GetWide() - 10, 45, function()
			lawlic = nil
			scroll.page["law"]()
		end)
		btnSave.bgc = Win98.Cls.gray
		btnSave.tc = color_black
		btnSave.htc = Win98.Text.b
		scroll:AddItem(btnSave)
	end
	scroll["law"] = scroll.page["law"]

	scroll.page["gun"] = function()
		scroll:Clear()
		Win98.Header(scroll, "Повторная лицензия на оружие", TEXT_ALIGN_CENTER, color_black, nil, "Roman.42")

		if not gunlic then
			Win98.InfoText(scroll, "Для печати повторной лицензии на оружие укажите серийный номер оружия. Если оружие было ранее зарегистрировано в базе данных, вы сможете распечатать повторую лицензию.", "Roman.21")

			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, "", function() end, false, nil, false, true, color_black, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.gray)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Поиск по серийному номеру", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск", "Roman.38", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("LicenseProcess", {type = "gun", passid = tostring(Entry:GetValue())})
			end)
			btnSave.bgc = Win98.Cls.gray
			btnSave.tc = color_black
			btnSave.htc = Win98.Text.b
			scroll:AddItem(btnSave)
			return
		end

		if gunlic.searching and gunlic.searching + gunlic.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(gunlic.seardelay, "InSine")
			ld:Start()
			ld.S = gunlic.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				scroll.page["gun"]()
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(Win98.Cls.gray)
				surface.DrawRect(0, 0, w, h)
				Win98.InnerRec(1, 1, w-2, h-2)

				surface.SetDrawColor(Win98.Text.b)
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				if gunlic.printed then
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("file_lines-0"), MSD.ColorAlpha(color_white, 255 - 255 * ja.Value))
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("printer-0"), color_white)
				else
					MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)
					MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
					MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
					MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				end

				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if gunlic.printed then
			Win98.InfoText(scroll, "Готово!", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Готово", "Roman.38", "trust0-0", scroll:GetWide() - 10, 55, function()
				gunlic = nil
				scroll.page["gun"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		if gunlic and (not gunlic.userid or not gunlic.passid or not gunlic.gun or not gunlic.gun.name) then
			Win98.InfoText(scroll, "Ничего не найдено", "Roman.21")
			local btnSave2 = Win98.ButtonBlack(scroll, "Отменить запрос", "Roman.38", "certificate_no-1", scroll:GetWide() - 10, 55, function()
				gunlic = nil
				scroll.page["gun"]()
			end)
			scroll:AddItem(btnSave2)
			return
		end

		Win98.InfoText(scroll, "Данные:", "Roman.34")

		Win98.InfoTextF1(scroll, gunlic.name .. " " .. gunlic.sname , scroll:GetWide() - 10, "Roman.32", color_black)
		Win98.InfoTextF1(scroll, gunlic.gun.name, scroll:GetWide() - 10, "Roman.32", color_black)
		Win98.InfoTextF1(scroll, gunlic.passid, scroll:GetWide() - 10, "Roman.32", color_black)

		Win98.InfoText(scroll, "Действия:", "Roman.34")

		local btnSave2 = Win98.ButtonBlack(scroll, "Печать документа", "Roman.21", "printer-0", scroll:GetWide() - 10, 45, function()
			Slawer.Mayor:NetStart("LicenseProcess", {type = "gun", print = true, passid = gunlic.passid})
		end)
		btnSave2.bgc = Win98.Cls.gray
		btnSave2.tc = color_black
		btnSave2.htc = Win98.Text.b
		scroll:AddItem(btnSave2)

		local btnSave = Win98.ButtonBlack(scroll, "Отменить", "Roman.21", "msg_error-0", scroll:GetWide() - 10, 45, function()
			gunlic = nil
			scroll.page["gun"]()
		end)
		btnSave.bgc = Win98.Cls.gray
		btnSave.tc = color_black
		btnSave.htc = Win98.Text.b
		scroll:AddItem(btnSave)
	end
	scroll["gun"] = scroll.page["gun"]

	scroll.page["main"]()
end

Slawer.Mayor:NetReceive("LicenseProcess", function(tbl)
	if tbl.type == "business" then
		buslic = tbl
		Slawer.Mayor:updatePanel("business")
	end

	if tbl.type == "carry" then
		crrlic = tbl
		Slawer.Mayor:updatePanel("carry")
	end

	if tbl.type == "law" then
		lawlic = tbl
		Slawer.Mayor:updatePanel("law")
	end

	if tbl.type == "gun" then
		gunlic = tbl
		Slawer.Mayor:updatePanel("gun")
	end
end)