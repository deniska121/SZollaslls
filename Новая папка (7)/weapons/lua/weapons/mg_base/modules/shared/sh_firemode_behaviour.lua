-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\shared\\sh_firemode_behaviour.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:CanChangeFiremode()
	return not self:GetIsReloading() and not self:IsDrawing() and not self:GetIsHolstering() and (not self:GetIsSprinting() or self:GetSafety()) and CurTime() > self:GetNextSprintTime() and CurTime() > self:GetNextPrimaryFire() and CurTime() > self:GetNextMeleeTime() and not self:IsCustomizing()
end

function SWEP:FiremodeBehaviourModule()
	if (CLIENT and game.SinglePlayer()) then return end

	if (self:GetOwner():KeyDown(IN_USE) and self:GetOwner():KeyDown(IN_RELOAD) and self:CanChangeFiremode()) and CurTime() > self:GetNextFiremodeTime() then
		local index = self:GetFiremode()

		if (self.Firemodes[index + 1]) then
			index = index + 1
		else
			index = 1
		end

		if (self:GetFiremode() ~= index) then
			local seqIndex = self:ApplyFiremode(index)

			if (game.SinglePlayer() or IsFirstTimePredicted()) then
				self:PlayViewModelAnimation(seqIndex)
			end

			local length = 0.5

			if (self.Animations[seqIndex].Length ~= nil) then
				length = self:GetAnimLength(seqIndex)
			end

			self:SetNextFiremodeTime(CurTime() + length)
			self:SetBurstRounds(0)
		end
	end

	if (CLIENT and game.SinglePlayer()) then return end

	if (self.Primary.BurstRounds > 1 and self:GetBurstRounds() < self.Primary.BurstRounds and self:GetBurstRounds() > 0) and not self:GetMalfunction() then
		self:PrimaryAttack()
	end
end

function SWEP:ApplyFiremodeStats()
	return self.Firemodes[self:GetFiremode()].OnSet(self)
end

function SWEP:ApplyFiremode(index)
	if (type(index) == "string") then
		index = tonumber(index)
	end

	self:SetFiremode(index)

	if (game.SinglePlayer() or IsFirstTimePredicted()) then
		self:BuildCustomizedGun()
	end

	if (game.SinglePlayer() and SERVER) then
		self:CallOnClient("ApplyFiremode", index)
	end

	return self:ApplyFiremodeStats()
end