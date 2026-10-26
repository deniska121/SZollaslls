--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/inventory/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

INV_WEAPON = "weapon"
INV_ENTITY = "entity"
INV_AMMO = "ammo"
INV_FOOD = "food"
INV_JUNK = "junk"

McINV.pickups = {
	["spawned_food"] = "food",
	["spawned_weapon"] = "weapon",
	["spawned_ammo"] = "ammo",
	["spawned_junk"] = "junk",
}

McINV.picktime = {}
McINV.drugStock = {}

McINV.picktime_class = {
	["mwb_357"] = 3,
	["mwb_deagle"] = 4,
	["mwb_m1911"] = 3,
	["mwb_sw4506"] = 3,
	["mwb_pm"] = 2.1,
	["mwb_m9"] = 3,
	["mwb_93r"] = 3,
	["mwb_glock21"] = 3.2,
	["mwb_glock17"] = 2.5,
	["mwb_glock19"] = 2.5,
	["mwb_p220"] = 2.6,
	["mwb_akm"] = 6,
	["mwb_ak74"] = 6,
	["mwb_ak74u"] = 6,
	["mwb_spapa12"] = 5,
	["mwb_m590"] = 6,
	["mwb_ithaca"] = 6,
	["mwb_mk17"] = 5,
	["mwb_marlin"] = 6,
	["mwb_kar98"] = 7,
	["mwb_c725"] = 7,
	["mwb_mp5"] = 6,
	["mwb_m4"] = 6,
	["mwb_m4a1"] = 6,
	["mwb_uzi"] = 5,
	["mwb_thompson"] = 5,
	["mwb_tec9"] = 3.2,
	["mwb_mac10"] = 4,
	["mwb_aug"] = 7,
	["mwb_auga2"] = 7,
}

McINV.gtypes = {
	["spawned_food"] = "Food",
	["spawned_weapon"] = "Weapons",
	["spawned_ammo"] = "Ammo",
	["spawned_junk"] = "Junk",
}

McINV.ttypes = {
	["weapon"] = "Weapons",
	["entity"] = "Entities",
	["ammo"] = "Ammo",
	["food"] = "Food",
	["junk"] = "Junk"
}

McINV.DarkRPTypes = {
	["Food"] = INV_FOOD,
	["Weapons"] = INV_WEAPON,
	["Entities"] = INV_ENTITY,
	["Junk"] = INV_JUNK,
	["Ammo"] = INV_AMMO
}

McINV.Shipments = {
	"models/props_junk/cardboard_box001a.mdl",
	"models/props_junk/cardboard_box001b.mdl",
	"models/props_junk/cardboard_box002a.mdl",
	"models/props_junk/cardboard_box002b.mdl"
}

McINV.CopyData = {
	["weight"] = true,
	["name"] = true,
	["mt"] = true,
	["ammo"] = true,
	["phone_type"] = true,
	["ud"] = true,
	["bookid"] = true,
	["docid"] = true,
	["batlvl"] = true,
}

McINV.ModifyData = {
	["ice_bag"] = function(tbl)
		if tbl.mt and tbl.mt < os.time() then
			tbl.name = "Пакет с водой"
		end
	end,
}

McINV.LimitedMailItems = {
	["dry_opium"] = true,
	["done_coca"] = true,
	["done_heroin"] = true,
	["craft_meth_ice"] = true,
	["dry_opium_small"] = true,
	["done_meth"] = true,
	["done_heroin_small"] = true,
	["done_coca_small"] = true,
	["dry_weed_small"] = true,
	["craft_coca_small"] = true,
	["done_meth_small"] = true,
	["craft_coca"] = true,
	["joint"] = true,
	["dry_coca"] = true,
	["fentanyl"] = true,
	["done_heroin_syr"] = true,
	["pills1"] = true,
	["pills2"] = true,
	["pills3"] = true,
	["pills4"] = true,
	["pills0"] = true,
}

