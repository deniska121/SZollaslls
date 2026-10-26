--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/lockpick/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "base_swb"
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.PrintName = "Отмычка"
SWEP.Author = "MacTavish"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPLockpick = true
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false

SWEP.WElements = {
	["model"] = {
		type = "Model",
		model = "models/craphead_scripts/armory_robbery2/w_lockpick.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(3.875, 0.9, -1.491),
		angle = Angle(27.478, 90, 90),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_Spine4"] = {
		scale = Vector(1, 1, 1),
		pos = Vector(0, 0, -5),
		angle = Angle(0, 0, 0)
	},
	["lock2"] = {
		scale = Vector(1, 1, 1),
		pos = Vector(0, 0, -5),
		angle = Angle(0, 0, 0)
	},
	["lock1"] = {
		scale = Vector(1, 1, 1),
		pos = Vector(0, 0, -5),
		angle = Angle(0, 0, 0)
	}
}

SWEP.ViewModelFOV = 75
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/craphead_scripts/armory_robbery2/c_lockpick.mdl"
SWEP.WorldModel = "models/craphead_scripts/armory_robbery2/w_lockpick.mdl"
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Sound = Sound("physics/wood/wood_box_impact_hard3.wav")
SWEP.Primary.ClipSize = 10 -- Size of a clip
SWEP.Primary.DefaultClip = 10 -- Default number of bullets in a clip
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1 -- Size of a clip
SWEP.Secondary.DefaultClip = -1 -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "IsLockpicking")
	self:NetworkVar("Float", 0, "LockpickStartTime")
	self:NetworkVar("Float", 1, "LockpickEndTime")
	self:NetworkVar("Float", 2, "NextIdle")
	self:NetworkVar("Entity", 0, "LockpickEnt")
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("draw"))
	vm:SetPlaybackRate(0.9)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	self:UpdateNextIdle()

	return true
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:Initialize()
	self:SetHoldType("normal")

	if CLIENT then
		-- Create a new table for every weapon instance
		self.VElements = table.FullCopy(self.VElements)
		self.WElements = table.FullCopy(self.WElements)
		self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
		self:CreateModels(self.VElements) -- create viewmodels
		self:CreateModels(self.WElements) -- create worldmodels

		-- init view model bone build function
		if IsValid(self:GetOwner()) then
			local vm = self:GetOwner():GetViewModel()

			if IsValid(vm) then
				self:ResetBonePositions(vm)

				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(Color(255, 255, 255, 255))
				else
					vm:SetColor(Color(255, 255, 255, 1))
					vm:SetMaterial("null")
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	self:SetNextPrimaryFire(CurTime() + 0.1)
	if self:GetIsLockpicking() then return end
	local Owner = self:GetOwner()
	if not IsValid(Owner) then return end

	if SERVER and self:Clip1() < 1 then
		Owner:EmitSound("physics/plastic/plastic_box_break2.wav", 75, 100)
		Owner:StripWeapon("lockpick")
	end

	Owner:LagCompensation(true)
	local trace = Owner:GetEyeTrace()
	Owner:LagCompensation(false)
	local ent = trace.Entity
	if not IsValid(ent) or ent.DarkRPCanLockpick == false then return end
	local canLockpick = hook.Call("canLockpick", nil, Owner, ent, trace)
	if canLockpick == false then return end
	if canLockpick ~= true and (trace.HitPos:DistToSqr(Owner:GetShootPos()) > 10000 or (not ent:isDoor() and not ent:IsVehicle() and not string.find(string.lower(ent:GetClass()), "vehicle") and not ent.isFadingDoor and not (ent:IsPlayer() and ent.HandCuffed))) then return end
	if canLockpick ~= true and (GAMEMODE.Config.ManHall[ent:MapCreationID()] or GAMEMODE.Config.AlarmsLocked[ent:MapCreationID()]) then return end

	if ent.IsSimfphyscar and SERVER then
		local _, dist = ent:GetDriverSeatPos(self:GetOwner())
		if (not dist or dist > (ent.EnterDist or 4000)) then return end
	end

	self:SetHoldType("slam")
	self:SetIsLockpicking(true)
	self:SetLockpickEnt(ent)
	self:SetLockpickStartTime(CurTime())
	local endDelta = hook.Call("lockpickTime", nil, Owner, ent) or 40

	if MCR.HasTatoo(Owner, "a4") then
		endDelta = math.max(1, endDelta * 0.7)
	end

	if Owner:getDarkRPVar("focus") then
		endDelta = math.max(1, endDelta * 0.4)
	end

	self:SetLockpickEndTime(CurTime() + endDelta)

	if SERVER and ent.IsSimfphyscar then
		ent.lokepiked = true
	end

	if IsFirstTimePredicted() then
		hook.Call("lockpickStarted", nil, Owner, ent, trace)
	end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("start"))
	self:UpdateNextIdle()
	if CLIENT then return end
	self:GetOwner().lockpick = self

	local Ltime = MCR.HasTatoo(Owner, "a4") and 3 or 2

	if self.MQS_weapon then
		endDelta = 40
		Ltime = 1

		local q = MQS.HasQuest(self:GetOwner())
		local task = MQS.Quests[q.quest]

		if not task then return end

		local obj = task.objects[MQS.GetNWdata(self:GetOwner(), "quest_objective") or 0]
		local pl_pos = self:GetOwner():GetPos()

		if task and obj and obj.point and ((obj.dist or 500) + 500) ^ 2 > pl_pos:DistToSqr(obj.point) then
			endDelta = 5
			Ltime = 5
		end
	end

	DarkRP.SC.Send(self:GetOwner(), Ltime, endDelta, function(ply)
		if not IsValid(ply) or not IsValid(ply.lockpick) then return end
		ply.lockpick:Succeed()
	end, function(ply)
		if not IsValid(ply) or not IsValid(ply.lockpick) then return end
		ply.lockpick:Fail(true)
		ply.lockpick:EmitSound("doors/vent_open1.wav", 50, 200)
		DarkRP.log("crime", ply, nil, "неудачная попытка взлома " .. tostring(ent) .. (ent.McCD_UniqueId and " Номер:" .. ent.McCD_UniqueId or ""), nil, nil, ply)
	end, "weapons/357/357_reload" .. math.random(3, 4) .. ".wav")
