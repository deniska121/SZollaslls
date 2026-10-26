-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\client\\cl_anim_think.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

local poseparameters = {
	aim_offset = "aim_offset",
	firemode_offset = "firemode_offset",
	jog_offset = "jog_offset",
	jog_loop = "jog_loop",
	walk_loop = "walk_loop",
	freefall_loop = "freefall_loop",
	empty_offset = "empty_offset",
	sprint_loop = "sprint_loop",
	hybrid_offset = "hybrid_offset"
}

local lerpAimDelta = 0

SWEP.InspectAnimList = {
	["Inspect"] = true,
	["Inspect_empty"] = true,
	["Inspect_end"] = true,
	["Equip"] = true
}

function SWEP:AnimThinkModule()
	--cant sync on the server yet, so for now its just client doing this
	if (not IsValid(self.m_ViewModel)) then return end
	self.m_ViewModel:SetPoseParameter(poseparameters.hybrid_offset, self:GetAimMode())
	lerpAimDelta = self:SafeLerp(30 * FrameTime(), lerpAimDelta, self:GetAimDelta())

	--next sequence
	if (self.Animations[self.m_nextSeqIndex] and not self.Animations[self.m_seqIndex].Reverced and self.m_ViewModel:GetCycle() and self.m_ViewModel:GetCycle() > 0.98) then
		self:PlayViewModelAnimation(self.m_nextSeqIndex)
	end


	if (self.Animations[self.m_nextSeqIndex] and self.Animations[self.m_seqIndex].Reverced and self.m_ViewModel:GetCycle() and self.m_ViewModel:GetCycle() < self.Animations[self.m_nextSeqIndex].StartCycle) then
		self:PlayViewModelAnimation(self.m_nextSeqIndex)
	end

	--movement animations
	self.m_ViewModel:SetPoseParameter(poseparameters.aim_offset, lerpAimDelta)
	self.m_ViewModel:SetPoseParameter(poseparameters.firemode_offset, self:GetFiremode() - 1)
	local velVector = Vector(self:GetOwner():GetVelocity().x, self:GetOwner():GetVelocity().y, 0)
	local vel = math.max(velVector:Length(), 0.1)
	local limit = self:GetOwner():GetWalkSpeed()
	local delta = vel / limit

	if (not self:GetOwner():IsOnGround()) then
		self.ViewModelVars.LerpJogOffset = Lerp(4 * FrameTime(), self.ViewModelVars.LerpJogOffset, 0)
	else
		self.ViewModelVars.LerpJogOffset = Lerp(10 * FrameTime(), self.ViewModelVars.LerpJogOffset, delta)
	end

	self.m_ViewModel:SetPoseParameter(poseparameters.jog_offset, self.ViewModelVars.LerpJogOffset * math.max(1 - lerpAimDelta * 2, 0))
	local jogDelta = 0
	local walkDelta = 0
	self.ViewModelVars.bJogging = false

	if (self:GetOwner():IsOnGround()) then
		if (vel <= self:GetOwner():GetSlowWalkSpeed() * 1.1) then
			walkDelta = math.min(vel / self:GetOwner():GetSlowWalkSpeed(), 1)
		else
			jogDelta = math.min(vel / self:GetOwner():GetWalkSpeed(), 1)
			self.ViewModelVars.bJogging = true
		end

		walkDelta = math.min(walkDelta + math.abs(self.ViewModelVars.Sway.X.Lerp) * 0.2, 1)
	end

	self.ViewModelVars.LerpJog = Lerp(5 * FrameTime(), self.ViewModelVars.LerpJog, jogDelta)
	self.ViewModelVars.LerpWalk = Lerp(5 * FrameTime(), self.ViewModelVars.LerpWalk, walkDelta)
	self.m_ViewModel:SetPoseParameter(poseparameters.jog_loop, self.ViewModelVars.LerpJog * Lerp(lerpAimDelta, 1, 0.1))
	self.m_ViewModel:SetPoseParameter(poseparameters.walk_loop, self.ViewModelVars.LerpWalk * Lerp(lerpAimDelta, 1, 0.2))

	if (self.m_seqIndex == "Idle" and lerpAimDelta <= 0) and (self.ViewModelVars.bWasJogging ~= self.ViewModelVars.bJogging) then
		local bJogging = self.ViewModelVars.bJogging

		if (not bJogging and self:GetOwner():IsOnGround()) then
			self:PlayViewModelAnimation("Jog_Out")
		end
	end

	self.ViewModelVars.bWasJogging = self.ViewModelVars.bJogging

	--crouch test
	if (self.m_seqIndex == "Idle" and lerpAimDelta <= 0) and (self.ViewModelVars.bWasCrouching ~= self:GetOwner():Crouching()) and (self:GetOwner():IsOnGround()) then
		self:PlayViewModelAnimation("Jog_Out")
	end

	self.ViewModelVars.bWasCrouching = self:GetOwner():Crouching()
	--freefall loop
	local z = math.min(self:GetOwner():GetVelocity().z, 0)
	delta = math.min(math.min(z + 500, 0) / -1100, 1)
	self.m_ViewModel:SetPoseParameter(poseparameters.freefall_loop, delta * Lerp(lerpAimDelta, 1, 0.1))
	--empty
	self.m_ViewModel:SetPoseParameter(poseparameters.empty_offset, (self:Clip1() <= 0 or self:GetMalfunction() or (self.Animations.Rechamber and not self:GetHasPumped())) and 1 or 0)

	--jump/land
	if ((self.m_seqIndex == "Idle" or self.m_seqIndex == "Jump" or self.m_seqIndex == "Land" or self.m_seqIndex == "Jog_Out") and self:GetAimDelta() <= 0) and (self.ViewModelVars.bWasOnGroundAnim ~= self:GetOwner():IsOnGround()) then
		local bOnGround = self:GetOwner():IsOnGround()

		if (not bOnGround) then
			self:PlayViewModelAnimation("Jump")
		else
			self:PlayViewModelAnimation("Land")
		end
	end

	self.ViewModelVars.bWasOnGroundAnim = self:GetOwner():IsOnGround()

	if (self:GetIsSprinting() and self:GetOwner():WaterLevel() <= 2) then
		local target = math.Clamp(vel / self:GetOwner():GetWalkSpeed(), 0.001, 1)
		local speed = 5

		if (not self:GetOwner():IsOnGround()) then
			target = 0.01
		end

		if (self:GetSafety() and not self:GetOwner():KeyDown(IN_SPEED)) then
			target = target * 0.3
		end

		local lerp = Lerp(speed * FrameTime(), self.m_ViewModel:GetPoseParameter(poseparameters.sprint_loop) or 0, target)
		self.m_ViewModel:SetPoseParameter(poseparameters.sprint_loop, lerp)
	else
		local lerp = Lerp(5 * FrameTime(), self.m_ViewModel:GetPoseParameter(poseparameters.sprint_loop) or 0, 0)
		self.m_ViewModel:SetPoseParameter(poseparameters.sprint_loop, lerp)
	end

	if (self:IsCustomizing() and self.InspectAnimList[self.m_seqIndex] and not self.Animations[self.m_seqIndex].Reverced and self.m_ViewModel:GetCycle() > (self.FreezeInspectDelta or 0.15)) then
		local cos = math.cos(CurTime() * 3) * 0.25
		self.ViewModelVars.LerpCustomizationPlayback = Lerp(4 * FrameTime(), self.ViewModelVars.LerpCustomizationPlayback, cos)
	elseif self.Animations[self.m_seqIndex] and self.Animations[self.m_seqIndex].Reverced then
		self.ViewModelVars.LerpCustomizationPlayback = Lerp(4 * FrameTime(), self.ViewModelVars.LerpCustomizationPlayback, -1)
	else
		self.ViewModelVars.LerpCustomizationPlayback = Lerp(4 * FrameTime(), self.ViewModelVars.LerpCustomizationPlayback, 1)
	end

	if self.InspectAnimList[self.m_seqIndex] then
		self.m_ViewModel:SetPlaybackRate(self.ViewModelVars.LerpCustomizationPlayback)
	end

	--grips
	if (self.GripPoseParameters ~= nil) then
		for i, pp in pairs(self.GripPoseParameters) do
			self.m_ViewModel:SetPoseParameter(pp, 0)
		end

		self.GripPoseParameter.Lerp = math.Approach(self.GripPoseParameter.Lerp, self.GripPoseParameter.Target, 20 * FrameTime())

		if (self.GripPoseParameter.PoseParameter ~= nil) then
			self.m_ViewModel:SetPoseParameter(self.GripPoseParameter.PoseParameter, self.GripPoseParameter.Lerp)
		end
	end

	if (self.GripPoseParameters2 ~= nil) then
		for i, pp in pairs(self.GripPoseParameters2) do
			self.m_ViewModel:SetPoseParameter(pp, 0)
		end

		self.GripPoseParameter2.Lerp = math.Approach(self.GripPoseParameter2.Lerp, self.GripPoseParameter2.Target, 20 * FrameTime())

		if (self.GripPoseParameter2.PoseParameter ~= nil) then
			self.m_ViewModel:SetPoseParameter(self.GripPoseParameter2.PoseParameter, self.GripPoseParameter2.Lerp)
		end
	end

	--smoke
	if self:IsCarriedByLocalPlayer() and not self:GetOwner():ShouldDrawLocalPlayer() and self.BarrelSmoke ~= nil then
		local data = self.m_SmokeData

		if (CurTime() > self:LastShootTime() + 0.1)  then
			if (data.Current >= self.BarrelSmoke.TemperatureThreshold and not data.bHasTriggered) then
				self:DoParticle(self.BarrelSmoke.Particle, self.BarrelSmoke.Attachment)
				data.bHasTriggered = true
			end

			data.Current = math.max(data.Current - (self.BarrelSmoke.TemperatureCooldown * FrameTime()), 0)

			if (data.Current < self.BarrelSmoke.TemperatureThreshold) then
				data.bHasTriggered = false
			end
		end
	end
