--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/weapon_axe.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Slot = 3
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.PrintName = "Многофункциональный инструмент"
SWEP.Base = "base_swb"
SWEP.Author = "MacTavish"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPDoorRam = true
SWEP.IconLetter = ""
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_fubar.mdl"
SWEP.WorldModel = "models/weapons/tfa_nmrih/w_me_fubar.mdl"
SWEP.AnimPrefix = "melee2"
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.Sound = {
	"physics/wood/wood_crate_break4.wav",
	"physics/wood/wood_panel_break1.wav",
	"physics/wood/wood_panel_impact_hard1.wav"
}
SWEP.Primary.ClipSize = -1 -- Size of a clip
SWEP.Primary.DefaultClip = 0 -- Default number of bullets in a clip
SWEP.Primary.Automatic = false -- Automatic/Semi Auto
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1 -- Size of a clip
SWEP.Secondary.DefaultClip = 0 -- Default number of bullets in a clip
SWEP.Secondary.Automatic = false -- Automatic/Semi Auto
SWEP.Secondary.Ammo = ""
SWEP.ShowWorldModel = false

SWEP.WElements = {
	["model"] = {
		type = "Model",
		model = "models/weapons/tfa_nmrih/w_me_fubar.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(4, -2, 2),
		angle = Angle(180, 90, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

function SWEP:Initialize()
	self:InitializeModels()

	self:SetHoldType("melee2")
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("draw"))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:EmitSound("viper/weapons/mike4/wfoly_ar_mike4_inspect_01.ogg")

	return true
end

function SWEP:Holster()
	self:UnloadSWB()

	return true
end

local function ramDoor(ply, trace, ent)
	if ply:EyePos():DistToSqr(trace.HitPos) > 2025 then return false end
	local allowed = true

	if CLIENT then return allowed end

	if ent.ramed then return end

	ent:keysUnLock()
	ent.oldspeed = ent:GetInternalVariable("Speed")
	ent:SetSaveValue("Speed", ent.oldspeed * 7)

	local localpos = ent:WorldToLocal(ply:GetPos())
	if localpos.x < 0 then
		ent:SetKeyValue("opendir", "1")
	else
		ent:SetKeyValue("opendir", "2")
	end

	ent:Fire("Open")
	ent.ramed = true

	timer.Simple(0.1, function()
		if not IsValid(ent) then return end
		ent:SetNotSolid(false)
		ent:SetSaveValue("Speed", ent.oldspeed)
		ent:SetKeyValue("opendir", "0")
		ent.oldspeed = nil
		ent.ramed = nil
	end)

	return true
end

local function ramVehicle(ply, trace, ent)
	if ply:EyePos():DistToSqr(trace.HitPos) > 10000 then return false end
	if CLIENT then return false end -- Ideally this would return true after ent:GetDriver() check

	if ent.IsSimfphyscar then
		ent:BreakGlass()
		ent:ApplyDamage(10, 0)
	end

	return true
end

local function ramFadingDoor(ply, trace, ent)
	if ply:EyePos():DistToSqr(trace.HitPos) > 10000 then return false end
	if CLIENT then return true end

	if not ent.fadeActive then
		ent:fadeActivate()
		ent.tt = CurTime() + 120
	end

	return true
end

local function getRamFunction(ply, trace)
	local ent = trace.Entity
	if not IsValid(ent) then return false end

	if GAMEMODE.Config.ManHall[ent:MapCreationID()] or GAMEMODE.Config.AlarmsLocked[ent:MapCreationID()] then return false end

	return ent:isDoor() and fp{ramDoor, ply, trace, ent} or ent.fadeActivate and fp{ramFadingDoor, ply, trace, ent} or false
end

local function getRamVehicle(ply, trace)
	local ent = trace.Entity
	if not IsValid(ent) then return false end

	return ent:IsVehicle() and fp{ramVehicle, ply, trace, ent} or false
end

function SWEP:ramDoor(Owner, trace)
	self:SetHoldType("melee")
	local vm = Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("attack_charge_begin"))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	timer.Simple(1.7, function()
		if not IsValid(self) then return end
		self:SetHoldType("melee2")
		vm = self:GetOwner():GetViewModel()
		vm:SendViewModelMatchingSequence(vm:LookupSequence("attack_charge_end"))
		vm:SetPlaybackRate(1)
		self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
		Owner:SetAnimation(PLAYER_ATTACK1)
		--melee_2h_left
	end)
	if SERVER then
		timer.Simple(1.9, function()
			if not IsValid(Owner) then return end
			local hasRammed = getRamFunction(Owner, trace)()
			hook.Call("onDoorRamUsed", GAMEMODE, hasRammed, Owner, trace)
			if not hasRammed then return end
			self:SetNextPrimaryFire(CurTime() + 1.5)
			Owner:EmitSound(self.Sound[math.random(#self.Sound)])
			Owner:ViewPunch(Angle(-10, math.random(-5, 5), 0))
		end)
	end
end

function SWEP:ramVehicle(Owner, trace)
	self:SetHoldType("melee")
	local vm = Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("shove"))
	vm:SetPlaybackRate(1)
	Owner:SetAnimation(PLAYER_ATTACK1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())

	if SERVER then
		timer.Simple(.25, function()
			self:SetHoldType("melee2")
			if not IsValid(Owner) then return end
			local hasRammed = getRamVehicle(Owner, trace)()
			hook.Call("onDoorRamUsed", GAMEMODE, hasRammed, Owner, trace)
			if not hasRammed then return end
			self:SetNextPrimaryFire(CurTime() + 1.5)
			Owner:ViewPunch(Angle(-10, math.random(-5, 5), 0))
		end)
	end
end

function SWEP:PrimaryAttack()
	local Owner = self:GetOwner()
	if not IsValid(Owner) then return end
	self:SetNextPrimaryFire(CurTime() + 0.5)

	Owner:LagCompensation(true)
	local trace = Owner:GetEyeTrace()
	Owner:LagCompensation(false)
	if getRamFunction(Owner, trace) then
		self:ramDoor(Owner, trace)
	end

	if getRamVehicle(Owner, trace) then
		self:ramVehicle(Owner, trace)
	end
end

function SWEP:SecondaryAttack()
	return
end