--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/deployment/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

SWEP.PrintName = "Предмет"
SWEP.Author = "Mactavish"
SWEP.Purpose = ""
SWEP.Slot = 1
SWEP.SlotPos = 4
SWEP.Spawnable = true
SWEP.ViewModel = Model("models/weapons/c_arms.mdl")
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 55
SWEP.UseHands = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.DrawAmmo = false
SWEP.DrawCrosshair = false
SWEP.HitDistance = 200

local pmp = {
	["models/mosi/fallout4/furniture/workstations/workshopbench.mdl"] = Vector(0,50,0),
	["models/noire/labset.mdl"] = Vector(0,15,42),
	["models/noire/alcset.mdl"] = Vector(-70,-20,47.2),
	["models/props_wasteland/controlroom_storagecloset001a.mdl"] = Vector(0,0,43),
	["models/props_c17/furniturefridge001a.mdl"] = Vector(0,0,33),
	["models/cityrp/pharmstation03.mdl"] = Vector(0,0,20),
	["models/props/cs_militia/footlocker01_closed.mdl"] = Vector(0,0,11),
	["models/anthon/safebox.mdl"] = Vector(5,-5,14),
	["models/mark2580/gtav/mp_apa_hi_garage/garage_stuff/engine_hoist_02a.mdl"] = Vector(0,35,0)
}

local nogost = {
	["models/anthon/safebox.mdl"] = "models/dog/eyeglass",
}

local function calcPos(self, pos, ang, ent)
	if pmp[ent] then
		return pos + ang:Right() * pmp[ent].x + ang:Forward() * pmp[ent].y + ang:Up() * pmp[ent].z
	end
	return pos
end

function SWEP:Initialize()
	self:SetHoldType("normal")
	self:SetGostAngle(Angle(0,0,0))
	self:SetState(1)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 0, "State")
	self:NetworkVar("Entity", 0, "BaseEntity")
	self:NetworkVar("String",0,"DeployModel")
	self:NetworkVar("String",1,"DeployEnt")
	self:NetworkVar("Bool",1,"InProgress")
	self:NetworkVar("Angle",1,"GostAngle")
end

local shops = {
	["warehouse"] = true,
	["store"] = true,
}

local restrinct = {
	["workstation_pharm"] = "pill",
	["workstation_guns"] = "pistol",
	["workstation_alc"] = "beer",
	["workstation_cook"] = "food",
	["workstation_car"] = "car_wrench",
}

local checklist = {
	["workstation_pharm"] = shops,
	["workstation_guns"] = shops,
	["workstation_alc"] = shops,
	["workstation_cook"] = shops,
	["workstation_car"] = {
		["warehouse"] = true,
		["workshop"] = true,
	}
}

local sameclass = {
	["workstation_alc"] = "workstation_cook",
	["workstation_cook"] = "workstation_alc",
}

function SWEP:FailInstall(msg)
	DarkRP.notify(self:GetOwner(), 1, 5, msg)
	self.GhostEntity:Remove()
	self.GhostEntity = nil
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	if self:GetInProgress() then return end
	self:SetNextPrimaryFire(CurTime() + 1)

	local pls = self:GetOwner():SteamID()
	local ent = self:GetDeployEnt()

	if ent and deploy_limit[pls] and deploy_limit[pls][ent] and deploy_limit[pls][ent] > 1 then
		DarkRP.notify(self:GetOwner(), 1, 3, "Достигнут лимит")
		return
	end

	local trace = self:GetOwner():GetEyeTrace()
	if not trace.Hit then return end
	local TargetPos = trace.HitPos

	if not TargetPos or TargetPos:DistToSqr(self:GetOwner():GetPos()) > 20000 or self:GetBaseEntity():GetPos():DistToSqr(self:GetOwner():GetPos()) > 30000 then
		DarkRP.notify(self:GetOwner(), 1, 3, "Неверная позиция")
		return
	end

	local ply = self:GetOwner()

	if restrinct[self:GetDeployEnt()] and ply.LastTerritiry then
		for _, e in ipairs(ents.FindByClass("workstation_*")) do
			if restrinct[e:GetClass()] and sameclass[e:GetClass()] ~= self:GetDeployEnt() and ply.LastTerritiry:IsInside(e) then
				DarkRP.notify(self:GetOwner(), 1, 3, "Помещение уже оборудовано")
				return
			end
		end
	end

	if IsValid(self.GhostEntity) then return end

	self.GhostEntity = ents.Create("prop_physics")
	self.GhostEntity:SetModel( self:GetDeployModel() )
	self.GhostEntity:SetAngles( self:GetGostAngle() )
	self.GhostEntity:SetPos( calcPos(self, TargetPos, self:GetGostAngle(), self:GetDeployModel())  )
	self.GhostEntity:Spawn()
	local phys = self.GhostEntity:GetPhysicsObject()
	phys:EnableMotion(false)
	self.GhostEntity:SetNoDraw(true)

	if not ply.LastTerritiry or ply.LastTerritiry.m_type ~= TERRITORY_TYPE_BUYABLE or not ply.LastTerritiry.masterOwner or not ply.LastTerritiry:IsInside(self.GhostEntity) then
		self:FailInstall("Предмет можно установить только в помещении")
		return
	end

	if checklist[self:GetDeployEnt()] and (not ply.LastTerritiry or not checklist[self:GetDeployEnt()][ply.LastTerritiry.type]) then
		self:FailInstall("Предмет можно установить только в специализированном помещении")
		return
	end

	local min, max = self.GhostEntity:GetCollisionBounds()
	min, max = self.GhostEntity:LocalToWorld(min), self.GhostEntity:LocalToWorld(max)
	for _,v in pairs(ents.FindInBox( min, max )) do
		if v == self.GhostEntity then continue end
		if IsValid(v) and IsValid(v:GetPhysicsObject()) and v:GetClass() ~= "prop_physics" then
			DarkRP.notify(self:GetOwner(), 1, 3, "Место оккупировано")
			self.GhostEntity:Remove()
			self.GhostEntity = nil
			return
		end
	end
	self.GhostEntity:SetNoDraw(false)
	self.GhostEntity:SetRenderMode( RENDERMODE_TRANSCOLOR )

	if nogost[self:GetDeployModel()] then
		self.GhostEntity:SetMaterial(nogost[self:GetDeployModel()])
	else
		self.GhostEntity:SetColor( Color( 255, 255, 255, 150) )
	end

	local time = 3
	self.EndCheck = CurTime() + time
	self:SetInProgress(true)
	net.Start("DrawProgressBar")
	net.WriteFloat(time)
	net.Send(self:GetOwner())
