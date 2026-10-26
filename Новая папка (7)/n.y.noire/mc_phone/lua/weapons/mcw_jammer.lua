--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/weapons/mcw_jammer.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--╔═╗╔═╦═══╦═══╦╗─────────────────╔╗──────────────────────────╔╗───╔╗───
--║║╚╝║║╔═╗║╔═╗║║────────────────╔╝╚╗─────────────────────────║║──╔╝║───
--║╔╗╔╗║║─╚╣╚═╝║╚═╦══╦═╗╔══╗╔══╦╗╠╗╔╬══╦═╗╔══╦╦══╦═╗─╔══╦══╦══╣║╔╗╚╗║───
--║║║║║║║─╔╣╔══╣╔╗║╔╗║╔╗╣║═╣║║═╬╬╬╣║║║═╣╔╗╣══╬╣╔╗║╔╗╗║╔╗║╔╗║╔═╣╚╝╝─║║───
--║║║║║║╚═╝║║──║║║║╚╝║║║║║═╣║║═╬╬╬╣╚╣║═╣║║╠══║║╚╝║║║║║╚╝║╔╗║╚═╣╔╗╗╔╝╚╗──
--╚╝╚╝╚╩═══╩╝──╚╝╚╩══╩╝╚╩══╝╚══╩╝╚╩═╩══╩╝╚╩══╩╩══╩╝╚╝║╔═╩╝╚╩══╩╝╚╝╚══╝──
--───────────────────────────────────────────────────║║─────────────────
--────────────────────────── By Mactavish ──────────────────────────────
if (CLIENT) then
	SWEP.PrintName = "Jammer"
	SWEP.Slot = 4
	SWEP.SlotPos = 1
	SWEP.DrawCrosshair = false
	SWEP.DrawAmmo = false
	language.Add("jammer_ammo", "Jammer")
end

game.AddAmmoType({
	name = "jammer",
})
SWEP.Base = "base_swb"
SWEP.Author = "Mactavish"
SWEP.Category = "McPhone"
SWEP.Instructions = "Place to jam phone net"
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/c_slam.mdl"
SWEP.WorldModel = "models/mc_phone/jammer.mdl"
SWEP.ShowViewModel = true
SWEP.ShowWorldModel = false
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.ViewModelFlip = false
SWEP.ThinkTick = 0
SWEP.HoldType = "slam"
SWEP.ViewModelFOV = 65
SWEP.UseHands = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "jammer"
SWEP.Primary.Delay = 1
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.VElementsDraw = true

function SWEP:Deploy()
	if self:Ammo1(self.Primary.Ammo) > 0 then
		self:SendWeaponAnim(ACT_SLAM_TRIPMINE_DRAW)
	else
		self:SendWeaponAnim(ACT_SLAM_TRIPMINE_ATTACH2)
	end

	return true
end

function SWEP:TraceWall()
	local ply = self:GetOwner()
	local tr = ply:GetEyeTrace()

	if self:Ammo1(self.Primary.Ammo) <= 0 or self.OutOfAmmo then
		self:SetNextPrimaryFire(CurTime() + 0.5)

		return
	end

	if not tr.Hit or IsValid(tr.Entity) then return false end
	local angles = tr.HitNormal:Angle()
	if angles[1] ~= 0 then return false end

	return tr.HitPos - (tr.HitNormal * -0.8), angles, tr
end

function SWEP:Think()
	local CT = CurTime()
	if self.ThinkTick > CT then return end
	self.ThinkTick = CT + 1

	if self.OutOfAmmo and self:Ammo1(self.Primary.Ammo) > 0 then
		self.OutOfAmmo = nil
		self.VElementsDraw = true
		self:SendWeaponAnim(ACT_SLAM_THROW_ND_DRAW)
	end
end

function SWEP:PrimaryAttack()
	local ply = self:GetOwner()
	local pos, ang, tr = self:TraceWall()
	if not pos or not tr then return end
	if pos and pos:DistToSqr(ply:EyePos()) > 400 then return end
	self:SendWeaponAnim(ACT_SLAM_TRIPMINE_ATTACH)
	self:SetNextPrimaryFire(CurTime() + 2)
	self:TakePrimaryAmmo(1)
	ply:EmitSound("mcphone/jammer_in.wav", 75, 100, 1)

	if CLIENT then return end

	timer.Simple(0.3, function()
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end
		self:SendWeaponAnim(ACT_SLAM_TRIPMINE_ATTACH2)
		self.VElementsDraw = false

		if (SERVER) then
			tr.Entity.hascharge = true
			self.atached = nil
			ply:EmitSound("weapons/slam/mine_mode.wav", 55, 100, 0.3)
			local ent = ents.Create("mc_jammer")
			ent:Spawn()
			ent:SetCollisionGroup(COLLISION_GROUP_WORLD)
			ent:SetPos(pos)
			ent:SetAngles(ang)
			ent:SetMoveType(MOVETYPE_NONE)
			ent:SetSolid(SOLID_VPHYSICS)
		end
	end)

	timer.Simple(1, function()
		if not IsValid(self) or not IsValid(self:GetOwner()) then return end

		if self:Ammo1(self.Primary.Ammo) > 0 then
			self.VElementsDraw = true
			self:SendWeaponAnim(ACT_SLAM_THROW_ND_DRAW)
		else
			self:Remove()
		end
	end)
end

function SWEP:SecondaryAttack()
end

SWEP.ViewModelBoneMods = {
	["ValveBiped.Bip01_L_UpperArm"] = {
		scale = Vector(0.009, 0.009, 0.009),
		pos = Vector(0, 0, 0),
		angle = Angle(0, 0, 0)
	},
	["Detonator"] = {
		scale = Vector(0.009, 0.009, 0.009),
		pos = Vector(0, 0, 0),
		angle = Angle(0, 0, 0)
	},
	["Slam_base"] = {
		scale = Vector(0.009, 0.009, 0.009),
		pos = Vector(-30, 0, 0),
		angle = Angle(10.574, 0, 0)
	},
	["ValveBiped.Bip01_L_Hand"] = {
		scale = Vector(0.009, 0.009, 0.009),
		pos = Vector(-30, 0, 0),
		angle = Angle(0, 0, 0)
	}
}

SWEP.VElements = {
	["vm"] = {
		type = "Model",
		model = "models/mc_phone/jammer.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(4.117, 2.321, -2.724),
		angle = Angle(-167.814, 35.359, 0),
		size = Vector(1.299, 1.299, 1.299),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

SWEP.WElements = {
	["wm"] = {
		type = "Model",
		model = "models/mc_phone/jammer.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(4.559, 1.337, -1.935),
		angle = Angle(-146.859, 27.884, 1.715),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

function SWEP:Initialize()
	self:InitializeModels()

	self:SetWeaponHoldType(self.HoldType)
end

function SWEP:Holster()
	self:UnloadSWB()

	return true
end

function SWEP:OnRemove()
	self:Holster()
end