McINV.BankBlackList = {
	["cuffs"] = true,
	["doc"] = true,
	["spawned_bag"] = true,
	["spawned_storage"] = true,
	["toolbox"] = true,
	["hookah"] = true,
}

function McINV.GetItemTable(ent, type, class)
	local tbl = {
		class = class,
		model = ent:GetModel(),
	}

	for dat, _ in pairs(McINV.CopyData) do
		if ent[dat] then
			tbl[dat] = ent[dat]
		end
	end

	if ent:GetMaterial() ~= "" then
		tbl.material = ent:GetMaterial()
	end

	if ent:GetColor() ~= color_white then
		tbl.color = ent:GetColor()
	end

	if ent.invCanStore and ent.inv then
		tbl.invS = ent.inv
	end

	if type == INV_WEAPON then
		tbl.clip1 = ent.clip1
		tbl.clip2 = ent.clip2
		tbl.att_saved = ent.att_precache or ent.att_saved
		tbl.gunstate = ent.gunstate or 1
		DarkRP.CopyGunDate(ent, tbl)
	end
	if ent.GetNetworkVars then
		tbl.dt = ent:GetNetworkVars()
	end
	return tbl
end

function McINV.ModifyItem(tbl)
	if McINV.ModifyData[tbl.class] then McINV.ModifyData[tbl.class](tbl) end
	return tbl
end

function McINV.GetWeight(ent, type, class)
	if ent and ent.weight then return ent.weight end
	if not class then debug.Trace() end
	if type == INV_WEAPON then
		return DarkRP.Weapons[class] and DarkRP.Weapons[class].weight or 1
	else
		return DarkRP.Entities[class] and DarkRP.Entities[class].weight or 1
	end
end

function McINV.GetSpace(contents)
	local weight = 0

	for type, items in pairs(contents) do
		for k, v in pairs(items) do
			weight = weight + McINV.GetWeight(v, type, v.class)
		end
	end

	return weight
end

function McINV.prt(item, type)
	return (type and "#" .. type or "") .. " [" .. (item.class or "null") .. "] " .. (item.register and item.register.id or "")
end

function McINV.CanLoot(ply, ent)
	if not ent.inv then return false end

	if ent:IsOnFire() then return false end

	if ent.GetTrunkPosition and ent:LocalToWorld(ent:GetTrunkPosition()):DistToSqr(ply:GetPos()) <= 22500 then
		return true
	end

	if ent:GetPos():DistToSqr(ply:GetPos()) <= 22500 then
		return true
	end

	return false
end

function McINV.GetItem(type, class)
	if type == INV_WEAPON and DarkRP.Weapons[class] then
		return DarkRP.Weapons[class]
	elseif type == INV_ENTITY and (DarkRP.Entities[class] or DarkRP.Stations[class]) then
		return DarkRP.Entities[class] or DarkRP.Stations[class]
	elseif type == INV_AMMO and DarkRP.Ammo[class] then
		return DarkRP.Ammo[class]
	elseif type == INV_FOOD and DarkRP.Food[class] then
		return DarkRP.Food[class]
	elseif type == INV_JUNK and DarkRP.Junk[class] then
		return DarkRP.Junk[class]
	end
	return false
end

function McINV.IsEmpty(contents)
	if not contents then return true end

	for k, v in pairs(contents) do
		for _, item in pairs(v) do
			return false
		end
	end

	return true
end

local entityMeta = FindMetaTable("Entity")

function entityMeta:GetBankSpace()
	return tonumber(self:getDarkRPVar("bankspace"))
end

function entityMeta:GetDefaultSpace()
	if self:IsPlayer() then
		return tonumber(self:getDarkRPVar("invspace"))
	else
		return (self.dt and self.dt.Space) and tonumber(self:GetSpace()) or 0
	end
end

