--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
include("shared.lua")
MWBASE_STENCIL_REFVALUE = 69
CreateClientConVar("mgbase_rig", "chands", true, false, "Change first person arms rig.")
CreateClientConVar("mgbase_rig_skin", "0", true, false, "Change first person arms rig skin.", 0)
CreateClientConVar("mgbase_gloves", "", true, false, "Change first person arms gloves.")
CreateClientConVar("mgbase_gloves_skin", "0", true, false, "Change first person arms gloves.", 0)
CreateClientConVar("mgbase_toggleaim", "0", true, true, "Hold to aim.", 0, 1)
CreateClientConVar("mgbase_autoreload", "1", true, true, "Toggle auto reload.", 0, 1)
CreateClientConVar("mgbase_aimassist", "1", true, true, "Toggle aim assist.", 0, 1)
CreateClientConVar("mgbase_manualrechamber", "0", true, true, "Toggle manual rechambering.", 0, 1)
CreateClientConVar("mgbase_fx_blur", "0", true, false, "Toggle first person blur.", 0, 1)
CreateClientConVar("mgbase_fx_smoke", "0", true, false, "Toggle barrel smoke.", 0, 1)
CreateClientConVar("mgbase_fx_laser_weaponcolor", "0", true, false, "Toggle sandbox weapon color usage for lasers.", 0, 1)
CreateClientConVar("mgbase_fx_vmfov", "1", true, false, "Change viewmodel FOV.", 0.1, 2)
CreateClientConVar("mgbase_fx_vmfov_ads", "1", true, false, "Change viewmodel FOV (only when aiming).", 0.1, 2)
CreateClientConVar("mgbase_hud_xhaircolor", "255 255 255", true, false, "Crosshair color.", 0, 1)
CreateClientConVar("mgbase_hud_xhair", "1", true, false, "Toggle crosshair.", 0, 1)
CreateClientConVar("mgbase_hud_firemode", "1", true, false, "Toggle firemode HUD.", 0, 1)
CreateClientConVar("mgbase_hud_sights", "1", true, false, "Toggle sights HUD.", 0, 1)
CreateClientConVar("mgbase_hud_flashlight", "1", true, false, "Toggle flashlight HUD.", 0, 1)
CreateClientConVar("mgbase_debug_freeview", "0", false, false, "Toggle debug free view.", 0, 1)
CreateClientConVar("mgbase_debug_crosshair", "0", false, false, "Toggle debug crosshair for ironsights.", 0, 1)
CreateClientConVar("mgbase_debug_disablebreathing", "0", false, false, "Toggle breathing.", 0, 1)
CreateClientConVar("mgbase_debug_vmrender", "1", false, false, "Toggle viewmodel render.", 0, 1)
CreateClientConVar("mgbase_debug_wmrender", "1", false, false, "Toggle worldmodel render.", 0, 1)
CreateClientConVar("mgbase_debug_freezeanim", "0", false, false, "Freeze viewmodel animations.", 0, 1)
CreateClientConVar("mgbase_debug_animdelta", "0", false, false, "Scrub the current animation on the viewmodel.", 0, 1)
CreateClientConVar("mgbase_presetspawnmethod", "0", true, false, "Spawn preset method: 0 = none, 1 = random, 2 = random default, 3 = random favorite")

net.Receive("mgbase_anim", function()
	local seqIndex = net.ReadString()
	local weapon = net.ReadEntity()
	local force = net.ReadBool()
	local cycle = net.ReadFloat()

	if (weapon == NULL) then return end
	if (not weapon.PlayViewModelAnimation) then return end

	if (weapon:IsCarriedByLocalPlayer()) then
		if force or game.SinglePlayer() then
			weapon:PlayViewModelAnimation(seqIndex, nil, cycle, true)
		end
	else
		weapon:PlayViewModelAnimation(seqIndex, nil, cycle)
	end
end)

net.Receive("mgbase_tpanim", function()
	local slot = net.ReadUInt(2)
	local anim = net.ReadInt(12)
	local ply = net.ReadEntity()
	if (ply == NULL) then return end
	ply:AnimRestartGesture(slot, anim, true)
end)

net.Receive("mgbase_customize_att_precache", function()
	local weapon = net.ReadEntity()
	local atts = net.ReadTable()
	if IsValid(weapon) then
		weapon.att_saved = atts
	end
end)

net.Receive("mgbase_customize_att_cl", function(len, ply)
	local weapon = net.ReadEntity()
	local attIndex = net.ReadInt(8)
	local slotIndex = net.ReadInt(8)
	local reset_ign = net.ReadBool()
	if (IsValid(weapon)) and weapon.Attach then
		weapon:Attach(attIndex, slotIndex, reset_ign)
	end
end)