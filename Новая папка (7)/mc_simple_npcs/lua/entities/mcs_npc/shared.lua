-- "addons\\mc_simple_npcs\\lua\\entities\\mcs_npc\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
ENT.Type = "ai"
ENT.Base = "base_anim"
ENT.PrintName = "Simple NPC"
ENT.Author = "Mactavish"
ENT.Spawnable = false
ENT.AdminSpawnable = true
ENT.SimpleNPC = true

local drawtable = {}

function ENT:Initialize()
	self.names = 0
	self.dist = 0

	drawtable[self] = true

	if SERVER then
		self:SetCollisionGroup(COLLISION_GROUP_WORLD)
		self:CapabilitiesAdd(CAP_ANIMATEDFACE)
	else
		self.extras = MCS.Spawns[self:GetUID()] and MCS.Spawns[self:GetUID()].extras
		if self.extras then
			for k,v in pairs(self.extras) do
				self[k] = v
			end
		end
	end

	self.ClModels = MCS.Spawns[self:GetUID()] and MCS.Spawns[self:GetUID()].ClModels or {}

	if CLIENT and self.ClModels then
		self.mdls = {}
		self.msdW = 0
		for k, v in ipairs(self.ClModels) do
			self.mdls[k] = ents.CreateClientProp()
			self.mdls[k]:SetModel( v.model )
			self.mdls[k]:SetSkin( v.skin or 0 )
			self.mdls[k]:InvalidateBoneCache()
			self.mdls[k]:SetMoveType(MOVETYPE_NONE)
			self.mdls[k]:SetParent( self )

			if v.marge then
				self.mdls[k]:AddEffects(EF_BONEMERGE)
				self.mdls[k]:AddEffects(EF_BONEMERGE_FASTCULL)
				self.mdls[k]:AddEffects(EF_PARENT_ANIMATES)
			else
				self.mdls[k]:SetPos(self:LocalToWorld(v.pos))
				self.mdls[k]:SetAngles( self:GetAngles() + v.ang )
				self.mdls[k].pos = v.pos
				self.mdls[k].ang = v.ang
				self.mdls[k].bone = v.bone
				local mat = Matrix()
				local scale = (v.scale or 1) * self:GetModelScale()
				mat:Scale(Vector(scale,scale,scale))
				self.mdls[k]:EnableMatrix("RenderMultiply", mat)
			end
			self.mdls[k]:Spawn()
		end
	end
end

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Namer")
	self:NetworkVar("String", 1, "UID")
	self:NetworkVar("String", 2, "DefAnimation")
	self:NetworkVar("Bool", 0, "InputLimit")
	self:NetworkVar("Float",0,"Space")
	self:NetworkVar("String",3,"StorageName")
end

function ENT:Think()
	local CT = CurTime()

	if SERVER and self:GetInputLimit() and self.UsingPlayer and not IsValid(self.UsingPlayer) then
		self.UsingPlayer = nil
	end

	if self.turntoplayer then
		if IsValid(self.UsingPlayer) then
			self:SetAngles(LerpAngle( FrameTime() * 2, self:GetAngles(), self.UsingPlayer:GetAngles() + Angle(0,180,0) ))
			self.turned = true
		elseif self.turned then
			self:SetAngles(LerpAngle( FrameTime() * 4, self:GetAngles(), self.DefAng ))
			if math.Round(self:GetAngles().y) == math.Round(self.DefAng.y)  then
				self.turned = nil
				MCS.PlayDefAnimation(self)
			end
		end
	end

	if SERVER and self.timer and self.timer < CT and not self.UsingPlayer then
		self:Remove()
		return true
	end

	if CLIENT then
		if not self.flexes then
			self.flexes = {
				self:GetFlexIDByName( "jaw_drop" ),
				self:GetFlexIDByName( "left_part" ),
				self:GetFlexIDByName( "right_part" ),
				self:GetFlexIDByName( "left_mouth_drop" ),
				self:GetFlexIDByName( "right_mouth_drop" )
			}
		end

		local weight = (MCS.Dialogue and MCS.Dialogue.Sound ) and math.Clamp(MCS.Dialogue.Sound:GetLevel() * 1.1, 0, 1 ) or 0

		for k, v in pairs( self.flexes ) do
			if not v then continue end
			self:SetFlexWeight( v, weight)
		end
	end

	self:NextThink(CT)

	return true
end

