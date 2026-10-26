--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/cardealer/lua/mc_cardealer/sh_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔══╗───╔╗╔══╗───────────╔╗──--
-- ║═╦╩╦╦╗║║║╔╗║╔═╦╦╦═╦╦═╦═╣╚╗─--
-- ║╔╣╬║╔╝║╚╣╠╣║║╬║╔╣╬╠╣╩╣═╣╔╣─--
-- ╚╝╚═╩╝─╚═╩╝╚╝║╔╩╝╚╦╝╠═╩═╩═╝─--
-- ─────────────╚╝───╚═╝───────--
-- ───── By Mactavish ─────────--
McCD.Config.Prew_car = {"audi_a4", "mustanggt", "chaser_simfphys", "sim_fphys_l4d_69sedan", "sim_fphys_l4d_69charger", "sim_fphys_l4d_crownvic"}

-- Позиция гаража
McCD.Config.TunePos = Vector(-6970.53125,1593.59375,-23)

-- Плата за спавн машины
McCD.Config.SpawnFee = 50

McCD.Config.Discount = 1
-- Позиция гаража относительно машины, лучше не трогать

-- Черный список проф для открытия салона
McCD.Config.BlackListJobs = {}

-- Сколько процентов вернется игроку за продажу машины
McCD.Config.RefundPercentage = 70

-- позиции камеры вокруг машины, пресет можно добавить еще, но не советую
McCD.Config.CamPoses = {
	[1] = Angle(25, 0, 0),
	[2] = Angle(25, 60, 0),
	[3] = Angle(25, 120, 0),
	[4] = Angle(25, 180, 0),
	[5] = Angle(25, 240, 0),
	[6] = Angle(25, 300, 0),
}

-- Цыета менюшек, пресет
McCD.Patern = {
	["main"] = Color(255, 147, 0),
	["bg_d"] = Color(10, 10, 10),
	["bg_s"] = Color(35, 35, 35),
	["bg_l"] = Color(42, 42, 42),
	["bg_ls"] = Color(80, 80, 80),
}

McCD.SkinNames = {
	["clear_cars"] = "Заводское",
}

-- Цена за перекраску
McCD.Config.CarColorPrice = 15000
-- Цена за смену скина
McCD.Config.CarSkinPrice = 0

McCD.Config.RandomPlate = 5000

McCD.Config.CoolDown = 21600

-- Дефолтные цвета машин при покупки
McCD.Config.CarColors = {
	{Color(35, 35, 35), "Заводской черный"},
	{Color(200, 200, 200), "Заводской белый"},
	{Color(78, 78, 78), "Заводской серый"},
	{Color(121, 19, 19), "Заводской красный"},
	{Color(23, 24, 119), "Заводской синий"}
}

McCD.Config.SpawnZone = {
	{
		Vector(-7660.060546875, 786.46600341797, -50),
		Vector(-7300, 972.72100830078, 90),
		Angle(0, -90, 0)
	},
	{
		Vector(-7300, 972.72100830078, -50),
		Vector(-7654.2451171875, 1155.8702392578, 90),
		Angle(0, -90, 0)
	},
	{
		Vector(-7654.2451171875, 1155.8702392578, -50),
		Vector(-7300, 1338.5607910156, 90),
		Angle(0, -90, 0)
	},
	{
		Vector(-6679.8002929688, 788.38861083984, -50),
		Vector(-6975.5708007813, 971.95965576172, 90),
		Angle(0, 90, 0)
	},
	{
		Vector(-6975.5708007813, 971.95965576172, -50),
		Vector(-6679.880859375, 1156.6435546875, 90),
		Angle(0, 90, 0)
	},
	{
		Vector(-6679.880859375, 1156.6435546875, -50),
		Vector(-6975.64453125, 1338.8697509766, 90),
		Angle(0, 90, 0)
	},
}

for k,zone in pairs(McCD.Config.SpawnZone) do
	debugoverlay.Line( zone[1], zone[2], 12, HSVToColor(k * 70, 1, 1))

