--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/weapons/weapon_simrepair.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Spawnable = true
SWEP.AdminSpawnable = false
SWEP.Base = "base_swb"
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_wrench.mdl"
SWEP.UseHands = true
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 45
SWEP.Weight = 42
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.HoldType = "physgun"
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.DrawCrosshair = false
SWEP.ShowViewModel = false
SWEP.ShowWorldModel = false

SWEP.WElements = {
	["model"] = { type = "Model", model = "models/weapons/tfa_nmrih/w_me_wrench.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(1, 1.2, 3), angle = Angle(10, 0, 180), size = Vector(1, 1, 1), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {}, hideFunc = function(self)
		return self:GetWelding()
	end },
	["model1"] = { type = "Model", model = "models/props_junk/torchoven_01_gastorch.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.618, 1.279, -3.152), angle = Angle(0, 166.828, 180), size = Vector(1, 1, 1), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {}, hideFunc = function(self)
		return not self:GetWelding()
	end }
}

if CLIENT then
	SWEP.PrintName = "Инструменты"
	SWEP.Author = "MacTavish"
	SWEP.Slot = 2
	SWEP.SlotPos = 9
	SWEP.IconLetter = "k"
end

local REPAIR_MODES = {
	hull    = {name = "Кузов",        iconKey = "car"},
	glass   = {name = "Стёкла",       iconKey = "car_windshield"},
	wheel   = {name = "Колеса",       iconKey = "car_brake_idle"},
	engine  = {name = "Двигатель",    iconKey = "engine"},
	battery = {name = "Аккумулятор",  iconKey = "car_battery"},
}

local REPAIR_MODE_ORDER = {"hull", "glass", "wheel", "engine", "battery"}

SWEP.RepairModes = REPAIR_MODES
SWEP.RepairModeOrder = REPAIR_MODE_ORDER

SWEP.RapairTimer = 35
SWEP.PartScanRange = 60

local tert = {
	["workshop"] = true,
	["warehouse"] = true,
}

local vec0 = Vector()
function SWEP:GetWelding()
	if self:GetWeld() and self:GetWeld() ~= vec0 then
		return self:GetWeld()
	end

	return nil
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextIdle")
	self:NetworkVar("String", 0, "RepairMode")
	self:NetworkVar("Bool", 0, "Repairing")
	self:NetworkVar("Vector", 0, "Weld")
end

function SWEP:Initialize()
	self:SetHoldType("normal")
	self:InitializeModels()

	if SERVER and self:GetRepairMode() == "" then
		self:SetRepairMode("hull")
	end
end

function SWEP:Think()
	local vm = self:GetOwner():GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if (idletime > 0 and curtime > idletime) then
		local idle = "Idle"

		if idle then
			vm:SendViewModelMatchingSequence(vm:LookupSequence(idle))
			self:UpdateNextIdle()
		end
	end

	local ply = self:GetOwner()

	if self:GetRepairing() and self:GetWelding() and (not self.nextfx or self.nextfx < curtime ) then
		self.nextfx = curtime + 0.1
		if SERVER then
			ply:EmitSound("ambient/energy/newspark0" .. math.random(5)  .. ".wav")
			if not ply:checkDarkRPVar("face", "weldingmask") and (not self.blastreact or self.blastreact < curtime ) then
				self.blastreact = curtime + math.random(2,3)
				DarkRP.PlayerGesture(ply, "react_blast")
			end
		end
		local trace = util.TraceLine({
			start = ply:EyePos(),
			endpos = self:GetWelding(),
			filter = {ply, self}
		})
		local ef = EffectData()
		ef:SetOrigin(trace.HitPos)
		ef:SetNormal(trace.HitNormal)
		util.Effect("ManhackSparks", ef)
	end

	if CLIENT then return end

	if not self.Repair or not timer.Exists("Repair" .. ply:UserID()) then return end

	if self.StopRem or not ply:IsFreeman() or not IsValid(self.Repair) or (IsValid(self.Repair) and not DarkRP.InRange(self.Repair, ply, 250)) then
		self:CancelRepair()
		self:SetNextPrimaryFire(CurTime() + 1)
	end
end

