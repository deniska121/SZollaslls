--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/modules/sh_darkrp.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


sAdmin.addCommand({
	name = "arrest",
	category = "Police",
	inputs = {
		{"player", "player_name"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("arrest", ply, args[1])
		local time = sAdmin.getTime(args, 2)

		for k, v in ipairs(targets) do
			v:arrest(time)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "arrest_response", ply, targets, time)
	end
})

sAdmin.addCommand({
	name = "unarrest",
	category = "Police",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unarrest", ply, args[1])

		for k, v in ipairs(targets) do
			v:unArrest()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unarrest_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "setmoney",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("setmoney", ply, args[1], 1)
		local amount = tonumber(args[2]) or 0

		for k, v in ipairs(targets) do
			local oldMoney = v:getDarkRPVar("money")
			v:addMoney(-oldMoney + amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "setmoney_response", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "addmoney",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	category = "DarkRP",
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("addmoney", ply, args[1])
		local amount = tonumber(args[2]) or 0

		for k, v in ipairs(targets) do
			v:addMoney(amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "addmoney_response", ply, amount, targets)
	end
})

sAdmin.addCommand({
	name = "setjob",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"text", "job"}
	},
	func = function(ply, args, silent)
		local targets, job = sAdmin.getTargets("setjob", ply, args[1], 1), tonumber(string.lower(args[2]))

		for k, target in ipairs(targets) do
			target:ChangeTeam(job, true)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "setjob_response", ply, targets, team.GetName(job or 1))
	end
})

sAdmin.addCommand({
	name = "resetjob",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("setjob", ply, args[1])

		for k, target in ipairs(targets) do
			if target:Team() < 4 then continue end
			target:ChangeTeam(MCR.DefTeams[target:getDarkRPVar("character") or 1], true)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s сбросил работу игроку %s", ply, targets)
	end
})

sAdmin.addCommand({
	name = "setcredits",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("setcredits", ply, args[1], 1)
		local amount = tonumber(args[2]) or 0

		for k, v in ipairs(targets) do
			v:SetCredits(amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "setcred_response", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "addcredits",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	category = "DarkRP",
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("addcredits", ply, args[1])
		local amount = tonumber(args[2]) or 0

		for k, v in ipairs(targets) do
			v:AddCredits(amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "addcred_response", ply, amount, targets)
	end
})

sAdmin.addCommand({
	name = "banjob",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"text", "job"},
		{"time"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("banjob", ply, args[1])
		local job = tonumber(string.lower(args[2]))
		local time = sAdmin.getTime(args, 3)
		if not job or not isnumber(job) then return end

		for _, v in ipairs(targets) do
			if not IsValid(v) then continue end
			v:TeamBan(job, time, true)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "banned_job", ply, targets, job, time)
	end
})

sAdmin.addCommand({
	name = "unbanjob",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"text", "job"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unbanjob", ply, args[1])
		local job = tonumber(string.lower(args[2]))
		if not job or not isnumber(job) then return end

		for _, v in ipairs(targets) do
			if not IsValid(v) then continue end
			v:TeamUnBan(job)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unbanned_job", ply, targets, job)
	end
})

sAdmin.addCommand({
	name = "setkarma",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("setkarma", ply, args[1], 1)
		local amount = tonumber(args[2]) or 0

		for k, v in ipairs(targets) do
			v:SetKarma(amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s установил %s рассудок на %s.", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "banjobid",
	category = "DarkRP",
	inputs = {
		{"text", "player_id"},
		{"text", "job"},
		{"time"}
	},
	func = function(ply, args, silent)
		local job = tonumber(string.lower(args[2]))
		local time = sAdmin.getTime(args, 3)
		if not job or not isnumber(job) then return end
		DarkRP.TeamBanId(args[1], job, time)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "banned_job", ply, args[1], job, time)
	end
})

sAdmin.addCommand({
	name = "unbanjobid",
	category = "DarkRP",
	inputs = {
		{"text", "player_id"},
		{"text", "job"}
	},
	func = function(ply, args, silent)
		local job = tonumber(string.lower(args[2]))
		if not job or not isnumber(job) then return end
		DarkRP.TeamBanId(args[1], job)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unbanned_job", ply, args[1], job)
	end
})

