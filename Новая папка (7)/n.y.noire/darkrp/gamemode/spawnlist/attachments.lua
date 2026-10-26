--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/spawnlist/attachments.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DarkRP.Ammo["mac_30"] = {
	name = "Маг. MAC-10 на 30",
	model = "models/cityrp/box8.mdl",
	material = "gbskins/box_mac",
	ammo = 30,
	shop = "kwpns",
	ammo_box = "box45",
	sell_empty = true,
	price = 450,
	bul = 0.015,
	weight = 0.15
}

DarkRP.Ammo["thom_30"] = {
	name = "Маг. Thompson на 30",
	model = "models/cityrp/box8.mdl",
	material = "gbskins/box_mac",
	ammo = 30,
	shop = "kwpns",
	xp = {"guns", 100},
	ammo_box = "box45",
	sell_empty = true,
	price = 450,
	bul = 0.015,
	weight = 0.15
}

DarkRP.Ammo["thom_50"] = {
	name = "Барабан Thompson на 50",
	model = "models/cityrp/bags/satchel_drop.mdl",
	ammo = 50,
	shop = "kwpns",
	ammo_box = "box45",
	xp = {"guns", 3000},
	sell_empty = true,
	price = 1000,
	bul = 0.015,
	weight = 0.15
}

DarkRP.Ammo["uzi_32"] = {
	name = "Маг. UZI на 32",
	model = "models/cityrp/box8.mdl",
	material = "gbskins/box_uzi",
	ammo = 32,
	shop = "kwpns",
	ammo_box = "box919",
	sell_empty = true,
	price = 450,
	bul = 0.01,
	weight = 0.15
}

DarkRP.Ammo["tec_32"] = {
	name = "Маг. Tec-9 на 32",
	model = "models/cityrp/box8.mdl",
	material = "gbskins/box_uzi",
	ammo = 32,
	shop = "kwpns",
	ammo_box = "box919",
	sell_empty = true,
	price = 450,
	bul = 0.01,
	weight = 0.15
}

DarkRP.Ammo["uzi_50"] = {
	name = "Маг. UZI на 50",
	model = "models/cityrp/box7.mdl",
	material = "gbskins/box_uzi",
	ammo = 50,
	shop = "kwpns",
	xp = {"guns", 1500},
	ammo_box = "box919",
	sell_empty = true,
	price = 900,
	bul = 0.01,
	weight = 0.25
}

DarkRP.Ammo["deagle_7"] = {
	name = "Маг. Deagle на 7",
	model = "models/cityrp/box6.mdl",
	material = "gbskins/box_deagle",
	ammo = 7,
	xp = {"guns", 500},
	shop = "kwpns",
	ammo_box = "box50",
	sell_empty = true,
	price = 130,
	bul = 0.025,
	weight = 0.2
}

DarkRP.Ammo["deagle_10"] = {
	name = "Маг. Deagle на 10",
	model = "models/cityrp/small/box3.mdl",
	material = "gbskins/box_deagle",
	ammo = 10,
	xp = {"guns", 1000},
	shop = "kwpns",
	ammo_box = "box50",
	sell_empty = true,
	price = 230,
	bul = 0.025,
	weight = 0.4
}

DarkRP.Ammo["deagle_13"] = {
	name = "Маг. Deagle на 13",
	model = "models/cityrp/small/box3.mdl",
	material = "gbskins/box_deagle",
	xp = {"guns", 2000},
	ammo = 13,
	shop = "kwpns",
	ammo_box = "box50",
	sell_empty = true,
	price = 320,
	bul = 0.025,
	weight = 0.5
}

DarkRP.Ammo["glock9_17"] = {
	name = "Маг. Glock на 17 (9x19mm)",
	model = "models/cityrp/box9.mdl",
	material = "gbskins/box_p320",
	ammo = 17,
	shop = "rdm",
	ammo_box = "box919",
	sell_empty = true,
	price = 180,
	bul = 0.01,
	weight = 0.16
}

DarkRP.Ammo["glock9_21"] = {
	name = "Маг. Glock на 21 (9x19mm)",
	model = "models/cityrp/box6.mdl",
	material = "gbskins/box_p320",
	ammo = 21,
	xp = {"guns", 500},
	shop = "kwpns",
	ammo_box = "box919",
	sell_empty = true,
	price = 250,
	bul = 0.01,
	weight = 0.23
}

DarkRP.Ammo["glock9_32"] = {
	name = "Маг. Glock на 32 (9x19mm)",
	model = "models/cityrp/small/box3.mdl",
	material = "gbskins/box_p320",
	xp = {"guns", 1200},
	ammo = 32,
	shop = "kwpns",
	ammo_box = "box919",
	sell_empty = true,
	price = 430,
	bul = 0.01,
	weight = 0.35
}

