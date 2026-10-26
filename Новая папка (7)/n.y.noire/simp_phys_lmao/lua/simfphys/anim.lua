--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/simfphys/anim.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local un_an = {
	{"sitchairtable1", Vector(9,0,-15)},
	{"sitchair1", Vector(0,0,-21)}
}

hook.Add("CalcMainActivity", "simfphysSeatActivityOverride", function(ply)
	if not IsValid(ply:GetSimfphys()) then return end

	if ply.m_bWasNoclipping then
		ply.m_bWasNoclipping = nil
		ply:AnimResetGestureSlot(GESTURE_SLOT_CUSTOM)

		if CLIENT then
			ply:SetIK(true)
		end
	end

	local IsDriverSeat, Sit = ply:IsDrivingSimfphys()
	ply.CalcIdeal = ACT_HL2MP_SIT
	local anim = (IsDriverSeat and Sit:GetNW2Int("pPodAnim") == 2) and "drive_airboat" or "drive_jeep"
	ply.CalcSeqOverride = IsDriverSeat and ply:LookupSequence(anim) or -1

	if ply:getDarkRPVar("unconscious") then
		local anm = un_an[IsDriverSeat and 1 or 2]
		local seqid = ply:LookupSequence(anm[1])
		if seqid ~= -1 then
			ply.CalcSeqOverride = seqid
			if not ply.ChangeSitPos then
				ply.ChangeSitPos = true
				ply:SetLocalPos(anm[2])
			end
		end
		return ply.CalcIdeal, ply.CalcSeqOverride
	end

	if ply.ChangeSitPos then
		ply.ChangeSitPos = nil
		ply:SetLocalPos(Vector(0,0,0))
	end

	if not IsDriverSeat and ply:GetAllowWeaponsInVehicle() and IsValid(ply:GetActiveWeapon()) then
		local holdtype = ply:GetActiveWeapon():GetHoldType()

		if holdtype == "smg" then
			holdtype = "smg1"
		end

		local seqid = ply:LookupSequence("sit_" .. holdtype)

		if seqid ~= -1 then
			ply.CalcSeqOverride = seqid
		end
	end

	return ply.CalcIdeal, ply.CalcSeqOverride
end)

hook.Add("UpdateAnimation", "simfphysPoseparameters", function(ply, vel, seq)
	if CLIENT then
		if not ply:IsDrivingSimfphys() then return end
		local Car = ply:GetSimfphys()
		if not IsValid(Car) then return end
		local Steer = Car:GetVehicleSteer()
		ply:SetPoseParameter("vehicle_steer", Steer)
		ply:InvalidateBoneCache()
		GAMEMODE:GrabEarAnimation(ply)
		GAMEMODE:MouthMoveAnimation(ply)

		return true
	end
end)