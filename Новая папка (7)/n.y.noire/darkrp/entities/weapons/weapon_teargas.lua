--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/weapon_teargas.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "base_swb"
SWEP.PrintName = "Слезоточивый газ"
SWEP.Author = "MacTavish"
SWEP.Purpose = "Yes"
SWEP.Slot = 4
SWEP.SlotPos = 4
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/cstrike/c_eq_flashbang.mdl"
SWEP.WorldModel = "models/weapons/w_eq_flashbang.mdl"
SWEP.ViewModelFOV = 45
SWEP.UseHands = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.HitDistance = 48
SWEP.TrowPower = 1000

SWEP.ShowViewModel = true
SWEP.ShowWorldModel = true

-- SWEP.WElements = {
-- 	["element_name"] = { type = "Model", model = "models/weapons/tfa_csgo/w_molotov.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.276, 2.009, 0), angle = Angle(180, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
-- }

function SWEP:Initialize()
	self:SetHoldType("slam")
	self:SetItem("molotov")

	self:InitializeModels()

	self.initfix = true
end

function SWEP:SetupDataTables()
	self:NetworkVar("String", 0, "Item")
	self:NetworkVar("Float", 0, "NextIdle")
	self:NetworkVar("Float", 1, "NextMeleeAttack")
end

function SWEP:UpdateNextIdle()
	local vm = self:GetOwner():GetViewModel()
	self:SetNextIdle(CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:SwingHands(rh)
	if self:GetOwner():Thirst() < 5 then return end

	self.Droping = true

	self:SetHoldType("grenade")
	--self:GetOwner():SetAnimation(PLAYER_ATTACK1)

	--self:GetOwner():ViewPunch(Angle(math.random(3), math.random(-1, 1), math.random(-1, 1)))
	self.TrowPower = rh and 700 or 1100
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("pullpin")) --throw
	self:EmitSound("weapons/tfa_csgo/molotov/fire_idle_loop_1.wav")
	self:UpdateNextIdle()
	self:SetNextMeleeAttack(CurTime() + vm:SequenceDuration())

	self:SetNextPrimaryFire(CurTime() + 5)
	self:SetNextSecondaryFire(CurTime() + 5)

end

function SWEP:PrimaryAttack()
	self:SwingHands()
	return
end

function SWEP:SecondaryAttack()
	self:SwingHands(true)
	return
end

function SWEP:Reload() end

function SWEP:DealDamage()
	self:GetOwner():LagCompensation(true)

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("throw")) --throw
	self:EmitSound("weapons/tfa_csgo/molotov/grenade_throw.wav")
	self:UpdateNextIdle()

	self:GetOwner():LagCompensation(false)

	if CLIENT then return end

	local pos = self:GetOwner():GetShootPos()
	local ang = self:GetOwner():GetAimVector():Angle()
	pos = pos + ang:Forward() * 0 + ang:Right() * 5 + ang:Up() * -5 / 2

	local ent = ents.Create("weapon_thow")
	ent:SetModel("models/weapons/w_eq_flashbang.mdl")
	ent.TrowType = "teargas"
	ent:SetOwner(self:GetOwner())
	ent:SetPos(pos)
	ent:SetAngles(ang)
	ent:Spawn()
	ent:Activate()
	ent:GetPhysicsObject():ApplyForceCenter(self:GetOwner():GetAimVector() * self.TrowPower)
	self:GetOwner():SetAnimation(PLAYER_ATTACK1)

	timer.Simple(0.5, function()
		if IsValid(self:GetOwner()) then
			self:GetOwner():StripWeapon(self:GetClass())
		end
	end)


	self:GetOwner():TakeThirst(1, true)
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("deploy"))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	self:UpdateNextIdle()

	return true
end

function SWEP:Holster()
	if self.Droping then return false end

	self:SetNextMeleeAttack(0)

	self:SetNextPrimaryFire(CurTime() + 3)
	self:SetNextSecondaryFire(CurTime() + 3)

	if IsValid(self:GetOwner()) and IsValid(self:GetOwner():GetViewModel()) and CLIENT then
		self:ResetBonePositions(self:GetOwner():GetViewModel())
	end

	return true
end

function SWEP:Think()
	local vm = self:GetOwner():GetViewModel()
	local curtime = CurTime()
	local idletime = self:GetNextIdle()

	if (idletime > 0 and curtime > idletime) then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("idle"))
		self:UpdateNextIdle()
	end

	local meleetime = self:GetNextMeleeAttack()

	if (meleetime > 0 and curtime > meleetime) then
		self:DealDamage()
		self:SetNextMeleeAttack(0)
	end

	if self.initfix then
		self.initfix = nil
		self:Deploy()
	end
end