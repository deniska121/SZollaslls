-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\sh_addonsup.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--   
----------------------------------------------------------------------------------------------------------------
------------------------- Warning! Edit this only if you know what are you doing -------------------------------
----------------------------------------------------------------------------------------------------------------
MCS.AddonList = {}
MCS.ActiveAddons = 0

function MCS.CheckID(id)
	return string.match( id, "^[a-zA-Z0-9_]*$" )
end

function MCS.TableCompress(data)
	local json_data = util.TableToJSON(data, false)
	local compressed_data = util.Compress(json_data)
	local bytes_number = string.len(compressed_data)

	return compressed_data, bytes_number
end

function MCS.TableDecompress(compressed_data)
	local json_data = util.Decompress(compressed_data)
	local data = util.JSONToTable(json_data)

	return data
end

MCS.AddonList["MQS Continue quest"] = {
	["check"] = function() return MQS and true or false end,
	["function"] = nil,
	["function_sv"] = function(ply, npc, data)
		local q = MQS.HasQuest(ply)

		if not q then return end

		if (data and not data.quest_id) and MQS.Quests[q.quest].objects[MQS.GetNWdata(ply, "quest_objective") or 0].type ~= "Talk to NPC" then
			return
		end

		if data and data.quest_id and data.quest_id ~= q.quest then
			return
		end

		MQS.UpdateObjective(ply)
	end,
	["enabled"] = false,
}

MCS.AddonList["MQS Skip to"] = {
	["check"] = function() return MQS and true or false end,
	["function"] = nil,
	["function_sv"] = function(ply, npc, data)
		local q = MQS.HasQuest(ply)

		if not q then return end

		if (data and not data.quest_id) and MQS.Quests[q.quest].objects[MQS.GetNWdata(ply, "quest_objective") or 0].type ~= "Talk to NPC" then
			return
		end

		if data and data.quest_id and data.quest_id ~= q.quest then
			return
		end

		MQS.UpdateObjective(ply, data.id)
	end,
	["add_data"] = {
		id = 1
	},
	["enabled"] = false,
}

MCS.AddonList["MQS Fail quest"] = {
	["check"] = function() return MQS and true or false end,
	["function"] = nil,
	["function_sv"] = function(ply)
		local q = MQS.HasQuest(ply)

		if not q then return end

		if MQS.Quests[q.quest].objects[MQS.GetNWdata(ply, "quest_objective") or 0].type ~= "Talk to NPC" then
			return
		end

		MQS.FailTask(ply, MSD.GetPhrase("m_blew"))
	end,
	["enabled"] = false,
}

MCS.AddonList["MQS Start quest"] = {
	["check"] = function() return MQS and true or false end,
	["function"] = function(npc, data)
		net.Start("MQS.StartTask")
		net.WriteString(data.quest_id)
		net.WriteString(npc:GetUID())
		net.SendToServer()
	end,
	["function_sv"] = nil,
	["enabled"] = false,
	["add_data"] = {
		quest_id = "none"
	},
	["hide"] = true,
}


MCS.AddonList["Loot Npc"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc)
		if not npc.inv or not DarkRP.InRange(ply, npc, 200) then return end
		McINV.Loot(npc, ply, false, true)
	end,
	["enabled"] = true,
}

MCS.AddonList["NYPD Npc"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc)
		if not npc.inv or not DarkRP.InRange(ply, npc, 200) then return end
		local found = 0
		for type,ilist in pairs(npc.inv) do
			for id, item in pairs(ilist) do
				if item.putby == ply:SteamID64() and item.personal then
					found = found + 1
				end
			end
		end

		for i = 1, found do
			for type,ilist in pairs(npc.inv) do
				for id, item in pairs(ilist) do
					if item.putby == ply:SteamID64() and item.personal then
						ply:AddItem(type, item)
						npc:RemoveItem(type, id)
						break
					end
				end
			end
		end
	end,
	["enabled"] = true,
}

