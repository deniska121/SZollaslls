--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_quests/lua/mqs/core/sh_init.lua
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
-------------- Events ---------------
--──────────────────────────────────--

MQS.Events["Spawn quest entity"] = function(id, ply, data, obj, task)

	local ent = ents.Create("mqs_ent")
	ent.model = data[1]
	ent.task = task
	ent.task_ply = ply
	ent.pointer = data[3]
	ent.enablephys = data[4]
	ent.pickeffect = data[13]
	ent.loopsnd = data[14]
	ent.allies = {}
	if data[9] and MQS.ActiveTask[id].vehicle then
		local veh = Entity(MQS.ActiveTask[id].vehicle)
		ent:SetParent(veh)
		ent:SetPos(veh:LocalToWorld(data[2]))
		local ang2 = data[5] or Angle(0,0,0)
		local ang = veh:GetAngles()
		ang:RotateAroundAxis(ang:Right(), ang2.p)
		ang:RotateAroundAxis(ang:Up(), ang2.y)
		ang:RotateAroundAxis(ang:Forward(), ang2.r)
		ent:SetAngles(ang)
	else
		ent:SetPos(data[2])
		if data[5] then
			ent:SetAngles(data[5])
		end
	end

	if data[6] then
		ent:SetMaterial(data[6])
	end

	if data[6] == "null" then
		ent:DrawShadow(false)
	end

	if data[7] then
		if data[7].a and  data[7].a < 255 then
			ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
		end
		ent:SetColor(data[7])
	end

	if data[8] then
		ent:SetUseHold(data[8])
	end
	ent.IsMQS = true
	ent.task_id = id
	ent:Spawn()

	if not MQS.ActiveTask[id].ents then
		MQS.ActiveTask[id].ents = {}
	end

	table.insert(MQS.ActiveTask[id].ents, ent:EntIndex())

	if data[10] then
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	if data[11] then
		ent.updateobj = data[11]
	end

	for k,v in pairs( ents.FindInSphere(data[2], 10) ) do
		if not IsValid(v) or v:GetClass() ~= "mqs_ent" or v.task_ply == ply then continue end
		table.insert(ent.allies, v)
	end

	if data[6] == "null" then
		ent:DrawShadow(false)
	end

	if data[12] then
		ent:SetDistractible(true)
		ent:SetHP(tonumber(data[12]) or 100)
	else
		ent:SetDistractible(false)
	end
end

MQS.Events["Spawn vehicle"] = function(task, ply, data)
	if MQS.ActiveTask[task].vehicle then return end
	local vehicle = MQS.SpawnQuestVehicle(ply, data[1], data[2], data[3], data[4])
	if not vehicle then return end

	if data[5] then
		vehicle:SetSkin(data[5])
	end

	if data[7] then
		vehicle:SetColor(data[7])
	end

	if data[8] then
		vehicle:SetNWBool("MccD.Radio", true)
	end
	vehicle.IsMQS = task
	vehicle.task_id = task
	vehicle.mqsowner = ply
	-- vehicle.spawnprotection = data[3]
	-- vehicle:SetCollisionGroup(COLLISION_GROUP_WORLD)
	vehicle = vehicle:EntIndex()

	if not MQS.ActiveTask[task].vehicle then
		MQS.ActiveTask[task].vehicle = vehicle
	end
end

MQS.Events["Remove vehicle"] = function(task, ply, data)
	if not MQS.ActiveTask[task].vehicle then return end
	local veh = Entity(MQS.ActiveTask[task].vehicle)
	MQS.ActiveTask[task].vehicle = nil

	if data and data > 0 then
		timer.Simple(data, function()
			if IsValid(veh) and veh.IsMQS then
				SafeRemoveEntity(veh)
			end
		end)
	else
		if IsValid(veh) and veh.IsMQS then
			SafeRemoveEntity(veh)
		end
	end
end

