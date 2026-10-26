--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/policemen/cl.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local clrs = {
	Color(27,39,150),
	Color(38,4,66),
	Color(17,0,255),
	Color(255,0,0),
	Color(255,217,0),
	Color(83,0,0)
}

local tabs = {
		{
			text = "Оружие",
			icon = "winrep-1",
			callback = function(pnl)
				pnl.pages["weapons"]()
			end,
		},
		{
			text = "Автотранспорт",
			icon = "certificate_gear",
			callback = function(pnl)
				pnl.pages["cars"]()
			end,
		},
		{
			text = "Штрафы",
			icon = "registration-0",
			callback = function(pnl)
				pnl.pages["fines"]()
			end,
		},
		{
			text = "Задержанные",
			icon = "keys-4",
			callback = function(pnl)
				Slawer.Mayor:NetStart("GetJail")
			end,
		},
		{
			text = "Дела судмедэкспертизы",
			icon = "address_book_card_users",
			callback = function(pnl)
				Slawer.Mayor:NetStart("GetDeathLOG")
			end,
		},
		{
			text = "Сотрудники",
			icon = "users-2",
			callback = function(pnl)
				Slawer.Mayor:ShowPolicemen(Slawer.Mayor.UPD)
			end,
		},
		{
			text = "Розыск",
			icon = "msagent-4",
			callback = function(pnl)
				Slawer.Mayor:ShowWanted(Slawer.Mayor.UPD)
			end,
		},
		{
			text = "Запрос ордера на обыск недвижимости",
			icon = "address_book_home",
			callback = function(pnl)
				Slawer.Mayor:ShowWarrants(Slawer.Mayor.UPD)
			end,
		},
	}

local timetables = {
	"1 час",
	"1 день",
	"3 дня",
	"1 неделя",
	"2 недели",
	"1 месяц",
	"Уволить",
}

local cats = {
	{"Незначительные правонарушения", 1, 5},
	{"Преступления лёгкого характера", 6, 11},
	{"Преступления средней тяжести", 12, 26},
	{"Тяжкие преступления", 27, 38},
	{"Особо тяжкие преступления", 39, 48},
	{"Покушения", 49, 56}
}

