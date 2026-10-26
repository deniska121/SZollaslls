--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/client/vgui.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local VoteVGUI = {}
local QuestionVGUI = {}
local VQpanels = {}

local bg = Color(0,0,0,200)

function DarkRP.MsgDoVote(msg, voteid, timeleft)
	if not IsValid(LocalPlayer()) then return end -- Sent right before player initialisation
	timeleft = timeleft == 0 and 100 or timeleft

	local question = string.Implode(" ", string.Explode(" ", msg))
	local OldTime = CurTime()
	local scrw = ScrW()
	surface.PlaySound("friends/friend_join.wav")

	local panel = vgui.Create("DPanel")
	panel:SetSize(scrw / 3, 80)
	panel:SetPos(scrw - (scrw / 3 + 10), -80)
	panel.id = table.insert(VQpanels, panel)
	panel.pressed = CurTime() + 0.2

	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, bg, false, true, false, true)
		MSDX.Draw(0, w - 5, 0, 5, h, MSD.Config.MainColor["p"], false, true, false, true)
		surface.SetDrawColor(MSD.Config.MainColor["p"])
		surface.SetMaterial(MSD.PinPoints[18])
		surface.DrawTexturedRect(4, 52, 24, 24)
		local time = tostring(math.Clamp(math.ceil(timeleft - (CurTime() - OldTime)), 0, 99))
		local txt = MSD.TextWrap(question, "MSDFont.22", w - 10)
		draw.DrawText(time, "MSDFont.24", 38, 50, MSD.Text.l, TEXT_ALIGN_LEFT)
		MSD.ShadowText(txt, "MSDFont.22", 5, 3, MSD.Text.l, TEXT_ALIGN_LEFT)
	end

	panel:MoveTo(panel:GetPos(), 10 + (panel.id - 1) * 85, 0.3)

	function panel:Think()
		if timeleft - (CurTime() - OldTime) <= 0 then
			panel:Close()
		end
	end

	function panel:Close()
		VoteVGUI[voteid .. "vote"] = nil
		table.remove(VQpanels, self.id)

		for k, v in pairs(VQpanels) do
			if IsValid(v) then
				v.id = k
				v:MoveTo(v:GetPos(), 10 + (k - 1) * 85, 0.2)
				v.pressed = CurTime() + 0.5
			end
		end

		self:Remove()
	end

	local yb = MSD.Button(panel, scrw / 3 - 215, 45, 100, 28, "Да", function()
		LocalPlayer():ConCommand("vote " .. voteid .. " yea\n")
		surface.PlaySound("gbpone/open.wav")
		panel:Close()
	end)

	yb.Think = function()
		if panel.id == 1 then
			yb:SetText("Да (F7)")

			if input.IsKeyDown(KEY_F7) and panel.pressed < CurTime() then
				yb:DoClick()
			end
		elseif yb:GetText() ~= "Да" then
			yb:SetText("Да")
		end
	end

	local nb = MSD.Button(panel, scrw / 3 - 110, 45, 100, 28, "Нет", function()
		LocalPlayer():ConCommand("vote " .. voteid .. " nay\n")
		surface.PlaySound("gbpone/close.wav")
		panel:Close()
	end)

	nb.Think = function()
		if panel.id == 1 then
			nb:SetText("Нет (F8)")

			if input.IsKeyDown(KEY_F8) and panel.pressed < CurTime() then
				nb:DoClick()
			end
		elseif nb:GetText() ~= "Нет" then
			nb:SetText("Нет")
		end
	end

	VoteVGUI[voteid .. "vote"] = panel
end

function DarkRP.KillVoteVGUI(id)
	if VoteVGUI[id .. "vote"] and VoteVGUI[id .. "vote"]:IsValid() then
		VoteVGUI[id .. "vote"]:Close()
	end
end

