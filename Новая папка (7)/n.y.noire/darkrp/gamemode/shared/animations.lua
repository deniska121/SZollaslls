--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/shared/animations.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local Anims = {}
Anims[ACT_GMOD_GESTURE_WAVE] = "Помахать"
Anims[ACT_GMOD_GESTURE_BOW] = "Поклон"
Anims[ACT_GMOD_GESTURE_BECON] = "За мной"
Anims[ACT_SIGNAL_FORWARD] = "Указать"
Anims[ACT_GMOD_GESTURE_AGREE] = "Палец вверх"
Anims[ACT_GMOD_GESTURE_DISAGREE] = "Нет, не так"

Gestures = {
	["g_drop_meleeweapon"] = "сброс",
	["g_frustrated_point_l"] = "Указать",
	["g_frustrated_point"] = "Указать",
	["g_thumbsup"] = "палец вверх",
	["g_salute"] = "честь",
	["g_pointleft_l"] = "указать влево",
	["g_pointright_l"] = "указать вправо",
	["g_point_l"] = "указать прямо",
	["g_plead_01"] = "Умолять",
	["g_medpuct_mid"] = "Руки вниз",
	["g_noway_small"] = "Не может быть",
	["g_noway_big"] = "Охуеть",
	["g_shrug"] = "ХЗ",
	["g_medurgent_mid"] = "Срочно",
	["g_what"] = "чего",
	["g_look"] = "короче",
	["g_wave"] = "за мной",
	["g_look_small"] = "ну вот..",
	["g_lookatthis"] = "глянь",
	["g_righthandroll"] = "ну и вот гворю..",
	["g_righthandheavy"] = "так вот",
	["g_righthandpoint"] = "и вот то",
	["g_lefthandmotion"] = "позвони мне",
	["g_righthandmotion"] = "вон тот сзеди",
	["g_puncuate"] = "вот",
	["g_fist"] = "кулак",
	["g_lhandease"] = "притормози",
	["g_palm_out_r"] = "стой",
	["g_fist_swing_across"] = "так держать",
	["g_point_swing"] = "точно",
	["g_point_swing_across"] = "точно (больше)",
	["g_mid_relaxed_fist_accent"] = "внимание",
	["g_present"] = "презент",
	["g_overhere_left"] = "головой влево",
	["g_overhere_right"] = "головой вправо",
	["hg_nod_right"] = "кивок вправо",
	["hg_nod_left"] = "кивок влево",
	["hg_puncuate_down"] = "кивок да",
	["hg_headshake"] = "кивок нет",
	["react_blast"] = "react_blast",
	["g_clap"] = "хлопает",
	["g_rarmpump"] = "кулак вверх",
	["overheat_2h"] = "overheat_2h",
	["reload_ar2_cell"] = "reload_ar2_cell",
}

DarkRP.Anims = Anims
hook.Add("CalcMainActivity", "darkrp_animations", function(ply, velocity) -- Using hook.Add and not GM:CalcMainActivity to prevent animation problems
	if ply.anim_DroppingItem then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_DROP, true)
		ply.anim_DroppingItem = nil
	end

	if ply.anim_GivingItem then
		ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_GIVE, true)
		ply.anim_GivingItem = nil
	end

	if CLIENT then
		if ply.SaidHi then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_SIGNAL_GROUP, true)
			ply.SaidHi = nil
		end

		if ply.ThrewPoop then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_THROW, true)
			ply.ThrewPoop = nil
		end

		if ply.shove then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_MELEE_SHOVE_2HAND, true)
			ply.shove = nil
		end

		if ply.knocking then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_HL2MP_GESTURE_RANGE_ATTACK_FIST, true)
			ply.knocking = nil
		end

		if ply.usekeys then
			ply:AnimRestartGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, ACT_GMOD_GESTURE_ITEM_PLACE, true)
			ply.usekeys = nil
		end
	end
end)

function DarkRP.PlayerGesture(ply, anim, lr, scl)
	if SERVER then
		DarkRP.UIEffect(nil, "PlayerGesture", {ply:UserID(), anim, lr, scl})
	end
	local lookup = ply:LookupSequence(anim)
	ply:SetLayerBlendIn(lookup, 1)
	ply:AddVCDSequenceToGestureSlot(6, lookup, scl or 0, not lr)
end

function DarkRP.ForceAnimation(ply, anim, duration, playback_rate)
	if CLIENT or not IsValid(ply) then return end
	playback_rate = playback_rate or 1

	if not duration then
		local seq = anim and ply:LookupSequence(anim) or -1
		duration = seq >= 0 and ply:SequenceDuration(seq) / math.max(playback_rate, 0.01) or 0
	end

	ply:SetDarkRPVar("fanim_n", anim)
	ply:SetDarkRPVar("fanim_r", playback_rate ~= 1 and playback_rate or nil)
	ply:SetDarkRPVar("fanim", CurTime() + duration)

	if anim then
		ply:SetCycle(0)
		DarkRP.UIEffect(nil, "plyAnimSetCycle", {ply:UserID()})
	end
end

function DarkRP.StopAnimation(ply)
	if CLIENT or not IsValid(ply) then return end
	ply:SetDarkRPVar("fanim", nil)
	ply:SetDarkRPVar("fanim_n", nil)
	ply:SetDarkRPVar("fanim_r", nil)
end

hook.Add("UpdateAnimation", "DarkRP_ForceAnimationRate", function(ply)
	local rate = ply:getDarkRPVar("fanim_r")
	if not rate or ply:InVehicle() then return end
	local endtime = ply:getDarkRPVar("fanim")
	if not endtime or endtime < CurTime() then return end

	ply:SetPlaybackRate(rate)
	GAMEMODE:GrabEarAnimation(ply)
	if CLIENT then
		GAMEMODE:MouthMoveAnimation(ply)
	end

	return true -- skip GM:UpdateAnimation, it would overwrite the playback rate
end)

if SERVER then
	local function CustomAnim(ply, cmd, args)
		local Gesture = tonumber(args[1] or 0)
		if not Anims[Gesture] then return end
		if ply:InVehicle() or ply.Restrained or ply.HandsUp then return end
		DarkRP.UIEffect(nil, "_DarkRP_CustomAnim", {ply:UserID(), Gesture})
	end
	concommand.Add("_DarkRP_DoAnimation", CustomAnim)
	return
end

function GM:MouthMoveAnimation( ply )

	local flexes = {
		ply:GetFlexIDByName( "jaw_drop" ),
		ply:GetFlexIDByName( "left_part" ),
		ply:GetFlexIDByName( "right_part" ),
		ply:GetFlexIDByName( "left_mouth_drop" ),
		ply:GetFlexIDByName( "right_mouth_drop" )
	}
	local vol = IsValid(ply.tts) and ply.tts:GetLevel() or 0
	if IsValid(ply.tts) then
		ply.tts:SetPos(ply:GetPos())
	end
	local weight = (ply:IsSpeaking() or vol > 0) and math.Clamp( (ply:VoiceVolume() + vol) * 2, 0, 2 ) or 0

	for k, v in pairs( flexes ) do
		ply:SetFlexWeight( v, weight )
	end

end