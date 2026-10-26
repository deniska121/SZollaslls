--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/shared/player_class.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PLAYER_CLASS = {}
PLAYER_CLASS.DisplayName = "DarkRP Player Class"
PLAYER_CLASS.TeammateNoCollide = false
PLAYER_CLASS.AvoidPlayers = false

local alc_lerp = 0
local next_alc = 0

function TauntCamera()
	local CAM = {}

	local OutLerp = 1
	local lock_ang, view_ang

	CAM.ShouldDrawLocalPlayer = function(self, ply, on) return on or OutLerp < 1 end

	CAM.CalcView = function(self, view, ply, on)
		if (not ply:Alive() or not IsValid(ply:GetViewEntity()) or ply:GetViewEntity() ~= ply) then
			on = false
		end

		local wp = ply:GetActiveWeapon()

		view.fov = math.Clamp(view.fov, math.min(IsValid(wp) and wp._fov or 70, 70), 110)

		local alc = ply:getDarkRPVar("alcohol") or (ply:getDarkRPVar("nausea") and 15)

		if alc and alc > 1 then
			if next_alc == alc_lerp then
				next_alc = math.random(alc / -20, alc / 20)
			end
			alc_lerp = math.Approach(alc_lerp, next_alc, FrameTime() * alc / 30)

			view.angles = view.angles + Angle(alc_lerp / -2,0,alc_lerp)
		end

		if not on then return end
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
		ply.removehead = true

		return true
	end

	CAM.CreateMove = function(self, cmd, ply, on)
		if ply.noblockcont then return end

		if (not ply:Alive()) then
			on = false
		end

		if not lock_ang then
			lock_ang = cmd:GetViewAngles()
			view_ang = cmd:GetViewAngles()
		end

		if (not on) then if lock_ang then lock_ang = nil end return end

		cmd:SetViewAngles( lock_ang )

		if not ply.drawlocalply then
			cmd:ClearButtons()
			cmd:ClearMovement()
		end

		return true
	end

	return CAM
end

PLAYER_CLASS.TauntCam = TauntCamera()

function PLAYER_CLASS:ShouldDrawLocal()
	if (self.TauntCam:ShouldDrawLocalPlayer(self.Player, (self.Player:IsPlayingTaunt() or self.Player.drawlocalply) and self.Player.removehead)) then return true end
end

function PLAYER_CLASS:CreateMove(cmd)
	if (self.TauntCam:CreateMove(cmd, self.Player, self.Player.drawlocalply or self.Player:IsPlayingTaunt())) then return true end
end

local wp
local checkwps = {
	["keys"] = true
}

function PLAYER_CLASS:CalcView(view)
	if (self.TauntCam:CalcView(view, self.Player, self.Player.drawlocalply or self.Player:IsPlayingTaunt())) then return true end

	if not IsValid(self.Player:GetViewEntity()) or self.Player:GetViewEntity() ~= self.Player then
		return
	end

	if not self.camposz then self.camposz = view.origin.z end

	local i = self.Player:LookupAttachment("eyes")
	local att = self.Player:GetAttachment(i)
	if not att then self.camposz = view.origin.z return end
	if math.abs(math.abs(view.origin.z) - math.abs(self.camposz)) > 100 then self.camposz = view.origin.z return end
	self.camposz = Lerp(0.1, self.camposz, att.Pos.z)

	if not i or self.Player:GetMoveType() == MOVETYPE_NOCLIP then return end

	wp = self.Player:GetActiveWeapon()
	if not IsValid(wp) or (not wp.IsMWwp and not checkwps[wp:GetClass()]) then return end
	if checkwps[wp:GetClass()] and wp.dt and wp.dt.State and wp:GetState() == 2 then return end
	view.origin.z = self.camposz
	return true
end

local nocheck = {
	["gmod_tool"] = true,
	["weapon_physgun"] = true
}