end

local function invalidateBoneCacheForParticles(ent)
	while (IsValid(ent)) do
		if (ent:IsEffectActive(EF_BONEMERGE) or not IsValid(ent:GetParent())) then
			ent:InvalidateBoneCache()
		end

		ent = ent:GetParent()
	end
end

function SWEP:DoParticle(particleName, attName)
	if self.bannedParticte and self.bannedParticte == attName then
		return
	end

	if (self.ParticleEffects ~= nil and self.ParticleEffects[particleName] ~= nil) then
		particleName = self.ParticleEffects[particleName]
	end

	if self.Particles[particleName] ~= nil and IsValid(self.Particles[particleName]) then
		self.Particles[particleName]:StopEmissionAndDestroyImmediately()
		self.Particles[particleName] = nil
	end

	if self.TpParticles[particleName] ~= nil and IsValid(self.TpParticles[particleName]) then
		self.TpParticles[particleName]:StopEmissionAndDestroyImmediately()
		self.TpParticles[particleName] = nil
	end

	local ent, attid = self:FindAttachmentInChildren(self.m_ViewModel, attName)
	local effect = CreateParticleSystem(ent, particleName, PATTACH_POINT_FOLLOW, attid)

	if IsValid(effect) then
		effect:StartEmission()
		effect:SetIsViewModelEffect(true)
		effect:SetShouldDraw(false)
		self.Particles[particleName] = effect
		invalidateBoneCacheForParticles(ent)
	end

	ent, attid = self:FindAttachmentInChildren(self.m_WorldModel, attName)
	effect = CreateParticleSystem(ent, particleName, PATTACH_POINT_FOLLOW, attid)
	if IsValid(effect) then
		effect:StartEmission()
		effect:SetIsViewModelEffect(false)
		effect:SetShouldDraw(false)
		self.TpParticles[particleName] = effect
		invalidateBoneCacheForParticles(ent)
	end
