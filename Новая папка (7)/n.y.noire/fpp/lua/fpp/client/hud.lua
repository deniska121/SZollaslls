--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/fpp/lua/fpp/client/hud.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

FPP = FPP or {}

surface.CreateFont("TabLarge", {
	size = 17,
	weight = 700,
	antialias = true,
	shadow = false,
	font = "Trebuchet MS"})

hook.Add("CanTool", "FPP_CL_CanTool", function(ply, trace, tool) -- Prevent client from SEEING his toolgun shoot while it doesn't shoot serverside.
	if IsValid(trace.Entity) and not FPP.canTouchEnt(trace.Entity, "Toolgun") then
		return false
	end
end)

-- This looks weird, but whenever a client touches an ent he can't touch, without the code it'll look like he picked it up. WITH the code it really looks like he can't
-- besides, when the client CAN pick up a prop, it also looks like he can.
hook.Add("PhysgunPickup", "FPP_CL_PhysgunPickup", function(ply, ent)
	if not FPP.canTouchEnt(ent, "Physgun") then
		return false
	end
end)

-- Makes sure the client doesn't think they can punt props
hook.Add("GravGunPunt", "FPP_CL_GravGunPunt", function(ply, ent)
	if tobool(FPP.Settings.FPP_GRAVGUN1.noshooting) then return false end
	if IsValid(ent) and not FPP.canTouchEnt(ent, "Gravgun") then
		return false
	end
end)

local surface_SetFont = surface.SetFont
local surface_GetTextSize = surface.GetTextSize
local draw_DrawText = draw.DrawText
-- MSDX may load after FPP, so resolve it at draw time
local function draw_RoundedBox(...) return MSDX.Draw(...) end

local weaponClassTouchTypes = {
	["weapon_physgun"] = "Physgun",
	["weapon_physcannon"] = "Gravgun",
	["gmod_tool"] = "Toolgun",
}

local function FilterEntityTable(eyepos, t)
	local filtered = nil
	local filteredDistance = nil

	for i, ent in ipairs(t) do
		local class = ent:GetClass()
		if ent:IsWeapon() or ent:IsPlayer() or class == "viewmodel" then continue end

		-- Get the entity that is closest by
		local distance = ent:NearestPoint(eyepos):DistToSqr(eyepos)
		if filtered == nil or distance < filteredDistance then
			filtered = ent
			filteredDistance = distance
		end
	end

	return filtered
end

local boxBackground = Color(0, 0, 0, 190)
local canTouchTextColor = Color(255, 150, 0)
local cannotTouchTextColor = Color(255, 8, 0)

local function HUDPaint()
	if not IsValid(LocalPlayer()) or not sAdmin.hasPermission(LocalPlayer(), "can_log") or GetConVar("cl_drawfpphud"):GetInt() == 0 or GetConVar("cl_drawhud"):GetInt() == 0 or LocalPlayer():Team() == 0 then return end
	if FPP.getPrivateSetting("HideOwner") then return end

	--Show the owner:
	local ply = LocalPlayer()
	local eyepos = ply:EyePos()
	local LAEnt2 = ents.FindAlongRay(eyepos, eyepos + EyeAngles():Forward() * 16384)

	local LAEnt = FilterEntityTable(eyepos, LAEnt2)
	if not IsValid(LAEnt) then return end
	-- Prevent being able to see ownership through walls
	local eyeTrace = ply:GetEyeTrace()
	-- GetEyeTrace can return nil before InitPostEntity
	if eyeTrace == nil then return end
	if eyeTrace.HitPos:DistToSqr(eyeTrace.StartPos) < LAEnt:NearestPoint(eyeTrace.StartPos):DistToSqr(eyeTrace.StartPos) then return end

	local weapon = ply:GetActiveWeapon()
	local class = weapon:IsValid() and weapon:GetClass() or ""

	local touchType = weaponClassTouchTypes[class] or "EntityDamage"
	local reason = FPP.entGetTouchReason(LAEnt, touchType)
	if not reason then return end
	local originalOwner = LAEnt:GetNW2String("FPP_OriginalOwner")
	originalOwner = originalOwner ~= "" and (" (previous owner: %s)"):format(originalOwner) or ""
	reason = reason .. originalOwner

	surface_SetFont("MSDFont.16")
	local w = surface_GetTextSize(reason)
	local col = FPP.canTouchEnt(LAEnt, touchType) and canTouchTextColor or cannotTouchTextColor
	local scrH = ScrH()

	draw_RoundedBox(0, 10, scrH / 2, w + 10, 20, boxBackground)
	draw_DrawText(reason, "MSDFont.16", 15, scrH / 2, col, 0)

end
hook.Add("HUDPaint", "FPP_HUDPaint", HUDPaint)