end

function SWEP:Holster()
	if self:GetIsLockpicking() and self:GetLockpickEndTime() ~= 0 then
		self:Fail()
	end

	if CLIENT and IsValid(self:GetOwner()) then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	return true
end

function SWEP:Succeed()
	self:SetHoldType("normal")
	local ent = self:GetLockpickEnt()
	self:SetIsLockpicking(false)
	self:SetLockpickEnt(nil)

	if SERVER and not self.MQS_weapon then
		self:SetClip1(self:Clip1() - 1)
	end

	if not IsValid(ent) then return end

	if not self.MQS_weapon and ent:getKeysNonOwnable() then return end

	local override = hook.Call("onLockpickCompleted", nil, self:GetOwner(), true, ent)
	if override then return end

	if ent:IsPlayer() and ent.HandCuffed then
		ent:CuffHands()
		self:GetOwner():AddItemByClass(INV_JUNK, "cuffs")
		return
	end

	if ent.isFadingDoor and ent.fadeActivate and not ent.fadeActive then
		ent:fadeActivate()
		ent.tt = CurTime() + 120
	elseif ent.Fire then
		ent:keysUnLock()
		ent:Fire("open", "", .6)
		ent:Fire("setanimation", "open", .6)
	end

	if SERVER and self:Clip1() < 1 then
		self:GetOwner():EmitSound("physics/plastic/plastic_box_break2.wav", 75, 100)
		self:GetOwner():StripWeapon("lockpick")
	end

	if SERVER then
		DarkRP.log("crime", self:GetOwner(), nil, "взломал отмычкой " .. tostring(ent) .. (ent.McCD_UniqueId and " Номер:" .. ent.McCD_UniqueId or ""), nil, nil, self:GetOwner())
	end
