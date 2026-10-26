--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/language/sh_english.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


-- DO NOT remove the english language!
local english = {
	-- Admin things
	need_admin = "Вы должны быть администратором ",
	need_sadmin = "Вы должны быть администратором ",
	no_jail_pos = "Нет тюрьмы",
	invalid_x = "Неверное значение",

	-- F1 menu
	mouse_wheel_to_scroll = "Используйте колесо мыши чтобы прокрутить станицу",

	-- Money things:
	customer_price = "Цена: %s ",
	reset_money = "%s обнулил все деньги игроков ",
	has_given = "%s дал вам %s",
	you_gave = "Вы дали %s %s",
	npc_killpay = "%s за убийство  NPC ",

	payday_message = "Уважаемый клиент,\nЗаработная плата в размере %s ожидает вашего снятия. Воспользуйтесь ближайшим банкоматом для подтверждения транзакции.\n\nВаш Bank of Union.",
	payday_unemployed = "Вы не получили зарплату, потому что вы безработный",
	payday_missed = "Вы не получили зарплату, потому что вы арестованы",

	property_tax = "Налог за недвижимость %s",
	property_tax_cant_afford = "Вы не в состоянии заплатить за дом Ваша недвижимость продана ",
	tax_lockdown = "Уважаемый гражданин! В связи с активным комендантским часом, организационные мероприятия и ваши официальные выплаты задержаны. Районный бюджет частично компенсировал вашу оплату труда суммой в %s долларов.\n\nНадеемся на понимание.",

	-- Players
	wanted = "Вы в розыске!",
	youre_arrested = "Вы арестованны на %d секунд ",
	hes_arrested = "%s был арестован на %d секупд ",
	hes_unarrested = "%s был освобожден ",
	health = "Здоровье: ",
	job = "Работа: %s",
	salary = "Зарплата: %s%s",
	wallet = "Наличные: %s%s",
	warrant_request = "%s разыскивается за %s",
	warrant_test = "Уважаемый %s\nОкружная Полиция получила разрешение на обыск вашего имущества.\nПричина обыска:\n%s\n\nОбжаловать решение можно в суде",
	wanted_test = "Уважаемый %s\nОкружная Полиция объявила вас в розыск.\nПричина розыска:\n%s\n\nНастоятельно рекомендуем вам самостоятельно прибыть в местное отделение Полиции. В противном случае, не сопротивляйтесь аресту.",
	warrant_request2 = "Запрос на розыск отправлен меру %s ",
	warrant_approved = "Запрос на розыск подтверждён %s ",
	warrant_approved2 = "Вам теперь можно обыскать его дом.",
	warrant_denied = "Районный администратор %s отклонил ваш запрос на розыск.",
	warrant_expired = "Ордер отменен",
	wanted_by_police = "%s в розыске ",
	wanted_expired = "%s больше не в розыске.",
	rpname_changed = "%s сменил ник на: %s",

	-- Teams
	need_to_be_before = "Вы должны быть %s чтобы стать %s",
	need_to_make_vote = "Вы должны создать голосование %s!",
	team_limit_reached = "Вы не можете стать %s достигнут лимит ",
	wants_to_be = "%s\nхочет быть\n%s",
	has_not_been_made_team = "%s не стал %s ",
	job_has_become = "%s стал %s ",

	-- Disasters
	meteor_approaching = "Внимание метеоритный шторм!",
	meteor_passing = "Меориты не оставили от нас не чего.",
	meteor_enabled = "Метеоритный шторм включён.",
	meteor_disabled = "Метеориты отключены.",
	earthquake_report = "Мы засекли землетрясение силой %sMw",
	earthtremor_report = "Земляная дрожь сообщила о магнитуде %sMw",

	-- Keys, vehicles and doors
	keys_allowed_to_coown = "Вы имеете право владеть дверью вместе с \n(Нажмите F2 или R+Ключи)\n",
	keys_other_allowed = "Разрешено владеть:\n %s",
	keys_allow_ownership = "(Нажмите F2 чтобы разрешить совладение)",
	keys_disallow_ownership = "(Нажмите F2 чтобы забрать совладение с вашей дверью)",
	keys_owned_by = "Владелец: ",
	keys_cops_and_mayor = "Вся полиция",
	keys_unowned = "Без владельца\n(Нажмите F2 чтобы купить)",
	keys_everyone = "(Нажмите F2 чтобы разрешить всем)",
	keys_cops = "(Нажмите F2 чтобы сделать только для полиции)",
	door_unown_arrested = "Вы не можете купить это пока вы под арестом ",
	door_unownable = "Дверь нельзя купить ",
	door_sold = "Вы продали это за %s",
	door_already_owned = "Дверь кем-то куплена ",
	door_cannot_afford = "Вы не можете купить эту дверь ",
	door_hobo_unable = "Вы бомж!",
	vehicle_cannot_afford = "У вас не хватает денег на машину ",
	door_bought = "Вы купили дверь за %s",
	vehicle_bought = "Вы купили машину за %s",
	door_need_to_own = "Вы должны купить эту дверь чтобы %s",
	door_rem_owners_unownable = "Вы не можете удалить владельцев ",
	door_add_owners_unownable = "Вы не можете добавить владельца ",
	rp_addowner_already_owns_door = "%s уже владеет (или уже добавлен в совладельцы) этой дверью ",

	-- Talking
	hear_noone = "Вас никто не слышит ",
	hear_everyone = "Все вас слышат ",
	hear_certain_persons = "Вас слышат: ",

	whisper = "Шепчет",
	yell = "Кричит",
	advert = "[Объявление]",
	radio = "Радио",
	request = "(Запрашивает!)",
	group = "(Группа)",


	-- Notifies
	disabled = "%s отключён! %s",
	limit = "Вы достигли %s лимит ",
	have_to_wait = "Подождите %d секунд перед использованием %s ",
	must_be_looking_at = "Вы должны смотреть %s ",
	incorrect_job = "У вас не та работа чтобы %s",
	unavailable = "Это %s недоступно",
	unable = "Вы не в состоянии %s. %s",
	cant_afford = "Вы не можете себе этого позволить %s",
	created_x = "%s создал %s",
	cleaned_up = "Вы %s были очищены.",
	you_bought_x = "Вы купили %s за %s",

	created_first_jailpos = "Вы создали первую позицию тюрьме ",
	added_jailpos = "Вы добавили одну дополнительную позицию тюрьме ",
	reset_add_jailpos = "Вы удалили все тюрьмы и вы добавили новый здесь.",
	created_spawnpos = "%s's спавн позиция созданна.",
	updated_spawnpos = "%s's спавн позиция обновленна.",
	do_not_own_ent = "Вы не владеете этой вещью!",
	cannot_drop_weapon = "Вы не можете выкинуть это!",
	team_switch = "Работа изменена!",

	-- Misc
	could_not_find = "Не возможно найти %s",
	f3tovote = "Нажмите F3 чтобы проголосовать",
	listen_up = "Слушайте", -- In rp_tell or rp_tellall
	nlr = "New Life Rule: Вы всё забыли.",
	reset_settings = "Все настройки сброшены!",
	must_be_x = "Вы должны быть %s чтобы %s.",
	agenda_updated = "Повестка была обновлена.",
	job_set = "%s сменил/ла работу на '%s'",
	demoted = "%s был понижен",
	demoted_not = "%s не был понижен ",
	demote_vote_started = "%s создал голосование на понижение %s",
	demote_vote_text = "Причина понижения:\n%s", -- '%s' is the reason here
	lockdown_started = "Комендантский час, идите домой!",
	lockdown_ended = "Комендантский час закончился",
	gunlicense_requested = "%s запросил %s лицензию на оружие",
	gunlicense_granted = "%s дал %s лицензию на оружие",
	gunlicense_denied = "%s отобрал %s лицензию на оружие",
	gunlicense_question_text = "Дать ли %s лицензию на оружие?",
	gunlicense_remove_vote_text = "%s начал голосование за удаление лицензии у %s",
	gunlicense_remove_vote_text2 = "Отобрать лицензию на оружие за:\n%s", -- Where %s is the reason
	gunlicense_removed = "%s's лицензию на оружие отобрана ",
	gunlicense_not_removed = "%s's лицензию на оружие не отобрана ",
	vote_specify_reason = "Вам нужна причина ",
	vote_started = "Голосование началось",
	vote_alone = "Вы выйграли голосование потому что вы один на севере.",
	jail_punishment = "Наказание за дисконнект! Вы в тюрьме на: %d секунд.",
	admin_only = "Только администратору ", -- When doing /addjailpos
	chief_or = "Шев или",-- When doing /addjailpos

	dead_in_jail = "Вы умерли в тюрьме ",
	died_in_jail = "%s умер в тюрьме ",

	-- The lottery
	lottery_started = "Лотерея! Участие за %s",
	lottery_entered = "Вы участвуете в лотереи за %s",
	lottery_not_entered = "%s вы не участвуете в лотереи",
	lottery_noone_entered = "Никто не участвует в лотереи",
	lottery_won = "%s выйграл в лотереи! Он выйграл %s",

	-- Hungermod
	starving = "Голод ",

	-- F4menu
	-- Tab 1
	give_money = "Дать деньги игроку перед собой",
	drop_money = "Бросить деньги",
	change_name = "Сменить РП имя",
	go_to_sleep = "Леч спать/проснуться",
	drop_weapon = "Выкинуть оружие",
	buy_health = "Купить здоровье(%s)",
	request_gunlicense = "Запросить лицензию на оружие",
	demote_player_menu = "Понизить игрока",


	searchwarrantbutton = "Добавить в розыск",
	unwarrantbutton = "Убрать статус 'розыскиваемый' с игрока",
	noone_available = "Нет доступных персонажей",
	request_warrant = "Запросить обыск игрока",
	make_wanted = "Добавить игрока в розыск",
	make_unwanted = "Убрать розыск с игрока",
	set_jailpos = "Установить тюрьму",
	add_jailpos = "Добавить позицию тюрьмы",

	set_custom_job = "Запустить работу",

	set_agenda = "Включить повестку",

	initiate_lockdown = "Начать комендантский час",
	stop_lockdown = "Остановить комендантский час",
	start_lottery = "Начать лотерею",
	give_license_lookingat = "Дать лицензию человеку перед собой",

	-- Second tab
	job_name = "Название: ",
	job_description = "Описание: " ,
	job_weapons = "Оружие: ",

	-- Entities tab
	buy_a = "Купить %s: %s",

	-- Licenseweaponstab
	license_tab = [[Оружие с лицензией

	Оружия которые люди могут носить без лицензии!
	]],
	license_tab_other_weapons = "Другое оружие:",
}

DarkRP.addLanguage("en", english)
