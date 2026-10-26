--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/carradio/lua/wcarradio/sh_ext.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local Entity = FindMetaTable("Entity")

function Entity:WCR_SetChannel(chan)
	self:SetNW2Int("wcr_chan", chan)
end
function Entity:WCR_GetChannel()
	return self:GetNW2Int("wcr_chan")
end

function Entity:WCR_IsCarEntity()
	if not self:IsVehicle() then return false end

	local par = self:GetParent()
	if par:IsValid() then return false end

	if IsValid(self:GetNWEntity("SCarEnt")) then
		return true
	end

	local cls = self:GetClass()
	return cls == "prop_vehicle_jeep" or
		cls == "prop_vehicle_jeep_old" or
		(cls == "spawned_junk" and self.Geteclass and self:Geteclass() == "radio")
end

local disabledModelsSet = nil

function Entity:WCR_GetCarEntity()
	if not IsValid(self) then return end

	if self:GetClass() == "spawned_junk" and self.Geteclass and self:Geteclass() == "radio" then
		return self
	end

	if not disabledModelsSet then
		disabledModelsSet = {}
		for _,dm in pairs(wyozicr.DisabledModels or {}) do
			disabledModelsSet[dm] = true
		end
	end

	 -- SCars
	local scarent = self:GetNWEntity("SCarEnt")
	if IsValid(scarent) then
		if disabledModelsSet[scarent:GetModel()] then return end
		return scarent
	end

	-- Sit anywhere
	if self:GetClass() == "prop_vehicle_prisoner_pod" and
		not self:GetParent():IsVehicle() then
		return
	end

	-- TDMCar stuff
	if self:GetClass() ~= "prop_vehicle_jeep" then
		local par = self:GetParent()
		if IsValid(par) then
			if disabledModelsSet[par:GetModel()] then return end
			return par
		end
	end

	if disabledModelsSet[self:GetModel()] then return end
	return self
end

function Entity:WCR_IsCarHealthy()
	return true
end

-- Whether this car entity can _currently_ play radio
function Entity:WCR_HasRadioCapability()
	return self:GetNWBool("MccD.Radio")
end