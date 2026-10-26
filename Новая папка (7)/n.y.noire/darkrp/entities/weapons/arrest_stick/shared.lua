--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/arrest_stick/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if SERVER then
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "base_swb"
SWEP.PrintName = "Наручники"
SWEP.Slot = 4
SWEP.SlotPos = 1
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.SwayScale = 0
SWEP.BobScale = 0
SWEP.DisplayAlpha = 0
SWEP.Weight = 1

SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = true

SWEP.Author = "MacTavish"
SWEP.Instructions = "Нажмите ЛКМ с зади игрока для того чтобы арестовать"
SWEP.Contact = ""
SWEP.Purpose = ""
SWEP.IconLetter = ""
SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix = "stunstick"
SWEP.Spawnable = true
SWEP.AdminSpawnable = true
SWEP.NextStrike = 0
SWEP.ViewModel = Model("models/weapons/spy/handcuffs.mdl")
SWEP.WorldModel = Model("models/weapons/spy/w_handcuffs.mdl")

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = 0
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""
SWEP.ArrestSoundTime = 0
SWEP.ArrestTargetTime = 0
SWEP.ArrestTime = 3
SWEP.CanArrestFromAnyAngle = true
SWEP.RightClickSwitchToUnarrestBaton = true
SWEP.Handcuffs = true
SWEP.UseHands = true
SWEP.ArrestCooldown = 0 -- change this value to add a cooldown for arresting after a successful arrest
SWEP.ArrestWait = 0 -- don't change this

SWEP.ViewModelBoneModsNoLighter = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, -30, -30), angle = Angle(0, 0, 0) },
	["Group02"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(-30, -30, -30), angle = Angle(0, 0, 0) }
}

SWEP.ViewModelBoneModsLighter = {
	["ValveBiped.Bip01_Spine4"] = { scale = Vector(0.75, 0.75, 0.75), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) },
	["Group02"] = { scale = Vector(1, 1, 1), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}

function SWEP:Initialize()
	self:SetHoldType("normal")
	self:SetHaveCuffs(false)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "HaveCuffs")
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("draw"))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration())
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration())
	if IsValid(self:GetOwner()) and self:GetOwner():HaveItem(INV_JUNK, "cuffs") > 0 then
		self.CanShoot = true
		self.ShowWorldModel = true
		if SERVER then self:SetHaveCuffs(true) end
		self.ViewModelBoneMods = self.ViewModelBoneModsLighter
		if CLIENT then self:UpdateBonePositions(vm) end
	else
		self.CanShoot = false
		self.ShowWorldModel = false
		if SERVER then self:SetHaveCuffs(false) end
		self.ViewModelBoneMods = self.ViewModelBoneModsNoLighter
		if CLIENT then self:UpdateBonePositions(vm) end
	end

	return true
end

local aim

local fiddlesnd = {"weapons/357/357_reload1.wav", "weapons/357/357_reload3.wav", "weapons/357/357_reload4.wav"}

