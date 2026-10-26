--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_quests/lua/mqs/core/sh_util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╦═══╗───────────────────────
-- ║║╚╝║║╔═╗║╔═╗║───────────────────────
-- ║╔╗╔╗║║─║║╚══╗───────────────────────
-- ║║║║║║║─║╠══╗║──By MacTavish <3──────
-- ║║║║║║╚═╝║╚═╝║───────────────────────
-- ╚╝╚╝╚╩══╗╠═══╝───────────────────────
-- ────────╚╝───────────────────────────
--──────────────────────────────────--
---------- Util functions ------------
--──────────────────────────────────--
function MQS.CheckID(id)
	id = string.match(id, "^[a-zA-Z0-9_]*$")
	if tonumber(id) then return false end

	return id
end

function MQS.TableCompress(data)
	local json_data = util.TableToJSON(data, false)
	local compressed_data = util.Compress(json_data)
	local bytes_number = string.len(compressed_data)

	return compressed_data, bytes_number
end

function MQS.TableDecompress(compressed_data)
	local json_data = util.Decompress(compressed_data)
	local data = util.JSONToTable(json_data)

	return data
end

function MQS.HasNPCLink(link, npc)
	if istable(link) then return link.id == npc end

	return link == npc
end

function MQS.QuestStatusCheck(tk, ply)
	if CLIENT and not ply then
		ply = LocalPlayer()
	end

	if ply.MQSdata and ply.MQSdata.Stored and ply.MQSdata.Stored.QuestList and ply.MQSdata.Stored.QuestList[tk] then return ply.MQSdata.Stored.QuestList[tk] end

	return false
end

function MQS.GetSData(ply, data, def)
	if CLIENT and not ply then
		ply = LocalPlayer()
	end

	if not ply.MQSdata or not ply.MQSdata.Stored or not ply.MQSdata.Stored[data] then return def end

	return ply.MQSdata.Stored[data]
end

function MQS.QuestFinished(quest, ply)
	if CLIENT and not ply then
		ply = LocalPlayer()
	end

	if ply.MQSdata and ply.MQSdata.Stored and ply.MQSdata.Stored.QuestList and ply.MQSdata.Stored.QuestList[quest] then return true end

	return false
end

function MQS.CanStartTask(tk, ply, npc, force)
	if CLIENT then
		ply = LocalPlayer()
	end

	local task = MQS.Quests[tk]
	if not task then return false, MSD.GetPhrase("inv_quest") end
	if not ply or not IsValid(ply) or not ply:Alive() then return false, MSD.GetPhrase("dead") end
	if MQS.HasQuest(ply) then return false, MSD.GetPhrase("active_quest") end

	if not force then
		local block, reason = hook.Call("MQS.PreventTaskStart", nil, ply, tk, task)
		if block then return false, reason or MSD.GetPhrase("inactive_quest") end
		if not MQS.IsEditor(ply) and not task.active and not MQS.Config.NPC.enable then return false, MSD.GetPhrase("inactive_quest") end
		if (CLIENT or not MQS.IsEditor(ply)) and MQS.Config.NPC.enable and (not npc or not task.link or not MQS.HasNPCLink(task.link, npc)) then return false, MSD.GetPhrase("inactive_quest") end
		local allow = hook.Call("MQS.AllowJailTaskStart", nil, ply, tk, task)
		if not allow and (ply:isWanted() or ply:isArrested()) then return false, MSD.GetPhrase("inactive_quest") end
		local tm = ply:Team()
		if not task.team_blacklist and task.team_whitelist and not task.team_whitelist[tm] then return false, MSD.GetPhrase("team_bl") end
		if task.team_blacklist and task.team_whitelist and task.team_whitelist[tm] then return false, MSD.GetPhrase("team_bl") end
		if task.need_players and #player.GetAll() < task.need_players then return false, MSD.GetPhrase("no_players") end
		if task.cant_replay and ply.MQSdata.Stored and ply.MQSdata.Stored.QuestList and ply.MQSdata.Stored.QuestList[tk] then return false, MSD.GetPhrase("q_noreplay") end
		if task.quest_needed and MQS.Quests[task.quest_needed] and not MQS.Quests[task.quest_needed].looped and (not ply.MQSdata.Stored.QuestList or not ply.MQSdata.Stored.QuestList[task.quest_needed]) then return false, MSD.GetPhrase("q_needquest") end
		if not task.cooldow_perply and MQS.TaskQueue[tk] and MQS.TaskQueue[tk] > CurTime() then return false, MSD.GetPhrase("q_time_wait") end
		if task.cooldow_perply and ply.MQSdata.Stored.CoolDown and ply.MQSdata.Stored.CoolDown[tk] and ply.MQSdata.Stored.CoolDown[tk] > os.time() then return false, MSD.GetPhrase("q_time_wait") end
		if task.limit and MQS.TaskCount[tk] and MQS.TaskCount[tk] >= task.limit then return false, MSD.GetPhrase("q_play_limit") end

		if task.conflictlist then
			for qst, _ in pairs(task.conflictlist) do
				if MQS.TaskCount[qst] and MQS.TaskCount[qst] > 0 then return false, MSD.GetPhrase("q_play_limit") end
			end
		end

		if task.quest_blacklist and ply.MQSdata.Stored.QuestList then
			for qst, _ in pairs(task.quest_blacklist) do
				if ply.MQSdata.Stored.QuestList[qst] then return false, MSD.GetPhrase("inactive_quest") end
			end
		end

		if task.need_teamplayers then
			for tms, num in pairs(task.need_teamplayers) do
				if team.NumPlayers(tms) < tonumber(num) then return false, MSD.GetPhrase("no_players_team") end
			end
		end
	end

	if SERVER and task.checkvehspawn then
		for id, object in pairs(task.objects) do
			if not object.events then continue end
			for id_e, event in pairs(object.events) do
				if event[1] == "Spawn vehicle" then
					for k, v in pairs(ents.FindInSphere(event[2][3], 200)) do
						if string.find(v:GetClass(), "fphysics") then
							return false, "Место появления машины занято"
						end
					end
				end
			end
		end
	end

	return true
