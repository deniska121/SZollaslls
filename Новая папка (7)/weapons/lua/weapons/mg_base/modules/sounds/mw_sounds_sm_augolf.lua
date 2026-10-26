-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\sounds\\mw_sounds_sm_augolf.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

sound.Add({
	name = "weap_t9powerburst_fire_plr",
	channel = CHAN_WEAPON,
	level = 85,
	pitch = {80, 110},
	sound = "^weapons_t9/sm_powerburst/weap_t9_powerburst_fire_plr_1.ogg",
})

sound.Add({
	name = "weap_t9powerburst_sup_fire_plr",
	channel = CHAN_WEAPON,
	level = 85,
	pitch = {80, 110},
	sound = "^weapons_t9/sm_powerburst/weap_t9_powerburst_fire_plr_sup_1.ogg",
})

sound.Add({
	name = "wpn_sm_powerburst_tail_ext",
	channel = CHAN_ATMO,
	level = 70,
	pitch = {90, 100},
	sound = {"weapons_t9/sm_powerburst/weap_smg4_fire_plr_atmo_ext1_01.ogg", "weapons_t9/sm_powerburst/weap_smg4_fire_plr_atmo_ext1_02.ogg", "weapons_t9/sm_powerburst/weap_smg4_fire_plr_atmo_ext1_03.ogg",}
})

sound.Add({
	name = "wpn_sm_powerburst_tail_int",
	channel = CHAN_ATMO,
	level = 70,
	pitch = {90, 100},
	sound = {"weapons_t9/sm_powerburst/weap_smg_fire_plr_atmo_int1_01.ogg", "weapons_t9/sm_powerburst/weap_smg_fire_plr_atmo_int1_02.ogg", "weapons_t9/sm_powerburst/weap_smg_fire_plr_atmo_int1_03.ogg",}
})

sound.Add({
	name = "wpn_sm_powerburst_sup_tail_ext",
	channel = CHAN_ATMO,
	level = 70,
	pitch = {90, 100},
	sound = {"weapons_t9/sm_powerburst/weap_smg_sup_fire_plr_atmo_ext1_01.ogg", "weapons_t9/sm_powerburst/weap_smg_sup_fire_plr_atmo_ext1_02.ogg", "weapons_t9/sm_powerburst/weap_smg_sup_fire_plr_atmo_ext1_03.ogg",}
})

sound.Add({
	name = "wpn_sm_powerburst_sup_tail_int",
	channel = CHAN_ATMO,
	level = 70,
	pitch = {90, 100},
	sound = {"weapons_t9/sm_powerburst/weap_pistol_sup_fire_plr_atmo_int1_01.ogg", "weapons_t9/sm_powerburst/weap_pistol_sup_fire_plr_atmo_int1_02.ogg", "weapons_t9/sm_powerburst/weap_pistol_sup_fire_plr_atmo_int1_03.ogg",}
})

-- Sound: 22
sound.Add({
	name = "weap_t9powerburst_disconnector_plr",
	channel = CHAN_WPNFOLEY + 1,
	sound = {"^weapons_t9/sm_powerburst/weap_augolf_disconnector_plr_01.ogg",}
})

-- Sound: 23
sound.Add({
	name = "weap_t9powerburst_fire_first_plr",
	channel = CHAN_WPNFOLEY + 2,
	sound = {"^weapons_t9/sm_powerburst/weap_augolf_fire_first_plr_01.ogg",}
})

-- Sound: 32
sound.Add({
	name = "wfoly_plr_trpowerburst_start",
	channel = CHAN_WPNFOLEY + 9,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_start.wav",}
})

-- Sound: 35
sound.Add({
	name = "wfoly_plr_trpowerburst_mag_out",
	channel = CHAN_WPNFOLEY + 2,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_mag_out.wav",}
})

-- Sound: 36
sound.Add({
	name = "wfoly_plr_trpowerburst_mag_grab",
	channel = CHAN_WPNFOLEY + 3,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_mag_grab.wav",}
})

-- Sound: 37
sound.Add({
	name = "wfoly_plr_trpowerburst_mag_in_start",
	channel = CHAN_WPNFOLEY + 4,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_mag_in_start.wav",}
})

-- Sound: 38
sound.Add({
	name = "wfoly_plr_trpowerburst_mag_in",
	channel = CHAN_WPNFOLEY + 5,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_mag_in.wav",}
})

-- Sound: 39
sound.Add({
	name = "wfoly_plr_trpowerburst_bolt_back",
	channel = CHAN_WPNFOLEY + 6,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_bolt_back.wav",}
})

-- Sound: 40
sound.Add({
	name = "wfoly_plr_trpowerburst_bolt_release",
	channel = CHAN_WPNFOLEY + 7,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_bolt_release.wav",}
})

-- Sound: 41
sound.Add({
	name = "wfoly_plr_trpowerburst_end",
	channel = CHAN_WPNFOLEY + 8,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_end.wav",}
})

-- Sound: 42
sound.Add({
	name = "wfoly_plr_trpowerburst_inspect_pt1",
	channel = CHAN_WPNFOLEY + 9,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_inspect_pt1.wav",}
})

-- Sound: 43
sound.Add({
	name = "wfoly_plr_trpowerburst_inspect_pt2",
	channel = CHAN_WPNFOLEY + 10,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_inspect_pt2.wav",}
})

-- Sound: 44
sound.Add({
	name = "wfoly_plr_trpowerburst_inspect_pt3",
	channel = CHAN_WPNFOLEY + 1,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_inspect_pt3.wav",}
})

-- Sound: 45
sound.Add({
	name = "wfoly_plr_trpowerburst_inspect_pt4",
	channel = CHAN_WPNFOLEY + 2,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_inspect_pt4.wav",}
})

-- Sound: 46
sound.Add({
	name = "wfoly_plr_trpowerburst_inspect_pt5",
	channel = CHAN_WPNFOLEY + 3,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_inspect_pt5.wav",}
})

-- Sound: 47
sound.Add({
	name = "wfoly_plr_trpowerburst_inspect_pt6",
	channel = CHAN_WPNFOLEY + 4,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_inspect_pt6.wav",}
})

-- Sound: 48
sound.Add({
	name = "wfoly_plr_trpowerburst_inspect_pt7",
	channel = CHAN_WPNFOLEY + 5,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_inspect_pt7.wav",}
})

-- Sound: 49
sound.Add({
	name = "wfoly_plr_trpowerburst_lower",
	channel = CHAN_WPNFOLEY + 6,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_lower.wav",}
})

-- Sound: 50
sound.Add({
	name = "wfoly_plr_trpowerburst_raise",
	channel = CHAN_WPNFOLEY + 7,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_raise.wav",}
})

-- Sound: 50
sound.Add({
	name = "wfoly_plr_trpowerburst_drum_out",
	channel = CHAN_WPNFOLEY + 7,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_drum_out.wav",}
})

-- Sound: 50
sound.Add({
	name = "wfoly_plr_trpowerburst_drum_in",
	channel = CHAN_WPNFOLEY + 7,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_drum_in.wav",}
})

-- Sound: 50
sound.Add({
	name = "wfoly_plr_trpowerburst_fast_bolt_back",
	channel = CHAN_WPNFOLEY + 7,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_fast_bolt_back.wav",}
})

-- Sound: 50
sound.Add({
	name = "wfoly_plr_trpowerburst_fast_bolt_release",
	channel = CHAN_WPNFOLEY + 7,
	sound = {"reloads/t9_tr_powerburst/fly_tr_powerburst_fast_bolt_release.wav",}
})