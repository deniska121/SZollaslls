--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/services/lua/entities/vfire/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
DEFINE_BASECLASS("base_anim")

function ENT:SetupDataTables()
	-- 1 is Tiny, 7 is Inferno
	self:NetworkVar("Int", 0, "FireState")
end

function ENT:Initialize()
	self:SetFireState(1)
	-- Make sure the fire is not directly interactable or seen
	self:SetCollisionGroup(COLLISION_GROUP_IN_VEHICLE)
	self:DrawShadow(false)
	-- Set the dummy model so we aren't a hidden error
	self:SetModel(vFireDummyModel)
	local parent = self:GetParent()

	if not IsValid(parent) then
		parent = game.GetWorld()
	end

	-- Store the parent
	self.parent = parent

	if not parent.fires then
		parent.fires = {}
	end

	parent.fires[self] = parent:WorldToLocal(self:GetPos())

	if SERVER then
		-- Life misc
		self.life = 1
		self.feed = 0

		-- Two relaxing variables (one goes up, one goes down) used to decided possible fire states
		-- Mainly needed for optimization
		if not self.stateUp then
			self.stateUp = 0
		end

		-- Acts as our max state
		if not self.stateDown then
			self.stateDown = vFireMaxState
		end

		-- Used to catch touching entities so we can burn them
		self:SetTrigger(true)
		-- A table holding whatever entity we're burning
		self.burning = {}
		-- What is the material type of this fire?
		self.matType = util.QuickTrace(self:GetPos(), self:GetForward() * -10).MatType or -1
		-- Initialize think timings
		self.nextFuelThink = 0
		self.nextLifeThink = 0
		self.nextEatThink = 0
		self.nextBurnThink = 0
		self.nextDropThink = 0
		self.nextSpreadThink = 0
	end

	if CLIENT then
		self.lastState = 1
		self.visState = 1

		if vFireIsCharacter(parent) and not game.SinglePlayer() then
			self:SetPredictable(true)
		end

		-- We use a pixel handle pVis, and an animation factor a to assist animations
		self.pVis = util.GetPixelVisibleHandle()
		self.a = 1
		-- Start out without LOD
		self.LOD = false
		self.visLOD = false
		-- Initialize think timings
		self.nextClusterThink = 0
		self.nextParticlesThink = 0
		self.nextAnimationThink = 0
		-- Start working
		self:RedoParticles(1)
	end

	-- Prioritize the new fire for responsiveness
	self:Prioritize(5)
	self.initialized = true
	hook.Run("vFireCreated", self, parent)

	if SERVER then
		self:FindCluster()
	end
end

--[[-------------------------------------------------------------------------
Remove ourselves from needed tables
---------------------------------------------------------------------------]]
function ENT:OnRemove()
	-- Remove the fire entity from the parent's fire tables
	local parent = self.parent

	if IsValid(parent) and parent.fires then
		parent.fires[self] = nil
	end

	-- This may not be necessary, but just in case: destroy all particle systems
	if CLIENT then

		if self.flames and self.flames:IsValid() then
			self.flames:StopEmission()
		end

		if self.base and self.base:IsValid() then
			self.base:StopEmission()
		end
	end

	local cluster = self.cluster

	if IsValid(cluster) then
		cluster:RemFire(self)
	end

	if self.initialized then
		hook.Run("vFireRemoved", self, parent)
	end
end

--[[-------------------------------------------------------------------------
Fire prioritization - priotizied fires will not be throttled
---------------------------------------------------------------------------]]
function ENT:IsPrioritized()
	return self.prioritized
end

function ENT:UnPrioritize()
	self.prioritized = false
end

function ENT:Prioritize(priority, broadcast)
	if priority <= 0 then
		self:UnPrioritize()

		return
	end

	self.prioritized = true

	timer.Simple(priority, function()
		if IsValid(self) then
			self:UnPrioritize()
		end
	end)

	self:Think()

	if SERVER and broadcast and player.GetCount() > 0 then
		net.Start("vFirePriority", true)
		net.WriteEntity(self)
		net.WriteInt(priority, 16)
		net.SendPVS(self:GetPos())
	end
end

if SERVER then
	util.AddNetworkString("vFirePriority")
end

if CLIENT then
	net.Receive("vFirePriority", function()
		local fire = net.ReadEntity()
		local priority = net.ReadInt(16)

		timer.Simple(0, function()
			if not IsValid(fire) then return end
			if not fire.UnPrioritize or not fire.Prioritize then return end

			if priority <= 0 then
				fire:UnPrioritize()
			else
				fire:Prioritize(priority)
			end
		end)
	end)
end

--[[-------------------------------------------------------------------------
Neighbor Functionalities
---------------------------------------------------------------------------]]
function ENT:GetClosestFire()
	if not IsValid(self.cluster) then return nil end
	if IsValid(self.closestFire) then return self.closestFire end
	-- The previous closest fire is invalid, find a new one
	local minDist = math.huge
	local cluster = self.cluster

	for k, fire2 in pairs(cluster.fires) do
		-- Return nil if there is no closest fire
		if self == fire2 then continue end
		local dist = cluster.distMem[self][fire2]


		if dist and dist < minDist then
			self.closestFire = fire2
			minDist = dist
		end
	end

	return self.closestFire, minDist