end

function SWEP:Succeed()
	local ply = self:GetOwner()
	net.SendSingleMessage("RemovePropgressBar", ply)
	if restrinct[self:GetDeployEnt()] and ply.LastTerritiry then
		for _, e in ipairs(ents.FindByClass("workstation_*")) do
			if restrinct[e:GetClass()] and sameclass[e:GetClass()] ~= self:GetDeployEnt() and ply.LastTerritiry:IsInside(e) then
				DarkRP.notify(ply, 1, 3, "Помещение уже оборудовано")
				self:Holster()
				return
			end
		end
	end

	if IsValid(self:GetBaseEntity()) and self:GetBaseEntity().shipment then
		self:GetBaseEntity():Remove()
	else
		self:Holster()
		return
	end

	if restrinct[self:GetDeployEnt()] and ply.LastTerritiry then
		ply.LastTerritiry.propetytype = restrinct[self:GetDeployEnt()]
		TerritoriesInfoUpdate()
	end

	local class = self:GetDeployEnt()
	local ent = ents.Create(class)
	ent:SetModel( self:GetDeployModel() )
	ent:SetPos( self.GhostEntity:GetPos() )
	ent:SetAngles( self.GhostEntity:GetAngles() )
	ent:Spawn()
	ent:CPPISetOwner(ply)
	local phys = ent:GetPhysicsObject()
	phys:EnableMotion(false)
	ply:EmitSound("physics/wood/wood_crate_impact_hard" .. math.random(4, 5) .. ".wav")

	local sid = ply:SteamID()
	deploy_limit[sid] = deploy_limit[sid] or {}
	deploy_limit[sid][class] = (deploy_limit[sid][class] and deploy_limit[sid][class] + 1) or 1

	ent.dsid = sid

	self:Holster()
end

function SWEP:Fail()
	net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
	self:Holster()
end

function SWEP:SecondaryAttack()
	self:SetNextSecondaryFire(CurTime() + 0.1)
	if CLIENT then return end
	local ang = self:GetGostAngle()
	ang:RotateAroundAxis(self:GetGostAngle():Up(), 45)
	self:SetGostAngle( ang )
end

function SWEP:Reload()

end

function SWEP:OnRemove()
	if IsValid(self.GhostEntity) then
		self.GhostEntity:Remove()
	end
end

function SWEP:OnDrop()
	if CLIENT then return end
	self:Remove()
end

function SWEP:Deploy()
	local vm = self:GetOwner():GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("idle"))
	self:SetNextPrimaryFire(CurTime() + 0.5)
	self:SetNextSecondaryFire(CurTime() + 0.5)
	return true
end

function SWEP:Holster()
	if CLIENT then return end
	if IsValid(self:GetBaseEntity()) then
		local phys = self:GetBaseEntity():GetPhysicsObject()
		phys:EnableMotion(true)
		self:GetBaseEntity().InUse = nil
	end
	self:GetOwner():DropWeapon(self)
end

