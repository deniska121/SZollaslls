--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mwb_spapa12/animations.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Animations = {
	["Idle"] = {
		Sequences = {"idle"},
		Fps = 30,
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
		}
	}, --idle is a special animation index, movement animations are played when this is on
	--does not need NextSequence to loop, it's an exception to the rule
	["Draw"] = {
		Sequences = {"draw"},
		Length = 0.65,
		Fps = 22,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("mw19.romeo870.raise"))
				end
			},
		}
	},
	["Holster"] = {
		Sequences = {"holster"},
		Length = 0.95,
		Fps = 22,
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("mw19.romeo870.drop"))
				end
			},
			{
				Time = 0.1,
				Callback = function(self)
					self:DisableGrip()
				end
			},
		}
	},
	["Equip"] = {
		Sequences = {"draw_First"},
		Length = 1.25,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_raise_first_02"))
				end
			},
			{
				Time = 0.633,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_raise_first_03"))
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_raise_first_01"))
				end
			},
		}
	},
	["Reload_Start"] = {
		Sequences = {"reload_start"},
		Length = 0.9,
		Fps = 30,
		MagLength = 0.76,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.1,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_start_01"))
				end
			},
			{
				Time = 0.533,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_start_02"))
				end
			},
		}
	},
	["Reload_Start_Folded"] = {
		Sequences = {"reload_start_folded"},
		Length = 0.9,
		Fps = 30,
		MagLength = 0.7,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.1,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0.1,
				Callback = function(self)
					self:DisableGrip2()
				end
			},
			{
				Time = 0.5,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_start_folded_02"))
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_start_folded_01"))
				end
			},
		}
	},
	["Reload_Loop"] = {
		Sequences = {"reload_loop"},
		Length = 0.65,
		Fps = 30,
		MagLength = 0.5,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0.333,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_loop_03"))
				end
			},
			{
				Time = 0.3,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_loop_02"))
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_loop_01"))
				end
			},
		}
	},
	["Reload_Loop_Folded"] = {
		Sequences = {"reload_loop_folded"},
		Length = 0.65,
		Fps = 30,
		MagLength = 0.5,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.1,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0.1,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_loop_folded_01"))
				end
			},
			{
				Time = 0.267,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_loop_folded_02"))
				end
			},
		}
	},
	["Reload_End"] = {
		Sequences = {"reload_end"},
		Length = 0.63,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.0,
				Callback = function(self) end
			},
			{
				Time = 0.0,
				Callback = function(self) end
			},
			{
				Time = 0.167,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_end_01"))
				end
			},
		}
	},
	["Reload_End_Folded"] = {
		Sequences = {"reload_end_folded"},
		Length = 0.63,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_end_folded_01"))
				end
			},
			{
				Time = 0.533,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_end_folded_02"))
				end
			},
			--{Time = 0.167, Callback = function(self) self:EnableGrip() end},
			{
				Time = 0.23,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
		}
	},
	["Reload_End_Empty"] = {
		Sequences = {"reload_end"},
		Length = 0.63,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.0,
				Callback = function(self) end
			},
			{
				Time = 0.0,
				Callback = function(self) end
			},
			{
				Time = 0.167,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_end_01"))
				end
			},
		}
	},
	["Reload_End_Empty_Folded"] = {
		Sequences = {"reload_end_folded"},
		Length = 0.63,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.0,
				Callback = function(self) end
			},
			{
				Time = 0.0,
				Callback = function(self) end
			},
			{
				Time = 0.167,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0.0,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_romeo870_reload_end_01"))
				end
			},
		}
	},
	["Fire"] = {
		Sequences = {"fire"},
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self.bCanEjectOnReload = true
					self:DoParticle("MuzzleFlash", "muzzle")
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
		}
	},
	["fire_slam"] = {
		Sequences = {"fire_slam"},
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self.bCanEjectOnReload = true
					self:DoParticle("MuzzleFlash", "muzzle")
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
		}
	},
	["Rechamber"] = {
		Sequences = {"draw_First"},
		Length = 1.25,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.17,
				Callback = function(self)
					self:DoSound("reloads/t9_sh_semiauto/fly_shotgun_semi_first_bolt_back.ogg")
				end
			},
			{
				Time = 1.2,
				Callback = function(self)
					self:DoSound("reloads/t9_sh_semiauto/fly_shotgun_semi_first_bolt_release.ogg")
				end
			},
		}
	},
	["Fire_Last"] = {
		Sequences = {"fire_last"},
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DoParticle("MuzzleFlash", "muzzle")
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
		}
	},
	["fire_last_slam"] = {
		Sequences = {"fire_last_slam"},
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DoParticle("MuzzleFlash", "muzzle")
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
		}
	},
	["Ads_In"] = {
		Sequences = {"ads_in"},
		Length = 0.25,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("mw19.dpapa12.ads.up"))
				end
			},
		}
	},
	["Ads_Out"] = {
		Sequences = {"ads_out"},
		Length = 0.25,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("mw19.dpapa12.ads.down"))
				end
			},
		}
	},
	["Sprint_In"] = {
		Sequences = {"sprint_in"},
		Fps = 24,
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	--NextSequence = "Sprint_Loop",
	["Sprint_Loop"] = {
		Sequences = {"sprint_loop"},
		Fps = 30,
		NextSequence = "Sprint_Loop", --make our state loop
		--while sprinting, the playback rate of the viewmodel is scaled with velocity (cod-like behaviour)
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["Sprint_Out"] = {
		Sequences = {"sprint_out"},
		Length = 0.3,
		Fps = 24,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["Inspect"] = {
		Sequences = {"inspect"},
		Length = 4.2,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 3.667,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_charlie725_inspect_04"))
				end
			},
			{
				Time = 4.367,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_charlie725_inspect_05"))
				end
			},
			{
				Time = 1.5,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_charlie725_inspect_02"))
				end
			},
			{
				Time = 2.5,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_charlie725_inspect_03"))
				end
			},
			{
				Time = 0.033,
				Callback = function(self)
					self:DoSound(Sound("ps_wfoly_plr_sh_charlie725_inspect_01"))
				end
			},
			{
				Time = 0.3,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 4.467,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["Jog_Out"] = {
		Sequences = {"jog_out"},
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["Jump"] = {
		Sequences = {"jump"},
		Fps = 15,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["Land"] = {
		Sequences = {"jump_land"},
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip2()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["Melee"] = {
		Sequences = {"melee_miss_01", "melee_miss_02", "melee_miss_03"},
		Length = 0.6, --if melee misses
		Size = 15,
		Range = 40,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("MW_Melee.Miss_Medium"))
				end
			},
			{
				Time = 0.8,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["Melee_Hit"] = {
		Sequences = {"melee_hit_01", "melee_hit_02", "melee_hit_03"},
		Length = 0.3, --if melee hits
		Damage = 30,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("MW_Melee.Flesh_Medium"))
				end
			},
			{
				Time = 0.8,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["melee_nostock"] = {
		Sequences = {"melee_miss_01_nostock", "melee_miss_02_nostock", "melee_miss_03_nostock"},
		Length = 0.6, --if melee misses
		Size = 15,
		Range = 40,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("MW_Melee.Miss_Medium"))
				end
			},
			{
				Time = 0.8,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
	["melee_hit_nostock"] = {
		Sequences = {"melee_hit_01_nostock", "melee_hit_02_nostock", "melee_hit_03_nostock"},
		Length = 0.3, --if melee hits
		Damage = 45,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DisableGrip()
				end
			},
			{
				Time = 0,
				Callback = function(self)
					self:DoSound(Sound("MW_Melee.Flesh_Medium"))
				end
			},
			{
				Time = 0.8,
				Callback = function(self)
					self:EnableGrip()
				end
			},
		}
	},
}