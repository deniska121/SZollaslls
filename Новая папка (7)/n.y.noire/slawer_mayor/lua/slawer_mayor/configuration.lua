--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/configuration.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Slawer.Mayor.Power = 30
Slawer.Mayor.Proyob = 0
Slawer.Mayor.Petition = 0
Slawer.Mayor.Petitioner = {}

local cfg = {}

-- Your mayor job can't access to the computer?
-- That means that you didn't put "mayor = true," in your DarkRP job creation code

-- Language of the addon (you can look at slawer_mayor/languages/ to know which are available)
cfg.Language = "ru"

-- Disabled modules (true = disabled)
cfg.DisabledModules = {
	["funds"] = false, -- will disable safe spawning
	["licenses"] = false,
	["news"] = false, -- needs wanted part to be working properly
	["policemen"] = false,
	["reports"] = false, -- police/fdny reports app
	["taxs"] = false,
	["wanted"] = false, -- will disable wanted screen spawning (even if news is enabled)
	["warrants"] = false,
}

-- Does everything reset when there is no mayor? (funds, upgrades, taxes)
cfg.AllResetWhenNoMayor = false

-- City funds when the server starts
cfg.DefaultFunds = 500

-- Max city funds when the server starts
cfg.DefaultMaxFunds = 5000

-- Is the mayor able to withdraw from the safe?
cfg.CanMayorWithdrawFromSafe = true

-- MIN/MAX Values that a mayor can give as a bonus
cfg.MinMaxBonus = {10, 5000}

-- Max tax that a mayor can set (never set it greater than 100!)
cfg.MaxTax = 3

-- delay between each bonus (seconds)
cfg.BonusDelay = 10

-- Delay between each firing (seconds)
cfg.KickDelay = 10

-- Time to lockpick a safe (seconds)
cfg.LockpickTime = 30

-- Lockpicked safe alarm duration (seconds)
cfg.AlarmDuration = 20

-- Size of the safe (1 = default)
cfg.SafeSize = 1

-- Jobs that cannot have salary taxes
cfg.TaxesBlacklist = {
	["Gangster"] = true
}

-- Can mayor fire a policeman?
cfg.MayorCanKickCP = true

-- How many policemen are necessary to lockpick the safe? (civil protection teams)
cfg.MinCopsToLockpick = 0

-- Can the a job lockpick a safe? (leave empty if everyone can)
-- if you want to put a job its like this:

cfg.LockpickWhitelist = {
	["Нелегал"] = true
}

-- Upgrades that can be bought with the funds of the city
cfg.Upgrades = {}

cfg.Upgrades[1] = {
	Name = "Полицейские бронежилеты",
	Description = "Закупка дополнительных бронежилетов позволит сократить время их поступления в арсеналы NYPD. Количество доступной защиты также увеличится.",
	DefaultLevel = 0,
	Levels = {
		[0] = {
			Armor = 5,
			Time = 300
		},
		[1] = {
			Price = 500,
			Armor = 7,
			Time = 240,
		},
		[2] = {
			Price = 2000,
			Armor = 10,
			Time = 120,
		},
	}
}

cfg.Upgrades[2] = {
	Name = "Оптимизация логистики",
	Description = "Выделение средств на новый транспорт ускорит доставку товаров на склады, а со складов - в бизнесы. Дополнительные деньги покроют топливные расходы.",
	DefaultLevel = 0,
	Levels = {
		[0] = {},
		[1] = {
			Price = 1000,
		},
		[2] = {
			Price = 1500,
		},
	}
}

cfg.Upgrades[3] = {
	Name = "Влияние (мэрия)",
	Description = "Для продуктивного диалога с высшей городской властью, нам необходимо доказать нашу заинтересованность в жизни Бруклина. Один из этапов выстраивания отношений - денежное доказательство работоспособности ваших реформ.",
	DefaultLevel = 0,
	Levels = {
		[0] = {
		},
		[1] = {
			Price = 5000,
		},
	},
	Check = function(ply)
		local found = 0

		for i = 1,5 do
			if Slawer.Mayor:GetUpgradeLevel(i) > 0 then
				found = found + 1
			end
		end

		return found >= 3
	end,
	CheckMsg = "Для разблокировки необходимо вложить бюджет в различные улучшения района"
}