sAdmin.addCommand({
	name = "randomname",
	category = "Management",
	inputs = {
		{"player", "player_name"},
	},
	func = function(pl, args, silent)
		if not args[1] then return end
		local targets = sAdmin.getTargets("randomname", pl, args[1], 1)

		local ply = targets[1]

		if not IsValid(ply) then return end

		local id = ply:getDarkRPVar("character") or 1
		if id > 3 or id < 0 then return end
		if not ply.characters or not ply.characters[id] then return end
		local data = ply.characters[id]
		data.fname, data.sname = MCR.GenerateName(data.gender, data.model, data.face)

		if not MCR.CheckName(data.fname) or not MCR.CheckName(data.sname) then return end
		DB.CreateCharData(ply, id, data.fname, data.sname, data.gender, data.model, data.face, data.eye, util.TableToJSON(data.suit))
		ply.characters[id] = data
		ply.characters[id].data = data.data
		DB.CreateExtraDataSave(ply, id)
		MCR.FetchData(ply)
		ply:SetDarkRPVar("dsname", data.fname)
		ply:SetDarkRPVar("rpname", data.fname .. " " .. data.sname)

		if not silent then
			sAdmin.msg(ply, "Вам сменили имя на %s %s, так как старое имя нарушало правило по созданию персонажей.", data.fname, data.sname)
		end

		sAdmin.msg(silent and pl or sAdmin.logPerm(), "%s сменил имя %s на случайное %s", pl, ply, data.fname .. " " .. data.sname)
	end
})

sAdmin.addCommand({
	name = "changename",
	category = "Management",
	inputs = {
		{"player", "player_name"},
		{"text", "имя"},
		{"text", "фамилия"}
	},
	func = function(pl, args, silent)
		if not args[1] or not args[2] or not args[3] then return end
		local targets = sAdmin.getTargets("changename", pl, args[1], 1)

		local ply = targets[1]

		if not IsValid(ply) then return end

		local id = ply:getDarkRPVar("character") or 1
		if id > 3 or id < 0 then return end
		if not ply.characters or not ply.characters[id] then return end
		local data = ply.characters[id]
		data.fname = args[2]
		data.sname = args[3]

		if not MCR.CheckName(data.fname) or not MCR.CheckName(data.sname) then return end
		DB.CreateCharData(ply, id, data.fname, data.sname, data.gender, data.model, data.face, data.eye, util.TableToJSON(data.suit))
		ply.characters[id] = data
		ply.characters[id].data = data.data
		DB.CreateExtraDataSave(ply, id)
		MCR.FetchData(ply)
		ply:SetDarkRPVar("dsname", data.fname)
		ply:SetDarkRPVar("rpname", data.fname .. " " .. data.sname)

		sAdmin.msg(silent and pl or sAdmin.logPerm(), "%s сменил имя %s на %s", pl, ply, data.fname .. " " .. data.sname)
	end
})

sAdmin.addCommand({
	name = "sellproperty",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("setkarma", ply, args[1], 1)
		local target = targets[1]

		for k, v in pairs(Territories.list) do
			if target:IsTerritoryMasterOwner(v) then
				v:keysUnOwn()
			end
		end

		McPhone.NewMail("SkyLine Риелтор", "Уважаемый арендатор! С сожалением сообщаем, что мы вынуждены изъять вашу собственность.\n\nПодробности на www.skyline.net", target)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s продал всю недвижимость %s", ply, target)
	end
})

sAdmin.addCommand({
	name = "unwanted",
	category = "Police",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unwanted", ply, args[1])
		for k, v in ipairs(targets) do
			v:unWanted("force command")
		end
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s убрал розыск с %s", ply, targets)
	end
})

sAdmin.addCommand({
	name = "skillslots",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unwanted", ply, args[1])
		local slots = math.Clamp(tonumber(args[2]) or 0, 0, 30)
		for k, v in ipairs(targets) do
			MCR.SetSkillPoints(v, slots, 30)
		end
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s выставил слоты %s кл: %s", ply, targets, slots)
	end
})

sAdmin.addCommand({
	name = "settattoos",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"text", "str"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unwanted", ply, args[1])
		if not args[2] or not tostring(args[2]) then return end

		local tatoos = string.Replace(args[2], "|", ";")
		for k, v in ipairs(targets) do
			MCR.RestoreTatoo(v, {tatoos, math.Clamp(tonumber(args[3]) or 10, 1, 30)})
		end
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s выставил тату %s кл: %s", ply, targets, tatoos)
	end
})

sAdmin.addCommand({
	name = "removetattoo",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unwanted", ply, args[1])
		for k, v in ipairs(targets) do
			MCR.RemoveTatoo(v)
		end
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s убрал все тату с %s", ply, targets)
	end
})

