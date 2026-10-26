--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/autorun/nmrihsounds.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

local SNDLVL_NORM = 80
local SNDLVL_55dB = 55
local SNDLVL_75dB = 75
local SNDLVL_85dB = 85
local SNDLVL_90dB = 90
local SNDLVL_95dB = 95
local SNDLVL_105dB = 105
local SNDLVL_105 = 105
local SNDLVL_135dB = 135

sound.Add({
	name = "Noire.DoorSlide01",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	sound = "unioncity2/doors/wood/aptwinclose.wav"
})

sound.Add({
	name = "Noire.DoorSlideStop01",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	sound = "unioncity2/doors/other/e_doorstop.wav"
})

sound.Add({
	name = "Noire.DoorLocked",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	sound = "unioncity2/doors/wood/aptwinclosestop.wav"
})

sound.Add({
	name = "Noire.DoorClosed01",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	sound = "unioncity2/doors/metal/doorclosed_metal2.wav"
})

sound.Add({
	name = "Noire.DoorClosed02",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	sound = "unioncity2/doors/other/close4.wav"
})

sound.Add({
	name = "Noire.DoorOpen01",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 75,
	sound = "mp3sounds/door_metal_medium_opening.wav"
})

sound.Add({
	name = "Noire.DoorOpen02",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 55,
	sound = "unioncity2/doors/other/open2.wav"
})

sound.Add({
	name = "Noire.DoorOpen03",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 55,
	sound = "ucsounds/doors/door_wood_opn_2.wav"
})

sound.Add({
	name = "Noire.DoorStop",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = 55,
	sound = "unioncity2/doors/other/storefreezer_close.wav"
})

sound.Add({
	name = "Weapon_AbrasiveSaw.IdleLoop",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_105,
	sound = ")weapons/melee/circular_saw/circular_saw_idle_01.wav",
})

sound.Add({
	name = "Weapon_AbrasiveSaw.SawLoop",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_135dB,
	sound = ")weapons/melee/circular_saw/circular_saw_fast_01.wav",
})

sound.Add({
	name = "Weapon_AbrasiveSaw.IdleToSaw",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = SNDLVL_95dB,
	sound = ")weapons/melee/circular_saw/circular_saw_idle_to_fast_01.wav",
})

sound.Add({
	name = "Weapon_AbrasiveSaw.SawToIdle",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = SNDLVL_95dB,
	sound = ")weapons/melee/circular_saw/circular_saw_fast_to_idle_01.wav",
})

sound.Add({
	name = "Weapon_AbrasiveSaw.Off",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_NORM,
	sound = ")weapons/melee/circular_saw/circular_saw_shut_off_01.wav",
})

sound.Add({
	name = "Weapon_AbrasiveSaw.StartupFailed",
	channel = CHAN_WEAPON,
	volume = 0.7,
	level = SNDLVL_NORM,
	sound = ")weapons/melee/circular_saw/circular_saw_start_fail_01.wav",
})

sound.Add({
	name = "Weapon_AbrasiveSaw.StartupSuccess",
	channel = CHAN_NORM,
	volume = 0.7,
	level = SNDLVL_NORM,
	sound = ")weapons/melee/circular_saw/circular_saw_start_success_01.wav",
})

sound.Add({
	name = "Weapon_Fireaxe.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Fireaxe.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Fireaxe.Shove",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.FireaxeLight",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_heavy_sharp_01.wav", ")weapons/melee/swing_heavy_sharp_02.wav", ")weapons/melee/swing_heavy_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Melee.FireaxeHeavy",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_heavy_sharp_01.wav", ")weapons/melee/swing_heavy_sharp_02.wav", ")weapons/melee/swing_heavy_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Bat.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Bat.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Bat.Shove",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.BatLight",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_light_blunt_01.wav", ")weapons/melee/swing_light_blunt_02.wav", ")weapons/melee/swing_light_blunt_03.wav"},
})

sound.Add({
	name = "Weapon_Melee.BatHeavy",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_light_blunt_01.wav", ")weapons/melee/swing_light_blunt_02.wav", ")weapons/melee/swing_light_blunt_03.wav"},
})

