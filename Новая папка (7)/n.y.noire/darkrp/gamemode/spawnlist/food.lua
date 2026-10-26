--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/spawnlist/food.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- SHOPS FASTFOOD
DarkRP.Food["pop_cola"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/cancola",
	sound = "can",
	name = "Напиток Cola",
	delay = 3.9,
	weight = 0.3,
	energy = 5,
	maxenergy = 50,
	thirst = 70,
	price = 2,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pop_cherry"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/cancherry",
	sound = "can",
	name = "Напиток Cherry",
	delay = 3.9,
	weight = 0.3,
	energy = 5,
	maxenergy = 50,
	thirst = 70,
	price = 2,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pop_life"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/canlife",
	sound = "can",
	name = "Напиток BlueEnergy",
	delay = 3.9,
	weight = 0.3,
	energy = 5,
	maxenergy = 50,
	thirst = 70,
	stamina = 50,
	price = 12,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pop_fanta"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/canfanta",
	sound = "can",
	name = "Напиток Миренда",
	delay = 3.9,
	weight = 0.3,
	energy = 5,
	maxenergy = 50,
	thirst = 70,
	price = 2,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pop_sprite"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/cansprite",
	sound = "can",
	name = "Напиток SweetSweat",
	delay = 3.9,
	weight = 0.3,
	energy = 5,
	maxenergy = 50,
	thirst = 70,
	price = 2,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pop_damage"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/canmd",
	sound = "can",
	name = "Напиток ED",
	delay = 3.9,
	weight = 0.3,
	energy = 5,
	maxenergy = 50,
	thirst = 70,
	stamina = 10,
	price = 2,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pop_whater"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/canwater",
	sound = "can",
	name = "Банка воды",
	delay = 3.9,
	weight = 0.3,
	energy = 0,
	thirst = 80,
	price = 1,
	noweb = true
}

DarkRP.Food["pop_carb"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/cancarb",
	sound = "can",
	name = "Банка содовой",
	delay = 3.9,
	weight = 0.3,
	energy = 0,
	thirst = 80,
	price = 1,
	noweb = true
}

DarkRP.Food["chips_small"] = {
	model = "models/meth2/meth_ziplock_small.mdl",
	material = "gbskins/chips1",
	sound = "chips",
	name = "Чипсы",
	delay = 7.6,
	weight = 0.1,
	energy = 50,
	maxenergy = 180,
	thirst = -5,
	price = 3,
}

DarkRP.Food["chips_twist"] = {
	model = "models/foodnhouseholditems/chipstwisties.mdl",
	sound = "chips",
	name = "Чипсы",
	delay = 7.6,
	weight = 0.3,
	energy = 90,
	maxenergy = 180,
	thirst = -10,
	price = 3,
	shop = "shop",
	noweb = true
}

DarkRP.Food["chips_dorit"] = {
	model = "models/foodnhouseholditems/chipsdoritos.mdl",
	sound = "chips",
	name = "Чипсы",
	delay = 7.6,
	weight = 0.3,
	energy = 90,
	maxenergy = 180,
	thirst = -10,
	price = 3,
	shop = "shop",
	noweb = true
}

DarkRP.Food["chips_lays"] = {
	model = "models/foodnhouseholditems/chipslays.mdl",
	sound = "chips",
	name = "Чипсы",
	delay = 7.6,
	weight = 0.3,
	energy = 90,
	maxenergy = 180,
	thirst = -10,
	price = 3,
	shop = "shop",
	noweb = true
}

DarkRP.Food["chips_cookie"] = {
	model = "models/props_interiors/goodtimewafers_blue.mdl",
	sound = "chips",
	name = "Печенье",
	delay = 7.6,
	weight = 0.2,
	energy = 90,
	maxenergy = 180,
	thirst = -10,
	price = 3,
	shop = "shop",
	noweb = true
}

DarkRP.Food["chips_chocookie"] = {
	model = "models/props_interiors/tntcandy.mdl",
	sound = "chips",
	name = "Печенье",
	delay = 7.6,
	weight = 0.2,
	energy = 90,
	maxenergy = 180,
	thirst = -10,
	price = 3,
	shop = "shop",
	noweb = true
}

DarkRP.Food["chocolate"] = {
	model = "models/foodnhouseholditems/marabou1.mdl",
	sound = "crunch",
	name = "Шоколад",
	delay = 2.7,
	weight = 0.15,
	energy = 110,
	maxenergy = 180,
	hunger = 30,
	thirst = -15,
	price = 15,
	noweb = true
}

DarkRP.Food["choco"] = {
	model = "models/props_interiors/chocobits_gold.mdl",
	rmdls = {"models/props_interiors/chocobits_black.mdl", "models/props_interiors/chocobits_gold.mdl", "models/props_interiors/chocobits_silver.mdl"},
	sound = "crunch",
	name = "Шоколад",
	delay = 2.7,
	weight = 0.1,
	energy = 90,
	maxenergy = 180,
	hunger = 30,
	thirst = -15,
	price = 15,
	shop = "shop",
	noweb = true
}

DarkRP.Food["kkkk"] = {
	model = "models/props_interiors/plentygood_chocobar.mdl",
	rmdls = {"models/props_interiors/munch_blue_chocobar.mdl", "models/props_interiors/munch_green_chocobar.mdl", "models/props_interiors/munch_orange_chocobar.mdl", "models/props_interiors/plentygood_chocobar.mdl"},
	sound = "crunch",
	name = "Шоколадка",
	delay = 2.7,
	weight = 0.07,
	energy = 70,
	maxenergy = 180,
	hunger = 20,
	thirst = -10,
	price = 7,
	shop = "shop",
	noweb = true
}

DarkRP.Food["noodles"] = {
	model = "models/fg/dohik.mdl",
	sound = "crunch",
	name = "Лапша",
	delay = 2.7,
	weight = 0.2,
	energy = 10,
	maxenergy = 180,
	thirst = 0,
	price = 1,
	shop = "shop",
}

DarkRP.Food["rice"] = {
	model = "models/cityrp/box0.mdl",
	material = "gbskins/box_rice",
	sound = "crunch",
	name = "Рис",
	uses = 5,
	delay = 2.7,
	weight = 0.15,
	energy = 75,
	maxenergy = 180,
	thirst = -150,
	price = 3,
	shop = "shop",
}

DarkRP.Food["nori"] = {
	model = "models/cityrp/box1.mdl",
	material = "gbskins/nori",
	sound = "crunch",
	name = "Нори",
	uses = 2,
	delay = 2.7,
	weight = 0.25,
	energy = 30,
	maxenergy = 180,
	thirst = 0,
	price = 7,
	shop = "shop",
}

DarkRP.Food["cereal"] = {
	model = "models/foodnhouseholditems/chocorings.mdl",
	sound = "crunch2",
	name = "Хлопья",
	delay = 4.3,
	weight = 0.5,
	energy = 100,
	maxenergy = 180,
	thirst = -20,
	price = 6,
	shop = "shop",
	noweb = true
}