end

function MQS.ActiveQuestLists(npc, ply)
	if CLIENT and not ply then
		ply = LocalPlayer()
	end

	local a_quests = {}

	for k, v in pairs(MQS.Quests) do
		if MQS.CanStartTask(k, ply, npc) then
			a_quests[k] = true
		end
	end

	return a_quests
end

MQS.QuestEntTable = {
	["env_steam"] = function(steam, data)
		steam:SetKeyValue("InitialState", "1")
		steam:SetKeyValue("angles", tostring(steam:GetAngles()))
		steam:SetKeyValue("rendercolor", "200 200 200")
		steam:SetKeyValue("renderamt", "200")
		steam:SetKeyValue("JetLength", "39")
		steam:SetKeyValue("SpreadSpeed", "25")
		steam:SetKeyValue("Speed", "135")
		steam:SetKeyValue("StartSize", "6")
		steam:SetKeyValue("EndSize", "32")
		steam:SetKeyValue("Rate", "32")
		steam:SetKeyValue("rollspeed", "12")
		steam:SetKeyValue("type", "0")
		steam:SetKeyValue("spawnflags", "1")
		steam:Fire("TurnOn", "", 0)
		steam:Activate()
	end,
	["env_spark"] = function(sparks, data)
		sparks:SetKeyValue("angles", tostring(sparks:GetAngles()))
		sparks:SetKeyValue("MaxDelay", "2")
		sparks:SetKeyValue("Magnitude", "2")
		sparks:SetKeyValue("TrailLength", "2")
		sparks:SetKeyValue("spawnflags", "704")
		sparks:Fire("SparkOnce", "", 0)
		sparks:Fire("StartSpark", "", 0)
		sparks:Activate()
	end,
}

-- Episodes moved to the glac addon (glac/sh_episodes.lua, Glac.Episodes)

MQS.Scenes = MQS.Scenes or {}
MQS.Scenes.Loaded = MQS.Scenes.Loaded or {}
MQS.Scenes.Cache = MQS.Scenes.Cache or {}