sound.Add({
	name = "Weapon_Chainsaw.IdleLoop",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_105,
	sound = ")weapons/melee/chainsaw/Chainsaw_idleloop.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.SawLoop",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_135dB,
	sound = ")weapons/melee/chainsaw/Chainsaw_sawloop.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.IdleLoop2",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_105,
	sound = ")weapons/melee/chainsaw/Chainsaw_idleloop2.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.SawLoop2",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_135dB,
	sound = ")weapons/melee/chainsaw/Chainsaw_sawloop2.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.IdleToSaw",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = SNDLVL_95dB,
	sound = ")weapons/melee/chainsaw/Chainsaw_idletosaw.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.SawToIdle",
	channel = CHAN_AUTO,
	volume = 0.4,
	level = SNDLVL_95dB,
	sound = ")weapons/melee/chainsaw/Chainsaw_sawtoidle.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.Off",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_NORM,
	sound = ")weapons/melee/chainsaw/Chainsaw_turnoff.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.StartupFailed",
	channel = CHAN_WEAPON,
	volume = 0.7,
	level = SNDLVL_NORM,
	sound = ")weapons/melee/chainsaw/Chainsaw_failedstart.wav",
})

sound.Add({
	name = "Weapon_Chainsaw.StartupSuccess",
	channel = CHAN_WEAPON,
	volume = 0.7,
	level = SNDLVL_NORM,
	sound = ")weapons/melee/chainsaw/Chainsaw_successstart.wav",
})

sound.Add({
	name = "Weapon_Crowbar.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Crowbar.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Crowbar.Shove",
	channel = CHAN_WEAPON,
	volume = 0.55,
	level = SNDLVL_105dB,
	pitch = {95, 100},
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.CrowbarLight",
	channel = CHAN_WEAPON,
	volume = 0.55,
	level = SNDLVL_105dB,
	pitch = {95, 100},
	sound = {")weapons/melee/swing_heavy_sharp_01.wav", ")weapons/melee/swing_heavy_sharp_02.wav", ")weapons/melee/swing_heavy_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Melee.CrowbarHeavy",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_105dB,
	pitch = {98, 102},
	sound = {")weapons/melee/swing_heavy_sharp_01.wav", ")weapons/melee/swing_heavy_sharp_02.wav", ")weapons/melee/swing_heavy_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Hatchet.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Hatchet.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Hatchet.Shove",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.HatchetLight",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Melee.HatchetHeavy",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_KitKnife.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.5,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_KitKnife.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.5,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_KitKnife.Shove",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.5,
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_KitKnife.SwingLight",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_NORM,
	pitch = PITCH_NORM,
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_KitKnife.SwingHeavy",
	channel = CHAN_WEAPON,
	volume = 1,
	level = SNDLVL_NORM,
	pitch = PITCH_NORM,
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Machete.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Machete.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Machete.Shove",
	channel = CHAN_WEAPON,
	volume = 0.55,
	level = SNDLVL_NORM,
	pitch = {95, 100},
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.MacheteLight",
	channel = CHAN_WEAPON,
	volume = 0.55,
	level = SNDLVL_NORM,
	pitch = {95, 100},
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Melee.MacheteHeavy",
	channel = CHAN_WEAPON,
	volume = 0.55,
	level = SNDLVL_NORM,
	pitch = {95, 100},
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Machete.Melee_Hit",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_NORM,
	pitch = {98, 102},
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Machete.Melee_HitWorld",
	channel = CHAN_WEAPON,
	volume = 0.7,
	level = SNDLVL_90dB,
	pitch = {90, 120},
	sound = {")weapons/crowbar/crowbar_impact1.wav", ")weapons/crowbar/crowbar_impact2.wav"},
})

sound.Add({
	name = "Weapon_PipeLead.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_PipeLead.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_PipeLead.Shove",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.PipeLeadLight",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_75dB,
	sound = {")weapons/melee/swing_light_blunt_01.wav", ")weapons/melee/swing_light_blunt_02.wav", ")weapons/melee/swing_light_blunt_03.wav"},
})

sound.Add({
	name = "Weapon_Melee.PipeLeadHeavy",
	channel = CHAN_WEAPON,
	volume = 1.0,
	level = SNDLVL_75dB,
	sound = {")weapons/melee/swing_light_blunt_01.wav", ")weapons/melee/swing_light_blunt_02.wav", ")weapons/melee/swing_light_blunt_03.wav"},
})

sound.Add({
	name = "Weapon_Spade.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Spade.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Spade.Shove",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.SpadeLight",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_heavy_sharp_01.wav", ")weapons/melee/swing_heavy_sharp_02.wav", ")weapons/melee/swing_heavy_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Melee.SpadeHeavy",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_heavy_sharp_01.wav", ")weapons/melee/swing_heavy_sharp_02.wav", ")weapons/melee/swing_heavy_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Sledge.Draw",
	channel = CHAN_WEAPON,
	volume = 0.5,
	level = SNDLVL_55dB,
	pitch = {98, 100},
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Sledge.Holster",
	channel = CHAN_WEAPON,
	volume = 0.5,
	level = SNDLVL_55dB,
	pitch = {98, 100},
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Sledge.Swing",
	channel = CHAN_WEAPON,
	level = SNDLVL_85dB,
	volume = 1.0,
	pitch = {95, 100},
	sound = {")weapons/melee/swing_heavy_blunt_01.wav", ")weapons/melee/swing_heavy_blunt_02.wav", ")weapons/melee/swing_heavy_blunt_03.wav"},
})

