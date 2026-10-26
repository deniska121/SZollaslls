--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/character/sh_cosmetics.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MCR.NoConsume = {
	["gasmask"] = true,
	["weldingmask"] = true,
}

MCR.Attachments = {}

MCR.Attachments.smoking = {
	["cigar"] = {
		model = "models/mordeciga/mordes/oldcigshib.mdl",
		pos = Vector(0.8, 0.5, 0),
		ang = Angle(-10, 0, 0),
		pms = {
			["female_01"] = {Vector(0.8, 0.5, -0.2)},
			["male_02"] = {Vector(0.2, 0.5, 0)},
			["male_03"] = {Vector(0.3, 0.5, 0.1)},
			["male_04"] = {Vector(0.3, 0.5, .4)},
			["male_05"] = {Vector(-0.1, 0.5, .1)},
			["male_06"] = {Vector(0.9, 0.5, .1)},
			["male_07"] = {Vector(0.5, 0.5, -.15)},
			["male_08"] = {Vector(0, 1, -.15)},
		}
	},
	["sigar"] = {
		model = "models/env/decor/ashtray/sigar01.mdl",
		pos = Vector(2.9, 2.5, 0.4),
		ang = Angle(60, 0, 0),
		pms = {
			["male_04"] = {Vector(2.9, 2.5, 0.6)},
			["male_06"] = {Vector(2.9, 2.5, 0.4)},
		}
	},
	["joint"] = {
		model = "models/joint/joint.mdl",
		pos = Vector(-1.1, 0, 0.2),
		ang = Angle(-120, 0, 0),
		scale = Vector(0.5, 0.5, 0.5),
		pms = {
			["male_04"] = {Vector(-1.1, 0, 0.4)},
			["male_07"] = {Vector(-1.4, 0, -0.1)},
			["male_08"] = {Vector(-1.8, 0, -0.1)},
		}
	},
	["pipe"] = {
		model = "models/crackpipe/hollowpipe.mdl",
		pos = Vector(1.9, 0, 0.1),
		ang = Angle(0, 0, 0),
		scale = Vector(0.5, 0.5, 0.5),
		pms = {
			["male_04"] = {Vector(1.9, 0, 0.5)},
			["male_05"] = {Vector(1.9, 0, 0.1)},
			["male_07"] = {Vector(1.9, 0, -0.12)},
			["male_09"] = {Vector(1.9, 0, 0.15)},
		}
	},
}

