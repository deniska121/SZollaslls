--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/modules/sh_chat.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin = sAdmin or {}
sAdmin.muted = sAdmin.muted or {}
sAdmin.gagged = sAdmin.gagged or {}

local function commsUnmute(ply, type)
	local sid64 = isnumber(ply) and ply or (IsValid(ply) and ply:SteamID64())
	sAdmin[type][sid64] = nil
	timer.Remove("sAdmin_" .. type .. "_" .. sid64)

	sAdmin.networkData(nil, {type, sid64}, nil)

	ply:RemovePData("sA:" .. type)
end

local function commsMute(ply, type, time, ignore)
	local sid64 = ply:SteamID64()
	sAdmin[type][sid64] = time or true
	if not isnumber(time) then return end

	if time > 0 then
		timer.Create("sAdmin_" .. type .. "_" .. sid64, time, 1, function()
			sAdmin[type][sid64] = nil

			sAdmin.networkData(nil, {type, sid64}, nil)

			if IsValid(ply) then
				ply:RemovePData("sA:" .. type)
			else
				util.RemovePData(util.SteamIDFrom64(sid64), "sA:" .. type)
			end
		end)
	else
		timer.Remove("sAdmin_" .. type .. "_" .. sid64)

		if time < 0 then
			commsUnmute(ply, type)
			return
		end
	end

	sAdmin.networkData(nil, {type, sid64}, true)

	if ignore then return end
	print("pdata", ply)
	ply:SetPData("sA:" .. type, time + os.time())
end

sAdmin.addCommand({
	name = "pm",
	category = "Chat",
	inputs = {
		{"player", "player_name"},
		{"text", "msg"}
	},
	func = function(ply, args)
		local targets = sAdmin.getTargets("pm", ply, args[1], 1, true)
		local msg = ""

		for i = 2, #args do
			msg = msg .. " " .. args[i]
		end

		if not msg or msg:Trim() == "" then return end

		for k, v in ipairs(targets) do
			sAdmin.msg(ply, "pm_response", v, msg)
			sAdmin.msg(v, "pm_response_receive", "Администрация", msg)
		end
	end
})

sAdmin.addCommand({
	name = "dm",
	category = "Chat",
	inputs = {
		{"numeric", "id"},
		{"text", "msg"}
	},
	func = function(ply, args)
		local id = tonumber(args[1] or 1)
		local req = sAdmin.requests[id]
		if not req or req.accepted then return end

		local reqpl = player.GetBySteamID64(req.sid64)

		if ply ~= reqpl and not sAdmin.hasPermission(ply, "is_staff") then return end

		if ply == reqpl and not req.chat then return end

		if not req.chat then
			req.chat = {}
			req.chatlog = {}
			if IsValid(reqpl) then
				sAdmin.msg(reqpl, "Администратор начал чат по вашей заявке №%s. Ответить можно комадной %s в чат", id, "/dm " .. id)
			end
			req.mainadmin = ply:SteamID64()
			for k, v in ipairs(player.GetAll()) do
				if not sAdmin.hasPermission(v, "is_staff") then continue end
				sAdmin.msg(v, "%s начал диалог по жалобе №%s", ply, id)
			end
			sAdmin.SendTickets()
		end

		if ply ~= reqpl and sAdmin.hasPermission(ply, "is_staff") and not req.chat[ply:SteamID64()] then
			req.chat[ply:SteamID64()] = true
		end

		local msg = ""

		for i = 2, #args do
			msg = msg .. " " .. args[i]
		end

		if not msg or msg:Trim() == "" then return end

		local targets = {
			reqpl
		}

		for k, _ in pairs(req.chat) do
			table.insert(targets, player.GetBySteamID64(k))
		end

		if req.chatlog then
			table.insert(req.chatlog, ply:SteamName() .. ": " .. msg )
		end

		for _, v in pairs(targets) do
			if not IsValid(v) then continue end
			local name = ply:SteamName()
			if not sAdmin.hasPermission(v, "is_staff") and v ~= ply then
				name = "Администратор"
			else
				sAdmin.SendTickets(v)
			end
			sAdmin.msg(v, "%s" .. msg, "[" .. id .. "] " .. name .. ":")
		end
	end
})

