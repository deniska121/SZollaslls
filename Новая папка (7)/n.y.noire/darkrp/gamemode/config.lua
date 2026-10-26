--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--[[
Toggle settings
Set to true or false
]]
DarkRP.Food = {}
DarkRP.Ammo = {}
DarkRP.Teams = {}
DarkRP.Weapons = {}
DarkRP.Entities = {}
DarkRP.Junk = {}
DarkRP.Stations = {}
DarkRP.LockMoney = {}
-- arrestspeed - Sets the max arrest speed.
GM.Config.arrestspeed = 90
-- demotetime - Number of seconds before a player can rejoin a team after demotion from that team.
GM.Config.demotetime = 600
-- doorcost - Sets the cost of a door.
GM.Config.doorcost = 300
-- entremovedelay - how long to wait before removing a bought entity after disconnect.
GM.Config.entremovedelay = 120
-- jailtimer - Sets the jailtimer. (in seconds)
GM.Config.jailtimer = 300
-- normalsalary - Sets the starting salary for newly joined players.
GM.Config.normalsalary = 0
-- propcost - How much prop spawning should cost. (prop paying must be enabled for this to have an effect)
GM.Config.propcost = 10
-- respawntime - Minimum amount of seconds a player has to wait before respawning.
GM.Config.respawntime = 240
-- runspeed - Sets the max running speed.
GM.Config.runspeed = 250
-- runspeed - Sets the max running speed for CP teams
GM.Config.runspeedcp = 270
-- startingmoney - your wallet when you join for the first time.
GM.Config.startingmoney = 1000
-- vehiclecost - Sets the cost of a vehicle (To own it).
GM.Config.vehiclecost = 30
-- wantedtime - Number of seconds for which a player is wanted for.
GM.Config.wantedtime = 1200
-- walkspeed - Sets the max walking speed.
GM.Config.walkspeed = 100

GM.FilterWords = {
	["chieftain.cc"] = true,
	["chieftain. cc"] = true,
	["chieftain .cc"] = true,
	["chieftain cc"] = true,
	["c h i e f t a i n"] = true,
}

-- VoiceDist - Dist for voice caht
GM.Config.VoiceDist = {
	[1] = 120,
	[2] = 500,
	[3] = 1000,
}

-- Jain and UnJail Pos
GM.Config.Positions = {
	["JailNPC"] = Vector(8405.12109375,7719.2504882813,200.03125),
	["Jail"] = Vector(9126.1884765625, 8429.9736328125, 200.03125),
	["UnJail"] = Vector(8056.96875, 7903.3203125, 200.03125),
	["Evedence"] = Vector(8743.96875, 7750.5522460938, 200.03125),
	["CityHall"] = Vector(2509.96875, 5048.220703125, 0.03125),
	["Hospital"] = Vector(7531.201171875,5347.96875,-55.96875),
}

GM.Config.PDs = {
	[1] = {Vector(-12323.711914063, -9947.96875, -255.96875), 4000},
	[2] = {Vector(8934.3486328125, 8485.34375, 27.210130691528), 4000},
}

GM.Config.ChopShop = {
	[1] = Vector(3661.6875, -2171.53125, -126.65625),
	[2] = Vector(3026.875, -1401, 55.84375),
}

GM.Config.PoliceArmory = {
	[1] = {Vector(8832.640625,7610.6977539063,-439.96875), 500},
}

McINV = McINV or {}
GM.Config.currency = "$"

GM.Config.DisallowDrop = {
	["arrest_stick"] = true,
	["stungun"] = true,
	["door_ram"] = true,
	["gmod_camera"] = true,
	["gmod_tool"] = true,
	["keys"] = true,
	["pill_wep_holstered"] = true,
	["deployment"] = true,
	["event_real"] = true,
	["fire_hose"] = true,
	["event_item"] = true,
	["weapon_simfillerpistol"] = true,
	["lockpick"] = false,
	["med_kit"] = true,
	["med_pd"] = true,
	["pocket"] = true,
	["stunstick"] = true,
	["unarrest_stick"] = true,
	["weapon_keypadchecker"] = true,
	["weapon_physcannon"] = true,
	["weapon_physgun"] = true,
	["weapon_fists"] = true,
	["weaponchecker"] = true,
	["keypad_cracker"] = true,
	["admin_keypad_cracker"] = true,
	["police_glock"] = true,
	["police_sw"] = true,
	["police_p320"] = true,
	["police_beanbag"] = true,
	["police_m590"] = true,
	["police_mp5"] = true,
	["police_m4"] = true,
	["police_mk18"] = true,
	["police_mk20"] = true,
	["weapon_ram"] = true,
	["weapon_jail"] = true,
	["weapon_taser"] = true,
	["mlw_tonfa"] = true,
	["mlw_policelight"] = true,
	["weapon_simrepair"] = true
}

