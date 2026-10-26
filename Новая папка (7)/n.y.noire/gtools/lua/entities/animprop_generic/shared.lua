--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/animprop_generic/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile("shared.lua")
ENT.Base = "base_gmodentity"
ENT.PrintName = "Animated Prop"
ENT.Category = "Animated Props"
ENT.Spawnable = false
ENT.AdminSpawnable = false
ENT.Type = "ai"
ENT.MyAnim = "tiefidget"
ENT.MyPlaybackRate = 1
ENT.DoIHaveEyes = true
ENT.BBoxHeight = 75
ENT.BBoxWidth = 10
ENT.AllowEditing = true
ENT.MyModelScale = 1
ENT.IsPaused = false
ENT.PauseFrame = 0
--ENT.UseCustomBBox	= false
ENT.IsPhysified = false
ENT.ConfirmationID = nil
ENT.StoredAimPitch = 0
ENT.StoredAimYaw = 0
ENT.StoredMoveX = 1
ENT.StoredMoveY = 0
ENT.StoredMoveYaw = 0
ENT.AutomaticFrameAdvance = true

function ENT:SpawnFunction(pl, tr)
	if CLIENT then return end
	if not tr.Hit then return end
	local posSpawn = tr.HitPos
	local angSpawn = tr.HitNormal:Angle()
	angSpawn.p = angSpawn.p + 90
	local ent = ents.Create("animprop_generic")
	ent:SetPos(posSpawn)
	ent:SetAngles(angSpawn)
	ent:SetModel("models/gman_high.mdl")
	ent:Spawn()
	ent:Activate()

	return ent
end

function ENT:Initialize()
	if SERVER then
		local Radius = 2
		local mins = Vector( 1, 1, 1 ) * Radius * -0.5
		local maxs = Vector( 1, 1, 1 ) * Radius * 0.5
		self:PhysicsInitBox( mins, maxs )
		-- self:SetSolid( SOLID_VPHYSICS )
		--self:SetMoveType( MOVETYPE_CUSTOM )

		local CurrentPhys = self:GetPhysicsObject()
		if (CurrentPhys:IsValid()) then
			CurrentPhys:EnableCollisions(false)
			CurrentPhys:EnableMotion(false)
			CurrentPhys:EnableGravity(false)
			CurrentPhys:EnableDrag(false)
			CurrentPhys:Sleep()
			self.wtfprop = true
		end
		--self:SetCollisionGroup( COLLISION_GROUP_VEHICLE_CLIP )

		local EyePos1 = self:GetPos() + Vector(0, 0, 65) + (self:GetAngles():Forward() * 800)

		if EyePos1 then
			self:SetEyeTarget(EyePos1)
		end
	end

	if (self.IsPaused == true) then
		self:ResetSequence(self:LookupSequence(self.MyAnim))
		self:SetCycle(self.PauseFrame)
		self:SetPlaybackRate(0)
		--	else
		--		self:LoopAnimation()
	end

end

hook.Add("PhysgunDrop", "DarkRP.AnimPropshit", function(ply, ent)
	if ent.wtfprop then
		local Phys = ent:GetPhysicsObject()
		if IsValid(Phys) then
			Phys:EnableMotion( false )
		end
	end
end)

function ENT:Think()
	if SERVER and self.IsPhysified == true and self:GetParent():IsValid() then
		if (self:GetModel() ~= self:GetParent():GetModel()) and self:GetParent():GetModel() ~= self:GetParent().MyStoredModel then
			self:SetModel(self:GetParent():GetModel())
			self:GetParent().ConfirmationModel = self:GetParent():GetModel()
			--poseparams have to all be called again because we changed our model
			self:SetPoseParameter("aim_pitch", self.StoredAimPitch)
			self:SetPoseParameter("aim_yaw", self.StoredAimYaw)
			self:SetPoseParameter("body_pitch", self.StoredAimPitch)
			self:SetPoseParameter("body_yaw", self.StoredAimYaw)
			self:SetPoseParameter("move_scale", 1) --for the few models that use this
			self:SetPoseParameter("move_x", self.StoredMoveX)
			self:SetPoseParameter("move_y", self.StoredMoveY)
			self:SetPoseParameter("move_yaw", self.StoredMoveYaw)
		end

		if (self:GetSkin() ~= self:GetParent():GetSkin()) then
			self:SetSkin(self:GetParent():GetSkin())
		end

		self:GetParent().ConfirmationSkin = self:GetParent():GetSkin()
	end

	--if ( self.UseCustomBBox == true ) then
	local cboundMin = self:GetRight() * self.BBoxWidth + self:GetForward() * self.BBoxWidth + self:GetUp() * self.BBoxHeight
	local cboundMax = self:GetRight() * -self.BBoxWidth + self:GetForward() * -self.BBoxWidth
	self:SetCollisionBounds(cboundMin, cboundMax)

	--end
	if SERVER then
		self:SetModelScale(self.MyModelScale, 0)
	end

	if (self.IsPaused == false) then
		self:SetPlaybackRate(self.MyPlaybackRate)
	else
		self:SetPlaybackRate(0)
		--if self:GetCycle() != self.PauseFrame then self:SetCycle(self.PauseFrame) MsgN(self:GetModel() ..": ".. self.PauseFrame .." isn't ".. self:GetCycle()) end
	end

	self:NextThink(CurTime())

	return true
end

function ENT:LoopAnimation()
	local function TimerLoop()
		if CLIENT then return end
		if not self:IsValid() then return end
		self:ResetSequence(self:LookupSequence(self.MyAnim))
		--if self.MyPlaybackRate == nil then return end
		local AnimTime = self:SequenceDuration()

		if AnimTime > 0 then
			if (AnimTime / self.MyPlaybackRate > 1000) then return end
			if (AnimTime / self.MyPlaybackRate == inf) then return end
			timer.Adjust("AnimationPropTimer_" .. self:EntIndex(), AnimTime / self.MyPlaybackRate, 0, TimerLoop)
		else
		end
	end

	if CLIENT then return end
	timer.Create("AnimationPropTimer_" .. self:EntIndex(), 0, 0, TimerLoop)
end

function ENT:OnRemove()
	if SERVER then
		timer.Remove("AnimationPropTimer_" .. self:EntIndex())
	end
end