function entityMeta:GetItemCount(type, class, bank, uses, cons, check)
	local count = 0
	local tbl = (CLIENT and self == LocalPlayer()) and McINV.inv[type] or self.inv[type]
	if bank then
		tbl = self.bank_inc[type]
	end
	for k, v in pairs(tbl) do
		if class == v.class then
			if check and not check(v) then
				continue
			end
			if uses and v.dt and v.dt.uses then
				local data = DarkRP[McINV.ttypes[type]][class]

				if cons and data and data.uses then
					count = count + (v.dt.uses / data.uses)
				else
					count = count + math.max(v.dt.uses, 1)
				end
			else
				count = count + 1
			end
		end
	end
	return count
end

function entityMeta:HaveMag(types)
	local tbl = (CLIENT and self == LocalPlayer()) and McINV.inv[INV_AMMO] or self.inv[INV_AMMO]

	if not tbl then return false end

	for k, v in pairs(tbl) do
		if v.class and types[v.class] and v.dt and v.dt.Ammo and (v.dt.Ammo > 0) then
			return true
		end
	end

	return false
end

function entityMeta:HaveItem(type, class, eclass, bank)
	return self:GetItemCount(type, class, bank)
end

function entityMeta:GetInvSpace()
	if not self.inv then return 0 end
	return McINV.GetSpace((CLIENT and self == LocalPlayer()) and McINV.inv or self.inv)
end

function entityMeta:HasBullets(types)
	local mag, id = 0, nil
	local tbl = (CLIENT and self == LocalPlayer()) and McINV.inv[INV_AMMO] or self.inv[INV_AMMO]

	for k, v in pairs(tbl) do
		if v.class and types[v.class] and v.dt and v.dt.Ammo and (mag < v.dt.Ammo) then
			mag = v.dt.Ammo
			id = k
			break
		end
	end

	if id and mag > 0 then
		return mag
	end

	return false
end

