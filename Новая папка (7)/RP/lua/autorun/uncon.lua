if CLIENT then return end

Downed, KOs, Hits, Bleeds, Drugs, Horrors, Horrors2, Son = Downed or {}, KOs or {}, Hits or {}, Bleeds or {}, Drugs or {}, Horrors or {}, Horrors2 or {}, Son or {}
DeathInventory = {}

local nWeps = { ["weapon_EbanieHands"] = true, ["weapon_physgun"] = true, ["gmod_tool"] = true, ["simfphys_keys"] = true, ["guigui_handcuffed"] = true, ["guigui_handcuffs"] = true }

local c_m = {
    ["models/cityrp/pm/nypd/male_01.mdl"] = true,
    ["models/cityrp/pm/nypd/male_02.mdl"] = true,
    ["models/cityrp/pm/nypd/male_03.mdl"] = true,
    ["models/cityrp/pm/nypd/male_04.mdl"] = true,
    ["models/cityrp/pm/nypd/male_05.mdl"] = true,
    ["models/cityrp/pm/nypd/male_06.mdl"] = true,
    ["models/cityrp/pm/nypd/male_07.mdl"] = true,
    ["models/cityrp/pm/nypd/male_08.mdl"] = true,
    ["models/cityrp/pm/nypd/male_09.mdl"] = true,
}

local sd = {"decals/blood4model","decals/bloodstain_001","decals/bloodstain_002","decals/bloodstain_003","decals/bloodstain_003b","decals/bloodstain_101"}

local function is_a(p)
    if not IsValid(p) then return false end
    if p:GetNWBool("detective", false) then return true end
    return c_m[string.lower(p:GetModel() or "")] == true
end

local function FCP(sP, eP, p)
	local lV = eP - sP
	local lL = lV:Length()
	if lL == 0 then return sP, 0 end
	local d = (p - sP):Dot(lV / lL)
	local t = math.Clamp(d, 0, lL)
	return sP + (lV / lL) * t, t / lL
end

hook.Add("EntityFireBullets", "v_hit", function(atk, data)
	local oCB = data.Callback
	data.Callback = function(a, tr, dmg)
		local targetVeh = tr.Entity
		if IsValid(targetVeh) and (targetVeh:IsVehicle() or (targetVeh.GetParent and IsValid(targetVeh:GetParent()) and targetVeh:GetParent():IsVehicle())) then
			for _, p in ipairs(player.GetAll()) do
				if IsValid(p) and p:Alive() and p:InVehicle() then
					local c, fr = FCP(tr.StartPos, tr.HitPos, p:WorldSpaceCenter())
					if c:DistToSqr(p:WorldSpaceCenter()) <= 1024 then
						if not dmg:IsDamageType(DMG_DIRECT) then
							local d = DamageInfo()
							d:SetDamage(dmg:GetDamage())
							d:SetAttacker(a)
							d:SetInflictor(dmg:GetInflictor() or a)
							d:SetDamageType(bit.bor(dmg:GetDamageType(), DMG_DIRECT))
							d:SetDamagePosition(c)
							p:TakeDamageInfo(d)
						end
						local fx = EffectData()
						fx:SetOrigin(c)
						fx:SetScale(3)
						util.Effect("BloodImpact", fx)
						tr.HitPos, tr.Fraction, tr.Entity = c, fr, p
						break
					end
				end
			end
		end
		if oCB then return oCB(a, tr, dmg) end
	end
	return true
end)

local function Clr(p)
    Drugs[p], Horrors[p], Horrors2[p], Son[p] = nil, nil, nil, nil
    p:SetNWFloat("DrugTime", 0)
    p:SetNWFloat("HorrorTime", 0)
    p:SetNWFloat("HorrorDuration", 0)
    p:SetNWFloat("Horror2Time", 0)
    p:SetNWFloat("Horror2Duration", 0)
    p:SetNWFloat("SonTime", 0)
    p:SetNWFloat("SonDuration", 0)
    p:SetNWBool("WakeUpActive", false)
    p:SetNWFloat("WakeUpLockTime", 0)
    p:SetNWFloat("WakeUpDuration", 0)
    p:SetNWString("WakeUpSeq", "")
    p:SetNWAngle("WakeUpLockAng", Angle(0,0,0))
