if SERVER then AddCSLuaFile() end

local mat = CLIENT and Material("msd/vignette.png", "nocull smooth") or nil
local bMat = CLIENT and Material("gmodla/hud/overlay_bleeding.png", "nocull smooth") or nil
local wMat = CLIENT and Material("gmodla/hud/overlay_freezing.png", "nocull smooth") or nil
local pMat = CLIENT and Material("gmodla/hud/overlay_poisoned.png", "nocull smooth") or nil

if CLIENT then
	local lastShotSlowTime = 0
	local heartBeatSound = nil
	local waterOverlayTarget = 0
	local waterOverlayCurrent = 0
	local showPoisonOverlay = false

	net.Receive("PS_WaterOverlay", function()
		waterOverlayTarget = net.ReadBool() and 128 or 0
	end)

	net.Receive("PS_PoisonOverlay", function()
		showPoisonOverlay = net.ReadBool()
	end)

	hook.Add("HUDPaint", "p_v", function()
		local p = LocalPlayer()
		if not IsValid(p) or not p:Alive() or p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) then return end
		
		local pn = p:GetNWFloat("Pain", 0)
		local hp = p:Health()
		local w, h = ScrW(), ScrH()
		
		if hp <= 60 then
			local bAl = math.Clamp(math.Remap(hp, 60, 5, 30, 245), 30, 245)
			surface.SetMaterial(bMat)
			surface.SetDrawColor(255, 255, 255, bAl)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		local bleedTime = p:GetNWFloat("BleedTime", 0)
		if bleedTime > 0 then
			local bleedAlpha = math.Clamp(math.Remap(bleedTime, CurTime() - 33, CurTime(), 120, 255), 120, 255)
			local pulse = 0.6 + 0.4 * math.sin(CurTime() * 0.8)
			bleedAlpha = bleedAlpha * pulse
			bleedAlpha = math.Clamp(bleedAlpha, 80, 255)
			surface.SetMaterial(bMat)
			surface.SetDrawColor(255, 30, 30, bleedAlpha)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		if pn > 0 then
			local pulse = 0.5 + 0.5 * math.sin(CurTime() * 2.5)
			local baseAlpha = math.Clamp(pn * 3.5, 0, 255)
			local finalAlpha = baseAlpha * (0.6 + 0.4 * pulse)
			surface.SetMaterial(mat)
			surface.SetDrawColor(255, 0, 0, finalAlpha)
			surface.DrawTexturedRect(0, 0, w, h)

			if pn > 15 then
				local pulseIntensity = math.Clamp((pn - 15) * 0.3 * pulse, 0, 50)
				surface.SetDrawColor(255, 0, 0, pulseIntensity)
				surface.DrawTexturedRect(-20, -20, w + 40, h + 40)
				surface.DrawTexturedRect(20, 20, w - 40, h - 40)
			end
		end

		local shock = p:GetNWFloat("Shock", 0)
		if shock > 0 then
			local pulse = 0.6 + 0.4 * math.sin(CurTime() * 3.0)
			local alpha = math.Clamp(shock * 2.5, 0, 255) * (0.7 + 0.3 * pulse)
			surface.SetMaterial(mat)
			surface.SetDrawColor(255, 20, 20, alpha)
			surface.DrawTexturedRect(0, 0, w, h)
		end

		waterOverlayCurrent = Lerp(5 * FrameTime(), waterOverlayCurrent, waterOverlayTarget)
		if waterOverlayCurrent > 0.5 then
			surface.SetMaterial(wMat)
			surface.SetDrawColor(255, 255, 255, math.Round(waterOverlayCurrent))
			surface.DrawTexturedRect(0, 0, w, h)
		end

		if showPoisonOverlay then
			surface.SetMaterial(pMat)
			surface.SetDrawColor(255, 255, 255, 128)
			surface.DrawTexturedRect(0, 0, w, h)
		end
	end)

	hook.Add("RenderScreenspaceEffects", "p_fx", function()
		local p = LocalPlayer()
		if not IsValid(p) or not p:Alive() or p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) then return end
		
		local pn = p:GetNWFloat("Pain", 0)
		if pn > 0 then
			DrawMotionBlur(0.2, math.Clamp(pn * 0.008, 0.1, 0.85), 0.02)
		end

		local shock = p:GetNWFloat("Shock", 0)
		if shock > 0 then
			local intensity = math.Clamp(shock / 100 * 0.3, 0, 0.3)
			if intensity > 0.01 then
				DrawMotionBlur(0.2, intensity, 0.02)
			end
		end

		local hp = p:Health()
		if hp < 60 then
			local sat = math.Clamp(math.Remap(hp, 60, 5, 0.85, 0.0), 0.0, 0.85)
			local tab = {
				["$pp_colour_addr"] = 0,
				["$pp_colour_addg"] = 0,
				["$pp_colour_addb"] = 0,
				["$pp_colour_brightness"] = 0,
				["$pp_colour_contrast"] = 1,
				["$pp_colour_colour"] = sat,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}
			DrawColorModify(tab)
		end
	end)

	hook.Add("InputMouseApply", "p_s", function(cmd, x, y, ang)
		local p = LocalPlayer()
		if not IsValid(p) or not p:Alive() or p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) then return end

		local block = p:GetNWFloat("NextActionTime", 0) > CurTime()
		local f = 1
		if block then
			f = 0.35
		end

		if f < 1 then
			cmd:SetMouseX(x * f)
			cmd:SetMouseY(y * f)
		end
	end)

	hook.Add("Think", "sp", function()
		local p = LocalPlayer()
		if not IsValid(p) or not p:Alive() then return end
		local st = p:GetNWFloat("ShotSlowTime", 0)
		if st > lastShotSlowTime then
			lastShotSlowTime = st
			if st > CurTime() then
				local pa = Angle(math.Rand(-7, 7), math.Rand(-7, 7), math.Rand(-2, 2))
				p:ViewPunch(pa)
			end
		end
	end)

	hook.Add("Think", "heartbeat", function()
		local p = LocalPlayer()
		if not IsValid(p) or not p:Alive() then return end
		local hp = p:Health()
		if hp < 30 then
			if not heartBeatSound then
				heartBeatSound = CreateSound(p, "player/heartbeat1.wav")
				heartBeatSound:PlayEx(0.6, 100)
			end
		else
			if heartBeatSound then
				heartBeatSound:Stop()
				heartBeatSound = nil
			end
		end
	end)