DarkRP.Food["spam"] = {
	model = "models/food/fl/cram.mdl",
	sound = "crunch2",
	name = "Консервы (ветчина)",
	uses = 3,
	conwht = 0.1,
	delay = 4.3,
	weight = 0.15,
	energy = 70,
	maxenergy = 220,
	thirst = -40,
	price = 7,
	shop = "shop",
	noweb = true
}

DarkRP.Food["noodles_cooked"] = {
	model = "models/props_junk/garbage_takeoutcarton001a.mdl",
	material = "gbskins/garbage_items",
	sound = "eating2",
	name = "Китайская лапша",
	delay = 3.7,
	weight = 0.2,
	energy = 90,
	maxenergy = 220,
	btime = 1800,
	thirst = 0,
	price = 6,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pizza"] = {
	model = "models/foodnhouseholditems/pizzaslice.mdl",
	sound = "eating2",
	name = "Кусок пиццы",
	delay = 3.7,
	weight = 0.1,
	energy = 34,
	maxenergy = 220,
	btime = 1200,
	thirst = 0,
	price = 1,
}
-- SHOPS
DarkRP.Food["joose"] = {
	model = "models/foodnhouseholditems/juice2.mdl",
	material = "gbskins/joose1",
	sound = "whater",
	name = "Сок кактусовый",
	delay = 3.3,
	weight = 0.5,
	energy = 30,
	maxenergy = 50,
	thirst = 120,
	price = 8,
	shop = "shop",
	noweb = true
}

DarkRP.Food["joose2"] = {
	model = "models/foodnhouseholditems/juice2.mdl",
	material = "gbskins/joose2",
	sound = "whater",
	name = "Сок огурцовый",
	delay = 3.3,
	weight = 0.5,
	energy = 30,
	maxenergy = 50,
	thirst = 120,
	price = 8,
	shop = "shop",
	noweb = true
}

DarkRP.Food["joose3"] = {
	model = "models/foodnhouseholditems/juice2.mdl",
	material = "gbskins/joose3",
	sound = "whater",
	name = "Сок обыкновенный",
	delay = 3.3,
	weight = 0.5,
	energy = 30,
	maxenergy = 50,
	thirst = 120,
	price = 8,
	shop = "shop",
	noweb = true
}

DarkRP.Food["toffi"] = {
	model = "models/props_interiors/krispwafers_orange.mdl",
	rmdls = {"models/props_interiors/krispwafers_orange.mdl", "models/props_interiors/krispwafers_yellow.mdl", "models/props_interiors/krispwafers_blue.mdl"},
	sound = "crunch",
	name = "Конфетки",
	delay = 2.7,
	weight = 0.2,
	energy = 70,
	maxenergy = 180,
	hunger = 10,
	thirst = 0,
	price = 10,
	shop = "shop",
	noweb = true
}

DarkRP.Food["sugar"] = {
	model = "models/foodnhouseholditems/coffee_nescafe.mdl",
	submat = {
		[0] = "gbskins/nescafes"
	},
	sound = "crunch",
	name = "Сахар",
	delay = 2.7,
	weight = 0.05,
	conwht = 0.09,
	energy = 20,
	maxenergy = 50,
	thirst = -20,
	toxic = 3,
	price = 4,
	uses = 5,
	shop = "shop",
	noweb = true
}

DarkRP.Food["whater"] = {
	model = "models/props/cs_office/Water_bottle.mdl",
	material = "gb_foods/pure",
	sound = "whater",
	name = "Бутылка воды",
	delay = 3.3,
	weight = 0.5,
	energy = 0,
	thirst = 110,
	price = 1,
	shop = "shop",
	noweb = true
}

DarkRP.Food["whater_jug"] = {
	model = "models/props_junk/garbage_milkcarton001a.mdl",
	sound = "whater",
	name = "Бутыль с водой 3л.",
	delay = 3.3,
	weight = 0.5,
	energy = 0,
	thirst = 110,
	uses = 6,
	price = 5,
	shop = "shop",
}

DarkRP.Food["whater_carb"] = {
	model = "models/props/cs_office/Water_bottle.mdl",
	material = "gb_foods/carbon",
	sound = "soda",
	name = "Бутылка содовой",
	delay = 4.7,
	weight = 0.5,
	energy = 0,
	thirst = 110,
	price = 1,
	shop = "shop",
	noweb = true
}
-- FRUIT HEALTHY
DarkRP.Food["melon"] = {
	model = "models/props_junk/watermelon01_chunk01b.mdl",
	sound = "crunch2",
	name = "Арбуз",
	delay = 4.3,
	weight = 0.2,
	energy = 10,
	maxenergy = 220,
	thirst = 80,
	price = 15,
	btime = 36400,
	hunger = 30
}

DarkRP.Food["banana"] = {
	model = "models/props/cs_italy/bananna.mdl",
	sound = "crunch",
	name = "Банан",
	delay = 2.7,
	weight = 0.2,
	energy = 60,
	maxenergy = 220,
	thirst = 20,
	price = 3,
	hunger = 20,
	btime = 36400,
	shop = "shop",
}

DarkRP.Food["apple"] = {
	model = "models/foodnhouseholditems/apple1.mdl",
	sound = "crunch",
	name = "Яблоко",
	delay = 2.7,
	weight = 0.2,
	energy = 60,
	maxenergy = 220,
	thirst = 20,
	price = 3,
	hunger = 20,
	btime = 36400,
	shop = "shop",
}

DarkRP.Food["orange"] = {
	model = "models/props/cs_italy/orange.mdl",
	sound = "crunch",
	name = "Апельсин",
	delay = 2.7,
	weight = 0.2,
	energy = 50,
	maxenergy = 220,
	thirst = 30,
	price = 3,
	hunger = 20,
	btime = 36400,
	shop = "shop",
}

DarkRP.Food["lemon"] = {
	model = "models/food/fruit_lemon.mdl",
	sound = "crunch",
	name = "Лимон",
	delay = 2.7,
	weight = 0.2,
	energy = 30,
	maxenergy = 220,
	thirst = 20,
	price = 4,
	hunger = 15,
	btime = 36400,
	shop = "shop",
}

DarkRP.Food["lime"] = {
	model = "models/food/fruit_lime.mdl",
	sound = "crunch",
	name = "Лайм",
	delay = 2.7,
	weight = 0.2,
	energy = 30,
	maxenergy = 220,
	thirst = 20,
	price = 4,
	hunger = 15,
	btime = 36400,
	shop = "shop",
}

DarkRP.Food["ananas"] = {
	model = "models/foodandhouseholditems/pineapple.mdl",
	sound = "crunch",
	name = "Ананас",
	uses = 2,
	delay = 2.7,
	weight = 0.2,
	energy = 30,
	maxenergy = 220,
	thirst = 20,
	price = 7,
	hunger = 20,
	btime = 36400,
	shop = "shop",
}

