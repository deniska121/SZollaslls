--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/base/att_optic.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_sight_reticle"
if (SERVER) then return end
ATTACHMENT._RTTexture = GetRenderTarget("mw19_rt", 512, 512)
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)
local ParallaxMaterial = Material("mw19_parallax.vmt")
local RefractTintMaterial = Material("mw19_refracttint.vmt")

local function util_NormalizeAngles(a)
	a.p = math.NormalizeAngle(a.p)
	a.y = math.NormalizeAngle(a.y)
	a.r = math.NormalizeAngle(a.r)

	return a
end

function ATTACHMENT:Init(weapon)
	BaseClass.Init(self, weapon)
	self.hideModel = ClientsideModel(self.Optic.HideModel, weapon.RenderGroup)
	self.hideModel:SetMoveType(MOVETYPE_NONE)
	self.hideModel:SetNoDraw(true)
end

function ATTACHMENT:OnRemove(weapon)
	BaseClass.OnRemove(self, weapon)
	if not IsValid(self.hideModel) then return end
	self.hideModel:Remove()
end

function ATTACHMENT:Render(weapon, model)
	local bCanRemoveBodygroup = weapon:GetAimModeDelta() < 0.5 and weapon:GetAimDelta() > 0.9
	self.m_Model:SetBodygroup(self.m_Model:FindBodygroupByName(self.Optic.LensBodygroup), bCanRemoveBodygroup and 0 or 1)

	if (not bCanRemoveBodygroup) then
		self.m_Model:DrawModel()

		return
	end

	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilPassOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(MWBASE_STENCIL_REFVALUE + 2)
	render.SetStencilCompareFunction(STENCIL_NEVER)
	render.SetStencilFailOperation(STENCIL_REPLACE)
	--dirty and quick way to make it work with velements and bonemerged
	self.m_Model:SetupBones()
	self.m_Model:InvalidateBoneCache()
	local matrix = self.m_Model:GetBoneMatrix(0)
	self.hideModel:SetPos(matrix:GetTranslation())
	self.hideModel:SetAngles(matrix:GetAngles())
	self.hideModel:DrawModel()
	render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
	render.SetStencilFailOperation(STENCIL_KEEP)
	self.m_Model:DrawModel()
	render.SetStencilCompareFunction(STENCIL_EQUAL)
	render.SetStencilFailOperation(STENCIL_KEEP)

	if (self.Optic.Thermal) then
		self:DrawThermal(weapon)
	end

	render.SetStencilEnable(false)
	render.ClearStencil()
	------------------------------
	self:DoReticleStencil(self.hideModel, self.Reticle, weapon)
	------------------------------
	local att = self.m_Model:GetAttachment(self.m_Model:LookupAttachment(self.Reticle.Attachment))
	render.PushRenderTarget(self._RTTexture, 0, 0, 1024, 1024)
	cam.Start2D()
	render.Clear(0, 0, 0, 0)
	--REFTINT:
	local tintSize = 400
	surface.SetMaterial(RefractTintMaterial)
	surface.SetDrawColor(0, 0, 0, 255)

	for i = 1, 2 do
		surface.DrawTexturedRect(tintSize * -0.5, tintSize * -0.5, ScrW() + tintSize, ScrH() + tintSize)
	end

	--if (not self.Optic.Thermal) then
	self:DrawParallax(weapon, att.Ang)
	--end
	cam.End2D()
	render.PopRenderTarget()
	self.Optic.LensHideMaterial:SetTexture("$basetexture", self._RTTexture)
end

local ThermalNoiseMaterial = Material("mw19_thermalnoise.vmt")
local sunMaterial = Material("mg/cursorglow")

local function drawEnt(ent)
	if (ent:GetNoDraw()) then return end
	ent:DrawModel()
end

function ATTACHMENT:DrawThermal(weapon)
	local backgroundColor = self.Optic.ThermalBackgroundColor or Color(50, 50, 50, 240)
	local bodyColor = self.Optic.ThermalBodiesColor or Color(255, 255, 255, 150)
	cam.Start2D()
	surface.SetDrawColor(backgroundColor.r, backgroundColor.g, backgroundColor.b, backgroundColor.a)
	surface.DrawRect(0, 0, ScrW(), ScrH())
	local sun = util.GetSunInfo()

	if (sun ~= nil and sun.obstruction > 0) then
		local pos = EyePos() + sun.direction * 4096
		pos = pos:ToScreen()
		local alpha = 255 * sun.obstruction
		local sunSize = 1024
		surface.SetMaterial(sunMaterial)
		surface.SetDrawColor(bodyColor.r, bodyColor.g, bodyColor.b, alpha)
		surface.DrawTexturedRect(pos.x - (sunSize * 0.5), pos.y - (sunSize * 0.5), sunSize, sunSize)
	end

	surface.SetMaterial(ThermalNoiseMaterial)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(ScrW() * 0.25, ScrH() * 0.25, ScrW() * 0.5, ScrH() * 0.5)
	cam.End2D()
	render.SetStencilPassOperation(STENCILOPERATION_INCR)
	render.SetBlend(0)
	drawEnt(weapon:GetOwner():GetHands())
	cam.Start3D()

	for i, e in pairs(ents.GetAll()) do
		if (e:IsNPC() or e:IsPlayer() or e:IsNextBot() or (e:GetClass() == "prop_ragdoll" and string.find(e:GetModel(), "cityrp"))) then
			--if (e:Health() <= 0) then continue end
			drawEnt(e)
		end
	end

	cam.End3D()
	render.SetBlend(1)
	render.SetStencilCompareFunction(STENCIL_LESS)
	cam.Start2D()
	surface.SetDrawColor(bodyColor.r, bodyColor.g, bodyColor.b, bodyColor.a)
	surface.DrawRect(0, 0, ScrW(), ScrH())
	cam.End2D()
	render.SetStencilEnable(false)
	render.ClearStencil()
end

function ATTACHMENT:DrawParallax(weapon, ang)
	--free aim: the gun is tilted down by the aim pitch offset, so reference the parallax against the
	--lowered aim direction. This keeps the reticle centred in the lens (on the green crosshair)
	--instead of the parallax flinging it off by offset*100 px.
	local eyeRef = EyeAngles()
	eyeRef.p = eyeRef.p + weapon:GetAimPitchOffsetCL() * weapon:GetAD()
	ang:Sub(eyeRef)
	local angDif = util_NormalizeAngles(ang) * 100
	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(MWBASE_STENCIL_REFVALUE + 2)
	local pSize = self.Optic.ParallaxSize - (weapon.Camera.Shake * 200)
	surface.SetMaterial(ParallaxMaterial)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(ScrW() * -0.5 - pSize * 0.5 - angDif.y, ScrH() * -0.5 - pSize * 0.5 + angDif.p, ScrW() * 2 + pSize, ScrH() * 2 + pSize)
	render.SetStencilCompareFunction(STENCIL_NOTEQUAL)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawRect(0, 0, ScrW(), ScrH())
	render.SetStencilEnable(false)
	render.ClearStencil()
end