end

function SWEP:Fail(remove)
	if not IsValid(self:GetOwner()) then return end

	self:SetIsLockpicking(false)
	self:SetHoldType("normal")

	if SERVER then
		DarkRP.SC.Fail(self:GetOwner(), true)
	end

	hook.Call("onLockpickCompleted", nil, self:GetOwner(), false, self:GetLockpickEnt())
	self:SetLockpickEnt(nil)

	if self.MQS_weapon then
		remove = nil
	end

	if remove and SERVER then
		self:SetClip1(self:Clip1() - 1)
	end

	if SERVER and self:Clip1() < 1 then
		self:GetOwner():EmitSound("physics/plastic/plastic_box_break2.wav", 75, 100)
		self:GetOwner():StripWeapon("lockpick")
	end

	local vm = self:GetOwner():GetViewModel()
	if not IsValid(vm) then return end
	vm:SendViewModelMatchingSequence(vm:LookupSequence("finish"))
	self:UpdateNextIdle()
end

local ia

function SWEP:Think()
	local vm = self:GetOwner():GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if (idletime > 0 and curtime > idletime) then
		ia = self:GetIsLockpicking() and "lockpick" or "idle"
		vm:SendViewModelMatchingSequence(vm:LookupSequence(ia))
		self:UpdateNextIdle()
	end

	if not self:GetIsLockpicking() or self:GetLockpickEndTime() == 0 then return end
	local trace = self:GetOwner():GetEyeTrace()

	if not IsValid(trace.Entity) or trace.Entity ~= self:GetLockpickEnt() or trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 10000 then
		self:Fail()
	end
end

if CLIENT then
	local clrs = {
		m = Color(255, 255, 255, 200),
		s = Color(127, 127, 127, 150),
		d = Color(0, 0, 0, 20),
		r = Color(255, 0, 0),
	}

	function SWEP:CheckTracerDoor(trace, ent)
		if (trace.HitPos:DistToSqr(self:GetOwner():GetShootPos()) > 10000 or (not ent:isDoor() and not ent:IsVehicle() and not string.find(string.lower(ent:GetClass()), "vehicle") and not ent.isFadingDoor and not (ent:IsPlayer() and ent.HandCuffed))) then return false end

		return true
	end

	function SWEP:DrawHUD()
		if LocalPlayer():InVehicle() then return end
		local w = ScrW()
		local h = ScrH()
		local tr = LocalPlayer():GetEyeTrace()
		local HitEnt = tr.Entity

		if not self.Time then
			self.Time = 0
		end

		if HitEnt and IsValid(HitEnt) and self:CheckTracerDoor(tr, HitEnt) then
			self.Time = math.min(1, self.Time + 2 * FrameTime())
		else
			self.Time = math.max(0, self.Time - 2 * FrameTime())
			local x, y = ScrW() * 0.5, ScrH() * 0.8
			draw.SimpleTextOutlined("Подойдите к двери или машине", "MSDFont.20", x, y, MSD.ColorAlpha(clrs.m, 220 * (1 - self.Time)), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * (1 - self.Time)))
		end

		if self.Time > 0 then
			local x, y = w / 2, h / 2
			MSD.DrawTexturedRect(x - 10, y - 10, 24, 24, MSD:Icon("lock_open"), MSD.ColorAlpha(color_black, 200 * self.Time))
			MSD.DrawTexturedRect(x - 12, y - 12, 24, 24, MSD:Icon("lock_open"), MSD.ColorAlpha((index == 2 and IsValid(HitEnt)) and clrs.r or color_white, 200 * self.Time))
			x, y = w * 0.52, h * 0.5 - 8
			local sp = MSD.DrawKey(x, y - 3, "ЛКМ", self.Time * 150)
			draw.SimpleTextOutlined("Взломать замок", "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(clrs.m, 220 * self.Time), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(clrs.d, 80 * self.Time))
		end
	end
end

function SWEP:SecondaryAttack()
	self:PrimaryAttack()
end