DarkRP.Food["milk"] = {
	model = "models/props_junk/garbage_milkcarton002a.mdl",
	material = "gbskins/garbage_items",
	sound = "whater",
	name = "Молоко",
	delay = 3.3,
	weight = 1,
	energy = 50,
	maxenergy = 220,
	btime = 7200,
	thirst = 120,
	price = 6,
	shop = "shop",
}

DarkRP.Food["cheese"] = {
	model = "models/food/meal_cheese01c.mdl",
	sound = "eating",
	name = "Сыр",
	delay = 2.3,
	weight = 0.3,
	energy = 70,
	maxenergy = 220,
	btime = 8200,
	thirst = 0,
	price = 14,
	shop = "shop",
}

DarkRP.Food["bread"] = {
	model = "models/food/props_shops/prop_bakery_bread_04_a.mdl",
	sound = "crunch2",
	name = "Батон хлеба",
	delay = 4.3,
	weight = 0.2,
	energy = 120,
	maxenergy = 180,
	btime = 7200,
	thirst = 0,
	price = 4,
	shop = "shop",
}
-- VEGETABLES
DarkRP.Food["potato"] = {
	model = "models/food/fnv/potato1.mdl",
	sound = "crunch",
	name = "Картофель",
	delay = 2.7,
	weight = 0.2,
	energy = 20,
	maxenergy = 50,
	thirst = 0,
	price = 2,
	shop = "shop",
}

DarkRP.Food["leek"] = {
	model = "models/food/alchemy/ingredonion.mdl",
	sound = "crunch",
	name = "Лук",
	delay = 2.7,
	weight = 0.2,
	energy = 20,
	maxenergy = 50,
	thirst = -5,
	price = 2,
	shop = "shop",
}

DarkRP.Food["garleek"] = {
	model = "models/food/garlic.mdl",
	sound = "crunch",
	name = "Чеснок",
	uses = 6,
	delay = 2.7,
	weight = 0.1,
	energy = 10,
	maxenergy = 50,
	thirst = -5,
	price = 6,
	shop = "shop",
}

DarkRP.Food["lettuce"] = {
	model = "models/foodnhouseholditems/lettuce.mdl",
	sound = "crunch",
	name = "Лист салата",
	delay = 2.7,
	weight = 0.2,
	energy = 20,
	maxenergy = 50,
	btime = 36400,
	thirst = 0,
	price = 2,
	shop = "shop",
}

DarkRP.Food["tomato"] = {
	model = "models/foodnhouseholditems/tomato.mdl",
	sound = "crunch",
	name = "Помидор",
	delay = 2.7,
	weight = 0.2,
	energy = 20,
	maxenergy = 220,
	btime = 36400,
	thirst = 5,
	price = 2,
	shop = "shop",
}
-- MEATS
DarkRP.Food["meat_row"] = {
	model = "models/food/fl/molemeatsteak.mdl",
	sound = "eating2",
	name = "Сырое мясо",
	delay = 3.7,
	weight = 0.4,
	energy = 10,
	maxenergy = 50,
	btime = 3600,
	thirst = 0,
	price = 16,
	toxic = 10,
	shop = "shop",
}

DarkRP.Food["feesh_row"] = {
	model = "models/food/warband/fish.mdl",
	sound = "eating2",
	name = "Сырая рыба",
	delay = 3.7,
	weight = 0.4,
	energy = 10,
	maxenergy = 50,
	btime = 3600,
	thirst = 0,
	price = 12,
	toxic = 15,
	shop = "shop",
}

DarkRP.Food["chicken_row"] = {
	model = "models/food/chicken/roasted_chicken.mdl",
	material = "models/chicken/chiken02",
	sound = "eating2",
	name = "Сырая курица",
	uses = 4,
	delay = 3.7,
	weight = 0.4,
	energy = 30,
	maxenergy = 50,
	btime = 3600,
	thirst = 0,
	price = 10,
	toxic = 15,
	shop = "shop",
}

DarkRP.Food["bacon_row"] = {
	model = "models/foodnhouseholditems/bacon.mdl",
	sound = "eating",
	name = "Сырой бекон",
	delay = 2.3,
	weight = 0.1,
	energy = 10,
	maxenergy = 50,
	btime = 3600,
	thirst = 0,
	toxic = 10,
	price = 6,
	shop = "shop",
}

DarkRP.Food["egg_row"] = {
	model = "models/foodnhouseholditems/egg_box4.mdl",
	sound = "crunch",
	name = "Лоток яиц",
	uses = 6,
	delay = 2.7,
	weight = 0.05,
	conwht = 0.05,
	btime = 7200,
	energy = 30,
	maxenergy = 50,
	thirst = 0,
	toxic = 1,
	price = 12,
	shop = "shop",
}

DarkRP.Food["soy_bean"] = {
	model = "models/food/dr2/beans.mdl",
	sound = "eating",
	name = "Соевые бобы",
	uses = 2,
	delay = 2.3,
	weight = 0.2,
	energy = 40,
	maxenergy = 220,
	thirst = 0,
	price = 12,
	shop = "shop",
}
-- SOOS
DarkRP.Food["sauce1"] = {
	model = "models/foodnhouseholditems/ketchup.mdl",
	material = "models/foodnhouseholditems/ketcup01",
	sound = "eating2",
	name = "Кетчуп",
	uses = 5,
	delay = 3.7,
	weight = 0.1,
	energy = 10,
	maxenergy = 50,
	thirst = -50,
	price = 5,
	shop = "shop",
}

DarkRP.Food["sauce2"] = {
	model = "models/foodnhouseholditems/ketchup.mdl",
	material = "models/foodnhouseholditems/ketcup02",
	sound = "eating2",
	name = "Горчица",
	uses = 5,
	delay = 3.7,
	weight = 0.1,
	energy = 10,
	maxenergy = 50,
	thirst = -50,
	price = 6,
	shop = "shop",
}

DarkRP.Food["sauce3"] = {
	model = "models/foodnhouseholditems/ketchup.mdl",
	material = "models/foodnhouseholditems/ketcup03",
	sound = "eating2",
	name = "Майонез",
	uses = 5,
	delay = 3.7,
	weight = 0.1,
	energy = 20,
	maxenergy = 50,
	thirst = -25,
	price = 5,
	shop = "shop",
}

DarkRP.Food["sauce4"] = {
	model = "models/foodnhouseholditems/ketchup.mdl",
	material = "models/foodnhouseholditems/ketcup04",
	sound = "eating2",
	name = "Соус Барбекю",
	uses = 5,
	delay = 3.7,
	weight = 0.1,
	energy = 10,
	maxenergy = 50,
	thirst = -50,
	price = 6,
	shop = "shop",
}

