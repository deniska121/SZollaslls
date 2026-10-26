--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mlw_briefcase_ex.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "mlw_base"
SWEP.PrintName = "Briefcase Extra"
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

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "normal",
	[3] = "melee",
}

function SWEP:ExtraDamageFunction(dtype, ent, tr)
	if not ent:IsPlayer() then return end

	if ent:Health() > 0 then
		ent:Ragdollize(120)
	end

	if dtype == 2 and math.random(5) > 3 then
		ent:AddTempStat("bleeding", math.random(5, 8))
	end
end

function SWEP:PrimaryAttack()
	if self:GetState() < 2 then return end
	if self.Running then return end
	local bullet = {}
	bullet.Num = 1
	bullet.Src = self:GetOwner():GetShootPos()
	bullet.Dir = self:GetOwner():GetAimVector()
	bullet.Spread = Vector(0.01, 0.01, 0)
	bullet.Tracer = 0
	bullet.Force = 10
	bullet.Damage = 30
	bullet.AmmoType = "Pistol"
	local rnda = math.random(-0.1, 0.1)
	local rndb = math.random(-0.1, 0.1)

	self:GetOwner():FireBullets(bullet)
	self:GetOwner():ViewPunch(Angle(rnda, rndb, math.random(-0.1, 0.1)))
	self:SetNextPrimaryFire(CurTime() + 0.03)
	self:SetNextSecondaryFire(CurTime() + 0.03)
	self:EmitSound(Sound("MW19_Deagle.Fire_S"))
	local outside = DarkRP.IsOutside(self:GetOwner():GetPos())

	if outside then
		-- if SERVER then
		-- 	DarkRP.UIEffect(nil, "DistSound", {self:GetOwner():GetPos(), "Reflection_AR.Sup.Distance", Sound("MW19_Deagle.Fire_S")})
		-- end
		self:EmitSound(Sound("Atmo_Pistol_Mag_Sup.Outside"))
		self:EmitSound(Sound("Reflection_ARSUP.Outside"))
	else
		self:EmitSound(Sound("Atmo_Pistol_Sup.Inside"))
		self:EmitSound(Sound("Reflection_ARSUP.Inside"))
	end
end

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
	["wmodel2"] = {
		type = "Model",
		model = "models/viper/mw/attachments/attachment_vm_silencer_pstl_02.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(10, 0, -5),
		angle = Angle(-90, 0, 0),
		size = Vector(1, 1, 1),
		color = color_white,
		surpresslightning = false,
		material = "",
		skin = 0,
		hideFunc = function(self)
			if not self:GetState() then return end
			return self:GetState() < 2
		end,
		bodygroup = {}
	}
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