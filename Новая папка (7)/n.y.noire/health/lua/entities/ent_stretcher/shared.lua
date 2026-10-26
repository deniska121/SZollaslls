--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/health/lua/entities/ent_stretcher/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Каталки"
ENT.Author = "Mac"
ENT.Spawnable = true
ENT.AdminSpawnable = false

function ENT:Initialize()
	if CLIENT then return end

	self:SetModel("models/props_unique/hospital/gurney.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:SetUseType(SIMPLE_USE)

	local stretcher = ents.Create("prop_vehicle_prisoner_pod")
	stretcher:SetPos(self:LocalToWorld(Vector(0,1,30)))
	stretcher:SetModel("models/nova/airboat_seat.mdl") -- DO NOT CHANGE OR CRASHES WILL HAPPEN
	stretcher:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
	stretcher:SetKeyValue("limitview", "0")
	stretcher:SetThirdPersonMode(false)
	stretcher:SetAngles(self:LocalToWorldAngles(Angle(5, 0, -5)))
	stretcher:Spawn()
	stretcher:Activate()
	stretcher:SetParent(self)
	stretcher:SetCollisionGroup(COLLISION_GROUP_WORLD)
	stretcher:SetNotSolid(true)
	stretcher:SetNW2String("sit_anim", "lying_down")

	local phys = stretcher:GetPhysicsObject()
	stretcher:SetMoveType(MOVETYPE_PUSH)
	phys:Sleep()
	phys:EnableGravity(false)
	phys:EnableMotion(false)
	phys:EnableCollisions(false)
	phys:SetMass(1)
	stretcher:SetKeyValue("limitview", "0")
	stretcher:CollisionRulesChanged()
	stretcher:SetNotSolid(true)
	stretcher:DrawShadow(false)
	stretcher:SetColor(Color(0, 0, 0, 0))
	stretcher:SetRenderMode(RENDERMODE_TRANSALPHA)
	stretcher:SetNoDraw(true)
	stretcher.Stretcher = self

	self.Stretcher = stretcher
	self.dragFixed = true
	self.drag_pen = 6
	self.dragMaxForce = 30000
	self:DeleteOnRemove(stretcher)
	self.AdminPhysGun = true

	constraint.Keepupright( self, self:GetAngles(), 0, 999999 )
end

function ENT:Think()
	if CLIENT then return end

	self:NextThink(CurTime() + 0.1)

	if IsValid(self.Draged) and IsValid(self.Draged:GetOwner()) then
		local ply = self.Draged:GetOwner()
		if not ply:getDarkRPVar("dragging") then return end
		local hit = util.TraceLine({start = self:GetPos(),endpos = self:GetPos() - Vector(0,0,5), filter = self}).Hit
		ply:SetSelfDarkRPVar("dragging", hit and 6 or 1)
	end
end

function ENT:KickPlayer()
	local ply = self.Stretcher:GetDriver()
	ply.m_intStretcherExitTime = CurTime() + 2

	if IsValid(ply) then
		ply:ExitVehicle()
	end

	ply:SetPos(self:GetPos())
	GAMEMODE.Util:UnstuckPlayer(ply, 72)

	if ply:IsUncon() then
		GAMEMODE.Util:NextTick(function()
			if not IsValid(ply) then return end
			ply:GoUncon()
		end)
	else
		if ply.m_bStretcherWasDead then
			ply.m_bStretcherWasDead = nil
			ply:Kill()
		end
	end
end

function ENT:Enter(ply)
	ply:EnterVehicle(self.Stretcher)
	ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
	ply:CollisionRulesChanged()
end

function ENT:Use(activator, caller, type, value)
	if self.used and self.used > CurTime() then return end
	if not activator:IsPlayer() then return end
	self.used = CurTime() + 1

	if activator:KeyDown( IN_SPEED ) then
		if IsValid(self.parented) then
			if not self.parented.fdoornum or self.parented.fdoornum ~= 1 then return end
			self:UnHook()
		else
			for k,v in ipairs(ents.FindInSphere(self:GetPos(), 100)) do
				if self.MainEnt and self.MainEnt ~= v then continue end
				if not v.EMS_car or not v.fdoornum or v.fdoornum ~= 1 then continue end
				self:Hook(v)
				break
			end
		end

		self.used = CurTime() + 5
		return
	end

	if IsValid(self.parented) then return end
	if self.m_intLastTouch and self.m_intLastTouch > CurTime() then return end

	self.m_intLastTouch = CurTime() + 5

	if IsValid(self.Stretcher:GetDriver()) then
		self.Stretcher:GetDriver():ExitVehicle()
		self.m_intLastTouch = CurTime() + 10
	else
		self:Enter(activator)
	end
end

function ENT:ExitPlayer()
	if IsValid(self.Stretcher:GetDriver()) then
		self:KickPlayer()
	end
end

function ENT:Hook(parent)
	if not IsValid(parent) then return end

	if parent.stretcher and IsValid(parent.stretcher) then return end

	self.parented = parent
	self:EmitSound("vcmod/car_connect.wav", 65, 120)
	self:PhysWake()
	self:SetPos(parent:LocalToWorld(Vector(-100,0,40)))
	self:SetAngles(parent:LocalToWorldAngles(Angle(0,90,0)))
	self:SetParent(parent)
	parent.stretcher = self
end

function ENT:UnHook(activator)
	local parent = self:GetParent()

	if IsValid(parent) then
		parent.stretcher = nil
		self.parented = nil
		self:SetParent()
		self:EmitSound("vcmod/car_connect.wav", 65, 120)
		self:SetPos(parent:LocalToWorld(Vector(-120,0,40)))
		self:PhysWake()
	end
end

function ENT:StartTouch(ent)
	if self.m_intLastTouch and self.m_intLastTouch > CurTime() then return end
	if not IsValid(self.Stretcher) or IsValid(self.Stretcher:GetDriver()) then return end

	if ent:GetClass() == "prop_ragdoll" and IsValid(ent.player) and ent.ragdollize then
		self.m_intLastTouch = CurTime() + 5
		local ply = ent.player
		if not ply:Alive() then return end

		ply:DeRagdollize()
		self:Enter(ply)
	end
end