MCR.Attachments.face = {
	["weldingmask"] = {
		model = "models/props_silo/welding_helmet.mdl",
		pos = Vector(-5.1, 0, -2.1),
		ang = Angle(-90, 0, 70)
	},
	["gasmask"] = {
		model = "models/half-dead/metroll/p_mask_1.mdl",
		pos = Vector(-0.7, 0, -2.1),
		ang = Angle(90, 0, 70),
		pms = {
			["male_06"] = {Vector(0.1, 0, -2.1)},
		}
	},
	["glasses01"] = {
		model = "models/cityrp/glasses_av.mdl",
		pos = Vector(0.1, -0.04, 0),
		ang = Angle(0, 0, 0),
		scale = Vector(0.93, 0.93, 0.93),
		pms = {
			["male_01"] = {Vector(0.5, -0.04, 0)},
			["male_04"] = {Vector(0.03, -0.05, 0.5)},
			["male_05"] = {Vector(-0.3, 0, 0)},
			["male_06"] = {Vector(0.5, 0, 0.3), nil, Vector(1, 1, 1)},
			["male_07"] = {Vector(-0.3, 0.04, -0.2), nil, Vector(0.89, 0.89, 0.89)},
			["male_08"] = {Vector(-0.3, 0.04, -0.2), nil, Vector(0.89, 0.89, 0.89)},
			["male_09"] = {Vector(0.1, 0, 0.3)},
		}
	},
	["glasses02"] = {
		model = "models/cityrp/glasses.mdl",
		pos = Vector(0.3, 0, 0.2),
		ang = Angle(0, 5, 0),
		scale = Vector(0.95, 0.95, 0.95),
		pms = {
			["male_01"] = {Vector(0.3, 0, 0.1)},
			["male_02"] = {Vector(0, 0, -0.15)},
			["male_03"] = {Vector(0.3, -0.1, 0.2), nil, Vector(0.87, 0.87, 0.87)},
			["male_04"] = {Vector(0.03, -0.05, 0.5)},
			["male_05"] = {Vector(-0.3, 0, 0)},
			["male_06"] = {Vector(0.5, 0.05, 0.3), nil, Vector(1, 1, 1)},
			["male_07"] = {Vector(-0.3, 0.12, -0.2), nil, Vector(0.89, 0.89, 0.89)},
			["male_08"] = {Vector(-0.3, 0.04, -0.2)},
			["male_09"] = {Vector(0.1, 0, 0.3)},
			["female_01"] = {Vector(0.1, 0, 0), nil, Vector(0.87, 0.87, 0.87)},
			["female_02"] = {Vector(0.3, 0, 0), nil, Vector(0.87, 0.87, 0.87)},
			["female_03"] = {Vector(0.3, 0, 0), nil, Vector(0.83, 0.83, 0.83)},
			["female_05"] = {Vector(0.7, 0, 0), nil, Vector(0.83, 0.83, 0.83)},
		}
	},
	["glasses04"] = {
		model = "models/mp2tfomp/accessories/w_glasses_bodyguard.mdl",
		pos = Vector(-5.1, 0.04, -2.9),
		ang = Angle(0, 0, 0),
		scale = Vector(1.1, 1.02, 1),
		pms = {
			["male_02"] = {Vector(-5.6, 0, -2.5), Angle(0, -4, 0), Vector(1.1, 1.02, 1)},
			["male_03"] = {Vector(-5.6, 0, -2.5), Angle(0, -2, 0), Vector(1.1, 1.02, 1)},
			["male_04"] = {Vector(-5.6, 0, -2.5), Angle(0, -2, 0), Vector(1.1, 1.02, 1)},
			["male_05"] = {Vector(-6.1, 0.08, -2.45), Angle(0, -4, 0), Vector(1.1, 1.02, 1)},
			["male_06"] = {Vector(-4.8, 0.1, -2.9), Angle(0, 0, 0), Vector(1.1, 1.07, 1)},
			["male_07"] = {Vector(-5.9, 0.03, -2.8), Angle(0, -4, 0), Vector(1.1, 1, 1)},
			["male_08"] = {Vector(-5.9, 0.08, -2.8), Angle(0, -4, 0), Vector(1.1, 1.03, 1)},
			["male_09"] = {Vector(-5.9, 0.08, -2.4), Angle(0, -4, 0), Vector(1.1, 1.09, 1)},
			["female_01"] = {Vector(-5.5, 0.04, -2.9), nil, Vector(1.1, 1, 1)},
			["female_03"] = {nil, nil, Vector(1.1, 0.98, 1)},
		}
	},
	["glasses05"] = {
		model = "models/mp1/accessories/glasses_killer.mdl",
		pos = Vector(-5.1, -0.04, -2.9),
		ang = Angle(0, 0, 0),
		scale = Vector(1.1, 1.02, 1),
		pms = {
			["male_02"] = {Vector(-5.1, -0.03, -3.5), Angle(0, 4, 0), Vector(1.1, 1.02, 1)},
			["male_05"] = {Vector(-5.1, -0.03, -3.5), Angle(0, 4, 0), Vector(1.1, 1.02, 1)},
			["female_05"] = {Vector(-4.5, -0.03, -3.5), Angle(0, 4, 0), Vector(1.1, 1, 1)},
			["male_06"] = {Vector(-4.7, -0.03, -2.9), Angle(0, 0, 0), Vector(1.1, 1.07, 1)},
			["male_07"] = {Vector(-5.1, 0.03, -3.8), Angle(0, 4, 0), Vector(1.1, 1, 1)},
			["male_08"] = {Vector(-5.1, 0.03, -3.8), Angle(0, 4, 0), Vector(1.1, 1.03, 1)},
		}
	},
	["glasses06"] = {
		model = "models/mp1/accessories/glasses_martin.mdl",
		pos = Vector(-4.9,0, -3.0),
		ang = Angle(0, 5, 0),
		scale = Vector(1.1, 1.05, 1),
		pms = {
			["male_01"] = {Vector(-4.6, 0, -3.0)},
			["male_02"] = {Vector(-4.9, -0.1, -3.2)},
			["male_03"] = {Vector(-4.9, -0.2, -3.0)},
			-- ["male_03"] = {Vector(-5.6, 0, -2.5), Angle(0, -2, 0), Vector(1.1, 1.02, 1)},
			-- ["male_04"] = {Vector(-5.6, 0, -2.5), Angle(0, -2, 0), Vector(1.1, 1.02, 1)},
			-- ["male_05"] = {Vector(-6.1, 0.08, -2.45), Angle(0, -4, 0), Vector(1.1, 1.02, 1)},
			-- ["male_06"] = {Vector(-4.8, 0.1, -2.9), Angle(0, 0, 0), Vector(1.1, 1.07, 1)},
			-- ["male_07"] = {Vector(-5.9, 0.03, -2.8), Angle(0, -4, 0), Vector(1.1, 1, 1)},
			-- ["male_08"] = {Vector(-5.9, 0.08, -2.8), Angle(0, -4, 0), Vector(1.1, 1.03, 1)},
			-- ["male_09"] = {Vector(-5.9, 0.08, -2.4), Angle(0, -4, 0), Vector(1.1, 1.09, 1)},
			-- ["female_01"] = {Vector(-5.5, 0.04, -2.9), nil, Vector(1.1, 1, 1)},
			-- ["female_03"] = {nil, nil, Vector(1.1, 0.98, 1)},
		}
	},
}

