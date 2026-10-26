-- "addons\\weapons\\lua\\weapons\\mwb_tec9\\animations.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

SWEP.Animations = {
	["Idle"] = {
		Sequences = {"idle"},
		Fps = 30
	},
	["Draw"] = {
		Sequences = {"draw"},
		Length = 0.45,
		Fps = 18,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Raise"))
				end
			}
		}
	},
	["Holster"] = {
		Sequences = {"holster"},
		Length = 0.25,
		Fps = 20,
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Drop"))
				end
			}
		}
	},
	["Equip"] = {
		Sequences = {"draw_First"},
		Length = 1,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0.16,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Raise_Open"))
				end
			},
			{
				Time = 0.6,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Raise_Clse"))
				end
			},
			{
				Time = 0.7,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Raise_First_End"))
				end
			}
		}
	},
	["Reload"] = {
		Sequences = {"reload"},
		Length = 1.5,
		Fps = 30,
		MagLength = 1.03,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start"))
				end
			},
			{
				Time = 0.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout"))
				end
			},
			{
				Time = 0.9,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert"))
				end
			},
			{
				Time = 1.03,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin"))
				end
			},
			{
				Time = 1.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End"))
				end
			}
		}
	},
	["Reload_XmagLrg"] = {
		Sequences = {"reload_xmaglrg"},
		Length = 2,
		Fps = 30,
		MagLength = 1.3,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start"))
				end
			},
			{
				Time = 0.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout"))
				end
			},
			{
				Time = 0.9,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert"))
				end
			},
			{
				Time = 1.03,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin"))
				end
			},
			{
				Time = 1.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End"))
				end
			}
		}
	},
	["Reload_Drummag"] = {
		Sequences = {"reload_drum"},
		Length = 2.4,
		Fps = 30,
		MagLength = 2.1,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start"))
				end
			},
			{
				Time = 0.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout"))
				end
			},
			{
				Time = 0.9,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert"))
				end
			},
			{
				Time = 1.03,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin"))
				end
			},
			{
				Time = 1.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End"))
				end
			}
		}
	},
	["Reload_Xmag"] = {
		Sequences = {"reload_xmag"},
		Length = 1.7,
		Fps = 30,
		MagLength = 1.2,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start"))
				end
			},
			{
				Time = 0.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout"))
				end
			},
			{
				Time = 0.9,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert"))
				end
			},
			{
				Time = 1.03,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin"))
				end
			},
			{
				Time = 1.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End"))
				end
			}
		}
	},
	["Reload_Fast"] = {
		Sequences = {"reload_fast"},
		Length = 1,
		Fps = 30,
		MagLength = 0.53,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Fast"))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Xmag_Fast"))
				end
			},
			{
				Time = 0.85,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.53,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Xmag_Fast"))
				end
			},
			{
				Time = 0.66,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Xmag_Fast"))
				end
			}
		}
	},
	["Reload_XmagLrg_Fast"] = {
		Sequences = {"reload_xmaglrg_fast"},
		Length = 1.7,
		Fps = 30,
		MagLength = 1.23,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Xmag_Fast"))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Xmag_Fast"))
				end
			},
			{
				Time = 0.85,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.53,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Xmag_Fast"))
				end
			},
			{
				Time = 0.66,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Xmag_Fast"))
				end
			}
		}
	},
	["Reload_Drummag_Fast"] = {
		Sequences = {"reload_drum_fast"},
		Length = 2,
		Fps = 30,
		MagLength = 1.73,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Xmag_Fast"))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Xmag_Fast"))
				end
			},
			{
				Time = 0.85,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.53,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Xmag_Fast"))
				end
			},
			{
				Time = 0.66,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Xmag_Fast"))
				end
			}
		}
	},
	["Reload_Xmag_Fast"] = {
		Sequences = {"reload_xmag_fast"},
		Length = 1.1,
		Fps = 30,
		MagLength = 0.83,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Xmag_Fast"))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Xmag_Fast"))
				end
			},
			{
				Time = 0.85,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.53,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Xmag_Fast"))
				end
			},
			{
				Time = 0.66,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Xmag_Fast"))
				end
			}
		}
	},
	["Reload_Empty"] = {
		Sequences = {"reload_empty"},
		Length = 2,
		Fps = 30,
		MagLength = 1.43,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty"))
				end
			},
			{
				Time = 0.36,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 1.1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert_Empty"))
				end
			},
			{
				Time = 1.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty"))
				end
			}
		}
	},
	["Reload_Empty_Xmag"] = {
		Sequences = {"reload_empty_xmag"},
		Length = 2,
		Fps = 30,
		MagLength = 1.63,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty_Xmag"))
				end
			},
			{
				Time = 0.36,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty_Xmag"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 1.1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert_Empty_Xmag"))
				end
			},
			{
				Time = 1.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty_Xmag"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty_Xmag"))
				end
			}
		}
	},
	["Reload_Empty_XmagLrg"] = {
		Sequences = {"reload_empty_xmaglrg"},
		Length = 2.2,
		Fps = 30,
		MagLength = 1.83,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty_Xmag"))
				end
			},
			{
				Time = 0.36,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty_Xmag"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 1.1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert_Empty_Xmag"))
				end
			},
			{
				Time = 1.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty_Xmag"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty_Xmag"))
				end
			}
		}
	},
	["Reload_Empty_Drummag"] = {
		Sequences = {"reload_empty_drum"},
		Length = 2.66,
		Fps = 30,
		MagLength = 2.33,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty_Xmag"))
				end
			},
			{
				Time = 0.36,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty_Xmag"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 1.1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Maginsert_Empty_Xmag"))
				end
			},
			{
				Time = 1.33,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty_Xmag"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge"))
				end
			},
			{
				Time = 1.63,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty_Xmag"))
				end
			}
		}
	},
	["Reload_Empty_Fast"] = {
		Sequences = {"reload_fast_empty"},
		Length = 1.25,
		Fps = 30,
		MagLength = 0.84,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty_Fast"))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty_Fast"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.5,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty_Fast"))
				end
			},
			{
				Time = 0.83,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge_Fast"))
				end
			},
			{
				Time = 0.96,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty_Fast"))
				end
			}
		}
	},
	["Reload_Empty_Xmag_Fast"] = {
		Sequences = {"reload_empty_xmag_fast"},
		Length = 1.4,
		Fps = 30,
		MagLength = 1,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty_Fast"))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty_Xmag_Fast"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.5,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty_Xmag_Fast"))
				end
			},
			{
				Time = 0.83,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge_Xmag_Fast"))
				end
			},
			{
				Time = 0.96,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty_Xmag_Fast"))
				end
			}
		}
	},
	["Reload_Empty_XmagLrg_Fast"] = {
		Sequences = {"reload_empty_xmaglrg_fast"},
		Length = 1.76,
		Fps = 30,
		MagLength = 1.3,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty_Fast"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty_Xmag_Fast"))
				end
			},
			{
				Time = 0.5,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty_Xmag_Fast"))
				end
			},
			{
				Time = 0.83,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge_Xmag_Fast"))
				end
			},
			{
				Time = 0.96,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty_Xmag_Fast"))
				end
			}
		}
	},
	["Reload_Empty_Drummag_Fast"] = {
		Sequences = {"reload_empty_drum_fast"},
		Length = 2.15,
		Fps = 30,
		MagLength = 1.6,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_Start_Empty_Fast"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					self:DoSpatialSound(Sound("MW_MagazineDrop.SMG.Poly"), Vector(0, 0, 0))
				end
			},
			{
				Time = 0.2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magout_Empty_Xmag_Fast"))
				end
			},
			{
				Time = 0.5,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Magin_Empty_Xmag_Fast"))
				end
			},
			{
				Time = 0.83,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Charge_Xmag_Fast"))
				end
			},
			{
				Time = 0.96,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Reload_End_Empty_Xmag_Fast"))
				end
			}
		}
	},
	["Fire"] = {
		Sequences = {"fire"},
		Fps = 60,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DoParticle("MuzzleFlash", "muzzle")
					self:DoParticle("Ejection", "shell_eject")
					self:DoEjection("shell_eject")
				end
			}
		}
	},
	["Fire_Last"] = {
		Sequences = {"fire_last"},
		Fps = 60,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					self:DoParticle("MuzzleFlash", "muzzle")
					self:DoParticle("Ejection", "shell_eject")
					self:DoEjection("shell_eject")
				end
			},
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Lastshot"))
				end
			},
		}
	},
	["Ads_In"] = {
		Sequences = {"ads_in"},
		Length = 0.3,
		Fps = 45,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.ADS_Up"))
				end
			}
		}
	},
	["Ads_Out"] = {
		Sequences = {"ads_out"},
		Length = 0.3,
		Fps = 45,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.ADS_Down"))
				end
			}
		}
	},
	["Sprint_In"] = {
		Sequences = {"sprint_in"},
		Fps = 30
	},
	["Sprint_Loop"] = {
		Sequences = {"sprint_loop"},
		Fps = 26,
		NextSequence = "Sprint_Loop"
	},
	["Sprint_Out"] = {
		Sequences = {"sprint_out"},
		Length = 0.3,
		Fps = 24,
		NextSequence = "Idle",
	},
	["Inspect"] = {
		Sequences = {"inspect"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Inspect_xmag"] = {
		Sequences = {"inspect_xmag"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Inspect_Xmaglrg"] = {
		Sequences = {"inspect_xmaglrg"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Inspect_drum"] = {
		Sequences = {"inspect_drum"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Inspect_empty"] = {
		Sequences = {"inspect_empty"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Inspect_empty_xmag"] = {
		Sequences = {"inspect_empty_xmag"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Inspect_empty_xmaglrg"] = {
		Sequences = {"inspect_empty_xmaglrg"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Inspect_empty_drum"] = {
		Sequences = {"inspect_empty_drum"},
		Length = 5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect01"))
				end
			},
			{
				Time = 1,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect02"))
				end
			},
			{
				Time = 2,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Inspect03"))
				end
			},
		}
	},
	["Firemode_Auto"] = {
		Sequences = {"semi_off"},
		Length = 0.5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Selectfire"))
				end
			}
		}
	},
	["Firemode_Semi"] = {
		Sequences = {"semi_on"},
		Length = 0.5,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW19_P320.Selectfire"))
				end
			}
		}
	},
	["Jog_Out"] = {
		Sequences = {"jog_out"},
		Fps = 30,
		NextSequence = "Idle"
	},
	["Jump"] = {
		Sequences = {"jump"},
		Fps = 15,
		NextSequence = "Idle"
	},
	["Land"] = {
		Sequences = {"jump_land"},
		Fps = 30,
		NextSequence = "Idle"
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
					--self:DoSound(Sound("MW_Melee.Miss_Small"))
				end
			}
		}
	},
	["Melee_Hit"] = {
		Sequences = {"melee_hit_01", "melee_hit_02", "melee_hit_03"},
		Length = 0.3, --if melee hits
		Damage = 15,
		Fps = 30,
		NextSequence = "Idle",
		Events = {
			{
				Time = 0,
				Callback = function(self)
					--self:DoSound(Sound("MW_Melee.Flesh_Small"))
				end
			}
		}
	},
}