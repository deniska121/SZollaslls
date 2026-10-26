--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/entities/fire_ladder.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_anim"
ENT.PrintName = "Engine Ladder"
ENT.Spawnable = false
ENT.AutomaticFrameAdvance = true
ENT.AdminSpawnable = false
ENT.DoNotDuplicate = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Open")
	self:NetworkVar("Float", 1, "Climb")
	self:NetworkVar("Float", 2, "Rotate")
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/left4dead/vehicles/ladder01a.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:DrawShadow(false)
		self:SetOpen(0)
		self:SetClimb(0)
		self:SetRotate(0)

		self.DriverSeat = ents.Create("prop_vehicle_prisoner_pod")
		self.DriverSeat:SetMoveType(MOVETYPE_NONE)
		self.DriverSeat:SetModel("models/nova/airboat_seat.mdl")
		self.DriverSeat:SetKeyValue("vehiclescript", "scripts/vehicles/prisoner_pod.txt")
		self.DriverSeat:SetKeyValue("limitview", 0)
		self.DriverSeat:SetPos(self:LocalToWorld(Vector(-59.04,-18.85,-33.5)))
		self.DriverSeat:SetAngles(self:GetAngles() + Angle(0,-90,0))
		self.DriverSeat:SetOwner(self)
		self.DriverSeat:Spawn()
		self.DriverSeat:Activate()
		self.DriverSeat:SetParent(self, 0)

		self.DriverSeat:GetPhysicsObject():EnableDrag(false)
		self.DriverSeat:GetPhysicsObject():EnableMotion(false)
		self.DriverSeat:GetPhysicsObject():SetMass(1)
		self.DriverSeat:SetNW2String("sit_anim", "d3_c17_03_tower_idle")
		self.DriverSeat.base = self
		self.DriverSeat.DoNotDuplicate = true

		self:DeleteOnRemove(self.DriverSeat)
		self.DriverSeat:SetNotSolid(true)
		self.DriverSeat:SetColor(Color(255, 255, 255, 0))
		self.DriverSeat:SetRenderMode(RENDERMODE_TRANSALPHA)
		self.DriverSeat:DrawShadow(false)
	end

	function ENT:Use(ply)
		if not IsValid(self.engine) or not self.engine.fixed_pos then return true end
		if self.lastDT and self.lastDT > CurTime() then return end
		ply:EnterVehicle(self.DriverSeat)
	end

	function ENT:OnRemove()
		if IsValid(self.ladderEnt) then
			self.ladderEnt:Remove()
		end
	end

	function ENT:UpdateSit()
		local att = self:GetBoneMatrix(0)
		local pos = self:WorldToLocal(att:GetTranslation())
		local ang = self:WorldToLocalAngles(att:GetAngles())

		self.DriverSeat:SetPos(pos + ang:Up() * 40 + ang:Forward() * 20 )
		self.DriverSeat:SetAngles(ang + self:LocalToWorldAngles(Angle(0,0,-90)))
		self.engine.usedladder = CurTime() + 1
	end

	function ENT:CollisionForward()
		local ladsp = self:GetAttachment(self:LookupAttachment("start"))
		local ladep = self:GetAttachment(self:LookupAttachment("end"))
		local dir = ladep.Pos - ladsp.Pos
		local cor = dir:Angle():Up() * -20 + dir:Angle():Right() * -2
		local tr = util.TraceLine( {
			start = ladsp.Pos + cor,
			endpos = ladep.Pos + dir:Angle():Forward() * 15 + cor,
			filter = {self, self.engine}
		})
		--DarkRP.UIEffect(nil, "debug", {tr.StartPos, tr.HitPos})
		return tr.Hit
	end

	function ENT:CollisionUp()
		local ladsp = self:GetAttachment(self:LookupAttachment("start"))
		local ladep = self:GetAttachment(self:LookupAttachment("end"))
		local dir = ladep.Pos - ladsp.Pos
		local cor = dir:Angle():Up() * 25
		local tr = util.TraceLine( {
			start = ladsp.Pos + cor,
			endpos = ladep.Pos + dir:Angle():Forward() * 30 + cor,
			filter = {self, self.engine}
		})
		return tr.Hit
	end

	function ENT:CollisionDown()
		local ladsp = self:GetAttachment(self:LookupAttachment("start"))
		local ladep = self:GetAttachment(self:LookupAttachment("end"))
		local dir = ladep.Pos - ladsp.Pos
		local cor = dir:Angle():Up() * -25
		local tr = util.TraceLine( {
			start = ladsp.Pos + cor,
			endpos = ladep.Pos + dir:Angle():Forward() * 30 + cor,
			filter = {self, self.engine}
		})
		return tr.Hit
	end

	function ENT:CollisionRight()
		local ladsp = self:GetAttachment(self:LookupAttachment("start"))
		local ladep = self:GetAttachment(self:LookupAttachment("end"))
		local dir = ladep.Pos - ladsp.Pos
		local cor = dir:Angle():Up() * 15 +  dir:Angle():Right() * 25
		local tr = util.TraceLine( {
			start = ladsp.Pos + cor,
			endpos = ladep.Pos + dir:Angle():Forward() * 15 + cor,
			filter = {self, self.engine}
		})
		return tr.Hit
	end

	function ENT:CollisionLeft()
		local ladsp = self:GetAttachment(self:LookupAttachment("start"))
		local ladep = self:GetAttachment(self:LookupAttachment("end"))
		local dir = ladep.Pos - ladsp.Pos
		local cor = dir:Angle():Up() * 15 +  dir:Angle():Right() * -25
		local tr = util.TraceLine( {
			start = ladsp.Pos + cor,
			endpos = ladep.Pos + dir:Angle():Forward() * 15 + cor,
			filter = {self, self.engine}
		})
		return tr.Hit
	end

	function ENT:Think()
		self:SetPoseParameter("open", self:GetOpen())
		self:SetPoseParameter("climb", self:GetClimb())
		self:SetPoseParameter("rotate", self:GetRotate())
		self:NextThink(CurTime())

		if not IsValid(self.engine) then return true end

		if (not self.lastDT or self.lastDT < CurTime()) and IsValid(self.DriverSeat) and IsValid(self.DriverSeat:GetDriver()) then

			local ply = self.DriverSeat:GetDriver()
			self.od = ply
			if self.engine.EngineRPM <= 0 then return true end

			if IsValid(self.ladderEnt) then
				self.ladderEnt:Remove()
			end

			self.lastDT = CurTime() + 0.1

			if ply:KeyDown(IN_ATTACK) then
				if self:CollisionForward() then return end
				self:SetOpen(math.Clamp(self:GetOpen() + 0.01, 0, 1))
				self.engine.usedladder = CurTime() + 1
			elseif ply:KeyDown(IN_ATTACK2) then
				self:SetOpen(math.Clamp(self:GetOpen() - 0.01, 0, 1))
				self.engine.usedladder = CurTime() + 1
			end

			if ply:KeyDown(IN_FORWARD) then
				if self:CollisionUp() then return end
				self:SetClimb(math.Clamp(self:GetClimb() + 0.01, 0, 1))
				self.engine.usedladder = CurTime() + 1
			elseif ply:KeyDown(IN_BACK) then
				if self:CollisionDown() then return end
				self:SetClimb(math.Clamp(self:GetClimb() - 0.01, 0, 1))
				self.engine.usedladder = CurTime() + 1
			end

			if ply:KeyDown(IN_MOVERIGHT) then
				if self:CollisionRight() then return end
				self:SetRotate(math.Clamp(self:GetRotate() + 0.003, -1, 1))
				self:UpdateSit()
			elseif ply:KeyDown(IN_MOVELEFT) then
				if self:CollisionLeft() then return end
				self:SetRotate(math.Clamp(self:GetRotate() - 0.003, -1, 1))
				self:UpdateSit()
			end

			if ply:KeyDown(IN_RELOAD) then
				if self:GetRotate() > 0 then
					if self:CollisionRight() then return end
					self:SetRotate(math.max(self:GetRotate() - 0.003, 0))
					self:UpdateSit()
				else
					if self:CollisionLeft() then return end
					self:SetRotate(math.min(self:GetRotate() + 0.003, 0))
					self:UpdateSit()
				end
			end
		end

		if not IsValid(self.DriverSeat:GetDriver()) and self.od then
			self.od = nil
			if IsValid(self.ladderEnt) then
				self.ladderEnt:Remove()
			end

			if self:GetOpen() == 0 and self:GetRotate() == 0 and self:GetClimb() == 0 then return true end
			self:EmitSound("vehicles/crane/crane_magnet_release.wav")
			local ladsp = self:GetAttachment(self:LookupAttachment("start"))
			local ladep = self:GetAttachment(self:LookupAttachment("end"))
			local ladderStartPos = ladsp.Pos
			local ladderEndPos = ladep.Pos

			self.ladderEnt = ents.Create("func_useableladder")
			self.ladderEnt:SetPos(ladderStartPos)
			self.ladderEnt:SetAngles(self:GetAngles())
			self.ladderEnt:SetKeyValue("point0", tostring(ladderStartPos))
			self.ladderEnt:SetKeyValue("point1", tostring(ladderEndPos))
			self.ladderEnt:Spawn()
			self.ladderEnt:Activate()
		end

		return true
	end