function DarkRP.MsgDoQuestion(question, quesid, timeleft)
	if not IsValid(LocalPlayer()) then return end -- Sent right before player initialisation
	timeleft = timeleft == 0 and 100 or timeleft
	local OldTime = CurTime()
	local scrw = ScrW()
	surface.PlaySound("friends/friend_join.wav")

	local panel = vgui.Create("DPanel")
	panel:SetSize(scrw / 3, 80)
	panel:SetPos(scrw - (scrw / 3 + 10), -80)
	panel.id = table.insert(VQpanels, panel)
	panel.pressed = CurTime() + 0.2

	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, bg, false, true, false, true)
		MSDX.Draw(0, w - 5, 0, 5, h, MSD.Config.MainColor["p"], false, true, false, true)
		surface.SetDrawColor(MSD.Config.MainColor["p"])
		surface.SetMaterial(MSD.PinPoints[18])
		surface.DrawTexturedRect(4, 52, 24, 24)
		local time = tostring(math.Clamp(math.ceil(timeleft - (CurTime() - OldTime)), 0, 99))
		local txt = MSD.TextWrap(question, "MSDFont.22", w - 10)
		draw.DrawText(time, "MSDFont.24", 38, 50, MSD.Text.l, TEXT_ALIGN_LEFT)
		MSD.ShadowText(txt, "MSDFont.22", 5, 3, MSD.Text.l, TEXT_ALIGN_LEFT)
	end

	panel:MoveTo(panel:GetPos(), 10 + (panel.id - 1) * 85, 0.3)

	function panel:Think()
		if timeleft - (CurTime() - OldTime) <= 0 then
			panel:Close()
		end
	end

	function panel:Close()
		QuestionVGUI[quesid .. "ques"] = nil
		table.remove(VQpanels, self.id)

		for k, v in pairs(VQpanels) do
			if IsValid(v) then
				v.id = k
				v:MoveTo(v:GetPos(), 10 + (k - 1) * 85, 0.2)
				v.pressed = CurTime() + 0.5
			end
		end

		self:Remove()
	end

	local yb = MSD.Button(panel, scrw / 3 - 215, 45, 100, 28, "Да", function()
		LocalPlayer():ConCommand("ans " .. quesid .. " 1\n")
		surface.PlaySound("gbpone/open.wav")
		panel:Close()
	end)

	yb.Think = function()
		if panel.id == 1 then
			yb:SetText("Да (F7)")

			if input.IsKeyDown(KEY_F7) and panel.pressed < CurTime() then
				yb:DoClick()
			end
		elseif yb:GetText() ~= "Да" then
			yb:SetText("Да")
		end
	end

	local nb = MSD.Button(panel, scrw / 3 - 110, 45, 100, 28, "Нет", function()
		LocalPlayer():ConCommand("ans " .. quesid .. " 2\n")
		surface.PlaySound("gbpone/close.wav")
		panel:Close()
	end)

	nb.Think = function()
		if panel.id == 1 then
			nb:SetText("Нет (F8)")

			if input.IsKeyDown(KEY_F8) and panel.pressed < CurTime() then
				nb:DoClick()
			end
		elseif nb:GetText() ~= "Нет" then
			nb:SetText("Нет")
		end
	end

	QuestionVGUI[quesid .. "ques"] = panel
end

function DarkRP.KillQuestionVGUI(id)
	if QuestionVGUI[id .. "ques"] and QuestionVGUI[id .. "ques"]:IsValid() then
		QuestionVGUI[id .. "ques"]:Close()
	end
end

local function DoVoteAnswerQuestion(ply, cmd, args)
	if not args[1] then return end
	local vote = 0

	if tonumber(args[1]) == 1 or string.lower(args[1]) == "yes" or string.lower(args[1]) == "true" then
		vote = 1
	end

	for k, v in pairs(VoteVGUI) do
		if IsValid(v) then
			local ID = string.sub(k, 1, -5)
			VoteVGUI[k]:Close()
			RunConsoleCommand("vote", ID, vote)

			return
		end
	end

	for k, v in pairs(QuestionVGUI) do
		if IsValid(v) then
			local ID = string.sub(k, 1, -5)
			QuestionVGUI[k]:Close()
			RunConsoleCommand("ans", ID, vote)

			return
		end
	end
end

concommand.Add("rp_vote", DoVoteAnswerQuestion)

local gestures = {
	["Приветствие"] = "salute",
	["Смех"] = "laugh",
	["Ура!"] = "cheer",
	["Поза тигра"] = "pers",
	["Поза зомби"] = "zombie",
	["Танец"] = "dance",
}

