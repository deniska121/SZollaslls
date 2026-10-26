--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/a_config_gmodla/lua/clprops/day_preset1.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local monitors = {"", "gbskins/tv/01", "gbskins/tv/02", "models/unioncity3/props_interior/monitor01b", "models/unioncity3/props_interior/monitor01c",}

local scene = {
	{
		ang = Angle(-0.68115234375, 58.178100585938, -0.494384765625),
		pos = Vector(-1919, 4570.65625, 1236.71875),
		mdl = "models/unioncity3/props_interior/monitor.mdl",
		delay = 120,
		think = function(mdl)
			mdl:SetMaterial(monitors[math.random(#monitors)])

			if math.random(1, 100) == 1 then
				mdl:SetMaterial("gbskins/tv/03")
			end
		end
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-3576, 3696, -113.2),
		mdl = "models/noire/impound.mdl",
	},
	{
		ang = Angle(0, -180, 0),
		pos = Vector(2553.6875, 4997.71875, 43.0),
		mdl = "models/props_lab/monitor02.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(2535.09375, 5003.78125, 43.0),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutterb.mdl",
	},
	{
		ang = Angle(-0.5767822265625, 79.019165039063, 0.087890625),
		pos = Vector(-1909.875, 4590.125, 1236.625),
		mdl = "models/props_electronics/keyboard-3.mdl",
	},
	{
		ang = Angle(0.0054931640625, 88.522338867188, -0.032958984375),
		pos = Vector(-1937.25, 4575.375, 1236.75),
		mdl = "models/props_electronics/computer-1.mdl",
	},
	{
		ang = Angle(-2.08740234375, 60.194091796875, -2.39501953125),
		pos = Vector(-1926.625, 4588.46875, 1236.8125),
		mdl = "models/props_office_supplies/floppy_disk-3.mdl",
	},
	{
		ang = Angle(-0.10986328125, 87.808227539063, -0.0933837890625),
		pos = Vector(-1893.125, 4572.4375, 1236.78125),
		mdl = "models/props_books/paper_stack-3.mdl",
	},
	{
		ang = Angle(-0.439453125, 139.24621582031, 0.296630859375),
		pos = Vector(-1886.9375, 4588.71875, 1236.78125),
		mdl = "models/props/cs_office/coffee_mug.mdl",
	},
	{
		ang = Angle(-0.37353515625, 102.1728515625, -0.0384521484375),
		pos = Vector(-1875.28125, 4574.15625, 1236.78125),
		mdl = "models/props_electronics/phone-4.mdl",
	},
	{
		ang = Angle(3.93310546875, 179.99450683594, -0.10986328125),
		pos = Vector(-9.78125, -4108.90625, -168.375),
		mdl = "models/unioncity2/props_unioncity/lifering.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(3663.625, -2156.09375, -69.375),
		mdl = "models/uc/props_interior/firehose_wallmount.mdl",
	},
	{
		ang = Angle(0, 100.11840820313, 0),
		pos = Vector(3606.21875, -2245.09375, -121.09375),
		mdl = "models/props_junk/trashcluster01a.mdl",
	},
	{
		ang = Angle(72.2900390625, 89.994506835938, 0),
		pos = Vector(3612.0625, -2270.3125, -57.34375),
		mdl = "models/unioncity2/props_street/alley_dumpsterlid.mdl",
	},
	{
		ang = Angle(-0.1922607421875, -18.781127929688, 175.25939941406),
		pos = Vector(3488.46875, -2248.84375, -83.78125),
		mdl = "models/props_vehicles/carparts_muffler01a.mdl",
	},
	{
		ang = Angle(89.9560546875, -1.64794921875, 180),
		pos = Vector(3271.875, -2254.125, -95.34375),
		mdl = "models/props_c17/trappropeller_engine.mdl",
	},
	{
		ang = Angle(-64.3798828125, 83.567504882813, -5.196533203125),
		pos = Vector(3224.4375, -2258.34375, -70.1875),
		mdl = "models/props_vehicles/carparts_axel01a.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(1688, -1272, -96),
		mdl = "models/unioncity2/props_stores/hardware_shelf05_products.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(1688, -1464, -96),
		mdl = "models/unioncity2/props_stores/hardware_shelf06_products.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(1452, -1296, -96),
		mdl = "models/unioncity2/props_stores/hardware_shelf01_products.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(1312, -1296, -96),
		mdl = "models/unioncity2/props_stores/hardware_shelf04_products.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(1172, -1296, -96),
		mdl = "models/unioncity2/props_stores/hardware_shelf03_products.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(6360, 7008, 136.28125),
		mdl = "models/props_street/flagpole_american.mdl",
		anm = "idle",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(762, 14390, 128),
		mdl = "models/unioncity2/props_stores/store_grocery05_products.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(762, 14208, 128),
		mdl = "models/unioncity2/props_stores/store_grocery02_products.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(762, 14049, 128),
		mdl = "models/unioncity2/props_stores/store_grocery01_products.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(966, 14028, 128),
		mdl = "models/unioncity2/props_stores/store_grocery03_products.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(7151, 1480, 831.25),
		mdl = "models/unioncity2/props_unioncity/lifering.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(5074, -5294, -256.75),
		mdl = "models/unioncity2/props_unioncity/lifering.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-1018, -6136, -256.75),
		mdl = "models/unioncity2/props_unioncity/lifering.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-6669, -3832, -257),
		mdl = "models/unioncity2/props_unioncity/lifering.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(-11192, -11096, -256.75),
		mdl = "models/unioncity2/props_unioncity/lifering.mdl",
	},
	{
		ang = Angle(-0.0054931640625, 90.428466796875, 0),
		pos = Vector(-1837.6875, 4580.625, 1200.34375),
		mdl = "models/props_electronics/printer-7.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(7834, 8006, 243),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutterb.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(8282, 8061, 240),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},

	{
		ang = Angle(0, 0, 0),
		pos = Vector(8326, 8062, 240),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(8319, 8070, 240),
		mdl = "models/unioncity3/props_interior/monitor.mdl",
		skin = 3,
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(8282, 8061, 240),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(8289.96875, 8054.96875, 240),
		mdl = "models/unioncity2/props_unioncity/pd_deskscreen.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(8607, 8056, 240.125),
		mdl = "models/unioncity2/props_unioncity/pd_deskscreen.mdl",
	},
	{
		ang = Angle(-0, 180, 0),
		pos = Vector(8599, 8062, 240),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(8546, 7746, 240),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(-0.538330078125, 0, -0.6207275390625),
		pos = Vector(7737.90625, 8509.625, 328.96875),
		mdl = "models/unioncity3/props_interior/monitor.mdl",
		skin = 3,
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(7808, 8835, 329.0625),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, 179.99450683594, 0),
		pos = Vector(8131.3125, 8709.5, 329.09375),
		mdl = "models/unioncity3/props_interior/monitor.mdl",
		skin = 3,
	},
	{
		ang = Angle(0, -179.6044921875, 0),
		pos = Vector(8121.8125, 8716.6875, 329.03125),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(-0.010986328125, 179.9560546875, 0.02197265625),
		pos = Vector(7884.96875, 8682.5625, 328.96875),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(-0.5328369140625, 176.24267578125, -0.494384765625),
		pos = Vector(7894.15625, 8674.1875, 328.9375),
		mdl = "models/unioncity3/props_interior/monitor.mdl",
	},
	{
		ang = Angle(-1.0052490234375, -72.850341796875, 1.4501953125),
		pos = Vector(7941.5, 8706.15625, 329.125),
		mdl = "models/props_books/paper_stack-4.mdl",
	},
	{
		ang = Angle(0.02197265625, -0.010986328125, -0.0274658203125),
		pos = Vector(7927.875, 8721.875, 328.9375),
		mdl = "models/props/cs_office/file_box.mdl",
	},
	{
		ang = Angle(-0.087890625, -17.9736328125, -0.0274658203125),
		pos = Vector(7927.75, 8680.53125, 328.90625),
		mdl = "models/props_electronics/printer-1.mdl",
	},
	{
		ang = Angle(2.186279296875, 15.6005859375, -1.6644287109375),
		pos = Vector(7936.34375, 8650.09375, 328.9375),
		mdl = "models/props_books/paper_stack-3.mdl",
	},
	{
		ang = Angle(-0.24169921875, 0.142822265625, 0.0823974609375),
		pos = Vector(7920.34375, 8650.96875, 328.8125),
		mdl = "models/unioncity3/props_misc/file_folders.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(8602.09375, 7472.5, -399.75),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(-0.5548095703125, 0.3570556640625, -0.5987548828125),
		pos = Vector(8539.28125, 7750.40625, 240.6875),
		mdl = "models/unioncity3/props_interior/monitor.mdl",
	},
	{
		ang = Angle(0.208740234375, -169.27734375, -0.1812744140625),
		pos = Vector(7920.34375, 8963.84375, 329),
		mdl = "models/props_books/paper_stack-3.mdl",
	},
	{
		ang = Angle(0.10986328125, 179.08813476563, 0.186767578125),
		pos = Vector(7921.0625, 8946.90625, 329.03125),
		mdl = "models/props_electronics/phone-4.mdl",
	},
	{
		ang = Angle(-1.1700439453125, 166.32202148438, 0.1812744140625),
		pos = Vector(7903.5, 8905.40625, 328.84375),
		mdl = "models/props_electronics/keyboard-3.mdl",
	},
	{
		ang = Angle(0.02197265625, 179.94506835938, 0.17578125),
		pos = Vector(7913.78125, 8885.21875, 328.78125),
		mdl = "models/props_electronics/computer-1.mdl",
	},
	{
		ang = Angle(-0.5548095703125, 86.15478515625, -0.428466796875),
		pos = Vector(7823.71875, 7990, 243.375),
		mdl = "models/unioncity3/props_interior/monitor.mdl",
		skin = 2,
	},
	{
		ang = Angle(0, 0.2801513671875, 0),
		pos = Vector(7746.125, 8503.125, 328.90625),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(8502, 7745, 240),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0.0494384765625, 89.994506835938, 0.0274658203125),
		pos = Vector(8450.8125, 9029.75, 327.125),
		mdl = "models/props_electronics/phone-4.mdl",
	},
	{
		ang = Angle(-0.3955078125, 2.384033203125, 0),
		pos = Vector(8301.71875, 9034.03125, 346.46875),
		mdl = "models/unioncity3/props_misc/file_folders.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(7834, 8006, 243),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutterb.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(8217, 8530, 328),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(8217, 8686, 328),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(8210, 8678, 328),
		mdl = "models/unioncity2/props_unioncity/pd_deskscreen.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(8704, 8680, 328),
		mdl = "models/unioncity2/props_unioncity/pd_deskscreen.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(8711, 8686, 328),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang	=	Angle(0,0,0),
		pos	=	Vector(3193.5,5151.59375,65.5625),
		mdl	=	"models/noirpropper/sign_conceal.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(8711, 8530, 328),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(899, 11148, 211),
		mdl = "models/uc/props_fastfood/spresso_machine.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(1394, 10900, 168.25),
		mdl = "models/uc/props_fastfood/jukebox.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(526, 14306, 168),
		mdl = "models/unioncity2/props_stores/slush_machine.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(526, 14262, 168),
		mdl = "models/uc/props_fastfood/coffee_machine.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(754, 13855, 128),
		mdl = "models/unioncity2/props_stores/gum_stand.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(-5682, 1366, 16),
		mdl = "models/unioncity2/props_stores/slush_machine.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(-5682, 1410, 16),
		mdl = "models/uc/props_fastfood/coffee_machine.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-6204, 1178, -23.75),
		mdl = "models/unioncity2/props_stores/gum_stand.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-7474, 4992, 64.34375),
		mdl = "models/unioncity2/props_unioncity/pd_deskscreen.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-7466, 4982.0625, 64),
		mdl = "models/unioncity2/props_unioncity/pd_deskclutter.mdl",
	},
	{
		ang = Angle(-0.0164794921875, 8.6737060546875, 0),
		pos = Vector(-1622.09375, -6272.5625, -319.59375),
		mdl = "models/props/de_prodigy/wood_pallet_01.mdl",
	},
	{
		ang = Angle(-0.0164794921875, 101.92565917969, 0),
		pos = Vector(-1511.34375, -6578.59375, -303.78125),
		mdl = "models/props_junk/wood_crate001a_half.mdl",
	},
	{
		ang = Angle(0, -2.7740478515625, 179.97253417969),
		pos = Vector(-1441, -6531, -317.875),
		mdl = "models/hunter/blocks/cube150x150x025.mdl",
		mat = "models/noirpropper/sign_id/metalfloor01"
	},
	{
		ang = Angle(0.0054931640625, -90.3515625, 0),
		pos = Vector(-5375.90625, -2003.5625, -9175.125),
		mdl = "models/props/de_train/pallet_barrels.mdl",
		smt = {
			[0] = "models/props_c17/oil_drum001a",
			[1] = "models/props_c17/oil_drum001c",
			[3] = "models/props_c17/oil_drum001d",
			[4] = "models/props_c17/oil_drum001e"
		},
	},
	{
		ang = Angle(0.0054931640625, -90.3076171875, 0),
		pos = Vector(-5375.78125, -1942.84375, -9175.25),
		mdl = "models/props/de_train/pallet_barrels.mdl",
		smt = {
			[0] = "models/props_c17/oil_drum001f",
			[1] = "models/props_c17/oil_drum001d",
			[3] = "models/props_c17/oil_drum001g",
			[4] = "models/props_c17/oil_drum001h"
		},
	},
	{
		ang = Angle(0.0494384765625, 90.016479492188, 0.0384521484375),
		pos = Vector(-159.28125, -5719.21875, -320.71875),
		mdl = "models/props/cs_assault/handtruck.mdl",
	},
	{
		ang = Angle(0, 90.016479492188, 0),
		pos = Vector(-230, -5718.5625, -320.71875),
		mdl = "models/props/cs_assault/handtruck.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(-1558.65625, 3208.1875, -513.28125),
		mdl = "models/props_equipment/firepipe02.mdl"
	},
	{
		ang = Angle(0, 180, 90),
		pos = Vector(-1558.1875, 3247.6875, -415.34375),
		mdl = "models/props_equipment/firepipe02.mdl",
	},
	{
		ang = Angle(90, 0, 180),
		pos = Vector(-1558.71875, 3233.3125, -415.4),
		mdl = "models/props_pipes/pipe02_tjoint01.mdl",
		scale = Vector(1.1, 1.1, 1.1),
		mat = "models/props_debris/building_template010a",
		col = Color(183, 90, 80)
	},
	{
		ang = Angle(90, 0, 180),
		pos = Vector(-1558.71875, 3233.3125, -440.4),
		mdl = "models/props_pipes/pipe02_tjoint01.mdl",
		scale = Vector(1.1, 1.1, 1.1),
		mat = "models/props_debris/building_template010a",
		col = Color(183, 90, 80)
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(-1680.03125, 3336.90625, -512.1875),
		mdl = "models/props_equipment/firepipe01.mdl",
	},
	{
		ang = Angle(88.79150390625, 110.75317382813, -69.444580078125),
		pos = Vector(-1680.09375, 3336.59375, -376.8125),
		mdl = "models/props_pipes/pipe02_90degree01.mdl",
	},
	{
		ang = Angle(0, 179.99450683594, 0),
		pos = Vector(-1054.3125, 3938.65625, -387.71875),
		mdl = "models/cityrp/door.mdl",
		mat = "models/props_c17/door01a_skin6"
	},
	{
		ang = Angle(-1.2579345703125, 98.6572265625, 0.2471923828125),
		pos = Vector(8487, 9051.3125, 327.03125),
		mdl = "models/props_electronics/keyboard-3.mdl",
	},
	{
		ang = Angle(0.0164794921875, 90.17578125, -0.0274658203125),
		pos = Vector(8478.875, 9042.34375, 288.25),
		mdl = "models/props_electronics/computer-1.mdl",
	},
	{
		ang = Angle(0, 90.010986328125, -0.1318359375),
		pos = Vector(8428.96875, 9041, 327.03125),
		mdl = "models/uc/props_unioncity/desk_clutter.mdl",
	},
	{
		ang = Angle(0.010986328125, 0.0054931640625, -0.0054931640625),
		pos = Vector(3319.90625, 5019.84375, 262.75),
		mdl = "models/props_electronics/computer-1.mdl",
	},
	{
		ang = Angle(-0.19775390625, 0, 0),
		pos = Vector(3332.34375, 5045.84375, 262.71875),
		mdl = "models/props_electronics/keyboard-3.mdl",
	},
	{
		ang = Angle(-0.0494384765625, -89.97802734375, 0),
		pos = Vector(3311.5625, 5094.03125, 262.59375),
		mdl = "models/unioncity3/props_misc/file_folders.mdl",
	},
	{
		mat = "",
		pos = Vector(1483.3125, -1980.53125, -19.218799591064),
		mdl = "models/props_lab/corkboard001.mdl",
		ang = Angle(0, 90, 0),
		smt = {
			[0] = "gbskins/corkboard2",
		},
	},
	{
		mat = "gbskins/corkboard",
		pos = Vector(1416.0625, -1983.21875, -2.6875),
		mdl = "models/props_interiors/corkboardverticle01.mdl",
		ang = Angle(0, 90, 0),
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(1379.4375, -1937.03125, 20.53125),
		mdl = "models/props_waterfront/tattoo_frames.mdl",
	},
	{
		ang = Angle(-0.0164794921875, 35.117797851563, 0.120849609375),
		pos = Vector(1441.28125, -1930.5, -95.65625),
		mdl = "models/props_waterfront/tattoo_chair_client_01.mdl",
	},
	{
		ang = Angle(-0.087890625, 89.901123046875, -0.10986328125),
		pos = Vector(1442.3125, -1968.1875, -59.625),
		mdl = "models/props_waterfront/tattoo_autoclave.mdl",
	},
	{
		ang = Angle(-0.0054931640625, 0.076904296875, -0.02197265625),
		pos = Vector(1461.75, -1971.53125, -95.5625),
		mdl = "models/props_waterfront/tattoo_table.mdl",
	},
	{
		mat = "",
		pos = Vector(1444.90625, -1892.75, -97.781196594238),
		mdl = "models/props_c17/chair_stool01a.mdl",
		ang = Angle(0.0439000017941, 51.641201019287, 0.054900001734495),
	},
	{
		mat = "",
		pos = Vector(1412.34375, -1900.40625, -95.218803405762),
		mdl = "models/props_lab/shelfcart001a.mdl",
		ang = Angle(0.30759999155998, 0, 0.28020000457764),
	},
	{
		mat = "",
		pos = Vector(1387.125, -1908.875, -95.5),
		mdl = "models/props_lab/labshelf001a.mdl",
		ang = Angle(0.0054999999701977, -89.70890045166, 0.53280001878738),
	},
	{
		mat = "",
		pos = Vector(1383.75, -1883.625, -54.718799591064),
		mdl = "models/props_junk/garbage_plasticbottle002a.mdl",
		ang = Angle(0.18680000305176, 10.854499816895, 0.46140000224113),
	},
	{
		mat = "gbskins/boxes_rdm",
		pos = Vector(1385.90625, -1870.8125, -59.531200408936),
		mdl = "models/props_junk/cardboard_box004a.mdl",
		ang = Angle(-0.16480000317097, 72.93270111084, -0.48339998722076),
	},
	{
		mat = "",
		pos = Vector(1387.84375, -1955.75, -51),
		mdl = "models/props/cs_office/paper_towels.mdl",
		ang = Angle(-0.35159999132156, 18.874500274658, -0.23620000481606),
	},
	{
		mat = "",
		pos = Vector(1388.59375, -1942.5625, -50.875),
		mdl = "models/props/cs_office/paper_towels.mdl",
		ang = Angle(-0.53280001878738, 2.1259000301361, -0.0054999999701977),
	},
	{
		mat = "gbskins/ink",
		pos = Vector(1390.8125, -1945.90625, -34.375),
		mdl = "models/props_interiors/dish_soap.mdl",
		col = {
			r = 127,
			b = 95,
			a = 255,
			g = 0,
		},
		ang = Angle(1.4940999746323, 64.01180267334, -0.36250001192093),
	},
	{
		mat = "gbskins/ink",
		pos = Vector(1390.1875, -1949.96875, -34.375),
		mdl = "models/props_interiors/dish_soap.mdl",
		col = {
			r = 0,
			b = 31,
			a = 255,
			g = 127,
		},
		ang = Angle(-0.60420000553131, -0.10440000146627, -0.30759999155998),
	},
	{
		mat = "",
		pos = Vector(1384.78125, -1956.59375, -28.781200408936),
		mdl = "models/props_lab/jar01b.mdl",
		col = {
			r = 255,
			b = 127,
			a = 255,
			g = 223,
		},
		ang = Angle(-0.30759999155998, -69.093002319336, 0.71960002183914),
	},
	{
		mat = "gbskins/ink",
		pos = Vector(1389.28125, -1956.53125, -19.468799591064),
		mdl = "models/props_interiors/dish_soap.mdl",
		col = {
			r = 0,
			b = 127,
			a = 255,
			g = 31,
		},
		ang = Angle(-1.9500999450684, -0.74159997701645, 0.52189999818802),
	},
	{
		mat = "gbskins/ink",
		pos = Vector(1382.5625, -1956.65625, -19.531200408936),
		mdl = "models/props_interiors/dish_soap.mdl",
		col = {
			r = 36,
			b = 36,
			a = 255,
			g = 36,
		},
		ang = Angle(2.6092998981476, 7.5420999526978, 0.73610001802444),
	},
	{
		mat = "gbskins/ink",
		pos = Vector(1384.59375, -1952.9375, -19.593799591064),
		mdl = "models/props_interiors/dish_soap.mdl",
		col = {
			r = 255,
			b = 0,
			a = 255,
			g = 191,
		},
		ang = Angle(-0.862399995327, 20.440099716187, 0.054900001734495),
	},
	{
		mat = "gbskins/ink",
		pos = Vector(1379.0625, -1951.78125, -18.5625),
		mdl = "models/props_interiors/dish_soap.mdl",
		col = {
			r = 127,
			b = 0,
			a = 255,
			g = 0,
		},
		ang = Angle(1.2029999494553, 8.1189002990723, -0.8899000287056),
	},
	{
		mat = "",
		pos = Vector(1384.84375, -1947.3125, -13.875),
		mdl = "models/props_lab/jar01b.mdl",
		col = {
			r = 0,
			b = 255,
			a = 255,
			g = 161,
		},
		ang = Angle(-0.25819998979568, -32.206401824951, 0.68120002746582),
	},
	{
		mat = "",
		pos = Vector(1385.25, -1940.34375, -13.8125),
		mdl = "models/props_lab/jar01b.mdl",
		col = {
			r = 127,
			b = 0,
			a = 255,
			g = 0,
		},
		ang = Angle(-0.15929999947548, -13.546099662781, 0.19230000674725),
	},
	{
		mat = "",
		pos = Vector(1383.96875, -1927.625, -11.4375),
		mdl = "models/props_lab/jar01a.mdl",
		col = {
			r = 36,
			b = 36,
			a = 255,
			g = 36,
		},
		ang = Angle(-0.13729999959469, -73.959999084473, 0.78549998998642),
	},
	{
		mat = "",
		pos = Vector(1382.8125, -1916.21875, -11.4375),
		mdl = "models/props_lab/jar01a.mdl",
		col = {
			r = 36,
			b = 36,
			a = 255,
			g = 36,
		},
		ang = Angle(0.15379999577999, -99.783302307129, 0.54379999637604),
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(8580.875, 7379.21875, 240),
		mdl = "models/diolator/phonebooth.mdl",
	},
	{
		ang = Angle(0, 33.28857421875, 0),
		pos = Vector(1767.1875, -1917.03125, -97.03125),
		mdl = "models/props/cs_militia/boxes_garage_lower_l4d2.mdl",
	},
	{
		ang = Angle(0, -85.599975585938, 0),
		pos = Vector(1691.15625, -1958.15625, -95.90625),
		mdl = "models/props_containers/storage_box_group4.mdl",
	},
	{
		ang = Angle(0, 83.776245117188, 0),
		pos = Vector(1650.25, -1971.4375, -64.3125),
		mdl = "models/props_electronics/printer-1.mdl",
	},
	{
		ang = Angle(0.1318359375, 89.82421875, 0.1043701171875),
		pos = Vector(1582.375, -1947.46875, -80.8125),
		mdl = "models/props_junk/metalgascan.mdl",
	},
	{
		ang = Angle(-0.010986328125, 101.11267089844, -0.010986328125),
		pos = Vector(1580.90625, -1937.3125, -80.8125),
		mdl = "models/props_junk/metalgascan.mdl",
	},
	{
		ang = Angle(0, -7.855224609375, 0),
		pos = Vector(1558.375, -1928.875, -47),
		mdl = "models/props_tools/toolbox-4.mdl",
	},
	{
		ang = Angle(0, 5.7073974609375, 0),
		pos = Vector(1545.53125, -1929.125, -47.15625),
		mdl = "models/props_tools/toolbox-4.mdl",
	},
	{
		ang = Angle(0, -15.485229492188, 0),
		pos = Vector(1551.65625, -1845.40625, -46.78125),
		mdl = "models/props_tools/toolbox-1.mdl",
	},
	{
		ang = Angle(0, -79.392700195313, 0),
		pos = Vector(1551.8125, -1845.03125, -78.625),
		mdl = "models/props_tools/toolbox-6.mdl",
	},
	{
		ang = Angle(0, -164.68505859375, 0),
		pos = Vector(1254.59375, -1580.25, -110.34375),
		mdl = "models/props/cs_militia/barstool01.mdl",
	},
	{
		ang = Angle(0.0054931640625, 99.058227539063, 0.010986328125),
		pos = Vector(1242.84375, -1623.59375, -95.59375),
		mdl = "models/uc/props_foliage/plant_pot.mdl",
	},
	{
		ang = Angle(0, -3.75732421875, -90),
		pos = Vector(1266.03125, -1645.375, -68.65625),
		mdl = "models/props_junk/metalgascan.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(1286.71875, -1650.53125, -74.5625),
		mdl = "models/props_junk/cardboard_box004a.mdl",
	},
	{
		ang = Angle(-0.9613037109375, 158.97216796875, 0.252685546875),
		pos = Vector(1296.90625, -1648.5625, -46.75),
		mdl = "models/props/cs_office/cardboard_box01.mdl",
	},
	{
		ang = Angle(0, 80.6396484375, 0),
		pos = Vector(1277.9375, -1653.09375, -5.5),
		mdl = "models/props_junk/cardboard_box003a.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(1312.09375, -1645.96875, -10.5),
		mdl = "models/props_junk/cardboard_box004a.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(1346.8125, -1640.59375, -4.6875),
		mdl = "models/props_junk/cardboard_box003a.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(1301.375, -1546.25, -56.15625),
		mdl = "models/props_electronics/phone-2.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(1316.9375, -1544.90625, -56.40625),
		mdl = "models/props_interiors/cashregister01.mdl",
	},
	{
		ang = Angle(0, 20.555419921875, 0),
		pos = Vector(-623.78125, 313.625, -56.03125),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-614.9375, 297.71875, -56.03125),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-615.4375, 270.09375, -56.03125),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(0, -16.902465820313, 0),
		pos = Vector(-622.6875, 250.1875, -56.03125),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-625.0625, 195.625, -56),
		mdl = "models/props_jewelery/necklace_rack-2.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-622.84375, 162, -56),
		mdl = "models/props_jewelery/watches/display_case-2.mdl",
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(-528, 144.4375, -54.03125),
		mdl = "models/props_jewelery/necklace_rack-1.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-519.5625, 136.75, -72.15625),
		mdl = "models/props_jewelery/display_case-1.mdl",
	},
	{
		ang = Angle(5.438232421875, 36.529541015625, 2.977294921875),
		pos = Vector(-518.8125, 136.78125, -70.21875),
		mdl = "models/props_jewelery/bracelet-1.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-523.46875, 147.53125, -72.46875),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(40.863647460938, 179.11560058594, 0),
		pos = Vector(-521.90625, 147.4375, -64.5625),
		mdl = "models/props_jewelery/gib-3.mdl",
	},
	{
		ang = Angle(6.1907958984375, 2.021484375, -0.3131103515625),
		pos = Vector(-518.8125, 159.75, -69.1875),
		mdl = "models/props_jewelery/gib-6.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-518.5625, 159.75, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-523.46875, 170.90625, -72.46875),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(-40.072631835938, 1.1370849609375, 3.416748046875),
		pos = Vector(-520.5, 171.125, -66.3125),
		mdl = "models/props_jewelery/gib-2.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-519.5625, 182.375, -72.15625),
		mdl = "models/props_jewelery/display_case-1.mdl",
	},
	{
		ang = Angle(7.7947998046875, 0.1043701171875, -0.010986328125),
		pos = Vector(-519.125, 182.34375, -70.15625),
		mdl = "models/props_jewelery/gib-1.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-520.25, 198.75, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(-4.5977783203125, -178.84094238281, -0.0494384765625),
		pos = Vector(-519.96875, 198.84375, -69.5),
		mdl = "models/props_jewelery/pendant-5.mdl",
	},
	{
		ang = Angle(-45, -179.5166015625, 0.0164794921875),
		pos = Vector(-523.125, 211.25, -67.6875),
		mdl = "models/props_jewelery/watches/watch_gib-1.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-526.4375, 211.375, -71.6875),
		mdl = "models/props_jewelery/watches/display_case-1.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-520.25, 223.84375, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(2.7960205078125, 0.9173583984375, -0.010986328125),
		pos = Vector(-520.34375, 223.9375, -69.3125),
		mdl = "models/props_jewelery/ring-1.mdl",
	},
	{
		ang = Angle(2.7960205078125, 0.9173583984375, -0.010986328125),
		pos = Vector(-520.34375, 223.9375, -69.3125),
		mdl = "models/props_jewelery/ring-1.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-526.4375, 237.125, -71.6875),
		mdl = "models/props_jewelery/watches/display_case-1.mdl",
	},
	{
		ang = Angle(45, 0, 0),
		pos = Vector(-523.75, 237, -67.71875),
		mdl = "models/props_jewelery/watches/watch_gib-3.mdl",
	},
	{
		ang = Angle(5.9930419921875, 0.032958984375, 0.2252197265625),
		pos = Vector(-520.5, 248.84375, -69.59375),
		mdl = "models/props_jewelery/pendant-6.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-520.25, 248.9375, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(2.7960205078125, 0.9173583984375, -0.010986328125),
		pos = Vector(-520.34375, 223.9375, -69.3125),
		mdl = "models/props_jewelery/ring-1.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-520.25, 223.84375, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-520.90625, 264.78125, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-520.875, 264.75, -69.0625),
		mdl = "models/props_jewelery/ring-4.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-525.84375, 274.625, -72.46875),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(-45, 0, 0),
		pos = Vector(-525.09375, 274.46875, -63.875),
		mdl = "models/props_jewelery/gib-5.mdl",
	},
	{
		ang = Angle(1.5985107421875, 0, -0.02197265625),
		pos = Vector(-520.96875, 287, -69.1875),
		mdl = "models/props_jewelery/ring-3.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-520.90625, 286.84375, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-525.84375, 298.03125, -72.46875),
		mdl = "models/props_jewelery/display_case-2.mdl",
	},
	{
		ang = Angle(45, 0, 0),
		pos = Vector(-526.3125, 297.9375, -63.625),
		mdl = "models/props_jewelery/pendant-7.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-520.90625, 308.90625, -72),
		mdl = "models/props_jewelery/display_case-3.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-520.9375, 308.84375, -69.0625),
		mdl = "models/props_jewelery/ring-10.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-521.96875, 330.875, -72.40625),
		mdl = "models/props_jewelery/cosmetics/cosmetics_b-13.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-524.59375, 343.5, -71.8125),
		mdl = "models/props_jewelery/cosmetics/cosmetics_b-12.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-522.6875, 355.59375, -72.25),
		mdl = "models/props_jewelery/cosmetics/cosmetics_b-10.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-523.96875, 369.96875, -72.03125),
		mdl = "models/props_jewelery/cosmetics/cosmetics_b-9.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(-6439.44, 1601.17, -21),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(-635, 678, -94),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(4695.4, 1917.36, -93.71),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(-4170.5, 4010.69, -31),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(-2432.9, 5911.56, 19.31),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(1446.74, 4132.94, -46),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(-98.78, 7406.77, 138),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, 180, 0),
		pos = Vector(3495.45, 7348.62, 138),
		mdl = "models/noirpropper/trash01.mdl",
		col = Color(119, 119, 119)
	},
	{
		ang = Angle(0, -134.99450683594, 0),
		pos = Vector(8992.0625, 8003.65625, -364),
		mdl = "models/unioncity2/propper/pipe05.mdl",
	},
}