function Slawer.Mayor:ShowPolicemen(scroll)
	scroll:Clear()

	local lgroup = MRS.GetNWdata(LocalPlayer(), "Group")
	local lrank = MRS.GetNWdata(LocalPlayer(), "Rank")
	local shift = {}

	local function update()
		timer.Simple(0.5, function()
			if not IsValid(scroll) then return end
			Slawer.Mayor:ShowPolicemen(scroll)
		end)
	end

	for intID, p in pairs(player.GetAll()) do
		if not (p:isCP() or p:isEMS()) then continue end

		local group = MRS.GetNWdata(p, "Group")
		local rank = MRS.GetNWdata(p, "Rank")

		if not group or not lgroup or group ~= lgroup or lrank < rank then
			continue
		end

		local unit = DarkRP.Police.Units[p:UserID()] or "29-0"
		local pr = unit .. " | "
		local rank_info
		if MRS.Ranks[group] and MRS.Ranks[group].ranks[rank] then
			rank_info = MRS.Ranks[group].ranks[rank]
			pr = pr .. rank_info.name .. " | "
		end

		local pnl = vgui.Create("DPanel", scroll)
		pnl:SetSize(scroll:GetWide() - 20, Slawer.Mayor.IsTooLowResolution and 69 or 64)
		function pnl:Paint(intW, intH)
			surface.SetDrawColor(color_black)
			surface.DrawRect(0, 0, intW, intH)

			if rank_info and rank_info.icon then
				MSD.DrawTexturedRect(8, 8, 48, 48, MRS.GetRankIcon(rank_info.icon), color_white)
			end
		end

		local lblName = vgui.Create("DLabel", pnl)
		lblName:SetSize(275, 25)
		lblName:SetPos(75, 10)
		lblName:SetText(p:FullName())
		lblName:SetFont("Roman.30")
		local lblJob = vgui.Create("DLabel", pnl)
		lblJob:SetSize(575, 25)
		lblJob:SetPos(75, 33)
		lblJob:SetText(pr .. team.GetName(p:Team()))
		lblJob:SetFont("Roman.22")
		lblJob:SetTextColor(Slawer.Mayor.Colors.LightGrey)

		scroll:AddItem(pnl)

		table.insert(shift, p)

		if not Slawer.Mayor:HasAccess(LocalPlayer(), "kick") or not (p:isEMS() or  p:isCP() or p:isMayor()) then continue end

		local btnDemote = vgui.Create("Slawer.Mayor:DButton", pnl)
		btnDemote:SetSize(48, 48)
		btnDemote:SetPos(pnl:GetWide() - 58, pnl:GetTall() * 0.5 - 24)
		btnDemote:SetImageButton(Win98.Icon("no-1"), color_white, 24)
		btnDemote:SetBackgroundColor(MSD.ColorAlpha(color_black, 100))
		function btnDemote:DoClick()
			self.Menu = MSD.MenuOpen()

			for k, v in ipairs(timetables) do
				if rank < 16 and group == "NYPD" and k > 4 then continue end
				self.Menu:AddOption(v, function()
					Slawer.Mayor:NetStart("KickCP", {
						cp = p:UserID(),
						time = k
					})
				end)
				update()
			end

			local mx, my = self:LocalToScreen(0, self:GetTall())
			self.Menu:SetMinimumWidth(self:GetWide())
			self.Menu:Open(mx, my, false, self)
		end

		if p:Team() ~= 5 then
			local btnJoint = vgui.Create("Slawer.Mayor:DButton", pnl)
			btnJoint:SetSize(48, 48)
			btnJoint:SetPos(pnl:GetWide() - 110, pnl:GetTall() * 0.5 - 24)
			btnJoint:SetImageButton(Win98.Icon("users-2"), color_white, 24)
			btnJoint:SetBackgroundColor(MSD.ColorAlpha(color_black, 100))
			function btnJoint:DoClick()
				self.Menu = MSD.MenuOpen(false, self)

				for k, v in ipairs(shift) do
					if v == p then continue end
					self.Menu:AddOption(v:FullName(), function()
						RunConsoleCommand("police_join", p:UserID(), v:UserID())
						update()
					end)
				end

				local mx, my = self:LocalToScreen(0, self:GetTall())
				self.Menu:SetMinimumWidth(self:GetWide())
				self.Menu:Open(mx, my, false, self)
			end
		end


		local exunit = string.Explode("-", unit)
		if exunit[3] and DarkRP.Police.PhoneticRev[exunit[2]] then
			local btnRestore = vgui.Create("Slawer.Mayor:DButton", pnl)
			btnRestore:SetSize(48, 48)
			btnRestore:SetPos(pnl:GetWide() - 162, pnl:GetTall() * 0.5 - 24)
			btnRestore:SetImageButton(Win98.Icon("user_network-1"), color_white, 24)
			btnRestore:SetBackgroundColor(MSD.ColorAlpha(color_black, 100))
			function btnRestore:DoClick()
				RunConsoleCommand("police_join", p:UserID())
				update()
			end
		end
	end
end

