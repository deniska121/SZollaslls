--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/creationmenu/content/contenttypes/dupes.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

allowed_spawnlist = {
	{
		parentid = 0,
		icon = "icon16/wrench.png",
		id = 1,
		contents = {},
		needsapp = "",
		name = "Строительство",
	},
	{
		parentid = 1,
		icon = "icon16/brick.png",
		id = 2,
		contents = {
			{
				type = "header",
				text = "Металл",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate1_tri.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate1x2_tri.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate2x2_tri.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate2x4.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate2x4_tri.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate4x4.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate4x4_tri.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_tube.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_tubex2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_angle360.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_angle180.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_angle90.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate_curve360.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate_curve180.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate_curve.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate_curve360x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate_curve180x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_plate_curve2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_dome360.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_dome180.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_dome90.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri1x1solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri1x1x1solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri1x1x2solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x1solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x1x1solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x1x2solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x2solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x2x1solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x2x2solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/trieq1x1x1solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/trieq1x1x2solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/trieq2x2x1solid.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/trieq2x2x2solid.mdl",
			},
			{
				type = "model",
				model = "models/Mechanics/gears2/pinion_20t2.mdl",
			},
			{
				type = "model",
				model = "models/Mechanics/gears2/pinion_20t3.mdl",
			},
			{
				type = "model",
				model = "models/Mechanics/gears2/pinion_40t2.mdl",
			},
			{
				type = "model",
				model = "models/Mechanics/gears2/pinion_40t3.mdl",
			},
			{
				type = "header",
				text = "Каркас",
			},
			{
				type = "model",
				model = "models/phxtended/bar1x.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/bar1x45a.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/bar1x45b.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/bar2x.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/bar2x45a.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/bar2x45b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire1x1.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/cab1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire1x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire1x2.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/cab2x1x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire1x1x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire1x1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire2x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire2x2.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/cab2x2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/metal_wire1x2x2b.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri1x1.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri1x1x2.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x1.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x1x1.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x1x2.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x2.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x2x1.mdl",
			},
			{
				type = "model",
				model = "models/phxtended/tri2x2x2.mdl",
			},
			{
				type = "header",
				text = "Окна",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window1x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window2x4.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window4x4.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_angle360.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_angle180.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_angle90.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_curve360x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_curve180x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_curve90x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_curve360x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_curve180x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_curve90x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_dome360.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_dome180.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/windows/window_dome90.mdl",
			},
			{
				type = "header",
				text = "Дерево",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_boardx1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_boardx2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_boardx4.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_panel1x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_panel1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_panel2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_panel2x4.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_panel4x4.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_angle360.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_angle180.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_angle90.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_curve360x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_curve180x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_curve90x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_curve360x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_curve180x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_curve90x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_dome360.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_dome180.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_dome90.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire1x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire1x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire1x1x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire1x1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire2x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire1x2x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire2x2x2b.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire_angle360x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire_angle180x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire_angle90x1.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire_angle360x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire_angle180x2.mdl",
			},
			{
				type = "model",
				model = "models/props_phx/construct/wood/wood_wire_angle90x2.mdl",
			},
		},
		needsapp = "",
		name = "Базовые",
	},
	{
		parentid = 1,
		icon = "icon16/brick.png",
		id = 3,
		contents = {
			{
				type = "header",
				text = "Панели",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate125.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate150.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate175.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x125.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x150.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x175.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate025x8.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x05_rounded.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate05x8.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x105.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate075x8.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x8.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2x6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2x7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate2x8.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate3x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate3x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate3x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate3x6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate3x7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate3x8.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate4x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate4x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate4x6.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate4x7.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate4x8.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate5x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate6x6.mdl",
			},
			{
				type = "header",
				text = "Блоки",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x025x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x05x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x075x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x125x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x150x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x1x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x2x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x3x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x4x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x5x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube025x6x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x05x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x05x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x075x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x105x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x1x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x1x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x2x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x2x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x3x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x3x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x4x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x4x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x5x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x5x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x6x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube05x6x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x075x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x075x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x1x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x1x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x2x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x2x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x2x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x3x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x3x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x3x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x4x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x4x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x5x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x6x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube075x6x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube125x125x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube150x150x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x150x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x1x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x1x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x2x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x2x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x2x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x3x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x3x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x4x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x4x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x4x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x5x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x6x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x6x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube1x6x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube2x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube2x2x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube2x2x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube2x2x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube2x2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube2x3x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube3x3x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube3x3x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube3x4x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/blocks/cube3x6x025.mdl",
			},
			{
				type = "header",
				text = "Треугольники",
			},
			{
				type = "model",
				model = "models/hunter/triangles/025x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/025x025mirrored.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/05x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/05x05mirrored.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/075x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/075x075mirrored.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/tri1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1mirrored.mdl",
			},
			{
				type = "model",
				model = "models/hunter/geometric/tri1x1eq.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/tri2x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/tri3x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x2mirrored.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/3x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/4x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/trapezium.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x3x1trap.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x4x2trap.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/plate1x4x2trap1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/05x05x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x05x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x05x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x5.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x2x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/3x2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x1carved.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x1carved025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x2carved.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x2carved025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x4carved.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/1x1x4carved025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x1x1carved.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x1x2carved.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x2x1carved.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/2x2x2carved.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/trapezium3x3x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/trapezium3x3x1a.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/trapezium3x3x1b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/triangles/trapezium3x3x1c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/squarecap1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/squarecap2x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/squarecap2x1x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/squarecap2x2x2.mdl",
			},
			{
				type = "header",
				text = "Трубы",
			},
			{
				type = "model",
				model = "models/hunter/misc/platehole1x1a.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/platehole1x1b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/platehole1x1c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/platehole1x1d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x1b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x1c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x1d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x2b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x2c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x2d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x3b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x3c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube1x1x3d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tubebend1x1x90.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/platehole2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/platehole3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/platehole1x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/plates/platehole1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/circle2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/circle2x2b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/circle2x2c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/circle2x2d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x025b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x025c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x025d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x05b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x05c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x05d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x1b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x1c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x1d.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x2b.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x2c.mdl",
			},
			{
				type = "model",
				model = "models/hunter/tubes/tube2x2x2d.mdl",
			},
			{
				type = "header",
				text = "Другое",
			},
			{
				type = "model",
				model = "models/hunter/misc/cone1x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/cone1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/cone2x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/cone2x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/cone2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/roundthing2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/roundthing3.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/roundthing4.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/roundthing1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/sphere025x025.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/sphere075x075.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/sphere1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/lift2x2.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/stair1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/stair1x1inside.mdl",
			},
			{
				type = "model",
				model = "models/hunter/misc/stair1x1outside.mdl",
			},
			{
				type = "model",
				model = "models/hunter/geometric/para1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/geometric/pent1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/geometric/hex05x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/geometric/hex1x1.mdl",
			},
			{
				type = "model",
				model = "models/hunter/geometric/hex1x05.mdl",
			},
			{
				type = "model",
				model = "models/hunter/geometric/hex025x1.mdl",
			},
		},
		needsapp = "",
		name = "Пластик",
	},
	{
		parentid = 1,
		icon = "icon16/brick.png",
		id = 4,
		contents = {
			{
				type = "header",
				text = "Брусья",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar1.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar2.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar3.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar4.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x1.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x2.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x3.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x4.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_bars/sf_bar25x25x8.mdl",
			},
			{
				type = "header",
				text = "Панели",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x1.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x2.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x3.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x4.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate1x8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate2x2.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate2x3.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate2x4.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate2x5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate2x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate2x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate2x8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate3x3.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate3x4.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate3x5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate3x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate3x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate3x8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate4x4.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate4x5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate4x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate4x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate4x8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate5x5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate5x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate5x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate5x8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate6x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate6x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate6x8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate7x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate7x8.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_plates/sf_plate8x8.mdl",
			},
			{
				type = "header",
				text = "Треугольники",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri1x1.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri2x2.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri3x3.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri4x4.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri5x5.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri6x6.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri7x7.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tris/sf_tri8x8.mdl",
			},
			{
				type = "header",
				text = "Трубы",
			},
			{
				type = "model",
				model = "models/squad/sf_tubes/sf_tube1x360.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tubes/sf_tube1x270.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tubes/sf_tube1x180.mdl",
			},
			{
				type = "model",
				model = "models/squad/sf_tubes/sf_tube1x90.mdl",
			},
		},
		needsapp = "",
		name = "Плоские",
	},
	{
		parentid = 1,
		icon = "icon16/box.png",
		id = 5,
		contents = {
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_1x3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_1x4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_3x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_3x3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_4x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_4x4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_1x3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_1x4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_3x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_3x3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_4x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_ds_4x4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_manhole.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling128_manhole_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling64.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling64_1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling64_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling64_ds_1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_eighthring112_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_eighthring128_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_eighthring240_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_eighthring256_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_halfring112_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_halfring128_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_halfring240_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_halfring256_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_quarterring112_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_quarterring128_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_quarterring240_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_quarterring256_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_ring112_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_ring128_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_ring240_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_ring256_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_utility5.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ceiling_utility5_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_cone128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_cone128_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_cone256_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthhollowsphere128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthhollowsphere256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_128_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_128_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_128_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_128_3x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_128_4x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_256_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_eighthring_256_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone128_2x1_t1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone128_2x1_t2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone128_2x1_t3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone128_t1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone128_t2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone128_t3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone256_2x1_t1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone256_2x1_t2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone256_2x1_t3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone256_t1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone256_t2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_frustumcone256_t3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfcone128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfcone128_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfcone256_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfhollowsphere128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfhollowsphere256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_128_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_128_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_128_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_256_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_256_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_halfring_256_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_hollowsphere128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_hollowsphere256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_pyramid128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quadprofile128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quadprofile256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterhollowsphere128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterhollowsphere256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_128_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_128_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_128_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_256_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_256_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_256_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_256_3x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_quarterring_256_4x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_128_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_128_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_128_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_256_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_256_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_ring_256_2x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_spiralstair128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_spiralstair128_02.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_spiralstair256.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_spiralstair256_02.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_triangle128_15.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_triangle128_15_2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_triangle128_15_3x3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_triangle128_15_4x4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_triangle128_25.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_triangle128_25_2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_triangle128_45.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_utility4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_utility5.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_utility5_ds.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_05x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_05x3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_05x4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_1x3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_1x4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_2x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole5.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole6.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole7.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole8_1x2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_doorhole9.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_edge_01.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_edge_02.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole11.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole5.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole6.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole7.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole8.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_hole9.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_utility1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_utility2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_utility3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_window1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_window2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_window3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_window4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole5.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole6.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole7.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall128_windowhole8.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall16.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall16_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall16_qr_pillar.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall16_qr_pillar_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall16_qr_pillar_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall2_q_pillar.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall2_q_pillar_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall2_q_pillar_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall2_r_pillar.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall2_r_pillar_025x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall2_r_pillar_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall32.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall32_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_05x1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole1.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole2.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole3.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole4.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole5.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole6.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole7.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall64_windowhole8.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall8.mdl",
			},
			{
				type = "model",
				model = "models/props_ktwalls/default/kt_wall8_05x1.mdl",
			},
		},
		needsapp = "",
		name = "Стены",
	},
	{
		parentid = 0,
		icon = "icon16/building.png",
		id = 6,
		contents = {
			{
				type = "header",
				text = "Дом - Офис",
			},
			{
				type = "model",
				model = "models/env/furniture/piano_stool/piano_stool.mdl",
			},
			{
				type = "model",
				model = "models/props_urban/plastic_chair001.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/barstool01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/chair_stool01a.mdl",
			},
			{
				type = "model",
				model = "models/props_furniture/cafe_barstool1.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/chairantique.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/patio_chair.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/wooden_chair.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/chair01.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/patio_chair2.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_chair001a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/metal_chair.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/chair02a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_chair03a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/chair_cafeteria.mdl",
			},
			{
				type = "model",
				model = "models/props_furniture/hotel_chair.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_chair01a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureChair001a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/chair_office2.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/chair_office01a.mdl",
			},
			{
				type = "model",
				model = "models/props_combine/breenchair.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Chair_office.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/cafeteria_bench001a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/wood_bench.mdl",
			},
			{
				type = "model",
				model = "models/props_mall/mall_bench.mdl",
			},
			{
				type = "model",
				model = "models/props_rpd/benchinterior01.mdl",
			},
			{
				type = "model",
				model = "models/props_rpd/benchinterior02.mdl",
			},
			{
				type = "model",
				model = "models/props_trainstation/BenchOutdoor01a.mdl",
			},
			{
				type = "model",
				model = "models/props_trainstation/bench_indoor001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/bench01a.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/deck_bench/deck_bench02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_street/street_bench.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/pd_waitingbench.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_Couch02a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureCouch002a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureCouch001a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_Couch01a.mdl",
			},
			{
				type = "model",
				model = "models/props_urban/hotel_chair001.mdl",
			},
			{
				type = "model",
				model = "models/chairs/armchair.mdl",
			},
			{
				type = "model",
				model = "models/highrise/lobby_chair_01.mdl",
			},
			{
				type = "model",
				model = "models/highrise/lobby_chair_02.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/sofa_chair.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/sofa.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/sofachair01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity3/props_interior/dirtysofa3.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/sofa01a.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/sofa01b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/leathercouch_b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/leathercouch_a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/sofa_chair01.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/sofa01.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/sofa_chair02.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/sofa02.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/couch.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_junk/couch_old.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_junk/old_couch.mdl",
			},
			{
				type = "model",
				model = "models/unioncity3/props_interior/hospital_seat.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/decosofa_wood/decosofa_wood_sin.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/decosofa_wood/decosofa_wood_dou.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/deco_table/deco_table.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/deco_table/deco_table_big.mdl",
			},
			{
				type = "model",
				model = "models/props_warehouse/office_furniture_desk.mdl",
			},
			{
				type = "model",
				model = "models/props_warehouse/office_furniture_desk_corner.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureTable003a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_Desk01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/furniture_desk01_l4d2a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureTable001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureTable002a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer002a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/table_bedside.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/table_end.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/side_table_square.mdl",
			},
			{
				type = "model",
				model = "models/props_urban/hotel_halfmoon_table001.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/table_coffee_l4d2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Table_coffee.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/wood_table.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/tableantique.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/tablecoffee.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/coffee_table_rectangular.mdl",
			},
			{
				type = "model",
				model = "models/props_downtown/booth_table.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/table_folding.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/dining_table_round.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/dinning_table_oval.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/table_shed.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/table_kitchen.mdl",
			},
			{
				type = "model",
				model = "models/exterior/kids_picnic_table.mdl",
			},
			{
				type = "model",
				model = "models/props_furniture/kitchen_countertop1.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_Vanity01a.mdl",
			},
			{
				type = "model",
				model = "models/props_combine/breendesk.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/desk_executive.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/cafeteria_table001a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_desk001b.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_desk001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/filedesk01a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/pd_desk.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/metal_desk.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/desk_metal.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officedesk_small.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officedesk_big.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/tv_stand02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/tv_stand01.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/desk_motel.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/desk_motel.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/table_console.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/tv_cabinet.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bookcasehutch01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/furnituredrawer001b.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/furniture_drawer01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/furniture_drawer01b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/furnituredrawer001c.mdl",
			},
			{
				type = "model",
				model = "models/props_tables_desks/presentation_desk-1.mdl",
			},
			{
				type = "model",
				model = "models/props_downtown/side_table.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer001a.mdl",
			},
			{
				type = "model",
				model = "models/props_furniture/drawer1.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/dresser_short.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureCupboard001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/partsbin01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer003a.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/file_cabinet3.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/file_cabinet1.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/file_cabinet2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/file_cabinet1_group.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/file_box.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_drawer001a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_filecabinet001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/filecabinet02.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_filecabinet002a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_storagecloset001a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/controlroom_storagecloset001b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/lockers001b_single.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/lockers001a_single.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/Lockers001a.mdl",
			},
			{
				type = "model",
				model = "models/props_tables_desks/locker-2.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/furniture_shelf01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_shelf01a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/shelfunit01a.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Bookshelf1.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Bookshelf2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Bookshelf3.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/bookshelf_empty.mdl",
			},
			{
				type = "model",
				model = "models/uc/propper/aptbookcase.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDresser001a.mdl",
			},
			{
				type = "model",
				model = "models/props_furniture/dresser1.mdl",
			},
			{
				type = "model",
				model = "models/props_tables_desks/filing_cabinet-2.mdl",
			},
			{
				type = "model",
				model = "models/props_map_structures/lawfirm/furniture/filing_cabinet-1_group2.mdl",
			},
			{
				type = "model",
				model = "models/props_map_structures/lawfirm/furniture/filing_cabinet-2_group1.mdl",
			},
			{
				type = "model",
				model = "models/props_map_structures/lawfirm/furniture/filing_cabinet-2_group2.mdl",
			},
			{
				type = "model",
				model = "models/props_map_structures/lawfirm/furniture/filing_cabinet-2b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officeshelf01a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officeshelf01b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officeshelf01c.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officeshelf02c.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officeshelf02b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/officeshelf02a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/shelves.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labshelf001a.mdl",
			},
			{
				type = "model",
				model = "models/furniture/file_cabinet_shelf.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/shelves_wood_l4d2.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/binderblue.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/binderbluelabel.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/bindergraylabel01a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/bindergreen.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/bindergraylabel01b.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/bindergreenlabel.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/binderredlabel.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/reportsfile1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/book1984.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/downspackage.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/book1.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/books7.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/books6.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/books5.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/books01.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/books02.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/books1.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/books2.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/cornerunit2_books.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/books3.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/books4.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/shelfcart001a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/gun_cabinet.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/footlocker01_open.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/footlocker01_closed.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/bed_connemara/bed_connemara_3rd.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/motel_bed.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bed.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/bed_andrea/bed_andrea_1st.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/bed_naronic/bed_naronic_1st.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_junk/mattress_b.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/prison_bedframe001b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureBed001a.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/bed.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/bunkbed.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/bunkbed.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/bunkbed2.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/clipboard.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/clipboard002a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/notepad001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/papersheet001a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/clipboardholder01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/clock01.mdl",
			},
			{
				type = "model",
				model = "models/nt/props_office/wallclock2.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/water_cooler.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/water_cooler.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/styrofoam_cups.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/styrofoam_cups_p4.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/pot01a.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/tea_pot-1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_jug.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/pot-2_static.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/metalPot001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/metalPot002a.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/pan-2.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/pot02a.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/pot-1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_pan_cooking.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_grill.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/dish_soap.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/soap_dispenser.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/soap_bar.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/toothbrush.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/toothpaste.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/toothbrushset01.mdl",
			},
			{
				type = "model",
				model = "models/props_food_drink/medicine-3.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_coffeemug001a.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/coffee_mug.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/coffee_mug2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/coffee_mug3.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/trash_can.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Paper_towels.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bbq_grill.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/mailbox01.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/napkinsbox.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/paperbox_01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/paperbox_02.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/paperbox_03.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox2.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox3.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox4.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox5.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox6.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox7.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox8.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/paperbox9.mdl",
			},
			{
				type = "header",
				text = "Декор",
			},
			{
				type = "model",
				model = "models/props/cs_office/offcertificatea.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintinga.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingb.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingd.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintinge.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingf.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingg.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingh.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingi.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingj.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingk.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingl.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingm.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offpaintingo.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offinspa.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offinspb.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offinspc.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offinspd.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offinspf.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/offinspg.mdl",
			},
			{
				type = "model",
				model = "models/maxofs2d/gm_painting.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/picture1.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/picture2.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/picture3.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/Frame002a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/corkboard001.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/corkboard002.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/corkboardverticle01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/propper/corkboard1.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/propper/corkboard2.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/propper/corkboard3.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/propper/corkboard4.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/moose_head.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_interior/dartboard.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/frame001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/frame002a.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_interior/sign_nosmoking.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/paper_order.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_age.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_beer.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_camera.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_camera2.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_car.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_carpet.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_coffee.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_conceal.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_deli1.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_deli2.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_deli3.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_delimenu.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_gun.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_gun2.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_id.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_keepout.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_litter.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_open.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_open2.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_policy.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_private.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_private2.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_safety.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_staff.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_toilet.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/sign_wash.mdl",
			},
			{
				type = "model",
				model = "models/props_wall_mounted/calendar-1.mdl",
			},
			{
				type = "model",
				model = "models/props_wall_mounted/calendar-3.mdl",
			},
			{
				type = "model",
				model = "models/props_wall_mounted/calendar-4.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/chalkboard.mdl",
			},
			{
				type = "header",
				text = "Растительность",
			},
			{
				type = "model",
				model = "models/props/de_inferno/potted_plant2.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/potted_plant3.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/potted_plant1.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/planter.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/plant01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_foliage/interiorplant01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_foliage/interiorplant02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_foliage/interiorplant04.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_foliage/interiorplant05.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_foliage/interiorplant06.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/cactus.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/cactus02a.mdl",
			},
			{
				type = "model",
				model = "models/highrise/potted_plant_04.mdl",
			},
			{
				type = "model",
				model = "models/highrise/potted_plant_05.mdl",
			},
			{
				type = "model",
				model = "models/nature/planter_04.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_foliage/plant_pot.mdl",
			},
		},
		needsapp = "",
		name = "Дом - Офис",
	},
	{
		parentid = 0,
		icon = "icon16/package.png",
		id = 7,
		contents = {
			{
				type = "header",
				text = "Кафе - Магазин",
			},
			{
				type = "model",
				model = "models/props_downtown/booth02.mdl",
			},
			{
				type = "model",
				model = "models/props_downtown/booth01.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/booth_b.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/booth_a.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/patio_chair2.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/loungeseat_double.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/loungeseat_triple.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_laundromat/laundry_bench.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/barbooth.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/vault_table.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/bar_table.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/table_cafeteria.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/restaurant_table.mdl",
			},
			{
				type = "model",
				model = "models/props_urban/patio_table2.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_counter001b.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_counter001d.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_counter001c.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_counter001a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_cabinet01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_counter01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_counter02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_counter03.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_fridge02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_fryer.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_shelf01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_sink.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_stove01.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/bar01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/bar01_l4d2.mdl",
			},
			{
				type = "model",
				model = "models/props/de_vostok/counter_generalstore.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/propper/clubvipcounter.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/menu_stand.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/cashregister01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/cashregister01.mdl",
			},
			{
				type = "model",
				model = "models/props_downtown/atm.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/square-2.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/airport/trash_bin1.mdl",
			},
			{
				type = "model",
				model = "models/props_urban/ashtray_stand001.mdl",
			},
			{
				type = "model",
				model = "models/props/de_piranesi/pi_bucket.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/beer_tap.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/beer_keg.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/coffee_machine.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/jukebox.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/snack_machine_01a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/vending_machine.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/VendingMachineSoda01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/VendingMachineSoda01a_door.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/spresso_machine.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/trashbin.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_interior/cigarette_vendor.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/slush_machine.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/soda_fountain.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/gum_stand.mdl",
			},
			{
				type = "model",
				model = "models/dynamic_props/ceiling_fan_short.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/barrier_pole-1b.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/barrier_pole-1c.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/display_cooler01a.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_stores/candybox_c.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_stores/candybox_b.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_stores/candybox_a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/shelf_household_b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/shelf_snacks_a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/shelf_snacks_b.mdl",
			},
			{
				type = "model",
				model = "models/props_store/shelf-1.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/electronics01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/electronics02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/electronics03.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/electronics04.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/magazinerack.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/shelf_auto_c.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/videoshelf.mdl",
			},
			{
				type = "model",
				model = "models/static_props/prop_market_shelf_large.mdl",
			},
			{
				type = "model",
				model = "models/static_props/prop_market_shelf_storage.mdl",
			},
			{
				type = "model",
				model = "models/props/misc/metalshelf2b.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_shelf002a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_shelf001a.mdl",
			},
			{
				type = "model",
				model = "models/furniture/file_cabinet_shelf.mdl",
			},
			{
				type = "model",
				model = "models/props_trainstation/traincar_rack001.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_fastfood/kitchen_shelf01.mdl",
			},
			{
				type = "model",
				model = "models/env/misc/pan_rack/pan_rack.mdl",
			},
			{
				type = "model",
				model = "models/unioncity3/props_stores/butcher_knifeset.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/champ_flute.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_07.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_08.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_09.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_10.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_11.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/pitcher_01.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/tequsunrise.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/cocktail.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_05.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_stack_09.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_03.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_04.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_06.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/pint_glass_01.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/shot_glass.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_stack.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_02.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_01.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/glass_stack_2.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/pitcher_02.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/optic_jd.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/optic_jd_static.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/optic_rum.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/optic_rum_static.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/optic_vodka.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/optic_vodka_static.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/champ_bucket.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/stirrers.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/tequila.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/bar_caddy.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/bar_drinkstraws.mdl",
			},
			{
				type = "model",
				model = "models/props_downtown/diner_silverware_holder_01.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/napkindisp.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/cockshaker.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/martinishaker_closed.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/martinishaker_open.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/coasterdisp.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/food_sugarjar.mdl",
			},
			{
				type = "model",
				model = "models/foodnhouseholditems/plate.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/bar_lemons.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/bar_limes.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/bar_oranges.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/barstuff/bar_beans.mdl",
			},
			{
				type = "model",
				model = "models/env/decor/ashtray/ashtray_empty.mdl",
			},
			{
				type = "model",
				model = "models/props_downtown/pooltable.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/PopCan01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/popcan02a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticcup001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticcup002a.mdl",
			},
			{
				type = "model",
				model = "models/foodnhouseholditems/pizzabox.mdl",
			},
			{
				type = "model",
				model = "models/foodnhouseholditems/pizzaboxbottom.mdl",
			},
			{
				type = "model",
				model = "models/foodnhouseholditems/pizzaboxtop.mdl",
			},
			{
				type = "model",
				model = "models/foodnhouseholditems/pizzaslicehalf.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticcan001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbox001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbox001b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbox002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbox002b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/glassjug01.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/GlassBottle01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_glassbottle003a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_glassbottle001a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/bottle01.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/bottle02.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/bottle03.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbottle003a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbottle003a_6pack.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/caseofbeer01.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break01.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break02.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break03.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break04.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break05.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break06.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break07.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break08.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break09.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break10.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break11.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf_break12.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bottles_shelf.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/bar_shelfbottles03.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/bar_shelfbottles01.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/bar_shelfbottles02.mdl",
			},
			{
				type = "model",
				model = "models/props_jewelery/cosmetics/cosmetics_b-10.mdl",
			},
			{
				type = "model",
				model = "models/props_jewelery/cosmetics/cosmetics_b-12.mdl",
			},
			{
				type = "model",
				model = "models/props_jewelery/cosmetics/cosmetics_b-13.mdl",
			},
			{
				type = "model",
				model = "models/props_jewelery/cosmetics/cosmetics_b-8.mdl",
			},
			{
				type = "model",
				model = "models/props_jewelery/cosmetics/cosmetics_b-9.mdl",
			},
			{
				type = "model",
				model = "models/props_store/soaps-1_gib7.mdl",
			},
			{
				type = "model",
				model = "models/props_food_drink/medicine-5.mdl",
			},
			{
				type = "model",
				model = "models/props_food_drink/noodles-1.mdl",
			},
			{
				type = "model",
				model = "models/props_food_drink/noodles-2.mdl",
			},
			{
				type = "model",
				model = "models/props_food_drink/vitamin_bottle-1.mdl",
			},
			{
				type = "model",
				model = "models/props_food_drink/vitamin_bottle-3.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_metalcan1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_metalcan1_used.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_metalcan2.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_metalcan2_used.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_beancan.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_bluechips.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_bottle1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_bottle2.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_bottle3.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_bottle4.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_grandmomscereal.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_grandmomscereal_used.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_tastytomschips.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_wheatsmartcereal.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/food_pile_wheatsmartcereal_used.mdl",
			},
			{
				type = "header",
				text = "Склады - Мастерские",
			},
			{
				type = "model",
				model = "models/furniture/keylocker.mdl",
			},
			{
				type = "model",
				model = "models/props_vents/alley_aircon_02.mdl",
			},
			{
				type = "model",
				model = "models/props_vents/alley_aircon_01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Shelves_metal1.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Shelves_metal2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Shelves_metal3.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/HandTruck.mdl",
			},
			{
				type = "model",
				model = "models/donald/props_junk/pushcart04a.mdl",
			},
			{
				type = "model",
				model = "models/donald/props_junk/pushcart05a.mdl",
			},
			{
				type = "model",
				model = "models/donald/props_junk/pushcart02a.mdl",
			},
			{
				type = "model",
				model = "models/donald/props_junk/pushcart03a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/PushCart01a.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/pushcart.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/forklift.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_italy/it_mkt_container2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_italy/it_mkt_container3.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_italy/it_mkt_container3a.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_italy/it_mkt_container1.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_italy/it_mkt_container1a.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/wine_barrel.mdl",
			},
			{
				type = "model",
				model = "models/props_borealis/bluebarrel001.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/oildrum001.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_bag001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/box01a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/box01b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_carboard002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cardboard_box004a.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Cardboard_box03.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Cardboard_box02.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Cardboard_box01.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cardboard_box001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cardboard_box001b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cardboard_box002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cardboard_box002b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cardboard_box003a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cardboard_box003b.mdl",
			},
			{
				type = "model",
				model = "models/props_containers/storage_box_group1.mdl",
			},
			{
				type = "model",
				model = "models/props_containers/storage_box_group4.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/smallmetalbox001a.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/flightcase_c.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/flightcase_d.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_crate002a_half.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_crate001a_half.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_crate003a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_crate001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_crate001a_damaged.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_crate001b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_crate002a.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_sweet_potatoes_5cans.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_sweet_potatoes_6cans.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food05.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/soda_box001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/soda_box001a_open.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_popcanbox_g.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_popcanbox_open_g.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food04.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_souptray_full_double.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_souptray_full_single.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_souptray_single.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food10.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_popcanbox_vanilla.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_popcanbox_open_vanilla.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food03.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_popcanbox_dietsoda.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_popcanbox_open_dietsoda.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food02.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_apples.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_sophias_big.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_sophias_small.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/food_stack.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_juice.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food09.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_fresh_potatoes.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food08.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_militia/food_stack_box_jabbers.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/storage_food07.mdl",
			},
			{
				type = "model",
				model = "models/props_office/c1a2c_foodcrate_01.mdl",
			},
			{
				type = "model",
				model = "models/props_office/c1a2c_foodcrate_02.mdl",
			},
			{
				type = "model",
				model = "models/props_office/c1a2c_foodcrate_03.mdl",
			},
			{
				type = "model",
				model = "models/maps/de_storage/de_storage_boxset01a.mdl",
			},
			{
				type = "model",
				model = "models/maps/de_storage/de_storage_boxset01b.mdl",
			},
			{
				type = "model",
				model = "models/maps/de_storage/de_storage_boxset02a.mdl",
			},
			{
				type = "model",
				model = "models/maps/de_storage/de_storage_boxset02b.mdl",
			},
			{
				type = "model",
				model = "models/maps/de_storage/de_storage_boxset02c.mdl",
			},
			{
				type = "model",
				model = "models/maps/de_storage/de_storage_boxset02d.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/boxpile02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/boxpile01.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/boxes_garage_lower.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/boxes_frontroom.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/crate_extrasmallmill.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/crate_extralargemill.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/crate_stackmill.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/dryer_box2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/dryer_box.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/washer_box.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/washer_box2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/MoneyPallet_WasherDryer.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/box_stack2.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/box_stack1.mdl",
			},
			{
				type = "model",
				model = "models/props/de_nuke/NuclearContainerBoxClosed.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/wood_pallet001a.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/wood_pallet_01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/pallet_stack.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/fertilizer.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/concretebags4.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/concretebags3.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/concretebags2.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/concretebags.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/tirestack3.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/tirestack2.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/tirestack.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/tire1.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/tire2.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/spool.mdl",
			},
			{
				type = "model",
				model = "models/props/de_prodigy/spoolwire.mdl",
			},
			{
				type = "model",
				model = "models/props_tools/toolbox-1.mdl",
			},
			{
				type = "model",
				model = "models/props_tools/toolbox-4.mdl",
			},
			{
				type = "model",
				model = "models/props_tools/toolbox-6.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/toolbox1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/toolbox2.mdl",
			},
			{
				type = "model",
				model = "models/props_equipment/toolchest_01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/workbench.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/mp_apa_hi_garage/garage_stuff/compressor_02.mdl",
			},
			{
				type = "model",
				model = "models/mark2580/gtav/mp_apa_hi_garage/garage_stuff/engine_hoist_02a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/reload_bullet_tray.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/reload_scale.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/reloadingpress01.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/axe.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/circularsaw01.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_gastorch.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/sawblade001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/TrapPropeller_Lever.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/tools_wrench01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bucket_tools02_plank004.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bucket_tools_saw.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bucket_tools_screwdriver.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bucket_tools02_nailsbox.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/TrapPropeller_Engine.mdl",
			},
			{
				type = "model",
				model = "models/props_vehicles/carparts_axel01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_pipe2.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_pipe1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_exhaust.mdl",
			},
			{
				type = "model",
				model = "models/props_vehicles/carparts_muffler01a.mdl",
			},
			{
				type = "model",
				model = "models/props_vehicles/carparts_door01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/MetalBucket01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/bucket_tools02_bucket.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_plasticbucket1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_plasticbucket2.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/MetalBucket02a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/spraycan01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbottle002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_milkcarton001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_plasticbottle001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/jar01b.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/jar01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/metal_paintcan001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/metal_paintcan001b.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/paintbucket01.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/spraycan01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/plasticbucket001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/PropaneCanister001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/canister02a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/canister01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/metalgascan.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/gascan001a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/sawhorse.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/sheetrock_leaning.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/ladder_office_collision.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/TrashDumpster02b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_brick1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_brick2.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/torchoven_01_brickstack.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/CinderBlock01a.mdl",
			},
			{
				type = "model",
				model = "models/props/de_nuke/cinderblock_stack.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/dockplank01b.mdl",
			},
			{
				type = "model",
				model = "models/props_debris/metal_panel02a.mdl",
			},
			{
				type = "model",
				model = "models/props_debris/metal_panel01a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/logpile2.mdl",
			},
		},
		needsapp = "",
		name = "Магазины - Склады",
	},
	{
		parentid = 0,
		icon = "icon16/computer.png",
		id = 8,
		contents = {
			{
				type = "header",
				text = "Сантехника",
			},
			{
				type = "model",
				model = "models/uc/props_interior/bath_sink.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_interior/urinal.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/prisontoilet.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/ensuite1_toilet/ensuite1_toilet_b.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/toilet.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/toilet_b.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/toilet.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/toilet_residential02a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureToilet001a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/paper_towel_dispenser.mdl",
			},
			{
				type = "model",
				model = "models/small_things/toilet_paper_02.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/toiletpaperdispenser_commercial.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/towel_rack.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/toiletpaperdispenser_residential.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/toiletpaperdispenser_residential.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/SinkKitchen01a.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/sink.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/sinkwallmounted01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureSink001a.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/laundrysink01.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/square_sink/sink_double.mdl",
			},
			{
				type = "model",
				model = "models/env/furniture/square_sink/sink_merged_b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureBathtub001a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/BathTub01a.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/bathtub01.mdl",
			},
			{
				type = "model",
				model = "models/props/interior/bathtub_showerhead.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureWashingmachine001a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/dryer.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/moneypallet_dryer.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/moneypallet_washer.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/moneypallet_washer_closed.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_interior/water_heater.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/furnace01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureFireplace001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureBoiler001a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/prison_heater001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureRadiator001a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Radiator01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/prison_heater001a_new.mdl",
			},
			{
				type = "model",
				model = "models/props/rpd/panel_radiator.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/drinking_fountain.mdl",
			},
			{
				type = "model",
				model = "models/props_equipment/firepipe02.mdl",
			},
			{
				type = "header",
				text = "Электроника",
			},
			{
				type = "model",
				model = "models/props_interiors/toaster.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/coffee_maker.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/coffeemachine01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/microwave.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/microwave01.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/refrigerator03.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureFridge001a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/refrigerator01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/refrigeratorDoor01a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/refrigeratorDoor02a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_fridge001a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/refrigerator01.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/stove01.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_stove001a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/kitchen_stove002a.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/stove02.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/furnitureStove001a.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/projector_remote.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/projector.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/laser_machine.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_club/club_spotlight.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/stagelights.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/ceiling_camera.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/camera.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/camera-12.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/camera-2.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/camera-3.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/camera-6.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/camera-4.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/camera-10.mdl",
			},
			{
				type = "model",
				model = "models/henry/gta sa/gmod/objects/camera/camera.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/tripod-1.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/floor_speaker.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/speakers-5.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/speakers-4.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/speakers-6.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_stores/store_speaker.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_club/turntable.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/oldphone01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/phone.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/phone_p1.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/phone_p2.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/phone-2.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/phone-4.mdl",
			},
			{
				type = "model",
				model = "models/props_combine/breenclock.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/alarm_clock.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/citizenradio.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/radio.mdl",
			},
			{
				type = "model",
				model = "models/physics_props/electronics/boombox_01.mdl",
			},
			{
				type = "model",
				model = "models/physics_props/electronics/boombox_02.mdl",
			},
			{
				type = "model",
				model = "models/physics_props/electronics/boombox_03.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/recorder-1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/cassettetape001a.mdl",
			},
			{
				type = "model",
				model = "models/props_office_supplies/floppy_disk-3.mdl",
			},
			{
				type = "model",
				model = "models/props_office_supplies/floppy_disk-2.mdl",
			},
			{
				type = "model",
				model = "models/props_office_supplies/cd_holder-3.mdl",
			},
			{
				type = "model",
				model = "models/props_office_supplies/cd_holder-2.mdl",
			},
			{
				type = "model",
				model = "models/props_office_supplies/cd_holder-1.mdl",
			},
			{
				type = "model",
				model = "models/props_office_supplies/box_folder-1.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifituner001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifituner002a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifituner003a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifituner004a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifituner005a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifituner006a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifisystem002a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/hifisystem001a.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/remote_control-1.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/television_console01.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/big90stv.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/tv.mdl",
			},
			{
				type = "model",
				model = "models/props/de_inferno/tv_monitor01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/tv_monitor01.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/monitor01b.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labmonitor002a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labmonitor002b.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labmonitor006a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labmonitor005a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labmonitor004a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/monitor01a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/monitor02.mdl",
			},
			{
				type = "model",
				model = "models/physics_props/electronics/monitor_01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/ceiling_tv.mdl",
			},
			{
				type = "model",
				model = "models/props_office/computer_monitor_01.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labmonitor001a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_furniture/lcd_tv.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/TV_plasma.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/pd_deskscreen.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/computer.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/computer_monitor.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/laptop-1.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/laptop-2.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/laptop-3.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/laptop-4.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/laptop-6.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/computer_keyboard.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labkeyboard001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/computer01_keyboard.mdl",
			},
			{
				type = "model",
				model = "models/physics_props/electronics/keyboard_02.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/keyboard-3.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/computer_mouse.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/computer_caseB.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labcomputer001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labcomputer002a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/labdrivestorage001a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/harddrive02.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/harddrive01.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/computer-1.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/reciever01a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/reciever01b.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/reciever01c.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/reciever01d.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/consolebox01a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/consolebox03a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/consolebox05a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/reciever_cart.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/printer-1.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/printer-6.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/printer-4.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/printer-5.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/printer-7.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/plotter.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/paperbin001a.mdl",
			},
			{
				type = "model",
				model = "models/gta_prop_michou/v_ind_cm_fan.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/fan-2.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/powerbar-1.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/powerbar-2.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/router-1.mdl",
			},
			{
				type = "model",
				model = "models/props_electronics/scanner-1.mdl",
			},
			{
				type = "model",
				model = "models/props_downtown/meterbox_small_01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_rooftop/satellite_dish.mdl",
			},
			{
				type = "model",
				model = "models/props/de_nuke/NuclearControlBox.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/fusebox001a.mdl",
			},
			{
				type = "model",
				model = "models/arcade/polybius.mdl",
			},
			{
				type = "model",
				model = "models/props_tools/vacuum-1.mdl",
			},
			{
				type = "model",
				model = "models/props_lighting/battery_unrigged.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/makeshift_stove_battery_battery.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/makeshift_stove_battery_stove.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/makeshift_stove_battery_stove_wires.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/makeshift_stove_battery_stove_battery.mdl",
			},
			{
				type = "header",
				text = "Свет",
			},
			{
				type = "model",
				model = "models/props/cs_office/light_ceiling.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_lighting/ceilinglamp01a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_lighting/ceilinglamp01b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/chandelier_b.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/lamp_b.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/artdeco_ceiling_light.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/prison_lamp001c.mdl",
			},
			{
				type = "model",
				model = "models/props/de_nuke/light_red2.mdl",
			},
			{
				type = "model",
				model = "models/props/lamps/p_lamp_fluor_02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_lighting/pool_lamp.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_lighting/interior_lamp02.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_lighting/bar_lamp01.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/artdeco_wall_light.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/entrance_lantern.mdl",
			},
			{
				type = "model",
				model = "models/props/de_nuke/wall_light.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_club/blue_clublight.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/Floodlight01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/Floodlight02.mdl",
			},
			{
				type = "model",
				model = "models/props/de_nuke/Floodlight.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/spotlight.mdl",
			},
			{
				type = "model",
				model = "models/static_props/candle_set_01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/candle_b.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/candle_a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/desklamp01.mdl",
			},
			{
				type = "model",
				model = "models/props_lamps_lights/table_lamp-2.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/lamp_table02.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/lamp_floor.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/Furniture_Lamp01a.mdl",
			},
			{
				type = "model",
				model = "models/env/lighting/lamp_trumpet/lamp_trumpet_tall.mdl",
			},
			{
				type = "model",
				model = "models/highrise/tall_lamp_01.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Exit_ceiling.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Exit_wall.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/lamp001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/lampShade001a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/light_spotlight01_lamp.mdl",
			},
		},
		needsapp = "",
		name = "Техника",
	},
	{
		parentid = 0,
		icon = "icon16/bin_closed.png",
		id = 9,
		contents = {
			{
				type = "header",
				text = "Двери",
			},
			{
				type = "model",
				model = "models/noirpropper/door1m.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/door2m.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/door01_left.mdl",
			},
			{
				type = "model",
				model = "models/props_doors/door03_slotted_left.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/door02_double.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/propper/bankdoor.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/prison_celldoor001b.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/ElevatorShaft_Door01a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/propper/glassdoor.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/freezerdoor.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_fastfood/freezerdoor_frame.mdl",
			},
			{
				type = "header",
				text = "Разное",
			},
			{
				type = "model",
				model = "models/props_books/blueprints-1.mdl",
			},
			{
				type = "model",
				model = "models/props_books/blueprints-2.mdl",
			},
			{
				type = "model",
				model = "models/henry/gta sa/gmod/objects/rhymes book/rhymes book.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_newspaper001b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_newspaper001a.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/newspaperstack01.mdl",
			},
			{
				type = "model",
				model = "models/props_books/paper_stack-3.mdl",
			},
			{
				type = "model",
				model = "models/props_books/paper_stack-4.mdl",
			},
			{
				type = "model",
				model = "models/props_office/books_3.mdl",
			},
			{
				type = "model",
				model = "models/gman_briefcase.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/BriefCase001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/SuitCase001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/SuitCase_Passenger_Physics.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/airport/luggage2.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/airport/luggage3.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/airport/luggage4.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/airport/luggage1.mdl",
			},
			{
				type = "model",
				model = "models/atlantis/generic/luggagebag1.mdl",
			},
			{
				type = "model",
				model = "models/props_containers/suitcase-3.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/medical_ecgmachine.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/medical_ivstand.mdl",
			},
			{
				type = "model",
				model = "models/atlantis/medical/wheelchair.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/medical_cabinet.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/painkillers.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/hospital_bed.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/surgery_bed.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/huladoll.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/doll-2.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/doll-3.mdl",
			},
			{
				type = "model",
				model = "models/props_misc/doll-5.mdl",
			},
			{
				type = "model",
				model = "models/anxiety/giraffe.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/vending_turtle.mdl",
			},
			{
				type = "model",
				model = "models/props_fairgrounds/alligator.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/vending_hat.mdl",
			},
			{
				type = "model",
				model = "models/props/de_tides/vending_tshirt.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/fishriver01.mdl",
			},
			{
				type = "model",
				model = "models/props/CS_militia/mountedfish01.mdl",
			},
			{
				type = "model",
				model = "models/props_street/mail_dropbox.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/bball.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer001a_Chunk01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer001a_Chunk02.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer001a_Chunk03.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer001a_Chunk06.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureDrawer001a_Chunk05.mdl",
			},
			{
				type = "model",
				model = "models/props_combine/breenglobe.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery01a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery02a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery03a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery04a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery05a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery06a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery07a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery08a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery09a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pottery_large01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/terracotta01.mdl",
			},
			{
				type = "model",
				model = "models/uc/propper/pdstoragewin.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureShelf002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/PlasticCrate01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/PlasticCrate01a.mdl",
				skin = 1,
			},
			{
				type = "model",
				model = "models/props_junk/PlasticCrate01a.mdl",
				skin = 2,
			},
			{
				type = "model",
				model = "models/props_junk/PlasticCrate01a.mdl",
				skin = 3,
			},
			{
				type = "model",
				model = "models/props_junk/PlasticCrate01a.mdl",
				skin = 4,
			},
			{
				type = "model",
				model = "models/props_c17/metalladder001.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/metalladder002.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/metalladder002b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pulleywheels_small01.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/pulleywheels_large01.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/kennel_physics.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/laundry_basket001.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/laundry_cart001.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/laundry_cart002.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/bicycle01a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign001c.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign002b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign003b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign004e.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign004f.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign005b.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign005c.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/streetsign005d.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_glassbottle002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_metalcan001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_metalcan002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/harpoon002a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/meathook001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/MetalBucket01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/MetalBucket02a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/grigori_shoe_left.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/grigori_shoe_right.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/shoe001b.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/Shoe001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/Shovel01a.mdl",
			},
			{
				type = "model",
				model = "models/props_trainstation/trainstation_post001.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/pylon.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/TrafficCone001a.mdl",
			},
			{
				type = "model",
				model = "models/props_fairgrounds/traffic_barrel.mdl",
			},
			{
				type = "model",
				model = "models/props_fortifications/traffic_barrier001.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/barricade002a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/barricade001a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/Wheebarrow01a.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/bewaredog.mdl",
			},
			{
				type = "model",
				model = "models/props_lab/crematorcase.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_office/Fire_Extinguisher.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_interior/extinguisher_case.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_interior/firehose_wallmount.mdl",
			},
			{
				type = "model",
				model = "models/props/de_nuke/LifePreserver.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/lifering.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_unioncity/alarmbell.mdl",
			},
			{
				type = "model",
				model = "models/props/cs_assault/FireHydrant.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/concrete_barrier001a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/medbridge_post01.mdl",
			},
			{
				type = "model",
				model = "models/props_docks/dock01_cleat01a.mdl",
			},
			{
				type = "model",
				model = "models/props_urban/ice_machine001.mdl",
			},
			{
				type = "model",
				model = "models/uc/propper/phoneframe.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/prison_shelf002a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureShelf001a.mdl",
			},
			{
				type = "model",
				model = "models/props_c17/FurnitureShelf001b.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/wood_fence01a.mdl",
			},
			{
				type = "model",
				model = "models/props_wasteland/wood_fence02a.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/doorboards_e.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_unioncity/doorboards_f.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/plasticflaps.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_laundromat/coin_change.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/petfoodbag01.mdl",
			},
			{
				type = "header",
				text = "Другое",
			},
			{
				type = "model",
				model = "models/effects/urban_puddle_model01a.mdl",
			},
			{
				type = "model",
				model = "models/effects/urban_puddle_model02a.mdl",
			},
			{
				type = "model",
				model = "models/effects/urban_puddle_model03a.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/puddle_oil.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/puddle_paint.mdl",
			},
			{
				type = "model",
				model = "models/noirpropper/puddle_paint2.mdl",
			},
			{
				type = "model",
				model = "models/props_destruction/dest_rubbletile01.mdl",
			},
			{
				type = "model",
				model = "models/props_destruction/dest_rubbletile02.mdl",
			},
			{
				type = "model",
				model = "models/props_destruction/dest_rubbletile03.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/clothing_pile1.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/clothing_pile2.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/clothing_pile3.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/spawn_apartment/blanket03.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_junk/junk_b.mdl",
			},
			{
				type = "model",
				model = "models/uc/props_junk/junk_c.mdl",
			},
			{
				type = "model",
				model = "models/unioncity3/props_alley/junk1.mdl",
			},
			{
				type = "model",
				model = "models/unioncity3/props_alley/junk4.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/clothing_pile4.mdl",
			},
			{
				type = "model",
				model = "models/props_interiors/clothing_pile5.mdl",
			},
			{
				type = "model",
				model = "models/props_mall/clothing_pile01.mdl",
			},
			{
				type = "model",
				model = "models/props_mall/clothing_pile02.mdl",
			},
			{
				type = "model",
				model = "models/props_mall/clothing_pile03.mdl",
			},
			{
				type = "model",
				model = "models/props_mall/clothing_pile07.mdl",
			},
			{
				type = "model",
				model = "models/props_unique/spawn_apartment/blanket01.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile-1.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile-1b.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile-1c.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile-2.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile-2b.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile-3.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile-3b.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_circular-1.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_circular-1b.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_circular-1c.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_circular-2.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_circular-2b.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_circular-2c.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_circular-3.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_linear-1.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_linear-1b.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_linear-2.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_linear-2b.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_linear-3.mdl",
			},
			{
				type = "model",
				model = "models/props_garbages/litter/pile_linear-3b.mdl",
			},
			{
				type = "model",
				model = "models/objects_city/trash_bag_01.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/trashbags1.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/trashbags2.mdl",
			},
			{
				type = "model",
				model = "models/props_trainstation/trashcan_indoor001b.mdl",
			},
			{
				type = "model",
				model = "models/props_trainstation/trashcan_indoor001a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_street/alley_trashcan.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/trash_can.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/TrashBin01a.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/TrashDumpster01a.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/dumpster1.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/dumpster2.mdl",
			},
			{
				type = "model",
				model = "models/unioncity2/props_alley/dumpster3.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/pants-1.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/pants-2.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/pants-3.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/shirt_pile-1.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/shirt_pile-2.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/shirt_pile-3.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/shirt_pile-4.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/shirt_pile-5.mdl",
			},
			{
				type = "model",
				model = "models/props_clothing/shirt_pile-8.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_carboard001a_box.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_carboard001b_box.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_carboard002a_box.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard1.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard2.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard3.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard3_box.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard4.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard5.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard5_box.mdl",
			},
			{
				type = "model",
				model = "models/props_junk/garbage_cardboard6.mdl",
			},
		},
		needsapp = "",
		name = "Разное",
	},
}

