--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mlw_torch.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.Base = "mlw_base"
SWEP.PrintName = "Фонарь"
SWEP.Category = "Melee"
SWEP.Slot = 4
SWEP.SlotPos = 5
SWEP.Weight = 30
SWEP.Spawnable = true
SWEP.ViewModel = "models/weapons/c_flashlight_zm.mdl"
SWEP.WorldModel = "models/weapons/w_flashlight_zm.mdl"
SWEP.ViewModelFOV = 57
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = false
SWEP.HitDistance = 50

SWEP.SimpleAttackDelay = 0.25
SWEP.VElements = {}

SWEP.DamageTypes = {
	[1] = {5,8},
	[2] = {5,15}
}

SWEP.ShowWorldModel = false

SWEP.IdleAnim = {
	[1] = nil,
	[2] = "Idle",
	[3] = "Attack_Charge_Idle",
}

SWEP.AttackAnim = {
	[1] = "hitcenter1",
	[2] = "hitcenter1",
	[3] = "hitcenter1",
}

SWEP.HoldIdels = {
	[1] = "Holster",
	[2] = "Draw",
	[3] = "Idle",
}

SWEP.HoldTypes = {
	[1] = "normal",
	[2] = "slam",
	[3] = "melee",
}

SWEP.RunIdle = "Sprint"
SWEP.WalkIdle = "Walk"

