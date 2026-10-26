--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/fire_hose.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
game.AddParticles("particles/srp_01.pcf")
SWEP.PrintName = "Шланг"
SWEP.Author = "Mactavish"
SWEP.Purpose = "Тушить"
SWEP.Instructions = "Пссс"
SWEP.Slot = 4
SWEP.SlotPos = 35
SWEP.Weight = 1
SWEP.DrawAmmo = true
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.DrawCrosshair = false
SWEP.Spawnable = true
SWEP.UseHands = true
SWEP.ViewModel = "models/weapons/c_firehose.mdl"
SWEP.ViewModelFOV = 94
SWEP.WorldModel = "models/weapons/w_firehose.mdl"
SWEP.HoldType = "shotgun"
SWEP.lastchek = 0
SWEP.CarryHack = nil
SWEP.MaxAmmo = 300
SWEP.Primary.ClipSize = 300
SWEP.Primary.DefaultClip = 300
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextIdle")
	self:NetworkVar("Vector", 0, "Intake")
	self:NetworkVar("Entity", 0, "Pair")
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)
end

function SWEP:GetPresure()
	if IsValid(self:GetPair()) then
		return self:GetPair():GetNW2Int("Pressure", 0)
	end

	return 300
end

function SWEP:TakePresure()
	if IsValid(self:GetPair()) then
		--self:GetPair().used = CurTime() + .1
		self:GetPair():SetNW2Int("Pressure", math.max( self:GetPair():GetNW2Int("Pressure", 0) - 2, 0))
	end
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:Idle()
	self:SetIntake(Vector(-7845.61328125,-34.181118011475,-20))
	return true
end

function SWEP:OnRemove()
	if (CLIENT) then return end

	if (self.Sound) then
		self.Sound:Stop()
		self.Sound = nil
	end

	if self.BSound then
		self.BSound:Stop()
		self.BSound = nil
	end

	if IsValid(self.CarryHack) then
		self.CarryHack:Remove()
	end
end

function SWEP:Holster()
	return false
end

function SWEP:OnDrop()
	if (self.Sound) then
		self.Sound:Stop()
		self.Sound = nil
	end

	if self.BSound then
		self.BSound:Stop()
		self.BSound = nil
	end

	if IsValid(self.CarryHack) then
		self.CarryHack:Remove()
	end

	self.Primary.DefaultClip = 0
end

function SWEP:DoExtinguish(pushforce)
	local mano = math.min(1, self:Clip1() / 100)

	local tr = util.TraceLine({
		start = self:GetOwner():GetShootPos() - Vector(0, 0, 1),
		endpos = self:GetOwner():GetShootPos() + (self:GetOwner():GetAimVector() - Vector(0, 0, 0.02 + (1 - mano) * 0.45)) * 500,
		filter = self:GetOwner()
	})

	self.lastchek = CurTime()

	if CLIENT then return end
	if (self:Clip1() < 1) then return end

	if (not self.IsInfinite) then
		self:TakePresure()
	end

	pushforce = pushforce or 0
	local pos = tr.HitPos
	local take = 1

	if mano > 0.9 then
		self:GetOwner():SetVelocity(self:GetOwner():GetAimVector() * -10)
	end

	if tr.Entity and IsValid(tr.Entity) and pushforce > 0 and tr.Entity:IsPlayer() and tr.Entity:GetMoveType() == MOVETYPE_WALK then
		tr.Entity:SetVelocity(self:GetOwner():GetAimVector() * (tr.Entity:IsOnGround() and 200 or 20) * mano)
		tr.Entity:AddCold(1, 15)
		tr.Entity:ViewPunch( Angle( -math.random(3,5), 0, 0 ) )
		if not self.lastcf or self.lastcf < CurTime() and not DarkRP.GasMask(tr.Entity) then
			tr.Entity:EmitSound("ambient/voices/cough" .. math.random(3) .. ".wav")
			self.lastcf = CurTime() + math.random(2)
		end
	end

	for id, prop in pairs(ents.FindInSphere(pos, 70)) do
		if not IsValid(prop) then continue end
		if (prop:IsWeapon() and IsValid(prop:GetOwner())) then continue end
		if (prop:GetClass():find("viewmodel")) then continue end

		if (pushforce > 0) and prop:GetPos():DistToSqr(pos) < 900 then
			local physobj = prop:GetPhysicsObject()

			if (IsValid(physobj)) then
				physobj:ApplyForceOffset(self:GetOwner():GetAimVector() * pushforce * mano, pos)
			end
		end

		if prop:GetClass() == "gmod_sent_vehicle_fphysics_gib" and not prop.cold then
			prop:ExtinguishFires(math.random(20))
		end

		if prop:GetClass() == "weapon_thow" and not prop.cold then
			prop.cold = true
		end

		if prop:IsOnFire() then
			if not self.lastsnd or self.lastsnd < CurTime() then
				prop:EmitSound("weapons/tfa_csgo/molotov/molotov_extinguish.wav")
				self.lastsnd = CurTime() + 7
			end

			if prop.SoftExtinguish then
				prop:SoftExtinguish(take)

				if self:GetOwner():Team() == TEAM_FIREFIGHTER and (not self.lastPayDay or self.lastPayDay < CurTime()) then
					self.lastPayDay = CurTime() + 10
					self:GetOwner():addPaydayMoney(15)
					self:GetOwner():JobXPAdd("fdny", 15)
				end

				continue
			end

			for _, fire in pairs(vFireGetFires(prop)) do
				fire:SoftExtinguish(take)
			end
		end
	end
end

