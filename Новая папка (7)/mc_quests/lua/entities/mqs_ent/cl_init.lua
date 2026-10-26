-- "addons\\mc_quests\\lua\\entities\\mqs_ent\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

function ENT:InitRenderModel()
	self.RenderModel = ClientsideModel(self:GetCModel())
	self.RenderModel:SetPos(self:GetPos())
	self.RenderModel:SetParent(self)
	self.RenderModel:SetMaterial(self:GetMaterial())
	self.RenderModel:SetColor(self:GetColor())
	self:CallOnRemove("RenderModel", function()
		SafeRemoveEntity(self.RenderModel)
	end)
end

local questarrows = {}
local ang0 = Angle()

function ENT:Draw()
	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local planeNormal = Ang:Up()
	if Pos:DistToSqr(LocalPlayer():GetPos()) > MQS.Config.QuestEntDrawDist ^ 2 then return end

	if self:GetEnablePhys() then
		if self:GetPA() and (not self.punch or self.punch < CurTime()) then
			self.punch = CurTime() + 0.3
			self.punchang = Angle(math.random(2,5), math.random(2,5), math.random(2,5))
			if not self.orang then
				self.orang = Angle(Ang)
			end
		end

		if self.punchang and self.punchang ~= ang0 then
			self.punchang = LerpAngle(0.02, self.punchang, ang0)
			self:SetRenderAngles(self.orang + self.punchang)
		end

		self:DrawModel()
	else
		if self:GetTPly() ~= LocalPlayer() then return end

		local sysTime = SysTime()
		local rotAng = Angle(Ang)
		self.rotationOffset = sysTime % 360 * 130
		rotAng:RotateAroundAxis(planeNormal, self.rotationOffset)

		if self:GetPA() then
			if not self.punch or self.punch < CurTime() then
				self.punch = CurTime() + 0.3
				self.punchang = Angle(math.random(2,8), math.random(2,8), math.random(2,8))
			end
			self.punchang = LerpAngle(0.02, self.punchang, ang0)
			rotAng = rotAng + self.punchang
		end

		if not IsValid(self.RenderModel) then
			self:InitRenderModel()
		end

		self.RenderModel:SetPos(Pos)
		self.RenderModel:SetAngles(rotAng)
	end

	if self:GetTPly() ~= LocalPlayer() then return end

	if not self:GetShowPointer() then return end

	if not questarrows[self] then questarrows[self] = true end
end

function ENT:Think()
	if not MQS.OtherEntities or not self:GetDistractible() then return end
	if not self.protect and MQS.OtherEntities[self:EntIndex()] then self.protect = true end
end

function ENT:OnRemove()
	questarrows[self] = nil
end

local x, y = 0, 0
local wd = 100
local hp_cl = Color(185,55,55)
local hp_cl2 = Color(185,133,55)

hook.Add( "PostDrawTranslucentRenderables", "DrawQuestIndicators", function( bDepth, bSkybox )
	for ent, _ in pairs(questarrows) do
		if not IsValid(ent) then return end

		local Pos = ent:GetPos()
		local eye = EyeAngles()

		if Pos:DistToSqr(LocalPlayer():GetPos()) > MQS.Config.QuestEntDrawDist ^ 2 then return end

		local q = MQS.HasQuest(LocalPlayer())

		if not q then return end

		if not ent.protect and MQS.Quests[q.quest].objects[MQS.GetNWdata(LocalPlayer(), "quest_objective") or 0].type ~= "Collect quest ents" then
			continue
		end

		local max = ent:OBBMaxs()
		if ent:GetDistractible() then
			Pos.z = Pos.z + max.z + 20
		else
			Pos.z = Pos.z + max.z + (20 + math.sin(CurTime() * 2) * 5)
		end

		cam.Start3D2D(Pos, Angle(0,eye.y - 90,90), 0.2)
			if ent:GetDistractible() then
				if not ent.maxhp then ent.maxhp = ent:GetHP() end
				if ent.protect then
					draw.SimpleTextOutlined("Protect", "MSDFont.18", x, y, color_white, TEXT_ALIGN_CENTER, 0, 1,color_black)
				end
				local pr = math.Clamp(wd * (ent:GetHP() / ent.maxhp), 0, wd)
				draw.RoundedBox(2, (x - wd / 2) - 1, y + 24, wd + 2, 7, color_black)
				draw.RoundedBox(2, x - wd / 2, y + 25, pr, 5, ent.protect and hp_cl2 or hp_cl)
			else
				MSD.DrawTexturedRect(-23, -23, 48, 64, MSD.Icons48.arrow_down_color, color_white)
			end
		cam.End3D2D()
	end

	if MQS.ProtectNPC then
		for k,v in pairs(MQS.ProtectNPC) do
			local ent = Entity(k)
			if not IsValid(ent) or ent:GetClass() ~= v or v == NULL then continue end
			local Pos = ent:GetPos()
			local eye = EyeAngles()

			if Pos:DistToSqr(LocalPlayer():GetPos()) > MQS.Config.QuestEntDrawDist ^ 2 then return end

			local q = MQS.HasQuest(LocalPlayer())

			if not q then return end

			local max = ent:OBBMaxs()
			Pos.z = Pos.z + max.z + 20

			cam.Start3D2D(Pos, Angle(0,eye.y - 90,90), 0.2)
				draw.SimpleTextOutlined("Protect", "MSDFont.18", x, y, color_white, TEXT_ALIGN_CENTER, 0, 1,color_black)
			cam.End3D2D()
		end
	end
end)