function McINV.PriceCut(price, class, ctt)
	local tm = (team.NumPlayers(2) or 0) / (#player.GetAll() or 0)
	local clamp = math.Clamp(tm - 0.15, 0, class and 0.3 or 0.7)
	ctt = ctt or McINV.drugStock
	if class and ctt[class] and ctt[class] > 5 then
		clamp = math.Clamp(((ctt[class] - 5) * 0.1) + clamp, 0, 0.7)
	end

	return price * clamp
end

function McINV.SellPrice(ply)
	local price = 0
	local tbl = (CLIENT and ply == LocalPlayer()) and McINV.inv[INV_JUNK] or ply.inv[INV_JUNK]
	local ctt = table.Copy(McINV.drugStock)

	for _, item in pairs(tbl) do
		local v = DarkRP.Junk[item.class]
		if not v then continue end
		if not v.sell or not v.price then continue end

		if v.w_price then
			local vp = v.price * item.weight
			price = price + (vp - McINV.PriceCut(vp, item.class, ctt))
		else
			price = price + (v.price - McINV.PriceCut(v.price, item.class, ctt))
		end

		ctt[item.class] = ctt[item.class] and ctt[item.class] + 1 or 1
	end

	return math.Round(price)
end

local tax

function McINV.Tax(price, type, item)
	tax = 0

	if type and type == INV_WEAPON and item and item.att_saved then
		for _, v in pairs(item.att_saved) do
			if v.m_Index and DarkRP.AttCost[v.m_Index] then
				price = price + DarkRP.AttCost[v.m_Index]
			end
		end
	end

	if type and type == INV_AMMO and item and item.dt and item.dt.Ammo and item.ammo then
		if item.ammo_box and DarkRP.Ammo[item.ammo_box] then
			local am = math.Round(DarkRP.Ammo[item.ammo_box].price / DarkRP.Ammo[item.ammo_box].ammo)
			price = price - ((item.ammo * am) - (item.dt.Ammo * am))
		else
			price = price * (item.dt.Ammo / item.ammo)
		end
	end

	if type and item and item.dt and item.dt.uses then
		local data = DarkRP[McINV.ttypes[type]][item.class]
		if data and data.uses then
			price = price * (item.dt.uses / data.uses)
		end
	end

	if Slawer.Mayor.JobTaxs and Slawer.Mayor.JobTaxs.shops > 0 then
		tax = math.Round(price * Slawer.Mayor.JobTaxs.shops / 100)
		price = price + tax
	end

	return price, tax
end

function McINV.WeaponTax(item)
	if not item then return end
	local shop = McINV.GetItem(INV_WEAPON, item.class)
	if not shop then return 0 end
	return math.Round(McINV.Tax(shop.price or 0, INV_WEAPON, item) * 0.14)
end

McINV.BankPlanes = {
	[15] = {
		descr = "Базовый",
		cl = Color(109,186,209)
	},
	[30] = {
		price = 10000,
		descr = "Улучшенный",
		cl = Color(11,79,226)
	},
	[45] = {
		need = 30,
		price = 30000,
		descr = "V.I.P.",
		cl = Color(91,5,161)
	},
	[60] = {
		donate = 450,
		descr = "Премиум",
		cl = Color(248,0,186)
	},
	[100] = {
		need = 60,
		donate = 600,
		descr = "Платинум",
		cl = Color(255,38,0)
	},
}

function McINV.GetLighter(ply)
	local tbl = (CLIENT and ply == LocalPlayer()) and McINV.inv or ply.inv

	if not tbl or not tbl[INV_JUNK] then return nil end

	for k, v in ipairs(tbl[INV_JUNK]) do
		if v.class == "lighter" then
			return v
		end
	end

	return nil
end

function McINV.GetPhone(self)
	local tbl = (CLIENT and self == LocalPlayer()) and McINV.inv or self.inv

	if not tbl or not tbl[INV_JUNK] then return nil end

	for k, v in ipairs(tbl[INV_JUNK]) do
		if v.phone_type then
			return k, v
		end
	end

	return nil
end

local phone = {
	["class"] = "phone_se",
	["color"] = color_black,
	["dt"] = {["eclass"] = "phone_se"},
	["model"] = "models/cityrp/se_phone.mdl",
	["name"] = "Телефон",
	["phone_type"] = 5,
	["ud"] = {
		["PhoneColor"] = color_black,
		["PhoneType"] = "Exp",
		["Ringtone"] = "cell/tone_1.wav",
		["Sleep"] = false,
		["WallPaper"] = "wp_1.png",
	},
	["weight"] = 0.1
}

local phone_2 = {
	["class"] = "phone_bj",
	["color"] = color_white,
	["dt"] = {["eclass"] = "phone_bj"},
	["model"] = "models/props_electronics/cellphone-5.mdl",
	["name"] = "Телефон",
	["phone_type"] = 7,
	["ud"] = {
		["PhoneColor"] = color_white,
		["PhoneType"] = "Beijing",
		["Ringtone"] = "cell/redsun.mp3",
		["Sleep"] = false,
		["WallPaper"] = "bch/1.png",
	},
	["weight"] = 0.1
}

function McINV.AddPhone(ply)
	if math.random(10) == 10 and (ply:GetModel() == "models/cityrp/pm/normal/male_05.mdl" or ply:GetModel() == "models/cityrp/pm/normal/female_04.mdl") then
		table.insert(ply.inv[INV_JUNK], phone_2)
		return
	end

	local cl = table.Random(McPhone.Exp.Themes)

	phone["color"] = cl["phone"]
	phone["ud"]["PhoneColor"] = cl["phone"]
	phone["ud"]["Ringtone"] = "cell/tone_" .. math.random(1,4) .. ".wav"
	phone["ud"]["WallPaper"] = "wp_" .. math.random(1,6) .. ".png"

	table.insert(ply.inv[INV_JUNK], phone)
end