MCR.Attachments.head = {
	["chefhat"] = {
		model = "models/chefhat.mdl",
		pos = Vector(-5.0, 0, 2.1),
		ang = Angle(-180, -20, 0),
		scale = Vector(0.9, 0.9, 0.9)
	},
	["hardhat"] = {
		model = "models/items/worker_helmet.mdl",
		pos = Vector(-0.7, 0, 0.5),
		ang = Angle(0, 0, 0),
		pms = {
			["male_06"] = {Vector(-0.5, 0, 1.1)},
		}
	},
	["helmet"] = {
		model = "models/helmets/camo_swat.mdl",
		pos = Vector(-3.5, 0, 1.5),
		ang = Angle(90, 0, 80),
		pms = {
			["male_06"] = {Vector(-3.2, 0, 2.5)},
		}
	},
	["hat01"] = {
		model = "models/cityrp/hat.mdl",
		pos = Vector(-0.9, 0, 0.9),
		ang = Angle(0, 10, 0),
		scale = Vector(0.9, 0.9, 0.9),
		pms = {
			["male_01"] = {Vector(-0.2, 0, 0.6), nil, Vector(1.01, 1.01, 1.01)},
			["male_04"] = {Vector(-0.2, 0, 0.8), nil, Vector(1, 1, 1)},
			["male_05"] = {Vector(-0.9, 0, 0.8), nil, Vector(0.97, 0.97, 0.97)},
			["male_06"] = {Vector(0.3, 0, 1.1), nil, Vector(1.03, 1.03, 1.03)},
			["male_07"] = {Vector(-0.9, 0, 0.6), nil, Vector(0.97, 0.97, 0.97)},
			["male_08"] = {Vector(-1.2, 0, 0.6), nil, Vector(0.98, 0.98, 0.98)},
			["male_09"] = {nil, nil, Vector(1, 1, 1)},
			["female_01"] = {Vector(-0.5, 0, 1.1), nil, Vector(1, 1, 1)},
			["female_02"] = {Vector(-0.5, 0, 1.1), nil, Vector(1, 1, 1)},
			["female_03"] = {Vector(-0.8, 0, 1.2), Angle(0, 2, 0), Vector(1, 1, 1)},
			["female_04"] = {Vector(-0.45, 0, 1.5), nil, Vector(0.97, 0.97, 0.97)},
			["female_05"] = {Vector(-0.8, 0, 1.2), Angle(0, 2, 0), Vector(1, 1, 1)},
			["female_06"] = {Vector(-1, 0, 1.5), nil, Vector(0.97, 0.97, 0.97)},
		}
	},
	["hatb01"] = {
		model = "models/cityrp/hatb.mdl",
		pos = Vector(-0.8, 0, 0.9),
		ang = Angle(0, 10, 0),
		pms = {
			["male_01"] = {Vector(-0.5, 0, 1.3), nil, Vector(1.04, 1.04, 1.04)},
			["male_04"] = {Vector(-0.5, 0, 0.8), nil, Vector(1.03, 1.03, 1.03)},
			["male_05"] = {Vector(-1, 0, 0.9), nil, Vector(1.03, 1.03, 1.03)},
			["male_06"] = {Vector(0.2, 0, 0.9), nil, Vector(1.11, 1.11, 1.11)},
			["male_07"] = {Vector(-0.8, 0, 0.9), nil, Vector(1.05, 1.05, 1.05)},
			["male_08"] = {Vector(-1.1, 0, 0.9), nil, Vector(1.05, 1.05, 1.05)},
			["male_09"] = {Vector(-0.6, 0, 1), nil, Vector(1.06, 1.06, 1.06)},
			["female_01"] = {Vector(-0.5, 0, 1), nil, Vector(1.06, 1.06, 1.06)},
			["female_02"] = {Vector(0, 0, 1), nil, Vector(1.06, 1.06, 1.06)},
			["female_03"] = {Vector(-0.8, 0, 1.1), Angle(0, 2, 0), Vector(1.08, 1.08, 1.08)},
			["female_04"] = {Vector(-0.3, 0, 1.1), Angle(0, 2, 0), Vector(1.08, 1.08, 1.08)},
			["female_05"] = {Vector(-0.3, 0, 1.1), Angle(0, 2, 0), Vector(1.08, 1.08, 1.08)},
			["female_06"] = {Vector(-0.3, 0, 1.1), Angle(0, 2, 0), Vector(1.08, 1.08, 1.08)},
		}
	},
	["cap01"] = {
		model = "models/cityrp/cap.mdl",
		pos = Vector(-0.6, 0, 0.6),
		ang = Angle(0, 0, 0),
		scale = Vector(0.9, 0.9, 0.9),
		pms = {
			["male_01"] = {Vector(-0.6, 0, 0.7), nil, Vector(1, 1, 1)},
			["male_04"] = {Vector(-0.4, 0, 0.7), nil, Vector(0.95, 0.95, 0.95)},
			["male_05"] = {Vector(-0.5, 0, 0.7), nil, Vector(0.95, 0.95, 0.95)},
			["male_06"] = {Vector(0.2, 0.08, 0.8), nil, Vector(1.03, 1.03, 1.03)},
			["male_07"] = {Vector(-0.9, 0.1, 0.5), nil, Vector(0.95, 0.95, 0.95)},
			["male_08"] = {Vector(-0.9, 0, 0.5), nil, Vector(0.95, 0.95, 0.95)},
			["male_09"] = {Vector(-0.4, 0, 0.6), nil, Vector(0.98, 0.98, 0.98)},
		}
	},
	["bcap01"] = {
		model = "models/props/cs_office/snowman_hat.mdl",
		pos = Vector(-2.13, -0.1, 2.1),
		ang = Angle(-90, 0, 0),
		scale = Vector(0.75, 0.8, 0.9),
		pms = {
			["female_01"] = {Vector(-2.06, -0.2, 2.1), nil, Vector(0.78, 0.85, 0.9)},
			["female_02"] = {Vector(-1.9, -0.2, 2.1), nil, Vector(0.78, 0.85, 0.9)},
			["female_03"] = {Vector(-2.65, 0, 2.1), nil, Vector(0.82, 0.9, 0.9)},
			["female_05"] = {Vector(-2.5, 0, 2.1), nil, Vector(0.82, 0.9, 0.9)},
			["female_04"] = {Vector(-1.8, -0.1, 2.1), nil, Vector(0.78, 0.85, 0.9)},
			["female_06"] = {Vector(-2, -0.1, 2.1), nil, Vector(0.76, 0.85, 0.9)},
			["male_01"] = {Vector(-2.06, -0.1, 2.1), nil, Vector(0.8, 0.85, 0.9)},
			["male_04"] = {Vector(-2.2, -0.05, 2.5), nil, Vector(0.73, 0.85, 0.9)},
			["male_05"] = {Vector(-2.72, -0.04, 2.1), nil, Vector(0.765, 0.77, 0.9)},
			["male_06"] = {Vector(-1.83, 0, 2.6), nil, Vector(0.8, 0.88, 0.9)},
			["male_07"] = {Vector(-2.7, 0, 2.1), nil, Vector(0.73, 0.84, 0.9)},
			["male_08"] = {Vector(-2.7, 0, 2.1), nil, Vector(0.8, 0.86, 0.9)},
			["male_09"] = {Vector(-2.5, 0, 2.1), nil, Vector(0.82, 0.86, 0.9)},
		}
	},
	["foilhat"] = {
		model = "models/cityrp/foilhat.mdl",
		pos = Vector(-5.13, 0, 1.1),
		ang = Angle(0, 20, 0),
		scale = Vector(0.91, 1, 0.9),
		pms = {
			["female_01"] = {Vector(-4.8, 0, 1.1)},
			["female_02"] = {Vector(-4.2, 0, 1.1)},
			["female_04"] = {Vector(-4.2, 0, 1.1)},
			["male_01"] = {Vector(-5.13, 0, 1.1), nil, Vector(1, 1, 1)},
			["male_04"] = {Vector(-5.13, 0, 1.1), nil, Vector(0.95, 1, 0.9)},
			["male_06"] = {Vector(-4.9, 0, 1.1), nil, Vector(1.05, 1.05, 1.05)},
			["male_07"] = {Vector(-5.4, 0, 1.1)},
			["male_08"] = {Vector(-5.7, 0, 1.1), nil, Vector(1, 1, 1)},
			["male_09"] = {Vector(-5.13, 0, 1.1), nil, Vector(1, 1, 1)},
		}
	},
	["tophat"] = {
		model = "models/player/items/humans/top_hat.mdl",
		pos = Vector(-5.13, 0, 1.1),
		ang = Angle(0, 20, 0),
		scale = Vector(0.91, 1, 0.9),
		pms = {
			-- ["female_01"] = {Vector(-4.8, 0, 1.1)},
			-- ["female_02"] = {Vector(-4.2, 0, 1.1)},
			-- ["female_04"] = {Vector(-4.2, 0, 1.1)},
			-- ["male_01"] = {Vector(-5.13, 0, 1.1), nil, Vector(1, 1, 1)},
			-- ["male_04"] = {Vector(-5.13, 0, 1.1), nil, Vector(0.95, 1, 0.9)},
			-- ["male_06"] = {Vector(-4.9, 0, 1.1), nil, Vector(1.05, 1.05, 1.05)},
			-- ["male_07"] = {Vector(-5.4, 0, 1.1)},
			-- ["male_08"] = {Vector(-5.7, 0, 1.1), nil, Vector(1, 1, 1)},
			-- ["male_09"] = {Vector(-5.13, 0, 1.1), nil, Vector(1, 1, 1)},
		}
	},
	["acap01"] = {
		model = "models/mp2tfomp/accessories/w_cap_cleaner_a.mdl",
		pos = Vector(-5.1, 0.05, -2.3),
		ang = Angle(0, 0, 0),
		mat = "gbskins/att/acap01",
		scale = Vector(1.17, 1.03, 1),
		pms = {
			["male_04"] = {Vector(-5.1, 0.05, -2.1)},
			["male_05"] = {Vector(-5.4, 0.12, -2.5), nil, Vector(1.09, 1.05, 1)},
			["male_06"] = { Vector(-5, 0.07, -1.8), nil, Vector(1.2, 1.07, 1)},
			["male_07"] = { Vector(-5.6, 0.05, -2.4), nil, Vector(1.15, 1.05, 1)},
			["male_08"] = { Vector(-5.9, 0.07, -2.4), nil, Vector(1.15, 1.05, 1)},
			["male_09"] = { Vector(-5.4, 0.09, -2.4), nil, Vector(1.15, 1.08, 1)},
			["female_01"] = { Vector(-5.1, -0.1, -2.3), nil, Vector(1.17, 1.08, 1)},
			["female_02"] = { Vector(-4.7, -0.1, -2.3), nil, Vector(1.17, 1.08, 1)},
			["female_03"] = { Vector(-5.7, 0.05, -2.3), nil, Vector(1.17, 1.1, 1)},
			["female_04"] = { Vector(-4.7, -0.1, -2.3), nil, Vector(1.17, 1.08, 1)},
			["female_05"] = { Vector(-5.5, 0.05, -2.3), nil, Vector(1.17, 1.1, 1)},
		}
	},
	["fcap01"] = {
		model = "models/mp2tfomp/accessories/w_cap_cleaner_b.mdl",
		pos = Vector(-5.1, -0.07, -2.3),
		ang = Angle(0, 0, 0),
		mat = "gbskins/att/acap01",
		scale = Vector(1.1, 1.03, 1),
		pms = {
			["male_02"] = {Vector(-5, -0.07, -2.8), nil, Vector(1.01, 1, 1)},
			["male_03"] = {Vector(-5, -0.07, -2.8), nil, Vector(1.01, 1, 1)},
			["male_04"] = {Vector(-5, 0.05, -2.6), nil, Vector(1.01, 1.03, 1)},
			["male_05"] = {Vector(-5.5, 0.1, -2.5), nil, Vector(1.01, 1.05, 1)},
			["male_06"] = { Vector(-5, 0.07, -1.8), nil, Vector(1.1, 1.07, 1)},
			["male_07"] = { Vector(-5.2, 0.05, -2.5), nil, Vector(1.03, 1.05, 1)},
			["male_08"] = { Vector(-5.6, -0.02, -2.4), nil, Vector(1.04, 1.07, 1)},
			["male_09"] = { Vector(-5.3, 0.05, -2.4), nil, Vector(1.04, 1.08, 1)},
			["female_01"] = { Vector(-5.1, -0.1, -2.3), nil, Vector(1.17, 1.08, 1)},
			["female_02"] = { Vector(-4.7, -0.1, -2.3), nil, Vector(1.01, 1.08, 1)},
			["female_03"] = { Vector(-5.7, -0.03, -2.3), nil, Vector(1.17, 1.1, 1)},
			["female_04"] = { Vector(-4.5, -0.1, -2.3), nil, Vector(1.01, 1.08, 1)},
			["female_05"] = { Vector(-5.5, 0.05, -2.3), nil, Vector(1.17, 1.1, 1)},
		}
	},
	["beanie01"] = {
		model = "models/mp2tfomp/accessories/w_beanie_blackops.mdl",
		pos = Vector(-4.9, 0, -2.6),
		ang = Angle(0, 0, 0),
		scale = Vector(1, 1.04, 1),
		pms = {
			["male_01"] = {Vector(-4.9, 0, -2.6), nil, Vector(1.1, 1.04, 1)},
			["male_03"] = {Vector(-4.5, 0, -2.6), nil, Vector(1, 1.04, 1)},
			["male_04"] = {Vector(-4.7, 0, -2.2), nil, Vector(1, 1.04, 1)},
			["male_06"] = {Vector(-4.5, 0.05, -2.2), nil, Vector(1.1, 1.07, 1)},
			["male_07"] = {Vector(-5.2, 0.05, -2.2), nil, Vector(1.05, 1.04, 1)},
			["male_08"] = {Vector(-5.2, 0.05, -2.2), nil, Vector(1.05, 1.04, 1)},
			["male_09"] = {Vector(-5.2, 0.05, -2.2), nil, Vector(1.05, 1.04, 1)},
		}
	},
	["beanie02"] = {
		model = "models/mp2tfomp/accessories/w_beanie_boozehound.mdl",
		pos = Vector(-5.59, 0.03, -2.21),
		ang = Angle(0, 0, 0),
		scale = Vector(1.13, 1.10, 1.21),
		pms = {
			["male_03"] = {Vector(-5.67, 0, -2.78)},
			["male_03"] = {Vector(-4.95, 0.08, -3.18), Angle(0, 10.01, 0), Vector(1.13, 1.08, 1.25)},
			["male_04"] = {Vector(-5.26, 0, -2.45), Angle(0, 7.2, 0), Vector(1.09, 1.17, 1.21)},
			["male_05"] = {Vector(-5.35, 0, -2.93), Angle(0, 8.73, 0), Vector(1.1, 1.21, 1.2)},
			["male_06"] = {Vector(-5.59, 0.19, -2.21), Angle(0, 0, 0), Vector(1.22, 1.23, 1.21)},
			["male_07"] = {Vector(-6.16, 0, -2.53)},
			["male_08"] = {Vector(-5.57, 0, -2.61), Angle(0, 15.8, 0), Vector(1.12, 1.17, 1.12)},
			["male_09"] = {Vector(-4.94, 0.08, -2.61), Angle(0, 15.8, 0), Vector(1.12, 1.2, 1.12)},
		}
	},
	["builders"] = {
		model = "models/items/worker_helmet.mdl",
		mat = "gbskins/worker_helmet",
		pos = Vector(-0.2,0,0),
		ang = Angle(0,0,0),
	},
}

