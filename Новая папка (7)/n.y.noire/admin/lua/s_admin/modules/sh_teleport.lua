--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/modules/sh_teleport.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local lastPos = {}

local function tpTo(caller, ply, dest_ply)
	local pos
	local og_pos = dest_ply:GetPos()
	local isNoclipped = ply:GetMoveType() == MOVETYPE_NOCLIP

	for i = 0, 360, 3 do
		local rad = math.rad(i)
		local dir = Vector(math.cos(rad), math.sin(rad), 0)
		local newpos = og_pos + dir * 80
		local detected = false

		for k, v in ipairs(ents.FindInSphere(newpos, 5)) do
			if not v:IsWeapon() and not isNoclipped then continue end
			detected = true
		end

		if util.IsInWorld(newpos) and not detected or isNoclipped then
			pos = newpos
			break
		end
	end

	if not pos then
		if caller then
			sAdmin.msg(caller, "no_valid_pos")
		end

		return
	end

	lastPos[ply] = ply:GetPos()

	if ply:InVehicle() then
		ply:ExitVehicle()
	end

	ply:SetPos(pos)
end

local function zapEffect(target)
	local effectdata = EffectData()
	effectdata:SetStart(target:GetShootPos())
	effectdata:SetOrigin(target:GetShootPos())
	effectdata:SetScale(1)
	effectdata:SetMagnitude(1)
	effectdata:SetScale(3)
	effectdata:SetRadius(1)
	effectdata:SetEntity(target)

	for i = 1, 100 do
		timer.Simple(1 / i, function()
			util.Effect("TeslaHitBoxes", effectdata, true, true)
		end)
	end

	local Zap = math.random(1, 9)

	if Zap == 4 then
		Zap = 3
	end

	target:EmitSound("ambient/energy/zap" .. Zap .. ".wav")
end

sAdmin.addCommand({
	name = "goto",
	category = "Teleport",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("goto", ply, args[1], 1)

		for k, v in ipairs(targets) do
			if v == ply then
				sAdmin.msg(ply, "cant_target_self")
				table.remove(targets, k)
				continue
			end

			tpTo(ply, ply, v)

			if args[2] then
				zapEffect(ply)
			end

			return
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "goto_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "gotocar",
	category = "Teleport",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("goto", ply, args[1], 1)

		for k, v in ipairs(targets) do
			if not IsValid(v.PersVeh) then
				sAdmin.msg(ply, "У игрока нет машины")
				continue
			end

			tpTo(ply, ply, v.PersVeh)
			sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s переместился к машине %s.", ply, v)

			return
		end
	end
})

sAdmin.addCommand({
	name = "gotobody",
	category = "Teleport",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("goto", ply, args[1], 1)

		for k, v in ipairs(targets) do
			if not IsValid(v.DeathRagdoll) then
				sAdmin.msg(ply, "Цель не найдена")
				continue
			end

			tpTo(ply, ply, v.DeathRagdoll)
			sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s переместился к телу %s.", ply, v)

			return
		end
	end
})

sAdmin.addCommand({
	name = "bring",
	category = "Teleport",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("bring", ply, args[1])
		local unavailableplys, toRemove = {}, {}

		for k, v in ipairs(targets) do
			if v == ply then
				sAdmin.msg(ply, "cant_target_self")
				table.insert(toRemove, k)
				continue
			end

			if v.physFrozen or v:IsFrozen() or sAdmin.jailData[v:SteamID64()] then
				table.insert(unavailableplys, v)
				table.insert(toRemove, k)
				continue
			end

			tpTo(ply, v, ply)
			break
		end

		for k, v in ipairs(toRemove) do
			targets[v] = nil
		end

		local clearTbl = {}

		for k, v in SortedPairs(targets) do
			table.insert(clearTbl, v)
		end

		targets = clearTbl
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "bring_response", ply, targets)
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "unavailable_plys", unavailableplys)
	end
})

sAdmin.addCommand({
	name = "tp",
	category = "Teleport",
	inputs = {
		{"player", "player_name"},
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local target_ply = sAdmin.getTargets("tp", ply, args[1], 1, true)
		local dest_ply = sAdmin.getTargets("tp", ply, args[2], 1, true)

		if target_ply[1] == dest_ply[1] then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		if target_ply[1] and dest_ply[1] then
			tpTo(ply, target_ply[1], dest_ply[1])
		else
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "tp_response", ply, target_ply[1], dest_ply[1])
	end
})

sAdmin.addCommand({
	name = "teleport",
	category = "Teleport",
	func = function(ply, args, silent)
		if not ply:Alive() then return end
		local t = {}
		t.start = ply:GetPos() + Vector(0, 0, 32) -- Move them up a bit so they can travel across the ground
		t.endpos = ply:GetPos() + ply:EyeAngles():Forward() * 16384
		t.filter = ply
		local tr = util.TraceEntity(t, ply)
		local pos = tr.HitPos
		if ply == calling_ply and pos:Distance(ply:GetPos()) < 64 then return end -- Laughable distance
		lastPos[ply] = ply:GetPos()

		if ply:InVehicle() then
			ply:ExitVehicle()
		end

		ply:SetPos(pos)
		ply:SetLocalVelocity(Vector(0, 0, 0)) -- Stop!

		if not silent then
			sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s телепортировался", ply)
		end
	end
})

sAdmin.addCommand({
	name = "return",
	category = "Teleport",
	inputs = {
		{"player", "player_name"}
	},
	func = function(ply, args, silent)
		local targets = sAdmin.getTargets("return", ply, args[1], nil, true)

		for k, v in ipairs(targets) do
			local pos = lastPos[v]

			if not pos then
				sAdmin.msg(ply, "no_valid_return_pos")

				return
			end

			v:SetPos(pos)
		end

		sAdmin.msg(silent and ply or sAdmin.logPerm(), "return_response", ply, targets)
	end
})

sAdmin.addCommand({
	name = "enttp",
	category = "Teleport",
	inputs = {
		{"numeric", "id"}
	},
	func = function(ply, args, silent)
		local ent = tonumber(args[1])

		if not ent or not IsValid(ents.GetByIndex(ent)) then
			sAdmin.msg(ply, "invalid_arguments")

			return
		end

		ents.GetByIndex(ent):SetPos(ply:GetPos())
		sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s телепортировал предмет, ID: %s", ply, ent)
	end
})

sAdmin.addCommand({
	name = "tptm",
	inputs = {
		{"numeric", "x"},
		{"numeric", "y"}
	},
	category = "Teleport",
	func = function(ply, args, silent)
		if not ply:Alive() then return end
		if ply:InVehicle() then return end
		if ply:GetMoveType() ~= MOVETYPE_NOCLIP then return end
		print(args[1], args[2])
		ply:SetPos(Vector(tonumber(args[1] or 0), tonumber(args[2] or 0), 0))
		ply:SetLocalVelocity(Vector(0, 0, 0)) -- Stop!

		if not silent then
			sAdmin.msg(silent and ply or sAdmin.logPerm(), "%s телепортировался", ply)
		end
	end
})