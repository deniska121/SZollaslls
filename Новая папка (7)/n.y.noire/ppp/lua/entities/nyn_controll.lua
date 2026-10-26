--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/nyn_controll.lua
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
ENT.PrintName = "A Controller"
ENT.Author = "Mac"
ENT.Spawnable = true
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("Float", 0, "Timer")
	self:NetworkVar("Float", 1, "FT")
	self:NetworkVar("Float", 2, "ET")
	self:NetworkVar("Float", 3, "FTK")
	self:NetworkVar("Float", 4, "ETK")
	self:NetworkVar("Float", 5, "StopTimer")
	self:NetworkVar("Int", 6, "EnemyC", {KeyName = "Enemy count",Edit = { type = "Int", order = 1, min = 0, max = 100, category = "Wheels"}})
	self:NetworkVar("Int", 7, "HostageC", {KeyName = "Hostage count",Edit = { type = "Int", order = 2, min = 0, max = 100, category = "Wheels"}})
end

if SERVER then
	function ENT:Initialize()

		self:SetModel("models/squad/sf_plates/sf_plate3x8.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMaterial("phoenix_storms/mat/mat_phx_carbonfiber")
		self:SetColor(Color(0, 0, 0))
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:SetUseType(SIMPLE_USE)
		self:SetTimer(CurTime())
		self:SetFT(0)
		self:SetET(0)
		self:SetFTK(0)
		self:SetETK(0)
		self:SetStopTimer(0)
		self:SetEnemyC(0)
		self:SetHostageC(0)
		local phys = self:GetPhysicsObject()
		self.nodupe = true
		self.ShareGravgun = true
		phys:Wake()
	end

	function ENT:Use(ply)
		if self.pressed and self.pressed > CurTime() then return end
		self.pressed = CurTime() + 5

		local et = 0
		local ft = 0
		local limite = self:GetEnemyC()
		local limith = self:GetHostageC()

		if limite > 0 or limith > 0 then
			for k,v in ipairs(ents.FindByClass("nyn_target")) do
				v:SetUrl("")
				local rnd = math.random(3)
				if rnd == 3 then continue end
				if rnd == 1 and ft < limith then
					v:ResetTarget(0)
					ft = ft + 1
				end
				if rnd == 2 and et < limite then
					v:ResetTarget(1)
					et = et + 1
				end
			end

			if ft < limith then
				for k,v in ipairs(ents.FindByClass("nyn_target")) do
					if v:GetUrl() ~= "" then continue end
					if ft < limith then
						v:ResetTarget(0)
						ft = ft + 1
					end
				end
			end

			if et < limite then
				for k,v in ipairs(ents.FindByClass("nyn_target")) do
					if v:GetUrl() ~= "" then continue end
					if et < limite then
						v:ResetTarget(1)
						et = et + 1
					end
				end
			end
		else
			for k,v in ipairs(ents.FindByClass("nyn_target")) do
				v:ResetTarget()
				if v:GetTargetType() == 0 then
					ft = ft + 1
				else
					et = et + 1
				end
			end
		end


		self:EmitSound("ambient/alarms/klaxon1.wav")

		self:SetTimer(CurTime())
		self:SetFT(0)
		self:SetET(0)
		self:SetFTK(ft)
		self:SetETK(et)
		self:SetStopTimer(0)
	end

	return
end

surface.CreateFont("InfoLEDAAA", {
	font = "Enhanced Dot Digital-7",
	extended = true,
	size = 120,
	weight = 800,
	antialias = true
})

function ENT:Draw()
	if not self.frame then
		self.frame = vgui.Create("DPanel")
		self.frame:SetSize(950, 350)
		self.frame:SetPaintedManually(true)

		self.frame.Paint = function(s, w, h)
			local oc = surface.DisableClipping(false)
			local timers = (self:GetStopTimer() > 0 and self:GetStopTimer() or CurTime())
			draw.DrawText(os.date("%M:%S", timers - self:GetTimer()), "InfoLEDAAA", w / 2, 9, color_white, 1)
			draw.DrawText(self:GetET() .. "/" .. self:GetETK(), "InfoLEDAAA", 60, 120, color_white, 0)
			draw.DrawText(self:GetFT() .. "/" .. self:GetFTK(), "InfoLEDAAA", w - 60, 120, color_white, 2)
			surface.DisableClipping(oc)
		end
	end

	self:DrawModel()

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	cam.Start3D2D(Pos + Ang:Up() * 1.1 - Ang:Right() * 36 + Ang:Forward() * 0.5, Ang, 0.1)
	self.frame:PaintManual()
	cam.End3D2D()
end