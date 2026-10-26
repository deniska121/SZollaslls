--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/a_config_gmodla/lua/city_extentions/cl_commands.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

concommand.Add("get_cam", function(ply)
	if not ply:IsAdmin() then return end
	local pos = ply:EyePos()
	local ang = ply:GetAngles()
	SetClipboardText("Territory.signPos = Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ")\nTerritory.signAngles = Angle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ")")
	print("Territory.signPos = Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ")\nTerritory.signAngles = Angle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ")")
end)

concommand.Add("get_pos", function(ply)
	if not ply:IsAdmin() then return end
	local pos = ply:GetPos()
	local ang = ply:GetAngles()
	SetClipboardText("Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ")\nAngle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ")")
	print("Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ")\nAngle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ")")
end)

concommand.Add("get_posv", function(ply)
	if not ply:IsAdmin() then return end
	local pos = ply:GetPos()
	SetClipboardText("Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. "),")
	print("Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. "),")
end)

concommand.Add("get_ent", function(ply)
	if not ply:IsAdmin() then return end
	local ent = ply:GetEyeTrace().Entity
	if not IsValid(ent) then return end
	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	print(ent)
	SetClipboardText("mailbox = {\n		Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. "),\n		Angle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ")\n	}")
	print("Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. ")\nAngle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ")")
	print(ent:GetModel())
end)

concommand.Add("get_group", function(ply)
	if not ply:IsAdmin() then return end

	for k, ent in ipairs(ents.FindInSphere(ply:GetEyeTrace().HitPos, 50)) do
		if not IsValid(ent) then continue end
		debugoverlay.EntityTextAtPosition(ent:GetPos(), k, ent:MapCreationID() .. " | " .. ent:GetClass(), 15)
	end
end)

concommand.Add("get_ent_mapid", function(ply)
	if not ply:IsAdmin() then return end
	local ent = ply:GetEyeTrace().Entity
	if not IsValid(ent) then return end
	print(ent:MapCreationID())
	SetClipboardText(ent:MapCreationID())
end)

concommand.Add("get_ent2", function(ply)
	if not ply:IsAdmin() then return end
	local ent = ply:GetEyeTrace().Entity
	if not IsValid(ent) then return end
	local pos = ent:GetPos()
	local ang = ent:GetAngles()
	SetClipboardText("{ ent = '" .. ent:GetClass() .. "', pos = Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. "), ang = Angle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ") },")
	print("{ ent = '" .. ent:GetClass() .. "', pos = Vector(" .. pos.x .. "," .. pos.y .. "," .. pos.z .. "), ang = Angle(" .. ang.p .. "," .. ang.y .. "," .. ang.r .. ") },")
	print(ent:GetModel())
end)

concommand.Add("get_ent_trace_pos2", function(ply)
	if not ply:IsAdmin() then return end
	local ent = ply:GetEyeTrace().Entity
	local hit = ply:GetEyeTrace().HitPos
	if not IsValid(ent) then return end
	local printpos = ent:WorldToLocal(hit)
	SetClipboardText("Vector(" .. math.Round(printpos.x, 2) .. "," .. math.Round(printpos.y, 2) .. "," .. math.Round(printpos.z, 2) .. ")")
	print("Vector(" .. math.Round(printpos.x, 2) .. "," .. math.Round(printpos.y, 2) .. "," .. math.Round(printpos.z, 2) .. ")")
end)

concommand.Add("print_inv", function(ply)
	if not ply:IsAdmin() then return end
	PrintTable(McINV.inv)
	SetClipboardText(table.ToString(McINV.inv.weapon, "wp", true))
end)

concommand.Add("get_anim", function(ply)
	if not ply:IsAdmin() then return end
	local v = ply:GetEyeTrace().Entity
	if not IsValid(v) then return end

	local item = {
		mdl = v:GetModel(),
		anm = v:GetSequenceName(v:GetSequence()),
		pos = v:GetPos(),
		ang = v:GetAngles(),
		col = v:GetColor(),
		skin = v:GetSkin(),
		mat = v:GetMaterial(),
		smt = {},
		bgr = {}
	}

	for _, b in pairs(v:GetBodyGroups()) do
		item.bgr[b.id] = v:GetBodygroup(b.id)
	end

	for i, s in pairs(v:GetMaterials()) do
		local cm = v:GetSubMaterial(i - 1)

		if cm and cm ~= "" then
			item.smt[i - 1] = cm
		end
	end

	print(table.ToString(item, nil))
	SetClipboardText(table.ToString(item, nil, true))
end)

