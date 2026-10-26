--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/modules/sh_management.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin.addCommand({
	name = "ban",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"time"},
		{"text", "reason"}
	},
	func = function(ply, args, silent)
		if not args[1] then return end
		local targets = sAdmin.getTargets("ban", ply, args[1], 1)
		local time = sAdmin.getTime(args[2])
		local reason = args[3] or slib.getLang("sadmin", sAdmin.config["language"], "no_reason_provided")

		for k, v in ipairs(targets) do
			if sAdmin.config["super_users"][v:SteamID64()] then continue end
			if ply == v then continue end
			sAdmin.banPly(v, time, reason, ply)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "ban_response", ply, targets, time, reason)
	end
})

sAdmin.addCommand({
	name = "banid",
	category = "Management",
	inputs = {
		{"text", "sid64/sid"},
		{"time"},
		{"text", "reason"}
	},
	func = function(ply, args, silent)
		local sid64 = sAdmin.convertSID64(args[1])
		if not sid64 then return end
		local time = sAdmin.getTime(args[2])
		local reason = args[3] or slib.getLang("sadmin", sAdmin.config["language"], "no_reason_provided")

		if sAdmin.config["super_users"][sid64] then return end

		if IsValid(slib.sid64ToPly[sid64]) then
			sAdmin.banPly(slib.sid64ToPly[sid64], time, reason, ply)
		else
			sAdmin.addBan(sid64, time, reason, ply)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "banid_response", ply, args[1], time, reason)
	end
})

sAdmin.addCommand({
	name = "unban",
	category = "Management",
	inputs = {
		{"text", "sid64/sid"}
	},
	func = function(ply, args, silent)
		local sid64 = sAdmin.convertSID64(args[1])
		if not sid64 then return end
		sAdmin.unban(sid64)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unban_response", ply, args[1])
	end
})

sAdmin.addCommand({
	name = "kick",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"text", "reason"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("kick", ply, args[1], 1)
		local reason = args[2] or slib.getLang("sadmin", sAdmin.config["language"], "no_reason_provided")

		for k, v in ipairs(targets) do
			v:Kick(sAdmin.config["prefix"] .. reason)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "kick_response", ply, targets, reason)
	end
})

sAdmin.addCommand({
	name = "setrank",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"text", "rank"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets, rank, time = sAdmin.getTargets("setrank", ply, args[1], 1), args[2], sAdmin.getTime(args, 3)

		if not rank or not time then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		if not sAdmin.usergroups[rank] then
			sAdmin.msg(ply, "invalid_usergroup")

			return
		end

		if IsValid(ply) and not sAdmin.config["super_users"][ply:SteamID64()] then
			local rank_immunity = sAdmin.usergroups[rank] and sAdmin.usergroups[rank].permissions and sAdmin.usergroups[rank].permissions.immunity and tonumber(sAdmin.usergroups[rank].permissions.immunity) or 0

			if rank_immunity > (tonumber(sAdmin.hasPermission(ply, "immunity")) or 0) then
				sAdmin.msg(ply, "too_high_rank")

				return
			end
		end

		for k, v in ipairs(targets) do
			sAdmin.setRank(v, rank, time)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "setrank_response", ply, targets, rank, time)
	end
})

sAdmin.addCommand({
	name = "setrankid",
	category = "Management",
	inputs = {
		{"text", "sid64/sid"},
		{"text", "rank"},
		{"time"}
	},
	func = function(ply, args, silent)
		local sid64 = sAdmin.convertSID64(args[1])
		if not sid64 then return end
		local rank, time = args[2], sAdmin.getTime(args, 3)

		if not rank or not time then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		if not sAdmin.usergroups[rank] then
			sAdmin.msg(ply, "invalid_usergroup")

			return
		end

		if IsValid(ply) and not sAdmin.config["super_users"][ply:SteamID64()] then
			local rank_immunity = sAdmin.usergroups[rank] and sAdmin.usergroups[rank].permissions and sAdmin.usergroups[rank].permissions.immunity and tonumber(sAdmin.usergroups[rank].permissions.immunity) or 0

			if rank_immunity > (tonumber(sAdmin.hasPermission(ply, "immunity")) or 0) then
				sAdmin.msg(ply, "too_high_rank")

				return
			end
		end

		if IsValid(slib.sid64ToPly[sid64]) then
			sAdmin.setRank(slib.sid64ToPly[sid64], rank, time)
		else
			sAdmin.updatePlayerRank(sid64, rank, time)

			sAdmin.queueNetworking(nil, function(p)
				sAdmin.networkData(p, {"offlinePlayers", "refresh"}, true)
			end)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "setrankid_response", ply, args[1], rank, time)
	end
})