MQS.Events["Check for vehicle"] = function(task, ply, data)
	if not MQS.ActiveTask[task].vehicle then return end
	local veh = Entity(MQS.ActiveTask[task].vehicle)
	MQS.ActiveTask[task].vehicle = nil

	if IsValid(veh) and veh.IsMQS and data[1]:DistToSqr(veh:GetPos()) > data[2] ^ 2 then
		MQS.FailTask(ply, MSD.GetPhrase("vehicle_bum"))
	end
end

MQS.Events["Ent Fire"] = function(task, ply, data)
	local ent = ents.GetMapCreatedEntity(data[1])
	if not IsValid(ent) then return end

	ent:Fire(data[2], data[3])
end

MQS.Events["Spawn entity"] = function(id, ply, data, obj, task)
	if data[1] == "worldspawn" then return end
	local ent = ents.Create(data[1])

	if not ent:IsValid() then
		MsgC(Color(255, 0, 0), "[MQS] Quest id: " .. task .. " failed to create " .. data[1] .. "!\n")

		return
	end

	ent:SetPos(data[2])
	ent:SetAngles(data[3])

	if data[4] then
		ent:SetModel(data[4])
	end

	if data[6] then
		ent:SetMaterial(data[6])
	end

	if data[7] then
		if data[7].a and  data[7].a < 255 then
			ent:SetRenderMode( RENDERMODE_TRANSCOLOR )
		end
		ent:SetColor(data[7])
	end

	ent.IsMQS = data[8] or "default"
	ent.task_id = id
	ent:Spawn()

	table.insert(MQS.ActiveTask[id].misc_ents, ent:EntIndex())

	if MQS.QuestEntTable and MQS.QuestEntTable[data[1]] then
		MQS.QuestEntTable[data[1]](ent, data)
		return
	end

	if data[5] then
		local phys = ent:GetPhysicsObject()

		if phys:IsValid() then
			phys:EnableMotion(false)
		end
	end

	if data[9] then
		ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
	end

	if data[1] == "gmod_sent_vehicle_fphysics_gib" then
		ent:Activate()
		ent:GetPhysicsObject():SetVelocity(Vector(math.random(-5, 5), math.random(-5, 5), math.random(150, 250)))
		ent.MakeSound = true
		ent.DoNotDuplicate = true
	end
end

MQS.Events["Remove entites by ID"] = function(task, ply, data)
	if MQS.ActiveTask[task].misc_ents then
		for k, v in pairs(MQS.ActiveTask[task].misc_ents) do
			local ent = ents.GetByIndex(v)
			if IsValid(ent) and ent.IsMQS == data[1] then
				SafeRemoveEntity(ent)
				MQS.ActiveTask[task].misc_ents[k] = nil
			end
		end
	end
end

MQS.Events["Remove all entites"] = function(task, ply, data)
	if MQS.ActiveTask[task].misc_ents then
		for k, v in pairs(MQS.ActiveTask[task].misc_ents) do
			local ent = ents.GetByIndex(v)
			if IsValid(ent) and ent.IsMQS then
				SafeRemoveEntity(ent)
			end
		end
	end
	MQS.ActiveTask[task].misc_ents = {}
end

MQS.NpcActions = {
	["team"] = function(ent, actions, ply, data)
		if actions[2] == "h" then
			ent:AddRelationship("player D_HT 99")
			ent.team = "h"
			for _,v in ipairs(ents.FindByClass(data[1])) do
				if not v.team or v.team == "h" then continue end
				ent:AddEntityRelationship(v, 1, 99)
				v:AddEntityRelationship(ent, 1, 99)
				v:SetNPCState(NPC_STATE_COMBAT)
			end
			return
		end

		if actions[2] == "n" then
			ent.team = "n"
			return
		end
		ent.team = actions[2]
	end
}

