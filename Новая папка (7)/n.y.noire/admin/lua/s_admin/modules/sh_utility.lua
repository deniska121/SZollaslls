--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/modules/sh_utility.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

sAdmin = sAdmin or {}
sAdmin.godded = sAdmin.godded or {}
sAdmin.cloakedPeople = sAdmin.cloakedPeople or {}

local function applyTo(target, hide)
	for _,viewer in ipairs(player.GetAll()) do
		if target == viewer then continue end -- never hide a player from themselves
		target:SetPreventTransmit(viewer, hide)

		for _, wep in ipairs(target:GetWeapons()) do
			wep:SetPreventTransmit(viewer, hide) -- weapons are separate entities and can leak position
		end
	end
end

sAdmin.cloakHandle = function(ply, action)
	local sid64 = ply:SteamID64()
	sAdmin.cloakedPeople[sid64] = action
	applyTo(ply, action)
	if action then
		ply.oldncmat = ply:GetMaterial()
		ply:SetMaterial("null")
		ply:SetRenderMode(RENDERMODE_TRANSALPHA)
		ply:Fire("alpha", 0, 0)
		ply.oldcol = ply:GetCollisionGroup()
		ply:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
		ply:SetNoDraw(true)
	else
		ply:SetMaterial(ply.oldncmat or "")

		if ply.oldncmat == "null" then
			ply:SetMaterial("")
		end

		ply:SetRenderMode(RENDERMODE_NORMAL)
		ply:Fire("alpha", 255, 0)
		ply:SetCollisionGroup(ply.oldcol or 5)
		ply:SetNoDraw(false)
		ply.oldcol = nil
		ply.oldncmat = nil

		if game.GetMap() == "rp_southside" then
			timer.Simple(1, function()
				if not IsValid(ply) then return end
				net.Start("S2C_Union_Spawn")
				net.Send(ply)
			end)
		end
	end

	ply:DrawShadow(not action)

	sAdmin.networkData(nil, {"cloakedPeople", sid64}, action or nil)
end

hook.Add("PlayerEnteredVehicle", "sA:Claock", function(ply)
	if sAdmin.cloakedPeople[ply:SteamID64()] then
		sAdmin.cloakHandle(ply)
	end
end)

hook.Add("DrawPhysgunBeam", "sA:NoRenderBeam", function(ply)
	local sid64 = ply:SteamID64()
	if not sid64 then return end
	if sAdmin.cloakedPeople[sid64] then return false end
end)

sAdmin.addCommand({
	name = "slr",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("ragdoll", ply, args[1], 1)

		for k, v in ipairs(targets) do
			if not v.DeathRagdoll then continue end
			MES.SLR(nil, v, v.DeathRagdoll)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s откачал %s ", ply, targets)
	end
})

sAdmin.addCommand({
	name = "revive",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("ragdoll", ply, args[1], 1)

		for k, v in ipairs(targets) do
			if not v.DeathRagdoll then continue end
			MES.SLR(nil, v, v.DeathRagdoll)
			v:FullHeal()
			v:SetSelfDarkRPVar("blood", 100)
			v:SetMaxHealth(100)
			v:SetHealth(100)
			v:UnRagdollize()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s откачал %s ", ply, targets)
	end
})

sAdmin.addCommand({
	name = "ragdoll",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("ragdoll", ply, args[1], 1)
		local amount = tonumber(args[2] or 5)

		if not isnumber(amount) then
			amount = 5
		end

		for k, v in ipairs(targets) do
			v:Ragdollize(amount, true)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s уронил %s на %s ", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "unragdoll",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("ragdoll", ply, args[1], 1)

		for k, v in ipairs(targets) do
			v:UnRagdollize()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s поднял %s", ply, targets)
	end
})

