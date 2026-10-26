--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/entities/gmod_sent_vehicle_fphysics_base/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.PrintName = "Comedy Effect"
ENT.Author = "Blu"
ENT.Information = ""
ENT.Category = "Fun + Games"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.AutomaticFrameAdvance = true
ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Editable = true
ENT.IsSimfphyscar = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 1, "SteerSpeed", {
		KeyName = "steerspeed",
		Edit = {
			type = "Float",
			order = 1,
			min = 1,
			max = 16,
			category = "Steering"
		}
	})

	self:NetworkVar("Float", 4, "FrontSuspensionHeight", {
		KeyName = "frontsuspensionheight",
		Edit = {
			type = "Float",
			order = 4,
			min = -1,
			max = 1,
			category = "Suspension"
		}
	})

	self:NetworkVar("Float", 5, "RearSuspensionHeight", {
		KeyName = "rearsuspensionheight",
		Edit = {
			type = "Float",
			order = 5,
			min = -1,
			max = 1,
			category = "Suspension"
		}
	})

	self:NetworkVar("Int", 0, "EngineSoundPreset", {
		KeyName = "enginesoundpreset",
		Edit = {
			type = "Int",
			order = 6,
			min = -1,
			max = 14,
			category = "Engine"
		}
	})

	self:NetworkVar("Int", 1, "IdleRPM", {
		KeyName = "idlerpm",
		Edit = {
			type = "Int",
			order = 7,
			min = 1,
			max = 25000,
			category = "Engine"
		}
	})

	self:NetworkVar("Int", 2, "LimitRPM", {
		KeyName = "limitrpm",
		Edit = {
			type = "Int",
			order = 8,
			min = 4,
			max = 25000,
			category = "Engine"
		}
	})

	self:NetworkVar("Int", 3, "PowerBandStart", {
		KeyName = "powerbandstart",
		Edit = {
			type = "Int",
			order = 9,
			min = 2,
			max = 25000,
			category = "Engine"
		}
	})

	self:NetworkVar("Int", 4, "PowerBandEnd", {
		KeyName = "powerbandend",
		Edit = {
			type = "Int",
			order = 10,
			min = 3,
			max = 25000,
			category = "Engine"
		}
	})

	self:NetworkVar("Float", 6, "MaxTorque", {
		KeyName = "maxtorque",
		Edit = {
			type = "Float",
			order = 11,
			min = 20,
			max = 1000,
			category = "Engine"
		}
	})

	self:NetworkVar("Bool", 10, "Revlimiter", {
		KeyName = "revlimiter",
		Edit = {
			type = "Boolean",
			order = 12,
			category = "Engine"
		}
	})

	self:NetworkVar("Bool", 1, "TurboCharged", {
		KeyName = "turbocharged",
		Edit = {
			type = "Boolean",
			order = 13,
			category = "Engine"
		}
	})

	self:NetworkVar("Bool", 4, "SuperCharged", {
		KeyName = "supercharged",
		Edit = {
			type = "Boolean",
			order = 14,
			category = "Engine"
		}
	})

	self:NetworkVar("Bool", 14, "BackFire", {
		KeyName = "backfire",
		Edit = {
			type = "Boolean",
			order = 15,
			category = "Engine"
		}
	})

	self:NetworkVar("Bool", 15, "DoNotStall", {
		KeyName = "donotstall",
		Edit = {
			type = "Boolean",
			order = 16,
			category = "Engine"
		}
	})

	self:NetworkVar("Float", 7, "DifferentialGear", {
		KeyName = "differentialgear",
		Edit = {
			type = "Float",
			order = 17,
			min = 0.2,
			max = 6,
			category = "Transmission"
		}
	})

	self:NetworkVar("Float", 8, "BrakePower", {
		KeyName = "brakepower",
		Edit = {
			type = "Float",
			order = 18,
			min = 0.1,
			max = 500,
			category = "Wheels"
		}
	})

	self:NetworkVar("Float", 9, "PowerDistribution", {
		KeyName = "powerdistribution",
		Edit = {
			type = "Float",
			order = 19,
			min = -1,
			max = 1,
			category = "Wheels"
		}
	})

	self:NetworkVar("Float", 10, "Efficiency", {
		KeyName = "efficiency",
		Edit = {
			type = "Float",
			order = 20,
			min = 0.2,
			max = 4,
			category = "Wheels"
		}
	})

	self:NetworkVar("Float", 11, "MaxTraction", {
		KeyName = "maxtraction",
		Edit = {
			type = "Float",
			order = 21,
			min = 5,
			max = 1000,
			category = "Wheels"
		}
	})

	self:NetworkVar("Float", 12, "TractionBias", {
		KeyName = "tractionbias",
		Edit = {
			type = "Float",
			order = 22,
			min = -0.99,
			max = 0.99,
			category = "Wheels"
		}
	})

	self:NetworkVar("Bool", 17, "BulletProofTires", {
		KeyName = "bulletprooftires",
		Edit = {
			type = "Boolean",
			order = 23,
			category = "Wheels"
		}
	})

	self:NetworkVar("Vector", 0, "TireSmokeColor", {
		KeyName = "tiresmokecolor",
		Edit = {
			type = "VectorColor",
			order = 24,
			category = "Wheels"
		}
	})

	self:NetworkVar("Float", 13, "FlyWheelRPM")
	self:NetworkVar("Float", 14, "Throttle")
	self:NetworkVar("Float", 15, "Space")
	self:NetworkVar("Int", 5, "Gear")
	self:NetworkVar("Int", 6, "Clutch")
	self:NetworkVar("Bool", 5, "IsCruiseModeOn")
	self:NetworkVar("Bool", 7, "IsBraking")
	self:NetworkVar("Bool", 8, "LightsEnabled")
	self:NetworkVar("Int", 9, "LampsEnabled")
	self:NetworkVar("Int", 10, "EMSEnabled")
	self:NetworkVar("Bool", 11, "FogLightsEnabled")
	self:NetworkVar("Bool", 16, "HandBrakeEnabled")
	self:NetworkVar("Bool", 18, "IsVehicleLocked")
	self:NetworkVar("Float", 16, "VehicleSteer")
	self:NetworkVar("Entity", 0, "Driver")
	self:NetworkVar("Entity", 1, "DriverSeat")
	self:NetworkVar("Bool", 3, "Active")
	self:NetworkVar("String", 1, "Spawn_List")
	self:NetworkVar("String", 2, "Lights_List")
	self:NetworkVar("String", 3, "Soundoverride")
	self:NetworkVar("Vector", 1, "FuelPortPosition")

	if SERVER then
		self:NetworkVarNotify("FrontSuspensionHeight", self.OnFrontSuspensionHeightChanged)
		self:NetworkVarNotify("RearSuspensionHeight", self.OnRearSuspensionHeightChanged)
		self:NetworkVarNotify("TurboCharged", self.OnTurboCharged)
		self:NetworkVarNotify("SuperCharged", self.OnSuperCharged)
		self:NetworkVarNotify("Active", self.OnActiveChanged)
		self:NetworkVarNotify("Throttle", self.OnThrottleChanged)
	end

	self:AddDataTables()
