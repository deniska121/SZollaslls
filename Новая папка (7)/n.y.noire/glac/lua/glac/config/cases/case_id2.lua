--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/config/cases/case_id2.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function CarPrice(car)
	return car.donate and car.price or math.Round(car.price / 200)
end

local function CarChance(price)
	local chance = 9100 - price

	if price < 2000 then
		chance = chance * 3
	end

	return chance
end

Glac.RegisterConfig("case_id2", function()
	Glac.AddCase("case_id2", {
		Name = "Врум-Врум",
		icon = SERVER and "" or Material("gmodla/f4/poster/carz1.png", "smooth"),
		icon_size = {700, 1000},
		desc = "машины",
		details = "Получи шанс выиграть почти любую машину из автосалона или одну из 3-х уникальных машин",
		Category = "Cases",
		Price = 1000,
		check = function(ply)
			local cars = SERVER and ply:LoadCars() or (CarInventory or {})
			local maxcars = 5 + (MQS.GetDataStored(ply, "car_slots") or 0)

			if cars and #cars >= maxcars then
				if SERVER then DarkRP.notify(ply, 1, 4, "У вас достигнут лимит свободного места в личном гараже, " .. #cars .. " из " .. maxcars .. " машин!") end
				return false
			end

			return true
		end,
		DropSort = CLIENT and function(menu, k, v, drop)
			for _, f in pairs(drop) do
				local car = McCD.Cars[f.item]
				f.name = car.name
				f.ext = ""

				if car.nobuy then
					f.ext = "\nУникальная"
					f.chance = 1
				end
			end

			local color = Glac.SortDrops(drop)

			MSD.InfoHeader(menu.canvas, "Содержание")

			for _, f in ipairs(drop) do
				MSD.DropIcon(menu.canvas, Material("entities/" .. f.item .. ".png", "smooth"), 10, color(f.chance), function() end, f.name .. f.ext)
			end
		end or nil,
	})

	local vehicles = list.Get("simfphys_vehicles")

	for class, car in pairs(McCD.Cars) do
		if car.nocase then continue end

		local veh = vehicles[class]
		local price = CarPrice(car)
		local chance = CarChance(price)

		if not veh or chance <= 0 then continue end

		Glac.AddItem(class, {
			Name = car.name,
			icon = {veh.Model, 120, class, car.fweels},
			desc = "",
			details = "",
			Category = "cars",
			Price = price,
			NoBuy = true,
			OnPurFunction = function(ply)
				McCD.AddCar(ply, class)
			end,
		})

		Glac.AddDrop("case_id2", class, chance)
	end
end)