end



if CLIENT then
	function ENT:OnActiveMove(play)
		if self.lastsound and self.lastsound > CurTime() then return end

		if not play then
			if self.sound then
				self.sound:ChangeVolume(0, 0.1)
			end
			return
		end

		if play then self.lastsound = CurTime() + 0.1 end

		if not self.sound then
			self.sound = CreateSound(self, "vehicles/crane/crane_magnet_grab.wav")
			self.sound:PlayEx(0, 100)
			self.sound:ChangeVolume(0.3, 0.1)
		else
			self.sound:ChangeVolume(0.3, 0.1)
		end
	end

	function ENT:Think()
		if not self.open then self.open = self:GetOpen() end
		if not self.climb then self.climb = self:GetClimb() end
		if not self.rotate then self.rotate = self:GetRotate() end

		if self.open ~= self:GetOpen() then
			self.open = math.Approach(self.open, self:GetOpen(), FrameTime() * 0.1)
			self:OnActiveMove(true)
		end
		if self.climb ~= self:GetClimb() then
			self.climb = math.Approach(self.climb, self:GetClimb(), FrameTime() * 0.1)
			self:OnActiveMove(true)
		end
		if self.rotate ~= self:GetRotate() then
			self.rotate = math.Approach(self.rotate, self:GetRotate(), FrameTime() * 0.03)
			self:OnActiveMove(true)
		end

		self:OnActiveMove(false)

		self:SetPoseParameter("open", self.open)
		self:SetPoseParameter("climb", self.climb)
		self:SetPoseParameter("rotate", self.rotate)
	end

	function ENT:OnRemove()
		if self.sound then
			self.sound:Stop()
		end
	end
end