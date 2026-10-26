--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/jobs.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TEAM_GANG = DarkRP.createJob("Нелегал", {
	description = [[]],
	command = "char3",
	weapons = {},
	max = 0,
	salary = 0,
	char = 3,
})

TEAM_OFFDUTY = DarkRP.createJob("Вне службы", {
	description = [[]],
	weapons = {},
	command = "char2",
	max = 0,
	salary = 10,
	char = 2,
	stype = "gov"
})

local rankstars = {
	[7] = "models/gmodbest/acc/ranks/lt",
	[8] = "models/gmodbest/acc/ranks/cpt",
	[9] = "models/gmodbest/acc/ranks/dins",
	[10] = "models/gmodbest/acc/ranks/ins",
	[11] = "models/gmodbest/acc/ranks/1star",
	[12] = "models/gmodbest/acc/ranks/2star",
	[13] = "models/gmodbest/acc/ranks/3star",
	[14] = "models/gmodbest/acc/ranks/4star",
}

local function SetupPolice(ply, char, aux)
	ply:SetModel("models/cityrp/pm/nypd/" .. char.gender .. "_0" .. char.model .. ".mdl")
	ply:SetBodygroup(5, 1)
	ply:SetBodygroup(2, 1)

	ply:SetBodygroup(1, 0)
	if char.gender == "male" then
		ply:SetBodygroup(4, 1)
	end
	local rank = MRS.GetPlyRank(ply, "NYPD")

	if rank > 5 and rank < 11 then
		MCR.SetMatCustomByName(ply, "hat_01", "models/gmodbest/acc/hat_02")
	elseif rank > 10 then
		MCR.SetMatCustomByName(ply, "hat_01", "models/gmodbest/acc/hat_03")
		if char.gender == "male" then ply:SetBodygroup(4, 3) end
	end

	if aux then
		MCR.SetMatCustomByPathName(ply, "rankl", "models/gmodbest/acc/rankaux")
		MCR.SetMatCustomByPathName(ply, "rank", "models/gmodbest/acc/rankaux")
		MCR.SetMatCustomByName(ply, "rank92", "models/gmodbest/acc/ranks/92a")
		MCR.SetMatCustomByName(ply, "acc/body_01", "models/gmodbest/acc/body_01aux")
		MCR.SetMatCustomByName(ply, "models/gmodbest/acc/armor2", "models/gmodbest/acc/armor2aux")
		MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topcad")
	end

	if rank == 6 then
		MCR.SetMatCustomByName(ply, "rank1", "models/gmodbest/acc/rank2")
		MCR.SetMatCustomByName(ply, "acc/body_01", aux and "models/gmodbest/acc/body_01auxs" or "models/gmodbest/acc/body_01s")
	end

	if rank > 6 then
		if char.gender == "male" then ply:SetBodygroup(4, 1) end
		ply:SetBodygroup(1, 0)
		MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topc")
		MCR.SetMatCustomByName(ply, "acc/rank_c", rankstars[rank] or "null")
		MCR.SetMatCustomByName(ply, "rank92", rankstars[rank] or "null")
	end

	if MRS.GetSData(ply, "hash", 0) > 0 then
		MCR.SetMatCustomByPathName(ply, "hash", "models/gmodbest/acc/hash/" .. MRS.GetSData(ply, "hash", 0))
	end

	if rank == 1 then
		ply:SetBodygroup(1, 0)
		ply:SetBodygroup(5, 0)
		ply:SetBodygroup(2, 0)
		MCR.SetMatCustomByName(ply, "rank92", "null")
		MCR.SetMatCustomByName(ply, "rank", "models/gmodbest/acc/rankcad")
		MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topcad")
	end

	if rank > 9 then
		ply:SetBodygroup(1, 4)
		ply:SetBodygroup(2, 0)
	end
end

TEAM_POLICE = DarkRP.createJob("Патрульный", {
	description = [[Выйдите на службу и вкусите всю суть работы в полиции. Помните, что вам нужно поддерживать порядок и слушать старшего, а не размахивать оружием налево-направо.]],
	weapons = {"arrest_stick"},
	command = "police",
	max = 10,
	salary = 125,
	rank = {"NYPD", 3},
	rank_max = {"NYPD", 4},
	ispolice = true,
	outfit = function(ply, char)
		SetupPolice(ply, char)
	end,
	char = 2,
	stype = "gov",
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 1)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		DarkRP.Police.AddUnit("NYPD", ply)
	end
})