end

function ENT:AddDataTables()
end

function ENT:IsSimfphyscar()
	return true
end

local TrunkCache = {}

function ENT:GetTrunkPosition()
	if not TrunkCache[self:GetSpawn_List()] then
		local obmx = self:OBBMaxs()
		local obmi = self:OBBMins()
		local obc = self:OBBCenter()
		local tp = CLIENT and self.VHL.TrunkPos or self.TrunkPos
		TrunkCache[self:GetSpawn_List()] = tp and tp(obc, obmi, obmx, self) or Vector(obmi.x + 15, obc.y, obc.z)
	end

	return TrunkCache[self:GetSpawn_List()]
end

local VehicleMeta = FindMetaTable("Entity")
local OldIsVehicle = VehicleMeta.IsVehicle

function VehicleMeta:IsVehicle()
	return self.IsSimfphyscar and self:IsSimfphyscar() or OldIsVehicle(self)
end

function ENT:GetBattery()
	return self:GetNW2Int("Bat", 100)
end

function ENT:GetEngineHP()
	return self:GetNW2Int("EHP", 100)
end

function ENT:GetEngineTemp()
	return self:GetNW2Int("ETP", 0)
end

function ENT:GetHullHealth()
	return self:GetNW2Float("Health", self:GetMaxHealth())
end

function ENT:GetMaxHealth()
	return self:GetNW2Float("MaxHealth", 2000)
end

function ENT:GetMaxFuel()
	return self:GetNW2Float("MaxFuel", 60)
end

function ENT:GetFuel()
	return self:GetNW2Float("Fuel", self:GetMaxFuel())
end

function ENT:GetFuelUse()
	return self:GetNW2Float("FuelUse", 0)
end

function ENT:GetFuelType()
	return self:GetNW2Int("FuelType", 1)
end