GM.Config.HolsterData = {
	["mwb_m4"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_m4a1"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["police_m4"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["police_mk18"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_spapa12"] = {"ValveBiped.Bip01_Spine2", Vector(12, 1.2, -2), Angle(0, 0, 180)},
	["mwb_m590"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_ithaca"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["police_beanbag"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["police_m590"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_akm"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_ak74"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_ak74u"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_mk17"] = {"ValveBiped.Bip01_Spine2",Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_marlin"] = {"ValveBiped.Bip01_Spine2",Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_kar98"] = {"ValveBiped.Bip01_Spine2",Vector(12, 4.5, 1), Angle(0, 180, 0)},
	["police_mk20"] = {"ValveBiped.Bip01_Spine2",Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_aug"] = {"ValveBiped.Bip01_Spine2", Vector(1, 2.5, 2), Angle(0, 0, 0)},
	["mwb_auga2"] = {"ValveBiped.Bip01_Spine2", Vector(1, 2.5, 2), Angle(0, 0, 0)},
	["mwb_mp5"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["police_mp5"] = {"ValveBiped.Bip01_Spine2", Vector(-5, 2.5, 2), Angle(0, 0, 0)},
	["mwb_uzi"] = {"ValveBiped.Bip01_Spine2", Vector(1, 2.5, 2), Angle(0, 0, 0)},
	["mwb_thompson"] = {"ValveBiped.Bip01_Spine2", Vector(1, 2.5, 2), Angle(0, 0, 0)},
	["mwb_357"] = {"ValveBiped.Bip01_R_Thigh", Vector(2, 0, -4.2), Angle(-110, 0, 0)},
	["mwb_deagle"] = {"ValveBiped.Bip01_R_Thigh", Vector(2, 0, -5), Angle(-110, 0, 0)},
	["mwb_glock21"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -2, -3), Angle(180, 90, 0)},
	["mwb_glock17"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -2, -3), Angle(180, 90, 0)},
	["mwb_glock19"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
	["mwb_p220"] = {"ValveBiped.Bip01_Pelvis", Vector(-8, -3, -3), Angle(180, 90, 0)},
	["police_glock"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
	["mwb_tec9"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -2, -3), Angle(180, 90, 0)},
	["police_glock21"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
	["police_m1911"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
	["mwb_m1911"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
	["mwb_sw4506"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
	["police_sw"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
	["mwb_pm"] = {"ValveBiped.Bip01_Pelvis", Vector(-8, -8, -3), Angle(180, 90, 0)},
}

GM.Config.FFL = {
	["attachment_vm_pi_mike9_barauto_diamatti"] = true,
	["att_vm_silencer04_pstl"] = true,
	["att_vm_pi_golf18_slide"] = true,
	["att_vm_silencer02_pstl"] = true,
	["attachment_vm_pi_tec9_bolt"] = true,
	["attachment_vm_pi_mike_barsil"] = true,
	["attachment_vm_pi_mike_barauto"] = true,
}

GM.Config.PushIgnore = {
	["gmod_sent_vehicle_fphysics_base"] = true,
	["gmod_sent_vehicle_fphysics_wheel"] = true,
	["spawned_food"] = true,
	["spawned_storage"] = true,
	["spawned_weapon"] = true,
	["spawned_ammo"] = true,
	["spawned_junk"] = true,
}

-- GM.Config.HolsterDataSV = {
-- 	["mwb_akm"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_ak74"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_ak74u"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_m4"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_m4a1"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["police_m4"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["police_mk18"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_m590"] = {"ValveBiped.Bip01_Spine2", Vector(4.7, -8, -3.2), Angle(90, 0, 70)},
-- 	["mwb_ithaca"] = {"ValveBiped.Bip01_Spine2", Vector(4.7, -8, -3.2),Angle(90, 0, 70)},
-- 	["police_beanbag"] = {"ValveBiped.Bip01_Spine2", Vector(4.7, -8, -3.2), Angle(90, 0, 70)},
-- 	["police_m590"] = {"ValveBiped.Bip01_Spine2", Vector(4.7, -8, -3.2), Angle(90, 0, 70)},
-- 	["mwb_mk17"] = {"ValveBiped.Bip01_Spine2",Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_marlin"] = {"ValveBiped.Bip01_Spine2",Vector(6.7, -2, -7.7), Angle(-90, 90, 0)},
-- 	["police_mk20"] = {"ValveBiped.Bip01_Spine2",Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_mp5"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["police_mp5"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_aug"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_auga2"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -2, -3.8), Angle(-90, 90, 0)},
-- 	["mwb_kar98"] = {"ValveBiped.Bip01_Spine2",Vector(6.7, -12, -3.2), Angle(90, 90, 0)},
-- 	["mwb_uzi"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -6, -5.8), Angle(-90, 90, 0)},
-- 	["mwb_thompson"] = {"ValveBiped.Bip01_Spine2", Vector(1.7, -16, -3.8), Angle(180, 180, -90)},
-- 	["mwb_spapa12"] = {"ValveBiped.Bip01_Spine2", Vector(6.7, -15, -10), Angle(90, -90, 0)},
-- 	["mwb_357"] = {"ValveBiped.Bip01_R_Thigh", Vector(2, 0, -4.2), Angle(-110, 0, 0)},
-- 	["mwb_deagle"] = {"ValveBiped.Bip01_R_Thigh", Vector(2, 0, -5), Angle(-110, 0, 0)},
-- 	["mwb_glock21"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -2, -3), Angle(180, 90, 0)},
-- 	["mwb_glock17"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -2, -3), Angle(180, 90, 0)},
-- 	["mwb_glock19"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
-- 	["police_glock"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
-- 	["mwb_tec9"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -2, -3), Angle(180, 90, 0)},
-- 	["police_glock21"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
-- 	["police_m1911"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
-- 	["mwb_m1911"] = {"ValveBiped.Bip01_Pelvis", Vector(-9, -8, -3), Angle(180, 90, 0)},
-- 	["mwb_m9"] = {"ValveBiped.Bip01_Pelvis", Vector(-8, -8, -3), Angle(180, 90, 0)},
-- 	["mwb_93r"] = {"ValveBiped.Bip01_Pelvis", Vector(-8, -8, -3), Angle(180, 90, 0)},
-- }

GM.Config.DefaultWeapons = {"keys",}

GM.Config.DisabledModules = {
	["sleep"] = true,
}

GM.Config.DefaultLaws = {}

GM.Config.TattooSalon = Vector(-384.08697509766,8885.916015625,128.03125)

GM.Config.Trash = {Vector(-9538.8603515625, 2008.6378173828, -9.96875), Vector(-8905.0126953125, 2740.84765625, -9.96875), Vector(-8630.2255859375, 3636.0830078125, -49.96875), Vector(-6435.3876953125, 1768.8370361328, -41.968757629395), Vector(-6234.4184570313, 3822.1762695313, -45.041687011719), Vector(-5084.1645507813, 12673.732421875, 125.89340209961), Vector(-4115.5927734375, 12018.90234375, 124.43934631348), Vector(-2263.7590332031, 12634.575195313, 118), Vector(-283.65112304688, 11783.150390625, 118.03125), Vector(5.376823425293, 13959.85546875, 118.03125), Vector(2700.9865722656, 10739.041015625, 118.03125), Vector(4303.5825195313, 7768.6684570313, 123.59030151367), Vector(920.27758789063, 7615.95703125, 97.535820007324), Vector(110.33811950684, 7515.1967773438, 118.03125), Vector(-5.1569442749023, 7391.0854492188, 161.78582763672), Vector(-160.43432617188, 7445.5615234375, 118.03125), Vector(-4412.0375976563, 7300.4072265625, 122.81837463379), Vector(-4451.9560546875, 7229.4262695313, 161.78582763672), Vector(-3758.1115722656, 6606.41796875, 38.03125), Vector(-3811.7897949219, 6576.607421875, 81.808525085449), Vector(-2633.3522949219, 6032.9340820313, 3.541877746582), Vector(-887.93127441406, 543.48748779297, -113.96875), Vector(1623.1439208984, 3533.3103027344, -113.96875), Vector(1459.1728515625, 4283.5078125, -65.968757629395), Vector(1440.1618652344, 4241.09375, -22.191482543945), Vector(4198.7700195313, 1799.5692138672, -112.55675506592), Vector(4146.8154296875, 1759.1973876953, -70.214179992676), Vector(4557.3012695313, 822.97760009766, -104.6697769165), Vector(5660.876953125, 5252.1904296875, -65.968753814697)}

GM.Config.DumpCO = {Vector(-2432.8178710938, 5920.5893554688, 1.6473846435547), Vector(-4171.8100585938, 4010.8359375, -46.352630615234), Vector(-6441.74609375, 1604.3920898438, -38.352638244629), Vector(-633.57189941406, 684.67932128906, -110.35264587402), Vector(1442.5346679688, 4131.3735351563, -62.352630615234), Vector(4696.0805664063, 1918.6944580078, -110.35263061523), Vector(3501.1513671875, 7343.4296875, 121.64736938477), Vector(-100.65339660645, 7406.2788085938, 121.64738464355)}

--GM.Config.DeathView = {origin = Vector(7351,5356,629), angles = Angle(15,-50,0), fov = 75}
GM.Config.DeathView = {origin = Vector(-3555.1877441406,5103.96875,-9110), angles = Angle(90,180,0), fov = 75}

GM.Config.PoliceCars = {
	["sim_fphys_l4d_police_city"] = true,
	["sim_fphys_l4d_police_city2"] = true,
	["sim_cherokee_police"] = true,
	["sim_fphys_l4d_police_rural"] = true,
	["sim_fphys_l4d_police_pickup2"] = true,
	["sim_fphys_l4d_swat"] = true,
	["sim_fphys_l4d_hmmwv"] = true,
	["sim_fphys_l4d_army_truck"] = true,
	["sim_fphys_l4d_apc"] = true,
	["sim_fphys_l4d_cbus"] = true
}

GM.Config.GovCarsPB = {
	["sim_fphys_l4d_swat"] = true,
	["sim_fphys_l4d_fire_engine"] = true,
	["sim_fphys_l4d_fire_truck"] = true,
	["sim_fphys_l4d_police_city"] = true,
	["sim_cherokee_police"] = true,
	["sim_fphys_l4d_police_city2"] = true,
	["sim_fphys_l4d_police_rural"] = true,
	["sim_fphys_l4d_ambulance"] = true,
	["sim_fphys_l4d_police_pickup"] = true,
	["sim_fphys_l4d_police_pickup2"] = true,
}

GM.Config.GovCars = {
	["sim_fphys_l4d_ambulance"] = true,
	["sim_fphys_l4d_fire_truck"] = true,
	["sim_fphys_l4d_fire_engine"] = true,
	["sim_fphys_l4d_police_pickup"] = true,
	["sim_fphys_l4d_bus"] = true,
	["sim_fphys_l4d_bus2"] = true,
	["sim_fphys_l4d_taxi_city"] = true,
	["sim_fphys_l4d_taxi_rural"] = true,
	["sim_fphys_l4d_taxi_old"] = true,
	["sim_fphys_l4d_trash_truck"] = true,
	["sim_fphys_l4d_pickup_tow"] = true,
	["sim_fphys_l4d_deliveryvan"] = true,
	["sim_fphys_l4d_cement_truck"] = true,
	["sim_fphys_l4d_utility_truck_m"] = true,
	["sim_fphys_l4d_van_m_e"] = true
}

GM.Config.wmfix = {
	["models/kyo/wm_pi_x12.mdl"] = "models/weapons/w_pistol.mdl",
	["models/viper/mw/weapons/w_romeo870.mdl"] = "models/weapons/w_shotgun.mdl",
}

table.Merge(GM.Config.GovCars, GM.Config.PoliceCars)

DarkRP.RestrictedCT = {
	["Magazine"] = true,
	["Magazines"] = true,
}

DarkRP.NonDelete = {
	["pills*"] = true,
	["parts_*"] = true,
	["hookah"] = true,
	["bong"] = true,
	["helmet"] = true,
	["boombox"] = true,
	["radio"] = true,
	["chefhat"] = true,
	["hardhat"] = true,
	["foilhat"] = true,
	["gasmask"] = true,
	["weldingmask"] = true,
	["joint"] = true,
	["sigar"] = true,
	["toolbox"] = true,
	["ied_charge"] = true,
	["car_radio"] = true,
	["armor"] = true,
	["bandage"] = true,
	["junk_cheap"] = true,
	["junk_medium"] = true,
	["junk_rich"] = true,
	["phone_bj"] = true,
	["phone_se"] = true,
	["phone_n"] = true,
	["phone_mc"] = true,
	["phone_bg"] = true,
	["phone_lm"] = true,
	["done_heroin"] = true,
	["done_coca"] = true,
	["done_heroin_small"] = true,
	["dry_opium_small"] = true,
	["done_heroin_syr"] = true,
	["done_coca_small"] = true,
	["done_meth"] = true,
	["done_meth_small"] = true,
	["dry_weed_small"] = true,
	["fentanyl"] = true,
	["craft_coca"] = true,
	["craft_coca_small"] = true,
	["craft_sphingosine"] = true,
	["craft_meth"] = true,
	["craft_meth_ice"] = true,
}

DarkRP.InterCAT = {
	["attachment_vm_ar_akilo47_smgstock"] = "attachment_vm_ar_akilo47_smgstock_unfolded",
	["attachment_vm_ar_akilo47_smgstock_unfolded"] = "attachment_vm_ar_akilo47_smgstock",
	["attachment_vm_sm_uzulu_stock_folded"] = "attachment_vm_sm_uzulu_stock",
	["attachment_vm_sm_uzulu_stock"] = "attachment_vm_sm_uzulu_stock_folded",
	["attachment_vm_sm_mpapa5_stock"] = "attachment_vm_sm_mpapa5_stock_nostock",
	["attachment_vm_sm_mpapa5_stock_nostock"] = "attachment_vm_sm_mpapa5_stock",
	["mac10_stock_mac10"] = "mac10_f_stock_mac10",
	["mac10_f_stock_mac10"] = "mac10_stock_mac10",
	["attachment_vm_sm_augolf_vertgrip01"] = "att_grip",
	["att_grip"] = "attachment_vm_sm_augolf_vertgrip01",
	["attachment_vm_ar_mike4_stock_def"] = "attachment_vm_ar_mike4_stock_v2",
	["attachment_vm_ar_mike4_stock_v2"] = "attachment_vm_ar_mike4_stock_def",
	["attachment_sh_t9semiauto_stock"] = "attachment_sh_t9semiauto_mixstock01",
	["attachment_sh_t9semiauto_mixstock01"] = "attachment_sh_t9semiauto_stock",
}

DarkRP.SameAtts = {
	["attachment_vm_ar_mike4_angledgrip01"] = "att_vm_angledgrip01",
	["attachment_vm_ar_mike4_stubbygrip01"] = "att_vm_stubbygrip01",
	["attachment_vm_ar_mike4_vertgrip01"] = "att_vm_vertgrip01",
	["attachment_vm_ar_mike4_vertgrip03"] = "att_vm_vertgrip03",
	["attachment_vm_ar_scharlie_angledgrip01"] = "att_vm_angledgrip01",
	["attachment_vm_ar_scharlie_stubbygrip01"] = "att_vm_stubbygrip01",
	["attachment_vm_ar_scharlie_vertgrip01"] = "att_vm_vertgrip01",
	["attachment_vm_ar_scharlie_vertgrip03"] = "att_vm_vertgrip03",
	["attachment_vm_ar_akilo47_angledgrip01"] = "att_vm_angledgrip01",
	["attachment_vm_ar_akilo47_stubbygrip01"] = "att_vm_stubbygrip01",
	["attachment_vm_ar_akilo47_vertgrip01"] = "att_vm_vertgrip01",
	["attachment_vm_ar_akilo47_vertgrip03"] = "att_vm_vertgrip03",
	["att_vm_pi_decho_laser01"] = "att_vm_laser01_pstl",
	["att_vm_pi_decho_laser03"] = "att_vm_laser03_pstl",
	["attachment_vm_ar_scharlie_laser03"] = "attachment_vm_ar_mike4_laser03",
}

DarkRP.ATWeight = {
	["att_vm_silencer06"] = 0.2,
	["mac_grip_mac10"] = 0.01,
	["mac_longmuz_mac10"] = 0.3,
	["attachment_vm_pi_papa320_silencer"] = 0.2,
	["attachment_vm_pi_mike1911_muzzlebrake"] = 0.09,
	["attachment_vm_pi_mike9_compensator"] = 0.09,
	["att_vm_compensator01_pstl"] = 0.07,
	["att_vm_compensator01"] = 0.07,
	["att_vm_muzzlebrake01"] = 0.07,
	["att_vm_flashhider04"] = 0.07,
	["att_vm_flashhider01"] = 0.07,
	["att_vm_muzzlebrake01_pstl"] = 0.05,
	["att_vm_flashhider01_pstl"] = 0.05,
	["attachment_vm_sm_uzulu_suppressor"] = 0.7,
	["attachment_vm_sm_uzulu_stockh"] = 0.4,
	["attachment_vm_sm_uzulu_barcust"] = 0.21,
	["attachment_vm_sm_uzulu_barlong"] = 0.2,
	["attachment_vm_sm_uzulu_barmid"] = 0.08,
	["attachment_vm_sm_uzulu_barmid"] = -0.08,

	["att_vm_pi_golf21_stock"] = 0.2,
	["attachment_vm_pi_mike9_stock"] = 0.2,
	["attachment_vm_pi_mike_stockh"] = 0.5,
	["attachment_vm_pi_mike_stockl"] = 0.09,
	["att_vm_stock_no"] = -0.4,
	["attachment_vm_ar_scharlie_stock_light"] = -0.1,
	["att_vm_stock_heavy01"] = 0.01,
	["attachment_vm_ar_scharlie_stock_dmr"] = 0.1,
	["att_vm_stock_heavy02"] = 0.05,
	["att_vm_stock_medium01"] = -0.03,
	["att_vm_stock_light01"] = -0.07,
	["attachment_vm_ar_scharlie_barrel_mid"] = 0.2,
	["attachment_vm_ar_scharlie_barrel_long"] = 0.35,
	["attachment_vm_ar_scharlie_barrel_pdw"] = -0.18,
	["attachment_vm_ar_mike4_customstock"] = 0.05,
	["attachment_vm_ar_mike4_stockno"] = -0.1,
	["attachment_vm_sm_mpapa5_stock_fullstock"] = 0.35,
	["attachment_vm_sm_mpapa5_barrel_suppressor"] = 0.25,
	["attachment_vm_sm_mpapa5_barrel_suppshort"] = 0.2,
	["att_vm_minireddot03"] = 0.2,
	["att_vm_reflex_east02_tall"] = 0.27,
	["att_vm_reflex_west03"] = 0.15,
	["attachment_vm_pi_mike9_scope"] = 0.43,
	["att_vm_hybrid_west02"] = 0.65,
	["att_vm_hybrid_west03"] = 0.71,
	["att_vm_hybrid_west01"] = 0.7,
	["att_vm_charlie725_2x_west01"] = 0.6,
	["att_vm_4x_west01_tall"] = 0.65,
	["att_vm_2x_west01"] = 0.6,
	["att_vm_thermal_east01"] = 0.6,
	["att_vm_charlie725_scope_mike14"] = 0.95,
	["att_vm_charlie725_scope_vz"] = 0.92,
	["att_vm_scope_mike14"] = 0.95,
	["attachment_vm_ar_akilo47_rail"] = 0.1,
	["attachment_vm_ar_mike4_carryhandle"] = 0.01,
	["attachment_vm_sm_mpapa5_railgrip"] = -0.03,
	["attachment_vm_sm_mpapa5_barrel_noflash"] = -0.01,
	["attachment_vm_sm_mpapa5_barshort"] = -0.1,
	["att_vm_pi_golf21_slide_black"] = -0.01,
	["att_vm_pi_golf21_slide_long"] = 0.02,
	["att_vm_pi_golf21_slide_auto"] = -0.02,
	["att_vm_pi_golf18_slide"] = -0.01,
	["attachment_vm_pi_mike9_pstlgrplght"] = -0.02,
	["att_vm_flashhider01_pstl"] = 0.02,
	["attachment_vm_pi_mike9_pstlgrpcust"] = 0.02,
	["attachment_vm_pi_mike9_gripvert"] = 0.05,
	["attachment_vm_pi_mike9_barauto"] = 0.1,
	["attachment_vm_pi_mike9_barlight"] = -0.01,
	["attachment_vm_pi_mike9_barlong"] = 0.05,
	["attachment_vm_pi_decho_slide_extended02"] = 0.3,
	["attachment_vm_pi_decho_slide_extended"] = 0.12,
	["attachment_vm_pi_mike1911_v2_slide"] = 0.01,
	["attachment_vm_pi_mike1911_barlong"] = 0.02,
	["attachment_vm_pi_mike1911_barshort"] = -0.02,
	["att_vm_pi_cpapa_stock01"] = 0.23,
	["att_vm_pi_cpapa_stock02"] = 0.15,
	["att_vm_pi_cpapa_barrel02"] = 0.05,
	["att_vm_pi_cpapa_barrel_long"] = 0.08,
	["att_vm_pi_cpapa_barrel_short"] = -0.03,
	["attachment_vm_pi_mike_pistolgrip02"] = -0.01,
	["attachment_vm_pi_mike_pistolgrip01"] = 0.01,
	["attachment_vm_pi_mike_barauto"] = 0.1,
	["attachment_vm_pi_mike_barsil"] = 0.2,
	["attachment_vm_sh_charlie725_stock"] = 0.3,
	["attachment_vm_sh_charlie725_stocktactical"] = 0.31,
	["attachment_vm_sh_charlie725_stocklight"] = 0.32,
	["attachment_vm_sh_charlie725_stockstable"] = 0.35,
	["attachment_vm_sh_charlie725_barrel"] = 0.8,
	["attachment_vm_sh_charlie725_barrel_mid"] = 1,
	["attachment_vm_sh_charlie725_barrel_long"] = 1.2,
	["attachment_vm_sh_charlie725_forendtactical"] = -0.1,
	["attachment_vm_sh_charlie725_foreendlight"] = -0.17,
	["attachment_vm_sh_charlie725_forendstable"] = 0.05,
	["attachment_vm_sh_romeo870_pumpalt"] = 0.01,
	["attachment_vm_sh_romeo870_pump_wood"] = 0.08,
	["attachment_vm_sh_romeo870_pump_custom"] = 0.01,
	["attachment_vm_sh_romeo870_stock_pistolgrip"] = -0.3,
	["att_vm_romeo870_stock_medium01"] = 0.01,
	["att_vm_romeo870_stock_heavy01"] = 0.02,
	["att_vm_romeo870_stock_heavy02"] = 0.04,
	["attachment_vm_sh_romeo870_stock_wood"] = 0.1,
	["att_vm_romeo870_stock_light01"] = -0.01,
	["590_eft_pump_870def"] = -0.03,
	["590_eft_pump_590_wood"] = 0.02,
	["590_no_rail"] = 0.01,
	["590_base_iro"] = 0.01,
	["590_eft_barrel_v3"] = 0.01,
	["590_eft_pump_590def"] = -0.01,
	["magpul_sga_stock"] = -0.07,
	["mwii_590_no_stock"] = -0.15,
	["590_mwii_barrel_v1"] = 0.08,
	["590_mwii_barrel_v2"] = -0.2,
	["590_eft_barrel_v1"] = -0.22,
	["590_eft_barrel_fg"] = -0.2,
	["590_eft_barrel_1897"] = -0.02,
	["590_eft_barrel_v4"] = -0.01,
	["590_mwii_barrel_v3"] = 0.01,

	["attachment_vm_ar_mike4_barrel"] = 0.15,
	["attachment_vm_ar_mike4_barsil"] = 0.65,
	["attachment_vm_ar_mike4_custombarrel"] = 0.65,
	["attachment_vm_ar_mike4_shortbarrel"] = -0.15,
	["attachment_vm_ar_mike4_barrel_v3_alt"] = -0.15,

	["attachment_vm_sm_augolf_arrail"] = -0.3,
	["attachment_vm_sm_augolf_stocks"] = -0.08,
	["attachment_vm_sm_augolf_stockl"] = 0.02,
	["attachment_vm_sm_augolf_stock_tactical"] = 0.1,
	["attachment_vm_sm_augolf_lmgbarrel"] = 0.3,
	["attachment_vm_sm_augolf_smgbarrel"] = -0.3,
	["attachment_vm_ar_akilo47_smgbarrel"] = -0.35,
	["attachment_vm_ar_akilo47_smgbarcust"] = -0.3,
	["attachment_vm_ar_akilo47_lmgbarrel"] = 1.1,
	["attachment_vm_ar_akilo47_lmgbarrel_grip"] = 1.15,
	["attachment_vm_ar_akilo47_custombarrel"] = 0.05,
	["attachment_vm_ar_akilo47_stockno"] = -0.39,
	["attachment_vm_ar_akilo47_smgstock_unfolded"] = -0.1,
	["attachment_vm_ar_akilo47_smgstock"] = -0.1,
	["attachment_vm_ar_akilo47_lmgstock"] = 0.9,
	["attachment_vm_sn_sbeta_stock_tactical"] = 0.1,
	["attachment_vm_sn_sbeta_stock_stable"] = 0.2,
	["attachment_vm_sn_sbeta_stock_light"] = -0.5,
	["attachment_vm_sn_sbeta_barshort"] = 0.15,
	["attachment_vm_sn_sbeta_barmid"] = 0.27,
	["attachment_vm_sn_sbeta_barlong"] = 0.39,
	["attachment_vm_sn_kilo98_stocks"] = 0.1,
	["attachment_vm_sn_kilo98_stock_tactical"] = 0.2,
	["attachment_vm_sn_kilo98_stockl"] = -0.5,
}

DarkRP.DonationAT = {
	["vm_thotel_stock_hv_00"] = true,
	["vm_sm_thotel_angled_00"] = true,
	["vm_thotel_barrel_l_00"] = true,
	["att_reargrip_golf"] = true,
	["sw4506_receiver"] = true,
	["sw4506_slide"] = true,
}

DarkRP.AttCost = {
	-- new
	["att_vm_pi_cpapa_barrel_long"] = 20,
	["att_vm_pi_cpapa_barrel_short"] = -20,
	["attachment_vm_sh_charlie725_barrel_long"] = 50,
	["attachment_vm_pi_decho_slide_extended02"] = 72,
	["attachment_vm_pi_decho_slide_extended"] = 450,
	["att_vm_pi_golf17_slide"] = 72,
	["att_vm_pi_golf17_slide_light"] = 72,
	["att_vm_pi_golf18_slide"] = 800,
	["attachment_vm_ar_mike4_receiver_black"] = 50,
	["attachment_vm_ar_mike4_receiver"] = 150,
	["attachment_vm_ar_mike4_barrel_v2"] = 300,
	["attachment_vm_ar_mike4_shortbarrel"] = 200,
	["attachment_vm_ar_mike4_barrel_v3_alt"] = 220,
	["attachment_vm_ar_mike4_custombarrel"] = 400,
	["attachment_vm_sm_mpapa5_receiver_v2"] = 800,
	["attachment_vm_ar_mike16_bolt"] = 800,
	["attachment_vm_ar_akilo47_bolt"] = 800,
	["attachment_vm_ar_mike4_bolt"] = 800,
	["attachment_vm_sm_mpapa5_barrel_suppressor"] = 380,

	["attachment_vm_ar_scharlie_barrel_pdw"] = -100,
	["attachment_vm_ar_scharlie_barrel_long"] = 300,

	["attachment_vm_sn_sbeta_barshort"] = 70,
	["attachment_vm_sn_sbeta_barmid"] = 90,
	["attachment_vm_sn_sbeta_barlong"] = 120,
	["mac_longmuz_mac10"] = 72,
	["attachment_vm_sm_uzulu_barshort"] = 72,
	["attachment_vm_sm_uzulu_barmid"] = 72,
	["attachment_vm_sm_uzulu_barlong"] = 72,
	["attachment_vm_sm_uzulu_barcust"] = 72,
	["590_mwii_barrel_v1"] = 200,
	["590_eft_barrel_v1"] = -200,

	["attachment_vm_pi_mike_barauto"] = 800,
	["attachment_vm_pi_mike_barsil"] = 150,
	["attachment_vm_pi_mike_pistolgrip01"] = 72,
	["attachment_vm_pi_mike_pistolgrip02"] = 72,
	["attachment_vm_pi_mike_pistolgrip03"] = 72,
	-- oldcc
	["mac_grip_mac10"] = 10,
	["attachment_vm_ar_akilo47_laser03_cylinder"] = 850,
	["att_vm_pi_decho_laser03"] = 850,
	["att_vm_laser03_pstl"] = 850,
	["att_vm_pi_mike1911_laser03"] = 850,
	["att_vm_pi_mike9_laser03"] = 850,
	["att_vm_pi_cpapa_laser03"] = 850,
	["attachment_vm_sh_charlie725_laser03"] = 850,
	["attachment_vm_ar_akilo47_laser02_cylinder"] = 850,
	["att_vm_pi_mike1911_laser02"] = 850,
	["att_vm_pi_mike9_laser02"] = 850,
	["att_vm_laser02_pstl"] = 850,
	["att_vm_pi_decho_laser02"] = 850,
	["att_vm_pi_cpapa_laser02"] = 850,
	["attachment_vm_sh_charlie725_laser02"] = 850,
	["attachment_vm_ar_akilo47_laser01_cylinder"] = 850,
	["att_vm_pi_mike1911_laser01"] = 850,
	["att_vm_pi_mike9_laser01"] = 850,
	["att_vm_pi_cpapa_laser01"] = 850,
	["attachment_vm_sh_charlie725_laser01"] = 850,
	["att_vm_laser01_pstl"] = 850,
	["att_vm_pi_decho_laser01"] = 850,
	["attachment_vm_sn_sbeta_stock_stable"] = 72,
	["attachment_vm_sn_sbeta_stock_light"] = 72,
	["attachment_vm_sn_kilo98_stocks"] = 70,
	["attachment_vm_sn_kilo98_stock_tactical"] = 80,
	["att_vm_minireddot01_tall"] = 150, --removed
	["attachment_vm_sn_kilo98_stockl"] = 50,
	["att_vm_silencer06"] = 400,
	["att_vm_flashhider01"] = 30,
	["att_vm_flashhider01_pstl"] = 30,
	["att_vm_muzzlebrake01"] = 40,
	["attachment_vm_pi_mike1911_muzzlebrake"] = 40,
	["att_vm_muzzlebrake01_pstl"] = 40,
	["att_vm_compensator01"] = 45,
	["att_vm_compensator01_pstl"] = 45,
	["attachment_vm_pi_mike9_compensator"] = 55,
	["att_vm_silencer_east01"] = 300,
	["attachment_vm_pi_papa320_silencer"] = 420,
	["att_vm_silencer01_pstl"] = 380,
	["att_vm_flashhider04"] = 50,
	["att_vm_minireddot03"] = 200,
	["att_vm_reflex_east02_tall"] = 300,
	["att_vm_reflex_west02_tall"] = 150, -- removed
	["att_vm_reflex_west03"] = 150,
	["attachment_vm_pi_mike9_scope"] = 550,
	["att_vm_hybrid_west02"] = 1530,
	["att_vm_hybrid_west03"] = 1500,
	["att_vm_hybrid_west01"] = 1900,
	["att_vm_charlie725_2x_west01"] = 700,
	["att_vm_4x_west01_tall"] = 930,
	["att_vm_2x_west01"] = 700,
	["att_vm_thermal_east01"] = 3750,
	["att_vm_charlie725_scope_mike14"] = 2570,
	["att_vm_charlie725_scope_vz"] = 3130,
	["att_vm_scope_mike14"] = 2570,
	["attachment_vm_ar_akilo47_rail"] = 15,
	["att_vm_romeo870_stock_heavy01"] = 330,
	["att_vm_romeo870_stock_light01"] = 320,
	["att_vm_romeo870_stock_medium01"] = 320,
	["att_vm_romeo870_stock_heavy02"] = 300,
	["att_vm_stock_heavy02"] = 300,
	["att_vm_stock_medium01"] = 280,
	["att_vm_stock_light01"] = 320,
	["att_vm_stock_heavy01"] = 330,
	["att_vm_pi_cpapa_stock02"] = 180,
	["attachment_vm_sm_augolf_stockl"] = 110,
	["attachment_vm_sm_augolf_stocks"] = 110,
	["attachment_vm_sm_augolf_stock_tactical"] = 110,
	["att_vm_pi_cpapa_stock01"] = 200,
	["att_vm_pi_golf21_stock"] = 200,
	["attachment_vm_ar_akilo47_custombarrel"] = 100,
	["attachment_vm_ar_akilo47_lmgbarrel_grip"] = 200,
	["attachment_vm_ar_akilo47_lmgbarrel"] = 210,
	["attachment_vm_ar_akilo47_smgbarrel"] = 150,
	["attachment_vm_ar_akilo47_smgbarcust"] = 120,
	["attachment_vm_sm_augolf_lmgbarrel"] = 200,
	["attachment_vm_ar_akilo47_lmgstock"] = 120,
	["attachment_vm_ar_akilo47_smgstock_unfolded"] = 130,
	["attachment_vm_ar_akilo47_smgstock"] = 130,
	["attachment_vm_stock_light01"] = 150,
	["att_vm_angledgrip_lod0"] = 50,
	["att_vm_angledgrip04"] = 60,
	["att_vm_vertgrip02_lod0"] = 80,
	["att_vm_minireddot03_tall"] = 100,
	["att_vm_holo_east"] = 200,
	["att_vm_4x_east_tall"] = 400,
	["weapon_vm_scope_mike14_alt"] = 500,
	["att_vm_muzzlebrake_shgn01"] = 30,
	["attachment_vm_sh_romeo870_choke"] = 30,
	["def_optic"] = 20,
	["attachment_vm_sh_romeo870_pump_custom"] = 80,
	["attachment_vm_sh_romeo870_heatguard_mp"] = 50,
	["attachment_vm_sh_romeo870_barrel_long"] = 150,
	["attachment_vm_sh_romeo870_barrel_sawn"] = 100,
	["attachment_vm_sh_romeo870_mag"] = 350,
	["att_vm_stock_heavy"] = 100,
	["attachment_vm_minireddot03"] = 50,
	["attachment_vm_pi_mike_pistolgrip03"] = 150,
	["attachment_vm_pi_mike_pistolgrip02"] = 50,
	["attachment_vm_pi_mike_pistolgrip02"] = 30,
	["attachment_vm_pi_mike_stockl"] = 120,
	["attachment_vm_pi_mike_stockh"] = 150,
	["attachment_vm_pi_mike_pistolgrip01"] = 20,
	["attachment_vm_silencerpstl"] = 350,
	["attachment_vm_pi_papa320_slide_vented"] = 50,
	["attachment_vm_pi_papa320_barrel_ext"] = 70,
	["attachment_vm_4x_east"] = 200,
	["attachment_vm_reflex_west02_lod0"] = 50,
	["attachment_vm_pi_mike1911_barlong"] = 20,
	["attachment_vm_pi_mike1911_barshort"] = 10,
	["attachment_vm_pi_mike1911_v2_slide"] = 30,
	["att_vm_pi_golf21_slide_auto"] = 850,
	["att_vm_pi_golf18_slide"] = 850,
	["att_vm_pi_golf21_slide_black"] = 350,
	["att_vm_pi_golf21_slide_long"] = 20,
	["attachment_vm_pi_mike9_pstlgrpcust"] = 20,
	["attachment_vm_pi_mike9_pstlgrplght"] = 30,
	["attachment_vm_pi_mike9_stock"] = 150,
	["attachment_vm_pi_mike9_gripvert"] = 100,
	["attachment_vm_pi_mike9_barlight"] = 50,
	["attachment_vm_pi_mike9_barlong"] = 72,
	["attachment_vm_pi_mike9_barrel_black"] = 72,
	["attachment_vm_pi_mike9_barauto"] = 72,
	["attachment_vm_pi_decho_cust_grip"] = 72,
}

local map_cfg = "config/" .. string.lower(game.GetMap()) .. ".lua"

include(map_cfg)
if SERVER then
	AddCSLuaFile(map_cfg)
end