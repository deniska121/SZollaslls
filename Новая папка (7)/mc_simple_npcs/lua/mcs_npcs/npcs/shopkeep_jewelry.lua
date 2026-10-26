-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\npcs\\shopkeep_jewelry.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
MCS.Spawns["shopkeep_jewelry"] = {
	name = "Продавец в ювелирном магазине",
	model = "models/cityrp/pm/suit/female_05.mdl",
	submat = {
		[4] = "models/gmodbest/suit/female/femsuit12",
		[5] = "models/gmodbest/suit/female/femsuit12",
		[6] = "models/gmodbest/suit/female/femsuit12",
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	pos = {},
	sequence = "lineidle01",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_sound = "vo/npc/female01/help01.wav",
	scare_timer = 900,
	scare_alarm = 4548,
	uselimit = false,
	skin = 0,
	bgr = {},
	dialogs = {
		[1] = {
			["Line"] = [[Да, да, да.. Вам что-то нужно?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/1.mp3",
			["Answers"] = {
				{"Хотелось бы прикупить что-то красивое..", 2,},
				{"У вас есть какая-нибудь подработка?", 8,},
				{"Как-то не очень культурно вы себя ведёте для консультанта в ювелирном магазине.", 9,},
				{"Нет. Я пойду.", 6,},
			},
		},
		[2] = {
			["Line"] = [[А мне-то что? Не видишь, у меня обед?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/2.mp3",
			["Answers"] = {
				{"...", 3,},
				{"Подавись.", 5,},
				{"Нет, не вижу.", 3,},
				{"Прошу прощения, я пойду.", 6,},
			},
		},
		[3] = {
			["Line"] = [[Разуй глаза - я ничего не делаю, потому что у меня перерыв.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/3.mp3",
			["Answers"] = {
				{"...", 5,},
				{"Подавись.", 5,},
				{"И сколько он будет продолжаться?", 4,},
				{"Прошу прощения, я пойду.", 6,},
			},
		},
		[4] = {
			["Line"] = [[Пока я не захочу обратного.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/4.mp3",
			["Answers"] = {
				{"...", 5,},
				{"Подавись.", 5,},
				{"Прошу прощения, я пойду.", 6,},
			},
		},
		[5] = {
			["Line"] = [[..Ты ещё здесь? Господи, какой назойливый человечишка!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/5.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Да что-б тебя ограбили!", 7,},
				{"Прошу прощения, уже ухожу.", 6,},
			},
		},
		[6] = {
			["Line"] = [[Серьёзно? Так чего ты тогда сюда приходишь? Чтобы заставить меня чувствовать себя некомфортно? Угнетатель, да я на тебя полиции пожалуюсь!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/6.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Да что-б тебя ограбили!", 7,},
				{"Да-да..", "close",},
			},
		},
		[7] = {
			["Line"] = [[Мечтай. Нас защищает доблестная полиция этого замечательного города. Они не допустят, чтобы какая-то обезьяна с пистолетом разбила витрины, и вынесла блестяшки, которые ты не заслуживаешь видеть даже во сне.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/7.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Это мы посмотрим.", "close",},
				{"Как скажешь.", "close",},
				{"Прошу прощения.", "close",},
			},
		},
		[8] = {
			["Line"] = [[Хм-м.. Да, есть кое-что - вынеси мусор, и себя заодно. Нечего лапать прелестное стекло своими грязными ручищами.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/8.mp3",
			["Answers"] = {
				{"...", 5,},
				{"Как-то не очень культурно вы себя ведёте для консультанта в ювелирном магазине.", 9,},
			},
		},
		[9] = {
			["Line"] = [[А ты очень 'культурно' отвлекаешь меня от обеда.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/shopkeep_jewelry/9.mp3",
			["Answers"] = {
				{"...", 5,},
				{"Подавись.", 5,},
				{"Какого обеда?", 3,},
				{"Прошу прощения, я пойду.", 6,},
			},
		},
	}
}