end

function WakeUp(p)
	if not IsValid(p) then return end
	local b = p.GetSimfphys and p:GetSimfphys()
	if IsValid(b) then
		if b.SetHornKeyDown then b:SetHornKeyDown(false) else b.HornKeyIsDown = false end
		if b.SetIsHornPressed then b:SetIsHornPressed(false) end
		if b.SetNWBool then b:SetNWBool("horn", false) end
		if b.horn then b.horn:Stop() b.horn = nil end
		if b.Inputs then b.Inputs.Horn = 0 end
		if b.Brake then b.Brake = 0 end
	end
	
	local wasInVeh = p:GetNWBool("UnconsciousInVehicle", false)
	Clr(p)
	p:SetNWFloat("DeathTime", 0)
	p:SetNWBool("Unconscious", false)
	p:SetDSP(0, false)
	p.blockcontrols = false

	local d = Downed[p] or {}
	local hp = d.hp or 30
	local ar = d.ar or 0

	local r = p:GetNWEntity("Ragdoll")
	local pos, ang
	if IsValid(r) then
		pos = r:GetPos()
		ang = r:GetAngles()
	end
	if not pos then pos = d.pos end
	if not ang then ang = d.ang end

	if wasInVeh then
		p:SetNWBool("UnconsciousInVehicle", false)
	else
		if IsValid(r) then r:Remove() end
		p:SetNWEntity("Ragdoll", NULL)
	end

	if #p:GetWeapons() == 0 then
		local weps = d.weps or {}
		local ammo = d.ammo or {}
		for _, wData in ipairs(weps) do
			local wep = p:Give(wData.class)
			if IsValid(wep) then
				wep:SetClip1(wData.c1)
				wep:SetClip2(wData.c2)
			end
		end
		for amType, amCount in pairs(ammo) do
			p:SetAmmo(amCount, amType)
		end
	end

	if not p:HasWeapon("weapon_EbanieHands") then
		p:Give("weapon_EbanieHands")
	end
	p:SelectWeapon("weapon_EbanieHands")

	if not wasInVeh then
		if pos then p:SetPos(pos) end
		if ang then p:SetEyeAngles(Angle(0, ang.y, 0)) end

		local dur = 3.6
		p:SetNWFloat("WakeUpLockTime", CurTime() + dur)
		p:SetNWFloat("WakeUpDuration", dur)
		p:SetNWString("WakeUpSeq", "zombie_slump_rise_01")
		p:SetNWBool("WakeUpActive", true)
		p:SetNWAngle("WakeUpLockAng", p:EyeAngles())
	end

	p:UnSpectate()
	p:SetObserverMode(0)
	p:SetMoveType(MOVETYPE_WALK)
	p:Freeze(false)
	p:SetHealth(math.Clamp(hp, 1, p:GetMaxHealth()))
	p:SetArmor(ar)
	p:SetPlayerColor(d.plyColor or Color(1,1,1))

	for gr, v in pairs(d.bg or {}) do p:SetBodygroup(gr, v) end

	p:SetDSP(0, false)
	p.blockcontrols = false
	Downed[p] = nil
end