sAdmin.addCommand({
	name = "removeuser",
	category = "Management",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("removeuser", ply, args[1], 1)

		for k, v in ipairs(targets) do
			sAdmin.setRank(v, "user")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "removeuser_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "alwaysban",
	category = "Management",
	inputs = {
		{"text", "sid"},
	},
	func = function(ply, args, silent)
		if not args[1] then return end
		local sid = args[1]
		if string.StartWith(sid, "7656") then
			sid = util.SteamIDFrom64(sid)
		end
		if not sid or not string.StartWith(sid, "STEAM") then return end

		sAdmin.AlwaysBan[sid] = true
		file.Write("allwaysban.json", util.TableToJSON(sAdmin.AlwaysBan))

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s добавил %s в ЧС мультиакков", ply, sid)
	end
})

-- sAdmin.addCommand({
-- 	name = "getip",
-- 	category = "Management",
-- 	inputs = {
-- 		{"player", "player_name"}
-- 	},
-- 	func = function(ply, args, silent)
-- 		local targets = sAdmin.getTargets("removeuser", ply, args[1], 1)

-- 		for k, v in ipairs(targets) do
-- 			sAdmin.setRank(v, "user")
-- 		end
-- 		// http://ip-api.com/json/85.196.251.158?fields=status,message,country,countryCode,region,regionName,city,timezone&lang=ru
-- 		sAdmin.msg(silent and ply or sAdmin.logPerm(), "removeuser_response", ply, targets)
-- 	end
-- })

local isConsole = {
	["0"] = true,
	["[NULL Entity]"] = true
}

local function repring(arg)
	local log = ""

	for k,v in ipairs(arg) do
		if isstring(v) then
			log = log .. v
		end
	end

	return log
end

sAdmin.addCommand({
	name = "checkban",
	category = "Management",
	inputs = {
		{"text", "sid64/sid"},
	},
	func = function(ply, args, silent)
		local sid64 = sAdmin.convertSID64(args[1])
		if not sid64 then return end

		if sAdmin.bans[sid64] and (tonumber(sAdmin.bans[sid64].expiration) == 0 or tonumber(sAdmin.bans[sid64].expiration) > os.time()) then
			local unbanTime = tonumber(sAdmin.bans[sid64].expiration) or 0
			local timeLeft = unbanTime == 0 and slib.getLang("sadmin", sAdmin.config["language"], "eternity") or sAdmin.formatTime(unbanTime - os.time())
			local log = sAdmin.msg(silent and ply or sAdmin.logPerm(), "Исполнитель: %s Причина: %s Время: %s", isConsole and isConsole[sAdmin.bans[sid64].admin_sid64] and slib.getLang("sadmin", sAdmin.config["language"], "console") or sAdmin.bans[sid64].admin_sid64, sAdmin.bans[sid64].reason, timeLeft)

			Discord.Log("request", {content = repring(log)})
			return
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "Нет активных банов")
		Discord.Log("request", {content = "❎ Нет активных банов"})
	end
})

sAdmin.addCommand({
	name = "claim_donation",
	category = "Management",
	inputs = {
		{"text", "paymentId"}
	},
	func = function(ply, args, silent)
		local paymentId = args[1]
		if not paymentId then return end

		Glac.Donations.Claim(paymentId, function(result)
			if result.success then
				Discord.Log("request", {content = "✅ Платеж принят"})
			else
				Discord.Log("request", {content = "❌ Нет платежа"})
			end
		end)
	end
})