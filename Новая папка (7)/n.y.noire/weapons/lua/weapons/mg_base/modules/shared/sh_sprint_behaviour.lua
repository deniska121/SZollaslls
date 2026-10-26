--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/shared/sh_sprint_behaviour.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

function SWEP:CanSprint()
	--checking velocity can sometimes cause desyncs (touching server entities while sprinting)
	return not self:IsDrawing() and not self:GetIsHolstering() and CurTime() > self:GetNextPrimaryFire() and (self:GetSafety() or self:GetOwner():WaterLevel() > 2 or self:GetOwner():KeyDown(IN_FORWARD) or self:GetOwner():KeyDown(IN_BACK) or self:GetOwner():KeyDown(IN_MOVERIGHT) or self:GetOwner():KeyDown(IN_MOVELEFT)) and (self:GetOwner():WaterLevel() > 2 or (not self:GetOwner():Crouching() or self:GetSafety())) and CurTime() > self:GetNextFiremodeTime() and CurTime() > self:GetNextMeleeTime()
end

function SWEP:CanPlaySprintOutAnim()
	return not self:IsDrawing() and not self:GetIsHolstering() and CurTime() > self:GetNextPrimaryFire() and CurTime() > self:GetNextFiremodeTime() and not self:IsCustomizing()
end

function SWEP:DoSprintIn()
	self:StopCustomizing()

	if (not self:GetIsSprinting()) then
		if (IsFirstTimePredicted()) then
			self:PlayViewModelAnimation("Sprint_In")
		end

		self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, 0)
	end

	self:SetIsSprinting(true)
	self:SetIsReloading(false)
end

function SWEP:DoSprintOut()
	if (self:GetIsSprinting()) then
		self:SetNextSprintTime(CurTime() + self:GetAnimLength("Sprint_Out"))

		if self:CanPlaySprintOutAnim() and IsFirstTimePredicted() then
			self:PlayViewModelAnimation("Sprint_Out")
		end
	end

	self:SetIsSprinting(false)
end

function SWEP:SprintBehaviourModule()
	if (CLIENT and game.SinglePlayer()) then return end

	if ((self:GetOwner():KeyDown(IN_SPEED) or self:GetOwner():WaterLevel() > 2 or self:GetSafety()) and self:CanSprint()) then
		self:DoSprintIn()
	else
		self:DoSprintOut()
	end

	-- if (self.m_bSafety ~= self:GetSafety() and not self:GetSafety()) then
	-- 	self:DoSprintOut()
	-- end

	-- self.m_bSafety = self:GetSafety()
end