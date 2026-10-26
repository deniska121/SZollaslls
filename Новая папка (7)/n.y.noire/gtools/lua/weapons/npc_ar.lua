--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/npc_ar.lua
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
SWEP.WorldModel = "models/weapons/w_rif_ak47.mdl"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.Primary.ClipSize = 18 -- Size of a clip
SWEP.Primary.DefaultClip = 18 -- Default number of bullets in a clip
SWEP.Primary.Automatic = true -- Automatic/Semi Auto
SWEP.Primary.Ammo = "SMG1"
SWEP.Primary.Damage = 22
SWEP.Primary.Delay = 0.2
SWEP.Primary.Penetrate = 10
SWEP.Primary.NumShots = 1
SWEP.Primary.Sound = Sound("mw19.akilo47.fire")

if CLIENT then
	SWEP.PrintName = "NPC AR"
	SWEP.Slot = 2
	SWEP.SlotPos = 2
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "GunType")
end

SWEP.Weight = 30
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true

SWEP.SpawnVars = {
	[1] = {"models/weapons/w_rif_ak47.mdl", Sound("mw19.akilo47.fire"), 30, 0.2, 18},
	[2] = {"models/weapons/w_rif_m4a1.mdl", Sound("mw19.mike4.fire"), 25, 0.1, 22}
}

function SWEP:Initialize()
	self:SetWeaponHoldType("ar2")

	if SERVER then
		self:GetOwner():Fire("DisableWeaponPickup")
		self:GetOwner():SetKeyValue("spawnflags", "256")
		self:SetGunType(math.random(#self.SpawnVars))
	end

	timer.Simple(1, function()
		if not IsValid(self) then return end
		local wt = self.SpawnVars[self:GetGunType()]
		self.Primary.Sound = wt[2]
		self.Primary.Damage = wt[3]
		self.Primary.Delay = wt[4]
		self.Primary.ClipSize = wt[5]
		self.Primary.DefaultClip = wt[5]
		self.WorldModel = wt[1]
		self:SetModel(wt[1])
		if not IsValid(self:GetOwner()) then return end
		self:GetOwner().DeadGun = wt[1]
	end)
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

	local ac = (4 - self:GetOwner():GetCurrentWeaponProficiency()) * 0.1 + math.Rand(0.01, 0.08)
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
end

function SWEP:GetNPCBurstSettings()
	return  3, 5, self.Primary.Delay
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

SWEP.ActivityTranslateAI = {
	[ACT_RANGE_ATTACK1] = ACT_RANGE_ATTACK_AR2,
	[ACT_RELOAD] = ACT_RELOAD_SMG1,
	[ACT_IDLE] = ACT_IDLE_SMG1,
	[ACT_IDLE_ANGRY] = ACT_IDLE_ANGRY_SMG1,
	[ACT_WALK] = ACT_WALK_RIFLE,
	[ACT_IDLE_RELAXED] = ACT_IDLE_SMG1_RELAXED,
	[ACT_IDLE_STIMULATED] = ACT_IDLE_SMG1_STIMULATED,
	[ACT_IDLE_AGITATED] = ACT_IDLE_ANGRY_SMG1,
	[ACT_WALK_RELAXED] = ACT_WALK_RIFLE_RELAXED,
	[ACT_WALK_STIMULATED] = ACT_WALK_RIFLE_STIMULATED,
	[ACT_WALK_AGITATED] = ACT_WALK_AIM_RIFLE,
	[ACT_RUN_RELAXED] = ACT_RUN_RIFLE_RELAXED,
	[ACT_RUN_STIMULATED] = ACT_RUN_RIFLE_STIMULATED,
	[ACT_RUN_AGITATED] = ACT_RUN_AIM_RIFLE,
	[ACT_IDLE_AIM_RELAXED] = ACT_IDLE_SMG1_RELAXED,
	[ACT_IDLE_AIM_STIMULATED] = ACT_IDLE_AIM_RIFLE_STIMULATED,
	[ACT_IDLE_AIM_AGITATED] = ACT_IDLE_ANGRY_SMG1,
	[ACT_WALK_AIM_RELAXED] = ACT_WALK_RIFLE_RELAXED,
	[ACT_WALK_AIM_STIMULATED] = ACT_WALK_AIM_RIFLE_STIMULATED,
	[ACT_WALK_AIM_AGITATED] = ACT_WALK_AIM_RIFLE,
	[ACT_RUN_AIM_RELAXED] = ACT_RUN_RIFLE_RELAXED,
	[ACT_RUN_AIM_STIMULATED] = ACT_RUN_AIM_RIFLE_STIMULATED,
	[ACT_RUN_AIM_AGITATED] = ACT_RUN_AIM_RIFLE,
	[ACT_WALK_AIM] = ACT_WALK_AIM_RIFLE,
	[ACT_WALK_CROUCH] = ACT_WALK_CROUCH_RIFLE,
	[ACT_WALK_CROUCH_AIM] = ACT_WALK_CROUCH_AIM_RIFLE,
	[ACT_RUN] = ACT_RUN_RIFLE,
	[ACT_RUN_AIM] = ACT_RUN_AIM_RIFLE,
	[ACT_RUN_CROUCH] = ACT_RUN_CROUCH_RIFLE,
	[ACT_RUN_CROUCH_AIM] = ACT_RUN_CROUCH_AIM_RIFLE,
	[ACT_GESTURE_RANGE_ATTACK1] = ACT_GESTURE_RANGE_ATTACK_AR2,
	[ACT_COVER_LOW] = ACT_COVER_SMG1_LOW,
	[ACT_RANGE_AIM_LOW] = ACT_RANGE_AIM_AR2_LOW,
	[ACT_RANGE_ATTACK1_LOW] = ACT_RANGE_ATTACK_SMG1_LOW,
	[ACT_RELOAD_LOW] = ACT_RELOAD_SMG1_LOW,
	[ACT_GESTURE_RELOAD] = ACT_GESTURE_RELOAD_SMG1
}