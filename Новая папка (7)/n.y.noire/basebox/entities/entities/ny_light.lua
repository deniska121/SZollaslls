--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/entities/ny_light.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
DEFINE_BASECLASS("base_anim")
ENT.PrintName = "Лампа"

function ENT:Initialize()
	if (CLIENT) then
		self.PixVis = util.GetPixelVisibleHandle()
	end

	if (SERVER) then
		self:SetModel("models/props/de_inferno/ceiling_light.mdl")
		self:SetSubMaterial(0, "models/props_c17/metalladder001")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(false)
		local phys = self:GetPhysicsObject()

		if (IsValid(phys)) then
			phys:EnableMotion(false)
		end
	end
end

function ENT:OnTakeDamage(dmginfo)
	self:TakePhysicsDamage(dmginfo)
end

function ENT:Toggle()
	self:SetSkin(self:GetSkin() == 1 and 0 or 1)
end

local c = Color(255, 211, 146)

function ENT:Think()
	self.BaseClass.Think(self)

	if (CLIENT) then
		if self:GetSkin() ~= 0 then return end
		local dlight = DynamicLight(self:EntIndex(), false)

		if (dlight) then
			dlight.Pos = self:GetPos() - self:GetAngles():Up() * 20
			dlight.r = c.r
			dlight.g = c.g
			dlight.b = c.b
			dlight.Brightness = 1
			dlight.Decay = 400 * 5
			dlight.Size = 400
			dlight.DieTime = CurTime() + 1
		end
	end
end

function ENT:GetOverlayText()
	return self:GetPlayerName()
end

local matLight = Material("sprites/light_ignorez")

function ENT:DrawEffects()
	if self:GetSkin() ~= 0 then return end
	local LightPos = self:GetPos()
	local Visibile = util.PixelVisible(LightPos, 4, self.PixVis)
	if (not Visibile or Visibile < 0.1) then return end
	local up = self:GetAngles():Up()
	render.SetMaterial(matLight)
	render.DrawSprite(LightPos - up * 7, 64, 64, Color(c.r, c.g, c.b, 64))
end

ENT.RenderGroup = RENDERGROUP_BOTH

function ENT:DrawTranslucent(flags)
	BaseClass.DrawTranslucent(self, flags)
	self:DrawEffects()
end