DarkRP.Food["sauce5"] = {
	model = "models/foodnhouseholditems/ketchup.mdl",
	material = "models/foodnhouseholditems/ketcup05",
	sound = "eating2",
	name = "Соевый соус",
	uses = 5,
	delay = 3.7,
	weight = 0.1,
	energy = 15,
	maxenergy = 50,
	thirst = -50,
	price = 7,
	shop = "shop",
}
-- COOKED FAST
DarkRP.Food["noodles_spam"] = {
	model = "models/food/fl/noodles.mdl",
	sound = "eating2",
	name = "Спамен",
	delay = 3.7,
	weight = 0.1,
	energy = 155,
	thirst = 0,
	hunger = 60,
	maxenergy = 250,
	btime = 7200,
	price = 5
}

DarkRP.Food["noodles_home"] = {
	model = "models/food/dr2/pasta.mdl",
	sound = "eating2",
	name = "Макароны",
	delay = 3.7,
	weight = 0.1,
	energy = 105,
	thirst = 0,
	hunger = 30,
	maxenergy = 250,
	btime = 7200,
	price = 6
}

DarkRP.Food["egg"] = {
	model = "models/foodnhouseholditems/egg.mdl",
	sound = "eating2",
	name = "Яичница",
	delay = 3.7,
	weight = 0.1,
	energy = 115,
	thirst = 5,
	hunger = 120,
	maxenergy = 250,
	btime = 7200,
	price = 3
}

DarkRP.Food["bacon"] = {
	model = "models/foodnhouseholditems/baconcooked.mdl",
	sound = "crunch",
	name = "Бекон",
	delay = 2.7,
	weight = 0.1,
	energy = 120,
	thirst = 0,
	hunger = 100,
	maxenergy = 250,
	btime = 7200,
	price = 7
}

DarkRP.Food["chicken"] = {
	model = "models/foodnhouseholditems/mcdfriedchickenleg.mdl",
	sound = "crunch",
	name = "Курица",
	delay = 2.7,
	weight = 0.2,
	energy = 90,
	thirst = 0,
	hunger = 100,
	maxenergy = 250,
	btime = 7200,
	price = 8,
}

DarkRP.Food["feesh_baked"] = {
	model = "models/food/warband/fish2.mdl",
	sound = "eating2",
	name = "Запечёная рыба",
	delay = 3.7,
	weight = 0.4,
	energy = 180,
	thirst = 0,
	hunger = 150,
	maxenergy = 290,
	btime = 7200,
	price = 16
}

DarkRP.Food["feesh_steak"] = {
	model = "models/foodnhouseholditems/salmon.mdl",
	sound = "eating2",
	name = "Жареная рыба",
	delay = 3.7,
	weight = 0.3,
	energy = 120,
	thirst = 0,
	hunger = 100,
	btime = 7200,
	price = 12
}

DarkRP.Food["meat_cooked"] = {
	model = "models/food/fl/moleratsteak.mdl",
	sound = "eating2",
	name = "Стейк",
	delay = 3.7,
	weight = 0.4,
	energy = 250,
	thirst = 0,
	hunger = 150,
	btime = 7200,
	price = 20
}

DarkRP.Food["sandwich"] = {
	model = "models/foodnhouseholditems/sandwich.mdl",
	sound = "crunch2",
	name = "Сэндвич",
	delay = 4.3,
	weight = 0.4,
	energy = 200,
	thirst = 0,
	hunger = 240,
	maxenergy = 250,
	btime = 7200,
	price = 10
}

DarkRP.Food["cereal_cooked"] = {
	model = "models/food/bowl.mdl",
	sound = "crunch2",
	name = "Миска хлопьев",
	delay = 4.3,
	weight = 0.4,
	energy = 180,
	thirst = 0,
	hunger = 170,
	maxenergy = 250,
	btime = 7200,
	price = 9
}

DarkRP.Food["potato_cooked"] = {
	model = "models/food/fnv/potato1.mdl",
	material = "gb_foods/nori",
	sound = "crunch2",
	name = "Жареный картофель",
	delay = 2.7,
	weight = 0.2,
	energy = 60,
	thirst = 0,
	hunger = 60,
	maxenergy = 250,
	btime = 7200,
	price = 4
}

DarkRP.Food["stock"] = {
	model = "models/food/fl/vegetablesoup.mdl",
	sound = "whater",
	name = "Бульон",
	delay = 3.5,
	weight = 0.3,
	energy = 30,
	thirst = 80,
	hunger = 40,
	maxenergy = 250,
	btime = 7200,
	price = 4
}

DarkRP.Food["soup"] = {
	model = "models/food/fl/vegetablesoup.mdl",
	sound = "whater",
	name = "Суп",
	delay = 3.5,
	weight = 0.3,
	energy = 90,
	thirst = 90,
	hunger = 120,
	maxenergy = 250,
	btime = 7200,
	price = 6
}

DarkRP.Food["soy_cooked"] = {
	model = "models/food/fnv/whitehorsenettleberries.mdl",
	sound = "eating",
	name = "Жареная соя",
	delay = 2.3,
	weight = 0.3,
	energy = 80,
	thirst = 0,
	hunger = 60,
	maxenergy = 250,
	btime = 7200,
	price = 13
}

DarkRP.Food["coffeecup"] = {
	model = "models/props_junk/garbage_coffeemug001a.mdl",
	sound = "whater",
	name = "Кружка кофе",
	delay = 3,
	weight = 0.4,
	energy = 40,
	maxenergy = 220,
	thirst = 70,
	stamina = 150,
	btime = 7200,
	price = 3
}

DarkRP.Food["teacup"] = {
	model = "models/props_junk/garbage_coffeemug001a.mdl",
	sound = "whater",
	name = "Кружка чая",
	delay = 3,
	weight = 0.4,
	energy = 0,
	thirst = 70,
	btime = 7200,
	price = 5
}

DarkRP.Food["teahp"] = {
	model = "models/props_junk/garbage_coffeemug001a.mdl",
	sound = "whater",
	name = "Целебный чай",
	delay = 3,
	weight = 0.4,
	energy = 20,
	maxenergy = 300,
	thirst = 70,
	hunger = 30,
	stamina = 60,
	btime = 7200,
	price = 11
}
-- DRINKS
DarkRP.Food["coffee_real"] = {
	model = "models/props_junk/garbage_coffeemug001a.mdl",
	sound = "whater",
	name = "Латте",
	delay = 3,
	weight = 0.4,
	energy = 40,
	maxenergy = 220,
	thirst = 70,
	stamina = 300,
	btime = 7200,
	price = 5
}