function SWEP:Think()
	if CLIENT then

		if self:GetInProgress() then
			if IsValid(self.GhostEntity) then
				self.GhostEntity:Remove()
			end
			return
		end

		if not IsValid(self.GhostEntity) then
			self:MakeGhostEntity( self:GetDeployModel(), self:GetOwner():GetPos(), self:GetGostAngle() )
		else
			self:UpdateGhostEntity()
		end

		return
	end

	if not IsValid(self:GetBaseEntity()) then
		net.SendSingleMessage("RemovePropgressBar", self:GetOwner())
		self:GetOwner():DropWeapon(self)
		return
	end

	if self:GetInProgress() then
		local trace = self:GetOwner():GetEyeTrace().Entity
		if not self.GhostEntity or self.GhostEntity ~= trace then
			self:Fail()
		elseif self.EndCheck <= CurTime() then
			self:Succeed()
		end
		return
	end

	if not IsValid(self:GetBaseEntity()) or ( IsValid(self:GetBaseEntity()) and self:GetBaseEntity():GetPos():DistToSqr(self:GetOwner():GetPos()) > 60000 ) then
		self:GetBaseEntity().InUse = nil
		local phys = self:GetBaseEntity():GetPhysicsObject()
		phys:EnableMotion(true)
	 	self:GetOwner():DropWeapon(self)
	end
end

if CLIENT then
	local icon = Material("msd/icons/hand-okay.png", "smooth")
	local icon2 = Material("msd/icons/cross.png", "smooth")

	function SWEP:DrawHUD()
		local x, y = ScrW() / 2, ScrH() / 2

		if self:GetInProgress() then return end

		if IsValid(self:GetBaseEntity()) and self.GhostEntity and not self.GhostEntity:GetNoDraw() then
			MSD.DrawTexturedRect(x - 10, y - 10, 24, 24, icon, MSD.ColorAlpha(color_black, 200))
			MSD.DrawTexturedRect(x - 12, y - 12, 24, 24, icon, MSD.ColorAlpha(color_white, 200))
			local pos = self:GetBaseEntity():GetPos():ToScreen()
			surface.DrawLine( pos.x, pos.y, x, y )

			x, y = ScrW() * 0.52, ScrH() * 0.5 - 8
			local sp = MSD.DrawKey(x, y - 3, "ЛКМ", 150)
			draw.SimpleTextOutlined("Поместить предмет", "MSDFont.20", x + sp + 10, y, MSD.ColorAlpha(color_white, 220), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(color_black, 80))
			sp = MSD.DrawKey(x, y + 37, "ПКМ", 150)
			draw.SimpleTextOutlined("Повернуть предмет", "MSDFont.20", x + sp + 10, y + 40, MSD.ColorAlpha(color_white, 220), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(color_black, 80))
		else
			MSD.DrawTexturedRect(x - 10, y - 10, 24, 24, icon2, MSD.ColorAlpha(color_black, 200))
			MSD.DrawTexturedRect(x - 12, y - 12, 24, 24, icon2, MSD.ColorAlpha(color_white, 200))
			draw.SimpleTextOutlined("Неверная позиция", "MSDFont.20", x, y + 20, MSD.ColorAlpha(color_white, 220), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(color_black, 80))
		end
	end

	function SWEP:MakeGhostEntity( model, pos, angle )
		if self.GhostEntity then
			if not IsValid( self.GhostEntity ) then self.GhostEntity = nil return end
			self.GhostEntity:Remove()
			self.GhostEntity = nil
		end
		self.GhostEntity = ClientsideModel( model )
		if not IsValid( self.GhostEntity ) then
			self.GhostEntity = nil
			return
		end
		self.GhostEntity:SetModel( model )
		self.GhostEntity:SetPos( calcPos(self, pos, angle, model) )
		self.GhostEntity:SetAngles( angle )
		self.GhostEntity:Spawn()
		self.GhostEntity:SetRenderMode( RENDERMODE_TRANSCOLOR )

		if nogost[model] then
			self.GhostEntity:SetMaterial(nogost[model])
		else
			self.GhostEntity:SetColor( Color( 255, 255, 255, 150) )
		end
	end

	function SWEP:UpdateGhostEntity()
		if ( self.GhostEntity == nil ) then return end
		if ( not IsValid( self.GhostEntity ) ) then self.GhostEntity = nil return end

		local trace = self:GetOwner():GetEyeTrace()
		if not trace.Hit then return end
		local TargetPos =  trace.HitPos

		if not TargetPos or TargetPos:DistToSqr(self:GetOwner():GetPos()) > 20000 or self:GetBaseEntity():GetPos():DistToSqr(self:GetOwner():GetPos()) > 30000 then self.GhostEntity:SetNoDraw(true) return end
		self.GhostEntity:SetNoDraw(false)
		self.GhostEntity:SetAngles( self:GetGostAngle() )
		self.GhostEntity:SetPos( calcPos(self, TargetPos, self:GetGostAngle(), self:GetDeployModel()) )

	end
end