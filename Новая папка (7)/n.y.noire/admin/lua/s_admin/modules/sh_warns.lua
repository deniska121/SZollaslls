--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/modules/sh_warns.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function warnPly(target, ply, reason)
	sAdmin.addWarn(target, ply, reason, function(amount)
		for k, v in SortedPairs(sAdmin.config["warns"]["punishments"], true) do
			if (tonumber(amount) or 0) >= k then
				if v.type == "kick" then
					sAdmin.addPunishmentLog(target, amount, 1)

					if IsValid(target) then
						target.autoban = true
						target:Kick(slib.getLang("sadmin", sAdmin.config["language"], "exceed_warn_limit", k, reason))
					end
				elseif v.type == "ban" then
					local sid64 = IsValid(target) and target:SteamID64() or target

					if IsValid(target) then
						target:EmitSound("noire/lowbat.wav")
						target:unArrest()
						if target.Restrained then
							target:CuffHands()
						end
						for _, a in pairs(ents.FindInSphere(target:GetPos(), 600)) do
							if not a:IsPlayer() then continue end
							print(a)
							sAdmin.msg(a, "%s заблокирован за нарушение правил.", target)
						end
					end

					if sAdmin.bans[sid64] and (tonumber(sAdmin.bans[sid64].expiration) == 0 or tonumber(sAdmin.bans[sid64].expiration) > os.time() + sAdmin.getTime(v.time or 0)) then
						sAdmin.msg(sAdmin.logPerm(), "%s уже в бане на срок выше", target)
					else
						sAdmin.addPunishmentLog(target, amount, 2)
						RunConsoleCommand("sa", "banid", IsValid(target) and target:SteamID64() or target, v.time or 0, slib.getLang("sadmin", sAdmin.config["language"], "exceed_warn_limit", k, reason))
					end
				end

				break
			end
		end

		sAdmin.queueNetworking(nil, function(p)
			sAdmin.networkData(p, {"offlineWarns", "refresh"}, true)

			sAdmin.networkData(p, {"onlineWarns", "refresh"}, true)
		end)
	end)

	if IsValid(target) then
		sAdmin.msg(target, "Вы получили предупреждение от администратора. Причина: %s", reason)
	end
end

sAdmin.addCommand({
	name = "notice",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"text", "reason"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("warn", ply, args[1], 1)
		local reason = args[2] or slib.getLang("sadmin", sAdmin.config["language"], "no_reason_provided")

		for k, target in ipairs(targets) do
			sAdmin.addInfoWarn(target, ply, "[NOTE] " .. reason)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s добавил %s пометку: %s", ply, targets, reason)
	end
})

sAdmin.addCommand({
	name = "noticeid",
	category = "Management",
	inputs = {
		{"text", "sid64/sid"},
		{"text", "reason"}
	},
	func = function(ply, args, silent)
		local sid64 = sAdmin.convertSID64(args[1])
		if not sid64 then return end
		local reason = args[2] or slib.getLang("sadmin", sAdmin.config["language"], "no_reason_provided")
		local target = slib.sid64ToPly[sid64]
		sAdmin.addInfoWarn(IsValid(target) and target or sid64, ply, "[NOTE] " .. reason)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s добавил %s пометку: %s", ply, args[1], reason)
	end
})

sAdmin.addCommand({
	name = "warn",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"text", "reason"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("warn", ply, args[1], 1)
		local reason = args[2] or slib.getLang("sadmin", sAdmin.config["language"], "no_reason_provided")

		for k, target in ipairs(targets) do
			warnPly(target, ply, reason)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "warn_response", ply, targets, reason)
	end
})

sAdmin.addCommand({
	name = "warnid",
	category = "Management",
	inputs = {
		{"text", "sid64/sid"},
		{"text", "reason"}
	},
	func = function(ply, args, silent)
		local sid64 = sAdmin.convertSID64(args[1])
		if not sid64 then return end
		local reason = args[2] or slib.getLang("sadmin", sAdmin.config["language"], "no_reason_provided")
		local target = slib.sid64ToPly[sid64]
		warnPly(IsValid(target) and target or sid64, ply, reason)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "warn_response", ply, args[1], reason)
	end
})

sAdmin.addCommand({
	name = "warn_remove",
	category = "Management",
	inputs = {
		{"text", "id"}
	},
	func = function(ply, args, silent)
		local id = args[1]

		if not id then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		sAdmin.deleteWarn(id, function(result, warn)
			if result then
				sAdmin.msg(silent and ply or sAdmin.logPerm(), "warn_remove_response", ply, id)
			else
				sAdmin.msg(ply, "invalid_id")
			end

			if ply:IsPlayer() and not ply:IsSuperAdmin() then
				Discord.Log("request", {
					content = "<@&1180491439378010145> " .. ply:SteamID64() .. " снял варн " .. id .. " " .. warn.sid64 .. " ",
					username = "Результат",
				})
			end

			sAdmin.queueNetworking(nil, function(p)
				sAdmin.networkData(p, {"offlineWarns", "refresh"}, true)

				sAdmin.networkData(p, {"onlineWarns", "refresh"}, true)
			end)
		end, ply)
	end
})

sAdmin.addCommand({
	name = "warn_setinactive",
	category = "Management",
	inputs = {
		{"text", "id"}
	},
	func = function(ply, args, silent)
		local id = args[1]

		if not id then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		sAdmin.setWarnInactive(id, function(result)
			if result then
				sAdmin.msg(silent and ply or sAdmin.logPerm(), "warn_setinactive_response", ply, id)
			else
				sAdmin.msg(ply, "invalid_id")
			end

			sAdmin.queueNetworking(nil, function(p)
				sAdmin.networkData(p, {"offlineWarns", "refresh"}, true)

				sAdmin.networkData(p, {"onlineWarns", "refresh"}, true)
			end)
		end)
	end
})