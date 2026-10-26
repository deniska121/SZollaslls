--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/config/sh_shop.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Glac.RegisterConfig("shop", function()
	Glac.AddItem("token", {
		Name = "Токен для смены персонажа",
		icon = Material("gmodla/f4/stuff/pass.png", "smooth"),
		desc = "",
		details = "Позволяет вам пересоздать любого уже существующего персонажа. Внимание! Пересоздание персонажа-госслужащего сбрасывает ваш прогресс в государственных структурах.",
		Category = "Other",
		Price = 100,
		--Old_Price = 100,
		OGPrice = 200,
		OnPurFunction = function(ply, item)
			local ct = MQS.GetDataStored(ply, "mcr_change") or 0
			MQS.SetNWStoredData(ply, "mcr_change", math.max(ct, 0) + 1)
		end,
	})

	Glac.AddItem("carslots", {
		Name = "Слот на расширение гаража",
		icon = Material("gmodla/f4/stuff/garage.png", "smooth"),
		desc = "",
		details = "Позволяет вам расширить гараж на 1 дополнительное место. Каждый последующий токен увеличивается в стоимости.",
		Category = "Other",
		Price = 200,
		priceUpdater = function(ply)
			local ct = MQS.GetDataStored(ply, "car_slots") or 0
			return math.max(200 + ct * 25, 200)
		end,
		OnPurFunction = function(ply, item)
			Glac.AddCarSlot(ply)
		end,
	})

	Glac.AddItem("token2", {
		Name = "Токен снятия блокировки до 90 дней",
		icon = Material("gmodla/f4/stuff/pass.png", "smooth"),
		desc = "",
		details = "Снятие блокировки таким образом возможно только со сроком до 90 дней. Снятие блокировки за кредиты не отменяет ваши проступки. За последующие нарушения вы можете получить двойное наказание без предупреждения. 1 день = 50 кредитов.",
		Category = "Other",
		Price = 1200,
		priceUpdater = function(ply)
			local time = ply:getDarkRPVar("BANNED") or 7776000
			time = time - os.time()
			time = math.Round(time / 86400)
			return math.Clamp(time * 50, 50, 5000)
		end,
		check = function(ply)
			if not ply:getDarkRPVar("BANNED") then return false end
			if CLIENT then return true end
			if not sAdmin.bans[ply:SteamID64()] then return false end
			local time = tonumber(sAdmin.bans[ply:SteamID64()].expiration)

			if not time or time == 0 or time - os.time() > 7776000 then return false end

			return true
		end,
		OnPurFunction = function(ply, item)
			sAdmin.unban(ply:SteamID64())

			Discord.Log("request", {content = "<@&1180491439378010145>", username = ply:Name(), embeds = {{
				url = "http://steamid.macnco.one/?q=" .. ply:SteamID64(),
				title = ply:SteamName(),
				description = "Покупка разбана",
				color = 0xFF9300
			}}})

			ply:Kick("Токен активирован")
		end,
	})

	Glac.AddItem("d_packrat1", {
		Name = "Турист",
		icon = SERVER and "" or Material("gmodla/f4/packs/tourist.png", "smooth"),
		icon_size = {700, 1000},
		desc = "старт в новом городе",
		details = "Набор включает в себя: $50.000, бейсболку туриста, и сувенирную футболку.",
		Category = "Pack",
		Price = 1000,
		--Old_Price = 1000,
		check = Glac.Once("d_packrat1"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packrat1", 1)
			ply:addMoney(50000)
		end,
	})

	Glac.AddItem("d_packrat4", {
		Name = "Англичанин",
		icon = SERVER and "" or Material("gmodla/f4/packs/englishman.png", "smooth"),
		icon_size = {700, 1000},
		desc = "джентльменский набор",
		details = "Набор включает в себя: набор мужских джемперов, две плоские кепки, и две клюшки. Оружие выдаётся единоразово.",
		Category = "Pack",
		Price = 2000,
		--Old_Price = 2000,
		check = Glac.Once("d_packrat4"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packrat4", 1)
			local give = {
				class = "mlw_club",
				name = "Клюшка",
				model = "models/weapons/melee/w_golfclub.mdl",
				dt = {
					eclass = "mlw_club",
				},
			}
			ply:AddBankItem(INV_WEAPON, give)
			ply:AddBankItem(INV_WEAPON, give)
		end,
	})

	Glac.AddItem("d_packrat5", {
		Name = "Американская мечта",
		icon = SERVER and "" or Material("gmodla/f4/packs/dream.png", "smooth"),
		icon_size = {700, 1000},
		desc = "..в глазах приезжего",
		details = "Набор включает в себя: $500.000, комплект уникальных курток, и машину \"2004 Victoria\" с дополнительным слотом в гараж.",
		Category = "Pack",
		Price = 4000,
		--Old_Price = 4000,
		check = Glac.Once("d_packrat5"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packrat5", 1)

			Glac.AddCarSlot(ply)

			ply:addMoney(500000)
			McCD.AddCar(ply, "sim_fphys_l4d_crownvic")
		end,
	})

	Glac.AddItem("d_packrat6", {
		Name = "Амбиции",
		icon = SERVER and "" or Material("gmodla/f4/packs/nissan.png", "smooth"),
		icon_size = {700, 1000},
		desc = "с ними всё получится",
		details = "Набор включает в себя: рубашку малибу, солнцезащитные очки, и машину \"99 Nissan Skyline\" с дополнительным слотом в гараж.",
		Category = "Pack",
		Price = 7000,
		--Old_Price = 7000,
		check = Glac.Once("d_packrat6"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packrat6", 1)

			Glac.AddCarSlot(ply)

			McCD.AddCar(ply, "r34_simfphys")
		end,
	})

	Glac.AddItem("d_packrat7", {
		Name = "Мафиосо",
		icon = SERVER and "" or Material("gmodla/f4/packs/mafia.png", "smooth"),
		icon_size = {700, 1000},
		desc = "возврат в 50-е",
		details = "Набор включает в себя: два автомата M1928 Thompson с барабанными магазинами и скином, строгий заказной костюм, шляпу \"Федора\", и уникальную машину \"53 Pontiac Chieftain\" с дополнительным слотом в гараж. Оружие выдаётся единоразово.",
		Category = "Pack",
		Price = 7000,
		--Old_Price = 7000,
		check = Glac.Once("d_packrat7"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packrat7", 1)

			Glac.AddCarSlot(ply)

			McCD.AddCar(ply, "simfphys_potomac_indian")

			local give = {
				["DefaultMag"] = "thom_50",
				["att_saved"] = {
					{
						["Slot"] = 1,
						["m_Index"] = "vm_thotel_mag_00"
					},
					{
						["Slot"] = 2,
						["m_Index"] = "vm_thotel_stock_hv_00"
					},
					{
						["Slot"] = 3,
						["m_Index"] = "vm_sm_thotel_angled_00"
					},
					{
						["Slot"] = 4,
						["m_Index"] = "vm_thotel_barrel_l_00"
					},
					{
						["Slot"] = 5,
						["m_Index"] = "vm_thotel_irons_s_00"
					}
				},
				["class"] = "mwb_thompson",
				["clip1"] = 50,
				["clip2"] = -1,
				["dt"] = {
					["eclass"] = "mwb_thompson",
				},
				["gunstate"] = 1,
				["model"] = "models/easy/vg/weapons/w_thotel.mdl",
				["name"] = "M1928 Thompson",
				["weight"] = 5.4,
			}
			ply:AddBankItem(INV_WEAPON, give)
			ply:AddBankItem(INV_WEAPON, give)
		end,
	})

	Glac.AddItem("d_blueblood", {
		Name = "Голубая кровь",
		icon = SERVER and "" or Material("gmodla/f4/packs/blueblood.png", "smooth"),
		icon_size = {700, 1000},
		desc = "честь, учтивость, справедливость",
		details = "Набор включает в себя: две тематические футболки и одну толстовку, синюю бейсболку, и ствол из нержавеющей стали на пистолет Glock 17.",
		Category = "Pack",
		Price = 1500,
		--Old_Price = 1500,
		check = Glac.Once("d_blueblood"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_blueblood", 1)
		end,
	})

	Glac.AddItem("d_packbluecolar", {
		Name = "Аппер Код",
		icon = SERVER and "" or Material("gmodla/f4/packs/uppercode.png", "smooth"),
		icon_size = {700, 1000},
		desc = "городской секрет",
		details = "Набор с рабочей, \"мужской\" направленностью, включает в себя: жилет, две шапки, две светоотражающие куртки, и восемь тематических комплектов одежды.",
		Category = "Pack",
		Price = 1500,
		--Old_Price = 1500,
		check = Glac.Once("d_packbluecolar"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packbluecolar", 1)
		end,
	})

	Glac.AddItem("d_packhotline", {
		Name = "Горячая линия",
		icon = SERVER and "" or Material("gmodla/f4/packs/hotline.png", "smooth"),
		icon_size = {700, 1000},
		desc = "профессионалы",
		details = "Набор включает в себя: снежный костюм, альтернативу костюмным рубашкам в виде мужской водолазки, уникальную штормовку, MAC-10 с глушителем, 5 банок таблеток LS4; биту, пожарный топор и возможность их персонализации через рабочий стол.",
		Category = "Pack",
		Price = 2700,
		Old_Price = 3000,
		check = Glac.Once("d_packhotline"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packhotline", 1)

			local pills = {
				class = "pills8",
				name = "Таблетки LS4",
				model = "models/pills.mdl",
				weight = 0.1,
				dt = {
					eclass = "pills8",
				},
			}
			for i = 1, 5 do
				ply:AddBankItem(INV_JUNK, pills)
			end

			ply:AddBankItem(INV_WEAPON, {
				["DefaultMag"] = "mac_30",
				["att_saved"] = {
					[2] = {
						["Slot"] = 2,
						["m_Index"] = "mac10_f_stock_mac10"
					},
					[4] = {
						["Slot"] = 4,
						["m_Index"] = "mac_sup_mac10"
					},
				},
				["class"] = "mwb_mac10",
				["clip1"] = 30,
				["clip2"] = -1,
				["dt"] = {
					["eclass"] = "mwb_mac10",
				},
				["gunstate"] = 1,
				["model"] = "models/viper/mw/weapons/w_mac10.mdl",
				["name"] = "MAC-10",
				["weight"] = 2.8,
			})

			ply:AddBankItem(INV_WEAPON, {
				class = "mlw_fireaxe",
				name = "Пожарный топор",
				model = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl",
				wskin = "salamanca",
				weight = 4.1,
				dt = {
					eclass = "mlw_fireaxe",
				},
			})

			ply:AddBankItem(INV_WEAPON, {
				class = "mlw_bat",
				name = "Бита",
				model = "models/weapons/tfa_nmrih/w_me_bat_metal.mdl",
				wskin = "wood",
				weight = 1.2,
				dt = {
					eclass = "mlw_bat",
				},
			})
		end,
	})

	Glac.AddItem("clear_cars", {
		Name = "Автолюбитель",
		icon = SERVER and "" or Material("gmodla/f4/packs/carz.png", "smooth"),
		icon_size = {700, 1000},
		desc = "новый взгляд на старые ценности",
		details = "Набор включает в себя: три автомобильных радио; чистое покрытие для: 69 Roadrunner, 69 Charger, 78 Ford, 82 Hatchback, 84 Fleetwood, 85 Mercedes W123, 95 Buick, 2001 Blazer, 2004 Victoria, и 2004 Ram.",
		Category = "Pack",
		Price = 1100,
		--Old_Price = 1100,
		check = Glac.Once("clear_cars"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "clear_cars", 1)
			local give = {
				class = "car_radio",
				name = "Радио (от машины)",
				model = "models/props_lab/reciever01d.mdl",
				dt = {
					eclass = "car_radio",
				},
			}
			ply:AddBankItem(INV_JUNK, give)
			ply:AddBankItem(INV_JUNK, give)
			ply:AddBankItem(INV_JUNK, give)
		end,
	})

	Glac.AddItem("d_fishy", {
		Name = "Быстрый бизнес",
		icon = SERVER and "" or Material("gmodla/f4/packs/fishy.png", "smooth"),
		icon_size = {700, 1000},
		desc = "почти фитнес",
		details = "Набор включает в себя: пять импортных телефонов, комплект спортивных поло, и однотонную бейсболку с двумя видами ношения.",
		Category = "Pack",
		Price = 600,
		--Old_Price = 600,
		check = Glac.Once("d_fishy"),
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_fishy", 1)
			local give = {
				["class"] = "phone_bj",
				["color"] = color_white,
				["dt"] = {["eclass"] = "phone_bj"},
				["model"] = "models/props_electronics/cellphone-5.mdl",
				["name"] = "Телефон",
				["phone_type"] = 7,
				["ud"] = {
					["PhoneColor"] = color_white,
					["PhoneType"] = "Beijing",
					["Ringtone"] = "cell/redsun.mp3",
					["Sleep"] = false,
					["WallPaper"] = "bch/1.png",
				},
				["weight"] = 0.1
			}
			for i = 1,5 do
				ply:AddBankItem(INV_JUNK, give)
			end
		end,
	})

	Glac.AddItem("packrathlwn", {
		Name = "Фамильярность",
		icon = SERVER and "" or Material("gmodla/f4/packs/hlwn.png", "smooth"),
		icon_size = {700, 1000},
		desc = "Ночь опасна.. возьми это с собой",
		details = "Набор включает в себя: $10.000, бейсболку бренд, и две кепки сантехника. Набор лимитирован - финальный день разблокировки 5 ноября",
		Category = "Pack",
		Price = 700,
		check = function(ply)
			return false
		end,
		OnPurFunction = function(ply, item)
			MQS.SetNWStoredData(ply, "d_packrathlwn", 1)
			ply:addMoney(10000)
		end,
	})

	Glac.AddItem("money", {
		Name = "$2.500",
		icon = Material("gmodla/f4/stuff/money_a.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 35,
		OnPurFunction = function(ply, item)
			ply:addMoney(2500)
		end,
	})

	Glac.AddItem("money1", {
		Name = "$7.000",
		icon = Material("gmodla/f4/stuff/money_s.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 70,
		OnPurFunction = function(ply, item)
			ply:addMoney(7000)
		end,
	})

	Glac.AddItem("money2", {
		Name = "$25.000",
		icon = Material("gmodla/f4/stuff/onemoney.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 200,
		OnPurFunction = function(ply, item)
			ply:addMoney(25000)
		end,
	})

	Glac.AddItem("money3", {
		Name = "$50.000",
		icon = Material("gmodla/f4/stuff/twomoney.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 350,
		OnPurFunction = function(ply, item)
			ply:addMoney(50000)
		end,
	})

	Glac.AddItem("money4", {
		Name = "$100.000",
		icon = Material("gmodla/f4/stuff/threemoney.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 650,
		OnPurFunction = function(ply, item)
			ply:addMoney(100000)
		end,
	})

	Glac.AddItem("money4.1", {
		Name = "$250.000",
		icon = Material("gmodla/f4/stuff/money_p.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 1500,
		OnPurFunction = function(ply, item)
			ply:addMoney(250000)
		end,
	})

	Glac.AddItem("money5", {
		Name = "$500.000",
		icon = Material("gmodla/f4/stuff/fourmoney.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 2920,
		OnPurFunction = function(ply, item)
			ply:addMoney(500000)
		end,
	})

	Glac.AddItem("money6", {
		Name = "$1.000.000",
		icon = Material("gmodla/f4/stuff/fivemoney.png", "smooth"),
		desc = "игровой валюты",
		details = "",
		Category = "Money",
		Price = 5000,
		OnPurFunction = function(ply, item)
			ply:addMoney(1000000)
		end,
	})

	local skins_restore = {
		["skin_ak_v21"] = 399,
		["skin_ak_supra"] = 299,
		["skin_ak_revol"] = 499,
		["skin_m4_thund"] = 299,
		["skin_m4_zip"] = 499,
		["skin_m4_oper"] = 349,
		["skin_m4_xrk"] = 999,
		["skin_scar_adder"] = 349,
		["skin_mp5_strap"] = 399,
		["skin_uzi_blow"] = 249,
		["skin_rem_eject"] = 249,
		["skin_rem_itha"] = 249,
		["skin_p320_quiet"] = 99,
		["skin_p320_slick"] = 179,
		["skin_glock_urban"] = 149,
		["skin_glock_task"] = 99,
		["skin_m9_guard"] = 149,
		["skin_m9_raf"] = 179,
		["skin_m1911_jav"] = 199,
		["skin_m1911_old"] = 449,
		["skin_walter"] = 249,
	}

	Glac.AddItem("token_restore", {
		Name = "Восстановление покупок",
		icon = Material("gmodla/f4/stuff/restore.png", "smooth"),
		desc = "",
		details = "Компенсирует кредиты за удалённые из игры предметы.",
		Category = "Other",
		Price = 0,
		check = function(ply)
			if not ply.MQSdata or not ply.MQSdata.Stored or not ply.MQSdata.Stored.skins then return false end

			return true
		end,
		OnPurFunction = function(ply, item)
			if not ply.MQSdata or not ply.MQSdata.Stored or not ply.MQSdata.Stored.skins then return end

			local price = 0

			for k, _ in pairs(ply.MQSdata.Stored.skins) do
				if skins_restore[k] then
					price = price + skins_restore[k]
				end
			end

			ply:AddCredits(price)
			MQS.SetNWStoredData(ply, "skins", nil)
		end,
	})
end)
