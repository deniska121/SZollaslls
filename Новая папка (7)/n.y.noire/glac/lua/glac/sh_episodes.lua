--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/sh_episodes.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Glac.Episodes = {}

Glac.Episodes[1] = {
	Name = "Эпизод первый",
	PremiumMultiplier = 1.5,
}

Glac.Episodes[1].Episodes = {
	[1] = "season1_civilian_1",
	[2] = "season1_civilian_2",
	[3] = "season1_civilian_3",
	[4] = "season1_civilian_4",
	[5] = "season1_civilian_5",
	[6] = "season1_govern_1",
	[7] = "season1_govern_2",
	[8] = "season1_govern_3",
	[9] = "season1_govern_4",
	[10] = "season1_govern_5",
	[11] = "season1_criminal_1",
	[12] = "season1_criminal_2",
	[13] = "season1_criminal_3",
	[14] = "season1_criminal_4",
	[15] = "season1_criminal_5",
}

Glac.Episodes[1].EpisodesSorted = {
	[1] = {
		[1] = "season1_civilian_1",
		[2] = "season1_civilian_2",
		[3] = "season1_civilian_3",
		[4] = "season1_civilian_4",
		[5] = "season1_civilian_5",
	},
	[2] = {
		[1] = "season1_govern_1",
		[2] = "season1_govern_2",
		[3] = "season1_govern_3",
		[4] = "season1_govern_4",
		[5] = "season1_govern_5",
	},
	[3] = {
		[1] = "season1_criminal_1",
		[2] = "season1_criminal_2",
		[3] = "season1_criminal_3",
		[4] = "season1_criminal_4",
		[5] = "season1_criminal_5",
	}
}