MQS.Events["Spawn npc"] = function(id, ply, data, obj, task)
	local ent = ents.Create(data[1])

	if not ent:IsValid() then
		MsgC(Color(255, 0, 0), "[MQS] Quest id: " .. task .. " failed to create " .. data[1] .. "!\n")
		return
	end

	ent:SetPos(data[2])
	ent:SetAngles(data[3])

	if data[4] then
		ent.is_quest_npc = task
		ent:SetNWBool( "MQSTarget", true )
		MQS.ActiveTask[id].npcs = MQS.ActiveTask[id].npcs and MQS.ActiveTask[id].npcs + 1 or 1
	elseif data[13] then
		ent.is_quest_protect = ply
		ent:SetNWString( "MQSProtect", data[14] or "Protect the npc")
		net.Start("MQS.UIEffect")
			net.WriteString("MQS.ProtectNPC")
			net.WriteTable({ent:EntIndex(), data[1]})
		net.Broadcast()
	end

	ent.IsMQS = true
	ent.task_id = id
	ent:Spawn()
	ent:Activate()

	if data[5] then
		if string.StartWith(data[5], "mcsnpc+") then
			local npc = MCS.Spawns[string.Explode("+", data[5])[2]]
			print(ent:GetPos())
			if npc then
				ent:SetModel(npc.model)
				if npc.submat then
					for k, v in pairs(npc.submat) do
						ent:SetSubMaterial(k, v)
					end
				end

				if npc.bgr then
					for k, v in pairs(npc.bgr) do
						ent:SetBodygroup(k, v)
					end
				end

				if npc.skin then
					ent:SetSkin(npc.skin)
				end
			end
		else
			ent:SetModel(data[5])
		end
	else
		ent:SetModel("models/Humans/Group0" .. math.random(2) .. "/Male_0" .. math.random(9) .. ".mdl")
		MCR.SetMatCustomByName(ent, "citizen_sheet", "gbskins/male/sheet_" .. math.random(52))
	end

	if data[6] then
		ent:Give(data[6])
	end

	ent:SetHealth(data[9] or 40)
	table.insert(MQS.ActiveTask[id].misc_ents, ent:EntIndex())

	if data[8] then return end
	local gr = "D_HT"
	if data[7] then
		ent:AddEntityRelationship(ply, 1, 99)
		ent:SetNPCState(NPC_STATE_COMBAT)
	else
		ent:AddEntityRelationship(ply, 4, 99)
		gr = "D_LI"
	end
	if obj.open_target then
		ent:AddRelationship("player " .. gr .. " 99")
		ent.open_target = true
	else
		ent:AddRelationship("player D_NU 99")
	end
	ent:SetKeyValue("spawnflags", bit.bor(SF_NPC_NO_WEAPON_DROP, SF_NPC_FADE_CORPSE))

	if data[10] then
		local flags = string.Explode(";", data[10])

		for _, v in ipairs(flags) do
			local actions = string.Explode(" ", v)

			if MQS.NpcActions[actions[1]] then
				MQS.NpcActions[actions[1]](ent, actions, ply, data, obj, task)
			end
		end
	end
end

MQS.Events["Give weapon"] = function(task, ply, data)
	local weapon = ply:Give(data)
	if IsValid(weapon) and weapon ~= NULL then
		weapon.MQS_weapon = true
	end
end

MQS.Events["NPC Change state"] = function(task, ply, data)
	local weapon = ply:Give("event_item")
	if IsValid(weapon) and weapon ~= NULL then
		weapon.MQS_weapon = true
		weapon:SetItem(data)
	end
	ply:SelectWeapon("event_item")
end

MQS.Events["Give quest item"] = function(task, ply, data)
	local weapon = ply:Give("event_item")
	if IsValid(weapon) and weapon ~= NULL then
		weapon.MQS_weapon = true
		weapon:SetItem(data)
	end
	ply:SelectWeapon("event_item")
end

MQS.Events["Give ammo"] = function(task, ply, data)
	ply:GiveAmmo(data[2], data[1], false)
end

MQS.Events["Strip Weapon"] = function(task, ply, data)
	ply:StripWeapon(data)
end

MQS.Events["Strip All FireArms"] = function(task, ply, data)
	for _, wep in pairs(ply:GetWeapons()) do
		if not wep.IsMWwp then continue end
		ply:StripWeapon(wep:GetClass())
	end
end