function SWEP:CancelRepair()
	local ply = self:GetOwner()

	self.StopRem = nil
	if IsValid(self.Repair) then
		self.Repair.Towed = nil
	end
	self.Repair = nil
	self:SetRepairing(false)

	if IsValid(ply) then
		timer.Remove("Repair" .. ply:UserID())
		net.SendSingleMessage("RemovePropgressBar", ply)
		ply:SetNW2Bool("SitAnyG_", false)
		ply:StopSound("vcmod/socket_wrench.wav")
		DarkRP.StopAnimation(ply)
	end

	if IsValid(self.toolbox) and IsValid(self.toolbox:GetPhysicsObject()) then
		self.toolbox.Draged = nil
		self.toolbox:GetPhysicsObject():EnableMotion(true)
	end

	if IsValid(self.part) and IsValid(self.part:GetPhysicsObject()) then
		self.part.Draged = nil
		self.part:GetPhysicsObject():EnableMotion(true)
	end
end

function SWEP:GetTerritoryTimer(base)
	local ply = self:GetOwner()
	if not ply.LastTerritiry or not ply.LastTerritiry:IsInside(ply) or ply.LastTerritiry.m_type ~= TERRITORY_TYPE_BUYABLE or not ply.LastTerritiry.type or not tert[ply.LastTerritiry.type] or not ply:IsTerritoryOwner(ply.LastTerritiry) then
		return base * 1.1
	end
	return base * 0.6
end

function SWEP:FindJunkInRange(eclass, carClass)
	local ply = self:GetOwner()
	if not IsValid(ply) then return end
	for _, v in ipairs(ents.FindInSphere(ply:GetPos(), self.PartScanRange)) do
		if not IsValid(v) or v:GetClass() ~= "spawned_junk" then continue end
		if v:Geteclass() ~= eclass then continue end
		if v.Draged then continue end
		if carClass and v.carclass and v.carclass ~= "" and v.carclass ~= carClass then continue end
		return v
	end
end

-- Per-mode plans. Each entry:
--   valid(swep, ply, ent) -> veh, ratio, wheelEnt (or nil to abort)
--   plan(swep, ply, veh, ratio, wheelEnt) -> {toolbox, part, apply(veh), wheel?} or nil to abort
local Modes = {}

local function ResolveVehicle(ent)
	local class = ent:GetClass():lower()
	if class == "gmod_sent_vehicle_fphysics_base" then
		return ent, false
	end
	if class == "gmod_sent_vehicle_fphysics_wheel" then
		return ent:GetBaseEnt(), true
	end
	return nil
end

Modes.hull = {
	valid = function(swep, ply, ent)
		local veh = ResolveVehicle(ent)
		if not IsValid(veh) then return end
		local sat = veh:GetHullHealth() / veh:GetMaxHealth()
		if sat >= 1 then DarkRP.notify(ply, 1, 4, "Кузов в полном порядке") return end
		if not DarkRP.InRangeVector(veh:WorldSpaceCenter(), ply:GetPos(), 110) then
			DarkRP.notify(ply, 1, 4, "Подойдите ближе")
			return
		end
		return veh, sat
	end,
	plan = function(swep, ply, veh, sat)
		local needsParts, repairTo
		if sat < 0.5 then
			needsParts = true
			repairTo = 0.5
		else
			needsParts = (1 - sat) > 0.35
			repairTo = 1
		end

		local toolbox = swep:FindJunkInRange("toolbox")
		if not IsValid(toolbox) then DarkRP.notify(ply, 1, 5, "Положите рем. комплект рядом") return end

		local part
		if needsParts then
			part = swep:FindJunkInRange("parts_hull", veh:GetSpawn_List())
			if not IsValid(part) then DarkRP.notify(ply, 1, 5, "Положите запчасти кузова для этого авто рядом") return end
		end

		return {
			toolbox = toolbox,
			part = part,
			weld = sat < 0.5,
			apply = function()
				local MaxHealth = veh:GetMaxHealth()
				local NewHealth = math.Round(MaxHealth * repairTo)
				veh:SetHullHealth(NewHealth)
				if NewHealth >= (MaxHealth * 0.5) then
					veh:SetOnSmoke(false)
					veh.startdelay = nil
				end
			end,
		}
	end,
}