function Sleep(p, dur, pos, ang)
	if not IsValid(p) or not p:Alive() or IsValid(p:GetNWEntity("Ragdoll")) or p:GetNWBool("UnconsciousInVehicle", false) then return end

	if p:GetNWBool("WakeUpActive", false) then
		p:SetNWBool("WakeUpActive", false)
		p:SetNWFloat("WakeUpLockTime", 0)
		p:SetNWFloat("WakeUpDuration", 0)
		p:SetNWString("WakeUpSeq", "")
		p:SetNWAngle("WakeUpLockAng", Angle(0,0,0))
	end
	
	KOs[p] = KOs[p] or { hits = 0, time = 0 }
	if CurTime() - KOs[p].time > 60 then KOs[p].hits = 0 end
	KOs[p].hits = KOs[p].hits + 1
	KOs[p].time = CurTime()

	local wk = math.Clamp((dur or 30) * 0.8 + 10, 20, 80)
	local c = p:GetPlayerColor()
	local ar = p:Armor()

	local veh = p.GetSimfphys and p:GetSimfphys()
	if IsValid(veh) then
		p:SetNWBool("UnconsciousInVehicle", true)
		p:SetNWBool("Unconscious", true)
		p.blockcontrols = true
		p:SetDSP(14, false)
		Downed[p] = { inVehicle = true, hp = p:Health(), ar = ar, wakeTime = CurTime() + wk, plyColor = c, pos = p:GetPos(), ang = p:GetAngles() }
		if not p:HasWeapon("weapon_EbanieHands") then
			p:Give("weapon_EbanieHands")
		end
		return
	end

	local droppedClass = nil
	if not is_a(p) then
		local actWep = p:GetActiveWeapon()
		if IsValid(actWep) and actWep:GetClass() != "weapon_EbanieHands" and not nWeps[actWep:GetClass()] then
			droppedClass = actWep:GetClass()
			local wep = p:DropWeapon(actWep)
			if IsValid(wep) then
				wep:SetPos(p:GetPos() + Vector(0,0,20))
				wep:SetAngles(p:GetAngles())
			end
		end
	end

	if not p:HasWeapon("weapon_EbanieHands") then
		p:Give("weapon_EbanieHands")
	end
	p:SelectWeapon("weapon_EbanieHands")

	local am, w, h = {}, {}, false
	for i = 0, 128 do
		local aC = p:GetAmmoCount(i)
		if aC > 0 then am[i] = aC end
	end
	for _, wp in ipairs(p:GetWeapons()) do
		if IsValid(wp) then
			if wp:GetClass() == droppedClass then continue end
			if wp:GetClass() == "weapon_EbanieHands" then h = true end
			table.insert(w, { class = wp:GetClass(), c1 = wp:Clip1(), c2 = wp:Clip2() })
		end
	end

	local r = ents.Create("prop_ragdoll")
	r:SetModel(p:GetModel())
	local pPos = pos or p:GetPos()
	local pAng = ang or p:GetAngles()
	r:SetPos(pPos)
	r:SetAngles(pAng)
	r:SetSkin(p:GetSkin())
	for i = 0, p:GetNumBodyGroups() - 1 do r:SetBodygroup(i, p:GetBodygroup(i)) end
	r:Spawn()
	r:Activate()

	local v = p:GetVelocity() * 0.15
	for i = 0, r:GetPhysicsObjectCount() - 1 do
		local ph = r:GetPhysicsObjectNum(i)
		if IsValid(ph) then
			local b = r:TranslatePhysBoneToBone(i)
			if b and b >= 0 then
				local bp, ba = p:GetBonePosition(b)
				if bp and ba then ph:SetPos(bp) ph:SetAngles(ba) end
			end
			ph:SetVelocity(v)
			ph:SetMass(ph:GetMass() * 3)
		end
	end

	r:SetNWEntity("Owner", p)
	r.cuffed = p:GetNWBool("HandCuffed", false)
	p:SetNWEntity("Ragdoll", r)
	p:SetNWBool("Unconscious", true)
	Downed[p] = { ragdoll = r, hp = p:Health(), ar = ar, wakeTime = CurTime() + wk, weps = w, ammo = am, hands = h, plyColor = c, pos = pPos, ang = pAng, bg = {} }
	for i = 0, p:GetNumBodyGroups() - 1 do Downed[p].bg[i] = p:GetBodygroup(i) end

	p:Spectate(OBS_MODE_CHASE)
	p:SpectateEntity(r)
	p:SetDSP(14, false)
end

