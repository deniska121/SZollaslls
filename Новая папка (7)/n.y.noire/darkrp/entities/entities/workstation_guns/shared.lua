--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_guns/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "workstation_base"
ENT.PrintName = "Стол оружейника"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.GunTable = true
ENT.TeamLimit = "Оружейный мастер"
ENT.XPTable = "guns"
ENT.SortBy = "order"
ENT.BluePrints = {}

ENT.SameClasses = {
	["mwb_m4a1"] = {
		["mwb_m4"] = true,
	},
	["mwb_m4"] = {
		["mwb_m4a1"] = true,
	},
}

local prints = {
	["ak74"] = {
		name = "AK74",
		time = 90,
		price = 48,
		xp = true,
		requiredbp = "akm",
		fcg = {4, "attachment_vm_ar_akilo47_bolt"},
		category = "АК74 (5.45x39)",
		subcategory = "Винтовки",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_ak74",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_akilo47_stock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_akilo47"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_bolt"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_ar_akilo47_receiver_v6"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_vm_muzzlebrake_ak74"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ak",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 1,
			},
		}
	},
	["ak74s"] = {
		name = "AKС74 | Складной приклад",
		time = 48,
		price = 250,
		requiredbp = "ak74",
		xp = true,
		fcg = {4, "attachment_vm_ar_akilo47_bolt"},
		category = "АК74 (5.45x39)",
		subcategory = "Винтовки",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_ak74",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_akilo47_smgstock_unfolded"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_akilo74"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_bolt"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_ar_akilo47_receiver_v6"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_vm_muzzlebrake_ak74"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ak",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 1,
			},
		}
	},
	["rpk74"] = {
		name = "РПК-74",
		requiredbp = "rpk",
		time = 120,
		price = 42,
		skipdisas = true,
		xp = true,
		fcg = {4, "attachment_vm_ar_akilo47_bolt"},
		category = "АК74 (5.45x39)",
		subcategory = "Винтовки",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_ak74",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_akilo47_lmgstock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_akilo47_lmgbarrel"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_bolt"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_ar_akilo47_receiver_v6"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_vm_muzzlebrake_ak74"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ak",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 4,
			},
		}
	},
	["akm"] = {
		name = "АКМ",
		time = 90,
		price = 42,
		xp = true,
		fcg = {4, "attachment_vm_ar_akilo47_bolt"},
		category = "АКM (7.62x39)",
		subcategory = "Винтовки",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_akm",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_akilo47_stock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_akilo47_barrel"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_bolt"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_ar_akilo47_receiver_v2"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ak",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 1,
			},
		}
	},
	["akms"] = {
		name = "АКМ | Складной приклад",
		time = 90,
		price = 48,
		requiredbp = "akm",
		xp = true,
		fcg = {4, "attachment_vm_ar_akilo47_bolt"},
		category = "АКM (7.62x39)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_akm",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_akilo47_smgstock_unfolded"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_akilo47_barrel"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_bolt"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_ar_akilo47_receiver_v2"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ak",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 1,
			},
		}
	},
	["rpk"] = {
		name = "РПК",
		time = 120,
		price = 42,
		requiredbp = "akm",
		skipdisas = true,
		xp = true,
		fcg = {4, "attachment_vm_ar_akilo47_bolt"},
		category = "АКM (7.62x39)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_akm",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_akilo47_lmgstock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_akilo47_lmgbarrel"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_bolt"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_ar_akilo47_receiver_v2"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ak",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 4,
			},
		}
	},
	["aks74u"] = {
		name = "АКС74У",
		time = 120,
		price = 248,
		xp = true,
		fcg = {4, "attachment_vm_ar_akilo47_bolt"},
		category = "АК74 (5.45x39)",
		requiredbp = "ak74s",
		order = "a3",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_ak74u",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_akilo47_smgstock_unfolded"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_akilo47_smgbarrel"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_bolt"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_ar_akilo47_receiver_v21"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ak",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 1,
			},
		}
	},
	["aug1"] = {
		name = "AUG A1",
		time = 120,
		price = 250,
		xp = true,
		category = "AUG (5.56x45)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_aug",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sm_augolf_arbarrel"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_sm_augolf_lmgrail"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_aug",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["aug2"] = {
		name = "AUG A2",
		time = 120,
		price = 250,
		requiredbp = "aug1",
		xp = true,
		category = "AUG (5.56x45)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_auga2",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sm_augolf_arbarrel"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_sight"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_aug",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 1,
			},
		}
	},
	["ar1"] = {
		name = "Colt Model 723",
		time = 100,
		price = 50,
		xp = true,
		requiredbp = "ar3",
		fcg = {10, "attachment_vm_ar_mike4_bolt"},
		category = "AR-15 (5.56x45)",
		order = "a3",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m4",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_mike4_barrel_def"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_mike4_stock_def"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_ar_mike4_receiver_black"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 10,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m4",
				count = 3,
			},
		}
	},
	["ar2"] = {
		name = "Colt AR-15 Sporter-1",
		time = 100,
		xp = true,
		fcg = {10, "attachment_vm_ar_mike4_bolt"},
		category = "AR-15 (5.56x45)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m4",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_mike4_barrel"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_mike4_customstock"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_ar_mike4_receiver_def"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 10,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m4",
				count = 3,
			},
		}
	},
	["ar3"] = {
		name = "Colt AR-15 Sporter-2",
		time = 100,
		price = 50,
		xp = true,
		requiredbp = "ar2",
		fcg = {10, "attachment_vm_ar_mike4_bolt"},
		category = "AR-15 (5.56x45)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m4",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_mike4_barsil"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_mike4_customstock"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_ar_mike4_receiver_black"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 10,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m4",
				count = 3,
			},
		}
	},
	["ar4"] = {
		name = "CAR-15",
		time = 100,
		price = 220,
		xp = true,
		fcg = {10, "attachment_vm_ar_mike4_bolt"},
		requiredbp = "ar2",
		category = "AR-15 (5.56x45)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m4",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_mike4_barrel_v3_alt"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_mike4_stock_def"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_ar_mike4_receiver_def"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 10,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m4",
				count = 3,
			},
		}
	},
	["ar5"] = {
		name = "Colt AR-15 Sporter-4",
		time = 110,
		price = 50,
		xp = true,
		requiredbp = "ar6",
		fcg = {10, "attachment_vm_ar_mike4_bolt"},
		category = "AR-15 (5.56x45)",
		order = "a6",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m4a1",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_mike4_custombarrel"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_mike4_customstock"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_ar_mike4_receiver"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 10,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m4",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount_ext",
				count = 5,
			},
		}
	},
	["ar6"] = {
		name = "Colt M4 Sporter Carbine",
		time = 110,
		price = 220,
		xp = true,
		requiredbp = "ar1",
		fcg = {10, "attachment_vm_ar_mike4_bolt"},
		category = "AR-15 (5.56x45)",
		order = "a4",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m4a1",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_mike4_barrel_v2"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_mike4_stock"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_ar_mike4_receiver"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 10,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m4",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount_ext",
				count = 4,
			},
		}
	},
	["ar7"] = {
		name = "Mk 18 Mod 0",
		time = 110,
		price = 220,
		xp = true,
		requiredbp = "ar4",
		fcg = {10, "attachment_vm_ar_mike4_bolt"},
		category = "AR-15 (5.56x45)",
		order = "a5",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m4a1",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_mike4_shortbarrel"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_mike4_stock_def"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_ar_mike4_receiver"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 10,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m4",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount_ext",
				count = 3,
			},
		}
	},
	["scar"] = {
		name = "FN SCAR 17",
		time = 120,
		price = 100,
		skipdisas = true,
		xp = true,
		fcg = {9, "attachment_vm_ar_akilo47_bolt"},
		category = "FN SCAR (7.62x51)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mk17",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_scharlie_barrel"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_scharlie_stock"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_scar",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 4,
			},
		}
	},
	["scar2"] = {
		name = "FN SCAR SC",
		time = 120,
		requiredbp = "scar",
		price = 100,
		xp = true,
		fcg = {9, "attachment_vm_ar_akilo47_bolt"},
		category = "FN SCAR (7.62x51)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mk17",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_scharlie_barrel_pdw"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_scharlie_stock_light"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_scar",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 3,
			},
		}
	},
	["scar3"] = {
		name = "FN SSR",
		time = 120,
		price = 300,
		skipdisas = true,
		requiredbp = "scar",
		xp = true,
		fcg = {9, "attachment_vm_ar_akilo47_bolt"},
		category = "FN SCAR (7.62x51)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mk17",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_ar_scharlie_barrel_long"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_ar_scharlie_stock_dmr"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "att_grip"
						},
						{
							["Slot"] = 9,
							["m_Index"] = "att_bolt"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_scar",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 5,
			},
		}
	},
	["marlin"] = {
		name = "Marlin Model 1895 SBL",
		time = 70,
		price = 200,
		xp = true,
		category = "Marlin Model 1895 (.357)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_marlin",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_stock"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sn_sbeta_barrel"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_sight"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_marlin",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 1,
			},
		}
	},
	["marlin2"] = {
		name = "Marlin Model 1895 | 457мм",
		time = 70,
		requiredbp = "marlin",
		price = 270,
		skipdisas = true,
		xp = true,
		category = "Marlin Model 1895 (.357)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_marlin",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_stock"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sn_sbeta_barshort"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_sight"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_marlin",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 1,
			},
		}
	},
	["marlin3"] = {
		name = "Marlin Model 1895 | 508мм",
		time = 70,
		price = 290,
		requiredbp = "marlin",
		skipdisas = true,
		xp = true,
		category = "Marlin Model 1895 (.357)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_marlin",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_stock"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sn_sbeta_barmid"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_laser"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_marlin",
				count = 4,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 1,
			},
		}
	},
	["marlin4"] = {
		name = "Marlin Model 1895 | 610мм",
		time = 70,
		requiredbp = "marlin",
		skipdisas = true,
		price = 300,
		xp = true,
		category = "Marlin Model 1895 (.357)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_marlin",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_stock"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sn_sbeta_barlong"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_laser"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_marlin",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "rail_mount",
				count = 1,
			},
		}
	},
	["kar"] = {
		name = "Mauser 98k",
		time = 150,
		price = 200,
		xp = true,
		category = "Mauser 98k (7.92x57)",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_kar98",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_kar",
				count = 3,
			},
		}
	},
	["spas12"] = {
		name = "SPAS-12 | Без приклада",
		time = 90,
		requiredbp = "spas13",
		xp = true,
		category = "SPAS-12 (Картечь)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_spapa12",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo_default"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_sh_t9semiauto_ammo"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_sh_t9semiauto_barrel_pump"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_sh_t9semiauto_nostock"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "attachment_sh_t9semiauto_barrel"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_spas",
				count = 3,
			},
		}
	},
	["spas13"] = {
		name = "SPAS-12 | Пластиковый приклад",
		time = 90,
		xp = true,
		category = "SPAS-12 (Картечь)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_spapa12",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo_default"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_sh_t9semiauto_ammo"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_sh_t9semiauto_barrel_pump"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_sh_t9semiauto_stalkerstock01"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "attachment_sh_t9semiauto_barrel"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_spas",
				count = 3,
			},
		}
	},
	["spas14"] = {
		name = "SPAS-12 | Складной приклад",
		time = 90,
		requiredbp = "spas12",
		xp = true,
		category = "SPAS-12 (Картечь)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_spapa12",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo_default"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_sh_t9semiauto_ammo"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_sh_t9semiauto_barrel_pump"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_sh_t9semiauto_stock"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 8,
							["m_Index"] = "attachment_sh_t9semiauto_barrel"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_spas",
				count = 3,
			},
		}
	},
	["bc725"] = {
		name = "Browning Citori 725",
		time = 60,
		category = "Browning Citori 725 (Картечь)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_c725",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "attachment_vm_sh_charlie725_barrel"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sh_charlie725_guard"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sh_charlie725_stock"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_b725",
				count = 2,
			},
		}
	},
	["bc727"] = {
		name = "Browning Citori 725 | Длинный ствол",
		time = 70,
		price = 50,
		xp = true,
		category = "Browning Citori 725 (Картечь)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_c725",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "attachment_vm_sh_charlie725_barrel_long"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sh_charlie725_guard"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sh_charlie725_stocktactical"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_b725",
				count = 2,
			},
		}
	},
	["bc726"] = {
		name = "Browning Citori 725 | Обрез",
		time = 60,
		xp = true,
		category = "Browning Citori 725 (Картечь)",
		order = "a1",
		componets = {
			{
				type = INV_WEAPON,
				class = "mwb_c725",
				change = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "attachment_vm_sh_charlie725_barrel_sawnoff"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sh_charlie725_guard"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sh_charlie725_stock_sawnoff"
						},
					}
				},
				check = function(e) return e.att_saved and e.att_saved[1] and e.att_saved[1]["m_Index"] ~= "attachment_vm_sh_charlie725_barrel_sawnoff" end,
				count = 1,
			},
		}
	},
	["mac10"] = {
		name = "MAC-10",
		time = 75,
		price = 60,
		xp = true,
		category = "MAC-10 (.45 ACP)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mac10",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "mac10_stock_mac10"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_grip_mac10"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_barrel_mac10"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "attachment_vm_sn_mac10_0"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_mac",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["mac11"] = {
		name = "MAC-10 | Радиаторный ствол",
		time = 75,
		price = 60,
		xp = true,
		skipdisas = true,
		category = "MAC-10 (.45 ACP)",
		requiredbp = "mac10",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mac10",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "mac10_stock_mac10"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_grip_mac10"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "mac_grip_mac10"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "attachment_vm_sn_mac10_0"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_mac",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["mp1"] = {
		name = "MP5A2",
		time = 90,
		xp = true,
		category = "MP5 (9x19mm)",
		fcg = {3, "attachment_vm_sm_mpapa5_receiver_v2"},
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mp5",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sm_mpapa5_stock_fullstock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sm_mpapa5_receiver"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_sm_mpapa5_barrel"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_mp5",
				count = 3,
			},
		}
	},
	["mp2"] = {
		name = "MP5A3 | Складываемый приклад",
		time = 90,
		requiredbp = "mp1",
		xp = true,
		category = "MP5 (9x19mm)",
		fcg = {3, "attachment_vm_sm_mpapa5_receiver_v2"},
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mp5",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sm_mpapa5_stock_nostock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sm_mpapa5_receiver"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_sm_mpapa5_barrel"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_mp5",
				count = 3,
			},
		}
	},
	["mp3"] = {
		name = "MP5SD2",
		requiredbp = "mp1",
		time = 90,
		price = 150,
		skipdisas = true,
		xp = true,
		category = "MP5 (9x19mm)",
		fcg = {3, "attachment_vm_sm_mpapa5_receiver_v2"},
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mp5",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sm_mpapa5_stock_fullstock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sm_mpapa5_receiver"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_sm_mpapa5_barrel_suppressor"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_mp5",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "att_vm_silencer01",
				count = 1,
			},
		}
	},
	["mp4"] = {
		name = "MP5SD3",
		requiredbp = "mp2",
		time = 90,
		xp = true,
		skipdisas = true,
		category = "MP5 (9x19mm)",
		fcg = {3, "attachment_vm_sm_mpapa5_receiver_v2"},
		order = "a3",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_mp5",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sm_mpapa5_stock_nostock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_sm_mpapa5_receiver"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "attachment_vm_sm_mpapa5_barrel_suppressor"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_mp5",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "att_vm_silencer01",
				count = 1,
			},
		}
	},
	["uzi"] = {
		name = "UZI | Складываемый приклад",
		time = 75,
		xp = true,
		category = "UZI (9x19mm)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_uzi",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sm_uzulu_stock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_sm_uzulu_barrel"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "attachment_vm_sm_uzulu_receiver"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_uzi",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["uzi2"] = {
		name = "UZI | Классический",
		time = 75,
		xp = true,
		skipdisas = true,
		category = "UZI (9x19mm)",
		requiredbp = "uzi",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_uzi",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_sm_uzulu_stockh"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "norail"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_sm_uzulu_barlong"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 7,
							["m_Index"] = "attachment_vm_sm_uzulu_receiver"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_uzi",
				count = 3,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["ithaca"] = {
		name = "Ithaca 37",
		time = 80,
		xp = true,
		category = "Ithaca 37 (Картечь)",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_ithaca",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_ithaca",
				count = 3,
			},
		}
	},
	["thompson"] = {
		name = "M1 Thompson",
		time = 130,
		xp = true,
		category = "Thompson (.45 ACP)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_thompson",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_thompson",
				count = 3,
			},
		}
	},
	["tec"] = {
		name = "Tec-9",
		time = 90,
		xp = true,
		category = "Tec-9 (9x19mm)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_tec9",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_bolt"
						}
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_tec",
				count = 2,
			},
		}
	},
	["tec2"] = {
		name = "Tec-9 | Автоматический",
		time = 13,
		price = 5,
		requiredbp = "tec",
		xp = true,
		category = "Tec-9 (9x19mm)",
		order = "a1",
		componets = {
			{
				type = INV_WEAPON,
				class = "mwb_tec9",
				change = {att_saved = function(item)
					item.att_saved[2]["m_Index"] = "attachment_vm_pi_tec9_bolt"
					return item.att_saved
				end},
				check = function(e) return e.att_saved and e.att_saved[2] and e.att_saved[2]["m_Index"] == "att_bolt" end,
				count = 1,
			},
		}
	},
	["m1911"] = {
		name = "Colt M1911",
		time = 50,
		xp = true,
		category = "Colt M1911",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m1911",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m1911",
				count = 2,
			},
		}
	},
	["p220"] = {
		name = "P220",
		time = 50,
		xp = true,
		category = "P220",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_p220",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_p220",
				count = 2,
			},
		}
	},
	["pm"] = {
		name = "ПМ",
		time = 40,
		xp = true,
		category = "ПМ (9x18mm)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_pm",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_stock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_pi_mike_grip"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_pi_mike_barrel"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_pm",
				count = 2,
			},
		}
	},
	["pb"] = {
		name = "ПБ",
		time = 40,
		requiredbp = "pm",
		skipdisas = true,
		xp = true,
		category = "ПМ (9x18mm)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_pm",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_stock"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_pi_mike_grip"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_pi_mike_barsil"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_pm",
				count = 3,
			},
		}
	},
	["aps"] = {
		name = "АПС",
		time = 40,
		requiredbp = "pm",
		skipdisas = true,
		xp = true,
		category = "ПМ (9x18mm)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_pm",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_pi_mike_stockl"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_pi_mike_grip"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_pi_mike_barauto"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_pm",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["glock21"] = {
		name = "Glock 21",
		time = 80,
		price = 50,
		xp = true,
		category = "Glock (.45 ACP)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_glock21",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_vm_pi_golf21_receiver_v1"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_laser"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_glock",
				count = 2,
			},
		}
	},
	["glock41"] = {
		name = "Glock 41",
		requiredbp = "glock21",
		time = 100,
		price = 70,
		xp = true,
		category = "Glock (.45 ACP)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_glock21",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_vm_pi_golf21_slide_long"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_laser"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_glock",
				count = 2,
			},
		}
	},
	["glock17"] = {
		name = "Glock 17",
		time = 40,
		category = "Glock (9x19mm)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_glock17",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_vm_pi_romeo18_slide"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_vm_pi_golf17def"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_miscellaneous"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_muzzle"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_glock",
				count = 2,
			},
		}
	},
	["glock19"] = {
		name = "Glock 19",
		time = 40,
		xp = true,
		category = "Glock (9x19mm)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_glock19",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_vm_pi_golf18_slide_light"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_vm_pi_golf18def"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_miscellaneous"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_muzzle"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_glock",
				count = 2,
			},
		}
	},
	["glock18"] = {
		name = "Glock 18c",
		requiredbp = "glock19",
		time = 120,
		skipdisas = true,
		xp = true,
		category = "Glock (9x19mm)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_glock19",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_vm_pi_golf18_slide"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_laser"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "att_vm_pi_golf18def"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_miscellaneous"
						},
						{
							["Slot"] = 6,
							["m_Index"] = "att_muzzle"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_glock",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["Deagle"] = {
		name = "Deagle",
		time = 75,
		price = 100,
		xp = true,
		category = "Desert Eagle (.50 AE)",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_deagle",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_deagle",
				count = 2,
			},
		}
	},
	["revolver1"] = {
		name = "Colt King Cobra .357",
		time = 60,
		price = 40,
		category = "Colt King Cobra (.357)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_357",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "attachment_vm_pi_cpapa_mag"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_vm_pi_cpapa_barrel01"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_magnum",
				count = 2,
			},
		}
	},
	["revolver2"] = {
		name = "Colt King Cobra .357 | Короткий ствол",
		time = 20,
		price = 100,
		xp = true,
		category = "Colt King Cobra (.357)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_357",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "attachment_vm_pi_cpapa_mag"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_vm_pi_cpapa_barrel_short"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_magnum",
				count = 2,
			},
		}
	},
	["revolver3"] = {
		name = "Colt King Cobra .357 | Длинный ствол",
		time = 60,
		price = 60,
		xp = true,
		category = "Colt King Cobra (.357)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_357",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "attachment_vm_pi_cpapa_mag"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "att_sight"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "att_vm_pi_cpapa_barrel_long"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_magnum",
				count = 2,
			},
		}
	},
	["m9"] = {
		name = "Beretta M9",
		time = 70,
		price = 20,
		xp = true,
		category = "Beretta M9 (9x19mm)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m9",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_pi_mike9_receiver_v2"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_pi_mike9_pgrip"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_pi_mike9_barrel"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_beretta",
				count = 2,
			},
		}
	},
	["93r"] = {
		name = "Beretta 93R",
		time = 80,
		price = 40,
		xp = true,
		requiredbp = "m9",
		category = "Beretta M9 (9x19mm)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_93r",
				count = 1,
				extras = {
					att_saved = {
						{
							["Slot"] = 1,
							["m_Index"] = "att_ammo"
						},
						{
							["Slot"] = 2,
							["m_Index"] = "attachment_vm_pi_mike9_receiver_diamatti"
						},
						{
							["Slot"] = 3,
							["m_Index"] = "attachment_vm_pi_mike9_pstlgrpcust_diamatti"
						},
						{
							["Slot"] = 4,
							["m_Index"] = "attachment_vm_pi_mike9_barauto_diamatti"
						},
						{
							["Slot"] = 5,
							["m_Index"] = "att_muzzle"
						},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_beretta",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		}
	},
	["moss1"] = {
		name = "Mossberg 590",
		time = 100,
		xp = true,
		category = "Mossberg 590 (Картечь)",
		order = "a0",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m590",
				count = 1,
				extras = {
					att_saved = {
						{["Slot"] = 1, ["m_Index"] = "590_eft_pump_590def"},
						{["Slot"] = 2, ["m_Index"] = "590_eft_pump_receiver"},
						{["Slot"] = 3, ["m_Index"] = "590_eft_barrel"},
						{["Slot"] = 4, ["m_Index"] = "magpul_sga_stock"},
						{["Slot"] = 5, ["m_Index"] = "590_base"},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m590",
				count = 3,
			},
		}
	},
	["moss2"] = {
		name = "Mossberg 590 | Длинный ствол",
		time = 100,
		requiredbp = "moss1",
		xp = true,
		category = "Mossberg 590 (Картечь)",
		order = "a1",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m590",
				count = 1,
				extras = {
					att_saved = {
						{["Slot"] = 1, ["m_Index"] = "pump_wood_2"},
						{["Slot"] = 2, ["m_Index"] = "590_eft_pump_receiver"},
						{["Slot"] = 3, ["m_Index"] = "590_mwii_barrel_v1"},
						{["Slot"] = 4, ["m_Index"] = "m500_stock"},
						{["Slot"] = 5, ["m_Index"] = "590_base_iro"},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m590",
				count = 4,
			},
		}
	},
	["moss3"] = {
		name = "Mossberg 500",
		time = 100,
		requiredbp = "moss1",
		xp = true,
		category = "Mossberg 590 (Картечь)",
		order = "a2",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m590",
				count = 1,
				extras = {
					att_saved = {
						{["Slot"] = 1, ["m_Index"] = "590_eft_pump_590_wood"},
						{["Slot"] = 2, ["m_Index"] = "590_eft_pump_receiver"},
						{["Slot"] = 3, ["m_Index"] = "590_eft_barrel_1897"},
						{["Slot"] = 4, ["m_Index"] = "m500_stock"},
						{["Slot"] = 5, ["m_Index"] = "590_base"},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m590",
				count = 3,
			},
		}
	},
	["moss4"] = {
		name = "Mossberg 590 Compact Cruiser",
		time = 100,
		requiredbp = "moss1",
		xp = true,
		category = "Mossberg 590 (Картечь)",
		order = "a3",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m590",
				count = 1,
				extras = {
					att_saved = {
						{["Slot"] = 1, ["m_Index"] = "590_eft_pump_870def"},
						{["Slot"] = 2, ["m_Index"] = "590_eft_pump_receiver"},
						{["Slot"] = 3, ["m_Index"] = "590_eft_barrel_v1"},
						{["Slot"] = 4, ["m_Index"] = "mwii_590_no_stock"},
						{["Slot"] = 5, ["m_Index"] = "590_base"},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m590",
				count = 3,
			},
		}
	},
	["moss5"] = {
		name = "Mossberg 590 Riot",
		time = 100,
		requiredbp = "moss4",
		xp = true,
		category = "Mossberg 590 (Картечь)",
		order = "a4",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m590",
				count = 1,
				extras = {
					att_saved = {
						{["Slot"] = 1, ["m_Index"] = "590_eft_pump_870def"},
						{["Slot"] = 2, ["m_Index"] = "590_eft_pump_receiver"},
						{["Slot"] = 3, ["m_Index"] = "590_mwii_barrel_v2"},
						{["Slot"] = 4, ["m_Index"] = "magpul_sga_stock"},
						{["Slot"] = 5, ["m_Index"] = "590_base"},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m590",
				count = 3,
			},
		}
	},
	["moss6"] = {
		name = "Mossberg 590 Sporter",
		time = 100,
		xp = true,
		category = "Mossberg 590 (Картечь)",
		order = "a5",
		products = {
			{
				type = INV_WEAPON,
				class = "mwb_m590",
				count = 1,
				extras = {
					att_saved = {
						{["Slot"] = 1, ["m_Index"] = "590_eft_pump_870def"},
						{["Slot"] = 2, ["m_Index"] = "590_eft_pump_receiver"},
						{["Slot"] = 3, ["m_Index"] = "590_eft_barrel_v4"},
						{["Slot"] = 4, ["m_Index"] = "magpul_sga_stock"},
						{["Slot"] = 5, ["m_Index"] = "590_base_iro"},
					}
				}
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "parts_m590",
				count = 3,
			},
		}
	},
}

local ammo = {
	["buckshot"] = {
		name = "Патроны 12 кал. 20 шт",
		time = 50,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "buckshot",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "buckshot_row",
				count = 20,
			},
			{
				type = INV_JUNK,
				class = "cases_buckshot",
				count = 20,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box357"] = {
		name = "Патроны .357 Mag 20шт",
		time = 60,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box357",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "bullets357",
				count = 20,
			},
			{
				type = INV_JUNK,
				class = "cases357",
				count = 20,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box918"] = {
		name = "Патроны 9x18mm 50шт",
		time = 120,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box918",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets9",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases9",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box919"] = {
		name = "Патроны 9x19mm 50шт",
		time = 50,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box919",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets9",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases9",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box10"] = {
		name = "Патроны 10mm AUTO 50шт",
		time = 50,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box10",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets10",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases10",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box45"] = {
		name = "Патроны .45 ACP 50шт",
		time = 50,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box45",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets45",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases45",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box50"] = {
		name = "Патроны .50 AE 20шт",
		time = 80,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box50",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 2,
			},
			{
				type = INV_JUNK,
				class = "bullets50",
				count = 20,
			},
			{
				type = INV_JUNK,
				class = "cases50",
				count = 20,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box545"] = {
		name = "Патроны 5.45x39 50шт",
		time = 180,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box545",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets545",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases545",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box556"] = {
		name = "Патроны 5.56x45 50шт",
		time = 120,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box556",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets556",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases556",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box762"] = {
		name = "Патроны 7.62x39 50шт",
		time = 180,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box762",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets762",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases762",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
	["box308"] = {
		name = "Патроны .308 Win 50шт",
		time = 180,
		category = "Патроны",
		products = {
			{
				type = INV_AMMO,
				class = "box308",
				count = 1,
			},
		},
		componets = {
			{
				type = INV_JUNK,
				class = "gunpowder",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "box_primer",
				count = 5,
			},
			{
				type = INV_JUNK,
				class = "bullets308",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "cases308",
				count = 50,
			},
			{
				type = INV_JUNK,
				class = "reloadingpress",
				count = 1,
				dont_use = true
			},
		}
	},
}

local repairs = {}
local disble = {}
local fcg = {}

GunNamesGlobal = {}

for k, v in pairs(ammo) do
	v.sound = "gb_sfx/craft/mechanical.wav"
end

local function CreateRepairs(k,v)
	if not v.products then return end

	local prod = table.Copy(v.products)

	local class = prod[1].class

	if GunNamesGlobal[class] then
		GunNamesGlobal[class][v.name] = true
	else
		GunNamesGlobal[class] = {}
		GunNamesGlobal[class][v.name] = true
	end

	if repairs[class .. "maints"] then
		return
	end

	prod[1].change = {
		gunstate = 1
	}

	prod[1].check = function(e) if not e.gunstate then return end return e.gunstate <= 0.9 and e.gunstate >= 0.2 end
	table.Add(prod, table.Copy(v.componets))

	local wp = DarkRP.Weapons[class]

	repairs[class .. "maints"] = {
		name = "Обслуживание \"" .. (wp and wp.name or v.name) .. "\"",
		time = 20,
		category = "Обслуживание",
		sound = "gb_sfx/craft/gun_cleaning.wav",
		componets = {
			prod[1],
			{
				type = INV_JUNK,
				class = "acetone",
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "parts_all",
				count = 1,
			},
		}
	}
end

local function CreateDisas(k,v)
	local prod = table.Copy(v.products)
	local comp = table.Copy(v.componets)

	if v.skipdisas then return end

	if not prod or not prod[1] then return end

	local class = prod[1].class

	if disble[class .. "disble"] then
		return
	end

	local wp = DarkRP.Weapons[class]

	local reuse = {}

	for a,b in pairs(comp) do
		if not string.StartsWith(b.class, "parts_") and b.class ~= "rail_mount" then continue end
		b.extras = {
			model = "models/cityrp/box5.mdl",
			material = "gbskins/box_blank",
			weight = 0.4,
			dt = {
				uses = 1,
				eclass = b.class
			}
		}
		table.insert(reuse, b)
	end

	prod[1].check = function(e) return e.gunstate and e.gunstate <= 0.2 end

	disble[class .. "disble"] = {
		name = "Разборка \"" .. (wp and wp.name or v.name) .. "\"",
		time = v.time / 2,
		category = "Разборка сломанного оружия",
		sound = "gb_sfx/craft/mechanical_2.wav",
		componets = prod,
		products = reuse
	}
end

local function CreateFCG(k,v)
	if not v.fcg then return end

	local prod = table.Copy(v.products)

	if not prod or not prod[1] then return end
	local wpn = prod[1]

	local class = wpn.class

	if fcg[class .. "fcg"] then
		return
	end

	local wp = DarkRP.Weapons[class]
	--att_m16_bolt attachment_vm_ar_mike16_bolt
	fcg[class .. "fcg"] = {
		name = "Установка УСМ на \"" .. (wp and wp.name or v.name) .. "\"",
		time = v.time / 2,
		category = "Замена УСМ",
		sound = "gb_sfx/craft/mechanical_2.wav",
		componets = {
			{
				type = INV_WEAPON,
				class = class,
				change = {att_saved = function(item)
					item.att_saved[v.fcg[1]]["m_Index"] = v.fcg[2]
					return item.att_saved
				end},
				check = function(e) return e.att_saved and e.att_saved[v.fcg[1]] and e.att_saved[v.fcg[1]]["m_Index"] ~= v.fcg[2] and e.gunstate and e.gunstate > 0.2 end,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "att_ar_bolt",
				count = 1,
			},
		},
	}

	if v.fcg[2] ~= "attachment_vm_ar_mike4_bolt" then return end

	fcg[class .. "m15fcg"] = {
		name = "Установка особого УСМ на \"" .. (wp and wp.name or v.name) .. "\"",
		time = v.time / 2,
		category = "Замена УСМ",
		sound = "gb_sfx/craft/mechanical_2.wav",
		componets = {
			{
				type = INV_WEAPON,
				class = class,
				change = {att_saved = function(item)
					item.att_saved[v.fcg[1]]["m_Index"] = "attachment_vm_ar_mike16_bolt"
					return item.att_saved
				end},
				check = function(e) return e.att_saved and e.att_saved[v.fcg[1]] and e.att_saved[v.fcg[1]]["m_Index"] ~= "attachment_vm_ar_mike16_bolt" and e.gunstate and e.gunstate > 0.2 end,
				count = 1,
			},
			{
				type = INV_JUNK,
				class = "att_m16_bolt",
				count = 1,
			},
		},
	}
end

for k, v in pairs(prints) do
	CreateRepairs(k,v)
	CreateDisas(k,v)
	CreateFCG(k,v)
	v.sound = "gb_sfx/craft/metal_grinding.wav"
	v.register = true
end

table.Merge(ENT.BluePrints, prints)
table.Merge(ENT.BluePrints, repairs)
table.Merge(ENT.BluePrints, disble)
table.Merge(ENT.BluePrints, ammo)
table.Merge(ENT.BluePrints, fcg)