--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/modules/sh_fun.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin.addCommand({
	name = "freeze",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("freeze", ply, args[1])

		for k, v in ipairs(targets) do
			v:Freeze(true)
			v:EmitSound("player/pl_drown2.wav")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "freeze_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "unfreeze",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unfreeze", ply, args[1])

		for k, v in ipairs(targets) do
			v:Freeze(false)
			v:EmitSound("player/pl_drown1.wav")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unfreeze_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "jail",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("jail", ply, args[1])
		local time = sAdmin.getTime(args, 2)

		for k, v in ipairs(targets) do
			local sid64 = v:SteamID64()
			if sid64 and sAdmin.jailData[sid64] then continue end

			if v == ply and args[1] == "*" then
				sAdmin.msg(ply, "cant_target_self")
				table.remove(targets, k)
				continue
			end

			sAdmin.jailPly(v, time)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "jail_response", ply, targets, time)
	end
})

sAdmin.addCommand({
	name = "unjail",
	category = "Management",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unjail", ply, args[1])

		for k, v in ipairs(targets) do
			sAdmin.unjailPly(v)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unjail_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "strip",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("strip", ply, args[1])

		for k, v in ipairs(targets) do
			v:StripWeapons()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "strip_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "slay",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("slay", ply, args[1])

		for k, v in ipairs(targets) do
			v:Kill()

			timer.Simple(1, function()
				if not IsValid(v) or not IsValid(v.DeathRagdoll) then return end
				v.DeathRagdoll.crithit = true
			end)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "slay_response", ply, targets)
	end
})

local pos_shots = {
	Vector(5008.9340820313,8235.1787109375,1100.6239013672),
	Vector(0,0,1651.5738525391),
	Vector(0,8448,1651.5738525391),
	Vector(5483.2626953125,5288.7026367188,773.67565917969),
	Vector(3951.3996582031,32.295654296875,1239.9278564453),
	Vector(8979.431640625,4597.8227539063,615.26647949219),
	Vector(1665.7216796875,-1725.89453125,541.54162597656),
	Vector(-12385.08984375,-9961.2861328125,384.34826660156),
	Vector(-2028.4117431641,2797.2224121094,988.95941162109),
}

sAdmin.addCommand({
	name = "slay_shot",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("slay", ply, args[1])

		for _, pl in ipairs(targets) do
			local close, spos, dist
			for _, pos in ipairs(pos_shots) do
				dist = pos:DistToSqr(pl:GetPos())
				if not close or close > dist then
					close = dist
					spos = pos
				end
			end
			DarkRP.UIEffect(nil, "DistSound", {spos, "Reflection_Sniper.Distance", "Reflection_Sniper.Distance"})
			pl.crithit = true
			local bullet = {
				Num = 1,
				Src = pl:EyePos(),
				Dir = pl:GetAngles():Right(),
				Tracer = 0,
				Damage = 7777
			}
			Entity(0):FireBullets(bullet)

			timer.Simple(0.01, function()
				if not IsValid(pl) or not IsValid(pl.DeathRagdoll) then return end
				pl.crithit = nil
				pl.DeathRagdoll.crithit = true
				DarkRP.BlowHead(pl.DeathRagdoll, pl)
			end)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "slay_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "slay_balka",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("slay", ply, args[1])

		for _, pl in ipairs(targets) do
			local ent = ents.Create("prop_physics")
			ent:SetModel( "models/props_junk/CinderBlock01a.mdl" )
			ent:SetAngles( pl:GetAngles() )
			ent:SetPos( pl:GetPos() + Vector(0,0,500) )
			ent:Spawn()

			timer.Simple(30, function()
				if IsValid(ent) then ent:Remove() end
			end)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "slay_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "exitvehicle",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("exitvehicle", ply, args[1])

		for k, v in ipairs(targets) do
			v:ExitVehicle()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "exitvehicle_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "respawn",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("respawn", ply, args[1])

		for k, v in ipairs(targets) do
			v:Spawn()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "respawn_response", ply, targets)
	end
})

local slap_sounds = {
	[1] = "physics/body/body_medium_impact_hard1.wav",
	[2] = "physics/body/body_medium_impact_hard2.wav",
	[3] = "physics/body/body_medium_impact_hard3.wav",
	[4] = "physics/body/body_medium_impact_hard4.wav",
	[5] = "physics/body/body_medium_impact_hard5.wav",
	[6] = "physics/body/body_medium_impact_hard6.wav"
}

sAdmin.addCommand({
	name = "slap",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"numeric", "damage"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("slap", ply, args[1])
		local dmg = tonumber(args[2] or 1)

		if not isnumber(dmg) then
			dmg = 1
		end

		dmg = dmg < 1 and 1 or dmg

		for k, v in ipairs(targets) do
			local dir = Vector(math.random(-150, 150), math.random(-150, 150), math.random(150, 350))
			v:SetVelocity(dir)
			local snd = table.Random(slap_sounds)
			v:EmitSound(snd)
			v:TakeDamage(dmg, v, v)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "slap_response", ply, targets, dmg)
	end
})