function SWEP:Think()
	local CT = CurTime()
	if CLIENT then return end
	if not self.ArrestTarget then return end
	if not self.ArrestEntity then return end

	if not IsValid(self.ArrestTarget) then
		net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
		self.ArrestTargetTime = 0
		self.ArrestTarget = nil
		self:SendWeaponAnim(ACT_VM_DRAW)
		return
	end

	if self.ArrestEntity ~= self.ArrestTarget then
		if not self.ArrestTarget:getDarkRPVar("unconscious") then self:ArrestInterrupted() return end
		if self.ArrestEntity.cuffed then self:ArrestInterrupted() return end
	end

	if self.ArrestEntity:GetPos():DistToSqr(self:GetOwner():GetPos()) <= 10000 and self:GetOwner():HaveItem(INV_JUNK, "cuffs") > 0 then
		aim = self.ArrestTarget:EyeAngles()
		aim.p = 0
		aim = aim:Forward()

		if self.ArrestTarget:Alive() and not self.ArrestTarget.HandCuffed and (not IsValid(self:GetOwner()) or self:GetOwner():Alive()) then
			if CT > self.ArrestSoundTime then
				self:GetOwner():EmitSound(table.Random(fiddlesnd), 70, 100)
				self.ArrestSoundTime = CT + 1
			end

			if CT > self.ArrestTargetTime then
				if aim:Dot((self:GetOwner():GetShootPos() - self.ArrestTarget:GetShootPos()):GetNormal()) <= -0.7 or self.ArrestEntity ~= self.ArrestTarget then
					self.ArrestTarget:CuffHands()
				else
					self.ArrestTarget:CuffHands(true)
				end

				self:GetOwner():EmitSound("weapons/357/357_spin1.wav", 70, 100)
				self.ArrestTarget.bRestain = nil
				self.ArrestTarget.restainBy = self:GetOwner()
				if self.ArrestEntity ~= self.ArrestTarget then
					DarkRP.applyCuffsToRag(self.ArrestEntity)
					self.ArrestTarget:SincRagdoll(self.ArrestEntity, true)
				else
					self.ArrestTarget:Freeze(false)
				end
				self.ArrestTargetTime = 0
				DarkRP.notify(self.ArrestTarget, 0, 20, self:GetOwner():FullName() .. " надел(а) на вас наручники")

				DarkRP.log("police", self:GetOwner(), self.ArrestTarget, "надел наручники")

				self:SendWeaponAnim(ACT_VM_DRAW)
				self.ArrestTarget = nil
				self.ArrestWait = CT + self.ArrestCooldown
				self:GetOwner():RemoveItemByClass(INV_JUNK, "cuffs")
			end
		else
			self:ArrestInterrupted()
		end

	else
		self:ArrestInterrupted()
	end
end

function SWEP:ArrestInterrupted()
	net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
	if IsValid(self.ArrestTarget) then
		self.ArrestTarget.bRestain = nil
		self.ArrestTarget:Freeze(false)
	end
	self.ArrestTargetTime = 0
	self.ArrestTarget = nil
	self:SendWeaponAnim(ACT_VM_DRAW)
end

function SWEP:ArrestInterruptedHolster()
	net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
	if IsValid(self.ArrestTarget) then
		self.ArrestTarget.bRestain = nil
		self.ArrestTarget:Freeze(false)
	end
	self.ArrestTarget = nil
end

function SWEP:Holster()
	self.ArrestTargetTime = 0
	self.DisplayAlpha = 0

	if SERVER then self:ArrestInterrupted() return true end

	if self.Droping then return false end
	self:SetNextPrimaryFire(CurTime() + 3)
	self:SetNextSecondaryFire(CurTime() + 3)
	if IsValid(self:GetOwner()) and IsValid(self:GetOwner():GetViewModel()) and CLIENT then
		self:ResetBonePositions(self:GetOwner():GetViewModel())
	end

	return true
end

function SWEP:OnRemove()
	if SERVER and IsValid(self.ArrestTarget) then
		net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
		if IsValid(self.ArrestTarget) then
			self.ArrestTarget.bRestain = nil
			self.ArrestTarget:Freeze(false)
		end
	end
end

