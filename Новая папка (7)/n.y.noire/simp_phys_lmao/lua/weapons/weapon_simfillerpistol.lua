--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/weapons/weapon_simfillerpistol.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
SWEP.Category = "simfphys"
SWEP.Spawnable = false
SWEP.AdminSpawnable = false
SWEP.ViewModel = "models/weapons/v_slam.mdl"
SWEP.WorldModel = "models/props_equipment/gas_pump_p13.mdl"
SWEP.UseHands = false
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 10
SWEP.Weight = 42
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.HoldType = "slam"
SWEP.RefilAmount = 1
SWEP.MaxDistance = 60
SWEP.NextNotice = nil
SWEP.refGal = 0
SWEP.refMon = 0
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "FuelType")
end

function SWEP:IsAimingAt(vpos)
	if not IsValid(self:GetOwner()) then return false end
	local dir = self:GetOwner():GetAimVector()
	local pos = self:GetOwner():GetShootPos()
	local des_dir = (vpos - pos):GetNormalized()
	local dist = (pos - vpos):Length()
	local ang = math.acos(math.Clamp(dir:Dot(des_dir), -1, 1)) * (180 / math.pi)
	local IsAimingAt = ang < 5 and dist < self.MaxDistance

	return IsAimingAt
end

if CLIENT then
	SWEP.PrintName = "Топливный пистолет"
	SWEP.Slot = 1
	SWEP.SlotPos = 12
	SWEP.IconLetter = "k"
	SWEP.DrawWeaponInfoBox = false
	SWEP.pViewModel = ClientsideModel("models/props_equipment/gas_pump_p13.mdl", RENDERGROUP_OPAQUE)
	SWEP.pViewModel:SetNoDraw(true)

	function SWEP:ViewModelDrawn()
		if IsValid(self:GetOwner()) then
			local vm = self:GetOwner():GetViewModel()
			local bm = vm:GetBoneMatrix(0)
			local pos = bm:GetTranslation()
			local ang = bm:GetAngles()
			pos = pos + ang:Up() * 220
			pos = pos + ang:Right() * 2
			pos = pos + ang:Forward() * -12
			ang:RotateAroundAxis(ang:Forward(), -85)
			ang:RotateAroundAxis(ang:Right(), -20)
			ang:RotateAroundAxis(ang:Up(), -70)
			self.pViewModel:SetPos(pos)
			self.pViewModel:SetAngles(ang)
			self.pViewModel:DrawModel()
			--vm:SetColor(Color(255, 255, 255, 1))
			vm:SetMaterial("null")
		end
	end

	function SWEP:DrawWorldModel()
		if not IsValid(self:GetOwner()) then return end
		local id = self:GetOwner():LookupAttachment("anim_attachment_rh")
		local attachment = self:GetOwner():GetAttachment(id)
		if not attachment then return end
		local pos = attachment.Pos + attachment.Ang:Forward() * 6 + attachment.Ang:Right() * -1.5 + attachment.Ang:Up() * 2.2
		local ang = attachment.Ang
		ang:RotateAroundAxis(attachment.Ang:Up(), 20)
		ang:RotateAroundAxis(attachment.Ang:Right(), -30)
		ang:RotateAroundAxis(attachment.Ang:Forward(), 0)
		self:SetRenderOrigin(pos)
		self:SetRenderAngles(ang)
		self:DrawModel()
	end

	function SWEP:DrawHUD()
		if LocalPlayer():InVehicle() then return end
		local screenw = ScrW()
		local screenh = ScrH()
		local Widescreen = (screenw / screenh) > (4 / 3)
		local sizex = screenw * (Widescreen and 1 or 1.32)
		local sizey = screenh
		local xpos = sizex / 2
		local ypos = sizey / 2

		local Trace = self:GetOwner():GetEyeTrace()
		local ent = Trace.Entity

		if simfphys.IsCar(ent) then
			local fuelpos = ent:GetFuelPos()
			local aming = self:IsAimingAt(fuelpos)
			local ss = fuelpos:ToScreen()
			local MaxFuel = math.Round(ent:GetMaxFuel(), 1)
			local Fuel = math.Round(ent:GetFuel(), 1)

			MSD.DrawTexturedRect(ss.x - 16, ss.y - 16, 32, 32, MSD.Icons48.gas_station, aming and MSD.Patern.MainColor["9"] or MSD.Patern.MainColor["2"])

			if aming then
				render.SetScissorRect(ss.x - 16, ss.y + 16 - 32 * (Fuel / MaxFuel), ss.x + 16, ss.y + 16, true )
					MSD.DrawTexturedRect(ss.x - 16, ss.y - 16, 32, 32, MSD.Icons48.gas_station, MSD.Patern.MainColor["p"])
				render.SetScissorRect(0, 0, 0, 0, false )
			end
		else
			draw.SimpleTextOutlined("Наведите на топливный бак", "MSDFont.24", xpos, ypos + 50, DarkRP.Hud.Patern["main_l"], TEXT_ALIGN_CENTER, 0, 2, DarkRP.Hud.Patern["shadow"])
		end
	end

	function SWEP:Holster()
		if self:GetOwner() == LocalPlayer() then
			self:GetOwner():GetViewModel():SetMaterial("")
		end
		return true
	end

	function SWEP:OnRemove()
		self:Holster()
	end