end

function ENT:IsBiggerThan(other)
	if SERVER then return self.life > other.life end

	if CLIENT then
		if self.GetFireState and other.GetFireState then
			return self:GetFireState() > other:GetFireState()
		else
			return false
		end
	end
end

function ENT:GetClosestSmallerFire()
	if not IsValid(self.cluster) then return nil end

	if IsValid(self.closestSmallerFire) then
		if not self:IsBiggerThan(self.closestSmallerFire) then
			self.closestSmallerFire = nil
		else
			return self.closestSmallerFire
		end
	end

	-- The previous closest fire is invalid, find a new one
	local minDist = math.huge
	local cluster = self.cluster

	for k, fire2 in pairs(cluster.fires) do
		-- Return nil if there is no closest fire
		if self == fire2 then continue end
		-- Don't account for bigger fires
		if not self:IsBiggerThan(fire2) then continue end
		local dist = cluster.distMem[self][fire2]


		if dist and dist < minDist then
			self.closestSmallerFire = fire2
			minDist = dist
		end
	end

	return self.closestSmallerFire, minDist
end

function ENT:GetClosestBiggerFire()
	if not IsValid(self.cluster) then return nil end

	if IsValid(self.closestBiggerFire) then
		if self:IsBiggerThan(self.closestBiggerFire) then
			self.closestBiggerFire = nil
		else
			return self.closestBiggerFire
		end
	end

	-- The previous closest fire is invalid, find a new one
	local minDist = math.huge
	local cluster = self.cluster

	for k, fire2 in pairs(cluster.fires) do
		-- Return nil if there is no closest fire
		if self == fire2 then continue end
		-- Don't account for smaller fires
		if self:IsBiggerThan(fire2) then continue end
		local dist = cluster.distMem[self][fire2]


		if dist and dist < minDist then
			self.closestBiggerFire = fire2
			minDist = dist
		end
	end

	return self.closestBiggerFire, minDist
end

--[[-------------------------------------------------------------------------
Returns the fire's wind vector
---------------------------------------------------------------------------]]
function ENT:GetWindVector()
	-- Allow overriding of the wind vector
	local overrideWindVec = hook.Run("vFireOnCalculateWind", self)

	if isvector(overrideWindVec) then
		local length = overrideWindVec:Length()

		if length > 1 then
			overrideWindVec = overrideWindVec / length
		end

		return overrideWindVec
	else -- Do our own thing
		local exposure

		if self.cluster then
			exposure = self.cluster.windExposure
		end

		if not exposure then
			exposure = math.Rand(0, 1)
		end

		return exposure * vFireGetWindVector()
	end
end

