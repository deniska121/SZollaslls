--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/wanted/cl.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function Slawer.Mayor:ShowWanted(scroll)
	scroll:Clear()
	local btnNew = Win98.ButtonBlack(scroll, "Подать в розыск", "Roman.38", "search_directory-5", scroll:GetWide() - 10, 45, function()
		Slawer.Mayor:ShowNewWanted(scroll)
	end)
	scroll:AddItem(btnNew)

	for k, p in pairs(player.GetAll()) do
		if not p:getDarkRPVar("wanted") then continue end
		local pnl = vgui.Create("DPanel", scroll)
		pnl:SetSize(scroll:GetWide() - 10, 60)

		function pnl:Paint(intW, intH)
			if not p or not IsValid(p) then
				self:Remove()

				return
			end

			surface.SetDrawColor(color_black)
			surface.DrawRect(0, 0, intW, intH)
			draw.SimpleText(p:FullName(), "Roman.22", 10, 5, color_white, 0, 0)
			draw.SimpleText(p:getDarkRPVar("wantedReason") or "", "Roman.20", 10, 30, color_white, 0, 0)
		end

		local btnEnd = Win98.ButtonBlack(pnl, "", "Roman.38", "msg_error-0", 60, 50, function()
			RunConsoleCommand("drp_unwanted", p:UserID())
			timer.Simple(1, function()
				if not IsValid(scroll) then return end
				Slawer.Mayor:ShowWanted(scroll)
			end)
		end)
		btnEnd:SetPos(pnl:GetWide() - btnEnd:GetWide() - 10, pnl:GetTall() * 0.5 - btnEnd:GetTall() * 0.5)


		scroll:AddItem(pnl)
	end
end

function Slawer.Mayor:ShowNewWanted(scroll)
	scroll:Clear()

	Win98.InfoTextF1(scroll, "Подать человека в розыск по номеру паспорта/имени и фамилии", scroll:GetWide() - 10, "Roman.38", color_white, color_black)
	local Entry = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 10, 45, "", function() end, false, nil, false, false, color_white, function(s, wd, hd)
		MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.nypd)
		Win98.InnerRec(0, 0, wd, hd)

		if s:GetValue() == "" then
			draw.SimpleText("Поиск по ID паспорта или имени", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end)
	Entry:SetFont("Roman.36")

	local txtReason = Win98.TextEntryAlt(scroll, nil, nil, scroll:GetWide() - 10, 45, "", function() end, false, nil, false, false, color_white, function(s, wd, hd)
		MSDX.Draw(0, 0, 0, wd, hd, Win98.Cls.nypd)
		Win98.InnerRec(0, 0, wd, hd)

		if s:GetValue() == "" then
			draw.SimpleText("Причина розыска", "Roman.22", 5, hd / 2, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
	end)
	txtReason:SetFont("Roman.36")

	local btnSave = Win98.ButtonBlack(scroll, "Подать в розыск", "Roman.38", "search_directory-5", scroll:GetWide() - 10, 45, function()
		RunConsoleCommand("drp_wanted", Entry:GetText(), txtReason:GetText())
		Slawer.Mayor:ShowWanted(scroll)
	end)
	scroll:AddItem(btnSave)

end

hook.Add("DarkRPVarChanged", "Slawer.Mayor:Wanted:DarkRPVarChanged", function(p, var, old, new)
	if var == "wanted" and old == true then
		Slawer.Mayor.WantedNumber = Slawer.Mayor.WantedNumber or 0
		Slawer.Mayor.WantedList = Slawer.Mayor.WantedList or {}
		Slawer.Mayor:RefreshPanel("Wanted")
		Slawer.Mayor.WantedNumber = math.Clamp(Slawer.Mayor.WantedNumber - 1, 0, math.huge)

		for k, v in pairs(Slawer.Mayor.WantedList) do
			if v.p == p then
				table.remove(Slawer.Mayor.WantedList, k)
				break
			end
		end
	elseif var == "wantedReason" then
		if not IsValid(p) or not p:IsPlayer() then return end
		Slawer.Mayor.WantedNumber = Slawer.Mayor.WantedNumber or 0
		Slawer.Mayor.WantedList = Slawer.Mayor.WantedList or {}
		Slawer.Mayor:RefreshPanel("Wanted")

		if new ~= nil then
			Slawer.Mayor.WantedNumber = Slawer.Mayor.WantedNumber + 1

			table.insert(Slawer.Mayor.WantedList, {
				p = p,
				sid = p:SteamID() or 0,
				reason = new,
				uid = p:UserID()
			})
		else
			for k, v in pairs(Slawer.Mayor.WantedList) do
				if v.p == p then
					Slawer.Mayor.WantedNumber = math.Clamp(Slawer.Mayor.WantedNumber - 1, 0, math.huge)
					table.remove(Slawer.Mayor.WantedList, k)
					break
				end
			end
		end
	end
end)
gameevent.Listen("player_disconnect")

hook.Add("player_disconnect", "Slawer:Mayor:player_disconnect", function(data)
	local steamid = data.networkid
	local uid = data.userid

	if not Slawer.Mayor.WantedList then return end

	for k, v in pairs(Slawer.Mayor.WantedList) do
		if v.sid == steamid or v.uid == uid then
			Slawer.Mayor.WantedNumber = Slawer.Mayor.WantedNumber - 1
			table.remove(Slawer.Mayor.WantedList, k)
			break
		end
	end
end)