--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/attachmentss/base/att_sight_reticle.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ATTACHMENT.Base = "att_sight"
ATTACHMENT.RenderOverride = true --allows you to control when to draw att's model
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.DontHide = true
	weapon.opticZoom = true
end

function ATTACHMENT:OnRemove(weapon)
	BaseClass.OnRemove(self, weapon)
	if not IsValid(self.hideModel) then return end
	self.hideModel:Remove()
	weapon.opticZoom = false
end

function ATTACHMENT:Render(weapon)
	self:DoReticleStencil(self.m_Model, self.Reticle, weapon)
end
local ParallaxMaterial = Material("mw19_parallax.vmt")
function ATTACHMENT:DoReticleStencil(model, ret, weapon)
	if IsValid(GetViewEntity()) and (CurTime() < GetViewEntity():GetNWFloat("MW19_EMPEffect", CurTime())) then
		model:DrawModel()

		return
	end

	render.SetStencilWriteMask(0xFF)
	render.SetStencilTestMask(0xFF)
	render.SetStencilReferenceValue(0)
	render.SetStencilCompareFunction(STENCIL_ALWAYS)
	render.SetStencilPassOperation(STENCIL_REPLACE)
	render.SetStencilFailOperation(STENCIL_KEEP)
	render.SetStencilZFailOperation(STENCIL_KEEP)
	render.SetStencilEnable(true)
	render.SetStencilReferenceValue(MWBASE_STENCIL_REFVALUE + 1)
	model:DrawModel()
	render.SetStencilCompareFunction(STENCIL_EQUAL)
	local att = self.m_Model:GetAttachment(self.m_Model:LookupAttachment(ret.Attachment))
	local size = ret.Size
	local color = ret.Color
	render.SetMaterial(ret.Material)
	--i don't know which one is faster, but the second one has a roll option
	--render.DrawSprite(att.Pos + att.Ang:Forward() * 100, size * 0.01, size * 0.01, color)
	local offset = att.Ang:Forward() * 100

	if (ret.Offset ~= nil) then
		offset = offset + att.Ang:Right() * ret.Offset.x
		offset = offset + att.Ang:Up() * ret.Offset.y
	end

	render.DrawQuadEasy(att.Pos + offset, att.Ang:Forward():GetNegated(), size * 0.01, size * 0.01, color, -att.Ang.r + 180)

	if ret.Parallaxing then
		render.SetMaterial(ParallaxMaterial)
		render.DrawQuadEasy(att.Pos + offset * 2, att.Ang:Forward():GetNegated(), ret.Parallaxing * 0.06, ret.Parallaxing * 0.06, color_black, -att.Ang.r + 180)
	end
	render.SetStencilEnable(false)
	render.ClearStencil()
end