DarkRP.Ammo["p220_8"] = {
	name = "Маг. P220 на 8",
	model = "models/cityrp/box6.mdl",
	material = "gbskins/box_p220",
	ammo = 8,
	shop = "rdm",
	ammo_box = "box10",
	sell_empty = true,
	price = 170,
	bul = 0.012,
	weight = 0.16
}

DarkRP.Ammo["glock_13"] = {
	name = "Маг. Glock на 13 (.45 ACP)",
	model = "models/cityrp/box6.mdl",
	material = "gbskins/box_45",
	ammo = 13,
	shop = "rdm",
	ammo_box = "box45",
	sell_empty = true,
	price = 170,
	bul = 0.015,
	weight = 0.2
}

DarkRP.Ammo["glock_17"] = {
	name = "Маг. Glock на 17 (.45 ACP)",
	model = "models/cityrp/box8.mdl",
	material = "gbskins/box_45",
	ammo = 17,
	shop = "kwpns",
	xp = {"guns", 700},
	ammo_box = "box45",
	sell_empty = true,
	price = 280,
	bul = 0.015,
	weight = 0.3
}

DarkRP.Ammo["glock_26"] = {
	name = "Маг. Glock на 26 (.45 ACP)",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_45",
	xp = {"guns", 1500},
	ammo = 26,
	shop = "kwpns",
	ammo_box = "box45",
	sell_empty = true,
	price = 380,
	bul = 0.015,
	weight = 0.31
}

DarkRP.Ammo["makarov_8"] = {
	name = "Маг. ПМ на 8",
	model = "models/cityrp/box9.mdl",
	material = "gbskins/box_pm",
	ammo = 8,
	shop = "kwpns",
	sell_empty = true,
	ammo_box = "box918",
	price = 30,
	bul = 0.01,
	weight = 0.1
}

DarkRP.Ammo["makarov_12"] = {
	name = "Маг. ПМ на 12",
	model = "models/cityrp/box6.mdl",
	material = "gbskins/box_pm",
	ammo = 12,
	sell_empty = true,
	xp = {"guns", 200},
	shop = "kwpns",
	ammo_box = "box918",
	price = 60,
	bul = 0.01,
	weight = 0.17
}

DarkRP.Ammo["makarov_80"] = {
	name = "Маг. ПМ на 80",
	model = "models/cityrp/bags/satchel_drop.mdl",
	ammo = 80,
	ammo_box = "box918",
	sell_empty = true,
	price = 550,
	bul = 0.01,
	weight = 0.5
}

DarkRP.Ammo["1911_7"] = {
	name = "Маг. 1911 на 7",
	model = "models/cityrp/box6.mdl",
	material = "gbskins/box_45",
	ammo = 7,
	shop = "rdm",
	sell_empty = true,
	ammo_box = "box45",
	price = 70,
	bul = 0.015,
	weight = 0.16
}

DarkRP.Ammo["beanbag"] = {
	name = "Травматические патроны",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_beanbag",
	ammo = 10,
	price = 180,
	bul = 0.03,
	weight = 0.01
}

DarkRP.Ammo["m9_15"] = {
	name = "Маг. M9 на 15",
	model = "models/cityrp/box9.mdl",
	material = "gbskins/box_m9",
	ammo = 15,
	shop = "rdm",
	sell_empty = true,
	ammo_box = "box919",
	price = 150,
	bul = 0.01,
	weight = 0.1
}

DarkRP.Ammo["m9_20"] = {
	name = "Маг. 93R на 20",
	model = "models/cityrp/box6.mdl",
	material = "gbskins/box_m9",
	ammo = 20,
	shop = "kwpns",
	xp = {"guns", 800},
	ammo_box = "box919",
	sell_empty = true,
	price = 200,
	bul = 0.01,
	weight = 0.1
}

DarkRP.Ammo["aug_30"] = {
	name = "Маг. AUG на 30",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_brand",
	ammo = 30,
	shop = "kwpns",
	ammo_box = "box556",
	sell_empty = true,
	price = 480,
	bul = 0.012,
	weight = 0.05
}

DarkRP.Ammo["stanag_20"] = {
	name = "Маг. 5.56 на 20",
	model = "models/cityrp/box4.mdl",
	material = "gbskins/box_stanag",
	ammo = 20,
	shop = "rdm",
	ammo_box = "box556",
	sell_empty = true,
	price = 300,
	bul = 0.012,
	weight = 0.08
}