MQS.Events["Strip All Weapons"] = function(task, ply, data)
	ply.MQS_oldWeap = ply.MQS_oldWeap or {}

	if data then
		ply.MQS_restore = true
	end

	for _, wep in pairs(ply:GetWeapons()) do
		if wep.MQS_weapon then continue end
		ply.MQS_oldWeap[wep:GetClass()] = true
	end

	ply:StripWeapons()
end

MQS.Events["Restore All Weapons"] = function(task, ply)
	for wep, _ in pairs(ply.MQS_oldWeap) do
		ply:Give(wep)
	end
end

MQS.Events["Manage do time"] = function(task, ply, data)
	if not MQS.GetNWdata(ply, "do_time") then return end
	if isbool(data[1]) then data[1] = 1 end

	if data[1] == 1 then
		local q = MQS.ActiveTask[task].task
		MQS.SetNWdata(ply, "do_time", CurTime() + MQS.Quests[q].do_time)
	elseif data[1] == 2 then
		MQS.SetNWdata(ply, "do_time", MQS.GetNWdata(ply, "do_time") + data[2])
	else
		MQS.SetNWdata(ply, "do_time", CurTime() + data[2])
	end

end

MQS.Events["Kill Penalty"] = function(task, ply, data)
	if data[1] == "remove" then
		MQS.ActiveTask[task].penalty = nil
	end
	MQS.ActiveTask[task].penalty = data[1]
end

MQS.Events["Set HP"] = function(task, ply, data)
	if data[1] then
		ply:MedHeal()
		if ply:Health() >= 30 then
			ply:AddTempStat("meds3", 300)
			ply:AddTempStat("hunger", 200)
			if ply:getDarkRPVar("energy") < 300 then
				ply:SetSelfDarkRPVar("energy", math.random(400, 500))
			end
			if ply:getDarkRPVar("thirst") < 50 then
				ply:SetSelfDarkRPVar("thirst", math.random(100, 150))
			end
		end
	else
		ply:SetHealth(data[2])
	end
end

MQS.Events["Check Player HP"] = function(task, ply, data)
	if ply:getDarkRPVar("bleeding") or ply:Health() < 30 then
		MQS.UpdateObjective(ply, data[1])
	end
end

MQS.Events["Set Armor"] = function(task, ply, data)
	ply:SetArmor(math.Clamp(data[1], 0, 255))
end

MQS.Events["Teleport player"] = function(task, ply, data)
	if ply:InVehicle() then
		ply:ExitVehicle()
	end

	local pos = data[1]

	if data[3] then
		pos = GAMEMODE:FindEmptyPos(data[1], {ply}, 600, 30, Vector(16, 16, 64))
	end

	ply:SetPos( pos )
	ply:SetEyeAngles( data[2] )
	ply:SetLocalVelocity( Vector( 0, 0, 0 ) )
end

MQS.Events["Set spawn point"] = function(task, ply, data)
	if data[1] then
		ply.EventData.SpawnPoint = data
	else
		ply.EventData.SpawnPoint = nil
	end
end

MQS.Events["Cinematic camera"] = function(task, ply, data)
	net.Start("MQS.UIEffect")
		net.WriteString("Cinematic camera")
		net.WriteTable(data)
	net.Send(ply)
end

MQS.Events["Music player"] = function(task, ply, data)
	net.Start("MQS.UIEffect")
		net.WriteString("Music")
		net.WriteTable(data)
	net.Send(ply)
end

MQS.Events["Music player pos"] = function(task, ply, data)
	net.Start("MQS.UIEffect")
		net.WriteString("Music Pos")
		net.WriteTable(data)
	net.Send(ply)
end

MQS.Events["Emit sound"] = function(task, ply, data)
	sound.Play(data[1], data[2], data[4] or 75, 100, data[3] and math.Clamp(tonumber(data[3]), 0, 1) or 1)
end

MQS.Events["Player emit sound"] = function(task, ply, data)
	ply:EmitSound(data[1], data[3] or 75, 100, data[2] and math.Clamp(tonumber(data[2]), 0, 1) or 1)
end

MQS.Events["DarkRP Wanted"] = function(task, ply, data)
	ply:wanted(nil, data[1])
end