sAdmin.addCommand({
	name = "giveammo",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("giveammo", ply, args[1])
		local amount = args[2] or 1

		for k, v in ipairs(targets) do
			local wep = v:GetActiveWeapon()
			if not IsValid(wep) then continue end
			local ammotype = wep:GetPrimaryAmmoType()
			if ammotype == -1 then continue end
			v:GiveAmmo(amount, ammotype)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "giveammo_response", ply, amount, targets)
	end
})

sAdmin.addCommand({
	name = "ignite",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("ignite", ply, args[1])
		local time = sAdmin.getTime(args, 2)

		if not isnumber(time) then
			time = 1
		end

		time = time < 1 and 1 or time

		for k, v in ipairs(targets) do
			v:Ignite(time)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "ignite_response", ply, targets, time)
	end
})

sAdmin.addCommand({
	name = "extinguish",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("extinguish", ply, args[1])

		for k, v in ipairs(targets) do
			v:Extinguish()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "extinguish_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "setmodel",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"text", "model"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("setmodel", ply, args[1])
		local mdl = args[2]
		if not mdl or mdl == "" or mdl == " " then
			for _, p in ipairs(targets) do
				GAMEMODE:PlayerSetModel(p, DarkRP.Teams[p:Team()], p:Team())
			end
			return
		end

		for _, v in ipairs(targets) do
			for k, _ in pairs(v:GetMaterials()) do
				v:SetSubMaterial(k - 1, "")
			end

			v:SetModel(mdl)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "setmodel_response", ply, targets, mdl)
	end
})

sAdmin.addCommand({
	name = "scale",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"numeric", "scale"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("scale", ply, args[1])
		local size = args[2] or 1

		for k, v in ipairs(targets) do
			v:SetModelScale(size, 0)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "scale_response", ply, targets, size)
	end
})

sAdmin.addCommand({
	name = "speed",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("speed", ply, args[1])
		local speed = args[2] or 1

		for k, v in ipairs(targets) do
			v:SetWalkSpeed(speed)
			v:SetRunSpeed(speed)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "speed_response", ply, targets, speed)
	end
})

sAdmin.addCommand({
	name = "walkspeed",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("walkspeed", ply, args[1])
		local speed = args[2] or 1

		for k, v in ipairs(targets) do
			v:SetWalkSpeed(speed)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "walkspeed_response", ply, targets, speed)
	end
})

sAdmin.addCommand({
	name = "runspeed",
	category = "Fun",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("runspeed", ply, args[1])
		local speed = args[2] or 1

		for k, v in ipairs(targets) do
			v:SetRunSpeed(speed)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "runspeed_response", ply, targets, speed)
	end
})

sAdmin.addCommand({
	name = "bot",
	category = "Fun",
	inputs = {},
	func = function(ply, args, silent)
		RunConsoleCommand("bot")
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "bot_response", ply)
	end
})

sAdmin.addCommand({
	name = "setplaytime",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("jail", ply, args[1])
		local time = sAdmin.getTime(args, 2)

		if not tonumber(time) then return end

		for k, v in ipairs(targets) do
			local sid64 = v:SteamID64()
			if sid64 and sAdmin.jailData[sid64] then continue end

			v:SetProDarkRPVar("playtime", time)
			v:SetProDarkRPVar("synctime", CurTime())

			if sAdmin.playerData[sid64] then
				ply.lastact = CurTime()
				sAdmin.playerData[sid64].synctime = CurTime()
				sAdmin.playerData[sid64].playtime = time
			end

			sAdmin.updatePlayerSessionEnd(v)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s выставил наигранное время %s на %t.", ply, targets, time)
	end
})

sAdmin.addCommand({
	name = "piss",
	category = "Fun",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("slay", ply, args[1])

		for _, pl in ipairs(targets) do
			local ent = ents.Create("prop_physics")
			ent:SetModel( "models/effects/urban_puddle_model01a.mdl" )
			ent:SetMaterial( "models/props/cs_militia/floater_juice" )
			ent:SetAngles( pl:GetAngles() )
			ent:SetPos( pl:GetPos() )
			ent:Spawn()
			ent:DrawShadow(false)
			ent:SetSolid(SOLID_NONE)
			local phys = ent:GetPhysicsObject()
			if phys and phys:IsValid() then
				phys:EnableMotion(false)
			end
			ent:SetModelScale(0.1, 0)
			ent:SetModelScale(1, 10)

			timer.Simple(130, function()
				if IsValid(ent) then ent:Remove() end
			end)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "% force pissed %", ply, targets)
	end
})