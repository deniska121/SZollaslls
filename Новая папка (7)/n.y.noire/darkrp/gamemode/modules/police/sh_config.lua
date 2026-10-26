--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/police/sh_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DarkRP.Police = DarkRP.Police or {}
DarkRP.Police.Vests = 5
DarkRP.Police.CuffPrice = 87
DarkRP.Police.VestsUpdate = 0
DarkRP.Police.Cuffs = {}
DarkRP.GunRegister = DarkRP.GunRegister or {}

DarkRP.Police.PrimaryWeps = {
	["police_mp5"] = {
		Name = "MP5",
		Icon = Material("entities/mwb_mp5.png", "smooth"),
		Price = 500,
		Rank = 4,
		Level = 2,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_DETECTIVE] = true,
			[TEAM_SWAT] = true,
		},
	},
	["police_m590"] = {
		Name = "Mossberg 590",
		Icon = Material("entities/weapon_m590.png", "smooth"),
		Price = 400,
		Rank = 4,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_DETECTIVE] = true,
			[TEAM_SWAT] = true,
		},
	},
	["police_m4"] = {
		Name = "Colt Model 629",
		Icon = Material("entities/weapon_m4.png", "smooth"),
		Price = 1000,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_DETECTIVE] = true,
			[TEAM_SWAT] = true,
		}
	},
	["police_mk18"] = {
		Name = "Mk18 Mod 1",
		Icon = Material("entities/mwb_m4a1.png", "smooth"),
		Price = 1000,
		AllowedTeams = {
			[TEAM_SWAT] = true,
		}
	},
	["police_mk20"] = {
		Name = "FN SSR",
		Icon = Material("entities/mwb_mk17.png", "smooth"),
		Price = 1000,
		AllowedTeams = {
			[TEAM_SWAT] = true,
		}
	},
	["mwb_spapa12"] = {
		Name = "SPAS-12",
		Icon = Material("entities/mwb_spapa12.png", "smooth"),
		Price = 1000,
		AllowedTeams = {
			[TEAM_SWAT] = true,
		}
	},
	["police_beanbag"] = {
		Name = "Mossberg 590 Травматический",
		Icon = Material("entities/weapon_beanbag.png", "smooth"),
		Price = 400,
		Rank = 3,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_DETECTIVE] = true,
			[TEAM_SWAT] = true,
		},
	},
}

DarkRP.Police.SecondaryWeps = {
	["police_glock"] = {
		Name = "Glock 17",
		Icon = Material("entities/mwb_glock17.png", "smooth"),
		Price = 200,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_DETECTIVE] = true,
			[TEAM_SWAT] = true,
		},
	},
	["mwb_m9"] = {
		Name = "Beretta M9",
		Icon = Material("entities/mwb_m9.png", "smooth"),
		Price = 900,
		AllowedTeams = {
			[TEAM_DETECTIVE] = true,
		},
	},
	["police_sw"] = {
		Name = "S&W 4506",
		Icon = "https://cityrp.macnco.one/sw4506.png",
		Price = 900,
		AllowedUsers = {
			["STEAM_0:0:713737542"] = true,
			["STEAM_0:1:524313405"] = true,
			["STEAM_0:0:47288123"] = true,
		},
		AllowedTeams = {
			[TEAM_DETECTIVE] = true,
			[TEAM_SWAT] = true,
			[TEAM_POLICESV] = true,
		},
	},
	["mwb_93r"] = {
		Name = "Beretta 93R",
		Icon = Material("entities/mwb_93r.png", "smooth"),
		Price = 200,
		AllowedTeams = {
			[TEAM_SWAT] = true,
		},
	},
}

DarkRP.Police.SidearmWeps = {
	["weapon_taser"] = {
		Name = "Тайзер",
		Icon = Material("entities/weapon_taser.png", "smooth"),
		Price = 0,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_SWAT] = true,
		},
	},
	["mlw_tonfa"] = {
		Name = "Дубинка",
		Icon = "https://i.imgur.com/OzLYGYL.png",
		Price = 0,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_WARDEN] = true,
			[TEAM_SWAT] = true,
		},
	},
	["med_pd"] = {
		Name = "Аптечка первой помощи",
		Icon = "https://i.imgur.com/OJXlJv1.png",
		Price = 0,
		SHCheck = function(ply) return MRS.GetSData(ply, "exam_pdkit") end,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_WARDEN] = true,
			[TEAM_SWAT] = true,
		},
	},
}

DarkRP.Police.Gear1 = {
	["mlw_policelight"] = {
		Name = "Фонарь",
		Icon = "http://cityrp.macnco.one/flashlight.png",
		Price = 0,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_WARDEN] = true,
			[TEAM_TRAFFIC] = true,
			[TEAM_SWAT] = true,
		},
	},
	["weapon_ram"] = {
		Name = "Таран",
		Icon = Material("entities/weapon_ram.png", "smooth"),
		Price = 0,
		AllowedTeams = {
			[TEAM_POLICE] = true,
			[TEAM_POLICESV] = true,
			[TEAM_SWAT] = true,
		},
	},
}

DarkRP.Police.Gear2 = {}
DarkRP.Police.Gear3 = {}
DarkRP.Police.Units = DarkRP.Police.Units or {}