end

if SERVER then
	util.AddNetworkString("PS_WaterOverlay")
	util.AddNetworkString("PS_PoisonOverlay")

	local function UpdateWaterOverlay(ply, show)
		net.Start("PS_WaterOverlay")
		net.WriteBool(show)
		net.Send(ply)
	end

	local function UpdatePoisonOverlay(ply, show)
		net.Start("PS_PoisonOverlay")
		net.WriteBool(show)
		net.Send(ply)
	end

	function AddShock(ply, amount)
		if not IsValid(ply) or not ply:Alive() then return end
		local current = ply:GetNWFloat("Shock", 0)
		local new = math.Clamp(current + amount, 0, 200)
		ply:SetNWFloat("Shock", new)
	end

	hook.Add("EntityTakeDamage", "p_d", function(t, d)
		if not IsValid(t) or not t:IsPlayer() then return end
		if d:IsDamageType(DMG_DROWN) or d:IsDamageType(DMG_CLUB) then return end
		if not t:Alive() or t:GetNWBool("UnconsciousInVehicle", false) or IsValid(t:GetNWEntity("Ragdoll")) then return end

		local am = d:GetDamage()
		if am > 0 then
			local ar = t:Armor()
			local mult = 1
			if ar > 0 then
				mult = math.Clamp(1 - (ar / 100), 0.05, 1)
			end

			if d:IsDamageType(DMG_BULLET) or d:IsDamageType(DMG_BUCKSHOT) then
				t:SetNWFloat("ShotSlowTime", CurTime() + 0.34)
			else
				local cooldown = t.PainCooldown or 0
				if CurTime() >= cooldown then
					local c = t:GetNWFloat("Pain", 0)
					local added = am * 5 * mult
					t:SetNWFloat("Pain", math.Clamp(c + added, 0, 100))
					t.PainCooldown = CurTime() + 3
				end
				t:SetNWFloat("ShotSlowTime", CurTime() + 0.34)
			end

			if math.random() < 0.3 then
				t:SetNWFloat("NextActionTime", CurTime() + 1.8)
				local currentShock = t:GetNWFloat("Shock", 0)
				t:SetNWFloat("Shock", math.Clamp(currentShock + 15, 0, 200))
			end
		end
	end)

	concommand.Add("testshock", function(ply, cmd, args)
		if not IsValid(ply) then return end
		if not ply:IsListenServerHost() then return end
		local amount = tonumber(args[1]) or 0
		if amount > 0 then
			AddShock(ply, amount)
		end
	end)

	hook.Add("Think", "p_t", function()
		for _, p in ipairs(player.GetAll()) do
			if IsValid(p) then
				if p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) then
					p:SetNWFloat("Pain", 0)
					p:SetNWFloat("Shock", 0)
					p:SetNWFloat("NextActionTime", 0)
					p:SetNWFloat("ShotSlowTime", 0)
				else
					local c = p:GetNWFloat("Pain", 0)
					if c > 0 then
						p:SetNWFloat("Pain", math.max(0, c - FrameTime() * 12))
					end
					local s = p:GetNWFloat("Shock", 0)
					if s > 0 then
						p:SetNWFloat("Shock", math.max(0, s - FrameTime() * 5))
					end
				end
			end
		end
	end)

	hook.Add("Think", "wd", function()
		for _, p in ipairs(player.GetAll()) do
			if IsValid(p) and p:Alive() and not p:GetNWBool("UnconsciousInVehicle", false) and not IsValid(p:GetNWEntity("Ragdoll")) then
				local wl = p:WaterLevel()
				if wl > 0 then
					if not p.WaterTimer then p.WaterTimer = 0 end
					p.WaterTimer = p.WaterTimer + FrameTime()
					p.WaterOverlayHideTime = nil

					if p.WaterTimer >= 10 and not p.WaterOverlayShown then
						UpdateWaterOverlay(p, true)
						p.WaterOverlayShown = true
					end

					if p.WaterTimer >= 15 then
						if not p.DamageTimer then
							p.DamageTimer = 0
							p.DrownDamage = 6
						end
						p.DamageTimer = p.DamageTimer + FrameTime()
						if p.DamageTimer >= 6 then
							local dmg = p.DrownDamage or 6
							local info = DamageInfo()
							info:SetDamage(dmg)
							info:SetDamageType(DMG_CLUB)
							info:SetAttacker(p)
							info:SetInflictor(p)
							p:TakeDamageInfo(info)
							p.DamageTimer = 0
							p.DrownDamage = math.min(p.DrownDamage + 1, 16)
						end
					end
				else
					if p.WaterOverlayShown then
						if not p.WaterOverlayHideTime then
							p.WaterOverlayHideTime = CurTime() + 8
						end
						if CurTime() >= p.WaterOverlayHideTime then
							UpdateWaterOverlay(p, false)
							p.WaterOverlayShown = false
							p.WaterOverlayHideTime = nil
							p.WaterTimer = 0
							p.DamageTimer = nil
							p.DrownDamage = nil
						end
					else
						p.WaterTimer = 0
						p.DamageTimer = nil
						p.DrownDamage = nil
						p.WaterOverlayHideTime = nil
					end
				end
			end
		end
	end)

	hook.Add("PlayerDeath", "wdeath", function(ply)
		if ply.WaterOverlayShown then
			UpdateWaterOverlay(ply, false)
			ply.WaterOverlayShown = false
		end
		ply.WaterTimer = nil
		ply.DamageTimer = nil
		ply.DrownDamage = nil
		ply.WaterOverlayHideTime = nil
	end)

	hook.Add("PlayerSpawn", "wspawn", function(ply)
		if ply.WaterOverlayShown then
			UpdateWaterOverlay(ply, false)
			ply.WaterOverlayShown = false
		end
		ply.WaterTimer = nil
		ply.DamageTimer = nil
		ply.DrownDamage = nil
		ply.WaterOverlayHideTime = nil
	end)