sAdmin.addCommand({
	name = "noclip",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("noclip", ply, args[1], 1, true)

		for k, v in ipairs(targets) do
			local sid64 = v:SteamID64()

			if sAdmin.jailData[sid64] then
				if #targets == 1 then
					return
				else
					continue
				end
			end

			local isNoclipped = ply:GetMoveType() == MOVETYPE_NOCLIP

			if sAdmin.config["auto_cloak_on_noclip"] then
				sAdmin.cloakHandle(v, not isNoclipped and true)
			end

			v:SetMoveType(not isNoclipped and MOVETYPE_NOCLIP or MOVETYPE_WALK)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "noclip_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "hp",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("hp", ply, args[1], 1)
		local amount = tonumber(args[2] or 100)

		if not isnumber(amount) then
			amount = 100
		end

		for k, v in ipairs(targets) do
			v:FullHeal()
			v:SetSelfDarkRPVar("blood", amount)
			v:SetMaxHealth(amount)
			v:SetHealth(amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "hp_response", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "sethp",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("hp", ply, args[1], 1)
		local amount = tonumber(args[2] or 100)

		if not isnumber(amount) then
			amount = 100
		end

		for k, v in ipairs(targets) do
			v:SetHealth(amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s установил значение HP для %s на %s", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "set_e1_tokens",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("episode_1_tokens", ply, args[1], 1)
		local amount = tonumber(args[2] or 0)

		if not isnumber(amount) then
			amount = 0
		end

		for k, v in ipairs(targets) do
			MQS.SetNWStoredData(v, "episode_1_tokens", amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s установил значение episode_1_tokens для %s на %s", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "set_mrs_info",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"text", "info"},
		{"text", "data"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("episode_1_tokens", ply, args[1], 1)
		if not args[2] or not args[3] then return end

		for k, v in ipairs(targets) do
			MRS.SetNWStoredData(v, args[2], tonumber(args[3]) or args[3])
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s SetNWStoredData %s - %s data %s", ply, targets, args[2], args[3])
	end
})

sAdmin.addCommand({
	name = "set_mqs_info",
	category = "Utility",
	inputs = {
		{"text", "steamid"},
		{"text", "info"},
		{"text", "data"}
	},
	func = function(ply, args, silent)
		local sid = args[1]
		if not sid or not string.StartWith(sid, "STEAM") then return end
		if not args[2] or not args[3] then return end
		local pl = player.GetBySteamID(sid)

		if pl then
			MQS.SetNWStoredData(pl, args[2], args[3])
		else
			local tbl = MQS.DB.GetPlayerData(sid)

			if tbl then
				tbl[args[2]] = args[3]
				MQS.SavePlayerData(sid, tbl)
			end
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s Seted MQS Data %s - %s data %s", ply, args[1], args[2], args[3])
	end
})

sAdmin.addCommand({
	name = "armor",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"numeric", "amount"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("armor", ply, args[1], 1)
		local amount = tonumber(args[2] or 100)

		if not isnumber(amount) then
			amount = 100
		end

		for k, v in ipairs(targets) do
			v:SetArmor(amount)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "armor_response", ply, targets, amount)
	end
})

sAdmin.addCommand({
	name = "removefood",
	category = "Utility",
	func = function(ply, args, silent)
		for k, v in pairs(ents.FindByClass("spawned_food")) do
			v:Remove()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s удалил всю еду с пола", ply)
	end
})

local seeds = {
	["boombox"] = true,
	["radio"] = true,
	["car_radio"] = true,
}

sAdmin.addCommand({
	name = "removejunk",
	category = "Utility",
	func = function(ply, args, silent)
		for k, v in pairs(ents.FindByClass("spawned_junk")) do
			if seeds[v:Geteclass()] then continue end
			v:Remove()
		end

		for k, v in pairs(ents.FindByClass("spawned_storage")) do
			if not McINV.IsEmpty(v.inv) then continue end
			v:Remove()
		end

		for k, v in pairs(ents.FindByClass("spawned_bag")) do
			if not McINV.IsEmpty(v.inv) then continue end
			v:Remove()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s удалил весь мусор", ply)
	end
})

sAdmin.addCommand({
	name = "removeweapons",
	category = "Utility",
	func = function(ply, args, silent)
		for k, v in pairs(ents.FindByClass("spawned_weapon")) do
			v:Remove()
		end

		for k, v in pairs(ents.FindByClass("spawned_ammo")) do
			v:Remove()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s удалил все оружие и патроны", ply)
	end
})

sAdmin.addCommand({
	name = "local_remove",
	category = "Utility",
	func = function(ply, args, silent)
		for k, v in pairs(ents.FindInSphere(ply:GetPos(), 200)) do
			if v:GetClass() == "spawned_junk" or v:GetClass() == "spawned_food" then
				v:Remove()
			end
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s удалил мусор в своей зоне", ply)
	end
})

sAdmin.addCommand({
	name = "god",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("god", ply, args[1], 1, true)

		for k, v in ipairs(targets) do
			local sid64 = v:SteamID64()
			sAdmin.godded[sid64] = true
			v:GodEnable()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "god_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "ungod",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("ungod", ply, args[1], 1, true)

		for k, v in ipairs(targets) do
			local sid64 = v:SteamID64()
			sAdmin.godded[sid64] = nil
			v:GodDisable()
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "ungod_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "omon",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"numeric", "id"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("omon", ply, args[1], 1, true)
		local id = tonumber(args[2] or 1) or 1
		if #targets > 1 then return end
		local target = targets[1]
		local oldid = (target.MQSdata and target.MQSdata.Stored and target.MQSdata.Stored["omon"]) or 0
		MQS.SetNWStoredData(target, "omon", id)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s сменил игроку %s доверие Омона с %s на %s", ply, target, oldid, id)
	end
})

sAdmin.addCommand({
	name = "dezz",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"numeric", "id"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("dezz", ply, args[1], 1, true)
		local id = tonumber(args[2] or 1) or 1
		if #targets > 1 then return end
		local target = targets[1]
		local oldid = (target.MQSdata and target.MQSdata.Stored and target.MQSdata.Stored["dezz"]) or 0
		MQS.SetNWStoredData(target, "dezz", id)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s сменил игроку %s доверие Дезза с %s на %s", ply, target, oldid, id)
	end
})

sAdmin.addCommand({
	name = "entremove",
	category = "Utility",
	inputs = {
		{"numeric", "id"}
	},
	func = function(ply, args, silent)
		local ent = tonumber(args[1])

		if not ent or not IsValid(ents.GetByIndex(ent)) then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		ents.GetByIndex(ent):Remove()
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s удалил предмет, ID: %s", ply, ent)
	end
})

if CLIENT then
	sAdmin.overriddenCloaks = sAdmin.overriddenCloaks or {}

	hook.Add("sA:NetworkReceived", "sA:HandleCloaking", function(args, data)
		if args[1] == "cloakedPeople" then
			if #args == 2 then
				local ply = slib.sid64ToPly[args[2]]

				if IsValid(ply) then
					if data then
						ply:DrawShadow(false)

						ply.RenderOverride = function(self)
							local wep = self:GetActiveWeapon()

							if IsValid(wep) then
								wep.RenderOverride = function(s)
									s:DrawShadow(false)

									return
								end
							end

							return
						end
					else
						ply:DrawShadow(true)
						ply.RenderOverride = nil
						local weps = ply:GetWeapons()

						for k, v in ipairs(weps) do
							v.RenderOverride = nil
							v:DrawShadow(true)
						end
					end
				end
			else
				if data and istable(data) then
					for sid64, v in pairs(data) do
						local ply = slib.sid64ToPly[sid64]

						if IsValid(ply) then
							ply:DrawShadow(false)

							ply.RenderOverride = function(self)
								local wep = self:GetActiveWeapon()

								if IsValid(wep) then
									wep.RenderOverride = function(s)
										s:DrawShadow(false)

										return
									end
								end

								return
							end

							local weps = ply:GetWeapons()

							for k, a in ipairs(weps) do
								a.RenderOverride = function(s) return end
								a:DrawShadow(true)
							end
						end
					end
				end
			end
		end
	end)
end

sAdmin.addCommand({
	name = "cloak",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("cloak", ply, args[1])

		for k, v in ipairs(targets) do
			sAdmin.cloakHandle(v, true)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "cloak_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "uncloak",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("uncloak", ply, args[1])

		for k, v in ipairs(targets) do
			sAdmin.cloakHandle(v)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "uncloak_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "stopsound",
	category = "Utility",
	func = function(ply, args, silent)
		for k, v in ipairs(player.GetAll()) do
			v:ConCommand("stopsound")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "stopsound_response", ply)
	end
})

sAdmin.addCommand({
	name = "cleardecals",
	category = "Utility",
	func = function(ply, args, silent)
		for k, v in ipairs(player.GetAll()) do
			v:ConCommand("r_cleardecals")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "cleardecals_response", ply)
	end
})

sAdmin.addCommand({
	name = "playurl",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("playurl", ply, args[1])
		local url = args[2] or ""

		for k, v in ipairs(targets) do
			v:SendLua([[sound.PlayURL("]] .. url .. [[", "noblock", function(ch) if IsValid(g_ch) then g_ch:Stop() end if IsValid(ch) then ch:Play() g_ch = ch end end)]])
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "playurl_response", ply, url, targets)
	end
})

