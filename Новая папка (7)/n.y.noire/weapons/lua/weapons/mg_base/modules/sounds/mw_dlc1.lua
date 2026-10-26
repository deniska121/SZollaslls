--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/sounds/mw_dlc1.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- Diamatti --
sound.Add({
	name = "bocw.pi_burst.fire",
	channel = CHAN_WEAPON,
	level = 85,
	volume = 1,
	sound = {"viper/weapons/diamatti/wpn_pistol_burst.ogg"}
})


local path = "/weapons/tfa_ins2/swmodel10/"
local pref = "TFA_INS2.SWM10"


sound.Add({
	name = "TFA_INS2.SWM10.1",
	channel = CHAN_WEAPON,
	level = 85,
	volume = 1,
	sound = {path .. "38shoot.wav"}
})

local AddWeaponSound = function(n, s)
	sound.Add({
		name = n,
		channel = CHAN_WPNFOLEY + 5,
		volume = 1,
		sound = s
	})
end

AddWeaponSound(pref .. ".Empty", path .. "revolver_empty.wav")
AddWeaponSound(pref .. ".OpenChamber", path .. "revolver_open_chamber.wav")
AddWeaponSound(pref .. ".CloseChamber", path .. "revolver_close_chamber.wav")
AddWeaponSound(pref .. ".CockHammer", path .. "revolver_cock_hammer.wav")
AddWeaponSound(pref .. ".DumpRounds", {path .. "revolver_dump_rounds_01.wav", path .. "revolver_dump_rounds_02.wav", path .. "revolver_dump_rounds_03.wav"})
AddWeaponSound(pref .. ".RoundInsertSpeedLoader", path .. "revolver_speed_loader_insert_01.wav")
AddWeaponSound(pref .. ".RoundInsertSingle", {path .. "revolver_round_insert_single_01.wav", path .. "revolver_round_insert_single_02.wav", path .. "revolver_round_insert_single_03.wav", path .. "revolver_round_insert_single_03.wav", path .. "revolver_round_insert_single_04.wav", path .. "revolver_round_insert_single_05.wav", path .. "revolver_round_insert_single_06.wav"})


-- Hauer 77 --
sound.Add({
	name = "bocw.shotgun_pump.fire",
	channel = CHAN_WEAPON,
	level = 85,
	volume = 1,
	sound = {"viper/weapons/shotgun_pump/wpn_shotgun_pump_fire.ogg"}
})

-- Waltuh Pepekei --
sound.Add({
	name = "pi.walterppk.fire",
	channel = CHAN_WEAPON,
	level = 85,
	volume = 1,
	sound = {"viper/weapons/walterppk/pi_walterppk_fire.ogg"}
})

-- Sound: 16
sound.Add({
	name = "CS2_Tec9_Fire",
	channel = CHAN_STATIC,
	level = 70,
	volume = 1,
	sound = {"tec9/tec9_fire.wav",}
})

sound.Add({
	name = "tec9_clipin",
	channel = CHAN_WPNFOLEY + 5,
	volume = 1,
	sound = {"tec9/tec9_clipin.wav",}
})

-- Sound: 69
sound.Add({
	name = "tec9_clipout",
	channel = CHAN_WPNFOLEY + 5,
	volume = 1,
	sound = {"tec9/tec9_clipout.wav",}
})

-- Sound: 70
sound.Add({
	name = "tec9_boltrelease",
	channel = CHAN_WPNFOLEY + 6,
	volume = 1,
	sound = {"tec9/tec9_boltrelease.wav",}
})

-- Sound: 71
sound.Add({
	name = "tec9_boltpull",
	channel = CHAN_WPNFOLEY + 7,
	volume = 1,
	sound = {"tec9/tec9_boltpull.wav",}
})

sound.Add({
	name = "tec9_boltsmack",
	channel = CHAN_WPNFOLEY + 7,
	volume = 1,
	sound = {"tec9/tec9_boltsmack.wav",}
})

sound.Add({
	name = "weap_mpapa5_disconnector_plr",
	channel = CHAN_WPNFOLEY + 1,
	volume = 1,
	pitch = {100, 100},
	sound = {"weapons/mpapa5/weap_mpapa5_disconnector_plr_01.ogg",}
})

-- Sound: 23
sound.Add({
	name = "wpn_thotel_plr_shot_first",
	channel = CHAN_WPNFOLEY + 2,
	volume = 1,
	pitch = {100, 100},
	sound = {"s4/weapons/thotel/shots/wpn_thotel_plr_shot_first_01.wav",}
})

-- Sound: 23
sound.Add({
	name = "wpn_thotel_plr_shot_first_sup",
	channel = CHAN_WPNFOLEY + 2,
	volume = 1,
	pitch = {100, 100},
	sound = {"s4/weapons/thotel/shots/wpn_supp_lt_smg_gen_plr_shot_01.wav",}
})

