--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/weapons/pill_laser.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--SWEP.base = "weapon_base"
AddCSLuaFile()
SWEP.ViewModel = "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel = ""
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"
SWEP.PrintName = "Laser"

lasers = lasers or {}

function SWEP:Initialize()
	lasers[self] = true
	if CLIENT then
		self.PixVis = {
			util.GetPixelVisibleHandle(),
			util.GetPixelVisibleHandle(),
			util.GetPixelVisibleHandle(),
		}
	end
	self:SetHoldType("normal")
	self:SetStatus(0)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "Charge")
	self:NetworkVar("Int", 1, "Status")
end

function SWEP:Draw()
	self:SetStatus(0)
	lasers[self] = true
end

function SWEP:PrimaryAttack()
	if self:GetStatus() > 0 then
		self:SetCharge(0)
		self:SetStatus(0)
		return
	end
	self:SetCharge(1)
	self:SetStatus(2)
end

function SWEP:Reload()
	self:SetCharge(0)
	self:SetStatus(0)
end

function SWEP:SecondaryAttack()
	if self:GetStatus() > 0 then
		self:SetCharge(0)
		self:SetStatus(0)
		return
	end
	self:SetCharge(0)
	self:SetStatus(1)
end

function MRS.Cam3d(ply)
	if not IsValid(ply) then return end

	if ply:GetActiveWeapon() and lasers[ply:GetActiveWeapon()] then
		ply:GetActiveWeapon():LaserProcess(ply)
	end
end

function SWEP:FireBeam()
	self:GetOwner():EmitSound("ambient/energy/newspark0" .. math.random(1, 11) .. ".wav")
	local tr = self:GetOwner():GetEyeTrace()
	ParticleEffect("red_laser_hit", tr.HitPos, Angle(0, 0, 0), nil)
	util.Decal("FadingScorch", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)

	if tr.Entity and tr.Entity.TakeDamageInfo then
		local dmginfo = DamageInfo()
		dmginfo:SetAttacker(self:GetOwner())
		dmginfo:SetInflictor(self)
		dmginfo:SetDamage(1000)
		dmginfo:SetDamageForce(Vector())
		dmginfo:SetDamageType( DMG_DISSOLVE )
		SuppressHostEvents(NULL)
		tr.Entity.crithit = true
		tr.Entity:TakeDamageInfo(dmginfo)
		SuppressHostEvents(self:GetOwner())
		if not tr.Entity:IsPlayer() then
			tr.Entity:Dissolve( 0, 100 )
		end
	end
end

function SWEP:Think()
	if CLIENT then return end
	if self:GetStatus() and self:GetStatus() == 1 then
		self:SetCharge(math.min(self:GetCharge() + 0.01, 1))

		if self:GetCharge() > 0.4 then
			self:SetCharge(1)
			self:SetStatus(2)
		end
	end

	if self:GetStatus() == 2 then
		if self:GetCharge() < 0.5 then
			self:SetCharge(0)
			self:SetStatus(0)
			return
		end

		self:SetCharge(math.max(self:GetCharge() - 0.005, 0))
		self:FireBeam()
	end
end

function SWEP:OnRemove()
	lasers[self] = nil
end

local LineMat = Material("effects/laser1")
local EyeMat = Material("effects/redflare")
local HitMat = Material("effects/led_glow")
local laser_cl = Color(248,6,6, 100)
--local LineMat = Material("sprites/redlaser1")

function SWEP:LaserProcess(ply)
	if not self:GetStatus() or self:GetStatus() < 1 then return end

	local tr = ply:GetEyeTrace()
	local sizedratio = (20 + math.random(1, 9)) * self:GetCharge()
	local laserrat = math.random(7, 11)

	local attachment = ply:GetAttachment( ply:LookupAttachment("eyes") )

	local lefteye = ( attachment.Pos + attachment.Ang:Right() * 1.4 + attachment.Ang:Up() * 0.35 )
	local righteye = ( attachment.Pos - attachment.Ang:Right() * 1.4 + attachment.Ang:Up() * 0.35 )

	local lev = util.PixelVisible(lefteye, 1, self.PixVis[1])
	local rev = util.PixelVisible(righteye, 1, self.PixVis[2])
	local hpv = util.PixelVisible(tr.HitPos, 1, self.PixVis[3])

	if self:GetStatus() > 1 then
		render.SetMaterial(LineMat)
		render.DrawBeam(righteye, tr.HitPos, laserrat, 0, 12.5, laser_cl)
		render.DrawBeam(lefteye, tr.HitPos, laserrat, 0, 12.5, laser_cl)
		render.DrawBeam(righteye, tr.HitPos, laserrat / 4, 0, 12.5, color_white)
		render.DrawBeam(lefteye, tr.HitPos, laserrat / 4, 0, 12.5, color_white)

		if hpv and hpv > 0 then
		render.SetMaterial(HitMat)
		render.DrawSprite(tr.HitPos, sizedratio, sizedratio, laser_cl)
		render.DrawSprite(tr.HitPos, sizedratio / 2, sizedratio / 2, color_white)
		render.DrawSprite(tr.HitPos, sizedratio, sizedratio, laser_cl)
		end
	end

	render.SetMaterial(EyeMat)
	if lev and lev > 0 then
		render.DrawSprite(lefteye, sizedratio * lev, (sizedratio / 2) * lev, color_white)
	end
	if rev and rev > 0 then
		render.DrawSprite(righteye, sizedratio * rev, (sizedratio / 2) * rev, color_white)
	end
end

function SWEP:ViewModelDrawn()
	self:LaserProcess(LocalPlayer())
end