MCR.Attachments.face["glasses03"] = table.Copy(MCR.Attachments.face["glasses02"])
MCR.Attachments.face["glasses03"].submat = {
	[1] = "gbskins/att/glass3"
}

MCR.Attachments.head["hat02"] = table.Copy(MCR.Attachments.head["hat01"])
MCR.Attachments.head["hat02"].mat = "gbskins/att/hat02"
MCR.Attachments.head["hat03"] = table.Copy(MCR.Attachments.head["hat01"])
MCR.Attachments.head["hat03"].mat = "gbskins/att/hat03"
MCR.Attachments.head["hat04"] = table.Copy(MCR.Attachments.head["hat01"])
MCR.Attachments.head["hat04"].mat = "gbskins/att/hat04"
MCR.Attachments.head["hatb02"] = table.Copy(MCR.Attachments.head["hatb01"])
MCR.Attachments.head["hatb02"].mat = "gbskins/att/hatb02"
MCR.Attachments.head["hatb03"] = table.Copy(MCR.Attachments.head["hatb01"])
MCR.Attachments.head["hatb03"].mat = "gbskins/att/hatb03"

MCR.Attachments.head["cap02"] = table.Copy(MCR.Attachments.head["cap01"])
MCR.Attachments.head["cap02"].mat = "gbskins/att/cap02"