cfg.Upgrades[4] = {
	Name = "Налоги",
	Description = "Увеличение максимального порога налогооблажения позволит нам эффективнее собирать будущий бюджет. Это налог для локальных предприятий - он идёт отдельно от федерального налога.",
	DefaultLevel = 0,
	Levels = {
		[0] = {
			tax = 0,
		},
		[1] = {
			Price = 1000,
			tax = 2,
		},
		[2] = {
			Price = 2000,
			tax = 5,
		},
		[3] = {
			Price = 3000,
			tax = 7,
		},
		[4] = {
			Price = 4000,
			tax = 12,
		}
	},
	Check = function(ply)
		return Slawer.Mayor:GetUpgradeLevel(3) > 0
	end,
	CheckMsg = "Для разблокировки необходимо влияние в мэрии"
}

cfg.Upgrades[5] = {
	Name = "Влияние (район)",
	Description = "Когда диалог с населением не задаётся, а имитации бурной деятельности недостаточно - мы можем.. накрутить статистику в вашу пользу. Это не спасёт ваш пост, если люди соберут петиции в большем количестве.",
	DefaultLevel = 0,
	Levels = {
		[0] = {
		},
		[1] = {
			Price = 2000,
		},
		[2] = {
			Price = 5000,
		},
		[3] = {
			Price = 10000,
		},
	},
	OnUpgrade = function(intID, intLevel)
		Slawer.Mayor.Power = 30 + intLevel * 20
	end,
}

cfg.Upgrades[6] = {
	Name = "Локализация бюджета",
	Description = "Мы можем увеличить наш максимальный бюджет его локализацией - хранением дополнительной части средств в сейфе вашего кабинета.",
	DefaultLevel = 0,
	Levels = {
		[0] = {},
		[1] = {
			Price = 5000,
			MaxFunds = 10000
		},
		[2] = {
			Price = 7000,
			MaxFunds = 20000
		}
	},
	OnUpgrade = function(intID, intLevel)
		Slawer.Mayor:SetMaxFunds(Slawer.Mayor.CFG.Upgrades[intID].Levels[intLevel].MaxFunds)
	end,
	Check = function(ply)
		local found = 0

		for i = 1,5 do
			if Slawer.Mayor:GetUpgradeLevel(i) > 0 then
				found = found + 1
			end
		end

		return found >= 3
	end,
	CheckMsg = "Для разблокировки необходимо вложить бюджет в различные улучшения района"
}

cfg.Upgrades[7] = {
	Name = "Программа спонсирования",
	Description = "Программа спонсирования позволит получать нам дополнительные средства из городского бюджета каждый фиксированный промежуток времени. Чем больше людей работает - тем больше средств нам выделяют.",
	DefaultLevel = 0,
	Levels = {
		[0] = {},
		[1] = {
			Price = 1800,
		},
	},
	Check = function(ply)
		return Slawer.Mayor:GetUpgradeLevel(6) > 0
	end,
	CheckMsg = "Для разблокировки необходимо локализировать бюджет"
}

cfg.Upgrades[8] = {
	Name = "Программа трудоустройства",
	Description = "Программа трудоустройства спонсирует частные компании, базирующиеся в нашем районе. Это позволит увеличить количество рабочих мест и принесёт нам больше должностей.",
	DefaultLevel = 0,
	Levels = {
		[0] = {},
		[1] = {
			Price = 500,
		},
	},
}

cfg.Upgrades[9] = {
	Name = "Программа субсидирования",
	Description = "Программа субсидирования организовывает налоговый вычет рабочим каждый зарплатный период. Это значит, что мы возвращаем деньги гражданам из нашего бюджета. Перед оформлением субсидий лучше подготовиться экономически.",
	DefaultLevel = 0,
	Levels = {
		[0] = {},
		[1] = {
			Price = 100,
		},
	},
	Check = function(ply)
		return Slawer.Mayor:GetUpgradeLevel(6) > 0
	end,
	CheckMsg = "Для разблокировки необходимо локализировать бюджет"
}

