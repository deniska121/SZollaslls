--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/config/cases/case_id3.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local DROPS = {
	{
		Name = "Лёгкий бронежилет x3",
		icon = Material("gmodla/icons/armor2.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 55,
		OnPurFunction = function(ply)
			local item = {
				class = "armor",
				name = "Лёгкий бронежилет",
				model = "models/tnb/items/wintercoat.mdl",
				material = "gbskins/armor2",
				weight = 2.5,
				dt = {
					eclass = "armor"
				},
			}

			for i = 1,3 do
				ply:AddBankItem(INV_JUNK, item)
			end
		end,
	},
	{
		Name = "Сигара x5",
		icon = Material("gmodla/icons/sigar.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 50,
		OnPurFunction = function(ply)
			local item = {
				class = "sigar",
				name = "Сигара",
				model = "models/env/decor/ashtray/sigar02.mdl",
				weight = 0.05,
				dt = {
					eclass = "sigar"
				},
			}

			for i = 1,5 do
				ply:AddBankItem(INV_JUNK, item)
			end
		end,
	},
	{
		Name = "Сварочная маска",
		icon = Material("gmodla/icons/welding_mask.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 300,
		OnPurFunction = function(ply)
			local item = {
				class = "weldingmask",
				name = "Сварочная маска",
				model = "models/ez2models/humans/group03b/welding_mask.mdl",
				weight = 1,
				dt = {
					eclass = "weldingmask"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Баллистический Шлем",
		icon = Material("gmodla/icons/camo_swat.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 300,
		OnPurFunction = function(ply)
			local item = {
				class = "helmet",
				name = "Баллистический Шлем",
				model = "models/helmets/camo_swat.mdl",
				weight = 1,
				dt = {
					eclass = "helmet"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Каска x2",
		icon = Material("gmodla/icons/worker_helmet.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 50,
		OnPurFunction = function(ply)
			local item = {
				class = "hardhat",
				name = "Каска",
				model = "models/items/worker_helmet.mdl",
				weight = 0.5,
				dt = {
					eclass = "hardhat"
				},
			}

			for i = 1,2 do
				ply:AddBankItem(INV_JUNK, item)
			end
		end,
	},
	{
		Name = "Бонг",
		icon = Material("gmodla/icons/bottle.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 220,
		OnPurFunction = function(ply)
			local item = {
				class = "bong",
				name = "Бонг",
				model = "models/henry/gta sa/gmod/objects/bottle/bottle.mdl",
				dt = {
					eclass = "bong"
				},
			}


			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Премиум зажигалка x3",
		icon = Material("gmodla/icons/lighter.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 250,
		OnPurFunction = function(ply)
			local item = {
				class = "lighter",
				name = "Премиум зажигалка",
				model = "models/weapons/w_lighter.mdl",
				material = "models/weapons/v_lighter/lighter" .. math.random(2,7),
				weight	=	0.08,
				dt = {
					eclass = "lighter"
				},
			}

			for i = 1,3 do
				ply:AddBankItem(INV_JUNK, item)
			end
		end,
	},
	{
		Name = "БумБокс",
		icon = Material("gmodla/icons/boombox_02.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 100,
		OnPurFunction = function(ply)
			local item = {
				class = "boombox",
				name = "БумБокс",
				model = "models/physics_props/electronics/boombox_02.mdl",
				weight = 5.2,
				dt = {
					eclass = "boombox"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "БумБокс",
		icon =  Material("gmodla/icons/boombox_01.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 120,
		OnPurFunction = function(ply)
			local item = {
				class = "boombox",
				name = "БумБокс",
				model = "models/physics_props/electronics/boombox_01.mdl",
				weight = 5.2,
				dt = {
					eclass = "boombox"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Радио",
		icon = Material("gmodla/icons/boombox_03.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 60,
		OnPurFunction = function(ply)
			local item = {
				class = "radio",
				name = "Радио",
				model = "models/physics_props/electronics/boombox_03.mdl",
				weight = 0.5,
				dt = {
					eclass = "radio"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Радио",
		icon = Material("gmodla/icons/radio.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 65,
		OnPurFunction = function(ply)
			local item = {
				class = "radio",
				name = "Радио",
				model = "models/props/cs_office/radio.mdl",
				weight = 0.5,
				dt = {
					eclass = "radio"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Радио (от машины)",
		icon = Material("gmodla/icons/reciever01d.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 100,
		OnPurFunction = function(ply)
			local item = {
				class = "car_radio",
				name = "Радио (от машины)",
				model = "models/props_lab/reciever01d.mdl",
				weight = 0.5,
				dt = {
					eclass = "car_radio"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Телефон x2",
		icon = Material("gmodla/icons/cellphone-5.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 70,
		OnPurFunction = function(ply)
			local item = {
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

			for i = 1,2 do
				ply:AddBankItem(INV_JUNK, item)
			end
		end,
	},
	{
		Name = "NOSTALGY PHONE x2",
		icon = Material("gmodla/icons/camphone.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 70,
		OnPurFunction = function(ply)
			local item = {
				["class"] = "phone_n",
				["color"] = color_white,
				["dt"] = {["eclass"] = "phone_n"},
				["model"] = "models/cityrp/camphone.mdl",
				["name"] = "Телефон",
				["phone_type"] = 6,
				["ud"] = {
					["PhoneColor"] = color_white,
					["PhoneType"] = "Nocla",
					["Ringtone"] = "cell/tone_1.wav",
					["Sleep"] = false,
					["WallPaper"] = "n/1.png",
				},
				["weight"] = 0.1
			}

			for i = 1,2 do
				ply:AddBankItem(INV_JUNK, item)
			end
		end,
	},
	{
		Name = "FUTURE PHONE",
		icon = Material("gmodla/inv/phone_lm.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 500,
		OnPurFunction = function(ply)
			local item = {
				["class"] = "phone_lm",
				["color"] = color_white,
				["dt"] = {["eclass"] = "phone_lm"},
				["model"] = "models/mactavish/lm_phone.mdl",
				["name"] = "Телефон",
				["phone_type"] = 3,
				["ud"] = {
					["PhoneColor"] = color_white,
					["PhoneType"] = "Bloom",
					["Ringtone"] = "tone_4.wav",
					["Sleep"] = false,
					["WallPaper"] = "",
				},
				["weight"] = 0.1
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Таблетки",
		icon = Material("gmodla/icons/pills.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 310,
		OnPurFunction = function(ply)
			local item = {
				class = "pills8",
				name = "Таблетки LS4",
				model = "models/pills.mdl",
				weight = 0.1,
				dt = {
					eclass = "pills8"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Шапочка из фольги",
		icon = Material("gmodla/icons/foilhat.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 300,
		OnPurFunction = function(ply)
			local item = {
				class = "foilhat",
				name = "Шапочка из фольги",
				model = "models/tnb/items/beanie.mdl",
				weight = 0.01,
				material = "cityrp/foil",
				dt = {
					eclass = "foilhat"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		Name = "Молоток x2",
		icon = Material("gmodla/icons/hammer.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 150,
		OnPurFunction = function(ply)
			local item = {
				class = "mlw_hammer",
				model = "models/weapons/tfa_nmrih/w_tool_barricade.mdl",
				dt = {
					eclass = "mlw_hammer"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		Name = "Труба x2",
		icon = Material("gmodla/icons/pipe.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 150,
		OnPurFunction = function(ply)
			local item = {
				class = "mlw_pipe",
				model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl",
				weight = 0.7,
				dt = {
					eclass = "mlw_pipe"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		Name = "Мачете x2",
		icon = Material("gmodla/icons/machete.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 200,
		OnPurFunction = function(ply)
			local item = {
				class = "mlw_machete",
				model = "models/weapons/tfa_nmrih/w_me_machete.mdl",
				weight = 1.1,
				dt = {
					eclass = "mlw_machete"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		Name = "Клюшка x2",
		icon = Material("gmodla/icons/golfclub.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 150,
		OnPurFunction = function(ply)
			local item = {
				class = "mlw_club",
				model = "models/weapons/melee/w_golfclub.mdl",
				weight = 1.2,
				dt = {
					eclass = "mlw_club"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		Name = "Кувалда",
		icon = Material("gmodla/icons/sledge.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 200,
		OnPurFunction = function(ply)
			local item = {
				class = "mlw_sledge",
				model = "models/weapons/tfa_nmrih/w_me_sledge.mdl",
				weight = 5.2,
				dt = {
					eclass = "mlw_sledge"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		Name = "Лопата",
		icon = Material("gmodla/icons/spade.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 200,
		OnPurFunction = function(ply)
			local item = {
				class = "mlw_spade",
				model = "models/weapons/tfa_nmrih/w_me_spade.mdl",
				weight = 2.2,
				dt = {
					eclass = "mlw_spade"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		Name = "Пожарный топор",
		icon = Material("gmodla/icons/axe.png", "smooth"),
		desc = "",
		details = "",
		Category = "misc",
		Price = 200,
		OnPurFunction = function(ply)
			local item = {
				class = "mlw_fireaxe",
				model = "models/weapons/tfa_nmrih/w_me_axe_fire.mdl",
				weight = 4.1,
				dt = {
					eclass = "mlw_fireaxe"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
}

Glac.RegisterConfig("case_id3", function()
	Glac.AddCase("case_id3", {
		Name = "Находка",
		icon = SERVER and "" or Material("gmodla/f4/poster/stuff.png", "smooth"),
		icon_size = {700, 1000},
		desc = "уникальные предметы",
		details = "Получи шанс выиграть уникальные предметы",
		Category = "Cases",
		Price = 100,
		DropSort = CLIENT and function(menu, k, v, drop)
			local hv, lv

			table.sort(drop, function(a, b)
				if not hv or hv > a.chance then hv = a.chance end
				if not lv or lv < a.chance then lv = a.chance end
				return a.chance > b.chance
			end)

			local av = math.Round(210 / (lv - hv), 3)

			MSD.InfoHeader(menu.canvas, "Содержание")

			for _, f in pairs(drop) do
				local item = Glac.Items[f.item]
				MSD.DropIcon(menu.canvas, item.icon, 10, HSLToColor(180 + (lv - f.chance) * av, 0.89, 0.57), function() end, item.Name)
			end
		end or nil,
	})

	for i, prize in ipairs(DROPS) do
		local key = "case_id3_" .. i

		prize.NoBuy = true
		Glac.AddItem(key, prize)
		Glac.AddDrop("case_id3", key, 501 - prize.Price)
	end
end)
