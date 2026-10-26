--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_simple_npcs/lua/mcs_npcs/cl_menu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--                                                          |__|                                               
----------------------------------------------------------------------------------------------------------------
------------------------- Warning! Edit this only if you know what are you doing -------------------------------
----------------------------------------------------------------------------------------------------------------

net.Receive("MCS.OpenMenu", function()
	local npc = net.ReadEntity()
	if not IsValid(npc) then return end
	local theme = MCS.Spawns[npc:GetUID()].theme
	MCS.OpenDialogue(npc, theme)
end)

MCS.StopSounds = function()
	if MCS.Dialogue and IsValid(MCS.Dialogue.Sound) then
		MCS.Dialogue.Sound:Stop()
		MCS.Dialogue.Sound = nil
	end
end

MCS.OpenDialogue = function(npc, theme, test, retry)
	if not IsValid(npc) and not test then return end

	if not theme then
		theme = "Default"
	end
	if IsValid(MCS.Dialogue) and MCS.Dialogue.NPC ~= npc then
		MCS.Dialogue.DoClose()
		if retry then return end
		timer.Simple(0.51, function()
			MCS.OpenDialogue(npc, theme, nil, true)
		end)
		return
	end

	if IsValid(MCS.Dialogue) and MCS.Dialogue.NPC == npc then
		return
	end

	local npc_table = test or MCS.Spawns[npc:GetUID()]

	if not npc_table.dialogs then return end

	theme = MCS.Themes[theme]
	theme.InProgress = true
	local testmode = MCS.Config.DebugMode

	if test then
		testmode = true
	end

	MCS.Dialogue = vgui.Create("DFrame")
	MCS.Dialogue:SetSize(ScrW(), ScrH())
	MCS.Dialogue:Center()
	MCS.Dialogue:MakePopup()
	MCS.Dialogue:SetDraggable(false)
	MCS.Dialogue:ShowCloseButton(testmode)
	MCS.Dialogue:SetTitle("")
	MCS.Dialogue.GCur = 1
	MCS.Dialogue.GSent = {}
	MCS.Dialogue.History = {}
	MCS.Dialogue.HtrProgress = 0
	MCS.Dialogue.Progress = 0
	MCS.Dialogue.ShowHint = true
	MCS.Dialogue.NPC = npc
	MCS.Dialogue.npc_table = npc_table
	MCS.Dialogue.dialogs = npc_table.dialogs
	LocalPlayer().MCSInUse = MCS.Dialogue

	MCS.Dialogue.DoClose = function()
		if theme.OnClose then
			theme.OnClose(MCS.Dialogue)
		end

		MCS.Dialogue:AlphaTo(0, 0.5, 0, function()
			MCS.Dialogue:Close()
		end)
	end

	MCS.Dialogue.OnRemove = function()
		MCS.StopSounds()

		MCS.Dialogue = nil
		theme.InProgress = false

		if IsValid(npc) and npc:GetInputLimit() then
			net.Start("MCS.CloseMenu")
			net.SendToServer()
		end
	end

	MCS.Dialogue.Paint = function(self, w, h)
		theme.FramePaint(self, w, h)
	end

	local ges

	MCS.Dialogue.Think = function()
		if theme.Process then
			theme.Process(MCS.Dialogue)
		end

		if not LocalPlayer():IsUnrestrained() and not npc_table.ignore then
			if theme.OnClose then
				theme.OnClose(MCS.Dialogue)
			end

			MCS.Dialogue:Close()
		end

		if MCS.Dialogue.Gestures and IsValid(MCS.Dialogue.Sound) and MCS.Dialogue.Gestures[MCS.Dialogue.GCur] then
			ges = MCS.Dialogue.Gestures[MCS.Dialogue.GCur]

			if ges[2] <= MCS.Dialogue.Sound:GetTime() then
				MCS.Dialogue.GCur = MCS.Dialogue.GCur + 1
				net.Start("MCS.SrartAnimation")
				net.WriteString(ges[1])
				net.WriteBool(true)
				net.SendToServer()
			end
		end
	end

	if theme.FadeIn then
		MCS.Dialogue:SetAlpha(1)
		MCS.Dialogue:AlphaTo(255, 0.3)
	end

	theme.FrameBuild(MCS.Dialogue)

	MCS.Dialogue.OpenDialogue = function(dialog, id)
		MCS.StopSounds()

		MCS.Dialogue.HtrProgress = MCS.Dialogue.HtrProgress + 1
		MCS.Dialogue.Current = id
		MCS.Dialogue.CurrentTable = dialog

		MCS.Dialogue.History[MCS.Dialogue.HtrProgress] = {
			line = dialog["Line"],
			ans = ""
		}

		theme.FrameUpdate(MCS.Dialogue, dialog, id, npc)

		if table.IsEmpty(dialog["Answers"]) then
			theme.PopulateAns(MCS.Dialogue, 1, {"...", "close"})
		else
			for k, ans in pairs(dialog["Answers"]) do
				if ans[4] and not ans[4]() then continue end
				theme.PopulateAns(MCS.Dialogue, k, ans, id)
			end
		end

		if npc_table.vos then
			dialog["Sound"] = npc_table.vos(id)
		end

		MCS.Dialogue.GCur = 1
		MCS.Dialogue.GSent = {}
		MCS.Dialogue.Gestures = dialog["Gestures"]

		local dcalb = dialog["CallBack"]

		if dialog["CallBackRun"] then
			dialog["CallBackRun"](MCS.Dialogue, dialog, id, npc)
		end

		if dcalb and MCS.AddonList[dcalb.name] then
			if MCS.AddonList[dcalb.name]["function_sv"] then
				net.Start("MCS.Dialogue")
					net.WriteUInt(id, 15)
					net.WriteUInt(0, 15)
					net.WriteEntity(npc)
				net.SendToServer()
			end

			if MCS.AddonList[dcalb.name]["function"] then
				MCS.AddonList[dcalb.name]["function"](npc, dcalb.data)
			end
		end

		if dialog["Animation"] then
			net.Start("MCS.SrartAnimation")
			net.WriteString(dialog["Animation"])
			net.WriteBool(false)
			net.SendToServer()
		end

		if dialog["Sound"] and dialog["Sound"] ~= "" then
			if dialog["Formater"] then
				local _, snd = dialog["Formater"](dialog["Line"])

				if snd then
					dialog["Sound"] = snd
				end
			end

			MCS.DialogSound(dialog["Sound"], dialog["SoundVolume"] or 1, npc)
		end
	end

	MCS.Dialogue.DoAnswer = function(ans, sid, mid)
		if MCS.Dialogue:GetAlpha() < 255 then return end
		MCS.Dialogue.History[MCS.Dialogue.HtrProgress].ans = ans[1]

		if isnumber(ans[2]) and MCS.Dialogue.dialogs[ans[2]] then
			MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[ans[2]], ans[2])
		elseif istable(ans[2]) then
			if ans[2].id and MCS.AddonList[ans[2].id] and MCS.AddonList[ans[2].id]["enabled"] then
				local id = ans[2].id

				if MCS.AddonList[id]["function"] then
					MCS.AddonList[id]["function"](npc, ans[2].data)
				end

				if MCS.AddonList[id]["function_sv"] then
					net.Start("MCS.Dialogue")
						net.WriteUInt(mid, 15)
						net.WriteUInt(sid, 15)
						net.WriteEntity(npc)
					net.SendToServer()
				end

				if ans[2].openid then
					MCS.Dialogue.OpenDialogue(ans[2].openid)
					return
				end

				if not MCS.AddonList[id]["donotclose"] then
					MCS.Dialogue.DoClose()
				end

				return
			end

			local random_v = ans[2][math.random(#ans[2])]

			if MCS.Dialogue.dialogs[random_v] then
				MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[random_v], random_v)
			end
		else
			if MCS.AddonList[ans[2]] and MCS.AddonList[ans[2]]["enabled"] then
				if MCS.AddonList[ans[2]]["function"] then
					MCS.AddonList[ans[2]]["function"](npc)
				end

				if MCS.AddonList[ans[2]]["function_sv"] then
					net.Start("MCS.Dialogue")
						net.WriteUInt(mid, 15)
						net.WriteUInt(sid, 15)
						net.WriteEntity(npc)
					net.SendToServer()
				end
			end

			if MCS.AddonList[ans[2]] and MCS.AddonList[ans[2]]["donotclose"] then return end
			MCS.Dialogue.DoClose()
		end

		if ans[3] then
			ans[3](npc)
		end

		if npc and npc.GetInputLimit and npc:GetInputLimit() and ans[5] and isstring(ans[5]) then
			net.Start("MCS.SrartAnimation")
			net.WriteString(ans[5])
			net.WriteBool(false)
			net.SendToServer()
		end
	end

	if not npc then
		MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[1], 1)
		return
	end

	local npc_t = MCS.Spawns[npc:GetUID()]

	if npc_t.themeCallback then
		npc_t.themeCallback(theme, MCS.Dialogue)
	end

	if MQS and MQS.HasQuest() then
		local q = MQS.HasQuest()
		local obj = MQS.GetNWdata(LocalPlayer(), "quest_objective")
		obj = MQS.Quests[q.quest].objects[obj]

		if obj.type == "Talk to NPC" and obj.npc == npc:GetUID() then
			if npc_t and npc_t.quest_random then
				local random_v = npc_t.quest_random[math.random(#npc_t.quest_random)]
				MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[random_v], random_v)
			else
				MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[obj.dialog], obj.dialog)
			end
			return
		end
	end

	if npc_table.extracheck and tonumber(npc_table.extracheck() or 0) > 0 then
		local id = npc_table.extracheck()
		MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[id], id)
		return
	end

	if npc_table.teams and npc_table.teams[LocalPlayer():Team()] then
		MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[npc_table.teams[LocalPlayer():Team()]], npc_table.teams[LocalPlayer():Team()])
		return
	end

	if npc_t and npc_t.random_dialog then
		local random_v = npc_t.random_dialog[math.random(#npc_t.random_dialog)]
		MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[random_v], random_v)
	else
		MCS.Dialogue.OpenDialogue(MCS.Dialogue.dialogs[1], 1)
	end
end

function MCS.DialogSound(soundpath, vol, npc)
	if IsValid(MCS.Dialogue.Sound) then
		MCS.Dialogue.Sound:Stop()
		MCS.Dialogue.Sound = nil
	end

	local url = false

	if string.StartWith(soundpath, "http") then
		url = true
	end

	if not string.StartWith(soundpath, "sound/") and not url then
		soundpath = "sound/" .. soundpath
	end

	if url then
		sound.PlayURL(soundpath, "noplay", function(station)
			MCS.StopSounds()

			if IsValid(MCS.Dialogue) and IsValid(station) then
				MCS.Dialogue.Sound = station
				MCS.Dialogue.Sound:Play()
				MCS.Dialogue.Sound:SetVolume(vol)
			else
				LocalPlayer():ChatPrint("[MCS] Invalid sound URL", soundpath)
			end
		end)
	else
		sound.PlayFile(soundpath, "noplay", function(station, errCode, errStr)
			MCS.StopSounds()

			if (IsValid(station)) then
				MCS.Dialogue.Sound = station
				MCS.Dialogue.Sound:Play()
				MCS.Dialogue.Sound:SetVolume(vol)
				--npc:AddLayeredSequence( npc:LookupSequence("g_fist"), 2 )

				npc:SetLayerSequence(2, npc:LookupSequence("g_fist"))

			else
				print("[MCS] Error playing sound", soundpath, errCode, errStr)
			end
		end)
	end
end

MCS.Themes["Default"] = {}
local theme = MCS.Themes["Default"]

theme.Colors = {
	main = MCS.Config.Main.NPCColor,
	sub = MCS.Config.Main.PlayerColor,
	gray = Color(155,155,155),
}

theme.Mats = {
	grad = Material("gui/center_gradient.vtf"),
}

theme.FadeIn = true
theme.InProgress = false
theme.DrawPlayer = true

theme.Cam = {
	pos = Vector(0, 0, 0),
	ang = Angle(0, 0, 0),
	fov = 90,
	state = 1,
	rotate = 210,
	laste_change = 0,
	state_change = 10,
}

theme.Process = function(base)
	local ent
	local CT = CurTime()
	local npc = base.NPC
	local ply = LocalPlayer()

	if not IsValid(npc) then
		ent = ply
		theme.Cam.state = nil
	end

	if theme.Cam.state == 1 then
		ent = npc
	else
		ent = ply
	end

	local head = ent:LookupBone("ValveBiped.Bip01_Head1")
	if not head then return end
	local sPos, sAng = ent:GetBonePosition(head)
	if not sPos then return end

	if theme.Cam.laste_change < CT then
		theme.Cam.laste_change = CT + 30
		theme.Cam.state_change = -theme.Cam.state_change
		theme.Cam.rotate = math.Rand(20, 22) * theme.Cam.state_change
	end

	sAng = Angle(0, ent:GetAngles().y, 0)
	sAng:RotateAroundAxis(sAng:Up(), theme.Cam.rotate)

	if not base.AnimInit then
		base.AnimInit = true
		theme.Cam.pos = ply:EyePos()
		theme.Cam.ang = ply:GetAngles()
	end

	local tr = util.TraceLine({
		start = sPos,
		endpos = sPos - sAng:Forward() * 45,
		filter = ent
	})

	local speed = FrameTime() * 3
	if base.Closing then
		tr.HitPos = ply:EyePos()
		sAng = ply:GetAngles()
		speed = FrameTime() * 8
		theme.DrawPlayer = false
	end

	theme.Cam.pos = LerpVector(speed, theme.Cam.pos, tr.HitPos)
	theme.Cam.ang = LerpAngle(speed, theme.Cam.ang, sAng)
	theme.Cam.fov = Lerp(speed, theme.Cam.fov, theme.Cam.state == 1 and 55 or 90)
end

theme.OnClose = function(base)
	base.Closing = true
end

theme.FramePaint = function(self, w, h)
	if MCS.Config.Main.Vignette then
		MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.vignette, color_black)
	end