MQS.Events["Load Scene"] = function(task, ply, data)
	if not MQS.ActiveTask[task].scenes then MQS.ActiveTask[task].scenes = {} end
	MQS.Scenes.Load(data[1])
	MQS.ActiveTask[task].scenes[data[1]] = true
end

MQS.Events["Unload Scene"] = function(task, ply, data)
	MQS.Scenes.UnLoad(data[1])
	MQS.ActiveTask[task].scenes[data[1]] = nil
end

MQS.Events["[MCS] Spawn npc"] = function(task, ply, data)
	if data[4] then
		if MQS.ActiveTask[task].misc_ents then
			for k, v in pairs(MQS.ActiveTask[task].misc_ents) do
				local ent = ents.GetByIndex(v)
				if IsValid(ent) and ent.IsMQS and ent:GetClass() == "mcs_npc" and ent:GetUID() == data[1] then
					SafeRemoveEntity(ent)
				end
			end
		end
		return
	end

	local npc = MCS.Spawns[data[1]]
	if not npc then return end

	local ent = MCS.SpawnNPC(npc, data[1], data[2], data[3])
	ent.IsMQS = true
	ent.task_id = task
	table.insert(MQS.ActiveTask[task].misc_ents, ent:EntIndex())

	MQS.ActiveTask[task].LastPoint = ent:GetPos()

	net.Start("MQS.UIEffect")
		net.WriteString("NPCPosition")
		net.WriteTable({id = data[1], pos = ent:GetPos()})
	net.Send(ply)
end

MQS.Events["Run Console Command"] = function(task, ply, data)
	local cmd = data[1]
	local args = data[2]
	local cmd_arg = ""
	args = string.Explode(" ", args)

	for _, arg in pairs(args) do
		if arg == "$uid" then
			arg = ply:UserID()
		end

		if arg == "$sid" then
			arg = ply:SteamID()
		end

		if arg == "$s64" then
			arg = ply:SteamID64()
		end

		if arg == "$n" then
			arg = "\"" .. ply:Name() .. "\""
		end

		cmd_arg = cmd_arg .. " " .. arg
	end
	game.ConsoleCommand(cmd .. cmd_arg .. "\n")
end

MQS.Events["Track player"] = function(task, ply, data)
	local ntable = {
		id = task,
		uid = ply:UserID(),
		text = data[1],
		icon = data[2],
		teams = data[3]
	}

	local filter = RecipientFilter()

	for _, p in pairs(player.GetAll()) do
		if p == ply then continue end
		if data[3][team.GetName(p:Team())] then
			filter:AddPlayer(p)
		end
	end

	net.Start("MQS.UIEffect")
		net.WriteString("Track")
		net.WriteTable(ntable)
	net.Send(filter)

	MQS.Notify(ply, MSD.GetPhrase("warning"), MSD.GetPhrase("youaretracked"), 4)
end

MQS.Events["End track player"] = function(task, ply, data)
	net.Start("MQS.UIEffect")
		net.WriteString("UnTrack")
		net.WriteTable({id = task})
	net.Broadcast()

	MQS.Notify(ply, MSD.GetPhrase("m_loop"), MSD.GetPhrase("nolongertracked"), 4)
end

MQS.Events["Set Job Name"] = function(task, ply, data)
	ply:updateJob( data[1] )
end

MQS.Events["Stop NPC protection"] = function(task, ply, data)
	if MQS.ActiveTask[task].misc_ents then
		for k, v in pairs(MQS.ActiveTask[task].misc_ents) do
			local ent = ents.GetByIndex(v)
			if IsValid(ent) and ent.IsMQS and ent.task_id == task and ent.is_quest_protect then
				ent.is_quest_protect = nil
				ent:SetNWString( "MQSProtect", nil)
			end
		end
	end
	net.Start("MQS.UIEffect")
		net.WriteString("MQS.ProtectNPCStop")
		net.WriteTable({})
	net.Broadcast()
end

