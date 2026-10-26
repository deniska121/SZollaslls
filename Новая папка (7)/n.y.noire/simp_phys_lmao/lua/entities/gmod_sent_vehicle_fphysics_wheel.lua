--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/entities/gmod_sent_vehicle_fphysics_wheel.lua
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
ENT.DoNotDuplicate = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "OnGround")
	self:NetworkVar("Float", 1, "Speed")
	self:NetworkVar("Float", 2, "SkidSound")
	self:NetworkVar("Float", 3, "GripLoss")
	self:NetworkVar("Bool", 0, "Damaged")
	self:NetworkVar("Entity", 0, "BaseEnt")
	self:NetworkVar("String", 0, "SurfaceMaterial")

	if SERVER then
		self:NetworkVarNotify("Damaged", self.OnDamaged)
	end
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_vehicles/tire001c_car.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		self:SetUseType(SIMPLE_USE)
		self:AddFlags(FL_OBJECT)
		self:DrawShadow(false)
		self.OldMaterial = ""
		self.OldMaterial2 = ""
		self.OldVar = 0
		self.OldVar2 = 0
		local Color = self:GetColor()
		local dot = Color.r * Color.g * Color.b * Color.a
		self.OldColor = dot

		timer.Simple(0.01, function()
			if not IsValid(self) then return end
			self.WheelDust = ents.Create("info_particle_system")
			self.WheelDust:SetKeyValue("effect_name", "WheelDust")
			self.WheelDust:SetKeyValue("start_active", 0)
			self.WheelDust:SetOwner(self)
			self.WheelDust:SetPos(self:GetPos() + Vector(0, 0, -self:BoundingRadius() * 0.4))
			self.WheelDust:SetAngles(self:GetAngles())
			self.WheelDust:Spawn()
			self.WheelDust:Activate()
			self.WheelDust:SetParent(self)
			self.WheelDust.DoNotDuplicate = true
			simfphys.SetOwner(self.EntityOwner, self.WheelDust)
			if not istable(StormFox) or not isfunction(StormFox.IsRaining) then return end
			self.WheelSplash = ents.Create("info_particle_system")
			self.WheelSplash:SetKeyValue("effect_name", "WheelSplashForward")
			self.WheelSplash:SetKeyValue("start_active", 0)
			self.WheelSplash:SetOwner(self)
			self.WheelSplash:SetPos(self:GetPos() + Vector(0, 0, -self:BoundingRadius() - 5))
			self.WheelSplash:SetAngles(self:GetAngles())
			self.WheelSplash:Spawn()
			self.WheelSplash:Activate()
			self.WheelSplash:SetParent(self)
			self.WheelSplash.DoNotDuplicate = true
			simfphys.SetOwner(self.EntityOwner, self.WheelSplash)
		end)

		self.snd_roll = "simulated_vehicles/sfx/concrete_roll.wav"
		self.snd_roll_dirt = "simulated_vehicles/sfx/dirt_roll.wav"
		self.snd_roll_grass = "simulated_vehicles/sfx/grass_roll.wav"
		self.snd_skid = "simulated_vehicles/sfx/concrete_skid.wav"
		self.snd_skid_dirt = "simulated_vehicles/sfx/dirt_skid.wav"
		self.snd_skid_grass = "simulated_vehicles/sfx/grass_skid.wav"
		self.RollSound = CreateSound(self, self.snd_roll)
		self.RollSound_Dirt = CreateSound(self, self.snd_roll_dirt)
		self.RollSound_Grass = CreateSound(self, self.snd_roll_grass)
		self.Skid = CreateSound(self, self.snd_skid)
		self.Skid_Dirt = CreateSound(self, self.snd_skid_dirt)
		self.Skid_Grass = CreateSound(self, self.snd_skid_grass)

		-- Caches of the last-seen sound paths; used to avoid re-CreateSounding the
		-- same file over and over (which orphans the previous CSoundPatch channel).
		self._lastSnd_roll = self.snd_roll
		self._lastSnd_roll_dirt = self.snd_roll_dirt
		self._lastSnd_roll_grass = self.snd_roll_grass
		self._lastSnd_skid = self.snd_skid
		self._lastSnd_skid_dirt = self.snd_skid_dirt
		self._lastSnd_skid_grass = self.snd_skid_grass
	end

	-- Helper: only recreate a CSoundPatch when the source path actually changed
	-- (e.g. rain flipped concrete → concrete_wet). Otherwise just return the
	-- existing patch. Always Stops the previous patch before replacement.
	local function ReplaceSoundIfChanged(ent, key, newPath, lastKey)
		if ent[lastKey] == newPath and ent[key] then return ent[key] end
		if ent[key] then ent[key]:Stop() end
		ent[key] = CreateSound(ent, newPath)
		ent[lastKey] = newPath
		return ent[key]
	end

	function ENT:Use(ply)
	end

	function ENT:Think()
		if self.GhostEnt then
			local Color = self:GetColor()
			local dot = Color.r * Color.g * Color.b * Color.a

			if dot ~= self.OldColor then
				if IsValid(self.GhostEnt) then
					self.GhostEnt:SetColor(Color)
					self.GhostEnt:SetRenderMode(self:GetRenderMode())
				end

				self.OldColor = dot
			end

		if self:GetDamaged() then
			self:WheelFxBroken()
		else
			self:WheelFx()
		end

		self:CheckWeather()
		self:NextThink(CurTime() + 0.15)
		end
		return true
	end

	function ENT:CheckWeather()
		if not istable(StormFox) or not isfunction(StormFox.IsRaining) then return end

		if StormFox.IsRaining() then
			self.RainDetected = true
			self.snd_roll = "simulated_vehicles/sfx/concrete_roll_wet.wav"
			self.snd_skid = "simulated_vehicles/sfx/concrete_skid_wet.wav"
		else
			self.RainDetected = false
			self.snd_roll = "simulated_vehicles/sfx/concrete_roll.wav"
			self.snd_skid = "simulated_vehicles/sfx/concrete_skid.wav"
		end
	end

	function ENT:WheelFxBroken()
		local ForwardSpeed = math.abs(self:GetSpeed())
		local SkidSound = math.Clamp(self:GetSkidSound(), 0, 255)
		local Speed = self:GetVelocity():Length()
		local WheelOnGround = self:GetOnGround()
		local EnableDust = (Speed * WheelOnGround > 200)
		local Material = self:GetSurfaceMaterial()
		local GripLoss = self:GetGripLoss()

		if EnableDust ~= self.OldVar then
			self.OldVar = EnableDust

			if self.RainDetected then
				if EnableDust then
					if IsValid(self.WheelSplash) then
						self.WheelSplash:Fire("Start")
					end
				else
					if IsValid(self.WheelSplash) then
						self.WheelSplash:Fire("Stop")
					end
				end
			else
				if IsValid(self.WheelSplash) then
					self.WheelSplash:Fire("Stop")
				end
			end

			if EnableDust then
				if Material == "grass" then
					if IsValid(self.WheelDust) then
						self.WheelDust:Fire("Start")
					end
				elseif Material == "dirt" or Material == "sand" then
					if IsValid(self.WheelDust) then
						self.WheelDust:Fire("Start")
					end
				end
			else
				if IsValid(self.WheelDust) then
					self.WheelDust:Fire("Stop")
				end
			end
		end

		if EnableDust and Material ~= self.OldMaterial then
			if Material == "grass" then
				if IsValid(self.WheelDust) then
					self.WheelDust:Fire("Start")
				end
			elseif Material == "dirt" or Material == "sand" then
				if IsValid(self.WheelDust) then
					self.WheelDust:Fire("Start")
				end
			else
				if IsValid(self.WheelDust) then
					self.WheelDust:Fire("Stop")
				end
			end

			self.OldMaterial = Material
		end

		if self.RollSound_Broken then
			local Volume = math.Clamp(SkidSound * 0.5 + ForwardSpeed / 1500, 0, 1) * WheelOnGround
			local PlaySound = Volume > 0.1
			self.OldPlaySound = self.OldPlaySound or false

			if PlaySound ~= self.OldPlaySound then
				self.OldPlaySound = PlaySound

				if PlaySound then
					self.RollSound_Broken:PlayEx(0, 0)
				else
					self.RollSound_Broken:Stop()
				end
			end

			self.RollSound_Broken:ChangeVolume(Volume)
			self.RollSound_Broken:ChangePitch(100 + math.Clamp((ForwardSpeed - 100) / 250 + (SkidSound * Speed / 800) + GripLoss * 22, 0, 155))
		end
	end

	function ENT:WheelFx()
		local ForwardSpeed = math.abs(self:GetSpeed())
		local SkidSound = math.Clamp(self:GetSkidSound(), 0, 255)
		local Speed = self:GetVelocity():Length()
		local WheelOnGround = self:GetOnGround()
		local EnableDust = (Speed * WheelOnGround > 200)
		local SurfMat = self:GetSurfaceMaterial()
		local GripLoss = self:GetGripLoss()

		if EnableDust ~= self.OldVar then
			self.OldVar = EnableDust

			if self.RainDetected then
				if EnableDust then
					if IsValid(self.WheelSplash) then
						self.WheelSplash:Fire("Start")
					end
				else
					if IsValid(self.WheelSplash) then
						self.WheelSplash:Fire("Stop")
					end
				end
			else
				if IsValid(self.WheelSplash) then
					self.WheelSplash:Fire("Stop")
				end
			end

			if EnableDust then
				if SurfMat == "grass" then
					if IsValid(self.WheelDust) then
						self.WheelDust:Fire("Start")
					end

					ReplaceSoundIfChanged(self, "RollSound_Grass", self.snd_roll_grass, "_lastSnd_roll_grass")
					self.RollSound_Grass:PlayEx(0, 0)
					self.RollSound_Dirt:Stop()
					self.RollSound:Stop()
				elseif SurfMat == "dirt" or SurfMat == "sand" then
					if IsValid(self.WheelDust) then
						self.WheelDust:Fire("Start")
					end

					ReplaceSoundIfChanged(self, "RollSound_Dirt", self.snd_roll_dirt, "_lastSnd_roll_dirt")
					self.RollSound_Dirt:PlayEx(0, 0)
					self.RollSound_Grass:Stop()
					self.RollSound:Stop()
				else
					self.RollSound_Grass:Stop()
					self.RollSound_Dirt:Stop()
					ReplaceSoundIfChanged(self, "RollSound", self.snd_roll, "_lastSnd_roll")
					self.RollSound:PlayEx(0, 0)
				end
			else
				if IsValid(self.WheelDust) then
					self.WheelDust:Fire("Stop")
				end

				self.RollSound:Stop()
				self.RollSound_Grass:Stop()
				self.RollSound_Dirt:Stop()
			end
		end

		if EnableDust then
			if SurfMat ~= self.OldMaterial then
				if SurfMat == "grass" then
					if IsValid(self.WheelDust) then
						self.WheelDust:Fire("Start")
					end

					ReplaceSoundIfChanged(self, "RollSound_Grass", self.snd_roll_grass, "_lastSnd_roll_grass")
					self.RollSound_Grass:PlayEx(0, 0)
					self.RollSound_Dirt:Stop()
					self.RollSound:Stop()
				elseif SurfMat == "dirt" or SurfMat == "sand" then
					if IsValid(self.WheelDust) then
						self.WheelDust:Fire("Start")
					end

					self.RollSound_Grass:Stop()
					ReplaceSoundIfChanged(self, "RollSound_Dirt", self.snd_roll_dirt, "_lastSnd_roll_dirt")
					self.RollSound_Dirt:PlayEx(0, 0)
					self.RollSound:Stop()
				else
					if IsValid(self.WheelDust) then
						self.WheelDust:Fire("Stop")
					end

					self.RollSound_Grass:Stop()
					self.RollSound_Dirt:Stop()
					ReplaceSoundIfChanged(self, "RollSound", self.snd_roll, "_lastSnd_roll")
					self.RollSound:PlayEx(0, 0)
				end

				self.OldMaterial = SurfMat
			end

			if SurfMat == "grass" then
				self.RollSound_Grass:ChangeVolume(math.Clamp((ForwardSpeed - 100) / 1600, 0, 1), 0)
				self.RollSound_Grass:ChangePitch(80 + math.Clamp((ForwardSpeed - 100) / 250, 0, 255), 0)
			elseif SurfMat == "dirt" or SurfMat == "sand" then
				self.RollSound_Dirt:ChangeVolume(math.Clamp((ForwardSpeed - 100) / 1600, 0, 1), 0)
				self.RollSound_Dirt:ChangePitch(80 + math.Clamp((ForwardSpeed - 100) / 250, 0, 255), 0)
			else
				self.RollSound:ChangeVolume(math.Clamp((ForwardSpeed - 100) / 1500, 0, 1), 0)
				self.RollSound:ChangePitch(100 + math.Clamp((ForwardSpeed - 400) / 200, 0, 255), 0)
			end
		end

		if WheelOnGround ~= self.OldVar2 then
			self.OldVar2 = WheelOnGround

			if WheelOnGround == 1 then
				if SurfMat == "grass" or SurfMat == "snow" then
					self.Skid:Stop()
					ReplaceSoundIfChanged(self, "Skid_Grass", self.snd_skid_grass, "_lastSnd_skid_grass")
					self.Skid_Grass:PlayEx(0, 0)
					self.Skid_Dirt:Stop()
				elseif SurfMat == "dirt" or SurfMat == "sand" then
					self.Skid_Grass:Stop()
					ReplaceSoundIfChanged(self, "Skid_Dirt", self.snd_skid_dirt, "_lastSnd_skid_dirt")
					self.Skid_Dirt:PlayEx(0, 0)
					self.Skid:Stop()
				elseif SurfMat == "ice" then
					self.Skid_Grass:Stop()
					self.Skid_Dirt:Stop()
					self.Skid:Stop()
				else
					ReplaceSoundIfChanged(self, "Skid", self.snd_skid, "_lastSnd_skid")
					self.Skid:PlayEx(0, 0)
					self.Skid_Grass:Stop()
					self.Skid_Dirt:Stop()
				end
			else
				self.Skid:Stop()
				self.Skid_Grass:Stop()
				self.Skid_Dirt:Stop()
			end
		end

		if WheelOnGround == 1 then
			if SurfMat ~= self.OldMaterial2 then
				if SurfMat == "grass" or SurfMat == "snow" then
					self.Skid:Stop()
					ReplaceSoundIfChanged(self, "Skid_Grass", self.snd_skid_grass, "_lastSnd_skid_grass")
					self.Skid_Grass:PlayEx(0, 0)
					self.Skid_Dirt:Stop()
				elseif SurfMat == "dirt" or SurfMat == "sand" then
					self.Skid:Stop()
					self.Skid_Grass:Stop()
					ReplaceSoundIfChanged(self, "Skid_Dirt", self.snd_skid_dirt, "_lastSnd_skid_dirt")
					self.Skid_Dirt:PlayEx(0, 0)
				elseif SurfMat == "ice" then
					self.Skid_Grass:Stop()
					self.Skid_Dirt:Stop()
					self.Skid:Stop()
				else
					ReplaceSoundIfChanged(self, "Skid", self.snd_skid, "_lastSnd_skid")
					self.Skid:PlayEx(0, 0)
					self.Skid_Grass:Stop()
					self.Skid_Dirt:Stop()
				end

				self.OldMaterial2 = SurfMat
			end

			if SurfMat == "grass" or SurfMat == "snow" then
				self.Skid_Grass:ChangeVolume(math.Clamp(SkidSound, 0, 1))
				self.Skid_Grass:ChangePitch(math.min(90 + (SkidSound * Speed / 500), 150))
			elseif SurfMat == "dirt" or SurfMat == "sand" then
				self.Skid_Dirt:ChangeVolume(math.Clamp(SkidSound, 0, 1) * 0.8)
				self.Skid_Dirt:ChangePitch(math.min(120 + (SkidSound * Speed / 500), 150))
			else
				self.Skid:ChangeVolume(math.Clamp(SkidSound * 0.5, 0, 1))
				self.Skid:ChangePitch(math.min(85 + (SkidSound * Speed / 800) + GripLoss * 22, 150))
			end
		end
	end

	function ENT:OnRemove()
		self.RollSound_Grass:Stop()
		self.RollSound_Dirt:Stop()
		self.RollSound:Stop()
		self.Skid:Stop()
		self.Skid_Grass:Stop()
		self.Skid_Dirt:Stop()

		if self.RollSound_Broken then
			self.RollSound_Broken:Stop()
		end

		if self.PreBreak then
			self.PreBreak:Stop()
		end
	end

	function ENT:PhysicsCollide(data, physobj)
		if data.Speed > 100 and data.DeltaTime > 0.2 then
			if data.Speed > 400 then
				self:EmitSound("Rubber_Tire.ImpactHard")
				self:EmitSound("simulated_vehicles/suspension_creak_" .. math.random(1, 6) .. ".ogg")
			else
				self:EmitSound("Rubber.ImpactSoft")
			end
		end
	end

	function ENT:OnTakeDamage(dmginfo)
		self:TakePhysicsDamage(dmginfo)
		if self:GetDamaged() or not simfphys.DamageEnabled or not self.GhostEnt then return end
		local TYPE = dmginfo:GetDamageType()
		local Damage = dmginfo:GetDamage()
		local BaseEnt = self:GetBaseEnt()
		if TYPE == DMG_BLAST or TYPE == DMG_CLUB then return end -- no tirepopping on explosions

		if IsValid(BaseEnt) then
			if BaseEnt:GetBulletProofTires() then return end

			if Damage > 1 then
				if not self.PreBreak then
					self.PreBreak = CreateSound(self, "ambient/gas/cannister_loop.wav")
					self.PreBreak:PlayEx(0.5, 100)

					timer.Simple(math.Rand(0.5, 5), function()
						if IsValid(self) and not self:GetDamaged() then
							self:SetDamaged(true)

							if self.PreBreak then
								self.PreBreak:Stop()
								self.PreBreak = nil
							end
						end
					end)
				else
					self:SetDamaged(true)
					self.PreBreak:Stop()
					self.PreBreak = nil
				end
			end
		end
	end

	function ENT:OnDamaged(name, old, new)
		if new == old then return end

		if new == true then
			self.dRadius = self:BoundingRadius() * 0.28
			self:EmitSound("simulated_vehicles/sfx/tire_break.ogg")

			if IsValid(self.GhostEnt) then
				self.GhostEnt:SetParent(nil)
				self.GhostEnt:GetPhysicsObject():EnableMotion(false)
				self.GhostEnt:SetPos(self:LocalToWorld(Vector(0, 0, -self.dRadius)))
				self.GhostEnt:SetParent(self)
			end

			self.Skid:Stop()
			self.Skid_Grass:Stop()
			self.Skid_Dirt:Stop()
			self.RollSound:Stop()
			self.RollSound_Grass:Stop()
			self.RollSound_Dirt:Stop()
			self.RollSound_Broken = CreateSound(self, "simulated_vehicles/sfx/tire_damaged.wav")
		else
			if IsValid(self.GhostEnt) then
				self.GhostEnt:SetParent(nil)
				self.GhostEnt:GetPhysicsObject():EnableMotion(false)
				self.GhostEnt:SetPos(self:LocalToWorld(Vector(0, 0, 0)))
				self.GhostEnt:SetParent(self)
			end

			if self.RollSound_Broken then
				self.RollSound_Broken:Stop()
			end
		end

		local BaseEnt = self:GetBaseEnt()

		if IsValid(BaseEnt) then
			BaseEnt:SetSuspension(self.Index, new)
		end
	end