Modes.engine = {
	valid = function(swep, ply, ent)
		local veh = ResolveVehicle(ent)
		if not IsValid(veh) then return end
		local ehp = veh:GetEngineHP()
		if ehp >= 100 then DarkRP.notify(ply, 1, 4, "Двигатель в порядке") return end
		if not DarkRP.InRangeVector(veh:GetEnginePos(), ply:GetPos(), 90) then
			DarkRP.notify(ply, 1, 4, "Подойдите ближе к мотору")
			return
		end
		if veh:EngineActive() then
			DarkRP.notify(ply, 1, 4, "Отключите двигатель!")
			return
		end
		return veh, ehp / 100
	end,
	plan = function(swep, ply, veh, sat)
		local needsParts, repairTo
		if sat < 0.5 then
			needsParts = true
			repairTo = 0.55
		else
			needsParts = (1 - sat) > 0.35
			repairTo = 1
		end

		local toolbox = swep:FindJunkInRange("toolbox")
		if not IsValid(toolbox) then DarkRP.notify(ply, 1, 5, "Положите рем. комплект рядом") return end

		local part
		if needsParts then
			part = swep:FindJunkInRange("parts_engine", veh:GetSpawn_List())
			if not IsValid(part) then DarkRP.notify(ply, 1, 5, "Положите запчасти двигателя для этого авто рядом") return end
		end

		if veh:EngineActive() then
			DarkRP.notify(ply, 1, 4, "Отключите двигатель!")
			return
		end

		return {
			toolbox = toolbox,
			part = part,
			timerBase = sat < 0.5 and 110 or 70,
			apply = function()
				veh:SetEngineHP(math.Round(100 * repairTo))
			end,
		}
	end,
}

Modes.glass = {
	valid = function(swep, ply, ent)
		local veh = ResolveVehicle(ent)
		if not IsValid(veh) then return end
		if veh:GetHull() < 0.9 then DarkRP.notify(ply, 1, 4, "Сначала восстановите кузов до 90%") return end
		if not veh.glassbroken then DarkRP.notify(ply, 1, 4, "Стёкла целы") return end
		if not DarkRP.InRangeVector(veh:WorldSpaceCenter(), ply:GetPos(), 110) then
			DarkRP.notify(ply, 1, 4, "Подойдите ближе")
			return
		end
		return veh
	end,
	plan = function(swep, ply, veh)
		local toolbox = swep:FindJunkInRange("toolbox")
		if not IsValid(toolbox) then DarkRP.notify(ply, 1, 5, "Положите рем. комплект рядом") return end
		local part = swep:FindJunkInRange("parts_glass", veh:GetSpawn_List())
		if not IsValid(part) then DarkRP.notify(ply, 1, 5, "Положите стёкла для этого авто рядом") return end

		return {
			toolbox = toolbox,
			part = part,
			timerBase = 90,
			apply = function()
				if not veh.glassbroken then return end
				for k, v in pairs(veh.glassbroken) do
					veh:SetSubMaterial(k, v)
				end
				veh:SetNW2Int("BrokenGlass", nil)
				veh.glassbroken = nil
			end,
		}
	end,
}

Modes.wheel = {
	valid = function(swep, ply, ent)
		local class = ent:GetClass():lower()
		if class ~= "gmod_sent_vehicle_fphysics_wheel" then
			DarkRP.notify(ply, 1, 4, "Наведитесь на колесо")
			return
		end
		if not ent:GetDamaged() then DarkRP.notify(ply, 1, 4, "Колесо в порядке") return end
		local veh = ent:GetBaseEnt()
		if not IsValid(veh) then return end
		return veh, nil, ent
	end,
	plan = function(swep, ply, veh, _, wheelEnt)
		local toolbox = swep:FindJunkInRange("toolbox")
		if not IsValid(toolbox) then DarkRP.notify(ply, 1, 5, "Положите рем. комплект рядом") return end

		return {
			toolbox = toolbox,
			wheel = true,
			timerBase = 28,
			apply = function()
				if IsValid(wheelEnt) then wheelEnt:SetDamaged(false) end
			end,
		}
	end,
}

