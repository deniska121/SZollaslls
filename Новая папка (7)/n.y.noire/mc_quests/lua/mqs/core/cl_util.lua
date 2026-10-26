--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_quests/lua/mqs/core/cl_util.lua
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
local scrx, scry = ScrW(), ScrH()
local center_gradient = Material("gui/center_gradient.vtf", "smooth")

function MQS.PreCheckQuest(quest, PopupMenu)
	local errorlist
	local alertlist
	MsgC(Color(0, 0, 255), "Quest check start\n")

	local function AddError(error)
		if not errorlist then
			errorlist = {}
		end

		table.insert(errorlist, error)
	end

	local function AddAllert(alert)
		if not alertlist then
			alertlist = {}
		end

		table.insert(alertlist, alert)
	end

	if quest.desc == "" or quest.desc == " " then
		AddAllert("You miss quest description")
	end

	if quest.success == "" or quest.success == " " then
		AddAllert("You miss quest complete message")
	end

	if #quest.objects < 2 then
		AddAllert("Ain't it too short of a quest?")
	end

	-- Check for valid objectives order
	local pre_object
	local car_valid = false

	for id, object in pairs(quest.objects) do
		if object.events then
			for id_e, event in pairs(object.events) do
				if event[1] == "Spawn vehicle" then
					car_valid = true
				end
			end
		end

		if object.events then
			for id_e, event in pairs(object.events) do
				if event[1] == "Remove vehicle" then
					if not car_valid then
						AddError("There is no vehicle to remove by 'Remove vehicle' event. Objective id: " .. id)
						continue
					end

					car_valid = false
				end
			end
		end

		if object.type == "Collect quest ents" then
			if pre_object and pre_object == object.type then
				AddError("You have 'Collect quest ents' objectives starting one after another, this may break your quest. Objective id: " .. id)
			end

			local found = false

			if object.events then
				for id_e, event in pairs(object.events) do
					if event[1] == "Spawn quest entity" then
						found = true
						break
					end
				end
			end

			if not found then
				AddError("'Collect quest ents' objectives has no 'Spawn quest entity' event, this will break your quest. Objective id: " .. id)
			end
		end

		if object.type == "Kill NPC" then
			local found = false

			if object.events then
				for id_e, event in pairs(object.events) do
					if event[1] == "Spawn npc" and event[2][4] then
						found = true
						break
					end
				end
			end

			if not found then
				AddError("'Kill NPC' has no target NPC. You need to create a target NPC. Objective id: " .. id)
			end
		end

		pre_object = object.type
	end

	if errorlist then
		MsgC(Color(255, 0, 0), "Errors:\n")
		PrintTable(errorlist)
	end

	if alertlist then
		MsgC(Color(255, 187, 0), "Alerts:\n")
		PrintTable(alertlist)
	end

	if not errorlist and not alertlist then
		MsgC(Color(0, 255, 0), "No error found!\n")
	end

	if PopupMenu then
		local sub_list = PopupMenu("Quest troubleshoot", 1.2, 1.5, 50)

		if errorlist then
			for k, v in ipairs(errorlist) do
				MSD.ButtonIcon(sub_list, "static", nil, 1, 50, v, MSD.Icons48.alert, nil, nil, Color(255, 0, 0))
			end
		end

		if alertlist then
			for k, v in ipairs(alertlist) do
				MSD.ButtonIcon(sub_list, "static", nil, 1, 50, v, MSD.Icons48.alert, nil, nil, Color(255, 187, 0))
			end
		end

		if not errorlist and not alertlist then
			MSD.ButtonIcon(sub_list, "static", nil, 1, 50, "No error found!", MSD.Icons48.submit, nil, nil, Color(0, 255, 0))
		end
	end
end

function MQS.QuestSubmit(quest)
	local cd, bn = MQS.TableCompress(quest)

	net.Start("MQS.QuestSubmit")
		net.WriteInt(bn, 32)
		net.WriteData(cd, bn)
	net.SendToServer()
end

MQS.PreviewTable = MQS.PreviewTable or {}

MQS.PreviewConfig = {
	ShowColors = true,
	ShowMaterials = true,
	Transparent = true,
}