MCS.AddonList["Get Unit"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc)
		if not DarkRP.InRange(ply, npc, 100) then return end

		if ply.sunit and ply.sunitkey and IsValid(ply.sunit) and tonumber(ply.sunitkey) then
			McPhone.ToggleGPS(ply, "Юнит", ply.sunit:LocalToWorld(ply.sunit.units[ply.sunitkey]))
			return
		end

		local units = ents.FindByClass("storage_units")
		ply.sunit = units[math.random(#units)]
		ply.sunitkey = math.random(7)

		McPhone.ToggleGPS(ply, "Юнит", ply.sunit:LocalToWorld(ply.sunit.units[ply.sunitkey]))
	end,
	["enabled"] = true,
}

MCS.AddonList["Auto Arrest"] = {
	["function"] = nil,
	["add_data"] = {
		time = 2000,
		reason = "",
	},
	["function_sv"] = function(ply)
		DarkRP.AutoArrest(ply, time, reason)
	end,
	["enabled"] = true,
}

MCS.AddonList["JailPlayer"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		DarkRP.AutoArrest(ply, 1200, "Кажется, вы оплошали")
	end,
	["enabled"] = true,
}

MCS.AddonList["MQS Jail"] = {
	["check"] = function() return MQS and true or false end,
	["function"] = nil,
	["function_sv"] = function(ply)
		local qst = "jail" .. math.random(3)
		if not MQS.CanStartTask(qst, ply) then
			qst = "jail1"
		end
		MQS.StartTask(qst, ply)
	end,
	["enabled"] = false,
}

local care = {
	"care_wash",
	"care_food",
}

local care_sub = {
	["care_food"] = "care_wash",
	["care_wash"] = "care_food",
}

MCS.AddonList["MQS Hobo"] = {
	["check"] = function() return MQS and true or false end,
	["function"] = nil,
	["function_sv"] = function(ply)
		local qst = care[math.random(2)]

		if not MQS.CanStartTask(qst, ply) then
			qst = care_sub[qst]
		end

		if not MQS.CanStartTask(qst, ply) then return end
		MQS.StartTask(qst, ply)
	end,
	["enabled"] = false,
}

MCS.AddonList["Shoot player"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc)
		local q = MQS.HasQuest(ply)

		if not q then return end

		if MQS.Quests[q.quest].objects[MQS.GetNWdata(ply, "quest_objective") or 0].type ~= "Talk to NPC" then
			return
		end

		npc:EmitSound("viper/weapons/m1911/weap_mike1911_fire_last_plr_mech_02.ogg")
		ply:Kill()
	end,
	["enabled"] = true,
}

MCS.AddonList["Damage player"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc)
		local q = MQS.HasQuest(ply)

		if not q then return end

		if MQS.Quests[q.quest].objects[MQS.GetNWdata(ply, "quest_objective") or 0].type ~= "Talk to NPC" then
			return
		end

		npc:EmitSound("ambient/energy/weld1.wav")
		ply:TakeDamage(math.random(5,10))
	end,
	["enabled"] = true,
}

MCS.AddonList["licensgun"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc, data)
	end,
	["enabled"] = true,
}

MCS.AddonList["licensbus"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc, data)
		local q = MQS.HasQuest(ply)

		if not q then return end

		if q.quest ~= "license_gun" or MQS.GetNWdata(ply, "quest_objective") ~= 25 then
			return
		end

		local item = McINV.AddCustomItem(nil, INV_JUNK, "doc", DarkRP.Junk["doc"])
		local pn = string.Explode(" ", ply:FullName())
		item.name = "Лицензия на бизнес"
		item.docid = {
			type = "extra",
			url = "https://cityrp.macnco.one/test/docs/businesslic.json",
			name = pn[1],
			sname = pn[2],
			wep = "",
			gender = ply:getDarkRPVar("gender") == "female" and "ЖЕН." or "МУЖ.",
			id = DarkRP.PassId(ply),
			id2 = ""
		}
		ply:AddItem(INV_JUNK, item)

	end,
	["enabled"] = true,
}

MCS.AddonList["licensenomoney"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc)
		ply:addMoney(-300)
		ply:wanted(nil, "Попытка дачи взятки")
	end,
	["enabled"] = true,
}