DarkRP.Ammo["stanag_30"] = {
	name = "Маг. 5.56 на 30",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_stanag",
	ammo = 30,
	sell_empty = true,
	shop = "kwpns",
	ammo_box = "box556",
	price = 410,
	bul = 0.012,
	weight = 0.11
}

DarkRP.Ammo["stanag_30c"] = {
	name = "Маг. 5.56 на 30",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_stanag",
	ammo = 30,
	sell_empty = true,
	shop = "kwpns",
	ammo_box = "box556",
	price = 410,
	bul = 0.012,
	weight = 0.11
}

DarkRP.Ammo["stanag_50"] = {
	name = "Маг. 5.56 на 50",
	model = "models/cityrp/box3.mdl",
	material = "gbskins/box_stanag",
	ammo = 50,
	shop = "kwpns",
	xp = {"guns", 1500},
	ammo_box = "box556",
	sell_empty = true,
	price = 910,
	bul = 0.012,
	weight = 0.16
}

DarkRP.Ammo["mp5_30"] = {
	name = "Маг. MP5 на 30",
	model = "models/cityrp/small/box3.mdl",
	material = "gbskins/box_mp5",
	ammo = 30,
	sell_empty = true,
	shop = "rdm",
	ammo_box = "box919",
	price = 340,
	bul = 0.01,
	weight = 0.2
}

DarkRP.Ammo["mp5_45"] = {
	name = "Маг. MP5 на 45",
	model = "models/cityrp/small/box2.mdl",
	material = "gbskins/box_mp5",
	ammo = 45,
	shop = "kwpns",
	xp = {"guns", 1500},
	ammo_box = "box919",
	sell_empty = true,
	price = 600,
	bul = 0.01,
	weight = 0.3
}

DarkRP.Ammo["stanag_60"] = {
	name = "Маг. 5.56 на 60",
	model = "models/cityrp/bags/satchel_drop.mdl",
	ammo = 60,
	ammo_box = "box556",
	xp = {"guns", 2500},
	sell_empty = true,
	price = 1100,
	bul = 0.012,
	weight = 0.18
}

DarkRP.Ammo["rem_5"] = {
	name = "Маг. Remington 700 на 5",
	model = "models/cityrp/box4.mdl",
	material = "gbskins/box_brand",
	ammo = 5,
	shop = "rdm",
	sell_empty = true,
	ammo_box = "box308",
	price = 90,
	bul = 0.01,
	weight = 0.15
}

DarkRP.Ammo["scar_10"] = {
	name = "Маг. SCAR на 10",
	model = "models/cityrp/box4.mdl",
	material = "gbskins/box_brand",
	ammo = 10,
	shop = "rdm",
	sell_empty = true,
	ammo_box = "box308",
	price = 160,
	bul = 0.01,
	weight = 0.15
}

DarkRP.Ammo["scar_20"] = {
	name = "Маг. SCAR на 20",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_brand",
	ammo = 20,
	shop = "kwpns",
	sell_empty = true,
	ammo_box = "box308",
	price = 400,
	bul = 0.01,
	weight = 0.25
}

DarkRP.Ammo["scar_25"] = {
	name = "Маг. SCAR на 25",
	model = "models/cityrp/box3.mdl",
	material = "gbskins/box_brand",
	ammo = 25,
	shop = "kwpns",
	xp = {"guns", 1500},
	ammo_box = "box308",
	sell_empty = true,
	price = 610,
	bul = 0.013,
	weight = 0.30
}

DarkRP.Ammo["scar_30"] = {
	name = "Маг. SCAR на 30",
	model = "models/cityrp/box2.mdl",
	material = "gbskins/box_brand",
	ammo = 30,
	shop = "kwpns",
	xp = {"guns", 2500},
	ammo_box = "box308",
	sell_empty = true,
	price = 920,
	bul = 0.013,
	weight = 0.35
}

DarkRP.Ammo["ak545_30"] = {
	name = "Маг. АК 5.45 на 30",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_ak74",
	ammo = 30,
	shop = "rdm",
	sell_empty = true,
	ammo_box = "box545",
	price = 390,
	bul = 0.011,
	weight = 0.21
}

DarkRP.Ammo["ak545_45"] = {
	name = "Маг. АК 5.45 на 45",
	model = "models/cityrp/box3.mdl",
	material = "gbskins/box_ak74",
	ammo = 45,
	shop = "kwpns",
	xp = {"guns", 2500},
	ammo_box = "box545",
	sell_empty = true,
	price = 880,
	bul = 0.011,
	weight = 0.28
}