local previe_events = {
	["Spawn quest entity"] = function(data, id, eid)
		local ent = ClientsideModel(data[1], RENDERGROUP_OPAQUE)
		table.insert(MQS.PreviewTable, ent)
		ent.class = "Quest Entity"
		ent.obj = id
		ent.eid = eid
		ent:SetPos(data[2])
		if data[5] then
			ent:SetAngles(data[5])
		end

		if data[6] and MQS.PreviewConfig.ShowMaterials then
			ent:SetMaterial(data[6])
		end
		ent:SetRenderMode( RENDERMODE_TRANSCOLOR )

		if data[7] then
			local cl = table.Copy(data[7])
			if MQS.PreviewConfig.Transparent then cl.a = 100 end
			ent:SetColor(data[7])
		else
			if MQS.PreviewConfig.Transparent then ent:SetColor(Color(255,255,255,100)) end
		end
	end,
	["Spawn entity"] =  function(data, id, eid)
		local ent = ClientsideModel(data[4] or "models/editor/node_hint.mdl", RENDERGROUP_OPAQUE)
		ent.class = data[1]
		table.insert(MQS.PreviewTable, ent)
		ent.obj = id
		ent.eid = eid
		ent:SetPos(data[2])
		ent:SetAngles(data[3])

		if data[4] then
			ent:SetModel(data[4])
		end

		if data[6] and MQS.PreviewConfig.ShowMaterials then
			ent:SetMaterial(data[6])
		end
		ent:SetRenderMode( RENDERMODE_TRANSCOLOR )

		if data[7] then
			local cl = table.Copy(data[7])
			if MQS.PreviewConfig.Transparent then cl.a = 100 end
			ent:SetColor(data[7])
		else
			if MQS.PreviewConfig.Transparent then ent:SetColor(Color(255,0,0,100)) end
		end
	end,
	["Spawn vehicle"] =  function(data, id, eid)
		local ent = ClientsideModel("models/props/de_nuke/car_nuke_red.mdl", RENDERGROUP_OPAQUE)
		ent.class = data[1]
		table.insert(MQS.PreviewTable, ent)
		ent.obj = id
		ent.eid = eid
		ent:SetPos(data[3])
		ent:SetAngles(data[4])
		if data[7] then
			ent:SetColor(data[7])
		end
		--ent:SetMaterial("models/cs_italy/light_orange")

		if data[2] == "simfphys" then
			local vehicle = list.Get("simfphys_vehicles")[data[1]]

			if vehicle then
				ent:SetModel(vehicle.Model)
			end
		end
	end,
	["Spawn npc"] =  function(data, id, eid)
		local ent = ClientsideModel("models/editor/playerstart.mdl", RENDERGROUP_OPAQUE)
		ent.class = data[1]
		table.insert(MQS.PreviewTable, ent)
		ent.obj = id
		ent.eid = eid
		ent:SetPos(data[2])
		ent:SetAngles(data[3])

		if data[5] then
			ent:SetModel(data[5])
		end
	end,
	["Teleport player"] =  function(data, id, eid)
		local ent = ClientsideModel("models/editor/playerstart.mdl", RENDERGROUP_OPAQUE)
		ent.class = "PLAYER TELEPORT"
		table.insert(MQS.PreviewTable, ent)
		ent.obj = id
		ent.eid = eid
		ent:SetPos(data[1])
		ent:SetAngles(data[2])
		ent:SetMaterial("phoenix_storms/wire/pcb_blue")
	end,
	["[MCS] Spawn npc"] =  function(data, id, eid)
		local ent = ClientsideModel("models/editor/playerstart.mdl", RENDERGROUP_OPAQUE)
		ent.class = "[MCS]" .. data[1]
		table.insert(MQS.PreviewTable, ent)
		ent.obj = id
		ent.eid = eid
		ent:SetPos(data[2] or Vector())
		ent:SetAngles(data[3] or Angle())

		ent:SetMaterial("models/cs_italy/light_orange")
	end,
}

local previe_objective = {
	["Wait time"] = function(obj, id)
		local pos = obj.point
		local screenpos = pos:ToScreen()
		local x, y = screenpos.x, screenpos.y

		local icon = MSD.ObjeciveList[obj.type] and MSD.ObjeciveList[obj.type].icon
		MSD.DrawTexturedRect(x - 24, y - 24, 48, 48, icon or MSD.PinPoints[0],  MSD.ColorAlpha(color_white, 100))
		draw.SimpleTextOutlined("Wait time ID" .. id, "MSDFont.25", x, y + 35, MSD.ColorAlpha(color_white, 100), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, 100))
	end,
	["Collect quest ents"] = function(obj, id)
		local pos = obj.point
		local screenpos = pos:ToScreen()
		local x, y = screenpos.x, screenpos.y

		local icon = MSD.ObjeciveList[obj.type] and MSD.ObjeciveList[obj.type].icon
		MSD.DrawTexturedRect(x - 24, y - 24, 48, 48, icon or MSD.PinPoints[0],  MSD.ColorAlpha(color_white, 100))
		draw.SimpleTextOutlined("Collect quest ents ID" .. id, "MSDFont.25", x, y + 35, MSD.ColorAlpha(color_white, 100), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, 100))
	end,
	["Leave area"] = function(obj, id)
		local pos = obj.point
		local screenpos = pos:ToScreen()
		local x, y = screenpos.x, screenpos.y

		local icon = MSD.ObjeciveList[obj.type] and MSD.ObjeciveList[obj.type].icon
		MSD.DrawTexturedRect(x - 24, y - 24, 48, 48, icon or MSD.PinPoints[0],  MSD.ColorAlpha(color_white, 100))
		draw.SimpleTextOutlined("Leave area ID" .. id, "MSDFont.25", x, y + 35, MSD.ColorAlpha(color_white, 100), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, 100))
	end,
	["Move to point"] = function(obj, id)
		local pos = obj.point
		local screenpos = pos:ToScreen()
		local x, y = screenpos.x, screenpos.y

		local icon = MSD.ObjeciveList[obj.type] and MSD.ObjeciveList[obj.type].icon
		MSD.DrawTexturedRect(x - 24, y - 24, 48, 48, icon or MSD.PinPoints[0],  MSD.ColorAlpha(color_white, 100))
		draw.SimpleTextOutlined("Move to point ID" .. id, "MSDFont.25", x, y + 35, MSD.ColorAlpha(color_white, 100), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, 100))
	end,
	["Move to any point"] = function(obj, id)
		for _,v in pairs(obj.points) do
			local pos = v.point
			local screenpos = pos:ToScreen()
			local x, y = screenpos.x, screenpos.y

			local icon = MSD.ObjeciveList[obj.type] and MSD.ObjeciveList[obj.type].icon
			MSD.DrawTexturedRect(x - 24, y - 24, 48, 48, icon or MSD.PinPoints[0],  MSD.ColorAlpha(color_white, 100))
			draw.SimpleTextOutlined("Move to any point ID" .. id, "MSDFont.25", x, y + 35, MSD.ColorAlpha(color_white, 100), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, 100))
		end
	end,
}