-- http.Fetch("http://cityrp.macnco.one/props_spawn.json", function(body)
-- 	if not body then return end
-- 	local tbl = util.JSONToTable(body)
-- 	SetClipboardText(table.ToString(tbl, "test", true))
-- end)

-- local tbl = {}
-- for k, v in pairs(allowed_spawnlist) do
-- 	if not v.contents then continue end
-- 	for i, o in pairs(v.contents) do
-- 		if not o.model then continue end
-- 		tbl[o.model] = true
-- 	end
-- end
-- file.Write("allowed_props.json", util.TableToJSON(tbl))
-- SetClipboardText(table.ToString(tbl, "test", true))

-- local tbl = {}
-- for k, v in pairs(spawnmenu.GetPropTable()) do
-- 	if v.name then
-- 		print(v.name)
-- 	end
-- 	if v.contents and v.name == "of" then
-- 		table.insert(tbl, v)
-- 	end
-- 	if v.contents and v.name == "tec" then
-- 		table.insert(tbl, v)
-- 	end
-- 	if v.contents and v.name == "mi" then
-- 		table.insert(tbl, v)
-- 	end
-- 	if v.contents and v.name == "mi2" then
-- 		table.insert(tbl, v)
-- 	end
-- end
-- file.Write("props_spawn.json", util.TableToJSON(tbl))
-- SetClipboardText(table.ToString(tbl, "test", true))