DarkRP.Food["juice"] = {
	model = "models/foodnhouseholditems/mcddrink.mdl",
	sound = "straw",
	name = "Свежевыжатый сок",
	delay = 3,
	weight = 0.4,
	energy = 40,
	maxenergy = 220,
	thirst = 120,
	stamina = 45,
	btime = 9200,
	price = 8
}
-- COOKED CULINARY
DarkRP.Food["feesh_gut"] = {
	model = "models/food/fnv/nvgeckosteak.mdl",
	sound = "eating2",
	name = "Разделанная рыба",
	delay = 3.7,
	weight = 0.2,
	energy = 10,
	maxenergy = 50,
	btime = 3600,
	thirst = 0,
	price = 10,
	toxic = 15,
}

DarkRP.Food["meat_t1"] = {
	model = "models/food/fl/antbits.mdl",
	sound = "eating",
	name = "Отбивные",
	delay = 2.3,
	weight = 0.3,
	energy = 250,
	hunger = 180,
	btime = 7200,
	thirst = 0,
	price = 18,
}

DarkRP.Food["egg_t1"] = {
	model = "models/food/fl/radscorpionomelette.mdl",
	sound = "eating2",
	name = "Омлет",
	delay = 3.7,
	weight = 0.1,
	energy = 175,
	thirst = 15,
	hunger = 120,
	btime = 7200,
	price = 9,
}

DarkRP.Food["bread_baked"] = {
	model = "models/food/props_shops/prop_bakery_bread_03_a.mdl",
	sound = "crunch2",
	name = "Батон хлеба",
	delay = 4.3,
	weight = 0.2,
	energy = 150,
	maxenergy = 450,
	btime = 7200,
	thirst = 0,
	price = 8,
}

DarkRP.Food["pie"] = {
	model = "models/food/dr2/pie.mdl",
	sound = "eating2",
	name = "Пирог",
	delay = 3.7,
	weight = 0.05,
	uses = 6,
	energy = 50,
	btime = 7200,
	thirst = 0,
	price = 19
}

DarkRP.Food["cake"] = {
	model = "models/foodnhouseholditems/cake.mdl",
	sound = "eating2",
	name = "Торт",
	delay = 3.7,
	weight = 0.05,
	uses = 6,
	energy = 60,
	btime = 7200,
	thirst = -20,
	price = 22
}
-- AMERICAN
DarkRP.Food["burger"] = {
	model = "models/foodnhouseholditems/burgergtaiv.mdl",
	sound = "eating2",
	name = "Бургер",
	delay = 3.7,
	weight = 0.5,
	energy = 250,
	thirst = 0,
	hunger = 300,
	btime = 7200,
	price = 14
}

DarkRP.Food["dog"] = {
	model = "models/food/hotdog.mdl",
	sound = "eating2",
	name = "Хотдог",
	delay = 3.7,
	weight = 0.5,
	energy = 235,
	thirst = 0,
	hunger = 260,
	btime = 7200,
	price = 11
}

DarkRP.Food["america"] = {
	model = "models/food/bread/sandwich_sb01.mdl",
	sound = "crunch2",
	name = "Американский сэндвич",
	uses = 2,
	delay = 4.3,
	weight = 0.3,
	energy = 175,
	thirst = 0,
	hunger = 270,
	btime = 7200,
	price = 26
}

DarkRP.Food["ribs"] = {
	model = "models/food/ribs_cooked.mdl",
	sound = "eating2",
	name = "Рёбра 'Барбекю'",
	uses = 4,
	delay = 3.7,
	weight = 0.2,
	energy = 200,
	thirst = 0,
	hunger = 300,
	btime = 7200,
	price = 40
}

DarkRP.Food["fries"] = {
	model = "models/foodnhouseholditems/mcdfrenchfries.mdl",
	material = "gbskins/macdmisc",
	sound = "crunch",
	name = "Картофель фри",
	delay = 2.7,
	weight = 0.1,
	energy = 115,
	thirst = 0,
	hunger = 90,
	btime = 7200,
	price = 4
}

DarkRP.Food["onion"] = {
	model = "models/food/dr2/onion_rings.mdl",
	sound = "crunch",
	name = "Луковые кольца",
	delay = 2.7,
	weight = 0.1,
	energy = 105,
	thirst = 0,
	hunger = 100,
	btime = 7200,
	price = 5
}

DarkRP.Food["brownie"] = {
	model = "models/food/dr2/brownie.mdl",
	sound = "crunch",
	name = "Брауни",
	delay = 2.7,
	weight = 0.2,
	energy = 105,
	thirst = 0,
	hunger = 100,
	btime = 7200,
	price = 9
}

DarkRP.Food["twinkie"] = {
	model = "models/food/twinkie.mdl",
	sound = "crunch",
	name = "Твинки",
	delay = 2.7,
	weight = 0.2,
	energy = 155,
	thirst = 0,
	hunger = 100,
	btime = 7200,
	price = 9
}

DarkRP.Food["moffin"] = {
	model = "models/food/muffin.mdl",
	sound = "eating",
	name = "Маффин",
	delay = 2.7,
	weight = 0.2,
	energy = 155,
	thirst = 0,
	hunger = 100,
	btime = 7200,
	price = 9
}

DarkRP.Food["donut"] = {
	model = "models/foodnhouseholditems/bagel1.mdl",
	sound = "crunch",
	name = "Пончик",
	delay = 2.7,
	weight = 0.1,
	energy = 100,
	thirst = 0,
	hunger = 90,
	btime = 7200,
	price = 5,
}
-- ITALIAN
DarkRP.Food["italian_bread"] = {
	model = "models/food/bread/bread_04d_sb01.mdl",
	sound = "crunch2",
	name = "Чиабатта",
	delay = 4.3,
	weight = 0.2,
	energy = 150,
	maxenergy = 450,
	btime = 7200,
	thirst = 0,
	price = 9,
}

DarkRP.Food["italian_bread2"] = {
	model = "models/foodnhouseholditems/bread_slice.mdl",
	sound = "crunch",
	name = "Чесночный хлеб",
	delay = 2.7,
	weight = 0.1,
	energy = 33,
	maxenergy = 450,
	btime = 7200,
	thirst = 0,
	price = 7,
}

DarkRP.Food["italian_bread3"] = {
	model = "models/foodnhouseholditems/chicken_wrap.mdl",
	sound = "crunch",
	name = "Пьядина",
	delay = 2.7,
	weight = 0.3,
	energy = 190,
	maxenergy = 450,
	btime = 7200,
	thirst = 0,
	price = 9,
}

DarkRP.Food["italian_noodles"] = {
	model = "models/food/spaghettiandmeatballs01.mdl",
	submat = {
		[2] = "null"
	},
	sound = "crunch",
	name = "Спагетти",
	btime = 7200,
	delay = 2.7,
	weight = 0.2,
	energy = 190,
	thirst = 10,
	price = 11,
}

