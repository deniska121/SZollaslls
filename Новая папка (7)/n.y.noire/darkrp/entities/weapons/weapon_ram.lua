--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/weapon_ram.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.PrintName = "Таран"
SWEP.Base = "base_swb"
SWEP.Author = "MacTavish"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IsDarkRPDoorRam = true
SWEP.IconLetter = ""
SWEP.ViewModelFOV = 72
SWEP.ViewModelFlip = false
SWEP.ViewModel = "models/weapons/c_batteringram.mdl"
SWEP.WorldModel = "models/weapons/w_batteringram.mdl"
SWEP.AnimPrefix = "shotgun"
SWEP.UseHands = true
SWEP.Spawnable = true
SWEP.AdminOnly = true

SWEP.Sound = {"physics/wood/wood_crate_break4.wav", "physics/wood/wood_panel_break1.wav", "physics/wood/wood_panel_impact_hard1.wav"}

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
		model = "models/weapons/w_batteringram.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(17, 0, 0),
		angle = Angle(180, 90, -15),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

function SWEP:GetViewModelPosition(pos, ang)
	return pos + ang:Right() * 0.839 + ang:Forward() * -6.802, ang
end

function SWEP:Initialize()
	self:InitializeModels()
	self:SetHoldType("shotgun")
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

-- Check whether an object of this player can be rammed
local function canRam(ply)
	return IsValid(ply) and (ply.warranted == true or ply:isWanted() or ply:isArrested())
end

local function ramDoor(ply, trace, ent)
	if ply:EyePos():DistToSqr(trace.HitPos) > 2025 or (ent:getKeysNonOwnable()) then return false end
	local allowed = false

	if ent:isKeysOwned() and not ent:isKeysOwnedBy(ply) then
		for _, v in ipairs(player.GetAll()) do
			if ent:isKeysOwnedBy(v) and canRam(v) then
				allowed = true
				break
			end
		end
	else
		allowed = true
	end

	if GAMEMODE.Config.ManHall[ent:MapCreationID()] or GAMEMODE.Config.AlarmsLocked[ent:MapCreationID()] then return end

	local keysDoorGroup = ent:getKeysDoorGroup()

	if keysDoorGroup then
		local teamDoors = RPExtraTeamDoors[keysDoorGroup]

		if teamDoors then
			allowed = false

			for _, v in ipairs(player.GetAll()) do
				if teamDoorsv[v:Team()] and canRam(v) then
					allowed = true
					break
				end
			end
		end
	end

	if ent.AnyDoor then
		allowed = true
	end

	if CLIENT then return allowed end

	if not allowed then
		DarkRP.notify(ply, 1, 5, "Нужен ордер")

		return false
	end

	if ent.ramed then return end
	ent:keysUnLock()
	ent.oldspeed = ent:GetInternalVariable("Speed")
	local localpos = ent:WorldToLocal(ply:GetPos())

	if localpos.x < 0 then
		ent:SetKeyValue("opendir", "1")
	else
		ent:SetKeyValue("opendir", "2")
	end
	ent:SetNotSolid(true)

	timer.Simple(0, function()
		if not IsValid(ent) then return end
		ent:SetSaveValue("Speed", 1000)
		ent:Fire("Open")
		ent:Fire("lock", "", .1)
	end)

	ent.ramed = true

	timer.Simple(120, function()
		if not IsValid(ent) then return end
		ent:SetNotSolid(false)
		ent:SetSaveValue("Speed", ent.oldspeed)
		ent:SetKeyValue("opendir", "0")
		ent.oldspeed = nil
		ent.ramed = nil
	end)

	return true
end

-- Ram action when ramming a vehicle
local function ramVehicle(ply, trace, ent)
	if ply:EyePos():DistToSqr(trace.HitPos) > 10000 then return false end
	if CLIENT then return false end -- Ideally this would return true after ent:GetDriver() check

	if ent.IsSimfphyscar then
		local sit, dist = ent:GetDriverSeatPos(ply)
		ply:EmitSound("physics/metal/metal_sheet_impact_hard6.wav")

		if dist and dist <= (ent.EnterDist or 4000) then
			ent:keysUnLock()
			ent:EmitSound("physics/plastic/plastic_box_break2.wav")

			if IsValid(sit:GetDriver()) then
				sit:GetDriver().seatsw = CurTime() + 2
			end
		else
			ent:ApplyDamage(10, 0)
		end
	end

	return false
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
	if not IsValid(ent) then return fp{fn.Id, false} end
	local override = hook.Call("canDoorRam", nil, ply, trace, ent)

	return override ~= nil and fp{fn.Id, override} or ent:isDoor() and fp{ramDoor, ply, trace, ent} or ent:IsVehicle() and fp{ramVehicle, ply, trace, ent} or ent.fadeActivate and fp{ramFadingDoor, ply, trace, ent} or fp{fn.Id, false}
end

function SWEP:PrimaryAttack()
	local Owner = self:GetOwner()
	if not IsValid(Owner) then return end
	self:SetNextPrimaryFire(CurTime() + 0.5)
	Owner:LagCompensation(true)
	local trace = Owner:GetEyeTrace()
	Owner:LagCompensation(false)
	local vm = Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("fire"))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	Owner:SetAnimation(PLAYER_ATTACK1)

	if SERVER then
		timer.Simple(0.5, function()
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

function SWEP:SecondaryAttack()
	return
end