end

theme.FrameBuild = function(base)
	theme.DrawPlayer = true
	theme.Colors = {
		main = MCS.Config.Main.NPCColor,
		sub = MCS.Config.Main.PlayerColor,
		gray = Color(155,155,155),
	}

	local sw, sh = base:GetWide(), base:GetTall()
	--local textspd = math.Clamp(MCS.Config.TextSpeed, 1, 10)
	base.panelPLY = vgui.Create("MSDPanelList", base)
	base.panelPLY:SetSize(sw - sw / 8, 200)
	base.panelPLY:SetPos(sw / 16, sh - sh / 3 + 10)
	base.panelPLY:EnableVerticalScrollbar()
	base.panelPLY:EnableHorizontal(true)
	base.panelPLY:SetSpacing(2)
	base.panelPLY:SetAlpha(1)
	base.panelPLY.IgnoreVbar = false
	base.panelPLY.Paint = function(self, w, lh)
		if MCS.Config.Main.Frame then
			local h = self:GetCanvas():GetTall() + 5
			if h > lh then h = lh end
			-- draw.RoundedBox(0, 0, 0, w, h, MSD.Theme.d)
			-- MCS.Blur(self, 2, 2, 255, w, h)
			MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.gradient, MSD.Theme.d)
			MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.gradient_center, MSD.Theme.d)
		end
	end

	base.panelPLY.UpdateF = function()
		base.panelPLY:Clear()
		local plyName = vgui.Create("Panel")

		plyName.StaticScale = {
			w = 1,
			fixed_h = 45,
			minw = 200,
			minh = 45
		}

		plyName.Paint = function(self, w, h)
			MSD.ShadowText(LocalPlayer():Name(), "Noire.32", 10, 0, MSD.Patern.MainColor["9"], TEXT_ALIGN_LEFT)
		end

		base.panelPLY:AddItem(plyName)
	end

	base.panelNPC = vgui.Create("DPanel", base)
	base.panelNPC:SetSize(sw - sw / 8, 55)
	base.panelNPC:SetPos(sw / 16, sh - sh / 3)
	base.panelNPC.line = ""
	base.panelNPC.text = ""
	base.panelNPC.typepos = 0
	base.panelNPC.typetime = 0

	base.panelNPC.Paint = function(self, w, h)
		if MCS.Config.Main.Frame then
			-- draw.RoundedBox(0, 0, 0, w, h, MSD.Theme.d)
			-- MCS.Blur(self, 2, 2, 255, w, h)
			MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.gradient_center, MSD.Theme.d)
		end

		MSD.ShadowText(base.npc_table.name, "Noire.32", 10, 0, MSD.Patern.MainColor.p, TEXT_ALIGN_LEFT)
		local text, _, th = MSD.TextWrap(self.line, "MSDFont.28", w - 15)
		MSD.ShadowText(text, "MSDFont.28", 10, 45, color_white, TEXT_ALIGN_LEFT)
		local nph = 55 + th
		if nph > h then
			self:SetSize(w, nph)

			local y = sh - (base.panelPLY:GetTall() + 5)
			local sy = y - (nph + 20)
			base.panelPLY:SetY(y)

			if sy and sy ~= self:GetY() then
				base.panelNPC:SetY(sy)
			end
		end
	end

	base.panelNPC.Think = function(self)
		local CT = CurTime()

		if (CT > self.typetime) and self.text ~= self.line and base:GetAlpha() > 150 then

			if IsValid(MCS.Dialogue.Sound) then
				local spos = MCS.Dialogue.Sound:GetTime() / MCS.Dialogue.Sound:GetLength()

				self.typepos = math.Round( self.len * spos )
				self.typetime = CT + 0.0001
			else
				self.typepos = self.typepos + 1
				self.typetime = CT + 0.02
			end

			self.line = string.subUTF8(self.text, 1, self.typepos)

			if input.IsMouseDown(MOUSE_FIRST) then
				self.typetime = CT + 10
				self.typepos = string.len(self.text)
				self.line = self.text
			end
		end

		if self.text == self.line and base.panelPLY and not self.changed then
			self.changed = true
			--theme.Cam.state = 2
			base.panelPLY:AlphaTo(255, 0.3, 0.3)
			-- base.panelNPC:MoveTo(sw / 16, sh - sh / 3 + 10, 0.3)
		end
	end