DarkRP.Food["italian_pizza"] = {
	model = "models/food/props_shops/prop_shop_pizza.mdl",
	sound = "eating2",
	name = "Пицца",
	delay = 3.7,
	weight = 0.1,
	btime = 7200,
	uses = 8,
	energy = 48,
	thirst = 0,
	price = 20
}
-- GERMAN
DarkRP.Food["german_soup"] = {
	model = "models/food/fl/vegetablesoup.mdl",
	sound = "whater",
	name = "Пихельштайнер",
	delay = 3.5,
	weight = 0.3,
	energy = 130,
	thirst = 90,
	hunger = 120,
	btime = 7200,
	price = 12
}

DarkRP.Food["german_sosig"] = {
	model = "models/food/props_shops/prop_butcher_sausage_01_a.mdl",
	sound = "eating",
	name = "Вурст",
	delay = 2.3,
	weight = 0.3,
	energy = 130,
	thirst = 20,
	hunger = 150,
	btime = 7200,
	price = 8
}

DarkRP.Food["german_sosig2"] = {
	model = "models/food/sausage.mdl",
	sound = "eating",
	name = "Братвурст",
	delay = 2.3,
	weight = 0.3,
	energy = 130,
	thirst = 20,
	hunger = 150,
	btime = 7200,
	price = 9
}

DarkRP.Food["german_curry"] = {
	model = "models/food/fl/fireantbits.mdl",
	sound = "eating",
	name = "Карривурст",
	delay = 2.3,
	weight = 0.3,
	energy = 270,
	hunger = 180,
	btime = 7200,
	thirst = 0,
	price = 21,
}

DarkRP.Food["german_chicken"] = {
	model = "models/food/chicken/roasted_chicken.mdl",
	sound = "eating2",
	name = "Хендль",
	uses = 4,
	delay = 3.7,
	weight = 0.4,
	energy = 125,
	hunger = 180,
	btime = 7200,
	thirst = 0,
	price = 30,
}

DarkRP.Food["german_bread"] = {
	model = "models/foodnhouseholditems/pretzel.mdl",
	sound = "crunch",
	name = "Крендель",
	delay = 2.7,
	weight = 0.2,
	energy = 120,
	thirst = -10,
	hunger = 90,
	btime = 7200,
	price = 9
}
-- ASIAN
DarkRP.Food["asian_soup"] = {
	model = "models/food/fl/vegetablesoup.mdl",
	sound = "whater",
	name = "Фо",
	delay = 3.5,
	weight = 0.3,
	energy = 130,
	thirst = 90,
	hunger = 150,
	btime = 7200,
	price = 17
}

DarkRP.Food["asian_rice"] = {
	model = "models/food/fnv/ramen01.mdl",
	material = "fnv/clutter/food/ramen02",
	sound = "eating2",
	name = "Приготовленный рис",
	delay = 3.7,
	weight = 0.3,
	energy = 150,
	thirst = 0,
	hunger = 150,
	btime = 7200,
	price = 10
}

DarkRP.Food["asian_kebab"] = {
	model = "models/food/fl/squirrelonastick.mdl",
	material = "fnv/clutter/food/ramen02",
	sound = "eating",
	name = "Сатэ",
	delay = 2.3,
	weight = 0.2,
	energy = 117,
	thirst = 0,
	hunger = 120,
	btime = 7200,
	price = 10
}

DarkRP.Food["asian_salad"] = {
	model = "models/food/fl/squirrelsoup.mdl",
	sound = "eating2",
	name = "Кимчи",
	delay = 3.7,
	weight = 0.3,
	energy = 150,
	thirst = 0,
	hunger = 200,
	btime = 7200,
	price = 18
}

DarkRP.Food["asian_ice"] = {
	model = "models/food/icecream.mdl",
	sound = "crunch",
	name = "Бин Чилинг",
	delay = 2.7,
	weight = 0.1,
	energy = 90,
	thirst = 30,
	hunger = 90,
	maxenergy = 250,
	btime = 7200,
	price = 7
}

DarkRP.Food["asian_fish"] = {
	model = "models/props/cs_militia/fishriver01.mdl",
	sound = "eating2",
	name = "Фугу",
	delay = 3.7,
	weight = 0.2,
	energy = 190,
	thirst = 0,
	hunger = 210,
	btime = 7200,
	price = 25
}

DarkRP.Food["asian_sushi"] = {
	model = "models/food/cityrp/susi02.mdl",
	sound = "eating",
	name = "Суши",
	delay = 2.3,
	weight = 0.1,
	energy = 85,
	thirst = 0,
	hunger = 60,
	btime = 7200,
	price = 7
}

DarkRP.Food["asian_set"] = {
	model = "models/props_junk/garbage_plasticbox002b.mdl",
	sound = "eating2",
	name = "Сет суши",
	uses = 6,
	delay = 3.7,
	weight = 0.1,
	energy = 175,
	thirst = 0,
	hunger = 100,
	btime = 7200,
	price = 35
}

-- FRENCH
DarkRP.Food["french_bread"] = {
	model = "models/food/bread/bread03a.mdl",
	sound = "crunch2",
	name = "Батард",
	delay = 4.3,
	weight = 0.2,
	energy = 150,
	maxenergy = 450,
	btime = 7200,
	thirst = 0,
	price = 9,
}

DarkRP.Food["french_baget"] = {
	model = "models/foodnhouseholditems/bagette.mdl",
	sound = "crunch2",
	name = "Багет",
	uses = 3,
	delay = 4.3,
	weight = 0.2,
	energy = 120,
	maxenergy = 450,
	thirst = 0,
	hunger = 50,
	btime = 7200,
	price = 15,
}

DarkRP.Food["french_gougere"] = {
	model = "models/food/alchemy/ingredsweetcake.mdl",
	sound = "crunch2",
	name = "Гужер",
	delay = 4.3,
	weight = 0.2,
	energy = 112,
	maxenergy = 450,
	btime = 7200,
	thirst = 0,
	price = 8,
}

DarkRP.Food["french_pancake"] = {
	model = "models/food/fl/deathclawomelette.mdl",
	sound = "eating2",
	name = "Креп",
	uses = 3,
	delay = 3.7,
	weight = 0.07,
	energy = 200,
	thirst = 0,
	hunger = 90,
	btime = 7200,
	price = 14,
}

DarkRP.Food["chocolatine"] = {
	model = "models/foodnhouseholditems/chocolatine.mdl",
	sound = "crunch",
	name = "Чоколатин",
	delay = 2.7,
	weight = 0.1,
	energy = 100,
	thirst = 0,
	hunger = 90,
	btime = 7200,
	price = 7
}

DarkRP.Food["french_croissant"] = {
	model = "models/foodnhouseholditems/croissant.mdl",
	sound = "crunch",
	name = "Круассан",
	delay = 2.7,
	weight = 0.1,
	energy = 100,
	thirst = 0,
	hunger = 90,
	btime = 7200,
	price = 7
}

DarkRP.Food["french_finger"] = {
	model = "models/food/shortbreadfinger.mdl",
	sound = "crunch",
	name = "Хлебные палочки",
	delay = 2.7,
	weight = 0.1,
	energy = 60,
	thirst = 0,
	hunger = 90,
	btime = 7200,
	price = 3
}

