--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/nyn_target.lua
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
ENT.PrintName = "A Target"
ENT.Author = "Mac"
ENT.Spawnable = true
ENT.AdminSpawnable = true

local targets = {
	[0] = {
		"https://i.imgur.com/N4zUBVu.png",
		"https://i.imgur.com/dav3S7T.png",
		"https://i.imgur.com/f6YuGg5.png",
	},
	[1] = {
		"https://i.imgur.com/A5867AI.png",
		"https://i.imgur.com/VTd5L7k.png",
		"https://i.imgur.com/G5OE09u.png",
		"https://i.imgur.com/W6mUkxb.png",
	}
}

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Url", { KeyName = "url", Edit = { type = "String", order = 1 } })
	self:NetworkVar("Int", 0, "TargetType")
	self:NetworkVar("Float", 0, "TargetHp")
end

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_junk/garbage_carboard002a.mdl")
		self:SetMaterial("models/uc2/propper/af_plywood_01")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)

		local targ = math.random(0,1)
		self:SetTargetType(targ)
		self:SetUrl(targets[targ][math.random(#targets[targ])])
		self:SetTargetHp(targ == 0 and 1 or 50)

		local phys = self:GetPhysicsObject()
		phys:EnableMotion(false)
	end

	local hp = Vector(0, 12, 0)
	function ENT:OnTakeDamage(data)
		if self.reseting then return end
		local pos = self:WorldToLocal(data:GetDamagePosition())

		local damage = data:GetDamage()

		if DarkRP.InRangeVector(pos, hp, 7) then
			damage = damage * 2
		end

		local nhp = self:GetTargetHp() - damage
		self:SetTargetHp(nhp)

		if nhp <= 1 then
			self.reseting = CurTime() + 90

			self:SetUrl("")

			if self:GetTargetType() == 0 then
				self:EmitSound("ambient/alarms/klaxon1.wav")
				self:AddFCount()
			else
				self:EmitSound("buttons/lever5.wav")
				self:AddECount()
			end
		end
	end

	function ENT:AddFCount()
		for k,v in ipairs(ents.FindByClass("pill_hopper")) do
			v:SetFT(v:GetFT() + 1)
			v:EmitSound("ambient/alarms/klaxon1.wav")
		end
	end

	function ENT:AddECount()
		for k,v in ipairs(ents.FindByClass("pill_hopper")) do
			v:SetET(v:GetET() + 1)

			if v:GetET() >= v:GetETK() then
				v:SetStopTimer(CurTime())
				v:EmitSound("unioncity2/environmental_objects/other/shootingrange_winner.wav")
			else
				v:EmitSound("buttons/lever5.wav")
			end
		end
	end

	function ENT:Think()
		-- if self.reseting and self.reseting < CurTime() then
		-- 	self:ResetTarget()
		-- end
	end

	function ENT:ResetTarget(targ)
		self.reseting = nil

		targ = targ or math.random(0,1)
		self:SetTargetType(targ)
		self:SetUrl(targets[targ][math.random(#targets[targ])])
		self:SetTargetHp(targ == 0 and 1 or 50)
	end

	return
end

local cl = Color(160,160,160,200)
function ENT:Draw()
	self:DrawModel()

	if not DarkRP.InRange(LocalPlayer(), self, 2900) then return end

	if not self.frame then
		self.frame = vgui.Create("DPanel")
		self.frame:SetSize(165, 264)
		self.frame.url = self:GetUrl()
		self.frame:SetPaintedManually(true)

		self.frame.Paint = function(s, w, h)
			local old = surface.DisableClipping(false)
			if s.url ~= "" then
				MSD.DrawTexturedRect(0, 0, w, h, MSD.ImgLib.GetMaterial(s.url), cl)
			end
			surface.DisableClipping(old)
		end
		return
	end

	if not IsValid(self.frame) then return end

	if self.frame and self.frame.url ~= self:GetUrl() then
		self.frame.url = self:GetUrl()
	end

	local Pos = self:GetPos()
	local Ang = self:GetAngles()

	Ang:RotateAroundAxis(Ang:Up(), 0)
	Ang:RotateAroundAxis(Ang:Forward(), 0)

	cam.Start3D2D(Pos + Ang:Up() * 0.5 - Ang:Right() * 20 + Ang:Forward() * -12, Ang, 0.15	)
		self.frame:PaintManual()
	cam.End3D2D()
end