hook.Add("DoPlayerDeath", "u_d", function(p, atk, dmg)
	local r = p:GetNWEntity("Ragdoll")
	Clr(p)
	p:SetDSP(14, false)
	p:SetNWBool("Unconscious", false)
	p:SetNWFloat("DeathTime", CurTime())
	p:SetNWBool("UnconsciousInVehicle", false)
	p.blockcontrols = false

	local am, w, h = {}, {}, false
	for i = 0, 128 do
		local aC = p:GetAmmoCount(i)
		if aC > 0 then am[i] = aC end
	end
	for _, wp in ipairs(p:GetWeapons()) do
		if IsValid(wp) then
			if wp:GetClass() == "weapon_EbanieHands" then h = true end
			table.insert(w, { class = wp:GetClass(), c1 = wp:Clip1(), c2 = wp:Clip2() })
		end
	end
	DeathInventory[p] = { weps = w, ammo = am, hands = h, plyColor = p:GetPlayerColor() }

	if IsValid(r) then
		if not r:GetNWBool("HeadExploded") then r:SetNWBool("Dead", true) end
		r:SetNWEntity("Owner", p)
		p:SetNWEntity("Ragdoll", r)
		p:Spectate(OBS_MODE_CHASE)
		p:SpectateEntity(r)
	else
		local sP, sA, sV = p:GetPos(), p:GetAngles(), p:GetVelocity() * 0.15
		local veh = p.GetSimfphys and p:GetSimfphys()
		if IsValid(veh) then
			sP, sA, sV = veh:GetPos() + Vector(0,0,16), veh:GetAngles(), veh:GetVelocity() * 0.15
			p:ExitVehicle()
		end
		local c = ents.Create("prop_ragdoll")
		c:SetModel(p:GetModel())
		c:SetPos(sP)
		c:SetAngles(sA)
		c:SetSkin(p:GetSkin())
		for i = 0, p:GetNumBodyGroups() - 1 do c:SetBodygroup(i, p:GetBodygroup(i)) end
		c:Spawn()
		c:Activate()
		for i = 0, c:GetPhysicsObjectCount() - 1 do
			local ph = c:GetPhysicsObjectNum(i)
			if IsValid(ph) then
				local b = c:TranslatePhysBoneToBone(i)
				if b and b >= 0 then
					local bp, ba = p:GetBonePosition(b)
					if bp and ba then ph:SetPos(bp) ph:SetAngles(ba) end
				end
				ph:SetVelocity(sV)
				ph:SetMass(ph:GetMass() * 3)
			end
		end
		c:SetNWBool("Dead", true)
		c:SetNWEntity("Owner", p)
		p:SetNWEntity("Ragdoll", c)
		p:Spectate(OBS_MODE_CHASE)
		p:SpectateEntity(c)
	end
	Downed[p] = nil
	return true
end)

hook.Add("PlayerDeathThink", "r_b", function(p)
	local d = p:GetNWFloat("DeathTime", 0)
	if d > 0 and (CurTime() - d) < 120 then return false end
end)

hook.Add("PlayerSpawn", "u_s", function(p)
	p:SetNWEntity("Ragdoll", NULL)
	Clr(p)
	p:UnSpectate()
	p:SetObserverMode(0)
	p:SetDSP(0, false)
	p:SetNWBool("Unconscious", false)
	p:SetNWBool("UnconsciousInVehicle", false)
	p:SetNWFloat("DeathTime", 0)
	p.blockcontrols = false
	p:SetMoveType(MOVETYPE_WALK)
	p:Freeze(false)
	p:SetEyeAngles(Angle(0, 0, 0))
	Hits[p] = nil
	DeathInventory[p] = nil

	timer.Simple(0.1, function()
		if IsValid(p) then
			p:UnSpectate()
			p:SetObserverMode(0)
			p:SetMoveType(MOVETYPE_WALK)
			p:Freeze(false)
			p:SetEyeAngles(Angle(0, 0, 0))
			p.blockcontrols = false
			local c = p.GetSimfphys and p:GetSimfphys()
			if IsValid(c) then
				if c.SetHornKeyDown then c:SetHornKeyDown(false) end
				if c.SetIsHornPressed then c:SetIsHornPressed(false) end
				c.HornKeyIsDown = false
				if c.SetNWBool then c:SetNWBool("horn", false) end
				if c.horn then c.horn:Stop() c.horn = nil end
			end
		end
	end)
end)

hook.Add("PlayerDisconnected", "u_dc", function(p)
	local d = Downed[p]
	if d then
		if d.ragdoll and IsValid(d.ragdoll) and not d.ragdoll:GetNWBool("Dead") and not d.ragdoll:GetNWBool("HeadExploded") then d.ragdoll:Remove() end
		if d.inVehicle then
			local b = p.GetSimfphys and p:GetSimfphys()
			if IsValid(b) and b:GetDriver() == p then
				if b.SetHornKeyDown then b:SetHornKeyDown(false) else b.HornKeyIsDown = false end
				if b.SetIsHornPressed then b:SetIsHornPressed(false) end
				if b.SetNWBool then b:SetNWBool("horn", false) end
				if b.horn then b.horn:Stop() b.horn = nil end
			end
		end
		Downed[p] = nil
	end
	p:SetNWEntity("Ragdoll", NULL)
	p:SetNWBool("Unconscious", false)
	p:SetNWBool("UnconsciousInVehicle", false)
	Clr(p)
end)

