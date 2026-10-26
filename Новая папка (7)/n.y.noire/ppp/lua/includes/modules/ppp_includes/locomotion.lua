--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/includes/modules/ppp_includes/locomotion.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
custom = {}

if SERVER then
	function custom.meleeEx(ply, ent, tbl)
		-- Small edit that can use a custom dmgType and doesn't force an animation, for morphs with multiple attacks in a single anim
		if not ply:IsOnGround() then return end

		timer.Simple(tbl.delay, function()
			if not IsValid(ent) then return end
			if not IsValid(ent) then return end

			if ply:TraceHullAttack(ply:EyePos(), ply:EyePos() + ply:EyeAngles():Forward() * tbl.range, Vector(-10, -10, -10), Vector(10, 10, 10), tbl.dmg, tbl.dmgType, 0.1, true) then
				ent:PillSound("melee_hit")
			else
				ent:PillSound("melee_miss")
			end
		end)
	end

	function custom.LocoAnim(ply, ent, anim)
		-- New function that uses animation locomotion (ish)
		if not ply:IsOnGround() then return end
		ent:PillAnim(anim, true)
		local seq, dur = ent:GetPuppet():LookupSequence(ent.formTable.anims.default[anim])
		local ga, gb, gc = ent:GetPuppet():GetSequenceMovement(seq, 0, 1)

		-- The animation has no locomotion or it's invalid or we failed in some other way.
		if not ga then
			print("ga failed")

			return
		end

		local pos = ply:GetPos()
		local trin = {}
		trin.maxs = Vector(16, 16, 72)
		trin.mins = Vector(-16, -16, 0)
		trin.start = ply:EyePos()
		trin.endpos = gb

		trin.filter = {ply, ent, ent:GetPuppet()}

		local trout = util.TraceHull(trin)
		local gd_prev = ent:GetPuppet():GetCycle()

		for i = 1, dur * 1000 do
			timer.Simple(0.001 * i, function()
				if not IsValid(ent) then return end
				if ply:GetPos() == trout.HitPos then return end -- Avoid going through walls if possible chief.
				local gd_cur = ent:GetPuppet():GetCycle()
				local ga2, gb2, gc2 = ent:GetPuppet():GetSequenceMovement(seq, gd_prev, gd_cur)
				gd_prev = gd_cur

				if not ga2 then
					print("ga failed")

					return
				end

				if gd_cur == 0 then return end
				if not util.IsInWorld(ply:LocalToWorld(gb2)) then return end
				ply:SetPos(ply:LocalToWorld(gb2))
				ply:SetAngles(ply:LocalToWorldAngles(gc2))
			end)
		end
	end
end