DarkRP.Food["french_waffle"] = {
	model = "models/food/waffle.mdl",
	sound = "crunch2",
	name = "Вафля",
	delay = 4.3,
	weight = 0.2,
	energy = 170,
	thirst = 0,
	hunger = 150,
	btime = 7200,
	price = 9
}

DarkRP.Food["french_pie"] = {
	model = "models/food/fl/pie.mdl",
	sound = "eating2",
	uses = 8,
	name = "Киш",
	delay = 3.7,
	weight = 0.1,
	energy = 65,
	thirst = 0,
	hunger = 150,
	btime = 7200,
	price = 11
}

DarkRP.Food["french_cake"] = {
	model = "models/food/napoleon.mdl",
	sound = "eating2",
	uses = 8,
	name = "Милле-Фюлле",
	delay = 3.7,
	weight = 0.05,
	energy = 70,
	thirst = 0,
	hunger = 150,
	btime = 7200,
	price = 17
}
-- EURASIAN
DarkRP.Food["europan_sosig"] = {
	model = "models/food/props_shops/prop_butcher_sausage_01_b.mdl",
	sound = "eating",
	name = "Сарделька",
	delay = 2.3,
	weight = 0.2,
	energy = 180,
	thirst = 0,
	hunger = 150,
	btime = 7200,
	price = 8
}

DarkRP.Food["europan_sandwich"] = {
	model = "models/food/sosiska_testo.mdl",
	sound = "eating",
	name = "Сосиска в тесте",
	delay = 2.3,
	weight = 0.3,
	energy = 190,
	thirst = 0,
	hunger = 220,
	btime = 7200,
	price = 10
}

DarkRP.Food["europan_dumpling"] = {
	model = "models/food/pelmeni.mdl",
	bgr = {
		[1] = 1,
		[2] = 1,
	},
	sound = "eating2",
	name = "Пельмени",
	delay = 3.7,
	weight = 0.3,
	energy = 230,
	thirst = 0,
	hunger = 240,
	btime = 7200,
	price = 13
}

DarkRP.Food["europan_soup"] = {
	model = "models/food/borsch.mdl",
	sound = "whater",
	name = "Борщ",
	delay = 3.5,
	weight = 0.3,
	energy = 140,
	thirst = 80,
	hunger = 120,
	btime = 7200,
	price = 11
}

DarkRP.Food["europan_pancake"] = {
	model = "models/food/blini.mdl",
	sound = "eating2",
	name = "Блины",
	uses = 6,
	delay = 3.7,
	weight = 0.05,
	energy = 60,
	thirst = 0,
	hunger = 60,
	btime = 7200,
	price = 10
}

DarkRP.Food["europan_bread"] = {
	model = "models/food/bread/bread.mdl",
	sound = "crunch2",
	name = "Ржаной хлеб",
	delay = 4.3,
	weight = 0.2,
	energy = 150,
	btime = 7200,
	maxenergy = 450,
	thirst = 0,
	price = 9,
}

DarkRP.Food["europan_cheburek"] = {
	model = "models/food/meal_cheburek.mdl",
	sound = "eating",
	name = "Чебурек",
	delay = 2.7,
	weight = 0.2,
	energy = 190,
	thirst = 0,
	price = 12,
	hunger = 240,
	btime = 7200,
}

DarkRP.Food["europan_hachapuri"] = {
	model = "models/food/hacha.mdl",
	sound = "eating",
	name = "Хачапури",
	delay = 2.7,
	weight = 0.2,
	energy = 200,
	thirst = 0,
	price = 12,
	hunger = 240,
	btime = 7200,
}

DarkRP.Food["europan_samsa"] = {
	model = "models/food/meal_samsa.mdl",
	sound = "eating",
	name = "Самса",
	delay = 2.7,
	weight = 0.2,
	energy = 240,
	thirst = 0,
	price = 12,
	hunger = 240,
	btime = 7200,
}

DarkRP.Food["doner"] = {
	model = "models/foodnhouseholditems/chicken_wrap.mdl",
	sound = "crunch2",
	name = "Шаурма",
	delay = 4.3,
	weight = 0.4,
	energy = 200,
	thirst = 0,
	hunger = 240,
	btime = 7200,
	price = 11
}
-- VEGAN
DarkRP.Food["vegan_salad"] = {
	model = "models/food/fnv/desertsalad.mdl",
	sound = "eating2",
	name = "Овощной салат",
	delay = 3.7,
	weight = 0.3,
	energy = 150,
	thirst = 0,
	hunger = 270,
	btime = 7200,
	price = 10
}

DarkRP.Food["vegan_fruit"] = {
	model = "models/food/bowl_of_fruit.mdl",
	sound = "eating2",
	name = "Фруктовый салат",
	uses = 3,
	delay = 3.7,
	weight = 0.2,
	energy = 60,
	thirst = 0,
	hunger = 135,
	btime = 7200,
	price = 15
}

DarkRP.Food["vegan_tofu"] = {
	model = "models/food/alchemy/ingreddaedrothteeth.mdl",
	sound = "eating",
	name = "Тофу",
	delay = 2.3,
	weight = 0.2,
	energy = 30,
	btime = 7200,
	thirst = 0,
	price = 10
}

DarkRP.Food["vegan_cooked"] = {
	model = "models/food/alchemy/ingreddaedrothteeth.mdl",
	material = "fnv/clutter/junk/nv/whitehorsenettleberries",
	sound = "eating",
	name = "Тофу",
	delay = 2.3,
	weight = 0.2,
	btime = 7200,
	energy = 120,
	thirst = 0,
	price = 19
}

DarkRP.Food["vegan_kebab"] = {
	model = "models/food/fl/iguanaonastick.mdl",
	sound = "eating",
	name = "Шашлык из тофу",
	delay = 2.3,
	weight = 0.2,
	btime = 7200,
	energy = 120,
	thirst = 0,
	price = 21
}

DarkRP.Food["vegan_stew"] = {
	model = "models/food/fl/squirrelsoup.mdl",
	sound = "eating2",
	name = "Рагу из тофу",
	delay = 3.7,
	weight = 0.3,
	btime = 7200,
	energy = 180,
	thirst = 30,
	price = 22
}

DarkRP.Food["vegan_noodles"] = {
	model = "models/food/fl/noodles.mdl",
	sound = "eating2",
	name = "Макароны из тофу",
	delay = 3.7,
	weight = 0.3,
	btime = 7200,
	energy = 140,
	thirst = 0,
	price = 23
}
-- BEST ITEM
DarkRP.Food["toxic_jar"] = {
	model = "models/props_lab/jar01a.mdl",
	sound = "straw",
	name = "Непонятная смесь",
	delay = 10,
	weight = 0.1,
	toxic = 50,
	energy = 0,
	thirst = 0,
	price = 5,
}

