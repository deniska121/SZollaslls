--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/core/sh_commands.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin = sAdmin or {}
sAdmin.commands = sAdmin.commands or {}
sAdmin.permissions = sAdmin.permissions or {}
sAdmin.abbreviations = sAdmin.abbreviations or {}
local index = 0

sAdmin.addCommand = function(data)
	if sAdmin.config["disabled_modules"][data.category] then return end
	index = index + 1

	sAdmin.commands[data.name] = {
		category = data.category,
		func = data.func,
		inputs = data.inputs,
		index = index
	}

	if data.abbreviation then
		for k, v in ipairs(data.abbreviation) do
			sAdmin.abbreviations[v] = data.name
		end
	end

	sAdmin.registerPermission(data.name, data.category)
end

sAdmin.runCommand = function(ply, name, args, silent)
	if not name then return end
	name = string.lower(name)
	local data = sAdmin.commands[name]
	if not data then return end
	if hook.Run("sA:RunCommand", ply, name, args) == false then return end

	if IsValid(ply) and not sAdmin.hasPermission(ply, name) then
		sAdmin.msg(ply, "no_permission", name)
		print(ply, name)
		return
	end

	data.func(ply, args, silent == true)
	local argsStr = ""
	local argCount = #args

	for k, v in ipairs(args) do
		argsStr = argsStr .. v .. (k >= argCount and "" or ", ")
	end

	if argsStr == "" then
		argsStr = slib.getLang("sadmin", sAdmin.config["language"], "n/a")
	end

	hook.Run("sA:RanCommand", ply, name, args, argsStr)

	if sAdmin.config["console_prints"]["attempt_call"] then
		local user = IsValid(ply) and ply:SteamName() or slib.getLang("sadmin", sAdmin.config["language"], "console")
		local sid = IsValid(ply) and ply:SteamID64() or slib.getLang("sadmin", sAdmin.config["language"], "console")
		local txt = " " .. slib.getLang("sadmin", sAdmin.config["language"], "ran_command") .. " "
		local wargs = " " .. slib.getLang("sadmin", sAdmin.config["language"], "with_args") .. " ["
		MsgC(sAdmin.config["chat_prefix"][1], sAdmin.config["chat_prefix"][2], sAdmin.config["colors"]["green_ply"], user, color_white, txt, sAdmin.config["colors"]["orange_ply"], name, color_white, wargs, sAdmin.config["colors"]["orange_ply"], argsStr, color_white, "]\n")

		if Discord then
			Discord.Log(sid == "КОНСОЛЬ" and "request" or "admin", {content = user .. txt .. name .. wargs .. argsStr .. "]", username = "[MCM] " .. sid})
		end
	end
end

local function autoComplete(ply, cmd)
	local alternatives = {}
	local base = "sa "
	cmd = string.gsub(cmd, " ", "", 1)
	local args = string.Split(cmd, " ")
	local command = args[1]

	if sAdmin.commands[command] then
		if args[2] then
			if sAdmin.commands[command].inputs[1] and sAdmin.commands[command].inputs[1][1] == "player" then
				for k, v in ipairs(player.GetAll()) do
					local nick = v:SteamName()
					if not string.find(string.lower(nick), string.lower(args[2])) then continue end
					table.insert(alternatives, base .. command .. ' "' .. nick .. '"')
				end
			end
		else
			table.insert(alternatives, base .. command)
		end
	else
		for name, v in pairs(sAdmin.commands) do
			if command and not string.find(string.lower(name), string.lower(command)) then continue end
			table.insert(alternatives, base .. name)
		end
	end

	local cmd_data = sAdmin.commands[string.lower(command)]

	if cmd_data and not args[2] then
		local params = ""

		if cmd_data.inputs then
			for k, type in ipairs(cmd_data.inputs) do
				params = params .. " [" .. slib.getLang("sadmin", sAdmin.config["language"], type[2] or type[1]) .. "]"
			end
		end
	end

	return alternatives
end

if SERVER then
	local cmd_func = function(ply, cmd, args, silent)
		local name = args[1]
		table.remove(args, 1)
		local param_limited = false
		local cmd_data = sAdmin.commands[name]
		local rank = IsValid(ply) and ply:GetUserGroup()

		if rank and sAdmin.ParameterLimitations[name] and sAdmin.ParameterLimitations[name][rank] and istable(sAdmin.ParameterLimitations[name][rank]) then
			for k, v in ipairs(cmd_data.inputs) do
				local limit = sAdmin.ParameterLimitations[name][rank][k] or sAdmin.ParameterLimitations[name][rank][tostring(k)]
				if not istable(limit) or not isnumber(limit.min) or not isnumber(limit.max) then continue end
				local limit_type = cmd_data.inputs and cmd_data.inputs[k]
				if not limit_type then continue end
				if limit_type[1] == "player" then continue end
				local val = (tonumber(args[k]) or 0)

				if limit_type[1] == "time" then
					val = sAdmin.getTime(args, k)

					if (val == 0 or not val) then
						param_limited = true
						break
					end
				end

				if (limit.min > 0 and val < limit.min) or (limit.max > 0 and val > limit.max) then
					param_limited = true
					break
				end
			end
		end

		if param_limited then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		sAdmin.runCommand(ply, name, args, silent)
	end

	concommand.Add("sa_cmd", function(ply, cmd, args, arg_str)
		cmd_func(ply, cmd, args)
	end)

	concommand.Add("sa_cmd_silent", function(ply, cmd, args, arg_str)
		if not sAdmin.hasPermission(ply, "silent") then
			sAdmin.msg(ply, "no_permission", slib.getLang("sadmin", sAdmin.config["language"], "silent"))

			return
		end

		cmd_func(ply, cmd, args, true)
	end)

	concommand.Add("sa", function(ply, cmd, args, arg_str)
		cmd_func(ply, cmd, args)
	end)

	concommand.Add("ulx", function(ply, cmd, args, arg_str)
		if not sAdmin.hasPermission(ply, "silent") then
			cmd_func(ply, cmd, args)
			return
		end

		cmd_func(ply, cmd, args, true)
	end)

	concommand.Add("sa_silent", function(ply, cmd, args, arg_str)
		if not sAdmin.hasPermission(ply, "silent") then
			sAdmin.msg(ply, "no_permission", slib.getLang("sadmin", sAdmin.config["language"], "silent"))

			return
		end

		cmd_func(ply, cmd, args, true)
	end)
else
	concommand.Add("sa", function(ply, _, _, arg_str)
		ply:ConCommand("sa_cmd " .. arg_str)
	end, autoComplete)

	concommand.Add("ulx", function(ply, _, _, arg_str)
		ply:ConCommand("sa_cmd_silent " .. arg_str)
	end, autoComplete)

	concommand.Add("sa_silent", function(ply, _, _, arg_str)
		ply:ConCommand("sa_cmd_silent " .. arg_str)
	end, autoComplete)
end