MCS.AddonList["licensemoney"] = {
	["function"] = nil,
	["function_sv"] = function(ply, npc)
		ply:addMoney(-300)
	end,
	["enabled"] = true,
}

MCS.AddonList["licensflag"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		if ply.MQSdata.Stored["lflag"] == 1 then return end
		MQS.SetNWStoredData(ply, "lflag", 1)
	end,
	["enabled"] = true,
}

MCS.AddonList["Dezz"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		MCS.CreateDiller(ply)
		ply.HasDillerInfo = CurTime() + 60
	end,
	["enabled"] = true,
}

MCS.AddonList["Dezz_Check"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		if not ply.MQSdata.Stored["dezz"] or ply.MQSdata.Stored["dezz"] ~= 1 then return end
		ply.CheckDezz = CurTime() + 300
		MQS.SetNWStoredData(ply, "dezz", 2)
	end,
	["enabled"] = true,
}

MCS.AddonList["Dezz_Check2"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		if not ply.MQSdata.Stored["dezz"] or ply.MQSdata.Stored["dezz"] ~= 3 then return end
		MQS.SetNWStoredData(ply, "dezz", 4)
	end,
	["enabled"] = true,
}

MCS.AddonList["Omon_give"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		MQS.SetNWStoredData(ply, "omon", 1)
	end,
	["enabled"] = true,
}

MCS.AddonList["ChopShop"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		McCD.ChopShop(ply)
	end,
	["enabled"] = true,
}

MCS.AddonList["DezzSell"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		McINV.SellStuff(ply, true)
	end,
	["enabled"] = true,
}

MCS.AddonList["Police_Check"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		MQS.SetNWStoredData(ply, "police", 1)
	end,
	["enabled"] = true,
}

MCS.AddonList["StartPoliceTest1"] = {
	["function"] = nil,
	["function_sv"] = function(ply)
		MRS.Exam.StartTest(ply, "PDcop")
	end,
	["enabled"] = true,
}

MCS.AddonList["StartPoliceExam"] = {
	["function"] = nil,
	["add_data"] = {
		exam = "none"
	},
	["function_sv"] = function(ply, n, data)
		MRS.Exam.StartTest(ply, data.exam)
	end,
	["enabled"] = true,
}

MCS.AddonList["MQS StoreData"] = {
	["check"] = function() return MQS and true or false end,
	["function"] = nil,
	["function_sv"] = function(ply, npc, data)
		if not data or not data.id or not data.quest_id or not data.info then return end

		local q = MQS.HasQuest(ply)
		if not q or data.quest_id ~= q.quest then return end

		if MQS.Quests[q.quest].objects[MQS.GetNWdata(ply, "quest_objective") or 0].type ~= "Talk to NPC" then
			return
		end

		if string.len(data.id) > 5 or not string.match( data.id, "^[a-zA-Z]+$" ) then return end

		if string.len(data.id) > 5 or not string.match( data.id, "^[a-zA-Z]+$" ) then return end

		data.info = math.Clamp(tonumber(data.info) or 0, 0, 10)

		if data.add then
			local sdata = MQS.GetSData(ply, "mcs." .. data.id, 0)
			data.info = math.Clamp(sdata + data.info, 0, 10)
		end

		if data.info == 0 then data.info = nil end

		MQS.SetNWStoredData(ply, "mcs." .. data.id, data.info)
		MQS.UpdateObjective(ply, data.skipto)
	end,
	["add_data"] = {
		quest_id = "",
		info = 0,
		id = ""
	},
	["enabled"] = false,
}

local function AddonListCheck()
	for id, addon in pairs(MCS.AddonList) do
		if not addon["enabled"] and addon["check"] and addon["check"]() then
			addon["enabled"] = true
			MCS.ActiveAddons = MCS.ActiveAddons + 1
			--print("[MCS] " .. id .. " support enabled!")
		end
	end
end

AddonListCheck()
timer.Create("MCS.AddonCheck", 20, 5, AddonListCheck)