DarkRP.Food["cursed_cereal"] = {
	model = "models/food/bowl.mdl",
	sound = "crunch2",
	name = "Миска хлопьев",
	delay = 4.3,
	weight = 0.4,
	energy = 180,
	thirst = 0,
	hunger = 170,
	maxenergy = 250,
	btime = 7200,
	alcohol = 5,
	price = 5
}

DarkRP.Food["hunger_jar"] = {
	model = "models/props_lab/jar01a.mdl",
	sound = "eating2",
	name = "Голодная смесь",
	delay = 0,
	weight = 0.1,
	energy = -500,
	thirst = -250,
	price = 1,
}
-- HOBO
DarkRP.Food["hobo_kebab"] = {
	model = "models/food/fnv/squirrelonastick01.mdl",
	sound = "eating",
	name = "Крыса на палочке",
	delay = 2.3,
	weight = 0.2,
	energy = 180,
	btime = 7200,
	thirst = 0,
	price = 0
}

DarkRP.Food["hobo_soup"] = {
	model = "models/food/fl/iguanasoup.mdl",
	sound = "whater",
	name = "Суп из голубя",
	delay = 3.5,
	weight = 0.2,
	btime = 7200,
	energy = 140,
	thirst = 60,
	price = 0
}

DarkRP.Food["hobo_steak"] = {
	model = "models/food/fl/moleratsteak.mdl",
	material = "fnv/clutter/food/humanflesh",
	sound = "eating2",
	name = "Стейк из человечины",
	delay = 3.7,
	btime = 7200,
	weight = 0.4,
	energy = 250,
	thirst = -30,
	price = 0
}

-- ALCOHOL 
DarkRP.Food["beer"] = {
	model = "models/mark2580/gtav/barstuff/beer_logger.mdl",
	sound = "beer",
	name = "Пиво",
	delay = 3.6,
	weight = 0.3,
	energy = 15,
	maxenergy = 50,
	thirst = 55,
	alcohol = 6,
	price = 4
}

DarkRP.Food["pop_beer"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/canthe",
	sound = "can",
	name = "Банка пива The",
	delay = 3.6,
	weight = 0.3,
	energy = 0,
	thirst = 55,
	alcohol = 5,
	price = 20,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pop_beer2"] = {
	model = "models/props_junk/popcan01a.mdl",
	material = "gb_foods/canmud",
	sound = "can",
	name = "Банка пива Mud",
	delay = 3.6,
	weight = 0.3,
	energy = 0,
	thirst = 55,
	alcohol = 5,
	price = 15,
	shop = "shop",
	noweb = true
}

DarkRP.Food["pilk"] = {
	model = "models/props_junk/garbage_plasticbottle003a.mdl",
	sound = "whater",
	name = "Кумыс",
	delay = 3.3,
	weight = 0.5,
	uses = 2,
	energy = 40,
	maxenergy = 50,
	btime = 7200,
	thirst = 55,
	alcohol = 5,
	price = 4
}

DarkRP.Food["wine"] = {
	model = "models/mark2580/gtav/barstuff/plonk_red.mdl",
	sound = "champagne",
	name = "Вино",
	delay = 4.2,
	weight = 0.25,
	uses = 2,
	energy = 10,
	maxenergy = 50,
	thirst = 40,
	alcohol = 7,
	price = 8
}

DarkRP.Food["fernet"] = {
	model = "models/fernet.mdl",
	sound = "whater",
	name = "Фернет",
	delay = 3.3,
	weight = 0.1,
	uses = 5,
	energy = 20,
	maxenergy = 50,
	thirst = 10,
	alcohol = 15,
	price = 15
}

DarkRP.Food["brandy"] = {
	model = "models/mark2580/gtav/barstuff/bottle_brandy.mdl",
	sound = "whater",
	name = "Бренди",
	delay = 3.3,
	weight = 0.1,
	uses = 5,
	energy = 5,
	maxenergy = 50,
	thirst = 5,
	alcohol = 15,
	price = 12
}

DarkRP.Food["rum"] = {
	model = "models/mark2580/gtav/barstuff/rum_bottle_2.mdl",
	sound = "champagne",
	name = "Ром",
	delay = 4.2,
	weight = 0.1,
	uses = 5,
	energy = 5,
	maxenergy = 50,
	thirst = 5,
	alcohol = 15,
	toxic = 0.1,
	price = 9
}

DarkRP.Food["gin"] = {
	model = "models/mark2580/gtav/barstuff/vodka_bottle.mdl",
	sound = "whater",
	name = "Джин",
	delay = 3.3,
	weight = 0.1,
	uses = 5,
	energy = 5,
	maxenergy = 50,
	thirst = 5,
	alcohol = 16,
	toxic = 0.1,
	price = 12
}

DarkRP.Food["whiskey"] = {
	model = "models/mark2580/gtav/barstuff/whiskey_bottle.mdl",
	sound = "whater",
	name = "Виски",
	delay = 3.3,
	weight = 0.1,
	uses = 5,
	energy = 5,
	maxenergy = 50,
	thirst = -5,
	alcohol = 15,
	toxic = 0.1,
	price = 12
}

DarkRP.Food["vodka"] = {
	model = "models/mark2580/gtav/barstuff/cherenkov_01.mdl",
	sound = "whater",
	name = "Водка",
	delay = 3.3,
	weight = 0.1,
	uses = 5,
	energy = 5,
	maxenergy = 50,
	thirst = -5,
	toxic = 0.1,
	alcohol = 15,
	price = 11
}

DarkRP.Food["absinthe"] = {
	model = "models/mark2580/gtav/barstuff/bottle_cognac.mdl",
	sound = "whater",
	name = "Абсент",
	delay = 3.3,
	weight = 0.1,
	uses = 5,
	energy = 5,
	maxenergy = 50,
	thirst = -10,
	alcohol = 30,
	toxic = 1,
	price = 14
}

DarkRP.Food["moonshine"] = {
	model = "models/props_junk/glassjug01.mdl",
	sound = "whater",
	name = "Самогон",
	delay = 3.3,
	weight = 0.1,
	uses = 5,
	energy = 3,
	maxenergy = 50,
	thirst = -20,
	alcohol = 35,
	toxic = 2,
	price = 1
}

for k,v in pairs(DarkRP.Food) do
	local _, icon
	if CLIENT then
		_, icon = MSD.IconRender.Get(v.model or "models/props_junk/CinderBlock01a.mdl", v.material, v.submat)
	end

	list.Set( "SpawnableEntities", k, {
		Name = v.name,
		Class = "spawned_food",
		Category = "DarkRP Food",
		PrintName = v.name,
		AdminOnly = false,
		Extras = INV_FOOD,
		IconOverride = icon and "data/msd_render/" .. icon,
		SpawnFunction = function(ply, pos)
			return DarkRP.SpawnFood(k, pos, Angle(0,0,0))
		end
	} )
end