end

function SWEP:DoSound(soundName)
	if self:GetOwner() ~= LocalPlayer() then return end
	self:GetOwner():EmitSound(soundName)
end

function SWEP:DoSpatialSound(soundName, position)
	local ang = self:GetOwner():EyeAngles()
	sound.Play(soundName, self:GetOwner():EyePos() + ang:Forward() * position.y + ang:Right() * position.x + ang:Up() * position.z)
end

function SWEP:DoEjection(attName)
end

function SWEP:AnimationEvents()
	if (self:GetOwner() == NULL) then return end
	if not IsValid(self.m_ViewModel) then return end

	if (self.Animations[self.m_seqIndex] and self.Animations[self.m_seqIndex].Events) then
		local events = self.Animations[self.m_seqIndex].Events
		local cycle = self.m_ViewModel:GetCycle()
		local len = self.m_ViewModel:SequenceDuration()

		for i, event in pairs(events) do
			if event.m_bFired then continue end
			local delta = math.min(event.Time / len, 1)

			if cycle and (cycle >= delta) then
				if not event.m_bFired and event.Callback then
					event.Callback(self)
				end

				event.m_bFired = true
			end
		end
	end
end

function SWEP:SetViewModelCycle(cycle)
	if not IsValid(self.m_ViewModel) then return end

	if (self.Animations[self.m_seqIndex] and self.Animations[self.m_seqIndex].Events) then
		local events = self.Animations[self.m_seqIndex].Events
		local len = self.m_ViewModel:SequenceDuration()

		for i, event in pairs(events) do
			local delta = math.min(event.Time / len, 1)

			if (cycle > delta) then
				event.m_bFired = true
			end
		end
	end

	self.m_ViewModel:SetCycle(cycle)
end

function SWEP:RenderParticles(particles)
	for i, particle in pairs(particles) do
		if (not particle:IsValid()) then
			particles[i] = nil
			continue
		end

		particle:Render()
	end
end

function SWEP:FindAttachmentInChildren(ent, att)
	-- first pass only for nonbonemerged things
	for slot, attachment in pairs(self:GetAllAttachmentsInUse()) do
		if (attachment.Model == nil) then continue end
		local model = ent == self.m_ViewModel and attachment.m_Model or attachment.m_TpModel
		if (not IsValid(model)) then continue end
		if (model:GetParent() == ent) then continue end
		local childAtt = model:LookupAttachment(att)
		if (childAtt > 0) then return model, childAtt end
	end

	--second pass for bonemerged things
	for slot, attachment in pairs(self:GetAllAttachmentsInUse()) do
		if (attachment.Model == nil) then continue end
		local model = ent == self.m_ViewModel and attachment.m_Model or attachment.m_TpModel
		if (not IsValid(model)) then continue end
		if (model:GetParent() ~= ent) then continue end
		local childAtt = model:LookupAttachment(att)
		if (childAtt > 0) then return model, childAtt end
	end

	return ent, ent:LookupAttachment(att)
end