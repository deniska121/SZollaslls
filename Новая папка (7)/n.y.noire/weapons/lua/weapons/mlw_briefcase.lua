--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mlw_briefcase.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Портфель"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/tfa_nmrih/v_me_crowbar.mdl"
SWEP.WorldModel = "models/gman_briefcase.mdl"
SWEP.ViewModelFOV = 55
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 50
SWEP.ShowWorldModel = false
SWEP.RagdollizeTH = 30
SWEP.RagdollizeMP = 2
SWEP.BluntDamage = false
SWEP.Primary.Automatic = true

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextAttack")
	self:NetworkVar("Float", 1, "NextCharge")
	self:NetworkVar("Float", 2, "NextIdle")
	self:NetworkVar("Float", 3, "NextReload")
	self:NetworkVar("Float", 4, "Penalty")
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Float",5,"Space")
	self:NetworkVar("String",0,"StorageName")
end

function SWEP:Initialize()
	self:InitializeModels()

	self:SetSpace(4)
	self:SetStorageName("Портфель")

	self:SetHoldType("normal")
	self:SetState(1)
	self:SetPenalty(0)
	self.ShowHint = CurTime() + 10
end

function SWEP:PrimaryAttack()
	if self.Running then return end

	if self:GetState() < 2 then
		if SERVER then
			if self.UseDelay and self.UseDelay > CurTime() then return end
			self.UseDelay = CurTime() + 2
			self:GetOwner().lastact = CurTime()
			McINV.Loot(self, self:GetOwner(), false, true)
		end
		return
	end

	if (MCR.HasTatoo(self:GetOwner(), "a7") or self:CanUseStamina(self.Stamina[1] + self:GetPenalty())) and not self:GetOwner():getDarkRPVar("fracturearm") then
		self:SwingHands(1)
	else
		self:SwingHands(0)
	end

	if SERVER then
		self:SetNextSecondaryFire(CurTime() + 2.2)
		self:GetOwner():SetCycle(0)
		DarkRP.UIEffect(nil, "plyAnimSetCycle", {self:GetOwner():UserID()})
		DarkRP.UIEffect(nil, "anim_keys", {type = "shove", ply = self:GetOwner():UserID()})
	end
end

SWEP.inv = {}
SWEP.inv[INV_WEAPON] = {}
SWEP.inv[INV_ENTITY] = {}
SWEP.inv[INV_AMMO] = {}
SWEP.inv[INV_FOOD] = {}
SWEP.inv[INV_JUNK] = {}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "normal",
	[3] = "melee",
}

SWEP.DamageTypes = {
	[1] = {7, 17},
	[2] = {13, 35}
}

SWEP.ViewModelBoneMods = {
	["v_me_crowbar"] = {
		scale = Vector(0.009, 0.009, 0.009),
		pos = Vector(0, 0, 0),
		angle = Angle(0, 0, 0)
	}
}

SWEP.WElements = {
	["wmodel"] = {
		type = "Model",
		model = "models/gman_briefcase.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(19, 0, 0),
		angle = Angle(90, 0, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	},
}

SWEP.VElements = {
	["vmodel"] = {
		type = "Model",
		model = "models/gman_briefcase.mdl",
		bone = "v_me_crowbar",
		rel = "",
		pos = Vector(0.751, 1.978, -21.423),
		angle = Angle(4.578, -79.165, 0),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

if CLIENT then
	function SWEP:ExtraHint(x, y, scw, sch, clrs)
		if self:GetState() > 1 then return end
		x, y = scw * 0.5, sch * 0.8 + 40
		local sp = draw.SimpleTextOutlined("Посмотреть содержимое", "MSDRoboto.20", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		MSD.DrawKey(x + sp / 2 + 10, y - 3, "ЛКМ")
	end
end