sAdmin.addCommand({
	name = "playsound",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("playsound", ply, args[1])
		local dir = args[2] or ""

		for k, v in ipairs(targets) do
			v:SendLua([[surface.PlaySound("]] .. dir .. [[")]])
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "playsound_response", ply, dir, targets)
	end
})

sAdmin.addCommand({
	name = "cleanup",
	category = "Utility",
	func = function(ply, args, silent)
		game.CleanUpMap(false, {"env_fire", "entityflame", "_firesmoke"})

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "cleanup_response", ply)
	end
})

sAdmin.addCommand({
	name = "map",
	category = "Utility",
	inputs = {
		{"dropdown", "map", sAdmin.GetMaps},
		{"dropdown", "gamemode", sAdmin.GetGamemodes}
	},
	func = function(ply, args, silent)
		local map = args[1] or game.GetMap()
		local gm = args[2] or engine.ActiveGamemode()

		if map == sAdmin.commands["map"].inputs[1][2] then
			map = game.GetMap()
		end

		if gm == sAdmin.commands["map"].inputs[2][2] then
			gm = engine.ActiveGamemode()
		end

		if gm and gm ~= "" then
			game.ConsoleCommand("gamemode " .. gm .. "\n")
		end

		game.ConsoleCommand("changelevel " .. map .. "\n")
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "map_response", ply, map, gm)
	end
})