DarkRP.Police.Phonetic = {
	["A"] = "Adam",
	["B"] = "Boy",
	["C"] = "Charles",
	["D"] = "David",
	["E"] = "Eddie",
	["F"] = "Frank",
	["G"] = "George",
	["H"] = "Henry",
	["I"] = "Ida",
	["J"] = "John",
	["K"] = "King",
	["L"] = "Larry",
	["M"] = "Mike",
	["N"] = "Nora",
	["O"] = "Oscar",
	["P"] = "Peter",
	["Q"] = "Queen",
	["R"] = "Robert",
	["S"] = "Sam",
	["T"] = "Thomas",
	["U"] = "Union",
	["V"] = "Victor",
	["W"] = "William",
	["X"] = "X Ray",
	["Y"] = "Yellow",
	["Z"] = "Zebra"
}

DarkRP.Police.PhoneticRev = {}

for k, v in pairs(DarkRP.Police.Phonetic) do
	DarkRP.Police.PhoneticRev[v] = k
end

DarkRP.Police.PhoneticNum = {"Adam", "Boy", "Charles", "David", "Eddie", "Frank", "George", "Henry", "Ida", "John", "King", "Larry", "Mike", "Nora", "Oscar", "Peter", "Queen", "Robert", "Sam", "Thomas", "Union", "Victor", "William", "X Ray", "Yellow", "Zebra"}

DarkRP.Police.TicketTypes = {
	{"Словесное домогательство; издевательство; оскорбление", 50, 10},
	{"Введение в заблуждение", 50, 10},
	{"Проникновение на чужую/запретную территорию", 50, 10},
	{"Нарушение общественного порядка", 200, 10},
	{"Нарушение ПДД", 200, 10},
	--
	{"Помеха исполнению закона", 200, 15},
	{"Мелкое воровство", 200, 15},
	{"Хулиганство", 200, 15},
	{"Шантаж", 200, 15},
	{"Неуплата пени", 200, 15},
	{"Отсутствие необходимых лицензий", 200, 15, true},
	--
	{"Побег с места преступления", 500, 25},
	{"Угрозы жизни, имуществу; причинение вреда чужому имуществу", 500, 25},
	{"Нападение или причинение вреда здоровью", 500, 25},
	{"Похищение", 500, 25},
	{"Взяточничество", 500, 25},
	{"Превышение полномочий на позиции гос. служащего", 1500, 25},
	{"Хранение или производство запрещённых предметов (до 1кг включительно)", 500, 25},
	{"Угон автомобиля", 500, 25},
	{"Воровство в крупном размере", 500, 25},
	{"Мародёрство", 500, 25},
	{"Невыполнение обязательств по пожарной безопасности", 700, 25, true},
	{"Нарушение условий контракта", 1000, 25},
	{"Участие в азартных играх", 1000, 25},
	{"Ложное освидетельствование", 1500, 40},
	{"Нарушение муниципальной части оружейного положения", 1000, 40, true},
	--
	{"Грабёж", 800, 45},
	{"Вымогательство; рэкет", 800, 45},
	{"Нанесение увечий", 800, 45},
	{"Доведение до суицида", 1000, 45},
	{"Непреднамеренное убийство", 1000, 45, "deathlog"},
	{"Поджоги", 1000, 45},
	{"Коррупция в крупных размерах", 1500, 45},
	{"Хранение или производство запрещённых предметов (от 1кг)", 800, 45},
	{"Участие в запрещённых или преступных организациях", 800, 45},
	{"Участие в массовых беспорядках", 800, 45},
	{"Незаконная передача оружия", 1200, 45},
	{"Нарушение федеральной части оружейного положения", 2000, 60, true},
	--
	{"Умышленное убийство", 2000, 60, "deathlog"},
	{"Организация преступных формирований", 2000, 60},
	{"Организация азартных игр", 2500, 60},
	{"Организация массовых беспорядков", 1500, 60},
	{"Пытки", 3000, 90},
	{"Попытка государственного переворота", 3000, 60},
	{"Незаконный оборот оружия", 2000, 80},
	{"Преступление против человечества", 2500, 60},
	{"Федеральная халатность", 3000, 90},
	{"Терроризм", 6000, 120},
	--
	{"Покушение на преступление лёгкого характера", 200, 15},
	{"Покушение на преступление средней тяжести", 500, 25},
	{"Покушение на тяжкое преступление", 800, 45},
	{"Покушение на особо тяжкое преступление", 1500, 60},
}

if SERVER then return end

hook.Add("InventoryStorageUI", "PoliceEvidence", function(ent, type, item, id, btn, list)
	if (ent.policeEvidnce or ent.RDMContract) and item.putby and LocalPlayer():SteamID64() ~= item.putby then
		btn.locked = true
	end

	if ent.policeEvidnce then
		if item.putname then
			btn.showdsc = true
			btn.descr = item.putname
		end

		if not IsValid(list.stuffed) then
			local combo = MSD.ComboBox(list, "static", nil, 1, 50, "", "")
			list:InsertAtTop(combo)

			combo.OnSelect = function(self, index, text, data)
				RunConsoleCommand("Inventory.Drop", "nypd", data)
			end

			if Slawer.JailTable then
				for a, data in pairs(Slawer.JailTable) do
					combo:AddChoice("Личные вещи #" .. a .. " " .. data.name .. " " .. data.sname, data.userid)
				end
			end

			combo:AddChoice("Центральный склад", "")
			list.stuffed = combo
		end
	end
end)