sAdmin.addCommand({
	name = "asay",
	category = "Chat",
	abbreviation = {"@"},
	inputs = {
		{"text", "msg"}
	},
	func = function(ply, args)
		local msg = ""

		for i = 1, #args do
			msg = msg .. " " .. args[i]
		end

		if not msg or msg:Trim() == "" then return end

		for k, v in ipairs(player.GetAll()) do
			if not sAdmin.hasPermission(v, "is_staff") or ply == v then continue end
			sAdmin.msg(v, "asay_response_receive", ply, msg)
		end

		sAdmin.msg(ply, "asay_response", ply, msg)
	end
})

sAdmin.addCommand({
	name = "mute",
	category = "Chat",
	inputs = {
		{"player", "player_name"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("mute", ply, args[1])
		local time = sAdmin.getTime(args, 2)

		for k, v in ipairs(targets) do
			commsMute(v, "muted", time)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "mute_response", ply, targets, time)
	end
})

sAdmin.addCommand({
	name = "unmute",
	category = "Chat",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unmute", ply, args[1])

		for k, v in ipairs(targets) do
			commsUnmute(v, "muted")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unmute_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "unmuteid",
	category = "Chat",
	inputs = {
		{"text", "player_id"},
	},
	func = function(ply, args, silent)
		if not args[1] then return end
		local target = args[1]

		if not string.StartsWith(target, "STEAM_") then
			target = util.SteamIDFrom64( target )
		end

		if not string.StartsWith(target, "STEAM_") then return end

		local online = player.GetBySteamID(target)

		if IsValid(online) then
			target = online
			commsUnmute(target, "muted")
		else
			sAdmin["muted"][target] = nil
			sAdmin.networkData(nil, {"muted", target}, nil)
			util.RemovePData(target, "sA:muted")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unmute_response", ply, target)
	end
})

sAdmin.addCommand({
	name = "gag",
	category = "Chat",
	inputs = {
		{"player", "player_name"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("gag", ply, args[1])
		local time = sAdmin.getTime(args, 2)

		for k, v in ipairs(targets) do
			commsMute(v, "gagged", time)
			v:ConCommand("-voicerecord")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "gag_response", ply, targets, time)
	end
})

sAdmin.addCommand({
	name = "ungag",
	category = "Chat",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("ungag", ply, args[1])

		for k, v in ipairs(targets) do
			commsUnmute(v, "gagged")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "ungag_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "advert",
	category = "Chat",
	inputs = {
		{"numeric", "type"},
		{"text", "msg"}
	},
	func = function(ply, args)
		local msg = ""
		local type = tonumber(args[1]) or 1

		if type > 4 then type = 4 end

		for i = 2, #args do
			msg = msg .. " " .. args[i]
		end

		if not msg or msg:Trim() == "" then return end

		MQS.Notify(player.GetAll(), "Внимание!", msg, type)
	end
})

hook.Add("PlayerCanHearPlayersVoice", "sA:HandleGag", function(listener, talker)
	local sid64 = talker:SteamID64()
	if sAdmin.gagged[sid64] then return false end
end)

hook.Add("PlayerInitialSpawn", "sA:RegisterCommsState", function(ply)
	local muted = ply:GetPData("sA:muted")
	local gagged = ply:GetPData("sA:gagged")

	if muted then
		commsMute(ply, "muted", muted - os.time(), true)
	end

	if gagged then
		commsMute(ply, "gagged", gagged - os.time(), true)
	end
end)

hook.Add("PlayerDisconnected", "sA:RemoveTimersComms", function(ply)
	local sid64 = ply:SteamID64()
	timer.Remove("sAdmin_muted_" .. sid64)
	timer.Remove("sAdmin_gagged_" .. sid64)
end)