local color_load = Color(38,129,233)
local color_prev = Color(231,219,47)
local oict = {}

function MQS.PreviewFilter(id)
	if not MQS.PreviewLoaded then return end

	for _,ent in pairs(MQS.PreviewTable) do
		if not IsValid(ent) then continue end
		if not id then
			ent:SetNoDraw(false)
			continue
		end

		ent:SetNoDraw(ent.obj ~= id)
	end
end

function MQS.LoadPreview(quest)
	if MQS.PreviewLoaded then
		MQS.PreviewLoaded = false
		MQS.PredrawZones = nil
		for k,v in pairs(MQS.PreviewTable) do
			if not IsValid(v) then continue end
			SafeRemoveEntity(v)
		end

		function MQS.PreviewHUD() end
		return
	end

	if MQS.PreviewLoaded or MQS.PreviewLoading then return end

	MQS.PreviewLoading = true

	local total = #quest.objects
	local preload = 0

	function MQS.PreviewHUD()
		surface.SetDrawColor(0, 0, 0, 170)
		surface.SetMaterial(center_gradient)
		surface.DrawTexturedRectRotated(scrx / 2, scry / 8, 250, scrx + 200, -90)
		draw.SimpleTextOutlined("Loading preview... " .. math.Round((preload / total) * 100) .. "%", "MSDFont.Biger", scrx / 2, scry / 8 - 50, color_load, TEXT_ALIGN_CENTER, 0, 1, color_black)
	end

	local addtime = 0

	MQS.PredrawZones = {}

	for id = 1, total - 1 do
		preload = preload + 1
		local object = quest.objects[id]

		if not object then continue end

		if object.points then
			for _,v in pairs(object.points) do
				table.insert(MQS.PredrawZones, {pos = v.point, rad = v.dist or v.stay_inarea or 350})
			end
		end

		if object.point then
			table.insert(MQS.PredrawZones, {pos = object.point, rad = object.dist or object.stay_inarea or 350})
		end

		if not object.events then continue end

		timer.Simple(addtime, function()
			for id_e, event in pairs(object.events) do
				if previe_events[event[1]] then previe_events[event[1]](event[2], id, id_e) end
			end
		end)


		for id_e, event in pairs(object.events) do
			if previe_events[event[1]] then
				addtime = addtime + 0.001
			end
		end
	end

	timer.Simple(addtime + 0.1, function()
		MQS.PreviewLoading = nil
		MQS.PreviewLoaded = true
		function MQS.PreviewHUD()
			surface.SetDrawColor(0, 0, 0, 170)
			surface.SetMaterial(center_gradient)
			surface.DrawTexturedRectRotated(scrx / 2, 0, 250, scrx + 200, -90)
			draw.SimpleTextOutlined("Quest preview in progress", "MSDFont.32", scrx / 2, 0, color_prev, TEXT_ALIGN_CENTER, 0, 1, color_black)

			for _,ent in pairs(ents.FindInSphere(LocalPlayer():GetPos(), 200)) do
				if not IsValid(ent) or not ent.obj or ent:GetNoDraw() then continue end
				if not oict[ent.obj] then
					oict[ent.obj] = HSVToColor(ent.obj + 10, 1, 1)
				end
				local s = ent:GetPos():ToScreen()
				draw.SimpleTextOutlined("[" .. ent.obj .. "] [" .. ent.eid .. "] " .. ent.class, "Default", s.x, s.y, oict[ent.obj], TEXT_ALIGN_CENTER, 0, 1, color_black)
			end

			for k,object in pairs(quest.objects) do
				if previe_objective[object.type] then
					previe_objective[object.type](object, k)
				end
			end
		end

		local id = total
		local object = quest.objects[id]
		if not object.events then return end

		for id_e, event in pairs(object.events) do
			if previe_events[event[1]] then previe_events[event[1]](event[2], id, id_e) end
		end
	end)
end