TEAM_WARDEN = DarkRP.createJob("Вспомогательная полиция", {
	description = [[Занимайтесь задачами малого риска: волонтёрской работой по участку, выписыванием штрафов, оцеплением, и иной непрямой помощью офицерам в поддержании порядка.]],
	weapons = {"arrest_stick"},
	time = 130,
	command = "auxpolice",
	ispolice = true,
	rank_max = {"NYPD", 2},
	checkguns = function(ply, class)
		local rank = MRS.GetPlyRank(ply, "NYPD") or 1
		if rank < 2 then return false end
		return true
	end,
	max = 10,
	salary = 125,
	stype = "gov",
	outfit = function(ply, char)
		SetupPolice(ply, char, true)
	end,
	char = 2,
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		ply:SetDarkRPVar("rc", 1)
		DarkRP.Police.AddUnit("NYPD", ply, "AUX", " на смене")
	end
})

TEAM_DETECTIVE = DarkRP.createJob("В штатском", {
	description = [[Выйдите на службу в своей одежде и занимайтесь нестандартными делами на благо города. Помните, что вам также нужно поддерживать порядок, пусть и типичная рутина вас не касается.]],
	weapons = {"arrest_stick"},
	time = 130,
	command = "detective",
	ispolice = true,
	nouniform = true,
	max = 7,
	rank = {"NYPD", 5},
	salary = 125,
	char = 2,
	stype = "gov",
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 1)
		DarkRP.Police.AssignUnit(ply, 6)
	end
})

TEAM_SWAT = DarkRP.createJob("Оперативник", {
	description = [[Вооружитесь посильнее для проведения антитеррористических операций. В таком обмундировании вы не имеете права заниматься обычной работой полиции - только рейды и нестандартные ситуации.]],
	weapons = {"arrest_stick"},
	time = 150,
	ispolice = true,
	command = "esu",
	outfit = function(ply, char)
		ply:SetMaterial("null")
	end,
	PlayerSpawn = function(ply)
		ply:SetDarkRPVar("hidename", true)
		ply:SetDarkRPVar("scba", 2)
		ply:SetMaterial("null")
		ply:SetArmor(200)
		ply:SetDarkRPVar("armorVest", 1)
	end,
	max = 5,
	rank = {"NYPD ESU", 2},
	salary = 150,
	char = 2,
	stype = "gov",
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 3)
		ply:SetDarkRPVar("hidename", true)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		ply:SetDarkRPVar("scba", 2)
		ply:SetMaterial("null")
		ply.esuteam = true
		DarkRP.Police.AddUnit("NYPD", ply, "ESU", true, "6-")
	end
})

TEAM_SUCURITY = DarkRP.createJob("Охранник", {
	description = [[Не допустите, чтобы с районным администратором случилось что-то нехорошее. У вас есть разрешение на ношение огнестрельного оружия на время трудоустройства.]],
	weapons = {},
	command = "sucuriry",
	max = 5,
	salary = 125,
	char = 1,
	stype = "citizens",
	npc = "",
})

TEAM_GUN = DarkRP.createJob("Оружейный мастер", {
	description = [[Собирайте огнестрел на заказ или откройте свой собственный магазин для продажи готовой продукции. У вас есть разрешение на покупку оружейных деталей, кассы для автоматической продажи оружия, а также знания для его монтажа на верстаке.]],
	weapons = {},
	command = "gundealer",
	max = 2,
	salary = 100,
	salary_ds = 225,
	workstations = {
		["pistol"] = true,
	},
	mintime = 18000,
	online = 2,
	char = 1,
	stype = "citizens",
})

TEAM_COOK = DarkRP.createJob("Кулинар", {
	description = [[Готовьте пищу и алкоголь для своих будущих клиентов, будь они целым городом или отдельной группой лиц. У вас есть разрешение на покупку кассы для автоматической продажи пищевой продукции, дистиллятора для алкоголя и плиты.]],
	weapons = {},
	command = "cook",
	max = 5,
	salary = 100,
	salary_ds = 200,
	workstations = {
		["beer"] = true,
		["food"] = true,
	},
	char = 1,
	stype = "citizens",
})

TEAM_HOBO = DarkRP.createJob("Бездомный", {
	description = [[Откажитесь от привычных многим благ и выживайте. Мусорные контейнеры и канализация – ваши лучшие друзья.]],
	weapons = {"weapon_bugbait"},
	command = "hobo",
	max = 0,
	salary = 0,
	char = 0,
})

