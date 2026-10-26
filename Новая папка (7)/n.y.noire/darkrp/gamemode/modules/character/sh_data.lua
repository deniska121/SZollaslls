--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/character/sh_data.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCR.Config = {}

MCR.Config.Cams = {
	[1] = {
		st = {
			pos = Vector(815.33795166016, -4290.3120117188, 981.59234619141),
			ang = Angle(-0.57916700839996, -131.41290283203, 0),
			fov = 25,
			spd = 1,
			aspd = 1
		},
		ed = {
			pos = Vector(815.33795166016, -4290.3120117188, 981.59234619141),
			ang = Angle(-5.7195725440979, -80.07663726807, 0),
			fov = 75,
			spd = 1,
			aspd = 1
		},
	},
	[2] = {
		st = {
			pos = Vector(-1228.9605712891, 3637.3056640625, 421.50433349609),
			ang = Angle(-47.226600646973, 90, 0),
			fov = 45,
			spd = 1,
			aspd = 1
		},
		ed = {
			pos = Vector(-1228.9605712891, 3637.3056640625, 421.50433349609),
			ang = Angle(14.255506515503, 90, 0),
			fov = 120,
			spd = 1,
			aspd = 1
		},
	},
	[3] = {
		st = {
			pos = Vector(1924.6267089844, 369.74279785156, 403.95388793945),
			ang = Angle(20.561576843262, 155.43455505371, 0),
			fov = 65,
			spd = 1,
			aspd = 1
		},
		ed = {
			pos = Vector(2124.0249023438, 533.54272460938, 536.03662109375),
			ang = Angle(4.1992945671082, 69.133949279785, 0),
			fov = 45,
			spd = 1,
			aspd = 1
		},
	},
	[4] = {
		st = {
			pos = Vector(3085.1787109375, 9277.8115234375, 321.4450378418),
			ang = Angle(0, 180, 0),
			fov = 90,
			spd = 1,
			aspd = 1
		},
		ed = {
			pos = Vector(5764.91796875, 9272.7080078125, 369.86752319336),
			ang = Angle(0, 180, 0),
			fov = 30,
			spd = 1,
			aspd = 1
		},
	},
	[5] = {
		st = {
			pos = Vector(-7670.3090820313, 6595.26171875, 48.525058746338),
			ang = Angle(0, -90, 60),
			fov = 90,
			spd = 1,
			aspd = 1
		},
		ed = {
			pos = Vector(-7670.3090820313, 6595.26171875, 48.525058746338),
			ang = Angle(0, -90, -20),
			fov = 45,
			spd = 1,
			aspd = 1
		},
	},
}

MCR.Config.GaragePos = Vector(-1551.4237060547, 4676.9638671875, 1480.03125)

MCR.Config.TimeNeed = {
	[1] = nil,
	[2] = 36000,
	[3] = 36000,
	[4] = 604800,
}

MCR.Config.Texts = {
	[1] = {
		name = "Гражданский",
		descr = "Гражданский – самая большая, и самая незаменимая ячейка общества. Продавцы и дворники, предприниматели и обыватели.. У них никогда не приходило в голову раскрыть свои амбиции полностью, а отсутствие нужного опыта закрыло им пути как государственной службы, так и отхождения от закона слишком далеко. Пусть и бывает скучно, зато это стабильность."
	},
	[2] = {
		name = "Госдепартамент",
		descr = "Госдепартамент – большая честь и обязанность. Государство обещает порядок и процветание, и государственные сотрудники – исполнители этих обещаний. Однако, это не значит, что сразу же будет 'весело' – порядок не про веселье. Порядок про патрули, проверки, заполнение бумаг и успешное удерживание оружия в кобуре. Веселье это хаос. Хаос – отсутствие порядка. Оружие применяется только тогда."
	},
	[3] = {
		name = "Нелегал",
		descr = "Нелегал – такой же гражданский, с одним большим исключением – опыт. Этот опыт позволил вовремя обзавестись необходимыми контактами для успешной нелегальной деятельности. Люди по ту сторону закона вполне враждуют друг с другом, иногда даже собираются в большие группы для достижения 'высших' целей.. Однако, они всё равно контактируют с одними и теми же специфическими кадрами. Какие недоступны простым людям."
	},
}

MCR.Config.MainCam = {
	pos = Vector(-1927.6800537109, 4683.1669921875, 1264.03125),
	ang = Angle(6.3697438240051, -70.503646850586, 0)
}

MCR.Config.ShopCam = {
	pos = Vector(-1969.4587402344, 10394.267578125, 200),
	ang = Angle(20.046154022217, -175.25086975098, 0)
}

MCR.Config.CharCam = {
	pos = Vector(6622.3764648438, 4863.072265625, 288.03125),
	ang = Angle(11.466708183289, 165.07008361816, 0)
}

