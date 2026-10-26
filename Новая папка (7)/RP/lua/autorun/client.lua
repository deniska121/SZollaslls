
if SERVER then return end

local a1, a2, a3 = 0, 0, 0
local nB, hs, h2s, ss = nil, nil, nil, nil
local breathSnd = nil

surface.CreateFont("FS", { font = "Snowstorm Kraft", size = ScreenScale(26), weight = 100, extended = true, antialiasing = true })
surface.CreateFont("FA", { font = "Arial", size = ScreenScale(9), weight = 500, italic = true, extended = true })

surface.CreateFont("ST", { font = "Snowstorm Kraft", size = ScreenScale(14), weight = 100, extended = true, antialiasing = true })

local sTxt = false
local sTxtStart = 0
local sTxtDur = 3.0

net.Receive("SKO", function()
    sTxt = true
    sTxtStart = CurTime()
end)

hook.Add("HUDPaint", "s_txt", function()
    if not sTxt then return end
    local p = LocalPlayer()
    if not IsValid(p) or not p:Alive() then
        sTxt = false
        return
    end

    local el = CurTime() - sTxtStart
    if el > sTxtDur then
        sTxt = false
        return
    end

    local a = 255
    if el < 0.3 then a = 255 * (el / 0.3) end
    if el > sTxtDur - 1.0 then a = 255 * ((sTxtDur - el) / 1.0) end
    a = math.Clamp(a, 0, 255)

    local tx = "Вы потеряли сознания от боли..."
    local x, y = ScrW() / 2, ScrH() - 120

    local shX = math.sin(CurTime() * 25) * 3 * (1 - el / sTxtDur)
    local shY = math.cos(CurTime() * 30) * 3 * (1 - el / sTxtDur)

    draw.SimpleText(tx, "ST", x + shX + 1, y + shY + 1, Color(0, 0, 0, a * 0.4), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
  
    draw.SimpleText(tx, "ST", x + shX, y + shY, Color(160, 30, 30, a * 0.75), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
end)

hook.Add("HUDPaint", "DHUD", function()
	local p = LocalPlayer()
	if not IsValid(p) then return end

	local t = ""
	local unc = p:GetNWBool("Unconscious", false) or (IsValid(p:GetNWEntity("Ragdoll")) and p:GetObserverMode() == OBS_MODE_CHASE) or p:GetNWBool("UnconsciousInVehicle", false)

	if not p:Alive() or p:Health() <= 0 then 
		local ds = p:GetNWFloat("DeathTime", 0)
		if ds == 0 and not p:Alive() then ds = CurTime() p:SetNWFloat("DeathTime", ds) end
		t = "ВЫ МЕРТВЫ"
	elseif unc then 
		t = "ВЫ БЕЗ СОЗНАНИЯ" 
	end

	if t ~= "" then
		local x, y = ScrW() / 2, ScrH() / 2 - 39
		local wC = Color(255, 255, 255, 255)
		local oC = Color(0, 0, 0, 255)
		local off = 3
		
		for ox = -off, off do
			for oy = -off, off do
				if ox == 0 and oy == 0 then continue end
				draw.SimpleText(t, "FS", x + ox, y + oy, oC, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
			end
		end
		draw.SimpleText(t, "FS", x, y, wC, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		if not p:Alive() then
			local ds = p:GetNWFloat("DeathTime", 0)
			if ds > 0 then
				local e = CurTime() - ds
				local pct = math.Clamp((120 - e) / 120, 0, 1)
				surface.SetFont("FS")
				local tw, th = surface.GetTextSize(t)
				local bW, bH = tw, 3
				local bX, bY = (ScrW() / 2) - (bW / 2), y + (th / 2) + 10
				surface.SetDrawColor(255, 255, 255, 40)
				surface.DrawRect(bX, bY, bW, bH)
				surface.SetDrawColor(255, 255, 255, 255)
				surface.DrawRect(bX, bY, bW * pct, bH)
			end
		end
	end
end)

hook.Add("CalcMainActivity", "sA", function(p)
	if IsValid(p) and p:GetNWBool("UnconsciousInVehicle", false) then
		local veh = p:GetSimfphys()
		if not IsValid(veh) or veh:GetDriver() ~= p then return end
		local sI = p:LookupSequence("sitchairtable1")
		if sI and sI >= 0 then return ACT_HL2MP_SIT, sI end
		return ACT_HL2MP_SIT
	end
end)

hook.Add("UpdateAnimation", "aU", function(p)
	if IsValid(p) and p:GetNWBool("UnconsciousInVehicle", false) then
		local veh = p:GetSimfphys()
		if not IsValid(veh) or veh:GetDriver() ~= p then return end
		local sI = p:LookupSequence("sitchairtable1")
		if sI and sI >= 0 then 
			p:SetSequence(sI) 
			p:SetCycle(0) 
			p:SetPlaybackRate(0) 
			return true 
		end
	end
end)

hook.Add("Think", "FAL", function()
	for _, p in ipairs(player.GetAll()) do
		if IsValid(p) then
			local veh = p:GetSimfphys()
			local isUncon = p:GetNWBool("UnconsciousInVehicle", false)
			if isUncon and IsValid(veh) and veh:GetDriver() == p then
				local pv = p:LookupBone("ValveBiped.Bip01_Pelvis")
				if pv then
					p:ManipulateBonePosition(pv, Vector(6.5, 0, -10.5))
					p.ResetPelvisBone = true
				end
			elseif p.ResetPelvisBone then
				local pv = p:LookupBone("ValveBiped.Bip01_Pelvis")
				if pv then p:ManipulateBonePosition(pv, Vector(0, 0, 0)) end
				p.ResetPelvisBone = nil
			end
		end
	end
end)

hook.Add("Think", "AL", function()
	local p = LocalPlayer()
	if not IsValid(p) then return end

	local s, hS, hD = p:GetNWFloat("BleedTime", 0), p:GetNWFloat("HorrorTime", 0), p:GetNWFloat("HorrorDuration", 43)
	local h2S, h2D = p:GetNWFloat("Horror2Time", 0), p:GetNWFloat("Horror2Duration", 43)
	local sS, sD = p:GetNWFloat("SonTime", 0), p:GetNWFloat("SonDuration", 180)
	local unc = p:GetNWBool("Unconscious", false) or (IsValid(p:GetNWEntity("Ragdoll")) and p:GetObserverMode() == OBS_MODE_CHASE) or p:GetNWBool("UnconsciousInVehicle", false)

	if hD <= 0 then hD = 43 end 
	if h2D <= 0 then h2D = 43 end 
	if sD <= 0 then sD = 180 end

	local function P(sn, snd, f, v)
		if sn > 0 and p:Alive() and not unc and (CurTime() - sn) < f then
			if not snd then 
				snd = CreateSound(p, v) 
				if snd then snd:PlayEx(0.45, 100) end 
			end
		else 
			if snd then 
				snd:Stop() 
				snd = nil 
			end 
		end
		return snd
	end

	hs = P(hS, hs, hD, "bandage/crazy.wav")
	h2s = P(h2S, h2s, h2D, "bandage/crazy2.wav")
	ss = P(sS, ss, sD, "bandage/Hotline.mp3")

	if s > 0 and p:Alive() and not unc then
		local e = CurTime() - s
		local totalBleedTime = 120
		if e >= (totalBleedTime - 10) and e < totalBleedTime then
			if not breathSnd then
				breathSnd = CreateSound(p, "player/breathe1.wav")
				breathSnd:PlayEx(0.7, 100)
			end
			if not nB or CurTime() >= nB then
				p:EmitSound("player/breathe1.wav", 60, 100, 0.7)
				nB = CurTime() + 2.5
			end
		else
			if breathSnd then
				breathSnd:Stop()
				breathSnd = nil
			end
			nB = nil
		end
	else
		if breathSnd then
			breathSnd:Stop()
			breathSnd = nil
		end
		nB = nil
	end
end)

hook.Add("RenderScreenspaceEffects", "SFX", function()
	local p = LocalPlayer()
	if not IsValid(p) then return end

	local unc = p:Alive() and (p:GetNWBool("Unconscious", false) or (IsValid(p:GetNWEntity("Ragdoll")) and p:GetObserverMode() == OBS_MODE_CHASE) or p:GetNWBool("UnconsciousInVehicle", false))
	local iD = not p:Alive()

	if iD then
		DrawColorModify({
			["$pp_colour_addr"] = 0, ["$pp_colour_addg"] = 0, ["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = -1.0, ["$pp_colour_contrast"] = 1.8, ["$pp_colour_colour"] = 0,
			["$pp_colour_mulr"] = 0, ["$pp_colour_mulg"] = 0, ["$pp_colour_mulb"] = 0
		})
	elseif unc then
		DrawColorModify({
			["$pp_colour_addr"] = 0, ["$pp_colour_addg"] = 0, ["$pp_colour_addb"] = 0,
			["$pp_colour_brightness"] = -0.29, ["$pp_colour_contrast"] = 1.8, ["$pp_colour_colour"] = 0,
			["$pp_colour_mulr"] = 0, ["$pp_colour_mulg"] = 0, ["$pp_colour_mulb"] = 0
		})
	end

	local dS = p:GetNWFloat("DrugTime", 0)
	if dS > 0 and p:Alive() and not unc then
		local pr = math.Clamp((CurTime() - dS) / 10, 0, 1)
		DrawColorModify({
			["$pp_colour_addr"] = math.sin(CurTime() * 1.5) * 0.22 * pr, ["$pp_colour_addg"] = math.cos(CurTime() * 2.0) * 0.22 * pr, ["$pp_colour_addb"] = math.sin(CurTime() * 1.0) * 0.32 * pr,
			["$pp_colour_brightness"] = -0.05 * pr, ["$pp_colour_contrast"] = 1 + (0.5 * pr), ["$pp_colour_colour"] = 1 + (4.5 * pr * math.sin(CurTime() * 0.9)),
			["$pp_colour_mulr"] = 0, ["$pp_colour_mulg"] = 0, ["$pp_colour_mulb"] = 0
		})
	end

	local hS, hD = p:GetNWFloat("HorrorTime", 0), p:GetNWFloat("HorrorDuration", 43)
	if hD <= 0 then hD = 43 end
	if hS > 0 and p:Alive() and not unc and (CurTime() - hS) < hD then
		local pr = math.Clamp((CurTime() - hS) / hD, 0, 1)
		DrawColorModify({
			["$pp_colour_addr"] = (0.22 * pr) + (math.sin(CurTime() * 3.5) * 0.05 * pr), ["$pp_colour_addg"] = -0.2 * pr, ["$pp_colour_addb"] = -0.2 * pr,
			["$pp_colour_brightness"] = -0.45 * pr, ["$pp_colour_contrast"] = 1 + (2.5 * pr), ["$pp_colour_colour"] = 1 - (1.0 * pr),
			["$pp_colour_mulr"] = 0, ["$pp_colour_mulg"] = 0, ["$pp_colour_mulb"] = 0
		})
		DrawSharpen(6 * pr, 2 * pr)
		if pr > 0.1 then DrawMotionBlur(0.15, 0.92 * ((pr - 0.1) / 0.9), 0.02) end
	end

	local h2S, h2D = p:GetNWFloat("Horror2Time", 0), p:GetNWFloat("Horror2Duration", 43)
	if h2D <= 0 then h2D = 43 end
	if h2S > 0 and p:Alive() and not unc and (CurTime() - h2S) < h2D then
		local pr = math.Clamp((CurTime() - h2S) / h2D, 0, 1)
		DrawColorModify({
			["$pp_colour_addr"] = -0.1 * pr, ["$pp_colour_addg"] = -0.3 * pr, ["$pp_colour_addb"] = (-0.2 * pr) + (math.sin(CurTime() * 6.0) * 0.15 * pr),
			["$pp_colour_brightness"] = -0.55 * pr, ["$pp_colour_contrast"] = 1 + (3.5 * pr), ["$pp_colour_colour"] = 1 - (1.2 * pr),
			["$pp_colour_mulr"] = 0, ["$pp_colour_mulg"] = 0, ["$pp_colour_mulb"] = 0
		})
		DrawSharpen(10 * pr * math.abs(math.sin(CurTime() * 5.0)), 2.5 * pr)
		if pr > 0.05 then DrawMotionBlur(0.1, 0.96 * ((pr - 0.05) / 0.95), 0.04) end
	end

	local sS, sD = p:GetNWFloat("SonTime", 0), p:GetNWFloat("SonDuration", 180)
	if sD <= 0 then sD = 180 end
	if sS > 0 and p:Alive() and not unc and (CurTime() - sS) < sD then
		local e = CurTime() - sS
		local pr = math.Clamp(e / 5, 0, 1)
		if sD - e < 5 then pr = math.Clamp((sD - e) / 5, 0, 1) end
		DrawColorModify({
			["$pp_colour_addr"] = math.sin(CurTime() * 2.5) * 0.07 * pr, ["$pp_colour_addg"] = math.cos(CurTime() * 2.0) * 0.07 * pr, ["$pp_colour_addb"] = math.sin(CurTime() * 3.0) * 0.1 * pr,
			["$pp_colour_brightness"] = -0.01 * pr, ["$pp_colour_contrast"] = 1 + (0.4 * pr), ["$pp_colour_colour"] = 1 + (2.0 * pr * math.abs(math.sin(CurTime() * 1.2))),
			["$pp_colour_mulr"] = math.sin(CurTime() * 2) * 0.7 * pr, ["$pp_colour_mulg"] = math.cos(CurTime() * 1.5) * 0.7 * pr, ["$pp_colour_mulb"] = math.sin(CurTime() * 2.5) * 0.7 * pr
		})
		DrawMotionBlur(0.12, 0.65 * pr, 0.03) 
		DrawSharpen(3 * pr, 0.7 * pr) 
		DrawBloom(0.4, 2.5 * pr, 6 * pr, 6 * pr, 2, 1, 1, 1, 1)
		DrawMaterialOverlay("effects/water_warp", math.sin(CurTime() * 1.5) * 0.002 * pr)
	end
end)

hook.Add("HUDShouldDraw", "NC", function(n)
	local p = LocalPlayer()
	if n == "CHudCrosshair" and IsValid(p) and p:Alive() and (p:GetNWBool("Unconscious", false) or (IsValid(p:GetNWEntity("Ragdoll")) and p:GetObserverMode() == OBS_MODE_CHASE) or p:GetNWBool("UnconsciousInVehicle", false)) then 
		return false 
	end
end)

hook.Add("CalcView", "R_Cam", function(p, po, a, f)
	local inV = p:GetNWBool("UnconsciousInVehicle", false)
	local unc = p:Alive() and (p:GetNWBool("Unconscious", false) or (p:GetObserverMode() == OBS_MODE_CHASE and IsValid(p:GetNWEntity("Ragdoll"))) or inV)
	
	if p:Alive() then
		local sS, sD = p:GetNWFloat("SonTime", 0), p:GetNWFloat("SonDuration", 180)
		if sS > 0 and not unc and (CurTime() - sS) < sD then
			local sh = math.Clamp((CurTime() - sS) / 5, 0, 1) * 1.2
			if sD - (CurTime() - sS) < 5 then sh = math.Clamp((sD - (CurTime() - sS)) / 5, 0, 1) * 1.8 end
			a.roll, a.pitch, a.yaw = a.roll + math.sin(CurTime() * 5.0) * sh, a.pitch + math.cos(CurTime() * 5.5) * (sh * 0.5), a.yaw + math.sin(CurTime() * 6.0) * (sh * 0.3)
			return { origin = po, angles = a, fov = f }
		end
	end

	if not unc and p:Alive() then return end
	
	local r = p:GetNWEntity("Ragdoll")
	if inV then return end
	if not IsValid(r) and not p:Alive() then r = p:GetRagdollEntity() end
	
	if IsValid(r) then
		r:SetupBones()
		local at = r:LookupAttachment("eyes")
		if at == 0 then at = r:LookupAttachment("head") end
		if at > 0 then
			local d = r:GetAttachment(at)
			if d and d.Pos ~= r:GetPos() then 
				return { origin = d.Pos + d.Ang:Forward() * 2, angles = d.Ang, fov = f, drawviewer = false } 
			end
		end
		
		local b = r:LookupBone("ValveBiped.Bip01_Head1")
		if b then
			local m = r:GetBoneMatrix(b)
			if m then
				local bp, ba = m:GetTranslation(), m:GetAngles()
				return { origin = bp + ba:Forward() * 2, angles = ba, fov = f, drawviewer = false }
			end
		end
	end
end)

hook.Add("Think", "HideWeaponsOnKO", function()
	for _, ply in ipairs(player.GetAll()) do
		if IsValid(ply) and ply:Alive() then
			local ko = ply:GetNWBool("Unconscious", false) or (IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE) or ply:GetNWBool("UnconsciousInVehicle", false)
			for _, wep in ipairs(ply:GetWeapons()) do
				if IsValid(wep) then
					wep:SetNoDraw(ko)
				end
			end
		end
	end
end)

hook.Add("PostGamemodeLoaded", "msd_hud_ply_ko", function()
	if HUD and HUD.HudPlayer then
		local old = HUD.HudPlayer
		HUD.HudPlayer = function(ply, Draw3D)
			if IsValid(ply) and (ply:GetNWBool("Unconscious", false) or (IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE) or ply:GetNWBool("UnconsciousInVehicle", false)) then
				return
			end
			old(ply, Draw3D)
		end
	end
end)

hook.Add("InputMouseApply", "wakeup_mouse", function(cmd, x, y, ang)
	local p = LocalPlayer()
	if IsValid(p) and p:GetNWBool("WakeUpActive", false) then
		local lockTime = p:GetNWFloat("WakeUpLockTime", 0)
		if lockTime > CurTime() then
			return true
		end
	end
end)

hook.Add("CalcView", "wakeup_view", function(ply, pos, ang, fov)
	if IsValid(ply) and ply:Alive() and ply:GetNWBool("WakeUpActive", false) then
		local lockTime = ply:GetNWFloat("WakeUpLockTime", 0)
		if lockTime > CurTime() then
			local eyes = ply:LookupAttachment("eyes")
			if eyes and eyes > 0 then
				local attach = ply:GetAttachment(eyes)
				if attach and attach.Pos then
					local bAng = attach.Ang
					bAng:RotateAroundAxis(bAng:Right(), -10)
					return {
						origin = attach.Pos + bAng:Forward() * 2,
						angles = bAng,
						fov = fov,
						drawviewer = true
					}
				end
			end
		end
	end
end)

hook.Add("CalcMainActivity", "wakeup_activity", function(ply)
	if IsValid(ply) and ply:GetNWBool("WakeUpActive", false) then
		local seq = ply:GetNWString("WakeUpSeq", "")
		if seq ~= "" then
			local idx = ply:LookupSequence(seq)
			if idx and idx >= 0 then
				return ACT_HL2MP_IDLE, idx
			end
		end
	end
end)

hook.Add("UpdateAnimation", "wakeup_anim", function(ply)
	if IsValid(ply) and ply:GetNWBool("WakeUpActive", false) then
		local seq = ply:GetNWString("WakeUpSeq", "")
		if seq ~= "" then
			local idx = ply:LookupSequence(seq)
			if idx and idx >= 0 then
				ply:SetSequence(idx)
				return true
			end
		end
	end
end)

hook.Add("StartCommand", "wakeup_cmd", function(ply, cmd)
	if IsValid(ply) and ply:GetNWBool("WakeUpActive", false) then
		local lockTime = ply:GetNWFloat("WakeUpLockTime", 0)
		if lockTime > CurTime() then
			cmd:ClearMovement()
			cmd:SetForwardMove(0)
			cmd:SetSideMove(0)
			cmd:SetUpMove(0)
			local buttons = cmd:GetButtons()
			buttons = bit.band(buttons, bit.bnot(IN_JUMP))
			buttons = bit.band(buttons, bit.bnot(IN_SPEED))
			cmd:SetButtons(buttons)
		end
	end
end)

hook.Add("SetupMove", "wakeup_move", function(ply, mv, cmd)
	if IsValid(ply) and ply:GetNWBool("WakeUpActive", false) then
		local lockTime = ply:GetNWFloat("WakeUpLockTime", 0)
		if lockTime > CurTime() then
			mv:SetForwardSpeed(0)
			mv:SetSideSpeed(0)
			mv:SetMaxClientSpeed(0)
			local buttons = mv:GetButtons()
			buttons = bit.band(buttons, bit.bnot(IN_JUMP))
			buttons = bit.band(buttons, bit.bnot(IN_SPEED))
			mv:SetButtons(buttons)
		end
	end
end)