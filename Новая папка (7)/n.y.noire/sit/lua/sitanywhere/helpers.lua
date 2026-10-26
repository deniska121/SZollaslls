--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/sit/lua/sitanywhere/helpers.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

SitAnywhere = SitAnywhere or {}

SitAnywhere.NET = {
	["SitWantedAng"] = 0,
	["SitRequestExit"] = 1,
}

SitAnywhere.ClassBlacklist = {
	["gmod_wire_keyboard"] = true,
	["prop_combine_ball"] = true
}

SitAnywhere.DoNotParent = {
	["yava_chunk"] = true
}

SitAnywhere.ModelBlacklist = {}
local EMETA = FindMetaTable"Entity"

function SitAnywhere.GetAreaProfile(pos, resolution, simple)
	local filter = player.GetAll()
	local dists = {}
	local distsang = {}
	local ang_smallest_hori = nil
	local smallest_hori = 90000
	local angPerIt = (360 / resolution)

	for I = 0, 360, angPerIt do
		local rad = math.rad(I)
		local dir = Vector(math.cos(rad), math.sin(rad), 0)
		local trace = util.QuickTrace(pos + dir * 20 + Vector(0, 0, 5), Vector(0, 0, -15000), filter)
		trace.HorizontalTrace = util.QuickTrace(pos + Vector(0, 0, 5), dir * 1000, filter)
		trace.Distance = trace.StartPos:DistToSqr(trace.HitPos)
		trace.Distance2 = trace.HorizontalTrace.StartPos:DistToSqr(trace.HorizontalTrace.HitPos)
		trace.ang = I

		if (not trace.Hit or trace.Distance > 196) and (not trace.HorizontalTrace.Hit or trace.Distance2 > 400) then
			if simple then return true end
			table.insert(dists, trace)
		end

		if trace.Distance2 < smallest_hori and (not trace.HorizontalTrace.Hit or trace.Distance2 > 9) then
			smallest_hori = trace.Distance2
			ang_smallest_hori = I
		end

		distsang[I] = trace
	end

	if simple then return false end

	return dists, distsang, ang_smallest_hori, smallest_hori
end

function SitAnywhere.CheckValidAngForSit(pos, surfaceAng, ang)
	local rad = math.rad(ang)
	local dir = Vector(math.cos(rad), math.sin(rad), 0)

	local trace2 = util.TraceLine({
		start = pos - dir * (20 - .5) + surfaceAng:Forward() * 5,
		endpos = pos - dir * (20 - .5) + surfaceAng:Forward() * -160,
		filter = player.GetAll()
	})

	local hor_trace = util.TraceLine({
		start = pos + Vector(0, 0, 5),
		endpos = pos + Vector(0, 0, 5) - dir * 1600,
		filter = player.GetAll()
	})

	return hor_trace.StartPos:DistToSqr(hor_trace.HitPos) > 100 and trace2.StartPos:DistToSqr(trace2.HitPos) > 196
end

local blacklist = SitAnywhere.ClassBlacklist
local model_blacklist = SitAnywhere.ModelBlacklist

local function inranger(a, b)
	if CLIENT then return true end
	if a > b + 10 then return true end
	return false
end

function SitAnywhere.ValidSitTrace(ply, EyeTrace)
	if not EyeTrace.Hit then return false end
	if EyeTrace.HitPos:DistToSqr(EyeTrace.StartPos) > 5000 then return false end
	local t = hook.Run("CheckValidSit", ply, EyeTrace)
	if t == false or t == true then return t end
	if not EyeTrace.HitWorld and blacklist[string.lower(EyeTrace.Entity:GetClass())] then return false end
	if not EyeTrace.HitWorld and EyeTrace.Entity:GetModel() and model_blacklist[string.lower(EyeTrace.Entity:GetModel())] then return false end

	if not inranger(EyeTrace.HitPos.z, ply:GetPos().z) then return false end

	return true
end

local seatClass = "prop_vehicle_prisoner_pod"
local PMETA = FindMetaTable"Player"

function PMETA:GetSitters()
	local seats, holders = {}, {}

	local function processSeat(seat, depth)
		depth = (depth or 0) + 1

		if IsValid(seat:GetDriver()) and seat:GetDriver() ~= self then
			table.insert(seats, seat)
		end

		for _, v in pairs(seat:GetChildren()) do
			if IsValid(v) and v:GetClass() == seatClass and IsValid(v:GetDriver()) and #v:GetChildren() > 0 and depth <= 128 then
				processSeat(v, depth)
			end
		end
	end

	local plyVehicle = self:GetVehicle()

	if IsValid(plyVehicle) and plyVehicle:GetClass() == seatClass then
		processSeat(plyVehicle)
	end

	for _, v in pairs(self:GetChildren()) do
		if IsValid(v) and v:GetClass() == seatClass then
			processSeat(v)
		end
	end

	for _, v in pairs(ents.FindByClass("sit_holder")) do
		if v.GetTargetPlayer and v:GetTargetPlayer() == self then
			table.insert(holders, v)

			if v.GetSeat and IsValid(v:GetSeat()) then
				processSeat(v:GetSeat())
			end
		end
	end

	return seats, holders
end

function PMETA:IsPlayerSittingOn(ply)
	local seats = ply:GetSitters()

	for _, v in pairs(seats) do
		if IsValid(v:GetDriver()) and v:GetDriver() == self then return true end
	end

	return false
end

function PMETA:GetSitting()
	if not IsValid(self:GetVehicle()) then return false end
	local veh = self:GetVehicle()

	if veh:GetNWBool("playerdynseat", false) then
		local parent = veh:GetParent()

		if IsValid(parent) and parent:GetClass() == "sit_holder" then
			return veh, parent
		else
			return veh
		end
	end

	return false
end

function PMETA:ExitSit()
	if CLIENT then
		if self ~= LocalPlayer() then return end
		net.Start("SitAnywhere")
		net.WriteInt(SitAnywhere.NET.SitRequestExit, 4)
		net.SendToServer()
	else
		local seat, holder = self:GetSitting()
		SafeRemoveEntity(seat)
		SafeRemoveEntity(holder)

		if SitAnywhere.GroundSit and self:GetNWBool("SitGroundSitting", false) then
			self:SetNWBool("SitGroundSitting", false)
		end
	end
end

function EMETA:IsSitAnywhereSeat()
	if self:GetClass() ~= "prop_vehicle_prisoner_pod" then return false end
	if SERVER and self.playerdynseat then return true end

	return self:GetNWBool("playerdynseat", false)
end