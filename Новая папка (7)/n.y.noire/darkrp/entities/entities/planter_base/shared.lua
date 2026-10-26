--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/planter_base/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Грядка"
ENT.Author = "Mactavish"
ENT.Spawnable = true
ENT.AdminSpawnable = false
ENT.CanPack = true
ENT.growTime = 10
ENT.ShowOnHud = true

-- Optimal hydration window per seed type. Outside this range the plant
-- grows slower and starts dying after a while.
ENT.SeedOptimalHydration = {
	["seed_weed"]  = {min = 20, max = 70},
	["seed_coca"]  = {min = 40, max = 80},
	["seed_opium"] = {min = 20, max = 50},
}

ENT.GrowStageMax       = 100  -- Stage at which the plant is fully grown.
ENT.SlowGrowMultiplier = 5    -- growTime multiplier when hydration is out of range.
ENT.BadHydrationDelay  = 270   -- Seconds of bad hydration before plant starts dying.
ENT.GrownDecayDelay    = 350  -- Seconds of sitting fully grown before plant starts dying.
ENT.DyingStageInterval = 300   -- Seconds between dying stage progressions (1 -> 2 -> 3).
ENT.MaxDyingStage      = 3    -- Total cosmetic dying stages.
ENT.HarvestTime        = 10    -- Seconds the harvest progress bar runs.
ENT.RemoveTime         = 15 -- Remove progress is 30% longer than harvest.
ENT.IdleWaterFloor     = 5   -- Without plants, evaporation stops here (10-20% target).
ENT.IdleEvapInterval   = 8    -- Seconds between idle evaporation ticks.

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "owning_ent")
	self:NetworkVar("Float",  0, "WaterLevel")
	self:NetworkVar("Float",  2, "LightLevel")
	self:NetworkVar("Float",  3, "Stage")
	self:NetworkVar("String", 0, "Seeds")
	self:NetworkVar("String", 1, "Boost")
	self:NetworkVar("Int",    0, "DyingStage") -- 0 = healthy, 1..MaxDyingStage = dying cosmetic stage
end

function ENT:GetOptimalHydration()
	return self.SeedOptimalHydration[self:GetSeeds()]
end

-- Single recommended figure shown in the UI (middle of the optimal range).
function ENT:GetRecommendedHydration()
	local range = self:GetOptimalHydration()
	if not range then return nil end
	return math.floor((range.min + range.max) / 2)
end

function ENT:IsHydrationOptimal()
	local range = self:GetOptimalHydration()
	if not range then return true end
	local w = self:GetWaterLevel()
	return w >= range.min and w <= range.max
end

function ENT:IsHydrationRecomended()
	local rec = self:GetRecommendedHydration()
	if not rec then return true end
	local range = {min = rec - 10, max = rec + 10}
	if not range then return true end
	local w = self:GetWaterLevel()
	return w >= range.min and w <= range.max
end

function ENT:IsDying()
	return self:GetDyingStage() > 0
end

function ENT:IsFullyGrown()
	return self:GetStage() >= self.GrowStageMax
end

function ENT:CanHarvest()
	return self:GetSeeds() ~= "" and self:IsFullyGrown() and not self:IsDying()
end