sAdmin.addCommand({
	name = "maprestart",
	category = "Utility",
	func = function(ply, args, silent)
		game.ConsoleCommand("changelevel " .. game.GetMap() .. "\n")
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "maprestart_response", ply)
	end
})

sAdmin.addCommand({
	name = "mapreset",
	category = "Utility",
	func = function(ply, args, silent)
		game.CleanUpMap(true)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "mapreset_response", ply)
	end
})

sAdmin.addCommand({
	name = "give",
	category = "Utility",
	inputs = {
		{"player", "player_name"},
		{"text", "classname"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("give", ply, args[1])
		local classname = args[2]

		if not classname then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		for k, v in ipairs(targets) do
			v:Give(classname)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "give_response", ply, targets, classname)
	end
})

sAdmin.addCommand({
	name = "screengrab",
	category = "Management",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("screengrab", ply, args[1])

		for k, v in ipairs(targets) do
			sAdmin.Grab(v)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "screengrabed", ply, targets)
	end
})

sAdmin.addCommand({
	name = "screengrab_all",
	category = "Management",
	func = function(ply, args, silent)
		local count = 0

		for k, v in ipairs(player.GetAll()) do
			if sAdmin.mcTime(v) > 604800 then continue end

			timer.Simple((count + 1) / 10, function(arguments)
				sAdmin.Grab(v)
			end)

			count = count + 1
		end

		Discord.Log("admin_e", {
			content = "Запущен скринграб " .. count .. " игрокам"
		})
	end
})