sound.Add({
	name = "Weapon_Sledge.Shove",
	channel = CHAN_WEAPON,
	level = SNDLVL_85dB,
	volume = 1.0,
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Sledge.HitFlesh",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/sledge/sledge_hit1.wav", ")weapons/melee/sledge/sledge_hit2.wav", ")weapons/melee/sledge/sledge_hit3.wav"},
})

sound.Add({
	name = "Weapon_Sledge.HitWorld",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/bat/Woodbat_hitworld1.wav", ")weapons/bat/Woodbat_hitworld2.wav"},
})

sound.Add({
	name = "Weapon_Wrench.Draw",
	channel = CHAN_ITEM,
	volume = 0.5,
	level = SNDLVL_55dB,
	pitch = {98, 100},
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Wrench.Holster",
	channel = CHAN_ITEM,
	volume = 0.5,
	level = SNDLVL_55dB,
	pitch = {98, 100},
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Wrench.Shove",
	channel = CHAN_ITEM,
	volume = 0.5,
	level = SNDLVL_55dB,
	pitch = {98, 100},
	sound = {")player/shove_01.wav", ")player/shove_02.wav", ")player/shove_03.wav", ")player/shove_04.wav", ")player/shove_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.Wrench",
	channel = CHAN_WEAPON,
	level = SNDLVL_85dB,
	volume = 0.85,
	pitch = {98, 100},
	sound = {")weapons/melee/swing_light_sharp_01.wav", ")weapons/melee/swing_light_sharp_02.wav", ")weapons/melee/swing_light_sharp_03.wav"},
})

sound.Add({
	name = "Weapon_Hammer.Draw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_draw_01.wav", ")player/weapon_draw_02.wav", ")player/weapon_draw_03.wav", ")player/weapon_draw_04.wav", ")player/weapon_draw_05.wav"},
})

sound.Add({
	name = "Weapon_Hammer.Holster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")player/weapon_holster_01.wav", ")player/weapon_holster_02.wav", ")player/weapon_holster_03.wav", ")player/weapon_holster_04.wav", ")player/weapon_holster_05.wav"},
})

sound.Add({
	name = "Weapon_Hammer.BoardDraw",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")weapons/melee/hammer/board-draw1.wav", ")weapons/melee/hammer/board-draw2.wav", ")weapons/melee/hammer/board-draw3.wav", ")weapons/melee/hammer/board-draw4.wav"},
})

sound.Add({
	name = "Weapon_Hammer.BoardHolster",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")weapons/melee/hammer/board-holster1.wav", ")weapons/melee/hammer/board-holster2.wav", ")weapons/melee/hammer/board-holster3.wav", ")weapons/melee/hammer/board-holster4.wav"},
})

sound.Add({
	name = "Weapon_Hammer.Barricade",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")weapons/melee/hammer/barricade-1.wav", ")weapons/melee/hammer/barricade-2.wav"},
})

sound.Add({
	name = "Weapon_Hammer.BoardLight",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")weapons/melee/hammer/board_damage-light1.wav", ")weapons/melee/hammer/board_damage-light2.wav", ")weapons/melee/hammer/board_damage-light3.wav", ")weapons/melee/hammer/board_damage-light4.wav"},
})

sound.Add({
	name = "Weapon_Hammer.BoardHeavy",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")weapons/melee/hammer/board_damage-heavy1.wav", ")weapons/melee/hammer/board_damage-heavy2.wav", ")weapons/melee/hammer/board_damage-heavy3.wav"},
})

sound.Add({
	name = "Weapon_Hammer.BoardBroken",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 0.4,
	sound = {")weapons/melee/hammer/board_damage-broken1.wav", ")weapons/melee/hammer/board_damage-broken2.wav"},
})

