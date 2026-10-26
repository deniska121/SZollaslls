-- "addons\\mc_simple_npcs\\lua\\mcs_npcs\\sh_npcspawn.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--  _______               __          _______  __                   __          _______  ______  ______        
-- |   |   |.---.-..----.|  |.-----. |     __||__|.--------..-----.|  |.-----. |    |  ||   __ \|      |.-----.
-- |       ||  _  ||  __| |_||__ --| |__     ||  ||        ||  _  ||  ||  -__| |       ||    __/|   ---||__ --|
-- |__|_|__||___._||____|    |_____| |_______||__||__|__|__||   __||__||_____| |__|____||___|   |______||_____|
--                                                          |__|      
-- Template moved to the documentation
MCS.Spawns["dezz"] = {
	name = "Дезз",
	model = "models/cityrp/pm/normal/male_01.mdl",
	submat = {
		[4] = "gbskins/outfit/top_19",
		[8] = "gbskins/outfit/pants_19",
		[9] = "gbskins/outfit/boots_3",
		[2] = "models/gmodbest/citizens/facemaps/van_facemap6"
	},
	namepos = 80,
	theme = "Default",
	scale = 1,
	questNPC = false,
	get_pos = {
		{Vector(-170.46875, 7518.1875, 129), Angle(0, 0, 0)},
		{Vector(4118, 2527.03125, -88), Angle(0, 0, 0)},
		{Vector(-9375.03125, 1876.125, 0), Angle(0, -180, 0)},
		{Vector(-12736.6875, 9750, 250.9375), Angle(0, 90, 0)}
	},
	sequence = "plazaidle4",
	uselimit = true,
	skin = 0,
	pos = {},
	bgr = {},
	ClModels = {},
	teams = {
		[2] = 4,
	},
	extracheck = function()
		if LocalPlayer().MQSdata.Stored["dezz"] and LocalPlayer().MQSdata.Stored["dezz"] < 0 then return 1 end

		return false
	end,
	dialogs = {
		[1] = {
			["Line"] = [[Уйди. Мешаешь.]],
			["Sound"] = "https://macnco.one/gmod/vo/dezth/extra_dialogues/1.mp3",
			["Answers"] = {
				{"...", "close",},
				{"Хорошо, как скажешь.", "close",},
				{"Мешаю что? Смотреть вникуда?", 2,},
				{"Я хочу поговорить.", 2,},
			},
		},
		[2] = {
			["Line"] = [[Нигер. Выёбываешься.]],
			["Sound"] = "https://macnco.one/gmod/vo/dezth/extra_dialogues/2.mp3",
			["Answers"] = {
				{"Хорошо, успокойся.", "close",},
				{"Сам ты нигер!", 3,},
				{"А если я вызову наряд?", 3,},
				{"Ты так реагируешь на каждого соседа?", 3,},
			},
		},
		[3] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Answers"] = {
				{"...", "close",},
				{"Что, съел? Будешь знать.", "close",},
				{"Ладно, прости, меня понесло.", "close",},
				{"Ну?", "close",},
			},
		},
		[4] = {
			["Line"] = [[Быстрее. Палишься. У меня тут ещё пару клиентов.]],
			["Sound"] = "https://macnco.one/gmod/vo/dezth/extra_dialogues/4.mp3",
			["Answers"] = {
				{"Да, сейчас..", 7, function() end},
				{"Что там по поводу поручений? Время не пришло?", 6, nil, function() return LocalPlayer().MQSdata.Stored["dezz"] and LocalPlayer().MQSdata.Stored["dezz"] == 3 end},
				{"Слушай, у тебя нет каких-нибудь поручений на стороне?", 5, nil, function() return LocalPlayer().MQSdata.Stored["dezz"] and LocalPlayer().MQSdata.Stored["dezz"] == 1 end},
				{"Потом. Резко сменились планы.", "close",},
			},
		},
		-- Dialogue before asking for jobs.		
		[5] = {
			["Line"] = [[Пока нет. Но ты мне нравишься. Проживёшь подольше, и дело тебя найдёт.]],
			["Sound"] = "https://macnco.one/gmod/vo/dezth/extra_dialogues/5.mp3",
			["Answers"] = {
				{"Спасибо.", "Dezz_Check"},
			},
		},
		-- Dialogue after asking for jobs.		
		[6] = {
			["Line"] = [[Пришло. Есть кое-что. Скоро скину контакт на телефон. Позвони ему, назначь встречу и он тебе расскажет. Не ляпни лишнего - такое в нашем деле не поощряется.]],
			["Sound"] = "https://macnco.one/gmod/vo/dezth/extra_dialogues/6.mp3",
			["Answers"] = {
				{"Спасибо. Это всё", "Dezz_Check2",},
			},
		},
		[7] = {
			["Line"] = [[...]],
			["Sound"] = "",
			["Formater_SV"] = function(ply) return McINV.SellStuff(ply) end,
			["Answers"] = {
				{"Сойдет", "DezzSell", nil, function() return false end},
				{"...", "close",},
			},
		},
	}
}

