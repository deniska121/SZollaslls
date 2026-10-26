--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/entities/gmod_sent_vehicle_fphysics_gib.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.Spawnable = false
ENT.AdminSpawnable = false

if CLIENT then
	local Mat = CreateMaterial("simfphysdamage", "VertexLitGeneric", {
		["$basetexture"] = "models/player/player_chrome1",
	})

	function ENT:Draw()
		self:DrawModel()
		render.SetColorModulation(1, 1, 1)
		render.ModelMaterialOverride(Mat)
		render.SetBlend(0.8)
		self:DrawModel()
		render.ModelMaterialOverride()
		render.SetBlend(1)
	end

	net.Receive("simfphys_explosion_fx", function(length)
		local en = net.ReadEntity()

		if IsValid(en) then
			local effectdata = EffectData()
			effectdata:SetOrigin(en:GetPos())
			util.Effect("simfphys_explosion", effectdata)
		end
	end)
end

if SERVER then
	util.AddNetworkString("simfphys_explosion_fx")

	function ENT:Initialize()
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self.burnhp = 100
		if not IsValid(self:GetPhysicsObject()) then
			self.RemoveTimer = 0
			self:Remove()

			return
		end

		self:GetPhysicsObject():EnableMotion(true)
		self:GetPhysicsObject():Wake()
		self:SetCollisionGroup(COLLISION_GROUP_NONE)
		self:SetRenderMode(RENDERMODE_TRANSALPHA)

		timer.Simple(0.05, function()
			if not IsValid(self) then return end

			if self.MakeSound == true then
				net.Start("simfphys_explosion_fx")
				net.WriteEntity(self)
				net.Broadcast()
				util.ScreenShake(self:GetPos(), 50, 50, 1.5, 700)
				util.BlastDamage(self, Entity(0), self:GetPos(), 300, 200)
				local Light = ents.Create("light_dynamic")
				Light:SetPos(self:GetPos() + Vector(0, 0, 10))
				local Lightpos = Light:GetPos() + Vector(0, 0, 10)
				Light:SetPos(Lightpos)
				Light:SetKeyValue("_light", "220 40 0 255")
				Light:SetKeyValue("style", 1)
				Light:SetKeyValue("distance", 255)
				Light:SetKeyValue("brightness", 2)
				Light:SetParent(self)
				Light:Spawn()
				Light:Fire("TurnOn", "", "0")

				timer.Simple(0.7, function()
					if not IsValid(self) then return end
					self.particleeffect = ents.Create("info_particle_system")
					self.particleeffect:SetKeyValue("effect_name", "fire_large_01")
					self.particleeffect:SetKeyValue("start_active", 1)
					self.particleeffect:SetOwner(self)
					self.particleeffect:SetPos(self:LocalToWorld(self:GetPhysicsObject():GetMassCenter() + Vector(0, 0, 15)))
					self.particleeffect:SetAngles(self:GetAngles())
					self.particleeffect:Spawn()
					self.particleeffect:Activate()
					self.particleeffect:SetParent(self)
					self.FireSound = CreateSound(self, "ambient/fire/firebig.wav")
					self.FireSound:Play()
				end)

				timer.Simple(390, function()
					if not IsValid(self) then return end

					if IsValid(Light) then
						Light:Remove()
					end

					if IsValid(self.particleeffect) then
						self.particleeffect:Remove()
					end

					if self.FireSound then
						self.FireSound:Stop()
					end
				end)
			else
				self.particleeffect = ents.Create("info_particle_system")
				self.particleeffect:SetKeyValue("effect_name", "fire_small_03")
				self.particleeffect:SetKeyValue("start_active", 1)
				self.particleeffect:SetOwner(self)
				self.particleeffect:SetPos(self:LocalToWorld(self:GetPhysicsObject():GetMassCenter()))
				self.particleeffect:SetAngles(self:GetAngles())
				self.particleeffect:Spawn()
				self.particleeffect:Activate()
				self.particleeffect:SetParent(self)
				self.particleeffect:Fire("Stop", "", math.random(0.5, 3))

				self.burnhp = 40
			end
		end)

		self.RemoveDis = 720
		self.RemoveTimer = CurTime() + self.RemoveDis
	end

	function ENT:Think()
		if self.RemoveTimer < CurTime() and self.RemoveDis > 0 then
			self:Remove()
		end

		if self:WaterLevel() > 1 then
			self:ExtinguishFires(2000)
		end

		self:NextThink(CurTime() + 0.2)

		return true
	end

	function ENT:OnRemove()
		if self.FireSound then
			self.FireSound:Stop()
		end
	end

	function ENT:OnTakeDamage(dmginfo)
		self:TakePhysicsDamage(dmginfo)
	end

	function ENT:PhysicsCollide(data, physobj)
		if self.cold then return end

		if self.lasd and self.lasd > CurTime() then
			return
		end

		self.lasd = CurTime() + 0.2

		if IsValid(data.HitEntity) and data.HitEntity:IsPlayer() then
			local d = DamageInfo()
			d:SetDamage( math.random(5))
			d:SetAttacker( self )
			d:SetDamageType( DMG_BURN )
			data.HitEntity:TakeDamageInfo( d )
		end
	end

	function ENT:ExtinguishFires(hp)
		if self.lastex and self.lastex > CurTime() then
			return
		end

		self.lastex = CurTime() + math.random(5)

		if self.burnhp > 0 then
			self.burnhp = self.burnhp - hp
			self:EmitSound("hl1/ambience/steamburst1.wav")
			return
		end

		if self.cold then return end

		self.cold = true

		if IsValid(Light) then
			Light:Remove()
		end

		if IsValid(self.particleeffect) then
			self.particleeffect:Remove()
		end

		if self.FireSound then
			self.FireSound:Stop()
		end
	end
end