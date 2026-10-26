--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/config/cases/case_id1.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Glac.RegisterConfig("case_id1", function()
	Glac.AddCase("case_id1", {
		Name = "Манетрон",
		icon = SERVER and "" or Material("gmodla/f4/poster/muni1.png", "smooth"),
		icon_size = {700, 1000},
		desc = "игровая валюта",
		details = "Получи шанс выиграть от $2.500 до $500.000 игровой валюты",
		Category = "Cases",
		Price = 250,
	})

	Glac.AddDrop("case_id1", "money", 200)
	Glac.AddDrop("case_id1", "money1", 175)
	Glac.AddDrop("case_id1", "money2", 150)
	Glac.AddDrop("case_id1", "money3", 100)
	Glac.AddDrop("case_id1", "money4", 50)
	Glac.AddDrop("case_id1", "money4.1", 50)
	Glac.AddDrop("case_id1", "money5", 1)
end)