end

--McCD.Config.CarColorNames = {

McCD.Config.TuneColors = {
	{Color(200, 200, 200), 15000},
	{Color(35, 35, 35), 15000},
	{Color(78, 78, 78), 15000},
	{Color(121, 19, 19), 15000},
	{Color(23, 24, 119), 15000},
	{Color(255, 223, 127), 15000},
	--
	{Color(235, 0, 0), 90000},
	{Color(235, 36, 5), 90000},
	{Color(196, 15, 15), 80000},
	{Color(136, 30, 30), 35000},
	{Color(192, 57, 43), 80000},
	{Color(160, 6, 24), 60000},
	{Color(60, 0, 0), 60000},
	{Color(99, 4, 42), 80000},
	{Color(197, 97, 112), 100000},
	{Color(211, 114, 175), 100000},
	{Color(85, 22, 59), 80000},
	{Color(88, 52, 56), 100000},
	{Color(39, 4, 8), 80000},
	--
	{Color(187, 76, 3), 80000},
	{Color(96, 61, 43), 55000},
	{Color(39, 15, 3), 80000},
	{Color(223, 74, 29), 100000},
	{Color(247, 168, 0), 55000},
	{Color(207, 168, 11), 55000},
	{Color(206, 112, 30), 35000},
	{Color(255, 113, 42), 55000},
	{Color(182, 142, 56), 55000},
	{Color(201, 124, 8), 55000},
	{Color(212, 176, 57), 55000},
	{Color(108, 100, 78), 35000},
	--
	{Color(52, 94, 5), 45000},
	{Color(7, 80, 7), 100000},
	{Color(58, 85, 34), 40000},
	{Color(2, 153, 57), 100000},
	{Color(3, 39, 15), 85000},
	{Color(25, 105, 25), 85000},
	{Color(18, 134, 111), 55000},
	{Color(15, 29, 25), 55000},
	{Color(33, 148, 81), 55000},
	{Color(61, 67, 54), 35000},

	--
	{Color(66, 68, 145), 55000},
	{Color(30, 109, 161), 100000},
	{Color(64, 71, 77), 85000},
	{Color(135, 197, 245), 85000},
	{Color(127, 159, 255), 85000},
	{Color(101, 60, 163), 100000},
	{Color(124, 116, 185), 85000},
	{Color(0, 0, 80), 95000},
	{Color(29, 29, 172), 85000},
	{Color(0, 0, 0), 85000},
	{Color(37, 96, 207), 100000},
	{Color(81, 139, 146), 55000},
	{Color(44, 68, 92), 35000},
	{Color(135, 73, 160), 100000},
	{Color(75, 10, 85), 100000},
	{Color(38, 36, 40), 35000},
	--
	{Color(104, 106, 108), 45000},
	{Color(163, 168, 172), 45000},
	{Color(88, 101, 102), 35000},
	{Color(255, 240, 240), 90000},
	{Color(255, 255, 255), 90000},
	{Color(19, 4, 43), 35000},
	{Color(10, 10, 10), 35000},
	{Color(51, 58, 52), 35000},
	{Color(48, 50, 50), 35000},
}

McCD.Config.TuneColorsForm = nil
-- Цвета перекраски машины после покупки
-- McCD.Config.TuneCarColors = {
-- }

-- Неоны
McCD.Config.Neon = {
	[0] = {"Нет"},
	[1] = {"Красный", Color(127, 0, 0)},
	[2] = {"Розовый", Color(150, 0, 115)},
	[3] = {"Желтый", Color(213, 198, 0)},
	[4] = {"Оранжевый", Color(195, 117, 0)},
	[5] = {"Зеленый", Color(45, 85, 0)},
	[6] = {"Синий", Color(0, 64, 255)},
	[7] = {"Белый", Color(255, 255, 255)},
	[8] = {"Бирюзовый", Color(26, 188, 156)},
	[9] = {"Ярко-фиолетовый", Color(96, 62, 148)},
	[10] = {"Фиолетовый", Color(111, 0, 255)},
	[11] = {"Ярко-розовый", Color(247, 136, 206)},
	[12] = {"Лайм", Color(206, 250, 5)},
	[13] = {"Токсичный зелёный", Color(55, 255, 1)},
	[14] = {"Ярко оранжевый", Color(251, 86, 4)},
	[15] = {"Сладкий-розовый", Color(249, 82, 107)},
	[16] = {"Аква Блю", Color(123, 255, 255)},
}

McCD.Config.Smoke = {
	[0] = {"Нет"},
	[1] = {"Красный", Color(88, 36, 36)},
	[2] = {"Розовый", Color(160, 84, 113)},
	[3] = {"Желтый", Color(151, 148, 97)},
	[4] = {"Оранжевый", Color(158, 126, 78)},
	[5] = {"Зеленый", Color(75, 90, 57)},
	[6] = {"Синий", Color(49, 70, 133)},
	[7] = {"Белый", Color(196, 196, 196)},
	[8] = {"Бирюзовый", Color(77, 119, 111)},
	[9] = {"Ярко-фиолетовый", Color(127, 109, 153)},
	[10] = {"Фиолетовый", Color(81, 68, 99)},
	[11] = {"Ярко-розовый", Color(155, 93, 132)},
	[12] = {"Лайм", Color(107, 116, 67)},
	[13] = {"Токсичный зелёный", Color(70, 136, 52)},
	[14] = {"Ярко оранжевый", Color(172, 105, 72)},
	[15] = {"Пыльный", Color(102, 85, 88)},
	[16] = {"Аква Блю", Color(91, 156, 156)},
}

-- Цена за неон
McCD.Config.TireSmokePrice = 10000
McCD.Config.NeonPrice = 500
-- цена за тюнинг
McCD.Config.BodyGroupPrice = 950
-- цена за радио
McCD.Config.RadioPrice = 1000
-- цена за пуленепробиваемые шины
McCD.Config.BpwPrice = 60000

McCD.Config.BannedBodyGroup = {
	["front_plate"] = true,
	["rear_plate"] = true,
	["plate"] = true,
}

McCD.Config.BodyGroupNames = {
	["hood"] = {"Капот", 3, 110},
	["headlights"] = {"Фары", 2, 110},
	["headlights_bodykit"] = {"Фары", 2, 110},
	["front_bumper"] = {"Передний бампер", 2, 110},
	["bonnet"] = {"Капот", 2, 110},
	["rear_bumper"] = {"Задний бампер", 5, 110},
	["rear_plate"] = {"Задний номер", 5, 90},
	["front_plate"] = {"Передний номер", 2, 90},
	["wing"] = {"Спойлер", 5, 110},
	["sideskirt"] = {"Боковая юбка", 3, 90},
	["bodykit"] = {"Кузов", 3, 90},
	["wheel"] = {"Колеса", 4, 90},
	["fenders"] = {"Крылья", 4, 90},
	["mirrors"] = {"Зеркала", 4, 90},
	["rear_window_blind"] = {"Шторка заднего стекла", 5, 110},
	["rollcage"] = {"Каркас безопасности", 1, 110}
}

-- Звуки гудков и их цена (цена в конце)
McCD.Config.Horns = {
	{"Обычный #1", "left4dead/vehicles/vic_horn.wav", 100},
	{"Обычный #2", "left4dead/vehicles/truck_nuke_horn.wav", 100},
	{"Обычный #3", "left4dead/vehicles/sedan95_horn.wav", 100},
	{"Обычный #4", "left4dead/vehicles/sedan84_horn.wav", 100},
	{"Обычный #5", "left4dead/vehicles/pickup2004_horn.wav", 100},
	{"Обычный #6", "left4dead/vehicles/pickup78_horn.wav", 100},
	{"Обычный #7", "left4dead/vehicles/hatch_horn.wav", 100},
	{"Обычный #8", "left4dead/vehicles/deliveryvan_horn.wav", 100},
	{"Обычный #9", "left4dead/vehicles/van_horn.wav", 100},
	{"Тяжелый #1", "left4dead/vehicles/semi_horn.wav", 1200},
	{"Тяжелый #2", "left4dead/vehicles/apfuel_horn.wav", 1200},
	{"Тяжелый #3", "left4dead/vehicles/longnose_horn.wav", 1200},
	{"Тяжелый #4", "left4dead/vehicles/flatnose_horn.wav", 1200},
	{"Тяжелый #5", "left4dead/vehicles/hmmwv_horn.wav", 5000},
	{"Особый #1", "simulated_vehicles/horn_4.wav", 9000},
	{"Особый #2", "vcmod/horn/general_lee.wav", 57000},
}

-- цена за улучшение двигателя
McCD.Config.Nitro = {
	[0] = 0,
	[1] = 9000,
	[2] = 22000,
	[3] = 25000,
}

McCD.Config.NitroNames = {
	[0] = "Заводская конфигурация",
	[1] = "Пользовательская конфигурация",
	[2] = "Спортивная конфигурация",
	[3] = "Раллийная конфигурация",
}

McCD.Config.Plates = {
	[0] = {"Стандартный", "", 0},
	[1] = {"Штат Нью-Йорк", "models/left4dead/vehicles/plate/l4d_front3", 10},
	[2] = {"Эмпайр-стейт #1", "models/left4dead/vehicles/plate/l4d_front1", 30},
	[3] = {"Эмпайр-стейт #2", "models/left4dead/vehicles/plate/l4d_front2", 30},
}

McCD.Config.SuperCharger = 30000
McCD.Config.TurboCharger = 15000

-- цена за улучшение тормозов
McCD.Config.Breaks = {
	[0] = 0,
	[1] = 1500,
	[2] = 3000,
	[3] = 5000,
}

McCD.Config.BreaksNames = {
	[0] = "Заводские тормоза",
	[1] = "Улучшенные задние тормоза",
	[2] = "Улучшенная тормозная система",
	[3] = "Спортивная тормозная система",
}

-- цена за улучшение подвески
McCD.Config.SuspensionPrice = 3000

McCD.Config.Suspension = {
	{0, "Заводская", 1000},
	{-0.5, "Заниженная", 3000},
	{0.3, "Завышенная", 3000},
}

function McCD.GetSpawnFee(car, blown)
	local price = car.donate and car.originalprice * 150 or car.originalprice

	if blown then
		return math.Round(math.max(price * 0.005, 600))
	else
		return math.Round(math.Clamp(price * 0.0005, 50, car.donate and 250 or 170))
	end
end

local csp = Vector(2706.9255371094,-1762.6270751953,-100)
McCD.LastChoper = nil
function McCD.ChopShop(ply, check)
	if not ply then return end

	if GetGlobalInt("LslChopShop") + 2400 > CurTime() then
		return "Слушай, мы тут немного.. заняты. Понимаешь в каком смысле, да?", "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/1.mp3", {{"Окей.", "close"}}
	end

	if McCD.LastChoper and McCD.LastChoper == ply:SteamID() then
		return "Слушай, мы тут немного.. заняты. Понимаешь в каком смысле, да?", "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/1.mp3", {{"Окей.", "close"}}
	end

	if ply:Team() ~= 2 then
		return "Ты кто?",  "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/1_2.mp3", {{"...", "close"}}
	end

	if ply:isWanted() then
		return "Гой, а вы кто? Не вас ли случаем полиция ищет?",  "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/1_3.mp3", {{"Тьфу!", "close"}}
	end

	for k,v in pairs(DarkRP.GetPolice()) do
		if DarkRP.InRangeVector(GAMEMODE.Config.ChopShop[1], v:GetPos(), 1700) then
			return "..А документы? Ключи? Права водительские? Вы поймите, идише шобла коп-ы..", "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/2.mp3", {{"..Коп-ы? А, всё, дошло. Потом заеду.", "close"}}
		end
	end

	local found_car

	for k, ent in ipairs(ents.FindInBox(GAMEMODE.Config.ChopShop[1], GAMEMODE.Config.ChopShop[2])) do
		if ent:GetClass() ~= "gmod_sent_vehicle_fphysics_base" then continue end

		if GAMEMODE.Config.GovCars[ent:GetSpawn_List()] or ent.IsECPDVeh then
			return "Гой, ты совсем шикер хозар?! Убирай это отсюда немедленно!", "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/3.mp3", {{"Не кричи ты так!", "close"}}
		end

		found_car = ent
	end

	if not IsValid(found_car) then
		return "Гой, так ты приведи её сюда, да?", "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/3_2.mp3", {{"Привезу..", "close"}}
	end

	if found_car.Owner and IsValid(found_car.Owner) and DarkRP.InRangeVector(GAMEMODE.Config.ChopShop[1], found_car.Owner:GetPos(), 1700) then
		return "..А документы? Ключи? Права водительские?", "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/3_3.mp3", {{"Потом заеду.", "close"}}
	end

	local price = found_car.McCD_CarData and McCD.GetSpawnFee(found_car.McCD_CarData, true) or 600
	price = price * 0.9

	price = math.max(30, price * (found_car:GetHullHealth() / found_car:GetMaxHealth()))

	if istable(found_car.Wheels) then
		for i = 1, table.Count(found_car.Wheels) do
			if IsValid(found_car.Wheels[i]) and found_car.Wheels[i]:GetDamaged() then
				price = math.max(30, price - 30)
			end
		end
	end

	price = math.Round(price)

	if SERVER and not check then
		if found_car.McCD_CarDataId and found_car.Owner and IsValid(found_car.Owner) then
			McCD.AddCarParameter(found_car.Owner, found_car.McCD_CarDataId, {
				wci = true,
				radio = false,
				wcitimer = os.time() + math.random(18, 24) * 200
			}, found_car)
		end

		DarkRP.log("crime", ply, found_car.Owner, " сдал машину " .. (found_car.McCD_UniqueId or "NIL"), nil, price)

		found_car:Remove()
		McCD.LastChoper = ply:SteamID()

		ply:addMoney(price)

		SetGlobalInt("LslChopShop", CurTime())

		local door = ents.GetMapCreatedEntity(GAMEMODE.Config.JunkDoor)
		door:Fire("Close")
		door:Fire("lock", "", .1)
		timer.Create("UnlockDoors", 2400, 1, function()
			if IsValid(door) then
				door:Fire("unlock", "", 0)
			end

			if IsValid(McCD.LastModel) then
				McCD.LastModel:Remove()
			end
		end)

		if IsValid(McCD.LastModel) then
			McCD.LastModel:Remove()
		end

		local prop = ents.Create("prop_physics")
		prop:SetModel(found_car:GetModel())
		prop:SetColor(found_car:GetColor())
		prop:SetSkin(found_car:GetSkin())
		prop:SetPos(csp)
		prop:SetAngles(Angle(0,0,0))
		prop:Spawn()

		McCD.LastModel = prop

		timer.Simple(1, function()
			if IsValid(McCD.LastModel) then
				local phys = McCD.LastModel:GetPhysicsObject()

				if IsValid(phys) then
					phys:Wake()
					phys:EnableMotion(false)
				end
			end
		end)
	end

	return (price > 500 and "Ой-вей! Кошерно, кошерно! Могу предложить за такую красоту " or "Гой, тут максимум на " ) .. price .. "$.", price > 500 and "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/4.mp3" or "https://macnco.one/cityrp/npcsound/junkyard_temp/auto/4_2.mp3", {{"По рукам!", "ChopShop"},{"Нет, так не пойдёт!", "close"},}
end