MCR.Config.CharP = {
	["main"] = {Vector(6565.25, 4878.4375, 224.03125), Angle(0, -23.362426757813, 0)},
	[1] = {Vector(-1904.4672851563, 4615.8247070313, 1200.03125), Angle(3.5027134418488, 86.653617858887, 0)},
	[2] = {Vector(8554.1875, 8077.53125, 200.03125), Angle(0, -144.580078125, 0)},
	[3] = {Vector(4268.5883789063,675,-101.44020080566), Angle(0, 0, 0)},
	["shop"] = {Vector(-2032.3125, 10390.5625, 132), Angle(0, -0.15380859375, 0)},
}

MCR.Config.CharC = {
	[1] = {Vector(-1927.6800537109, 4683.1669921875, 1264.03125), Angle(6.3697438240051, -70.503646850586, 0)},
	[2] = {Vector(8506.7451171875, 8038.0375976563, 264.03125), Angle(8.279088973999, 29.047401428223, 0)},
	[3] = {Vector(4324.8310546875,673.40777587891,-35.986015319824), Angle(6.3708095550537,-179.1720123291,0)}
}

MCR.SkinsID = {}

for i = 1, 9 do
	util.PrecacheModel("models/cityrp/pm/nb/male_0" .. i .. ".mdl")
	util.PrecacheModel("models/cityrp/pm/normal/male_0" .. i .. ".mdl")
	util.PrecacheModel("models/cityrp/pm/nypd/male_0" .. i .. ".mdl")
	util.PrecacheModel("models/cityrp/pm/suit/male_0" .. i .. ".mdl")
end

for i = 1, 6 do
	util.PrecacheModel("models/cityrp/pm/nb/female_0" .. i .. ".mdl")
	util.PrecacheModel("models/cityrp/pm/normal/female_0" .. i .. ".mdl")
	util.PrecacheModel("models/cityrp/pm/nypd/female_0" .. i .. ".mdl")
	util.PrecacheModel("models/cityrp/pm/suit/female_0" .. i .. ".mdl")
end

MCR.FaceRawMX = {
	["male_01"] = 17, -- van
	["male_02"] = 29, -- ted
	["male_03"] = 23, -- joe
	["male_04"] = 27, -- eric
	["male_05"] = 21, -- art
	["male_06"] = 23, -- sandro
	["male_07"] = 24, -- mike 
	["male_08"] = 17, -- vance
	["male_09"] = 20, -- erdim
	["female_01"] = 19, -- joey
	["female_02"] = 19, -- kanisha
	["female_03"] = 7, -- kim
	["female_04"] = 13, -- chau
	["female_05"] = 8, -- lekeetra
	["female_06"] = 12 -- naomi
}

MCR.ArmsLatin = {
	["male_05"] = {
		[4] = "arms_tan",
		[9] = "arms_tan",
		[11] = "arms_latin",
	},
	["male_06"] = {
		[11] = "arms_latin",
		[21] = "arms_latin"
	},
	["male_07"] = {
		[9] = "arms_tan",
	},
	["male_04"] = {
		[5] = "arms_latin",
		[6] = "arms_latin",
		[7] = "arms_latin",
		[13] = "arms_latin",
		[14] = "arms_tan",
		[17] = "arms_tan",
		[27] = "arms_latin"
	},
	["male_09"] = {
		[8] = "arms_tan",
		[12] = "arms_tan",
		[14] = "arms_tan",
		[15] = "arms_tan"
	}
}

MCR.names = {}
MCR.names.male = {}
MCR.names.female = {}
MCR.names.surnames = {}

MCR.names.female.w = {"Amanda", "Alice", "Barbara", "Charlotte", "Evelyn", "Emma", "Mia", "Marie", "Mary", "Laila", "Natalie", "Samantha", "Poppy", "Sophia", "Stephanie", "Dominique", "Sabrina", "Olivia", "Willow", "Carol", "Diana", "Sam", "Sarah", "Alex", "Max", "Amber", "Ruby", "Karen", "Robin", "Linda", "Alisson", "Violet", "Charlie", "Jessica", "Angel", "Phoebe", "Meredith", "Cassie", "Rory", "Hillary", "Elizabeth", "Virginia", "June", "Boe", "Jennifer"}

MCR.names.female.b = {"Aaliyah", "Imani", "Laila", "Jordan", "Thema", "Takeisha", "Patricia", "Shantae", "Miranda", "Zuri", "Joy", "Sam", "Alex", "Sarah", "Sabina", "Regina", "Thairee", "Jadonna", "Carline", "Sheylinn", "Jarnesha", "Pearlina", "Laquita", "Jumana", "Jewel"}