MQS.Events["Passanger spawn"] = function(task, ply, data)
	local ent = ents.Create("npc_passenger")
	ent:SetPos(data[1])
	ent:SetAngles(data[2])
	if data[8] then
		ent.standpos = data[8]
	end
	local gender = math.random(2)
	ent:Spawn()
	ent:Activate()

	ent.pmdata = {
		gn = gender == 1 and "male" or "female",
		model = gender == 1 and math.random(9) or math.random(6),
		top = gender == 1 and math.random(44) or math.random(25),
		pants = gender == 1 and math.random(44) or math.random(25),
		sit = data[3] and 3 or math.random(11, 20),
		ef = 3,
	}

	if data[4] then
		ent.pmdata.gn = data[4]
		ent.pmdata.model = data[5]
		ent.pmdata.top = data[6]
		ent.pmdata.pants = data[7]
	end

	if MQS.ActiveTask[task].vehicle then
		local veh = Entity(MQS.ActiveTask[task].vehicle)
		ent.simf = veh
	end

	ent:SetModel( "models/cityrp/pm/normal/" .. ent.pmdata.gn .. "_0" .. ent.pmdata.model .. ".mdl" )

	MCR.SetMatID(ent, ent.pmdata.gn, "top", ent.pmdata.top)
	MCR.SetMatID(ent, ent.pmdata.gn, "pants", ent.pmdata.pants)
end

MQS.Events["Passanger spawn random"] = function(task, ply, data)
	if  math.random(10) < 3 then return end

	local ent = ents.Create("npc_passenger")
	ent:SetPos(data[1])
	ent:SetAngles(data[2])

	local gender = math.random(2)
	ent:Spawn()
	ent:Activate()

	ent.pmdata = {
		gn = gender == 1 and "male" or "female",
		model = gender == 1 and math.random(9) or math.random(6),
		top = gender == 1 and math.random(44) or math.random(25),
		pants = gender == 1 and math.random(44) or math.random(25),
		sit = math.random(5, 10),
		enp = Vector(-157.5,-51.81,24.83),
		exf = Vector(206.09,-90.92,26.45)
	}

	if MQS.ActiveTask[task].vehicle then
		local veh = Entity(MQS.ActiveTask[task].vehicle)
		ent.simf = veh
	end

	ent:SetModel( "models/cityrp/pm/normal/" .. ent.pmdata.gn .. "_0" .. ent.pmdata.model .. ".mdl" )

	MCR.SetMatID(ent, ent.pmdata.gn, "top", ent.pmdata.top)
	MCR.SetMatID(ent, ent.pmdata.gn, "pants", ent.pmdata.pants)
end

MQS.Events["Passanger delete"] = function(task, ply, data)
	if not MQS.ActiveTask[task].vehicle then return end
	local veh = Entity(MQS.ActiveTask[task].vehicle)

	if not IsValid(veh) then return end

	timer.Simple(1, function()
		if not IsValid(veh) then return end
		veh:RemoveAnyCLPass(true)
	end)
end

MQS.Events["Passanger delete random"] = function(task, ply, data)
	if math.random(10) < 3 then return end
	if not MQS.ActiveTask[task].vehicle then return end
	local veh = Entity(MQS.ActiveTask[task].vehicle)

	timer.Simple(2, function()
		if not IsValid(veh) then return end
		veh:RemoveAnyCLPass(true)
	end)
end

MQS.Events["Give Inv"] = function(task, ply, data)
	local gclass = McINV.ttypes[data[2]]
	local ent_data = DarkRP[gclass][data[1]]
	McINV.AddCustomItem(ply, data[2], data[1], ent_data, false)
end

MQS.Events["DarkRP Junk"] = function(id, ply, data, obj, task)
	if not data[1] then return end
	local ent = DarkRP.CreateJunk(data[1], data[2], data[3])
	if not ent then return end

	if data[4] then
		ent:SetModel(data[4])
		ent:PhysicsInit(SOLID_VPHYSICS)
	end

	if data[5] then
		ent:SetMaterial(data[5])
	end

	if data[6] then
		ent.name = data[6]
	end

	if data[7] then
		ent.weight = tonumber(data[7]) or 0
	end

	ent.IsMQS = "default"
	ent.task_id = id

	table.insert(MQS.ActiveTask[id].misc_ents, ent:EntIndex())