end

theme.FrameUpdate = function(base, dialog, id, npc)
	local sw, sh = base:GetWide(), base:GetTall()
	base.panelNPC.typepos = 0
	base.panelNPC.typetime = 0
	base.panelNPC.changed = nil
	local text, answ = dialog["Line"], nil
	if dialog["Formater"] then
		text = dialog["Formater"](text)
	end

	if dialog["Formater_SV"] then
		net.Start("MCS.Formater")
			net.WriteUInt(id, 15)
			net.WriteEntity(npc)
		net.SendToServer()
	end

	base.panelNPC.text = text
	base.panelNPC.line = ""
	base.panelNPC.answ = answ
	base.panelNPC.len = utf8.len(text)
	base.panelNPC:SetTall(55)
	base.panelNPC:SetPos(sw / 16, sh - sh / 3)
	base.panelPLY:SetAlpha(0)
	base.panelPLY.UpdateF()
	theme.Cam.laste_change = CurTime() + 30
	theme.Cam.state = 1
end

local answ_cls = {
	r = Color(255,255,255),
	a = Color(255,232,100),
	c = Color(255,91,91)
}

theme.PopulateAns = function(base, k, ans, mid)
	local button = vgui.Create("DButton", bg)

	button.StaticScale = {
		w = 1,
		fixed_h = 27,
		minw = 200,
		minh = 27
	}

	button:SetText("")
	button.fade = 0
	button.text = ans[1]

	local ans_cl = (ans[2] == "close" and not ans[3]) and answ_cls.c or answ_cls.r

	if ans[3] or istable(ans[2]) or (isstring(ans[2]) and ans[2] ~= "close") then
		ans_cl = answ_cls.a
	end

	if ans[6] then
		button.text = ans[6]()
	end

	button.Paint = function(self, w, h)
		if self.hover then
			self.fade = Lerp(FrameTime() * 7, self.fade, 1)
		else
			self.fade = Lerp(FrameTime() * 7, self.fade, 0)
		end

		local text, _, texth = MSD.TextWrap(self.text, "MSDFont.28", w - 5)

		if texth > self.StaticScale.minh and w > 200 then
			self.StaticScale.minh = texth
			self.StaticScale.fixed_h = texth
			base.panelPLY:PerformLayout()
		end

		MSD.ShadowText(text, "MSDFont.28", 10, 0, MSD.ColorAlpha(ans_cl, 255 - self.fade * 255), TEXT_ALIGN_LEFT)
		draw.DrawText(text, "MSDFont.28", 10, 0,  MSD.ColorAlpha(theme.Colors.main, self.fade * 255), TEXT_ALIGN_LEFT)
	end

	button.DoClick = function()
		if base.panelPLY:GetAlpha() > 200 then
			base.DoAnswer(ans, k, mid)
		end
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	base.panelPLY:AddItem(button)
end