sAdmin.addCommand({
	name = "additem",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"text", "type"},
		{"text", "class"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("additem", ply, args[1], 1)
		local amount = tonumber(args[4]) or 1

		for k, v in ipairs(targets) do
			if not McINV.ttypes[args[2]] then return end

			local ctype = McINV.ttypes[args[2]]

			if not DarkRP[ctype] then return end

			local ent_data = DarkRP[ctype][args[3]]
			if not ent_data then return end

			for i = 1, amount do
				McINV.AddCustomItem(v, args[2], args[3], table.Copy(ent_data), true)
			end
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s выдал %s %s предмет(ов) [%s] %s", ply, targets, amount, args[2], args[3])
	end
})

sAdmin.addCommand({
	name = "setmedals",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"text", "table"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unwanted", ply, args[1])
		for k, v in ipairs(targets) do
			MCR.SetMedals(v, args[2])
		end
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s выставил медали %s на %s", ply, targets, args[2])
	end
})

sAdmin.addCommand({
	name = "addcraftpoints",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"},
		{"text", "xptable"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("unwanted", ply, args[1])
		local slots = tonumber(args[2]) or 0
		for k, v in ipairs(targets) do
			v:JobXPAdd(args[3], slots)
		end
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s добавил %s очков %s на %s", ply, slots, targets, args[3])
	end
})

sAdmin.addCommand({
	name = "char_token",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("char_token", ply, args[1], 1)
		local amount = tonumber(args[2]) or 0

		for k, v in ipairs(targets) do
			MQS.SetNWStoredData(v, "mcr_change", amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s установил токены смены персонажа %s на %s", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "char_save",
	category = "DarkRP",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("char_save", ply, args[1], 1)
		local amount = tonumber(args[2]) or 0

		for k, v in ipairs(targets) do
			MQS.SetNWStoredData(v, "mcr_save", amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s установил токены сохранения персонажа %s на %s", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "getjobbans",
	category = "DarkRP",
	inputs = {
		{"text", "player_id"},
	},
	func = function(ply, args, silent)
		if not args[1] then return end

		MySQLite.query("SELECT * FROM darkrp_jobban WHERE uid = " .. sql.SQLStr(args[1], true) .. ";", function(data)
			local info = data and data[1] or "[]"
			if not info.data then return end
			info = util.JSONToTable(info.data)
			local bannedfrom = info or {}
			local ds = ""

			if table.IsEmpty(bannedfrom) then
				ds = "Нет активных банов"
			end

			for t, time in pairs(bannedfrom) do

				if time == 0 then
					ds = ds .. "\n[" .. t .. "] **" .. team.GetName(t) .. "** - Вечность"
					continue
				end
				time = time - os.time()

				if time <= 0 then
					ds = ds .. "\n[" .. t .. "] **" .. team.GetName(t) .. "** - время бана истекло"
					continue
				end

				ds = ds .. "\n[" .. t .. "] **" .. team.GetName(t) .. "** - " .. sAdmin.formatTime(time)

			end

			Discord.Log("request", {username = "Результат", embeds = {{
				title = args[1],
				description = ds,
				color = 0xFF9300
			}}})
			sAdmin.msg(silent and ply or sAdmin.logPerm(), ds)
		end, function()
			sAdmin.msg(silent and ply or sAdmin.logPerm(), "Failed to print bans for jobs")
		end)
	end
})

sAdmin.addCommand({
	name = "cuffs",
	category = "Police",
	inputs = {
		{"player", "player_name"},
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("arrest", ply, args[1])

		for k, v in ipairs(targets) do
			v:CuffHands()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s применил наручники на %s", ply, targets)
	end
})

list.Set( "OverlayMaterials", "16x9_Vertical_helper_clean",	{ Material = "16x9_Vertical_helper_clean", Icon = "16x9_Vertical_helper_clean" } )
list.Set( "OverlayMaterials", "16x9_Vertical_helper",	{ Material = "16x9_Vertical_helper", Icon = "16x9_Vertical_helper" } )
list.Set( "OverlayMaterials", "Rule_of_third",	{ Material = "Rule_of_third", Icon = "Rule_of_third" } )
list.Set( "OverlayMaterials", "Rule_of_third_with_dots",	{ Material = "Rule_of_third_with_dots", Icon = "Rule_of_third_with_dots" } )
list.Set( "OverlayMaterials", "quadrant",	{ Material = "quadrant", Icon = "quadrant" } )