sound.Add({
	name = "Weapon_Melee.HammerLight",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/hammer/Hammer_Hit1.wav", ")weapons/melee/hammer/Hammer_Hit2.wav", ")weapons/melee/hammer/Hammer_Hit3.wav"},
})

sound.Add({
	name = "Weapon_Melee.HammerSwing",
	channel = CHAN_ITEM,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")weapons/melee/swing_light_blunt_01.wav", ")weapons/melee/swing_light_blunt_02.wav", ")weapons/melee/swing_light_blunt_03.wav"},
})

sound.Add({
	name = "Weapon_Extinguisher.Extinguish",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_105dB,
	sound = ")weapons/tools/fire_extinguisher/Fire_Extinguisger_StartLoop.wav",
})

sound.Add({
	name = "Weapon_Extinguisher.Extinguish_Stop",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_105dB,
	sound = ")weapons/tools/fire_extinguisher/Fire_Extinguisger_Stop.wav",
})

sound.Add({
	name = "Weapon_Extinguisher.Lever",
	channel = CHAN_AUTO,
	volume = 1.0,
	level = SNDLVL_105dB,
	sound = ")weapons/tools/fire_extinguisher/Fire_Extinguisger_Lever.wav",
})

sound.Add({
	name = "Weapon_Melee_Blunt.Impact_Light",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/blunt_light1.wav", ")nmrihimpact/blunt_light2.wav", ")nmrihimpact/blunt_light3.wav", ")nmrihimpact/blunt_light4.wav", ")nmrihimpact/blunt_light5.wav", ")nmrihimpact/blunt_light6.wav", ")nmrihimpact/blunt_light7.wav", ")nmrihimpact/blunt_light8.wav"},
})

sound.Add({
	name = "Weapon_Melee_Blunt.Impact_Heavy",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/blunt_heavy1.wav", ")nmrihimpact/blunt_heavy2.wav", ")nmrihimpact/blunt_heavy3.wav", ")nmrihimpact/blunt_heavy4.wav", ")nmrihimpact/blunt_heavy5.wav", ")nmrihimpact/blunt_heavy6.wav"},
})

sound.Add({
	name = "Weapon_Melee_Sharp.Impact_Light",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/sharp_light1.wav", ")nmrihimpact/sharp_light2.wav", ")nmrihimpact/sharp_light3.wav"},
})

sound.Add({
	name = "Weapon_Melee_Sharp.Impact_Heavy",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/sharp_heavy1.wav", ")nmrihimpact/sharp_heavy2.wav", ")nmrihimpact/sharp_heavy3.wav", ")nmrihimpact/sharp_heavy4.wav", ")nmrihimpact/sharp_heavy5.wav", ")nmrihimpact/sharp_heavy6.wav"},
})

sound.Add({
	name = "Weapon_Melee.Impact_Brick",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/brick/brick_impact_bullet1.wav", ")nmrihimpact/brick/brick_impact_bullet2.wav", ")nmrihimpact/brick/brick_impact_bullet3.wav", ")nmrihimpact/brick/brick_impact_bullet4.wav", ")nmrihimpact/brick/brick_impact_bullet5.wav"},
})

sound.Add({
	name = "Weapon_Melee.Impact_Cardboard",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/cardboard/ammo_box_impact_01.wav", ")nmrihimpact/cardboard/ammo_box_impact_02.wav", ")nmrihimpact/cardboard/ammo_box_impact_03.wav", ")nmrihimpact/cardboard/ammo_box_impact_04.wav", ")nmrihimpact/cardboard/ammo_box_impact_05.wav"},
})

sound.Add({
	name = "Weapon_Melee.Impact_Concrete",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/concrete/concrete_impact_bullet1.wav", ")nmrihimpact/concrete/concrete_impact_bullet2.wav", ")nmrihimpact/concrete/concrete_impact_bullet3.wav", ")nmrihimpact/concrete/concrete_impact_bullet4.wav", ")nmrihimpact/concrete/concrete_impact_bullet5.wav"},
})

sound.Add({
	name = "Weapon_Melee.Impact_Metal",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/metal/metal_solid_impact_bullet1.wav", ")nmrihimpact/metal/metal_solid_impact_bullet2.wav", ")nmrihimpact/metal/metal_solid_impact_bullet3.wav", ")nmrihimpact/metal/metal_solid_impact_bullet4.wav", ")nmrihimpact/metal/metal_solid_impact_bullet5.wav"},
})

