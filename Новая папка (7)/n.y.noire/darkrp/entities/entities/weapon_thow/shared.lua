--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/weapon_thow/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Коктейль Молотова"
ENT.Author = "MacTavish"

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "clEffect")
end

local think_sv = {
	["teargas"] = function(self)
		if not self.emitgas and self.itime and self.itime + 3 < CurTime() then
			self.emitgas = true
			self:EmitSound("weapons/smokegrenade/sg_explode.wav")
			self:SetclEffect("teargas")
		end

		if self.emitgas and (not self.cuffed or self.cuffed < CurTime()) then
			self.cuffed = CurTime() + 2
			for _,ply in pairs(ents.FindInSphere(self:GetPos(), math.Clamp((CurTime() - self.itime) * 20, 50, 650))) do
				if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() or not DarkRP.IsInRoom(ply, self) then continue end
				if DarkRP.GasMask(ply) then continue end
				ply:AddTempStat("cough", 25)
				ply:AddTempStat("shock", 15)
			end
		end
	end,
	["flashbang"] = function(self)
		if not self.emitgas and self.itime and self.itime + 3 < CurTime() then
			self.emitgas = true
			self:EmitSound("gb_sfx/sndBreakDoor.wav")

			local effectdata = EffectData()
			effectdata:SetOrigin( self:GetPos() )
			util.Effect( "HelicopterMegaBomb", effectdata )
			util.Effect( "cball_explode", effectdata )
			util.Effect( "camera_flash", effectdata )

			for _,ply in pairs(ents.FindInSphere(self:GetPos(), 450)) do
				if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() or not DarkRP.IsInRoom(ply, self) then continue end
				if ply:GetMoveType() == MOVETYPE_NOCLIP then continue end
				local intense = (450 - ply:GetPos():Distance(self:GetPos())) / 450
				if intense > 0.7 then
					ply:Ragdollize(10 * intense)
				end
				ply:AddTempStat("shock", intense * 55)
				DarkRP.UIEffect(ply, "flashbang", {intense, self:GetPos()})
				DarkRP.PlayerGesture(ply, "react_blast")
			end

			self:Remove()
		end
	end,
}

local think_cl = {
	["teargas"] = function(self)
		if not self.effect then
			self.effect = ParticleEmitter(self:GetPos())
		end

		if self.effect and (not self.nexteffect or self.nexteffect < CurTime()) then
			local pos = self:GetPos() + self:GetUp() * 1.5

			local particle = self.effect:Add("particle/particle_smokegrenade", pos)
			particle:SetVelocity(VectorRand() * 20 + self:GetUp() * 100)
			particle:SetDieTime(math.random(7, 12))
			particle:SetStartAlpha(155)
			particle:SetEndAlpha(0)
			particle:SetColor(155, 140, 140)
			particle:SetStartSize(1)
			particle:SetEndSize(70)
			particle:SetRoll(math.Rand(0, 360))
			particle:SetAirResistance(120)
			particle:SetCollide(true)
			particle:SetBounce(5)
			particle:SetGravity(VectorRand() * 5)

			self.nexteffect = CurTime() + 0.1
		end
	end,
}

function ENT:Think()
	self:NextThink(CurTime())

	if SERVER then
		if self.itime and self.itime + 80 < CurTime() then
			self:Remove()

			return true
		end

		if think_sv[self.TrowType] then
			think_sv[self.TrowType](self)
		end
	else
		if self:GetclEffect() and think_cl[self:GetclEffect()] then
			think_cl[self:GetclEffect()](self)
		end
	end

	return true
end