MCR.Attachments.head["capm"] = table.Copy(MCR.Attachments.head["cap01"])
MCR.Attachments.head["capl"] = table.Copy(MCR.Attachments.head["cap01"])
MCR.Attachments.head["capm"].mat = "gbskins/att/capm"
MCR.Attachments.head["capl"].mat = "gbskins/att/capl"

MCR.Attachments.head["bcap02"] = table.Copy(MCR.Attachments.head["bcap01"])
MCR.Attachments.head["bcap02"].mat = "gbskins/att/bcap02"

MCR.Attachments.head["bcap03"] = table.Copy(MCR.Attachments.head["bcap01"])
MCR.Attachments.head["bcap03"].mat = "gbskins/att/bcap03"

MCR.Attachments.head["bcap04"] = table.Copy(MCR.Attachments.head["bcap01"])
MCR.Attachments.head["bcap04"].mat = "gbskins/att/bcap04"

MCR.Attachments.head["bcap801"] = table.Copy(MCR.Attachments.head["bcap01"])
MCR.Attachments.head["bcap801"].mat = "gbskins/att/bcap801"

MCR.Attachments.head["acap02"] = table.Copy(MCR.Attachments.head["acap01"])
MCR.Attachments.head["acap02"].mat = "gbskins/att/acap02"