function Slawer.Mayor:ShowCodex(pnlContent)

	local main = vgui.Create("WINPanelList", pnlContent)
	main:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 35)
	main:SetPos(2, 30)
	function main:Paint(w,h)
		MSDX.Draw(0,0,0,w,h,color_white)
		MSD.DrawTexturedRect(0,0,w,h, Win98.Icon("bg"), color_white)
	end

	local scroll = vgui.Create("WINPanelList", pnlContent)
	scroll:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 70)
	scroll:SetPos(2, 70)
	scroll:EnableVerticalScrollbar()
	scroll:EnableHorizontal(true)
	scroll:SetSpacing(5)
	scroll:SetPadding(5)
	scroll.IgnoreVbar = true

	scroll.page = {}

	local stabs = {
		{
			text = "Советы будущему администратору",
			icon = "winrep-1",
			check = function()
				return LocalPlayer():Team() == 15
			end,
			callback = function()
				Win98.Header(scroll, "Советы будущему администратору", TEXT_ALIGN_CENTER)
				Win98.InfoTextF1(scroll, Slawer.Mayor:L("MayorTip1"), pnlContent:GetWide() - 40, nil, color_black)
			end,
		},
		{
			text = "Оформление документов",
			icon = "winrep-1",
			check = function()
				return LocalPlayer():Team() == 15
			end,
			callback = function()
				Win98.Header(scroll, "Оформление документов", TEXT_ALIGN_CENTER)
				Win98.InfoTextF1(scroll, Slawer.Mayor:L("MayorTip2"), pnlContent:GetWide() - 40, nil, color_black)
			end,
		},
		{
			text = "Кодекс NYPD",
			icon = "nypd",
			callback = function()
					http.Fetch("http://cityrp.macnco.one/codex.json", function(body)
					if not body or not IsValid(scroll) then return end
					local tbl = util.JSONToTable(body)

					for _, p in pairs(tbl) do
						if p.type == "header" then
							Win98.Header(scroll, "", TEXT_ALIGN_CENTER)
						end

						if p.type == "text" then
							Win98.InfoTextF1(scroll, p.cont, pnlContent:GetWide() - 40, nil, color_black)
						end

						if p.type == "subheader" then
							Win98.InfoText(scroll, p.cont)
						end
					end
				end)
			end,
		},
		{
			text = "Кодекс FDNY",
			icon = "fdny",
			callback = function()
					http.Fetch("http://cityrp.macnco.one/codexfd.json", function(body)
					if not body or not IsValid(scroll) then return end
					local tbl = util.JSONToTable(body)

					for _, p in pairs(tbl) do
						if p.type == "header" then
							Win98.Header(scroll, p.cont, TEXT_ALIGN_CENTER)
						end

						if p.type == "text" then
							Win98.InfoTextF1(scroll, p.cont, pnlContent:GetWide() - 40, nil, color_black)
						end

						if p.type == "subheader" then
							Win98.InfoText(scroll, p.cont)
						end
					end
				end)
			end,
		},
		{
			text = "Памятка по оформлению подозреваемого",
			icon = "winrep-1",
			check = function()
				return LocalPlayer():isCP()
			end,
			callback = function()
				Win98.Header(scroll, "Памятка по оформлению подозреваемого", TEXT_ALIGN_CENTER)
				Win98.InfoTextF1(scroll, Slawer.Mayor:L("PoliceTip"), pnlContent:GetWide() - 40, nil, color_black)
			end,
		},
	}

	MSD.IconButtonText(pnlContent, "", Win98.Icon("homepage-0"), 35, 40, 25, color_white, color_white, function(sl)
		surface.PlaySound("win/click.wav")
		scroll.page["main"]()
	end)

	for k,v in ipairs(stabs) do
		if v.check and not v.check() then continue end
		MSD.IconButtonText(pnlContent, "", Win98.Icon(v.icon), 35 + k * 30, 40, 25, color_white, color_white, function(sl)
			surface.PlaySound("win/click.wav")
			scroll:Clear()
			v.callback()
		end)
	end

	scroll.page["main"] = function()
		scroll:Clear()
		Win98.Header(scroll, "Руководства", TEXT_ALIGN_CENTER, color_black, nil, "Roman.42")

		for k,v in ipairs(stabs) do
			if v.check and not v.check() then continue end
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

	scroll.page["main"]()
end

local gunlic, cars, fines