cfg.Upgrades[10] = {
	Name = "Обучение специалистов",
	Description = "Подготовка ответственных подручных поможет решать спорные ситуации, возникающие в районе. Когда кто-то решает дела за вас - вам не придётся вмешиваться самостоятельно.",
	DefaultLevel = 0,
	Levels = {
		[0] = {},
		[1] = {
			Price = 1500,
		},
		[2] = {
			Price = 1500,
		},
	}
}

cfg.Reports = {
	SendCooldown = 15,
	MaxTitleLength = 120,
	MaxBodyLength = 4000,
	FreeTheme = "Свободная тема",

	-- Who may delete reports. Deletion is allowed for a report in a department the
	-- player is currently on duty in, when either their SteamID is listed here, or
	-- their rank in that department's group is >= the value configured for it.
	CanDelete = {
		steamids = {
			"STEAM_0:0:47288123",
			"STEAM_0:0:47288123",
		},
		ranks = {
			["nypd"] = 8,
			["fdny"] = 8,
		},
	},

	-- Departments that have access to the reports app.
	-- A player can only read a report while on duty in that report's department
	-- (this applies even to reports the player wrote themselves).
	--   name  = full name shown in the app header
	--   group = MRS rank group, used when matching recipients by rank id
	--   icon  = win98 icon shown in the app header
	--   check = function deciding whether a player currently belongs to the department
	Departments = {
		["nypd"] = {
			name = "New York City Police Department",
			group = "NYPD",
			icon = "nypd",
			check = function(ply) return ply:isCP() end,
		},
		["fdny"] = {
			name = "Fire Department of the City of New York",
			group = "FDNY",
			icon = "fdny",
			check = function(ply) return ply:isEMS() end,
		},
	},

	Recipients = {
		["pct_com"] = {
			name = "Командир участка",
			dept = "nypd",
			themes = {
				"Перевод в другое бюро",
				"Жалоба на сотрудника",
				"Доклад по ситуации",
				"Отпуск/продление отпуска",
				"Межведомственное сообщение",
				"Свободная тема",
			},
			rank = 8,
		},
		["fto"] = {
			name = "Координатор программы полевой подготовки",
			dept = "nypd",
			themes = {
				"Отчет о проделанной работе",
				"Рапорт наставника",
				"Заявление на участие в программе",
				"Заявление на уход из программы",
			},
			rank = 6,
		},
		["sht_com"] = {
			name = "Начальник смены",
			dept = "nypd",
			themes = {
				"Отчет о проделанной работе",
				"Доклад по ситуации",
				"Рапорт о собственном нарушении",
				"Внутренний инцидент",
				"Свободная тема",
			},
			rank = 7,
		},
		["det_com"] = {
			name = "Координатор детективного подразделения",
			dept = "nypd",
			themes = {
				"Отчет о проделанной работе",
				"Доклад по ситуации",
				"Доклад о расследовании",
				"Свободная тема",
			},
			steamids = {
				"STEAM_0:0:47288123",
			},
			rank = 8,
		},
		["iab"] = {
			name = "Отдел внутренних расследований",
			dept = "nypd",
			themes = {
				"Жалоба на сотрудника",
				"Рапорт о собственном нарушении",
				"Внутренний инцидент",
			},
			rank = 11,
		},
		["fdny_chief"] = {
			name = "Начальник станции",
			dept = "fdny",
			themes = {
				"Рапорт о происшествии",
				"Отчет о проделанной работе",
				"Доклад по ситуации",
				"Межведомственное сообщение",
				"Перевод",
				"Свободная тема",
			},
			rank = 7,
		},
	},
}

Slawer.Mayor.CFG = cfg

local quests = {
	["fisherman1"] = true,
	["cleaner1"] = true,
	["loader1"] = true,
	["newsman1"] = true,
}

hook.Add("MQS.PreventTaskStart", "DarkRP.MayorShit", function(ply, id, quest)
	if quests[id] and Slawer.Mayor:GetUpgradeLevel(8) < 1 then return true, "Работы не доступны" end
end)