function SWEP:PrimaryAttack()
	local CT = CurTime()
	if CT < self.NextStrike then return end
	self.NextStrike = CT + 2
	if CLIENT then return end
	if CT < self.ArrestWait then return end
	if self:GetOwner():HaveItem(INV_JUNK, "cuffs") <= 0 then return end
	local trace = self:GetOwner():GetEyeTrace()

	if not IsValid(trace.Entity) or (self:GetOwner():EyePos():DistToSqr(trace.Entity:GetPos()) > 20000) then return end

	local aent = trace.Entity
	local aply = trace.Entity

	if aent:GetClass() == "prop_ragdoll" and IsValid(aent.player) and aent.player:IsPlayer() then
		aply = aent.player
	end

	if not aply:IsPlayer() or aply:Team() == 19 then return end
	if aply.Restrained then return end
	if aply.StartCuff and aply.StartCuff > CurTime() then return end

	aply.StartCuff = CurTime() + 1

	if self:GetOwner():isCP() and MRS.GetNWdata(self:GetOwner(), "Rank") < 4 and aply:isCP() then return end
	if aent == aply and aply:getDarkRPVar("unconscious") then return end
	if aent ~= aply and not aply:getDarkRPVar("unconscious") then return end
	if aent ~= aply and aent.cuffed  then return end

	if aply:GetVelocity():Length() <= 220 then
		aim = aply:EyeAngles()
		aim.p = 0
		aim = aim:Forward()
		local DotProduct = aim:Dot((self:GetOwner():GetShootPos() - aply:GetShootPos()):GetNormal())

		self:SetHoldType("revolver")
		self:GetOwner():SetAnimation(PLAYER_RELOAD)
		self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)

		timer.Simple(2, function()
			if self:IsValid() then
				self:SetHoldType("normal")
			end
		end)

		self.ArrestTargetTime = CT + self.ArrestTime
		self.ArrestTarget = aply
		self.ArrestEntity = aent
		self.ArrestTarget.bRestain = true
		self.ArrestSoundTime = CT + 0.6
		if aent == aply and DarkRP.IsHoldingKeys(self.ArrestTarget) and DotProduct <= -0.7 then
			self.ArrestTarget:Freeze(true)
		end
		net.Start("DrawProgressBar")
			net.WriteFloat(self.ArrestTime)
		net.Send(self:GetOwner())
	end

end

function SWEP:SecondaryAttack()
	if CurTime() < self.NextStrike then return end
	self.NextStrike = CurTime() + .4
	if CLIENT then return end
	local trace = self:GetOwner():GetEyeTrace()
	if not IsValid(trace.Entity) or not trace.Entity:IsPlayer() or (self:GetOwner():EyePos():DistToSqr(trace.Entity:GetPos()) > 20000) or not (trace.Entity.HandCuffed or trace.Entity:getDarkRPVar("Arrested")) then return end

	if trace.Entity.HandCuffed then
		trace.Entity:CuffHands()
		DarkRP.log("police", self:GetOwner(), trace.Entity, "снял наручники")
		self:GetOwner():AddItemByClass(INV_JUNK, "cuffs")
	end

	DarkRP.UIEffect(nil, "anim_dropitem", {self:GetOwner():UserID()})
	self:GetOwner():AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
	self:GetOwner():EmitSound("npc/metropolice/gear" .. math.floor(math.Rand(1, 7)) .. ".wav")
	self:SendWeaponAnim(ACT_VM_HITCENTER)
end