sound.Add({
	name = "Weapon_Melee.Impact_Generic",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/surfaces/sand_impact_bullet1.wav", ")nmrihimpact/surfaces/sand_impact_bullet2.wav", ")nmrihimpact/surfaces/sand_impact_bullet3.wav", ")nmrihimpact/surfaces/sand_impact_bullet4.wav", ")nmrihimpact/surfaces/sand_impact_bullet5.wav"},
})

sound.Add({
	name = "Weapon_Melee.Impact_Wood",
	channel = CHAN_AUTO,
	level = SNDLVL_NORM,
	volume = 1.0,
	sound = {")nmrihimpact/wood/wood_solid_impact_bullet1.wav", ")nmrihimpact/wood/wood_solid_impact_bullet2.wav", ")nmrihimpact/wood/wood_solid_impact_bullet3.wav", ")nmrihimpact/wood/wood_solid_impact_bullet4.wav", ")nmrihimpact/wood/wood_solid_impact_bullet5.wav"},
})


local function rb655_property_filter(filtor, ent, ply)
	if (type(filtor) == "string" and filtor ~= ent:GetClass()) then return false end
	if (type(filtor) == "table" and not table.HasValue(filtor, ent:GetClass())) then return false end
	if (type(filtor) == "function" and not filtor(ent, ply)) then return false end

	return true
end

function AddEntFunctionProperty(name, label, pos, filtor, func, icon)
	properties.Add(name, {
		MenuLabel = label,
		MenuIcon = icon,
		Order = pos,
		Filter = function(self, ent, ply)
			if not ply:IsSuperAdmin() then return false end
			--if (not IsValid(ent) or not gamemode.Call("CanProperty", ply, name, ent)) then return false end
			if (not rb655_property_filter(filtor, ent, ply)) then return false end

			return true
		end,
		Action = function(self, ent)
			self:MsgStart()
			net.WriteEntity(ent)
			self:MsgEnd()
		end,
		Receive = function(self, length, ply)
			local ent = net.ReadEntity()
			if (not IsValid(ply) or not IsValid(ent) or not self:Filter(ent, ply)) then return false end
			func(ent, ply)
		end
	})
end

function AddEntFireProperty(name, label, pos, class, input, icon)
	AddEntFunctionProperty(name, label, pos, class, function(e)
		e:Fire(unpack(string.Explode(" ", input)))
	end, icon)
end

local ExplodeIcon = "icon16/bomb.png"
local EnableIcon = "icon16/tick.png"
local DisableIcon = "icon16/cross.png"

-------------------------------------------------- Half - Life 2 Specific --------------------------------------------------
AddEntFireProperty("rb655_door_open", "Open", 655, function(ent, ply)
	if ent:GetClass() == "prop_door_rotating" then return false end

	return rb655_property_filter({"prop_door_rotating", "func_door_rotating", "func_door"}, ent, ply)
end, "Open", "icon16/door_open.png")

AddEntFireProperty("rb655_door_close", "Close", 656, function(ent, ply)
	if (ent:GetClass() == "prop_door_rotating") then return false end

	return rb655_property_filter({"prop_door_rotating", "func_door_rotating", "func_door"}, ent, ply)
end, "Close", "icon16/door.png")

AddEntFireProperty("rb655_door_lock", "Lock", 657, function(ent, ply)

	return rb655_property_filter({"prop_door_rotating", "func_door_rotating", "func_door", "prop_vehicle_jeep", "prop_vehicle_airboat", "prop_vehicle_prisoner_pod"}, ent, ply)
end, "Lock", "icon16/lock.png")

AddEntFireProperty("rb655_door_unlock", "Unlock", 658, function(ent, ply)

	return rb655_property_filter({"prop_door_rotating", "func_door_rotating", "func_door", "prop_vehicle_jeep", "prop_vehicle_airboat", "prop_vehicle_prisoner_pod"}, ent, ply)
end, "Unlock", "icon16/lock_open.png")

AddEntFireProperty("rb655_func_movelinear_open", "Start", 655, "func_movelinear", "Open", "icon16/arrow_right.png")
AddEntFireProperty("rb655_func_movelinear_close", "Return", 656, "func_movelinear", "Close", "icon16/arrow_left.png")

