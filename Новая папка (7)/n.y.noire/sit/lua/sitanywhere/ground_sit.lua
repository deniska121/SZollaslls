--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/sit/lua/sitanywhere/ground_sit.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

SitAnywhere = SitAnywhere or {}
SitAnywhere.GroundSit = true
local TAG = "SitAnyG_"

hook.Add("SetupMove", TAG .. "SetupMove", function(ply, mv)
	local butts = mv:GetButtons()
	if not ply:GetNWBool(TAG) then return end
	local getUp = bit.band(butts, IN_JUMP) == IN_JUMP or bit.band(butts, IN_DUCK) == IN_DUCK or ply:GetMoveType() ~= MOVETYPE_WALK or ply:InVehicle() or not ply:Alive()

	if SERVER and getUp and (not ply.LastSit or ply.LastSit < CurTime()) then
		ply:SetNWBool(TAG, false)
	end

	butts = bit.bxor(bit.bor(butts, bit.bor(IN_JUMP, IN_DUCK)), IN_JUMP)
	mv:SetButtons(butts)
	mv:SetSideSpeed(0)
	mv:SetForwardSpeed(0)
	mv:SetUpSpeed(0)
end)

local standing_pose = {
	[1] = "pose_standing_01",
	[2] = "pose_standing_02",
	[3] = "menu_combine",
	[4] = "idle_all_scared",
	[5] = "idle_all_angry",
	[6] = "lineidle01",
	[7] = "lineidle02",
	[8] = "lineidle03",
	[9] = "lineidle04",
}

local ducking_pose = {
	"pose_ducking_01",
	"pose_ducking_02",
	"sit_zen",
	"idle_all_cower",
	"sit_ground",
	"pose_sitting0",
	"pose_sitting1",
	"wos_uap_mocap_soft_bounce_1",
	"wos_uap_mocap_soft_bounce_2",
	"wos_uap_mocap_soft_bounce_4",
	"wos_uap_mocap_soft_bounce_13",
	"wos_uap_mocap_soft_bounce_15",
	"pose_sitting0",
	"apcarrestidle",
	"d1_town05_wounded_idle_1",
	"lying_down",
	"d2_coast03_postbattle_idle02",
	"pullrope2idle",
	"d1_town05_wounded_idle_2",
	"ss_alyx_move_post",
	"d1_town05_leon_lean_table_idle",
	"sitcouchknees1",
	"pose_againstwall",
	"wos_uap_mocap_soft_bounce_1",
	"wos_uap_mocap_soft_bounce_2",
	"wos_uap_mocap_soft_bounce_3",
	"wos_uap_mocap_soft_bounce_4",
	"wos_uap_mocap_soft_bounce_5",
	"wos_uap_mocap_soft_bounce_6",
	"wos_uap_mocap_soft_bounce_7",
	"wos_uap_mocap_soft_bounce_8",
	"wos_uap_mocap_soft_bounce_9",
	"wos_uap_mocap_soft_bounce_10",
	"wos_uap_mocap_soft_bounce_11",
	"wos_uap_mocap_soft_bounce_12",
	"wos_uap_mocap_soft_bounce_13",
	"wos_uap_mocap_soft_bounce_14",
	"wos_uap_mocap_soft_bounce_15",
	"wos_uap_mocap_soft_bounce_16",
	"wos_uap_mocap_soft_bounce_17",
}

local pose_weapons = {
	["keys"] = true,
}

hook.Add("TranslateActivity", TAG .. "TranslateActivity", function(ply, act)
	if act == 33 and ply:GetVelocity():LengthSqr() > 10000 then
		ply.drawlocalply = true

		if SERVER and (ply:getDarkRPVar("fanim_n") ~= "jump_holding_land" or (ply:getDarkRPVar("fanim") or 0) < CurTime()) then
			DarkRP.ForceAnimation(ply, "jump_holding_land", 1)
		end
	end
end)