Glac.Episodes[1].Rewards = {
	{
		name = "2500$",
		icon = Material("gmodla/f4/stuff/onemoney.png", "smooth"),
		premium = false,
		dec = "Денежное вознаграждение за очки прогресса",
		cost = 150,
		give_func = function(ply)
			ply:addMoney(2500)
		end,
	},
	{
		name = "Труба x2",
		icon = Material("gmodla/icons/pipe.png", "smooth"),
		dec = "Предмет можно использовать для ближнего боя; после разблокировки он автоматически попадёт в ваше хранилище",
		premium = true,
		cost = 300,
		give_func = function(ply)
			local item = {
				class = "mlw_pipe",
				model = "models/weapons/tfa_nmrih/w_me_pipe_lead.mdl",
				dt = {
					eclass = "mlw_pipe"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		name = "Beretta M9",
		icon = Material("gmodla/icons/m9.png", "smooth"),
		dec = "Пистолет; после разблокировки он автоматически попадёт в ваше хранилище",
		premium = false,
		cost = 200,
		give_func = function(ply)
			local item = {
				class = "mwb_m9",
				name = "Beretta M9",
				gunstate = 1,
				weight = 1.02,
				model = "models/viper/mw/weapons/w_m9.mdl",
				dt = {
					eclass = "mwb_m9"
				},
				att_saved = {
					{
						["Slot"] = 1,
						["m_Index"] = "att_ammo",
					},
					{
						["Slot"] = 2,
						["m_Index"] = "attachment_vm_pi_mike9_receiver_v2",
					},
					{
						["Slot"] = 3,
						["m_Index"] = "attachment_vm_pi_mike9_pstlgrpcust",
					},
					{
						["Slot"] = 4,
						["m_Index"] = "attachment_vm_pi_mike9_barauto",
					},
					{
						["Slot"] = 5,
						["m_Index"] = "att_muzzle",
					}
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		name = "2500$",
		icon = Material("gmodla/f4/stuff/onemoney.png", "smooth"),
		dec = "Денежное вознаграждение за очки прогресса",
		premium = false,
		cost = 150,
		give_func = function(ply)
			ply:addMoney(2500)
		end,
	},
	{
		name = "Лёгкий бронежилет x2",
		icon = Material("gmodla/icons/armor2.png", "smooth"),
		dec = "Лёгкий бронежилет; после разблокировки он автоматически попадёт в ваше хранилище",
		premium = false,
		cost = 300,
		give_func = function(ply)
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

			ply:AddBankItem(INV_JUNK, item)
			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		name = "Сигара",
		icon = Material("gmodla/icons/sigar.png", "smooth"),
		dec = "Предмет можно единоразово использовать; после разблокировки он автоматически попадёт в ваше хранилище",
		premium = false,
		cost = 200,
		give_func = function(ply)
			local item = {
				class = "sigar",
				name = "Сигара",
				model = "models/env/decor/ashtray/sigar02.mdl",
				dt = {
					eclass = "sigar"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		name = "2500$",
		icon = Material("gmodla/f4/stuff/onemoney.png", "smooth"),
		dec = "Денежное вознаграждение за очки прогресса",
		premium = false,
		cost = 150,
		give_func = function(ply)
			ply:addMoney(2500)
		end,
	},
	{
		name = "Молоток x2",
		icon = Material("gmodla/icons/hammer.png", "smooth"),
		dec = "Предмет можно использовать для ближнего боя; после разблокировки он автоматически попадёт в ваше хранилище",
		premium = true,
		cost = 500,
		give_func = function(ply)
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
		name = "Beretta 93R",
		icon = Material("gmodla/icons/93r.png", "smooth"),
		dec = "Автоматический пистолет; после разблокировки он автоматически попадёт в ваше хранилище",
		premium = false,
		cost = 300,
		give_func = function(ply)
			local item = {
				class = "mwb_93r",
				name = "Beretta 93R",
				gunstate = 1,
				weight = 1.05,
				model = "models/viper/mw/weapons/w_m9.mdl",
				dt = {
					eclass = "mwb_93r"
				},
				att_saved = {
					{
						["Slot"] = 1,
						["m_Index"] = "att_ammo",
					},
					{
						["Slot"] = 2,
						["m_Index"] = "attachment_vm_pi_mike9_receiver_diamatti",
					},
					{
						["Slot"] = 3,
						["m_Index"] = "attachment_vm_pi_mike9_pstlgrpcust_diamatti",
					},
					{
						["Slot"] = 4,
						["m_Index"] = "attachment_vm_pi_mike9_barauto_diamatti",
					},
					{
						["Slot"] = 5,
						["m_Index"] = "att_muzzle",
					},
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		name = "Каска x2",
		icon = Material("gmodla/icons/worker_helmet.png", "smooth"),
		dec = "Предмет можно надеть; после разблокировки он автоматически попадёт в ваше хранилище. Этот предмет пропадет при смерти персонажа или выходе с сервера, если вы его не сняли!",
		premium = false,
		cost = 300,
		give_func = function(ply)
			local item = {
				class = "hardhat",
				name = "Каска",
				model = "models/items/worker_helmet.mdl",
				weight = 1,
				dt = {
					eclass = "hardhat"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		name = "5000$",
		icon = Material("gmodla/f4/stuff/money_p.png", "smooth"),
		dec = "Денежное вознаграждение за очки прогресса",
		premium = false,
		cost = 300,
		give_func = function(ply)
			ply:addMoney(5000)
		end,
	},
	{
		name = "Сигара x3",
		icon = Material("gmodla/icons/sigar.png", "smooth"),
		dec = "Предмет можно единоразово использовать; после разблокировки автоматически попадёт в ваше хранилище",
		premium = true,
		cost = 200,
		give_func = function(ply)
			local item = {
				class = "sigar",
				name = "Сигара",
				model = "models/env/decor/ashtray/sigar02.mdl",
				dt = {
					eclass = "sigar"
				},
			}

			ply:AddBankItem(INV_JUNK, item)
			ply:AddBankItem(INV_JUNK, item)
			ply:AddBankItem(INV_JUNK, item)
		end,
	},
	{
		name = "AUG A1",
		icon = Material("gmodla/icons/aug.png", "smooth"),
		dec = "Редкая автоматическая винтовка; после разблокировки она автоматически попадёт в ваше хранилище",
		premium = true,
		cost = 300,
		give_func = function(ply)
			local item = {
				class = "mwb_aug",
				name = "AUG A1",
				gunstate = 1,
				weight = 3.6,
				model = "models/easy/cw/weapons/w_sm_t9powerburst.mdl",
				dt = {
					eclass = "mwb_aug"
				},
				att_saved = {
					{
						["Slot"] = 1,
						["m_Index"] = "att_ammo",
					},
					{
						["Slot"] = 2,
						["m_Index"] = "att_grip",
					},
					{
						["Slot"] = 3,
						["m_Index"] = "attachment_vm_sm_augolf_arbarrel",
					},
					{
						["Slot"] = 4,
						["m_Index"] = "att_muzzle",
					},
					{
						["Slot"] = 5,
						["m_Index"] = "attachment_vm_sm_augolf_lmgrail",
					}
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		name = "10000$",
		icon = Material("gmodla/f4/stuff/fourmoney.png", "smooth"),
		dec = "Денежное вознаграждение за очки прогресса",
		premium = true,
		cost = 500,
		give_func = function(ply)
			ply:addMoney(10000)
		end,
	},
	{
		name = "Мачете x2",
		icon = Material("gmodla/icons/machete.png", "smooth"),
		dec = "Предмет можно использовать для ближнего боя; после разблокировки он автоматически попадёт в ваше хранилище",
		premium = true,
		cost = 500,
		give_func = function(ply)
			local item = {
				class = "mlw_machete",
				model = "models/weapons/tfa_nmrih/w_me_machete.mdl",
				dt = {
					eclass = "mlw_machete"
				},
			}

			ply:AddBankItem(INV_WEAPON, item)
			ply:AddBankItem(INV_WEAPON, item)
		end,
	},
	{
		name = "Авиаторы",
		dec = "Предмет можно надеть; этот предмет всегда доступен для использования во вкладке внешний вид меню F4",
		icon = Material("gmodla/icons/glasses01.png", "smooth"),
		premium = true,
		cost = 5000,
		give_func = function(ply)
			MQS.SetNWStoredData(ply, "episode_1_glasses01", true)
		end,
	},
	{
		name = "2500$",
		icon = Material("gmodla/f4/stuff/onemoney.png", "smooth"),
		premium = true,
		oncomplete = true,
		dec = "Денежное вознаграждение за очки прогресса",
		cost = 250,
		give_func = function(ply)
			ply:addMoney(2500)
		end,
	},
}

local function Key(episode, name)
	return "episode_" .. episode .. "_" .. name
end

function Glac.AddEpisodePoints(ply, points, episode)
	episode = episode or 1
	local ep = Glac.Episodes[episode]
	if not ep then return end

	if MQS.GetDataStored(ply, Key(episode, "premium")) then
		points = points * (ep.PremiumMultiplier or 1)
	end

	local tokens = MQS.GetDataStored(ply, Key(episode, "tokens")) or 0
	MQS.SetNWStoredData(ply, Key(episode, "tokens"), tokens + points)
end

Glac.RegisterConfig("episodes", function()
	Glac.AddItem("episode_1_premium", {
		Name = "Премиум пропуск - Эпизод первый",
		icon = Material("gmodla/f4/stuff/pass.png", "smooth"),
		desc = "",
		details = "",
		Category = "Other",
		Price = 1000,
		check = Glac.Once("episode_1_premium"),
		OnPurFunction = function(ply)
			MQS.SetNWStoredData(ply, "episode_1_premium", true)
		end,
	})
end)

if CLIENT then return end

Glac.NetReceive("BuyReward", function(ply)
	if DarkRP.SpamBlock(ply, 1) then return end

	local episode = net.ReadUInt(8)
	local index = net.ReadUInt(8)
	local ep = Glac.Episodes[episode]
	local reward = ep and ep.Rewards[index]
	if not reward then return end

	local unlocks = MQS.GetDataStored(ply, Key(episode, "unlocks")) or {}
	local premium = MQS.GetDataStored(ply, Key(episode, "premium"))
	local tokens = MQS.GetDataStored(ply, Key(episode, "tokens")) or 0

	if unlocks[index] then return end
	if reward.premium and not premium then return end

	if reward.cost > tokens then
		Glac.SendFail(ply)
		return
	end

	if reward.oncomplete then
		if table.Count(unlocks) < #ep.Rewards - 1 then return end
	else
		unlocks[index] = true
		MQS.SetNWStoredData(ply, Key(episode, "unlocks"), unlocks)
	end

	MQS.SetNWStoredData(ply, Key(episode, "tokens"), tokens - reward.cost)
	reward.give_func(ply)

	Glac.NetStart("Result")
	net.WriteUInt(Glac.RESULT_REWARD, 2)
	net.WriteUInt(episode, 8)
	net.WriteUInt(index, 8)
	net.WriteInt(50, 10)
	net.Send(ply)
end)
