--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/a_config_gmodla/lua/clprops/only_day.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

scene = {
	{
		anm = "roofidle1",
		mdl = "models/cityrp/pm/nypd/male_02.mdl",
		pos = Vector(7820.5625, 8134.46875, 199.71879577637),
		ang = Angle(0, 86.671096801758, 0),
		smt = {},
	},
	{
		pos = Vector(7433.65625, 5710.53125, 224.46879577637),
		mdl = "models/atlantis/medical/wheelchair.mdl",
		ang = Angle(0, -51.767601013184, -0.16480000317097),
		smt = {},
		bgr = {
			[0] = 0,
		},
	},
	--FD
	{
		ang = Angle(0.0274658203125, 179.98901367188, 0.0164794921875),
		pos = Vector(8611.40625, 7436, -397.96875),
		mdl = "models/props_lab/hifisystem001a.mdl",
	},
	{
		ang = Angle(0.02197265625, 179.98352050781, 0.098876953125),
		pos = Vector(9981.71875, 1959.75, 239.34375),
		mdl = "models/props/cs_office/microwave.mdl",
	},
	{
		ang = Angle(0.010986328125, -90.005493164063, -0.0054931640625),
		pos = Vector(10030.96875, 1966.09375, 253.28125),
		mdl = "models/props_interiors/styrofoam_cups.mdl",
	},
	{
		ang = Angle(0.142822265625, -90.10986328125, -0.076904296875),
		pos = Vector(10045.40625, 1962.34375, 197.375),
		mdl = "models/props_interiors/water_cooler.mdl",
	},
	{
		ang = Angle(0.5108642578125, 100.29968261719, -0.46142578125),
		pos = Vector(9121.03125, 2014.1875, 235.6875),
		mdl = "models/props_books/paper_stack-3.mdl",
	},
	{
		ang = Angle(-0.4779052734375, -179.69787597656, -0.054931640625),
		pos = Vector(9117.25, 2034.5625, 235.6875),
		mdl = "models/props_electronics/keyboard-3.mdl",
	},
	{
		ang = Angle(-0.02197265625, 179.96704101563, 0.087890625),
		pos = Vector(9145.21875, 2014.28125, 235.6875),
		mdl = "models/props_electronics/computer-1.mdl",
	},
	{
		ang = Angle(0.19775390625, 141.89392089844, 0.4779052734375),
		pos = Vector(9146.84375, 2068.15625, 235.90625),
		mdl = "models/props_books/paper_stack-4.mdl",
	},
	{
		ang = Angle(0, -0.032958984375, 0),
		pos = Vector(9135.3125, 2089.875, 235.78125),
		mdl = "models/props_office/books_3.mdl",
	},
	{
		ang = Angle(-0.50537109375, -147.47497558594, 1.9775390625),
		pos = Vector(9118.1875, 2086.625, 235.875),
		mdl = "models/props_electronics/phone-4.mdl",
	},
	{
		ang = Angle(-0.1318359375, 89.97802734375, 0.032958984375),
		pos = Vector(9223.40625, 1949.8125, 234.59375),
		mdl = "models/props_electronics/printer-1.mdl",
	},
	{
		ang = Angle(-0.2197265625, 90.02197265625, 0.24169921875),
		pos = Vector(9845.5, 1081, 96.5),
		mdl = "models/props/cs_militia/toilet.mdl",
	},
}

table.Add(client_list, scene)