function SWEP:PrimaryAttack()
	if (self:Clip1() < 1) then return end
	if (self:GetNextPrimaryFire() > CurTime()) then return end
	local ExtinguishEffect = EffectData()
	ExtinguishEffect:SetScale(math.min(1, self:Clip1() / 100))
	ExtinguishEffect:SetEntity(self:GetOwner())
	ExtinguishEffect:SetOrigin(self:GetOwner():GetShootPos())
	ExtinguishEffect:SetNormal(self:GetOwner():GetAimVector())
	util.Effect("extinguish_big", ExtinguishEffect)

	if (IsFirstTimePredicted()) then
		self:DoExtinguish(300)

		if (SERVER) then
			if (self:GetOwner():KeyPressed(IN_ATTACK) or not self.Sound) then
				self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
				self.Sound = CreateSound(self:GetOwner(), Sound("weapons/extinguisher/fire1.wav"))
				self:Idle()
			end

			if (self:Clip1() > 0 and self.Sound) then
				self.Sound:Play()
			end
		end
	end

	self:SetNextPrimaryFire(CurTime() + 0.02)
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:PlaySound()
	self:EmitSound("weapons/extinguisher/release1.wav", 100, math.random(95, 110))
end

function SWEP:Think()
	local CT = CurTime()

	local int = self:GetIntake()
	local ent = self:GetPair()
	local sp = (IsValid(ent) and ent:LocalToWorld(int) or int):DistToSqr(self:GetOwner():GetPos())

	if sp > 1900 ^ 2 then
		if not self.BSound then
			self.BSound = CreateSound(self:GetOwner(), Sound("physics/plastic/plastic_barrel_scrape_rough_loop1.wav"))
		end
		self.BSound:Play()
		self.BSound:ChangeVolume(1 - math.max(0, (2100 ^ 2 - sp) / 1000000))

		if sp >= 2100 ^ 2 and SERVER then
			if self.BSound then
				self.BSound:Stop()
				self.BSound = nil
			end
			self:Remove()
		end
	elseif self.BSound then
		self.BSound:Stop()
		self.BSound = nil
	end

	self:SetClip1(self:GetPresure())

	if (self:GetNextIdle() > 0 and CT > self:GetNextIdle()) then
		self:DoIdleAnimation()
		self:Idle()
	end

	if (self.Sound and self.Sound:IsPlaying() and self:Clip1() < 1) then
		self.Sound:Stop()
		self.Sound = nil
		self:PlaySound()
		self:DoIdleAnimation()
		self:Idle()
	end

	if (self:GetOwner():KeyReleased(IN_ATTACK) or (not self:GetOwner():KeyDown(IN_ATTACK) and self.Sound)) then
		self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)

		if (self.Sound) then
			self.Sound:Stop()
			self.Sound = nil

			if (self:Clip1() > 0) then
				self:PlaySound()

				if (not game.SinglePlayer()) then
					self:CallOnClient("PlaySound", "")
				end
			end
		end

		self:SetNextPrimaryFire(CT + self:SequenceDuration())
		self:SetNextSecondaryFire(CT + self:SequenceDuration())
		self:Idle()
	end
end

function SWEP:DoIdleAnimation()
	if (self:GetOwner():KeyDown(IN_ATTACK) and self:Clip1() > 0) then
		self:SendWeaponAnim(ACT_VM_IDLE_1)

		return
	end

	if (self:GetOwner():KeyDown(IN_ATTACK) and self:Clip1() < 1) then
		self:SendWeaponAnim(ACT_VM_IDLE_EMPTY)

		return
	end

	self:SendWeaponAnim(ACT_VM_IDLE)
end

function SWEP:Idle()
	self:SetNextIdle(CurTime() + self:GetAnimationTime())
end

function SWEP:GetAnimationTime()
	local time = self:SequenceDuration()

	if (time == 0 and IsValid(self:GetOwner()) and not self:GetOwner():IsNPC() and IsValid(self:GetOwner():GetViewModel())) then
		time = self:GetOwner():GetViewModel():SequenceDuration()
	end

	return time
end

if SERVER then return end

local cable = Material("cable/hose")

function SWEP:DrawHose()
	local ply = self:GetOwner()
	local int = self:GetIntake()
	local ent = self:GetPair()

	if not IsValid(ply) or (not IsValid(ent) and int:IsZero()) then return end

	local startPos = IsValid(ent) and ent:LocalToWorld(int) or int

	local id = ply:LookupAttachment("anim_attachment_rh")
	local attachment = ply:GetAttachment(id)
	if not attachment then return end

	local endPos = (attachment.Pos + attachment.Ang:Forward() * -3 + attachment.Ang:Right() * 2 + attachment.Ang:Up() * -1.5)
	local p2 = startPos - (startPos - endPos):Angle():Up() * 35
	local p3 = endPos + attachment.Ang:Right() * 15 + attachment.Ang:Up() * math.min(ply:EyeAngles().p, 0)

	for i = 1, 15 do
		local sp = DarkRP.BernsteinBezier(startPos, p2, p3, endPos, (i - 1) / 15)
		local ep = DarkRP.BernsteinBezier(startPos, p2, p3, endPos, i / 15)
		render.SetMaterial(cable)
		render.DrawBeam(sp, ep, 5, 1, 1, color_white)
	end
end

function SWEP:DrawWorldModel( flags )
	self:DrawModel( flags )
	self:SetSubMaterial(1, "null")
	self:DrawHose()
end

hook.Add("PostDrawTranslucentRenderables", "Fire:Hose", function( bDepth, bSkybox )
	if bDepth or bSkybox then return end
	local ply = LocalPlayer()
	if IsValid(ply) and IsValid(ply:GetActiveWeapon()) and ply:GetActiveWeapon():GetClass() == "fire_hose" then
		ply:GetActiveWeapon():DrawHose()
	end
end)