local poses_stand = {
	["Спокойная"] = {0},
	["Скрещенные руки 1"] = {1},
	["Скрещенные руки 2"] = {7},
	["Руки на поясе"] = {2},
	["Самоуверенная"] = {3},
	["Испуганная"] = {4},
	["Сгорбленная"] = {5},
	["Руки в карманах"] = {9, function()
		return LocalPlayer():getDarkRPVar("gender") == "male"
	end},
	["Скрещенные руки 3"] = {8, function()
		return LocalPlayer():getDarkRPVar("gender") == "female"
	end},
	["Скрещенные руки 4"] = {6, function()
		return LocalPlayer():getDarkRPVar("gender") == "female"
	end},
	["Альтернативная 2"] = {8, function()
		return LocalPlayer():getDarkRPVar("gender") == "male"
	end},
	["Альтернативная 1"] = {6, function()
		return LocalPlayer():getDarkRPVar("gender") == "male"
	end},
}

local poses_sit = {
	["На колене"] = 1,
	["Походная"] = 2,
	["Медитация"] = 3,
	["На полу"] = 5,
}

local owned_door = {
	["Отдать ключи"] = {
		func = function(panel)
			RunConsoleCommand("darkrp", "/toggleown")
			panel.Close()
		end,
		icon = MSD.Icons48.close_thick
	},
	["Добавить владельца"] = {
		func = function(panel, ent)
			panel.Close()

			local combo, but = MSD.AskPopupCombo(nil, "Добавить владельца", false, {
				"Выберите игрока", "Добавить", function(sf)
					RunConsoleCommand("darkrp", "/ao", sf.data)
				end
			})

			for k, v in pairs(player.GetAll()) do
				if not DarkRP.InRange(LocalPlayer(), v, 100) then continue end
				if ent:isKeysOwnedBy(v) or ent:isKeysAllowedToOwn(v) then continue end
				combo:AddChoice(v:Name(), v:UserID())
			end

			function combo:OnSelect(index, text, data)
				but.data = data
			end
		end,
		icon = MSD.Icons48.key_plus
	},
	["Удалить владельца"] = {
		func = function(panel, ent)
			panel.Close()

			local combo, but = MSD.AskPopupCombo(nil, "Удалить владельца", false, {
				"Выберите игрока", "Удалить", function(sf)
					RunConsoleCommand("darkrp", "/ro", sf.data)
				end
			})

			for k, v in pairs(player.GetAll()) do
				if not ((ent:isKeysOwnedBy(v) and not ent:isMasterOwner(v)) or ent:isKeysAllowedToOwn(v)) then continue end
				combo:AddChoice(v:Name(), v:UserID())
			end

			function combo:OnSelect(index, text, data)
				but.data = data
			end
		end,
		icon = MSD.Icons48.key_remove
	},
	["Название"] = {
		func = function(panel)
			MSD.AskPopupEntr(nil, "Введите название", false, {
				"", function(sf)
					RunConsoleCommand("darkrp", "/title", sf:GetValue())
				end
			})

			panel.Close()
		end,
		icon = MSD.Icons48.door
	},
}

local admin_door = {
	["Разрешить покупку"] = {
		func = function(panel)
			RunConsoleCommand("darkrp", "/toggleownable")
			panel.Close()
		end,
		icon = MSD.Icons48.key_plus,
		check = function(ent) return ent:getKeysNonOwnable() end
	},
	["Запретить покупку"] = {
		func = function(panel)
			RunConsoleCommand("darkrp", "/toggleownable")
			panel.Close()
		end,
		icon = MSD.Icons48.key_remove,
		check = function(ent) return not ent:getKeysNonOwnable() end
	},
	["Название"] = {
		func = function(panel)
			MSD.AskPopupEntr(nil, "Введите название", false, {
				"", function(sf)
					RunConsoleCommand("darkrp", "/title", sf:GetValue())
				end
			})

			panel.Close()
		end,
		icon = MSD.Icons48.door
	},
	["Группы"] = {
		func = function(panel, ent)
			local menu = MSD.MenuOpen(false)
			local groups = menu:AddSubMenu("Группы дверей")
			local teams = menu:AddSubMenu("Работы")
			local add = teams:AddSubMenu("Добавить")
			local remove = teams:AddSubMenu("Удалить")

			menu:AddOption("Убрать все", function()
				RunConsoleCommand("darkrp", "/togglegroupownable")
				if IsValid(Frame) then Frame:Close() end
			end)

			for k in pairs(RPExtraTeamDoors) do
				groups:AddOption(k, function()
					RunConsoleCommand("darkrp", "/togglegroupownable", k)
					if IsValid(Frame) then Frame:Close() end
				end)
			end

			local doorTeams = ent:getKeysDoorTeams()
			for k, v in pairs(DarkRP.Teams) do
				local which = (not doorTeams or not doorTeams[k]) and add or remove
				which:AddOption(v.name, function()
					RunConsoleCommand("darkrp", "/toggleteamownable", k)
					if IsValid(Frame) then Frame:Close() end
				end)
			end

			menu:Open()

			panel.Close()
		end,
		check = function(ent) return not ent:getKeysNonOwnable() end,
		icon = MSD.Icons48.account_multiple
	},
}