local storage = {
	{
		ang = Angle(0, 0, 0),
		pos = Vector(444.375, -5459.8125, -260.625),
		mdl = "models/props_interiors/clipboardholder01.mdl",
	},
	{
		ang = Angle(0, -63.978881835938, 0),
		pos = Vector(466.1875, -5524.28125, -275.25),
		mdl = "models/props_lab/labmonitor005a.mdl",
	},
	{
		ang = Angle(0.0054931640625, -68.757934570313, 0),
		pos = Vector(454.59375, -5535.03125, -286.6875),
		mdl = "models/props_lab/clipboard002a.mdl",
	},
	{
		ang = Angle(-1.8951416015625, -78.8818359375, -0.0494384765625),
		pos = Vector(474.4375, -5531.84375, -287),
		mdl = "models/props_electronics/keyboard-3.mdl",
	},
	{
		ang = Angle(-0.087890625, 2.548828125, 0.076904296875),
		pos = Vector(507.1875, -5527.875, -286.96875),
		mdl = "models/props_books/paper_stack-3.mdl",
	},
	{
		ang = Angle(0.142822265625, -88.83544921875, -0.263671875),
		pos = Vector(520.8125, -5522.875, -286.875),
		mdl = "models/props_electronics/phone-4.mdl",
	},
	{
		ang = Angle(6.39404296875, 48.8671875, 0),
		pos = Vector(525.90625, -5536.5, -288),
		mdl = "models/items/worker_helmet.mdl",
	},
	{
		ang = Angle(8.162841796875, -153.33068847656, -8.45947265625),
		pos = Vector(513.6875, -5500.375, -317.90625),
		mdl = "models/props_junk/garbage_sodacan01b_crushed_fullsheet.mdl",
	},
	{
		ang = Angle(0.1318359375, -87.951049804688, 0.252685546875),
		pos = Vector(478.90625, -5368.84375, -319.3125),
		mdl = "models/props_junk/toolbox2.mdl",
	},
	{
		ang = Angle(78.848876953125, -178.28063964844, -165.52001953125),
		pos = Vector(486.6875, -5364.96875, -306.71875),
		mdl = "models/props_containers/suitcase-3.mdl",
	},
	{
		ang = Angle(-0.0274658203125, -90.7470703125, -0.06591796875),
		pos = Vector(532.53125, -5370.125, -314.3125),
		mdl = "models/props/toolbox.mdl",
	},
	{
		ang = Angle(-0.0384521484375, -3.6968994140625, -0.120849609375),
		pos = Vector(521.03125, -5366.59375, -265.59375),
		mdl = "models/props_junk/paperbox8.mdl",
	},
	{
		ang = Angle(-0.823974609375, -80.458374023438, -0.6207275390625),
		pos = Vector(540.84375, -5371.3125, -265.53125),
		mdl = "models/props_junk/paperbox1.mdl",
	},
	{
		ang = Angle(0.0384521484375, -98.750610351563, 90.087890625),
		pos = Vector(502.40625, -5372.59375, -238.09375),
		mdl = "models/props_office_supplies/box_folder-1.mdl",
	},
	{
		ang = Angle(0, -90, 0),
		pos = Vector(519.375, -5370.8125, -216.75),
		mdl = "models/unioncity2/props_alley/boxpile02.mdl",
	},
	{
		ang = Angle(-0.076904296875, -76.173706054688, 0.0274658203125),
		pos = Vector(655.125, -5391.96875, -319.4375),
		mdl = "models/props_junk/garbage_carboard002a.mdl",
	},
	{
		ang = Angle(0.02197265625, -172.69409179688, -0.1043701171875),
		pos = Vector(714.34375, -5379, -319.15625),
		mdl = "models/unioncity2/props_foliage/interiorplant05.mdl",
	},
	{
		ang = Angle(0.230712890625, -169.40368652344, 0.7635498046875),
		pos = Vector(727.125, -5493.0625, -287.875),
		mdl = "models/props_interiors/coffee_maker.mdl",
	},
	{
		ang = Angle(6.2457275390625, -150.87524414063, 0.7855224609375),
		pos = Vector(647.28125, -5503.84375, -288.875),
		mdl = "models/items/worker_helmet.mdl",
	},
	{
		ang = Angle(0.3350830078125, 6.053466796875, -0.4888916015625),
		pos = Vector(643.5, -5556.6875, -289.03125),
		mdl = "models/props_electronics/phone-4.mdl",
	},
	{
		ang = Angle(-0.6646728515625, -8.32763671875, -0.2252197265625),
		pos = Vector(657.59375, -5552.34375, -289.5625),
		mdl = "models/props_electronics/cellphone-9.mdl",
	},
	{
		ang = Angle(-0.0054931640625, -11.35986328125, 0.120849609375),
		pos = Vector(651.46875, -5578.1875, -289),
		mdl = "models/props_electronics/laptop-3.mdl",
	},
	{
		ang = Angle(0.8953857421875, 91.834716796875, 0.472412109375),
		pos = Vector(649.0625, -5604.8125, -288.96875),
		mdl = "models/props_electronics/router-1.mdl",
	},
	{
		ang = Angle(0.0274658203125, -179.64294433594, -0.384521484375),
		pos = Vector(649.53125, -5617.34375, -289.03125),
		mdl = "models/props_junk/paperbox7.mdl",
	},
	{
		ang = Angle(-11.552124023438, 93.433227539063, -90.24169921875),
		pos = Vector(680.96875, -5620.0625, -303.78125),
		mdl = "models/mr.l/cscz/cso_mp5.mdl",
	},
	{
		ang = Angle(0, 136.0546875, 0),
		pos = Vector(682.84375, -5590.0625, -319.15625),
		mdl = "models/props/cs_office/chair_office.mdl",
	},
	{
		ang = Angle(0.010986328125, 79.4091796875, 0.0164794921875),
		pos = Vector(498.625, -5578.125, -321.40625),
		mdl = "models/props_interiors/chair_office2.mdl",
	},
	{
		ang = Angle(0.0933837890625, -0.758056640625, -0.1043701171875),
		pos = Vector(554.125, -5606.28125, -280.09375),
		mdl = "models/props_lab/workspace004_stack.mdl",
	},
	{
		ang = Angle(0, 89.994506835938, 0),
		pos = Vector(593.9375, -5621.25, -319.21875),
		mdl = "models/props/rpd/panel_radiator.mdl",
	},
	{
		ang = Angle(0, 90, 0),
		pos = Vector(591.28125, -5623.21875, -244.9375),
		mdl = "models/unioncity2/propper/corkboard2.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(494.40625, -5623.59375, -276.09375),
		mdl = "models/furniture/keylocker.mdl",
	},
	{
		ang = Angle(0.2362060546875, 90.164794921875, -0.0439453125),
		pos = Vector(452.78125, -5607.875, -284.34375),
		mdl = "models/props_wasteland/controlroom_filecabinet002a.mdl",
	},
	{
		ang = Angle(0, 0, 0),
		pos = Vector(444.375, -5459.8125, -260.625),
		mdl = "models/props_interiors/clipboardholder01.mdl",
	},
	{
		ang = Angle(-0.054931640625, 176.16577148438, -0.1373291015625),
		pos = Vector(448.5625, -5337.65625, -319.53125),
		mdl = "models/props_urban/ashtray_stand001.mdl",
	},
}

table.Add(client_list, scene)
table.Add(client_list, storage)