MCS.Spawns["police_arsenal"] = {
	name = "Джон Диллинджер",
	desc = "Офицер Полиции",
	n_icon = Material("ranks_ui/icons/nypd/po.png", "smooth"),
	model = "models/cityrp/pm/nypd/male_06.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	hint = 2,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(8801.03125, 7608.1171875, -439.96875), Angle(0, 180, 0)},
	},
	sequence = "menu_combine",
	uselimit = false,
	skin = 0,
	bgr = {
		[1] = 0,
		[2] = 2,
		[3] = 2,
		[5] = 1,
	},
	ClModels = {},
	teams = {
		[3] = 2,
		[4] = 2,
		[5] = 2,
		[6] = 2,
		[7] = 2,
		[19] = 2,
		[15] = 4,
	},
	dialogs = {
		[1] = {
			["Line"] = [[Вы чего тут делаете?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal/1.mp3",
			["Answers"] = {
				{"Простите, кажется у меня развивается топографический кретинизм.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Добрый день.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal/2.mp3",
			["Answers"] = {
				{
					"Я хочу встать на смену.", "close", function()
						DarkRP.OpenJobMenuPolice()
					end,
					function() return LocalPlayer():Team() == 3 end
				},
				{
					"Я хочу сменить снаряжение.", "close", function()
						MSD.Loadout.Create()
					end,
					function() return LocalPlayer():isCP() and (MRS.GetNWdata(LocalPlayer(), "Rank") or 1) > 1 end
				},
				{"Я хочу сменить снаряжение.", 5, function() end, function() return LocalPlayer():isCP() and (MRS.GetNWdata(LocalPlayer(), "Rank") or 1) == 1 end},
				{
					"Я хочу закончить смену.", "close", function()
						RunConsoleCommand("rp_job", 3)
					end,
					function() return LocalPlayer():Team() ~= 3 end
				},
				{"Я хочу поговорить.", 3,},
				{"Потом зайду.", "close",},
			},
		},
		[3] = {
			["Line"] = [[А я нет. Не задерживай остальных.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal/3.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[4] = {
			["Line"] = [[Добрый день.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal/2.mp3",
			["Answers"] = {
				{"Добрый.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Ты? Снаряжение? А не рановато ли? ..Может лучше сначала выпросишь фуражку у сержанта в офисах?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal/5.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
	}
}

MCS.Spawns["police_evidence"] = {
	name = "Куигли Смитти",
	desc = "Офицер Полиции",
	n_icon = Material("ranks_ui/icons/nypd/po.png", "smooth"),
	model = "models/cityrp/pm/nypd/male_07.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	hasinv = {1000, "Изъятое имущество"},
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(8800.046875, 7740.6904296875, 200.03125), Angle(0, 180, 0)},
	},
	extras = {
		policeEvidnce = true,
	},
	sequence = "menu_combine",
	uselimit = false,
	skin = 0,
	bgr = {
		[1] = 0,
		[2] = 1,
		[5] = 1,
	},
	ClModels = {
		{
			model = "models/cityrp/nypd/badge_po3.mdl",
			pos = Vector(3, -1.9, 7.25),
			ang = Angle(0, 150, 60),
			bone = 4
		},
	},
	teams = {
		[3] = 2,
		[4] = 2,
		[5] = 2,
		[6] = 2,
		[7] = 2,
		[19] = 2,
		[15] = 5,
	},
	dialogs = {
		[1] = {
			["Line"] = [[Для гражданских все вопросы в приёмную.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence/1.mp3",
			["Answers"] = {
				{"Я хочу забрать свои личные вещи.", "NYPD Npc",},
				{"Простите, больше не отвлекаю.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Добрый день.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence/2.mp3",
			["Answers"] = {
				{"Я хочу оформить изъятое.", "Loot Npc", nil, function() return LocalPlayer():Team() ~= 3 end},
				--{"Я хочу сдать улики, по поручению.", 4,},
				{"Я хочу поговорить.", 3,},
				{"Потом зайду.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Давай после смены, не задерживай остальных.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence/3.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[4] = {
			["Line"] = [[Это давай самостоятельно. Я оформляю только тех, кому срочно - именно патрульных. Заходи со служебного, бери бланк и ручку, и с песней.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence/4.mp3",
			["Answers"] = {
				{"Ладно.", "close",},
				{"Лентяй чёртов.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Добрый день.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence/5.mp3",
			["Answers"] = {
				{"Добрый.", "close",},
			},
		},
	}
}

MCS.Spawns["police_cadet"] = {
	name = "Джимми Шаклс",
	desc = "Офицер Полиции",
	n_icon = Material("vgui/ppo.png", "smooth"),
	model = "models/cityrp/pm/nypd/male_02.mdl",
	namepos = 80,
	theme = "Default",
	checkpos = true,
	scale = 1,
	questNPC = false,
	pos = {
		["rp_southside_noire"] = {Vector(7901.7875976563, 8034.03125, 200.03129577637), Angle(0, -88.352096557617, 0)},
		["rp_southside"] = {Vector(7901.7875976563, 8034.03125, 200.03129577637), Angle(0, -88.352096557617, 0)},
	},
	bgr = {
		[2] = 1,
		[5] = 1,
	},
	ClModels = {
		{
			model = "models/cityrp/nypd/badge_po3.mdl",
			pos = Vector(3, -1.9, 7.25),
			ang = Angle(0, 150, 60),
			bone = 4
		},
	},
	sequence = "pose_standing_02",
	uselimit = false,
	skin = 0,
	teams = {
		[3] = 6,
		[4] = 8,
		[5] = 8,
		[6] = 8,
		[7] = 8,
		[19] = 8,
		[15] = 11,
	},
	dialogs = {
	-- VOICE - TYRONE
		[1] = {
			["Line"] = [[Здравствуйте! Вы попали в Полицейский Департамент Юнион Сити. У вас запланировано свидание с заключённым, или вы желаете внести залог?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/1.mp3",
			["Answers"] = {
				{"Я хочу стать полицейским.", 2,},
				{
					"Я хочу оставить подпись за отстранение районного администратора от должности.", 10, function()
						RunConsoleCommand("mayor_demote")
					end,
					function() return #team.GetPlayers(TEAM_MAYOR) > 0 end
				},
				--{"[script] Я хочу внести залог.", "close",},
				{"..Вы всерьёз читаете по бумажке?", 3,},
				{"Вы упомянули Юнион - почему Нью-Йорк иногда называют Юнионом?", 12,},
				{"Мне пора.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Так.. ну, здесь уже проблематично. Сейчас кого попало не берут. Да и если чудом возьмут - пройти испытательный срок ещё то испытание. Говорю по опыту.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/2.mp3",
			["Answers"] = {
				{"Хорошо, спасибо.", 4,},
			},
		},
		[3] = {
			["Line"] = [[Простите, я не могу ответить на этот вопрос.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/3.mp3",
			["Answers"] = {
				{"Хорошо, спасибо.", 4,},
				{"Настолько не с кем поговорить?", 5,},
			},
		},
		[4] = {
			["Line"] = [[Рад, что мы урегулировали этот вопрос. У вас есть ещё вопросы?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/4.mp3",
			["Answers"] = {
				{"Я хочу стать полицейским.", 2, nil, function() return not LocalPlayer():isCP() end},
				--{"[script] Я хочу внести залог.", "close",},
				{"Мне пора.", "close",},
			},
		},
		[5] = {
			["Line"] = [[..Не то слово. Вы только кэпу не говорите, ладно?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/5.mp3",
			["Answers"] = {
				{"Без проблем.", 4,},
			},
		},
		-- [OFF SHIFT]
		[6] = {
			["Line"] = [[О, здаров! Ну, не отворачивайся - узнал же! На сменах сейчас туго, так что нам не помешает кто-нибудь ещё на улицах. Форма и снаряжение как обычно на самом нижнем этаже - третьем снизу, если лифтом пользоваться.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/6.mp3",
			["Answers"] = {
				{
					"Я хочу оставить подпись за отстранение районного администратора от должности.", 10, function()
						RunConsoleCommand("mayor_demote")
					end,
					function() return #team.GetPlayers(TEAM_MAYOR) > 0 end
				},
				{"Удачной смены.", "close",},
				{"Не по протоколу разговариваешь. Что это такое?", 7,},
			},
		},
		[7] = {
			["Line"] = [[Эй! Это же мелочь. Ты ведь другим не расскажешь? ..Да и даже если расскажешь - пусть! Мне тут, может, нравится сидеть и вечно бумаги перебирать!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/7.mp3",
			["Answers"] = {
				{"Успокойся, не скажу.", "close",},
				{"Все и так знают о твоей болтливости.", "close",},
				{"Эта 'мелочь' отличает нас от преступников.", "close",},
				{"Вот поэтому тебе не суждено подняться выше по карьерной лестнице.", "close",},
			},
		},
		-- [ON SHIFT]
		[8] = {
			["Line"] = [[Здравия желаю! Как там смена? Что на улице? Столько работы, что даже покурить времени нет. Не то чтоб я курил..]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/8.mp3",
			["Answers"] = {
				{"Мне пора.", "close",},
				--{"Привёл подозреваемого. Оформишь?", 9, nil, function() return LocalPlayer():getDarkRPVar("Player.Drag") end},
				{
					"Я хочу оставить подпись за отстранение районного администратора от должности.", 10, function()
						RunConsoleCommand("mayor_demote")
					end,
					function() return #team.GetPlayers(TEAM_MAYOR) > 0 end
				},
				{"Слушай, а есть какие-нибудь поручения на стороне? Так сказать, едва официальные.", 13, nil, function() return not LocalPlayer().MQSdata.Stored["police"] or LocalPlayer().MQSdata.Stored["police"] ~= 1 end},
				{"Слушай, не подскажешь как подняться по карьерной лестнице?", 15, nil, function() return MRS.GetPlyRank(LocalPlayer(), "NYPD") == 1 end},
				{
					"А как дальше повышаться? Тоже экзамен какой-то?", 16, nil, function()
						local rank = MRS.GetPlyRank(LocalPlayer(), "NYPD")

						return rank > 1 and rank < 4
					end
				}
			},
		},
		[9] = {
			["Line"] = [[О! Да, конечно, я справлюсь! ..Погоди, а за что этого подозреваемого? На сколько?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/9.mp3",
			["Answers"] = {
				{
					"В обезьянник его, пускай протрезвеет.", "close", function()
						net.Start("Police.Arrest")
						net.WriteUInt(300, 12)
						net.SendToServer()
					end
				},
				{
					"Преступление средней тяжести. Пускай подумает.", "close", function()
						net.Start("Police.Arrest")
						net.WriteUInt(900, 12)
						net.SendToServer()
					end
				},
				{
					"Тяжкое преступление. На исправительные работы его.", "close", function()
						net.Start("Police.Arrest")
						net.WriteUInt(1500, 12)
						net.SendToServer()
					end
				},
				{
					"Особо тяжкое преступление. Пускай гниет.", "close", function()
						net.Start("Police.Arrest")
						net.WriteUInt(2700, 12)
						net.SendToServer()
					end
				},
				{"Подожди. Нужно сначала уладить одно дело.", "close",},
			},
		},
		[10] = {
			["Line"] = [[Разве по таким вопросам не к мэр- ..в смысле не к секретарю в бывшей мэрии? А, погодите, мы тоже можем принять ваше заявление. Вот бланк, подпишите тут и тут. И ещё тут. Вроде всё. Спасибо за обращение!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/10.mp3",
			["Answers"] = {
				{"Спасибо, до свидания.", "close",},
			},
		},
		[11] = {
			["Line"] = [[Здравия желаю!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/11.mp3",
			["Answers"] = {
				{"Добрый.", "close",},
			},
		},
		[12] = {
			["Line"] = [[Это формальность! Ну, неформальность точнее. Нью-Йорк настолько дружный, что все его так и называют!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/12.mp3",
			["Answers"] = {
				{"Хорошо, спасибо.", 4,},
				{"Вы в Парабеллум переиграли?", 38,},
				{"Спасибо. До свидания!", "close",},
			},
		},
		[13] = {
			["Line"] = [[А-а-а.. Выслужиться значит хочешь? ..Наверное, мы можем помочь друг другу. Давай ты замолвишь за меня словечко ше- ..капитану, а я буду оставлять для тебя какие-нибудь прибыльные дела?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/13.mp3",
			["Answers"] = {
				{"Идёт.", 14,},
				{"Знаешь, я наверное пас. Такие авантюры плохо заканчиваются.", "close",},
			},
		},
		[14] = {
			["Line"] = [[Тогда вот тебе номерок регистратуры, горячая линия так сказать, звони как время появится! Может быть, к этому моменту что-нибудь заваляется. Ты главное это, после выполнения не проси повышение..]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/14.mp3",
			["Answers"] = {
				{"Буду иметь в виду, спасибо.", "Police_Check",},
			},
		},
		[15] = {
			["Line"] = [[А, это легко! Нужно экзамен сдать. ..Вот экзамен уже сложно. Подойди к Комисса- ..То есть, к сержанту Колдуэллу; он выдаст нужные бланки и ручку. Перед этим обязательно подучи руководство - оно в компьютере записано.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/15.mp3",
			["Answers"] = {
				{
					"Cпасибо.", 4, function()
						McPhone.ToggleGPS("Cержант Колдуэлл", Vector(8649.2177734375, 8740.9111328125, 288.03125))
					end
				},
			},
		},
		[16] = {
			["Line"] = [[Да. Только тут Комиссар уже не поможет, не в его компетенции. Тебе нужно к заведующему составом обратиться, к лейтенанту например - только не выпрашивай повышений и ни в коем случае не говори об этом с Брэдли! Он меня уже не первый год в регистратуре держит из-за этого.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/16.mp3",
			["Answers"] = {
				{"Cпасибо.", 4,},
			},
		},
		[17] = {
			["Line"] = [[Здравствуйте! ..Я так понимаю, вы по делу?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/17.mp3",
			["Answers"] = {
				{"По делу. Нужно ваше разрешение для оформления лицензии на оружие.", 18, nil, function() return not (LocalPlayer():HasPistol() or LocalPlayer():HasRifle()) end},
				{"По делу. Нужно ваше разрешение для оформления лицензии на оружие.", 36, nil, function() return LocalPlayer():HasPistol() or LocalPlayer():HasRifle() end},
			},
		},
		[18] = {
			["Line"] = [[Вы в курсе действующих законов?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/18.mp3",
			["Answers"] = {
				{"Да.", 19,},
				{"Нет.", 20,},
			},
		},
		[19] = {
			["Line"] = [[Вы знаете, как обращаться с огнестрельным оружием?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/19.mp3",
			["Answers"] = {
				{
					"Да.", {21, 25, 27, 29},
				},
				{"Нет.", 20,},
			},
		},
		[20] = {
			["Line"] = [[В таком случае, я не могу разрешить вам ..разрешение. Подойдите позже.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/20.mp3",
			["Answers"] = {
				{"Ладно.", "MQS Fail quest",},
				{"Я всё равно возьму оружие.", "MQS Fail quest",},
				{"Это шутка такая!", "MQS Fail quest",},
			},
		},
		[21] = {
			["Line"] = [[Назовите хотя бы один принцип безопасного обращения с оружием.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/21.mp3",
			["Answers"] = {
				{"Не направлять оружие на людей.", 22,},
				{"Не направлять оружие туда, куда не собираешься стрелять.", 31,},
				{"Не стрелять в безоружных.", 22,},
				{"Не направлять оружие на критические участки тела и окружения.", 22,},
			},
		},
		[22] = {
			["Line"] = [[..А зачем вам оружие, если вы не собираетесь им пользоваться?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/22.mp3",
			["Answers"] = {
				{"Коллекционировать хочу.", 23,},
				{"Э-э..", 23,},
				{"Блин. Я не знаю эти ваши принципы.", 23,},
			},
		},
		[23] = {
			["Line"] = [[Я не могу оформить вам разрешение на оформление лицензии, пока вы не выучите четыре основных принципа безопасного обращения с оружием. Подойдите позже.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/23.mp3",
			["Answers"] = {
				{"Ладно.", "MQS Fail quest",},
				{"Я всё равно возьму оружие.", "MQS Fail quest",},
				{"Это шутка такая!", "MQS Fail quest",},
				{"А где мне их узнать?", 24,},
			},
		},
		[24] = {
			["Line"] = [[Посмотрите в интернете. На форуме на худой конец. Простите, ничем больше не могу вам помочь.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/24.mp3",
			["Answers"] = {
				{"Окей.", "MQS Fail quest",},
			},
		},
		[25] = {
			["Line"] = [[Назовите хотя бы один принцип безопасного обращения с оружием.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/21.mp3",
			["Answers"] = {
				{"Держать ситуацию под контролем, чтобы не пострадал никто лишний.", 26,},
				{"Узнать ситуацию глубже перед применением оружия.", 26,},
				{"Держать в прицеле только свою цель.", 26,},
				{"Знать свою цель и что находится за ней.", 31,},
			},
		},
		[26] = {
			["Line"] = [[..А если угроз несколько? Как минимизировать возможный ущерб? Как это сделать быстро?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/26.mp3",
			["Answers"] = {
				{"Стрелять по врагам сразу же.", 23,},
				{"Э-э..", 23,},
				{"Блин. Я не знаю эти ваши принципы.", 23,},
			},
		},
		[27] = {
			["Line"] = [[Назовите хотя бы один принцип безопасного обращения с оружием.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/21.mp3",
			["Answers"] = {
				{"Всегда обращаться с оружием, как с заряженным.", 31,},
				{"Никогда не передёргивать затвор, пока не появится прямая угроза.", 28,},
				{"Всегда разряжать оружие вне использования.", 28,},
				{"Никогда не заряжать оружие запрещёнными типами патронов.", 28,},
			},
		},
		[28] = {
			["Line"] = [[..А хватит ли вам времени отреагировать? Не проще ли с тем же успехом позвонить в полицию?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/28.mp3",
			["Answers"] = {
				{"С вашей реакцией - не проще.", 23,},
				{"Э-э..", 23,},
				{"Блин. Я не знаю эти ваши принципы.", 23,},
			},
		},
		[29] = {
			["Line"] = [[Назовите хотя бы один принцип безопасного обращения с оружием.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/21.mp3",
			["Answers"] = {
				{"Ставить палец на курок только когда собираешься стрелять.", 30,},
				{"Ставить оружие на предохранитель когда оно не используется.", 30,},
				{"Ставить палец на спусковой крючок только когда собираешься стрелять.", 31,},
				{"Ставить оружие под угол когда оно не используется.", 30,},
			},
		},
		[30] = {
			["Line"] = [[..А вы знаете, как устроено оружие?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/30.mp3",
			["Answers"] = {
				{"Конечно. В него вставляется обойма, а курок выстреливает гильзы.", 23,},
				{"Э-э..", 23,},
				{"Блин. Я не знаю эти ваши принципы.", 23,},
			},
		},
		[31] = {
			["Line"] = [[Где вы можете носить своё оружие, по закону?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/31.mp3",
			["Answers"] = {
				{"Где угодно, в любом виде. Нужно иметь возможность себя защитить.", 32,},
				{"Тяжёлое нельзя носить в общественном месте.", 33,},
				{"Тяжёлое оружие нельзя носить в принципе. С ним ходят или полицейские, или всякие нелегалы.", 32,},
				{"Зависит от ситуации. Что скажет районный администратор - так и будет.", 32,},
			},
		},
		[32] = {
			["Line"] = [[..Кажется, вы немного не знаете законов. Я не могу помочь вам в оформлении разрешения на оружие. Подойдите позже.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/32.mp3",
			["Answers"] = {
				{"Да что-ж такое!", "MQS Fail quest",},
				{"Я всё равно возьму оружие.", "MQS Fail quest",},
				{"Ладно.", "MQS Fail quest",},
			},
		},
		[33] = {
			["Line"] = [[Что-ж.. Вы прошли проверку! Ещё один небольшой вопрос, из чистого любопытства: для чего вам оружие?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/33.mp3",
			["Answers"] = {
				{"Чтобы убивать людей.", 34,},
				{"Чтобы защищать свою территорию.", 35,},
				{"Чтобы охотиться. Коллекция.", 34,},
				{"Чтобы защищать свой бизнес.", 35,},
			},
		},
		[34] = {
			["Line"] = [[..Кажется, вам нельзя оружие. Я передам информацию о вас старшему по смене.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/34.mp3",
			["Answers"] = {
				{"В смысле?!", "MQS Fail quest",},
			},
		},
		[35] = {
			["Line"] = [[Всё, прекрасно! Передайте пожалуйста паспорт, проверим вас по базе данных. Выпишем вам разрешение как узнаем подробности.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/35.mp3",
			["Answers"] = {
				{"Сейчас..", "MQS Continue quest",},
			},
		},
		[36] = {
			["Line"] = [[Подождите! Почему вы носите оружие без лицензии?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/36.mp3",
			["Answers"] = {
				{
					"Я..", {
						id = "MQS Skip to",
						data = {
							id = 58,
							quest_id = "license_gun"
						}
					}
				},
				{
					"Это муляж. Примеряю в кобуре.", {
						id = "MQS Skip to",
						data = {
							id = 58,
							quest_id = "license_gun"
						}
					}
				},
				{
					"Так я оформить её как раз хочу!", {
						id = "MQS Skip to",
						data = {
							id = 58,
							quest_id = "license_gun"
						}
					}
				},
			},
		},
		[37] = {
			["Line"] = [[Подождите. Вы.. Разыскиваемый, не двигаться!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/37.mp3",
			["Answers"] = {
				{"Чёрт!", "JailPlayer",},
				{"Я хочу сдаться.", "JailPlayer",},
				{"Попробуй поймай!", "JailPlayer",},
			},
		},
		[38] = {
			["Line"] = [[..Как вы догадались?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_cadet/38.mp3",
			["Answers"] = {
				{"Чуйка.", 4,},
				{"Тоже в него поигрываю. Вор вора видит издалека.", 4,},
				{"Не важно. Всего хорошего.", "close",},
			},
		},
	}
}

MCS.Spawns["mayor"] = {
	name = "Саманд Уокер",
	desc = "Секретарь",
	model = "models/cityrp/pm/suit/female_02.mdl",
	namepos = 72,
	theme = "Default",
	checkpos = true,
	scale = 1,
	hint = "m",
	questNPC = false,
	submat = {
		[1] = "models/gmodbest/citizens/facemaps/kanisha_facemap2",
		[5] = "models/gmodbest/suit/female/femsuit3"
	},
	pos = {
		["rp_southside_noire"] = {Vector(2508.525390625, 5103.5654296875, 0.031300000846386), Angle(0, 2.2606000900269, 0)},
		["rp_southside"] = {Vector(2508.525390625, 5103.5654296875, 0.031300000846386), Angle(0, 2.2606000900269, 0)},
	},
	sequence = "lineidle02",
	scare_anim = {"cower", "crouch_to_stand"},
	scare_timer = 39,
	scare_sound = "vo/npc/female01/help01.wav",
	uselimit = true,
	skin = 1,
	bgr = {
		[2] = 1,
	},
	ClModels = {},
	teams = {
		[15] = 6,
	},
	dialogs = {
	-- VOICE - JESSICA
		[1] = {
			["Line"] = [[Приветствую! Чем могу помочь?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/1.mp3",
			["Answers"] = {
				{"Я хочу записаться на приём к администратору.", 2, nil, function() return #team.GetPlayers(TEAM_MAYOR) > 0 end},
				{
					"Я хочу оставить подпись за отстранение районного администратора от должности.", 5, function()
						RunConsoleCommand("mayor_demote")
					end,
					function() return #team.GetPlayers(TEAM_MAYOR) > 0 end
				},
				{
					"Я хочу записаться на выборы.", "close", function()
						Slawer.Elections.MenuOpenRegister()
					end,
					function() return #team.GetPlayers(TEAM_MAYOR) < 1 end
				},
				{"Я хочу обзавестись лицензией.", 17, nil, function() return #team.GetPlayers(TEAM_MAYOR) < 1 end},
				{"Я хочу обзавестись лицензией.", 34, nil, function() return #team.GetPlayers(TEAM_MAYOR) >= 1 end},
				{"Я хочу устроиться на работу.", 3, nil, function() return MRS.GetPlyRank(LocalPlayer(), "NYC LD") <= 1 end},
				{"Есть нерешённые юридические вопросы?", "close", function()
					RunConsoleCommand("rp_job", 23)
				end, function() return MRS.GetPlyRank(LocalPlayer(), "NYC LD") > 1 end},
				{"Простите, кажется мне надо не сюда.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Так, сейчас.. Блин, опять глюки какие-то в системе. Вся очередь взяла и потерялась. Наверное, вам в таком случае можно и так подойти.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/2.mp3",
			["Answers"] = {
				{"Спасибо.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Это очень правильное решение! Но вам надо не сюда - это ратуша, а не центр занятости. Вам нужно в бизнес-центр корпорации World Corp. Когда вы выйдете на улицу, то пройдите чуть подальше от ратуши и посмотрите повыше - вам надо в большое стеклянное здание.
Или воспользуйтесь GPS. У вас ведь есть телефон?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/3.mp3",
			["Answers"] = {
				{"Спасибо за помощь.", "close",},
				{"Я хочу работать на государство. Врачом, полицейским например.", 4,},
			},
		},
		[4] = {
			["Line"] = [[А-а-а.. В таком случае, помочь вам не могу. Департаменты сами решают, по каким критериям нанимать; ратуша заняла все свободные вакансии, а мэрия.. Даже мне туда далеко. Простите.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/4.mp3",
			["Answers"] = {
				{"Спасибо.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Конечно! Подпишите тут, тут и тут.. а, и ещё тут. Готово! Удачного вам дня!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/5.mp3",
			["Answers"] = {
				{"Спасибо, до свидания.", "close",},
			},
		},
		--mayor_demote_self
		[6] = {
			["Line"] = [[Здравствуйте! У нас как всегда завал по работе, стараемся как можем.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/6.mp3",
			["Answers"] = {
				{"Я хочу уйти со своей должности.", 7,},
				{"У меня есть вопросы по районному администратору.", 9,},
				{"Хорошо.", "close",},
			},
		},
		[7] = {
			["Line"] = [[Вы точно уверены в этом? Нам без вас будет тяжело вести дела!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/7.mp3",
			["Answers"] = {
				{
					"Я уверен.", "close", function()
						RunConsoleCommand("mayor_demote_self")
					end
				},
				{"Шутка, успокойся.", "close",},
			},
		},
		[8] = {
			["Line"] = [[Вы же районный администратор - вам и нужно разбира-! ..Ой, то есть зависит от ситуации. Массовые беспорядки - нужно влияние; вооружённые разбои - финансирование ближайшего полицейского участка; денег мало - налоги.
Поговорите с народом, оглядитесь вокруг. Ответы сразу к вам придут.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/8.mp3",
			["Answers"] = {
				{"Спасибо. У меня есть ещё вопросы.", 10,},
				{"Спасибо, на этом пока всё.", "close",},
			},
		},
		[9] = {
			["Line"] = [[Ох, постараюсь помочь вам наилучшим образом! Знаете, через ваш пост прошло уже столько людей.. Кхм, какой у вас вопрос?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/9.mp3",
			["Answers"] = {
				{"Я так понимаю, обязанности районного администратора ничем не отличаются от мэра?", 11,},
				{"Чего мне стоит ожидать на данном посту?", 12,},
				{"Меня беспокоит вкладка 'Бюджет' в компьютере. За что стоит взяться в самом начале?", 8,},
				{"..Хотя, я лучше разберусь по ходу. Спасибо за время.", "close",},
			},
		},
		[10] = {
			["Line"] = [[Конечно!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/10.mp3",
			["Answers"] = {
				{"Я так понимаю, обязанности районного администратора ничем не отличаются от мэра?", 11,},
				{"Чего мне стоит ожидать на данном посту?", 12,},
				{"Меня беспокоит вкладка 'Бюджет' в компьютере. Что стоит 'улучшить' в самом начале?", 8,},
				{"Я хочу уйти со своей должности.", 7,},
				{"Спасибо, на этом пока всё.", "close",},
			},
		},
		[11] = {
			["Line"] = [[Ну.. почти! Мэр отвечает за весь город, а районный администратор только за свой район. Вам стоит почитать рабочую сводку административного района Квинс. Там английским по.. жёлтому расписано: все решения касаемо самого-слэш-только района перекладываются на плечи ответственного выдвиженца из народа. 

А уже тот отчитывается перед самим мэром. И другими источниками власти, разумеется.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/11.mp3",
			["Answers"] = {
				{"Спасибо. У меня есть ещё вопросы.", 10,},
				{"Спасибо. На этом всё.", "close",},
			},
		},
		[12] = {
			["Line"] = [[Всего что угодно! Мэрия переехала как раз из-за этого - слишком много опасности с улиц лезут в кабинет! Будьте готовы, что вас или часть бюджета захотят похитить. ..А вот что касается общерайонных происшествий, то это уже лежит полностью на вас. Ваш пост на то и существует - нужен ответственный за внештатные ситуации. Простите.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/12.mp3",
			["Answers"] = {
				{"Общерайонные происшествия? Можно поподробнее?", 13,},
				{"Спасибо. У меня есть ещё вопросы.", 10,},
				{"Спасибо. На этом всё.", "close",},
			},
		},
		[13] = {
			["Line"] = [[Бывает возникают ситуации, требующие внимание кого-то совсем-совсем сверху. Ну, то есть вас. Эти сообщения приходят к вам на компьютер, а дальше.. решать исключительно вам. Иногда действительно правильные решения совсем неочевидные. А иногда, бездействие является лучшим действием.

Следуйте зову сердца - одни и те же решения схожим ситуациям могут иметь разные последствия. Это результат, скажем так, невидимых факторов, не передаваемых через сообщение на расстоянии.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/13.mp3",
			["Answers"] = {
				{"Спасибо. У меня есть ещё вопросы.", 10,},
				{"Спасибо. На этом всё.", "close",},
			},
		},
		[14] = {
			["Line"] = [[Посмотрите новости! Там коротко разъяснено, что к чему.]],
			["Sound"] = "",
			["Answers"] = {
				{"А можно не коротко? Скажем так, небольшой секрет между нами?", 15,},
				{"Спасибо, как-нибудь почитаю.", "close",},
			},
		},
		[15] = {
			["Line"] = [[Ну раз так, то-

..Нет, вы меня не проведёте. Жители Бруклина точно в курсе что к чему, вы не отсюда! Вы почти поймали меня, инспектор.]],
			["Sound"] = "",
			["Answers"] = {
				{"..Да уж.", "close",},
			},
		},
		[16] = {
			["Line"] = [[Привет!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/16.mp3",
			["Answers"] = {
				{"Я хочу обзавестись лицензией.", 17},
			},
		},
		[17] = {
			["Line"] = [[Конечно! Держите бланк на первичную обработку документов.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/17.mp3",
			["Answers"] = {
				{
					"Спасибо.", {
						id = "MQS Start quest",
						data = {
							quest_id = "license_gun"
						}
					},
				},
			},
		},
		[18] = {
			["Line"] = [[На что вы хотите оформить лицензию?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/18.mp3",
			["Answers"] = {
				{"На бизнес.", 21, nil, function() return not DarkRP.HasBnslicense(LocalPlayer()) end},
				{"Пока ни на что. Хочу получить все необходимые бланки, чтобы сразу прийти с полным набором бумаг когда то потребуется.", 19,},
			},
		},
		[19] = {
			["Line"] = [[Вы же понимаете, что это так не работает?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/19.mp3",
			["Answers"] = {
				{"Простите, шутка такая.", 20,},
				{"Я не хочу повторять больничный опыт!", 20,},
				{"Тогда зайду в другой раз.", "MQS Fail quest",},
			},
		},
		[20] = {
			["Line"] = [[Нет уж, до свидания.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/20.mp3",
			["Answers"] = {
				{"Постойте..!", "MQS Fail quest",},
			},
		},
		[21] = {
			["Line"] = [[В таком случае, вам нужно получить разрешение от санитарного надзора. Вам с этим самым бланком в ближайший медцентр. ..Ой, секунду, нужно соответствующую печать поставить!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/21.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"Вы даже не поинтересовались, какой у меня бизнес.", 22,},
			},
		},
		[22] = {
			["Line"] = [[У нас в районе общее разрешение на все виды бизнесов. Во всех случаях нужно подтверждение от высших инстанций!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/22.mp3",
			["Answers"] = {
				{"Хорошо.", "MQS Continue quest",},
				{"А если я например собираюсь открыть похоронное бюро? Для живых клиентов?", 20,},
			},
		},
		[23] = {
			["Line"] = [[В таком случае, вам нужно получить справку о состоянии вашего психического здоровья. ..Ой, секунду, нужно соответствующую печать поставить!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/23.mp3",
			["Answers"] = {
				{
					"Хорошо.", {
						id = "MQS Skip to",
						data = {
							id = 27,
							quest_id = "license_gun"
						}
					},
				},
				{"Вы даже не поинтересовались, зачем мне оружие.", 24,},
			},
		},
		[24] = {
			["Line"] = [[А с этим вам потом к полиции обращаться, разрешение от них получать. Дело районной администрации - обработка документов, а не первичная проверка.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/24.mp3",
			["CallBack"] = {
				name = "licensflag"
			},
			["Answers"] = {
				{
					"Хорошо. Спасибо за уточнение.", {
						id = "MQS Skip to",
						data = {
							id = 27,
							quest_id = "license_gun"
						}
					},
				},
			},
		},
		[25] = {
			["Line"] = [[Снова здравствуйте!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/25.mp3",
			["Answers"] = {
				{"Вот документы. Всё на месте.", 26,},
				{"Слушайте, вот документы все при себе, а с типом лицензии ошибочка вышла. Можно ли как-то оформить по этим бумагам другую лицензию?", 19,},
			},
		},
		[26] = {
			["Line"] = [[Отлично! Ожидайте. Это займёт некоторое время.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/26.mp3",
			["Answers"] = {
				{"Да куда уж там..?", "MQS Continue quest",},
			},
		},
		[27] = {
			["Line"] = [[Готово! Поздравляем с получением лицензии на бизнес! Скоро мы обновим базу данных, и вы полноценно утвердитесь как предприниматель. Вы уже можете начинать остальные подготовления по новому виду деятельности.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/27.mp3",
			["CallBack"] = {
				name = "licensbus"
			},
			["Answers"] = {
				{"Спасибо!", "MQS Continue quest",},
				{"Наконец-то!", "MQS Continue quest",},
			},
		},
		[28] = {
			["Line"] = [[Готово! Поздравляем с получением лицензии на оружие! Скоро мы обновим базу данных, и вы утвердитесь как потенциальный владелец оружия. Помните о правилах обращения с оружием и не нарушайте закон!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/28.mp3",
			["CallBack"] = {
				name = "licensgun"
			},
			["Answers"] = {
				{"Спасибо!", "MQS Continue quest",},
				{"Наконец-то!", "MQS Continue quest",},
			},
		},
		[29] = {
			["Line"] = [[Простите, мы сейчас загружены по горло и по нос! Подойдите позже.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/29.mp3",
			["Answers"] = {
				{"Тогда зайду позже.", "close",},
				{"Вообще никак не получится? ..Ладно.", "close",},
				{"Да у вас всё по нос. Особенно бюрократия.", "close",},
			},
		},
		[30] = {
			["Line"] = [[Снова здравствуйте!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/25.mp3",
			["Answers"] = {
				{"Вот документы. Всё на месте.", 31,},
				{"Слушайте, вот документы все при себе, а с типом лицензии ошибочка вышла. Можно ли как-то оформить по этим бумагам другую лицензию?", 19,},
			},
		},
		[31] = {
			["Line"] = [[..А где разрешение от полиции?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/31.mp3",
			["Answers"] = {
				{"Какое разрешение?", 32,},
			},
		},
		[32] = {
			["Line"] = [[Ой, а я разве вам не сказала?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/32.mp3",
			["CallBack"] = {
				name = "licensflag"
			},
			["Answers"] = {
				{"Нет, вы не говорили.", 33,},
				{"..Точно. Простите. Я сейчас.", "MQS Continue quest",},
				{"Не помню.", 33,},
			},
		},
		[33] = {
			["Line"] = [[Простите пожалуйста! ..Теперь вы точно знаете. Через ратушу столько людей каждый день проходит, сложно! Вы ведь понимаете..?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/33.mp3",
			["Answers"] = {
				{"Если мне придётся оббежать весь город ради очередной бумажки..", "MQS Continue quest",},
				{"Понимаю. Я в участок и обратно.", "MQS Continue quest",},
				{"Надеюсь в полиции не работают такие же, как ты.", "MQS Continue quest",},
			},
		},
		[34] = {
			["Line"] = [[Обратитесь к районному администратору. Он сейчас вроде бы на месте.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/34.mp3",
			["Answers"] = {
				{"Хорошо, спасибо.", "close",},
				{"Он не хочет выписывать лицензии.", 35,},
				{"Его нет на месте. Можно ли как-то через вас оформиться?", 35,},
				{"Сука, вы все повязаны! К одному обращаешься - он к другому посылает! Хватит!", 36,},
				{"Может, мы как-нибудь договоримся?", 38,},
			},
		},
		[35] = {
			["Line"] = [[Простите, ничем не могу помочь. Регламент такой!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/35.mp3",
			["Answers"] = {
				{"Хорошо, спасибо.", "close",},
				{"Сука, вы все повязаны! К одному обращаешься - он к другому посылает! Хватит!", 36,},
				{"Может, мы как-нибудь договоримся?", 38,},
			},
		},
		[36] = {
			["Line"] = [[Пожалуйста, успокойтесь!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/36.mp3",
			["Answers"] = {
				{"Извините.", "close",},
				{"Нет. Я пользуюсь первой поправкой к конституции, имею право выражаться как хочу и где хочу!", 37,},
				{"Нет! Я сейчас воспользуюсь второй поправкой к конституции, если вы не примите первую!", 37,},
			},
		},
		[37] = {
			["Line"] = [[..Я вызываю полицию.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/37.mp3",
			["Answers"] = {
				{"..Ой.", "close",},
				{"Ну и ладно.", "close",},
				{"Не надо, я ухожу.", "close",},
			},
		},
		[38] = {
			["Line"] = [[Вы- ..но- ..Вы что? Мне нельзя.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/38.mp3",
			["Answers"] = {
				{
					"Никто ничего не заметит. У меня есть целых 300 причин, и я вам их передам.", {40, 41},
				},
				{"В этом городе никому ничего нельзя без лицензии. Пожалуйста, войдите в положение.", 39,},
				{"Ладно.", "close",},
				{"Я это запомню.", "close",},
			},
		},
		[39] = {
			["Line"] = [[Простите, я ничем не могу вам помочь.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/39.mp3",
			["Answers"] = {
				{
					"Никто ничего не заметит. У меня есть целых 300 причин, и я вам их передам.", {40, 41},
				},
				{"Ладно.", "close",},
				{"Я это запомню.", "close",},
			},
		},
		[40] = {
			["Line"] = [[Тогда.. ожидайте. ..Сейчас, мы подготовим необходимые формы, и всё для вас оформим. Подождите чуть-чуть в холле.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/40.mp3",
			["CallBack"] = {
				name = "licensenomoney"
			},
			["Answers"] = {
				{"Хорошо.", "close",},
			},
		},
		[41] = {
			["Line"] = [[Тогда.. Вот, держите форму. Только никому не говорите!]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/41.mp3",
			["CallBack"] = {
				name = "licensemoney"
			},
			["Answers"] = {
				{
					"Никому не скажу.", {
						id = "MQS Start quest",
						data = {
							quest_id = "license_gun"
						}
					},
				},
			},
		},
		[42] = {
			["Line"] = [[Здра- ..Постойте, а не вы ли случайно находитесь в активном розыске?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/42.mp3",
			["Answers"] = {
				{"Кажется, вы меня с кем-то путаете.", "close",},
				{"Сука!", "close",},
			},
		},
		[43] = {
			["Line"] = [[Вам нужна лицензия на оружие, и у вас.. висит оружие?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/43.mp3",
			["Answers"] = {
				{"Это муляж.", 44,},
				{"Старая просрочилась. Я всё делаю по закону, смысл мне врать?", 44,},
				{"Вам показалось.", 44,},
				{"А как иначе? Сначала ведь оружие покупается, а потом лицензия оформляется. Нет?", 44,},
			},
		},
		[44] = {
			["Line"] = [[..Я звоню в полицию.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/mayor/44.mp3",
			["Answers"] = {
				{
					"..Ой.", {
						id = "MQS Skip to",
						data = {
							id = 58,
							quest_id = "license_gun"
						}
					},
				},
				{
					"Ну и ладно.", {
						id = "MQS Skip to",
						data = {
							id = 58,
							quest_id = "license_gun"
						}
					},
				},
				{
					"Не надо, я ухожу.", {
						id = "MQS Skip to",
						data = {
							id = 58,
							quest_id = "license_gun"
						}
					},
				},
			},
		},
	}
}

if game.GetMap() == "rp_southside" then
	MCS.Spawns["mayor"].name = "Вероника Коттон"
	MCS.Spawns["mayor"].model = "models/cityrp/pm/suit/female_01.mdl"

	MCS.Spawns["mayor"].submat = {
		[3] = "models/gmodbest/citizens/facemaps/joey_facemap2",
		[5] = "models/gmodbest/suit/female/femsuit3"
	}
end

MCS.Spawns["police_arsenal_night"] = {
	name = "Клайд Бэрроу",
	desc = "Офицер Полиции",
	n_icon = Material("ranks_ui/icons/nypd/po.png", "smooth"),
	model = "models/cityrp/pm/nypd/male_02.mdl",
	namepos = 80,
	submat = {
		[0] = "models/gmodbest/citizens/facemaps/ted_facemap3"
	},
	theme = "Default",
	scale = 1,
	hint = 2,
	questNPC = false,
	pos = {
		["rp_southside"] = {Vector(8801.03125, 7608.1171875, -439.96875), Angle(0, 180, 0)},
	},
	sequence = "menu_combine",
	uselimit = false,
	skin = 0,
	bgr = {
		[1] = 0,
		[2] = 2,
		[3] = 2,
		[5] = 1,
	},
	ClModels = {},
	teams = {
		[3] = 2,
		[4] = 2,
		[5] = 2,
		[6] = 2,
		[7] = 2,
		[19] = 2,
		[15] = 4,
	},
	dialogs = {
		[1] = {
			["Line"] = [[Вы чего тут делаете?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal_night/1.mp3",
			["Answers"] = {
				{"Простите, кажется у меня развивается топографический кретинизм.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Добрый вечер.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal_night/2.mp3",
			["Answers"] = {
				{
					"Я хочу встать на смену.", "close", function()
						DarkRP.OpenJobMenuPolice()
					end,
					function() return LocalPlayer():Team() == 3 end
				},
				{
					"Я хочу сменить снаряжение.", "close", function()
						MSD.Loadout.Create()
					end,
					function() return LocalPlayer():isCP() and (MRS.GetNWdata(LocalPlayer(), "Rank") or 1) > 1 end
				},
				{"Я хочу сменить снаряжение.", 5, function() end, function() return LocalPlayer():isCP() and (MRS.GetNWdata(LocalPlayer(), "Rank") or 1) == 1 end},
				{
					"Я хочу закончить смену.", "close", function()
						RunConsoleCommand("rp_job", 3)
					end,
					function() return LocalPlayer():Team() ~= 3 end
				},
				{"Я хочу поговорить.", 3,},
				{"Потом зайду.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Слушай, мой дневной коллега на меня всю волокиту перевесил. Давай завтра?]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal_night/3.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[4] = {
			["Line"] = [[Добрый вечер.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal_night/2.mp3",
			["Answers"] = {
				{"Добрый.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Ты? Снаряжение? А не рановато ли? ..Тебе надо к сержанту Колдуэллу. Он работает в дневную смену.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_arsenal_night/5.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
	}
}

MCS.Spawns["police_evidence_night"] = {
	name = "Доминика Скалли",
	desc = "Офицер Полиции",
	n_icon = Material("ranks_ui/icons/nypd/po.png", "smooth"),
	model = "models/cityrp/pm/nypd/female_06.mdl",
	namepos = 80,
	theme = "Default",
	scale = 1,
	hasinv = {1000, "Изъятое имущество"},
	questNPC = false,
	pos = {
		["rp_southside"] = {Vector(8566.7431640625,7511.96875,-119.96875), Angle(0,90,0)},
	},
	extras = {
		policeEvidnce = true,
	},
	sequence = "menu_combine",
	uselimit = false,
	skin = 0,
	bgr = {
		[1] = 0,
		[3] = 2,
		[5] = 1,
	},
	ClModels = {
		{
			model = "models/cityrp/nypd/badge_po3.mdl",
			pos = Vector(3, -1.9, 7.25),
			ang = Angle(0, 150, 60),
			bone = 4
		},
	},
	teams = {
		[3] = 2,
		[4] = 2,
		[5] = 2,
		[6] = 2,
		[7] = 2,
		[19] = 2,
		[15] = 5,
	},
	dialogs = {
		[1] = {
			["Line"] = [[Для гражданских все вопросы в приёмную.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence_night/1.mp3",
			["Answers"] = {
				{"Простите, больше не буду отвлекать.", "close",},
			},
		},
		[2] = {
			["Line"] = [[Добрый вечер.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence_night/2.mp3",
			["Answers"] = {
				{"Я хочу сдать улики.", "Loot Npc", nil, function() return LocalPlayer():Team() ~= 3 end},
				--{"Я хочу сдать улики, по поручению.", 4,},
				{"Я хочу поговорить.", 3,},
				{"Потом зайду.", "close",},
			},
		},
		[3] = {
			["Line"] = [[Давай позже. У меня смена до утра.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence_night/3.mp3",
			["Answers"] = {
				{"...", "close",},
			},
		},
		[4] = {
			["Line"] = [[Это давай самостоятельно; дверь открыта. Я оформляю только официально - патрульных.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence_night/4.mp3",
			["Answers"] = {
				{"Ладно.", "close",},
				{"Лентяйка чёртова.", "close",},
			},
		},
		[5] = {
			["Line"] = [[Добрый вечер.]],
			["Sound"] = "https://macnco.one/cityrp/npcsound/police_evidence_night/2.mp3",
			["Answers"] = {
				{"Добрый.", "close",},
			},
		},
	}
}