--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/workstation_alc/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

function ENT:Think()
	local CT = CurTime()

	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 500000 then
		self:PauseSounds()
		return
	end

	if self:GetCrafting() and not self:GetStopCraft() then
		if not self.nexteffect or self.nexteffect < CT then
			self.nexteffect = CT + 0.2
			if not IsValid(self.sound) then
				self:StartCraftingSound()
			else
				self:ContinueSounds()
				self.sound:SetPos(self:GetPos())
			end
		end
	else
		self:StopCraftingSound()
	end

	self:NextThink(CT)
	return true
end

function ENT:Draw()
	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 22000000 then
		return
	end
	self:DrawModel()
end

function ENT:StopSounds()
	if IsValid(self.sound) then
		self.sound:Stop()
		self.sound = nil
	end
end

function ENT:PauseSounds()
	if IsValid(self.sound) and self.sound:GetState() ~= 2 then
		self.sound:Pause()
	end
end

function ENT:ContinueSounds()
	if IsValid(self.sound) and self.sound:GetState() == 2 then
		self.sound:Play()
	end
end

function ENT:StopCraftingSound()
	if IsValid(self.sound) then
		self.sound:Stop()
		sound.PlayFile( "sound/ambient/levels/canals/toxic_slime_gurgle6.wav", "3d noplay noblock", function( station, errCode, errStr )
			if IsValid( station ) then
				station:SetPos(self:GetPos())
				station:Play()
				station:SetVolume(0.5)
				station:Set3DCone( 360, 360, 0 )
			end
		end)
		self.sound = nil
	end
end

function ENT:StartCraftingSound()
	sound.PlayFile( "sound/ambient/levels/canals/toxic_slime_gurgle5.wav", "3d noplay noblock", function( station )
		if IsValid( station ) then
			station:SetPos(self:GetPos())
			station:Play()
			station:SetVolume(0.5)
			station:Set3DCone( 360, 360, 0 )
			self.sound = station
		end
	end)
	timer.Simple(0.5, function()
		if not IsValid(self) then return end
		sound.PlayFile( "sound/ambient/levels/canals/waterleak_loop1.wav", "3d noplay noblock", function( station )
			if IsValid( station ) then
				station:EnableLooping(true)
				station:SetPos(self:GetPos())
				station:Play()
				station:SetVolume(0.1)
				station:Set3DCone( 360, 360, 0 )
				self.sound = station
			end
		end)
	end)
end

function ENT:ClearModels()
	if not self.models then return end
	for k,v in pairs(self.models) do
		if not IsValid(v) then continue end
		v:Remove()
	end
end

function ENT:OnRemove()
	self:StopSounds()
	self:ClearModels()
end