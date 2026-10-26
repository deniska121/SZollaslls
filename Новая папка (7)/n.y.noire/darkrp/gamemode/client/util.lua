--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/client/util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DarkRP.UIEffects = {}

local cpct = false

function DarkRP.PoliceChatter(snd, state)
	if cpct and not state then return end

	cpct = true

	state = state or 1

	local snds = {
		"sound/npc/overwatch/radiovoice/on3.wav",
	}

	if istable(snd) then
		table.Add(snds, snd)
	else
		table.insert(snds, snd)
	end

	table.insert(snds, "sound/npc/overwatch/radiovoice/off2.wav")

	if state > #snds then cpct = false return end

	sound.PlayFile(snds[state], "noplay", function( station, errCode, errStr )
		if ( IsValid( station ) ) then
			station:Play()
			timer.Simple(station:GetLength(), function() DarkRP.PoliceChatter(snd, state + 1) end)
		else
			cpct = false
		end
	end )
end

local bbox = {
	smin	=	Vector( -12, -12, 0 ),
	smax	=	Vector( 12, 12, 70 ),
	dmin	=	Vector( -12, -12, 0 ),
	dmax	=	Vector( 12, 12, 36 ),
}

DarkRP.UIEffects["SpawnFunctions"] = function(data)
	LocalPlayer():SetHull(bbox.smin, bbox.smax)
	LocalPlayer():SetHullDuck(bbox.dmin, bbox.dmax)
end

DarkRP.UIEffects["PlaySound"] = function(data)
	sound.PlayFile("sound/" .. data[1], "noblock", function(station, errCode, errStr)
		if IsValid(station) then
			station:SetVolume(1)
		end
	end)
end

DarkRP.UIEffects["policeChatter"] = function(data)
	DarkRP.PoliceChatter(data)
end

DarkRP.UIEffects["openbook"] = function(data)
	MSD.LoadBook(data[1])
end

DarkRP.UIEffects["opendoc"] = function(data)
	DarkRP.LoadDock(data[1])
end

DarkRP.UIEffects["tattoomenu"] = function(data)
	MSD.OpenTattooMenu()
end

local bl_init = 0
local w, h = ScrW(), ScrH()

DarkRP.UIEffects["blackScreen"] = function(data)
	if data[1] then
		bl_init = 0
		hook.Add("DrawOverlay", "BlackScreen", function()
			if data[2] then
				bl_init = math.Approach(bl_init, 1, FrameTime() * 0.8)
			else
				bl_init = 1
			end
			surface.SetDrawColor(MSD.ColorAlpha(color_black, bl_init * 255))
			surface.DrawRect(0, 0, w, h)
		end)
	else
		if data[2] then
			bl_init = 1
			hook.Add("DrawOverlay", "BlackScreen", function()
				if bl_init > 0 then
					bl_init = math.Approach(bl_init, 0, FrameTime() * 0.8)
				else
					hook.Remove("DrawOverlay", "BlackScreen")
				end
				surface.SetDrawColor(MSD.ColorAlpha(color_black, bl_init * 255))
				surface.DrawRect(0, 0, w, h)
			end)
		else
			hook.Remove("DrawOverlay", "BlackScreen")
		end
	end
end

local n_colors = {
	[0] = DarkRP.Hud.Patern["yellow"],
	[1] = DarkRP.Hud.Patern["red"],
	[2] = DarkRP.Hud.Patern["yellow"],
	[3] = DarkRP.Hud.Patern["yellow"],
	[4] = DarkRP.Hud.Patern["blue"],
}

DarkRP.UIEffects["ChatText"] = function(data)
	chat.AddText( n_colors[data.type], "[!] ", DarkRP.Hud.Patern["main_l"], data.text )
end

DarkRP.UIEffects["WantedStatus"] = function(data)
	local ply = Player(data.ply)
	if not LocalPlayer().isCP or not LocalPlayer():isCP() or not IsValid(ply) then return end
	MQS.UdpateTracking(ply:GetPos(), MSD.PinPoints[8])
end

DarkRP.UIEffects["AdminLog"] = function(data)
	MsgC(color_white, "[")
	MsgC(MSD.Patern.MainColor["p"], data.prf or "CityRP")
	MsgC(color_white, "] ")
	MsgC(data.cl,  data.msg .. "\n")
end