TEAM_CAR = DarkRP.createJob("Автомеханик", {
	description = [[Производите ремонт автомобилей за деньги. Рано или поздно к вам обратятся.]],
	--description = [[Производите ремонт автомобилей и эвакуируйте неправильно припаркованный транспорт на штраф-стоянку. В вашем распоряжении есть уникальный эвакуатор.]],
	weapons = {"weapon_simrepair"},
	command = "car",
	max = 2,
	char = 1,
	salary = 0,
	npc = "ramon",
	stype = "citizens",
	customCheck = function(ply) return not IsValid(ply.PersVeh) end,
	customCheckFailMsg = "Сдайте свою машину в гараж для выбора этой профессии"
})

TEAM_REF = DarkRP.createJob("Парамедик", {
	description = [[Выезжайте на вызовы и оказывайте медицинскую помощь нуждающимся. Помните о клятве Гиппократа.]],
	weapons = {"med_kit"},
	command = "medic",
	nlrank = {"FDNY", 7},
	max = 4,
	salary = 125,
	outfit = function(ply, char)
		local rank = MRS.GetPlyRank(ply, "FDNY")

		ply:SetModel("models/cityrp/pm/nypd/" .. char.gender .. "_0" .. char.model .. ".mdl")

		MCR.SetMatCustomByPathName(ply, "rank92", "null")
		MCR.SetMatCustomByPathName(ply, "rankl", "models/gmodbest/acc/rankems")
		if rank == 1 then
			MCR.SetMatCustomByPathName(ply, "rank", "models/gmodbest/acc/rankemt")
			MCR.SetMatCustomByName(ply, "body_01", "models/gmodbest/acc/body_02t")
			MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topp2")
		else
			MCR.SetMatCustomByName(ply, "body_01", "models/gmodbest/acc/body_02")
			MCR.SetMatCustomByPathName(ply, "rank", "models/gmodbest/acc/rankmed")
			MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topp")
		end

		if rank > 6 then
			MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topp3")
			MCR.SetMatCustomByName(ply, "hat_01", "models/gmodbest/acc/hat_fd3")
		end

		if rank < 8 then
			ply:SetBodygroup(1, 0)
			ply:SetBodygroup(2, 2)
			--ply.comfort = 2
		else
			ply:SetBodygroup(5, 1)
		end
	end,
	online = 2,
	char = 2,
	npc = "ems",
	stype = "gov",
	spawn_point = Vector(9844.3193359375,1557.5646972656,-103.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 4)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		DarkRP.Police.AddUnit("FDNY", ply, "EMS", true, "96-")
	end
})

TEAM_FIREFIGHTER = DarkRP.createJob("Пожарный", {
	description = [[Выезжайте на вызовы и тушите физические возгорания любых видов.]],
	weapons = {"med_pd"},
	command = "firefighter",
	nlrank = {"FDNY", 7},
	max = 6,
	salary = 125,
	online = 2,
	outfit = function(ply, char)
		local rank = MRS.GetPlyRank(ply, "FDNY")
		ply:SetModel("models/cityrp/pm/nypd/" .. char.gender .. "_0" .. char.model .. ".mdl")

		MCR.SetMatCustomByPathName(ply, "rank92", "null")
		MCR.SetMatCustomByPathName(ply, "rankl", "models/gmodbest/acc/rankems")
		MCR.SetMatCustomByPathName(ply, "rank", "models/gmodbest/acc/rankems")
		MCR.SetMatCustomByName(ply, "body_01", "models/gmodbest/acc/body_03")
		MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topfd")
		MCR.SetMatCustomByName(ply, "pants", "models/gmodbest/suit/male/pantsf")

		if rank > 6 then
			MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/" .. (rank == 7 and "topf" or "topc1"))
			MCR.SetMatCustomByName(ply, "hat_01", "models/gmodbest/acc/" .. (rank == 7 and "hat_fd2" or "hat_fd1"))
		end

		if rank < 8 then
			ply:SetBodygroup(1, 0)
			ply:SetBodygroup(2, 2)
			--ply.comfort = 2
		else
			ply:SetBodygroup(5, 1)
		end
	end,
	char = 2,
	npc = "ems",
	stype = "gov",
	spawn_point = Vector(9844.3193359375,1557.5646972656,-103.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 4)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		DarkRP.Police.AddUnit("FDNY", ply, "RESCUE", true, "96-")
	end,
})