local player_police = {
	["Снять оружие"] = {
		func = function(panel, ent)
			net.Start("Police.RemoveWeapons")
			net.WriteEntity(ent)
			net.SendToServer()
			panel.Close()
		end,
		icon = Material("mqs/icons/pistol_remove.png", "smooth")
	},
	["Обыск инвентаря"] = {
		func = function(panel, ent)
			net.Start("Police.CheckInv")
			net.WriteEntity(ent)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.Icons48.briefcase
	}
}

local player_exam = {
	["Экзамен НИС"] = {
		func = function(panel, ent)
			net.Start("MRS.Exam")
				net.WriteUInt(1, 3)
				net.WriteString("PDcop2")
				net.WriteUInt(ent:UserID(), 32)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.Icons48.file_document
	},
	["Экзамен ПО"] = {
		func = function(panel, ent)
			net.Start("MRS.Exam")
				net.WriteUInt(1, 3)
				net.WriteString("PDofficer")
				net.WriteUInt(ent:UserID(), 32)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.Icons48.file_document
	},
	["Нелетальное"] = {
		func = function(panel, ent)
			net.Start("MRS.Exam")
				net.WriteUInt(1, 3)
				net.WriteString("PDtaser")
				net.WriteUInt(ent:UserID(), 32)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.Icons48.file_document
	},
	["Оружие"] = {
		func = function(panel, ent)
			net.Start("MRS.Exam")
				net.WriteUInt(1, 3)
				net.WriteString("GUN2")
				net.WriteUInt(ent:UserID(), 32)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.Icons48.file_document
	},
	["Знание принципов работы полиции"] = {
		func = function(panel, ent)
			net.Start("MRS.Exam")
				net.WriteUInt(1, 3)
				net.WriteString("PDprobation")
				net.WriteUInt(ent:UserID(), 32)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.Icons48.file_document
	}
}

local player_exam2 = {
	["Экзамен на пожарного"] = {
		func = function(panel, ent)
			net.Start("MRS.Exam")
				net.WriteUInt(4, 3)
				net.WriteString("FD")
				net.WriteUInt(ent:UserID(), 32)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.ImgLib.GetMaterial("http://macnco.one/rankup/fd/2.png")
	},
	["Экзамен на парамедика"] = {
		func = function(panel, ent)
			net.Start("MRS.Exam")
				net.WriteUInt(4, 3)
				net.WriteString("FDmed")
				net.WriteUInt(ent:UserID(), 32)
			net.SendToServer()
			panel.Close()
		end,
		icon = MSD.ImgLib.GetMaterial("http://macnco.one/rankup/fd/3.png")
	},
}

local pumps = {
	["sim_fphys_l4d_fire_engine"] = true,
	["sim_fphys_l4d_fire_truck"] = true,
}