Modes.battery = {
	valid = function(swep, ply, ent)
		local veh = ResolveVehicle(ent)
		if not IsValid(veh) then return end
		if not DarkRP.InRangeVector(veh:GetEnginePos(), ply:GetPos(), 90) then
			DarkRP.notify(ply, 1, 4, "Подойдите ближе к мотору")
			return
		end

		if veh:EngineActive() then
			DarkRP.notify(ply, 1, 4, "Отключите двигатель!")
			return
		end

		local bat = veh:GetBattery()
		local op

		if bat >= 5 then
			op = "remove"
		elseif bat < 5 then
			op = "install"
		else
			DarkRP.notify(ply, 1, 4, "Аккумулятор не в подходящем состоянии для замены")
			return
		end

		return veh, op
	end,
	plan = function(swep, ply, veh, op)
		if op == "install" then
			local part = swep:FindJunkInRange("parts_battery")
			if not IsValid(part) then DarkRP.notify(ply, 1, 5, "Положите аккумулятор рядом") return end

			if veh:EngineActive() then
				DarkRP.notify(ply, 1, 4, "Отключите двигатель!")
				return
			end

			return {
				part = part,
				timerBase = 15,
				apply = function()
					local lvl = tonumber(part.batlvl) or 100
					veh:SetBattery(math.Clamp(lvl, 0, 100))
				end,
			}
		end

		-- remove
		return {
			timerBase = 15,
			apply = function()
				local lvl = veh:GetBattery()
				veh:SetBattery(0)
				local pos = ply:GetPos()
				local junk = DarkRP.CreateJunk("parts_battery", pos + Vector(0, 0, 30))
				if IsValid(junk) then
					junk.batlvl = lvl
				end
			end,
		}
	end,
}

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 1)

	if CLIENT then return end

	local ply = self:GetOwner()
	if not IsValid(ply) then return end

	local Trace = ply:GetEyeTrace()
	local ent = Trace.Entity
	if not IsValid(ent) then return end

	if Trace.HitPos:DistToSqr(ply:GetPos()) > 14000 then
		DarkRP.notify(ply, 1, 5, "Подойдите ближе к машине")
		return
	end

	local mode = self:GetRepairMode()
	if mode == "" then mode = "hull" end
	local def = Modes[mode]
	if not def then return end

	local veh, sat, wheelEnt = def.valid(self, ply, ent)
	if not IsValid(veh) then return end

	if IsValid(veh.Towed) then
		DarkRP.notify(ply, 1, 5, "Вы не можете приступить к ремонту сейчас")
		return
	end

	if veh:GetIsVehicleLocked() then
		DarkRP.notify(ply, 1, 5, "Вы не можете приступить к ремонту закрытой машины")
		return
	end

	local Driver = veh:GetDriver()
	if IsValid(Driver) then
		DarkRP.notify(ply, 1, 5, "В машине есть люди")
		return
	end

	if istable(veh.pSeat) then
		for i = 1, table.Count(veh.pSeat) do
			if IsValid(veh.pSeat[i]) and IsValid(veh.pSeat[i]:GetDriver()) then
				DarkRP.notify(ply, 1, 5, "В машине есть люди")
				return
			end
		end
	end

	local plan = def.plan(self, ply, veh, sat, wheelEnt)
	if not plan then return end

	local timerLen = self:GetTerritoryTimer(plan.timerBase or 40)

	veh.Towed = ply
	self.Repair = veh
	self.toolbox = plan.toolbox
	self.part = plan.part
	self:SetRepairing(true)

	local anim = plan.wheel and "roofidle1" or "d1_town05_leon_lean_table_idle"
	if ply:getDarkRPVar("gender") == "female" then anim = "d1_town05_jacobs_heal" end

	if plan.weld then
		anim = ply:getDarkRPVar("gender") == "male" and "welder_loop" or "cidle_slam"
		self:SetWeld(Trace.HitPos)
		if not ply:checkDarkRPVar("face", "weldingmask") then timerLen = timerLen * 3 end
	else
		if ply:checkDarkRPVar("face", "weldingmask") then timerLen = timerLen * 3 end
		self:SetWeld(Vector())
	end

	self.RapairTimer = timerLen
	self:SetNextPrimaryFire(CurTime() + timerLen)
	ply:SetNW2Bool("SitAnyG_", true)
	ply:SetDarkRPVar("sa", 1)
	ply.LastSit = CurTime() + timerLen

	if not plan.weld then
		ply:EmitSound("vcmod/socket_wrench.wav")
	end

	net.Start("DrawProgressBar")
		net.WriteFloat(timerLen)
	net.Send(ply)

	timer.Simple(0.1, function()
		if not IsValid(ply) then return end
		DarkRP.ForceAnimation(ply, anim, timerLen)
	end)

	-- lock toolbox + part in place during repair
	if IsValid(plan.toolbox) and IsValid(plan.toolbox:GetPhysicsObject()) then
		plan.toolbox:GetPhysicsObject():EnableMotion(false)
		plan.toolbox.Draged = true
	end

	if IsValid(plan.part) then
		if IsValid(plan.part:GetPhysicsObject()) then
			plan.part:GetPhysicsObject():EnableMotion(false)
		end
		plan.part.Draged = true
	end

	local startUses = IsValid(plan.toolbox) and plan.toolbox:Getuses() or 0

	timer.Create("Repair" .. ply:UserID(), timerLen + 0.1, 1, function()
		if IsValid(self) then
			self.Repair = nil
			self.toolbox = nil
			self.part = nil
			self:SetRepairing(false)
		end

		if IsValid(ply) then
			if not ply:Alive() then return end
			ply:SetNW2Bool("SitAnyG_", false)
			ply:StopSound("vcmod/socket_wrench.wav")
			if plan.wheel then ply:EmitSound("vcmod/air_piston.wav") end
			ply:JobXPAdd("car", 25)
		end

		if IsValid(veh) then
			veh.Towed = nil
			plan.apply()
			sound.Play("vcmod/air_wrench_long.wav", IsValid(self) and self:GetPos() or veh:GetPos(), 75)
		end

		-- consume one toolbox use
		if IsValid(plan.toolbox) then
			local us = (plan.toolbox:Getuses() or startUses) - 1
			if us < 1 then
				plan.toolbox:Remove()
			else
				plan.toolbox:Setuses(us)
				plan.toolbox.weight = us * 0.4 + 2
				if IsValid(plan.toolbox:GetPhysicsObject()) then
					plan.toolbox.Draged = nil
					plan.toolbox:GetPhysicsObject():EnableMotion(true)
				end
			end
		end

		-- consume the part if one was required
		if IsValid(plan.part) then
			plan.part:Remove()
		end
	end)