function ENT:GetFuelPos()
	return self:LocalToWorld(self:GetFuelPortPosition())
end

function ENT:OnSmoke()
	return self:GetNW2Bool("OnSmoke", false)
end

function ENT:GetBackfireSound()
	return self:GetNW2String("backfiresound")
end

function ENT:SetBackfireSound(the_sound)
	self:SetNW2String("backfiresound", the_sound)
end

function ENT:GetHull()
	return self:GetHullHealth() / self:GetMaxHealth()
end


function ENT:BodyGroupIsValid(bodygroups)
	for index, groups in pairs(bodygroups) do
		local mygroup = self:GetBodygroup(index)

		for g_index = 1, table.Count(groups) do
			if mygroup == groups[g_index] then return true end
		end
	end

	return false
end

function ENT:GetPassengerSeats()
	if not istable(self.pSeat) then
		self.pSeat = {}
		local DriverSeat = self:GetDriverSeat()

		for _, v in pairs(self:GetChildren()) do
			if v ~= DriverSeat and v:GetClass():lower() == "prop_vehicle_prisoner_pod" then
				table.insert(self.pSeat, v)
			end
		end
	end

	return self.pSeat
end

function ENT:GetVehicleClass()
	return "these are not the droids you are looking for"
end

function ENT:SetCLPass(data)
	if SERVER then
		data.gotin = CurTime() + 1
		self.npcinfo[data.sit] = data
		net.Start("simfphys_addclpass")
		net.WriteEntity(self)
		net.WriteTable(data)
		net.Broadcast()

		if self.pSeat[data.sit] and IsValid(self.pSeat[data.sit]) then
			local Driver = self.pSeat[data.sit]:GetDriver()
			if IsValid(Driver) then
				Driver:ExitVehicle()
			end
		end
	else
		local sits = {}
		local switch

		for k, v in pairs(self.npcinfo) do
			if data.sit == v.sit then
				switch = true
				data.sit = 7
			end

			sits[v.sit] = true
		end

		if switch then
			while sits[data.sit] do
				data.sit = data.sit + 1
			end

			if data.sit > 17 then
				data.sit = 17
			end
		end

		self.npcinfo[data.sit] = data
	end
end

function ENT:CreateLoopingSound(id, path, level, parent)
	local snd = self.sounds[id]

	if not snd then
		snd = CreateSound(parent or self, path)
		snd:SetSoundLevel(level)
		self.sounds[id] = snd
	end

	return snd
end

function ENT:CreateFastSound(id, path, level, parent)
	local snd = self.sounds[id]

	if snd then
		snd:Stop()
	end

	snd = CreateSound(parent or self, path)
	snd:SetSoundLevel(level)
	self.sounds[id] = snd

	return snd
end

function ENT:StopLoopSounds(id)
	local snd = self.sounds[id]

	if snd then
		snd:Stop()
		self.sounds[id] = nil
	end
end

function ENT:RemoveCLPass(pos, spawn)
	if SERVER then
		if not self.npcinfo[pos] then return end
		if self.npcinfo[pos].gotin > CurTime() then return end

		if spawn then
			local ent = ents.Create("npc_passenger")

			if self.npcinfo[pos].exf then
				ent:SetPos(self:LocalToWorld(self.npcinfo[pos].exf))
			else
				local exitpoint = ExitUsingMyTraces(IsValid(self.pSeat[2]) and self.pSeat[2] or self, ent, self, true)
				ent:SetPos(exitpoint)
			end

			ent:Spawn()
			ent:Activate()
			ent.pmdata = self.npcinfo[pos]
			ent:SetModel("models/cityrp/pm/normal/" .. ent.pmdata.gn .. "_0" .. ent.pmdata.model .. ".mdl")
			MCR.SetMatID(ent, ent.pmdata.gn, "top", ent.pmdata.top)
			MCR.SetMatID(ent, ent.pmdata.gn, "pants", ent.pmdata.pants)
		end

		net.Start("simfphys_removeclpass")
		net.WriteEntity(self)
		net.WriteInt(pos, 6)
		net.Broadcast()
		self.npcinfo[pos] = nil
	else
		if not self.npcinfo[pos] then return end
		self.npcinfo[pos] = nil

		if IsValid(self.sitnpc[pos]) then
			self.sitnpc[pos]:Remove()
		end

		self.sitnpc[pos] = nil
	end
end

function ENT:RemoveAnyCLPass(spawn)
	if SERVER then
		local _, pos = table.Random(self.npcinfo)
		self:RemoveCLPass(pos, spawn)
	end
end