end

function SWEP:Initialize()
	self:SetHoldType(self.HoldType)

	if IsValid(self:GetOwner()) then
		self:GetOwner().usedFuel = 0
	end
end

function SWEP:OwnerChanged()
end

function SWEP:Think()
	if SERVER then
		if not self.MainEnt or not IsValid(self.MainEnt) then
			self:Remove()
		end

		if self.NextNotice and self.NextNotice < CurTime() then
			self.NextNotice = nil
			DarkRP.notify(self:GetOwner(), 0, 4, "Вы заправили " .. math.Round(self.refGal * 0.26417, 2) .. " гал. на сумму " .. GAMEMODE.Config.currency .. self.refMon)

			self.refGal = 0
			self.refMon = 0
		end
	end
end

function SWEP:CanPrimaryAttack()
	self.NextFire = self.NextFire or 0
	if self.NextFire > CurTime() then return false end

	return true
end

function SWEP:SetNextPrimaryFire(time)
	self.NextFire = time
end

function SWEP:PrimaryAttack()
	if not self:CanPrimaryAttack() then return end
	local Trace = self:GetOwner():GetEyeTrace()
	local ent = Trace.Entity
	local InRange = (Trace.HitPos - self:GetOwner():GetPos()):Length() < self.MaxDistance
	local HIT = IsValid(ent) and simfphys.IsCar(ent) and InRange
	self:SetNextPrimaryFire(CurTime() + 1)
	if CLIENT then return end
	if not self:GetOwner():canAfford(math.Round(6 * self.RefilAmount)) then return end
	if not HIT then return end

	local Fuel = ent:GetFuel()
	local MaxFuel = ent:GetMaxFuel()

	if self:IsAimingAt(ent:GetFuelPos()) and Fuel + 0.1 < MaxFuel then

		self:GetOwner().pumping = CurTime() + 1.1

		timer.Simple(0.2, function()
			if not IsValid(ent) then return end
			if not IsValid(self) then return end
			if not IsValid(self:GetOwner()) then return end

			self:GetOwner().usedFuel = self:GetOwner().usedFuel or 0
			ent:SetFuel(Fuel + self.RefilAmount)
			self:GetOwner():addMoney(-6 * self.RefilAmount)

			self.NextNotice = CurTime() + 1
			self.refGal = self.refGal + self.RefilAmount
			self.refMon = self.refMon + (6 * self.RefilAmount)

			self:GetOwner().usedFuel = self:GetOwner().usedFuel + self.RefilAmount
		end)
	end
end

function SWEP:SecondaryAttack()
	return false
end

function SWEP:Deploy()
	self:SendWeaponAnim(ACT_VM_DRAW)

	return true
end