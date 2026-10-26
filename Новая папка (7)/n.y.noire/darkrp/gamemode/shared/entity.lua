--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/shared/entity.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local playerMeta = FindMetaTable("Player")

function playerMeta:HasAdminAccess(type)
	return self:IsSuperAdmin()
end

function playerMeta:CharID()
	return self:AccountID() .. (self:getDarkRPVar("character") or 1)
end

function playerMeta:isMale()
	return self:getDarkRPVar("gender") and self:getDarkRPVar("gender") == "male" or false
end

function playerMeta:isCP()
	if not IsValid(self) then return false end
	local tm = self:Team()

	return GAMEMODE.CivilProtection and GAMEMODE.CivilProtection[tm]
end

function playerMeta:isEMS()
	if not IsValid(self) then return false end
	local tm = self:Team()

	return GAMEMODE.EMSTeams and GAMEMODE.EMSTeams[tm]
end

function playerMeta:isMayor()
	if not IsValid(self) then return false end

	return self:Team() == 15
end

function playerMeta:canAfford(amount)
	if not amount or self.DarkRPUnInitialized then return false end

	return math.floor(amount) >= 0 and (self:getDarkRPVar("money") or 0) - math.floor(amount) >= 0
end

function playerMeta:IsUnrestrained()
	if not self:Alive() or self:getDarkRPVar("jailed") or self:getDarkRPVar("unconscious") or self:getDarkRPVar("HandCuffed") then return false end

	return true
end

function playerMeta:IsFreeman()
	if not self:Alive() or self:getDarkRPVar("Arrested") or self:getDarkRPVar("jailed") or self:getDarkRPVar("unconscious") or self:getDarkRPVar("HandCuffed") then return false end

	return true
end

function playerMeta:JobXP(code)
	if not self.jobxp or not self.jobxp[code] or not self.jobxp[code]["xp"] then
		return 0
	end

	return self.jobxp[code]["xp"]
end

function playerMeta:JobXPOpen(code, item)
	if self.jobxp and self.jobxp[code] and self.jobxp[code]["unlocks"] and self.jobxp[code]["unlocks"][item] then
		return true
	end

	return false
end

function DarkRP.HideEntity(ent, time)
	if not IsValid(ent) then return end

	ent:SetNotSolid(true)
	ent:SetNoDraw(true)

	local phys = ent:GetPhysicsObject()
	if phys and phys:IsValid() then
		phys:Sleep()
	end

	timer.Simple(time, function()
		if not IsValid(ent) then return end
		ent:SetNotSolid(false)
		ent:SetNoDraw(false)
		local ph = ent:GetPhysicsObject()
		if ph and ph:IsValid() then
			ph:Wake()
		end
	end)
end