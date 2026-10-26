--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/spawned_bag.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "spawned_storage"
ENT.PrintName = "Пакет"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.invCanStore = 0.01

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_shops/prop_bakery_flourbag_01_a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		local phys = self:GetPhysicsObject()
		phys:Wake()
		self:SetSpace(2)
		self:SetStorageName("Пакет")
		self.inv = {}
		self.inv[INV_WEAPON] = {}
		self.inv[INV_ENTITY] = {}
		self.inv[INV_AMMO] = {}
		self.inv[INV_FOOD] = {}
		self.inv[INV_JUNK] = {}
	end

	function ENT:Use(ply)
		if DarkRP.UseDelay(self, 2) then return end
		McINV.Loot(self, ply, false, true)
		self:EmitSound("physics/cardboard/cardboard_box_strain1.wav")
	end
end