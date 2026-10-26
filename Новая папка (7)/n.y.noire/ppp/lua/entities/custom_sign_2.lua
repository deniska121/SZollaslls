--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/custom_sign_2.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_edit"
ENT.PrintName = "SignUrl small"
ENT.Author = "Mac"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Url", { KeyName = "url", Edit = { type = "String", order = 1 } })
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props/de_tides/menu_stand.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetMaterial("models/gibs/metalgibs/metal_gibs")
		local phys = self:GetPhysicsObject()
		phys:EnableMotion(false)

		self:SetUrl("https://i.imgur.com/kfbmRr9.png")
	end
	return
end

function ENT:Draw()
	self:DrawModel()

	if not DarkRP.InRange(LocalPlayer(), self, 2900) then return end

	if not self.frame then
		self.frame = vgui.Create("DPanel")
		self.frame:SetSize(187, 264)
		self.frame.url = self:GetUrl()
		self.frame:SetPaintedManually(true)

		self.frame.Paint = function(s, w, h)
			surface.DisableClipping(false)
			--draw.RoundedBox(0, 0, 0, w, h, color_white)
			if s.url ~= "" then
				MSD.DrawTexturedRect(0, 0, w, h, MSD.ImgLib.GetMaterial(s.url), color_white)
			end
		end
		return
	end

	if not IsValid(self.frame) then return end

	if self.frame and self.frame.url ~= self:GetUrl() then
		self.frame.url = self:GetUrl()
	end

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), -90)
	Ang:RotateAroundAxis(Ang:Forward(), 75)

	cam.Start3D2D(Pos + Ang:Up() * 5.5 - Ang:Right() * 17 + Ang:Forward() * -7.5, Ang, 0.08	)
		self.frame:PaintManual()
	cam.End3D2D()
end