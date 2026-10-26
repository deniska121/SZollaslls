--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/simfphys/view.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function GetViewOverride(ent)
	if not IsValid(ent) then return Vector(0, 0, 0) end

	if not ent.customview then
		local vehiclelist = list.Get("simfphys_vehicles")[ent:GetSpawn_List()]

		if vehiclelist then
			ent.customview = vehiclelist.Members.FirstPersonViewPos or Vector(0, -9, 5)
		else
			ent.customview = Vector(0, -9, 5)
		end
	end

	return ent.customview
end

hook.Add("CalcVehicleView", "simfphysViewOverride", function(Vehicle, ply, view)
	if IsValid(Vehicle) and Vehicle:GetNW2String("sit_anim", "") ~= "" and not Vehicle:GetThirdPersonMode() then

		local i = ply:LookupAttachment("eyes")
		if not i then return end
		local att = ply:GetAttachment(i)
		if not att then return end
		view.origin = att.Pos
		if not view_ang then
			view_ang = att.Ang
		else
			view_ang = LerpAngle(FrameTime() * 2, view_ang, att.Ang)
		end

		view.angles = view_ang

		return view
	end

	local vehiclebase = ply:GetSimfphys()
	if not IsValid(vehiclebase) then return end
	local IsDriverSeat = ply:IsDrivingSimfphys()
	if Vehicle.GetThirdPersonMode == nil or ply:GetViewEntity() ~= ply then return end
	ply.simfphys_smooth_out = 0

	vehiclebase.speed = vehiclebase:GetVelocity():LengthSqr()
	local speed = (vehiclebase.speed / 750005)

	if not Vehicle:GetThirdPersonMode() then
		view.fov = math.Clamp(Lerp(0.01, view.fov, math.Round(80 + speed * 1.1)), 80, 110)
		local viewoverride = GetViewOverride(vehiclebase)
		local X = viewoverride.X
		local Y = viewoverride.Y
		local Z = viewoverride.Z
		view.origin = IsDriverSeat and view.origin + Vehicle:GetForward() * X + Vehicle:GetRight() * Y + Vehicle:GetUp() * Z or view.origin + Vehicle:GetUp() * 5
		return view
	end

	-- if vehiclebase:GetNW2Int("BrokenGlass", 0) > 0 then
	-- 	if view.angles.y < 0 then
	-- 		view.angles.y = math.Clamp(view.angles.y, -180, -150)
	-- 	else
	-- 		view.angles.y = math.Clamp(view.angles.y, 150, 180)
	-- 	end
	-- end

	view.fov = math.Clamp(Lerp(0.01, 75 + 30 * speed, 90), 75, 90)
	local mn, mx = vehiclebase:GetRenderBounds()
	local bounds = (mn - mx):Length()

	if vehiclebase.VHL.CameraDist then
		bounds = bounds + vehiclebase.VHL.CameraDist
	end

	if vehiclebase.VHL.CameraZ then
		mx.z = mx.z + vehiclebase.VHL.CameraZ
	end

	local radius = bounds - 70
	radius = math.Clamp(radius, bounds / 2, bounds)
	local TargetOrigin = vehiclebase:LocalToWorld(Vector(0,0,mx.z - 20)) + (view.angles:Forward() * -radius)
	local WallOffset = 4

	local tr = util.TraceHull({
		start = view.origin,
		endpos = TargetOrigin,
		filter = function(e)
			local c = e:GetClass()
			local collide = not c:StartWith("prop_physics") and not c:StartWith("prop_dynamic") and not c:StartWith("prop_ragdoll") and not e:IsVehicle() and not c:StartWith("gmod_") and not c:StartWith("player")
			return collide
		end,
		mins = Vector(-WallOffset, -WallOffset, -WallOffset),
		maxs = Vector(WallOffset, WallOffset, WallOffset),
	})

	view.origin = tr.HitPos
	view.drawviewer = true


	if tr.Hit and not tr.StartSolid then
		view.origin = view.origin + tr.HitNormal * WallOffset
	end

	return view
end)