end

hook.Add("StartCommand", "p_c", function(p, cmd)
	if IsValid(p) and p:Alive() then
		if p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) then
			p:SetNWFloat("Pain", 0)
			p:SetNWFloat("Shock", 0)
			p:SetNWFloat("NextActionTime", 0)
			p:SetNWFloat("ShotSlowTime", 0)
			return
		end

		if p:GetNWFloat("NextActionTime", 0) > CurTime() then
			cmd:RemoveKey(IN_ATTACK)
			cmd:RemoveKey(IN_ATTACK2)
			cmd:RemoveKey(IN_JUMP)
		end

		if p:Health() <= 30 then
			cmd:RemoveKey(IN_WALK)
		end
	end
end)

hook.Add("SetupMove", "p_m", function(p, mv, cmd)
	if IsValid(p) and p:Alive() and not p:GetNWBool("UnconsciousInVehicle", false) and not IsValid(p:GetNWEntity("Ragdoll")) then
		local f = 1

		local shock = p:GetNWFloat("Shock", 0)
		if shock > 0 then
			f = f * math.Clamp(1 - (shock / 100 * 0.9), 0.1, 1)
		end

		local hp = p:Health()
		if hp <= 30 then
			mv:SetMaxClientSpeed(100)
			f = f * math.Clamp(math.Remap(hp, 30, 5, 0.85, 0.5), 0.5, 0.85)
		end

		local shotSlow = p:GetNWFloat("ShotSlowTime", 0)
		if shotSlow > CurTime() then
			f = f * 0.2
			mv:SetMaxClientSpeed(50)
		end

		if f < 1 then
			mv:SetForwardSpeed(mv:GetForwardSpeed() * f)
			mv:SetSideSpeed(mv:GetSideSpeed() * f)
			mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() * f)
			mv:SetMaxSpeed(mv:GetMaxSpeed() * f)
		end
	end
end)
