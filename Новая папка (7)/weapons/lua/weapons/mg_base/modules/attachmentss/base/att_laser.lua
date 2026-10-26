-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\base\\att_laser.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_base"
ATTACHMENT.Name = "Default"
ATTACHMENT.Category = "ЛЦУ"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:RemoveFlashlightStuffFromModel(flashModel)
	if (IsValid(flashModel)) then
		if (flashModel.mw_flashlightProjTexture ~= nil) then
			flashModel.mw_flashlightProjTexture:Remove()
		end

		if (flashModel.mw_flashlightParticle ~= nil and IsValid(flashModel.mw_flashlightParticle)) then
			flashModel.mw_flashlightParticle:StopEmissionAndDestroyImmediately()
		end
	end
end

function ATTACHMENT:DoLaserRender(weapon, laserModel)
	if not weapon:GetLaserIsOn() then return end

	local att = laserModel:GetAttachment(laserModel:LookupAttachment(self.Laser.Attachment))

	local tr = util.TraceLine({
		start = att.Pos + att.Ang:Forward() * -10,
		endpos = att.Pos + att.Ang:Forward() * 1000,
		filter = {weapon, weapon:GetOwner()},
		mask = MASK_SHOT
	})

	if tr.HitSky then return end

	if (laserModel.mw_laserTrailPos == nil) then
		laserModel.mw_laserTrailPos = tr.HitPos
	end

	local distSq = tr.HitPos:DistToSqr(att.Pos)
	local beamDelta = math.Clamp(distSq / (self.Laser.BeamSize * self.Laser.BeamSize), 0, 1)
	local color = self.Laser.Color

	render.SetMaterial(self.Laser.BeamMaterial)
	render.DrawBeam(att.Pos, att.Pos + att.Ang:Forward() * (beamDelta * self.Laser.BeamSize), self.Laser.BeamWidth * math.random(0.5, 1), 0, 0.95, color)

	local pos = tr.HitPos * 1

	weapon:SafeLerpVector(0, pos, EyePos() + EyeAngles():Forward() * 300)
	local normal = tr.HitNormal * 1

	local sens = Lerp(0, 50, 150)
	weapon:SafeLerpVector(math.min(sens * FrameTime(), 1), laserModel.mw_laserTrailPos, pos)

	render.SetMaterial(self.Laser.DotMaterial)
	render.DrawQuadEasy(pos, normal, self.Laser.DotSize, self.Laser.DotSize, color, math.random(179, 180))
	render.DrawBeam(laserModel.mw_laserTrailPos, pos, self.Laser.DotSize * 0.8, 0, 0.5, color)
end

function ATTACHMENT:DrawFlashlight(weapon, model)
	if (self.Flashlight == nil) then return end

	if (not weapon:GetFlashlight() or weapon:GetOwner():FlashlightIsOn() or weapon:GetIsHolstering()) then
		self:RemoveFlashlightStuffFromModel(model)

		return
	end

	local attId = model:LookupAttachment(self.Flashlight.Attachment)
	local att = model:GetAttachment(attId)

	if (not IsValid(model.mw_flashlightParticle)) then
		model.mw_flashlightParticle = CreateParticleSystem(model, "flashlight_mw19", PATTACH_POINT_FOLLOW, attId)
		model.mw_flashlightParticle:StartEmission()
	end

	local particle = model.mw_flashlightParticle
	particle:SetShouldDraw(false)
	particle:SetControlPoint(1, att.Pos)
	particle:SetControlPointOrientation(1, att.Ang:Forward(), att.Ang:Right(), att.Ang:Up())
	particle:Render()
	if (model == self.m_TpModel) then return end

	if (not IsValid(model.mw_flashlightProjTexture)) then
		model.mw_flashlightProjTexture = ProjectedTexture()
	end

	local proj = model.mw_flashlightProjTexture
	proj:SetPos(att.Pos + att.Ang:Forward() * -3)
	proj:SetAngles(att.Ang)
	proj:SetFOV(50)
	proj:SetFarZ(900)
	proj:SetBrightness(0.3)
	proj:SetTexture(self.Flashlight.FlashlightMaterial:GetTexture("$basetexture"))
	proj:Update()
end

local bDrewViewModel = false

function ATTACHMENT:Render(weapon, model)
	self:DoLaserRender(weapon, model)
	self:DrawFlashlight(weapon, model)

	if (model == self.m_Model) then
		bDrewViewModel = true
	end

	if (model == self.m_TpModel) then
		if (not bDrewViewModel) then
			self:RemoveFlashlightStuffFromModel(self.m_Model)
		end

		bDrewViewModel = false
	end
end

function ATTACHMENT:OnRemove(weapon)
	if (CLIENT) then
		self:RemoveFlashlightStuffFromModel(self.m_Model)
		self:RemoveFlashlightStuffFromModel(self.m_TpModel)
	end

	BaseClass.OnRemove(self, weapon)
end