end


-- MQS.Events["Rato?"] = function(task, ply, data)
-- 	pk_pills.apply(ply, "rat", "lock-life")
-- end

-- MQS.Events["No more Rato :("] = function(task, ply, data)
-- 	pk_pills.restore(ply, true)
-- end

--──────────────────────────────────--
-------------- Rewards ---------------
--──────────────────────────────────--

MQS.Rewards["Give Weapon"] = {
	reward = function(ply, val)
		ply:Give(val[1])
	end,
}

MQS.Rewards["Episode Points"] = {
	reward = function(ply, val)
		Glac.AddEpisodePoints(ply, val[1])
	end,
}

MQS.Rewards["DarkRP money"] = {
	check = function()
		if DarkRP then return false end

		return true
	end,
	reward = function(ply, val)
		ply:addMoney(val[1])
	end,
}

MQS.Rewards["DarkRP PayDay"] = {
	check = function()
		if DarkRP then return false end

		return true
	end,
	reward = function(ply, val)
		ply:PayDay(val[1])
	end,
}

MQS.Rewards["DarkRP Sanity"] = {
	check = function()
		if DarkRP then return false end

		return true
	end,
	reward = function(ply, val)
		ply:addKarma(val[1])
	end,
}

MQS.Rewards["Run Console Command"] = {
	reward = function(ply, val)
		local cmd = val[1]
		local args = val[2]
		local cmd_arg = ""
		args = string.Explode(" ", args)

		for _, arg in pairs(args) do
			if arg == "$uid" then
				arg = ply:UserID()
			end

			if arg == "$sid" then
				arg = "\"" .. ply:SteamID() .. "\""
			end

			if arg == "$s64" then
				arg = ply:SteamID64()
			end

			if arg == "$n" then
				arg = "\"" .. ply:Name() .. "\""
			end

			cmd_arg = cmd_arg .. " " .. arg
		end
		game.ConsoleCommand(cmd .. cmd_arg .. "\n")
	end,
}

MQS.Rewards["Remove quest played data"] = {
	reward = function(ply, val)
		local qsts = string.Explode(",", val[1])

		local qs = ply.MQSdata.Stored.QuestList

		for k,v in ipairs(qsts) do
			if not qs[v] then continue end
			qs[v] = nil
		end

		MQS.SetNWStoredData(ply, "QuestList", qs)
	end,
}

MQS.Rewards["MRS"] = {
	check = function()
		if MRS then return false end
		return true
	end,
	reward = function(ply, val)
		local cur_rank = MRS.GetPlyRank(ply, val[1])
		if val[3] == 1 and cur_rank < val[2] then
			MRS.SetPlayerRank(ply, val[1], val[2], true)
		elseif val[3] == 2 then
			MRS.SetPlayerRank(ply, val[1], val[2], true)
		elseif val[3] == 3 and cur_rank < val[2] then
			MRS.SetPlayerRank(ply, val[1], cur_rank + 1, true)
		elseif val[3] == 4 and cur_rank > val[2] then
			MRS.SetPlayerRank(ply, val[1], cur_rank - 1, true)
		end
	end,
}

MQS.Rewards["Arrest Time"] = {
	reward = function(ply, val)
		if not ply:getDarkRPVar("Arrested") then return end
		local time = table.Copy(val)[1]
		if #team.GetPlayers(5) > 0 then time = time * 2 end

		ply:SetDarkRPVar("Arrested", ply:getDarkRPVar("Arrested") - time)

		for k, v in ipairs(player.GetHumans()) do
			if IsValid(v) and v:isCP() then
				v:addMoney(time)
				DarkRP.notify(v, 0, 3, "Вы получили $" .. time .. " за работу заключённых")
			end
		end
	end,
}

MQS.Rewards["Give Inv"] = {
	reward = function(ply, val)
		local gclass = McINV.ttypes[val[2]]
		local ent_data = DarkRP[gclass][val[1]]
		McINV.AddCustomItem(ply, val[2], val[1], ent_data, false)
	end,
}