hook.Add("InputMouseApply", "LockToPitchOnly", function( ccmd, x, y, angle )
	if LocalPlayer():getDarkRPVar("dragFixed") then
		angle.yaw = angle.yaw - x / 50
		angle.pitch = math.Clamp( angle.pitch + y / 50, 5, 35 )
		ccmd:SetViewAngles( angle )
		return true
	end

	if LocalPlayer():getDarkRPVar("unconscious") then return true end

	wp = LocalPlayer():GetActiveWeapon()
	if IsValid(wp) and nocheck[wp:GetClass()] then return end
	angle.yaw = angle.yaw - x / 50
	angle.pitch = math.Clamp( angle.pitch + y / 50, -60, 85 )
	ccmd:SetViewAngles( angle )
	return true
end)

local hands = {
	model = "models/cityrp/pm/c_arms.mdl",
	skin = 0,
	body = "0200000"
}

function PLAYER_CLASS:GetHandsModel()
	return hands
end

local black_hands = {
	male = {
		[1] = true,
		[3] = true
	},
	female = {
		[3] = true,
		[5] = true
	}
}

local latin_hands = {
	[4] = {
		[5] = true,
		[6] = true,
		[7] = true,
		[13] = true
	},
	[5] = {
		[11] = true,
	},
	[6] = {
		[11] = true
	},
}

function GM:PlayerSetHandsModel(ply, ent)
	if ply:IsBot() then return end
	if not ply.characters then return end
	local char_id = ply:getDarkRPVar("character")
	local char = ply.characters[char_id]
	local im = char.gender == "male"
	ent:SetModel("models/cityrp/pm/c_arms.mdl")
	ent:SetBodygroup(0, im and 1 or 0)
	ent:SetSubMaterial(0, "gbskins/new_arms_1")

	if black_hands[char.gender][tonumber(char.model or 1)] then
		ent:SetSubMaterial(im and 1 or 0, im and "models/weapons/c_arms_citizen/c_arms_citizen_hands_black" or "gbskins/new_arms_2")
	end

	if im and latin_hands[tonumber(char.model or 1)] and latin_hands[tonumber(char.model or 1)][tonumber(char.face or 1)] then
		ent:SetSubMaterial(1, "models/weapons/c_arms_citizen/c_arms_citizen_hands_black")
	end

	if string.find(ply:GetModel(), "nypd") then
		if not ply:isCP() and ply:GetBodygroup(1) == 1 then
			ent:SetBodygroup(1, 4)

			for i,mat in ipairs(ply:GetMaterials()) do
				if string.find(mat, "body_01") then
					ent:SetSubMaterial(8, ply:GetSubMaterial(i - 1))
					break
				end
			end
			return
		end

		ent:SetBodygroup(1, 2)

		for i,mat in ipairs(ply:GetMaterials()) do
			if string.find(mat, "top2") then
				local find = string.Explode("/", ply:GetSubMaterial(i - 1))
				if not find or not find[5] then continue end
				ent:SetSubMaterial(6, "models/gmodbest/suit/male/" .. find[5])
				break
			end
		end
		return
	end

	local subs = {
		[3] = MCR.GetMatCustom(ply, "top"),
		[4] = MCR.GetMatCustom(ply, "suit"),
		[5] = MCR.GetMatCustom(ply, "shirt"),
		[7] = MCR.GetMatCustom(ply, "coat"),
	}

	for k,v in pairs(subs) do
		if not v then return end
		ent:SetSubMaterial(k, v)
	end

	if ply:GetBodygroup(1) == 2 then
		ent:SetBodygroup(1, 3)
	end

	if string.find(ply:GetModel(), "suit") then
		ent:SetBodygroup(1, 1)
	end
end

function PLAYER_CLASS:Spawn()
	self.Player:SetPlayerColor(Vector(0.05, 0.005, 0.15))
	self.Player:SetWeaponColor(Vector(1, 0.4, 0))
end

player_manager.RegisterClass("player_DarkRP", PLAYER_CLASS, "player_default")