end

local function ET(pos, pos2, mask)
	local t = util.TraceLine({
		start = pos,
		endpos = pos + pos2,
		mask = mask,
		filter = LocalPlayer():GetViewEntity() or LocalPlayer()
	})

	if not t then
		t = {}
		t.HitPos = pos + pos2

		return t
	end

	t.HitPos = t.HitPos or (pos + pos2)

	return t
end

local skidmarks = {}
local mat_tire = Material("simfphys/skidmarks", "smooth")


if CLIENT then
	function ENT:Initialize()
		self.FadeHeat = 0

		timer.Simple(0.01, function()
			if not IsValid(self) then return end
			self.Radius = self:BoundingRadius()
		end)
	end

	function ENT:Think()
		if self.GetHideFX and self:GetHideFX() then return end

		local curtime = CurTime()
		self.SmokeTimer = self.SmokeTimer or 0

		if self.SmokeTimer < curtime then
			self:ManageSmoke()
			self.SmokeTimer = curtime + 0.005
		end

		self:NextThink(curtime)

		return true
	end

	function ENT:ManageSmoke()
		local BaseEnt = self:GetBaseEnt()
		if not IsValid(BaseEnt) then return end
		local WheelOnGround = self:GetOnGround()
		local GripLoss = self:GetGripLoss()
		local surfMat = self:GetSurfaceMaterial()

		if WheelOnGround > 0 and (surfMat == "concrete" or surfMat == "rock" or surfMat == "tile") and GripLoss > 0 then
			self.FadeHeat = math.Clamp(self.FadeHeat + GripLoss * 0.06, 0, 10)
		else
			self.FadeHeat = self.FadeHeat * 0.995
		end

		local Scale = self.FadeHeat ^ 3 / 1000
		local SmokeOn = (self.FadeHeat >= 7)
		local DirtOn = GripLoss > 0.05
		if not self.lcol then
			self.lcol = BaseEnt:GetTireSmokeColor() * 255
		end
		local Speed = self:GetVelocity():LengthSqr()
		local OnRim = self:GetDamaged()
		local Forward = self:GetForward()
		local Dir = (BaseEnt:GetGear() < 2) and Forward or -Forward
		local WheelSize = self.Radius or 0
		local Pos = self:GetPos()

		if SmokeOn and not OnRim and GetConVar("noire_car_smokeon"):GetBool() then
			local effectdata = EffectData()
			effectdata:SetOrigin(Pos)
			effectdata:SetNormal(Dir)
			effectdata:SetMagnitude(Scale)
			effectdata:SetRadius(WheelSize)
			effectdata:SetStart(Vector(self.lcol.r, self.lcol.g, self.lcol.b))
			effectdata:SetEntity(NULL)
			util.Effect("simfphys_tiresmoke", effectdata)
		end

		if WheelOnGround == 0 then return end

		if (Speed > 22500 or DirtOn) and OnRim then
			self:MakeSparks(GripLoss, Dir, Pos, WheelSize)
		end

		if DirtOn then
			if GetConVar("noire_car_smokeon"):GetBool() then
				local effectdata = EffectData()
				effectdata:SetOrigin(Pos)
				effectdata:SetNormal(Dir)
				effectdata:SetMagnitude(GripLoss)
				effectdata:SetRadius(WheelSize)
				effectdata:SetEntity(self)
				util.Effect("simfphys_tiresmoke", effectdata)
			end

			if not self.LastTireSlide or self.LastTireSlide < CurTime() then
				self.LastTireSlide = CurTime() + 0.1
				local tr = ET(Pos + Vector(0, 0, 20), Vector(0, 0, -40), MASK_SOLID_BRUSHONLY)
				local ang = self:GetAngles()
				ang:RotateAroundAxis(ang:Up(), 90)

				if not tr.HitWorld then
					self.last_insert = nil

					return
				end

				if self.last_insert and skidmarks[self.last_insert] then
					skidmarks[self.last_insert][2] = tr.HitPos
				end

				tr.HitPos.z = tr.HitPos.z + 1

				self.last_insert = table.insert(skidmarks, {tr.HitPos, tr.HitPos, CurTime() + 5})
			else
				if self.last_insert and skidmarks[self.last_insert] then
					local tr = ET(Pos + Vector(0, 0, 20), Vector(0, 0, -40), MASK_SOLID_BRUSHONLY)

					if not tr.HitWorld then
						self.last_insert = nil

						return
					end

					tr.HitPos.z = tr.HitPos.z + 1
					skidmarks[self.last_insert][2] = tr.HitPos
				end
			end
		else
			self.last_insert = nil
		end
	end

	function ENT:MakeSparks(Scale, Dir, Pos, WheelSize)
		self.NextSpark = self.NextSpark or 0

		if self.NextSpark < CurTime() then
			self.NextSpark = CurTime() + 0.1
			local effectdata = EffectData()
			effectdata:SetOrigin(Pos - Vector(0, 0, WheelSize * 0.5))
			effectdata:SetNormal((Dir + Vector(0, 0, 0.5)) * Scale * 0.5)
			util.Effect("manhacksparks", effectdata, true, true)
		end
	end

	function ENT:Draw()
		return false
	end

	function ENT:OnRemove()
	end

	local mark_size = 5

	hook.Add("PreDrawOpaqueRenderables", "rints!", function()
		if not GetConVar("noire_car_skidmarks"):GetBool() then return end
		if not skidmarks then return end

		for k, v in pairs(skidmarks) do
			local pos, epos, life = v[1], v[2], v[3]

			if epos:DistToSqr(LocalPlayer():GetPos()) > 900000 then
				skidmarks[k] = nil
				continue
			end

			local blend = math.Clamp((life - CurTime()) / 10, 0, 1)

			if blend <= 0 then
				skidmarks[k] = nil
				continue
			else
				local d3 = (epos - pos)
				d3:Normalize()
				d3 = d3:Angle():Right() * mark_size
				render.SetMaterial(mat_tire)
				render.DrawQuad(pos - d3, epos - d3, epos + d3, pos + d3, Color(255, 255, 255, blend * 255))
			end
		end
	end)
end