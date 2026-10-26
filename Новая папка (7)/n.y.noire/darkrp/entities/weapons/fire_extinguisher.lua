--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/fire_extinguisher.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Base = "base_swb"
SWEP.Author = "Mactavish"
SWEP.PrintName = "Огнетушитель"
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.Instructions = "Чтобы брызнуть пеной, зажмите левую кнопку мыши"
SWEP.ViewModelFOV = 45
SWEP.ViewModelFlip = false
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.UseHands = true
SWEP.Primary.ClipSize = 50
SWEP.Primary.DefaultClip = 50
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "AirboatGun"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Ammo = ""
SWEP.ViewModel = "models/weapons/c_fire_extinguisher.mdl"
SWEP.WorldModel = "models/props/cs_office/fire_extinguisher.mdl"
SWEP.ShowWorldModel = false
SWEP.lastchek = 0

SWEP.WElements = {
	["element_name"] = {
		type = "Model",
		model = "models/props/cs_office/fire_extinguisher.mdl",
		bone = "ValveBiped.Bip01_R_Hand",
		rel = "",
		pos = Vector(11.168, 4.217, 19.117),
		angle = Angle(-178.07, 48.65, -19.195),
		size = Vector(1, 1, 1),
		color = Color(255, 255, 255, 255),
		surpresslightning = false,
		material = "",
		skin = 0,
		bodygroup = {}
	}
}

function SWEP:Initialize()
	self:SetHoldType("slam")
	self:InitializeModels()
end

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextIdle")
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)
	self:SetNextPrimaryFire(CurTime() + self:SequenceDuration())
	self:Idle()

	return true
end

function SWEP:Holster(weapon)
	if CLIENT and IsValid(self:GetOwner()) and IsValid(self:GetOwner():GetViewModel()) then
		self:ResetBonePositions(self:GetOwner():GetViewModel())
		return
	end

	if (self.Sound) then
		self.Sound:Stop()
		self.Sound = nil
	end
	if SERVER and IsValid(self:GetOwner()) and (not self:GetOwner():getDarkRPVar("scba")) then
		self:GetOwner():DropDRPWeapon(self)
	end
	return true
end

function SWEP:OnDrop()
	if (self.Sound) then
		self.Sound:Stop()
		self.Sound = nil
	end
end

function SWEP:PrimaryAttack()
	if not IsValid(self:GetOwner()) or self:Clip1() < 1 then
		if SERVER and IsValid(self:GetOwner()) and (not self:GetOwner():getDarkRPVar("scba")) then
			self:GetOwner():StripWeapon("fire_extinguisher")
		end

		return
	end

	local CT = CurTime()

	if SERVER and IsFirstTimePredicted() then
		if (self:GetOwner():KeyPressed(IN_ATTACK) or not self.Sound) then
			self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
			self.Sound = CreateSound(self:GetOwner(), Sound("ambient/gas/cannister_loop.wav"))
			--self:EmitSound("buttons/lever5.wav")
			self:Idle()
		end

		if (self:Clip1() > 0 and self.Sound) then
			self.Sound:PlayEx(0.5, 60)
		end
	end

	local bone = self:GetOwner():LookupBone("ValveBiped.Bip01_R_Hand")
	self:SetNextPrimaryFire(CT + math.Rand(0.05, 0.01))
	local ExtinguishEffect = EffectData()
	ExtinguishEffect:SetScale(1.1)
	ExtinguishEffect:SetEntity(self:GetOwner())
	ExtinguishEffect:SetOrigin(bone and self:GetOwner():GetBoneMatrix(bone):GetTranslation() or self:GetOwner():GetShootPos())
	ExtinguishEffect:SetNormal(self:GetOwner():GetAimVector())
	util.Effect("extinguish", ExtinguishEffect)

	if SERVER and self.lastchek < CT then
		self.lastchek = CT + 0.8
		self:TakePrimaryAmmo(1)
		local trace = {}
		trace.start = self:GetOwner():GetShootPos()
		trace.endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * 150
		trace.filter = self:GetOwner()
		local tr = util.TraceLine(trace)
		local take = self:GetOwner():Team() == TEAM_FIREFIGHTER and 5 or 1

		for k, v in pairs(ents.FindInSphere(tr.HitPos, 50)) do
			if not IsValid(v) then continue end

			if math.random(2) == 1 and v:IsPlayer() and v:Alive() and not DarkRP.GasMask(v) then
				v:EmitSound("ambient/voices/cough" .. math.random(3) .. ".wav")
				v:ViewPunch(Angle(-math.random(3, 5), 0, 0))
			end

			if v:IsOnFire() then
				if v.SoftExtinguish then
					v:SoftExtinguish(take)

					if self:GetOwner():Team() == TEAM_FIREFIGHTER and (not self.lastPayDay or self.lastPayDay < CT) then
						self.lastPayDay = CT + 10
						self:GetOwner():addPaydayMoney(15)
						self:GetOwner():JobXPAdd("fdny", 15)
					end

					continue
				end

				for _, fire in pairs(vFireGetFires(v)) do
					fire:SoftExtinguish(take)
				end
			end
		end
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Think()
	local CT = CurTime()

	if SERVER and self.lastchek + 2 < CT and IsValid(self:GetOwner()) and (self:GetOwner():getDarkRPVar("scba")) then
		self.lastchek = CT
		self:SetClip1(math.min(self:Clip1() + 5, 50))
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

function SWEP:PlaySound()
	self:EmitSound("weapons/extinguisher/release1.wav", 35, 150)
end