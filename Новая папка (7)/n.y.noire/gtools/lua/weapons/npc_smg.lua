--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/npc_smg.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Category = "NPC Weapons"
SWEP.Author = "MacTavish"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.Instructions = ""
SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_smg_mac10.mdl"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.Primary.ClipSize = 27 -- Size of a clip
SWEP.Primary.DefaultClip = 27 -- Default number of bullets in a clip
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Damage = 13
SWEP.Primary.Delay = 0.0001
SWEP.Primary.Penetrate = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Sound = Sound("Atmo_SMG.Outside")

if CLIENT then
	SWEP.PrintName = "NPC SMG"
	SWEP.Slot = 2
	SWEP.SlotPos = 2
end

SWEP.Weight = 30
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

function SWEP:Initialize()
	self:SetWeaponHoldType("pistol")

	if SERVER then
		self:GetOwner():Fire("DisableWeaponPickup")
		self:GetOwner():SetKeyValue("spawnflags", "256")
	end

	self:GetOwner().DeadGun = self.WorldModel
end

function SWEP:PrimaryAttack()
	if self:Clip1() <= 0 then
		self:NpcReload()
		return
	end

	self:EmitSound(self.Primary.Sound, 120)
	local ef = EffectData()
	ef:SetEntity(self)
	ef:SetAttachment(1)
	ef:SetFlags(7)
	util.Effect("MuzzleFlash", ef)

	self:TakePrimaryAmmo(1)
	if self:GetOwner():GetEnemy() == nil then return end
	if not self:GetOwner():GetEnemy() then return end
	local att = self:GetAttachment(1)
	if not att then att = self:GetOwner() end
	local posTgt = self:GetOwner():GetEnemy():LocalToWorld(self:GetOwner():GetEnemy():OBBCenter())
	local angAcc = (posTgt - att.Pos):Angle()
	local bullet = {}
	bullet.Num = self.Primary.NumberofShots --The number of shots fired
	bullet.Src = self:GetOwner():GetShootPos() --Gets where the bullet comes from
	bullet.Dir = Angle(math.ApproachAngle(att.Ang.p, angAcc.p, 45), math.ApproachAngle(att.Ang.y, angAcc.y, 35), 0):Forward()
	bullet.Tracer = 0

	local ac = (4 - self:GetOwner():GetCurrentWeaponProficiency()) * 0.1 + math.Rand(0.1, 0.2)
	bullet.Spread = Vector(ac, ac, ac)

	bullet.Damage = self.Primary.Damage
	bullet.AmmoType = self.Primary.Ammo
	self:GetOwner():FireBullets(bullet)
end

function SWEP:Reload()
end

function SWEP:NpcReload()
	if not self:IsValid() or not self:GetOwner():IsValid() then return end
	self:GetOwner():SetSchedule(SCHED_RELOAD)
end

function SWEP:NPCShoot_Primary(ShootPos, ShootDir)
	if (not self:IsValid()) or (not self:GetOwner():IsValid()) then return end
	self:PrimaryAttack()

	timer.Simple(0.02, function()
		if not self:IsValid() or not self:GetOwner():IsValid() or not self:GetOwner():GetEnemy() then return end
		self:PrimaryAttack()
	end)

	timer.Simple(0.04, function()
		if not self:IsValid() or not self:GetOwner():IsValid() or not self:GetOwner():GetEnemy() then return end
		self:PrimaryAttack()
	end)

	timer.Simple(0.06, function()
		if not self:IsValid() or not self:GetOwner():IsValid() or not self:GetOwner():GetEnemy() then return end
		self:PrimaryAttack()
	end)
end

function SWEP:GetNPCBurstSettings()
	return  10, 15, 0.001
end

function SWEP:GetNPCRestTimes()
	return  0.01, 0.02
end

if SERVER then
	AccessorFunc(SWEP, "fNPCMinBurst", "NPCMinBurst")
	AccessorFunc(SWEP, "fNPCMaxBurst", "NPCMaxBurst")
	AccessorFunc(SWEP, "fNPCFireRate", "NPCFireRate")
	AccessorFunc(SWEP, "fNPCMinRestTime", "NPCMinRest")
	AccessorFunc(SWEP, "fNPCMaxRestTime", "NPCMaxRest")

	function SWEP:OnDrop()
		self:Remove()
	end
end