if SERVER then
	function ENT:PingPlayer(ply)
		if self.canscare and (ply:isWanted() or (not ply:isCP() and ((IsValid(ply:GetActiveWeapon()) and DarkRP.SingleWep.FireArms[ply:GetActiveWeapon():GetClass()]) or ply:HasRifle()) )) then
			local npct = MCS.Spawns[self:GetUID()]
			if not npct then return end
			self:ResetSequence(npct.scare_anim[1])
			self:SetCycle(0)
			self.LastAnim = CurTime()
			self.scared = true

			if npct.scare_sound then
				self:EmitSound(npct.scare_sound)
			end

			if npct.scare_alarm and not self.triggerbut then
				self.triggerbut = ents.GetMapCreatedEntity(npct.scare_alarm)
			end

			if IsValid(self.triggerbut) then
				self.triggerbut:Fire("PressIn")
			end
			DarkRP.UIEffect(nil, "WantedStatus", {ply = ply:UserID()})
			Dispatcher.Call("NYPD", ply:GetPos(), "Вызов от системы защиты", "[сигнализация]")
			timer.Simple(npct.scare_timer, function()
				if not IsValid(self) then return end
				self:ResetSequence(npct.scare_anim[2])
				self:SetCycle(0)
				self.LastAnim = CurTime()
				self.scared = nil

				if IsValid(self.triggerbut) then
					self.triggerbut:Fire("PressOut")
				end
			end)

			return true
		end

		return false
	end

	function ENT:Use(ply, _, _, force)
		if force == 2 then
			net.Start("MCS.OpenMenu")
			net.WriteEntity(self)
			net.Send(ply)
		end

		if self.scared then return end

		if not IsValid(ply) or (ply.UseTimer and ply.UseTimer > CurTime()) then return end

		if self:PingPlayer(ply) then
			return
		end

		ply.UseTimer = CurTime() + MCS.Config.UseDelay

		if self.checkpos and ply:GetMoveType() ~= MOVETYPE_NOCLIP then
			if self:GetPos().z <= ply:GetPos().z - 10 then
				ply:Ragdollize(3)
				return
			end
			if self:GetAngles():Forward():Dot((ply:GetShootPos() - self:GetPos()):GetNormal()) < 0.1 then
				return
			end
		end

		if self:GetInputLimit() then
			if self.UsingPlayer then
				return
			else
				self.UsingPlayer = ply
				ply.MCSInUse = self
			end

			if self.timer then
				self.timer = self.timer + 120
			end
		end

		net.Start("MCS.OpenMenu")
		net.WriteEntity(self)
		net.Send(ply)
	end

	function ENT:OnTakeDamage(data)
		if self.scared then return end

		local attc = data:GetAttacker()

		if IsValid(attc) and attc:IsPlayer() then
			self:PingPlayer(attc)
		end
	end
else
	function ENT:Draw()
		self:DrawModel()

		local p_dist = self:GetPos():DistToSqr(LocalPlayer():GetPos())

		if p_dist > 100000 then return end

		if not drawtable[self] then
			drawtable[self] = true
		end

		local npct = MCS.Spawns[self:GetUID()]

		if not npct then return end

		if not self.mdls then return end
		for k,v in ipairs(self.mdls) do
			if IsValid(v) and v.bone then
				local pos, ang = MCS.GetBoneOrientation(self, v.bone, v.pos, v.ang, self:GetModelScale())
				ang:RotateAroundAxis(ang:Up(), v.ang.y)
				ang:RotateAroundAxis(ang:Right(), v.ang.p)
				ang:RotateAroundAxis(ang:Forward(), v.ang.r)
				v:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
				v:SetAngles(ang)
				if v:GetParent() == NULL then
					v:SetParent(self)
				end
			end
		end

	end

	function ENT:DrawTranslucentName()
		local p_dist = self:GetPos():DistToSqr(LocalPlayer():GetPos())

		if p_dist > 70000 then return end

		local npct = MCS.Spawns[self:GetUID()]

		if not npct or npct.noinfo then return end

		if not self.msdna then self.msdna = 0 end

		if LocalPlayer():GetEyeTrace().Entity == self then
			self.msdna = Lerp(0.01, self.msdna, 1)
		else
			self.msdna = Lerp(0.01, self.msdna, 0)
		end

		if self.msdna < 0.01 then return end

		local Pos = self:GetPos()
		local Ang = self:GetAngles()
		local eyepos = EyePos()
		local planeNormal = Ang:Up()

		Ang:RotateAroundAxis(Ang:Forward(), 90)

		if npct and npct.namepos then
			local head = self:LookupBone("ValveBiped.Bip01_Head1")
			if head then
				Pos = MCS.GetBoneOrientation(self, head, Pos, Ang)
			else
				Pos.z = Pos.z + (npct.namepos * self:GetModelScale())
			end
		else
			Pos.z = Pos.z + (77 * self:GetModelScale())
		end

		local relativeEye = eyepos - Pos
		local relativeEyeOnPlane = relativeEye - planeNormal * relativeEye:Dot(planeNormal)
		local textAng = relativeEyeOnPlane:AngleEx(planeNormal)

		textAng:RotateAroundAxis(textAng:Up(), 90)
		textAng:RotateAroundAxis(textAng:Forward(), 90)
		local hover = Vector(0,0,-2)
		if MCS.Config.NPCNameHover then
			hover = Ang:Right() * math.sin(CurTime()) * 0.9
		end

		cam.Start3D2D(Pos - hover, textAng, 0.1)
			DarkRP.Hud.DrawPlayerInfo(self, self:GetNamer(), npct and npct.desc or "",  55, -40, MSD.Config.HUD, npct.n_icon)
		cam.End3D2D()

	end

	hook.Add( "PostDrawTranslucentRenderables", "McsNPCsNames", function( bDepth, bSkybox )
		for ent, _ in pairs(drawtable) do
			if not IsValid(ent) then return end
			ent:DrawTranslucentName()
		end
	end)

	function ENT:OnRemove()
		if drawtable[self] then
			drawtable[self] = nil
		end

		if not self.mdls then return end
		for k,v in ipairs(self.mdls) do
			if IsValid(v) then
				v:Remove()
			end
		end
	end
end