hook.Add("CalcMainActivity", TAG .. "CalcMainActivity", function(ply, vel)
	if ply:InVehicle() and IsValid(ply:GetVehicle()) and ply:GetVehicle():GetNW2String("sit_anim", "") ~= "" then return ACT_IDLE, ply:LookupSequence(ply:GetVehicle():GetNW2String("sit_anim")) end

	if ply:getDarkRPVar("fanim") and ply:getDarkRPVar("fanim") >= CurTime() then
		ply.drawlocalply = true

		if ply:getDarkRPVar("fanim_n") then
			return ACT_IDLE, ply:LookupSequence(ply:getDarkRPVar("fanim_n"))
		else
			return
		end
	end

	if vel:IsZero() and not ply:InVehicle() and IsValid(ply:GetActiveWeapon()) and pose_weapons[ply:GetActiveWeapon():GetClass()] and ply:GetActiveWeapon():GetHoldType() == "normal" and (not ply:getDarkRPVar("McPhone.Active") or ply:getDarkRPVar("McPhone.Active") == 0) then
		if ply:GetNWBool(TAG) then
			ply.drawlocalply = true

			return ACT_IDLE, ply:LookupSequence(ply:getDarkRPVar("sa") and ducking_pose[ply:getDarkRPVar("sa")] or "pose_ducking_01")
		elseif not ply:Crouching() and ply:getDarkRPVar("ia") and standing_pose[ply:getDarkRPVar("ia")] then
			if ply.drawlocalply then
				ply.drawlocalply = nil
			end

			return ACT_IDLE, ply:LookupSequence(standing_pose[ply:getDarkRPVar("ia")])
		elseif ply.drawlocalply then
			ply.drawlocalply = nil
		end
	elseif ply.drawlocalply then
		ply.drawlocalply = nil
	end
end)

if SERVER then
	hook.Add("HandleSit", "GroundSit", function(ply, dists, EyeTrace)
		if #dists == 0 and ply:EyeAngles().p > 80 then
			local t = hook.Run("OnGroundSit", ply, EyeTrace)
			if t == false then return end

			if not ply:GetNWBool(TAG) then
				if not ply:getDarkRPVar("sa") or ply:getDarkRPVar("sa") > 6 then
					ply:SetDarkRPVar("sa", 1)
				end

				ply:SetNWBool(TAG, true)
				ply.LastSit = CurTime() + 1

				return true
			end
		end
	end)

	concommand.Add("ground_sit", function(ply, cmd, args)
		if (not ply.LastSit or ply.LastSit < CurTime()) then
			if ply:getDarkRPVar("sa") > 6 then
				ply:SetDarkRPVar("sa", 1)
			end

			ply:SetNWBool(TAG, not ply:GetNWBool(TAG))
			ply.LastSit = CurTime() + 1

			-- if args[1] and tonumber(args[1] or 0) == 4 then
			-- 	ply:SetDarkRPVar("sa", 13)
			-- end
		end
	end)

	concommand.Add("idle_pose", function(ply, cmd, args)
		if DarkRP.NetDelay(ply, 1) then return end
		ply:SetDarkRPVar("ia", math.Clamp(args[1] and tonumber(args[1]) or 0, 0, 9))
	end)

	concommand.Add("idle_sit", function(ply, cmd, args)
		if DarkRP.NetDelay(ply, 1) then return end
		ply:SetDarkRPVar("sa", math.Clamp(args[1] and tonumber(args[1]) or 0, 0, 7))
	end)

	concommand.Add("anim_player", function(ply, cmd, args)
		if DarkRP.NetDelay(ply, 1) or not ply:IsAdmin() or not args[1] then return end

		if args[2] and tonumber(args[2]) and IsValid(Player(tonumber(args[2]))) then
			ply = Player(tonumber(args[2]))
		end
		DarkRP.ForceAnimation(ply, args[1], nil, tonumber(args[3]))
	end)

	concommand.Add("anim_idle", function(ply, cmd, args)
		if not ply:IsAdmin() or not args[1] then return end

		if (not ply.LastSit or ply.LastSit < CurTime()) then
			ply:SetDarkRPVar("sa", math.Clamp(args[1] and tonumber(args[1]) or 0, 0, #ducking_pose))
			ply:SetNWBool(TAG, true)
			ply.LastSit = CurTime() + 1
		end
	end)

	concommand.Add("dance", function(ply, cmd, args)
		if DarkRP.NetDelay(ply, 1) or not args[1] or not MCR.HasTatoo(ply, "d1") then return end
		ply:SetNWBool(TAG, true)
		ply.LastSit = CurTime() + 1
		ply:SetDarkRPVar("sa", 23 + math.Clamp(args[1] and tonumber(args[1]) or 1, 1, 17))
	end)
end