if SERVER then
	function ENT:ChangeLife(newLife)
		self.life = math.min(newLife, vFireStateToLife(self.stateDown or vFireMaxLife))
	end

	function ENT:GiveLife(fire2, amount)
		local take = math.Min(amount, self.life)
		fire2:ChangeLife(fire2.life + take)
		self:ChangeLife(self.life - take)
	end

	function ENT:GiveFeed(fire2, amount)
		local take = math.Min(amount, self.feed)
		fire2.feed = fire2.feed + take
		self.feed = self.feed - take
	end

	function ENT:Eat(fire2)
		fire2:GiveLife(self, fire2.life)
		fire2:GiveFeed(self, fire2.feed)
		fire2:Remove()
	end

	function ENT:SoftExtinguish(amount)
		self:ChangeLife(self.life - amount)
	end

	--[[-------------------------------------------------------------------------
	Find clusters
	---------------------------------------------------------------------------]]
	function ENT:FindCluster()
		local foundCluster
		local minDist = math.huge
		local closeEnts = ents.FindInSphere(self:GetPos(), vFireClusterSize)

		for k, cluster in pairs(closeEnts) do
			-- We only care about fire clusters
			if cluster:GetClass() ~= "vfire_cluster" then continue end
			-- We have to be on the same parent
			if cluster.parent ~= self.parent then continue end
			-- We have to have matching material types
			if cluster.matType ~= self.matType then continue end
			-- Find the closest cluster
			local dist = self:GetPos():DistToSqr(cluster:GetPos())

			if dist < minDist then
				minDist = dist
				foundCluster = cluster
			end
		end

		if IsValid(foundCluster) then
			-- We found a cluster, add it
			foundCluster:AddFire(self)
		else
			-- We didn't find a cluster, create one of our own
			foundCluster = ents.Create("vfire_cluster")
			foundCluster:SetNW2Entity("ClusterParent", self.parent)
			foundCluster.matType = self.matType
			foundCluster:Spawn()
			foundCluster:AddFire(self)
		end
	end

	--[[-------------------------------------------------------------------------
	Burn activations
	---------------------------------------------------------------------------]]
	function ENT:AddBurning(ent)
		if self.burning[ent] or vFireIsVFireEnt(ent) or ent == self.parent then return end
		self.burning[ent] = ent
	end

	function ENT:RemoveBurning(ent)
		if self.burning[ent] then
			self.burning[ent] = nil
		end
	end

	-- We gonna burn shit
	function ENT:StartTouch(otherEnt)
		self:AddBurning(otherEnt)
	end

	-- No more burning shit
	function ENT:EndTouch(otherEnt)
		self:RemoveBurning(otherEnt)
	end

	--[[-------------------------------------------------------------------------
	Misc
	---------------------------------------------------------------------------]]
	function ENT:Drop()
		local dropPos = self:GetPos() + self:GetForward()
		local fireBall = CreateVFireBall(self.life, self.feed, dropPos, Vector(), self:GetOwner())
		self:Remove()

		return fireBall
	end

	function ENT:IsPotentiallyVisible()
		local cluster = self.cluster

		if cluster then
			return cluster.PVSLOD or true
		else
			return true
		end
	end

	function ENT:ImprovePlacement(targetState, parent)
		if not parent then
			parent = self.parent
		end

		local forward = self:GetForward()
		local pos = self:GetPos()
		local ignoreFraction = not parent:IsWorld()
		local offset

		if ignoreFraction then
			offset = Vector()
		else
			offset = forward
		end

		local tracePos = pos + offset
		local traceLen = 16.5
		local traceOffset = vFireBaseRadius(targetState) * 0.4
		local traceDir = forward * -traceLen
		local up = self:GetUp()
		local down = -up
		local right = self:GetRight()
		local left = -right
		-- We won't be able to improve if two opposite sides aren't determined 'good'
		local upTr = util.QuickTrace(tracePos + up * traceOffset, traceDir, function(ent) return ent == parent end)
		local downTr = util.QuickTrace(tracePos + down * traceOffset, traceDir, function(ent) return ent == parent end)
		local goodUp = upTr.Hit and upTr.Entity == parent and (ignoreFraction or upTr.Fraction > 0)
		local goodDown = downTr.Hit and downTr.Entity == parent and (ignoreFraction or downTr.Fraction > 0)
		if not goodUp and not goodDown then return false end
		local rightTr = util.QuickTrace(tracePos + right * traceOffset, traceDir, function(ent) return ent == parent end)
		local leftTr = util.QuickTrace(tracePos + left * traceOffset, traceDir, function(ent) return ent == parent end)
		local goodRight = rightTr.Hit and rightTr.Entity == parent and (ignoreFraction or rightTr.Fraction > 0)
		local goodLeft = leftTr.Hit and leftTr.Entity == parent and (ignoreFraction or leftTr.Fraction > 0)
		if not goodRight and not goodLeft then return false end
		-- We're good, find the average vector
		local sum = 0
		local sumVec = Vector()

		if goodUp then
			sum = sum + 1
			sumVec = sumVec + upTr.HitPos
		end

		if goodDown then
			sum = sum + 1
			sumVec = sumVec + downTr.HitPos
		end

		if goodRight then
			sum = sum + 1
			sumVec = sumVec + rightTr.HitPos
		end

		if goodLeft then
			sum = sum + 1
			sumVec = sumVec + leftTr.HitPos
		end

		if sum > 0 then
			local newPos = sumVec / sum
			tracePos = newPos + offset

			-- Fill the rest
			if not goodUp then
				upTr = util.QuickTrace(tracePos + up * traceOffset, traceDir, function(ent) return ent == parent end)
				goodUp = upTr.Hit and upTr.Entity == parent and (ignoreFraction or upTr.Fraction > 0)
				if not goodUp then return false end
			end

			if not goodDown then
				downTr = util.QuickTrace(tracePos + down * traceOffset, traceDir, function(ent) return ent == parent end)
				goodDown = downTr.Hit and downTr.Entity == parent and (ignoreFraction or downTr.Fraction > 0)
				if not goodDown then return false end
			end

			if not goodRight then
				rightTr = util.QuickTrace(tracePos + right * traceOffset, traceDir, function(ent) return ent == parent end)
				goodRight = rightTr.Hit and rightTr.Entity == parent and (ignoreFraction or rightTr.Fraction > 0)
				if not goodRight then return false end
			end

			if not goodLeft then
				leftTr = util.QuickTrace(tracePos + left * traceOffset, traceDir, function(ent) return ent == parent end)
				goodLeft = leftTr.Hit and leftTr.Entity == parent and (ignoreFraction or leftTr.Fraction > 0)
				if not goodLeft then return false end
			end

			if goodUp and goodDown and goodRight and goodLeft then
				-- Don't change the forward height
				if newPos ~= pos then
					-- Intersect with ray approach
					local fixedPos = util.IntersectRayWithPlane(newPos, forward, pos, forward)

					if fixedPos then
						newPos = fixedPos
					end
					-- Trace approach
					-- local fixTrace = util.QuickTrace(newPos + self:GetForward() * 10, -self:GetForward() * 10, hitParent(ent, parent))
					-- if fixTrace.Hit then
					-- 	newPos = fixTrace.HitPos
					-- end
				end

				return true, newPos
			end
		else
			return false
		end
	end

	function ENT:UpdateCollisionBounds(state)
		local col = vFireBaseRadius(state) * 0.2
		-- Update trigger bounds to damage whatever is close, but given enough time for players to escape
		self:SetCollisionBounds(Vector(-col, -col, -col), Vector(col, col, col))
		self:UseTriggerBounds(true, col)
	end

	--[[-------------------------------------------------------------------------
	Thinking tasks
	---------------------------------------------------------------------------]]
	function ENT:Think()
		-- Don't think at all if we don't have a parent
		if not IsValid(self.parent) and not self.parent:IsWorld() then
			self:Remove()

			return
		end

		local curTime = CurTime()
		-- Don't throttle prioritized fires
		local throttleAdd

		if self:IsPrioritized() then
			throttleAdd = 0
		else
			throttleAdd = vFireThinkThrottle
		end

		if curTime >= self.nextFuelThink then
			self:FuelThink()
			self.nextFuelThink = curTime + vFireFuelThinkTickRate + throttleAdd
		end

		if curTime >= self.nextLifeThink then
			self:LifeThink()
			self.nextLifeThink = curTime + vFireLifeThinkTickRate + throttleAdd
		end

		if curTime >= self.nextEatThink then
			self:EatThink()
			self.nextEatThink = curTime + vFireEatThinkTickRate + throttleAdd
		end

		if curTime >= self.nextBurnThink then
			self:BurnThink()
			self.nextBurnThink = curTime + vFireBurnThinkTickRate -- We're not throttling the burn task
		end

		local ran

		if curTime >= self.nextDropThink then
			if not ran then
				ran = math.random(0, 1000 + vFiresCount * 10)
			end

			self:DropThink(ran)
			self.nextDropThink = curTime + vFireDropThinkTickRate + throttleAdd
		end

		if curTime >= self.nextSpreadThink then
			if not ran then
				ran = math.random(0, 1000 + vFiresCount * 10)
			end

			self:SpreadThink(ran)
			self.nextSpreadThink = curTime + vFireSpreadThinkTickRate + throttleAdd
		end

		-- Our next think will always be the minimal of our next think tasks' timings
		local nextThink = math.Min(self.nextFuelThink, self.nextLifeThink, self.nextEatThink, self.nextBurnThink, self.nextDropThink, self.nextSpreadThink)
		self:NextThink(nextThink)

		return true
	end

	function ENT:FuelThink()
		local take = self.life
		-- Feed ourselves from the parent
		local fuel = vFireTakeFuel(self.parent, take * 2)

		if fuel > 0 then
			self.feed = self.feed + fuel
		else
			-- Take feed from the cluster, but only if we're new enough (we want to promote spreading...)
			if not self.clusterFuels then
				self.clusterFuels = 10
			end

			if self.clusterFuels > 0 then
				local cluster = self.cluster

				if IsValid(cluster) then
					fuel = vFireTakeFuel(self.cluster, take)
					self.feed = self.feed + fuel
					self.clusterFuels = self.clusterFuels - 1
				end
			end
		end

		-- And take fuel from what we're burning
		local ent = table.Random(self.burning)

		if IsValid(ent) then
			local fuel = vFireTakeFuel(ent, take)

			if fuel > 0 then
				self.feed = self.feed + fuel
			end
		end
	end

	function ENT:LifeThink()
		-- Handle life and feed
		if (self.life <= 0) or self:WaterLevel() > 0 then
			-- We're dead, die
			self:Remove()

			return
		else
			-- We're alive, feed ourselves
			local feedSave = 5

			-- We want feed to be used faster on characters
			if vFireIsCharacter(self.parent) then
				feedSave = 1
			end

			local f = math.Min(math.Rand(0, self.feed / feedSave) + 1, self.feed)
			self.feed = self.feed - f

			-- We wish to end fires faster if we have a lot of fires for optimization purposes (but only if we're not prioritized)
			if self:IsPrioritized() then
				self:ChangeLife(self.life + f)
			else
				local decayMul = 1 - (vIsFireFiters() and 0.001 or vFireDecayRate)
				self:ChangeLife(self.life * decayMul + f - vFireLifeThrottle)

				-- If a fire isn't prioritized, we don't give it a second chance in fueling up
				if self.life <= 0 then
					self:Remove()

					return
				end
			end
		end

		-- Change the state, network it only if it changes
		local oldState = self:GetFireState()
		local state = vFireLifeToState(self.life)

		-- We've changed states
		if state ~= oldState then
			-- Relax our state limiters

				if state <= self.stateDown and state > self.stateUp then
					local canGrow, newPos

					while not canGrow do
						if state <= self.stateUp then break end
						canGrow, newPos = self:ImprovePlacement(state)

						-- We can grow, relax our stateUp
						if canGrow then
							self.stateUp = state -- stateUp moves upwards
							-- And set our improved position
							self:SetPos(newPos)
						else -- We can't grow, relax our stateDown
							-- Did we fail at even the smallest state?
							if state == 1 then break end -- Do nothing
							self.stateDown = state - 1 -- stateDown moves downwards
							-- Update our state and try again
							state = self.stateDown
						end
					end
			end

			self:SetFireState(state)
			self:UpdateCollisionBounds(state)
		end
	end

	function ENT:EatThink()
		-- Eat up the nearest smaller fire if it's close enough (good for optimization),
		-- but only if we're not on a character, for animation/fidelity purposes
		if not vFireIsCharacter(self.parent) then
			local closestSmallerFire, closestSmallerFireDist = self:GetClosestSmallerFire()

			if IsValid(closestSmallerFire) and closestSmallerFireDist and closestSmallerFireDist <= vFireBaseRadius(self:GetFireState()) * 0.7 then
				self:Eat(closestSmallerFire)
			end
		end
	end

	function ENT:BurnThink()
		local damageEnabled = vFireEnableDamage and vFireDamageMultiplier > 0
		-- Who is the owner of the fire? This will likely be the doer of the damage
		local owner = self:GetOwner()

		if not IsValid(owner) then
			owner = nil
		end

		-- How much damage are we doing this burn cycle?
		local amount = self.life * math.Rand(0.01, 0.08) * vFireDamageMultiplier

		-- Loop through whatever we're burning
		for k, ent in pairs(self.burning) do
			if IsValid(ent) then
				-- Don't burn players that are in vehicles
				if ent:IsPlayer() and ent:InVehicle() and not vFireEnableDamageInVehicles then continue end

				if damageEnabled then
					-- Create the damage information
					local dmg = DamageInfo()

					-- Decide what this entity's best damage case should be... and cache it
					if ent.vFireDamageData == nil then
						vFireSetDamageData(ent)
					end

					if not ent.vFireDamageData then continue end
					dmg:SetDamage(amount * ent.vFireDamageData.dmgMul)
					dmg:SetDamageType(ent.vFireDamageData.dmgType)
					-- Who's in charge of doing the burning?
					local doer = owner or ent
					dmg:SetAttacker(doer)
					dmg:SetDamageType(DMG_BURN)

					if ent.vFireDamageData.inflict then
						dmg:SetInflictor(doer) -- Not passing an inflictor can cause crashes on entities that want one
					end

					ent:TakeDamageInfo(dmg)
				end

				-- If we're burning a character, use the oppurtunity to spread to it
				if vFireIsCharacter(ent) and vFireEnableSpread and (ent:IsPlayer() and math.random(1, 4) == 1 or not ent:IsPlayer()) then
					-- If we're burning an NPC, spread to it, if it's a player, lower the chance of spread
					local newFeed = self.feed + vFireTakeFuel(ent, 12)

					if newFeed > 0 then
						CreateVFire(ent, ent:GetPos(), Vector(), newFeed, self)
					end
				end
			else
				-- The entity isn't valid, use the loop's oppurtunity to remove it
				self.burning[k] = nil
			end
		end

		-- Damage the parent as well (it's not in our burning table)
		local parent = self.parent

		if damageEnabled and not parent:IsWorld() then
			local dmg = DamageInfo()

			-- Decide what this entity's best damage case should be... and cache it
			if parent.vFireDamageData == nil then
				vFireSetDamageData(parent)
			end

			if not parent.vFireDamageData then return end
			dmg:SetDamage(amount * parent.vFireDamageData.dmgMul)
			dmg:SetDamageType(parent.vFireDamageData.dmgType)
			-- A workaround to find the doer of the damage
			local doer

			-- We're about to die, register the actual owner for the kill to register...
			if parent:Health() - dmg:GetDamage() <= 0 then
				doer = owner or parent
			else -- Set the attacker to itself, this makes NPCs have better reaction sounds... :/
				doer = parent
			end

			dmg:SetAttacker(doer)

			if parent.vFireDamageData.inflict then
				dmg:SetInflictor(doer) -- Not passing an inflictor can cause crashes on entities that want one
			end

			dmg:SetDamageType(DMG_BURN)
			-- Finalize
			parent:TakeDamageInfo(dmg)
		end

		-- If we're on a player, drop (randomly) but only if the player has moved a certain distance
		if parent:IsPlayer() then
			if not self.stickToPlayer then
				self.stickToPlayer = math.random(1, self:GetFireState())
			end

			if self.stickToPlayer > 0 then
				self.stickToPlayer = self.stickToPlayer - 1
			else
				self:Drop()
			end
		end
	end

	function ENT:DropThink(ran)
		if self.life > 5 then
			for _, v in ipairs(ents.FindInSphere(self:GetPos(), 300)) do
				if IsValid(v) and v:IsPlayer() then
					if v:GetMoveType() == MOVETYPE_NOCLIP or v:HasGodMode() then continue end
					if not DarkRP.GasMask(v) and not DarkRP.IsOutside(v:GetPos()) then
						v:AddTempStat("cough", 15)
						v:AddOxigen(5)
					end
					v.inconfort = true
				end
			end
		end

		if ran < 150 and self.life < 7 then
			if self.cantDrop then return end
			local dropPos = self:GetPos() + self:GetForward()
			local tr = util.QuickTrace(dropPos, Vector(0, 0, -5))

			if not tr.Hit then
				self:Drop()
			else
				-- We're not mobile, and we can't drop, save further calculations
				self.cantDrop = not vFireIsMobile(self.parent)
			end
		end
	end

	function ENT:SpreadThink(ran)
		-- Attempt to spread
		if vFireEnableSpread then
			if not self:IsPotentiallyVisible() then return end

			-- We only spread if our random variable is below 1000 - the more throttle there is, the higher the probability of ran being >= 1000
			-- and as a result, fire spreading is throttled
			if ran < 1000 then
				local forward = self:GetForward()

				-- Attempt to spread upwards
				if ran < 575 then
					local upwards = Vector(0, 0, 1)
					local dir = upwards + self:GetWindVector() + VectorRand()
					dir = dir * vFireBaseRadius(self:GetFireState())
					local tr = util.QuickTrace(self:GetPos(), dir, self.parent)

					if tr.Hit and tr.Fraction > 0 then
						local ent = tr.Entity
						if vFireIsVFireEnt(ent) then return end
						local newFeed = self.feed + vFireTakeFuel(ent, 12)

						if newFeed > 0 then
							CreateVFire(ent, tr.HitPos, tr.HitNormal, newFeed, self)
						end
					end
				else -- Attempt to spread on the ground
					local mul = vFireBaseRadius(self:GetFireState()) * math.Rand(0.775, 1)
					local dir = forward * -mul
					local ang = self:GetAngles()

					-- We use a constant spread angle to give fire spreading a sort of 'momentum'
					-- This value gets passed on to children fires with a slight offset
					if not self.spreadAng then
						self.spreadAng = math.Rand(0, 360)
					end

					ang:RotateAroundAxis(forward, self.spreadAng)
					local offset = ang:Right() * mul + forward * 2
					local pos = self:GetPos() + offset
					local tr = util.QuickTrace(pos, dir)
					local ent = tr.Entity

					if tr.Hit and (tr.Fraction > 0 or IsValid(ent)) then
						if vFireIsVFireEnt(ent) then return end
						local newFire
						local newFeed = self.feed + vFireTakeFuel(ent, 12)

						if newFeed > 0 then
							newFire = CreateVFire(ent, tr.HitPos, tr.HitNormal, newFeed, self)
						end

						if IsValid(newFire) then
							if self.spreadAng then
								-- Randomize the spread angle of next iterations
								local spreadAngRan = math.Rand(-60, 60)
								-- Pass the spread angle (plust the randomized addition) to the child to preserve momentum
								newFire.spreadAng = self.spreadAng + spreadAngRan
								-- Negate said randomized angle to our own - avoid unnecessary merges in the future
								self.spreadAng = self.spreadAng - spreadAngRan
							end
						else -- We hit something, but we failed to create a fire (likely merged), try again
							self.spreadAng = nil
						end
					else -- We didn't hit, try a different spread angle for next iterations
						self.spreadAng = nil
					end
				end
			end
		end
	end
end

--[[-------------------------------------------------------------------------

	Client Functionalities

---------------------------------------------------------------------------]]
if CLIENT then
	--[[-------------------------------------------------------------------------
	In charge of updating particle systems
	---------------------------------------------------------------------------]]
	function ENT:RedoParticles(state)
		if not IsValid(self) then return end
		local size = vFireStateToSize(state)

		if self.base and self.base:IsValid() then
			self.base:StopEmission()
		end

		if self.flames and self.flames:IsValid() then
			self.flames:StopEmission()
		end

		-- Should we create LOD'ed particles?
		self.visLOD = false
		local LODStr = ""

		if self.LOD == 1 then
			LODStr = "_LOD"
			self.visLOD = true
		end

		-- If we're on an animated surface, such as a player or an NPC, don't create the base
		if vFireIsCharacter(self.parent) then
			self.flames = CreateParticleSystem(self, "vFire_Flames_" .. size .. LODStr, 0, 0)
		else
			-- Spawn the systems in an offset
			local forward = self:GetForward()
			local offSet = forward
			-- Define a particle system offset so they're closer to the ground
			self.base = CreateParticleSystem(self, "vFire_Base_" .. size .. LODStr, 0, 0, offSet * (state - 1))
			-- Have a slight chance (grows the smaller the flame) to make the flames smaller
			-- but that chance is reduced the further we are from an upright slope - small flames on walls look bad
			local chanceForSmallerFlame = -4.5 -- The less the higher the chance

			if forward.z < 1 then
				if forward.z < 0 then
					chanceForSmallerFlame = 0
				else -- We're somewhere in the range between 1 (straight floor) and 0 (upright wall), bother to multiply
					chanceForSmallerFlame = chanceForSmallerFlame * forward.z
				end
			end

			if math.Rand(chanceForSmallerFlame, state) < 0 then
				if state > 1 then
					state = state - 1
					size = vFireStateToSize(state)
					self.flames = CreateParticleSystem(self, "vFire_Flames_" .. size .. LODStr, 0, 0)
				end
			else
				self.flames = CreateParticleSystem(self, "vFire_Flames_" .. size .. LODStr, 0, 0)
			end
		end

		-- Store the state that's actually visible for consistent animations
		self.visState = state
		-- Update our animation as soon as possible for visual consistency
		self:AnimationThink()
	end

	--[[-------------------------------------------------------------------------
	Flame animation tweaks via pull force control point
	---------------------------------------------------------------------------]]
	-- The stateMul table defines how far to set the pull control point for each state
	-- The bigger the distance, the less effect the control point has
	local stateMul = {30, 45, 65, 115, 245, 345, 400}

	-- The minimum flame pull strength, used to avoid dividing by zero
	local minStrength = 1 / 1000000000

	-- Pulls the flames towards a direction, with an optional strength ranging between [0, 1]
	function ENT:FlameSetDirection(dir, strength)
		if IsValid(self.flames) then
			if dir and strength then
				dir:Normalize()
				dir = dir * stateMul[self.visState or self:GetFireState()]
				local pos

				-- The bigger the strength, the closer the control point is
				if strength then
					pos = self:GetPos() + dir / math.Clamp(strength, minStrength, 1)
				else
					pos = self:GetPos() + dir
				end

				vFirePullParticlesToPos(self.flames, pos)
			else -- Reset the flame direction
				vFirePullParticlesToPos(self.flames, Vector())
			end
		end
	end

	-- Pulls the base towards a given point
	function ENT:BasePullToPoint(pos)
		if IsValid(self.base) then
			vFirePullParticlesToPos(self.base, pos)
		end
	end

	--[[-------------------------------------------------------------------------
	In charge of animating assisting elements such as glow and light
	---------------------------------------------------------------------------]]
	ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
	local lightmat = Material("sprites/light_ignorez")
	local lightDecay = 600
	local lightCalls = {}

	for i = 1, vFireMaxState do
		lightCalls[i] = {}
	end

	local glowCalls = {}
	local blue = 10
	local yellow = 100

	-- Used for optimization purposes
	-- local draws = 0
	function ENT:Draw()
		-- We're very harsh with our LODifying, fuck beautiful sprites and glow, we need the FPS
		if self.LOD == 1 then return end
		-- Count how many fires are drawn
		-- draws = draws + 1
		local state = self.visState

		-- We don't want to draw stuff for tiny fires, but we also want a gradual draw fade out
		-- Lerp the animation factor to 0 for tiny fires, proceed as normal for other fires
		if state == 1 then
			self.a = Lerp(FrameTime() * 2, self.a, 0)
		else
			self.a = Lerp(FrameTime() * 2, self.a, math.Rand(0, state) * 5)
		end

		local a = self.a
		-- Only continue if the animation parameter is big enough (save calculations for tiny fires)
		if a < 0.1 then return end
		local pos = self:GetPos() + self:GetForward() * 7
		local aSqrd = a * a

		if vFireEnableGlows then
			local vis = util.PixelVisible(pos, 1, self.pVis)

			-- Only draw the sprite if it'll be visible
			if vis > 0 then
				local glowSize = vis * aSqrd * 6

				-- Load information onto our glow calls table
				table.insert(glowCalls, {
					pos = pos,
					glowSize = glowSize,
					aSqrd = aSqrd
				})
			end
		end

		-- Don't draw lights if we're LODed at all
		if self.LOD then return end

		if vFireEnableLights then
			-- Load information onto our light calls table
			local entIndex = self:EntIndex()

			lightCalls[state][entIndex] = {pos, a, aSqrd * 2}
			-- Position of the light
			-- Brightness
			-- Size
		end
	end

	-- Sum the total fire draws
	-- hook.Add("PostRender", "vFireCountDrawnFires", function()
	-- vFiresDrawn = draws
	-- draws = 0
	-- end)
	-- Draw our glow calls, arguably better than drawing seperate sprites because we
	-- only set our material once?
	hook.Add("PostDrawTranslucentRenderables", "_vFireLightCallbacks", function()
		render.SetMaterial(lightmat)

		for key, glowData in pairs(glowCalls) do
			render.DrawSprite(glowData.pos, glowData.glowSize, glowData.glowSize, Color(255, yellow, blue, math.Min(glowData.aSqrd * 0.85, 255))) -- Position -- Width -- Height (or the other way around) -- Color
		end

		glowCalls = {}
	end)

	-- We need to cache our r_maxdlights ConVar for the sake of performance
	local maxLights = 5


	-- Draw our light calls so that priority is given to larger fires
	hook.Add("Think", "_vFireLightCallbacks", function()
		-- Draw lights from biggest to smallest to prioritize big lights in case of limit breach
		local lightsDrawn = 0

		for state = vFireMaxState, 1, -1 do
			for entIndex, callback in pairs(lightCalls[state]) do
				local dLight = DynamicLight(entIndex)

				if dLight then
					dLight.Pos = callback[1]
					dLight.r = 255
					dLight.g = yellow
					dLight.b = blue
					dLight.Brightness = callback[2] * vFireLightMul
					dLight.Decay = lightDecay
					dLight.Size = callback[3]
					dLight.DieTime = CurTime() + 10
					lightsDrawn = lightsDrawn + 1
					if lightsDrawn >= maxLights then break end
				end
			end

			lightCalls[state] = {}
			if lightsDrawn >= maxLights then break end
		end
	end)

	--[[-------------------------------------------------------------------------
	Thinking tasks
	---------------------------------------------------------------------------]]
	function ENT:Think()
		local curTime = CurTime()
		-- Don't throttle prioritized fires
		local throttleAdd

		if self:IsPrioritized() then
			throttleAdd = 0
		else
			throttleAdd = vFireThinkThrottle
		end

		if curTime >= self.nextClusterThink then
			self:ClusterThink()
			self.nextClusterThink = curTime + vFireClusterThinkTickRate + throttleAdd
		end

		if curTime >= self.nextParticlesThink then
			self:ParticlesThink()
			self.nextParticlesThink = curTime + vFireParticlesThinkTickRate + throttleAdd
		end

		if curTime >= self.nextAnimationThink then
			self:AnimationThink()
			self.nextAnimationThink = curTime + vFireAnimationThinkTickRate + throttleAdd
		end

		-- Our next think will always be the minimal of our next think tasks' timings
		local nextThink = math.Min(self.nextClusterThink, self.nextParticlesThink, self.nextAnimationThink)
		-- We would like to introduce some timing differences between fires to avoid obvious update intervals
		local ranTime = math.Rand(-0.1, 0.1)
		self:SetNextClientThink(nextThink + ranTime)
		-- We wish to override ticking rate

		return true
	end

	function ENT:ClusterThink()
		-- Add to a nearby fire cluster if we aren't in one yet
		local netCluster = self:GetNW2Entity("FireCluster")

		if IsValid(netCluster) and netCluster.AddFire and (not self.cluster or self.cluster ~= netCluster) then
			netCluster:AddFire(self)
		end

		local p = self:GetPos()
		if not DarkRP.IsOutside(p) and self:GetFireState() > 2 then
			if not self.smoke_ef then
				self.smoke_ef = ParticleEmitter(p)
			end

			for i = 1, 10 do
				local particle = self.smoke_ef:Add("particle/particle_smokegrenade", p + Vector(0,0,15) + VectorRand() * 25)
				particle:SetVelocity(VectorRand() * 50)
				particle:SetDieTime(math.random(50,85))
				particle:SetStartAlpha(255)
				particle:SetEndAlpha(0)
				particle:SetColor(55, 55, 55)
				particle:SetStartSize(math.random(10,35))
				particle:SetEndSize(60)
				particle:SetRoll(math.Rand(0, 360))
				particle:SetAirResistance(120)
				particle:SetCollide(true)
				particle:SetBounce(0.2)
				particle:SetGravity(VectorRand() * 15)
			end
		end
	end

	function ENT:ParticlesThink()
		-- Check if we should LOD up
		if IsValid(self.cluster) then
			-- Use the cluster LOD to avoid LOD calculations for every fire
			self.LOD = self.cluster.LOD
		else
			self.LOD = vFireGetLOD(self)
		end

		local shouldRedoParticles = false
		-- Handle state changes
		local lastState = self.lastState
		local state = self:GetFireState()
		self.lastState = state

		-- We changed states
		if state ~= lastState then
			shouldRedoParticles = true


			if not self.visLOD and math.random(1, 3) == 1 then
				local lifePercent = state * math.Rand(0.5, 1.25) / vFireMaxState
				sound.Play("ambient/fire/mtov_flame2.wav", self:GetPos(), 80, 140 - 100 * lifePercent, math.min(lifePercent, 1)) -- Sound -- Position -- Level -- Pitch -- Volume
			end


			-- Make sure we'll always draw ourselves
			local renderSize = state * 25
			self:SetRenderBounds(Vector(0, 0, 0), Vector(0, 0, 0), Vector(renderSize, renderSize, renderSize))
		end

		local shouldParticlesLOD = false

		if self.LOD == 1 then
			shouldParticlesLOD = true
		end

		if shouldParticlesLOD ~= self.visLOD then
			shouldRedoParticles = true
		end

		if shouldRedoParticles then
			self:RedoParticles(state)
		end
	end

	function ENT:AnimationThink()
		-- Pull the base towards the center point for best animations, and increase the pull
		-- the more we're not upright
		local forward = self:GetForward()
		local mul = (1 - forward.z) * 15 + 1
		self:BasePullToPoint(self:GetPos() + forward * mul)
		-- Handle directions
		local pullDir = Vector()
		local pullStrength = 0
		-- Test for wind direction
		local windVec = self:GetWindVector()
		local windExposure = windVec:Length()

		-- If the fire is facing towards or away from the wind direction, don't be affected
		if windExposure > 0.1 then
			local windProd = windVec:Dot(forward)
			local prodMul = 1 - math.abs(math.Clamp(windProd, -1, 1))
			local windMul = prodMul * windExposure
			pullDir = windVec * windMul
			pullStrength = windMul
		end

		-- Bias our direction if we're not upright to prevent flames from
		-- clipping into walls
		local upSideDownMul = -forward.z

		if upSideDownMul > 0 then
			pullDir = pullDir + forward * upSideDownMul
			pullStrength = pullStrength + upSideDownMul
		end

		-- Vector zero will cause fire to collapse on itself
		if pullDir and pullDir ~= Vector(0, 0, 0) and pullStrength ~= 0 then
			self.lastFlameDir = pullDir
			self:FlameSetDirection(pullDir, pullStrength)
		else
			-- Passing nothing means resetting the flame direction
			self:FlameSetDirection()
		end
	end
end