TEAM_MAYOR = DarkRP.createJob("Районный Администратор", {
	description = [[Баллотируйтесь на возможность занять наиважнейший пост городской власти. Постарайтесь не разочаровать своих избирателей и следите за экономикой - это в первую очередь скажется на вас. В вашем распоряжении бюджет целого города.]],
	weapons = {},
	command = "mayor",
	max = 1,
	salary = 250,
	online = 3,
	mayor = true,
	stype = "gov",
	customCheck = function(ply) return #team.GetPlayers(TEAM_MAYOR) == 0 end,
	outfit = function(ply, char)
		ply:SetModel("models/cityrp/pm/suit/" .. char.gender .. "_0" .. char.model .. ".mdl")
		ply.insuit = true
		MCR.SetMatID(ply, char.gender, "suit", 0)
		MCR.SetMatID(ply, char.gender, "shirt", 0)
		MCR.SetMatID(ply, char.gender, "spants", 0)

		McINV.InventorySize(ply, 4)
	end,
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 10)
	end,
	PlayerSpawn = function(ply)
		if ply.emsspawned then return end
		ply:ChangeTeam(MCR.DefTeams[ply:getDarkRPVar("character")], true)
		ply:SetSelfDarkRPVar("salary", 0)
		DarkRP.notifyAll(0, 4, "Районный администратор пал!")
	end
})

TEAM_DOC = DarkRP.createJob("Врач", {
	description = [[Оказывайте медицинскую помощь нуждающимся. Помните о клятве Гиппократа.]],
	weapons = {},
	command = "doctor",
	max = 5,
	salary = 200,
	stype = "gov",
	outfit = function(ply, char)
		MCR.SetMatCustom(ply, "top", "gbskins/outfit/top_746")
		MCR.SetMatCustom(ply, "pants", "gbskins/outfit/pants_746")
		MCR.SetMatCustom(ply, "boots", "gbskins/outfit/boots_1")
	end,
	spawn_point = Vector(7540.357421875,5483.2729492188,504.03125),
	online = 2,
	char = 0,
})

TEAM_MED = DarkRP.createJob("Фармацевт", {
	description = [[Производите и продавайте медицинские препараты гражданам. У вас есть разрешение на покупку фармацевтического стола и производство некоторых препаратов строгого оборота. Не забывайте вести учёт полу-легальных препаратов.]],
	weapons = {},
	command = "medpers",
	max = 2,
	salary = 100,
	salary_ds = 265,
	workstations = {
		["pill"] = true,
	},
	stype = "citizens",
	outfit = function(ply, char)
		MCR.SetMatCustom(ply, "top", "gbskins/outfit/top_745")
		MCR.SetMatCustom(ply, "pants", "gbskins/outfit/pants_745")
		MCR.SetMatCustom(ply, "boots", "gbskins/outfit/boots_1")
	end,
	char = 1,
})

TEAM_INS = DarkRP.createJob("Инспектор", {
	description = [[Устраивайте плановые и внеплановые проверки своим коллегам и бизнесам других людей. Ваша прямая обязанность - обеспечение пожарной безопасности.]],
	weapons = {},
	command = "fireuns",
	max = 3,
	salary = 125,
	online = 2,
	stype = "gov",
	outfit = function(ply, char)
		ply:SetModel("models/cityrp/pm/nypd/" .. char.gender .. "_0" .. char.model .. ".mdl")
		MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/" .. char.gender .. "/topf")
		MCR.SetMatCustomByPathName(ply, "rankl", "models/gmodbest/acc/rankems")
		MCR.SetMatCustomByPathName(ply, "rank", "models/gmodbest/acc/rankems")

		MCR.SetMatCustomByName(ply, "body_01", "models/gmodbest/acc/body_03")
	end,
	char = 2,
	rank = {"FDNY", 4},
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 6)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		DarkRP.Police.AddUnit("FDNY", ply, "COM", true, "96-")
	end,
	customCheck = function(ply) return game.GetMap() ~= "rp_southside" end,
	customCheckFailMsg = "Возвращайтесь утром",
	npc = "ems",
	spawn_point = Vector(9844.3193359375,1557.5646972656,-103.96875),
})