--MQS.Scenes.Load("crack") MQS.Scenes.UnLoad("crack")
if SERVER then
	function MQS.Scenes.Convert(name)
		if not file.Exists("a_scenes/" .. name .. ".dat", "DATA") then return end
		local scene = util.Decompress(file.Read("a_scenes/" .. name .. ".dat", "DATA"))
		file.Write("a_scenes/" .. name .. ".json", scene)
	end

	function MQS.Scenes.ConvertBack(name)
		if not file.Exists("a_scenes/" .. name .. ".json", "DATA") then return end
		local scene = file.Read("a_scenes/" .. name .. ".json", "DATA")
		scene = util.Compress(scene)
		file.Write("a_scenes/" .. name .. ".dat", scene)
	end

	--MQS.Scenes.Convert("burnedaparts3")
	--MQS.Scenes.ConvertBack("burnedaparts3")
	function MQS.Scenes.Load(name)
		if MQS.Scenes.Loaded[name] then return end
		if not file.Exists("a_scenes/" .. name .. ".dat", "DATA") then return end
		local scene = util.JSONToTable(util.Decompress(file.Read("a_scenes/" .. name .. ".dat", "DATA")))
		MQS.Scenes.Loaded[name] = {}
		MQS.Scenes.Cache[name] = scene.cs
		local cd, bn = MQS.TableCompress(scene.cs)
		net.Start("MQS.SceneManage")
		net.WriteString(name)
		net.WriteUInt(1, 2)
		net.WriteUInt(bn, 32)
		net.WriteData(cd, bn)
		net.Broadcast()

		for k, v in ipairs(scene.sv) do
			if v.mdl == "models/maxofs2d/light_tubular.mdl" then
				local mdl = ents.Create("gmod_light")
				mdl:SetPos(v.pos)
				mdl:SetColor(v.col)
				mdl:SetLightSize((v.col.a / 255) * 1024)
				mdl:SetBrightness(v.skin or 1)
				mdl:SetOn(true)
				mdl:Spawn()
				print(mdl)
				mdl:SetSolid(SOLID_NONE)
				mdl:SetMoveType( MOVETYPE_NONE )
				mdl:SetNoDraw(true)
				table.insert(MQS.Scenes.Loaded[name], mdl)
				continue
			end

			local mdl = ents.Create("prop_physics")
			mdl:SetModel(v.mdl)
			mdl:SetPos(v.pos)
			mdl:SetAngles(v.ang)
			mdl:Spawn()
			table.insert(MQS.Scenes.Loaded[name], mdl)
			local phys = mdl:GetPhysicsObject()
			phys:EnableMotion(false)
			mdl:SetSkin(v.skin or 1)
			mdl:SetMaterial(v.mat or "")

			if v.col then
				mdl:SetColor(v.col)
			end

			if v.col and v.col.a < 255 then
				mdl:SetRenderMode(RENDERMODE_TRANSCOLOR)
			end

			if v.smt then
				for i, m in pairs(v.smt) do
					mdl:SetSubMaterial(i, m)
				end
			end

			if v.bgr then
				for i, m in pairs(v.bgr) do
					mdl:SetBodygroup(i, m)
				end
			end
		end
	end

	function MQS.Scenes.UnLoad(name)
		if not MQS.Scenes.Loaded[name] then return end
		net.Start("MQS.SceneManage")
		net.WriteString(name)
		net.WriteUInt(0, 2)
		net.Broadcast()

		for k, v in ipairs(MQS.Scenes.Loaded[name]) do
			if IsValid(v) then
				v:Remove()
			end
		end

		MQS.Scenes.Loaded[name] = nil
		MQS.Scenes.Cache[name] = nil
	end
else
	function MQS.Scenes.Load(name, data)
		if MQS.Scenes.Loaded[name] then return end
		MQS.Scenes.Loaded[name] = {}

		for k, v in ipairs(data) do
			local mdl = ClientsideModel(v.mdl, RENDERGROUP_OPAQUE)
			mdl.data = v
			mdl.id = k
			mdl.scene = name
			mdl:SetModel(v.mdl)
			mdl:SetPos(v.pos)
			mdl:SetAngles(v.ang)
			table.insert(MQS.Scenes.Loaded[name], mdl)

			if client_mdls then
				table.insert(client_mdls, mdl)
			end

			mdl:SetSkin(v.skin or 1)
			mdl:SetMaterial(v.mat or "")

			if v.col then
				mdl:SetColor(v.col)
			end

			if v.col and v.col.a < 255 then
				mdl:SetRenderMode(RENDERMODE_TRANSCOLOR)
			end

			if v.smt then
				for i, m in pairs(v.smt) do
					mdl:SetSubMaterial(i, m)
				end
			end

			if v.bgr then
				for i, m in pairs(v.bgr) do
					mdl:SetBodygroup(i, m)
				end
			end

			if v.anm then
				mdl:ResetSequence(v.anm)
				mdl:ResetSequenceInfo()
				mdl:SetPlaybackRate(v.pbs or 1)
				mdl:SetIK(false)
				mdl:SetCycle(0)

				if client_mdls_anim then
					table.insert(client_mdls_anim, mdl)
				end
			end
		end
	end

	function MQS.Scenes.UnLoad(name)
		if not MQS.Scenes.Loaded[name] then return end

		for k, v in ipairs(MQS.Scenes.Loaded[name]) do
			if IsValid(v) then
				v:Remove()
			end
		end

		MQS.Scenes.Loaded[name] = nil
	end

	net.Receive("MQS.SceneManage", function()
		local scene = net.ReadString()
		local tp = net.ReadUInt(2)

		if tp == 1 then
			local bytes_number = net.ReadUInt(32)
			local compressed_data = net.ReadData(bytes_number)
			local data = MQS.TableDecompress(compressed_data)
			MQS.Scenes.Load(scene, data)
		elseif tp == 0 then
			MQS.Scenes.UnLoad(scene)
		elseif tp == 2 then
			local bytes_number = net.ReadUInt(32)
			local compressed_data = net.ReadData(bytes_number)
			local data = MQS.TableDecompress(compressed_data)

			for k, v in pairs(data) do
				MQS.Scenes.Load(k, v)
			end
		end
	end)
end