if CLIENT then
	SWEP.Time = 0

	function SWEP:DrawWorldModel()
		if self:GetHaveCuffs() then
			self:DrawModel()
		end
	end

	local clrs = {
		m = Color(255, 255, 255, 200),
		s = Color(127, 127, 127, 150),
		d = Color(0, 0, 0, 20),
		r = Color(255, 0, 0),
	}

	function SWEP:DrawHUD()
		if self:GetOwner():getDarkRPVar("unconscious") then return end
		local p = LocalPlayer():GetEyeTrace().Entity

		local x, y = ScrW() / 2, ScrH() * 0.8

		if not self.CanShoot then
			draw.SimpleTextOutlined("У вас нет наручников. Их можно получить в арсенале или сняв с игрока.", "MSDFont.20", x, y - 30, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		end

		if IsValid(p) and p:IsPlayer() then
			local cuffed = p:getDarkRPVar("HandCuffed")
			local sp = draw.SimpleTextOutlined(cuffed and "Снять наручники" or "Надеть наручники", "MSDFont.20", x, y + 3, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
			MSD.DrawKey(x - sp / 2 - 55, y, cuffed and "ПКМ" or "ЛКМ", 155)
		end
	end

	SWEP.BlendPos = Vector(0, 0, 0)
	SWEP.BlendAng = Vector(0, 0, 0)
	SWEP.OldDelta = Angle(0, 0, 0)
	SWEP.AngleDelta = Angle(0, 0, 0)

	local Vec0 = Vector(0, 0, 0)
	local cos1, sin1, tan, ws, rs, mod, vel, FT, delta
	local PosMod, AngMod = Vector(0, 0, 0), Vector(0, 0, 0)
	local CurPosMod, CurAngMod = Vector(0, 0, 0), Vector(0, 0, 0)

	function SWEP:PreDrawViewModel()
		local CT = UnPredictedCurTime()
		vm = self:GetOwner():GetViewModel()
		EA = EyeAngles()
		FT = FrameTime()
		delta = Angle(EA.p, EA.y, 0) - self.OldDelta
		delta.p = math.Clamp(delta.p, -10, 10)
		self.OldDelta = Angle(EA.p, EA.y, 0)
		self.AngleDelta = LerpAngle(math.Clamp(FT * 10, 0, 1), self.AngleDelta, delta)
		self.AngleDelta.y = math.Clamp(self.AngleDelta.y, -10, 10)
		vel = self:GetOwner():GetVelocity():Length()
		ws = self:GetOwner():GetWalkSpeed()
		PosMod, AngMod = Vec0 * 1, Vec0 * 1

		if vel < 10 or not self:GetOwner():OnGround() then
			cos1, sin1 = math.cos(CT), math.sin(CT)
			tan = math.atan(cos1 * sin1, cos1 * sin1)
			AngMod.x = AngMod.x + tan * 1.15
			AngMod.y = AngMod.y + cos1 * 0.4
			AngMod.z = AngMod.z + tan
			PosMod.y = PosMod.y + tan * 0.2
		elseif vel > 10 and vel < ws * 1.2 then
			mod = 6 + ws / 130
			mul = math.Clamp(vel / ws, 0, 1)
			sin1 = math.sin(CT * mod) * mul
			cos1 = math.cos(CT * mod) * mul
			tan1 = math.tan(sin1 * cos1) * mul
			AngMod.x = AngMod.x + tan1
			AngMod.y = AngMod.y - cos1
			AngMod.z = AngMod.z + cos1
			PosMod.x = PosMod.x - sin1 * 0.4
			PosMod.y = PosMod.y + tan1 * 1
			PosMod.z = PosMod.z + tan1 * 0.5
		elseif (vel > ws * 1.2 and self:GetOwner():KeyDown(IN_SPEED)) or vel > ws * 3 then
			rs = self:GetOwner():GetRunSpeed()
			mod = 7 + math.Clamp(rs / 100, 0, 6)
			mul = math.Clamp(vel / rs, 0, 1)
			sin1 = math.sin(CT * mod) * mul
			cos1 = math.cos(CT * mod) * mul
			tan1 = math.tan(sin1 * cos1) * mul
			AngMod.x = AngMod.x + tan1 * 0.2
			AngMod.y = AngMod.y - cos1 * 1.5
			AngMod.z = AngMod.z + cos1 * 3
			PosMod.x = PosMod.x - sin1 * 1.2
			PosMod.y = PosMod.y + tan1 * 1.5
			PosMod.z = PosMod.z + tan1
		end

		FT = FrameTime()
		CurPosMod = LerpVector(FT * 10, CurPosMod, PosMod)
		CurAngMod = LerpVector(FT * 10, CurAngMod, AngMod)
	end

	function SWEP:GetViewModelPosition(pos, ang)
		ang:RotateAroundAxis(ang:Right(), CurAngMod.x + self.AngleDelta.p)
		ang:RotateAroundAxis(ang:Up(), CurAngMod.y + self.AngleDelta.y * 0.3)
		ang:RotateAroundAxis(ang:Forward(), CurAngMod.z + self.AngleDelta.y * 0.3)
		pos = pos + (CurPosMod.x + self.AngleDelta.y * 0.1) * ang:Right()
		pos = pos + (CurPosMod.y + self.BlendPos.y) * ang:Forward()
		pos = pos + (CurPosMod.z + self.BlendPos.z - self.AngleDelta.p * 0.1) * ang:Up()

		return pos, ang
	end
end