end

if CLIENT then
	local clrs = {
		m = Color(255, 255, 255, 200),
		s = Color(127, 127, 127, 150),
		d = Color(0, 0, 0, 20),
		r = Color(255, 0, 0),
	}

	local REPAIR_POS = {
		hull = function(ent)
			return ent:WorldSpaceCenter(), MSD.PinPoints[64]
		end,
		glass = function(ent)
			return ent:WorldSpaceCenter(), MSD.Icons48.car_windshield_outline
		end,
		wheel = function(ent)
			return
		end,
		engine = function(ent)
			return ent:GetEnginePos(), MSD.Icons48.engine_outline
		end,
		battery = function(ent)
			return ent:GetEnginePos(), MSD.Icons48.car_battery
		end,
	}

	local function OpenRadial(buildPage, holdKeyCheck, selectOnClose)
		if IsValid(MSD.RadialMenu) then return end

		MSD.RadialMenu = vgui.Create("MSD.RadialMenu")
		local panel = MSD.RadialMenu
		panel:SetSize(700, 700)
		panel:MakePopup()
		panel:Center()
		panel.inittime = CurTime() + 0.15

		panel.KeyThink = function()
			if holdKeyCheck and panel.inittime < CurTime() and holdKeyCheck() then
				panel.Close()
			end
		end

		panel.Close = function()
			if selectOnClose then
				local selection = panel:GetCurrentSelection()
				local action = panel.m_tblButtons and panel.m_tblButtons[selection]
				if action and action.Cmd then action.Cmd() end
			end
			if IsValid(MSD.RadialMenu) then
				MSD.RadialMenu:Remove()
			end
			MSD.RadialMenu = nil
			MSD.PlaySnd("msd/ui/toggle.wav")
		end

		panel.Page = {}
		panel.OpenPage = function(id)
			page = panel.Page[id]
			if not page then return end
			MSD.PlaySnd("msd/ui/toggle.wav")
			panel.actions = page
			panel:Build()
		end

		buildPage(panel)
		panel.OpenPage("main")
	end

	function SWEP:OpenModeRadial()
		OpenRadial(function(panel)
			panel.Page["main"] = {}
			for _, key in ipairs(self.RepairModeOrder) do
				local m = self.RepairModes[key]
				table.insert(panel.Page["main"], {
					m.name,
					function()
						net.Start("SimRepair.SetMode")
							net.WriteString(key)
						net.SendToServer()
					end,
					MSD.Icons48[m.iconKey],
				})
			end
		end, function()
			return not input.IsMouseDown(MOUSE_RIGHT)
		end, true)
	end

	function SWEP:OpenStatsRadial()
		local ply = LocalPlayer()
		local trace = ply:GetEyeTrace()
		local ent = trace.Entity

		local veh
		if IsValid(ent) then
			local class = ent:GetClass():lower()
			if class == "gmod_sent_vehicle_fphysics_base" then
				veh = ent
			elseif class == "gmod_sent_vehicle_fphysics_wheel" then
				veh = ent:GetBaseEnt()
			end
		end

		if not IsValid(veh) then
			return
		end

		if not DarkRP.InRange(ply, veh, 200) then return end

		local hullPct = math.Round(veh:GetHull() * 100)
		local enginePct = veh:GetEngineHP()
		local batRaw = veh:GetBattery()
		local hasBattery = batRaw >= 10
		local batPct = math.Clamp(hasBattery and math.Round((batRaw - 15) / 85 * 100) or 0,0,100)

		OpenRadial(function(panel)
			panel.Page["main"] = {
				{"Кузов: " .. hullPct .. "%",       function() end, MSD.Icons48.car},
				{"Двигатель: " .. enginePct .. "%", function() end, MSD.Icons48.engine},
				{"Аккумулятор: " .. (hasBattery and (batPct .. "%") or "Нет"), function() end, MSD.Icons48.car_battery},
			}
		end, function()
			return input.IsMouseDown(MOUSE_RIGHT) or input.IsMouseDown(MOUSE_LEFT)
		end, false)
	end

	function SWEP:DrawHUD()
		if LocalPlayer():InVehicle() then return end

		if self:GetOwner():getDarkRPVar("unconscious") then return end
		local x, y = ScrW() / 2, ScrH() * 0.6
		local mod = REPAIR_MODES[self:GetRepairMode()]
		local sp = draw.SimpleTextOutlined("Режим: " .. mod.name, "MSDFont.20", x, y + 3, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		MSD.DrawKeyIcon(x - sp / 2 - 35, y, MSD.Icons48[mod.iconKey], 20)


		x, y = ScrW() / 2, ScrH() * 0.8
		sp = draw.SimpleTextOutlined("Взаимодействие с ТС", "MSDFont.20", x, y + 3, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		MSD.DrawKey(x - sp / 2 - 55, y, "ЛКМ", 155)
		sp = draw.SimpleTextOutlined("Смена режима", "MSDFont.20", x, y + 33, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		MSD.DrawKey(x - sp / 2 - 55, y + 30, "ПКМ", 155)
		sp = draw.SimpleTextOutlined("Диагностика ТС", "MSDFont.20", x, y + 63, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		MSD.DrawKey(x - sp / 2 - 55, y + 60, input.LookupBinding("+reload"), 155)

		local Trace = self:GetOwner():GetEyeTrace()
		local ent = Trace.Entity

		if not simfphys.IsCar(ent) then return end

		if not DarkRP.InRange(LocalPlayer(), ent, 200) then return end

		local pos, icon = REPAIR_POS[self:GetRepairMode()](ent)

		if pos then
			local close = DarkRP.InRangeVector(pos, self:GetOwner():GetPos(), 90)
			pos = pos:ToScreen()

			local sz = close and 32 or 24
			MSD.DrawTexturedRect(pos.x - sz / 2 + 1, pos.y - sz / 2 + 1, sz, sz, icon, color_black)
			MSD.DrawTexturedRect(pos.x - sz / 2, pos.y - sz / 2, sz, sz, icon, close and MSD.Patern.MainColor["p"] or MSD.Patern.MainColor["9"])
		end

	end
end
function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.2)
	if SERVER then return end
	self:OpenModeRadial()
end

function SWEP:Reload()
	if SERVER then
		if self:GetRepairing() then
			self.StopRem = true
		end
		return
	end

	if self:GetRepairing() then return end

	self:OpenStatsRadial()
end

function SWEP:Deploy()
	self:ChangeAnim("Draw")

	return true
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:ChangeAnim(anim)
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	self:UpdateNextIdle()

	return vm
end

function SWEP:Holster()
	self:UnloadSWB()

	return true
end

if SERVER then
	util.AddNetworkString("SimRepair.SetMode")

	net.Receive("SimRepair.SetMode", function(l, ply)
		if DarkRP.NetDelay(ply, 0.2) then return end
		local mode = net.ReadString()
		if not REPAIR_MODES[mode] then return end
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) or wep:GetClass() ~= "weapon_simrepair" then return end
		wep:SetRepairMode(mode)
		DarkRP.notify(ply, 0, 2, "Режим: " .. REPAIR_MODES[mode].name)
	end)
end