MCR.names.female.a = {"Naomi", "Huang", "Hou", "Tao", "Zou", "Gong", "Yui", "Lei", "Liu", "Tian", "Shao", "Fang", "Yuan", "Fenhua", "Yawen", "Rei", "Mai", "Mei", "Sun", "Jin", "Peng", "Liang"}

MCR.names.male.w = {"Aaron", "Anthony", "Tommy", "Alex", "Matthew", "Paul", "Ben", "Terry", "Felix", "Rudy", "Adam", "Russell", "David", "Edward", "John", "Jack", "James", "Jeremy", "Joel", "Dominic", "George", "Henry", "Kevin", "Paul", "Max", "Michael", "Noah", "Liam", "Lucas", "Robin", "Robert", "Sam", "Steven", "Elliot", "Carl", "Chad", "Oliver", "Jerry", "Frank", "Troy", "Marcelle", "Dylan", "Mitchell", "Cassidy", "Tobias", "Casey", "Edgar", "Connor", "Chase", "Wayne", "Raymond", "Jake", "Mark", "Wade", "Ian", "Cole", "Brandon", "Graham", "Todd", "Marvin", "Will", "Ronnie", "Quentin", "Stephen", "Martin", "Tyler", "Christopher", "Leopold", "Donovan", "Sylvester", "Joe", "Freddie", "Francis", "Bill", "Jim", "Archie", "Tom", "Patrick", "Vince", "Nash"}

MCR.names.male.b = {"Aaron", "Eric", "Keagan", "Paul", "Alex", "Terry", "John", "Robert", "Samuel", "Miles", "Caleb", "Jeremy", "Marcus", "Jaden", "Frank", "Tyler", "Will", "Brye", "Reed", "Keith", "Ericson", "Embry", "Chadwick", "Hakeem", "Cameron", "Lou", "Carl", "Luke", "Desmond", "Jermaine", "Jerald", "Jax", "Byron", "Floyd", "Melvin", "Brandon", "Darren", "Will", "Dwayne", "Shaun", "Sterling", "Henrik", "Edgar", "Demarcus", "Tyson", "Wayne", "Wade", "Raymond", "Patrick", "Dustin", "Bernie", "Nash", "Gerald", "Brody", "Joel", "Joe"}

MCR.names.male.l = {"Jose", "Ignacio", "Fernando", "Alejandro", "Pepe", "Luca", "Sebastian", "Maximo", "Valerio", "Pablo", "Julian", "Paulo", "Benito", "Raul", "Alonso", "Lucian", "Emilio", "Hector", "Jesus", "Esteban", "Oscar", "Luis", "Gabriel", "Franco", "Bautista", "Carlos", "Juan", "Jorge", "Pedro", "Manuel", "Santiago", "Javier", "Nicolas", "Miguel", "Diego", "Valentino"}

MCR.names.male.a = {"Lee", "Dai", "Wei", "Cao", "Mao", "Lai", "Cheng", "Xie", "Zeng", "Peng", "Tang", "Zhao", "Kang", "Huang", "Tsun", "Yichen", "Kazuhira", "Kenji", "Akito", "Sakamoto", "Satoshi", "Deng", "Kong", "Yao", "Jiang", "Xue", "Long"}

MCR.names.surnames.bw = {"Davis", "Price", "Clark", "Myers", "Cash", "Hudson", "Royal", "Knox", "Moore", "Watson", "Jameson", "Gray", "Smith", "Miller", "Brown", "King", "Wright", "Flores", "Burns", "Richard", "Reid", "Fields", "Nelson", "Wood", "Jackson", "Foreman", "Rogers", "Green", "McGee", "McClain", "Barnes", "Little", "Benjamin", "Anderson", "Campbell", "Baker", "Hall", "Hill", "Bradley", "Smith", "White", "Hopkins", "Vance", "Mays", "Park", "Callan", "Dallas", "Prince", "Forrest", "Marc", "Briggs", "Dexter", "Winston", "Sky", "Lynn", "Jefferson", "Fisher", "Crosby", "Andreas", "Cannon", "Clay", "Milton", "Thomas", "Colt", "Drew", "Major", "Trace", "Martin", "Branson", "Royce", "Joyce", "Cullen", "Princeton"}

MCR.names.surnames.l = {"Martinez", "Quesada", "Collazo", "Mascar", "Romero", "Navarro", "Espinar", "Molina", "Espiga", "Laguna", "Miralles", "Ramirez", "Sanchez", "Perez", "Garcia", "Rubio", "Aguilar", "Gonzales", "Hernandez", "Diaz", "Gomez", "Miranda", "Delgado", "Santino"}