AddEntFireProperty("rb655_func_tracktrain_StartForward", "Start Forward", 655, function(ent, ply)
	return rb655_property_filter("func_tracktrain", ent, ply)
end, "StartForward", "icon16/arrow_right.png")

AddEntFireProperty("rb655_func_tracktrain_StartBackward", "Start Backward", 656, function(ent, ply)
	return rb655_property_filter("func_tracktrain", ent, ply)
end, "StartBackward", "icon16/arrow_left.png")

--AddEntFireProperty( "rb655_func_tracktrain_Reverse", "Reverse", 657, "func_tr2acktrain", "Reverse", "icon16/arrow_undo.png" ) -- Same as two above
AddEntFireProperty("rb655_func_tracktrain_Stop", "Stop", 658, function(ent, ply)
	return rb655_property_filter("func_tracktrain", ent, ply)
end, "Stop", "icon16/shape_square.png")

AddEntFireProperty("rb655_func_tracktrain_Resume", "Resume", 659, function(ent, ply)
	return rb655_property_filter("func_tracktrain", ent, ply)
end, "Resume", "icon16/resultset_next.png")

--AddEntFireProperty( "rb655_func_tracktrain_Toggle", "Toggle", 660, "func_track2train", "Toggle", ToggleIcon ) -- Same as two above
AddEntFireProperty("rb655_breakable_break", "Break", 655, function(ent, ply)
	if (ent:Health() < 1) then return false end

	return rb655_property_filter({"func_breakable", "func_physbox", "prop_physics", "func_pushable"}, ent, ply)
end, "Break", ExplodeIcon)

-------------------------------------------------- Vehicles --------------------------------------------------
AddEntFunctionProperty("rb655_vehicle_exit", "Kick Driver", 655, function(ent)
	if (ent:IsVehicle()) then return true end

	return false
end, function(ent)
	if (not IsValid(ent:GetDriver()) or not ent:GetDriver().ExitVehicle) then return end
	ent:GetDriver():ExitVehicle()
end, "icon16/car.png")



AddEntFunctionProperty("rb655_vehicle_enter", "Enter Vehicle", 656, function(ent)
	if (ent:IsVehicle()) then return true end

	return false
end, function(ent, ply)
	ply:ExitVehicle()
	ply:EnterVehicle(ent)
end, "icon16/car.png")

-------------------------------------------------- Garry's Mod Specific --------------------------------------------------
AddEntFunctionProperty("rb655_baloon_break", "Pop", 655, "gmod_balloon", function(ent, ply)
	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(ply)
	ent:OnTakeDamage(dmginfo)
end, ExplodeIcon)

AddEntFunctionProperty("rb655_dynamite_activate", "Explode", 655, "gmod_dynamite", function(ent, ply)
	ent:Explode(0, ply)
end, ExplodeIcon)

-- Emitter
AddEntFunctionProperty("rb655_emitter_on", "Start Emitting", 655, function(ent)
	if (ent:GetClass() == "gmod_emitter" and not ent:GetOn()) then return true end

	return false
end, function(ent, ply)
	ent:SetOn(true)
end, EnableIcon)

AddEntFunctionProperty("rb655_emitter_off", "Stop Emitting", 656, function(ent)
	if (ent:GetClass() == "gmod_emitter" and ent:GetOn()) then return true end

	return false
end, function(ent, ply)
	ent:SetOn(false)
end, DisableIcon)

-- Lamps
AddEntFunctionProperty("rb655_lamp_on", "Enable", 655, function(ent)
	if (ent:GetClass() == "gmod_lamp" and not ent:GetOn()) then return true end

	return false
end, function(ent, ply)
	ent:Switch(true)
end, EnableIcon)

AddEntFunctionProperty("rb655_lamp_off", "Disable", 656, function(ent)
	if (ent:GetClass() == "gmod_lamp" and ent:GetOn()) then return true end

	return false
end, function(ent, ply)
	ent:Switch(false)
end, DisableIcon)

-- Light
AddEntFunctionProperty("rb655_light_on", "Enable", 655, function(ent)
	if (ent:GetClass() == "gmod_light" and not ent:GetOn()) then return true end

	return false
end, function(ent, ply)
	ent:SetOn(true)
end, EnableIcon)

AddEntFunctionProperty("rb655_light_off", "Disable", 656, function(ent)
	if (ent:GetClass() == "gmod_light" and ent:GetOn()) then return true end

	return false
end, function(ent, ply)
	ent:SetOn(false)
end, DisableIcon)