DarkRP.Ammo["ak762_30"] = {
	name = "Маг. АК 7.62 на 30",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_akm",
	ammo = 30,
	sell_empty = true,
	shop = "rdm",
	ammo_box = "box762",
	price = 400,
	bul = 0.02,
	weight = 0.37
}

DarkRP.Ammo["ak762_40"] = {
	name = "Маг. АК 7.62 на 40",
	model = "models/cityrp/box3.mdl",
	material = "gbskins/box_akm",
	ammo = 40,
	shop = "kwpns",
	xp = {"guns", 2500},
	ammo_box = "box762",
	sell_empty = true,
	price = 640,
	bul = 0.02,
	weight = 0.32
}

DarkRP.Ammo["ak762_75"] = {
	name = "Барабан АК 7.62 на 75",
	model = "models/cityrp/bags/satchel_drop.mdl",
	ammo = 75,
	xp = {"guns", 5500},
	ammo_box = "box762",
	sell_empty = true,
	price = 1400,
	bul = 0.02,
	weight = 0.72
}

DarkRP.Ammo["buckshot"] = {
	name = "Коробка картечи",
	model = "models/cityrp/box0.mdl",
	material = "gbskins/box_buck",
	ammo = 20,
	shop = "kwpns",
	xp = {"guns", 300},
	price = 180,
	bul = 0.03,
	weight = 0.01
}

DarkRP.Ammo["box357"] = {
	name = "Коробка .357",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_357",
	ammo = 20,
	shop = "kwpns",
	xp = {"guns", 700},
	price = 300,
	bul = 0.02,
	weight = 0.01
}

DarkRP.Ammo["box792"] = {
	name = "Коробка 7.92x57mm Mauser",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_8mm",
	ammo = 10,
	shop = "kwpns",
	xp = {"guns", 700},
	price = 500,
	bul = 0.02,
	weight = 0.01
}

-- NEW

DarkRP.Ammo["box918"] = {
	name = "Коробка 9x18mm",
	model = "models/cityrp/box4.mdl",
	ammo = 50,
	price = 100,
	bul = 0.01,
	weight = 0.01
}

DarkRP.Ammo["box919"] = {
	name = "Коробка 9x19mm",
	model = "models/cityrp/box4.mdl",
	ammo = 50,
	price = 150,
	bul = 0.01,
	weight = 0.01
}

DarkRP.Ammo["box10"] = {
	name = "Коробка 10mm AUTO",
	model = "models/cityrp/box4.mdl",
	ammo = 50,
	price = 170,
	bul = 0.012,
	weight = 0.01
}

DarkRP.Ammo["box45"] = {
	name = "Коробка .45 ACP",
	model = "models/cityrp/box4.mdl",
	ammo = 50,
	price = 200,
	bul = 0.015,
	weight = 0.01
}

DarkRP.Ammo["box50"] = {
	name = "Коробка .50 AE",
	model = "models/cityrp/box1.mdl",
	material = "gbskins/box_50ae",
	ammo = 20,
	price = 200,
	bul = 0.025,
	weight = 0.01
}

DarkRP.Ammo["box545"] = {
	name = "Коробка 5.45x39mm",
	model = "models/cityrp/box0.mdl",
	material = "gbskins/box_545",
	ammo = 50,
	price = 250,
	bul = 0.011,
	weight = 0.01
}

DarkRP.Ammo["box556"] = {
	name = "Коробка 5.56x45mm",
	model = "models/cityrp/box0.mdl",
	ammo = 50,
	price = 300,
	bul = 0.012,
	weight = 0.01
}

DarkRP.Ammo["box762"] = {
	name = "Коробка 7.62x39mm",
	model = "models/cityrp/box0.mdl",
	material = "gbskins/box_762",
	ammo = 50,
	price = 350,
	bul = 0.02,
	weight = 0.01
}

DarkRP.Ammo["box308"] = {
	name = "Коробка .308 Win",
	model = "models/cityrp/box0.mdl",
	ammo = 50,
	price = 400,
	bul = 0.013,
	weight = 0.01
}

for k,v in pairs(DarkRP.Ammo) do
	local _, icon
	if CLIENT then
		_, icon = MSD.IconRender.Get(v.model or "models/props_junk/CinderBlock01a.mdl", v.material, v.submat)
	end

	list.Set( "SpawnableEntities", k, {
		Name = v.name,
		Class = "spawned_ammo",
		Category = "DarkRP Ammo",
		PrintName = v.name,
		Extras = INV_AMMO,
		AdminOnly = false,
		IconOverride = icon and "data/msd_render/" .. icon,
		SpawnFunction = function(ply, pos)
			return DarkRP.CreateAmmo(k, pos)
		end
	} )
end