MCR.Attachments.head["fcap02"] = table.Copy(MCR.Attachments.head["fcap01"])
MCR.Attachments.head["fcap02"].mat = "gbskins/att/acap02"

MCR.Cosmetics = {
	["head"] = {
		["hat01"] = {
			name = "Федора, черная",
			icon = Material("gmodla/icons/hat01.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat7")
			end,
		},
		["hat02"] = {
			name = "Федора, серая",
			icon = Material("gmodla/icons/hat02.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat7")
			end,
		},
		["hat03"] = {
			name = "Федора, коричневая",
			icon = Material("gmodla/icons/hat03.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat7")
			end,
		},
		["hat04"] = {
			name = "Федора, белая",
			icon = Material("gmodla/icons/hat04.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat7")
			end,
		},
		["hatb01"] = {
			name = "Шляпа, черная",
			icon = Material("gmodla/icons/hatb01.png", "smooth"),
			check = function(ply)
				return ply:IsSuperAdmin()
			end,
		},
		["hatb02"] = {
			name = "Шляпа, белая",
			icon = Material("gmodla/icons/hatb02.png", "smooth"),
			check = function(ply)
				return ply:IsSuperAdmin()
			end,
		},
		["hatb03"] = {
			name = "Шляпа, соломенная",
			icon = Material("gmodla/icons/hatb03.png", "smooth"),
			check = function(ply)
				return ply:IsSuperAdmin()
			end,
		},
		["cap01"] = {
			name = "Плоская кепка, коричневая",
			icon = Material("gmodla/icons/cap01.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat4")
			end,
		},
		["cap02"] = {
			name = "Плоская кепка, серая",
			icon = Material("gmodla/icons/cap02.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat4")
			end,
		},
		["bcap01"] = {
			name = "Бейсболка патриота",
			icon = Material("gmodla/icons/bcap01.png", "smooth"),
			check = function(ply)
				return ply:IsSuperAdmin()
			end,
		},
		["bcap02"] = {
			name = "Бейсболка туриста",
			icon = Material("gmodla/icons/bcap02.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat1")
			end,
		},
		["bcap03"] = {
			name = "Бейсболка бренд",
			icon = Material("gmodla/icons/bcap03.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrathlwn")
			end,
		},
		["bcap04"] = {
			name = "Бейсболка бренд",
			icon = Material("gmodla/icons/bcap04.png", "smooth"),
			check = function(ply)
				if sAdmin.mcTime(ply) > 5256000 then return true end

				return false
			end,
		},
		["bcap801"] = {
			name = "Бейсболка бренд",
			icon = Material("gmodla/icons/bcap801.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "dinkenson_pack")
			end,
		},
		["capm"] = {
			name = "Кепка, сантехник M",
			icon = Material("gmodla/icons/capm.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrathlwn")
			end,
		},
		["capl"] = {
			name = "Кепка, сантехник L",
			icon = Material("gmodla/icons/capl.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrathlwn")
			end,
		},
		["acap01"] = {
			name = "Бейсболка",
			icon = Material("gmodla/icons/acap01.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_fishy")
			end,
		},
		["fcap01"] = {
			name = "Бейсболка назад",
			icon = Material("gmodla/icons/fcap01.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_fishy")
			end,
		},
		["acap02"] = {
			name = "Бейсболка",
			icon = Material("gmodla/icons/acap02.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_blueblood")
			end,
		},
		["fcap02"] = {
			name = "Бейсболка назад",
			icon = Material("gmodla/icons/fcap02.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_blueblood")
			end,
		},
		["beanie01"] = {
			name = "Шапка, тёмно-синяя",
			icon = Material("gmodla/icons/beanie01.png", "smooth"),
			check = function(ply)
				if ply:getDarkRPVar("gender") == "female" then return false end
				return MQS.GetSData(ply, "d_packbluecolar")
			end,
		},
		["beanie02"] = {
			name = "Шапка, коричневая",
			icon = Material("gmodla/icons/beanie02.png", "smooth"),
			check = function(ply)
				if ply:getDarkRPVar("gender") == "female" then return false end
				return MQS.GetSData(ply, "d_packbluecolar")
			end,
		},
		["builders"] = {
			name = "Каска",
			icon = Material("gmodla/icons/worker_helmet2.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_builder")
			end,
		},
	},
	["face"] = {
		["glasses01"] = {
			name = "Авиаторы",
			icon = Material("gmodla/icons/glasses01.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "episode_1_glasses01")
			end,
		},
		["glasses02"] = {
			name = "Очки, пластиковые",
			icon = Material("gmodla/icons/glasses02.png", "smooth"),
			check = function(ply)
				if sAdmin.mcTime(ply) > 2628000 then return true end

				return false
			end,
		},
		["glasses03"] = {
			name = "Очки, солнечные",
			icon = Material("gmodla/icons/glasses03.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packrat6")
			end,
		},
		["glasses04"] = {
			name = "Очки, стильные",
			icon = Material("spawnicons/models/mp2tfomp/accessories/w_glasses_bodyguard.png", "smooth"),
			check = function(ply)
				return ply:IsSuperAdmin() or ply:SteamID() == "STEAM_0:0:163281864" or MQS.GetSData(ply, "secret_pack")
			end,
		},
		["glasses05"] = {
			name = "Очки, 'Киллер'",
			icon = Material("spawnicons/models/mp1/accessories/glasses_killer.png", "smooth"),
			check = function(ply)
				return ply:IsSuperAdmin() or ply:SteamID() == "STEAM_0:0:804598308"
			end,
		},
		["glasses06"] = {
			name = "Очки, 'Агент'",
			icon = Material("spawnicons/models/mp1/accessories/glasses_martin.png", "smooth"),
			check = function(ply)
				return ply:IsSuperAdmin()
			end,
		},
	},
	["vest"] = {
		["vest01"] = {
			name = "Жилет",
			icon = Material("gmodla/icons/vest01.png", "smooth"),
			check = function(ply)
				return MQS.GetSData(ply, "d_packbluecolar") and not string.find(ply:GetModel(), "suit/")
			end,
		},
	},
}

MCR.Medals = {
	["1"] = "medal2", -- Police Expert
	["2"] = "medal3", -- Exelent PD
	["3"] = "medal7", -- Почетная ПС
	["4"] = "medal10", -- Помощь обзеству
	["5"] = "medal9", -- Порядочность-благодарность
	["6"] = "medal8", -- Исключительные заслуги
	["7"] = "medal4", -- Почетный отзыв
	["8"] = "medal6", -- Медаль за отвагу
	["9"] = "medal11", -- боевой крест
	["10"] = "medal5", -- медаль за доблесть
}

MCR.Tatoo = {
	["a1"] = {"Скрытое ношение", 1, 500, "Скрытое ношение компактного оружия без необходимости его долго перепрятывать."},
	["a2"] = {"Выносливость", 1, 1000, "Максимальное здоровье повышено до 110%.", "a6"},
	["a3"] = {"Организованность", 1, 300, "Ускоренное перемещение предметов в инвентарь.", "b6"},
	["a4"] = {"Гибкие пальцы", 2, 700, "Взлом отмычкой происходит быстрее и легче обычного."},
	["a5"] = {"Острый ум", 1, 500, "Необходимый опыт профессий зарабатывается быстрее. Упрощена проверка реакции в манипуляции с серийным номером."},
	["a6"] = {"Марафонец", 1, 500, "Вы бежите быстрее типичного Джо. Ваше здоровье снижено до 90%.", "a2"},
	["a7"] = {"Целеустремлённость", 1, 350, "Выносливость не влияет на способность участвовать в ближнем бою."},
	["a8"] = {"Коммандос", 1, 500, "Возможность держать в руках дополнительное оружие, тип которого уже висит на персонаже. Кроме точно такого же варианта оружия."},
	["a9"] = {"Автолюбитель", 1, 800, "Вы знаете, как завести машину без ключей."},
	["b1"] = {"Могильщик", 1, 300, "Обыск тел ускорен."},
	["b2"] = {"Бескровность", 2, 700, "Кровотечения затягиваются самостоятельно в разы быстрее."},
	["b3"] = {"Садист", 2, 500, "Удары предметами рукопашного боя причиняют чрезвычайную боль вашему противнику."},
	["b4"] = {"Подлость", 1, 350, "Негативно влияет на вашу конечную выживаемость. Или позитивно, смотря под каким углом на это смотреть.."},
	["b5"] = {"Чутьё", 2, 350, "Вы чувствуете, когда добиваете кого-либо."},
	["b6"] = {"Мул", 1, 500, "Увеличен размер инвентаря засчёт сниженной скорости подбора предметов. Не работает в костюме.", "a3"},
	["b7"] = {"Блэкджек", 1, 1200, "Не режущие предметы ближнего боя оглушают тяжёлым ударом со 100% шансом.", "g7"},
	["b8"] = {"Глубокие лёгкие", 1, 500, "Увеличен порог до появления изнеможения."},
	["b9"] = {"Доктор", 2, 350, "Возможность провести СЛР без спецсредств."},
	["g1"] = {"Крепкий хват", 2, 350, "Оружие не выпадает при ранении в руку."},
	["g2"] = {"Марксман", 2, 500, "Снижена отдача в прицельной стрельбе."},
	["g3"] = {"Баптист", 1, 1200, "Вода залива Аппер не такая холодная для вас, как для других."},
	["g4"] = {"Сомелье", 1, 500, "Ваш порог опьянения от алкоголя выше чем у других."},
	["g5"] = {"Внимательность", 2, 700, "Осмотр окружения ненадолго подсвечивает используемые предметы на близком расстоянии."},
	["g6"] = {"Непреодолимая сила", 3, 1200, "Огнестрельные ранения никогда не отправят вас в бессознательное состояние."},
	["g7"] = {"Ассассин", 1, 300, "Долгий замах предметами ближнего боя производится без предупредительного шума.", "b7"},
	["d1"] = {"Танцор", 3, 500, "Открывает мир современных движений для танцев."},
}