MCR.names.surnames.a = {"Lee", "Fui", "Wen", "Zhenzhen", "Ling", "Tung", "Liling", "Fenfang", "Jie", "Shui", "Bai", "Xiao", "Feng", "Duyi", "Changming", "Qingsheng", "Zheng", "Shanyuan", "Hong", "Weisheng", "Myeong", "Rei", "Qiao", "Ming", "Yuri", "Tao", "Lao", "Inu", "Yonk", "Kenzo"}

MCR.AgeCounter = {
	["male_01"] = {
		[1] = 4,
		[5] = 4,
		[6] = 4,
		[7] = 4,
		[8] = 5,
		[9] = 5,
		[10] = 5,
		[11] = 4,
		[15] = 2,
		[16] = 2,
	},
	["male_02"] = {
		[3] = 2,
		[4] = 4,
		[5] = 4,
		[6] = 2,
		[11] = 2,
		[12] = 2,
		[15] = 4,
		[16] = 4,
		[17] = 2,
		[18] = 4,
		[20] = 4,
		[21] = 2,
		[22] = 4,
		[24] = 2,
		[25] = 2,
		[26] = 2,
		[27] = 2,
		[28] = 5,
		[29] = 5,
	},
	["male_03"] = {
		[2] = 2,
		[8] = 2,
		[10] = 4,
		[12] = 2,
		[14] = 4,
		[23] = 6,
	},
	["male_04"] = {
		[1] = 2,
		[2] = 2,
		[4] = 4,
		[5] = 2,
		[6] = 2,
		[9] = 2,
		[10] = 4,
		[11] = 4,
		[12] = 2,
		[13] = 2,
		[14] = 4,
		[15] = 2,
		[16] = 2,
		[18] = 4,
		[24] = 2,
		[25] = 4,
		[26] = 4,
	},
	["male_05"] = {
		[2] = 2,
		[3] = 2,
		[5] = 2,
		[9] = 4,
		[11] = 4,
		[12] = 4,
		[15] = 2,
		[16] = 4,
		[17] = 2,
		[18] = 4,
		[19] = 5,
		[20] = 4,
		[21] = 2,
	},
	["male_06"] = {
		[3] = 2,
		[4] = 2,
		[5] = 4,
		[7] = 4,
		[8] = 4,
		[9] = 2,
		[11] = 4,
		[12] = 4,
		[13] = 5,
		[14] = 5,
		[16] = 2,
		[17] = 2,
		[19] = 2,
		[22] = 5,
		[23] = 4,
	},
	["male_07"] = {
		[1] = 2,
		[2] = 2,
		[3] = 2,
		[4] = 2,
		[9] = 4,
		[10] = 2,
		[11] = 2,
		[12] = 4,
		[13] = 2,
		[19] = 2,
		[20] = 4,
		[22] = 2,
		[23] = 2,
		[24] = 2,
	},
	["male_08"] = {
		[1] = 4,
		[2] = 4,
		[3] = 6,
		[4] = 4,
		[5] = 5,
		[6] = 4,
		[7] = 5,
		[8] = 4,
		[9] = 5,
		[11] = 4,
		[13] = 4,
		[14] = 4,
		[15] = 4,
	},
	["male_09"] = {
		[1] = 2,
		[2] = 2,
		[6] = 2,
		[7] = 2,
		[8] = 4,
		[9] = 2,
		[12] = 2,
		[13] = 2,
		[14] = 4,
		[17] = 2,
		[18] = 2,
	},
	["female_01"] = {
		[1] = 2,
		[2] = 2,
		[4] = 2,
		[6] = 2,
		[7] = 2,
		[8] = 2,
		[9] = 2,
		[10] = 4,
		[13] = 2,
		[14] = 2,
		[17] = 4,
		[18] = 4,
		[19] = 2,
	},
	["female_02"] = {
		[1] = 2,
		[2] = 2,
		[5] = 2,
		[6] = 2,
		[7] = 2,
		[9] = 2,
		[13] = 2,
		[14] = 4,
		[17] = 2,
		[18] = 2,
		[19] = 2,
	},
	["female_03"] = {
		[2] = 2,
		[4] = 2,
		[5] = 2,
		[6] = 2,
		[7] = 2,
	},
	["female_04"] = {
		[1] = 2,
		[2] = 2,
		[3] = 2,
		[6] = 2,
		[7] = 2,
		[8] = 2,
		[9] = 5,
		[10] = 2,
		[12] = 2,
		[13] = 2,
	},
	["female_05"] = {
		[2] = 2,
		[3] = 2,
		[4] = 2,
		[6] = 2,
		[7] = 2,
	},
	["female_06"] = {
		[3] = 2,
		[6] = 2,
		[7] = 2,
		[9] = 6,
		[10] = 2,
		[11] = 2,
	}
}