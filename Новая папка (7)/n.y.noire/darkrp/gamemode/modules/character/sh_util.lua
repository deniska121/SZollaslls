--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/character/sh_util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local eyes_var = {
	[1] = "",
	[2] = "models/gmodbest/eyeball_l_blue",
	[3] = "models/gmodbest/eyeball_l_green",
	[4] = "models/gmodbest/eyeball_l_gray",
	[5] = "models/gmodbest/eyeball_l_black",
}

function MCR.CheckName(id)
	if #id > 16 or #id < 3 then return false end
	id = string.match( id, "^[a-zA-Z]*$" )
	return id
end

function MCR.NiceName(strng, src)
	strng = string.lower(strng)

	if src and string.StartWith(strng, "mac") then
		return "Mac" .. string.upper(string.sub(strng, 4, 4)) .. string.sub(strng, 5, #strng)
	end

	if src and string.StartWith(strng, "mc") then
		return "Mc" .. string.upper(string.sub(strng, 3, 3)) .. string.sub(strng, 4, #strng)
	end

	return string.upper(string.sub(strng, 1, 1)) .. string.sub(strng, 2, #strng)
end

function MCR.CanCreateExtraChar(id)
end

function MCR.GetMDL(ent)
	if ent.cmdl and ent.cmdl == ent:GetModel() then
		return ent.cmdlname
	else
		ent.cmdl = ent:GetModel()
		ent.cmdlname = ent.cmdl

		if string.find(ent.cmdl, "male") then
			local model = string.Explode("male_", string.Explode(".mdl", ent.cmdl)[1])[2]
			local female = string.find(ent.cmdl, "female")
			ent.cmdlname = female and "female_" .. model or "male_" .. model
			return ent.cmdlname
		end
	end

	return ent:GetModel()
end

function MCR.PoliceArmmor(ent, remove)
	if string.find( ent:GetModel(), "female" ) then
		ent:SetBodygroup(2, remove and 1 or 2)
	else
		ent:SetBodygroup(3, remove and 1 or 3)
	end
end

function MCR.SetEyeMatID(ent, id)
	if not IsValid(ent) then return end
	id = tonumber(id)
	local modeltable = MCR.GetModelTable(ent)
	if not modeltable then return end

	local eyestr = eyes_var[id]
	if not eyestr then return end

	for k, v in pairs(modeltable["eyes"]) do
		ent:SetSubMaterial(v, eyestr)
	end
end

function MCR.SetSCBA(ply, set)
	if not set then
		ply:SetDarkRPVar("scba", nil)
		ply:SetDarkRPVar("armorVest", nil)
		GAMEMODE:PlayerSetModel(ply, DarkRP.Teams[ply:Team()])
		return
	end

	GAMEMODE:PlayerSetModel(ply, nil, nil, true)

	for k, v in pairs(ply:GetMaterials()) do
		if k <= 4 then continue end
		ply:SetSubMaterial(k - 1, "null")
	end

	ply:SetDarkRPVar("head", nil)
	ply:SetDarkRPVar("vest", nil)
	ply:SetDarkRPVar("face", nil)
	ply:SetDarkRPVar("armorVest", 3)
	ply:SetDarkRPVar("scba", 4)
	ply:SetArmor(20)
	ply:SetBodygroup(1, 6)
	ply:Flashlight(true)
end

function MCR.SetArmor(ent, set, p)
	if not IsValid(ent) then return end

	if string.find(ent:GetModel(), "nypd") then
		local s = ent:GetBodygroup(1) > 1
		if p == 2 then
			ent.comfort = s and 1 or 2
			ent:SetBodygroup(1, s and 0 or 1)
			ent:SetBodygroup(2, s and 1 or 0)
			return
		end
		if p == 3 then
			ent:SetBodygroup(1, s and 0 or 4)
			ent:SetBodygroup(2, s and 1 or 0)
			return
		end
		if s then
			ent.oldset = ent:GetBodygroup(1)
			ent:SetBodygroup(1, 0)
			ent:SetBodygroup(2, 1)
		end
	end

	if not set and ent.oldset then
		ent:SetBodygroup(1, ent.oldset)
	end

	for k, v in pairs(ent:GetBodyGroups())  do
		if v.name == "armor" then
			ent:SetBodygroup(v.id, set and (p and 2 or 1) or 0)
			return
		end
	end
end

function MCR.SetShopID(ent, gen, part, id)
	if part == "tn" then
		part = "shirt"
		local data = MCR.shop[part] and MCR.shop[part][id] and MCR.shop[part][id] or {}
		MCR.SetMatID(ent, gen, "tn", data.id or 1)
		return
	end

	local data = MCR.shop[part] and MCR.shop[part][id] and MCR.shop[part][id] or {}
	MCR.SetMatID(ent, gen, part, data.id or 1)

	if data.f and MCR.shop.bgs[data.f] then
		ent:SetBodygroup(MCR.shop.bgs[data.f][1], MCR.shop.bgs[data.f][2])
	end
end

function MCR.SetMatID(ent, gen, part, id)
	if not IsValid(ent) or not id then return end
	local modeltable = MCR.GetModelTable(ent)
	if not modeltable then return end

	if part == "tn" then
		ent:SetSubMaterial(modeltable["shirt"], id == "clear" and "" or "models/gmodbest/suit/male/tn/suit_sheet" .. id )
		return
	end

	if not modeltable[part] then return end

	if part == "suit" or part == "shirt" or part == "spants" then
		ent:SetSubMaterial(modeltable[part], id == "clear" and "" or (gen == "male" and "models/gmodbest/suit/male/suit_sheet" or "models/gmodbest/suit/female/femsuit") .. id )
		return
	end

	if part == "coat" then
		ent:SetSubMaterial(modeltable[part], id == "clear" and "" or "gbskins/coat/sheet_" .. id )
		return
	end

	if part == "wboots" then
		ent:SetSubMaterial(modeltable[part], id == "clear" and "" or "gbskins/wboots/sheet_" .. id )
		return
	end

	ent:SetSubMaterial(modeltable[part], id == "clear" and "" or "gbskins/outfit/" .. part .. "_" .. id )
end

function MCR.SetMatCustom(ent, part, path)
	if not IsValid(ent) then return end
	local modeltable = MCR.GetModelTable(ent)
	if not modeltable or not modeltable[part] then return end

	ent:SetSubMaterial(modeltable[part], path)
end

function MCR.GetMatCustom(ent, part)
	if not IsValid(ent) then return end
	local modeltable = MCR.GetModelTable(ent)
	if not modeltable or not modeltable[part] then return end
	return ent:GetSubMaterial(modeltable[part])
end

function MCR.SetMatCustomByPathName(ent, part, path)
	if not IsValid(ent) then return end
	for k,v in pairs(ent:GetMaterials()) do
		local pt = string.Explode("/", v)
		if pt[#pt] == part then
			ent:SetSubMaterial(k - 1, path)
			return
		end
	end
end

function MCR.SetMatCustomByName(ent, part, path)
	if not IsValid(ent) then return end
	for k,v in pairs(ent:GetMaterials()) do
		if string.find(v, part) then
			ent:SetSubMaterial(k - 1, path)
			return
		end
	end
end

function MCR.CanEquipCosmetics(ply, part, id)
	if string.find(ply:GetModel(), "nypd") and part == "head" then return false end
	if string.find(ply:GetModel(), "nypd") and part == "vest" then return false end
	if ply:getDarkRPVar("scba") then return false end
	if ply:getDarkRPVar("armorVest") and part == "vest" then return false end
	return true
end

function MCR.GetFaceMax(id)
	if MCR.FaceRawMX[id] then
		return MCR.FaceRawMX[id]
	end
	return 1
end

function MCR.SetFaceMatID(ent, id)
	if not IsValid(ent) then return end
	id = tonumber(id)

	local model = MCR.GetMDL(ent)
	local modeltable = MCR.GetModelTable(ent)
	if not modeltable then return end

	local facestring = ent:GetMaterials()[modeltable["face"] + 1]
	if not facestring then return end

	if id > 1 then
		ent:SetSubMaterial(modeltable["face"], facestring .. id)
	else
		ent:SetSubMaterial(modeltable["face"], "")
	end

	if MCR.ArmsLatin[model] and MCR.ArmsLatin[model][id] then
		MCR.SetMatCustomByName(ent, "arms", "models/gmodbest/citizens/" .. MCR.ArmsLatin[model][id])
	else
		MCR.SetMatCustomByName(ent, "arms", "")
	end
end

local bmodel = {
	female = {
		[3] = true,
		[5] = true
	},
	male = {
		[1] = true,
		[3] = true
	},
}

local lmodel = {
	[4] = {
		[5] = true,
		[6] = true,
		[7] = true,
		[13] = true,
		[17] = true,
		[17] = true,
	},
	[6] = {
		[21] = true,
	},
	[9] = {
		[8] = true,
		[12] = true,
		[15] = true,
	}
}

function MCR.GenerateName(gen, model, face)
	local name = MCR.names[gen].w
	local surname = MCR.names.surnames.bw
	model = tonumber(model) or 1
	face = tonumber(face) or 1

	if bmodel[gen][model] or (gen == "male" and model == 4 and face == 14) then
		name = MCR.names[gen].b
	elseif gen == "male" and lmodel[model] and lmodel[model][face] then
		name = MCR.names[gen].l
		surname = MCR.names.surnames.l
	elseif (gen == "male" and model == 5) or (gen == "female" and model == 4) then
		name = MCR.names[gen].a
		surname = MCR.names.surnames.a
		if gen == "male" and face == 15 then
			name = MCR.names[gen].w
			surname = MCR.names.surnames.bw
		end
	end

	return name[math.random(#name)], surname[math.random(#surname)]
end

function MCR.GetTatoos(ply)
	local t = ply:getDarkRPVar("tatoo")

	if not t then return nil end

	if not ply.c_tatoo or t ~= ply.c_tatoo then
		ply.c_tatoo = t
		ply.tatoo = {}
		for k,v in ipairs(string.Explode(";", t)) do
			if not MCR.Tatoo[v] then continue end
			ply.tatoo[v] = true
		end
	end

	return ply.tatoo
end

function MCR.GetMedals(ply)
	local t = ply:getDarkRPVar("medals")
	if not t then return nil end

	if not ply.c_medals or t ~= ply.c_medals then
		ply.c_medals = t
		ply.medals = {}
		for k,v in ipairs(string.Explode(";", t)) do
			ply.medals[v] = true
		end
	end

	return ply.medals
end

function MCR.HasTatoo(ply, name)
	local t = MCR.GetTatoos(ply)

	if not t or not t[name] then return false end

	return true
end

function MCR.HasMdela(ply, name)
	local t = MCR.GetMedals(ply)

	if not t or not t[name] then return false end

	return true
end

function MCR.GetSkillPoints(ply)
	return ply:getDarkRPVar("skillpoint") or 0
end

function MCR.GetModelTable(ent)
	if MCR.SkinsID[ent:GetModel()] then
		return MCR.SkinsID[ent:GetModel()]
	end

	local tbl = {}
	local female = string.find(ent:GetModel(), "female")

	for k, v in pairs(ent:GetMaterials()) do
		local id = k - 1

		if string.find(v, "eyeball_l") then
			if not tbl["eyes"] then tbl["eyes"] = {} end
			tbl["eyes"][1] = id
			continue
		end

		if string.find(v, "eyeball_r") then
			if not tbl["eyes"] then tbl["eyes"] = {} end
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

		if string.find(v, "sheet_1") then
			tbl["top"] = id
			continue
		end

		if string.find(v, "sheet_2") then
			tbl["pants"] = id
			continue
		end

		if string.find(v, "sheet_3") then
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

		if string.find(v, female and "wintercoat1" or "wintercoat") then
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

	MCR.SkinsID[ent:GetModel()] = tbl

	return MCR.SkinsID[ent:GetModel()]
end

function MCR.ApplySkinData(ply, char)
	ply:SetModel("models/cityrp/pm/" .. (char.suit.insuit and "suit" or "normal") .. "/" .. char.gender .. "_0" .. char.model .. ".mdl")

	if char.suit.insuit then
		MCR.SetShopID(ply, char.gender, "suit", char.suit["suit"] or 1)
		MCR.SetShopID(ply, char.gender, "spants", char.suit["spants"] or 1)

		if isbool(char.suit.insuit) then char.suit.insuit = 1 end

		if char.suit.insuit > 4 then
			MCR.SetShopID(ply, char.gender, "tn", char.suit["shirt"] or 1)
		else
			MCR.SetShopID(ply, char.gender, "shirt", char.suit["shirt"] or 1)
		end

		if char.gender == "male" then
			ply:SetBodygroup(1, char.suit.insuit - 1 or 0)
		else
			ply:SetBodygroup(2, math.Clamp(char.suit.insuit - 1 or 0, 0, 1))
		end
	else
		MCR.SetShopID(ply, char.gender, "top", char.suit["top"])
		MCR.SetShopID(ply, char.gender, "pants", char.suit["pants"])
		MCR.SetShopID(ply, char.gender, "boots", char.suit["boots"])
	end

	if char.gender == "female" then
		if char.suit["wboots"] or char.suit["coat"] then
			MCR.SetShopID(ply, char.gender, "wboots", char.suit["wboots"] or 1)
			MCR.SetShopID(ply, char.gender, "coat", char.suit["coat"] or 1)
			ply:SetBodygroup(2, 1)
		else
			ply:SetBodygroup(2, 0)
		end
	end
end