function Slawer.Mayor:ShowNYPD(pnlContent)
	local main = vgui.Create("WINPanelList", pnlContent)
	main:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 35)
	main:SetPos(2, 30)
	function main:Paint(w,h)
		MSDX.Draw(0,0,0,w,h,clrs[1])
		MSDX.Draw(0,0,0,w,65,color_black)

		MSD.DrawTexturedRect(10, 5, 48, 48, Win98.Icon("nypd"), color_white)
		draw.SimpleText("New York City Police Department", "Roman.38", 90, 25, color_white, TEXT_ALIGN_LEFT, 1)
		draw.SimpleText("Police Information & Security Service", "Roman.22", 90, 50, color_white, TEXT_ALIGN_LEFT, 1)
	end

	local backb = Win98.ButtonBlack(main, "Главная", "Roman.22", "homepage_alt", 155, 40, function()
		main.pages["main"]()
	end)
	backb:SetPos(main:GetWide() - 160, 15)

	local scroll = vgui.Create("WINPanelList", pnlContent)
	scroll:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 110)
	scroll:SetPos(2, 105)
	scroll:EnableVerticalScrollbar()
	scroll:EnableHorizontal(true)
	scroll:SetSpacing(5)
	scroll:SetPadding(5)
	scroll.IgnoreVbar = true

	main.pages = {}

	Slawer.Mayor.UPD = scroll
	scroll["jail"] = function()
		scroll:Clear()
		for id, data in pairs(Slawer.JailTable) do
			local ply = Player(data.userid)
			if data.openuser then
				main.pages["arrest"](ply, data)
				return
			end
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)
			local reason = DarkRP.Police.TicketTypes[data.reason]
			function pnl:Paint(w, h)

				local intTime = ply:getDarkRPVar("Arrested") and ply:getDarkRPVar("Arrested") - CurTime() or 300

				surface.SetDrawColor(Win98.Cls.nypd)
				surface.DrawRect(0, 0, w, h)
				draw.DrawText("#" .. id .. " " .. data.name .. " " .. data.sname, "Roman.28", 5, 5, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText(reason[1], "Roman.18", 5, 32, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText(MSD.NiceTime( intTime or 0), "Roman.28", w - 5, 5, color_white, TEXT_ALIGN_RIGHT)
			end

			local unjail = Win98.ButtonBlack(pnl, "Освободить", "Roman.22", "key_gray", 200, 40, function()
				Slawer.Mayor:NetStart("UnJail", {
					cp = data.userid
				})
			end)
			unjail:SetPos(pnl:GetWide() - 210, 65)

			local book = Win98.ButtonBlack(pnl, data.closed and "Детали" or "Оформить арест", "Roman.22", data.closed and "directory_open_cabinet_fc-2" or "key_padlock-0", 250, 40, function()
				main.pages["arrest"](ply, data)
			end)
			book:SetPos(pnl:GetWide() - 470, 65)

			scroll:AddItem(pnl)
		end
	end

	scroll["log"] = function()
		scroll:Clear()
		for id, data in pairs(Slawer.DeathLOG) do

			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 100)
			function pnl:Paint(w, h)
				surface.SetDrawColor(Win98.Cls.nypd)
				surface.DrawRect(0, 0, w, h)
				draw.DrawText("#" .. data[3], "Roman.28", 5, 5, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText(string.Explode("\n", data[2])[2], "Roman.18", 5, 32, color_white, TEXT_ALIGN_LEFT)
				-- draw.DrawText(os.date("%M:%S", intTime or 0), "Roman.28", w - 5, 5, color_white, TEXT_ALIGN_RIGHT)
			end

			local book = Win98.ButtonBlack(pnl, "Просмотреть дело", "Roman.22", "directory_open_file_mydocs_small-4", 250, 40, function()
				main.pages["deathlog"](data)
			end)
			book:SetPos(pnl:GetWide() - 270, 55)

			scroll:AddItem(pnl)
		end
	end

	main.pages["deathlog"] = function(data)
		scroll:Clear()

		Win98.InfoTextF1(scroll, "Дело #" .. data[3], scroll:GetWide() - 10, "Roman.32", color_white, color_black)
		Win98.InfoTextF1(scroll, data[2], scroll:GetWide() - 10, "Roman.22", color_white, color_black)

		if data[5] then
			local logmelee = {}
			local logdamage = {}
			for k,v in pairs(data[5]) do
				if MES.melee[k] then
					local log = MES.melee[k][2]
					logmelee[log] = logmelee[log] and logmelee[log] + v[1] or v[1]
				end
				if MES.gunz[k] then
					local log = MES.gunz[k][1]
					logdamage[log] = logdamage[log] and logdamage[log] + v[1] or v[1]
				end
			end

			local fulllog = "Увечья до установленого времени смерти:\n"
			for k,v in pairs(logmelee) do
				fulllog = fulllog .. string.format(k, v) .. "\n"
			end
			for k,v in pairs(logdamage) do
				fulllog = fulllog .. "Огнестрельное ранение " .. k .. " - " .. v .. "\n"
			end

			Win98.InfoTextF1(scroll, fulllog, scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		end

		if data[4] then
			local logmelee = {}
			local logdamage = {}
			for k,v in pairs(data[4]) do
				if MES.melee[k] then
					local log = MES.melee[k][2]
					logmelee[log] = logmelee[log] and logmelee[log] + v or v
				end
				if MES.gunz[k] then
					local log = MES.gunz[k][1]
					logdamage[log] = logdamage[log] and logdamage[log] + v or v
				end
			end

			local fulllog = "Прочие увечья:\n"
			for k,v in pairs(logmelee) do
				fulllog = fulllog .. string.format(k, v) .. "\n"
			end
			for k,v in pairs(logdamage) do
				fulllog = fulllog .. "Огнестрельное ранение " .. k .. " - " .. v .. "\n"
			end

			Win98.InfoTextF1(scroll, fulllog, scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		end
	end

	main.pages["arrest"] = function(ply, data)
		scroll:Clear()

		if data.searching and data.searching + data.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(data.seardelay, "InExpo")
			ld:Start()
			ld.S = data.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				main.pages["arrest"](ply, data)
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(color_black)
				surface.DrawRect(0, 0, w, h)
				surface.SetDrawColor(Win98.Text.b)
				--local stimer = () / data.seardelay
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)

				MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
				MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
				MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if data.passid == "" then
			Win98.InfoTextF1(scroll, "Не достаточно данных для оформления ареста", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, "", function() end, false, nil, false, true, color_white, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.nypd)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Поиск по ID паспорта", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск", "Roman.38", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("JailInfoUpdate", {user = data.userid, passid = tostring(Entry:GetValue())})
			end)
			scroll:AddItem(btnSave)

			local btnSave2 = Win98.ButtonBlack(scroll, "Запросить поиск в базе данных N.L.R.", "Roman.38", "search_laptop_1", scroll:GetWide() - 10, 55, function()
				Slawer.Mayor:NetStart("JailInfoUpdate", {user = data.userid})
			end)
			scroll:AddItem(btnSave2)

			return
		end

		Win98.InfoTextF1(scroll, data.name .. " " .. data.sname .. "        Дело #" .. data.userid, scroll:GetWide() - 10, "Roman.32", color_white, color_black)
		Win98.InfoTextF1(scroll, "Дата рождения: " .. data.date .. "   Пол: " .. data.gen .. "   ID паспорта: " .. data.passid .. " " .. data.type, scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		Win98.InfoTextF1(scroll, "Задержан сотрудником: " .. data.rank .. " " .. data.aresster, scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		Win98.InfoTextF1(scroll, "Причина задержания: " .. DarkRP.Police.TicketTypes[data.reason][1], scroll:GetWide() - 10, "Roman.22", color_white, color_black)

		if data.accusations then
			local accusations = ""

			for _,v in ipairs(data.accusations) do
				accusations = accusations .. DarkRP.Police.TicketTypes[v][1] .. "\n"
			end
			Win98.InfoTextF1(scroll, "Обвинения:\n" .. accusations, scroll:GetWide() - 10, "Roman.22", color_white, color_black)
		else
			Win98.InfoTextF1(scroll, "Обвинения не предъявлены", scroll:GetWide() - 10, "Roman.32", clrs[5], color_black)
		end

		if data.kills then
			for k,_ in pairs(data.kills) do
				local pn = Win98.InfoTextF1(scroll, "Прикреплено дело об убийстве #" .. k, scroll:GetWide() - 65, "Roman.32", clrs[5], color_black)
				if data.closed then continue end
				pn.StaticScale.w = 1.4
				local remove = Win98.ButtonBlack(scroll, "Удалить", "Roman.32", "msg_error-0", 210, pn.StaticScale.minh + 10, function(s)
					Slawer.Mayor:NetStart("JailInfoUpdate", {user = data.userid, remove_kill = k})
				end)
				scroll:AddItem(remove)
			end
		end

		if data.closed then
			return
		end

		local addkill = Win98.ButtonBlack(scroll, "Прикрепить дело", "Roman.32", "directory_open_file_mydocs_cool-1", scroll:GetWide() - 10, 55, function(s)
			if not Slawer.DeathLOG then return end
			local Menu = DermaMenu(s)
			Menu:SetSkin("GMod98")

			for id, d in pairs(Slawer.DeathLOG) do
				Menu:AddOption( "Дело #" .. d[3], function()
					Slawer.Mayor:NetStart("JailInfoUpdate", {user = data.userid, add_kill = d[3]})
				end)
			end
			Menu:Open()
		end)
		scroll:AddItem(addkill)

		local add = Win98.ButtonBlack(scroll, "Добавить обвинение", "Roman.32", "winrep-1", scroll:GetWide() - 10, 55, function(s)
			local Menu = DermaMenu(s)
			Menu:SetSkin("GMod98")

			for _, cat in pairs(cats) do
				local SubMenu = Menu:AddSubMenu(cat[1])
				for k,v in ipairs(DarkRP.Police.TicketTypes) do
					if k < cat[2] or k > cat[3] then continue end
					SubMenu:AddOption( v[1], function()
						Slawer.Mayor:NetStart("JailInfoUpdate", {user = data.userid, add_accusation = k})
					end)
				end
			end
			Menu:Open()
		end)
		scroll:AddItem(add)

		local btnSave2 = Win98.ButtonBlack(scroll, "Передать дело в суд", "Roman.32", "replace_directory", scroll:GetWide() - 10, 55, function()
			Slawer.Mayor:NetStart("SendToPrison", {user = data.userid})
			main.pages["main"]()
		end)
		scroll:AddItem(btnSave2)
	end

	main.pages["main"] = function()
		scroll:Clear()
		for k,v in ipairs(tabs) do
			local btnSave = Win98.ButtonBlack(scroll, v.text, "Roman.38", v.icon, scroll:GetWide() - 10, 44, function()
				v.callback(main)
			end)
			scroll:AddItem(btnSave)
		end
	end

	main.pages["weapons"] = function()
		scroll:Clear()

		if not gunlic then
			Win98.InfoTextF1(scroll, "Поиск владельца оружия по серийному номеру в базе данных N.L.R.", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, "", function() end, false, nil, false, true, color_white, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.nypd)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Укажите серийный номер оружия для поиска", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск", "Roman.38", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("GetGunLic", {gunid = tostring(Entry:GetValue())})
			end)
			scroll:AddItem(btnSave)
			return
		end

		if gunlic.searching and gunlic.searching + gunlic.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(gunlic.seardelay, "InExpo")
			ld:Start()
			ld.S = gunlic.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				main.pages["weapons"](ply, gunlic)
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(color_black)
				surface.DrawRect(0, 0, w, h)
				surface.SetDrawColor(Win98.Text.b)
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)

				MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
				MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
				MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if gunlic.gunid then
			PrintTable(gunlic)
			Win98.InfoTextF1(scroll, "Данные:", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
			local name = gunlic.name and (gunlic.name .. " " .. gunlic.sname) or "Ошибка поиска"
			Win98.InfoTextF1(scroll, "Лицензиат: " .. name , scroll:GetWide() - 10, "Roman.32", color_white, color_black)
			Win98.InfoTextF1(scroll, "Паспорт: " .. (gunlic.plypassid or "Ошибка поиска") , scroll:GetWide() - 10, "Roman.32", color_white, color_black)
			Win98.InfoTextF1(scroll, "Оружие: " .. (gunlic.gun and gunlic.gun.name or "Ошибка поиска"), scroll:GetWide() - 10, "Roman.32", color_white, color_black)
			Win98.InfoTextF1(scroll, "Серийный номер: " .. gunlic.gunid, scroll:GetWide() - 10, "Roman.32", color_white, color_black)
		else
			Win98.InfoTextF1(scroll, "Данные не найдены или устарели.", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
		end

		local btnSave = Win98.ButtonBlack(scroll, "Закрыть", "Roman.21", "msg_error-0", scroll:GetWide() - 10, 45, function()
			gunlic = nil
			main.pages["weapons"]()
		end)
		scroll:AddItem(btnSave)
	end
	scroll["weapons"] = main.pages["weapons"]

	main.pages["cars"] = function()
		scroll:Clear()

		if not cars then
			Win98.InfoTextF1(scroll, "Поиск владельца автотранспорта по серийному номеру в базе данных N.L.R.", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, "", function() end, false, nil, false, false, color_white, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.nypd)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Укажите номер машины", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск", "Roman.38", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("GetCarOwners", {plate = tostring(Entry:GetValue())})
			end)
			scroll:AddItem(btnSave)
			return
		end

		if cars.searching and cars.searching + cars.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(cars.seardelay, "InExpo")
			ld:Start()
			ld.S = cars.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				main.pages["cars"](ply, cars)
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(color_black)
				surface.DrawRect(0, 0, w, h)
				surface.SetDrawColor(Win98.Text.b)
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)

				MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
				MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
				MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if cars.carname then
			Win98.InfoTextF1(scroll, "Данные:", scroll:GetWide() - 10, "Roman.38", color_white, color_black)

			Win98.InfoTextF1(scroll, "Авто: " .. cars.carname , scroll:GetWide() - 10, "Roman.32", color_white, color_black)
			Win98.InfoTextF1(scroll, "Номер: " .. string.Replace(cars.number, "@", "-") , scroll:GetWide() - 10, "Roman.32", color_white, color_black)
			if cars.name then
				Win98.InfoTextF1(scroll, "Владелец: " .. cars.name .. " " .. cars.sname , scroll:GetWide() - 10, "Roman.32", color_white, color_black)
				Win98.InfoTextF1(scroll, "Паспорт: " .. cars.plypassid , scroll:GetWide() - 10, "Roman.32", color_white, color_black)
			else
				Win98.InfoTextF1(scroll, "Владелец: " .. cars.owner , scroll:GetWide() - 10, "Roman.32", color_white, color_black)
			end
		else
			Win98.InfoTextF1(scroll, "Данные не найдены", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
		end

		local btnSave = Win98.ButtonBlack(scroll, "Закрыть", "Roman.21", "msg_error-0", scroll:GetWide() - 10, 45, function()
			cars = nil
			main.pages["cars"]()
		end)
		scroll:AddItem(btnSave)
	end
	scroll["cars"] = main.pages["cars"]

	main.pages["fines"] = function(fine, id, val)
		scroll:Clear()

		if not fines then
			Win98.InfoTextF1(scroll, "Поиск и выдача штрафов по номеру паспорта", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
			local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 255, 45, val or "", function() end, false, nil, false, true, color_white, function(s, wd, hd)
				MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.nypd)
				Win98.InnerRec(0, 0, wd, hd)

				if s:GetValue() == "" then
					draw.SimpleText("Укажите номер паспорта", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
				end
			end)
			Entry:SetFont("Roman.36")

			local btnSave = Win98.ButtonBlack(scroll, "Поиск штрафов", "Roman.22", "search_directory-5", 240, 45, function()
				Slawer.Mayor:NetStart("GetTickets", {passid = tostring(Entry:GetValue())})
			end)
			scroll:AddItem(btnSave)

			if not fine then
				local btnSave2 = Win98.ButtonBlack(scroll, "Выбрать штраф", "Roman.38", "registration-0", scroll:GetWide() - 10, 45, function()
					local Menu = DermaMenu(s)
					Menu:SetSkin("GMod98")

					for _, cat in pairs(cats) do
						local SubMenu = Menu:AddSubMenu(cat[1])
						for k,v in ipairs(DarkRP.Police.TicketTypes) do
							if k < cat[2] or k > cat[3] then continue end
							SubMenu:AddOption( v[1], function()
								main.pages["fines"](v, k, Entry:GetValue())
							end)
						end
					end
					Menu:Open()
				end)
				scroll:AddItem(btnSave2)
			else
				Win98.InfoTextF1(scroll, fine[1], scroll:GetWide() - 10, "Roman.38", color_white, color_black)
				local header = Win98.InfoTextF1(scroll, "Размер штрафа - ", scroll:GetWide() - 10, "Roman.36", color_white, color_black)

				local fee = 0

				local feeNum = MSD.NumberWang(header, 255, 2, 155, 45, fine[2] / 4, fine[2], fine[2], "", function(slf, txt)
					print(fee)
					if not fine then return end
					fee = math.Round(math.Clamp(tonumber(txt) or 0, fine[2] / 4, fine[2]))
					if fee ~= (tonumber(txt) or 0) then
						slf:SetValue(fee)
					end
				end)
				feeNum:SetFont("Roman.36")
				feeNum:SetValue(fine[2])

				local btnSave2 = Win98.ButtonBlack(scroll, "Выписать штраф", "Roman.38", "registration-0", scroll:GetWide() / 2 - 5, 45, function()
					Slawer.Mayor:NetStart("SendTicket", {
						passid = tostring(Entry:GetValue()),
						ticket = id,
						fee = fee,
					})

					fines = {
						searching = CurTime(),
						seardelay = 5
					}

					main.pages["fines"]()
				end)
				scroll:AddItem(btnSave2)

				local btnSave3 = Win98.ButtonBlack(scroll, "Отмена", "Roman.38", "msg_error-0", scroll:GetWide() / 2 - 5, 45, function()
					main.pages["fines"](nil, nil, Entry:GetValue())
				end)
				scroll:AddItem(btnSave3)
			end

			return
		end

		if fines.searching and fines.searching + fines.seardelay > CurTime() then
			local pnl = vgui.Create("DPanel", scroll)
			pnl:SetSize(scroll:GetWide() - 10, 120)

			local ja = MSD.Anim(3)
			ja:Start()

			local ld = MSD.Anim(fines.seardelay, "InExpo")
			ld:Start()
			ld.S = fines.searching

			function ja:Done()
				self:Reset()
				self:Start()
			end

			function ld:Done()
				main.pages["fines"](ply, fines)
			end

			function pnl:Paint(w, h)
				surface.SetDrawColor(color_black)
				surface.DrawRect(0, 0, w, h)
				surface.SetDrawColor(Win98.Text.b)
				surface.DrawRect(40, h - 55, (w - 80) * ld.Value, 30)
				Win98.InnerRec(40, h - 55, w - 80, 30)

				MSD.DrawTexturedRect(w / 2 - 90 + (130 * ja.Value), 20, 32, 32, Win98.Icon("message_file-0"), color_white)

				MSD.DrawTexturedRect(w / 2 - 90, 10, 48, 48, Win98.Icon("directory_business_calendar-2"), color_white)
				MSD.DrawTexturedRect(w / 2 + 30, 10, 48, 48, Win98.Icon("directory_check-2"), color_white)
				MSD.DrawTexturedRect(w / 2 - 20, 10 + math.cos(CurTime() * 5) * 5, 48, 48, Win98.Icon("magnifying_glass-0"), color_white)
				ja:Play()
				ld:Play()
			end
			scroll:AddItem(pnl)

			return
		end

		if fines.tickets then
			Win98.InfoTextF1(scroll, "Данные:", scroll:GetWide() - 10, "Roman.28", color_white, color_black)

			Win98.InfoTextF1(scroll, (fines.name or "") .. " " .. (fines.sname or "") , scroll:GetWide() - 10, "Roman.22", color_white, color_black)
			Win98.InfoTextF1(scroll, "Паспорт: " .. fines.passid , scroll:GetWide() - 10, "Roman.22", color_white, color_black)

			Win98.InfoTextF1(scroll, "Штрафы:", scroll:GetWide() - 10, "Roman.28", color_white, color_black)

			for k,v in pairs(fines.tickets) do
				Win98.InfoTextF1(scroll, v.name .. "\n$" .. v.fee .. " Выдан: " .. v.cp, scroll:GetWide() - 10, "Roman.22", color_white, color_black)
			end
		else
			Win98.InfoTextF1(scroll, "Запрос обработан", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
		end

		local btnSave = Win98.ButtonBlack(scroll, "Закрыть", "Roman.21", "msg_error-0", scroll:GetWide() - 10, 45, function()
			fines = nil
			main.pages["fines"]()
		end)
		scroll:AddItem(btnSave)
	end
	scroll["fines"] = main.pages["fines"]

	main.pages["main"]()
end

function Slawer.Mayor:ShowFDNY(pnlContent)
	local main = vgui.Create("WINPanelList", pnlContent)
	main:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 35)
	main:SetPos(2, 30)
	function main:Paint(w,h)
		MSDX.Draw(0,0,0,w,h,clrs[6])
		MSDX.Draw(0,0,0,w,65,color_black)

		MSD.DrawTexturedRect(10, 5, 48, 48, Win98.Icon("fdny"), color_white)
		draw.SimpleText("Fire Department of the City of New York", "Roman.38", 90, 25, color_white, TEXT_ALIGN_LEFT, 1)
		draw.SimpleText("Personal Management System", "Roman.22", 90, 50, color_white, TEXT_ALIGN_LEFT, 1)
	end

	local scroll = vgui.Create("WINPanelList", pnlContent)
	scroll:SetSize(pnlContent:GetWide() - 4, pnlContent:GetTall() - 110)
	scroll:SetPos(2, 105)
	scroll:EnableVerticalScrollbar()
	scroll:EnableHorizontal(true)
	scroll:SetSpacing(5)
	scroll:SetPadding(5)
	scroll.IgnoreVbar = true

	Slawer.Mayor:ShowPolicemen(scroll)
end

Slawer.Mayor:NetReceive("GetJail", function(data)
	Slawer.JailTable = data
	Slawer.Mayor:updatePanel("jail")
end)

Slawer.Mayor:NetReceive("GetDeathLOG", function(data)
	Slawer.DeathLOG = data
	Slawer.Mayor:updatePanel("log")
end)

Slawer.Mayor:NetReceive("GetGunLic", function(data)
	gunlic = data
	Slawer.Mayor:updatePanel("weapons")
end)

Slawer.Mayor:NetReceive("SyncPolicemen", function()
	Slawer.Mayor:RefreshPanel("Policemen")
end)

Slawer.Mayor:NetReceive("GetCarOwners", function(data)
	cars = data
	Slawer.Mayor:updatePanel("cars")
end)

Slawer.Mayor:NetReceive("GetTickets", function(data)
	fines = data
	Slawer.Mayor:updatePanel("fines")

	if fines.tickets and IsValid(Slawer.Mayor.TicketsMenu) then
		Slawer.Mayor.TicketsMenu.update(fines)
	end
end)