concommand.Add("get_anim_p", function(ply)
	if not ply:IsAdmin() then return end
	local v = ply:GetEyeTrace().Entity
	if not IsValid(v) then return end

	local item = {
		mdl = v:GetModel(),
		pos = v:GetPos(),
		ang = v:GetAngles(),
	}

	print(table.ToString(item, nil))
	SetClipboardText(table.ToString(item, nil, true))
end)

concommand.Add("print_suit_table2", function(ply)
	if not ply:IsAdmin() then return end
	--local ent = ply:GetEyeTrace().Entity
	local pms = {}

	for _, ent in pairs(ents.FindByClass("prop_ragdoll")) do
		if not ent then return end

		local tbl = {
			["eyes"] = {0, 1},
			["face"] = 0,
		}

		-- ["armor"] = {
		-- 	["bd_id"] = 3,
		-- 	["non"] = 0,
		-- 	["light"] = 1,
		-- 	["police"] = 2,
		-- }
		for k, v in pairs(ent:GetMaterials()) do
			local id = k - 1

			if string.find(v, "eyeball_l") then
				tbl["eyes"][1] = id
				continue
			end

			if string.find(v, "eyeball_r") then
				tbl["eyes"][2] = id
				continue
			end

			if string.find(v, "facemap") then
				tbl["face"] = id
				continue
			end

			if string.find(v, "top_1") then
				tbl["top"] = id
				continue
			end

			if string.find(v, "pants_1") then
				tbl["pants"] = id
				continue
			end

			if string.find(v, "boots_1") then
				tbl["boots"] = id
				continue
			end

			if string.find(v, "group03/citizen_sheet") then
				tbl["milpants"] = id
				continue
			end

			if string.find(v, "workerboots1") then
				tbl["wboots"] = id
				continue
			end

			if string.find(v, "wintercoat") then
				tbl["coat"] = id
				continue
			end

			if string.find(v, "femsuit1") then
				tbl["suit"] = id
				continue
			end

			if string.find(v, "femsuit2") then
				tbl["shirt"] = id
				continue
			end

			if string.find(v, "femsuit3") then
				tbl["spants"] = id
				continue
			end

			if string.find(v, "suit_sheet1") then
				tbl["suit"] = id
				continue
			end

			if string.find(v, "suit_sheet2") then
				tbl["shirt"] = id
				continue
			end

			if string.find(v, "suit_sheet3") then
				tbl["spants"] = id
				continue
			end
		end

		-- for k, v in pairs(ent:GetBodyGroups())  do
		-- 	if v.name == "torso" then
		-- 		if not tbl["bgs"] then tbl["bgs"] = {} end
		-- 		tbl["bgs"]["torso"] = {}
		-- 		tbl["bgs"]["torso"]["id"] = v.id

		-- 		for i, s in pairs(v.submodels) do
		-- 			if string.find(s, "_top") then
		-- 				tbl["bgs"]["torso"]["top"] = i
		-- 			end
		-- 			if string.find(s, "_polo") then
		-- 				tbl["bgs"]["torso"]["polo"] = i
		-- 			end
		-- 			if string.find(s, "_coat") then
		-- 				tbl["bgs"]["torso"]["coat"] = i
		-- 			end
		-- 			if string.find(s, "_jacket") then
		-- 				tbl["bgs"]["torso"]["jacket"] = i
		-- 			end
		-- 		end
		-- 	end

		-- 	if v.name == "legs" then
		-- 		if not tbl["bgs"] then tbl["bgs"] = {} end
		-- 		tbl["bgs"]["legs"] = v.id
		-- 	end
		-- end

		pms["[\"" .. ent:GetModel() .. "\"]"] = tbl
	end
	table.SortDesc(pms)
	local t = table.ToString(pms, "mdls", true)
	print(t)
	SetClipboardText(t .. ",")
end)