function MSD.SetUpF2Pages(panel)
	local w = LocalPlayer():GetActiveWeapon()

	panel.Page["main"] = {
		{
			"Персонаж", function()
				panel.OpenPage("gest")
			end,
			MSD.Icons48.human_male
		}
	}

	panel.Page["weapon"] = {}

	panel.Page["gest"] = {
		{
			"Долгие жесты", function()
				panel.OpenPage("long")
			end,
			MSD.Icons48.human_greeting
		},
		{
			"Быстрые жесты", function()
				panel.OpenPage("quick")
			end,
			MSD.Icons48.hand_peace_variant
		},
		{
			"Сдаться", function()
				RunConsoleCommand("idle_sit", 4)
				RunConsoleCommand("ground_sit", 4)
			end,
			MSD.Icons48.human_handsup
		},
		{
			"Позы бездействия", function()
				panel.OpenPage("idle")
			end,
			MSD.Icons48.human_male
		},
		{
			"Позы сидя", function()
				panel.OpenPage("idle_sit")
			end,
			MSD.Icons48.meditation
		}
	}

	panel.Page["quick"] = {}

	for k, v in pairs(DarkRP.Anims) do
		table.insert(panel.Page["quick"], {
			v, function()
				RunConsoleCommand("_DarkRP_DoAnimation", k)
				panel.Close()
			end
		})
	end

	panel.Page["long"] = {}

	for k, v in pairs(gestures) do
		table.insert(panel.Page["long"], {
			k, function()
				RunConsoleCommand("act", v)
				panel.Close()
			end
		})
	end

	if MCR.HasTatoo(LocalPlayer(), "d1") then
		panel.Page["dances"] = {}

		table.insert(panel.Page["gest"], {
			"Танцы", function()
				panel.OpenPage("dances")
			end,
			MSD.Icons48.walk
		})

		for i = 1, 17 do
			table.insert(panel.Page["dances"], {
				"#" .. i, function()
					RunConsoleCommand("dance", i)
					panel.Close()
				end
			})
		end
	end

	panel.Page["idle"] = {}

	for k, v in pairs(poses_stand) do
		if v[2] and not v[2]() then continue end
		table.insert(panel.Page["idle"], {
			k, function()
				RunConsoleCommand("idle_pose", v[1])
				panel.Close()
			end
		})
	end

	panel.Page["idle_sit"] = {}

	for k, v in pairs(poses_sit) do
		table.insert(panel.Page["idle_sit"], {
			k, function()
				RunConsoleCommand("idle_sit", v)
				if not LocalPlayer():GetNWBool("SitAnyG_", false) then
					RunConsoleCommand("ground_sit")
				end
				panel.Close()
			end
		})
	end

	panel.Page["radio"] = {
		{
			"Вкл/Выкл", function()
				net.Start("Police.Radio")
					net.WriteUInt(LocalPlayer():getDarkRPVar("rc_on") and 0 or 1, 3)
				net.SendToServer()
				panel.Close()
			end, MSD.Icons48.cellphone_basic
		},
		{
			"Каналы", function()
				panel.OpenPage("radio_chan")
			end, MSD.Icons48.menu
		},
		{
			"Вызовы", function()
				Dispatcher.OpenMenu()
				panel.Close()
			end, MSD.Icons48.folder_open
		},
	}

	panel.Page["radio_chan"] = {}

	for i = 1,3 do
		table.insert(panel.Page["radio_chan"], {
			"PD канал #" .. i, function()
				net.Start("Police.Radio")
					net.WriteUInt(2, 3)
					net.WriteUInt(i, 5)
				net.SendToServer()
				panel.Close()
			end
		})
	end

	for i = 1,3 do
		table.insert(panel.Page["radio_chan"], {
			"FD канал #" .. i, function()
				net.Start("Police.Radio")
					net.WriteUInt(2, 3)
					net.WriteUInt(3 + i, 5)
				net.SendToServer()
				panel.Close()
			end
		})
	end

	table.insert(panel.Page["radio_chan"], {
		"COM канал", function()
			net.Start("Police.Radio")
				net.WriteUInt(2, 3)
				net.WriteUInt(10, 5)
			net.SendToServer()
			panel.Close()
		end
	})

	local ent = LocalPlayer():GetEyeTrace().Entity

	if not DarkRP.GasMask(LocalPlayer(), true) and LocalPlayer():getDarkRPVar("deoxygen") and LocalPlayer():getDarkRPVar("deoxygen") > 30 and LocalPlayer():IsFreeman() and not LocalPlayer():getDarkRPVar("cough") then
		table.insert(panel.Page["main"], {
			"Отдохнуть", function()
				RunConsoleCommand("say", "/rest")
			end,
			MSD.Icons48.account_convert
		})
	end

	if GAMEMODE.RadioTeams[LocalPlayer():Team()] then
		table.insert(panel.Page["main"], {
			"Рация", function()
				panel.OpenPage("radio")
			end,
			MSD.Icons48.cellphone_basic
		})
	end

	if IsValid(ent) and ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 26000 then
		local function check()
			return IsValid(ent)
		end

		if MCR.HasTatoo(LocalPlayer(), "b9") and ent.SelfPlayer then
			table.insert(panel.Page["main"], {
				"Начать СЛР", function()
					RunConsoleCommand("say", "/slr_tatoo")
					panel.Close()
				end,
				MSD.Icons48.heart_flash
			})
		end

		if IsValid(w) and DarkRP.SingleWep.FireArms[w:GetClass()] and LocalPlayer():Team() == 2 then
			panel.Page["main"] = {
				{
					"Ограбить", function()
						RunConsoleCommand("say", "/rob")
						panel.Close()
					end,
					MSD.Icons48.wallet
				}
			}
		end

		if ent:IsVehicle() and pumps[ent:GetSpawn_List()] and LocalPlayer():Team() == 14 then
			table.insert(panel.Page["main"], {
				"Разложить/Сложить Рукав", function()
					RunConsoleCommand("get_hose")
					panel.Close()
				end,
				MSD.Icons48.fire_hydrant, check
			})

			if LocalPlayer():getDarkRPVar("scba") then
				table.insert(panel.Page["main"], {
					"Надеть/Снять СИЗОД", function()
						RunConsoleCommand("get_hose", "scba")
						panel.Close()
					end,
					MSD.Icons48.face_mask_custom, check
				})
			end
		end

		if ent.CanPack then
			table.insert(panel.Page["main"], {
				"Запаковать", function()
					RunConsoleCommand("Inventory.Pack")
					panel.Close()
				end,
				MSD.PinPoints[9], check
			})
		end

		if GAMEMODE.RadioTeams[LocalPlayer():Team()] and ent:GetClass() == "prop_ragdoll" then
			table.insert(panel.Page["main"], {
				"Упаковать тело", function()
					RunConsoleCommand("bag_ragdoll")
					panel.Close()
				end,
				MSD.Icons48.heart_broken, check
			})
		end

		if (ent:isDoor() or ent:IsVehicle()) and not ent:getKeysNonOwnable() then
			table.insert(panel.Page["main"], {
				ent:IsVehicle() and "Машина" or "Дверь", function()
					panel.OpenPage("door")
				end,
				ent:IsVehicle() and MSD.Icons48.car or MSD.Icons48.door, check
			})

			if ent:IsVehicle() and ent:IsSimfphyscar() and GAMEMODE.Config.PoliceCars[ent:GetSpawn_List()] and LocalPlayer():isCP() then
				table.insert(panel.Page["main"], {
					"Разгрузка", function()
						MSD.Loadout.Create()
					end,
					MSD.Icons48.briefcase, check
				})
			end

			panel.Page["door"] = {}

			if ent:isKeysOwnedBy(LocalPlayer()) then
				for k, v in pairs(owned_door) do
					table.insert(panel.Page["door"], {
						k, function()
							v.func(panel, ent)
						end,
						v.icon, check
					})
				end
			elseif ent:isKeysOwnable() and (not ent:isKeysOwned() or ent:isKeysAllowedToOwn(LocalPlayer())) then
				table.insert(panel.Page["door"], {
					"Получить ключи", function()
						RunConsoleCommand("darkrp", "/toggleown")
						panel.Close()
					end,
					MSD.Icons48.key, check
				})
			end
		end

		if ent:isDoor() and LocalPlayer():HasAdminAccess("door") then
			table.insert(panel.Page["main"], {
				"Управление", function()
					panel.OpenPage("door_admin")
				end,
				MSD.Icons48.submit, check
			})

			panel.Page["door_admin"] = {}

			for k, v in pairs(admin_door) do
				if v.check and not v.check(ent) then continue end

				table.insert(panel.Page["door_admin"], {
					k, function()
						v.func(panel, ent)
					end,
					v.icon
				})
			end
		end

		if ent:IsPlayer() and ent:getDarkRPVar("HandCuffed") then
			table.insert(panel.Page["main"], {
				"Обыск игрока", function()
					panel.OpenPage("player")
				end,
				MSD.Icons48.account_convert, check
			})

			panel.Page["player"] = {}

			for k, v in pairs(player_police) do
				if v.check and not v.check(ent) then continue end

				table.insert(panel.Page["player"], {
					k, function()
						v.func(panel, ent)
					end,
					v.icon
				})
			end

			if LocalPlayer():getDarkRPVar("Player.Drag") and not ent:getDarkRPVar("Arrested") and DarkRP.InRangeVector(ent:GetPos(), GAMEMODE.Config.Positions["JailNPC"], 500) then
				table.insert(panel.Page["main"], {
					"Задержать игрока", function()
						DarkRP.OpenBooking(ent)
					end,
					MSD.Icons48.cuffs, check
				})
			end
		end

		if ent:IsPlayer() and ent:isCP() and MRS.GetNWdata(ent, "Group") == MRS.GetNWdata(LocalPlayer(), "Group") and MRS.GetNWdata(LocalPlayer(), "Rank") and MRS.GetNWdata(LocalPlayer(), "Rank") > 5 then
			table.insert(panel.Page["main"], {
				"Экзамен", function()
					panel.OpenPage("exam")
				end,
				MSD.Icons48.file_document, check
			})

			panel.Page["exam"] = {}

			for k, v in pairs(player_exam) do
				if v.check and not v.check(ent) then continue end

				table.insert(panel.Page["exam"], {
					k, function()
						v.func(panel, ent)
					end,
					v.icon
				})
			end
		end

		if ent:IsPlayer() and ent:isEMS() and MRS.GetNWdata(ent, "Group") == MRS.GetNWdata(LocalPlayer(), "Group") and MRS.GetNWdata(LocalPlayer(), "Rank") and MRS.GetNWdata(LocalPlayer(), "Rank") > 6 then
			table.insert(panel.Page["main"], {
				"Экзамен", function()
					panel.OpenPage("exam")
				end,
				MSD.Icons48.file_document, check
			})

			panel.Page["exam"] = {}

			for k, v in pairs(player_exam2) do
				if v.check and not v.check(ent) then continue end

				table.insert(panel.Page["exam"], {
					k, function()
						v.func(panel, ent)
					end,
					v.icon
				})
			end
		end
	end

	if IsValid(w) and w.IsMWwp then
		if w:GetFlashlightAttachment() then
			table.insert(panel.Page["weapon"], {
				"Фонарь", function()
					LocalPlayer():ConCommand( "flashlight" )
				end,
				MSD.PinPoints[8]
			})
		end
		if w:GetLaser() and w.laser.Laser.Attachment then
			table.insert(panel.Page["weapon"], {
				"Лазер", function()
					LocalPlayer():ConCommand( "lasertoggle" )
				end,
				MSD.Icons48.lightning
			})
		end
		table.insert(panel.Page["weapon"], {
			"Разрядить", function()
				LocalPlayer():ConCommand( "unloadgun" )
			end,
			MSD.Icons48.magazine
		})
		table.insert(panel.Page["weapon"], {
			"Выбросить", function()
				LocalPlayer():ConCommand( "say /drop" )
			end,
			MSD.Icons48.arrow_down
		})
		table.insert(panel.Page["main"], {
			"Оружие", function()
				panel.OpenPage("weapon")
			end,
			MSD.Icons48.pistol
		})
	end

	local found_cases

	if not MW_CASES then return end

	for i,p in pairs(MW_CASES) do
		if DarkRP.InRangeVector(p.pos, LocalPlayer():GetPos(), 60) then
			found_cases = true
			break
		end
	end

	if found_cases then
		table.insert(panel.Page["main"], {
			"Собрать гильзы", function()
				RunConsoleCommand("mw_lookupcases")
				panel.Close()
			end,
			MSD.Icons48.hand_okay
		})
	end
end

concommand.Add("+mcs_f2", function()
	if IsValid(MSD.RadialMenu) then return end
	MSD.RadialMenu = vgui.Create("MSD.RadialMenu")

	local panel = MSD.RadialMenu
	panel:SetSize(700, 700)
	panel:MakePopup()
	panel:Center()

	panel.KeyThink = function()
		if not input.IsKeyDown(KEY_F2) then
			panel.Close()
		end
	end

	panel.Close = function()
		MSD.RadialMenu:Remove()
		MSD.RadialMenu = nil
		MSD.PlaySnd("msd/ui/toggle.wav")
	end

	panel.Page = {}

	panel.OpenPage = function(id)
		page = panel.Page[id]
		if not page then return end
		MSD.PlaySnd("msd/ui/toggle.wav")
		panel.actions = page
		panel:Build()
	end

	MSD.SetUpF2Pages(panel)

	panel.OpenPage("main")
end)

concommand.Add("-mcs_f2", function()
	if IsValid(MSD.RadialMenu) then
		MSD.RadialMenu:Remove()
		MSD.PlaySnd("msd/ui/toggle.wav")
	end
end)

GM.ShowTeam = function()
	RunConsoleCommand("+mcs_f2")
end