hook.Add("CalcMainActivity", "sA_sv", function(p)
	if p:GetNWFloat("MedLockTime", 0) > CurTime() then
		local sI = p:LookupSequence("roofidle1")
		if sI and sI >= 0 then return ACT_HL2MP_IDLE, sI end
	end
end)

hook.Add("UpdateAnimation", "aU_sv", function(p)
	if p:GetNWFloat("MedLockTime", 0) > CurTime() then
		local sI = p:LookupSequence("roofidle1")
		if sI and sI >= 0 then
			p:SetSequence(sI)
			return true
		end
	end
end)

hook.Add("EntityTakeDamage", "u_dmg", function(t, d)
	if not IsValid(t) then return end

	if t:IsVehicle() or (t.GetClass and string.find(string.lower(t:GetClass()), "simfphys")) then
		local p = {}
		if t.GetDriver and IsValid(t:GetDriver()) then table.insert(p, t:GetDriver()) end
		if t.GetPassengerSeats then
			for _, s in pairs(t:GetPassengerSeats()) do
				if IsValid(s) and s.GetDriver and IsValid(s:GetDriver()) then table.insert(p, s:GetDriver()) end
			end
		end
		for _, pl in ipairs(player.GetAll()) do
			if pl:Alive() and pl:InVehicle() and (pl:GetVehicle() == t or (t.GetDriver and t:GetDriver() == pl)) then
				if not table.HasValue(p, pl) then table.insert(p, pl) end
			end
		end

		for _, ps in ipairs(p) do
			if IsValid(ps) and ps:IsPlayer() and ps:Alive() then
				if not d:IsDamageType(DMG_BULLET) and not d:IsDamageType(DMG_BUCKSHOT) and not d:IsDamageType(DMG_DIRECT) then
					local a = d:GetDamage()
					if d:IsDamageType(DMG_CRUSH) then a = a * 0.15 end
					if a > 0 then
						local dp = DamageInfo()
						dp:SetDamage(a)
						dp:SetAttacker(d:GetAttacker())
						dp:SetInflictor(d:GetInflictor() or d:GetAttacker())
						dp:SetDamageType(bit.bor(d:GetDamageType(), DMG_DIRECT))
						dp:SetDamagePosition(d:GetDamagePosition())
						ps:TakeDamageInfo(dp)
					end
				end
			end
		end
	end

	if t:IsPlayer() and t:Alive() then
		local a = d:GetDamage()
		if t:GetNWBool("UnconsciousInVehicle", false) then
			if Downed[t] then
				Downed[t].hp = Downed[t].hp - a
				t:SetHealth(math.max(0, t:Health() - a))
				if Downed[t].hp <= 0 or t:Health() <= 0 then Downed[t] = nil t:Kill() end
			end
			d:SetDamage(0)
			return true
		end

		if a > 0 then
			Hits[t] = Hits[t] or {}
			table.insert(Hits[t], { time = CurTime(), amt = a })
			local l, tot = CurTime() - 10, 0
			for i = #Hits[t], 1, -1 do
				local h = Hits[t][i]
				if h.time < l then table.remove(Hits[t], i) else tot = tot + h.amt end
			end

			local veh = t.GetSimfphys and t:GetSimfphys()
			local inAnyVeh = t:InVehicle()
			local isDriver = false
			if inAnyVeh then
				local v = t:GetVehicle()
				if IsValid(v) and v.GetDriver then
					isDriver = (v:GetDriver() == t)
				end
			end

			if IsValid(veh) and isDriver then
				local thr = 20
				if d:IsBulletDamage() or d:IsDamageType(DMG_BUCKSHOT) then thr = 40 end
				if a >= thr or tot >= thr or (t:Health() - a) <= 30 then
					timer.Simple(0, function()
						if IsValid(t) and t:Alive() then Sleep(t, a) end
					end)
				end
			elseif not inAnyVeh then
				local fallDmg = d:IsDamageType(DMG_FALL)
				if (fallDmg or t:Armor() <= 0) and ((t:Health() - a) <= 30 or tot >= 40) then
					timer.Simple(0, function()
						if IsValid(t) and t:Alive() then Sleep(t, a) end
					end)
				end
			end
		end
	end

	if t:GetClass() == "prop_ragdoll" and not t:GetNWBool("HeadExploded") then
		local dp, pb = d:GetDamagePosition(), -1
		if dp and dp ~= Vector(0,0,0) then
			local c = math.huge
			for i = 0, t:GetPhysicsObjectCount() - 1 do
				local ph = t:GetPhysicsObjectNum(i)
				if IsValid(ph) then
					local dst = ph:GetPos():DistToSqr(dp)
					if dst < c then c = dst pb = i end
				end
			end
		end

		local iH = false
		if pb ~= -1 then
			local b = t:GetBoneName(t:TranslatePhysBoneToBone(pb))
			iH = b and (string.find(string.lower(b), "head") or string.find(string.lower(b), "face"))
		end

		local iF = d:IsBulletDamage() or d:IsDamageType(DMG_BUCKSHOT) or d:IsDamageType(DMG_BLAST) or d:IsDamageType(DMG_SLASH)
		if iH and iF then
			t.HDmg = (t.HDmg or 0) + d:GetDamage()
			if t.HDmg >= 200 or d:GetDamage() >= 200 then
				t:SetNWBool("HeadExploded", true)
				t:SetNWBool("Dead", true)
				local hI = t:LookupBone("ValveBiped.Bip01_Head1")
				if hI then t:ManipulateBoneScale(hI, Vector(0,0,0)) end
				
				if dp == Vector(0,0,0) then
					local pO = t:GetPhysicsObjectNum(pb ~= -1 and pb or 0)
					dp = IsValid(pO) and pO:GetPos() or t:WorldSpaceCenter()
				end

				local fx = EffectData()
				fx:SetOrigin(dp)
				fx:SetScale(6)
				util.Effect("BloodImpact", fx)
				for i = 1, 5 do util.Effect("bloodspray", fx) end
				for i = 1, 6 do
					local rD = VectorRand()
					rD.z = rD.z - 0.6
					rD:Normalize()
					local tr = util.TraceLine({ start = dp, endpos = dp + rD * 150, filter = t })
					if tr.Hit then util.Decal("Blood", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, t) end
				end

				for i = 1, 3 do
					local dec = sd[math.random(1,#sd)]
					local dir = VectorRand()
					dir.z = dir.z - 0.5
					dir:Normalize()
					local tr = util.TraceLine({start=dp, endpos=dp + dir*100, filter=t})
					if tr.Hit then
						util.Decal(dec, tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal, t)
					end
				end

				   t:EmitSound("npc/antlion_grub/squashed.wav", 80, 95)

				for pl, dt in pairs(Downed) do
					if dt.ragdoll == t and IsValid(pl) then dt.hp = 0 Downed[pl] = nil pl:Kill() break end
				end
				return
			end
		end

		if not t:GetNWBool("Dead") then
			for pl, dt in pairs(Downed) do
				if dt.ragdoll == t and IsValid(pl) then
					local a = d:GetDamage()
					if d:IsDamageType(DMG_CRUSH) then a = math.min(a * 0.2, 15) end
					dt.hp = math.Clamp(dt.hp - a, 0, pl:GetMaxHealth())
					if dt.hp <= 0 then Downed[pl] = nil pl:Kill() end
					break
				end
			end
		end
	end
end)

hook.Add("Think", "u_loop", function()
	for p, d in pairs(Downed) do
		if not IsValid(p) or not p:Alive() then
			if d.ragdoll and IsValid(d.ragdoll) and not d.ragdoll:GetNWBool("Dead") and not d.ragdoll:GetNWBool("HeadExploded") then d.ragdoll:Remove() end
			if IsValid(p) then p:SetDSP(0, false) p.blockcontrols = false end
			Downed[p] = nil
		elseif d.inVehicle then
			local b = p.GetSimfphys and p:GetSimfphys()
			if not IsValid(b) then
				p:SetNWBool("UnconsciousInVehicle", false)
				p:SetNWBool("Unconscious", false)
				p.blockcontrols = false
				local rm = math.max(0.1, d.wakeTime - CurTime())
				local hp = d.hp
				local ar = d.ar
				local pos = d.pos
				local ang = d.ang
				Downed[p] = nil
				Sleep(p, rm, pos, ang)
				if Downed[p] then Downed[p].hp = hp Downed[p].ar = ar end
			else
				if b:GetDriver() == p then
					p.blockcontrols = true
					if not b.HookedUnconFuncs then
						b.HookedUnconFuncs = true
						local oSH = b.SetIsHornPressed
						if oSH then
							b.SetIsHornPressed = function(e, bl)
								local dr = e:GetDriver()
								if IsValid(dr) and dr:GetNWBool("UnconsciousInVehicle", false) then oSH(e, true) return end
								oSH(e, bl)
							end
						end
					end

					if b.PressedKeys then
						b.PressedKeys["w"], b.PressedKeys["a"], b.PressedKeys["s"], b.PressedKeys["d"], b.PressedKeys["r"] = false, false, false, false, false
						b.PressedKeys["h"] = true
						local k = {"joystick_steer_left", "joystick_steer_right", "joystick_throttle", "joystick_brake", "joystick_handbrake"}
						for _, v in ipairs(k) do if b.PressedKeys[v] then b.PressedKeys[v] = 0 end end
					end

					if b.Inputs then 
						b.Inputs.Throttle = 0
						b.Inputs.Steer = 0
						b.Inputs.Brake = 0
						b.Inputs.HandBrake = 0
						b.Inputs.Clutch = 0
						b.Inputs.Horn = 1
					end
					if b.SetThrottle then b:SetThrottle(0) end
					if b.SetSteer then b:SetSteer(0) end
					if b.SetHandBrakeEnabled then b:SetHandBrakeEnabled(false) end
					if b.SetIsBraking then b:SetIsBraking(false) end
					if b.SetHornKeyDown then b:SetHornKeyDown(true) else
						b.HornKeyIsDown = true
						if not b.horn and b.snd_horn then b.horn = CreateSound(b, b.snd_horn) end
						if b.horn then b.horn:PlayEx(1, 100) end
					end
					if b.SetNWBool then b:SetNWBool("horn", true) end
					if b.Brake then b.Brake = 0 end
					b.ms_Steer = 0
				end
				if CurTime() >= d.wakeTime then WakeUp(p) end
			end
		elseif not d.inVehicle and not IsValid(d.ragdoll) then
			if IsValid(p) then p:SetDSP(0, false) p:SetNWBool("Unconscious", false) end
			Downed[p] = nil
		elseif CurTime() >= d.wakeTime then
			local b = p.GetSimfphys and p:GetSimfphys()
			if IsValid(b) then
				if b.SetHornKeyDown then b:SetHornKeyDown(false) else b.HornKeyIsDown = false end
				if b.SetIsHornPressed then b:SetIsHornPressed(false) end
				if b.SetNWBool then b:SetNWBool("horn", false) end
				if b.horn then b.horn:Stop() b.horn = nil end
			end
			WakeUp(p)
		end
	end
end)

hook.Add("Think", "clear_wakeup", function()
	for _, p in ipairs(player.GetAll()) do
		if IsValid(p) and p:GetNWBool("WakeUpActive", false) then
			local lockTime = p:GetNWFloat("WakeUpLockTime", 0)
			if lockTime > 0 and CurTime() >= lockTime then
				p:SetNWBool("WakeUpActive", false)
				p:SetNWFloat("WakeUpLockTime", 0)
				p:SetNWFloat("WakeUpDuration", 0)
				p:SetNWString("WakeUpSeq", "")
				p:SetNWAngle("WakeUpLockAng", Angle(0,0,0))
			end
		end
	end
end)

hook.Add("Think", "u_v_s", function()
	for _, pl in ipairs(player.GetAll()) do
		if IsValid(pl) then
			local b = not pl:Alive() or pl:GetNWBool("UnconsciousInVehicle", false) or IsValid(pl:GetNWEntity("Ragdoll"))
			if b and pl:IsSpeaking() then pl:ConCommand("voicestop") end
		end
	end
end)

hook.Add("CanExitVehicle", "e_b", function(v, p)
	local veh = p.GetSimfphys and p:GetSimfphys()
	if IsValid(veh) and p:GetNWBool("UnconsciousInVehicle", false) then return false end
end)

hook.Add("StartCommand", "u_c", function(p, c)
	if IsValid(p) and p:Alive() and (p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) or p:GetNWBool("WakeUpActive", false)) then
		c:ClearMovement() c:ClearButtons() c:SetForwardMove(0) c:SetSideMove(0) c:SetUpMove(0)
		local b = p.GetSimfphys and p:GetSimfphys()
		if IsValid(b) and b:GetDriver() == p then
			b.ms_Steer = 0
			if b.PressedKeys then
				b.PressedKeys["w"], b.PressedKeys["a"], b.PressedKeys["s"], b.PressedKeys["d"], b.PressedKeys["r"] = false, false, false, false, false
				b.PressedKeys["h"] = true
				local k = {"joystick_steer_left", "joystick_steer_right", "joystick_throttle", "joystick_brake", "joystick_handbrake"}
				for _, v in ipairs(k) do if b.PressedKeys[v] then b.PressedKeys[v] = 0 end end
			end
			if b.Inputs then 
				b.Inputs.Throttle = 0
				b.Inputs.Steer = 0
				b.Inputs.Brake = 0
				b.Inputs.HandBrake = 0
				b.Inputs.Horn = 1 
			end
			if b.SetHornKeyDown then b:SetHornKeyDown(true) else
				b.HornKeyIsDown = true
				if not b.horn and b.snd_horn then b.horn = CreateSound(b, b.snd_horn) end
				if b.horn then b.horn:PlayEx(1, 100) end
			end
			if b.SetNWBool then b:SetNWBool("horn", true) end
			if b.Brake then b.Brake = 0 end
		end
	end
end)

hook.Add("PlayerSwitchWeapon", "u_sw", function(ply, old, new)
	if ply:GetNWBool("UnconsciousInVehicle", false) or IsValid(ply:GetNWEntity("Ragdoll")) or ply:GetNWBool("WakeUpActive", false) then return true end
end)

hook.Add("PlayerSay", "u_c_blk", function(ply, text, teamChat)
	if IsValid(ply) and (not ply:Alive() or ply:GetNWBool("UnconsciousInVehicle", false) or IsValid(ply:GetNWEntity("Ragdoll")) or ply:GetNWBool("WakeUpActive", false)) then return "" end
end)

local function Bk(p) if IsValid(p) and p:Alive() and (p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) or p:GetNWBool("WakeUpActive", false)) then return true end end
local function BkR(p) if IsValid(p) and p:Alive() and (p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) or p:GetNWBool("WakeUpActive", false)) then return false end end

hook.Add("KeyPress", "kp_b", Bk)
hook.Add("KeyRelease", "kr_b", Bk)
hook.Add("PlayerButtonDown", "btn_b", Bk)
hook.Add("PlayerPropertyBonusChanged", "p_b", BkR)

concommand.Add("testuncon", function(ply, cmd, args)
    if not IsValid(ply) or not ply:Alive() then return end
    local dur = tonumber(args[1]) or 10
    Sleep(ply, dur)
end)

util.AddNetworkString("SKO")
local lastSKO = {}
hook.Add("Think", "s_ko", function()
    for _, p in ipairs(player.GetAll()) do
        if not IsValid(p) or not p:Alive() then continue end
        if p:GetNWBool("Unconscious", false) or p:GetNWBool("UnconsciousInVehicle", false) or IsValid(p:GetNWEntity("Ragdoll")) then continue end

        local shock = p:GetNWFloat("Shock", 0)
        if shock > 150 then
            local last = lastSKO[p] or 0
            if CurTime() - last > 5 then
                local dur = math.random(15, 25)
                Sleep(p, dur)
                p:SetNWFloat("Shock", 0)
                lastSKO[p] = CurTime()
                net.Start("SKO")
                net.Send(p)
            end
        end
    end
end)