hook.Add("HUDShouldDraw", "MCS.DefaultTheme.HideHUD", function()
	if theme.InProgress then return false end
end)

hook.Add("CalcView", "MCS.DefaultTheme.CalcView", function(ply, pos, angles, fov)
	if not MCS.Config.EnableCamera then return end
	if theme.InProgress then
		local view = {
			origin = theme.Cam.pos,
			angles = theme.Cam.ang,
			fov = theme.Cam.fov,
			drawviewer = theme.DrawPlayer
		}

		return view
	else
		theme.Cam.fov = fov
	end
end)

net.Receive("MCS.Formater", function()
	local name = net.ReadString()
	local snd = net.ReadString()
	local data = net.ReadTable()

	if not IsValid(MCS.Dialogue) or not MCS.Dialogue.CurrentTable then return end

	local dialog = table.Copy(MCS.Dialogue.CurrentTable)

	dialog["Line"] = name
	dialog["Sound"] = snd
	dialog["Formater_SV"] = nil

	MCS.DialogSound(dialog["Sound"], 1, MCS.Dialogue.NPC)

	theme.FrameUpdate(MCS.Dialogue, dialog, MCS.Dialogue.Current, MCS.Dialogue.NPC)

	if not data then
		theme.PopulateAns(MCS.Dialogue, 1, {"...", "close"})
	else
		for k, ans in pairs(data) do
			theme.PopulateAns(MCS.Dialogue, k, ans, MCS.Dialogue.Current)
		end
	end
end)