sound.Add({
	name = "wpn_thotel_plr_shot_int",
	channel = CHAN_ATMO + 1,
	volume = 140,
	pitch = {90, 101},
	sound = {"s4/weapons/thotel/int/wpn_mpapa40_plr_shot_tail_int_01.wav", "s4/weapons/thotel/int/wpn_mpapa40_plr_shot_tail_int_02.wav", "s4/weapons/thotel/int/wpn_mpapa40_plr_shot_tail_int_03.wav",}
})

-- Sound: 17
sound.Add({
	name = "wpn_thotel_plr_ads_down",
	channel = CHAN_WPNFOLEY + 8,
	volume = 1,
	pitch = {100, 100},
	sound = {"s4/weapons/thotel/foley/wpn_sm_ads_down_01.wav", "s4/weapons/thotel/foley/wpn_sm_ads_down_02.wav",}
})

-- Sound: 18
sound.Add({
	name = "wpn_thotel_plr_ads_up",
	channel = CHAN_WPNFOLEY + 9,
	volume = 1,
	pitch = {100, 100},
	sound = {"s4/weapons/thotel/foley/wpn_sm_ads_up_01.wav", "s4/weapons/thotel/foley/wpn_sm_ads_up_02.wav",}
})

-- Sound: 18
sound.Add({
	name = "wpn_thotel_plr_inspect_mvmnt_med",
	channel = CHAN_WPNFOLEY + 10,
	volume = 1,
	pitch = {100, 100},
	sound = {"s4/weapons/thotel/foley/wpn_smg_insp_med_a.wav", "s4/weapons/thotel/foley/wpn_smg_insp_med_b.wav",}
})

-- Sound: 18
sound.Add({
	name = "wpn_thotel_plr_inspect_settle_sml",
	channel = CHAN_WPNFOLEY + 11,
	volume = 1,
	pitch = {100, 100},
	sound = {"s4/weapons/thotel/foley/wpn_smg_insp_shldr_a.wav",}
})

-- Sound: 18
sound.Add({
	name = "wpn_thotel_plr_inspect_settle",
	channel = CHAN_WPNFOLEY + 11,
	volume = 1,
	pitch = {100, 100},
	sound = {"s4/weapons/thotel/foley/wpn_smg_insp_sml_a.wav",}
})

sound.Add({
	name = "wpn_thotel_plr_reload_fpo",
	channel = CHAN_WPNFOLEY + 1,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_fpo.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magin_empty",
	channel = CHAN_WPNFOLEY + 2,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magin_empty.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magin_empty_ext",
	channel = CHAN_WPNFOLEY + 3,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magin_empty_ext.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magin_empty_fast",
	channel = CHAN_WPNFOLEY + 4,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magin_empty_fast.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magin_tac",
	channel = CHAN_WPNFOLEY + 5,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magin_tac.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magin_tac_ext",
	channel = CHAN_WPNFOLEY + 6,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magin_tac_ext.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magin_tac_fast",
	channel = CHAN_WPNFOLEY + 7,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magin_tac_fast.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magout_empty",
	channel = CHAN_WPNFOLEY + 8,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magout_empty.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magout_empty_ext",
	channel = CHAN_WPNFOLEY + 9,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magout_empty_ext.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magout_empty_fast",
	channel = CHAN_WPNFOLEY + 10,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magout_empty_fast.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magout_tac",
	channel = CHAN_WPNFOLEY + 11,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magout_tac.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magout_tac_ext",
	channel = CHAN_WPNFOLEY + 12,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magout_tac_ext.wav"}
})

sound.Add({
	name = "wpn_thotel_plr_reload_magout_tac_fast",
	channel = CHAN_WPNFOLEY + 13,
	volume = 1,
	sound = {"s4/weapons/thotel/wpn_thotel_plr_reload_magout_tac_fast.wav"}
})

sound.Add({
	name = "wfoly_plr_sm_thotel_drop_01",
	channel = CHAN_WPNFOLEY + 12,
	volume = 1,
	sound = {"s4/weapons/thotel/foley/wpn_sm_holster_01.wav", "s4/weapons/thotel/foley/wpn_sm_holster_02.wav", "s4/weapons/thotel/foley/wpn_sm_holster_03.wav",}
})

sound.Add({
	name = "wfoly_plr_sm_thotel_raise_01",
	channel = CHAN_WPNFOLEY + 13,
	volume = 1,
	sound = {"s4/weapons/thotel/foley/wpn_sm_raise_01.wav", "s4/weapons/thotel/foley/wpn_sm_raise_02.wav", "s4/weapons/thotel/foley/wpn_sm_raise_03.wav",}
})