TEAM_POLICESV = DarkRP.createJob("Cупервайзер", {
	description = [[Занимайтесь внутренними делами полиции, координируйте и проверяйте офицеров. Вы обязаны работать исключительно из своего участка.]],
	weapons = {"arrest_stick"},
	command = "policesv",
	max = 10,
	salary = 125,
	rank = {"NYPD", 6},
	ispolice = true,
	stype = "gov",
	outfit = function(ply, char)
		SetupPolice(ply, char)
	end,
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("rc", 1)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		DarkRP.Police.AssignUnit(ply, 19)
	end,
	char = 2,
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
})

TEAM_FBI = DarkRP.createJob("Агент", {
	description = [[Сотрудник ФБР.]],
	weapons = {"arrest_stick"},
	command = "fbi",
	rank = {"FBI", 2},
	max = 2,
	char = 0,
	salary = 200,
	stype = "gov",
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
})

TEAM_FBISWAT = DarkRP.createJob("Оперативник ФБР", {
	description = [[Вооружитесь посильнее для проведения антитеррористических операций. В таком обмундировании вы не имеете права заниматься обычной работой полиции - только рейды и нестандартные ситуации.]],
	weapons = {"arrest_stick"},
	time = 150,
	ispolice = true,
	command = "swat",
	outfit = function(ply, char)
		ply:SetMaterial("null")
	end,
	PlayerSpawn = function(ply)
		ply:SetDarkRPVar("hidename", true)
		ply:SetDarkRPVar("scba", 3)
		ply:SetArmor(200)
		ply:SetDarkRPVar("armorVest", 1)
	end,
	max = 5,
	rank = {"NYPD ESU", 2},
	salary = 200,
	char = 0,
	stype = "gov",
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("hidename", true)
		ply:SetDarkRPVar("scba", 3)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		ply:SetDarkRPVar("rc", 3)
		ply.esuteam = true
		DarkRP.Police.AddUnit("NYPD", ply, "ESU", true, "6-")
	end
})

TEAM_ADMIN = DarkRP.createJob("На службе", {
	weapons = {},
	command = "admin",
	max = 4,
	salary = 0,
	char = 0,
	customCheck = function(ply) return CLIENT or ply:IsAdmin() end,
	customCheckFailMsg = "Да",
})

TEAM_LAWYER = DarkRP.createJob("Юрист", {
	description = [[]],
	weapons = {},
	command = "lawyer",
	rank = {"NYC LD", 2},
	max = 3,
	online = 1,
	salary = 100,
	stype = "citizens",
	npc = "",
	char = 1,
})

TEAM_TRAFFIC = DarkRP.createJob("Дорожная служба", {
	description = [[Обеспечивайте безопасность на дорогах без лишнего риска: выписывайте штрафы, следите за трафиком, помогайте офицерам полиции поддерживать порядок в городе.]],
	weapons = {"arrest_stick", "mlw_policelight"},
	time = 130,
	command = "trafficpolice",
	ispolice = true,
	rank = {"NYPD Traffic", 2},
	max = 10,
	salary = 125,
	stype = "gov",
	outfit = function(ply, char)
		ply:SetModel("models/cityrp/pm/nypd/" .. char.gender .. "_0" .. char.model .. ".mdl")
		ply:SetBodygroup(5, 1)
		ply:SetBodygroup(2, 1)

		ply:SetBodygroup(1, 0)
		if char.gender == "male" then
			ply:SetBodygroup(4, 1)
		end

		MCR.SetMatCustomByPathName(ply, "rankl", "models/gmodbest/acc/ranktraf")
		MCR.SetMatCustomByPathName(ply, "rank", "models/gmodbest/acc/ranktraf")
		MCR.SetMatCustomByName(ply, "rank92", "models/gmodbest/acc/ranks/tebn")
		MCR.SetMatCustomByName(ply, "acc/body_01", "models/gmodbest/acc/body_01aux")
		MCR.SetMatCustomByName(ply, "models/gmodbest/acc/armor2", "models/gmodbest/acc/armor2aux")
		MCR.SetMatCustomByName(ply, "top2", "models/gmodbest/suit/male/topcad")
		MCR.SetMatCustomByName(ply, "hat_01", "models/gmodbest/acc/hat_04")
	end,
	char = 2,
	spawn_point = Vector(8890.306640625,7298.548828125,-439.96875),
	PlayerChangeTeam = function(ply)
		ply:SetDarkRPVar("head", nil)
		ply:SetDarkRPVar("vest", nil)
		ply:SetDarkRPVar("face", nil)
		ply:SetDarkRPVar("rc", 1)
		DarkRP.Police.AddUnit("NYPD", ply, "TRAFFIC", " на смене", "BN-")
	end
})