SWEP.WElements = {
	["light"] = { type = "Sprite", sprite = "effects/flashlight_halo", bone = "ValveBiped.Bip01_R_Hand", rel = "wmodel", pos = Vector(-1.216, -2.099, 4.696), size = { x = 30, y = 30 }, color = Color(255, 255, 255, 255), nocull = true, additive = true, vertexalpha = true, vertexcolor = true, ignorez = false, hideFunc = function(wep)
		if not wep:GetFlashlightOn() then
			return true
		end
	end},
	["light_f"] = { type = "QuadExtra", bone = "ValveBiped.Bip01_R_Hand", rel = "wmodel", pos = Vector(0, 0, 0), angle = Angle(0, 0, 0), size = 1, draw_func = function(wep, a, b, c)
		wep:DrawWorldLight(a,b,c)
	end},
	["wmodel"] = { type = "Model", model = "models/weapons/w_flashlight_zm.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.816, 1.945, -0.899), angle = Angle(104.245, 180, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:SetupDataTables()
	self:NetworkVar("Float", 0, "NextAttack")
	self:NetworkVar("Float", 1, "NextCharge")
	self:NetworkVar("Float", 2, "NextIdle")
	self:NetworkVar("Float", 3, "NextReload")
	self:NetworkVar("Float", 4, "Penalty")
	self:NetworkVar("Bool", 0, "FlashlightOn")
	self:NetworkVar("Int", 0, "State")
	self:SetFlashlightOn(false)
end

function SWEP:PrimaryAttack()
	if self:GetState() < 2 then return end
	if self.Running then return end

	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("trigger"))
	vm:SetPlaybackRate(0.75)
	self:UpdateNextIdle()
	self:ToggleLight()
	self:EmitSound("zeron/mwii/weap_papa220_fcg_disconnector_plr_0" .. math.random(5) .. ".wav")
end

function SWEP:Reload()
	local CT = CurTime()
	if self:GetNextReload() > CT then return end

	self:SetState(self:GetState() == 1 and 2 or 1)
	local vm = self:ChangeAnim(self.HoldIdels[self:GetState()])
	self:SetHoldType(self.HoldTypes[self:GetState()])

	self:SetNextReload(CurTime() + 0.3 + vm:SequenceDuration() / vm:GetPlaybackRate())
	if self:GetFlashlightOn() then
		self:SetLight(false)
		self:EmitSound("zeron/mwii/weap_papa220_fcg_disconnector_plr_0" .. math.random(5) .. ".wav")
	end
end

function SWEP:ToggleLight()
	self:SetLight(not self:GetFlashlightOn())
end

function SWEP:Holster()
	self:UnloadSWB()

	self:SetNextAttack(0)
	self:SetNextCharge(0)
	if self.InProgress then net.SendSingleMessage("RemovePropgressBar", self:GetOwner()) end
	self.InProgress = false
	self.m_FreeAim = nil
	self.m_FreeAimReady = nil

	if CLIENT and IsValid(self.light) then
		self.light:Remove()
	end

	self:SetFlashlightOn(false)

	return true
end

local addangle = Vector(0, 90, 0)

function SWEP:PostDrawViewModel(vm)
	if not IsValid(self.light) then
		self:CreateLight()
	end

	local attachment = vm:GetAttachment(1)
	local lightattachment = vm:GetAttachment(2)

	if self:GetFlashlightOn() and self.light:GetBrightness() == 0 then
		self.light:SetBrightness(1)
	end

	lightattachment.Ang:RotateAroundAxis(lightattachment.Ang:Right(), addangle.y)
	lightattachment.Ang:RotateAroundAxis(-lightattachment.Ang:Up(), addangle.x)
	local lightpos = lightattachment.Pos

	self.light:SetPos(lightpos)


	self.light:SetAngles(lightattachment.Ang)


	if self.curframe then
		self.light:SetTextureFrame(math.floor(self.curframe))
	end

	self.light:Update()
	self.camang = vm:GetAngles() - attachment.Ang
end

function SWEP:SetLight(value)
	self:SetFlashlightOn(value)

	if not self:GetFlashlightOn() then
		self:SetSkin(0)

		if self.light then
			self.light:SetBrightness(0)
		end
	else
		if self.light then
			self.light:SetBrightness(1)
		end
	end
end

function SWEP:CreateLight()
	if CLIENT then
		local light = ProjectedTexture()
		self.light = light
		light:SetTexture("effects/flashlight001")
		self.light:SetFarZ(2555)
		self.light:SetFOV(55)
		self.light:SetColor(Color(255,255,255))
		light:SetBrightness(0)
		light:SetPos(self:GetPos())
		light:SetAngles(self:GetAngles())
		light:Update()
	end
end

function SWEP:OnRemove()
	self:Holster()
	if IsValid(self.light) then
		self.light:Remove()
	end
end

function SWEP:SecondaryAttack()
	if self:GetState() < 2 then
		local trace = self:GetOwner():GetEyeTrace().Entity

		if SERVER and trace and IsValid(trace) and trace:IsPlayer() and trace:Alive() and DarkRP.InRange(trace, self:GetOwner(), 60) and trace:GetMoveType() == MOVETYPE_WALK then
			if not self:GetOwner():HasStamina(10) or self:GetOwner():getDarkRPVar("fracturearm") then return end
			if self:GetOwner():Health() < 20 then return end

			timer.Simple(0.3, function()
				if not IsValid(self) then return end
				self:Push(trace)
			end)
			self:GetOwner():TakeStamina(9)
			self:SetNextSecondaryFire(CurTime() + 2.2)
			DarkRP.ForceAnimation(self:GetOwner(), "", 1.6)
			DarkRP.UIEffect(nil, "anim_keys", {type = "shove", ply = self:GetOwner():UserID()})
		end

		return
	end
	if self.Running then return end

	if (MCR.HasTatoo(self:GetOwner(), "a7") or self:CanUseStamina(self.Stamina[2] + self:GetPenalty())) and not self:GetOwner():getDarkRPVar("fracturearm") then
		self:SwingHands(1)
		self:SetHoldType(self.HoldTypes[3])
	else
		self:SwingHands(0)
	end
end

function SWEP:DrawWorldLight(a,b,c)

	if not self:GetFlashlightOn() then
		if IsValid(self.light) then
			self.light:Remove()
		end

		return
	end

	if not IsValid(self.light) then
		self:CreateLight()
	end

	if self:GetFlashlightOn() and self.light:GetBrightness() == 0 then
		self.light:SetBrightness(1)
	end

	if IsValid(self.light) then
		self.light:SetPos(b + self.Owner:EyeAngles():Forward() * 5)
		local trace = self.Owner:EyePos() + self.Owner:EyeAngles():Forward() * 2555
		local centerang = (trace - b):Angle()
		centerang.r = 0
		self.light:SetAngles(centerang)

		if self.curframe then
			self.light:SetTextureFrame(math.floor(self.curframe))
		end

		self.light:Update()
	end
end