DarkRP.UIEffects["anim_dropitem"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	ply.anim_DroppingItem = true
end

DarkRP.UIEffects["ShowModelR"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	ply.smdr = {CurTime() + data[2], data[3], data[4], data[5]}
end

DarkRP.UIEffects["ShowModelL"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	ply.smdl = {CurTime() + data[2], data[3], data[4], data[5]}
end

DarkRP.UIEffects["DoorLock"] = function(data)
	DarkRP.Hud.DoorPrint(data[1])
end

DarkRP.UIEffects["showpass"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	DarkRP.OpenPassport(ply)
end

DarkRP.UIEffects["showpdid"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	DarkRP.OpenPDid(ply)
end

DarkRP.UIEffects["_DarkRP_CustomAnim"] = function(data)
	local ply = Player(tonumber(data[1]))
	local act = tonumber(data[2])

	if not IsValid(ply) then return end
	ply:AnimRestartGesture(GESTURE_SLOT_CUSTOM, act, true)
end

DarkRP.UIEffects["plyAnimSetCycle"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	ply:SetCycle(0)
end

DarkRP.UIEffects["PlayerGesture"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	DarkRP.PlayerGesture(ply, data[2], data[3], data[4])
end

DarkRP.UIEffects["anim_giveitem"] = function(data)
	local ply = Player(tonumber(data[1]))
	if not IsValid(ply) then return end
	ply.anim_GivingItem = true
end

DarkRP.UIEffects["unconscious"] = function(data)
	local ent = Entity(tonumber(data[1]))
	local ply = Player(tonumber(data[2]))
	if not IsValid(ent) or not IsValid(ply) then return end
	ply.DeathRagdoll = ent
	ent.playerUncon = ply
end

DarkRP.UIEffects["OpenAdminMenu"] = function(data)
	MSD.OpenAdminMenu()
end

DarkRP.UIEffects["debug"] = function(data)
	local cl = Color(255,145,0)

	if data[3] then
		cl = Color(255,0,0)
	end

	debugoverlay.Line( data[1], data[2], 5, cl)
	debugoverlay.Sphere( data[1], 1, 5, Color(255,0,0))
	debugoverlay.Sphere( data[2], 1, 5, Color(255,0,0))
	-- local dm = math.Round(data[2],1)
	-- debugoverlay.EntityTextAtPosition( data[1], 0, dm, 5, Color(255,145,0))
	-- debugoverlay.Line( data[1], data[3]:GetShootPos(), 3, Color(255,145,0))
end

DarkRP.UIEffects["hitef"] = function(data)
	--DarkRP.Hud.HitMark()
end

DarkRP.UIEffects["anim_keys"] = function(data)
	local ply = Player(data.ply)
	ply[data.type] = true
end

DarkRP.UIEffects["CutScene"] = function(data)
	data = data or {}
	local camPos = data[3] or Vector(7300,7907.7353,404.24380)
	local camAngles = data[4] or Angle(-10,0,0)
	local start, bl, color = CurTime(), 1, MSD.Patern.MainColor["p"]
	local text2
	local fov = 70
	hook.Add("DrawOverlay", "CutScene", function()
		fov = math.Approach(fov, 50, FrameTime() * 0.8)
		render.RenderView({
			origin = camPos,
			angles = camAngles,
			fov = fov,
			drawviewmodel = false,
			drawhud = false,
			x = 0,
			y = 0,
			w = w,
			h = h
		})

		if start + 2 > CurTime() then
			bl = math.Approach(bl, 0, FrameTime() * 0.8)
		end

		if start + 9 < CurTime() then
			bl = math.Approach(bl, 1, FrameTime() * 0.8)
		end

		MSDX.Draw(0, 0, 0, w, h / 8, color_black)
		MSDX.Draw(0, 0, h - h / 8, w, h / 8, color_black)
		draw.SimpleText(utf8.upper(data[2] or "ВАС АРЕСТОВАЛИ"), "Noire.Big", w / 2, 25, color, TEXT_ALIGN_CENTER, 0)

		if not text2 then text2 = MSD.TextWrap(data[1] or "", "MSDFont.28", h) end
		draw.SimpleTextOutlined(text2, "MSDFont.Big", w / 2, h - h / 10 + 10, icon_color, TEXT_ALIGN_CENTER, 0, 1, color_black)

		surface.SetDrawColor(MSD.ColorAlpha(color_black, bl * 255))
		surface.DrawRect(0, 0, w, h)
	end)

	timer.Simple(9.5, function()
		DarkRP.UIEffects["blackScreen"]({true, true})
	end)

	timer.Simple(10, function()
		hook.Remove("DrawOverlay", "CutScene")
		DarkRP.UIEffects["blackScreen"]({false, true})
	end)
end

DarkRP.UIEffects["OpenCharacterCreator"] = function(data)
	hook.Remove("DrawOverlay", "BlackScreen")
	MCR.OpenCharacterCreator()
end

DarkRP.UIEffects["DoVote"] = function(data)
	DarkRP.MsgDoVote(data.msg, data.id, tonumber(data.time) or 0)
end

DarkRP.UIEffects["DoQuestion"] = function(data)
	DarkRP.MsgDoQuestion(data.msg, data.id, tonumber(data.time) or 0)
end

DarkRP.UIEffects["KillVoteVGUI"] = function(data)
	DarkRP.KillVoteVGUI(data[1])
end

DarkRP.UIEffects["KillQuestionVGUI"] = function(data)
	DarkRP.KillQuestionVGUI(data[1])
end

DarkRP.UIEffects["FocuseOnEnt"] = function(data)
	DarkRP.ViewFocus = {
		ent = ents.GetByIndex(tonumber(data[1])),
		ang = tonumber(data[2]),
		point = data[3],
		fade = false
	}
end

DarkRP.UIEffects["UnFocuseOnEnt"] = function(data)
	if DarkRP.ViewFocus then
		DarkRP.ViewFocus.fade = true
	end
end

DarkRP.UIEffects["MCRChange"] = function(data)
	LocalPlayer().ischanging = data[1]
end

DarkRP.UIEffects["PlaySound"] = function(data)
	surface.PlaySound(data[1])
end

DarkRP.UIEffects["StartHalloween"] = function(data)
	surface.PlaySound(data[1])
	DarkRP.Halloween = 0
end

DarkRP.UIEffects["StopHalloween"] = function(data)
	DarkRP.Halloween = nil
end

DarkRP.UIEffects["radio_open"] = function(data)
	local ent = ents.GetByIndex(tonumber(data.idx))
	if not IsValid(ent) then return end
	RadioUIOpen(ent, true)
end

DarkRP.UIEffects["boom_big"] = function(data)
	local ent = Entity(tonumber(data[1]))
	if not IsValid(ent) then return end

	if LocalPlayer():GetPos():DistToSqr(ent:GetPos()) < 1000000 then
		surface.PlaySound("gb_sfx/snd_big_exp.wav")
	end

	local ed = EffectData()
	ed:SetScale(5000)
	ed:SetOrigin(ent:GetPos())
	ed:SetRadius(512)
	ed:SetMagnitude(1000)
	ed:SetScale(1000)
	ed:SetEntity(ent)
	util.Effect("ShakeRopes", ed)
end

local tab = {
	[ "$pp_colour_addr" ] = 0.02,
	[ "$pp_colour_addg" ] = 00,
	[ "$pp_colour_addb" ] = 0,
	[ "$pp_colour_brightness" ] = 0,
	[ "$pp_colour_contrast" ] = 1,
	[ "$pp_colour_colour" ] = 1,
	[ "$pp_colour_mulr" ] = 1,
	[ "$pp_colour_mulg" ] = 0,
	[ "$pp_colour_mulb" ] = 0
}

DarkRP.UIEffects["headshot"] = function(data)
	local effectdata = EffectData()
	effectdata:SetOrigin(data[1])
	effectdata:SetFlags(3)
	effectdata:SetColor(0)
	effectdata:SetScale(6)
	util.Effect("bloodspray", effectdata)
	util.Effect("BloodImpact", effectdata)
end

DarkRP.UIEffects["hookah2"] = function(data)
	local ent = ents.GetByIndex(tonumber(data.idx))
	if not IsValid(ent) then return end

	if not ent.hookah_ef then
		ent.hookah_ef = ParticleEmitter(ent:GetPos())
	end

	local isp = ent:IsPlayer()

	if ent.hookah_ef then
		local pos = ent:GetPos() + ent:GetAngles():Up() * 20

		if isp then
			pos = ent:GetShootPos() + ent:GetAngles():Forward() * 10
		end
		for i = 1, (isp and 15 or 5) do
			local particle = ent.hookah_ef:Add("particle/particle_smokegrenade", pos)
			particle:SetVelocity(VectorRand() + ent:GetAngles():Forward() * (isp and 5 or 25))
			particle:SetDieTime(math.random(30,55))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetColor(155, 155, 155)
			particle:SetStartSize(1)
			particle:SetEndSize(50)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetAirResistance(120)
			particle:SetCollide(true)
			particle:SetBounce(0.2)
			particle:SetGravity(VectorRand() * 5)
		end
	end
end

DarkRP.UIEffects["hookah"] = function(data)
	hook.Add("RenderScreenspaceEffects", "DrubEffect1", function()
		tab["$pp_colour_colour"] = 1 +  math.abs(math.sin(CurTime()))
		DrawColorModify( tab )
	end)

	timer.Create("DrubEffect1", math.random(10,30), 1, function()
		hook.Remove("RenderScreenspaceEffects", "DrubEffect1")
	end)
end

DarkRP.UIEffects["atm_open"] = function(data)
	local ent = ents.GetByIndex(tonumber(data.idx))
	if not IsValid(ent) then return end

	ent:OpenMenu()
end

local flare = Material("effects/blueflare1")

DarkRP.UIEffects["flashbang"] = function(data)
	surface.PlaySound("gb_sfx/snd_big_exp.wav")

	if LocalPlayer():checkDarkRPVar("face", "weldingmask") then return end

	local directionAngCos = math.cos(math.pi / 4)
	local aimVector = LocalPlayer():GetAimVector()
	local entVector = data[2] - LocalPlayer():GetShootPos()
	local angCos = aimVector:Dot(entVector) / entVector:Length()
	data[1] = angCos >= directionAngCos and data[1] or data[1] / 3

	local endtime = CurTime() + data[1] * 100
	local anim = 1
	local fp = data[2]:ToScreen()

	--timer.Simple(0.02, function()
		hook.Add("HUDPaint", "Flash.Effect", function()
			local CT = CurTime()
			local wd = ScrW()

			anim = (endtime - CurTime()) / 100

			local cl = MSD.ColorAlpha(color_white, anim * 155)

			MSD.DrawTexturedRect(fp.x - wd / 2, fp.y - wd / 2, wd, wd, flare, cl)

			surface.SetDrawColor(cl)
			surface.DrawRect(0, 0, wd, ScrH())

			DrawMotionBlur(0, anim * 4, 0)

			if endtime < CT then
				hook.Remove("HUDPaint", "Flash.Effect")
			end
		end)
	--end)
end

DarkRP.UIEffects["ban_info"] = function(data)
	MCR.BANINFO = data
end

DarkRP.UIEffects["smoke"] = function(data)
	local ent = ents.GetByIndex(tonumber(data.idx))
	if not IsValid(ent) then return end
	local i = ent:LookupAttachment("mouth")
	if not i then return end
	local att = ent:GetAttachment(i)
	if not att then return end
	local pos, ang = att.Pos, att.Ang

	if not ent.hookah_ef then
		ent.hookah_ef = ParticleEmitter(ent:GetPos())
	end

	if ent.hookah_ef then
		for e = 1, 5 do
			local particle = ent.hookah_ef:Add("particle/particle_smokegrenade", pos)
			particle:SetVelocity(ang:Forward() * 12)
			particle:SetDieTime(math.random(5,7))
			particle:SetStartAlpha(255)
			particle:SetEndAlpha(0)
			particle:SetColor(120, 120, 120)
			particle:SetStartSize(1)
			particle:SetEndSize(15)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetAirResistance(120)
			particle:SetCollide(true)
			particle:SetBounce(0.2)
			particle:SetGravity(VectorRand() * 5)
		end
	end

	if ent == LocalPlayer() then
		DarkRP.Hud.SmokeEf()
	end
end

DarkRP.UIEffects["overdose"] = function(data)
	local anim = 0
	hook.Add("RenderScreenspaceEffects", "OverDose", function()
		anim = math.Approach(anim, 1, FrameTime() * 0.1)
		tab["$pp_colour_mulr"] = math.sin(CurTime()) * (anim * 5)
		DrawColorModify( tab )
		DrawSharpen(anim * 2, anim * 3)
		DrawToyTown(anim * 10, (h / 3) * anim)
	end)

	timer.Create("DrubEffect1", 15, 1, function()
		hook.Remove("RenderScreenspaceEffects", "OverDose")
	end)
end

DarkRP.UIEffects["NLR"] = function(data)
	local alpha = 0
	local t_dist = 2000000
	local color_red = Color(255,0,0)
	hook.Add("HUDPaint", "NLR", function()
		if data[2] + 1300 < CurTime() then
			hook.Remove("HUDPaint", "NLR")
			return
		end

		local pl_pos = LocalPlayer():GetPos()
		local dist = pl_pos:DistToSqr(data[1])

		if dist < t_dist then
			alpha = Lerp(FrameTime() * 7, alpha, 1)
		else
			alpha = Lerp(FrameTime() * 7, alpha, 0)
		end

		tab["$pp_colour_colour"] = 1 - alpha
		DrawColorModify( tab )

		surface.SetMaterial(DarkRP.Hud.Materials["vignette"])
		surface.SetDrawColor(0, 0, 0, 255 * alpha)
		surface.DrawTexturedRect(0, 0, w, h)

		local _, hd = draw.SimpleTextOutlined("Внимание! Вы нарушаете правило NLR!", "Noire.Big", w / 2, h / 4 - 50, MSD.ColorAlpha(color_red, alpha * 255), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, alpha * 100))
		draw.SimpleTextOutlined("Вы на месте своей смерти, покиньте его до получения наказания!", "MSDFont.36", w / 2, h / 4 + hd - 50, MSD.ColorAlpha(color_white, alpha * 255), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, alpha * 100))
	end)
end

DarkRP.UIEffects["unNLR"] = function(data)
	hook.Remove("HUDPaint", "NLR")
end

local efcts = {
	{"gb_sfx/sndtinnitushospital.wav", 7},
	{"gb_sfx/sndhospitaltinnitus.wav", 15},
}

DarkRP.UIEffects["headache"] = function(data)
	local tab1 = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_inv"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	local effect = efcts[math.random(#efcts)]

	local startt = CurTime()
	local anim = 0
	surface.PlaySound(effect[1])

	hook.Add("HUDPaint", "Headache.Effect", function()
		local CT = CurTime()
		if startt + effect[2] / 2 < CT then
			anim = Lerp(FrameTime() * 9, anim, 0)
		else
			anim = Lerp(FrameTime() * 5, anim, 1)
		end

		tab1["$pp_colour_colour"] = 1 - anim
		DrawColorModify(tab1)

		if anim > 0.5 then
			DrawMotionBlur(0.4, 0.8, 0.01 + anim * 0.01 )
			util.ScreenShake( Vector(0, 0, 0), 1, 0.1, 1, 0 )
		end

		if startt + effect[2] + 3 < CT then
			hook.Remove("HUDPaint", "Headache.Effect")
		end
	end)
end

DarkRP.UIEffects["johnache"] = function(data)
	local tab1 = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_inv"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	local time = data[1]
	local startt = CurTime()

	local ja = MSD.Anim(time / 2)
	ja:Start()

	hook.Add("HUDPaint", "Headache.Effect", function()
		local CT = CurTime()

		if startt + (time - 2) < CT and not ja.donerev then
			ja.donerev = true
			ja.D = 3
			ja:Reverse()
			ja:Start()
		end

		ja:Play()

		tab1["$pp_colour_colour"] = 1 - ja.Value * 0.5

		DrawColorModify(tab1)
		DrawSharpen( ja.Value * 3, ja.Value * 1.2)

		MSDX.Draw(0, 0, 0, w, (h / 6) * ja.Value, color_black)
		MSDX.Draw(0, 0, h - ((h / 6) * ja.Value), w, h / 6, color_black)

		if startt + time + 3 < CT then
			hook.Remove("HUDPaint", "Headache.Effect")
		end
	end)
end

DarkRP.UIEffects["lsd"] = function(data)
	local tab1 = {
		["$pp_colour_addr"] = 0,
		["$pp_colour_addg"] = 0,
		["$pp_colour_addb"] = 0,
		["$pp_colour_inv"] = 0,
		["$pp_colour_brightness"] = 0,
		["$pp_colour_contrast"] = 1,
		["$pp_colour_colour"] = 1,
		["$pp_colour_mulr"] = 0,
		["$pp_colour_mulg"] = 0,
		["$pp_colour_mulb"] = 0
	}

	local time = 180
	local startt = CurTime()
	local ja = MSD.Anim(27)
	local pa = MSD.Anim(math.random(1, 3) * 10)
	local f2 = false

	LocalPlayer().nark_effect = true
	if MCR.Sound then
		MCR.Sound:Stop()
		MCR.Sound = nil
	end

	sound.PlayURL("https://macnco.one/music/narc.mp3", "noblock noplay", function( station )
		if ( IsValid( station ) ) then
			MCR.Sound = station
			ja:Start()
		end
	end)

	hook.Add("HUDPaint", "NLR", function()
		if (IsValid(MCR.Sound)) then
			MCR.Sound:Play()
			MCR.Sound:SetVolume(ja.Value)
			MCR.Loaded = true
		else
			return
		end

		local CT = CurTime()

		if startt + (time - 2) < CT and not ja.donerev then
			ja.donerev = true
			ja.D = 3
			ja:Reverse()
			ja:Start()
		end

		if not f2 and ja.Value == 1 then pa:Start() f2 = true end
		if f2 then
			pa:Play()
			DrawMaterialOverlay( "effects/strider_bulge_dudv", math.sin(CurTime() * 2) * pa.Value * 0.05 * ja.Value )
			tab1["$pp_colour_addr"] = ja.Value * pa.Value * math.sin(CurTime() * 2) * 0.1
			tab1["$pp_colour_addg"] = ja.Value * pa.Value * math.sin(CurTime() * 3) * 0.1
			tab1["$pp_colour_addb"] = ja.Value * pa.Value * math.sin(CurTime() * 4) * 0.1
			DrawSharpen( ja.Value * pa.Value * 3, ja.Value * pa.Value * 1.2)

			for k,prop in pairs(ents.FindInSphere(LocalPlayer():GetPos(), 500)) do
				if not IsValid(prop) or not (prop:IsPlayer() or prop:GetClass() == "prop_physics") then continue end
				if LocalPlayer() == prop then continue end
				local scale = Vector(1 + ja.Value * pa.Value * math.abs(math.sin(CurTime() * 0.4)),1 + ja.Value * pa.Value * math.abs(math.sin(CurTime() * 0.2)),1 + ja.Value * pa.Value * math.abs(math.sin(CurTime() * 0.5)))

				local mat = Matrix()
				mat:Scale(scale)
				prop:EnableMatrix("RenderMultiply", mat)
				prop.nark = true
			end
		end

		ja:Play()

		tab1["$pp_colour_colour"] = 1 + ja.Value * 1.5
		tab1["$pp_colour_contrast"] = 1 + ja.Value * 0.7
		tab1["$pp_colour_mulr"] = math.sin(CurTime() * 2) * ja.Value * 1.7
		tab1["$pp_colour_mulg"] = math.sin(CurTime() * 3) * ja.Value * 1.1
		tab1["$pp_colour_mulb"] = math.sin(CurTime() * 5) * ja.Value * 1.4


		DrawColorModify(tab1)
		DrawMaterialOverlay( "effects/screen_refract", math.sin(CurTime()) * ja.Value * 0.5 )

		if startt + time + 3 < CT then
			hook.Remove("HUDPaint", "NLR")
			LocalPlayer().nark_effect = nil

			if MCR.Sound then
				MCR.Sound:Stop()
				MCR.Sound = nil
			end

			for k,prop in pairs(ents.GetAll()) do
				if not prop.nark then continue end
				prop:DisableMatrix("RenderMultiply")
				prop.nark = nil
			end
		end
	end)
end

DarkRP.UIEffects["trigger_event"] = function(data)
	local ent = ents.GetByIndex(tonumber(data.idx))
	if not IsValid(ent) or not ent.TriggeEvent then return end
	ent:Event(data)
end

local press = 0

function DarkRP.PressDelay(delay)
	local CT = CurTime()
	if press and press > CT then return true end
	press = CT + delay
	return false
end

local distsound = {
	["Reflection_Pistol.Distance"] = {"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_01.ogg", "viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_02.ogg", "viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_03.ogg", "viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_04.ogg", "viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_05.ogg", "viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_06.ogg"},
	["Reflection_AR.Distance"] = {"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_01.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_02.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_03.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_04.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_05.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_06.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_07.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_08.ogg"},
	["Reflection_AR.Sup.Distance"] = {"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_01.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_02.ogg","viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_03.ogg", "viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_04.ogg","viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_05.ogg","viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_06.ogg"},
	["Reflection_Sniper.Distance"] = {"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_01.ogg", "viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_02.ogg", "viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_03.ogg", "viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_04.ogg", "viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_05.ogg", "viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_06.ogg", "viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_07.ogg", "viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_08.ogg"},
	["Explosion_Medium"] = {"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_01.ogg", "viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_02.ogg", "viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_03.ogg", "viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_04.ogg"},
}

local distrev = {
	["Reflection_Pistol.Distance"] = 5000,
	["Reflection_AR.Distance"] = 7000,
	["Reflection_Shotgun.Distance"] = 6000,
	["Reflection_Sniper.Distance"] = 9000,
	["Explosion_Medium"] = 13000,
	["Reflection_AR.Sup.Distance"] = 5000
}

DarkRP.UIEffects["DistSound"] = function(data)
	if not data[2] or not distsound[data[2]] then return end

	local snd = distsound[data[2]]
	local dist = data[1]:DistToSqr(LocalPlayer():GetPos())

	local volume = 1

	if dist < 1000000 then
		volume = volume * dist / 1000000
	else
		volume = math.max(volume * (1 - (dist / (distrev[data[2]] or 3000) ^ 2)), 0)
	end

	if volume <= 0 then return end

	if snd[2] then
		snd = snd[math.random(#snd)]
	else
		snd = snd[1]
	end

	sound.PlayFile("sound/" .. snd, "3d noblock", function(station, errCode, errStr)
		if IsValid(station) then
			station:SetPos(data[1])
			station:Set3DFadeDistance( 20000, 1000000000 )
			station:SetVolume(volume)
		end
	end)
end

local tts = true

local dist = {
	[1] = 12100,
	[2] = 95500,
	[3] = 612500,
}

local multt = {
	[1] = 0.4,
	[2] = 1,
	[3] = 3,
}

local char_to_hex = function(c)
	return string.format("%%%02X", string.byte(c))
end

local charset = {
	["sh"] = "ш", ["ch"] = "ч",
	["a"] = "а", ["b"] = "б", ["v"] = "в", ["g"] = "г", ["d"] = "д",
	["e"] = "е", ["z"] = "з", ["i"] = "и", ["k"] = "к", ["l"] = "л",
	["m"] = "м", ["n"] = "н", ["o"] = "о", ["p"] = "п", ["r"] = "р",
	["s"] = "с", ["t"] = "т", ["u"] = "у", ["f"] = "ф", ["h"] = "х",
}

function urlencode(url)
	if url == nil then
		return
	end
	url = string.gsub(string.lower(url), ".", charset)
	url = string.Replace(url, "'", "")
	url = string.Replace(url, "\"", "")
	url = url:gsub("\n", "\r\n")
	url = url:gsub("([^%w ])", char_to_hex)
	url = url:gsub(" ", "+")
	return url
end

local tts_table = {
	male = {
		[1] = "aidar",
		[2] = "eugene",
		[3] = "aidar",
		[4] = "eugene",
		[5] = "aidar",
		[6] = "eugene",
		[7] = "eugene",
		[8] = "aidar",
		[9] = "eugene"
	},
	female = {
		[1] = "kseniya",
		[2] = "baya",
		[3] = "kseniya",
		[4] = "xenia",
		[5] = "baya",
		[6] = "xenia",
	}
}

local function shuffleTable(t)
	local n = #t
	for i = n, 2, -1 do
		local j = math.random(i)
		t[i], t[j] = t[j], t[i]
	end

	return t
end

net.Receive("GLA.OnPlayerChat", function()
	local prefixText = net.ReadString(name)
	local text = net.ReadString(msg)
	local col1 = net.ReadColor(false)
	local col2 = net.ReadColor(false)
	local ply = net.ReadEntity(ply)
	local notts = net.ReadBool()

	ply = IsValid(ply) and ply or LocalPlayer()

	if prefixText == "" or not prefixText then
		prefixText = ply:Nick()
		prefixText = prefixText ~= "" and prefixText or ply:SteamName()
	end

	if text and text ~= "" then
		if IsValid(ply) then
			shouldShow = hook.Call("OnPlayerChat", nil, ply, text, false, not ply:Alive(), prefixText, col1, col2)
		end

		if shouldShow ~= true then
			if LocalPlayer():getDarkRPVar("nark") then
				text = table.concat(shuffleTable(string.ToTable(text)))
			end

			chat.AddText(col1, prefixText, col2, ": " .. text)

			local rate = "24000"
			local radio = false

			if string.StartsWith(prefixText, "[Рация]") or string.StartsWith(prefixText, "[Телефон]") then
				rate = "8000"
				notts = false
				radio = true
				if string.StartsWith(prefixText, "[Рация]") then
					surface.PlaySound("radio/ground_short.wav")
				end
			end

			if tts and not notts and ply:Alive() then
				if IsValid(ply.tts) then
					ply.tts:Stop()
					ply.tts = nil
				end
				local url = urlencode(text)
				local voice = ply:getDarkRPVar("gender") == "female" and "sasha" or "kolya"
				local check = tts_table[ply:getDarkRPVar("gender")][tonumber(ply:getDarkRPVar("model"))]

				local mult = multt[ply:getDarkRPVar("voicedist")]
				local aval = string.Explode(" ", ply:getDarkRPVar("age"))[3] or 1980
				local age = ((2000 - aval) / 30) * 0.1

				if check then voice = check end
				local volume = mult - math.min(LocalPlayer():GetPos():DistToSqr(ply:GetPos()) / dist[ply:getDarkRPVar("voicedist")] , 1) * mult
				if radio then
					volume = 1
				end
				if volume <= 0 then return end
				DarkRP.SayPhrase(ply, text)
				sound.PlayURL("http://194.67.93.33:5010/getwav?text_to_speech=" .. url .. "&speaker=" .. voice .. "&sample_rate=" .. rate .. "&put_accent=1&put_yo=1", radio and "" or "3d", function(station)
					if IsValid(station) then
						if not radio then
							station:SetPos( LocalPlayer():GetPos() )
						end
						station:SetVolume(volume)
						station:SetPlaybackRate(1.13 - age)
						station:Play()
						ply.tts = station
					end
				end)
			end
		end
	else
		shouldShow = hook.Call("ChatText", nil, "0", prefixText, prefixText, "none")

		if shouldShow ~= true then
			chat.AddText(col1, prefixText)
		end

		if utf8.sub(prefixText, 1, 7) == "[Рация]" then
			surface.PlaySound("radio/ground_short.wav")
		end
	end

	chat.PlaySound()
end)

net.Receive("GLA.UIEffects", function()
	local effect = net.ReadString()
	local set = net.ReadBool()
	local data = {}

	if set == true then
		data = net.ReadTable()
	end

	if DarkRP.UIEffects[effect] then
		DarkRP.UIEffects[effect](data)
	end
end)

local ignore = {
	["gmod_sent_vehicle_fphysics_base"] = true,
	["gmod_sent_vehicle_fphysics_wheel"] = true,
}

local lasthlt = 0
local enthlt = {
	["spawned_food"] = Color(255,145,0),
	["spawned_weapon"] = Color(255,0,0),
	["spawned_ammo"] = Color(255,145,0),
	["spawned_junk"] = Color(255,145,0),
}

function DarkRP.higlightTattoo()
	if not MCR.HasTatoo(LocalPlayer(), "g5") then return end
	if lasthlt > CurTime() then return end
	lasthlt = CurTime() + 10

	for _,ent in ipairs(ents.FindInSphere(LocalPlayer():GetPos(), 300)) do
		if not enthlt[ent:GetClass()] then continue end
		cl = enthlt[ent:GetClass()]
		local dlight = DynamicLight(ent:EntIndex() .. 89)
		dlight.r = cl.r
		dlight.g = cl.g
		dlight.b = cl.b
		dlight.Brightness = 1
		dlight.Pos = ent:GetPos()
		dlight.Size = 100
		dlight.decay = 20
		dlight.DieTime = CurTime() + 5
	end
end

net.Receive("DarkRP.ItCommand", function()
	local reload = net.ReadUInt(2)

	if reload == 2 then
		hook.Remove("HUDPaint", "Info.HUDPaint")
		return
	end

	local bytes_number = net.ReadUInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local data = DarkRP.TableDecompress(compressed_data)
	local ply = LocalPlayer()

	if data.props then
		for id, text in pairs(data.props) do
			local ent = Entity(id)

			if not IsValid(ent) then continue end
			ent.text = text
		end
	else
		data.props = {}
	end

	local wd = 0

	if data.cases then
		MW_CASES = data.cases
	end

	hook.Add("HUDPaint", "Info.HUDPaint", function()
		if not ply:KeyDown( IN_ZOOM ) then return end

		for id, text in pairs(data.props) do
			local ent = Entity(id)

			if not IsValid(ent) or not DarkRP.InRange(ent, ply, ent.IsSimfphyscar and 1200 or 300) then continue end

			local pos = ent:LocalToWorld(ent:OBBCenter())
			local Tr = util.TraceLine{start = ply:GetShootPos(), endpos = pos, filter = function(e)
				if (ignore[e:GetClass()] or e == ply) and e ~= ent then return false end
				return true
			end}
			if Tr.Entity ~= ent then continue end
			local screenpos = pos:ToScreen()
			local x, y = screenpos.x, screenpos.y - 50

			if string.EndsWith(text, "[n]") then
				surface.SetDrawColor(0, 0, 0, 170)
				surface.SetMaterial(MSD.Materials.gradient_center)
				surface.DrawTexturedRectRotated(x, y + 55, 150, wd + 150, -90)
				wd = draw.SimpleTextOutlined("Номерные знаки:", "MSDFont.26", x, y + 13, MSD.Config.MainColor.p, TEXT_ALIGN_CENTER, 0, 1, color_black)
				local num = string.Explode("[n", text)[1]
				draw.SimpleTextOutlined(num, "Moster.36", x, y + 40, color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
				if ply:isCP() then
					local tb = string.ToTable(num)
					num = ""
					for k,v in ipairs(tb) do
						num = num .. (num == "" and "" or " | ") .. (DarkRP.Police.Phonetic[string.upper(v)] or v)
					end
					wd = draw.SimpleTextOutlined(num, "MSDFont.22", x, y + 75, color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
				end
			else
				if LocalPlayer():GetEyeTrace().Entity == ent then
					draw.SimpleTextOutlined(text, "MSDFont.26", x, y + 32, color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
					continue
				end
				draw.SimpleTextOutlined(text, "MSDFont.16", x, y + 32, color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
			end

		end

		if not data.cases then return end

		for _, cases in pairs(data.cases) do
			local dis = cases.pos:DistToSqr(LocalPlayer():GetPos())
			if dis > 50000 then continue end
			local pos = cases.pos:ToScreen()
			dis = 1 - (dis / 50000)
			draw.SimpleTextOutlined("Гильзы", "MSDFont.16", pos.x, pos.y, MSD.ColorAlpha(color_white, 255 * dis), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, 255 * dis))
		end
	end)

	timer.Create("Info.HUDPaint", 60, 1, function()
		hook.Remove("HUDPaint", "Info.HUDPaint")
	end)
end)

net.Receive("DarkRP.ClientRagdoll", function()
	local ply = net.ReadEntity()
	local ragdoll = net.ReadUInt(32)
	local color = net.ReadVector()
	local tbl
	local saved = {
		["head"] = false,
		["vest"] = false,
		["face"] = false,
		["mouth"] = false,
		["bag"] = false,
		["showrank"] = false,
	}

	if ply.cosmetics then
		tbl = {}
		for i,m in pairs(ply.cosmetics) do
			if i == 13 and net.ReadBool() then tbl[i] = true continue end
			if not m or not IsValid(m) then continue end
			tbl[i] = true
		end
	end

	for k,v in pairs(saved) do
		if not ply.getDarkRPVar then continue end
		saved[k] = ply:getDarkRPVar(k)
	end

	timer.Simple(0.1, function()
		ragdoll = Entity(ragdoll)
		if not IsValid(ragdoll) then return end
		ply.DeathRagdoll = ragdoll
		ragdoll.SelfPlayer = ply
		if tbl then
			ragdoll.RenderOverride = function(self) self:DrawModel() DarkRP.ClientCosmet(self, tbl, saved) end
		end
		ragdoll.GetPlayerColor = function(self) return color end
	end)
end)

net.Receive("DarkRP.PlayerSendData", function()
	local bytes_number = net.ReadInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local data = DarkRP.TableDecompress(compressed_data)
	local info = net.ReadString()
	local ply = LocalPlayer()

	ply[info] = data
end)

net.Receive("DarkRP.SendDataShared", function()
	local bytes_number = net.ReadInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local data = DarkRP.TableDecompress(compressed_data)
	local p1 = net.ReadString()
	local p2 = net.ReadString()

	DarkRP[p1][p2] = data
end)

hook.Add("Think", "GmodLA.FocuseOnEntThink", function()
	local ply = LocalPlayer()

	if ply.nark_effect then
		if not DarkRP.DSP then
			DarkRP.DSP = true
			ply:SetDSP(16, true)
		end
		return
	end

	if ply:getDarkRPVar("unconscious") and ply:getDarkRPVar("unconscious") > 9 then
		if not DarkRP.DSP then
			DarkRP.DSP = true
			ply:SetDSP(15, true)
		end
		return
	elseif DarkRP.DSP then
		DarkRP.DSP = nil
		ply:SetDSP(0)
	end

	if ply.removehead then
		local head = ply:LookupBone("ValveBiped.Bip01_Head1")
		if IsValid(ply:GetViewEntity()) and ply:GetViewEntity() == ply then
			if head and not ply.headremoved then ply:ManipulateBoneScale(head, Vector(0, 0, 0)) ply.headremoved = true end
		else
			if ply.headremoved and head then
				ply:ManipulateBoneScale(head, Vector(1, 1, 1)) ply.headremoved = nil
			end
		end
		ply.removehead = nil
	else
		if ply.headremoved then
			local head = ply:LookupBone("ValveBiped.Bip01_Head1")
			if head then ply:ManipulateBoneScale(head, Vector(1, 1, 1)) ply.headremoved = nil end
		end
	end

	if not DarkRP.ViewFocus then return end
	local view = DarkRP.ViewFocus
	local speed = FrameTime() * 3
	local pos, ang, fov

	if not view.animInit then
		view.animInit = true
		view.origin = ply:EyePos()
		view.angles = ply:GetAngles()
		view.fov = ply:GetFOV()
		view.drawPlayer = view.drawp
	end

	if view.fade or not IsValid(view.ent) then
		pos = ply:EyePos()
		ang = ply:GetAngles()
		fov = ply:GetFOV()
		speed = FrameTime() * 8
		view.drawPlayer = false

		if not view.closing then
			view.closing = CurTime() + 0.3
		end

		if view.closing <= CurTime() then
			DarkRP.ViewFocus = nil
			return
		end
	else
		local sPos, sAng = view.ent:GetPos(), view.ent:GetAngles()

		if view.point then
			sPos = view.ent:LocalToWorld(view.point)
		end

		sAng = Angle(0, sAng.y, 0)
		if isangle(view.ang) then
			sAng:RotateAroundAxis(sAng:Up(), view.ang.r)
			sAng:RotateAroundAxis(sAng:Right(), view.ang.y)
			sAng:RotateAroundAxis(sAng:Forward(), view.ang.p)
		else
			sAng:RotateAroundAxis(sAng:Up(), view.ang)
			sAng:RotateAroundAxis(sAng:Right(), -45)
		end
		local tr = util.TraceLine({
			start = sPos,
			endpos = sPos + sAng:Up() * 10 - sAng:Forward() * 55,
			filter = {ply, ent}
		})

		pos = tr.HitPos
		ang = sAng
		fov = view.cfov or 55
	end


	view.origin = LerpVector(speed, view.origin, pos)
	view.angles = LerpAngle(speed, view.angles, ang)
	view.fov = Lerp(speed, view.fov, fov)
end)

hook.Add("PreDrawViewModel", "GmodLA.PreDrawViewModel", function()
	if LocalPlayer():getDarkRPVar("unconscious") or (LocalPlayer():getDarkRPVar("fanim") and LocalPlayer():getDarkRPVar("fanim") > CurTime()) then
		return true
	end
end)

hook.Add("HUDShouldDraw", "GmodLA.FocuseOnEnt.HideHUD", function()
	if DarkRP.ViewFocus and not DarkRP.ViewFocus.closing then return false end
end)

hook.Add("ShouldDrawLocalPlayer", "GmodLA.ShouldDrawLocalPlayer", function(ply)
	if ply:Alive() and ply:InVehicle() and not ply:GetVehicle():GetThirdPersonMode() and IsValid(ply:GetViewEntity()) and ply:GetViewEntity() == ply then
		ply.removehead = true
		return true
	end
end)

hook.Add("CalcView", "GmodLA.FocuseOnEnt", function(pl, pos, ang, o_fov)
	if DarkRP.ViewFocus then
		local view = {
			origin = DarkRP.ViewFocus.origin,
			angles = DarkRP.ViewFocus.angles,
			fov = DarkRP.ViewFocus.fov,
			drawviewmodel = false,
			drawviewer = DarkRP.ViewFocus.drawPlayer
		}

		return view
	end
end)

hook.Add( "OnScreenSizeChanged", "ChangeHudStats2", function( oldWidth, oldHeight )
	w, h = ScrW(), ScrH()
end )

local tr = {collisiongroup = COLLISION_GROUP_PASSABLE_DOOR, output = {}}
function util.IsInWorld( pos )
	tr.start = pos
	tr.endpos = pos + Vector(0,0,3)

	return not util.TraceLine( tr ).Hit
end

language.Add("GMOD_ToolGun", "Инструмент")