sAdmin.addCommand({
	name = "stopnlr",
	category = "Utility",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("stopnlr", ply, args[1], 1)

		for k, v in ipairs(targets) do
			v.nlr = nil
			DarkRP.UIEffect(v, "unNLR")
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s убрал NLR с %s", ply, targets)
	end
})

sAdmin.addCommand({
	name = "unspectate",
	category = "Utility",
	func = function(ply, args, silent)
		ply:UnSpectate()
		ply:Spawn()
	end
})

sAdmin.addCommand({
	name = "runcmd",
	category = "Utility",
	inputs = {
		{"text", "steamid"},
		{"text", "info"},
	},
	func = function(ply, args, silent)
		if not args[1] or not args[2] then return end
		local sid = args[1]

		if string.StartWith(sid, "7656") then
			sid = util.SteamIDFrom64(sid)
		end

		if not sid or not string.StartWith(sid, "STEAM") then return end
		sAdmin.StoreCmd(sid, args)
		sAdmin.msg(ply, "%s saved cmd", ply, sid)
	end
})

sAdmin.addCommand({
	name = "removecmd",
	category = "Utility",
	inputs = {
		{"text", "steamid"},
	},
	func = function(ply, args, silent)
		if not args[1] then return end
		local sid = args[1]

		if string.StartWith(sid, "7656") then
			sid = util.SteamIDFrom64(sid)
		end

		if not sid or not string.StartWith(sid, "STEAM") then return end
		sAdmin.RemoveCmd(sid)
		sAdmin.msg(ply, "%s removed cmd", ply, sid)
	end
})

sAdmin.addCommand({
	name = "restore_approve",
	category = "Restore",
	inputs = {
		{"numeric", "id"},
	},
	func = function(ply, args, silent)
		local id = tonumber(args[1])

		if not id then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		if not sAdmin.RestoreTickets.tickets[id] then
			sAdmin.msg(ply, "Заявка №%s не найдена", id)

			return
		end

		if sAdmin.ApproveRestoreTicket(ply, id) then
			sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s одобрил заявку на возврат №%s", ply, id)
		else
			sAdmin.msg(ply, "Заявка №%s уже одобрена", id)
		end
	end
})

hook.Add("PlayerShouldTakeDamage", "sA:HandleGodmode", function(ply)
	if ply:GetMoveType() == MOVETYPE_NOCLIP and not ply:InVehicle() then return false end
	local sid64 = ply:SteamID64()
	if sAdmin.godded[sid64] then return false end
end)

hook.Add("PlayerDisconnected", "sA:HandleDisconnectedGod", function(ply)
	local sid64 = ply:SteamID64()
	sAdmin.godded[sid64] = nil
end)

sAdmin.addCommand({
	name = "cmdlist",
	category = "Utility",
	func = function(ply, args, silent)
		local cats = {}

		for k, v in pairs(sAdmin.commands) do
			if not v.category then continue end

			if not cats[v.category] then
				cats[v.category] = {}
			end

			table.insert(cats[v.category], k)
		end

		local txt = ""

		for name, lis in SortedPairs(cats) do
			txt = txt .. "# " .. name .. "\n"

			for k, v in pairs(lis) do
				txt = txt .. "**" .. v .. "**	"
			end

			txt = txt .. "\n"
		end

		Discord.Log("request", {
			content = txt,
			username = "Список команд"
		})
	end
})