--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/police/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if CLIENT then
	net.Receive("Police.ForceWp", function()
		local wp = net.ReadEntity()
		if not wp or not IsValid(wp) then return end
		input.SelectWeapon(wp)
	end)
end

function DarkRP.GetPolice()
	local lst = {}

	for k, v in pairs(player.GetHumans()) do
		if v:isCP() then
			table.insert(lst, v)
		end
	end

	return lst
end

function DarkRP.GetGroup(gr)
	local lst = {}

	for k, v in pairs(player.GetHumans()) do
		if MRS.GetNWdata(v, "Group") == gr then
			table.insert(lst, v)
		end
	end

	return lst
end

local plyMeta = FindMetaTable("Player")

--[[---------------------------------------------------------------------------
Interface functions
---------------------------------------------------------------------------]]
function plyMeta:isArrested()
	return self:getDarkRPVar("Arrested")
end

function plyMeta:isWanted()
	return self:getDarkRPVar("wanted")
end

function plyMeta:getWantedReason()
	return self:getDarkRPVar("wantedReason")
end

function plyMeta:CanRadio(ply)
	if not IsValid(ply) or not IsValid(self) then return false end
	if not self:Alive() then return false end

	if not GAMEMODE.RadioTeams[self:Team()] or not GAMEMODE.RadioTeams[ply:Team()] then return false end

	if not self:getDarkRPVar("rc_speek") then return false end

	if self:getDarkRPVar("rc") == 10 and MRS.GetNWdata(self, "Rank") and MRS.GetNWdata(self, "Rank") > 5 then return true end

	if self:getDarkRPVar("rc_on") and ply:getDarkRPVar("rc_on") and self:getDarkRPVar("rc") ~= 10 and ply:getDarkRPVar("rc") == self:getDarkRPVar("rc") then
		return true
	else
		return false
	end
end

--[[---------------------------------------------------------------------------
Hooks
---------------------------------------------------------------------------]]
function DarkRP.hooks:canRequestWarrant(target, actor, reason)
	if not reason or string.len(reason) == 0 then return false, DarkRP.getPhrase("vote_specify_reason") end
	if not IsValid(target) then return false, "Указанный игрок не существует" end
	if not IsValid(actor) then return false, "Ошибка 12" end
	if not actor:Alive() then return false, "Вы мертвы" end
	if target.warranted then return false, "Уже есть ордер на обыск" end
	if not actor:isCP() then return false, "Вы не полицейский" end
	if utf8.len(reason) > 100 then return false, "Неверная причина" end

	return true
end

function DarkRP.hooks:canWanted(target, actor, reason)
	if not reason or string.len(reason) == 0 then return false, DarkRP.getPhrase("vote_specify_reason") end
	if not IsValid(target) then return false, "Указанный игрок не существует" end
	if not IsValid(actor) then return false, "Ошиька 12" end
	if not actor:Alive() then return false, "Вы мертвы" end
	if not actor:isCP() then return false, "Вы не полицейский" end
	if target:isWanted() then return false, "Этот человек уже в розыске" end
	if target:isArrested() then return false, "Игрок уже в тюрьме." end
	if utf8.len(reason) > 100 then return false, "Неверная причина" end

	return true
end

function DarkRP.hooks:canUnwant(target, actor)
	if not IsValid(target) then return false, "Указанный игрок не существует" end
	if not IsValid(actor) then return false, "Ошиька 12" end
	if not actor:Alive() then return false, "Вы мертвы" end
	if not actor:isCP() then return false, "Вы не полицейский" end
	if not target:isWanted() then return false, "Этот человек не розыскивается полицией" end
	if not target:Alive() then return false, "Игрок мертв" end
	if MRS.GetPlyRank(actor, "NYPD") < 5 then return false, "Отказ в доступе" end

	return true
end

function DarkRP.hooks:canUnwarrant(target, actor)
	if not IsValid(target) then return false, "Указанный игрок не существует" end
	if not IsValid(actor) then return false, "Ошиька 12" end
	if not actor:Alive() then return false, "Вы мертвы" end
	if not actor:isCP() then return false, "Вы не полицейский" end
	if not target.warranted then return false, "Ордер на обыск не найден" end
	if not target:Alive() then return false, "Игрок мертв" end
	if MRS.GetPlyRank(actor, "NYPD") < 5 then return false, "Отказ в доступе" end
	return true
end

hook.Add("MQS.PreventTaskStart", "DarkRP.MQSArrested", function(ply, id, quest)

	if id == "season1_govern_1" or id == "season1_criminal_1" then
		if MQS.GetDataStored(ply, "episode_1_premium") then
			return false
		end

		local unlocks = MQS.GetDataStored(ply, "episode_1_unlocks") or {}

		if unlocks[id] then return false end

		local token = MQS.GetDataStored(ply, "episode_1_tokens") or 0

		if token < 900 then return true, "Вам нужно 900 ✫ очков прогресса для разблокировки эпизода" end
	end

	if string.sub(id, 1, 4) == "jail" and not ply:isArrested() then return true, "Вы не заключённый" end
end)

hook.Add("MQS.AllowJailTaskStart", "DarkRP.MQSArrested", function(ply, id, quest)
	if string.sub(id, 1, 4) == "jail" then return true end
end)

hook.Add("MW19FireBullet", "DarkRP.AutoArrested", function(wep, ply)
	if not IsValid(ply) or ply:isCP() then return end
	if CLIENT and CURRENT_TERRITORY and CURRENT_TERRITORY.police_zone then return true end

	if CLIENT then return end

	if ply.LastTerritiry and (ply.LastTerritiry.police_zone or ply.LastTerritiry.club_zone) and ply.LastTerritiry:IsInside(ply) then
		if ply.LastTerritiry.police_zone then
			DarkRP.AutoArrest(ply)
		else
			DarkRP.CubKick(ply)
		end
		return true
	end
end)

hook.Add("SetupMove", "DarkRP.Cuffs", function(ply, mv, cmd)
	if not ply:getDarkRPVar("HandCuffed") then return end
	if ply:getDarkRPVar("HandCuffed") == 1 then
		mv:SetMaxClientSpeed(mv:GetMaxClientSpeed() * 0.5)
	end
	local kidnapper = ply.DraggedBy
	if not IsValid(kidnapper) then return end
	if kidnapper == ply then return end
	if kidnapper:GetVelocity():Length2DSqr() < 10 then return end
	local TargetPoint = (kidnapper:IsPlayer() and kidnapper:GetShootPos()) or kidnapper:GetPos()
	local MoveDir = (TargetPoint - kidnapper:GetEyeTrace().HitPos):GetNormal()
	local ShootPos = ply:GetShootPos() + (Vector(0, 0, ply:Crouching() and 0))
	local Distance = 50
	local TargetPos = TargetPoint - (MoveDir * Distance)
	local xDif = math.abs(ShootPos[1] - TargetPos[1])
	local yDif = math.abs(ShootPos[2] - TargetPos[2])
	local zDif = math.abs(ShootPos[3] - TargetPos[3])
	local speedMult = 3 + ((xDif + yDif) * 0.5) ^ 1.4
	local vertMult = math.max((math.Max(300 - (xDif + yDif), -10) * 0.08) ^ 1.01 + (zDif / 2), 0)

	if kidnapper:GetGroundEntity() == ply then
		vertMult = -vertMult
	end

	local TargetVel = (TargetPos - ShootPos):GetNormal() * 10
	TargetVel[1] = TargetVel[1] * speedMult
	TargetVel[2] = TargetVel[2] * speedMult
	TargetVel[3] = TargetVel[3] * vertMult
	local dir = mv:GetVelocity()
	local clamp = 50
	local vclamp = 20
	local accel = 600
	local vaccel = 30 * (vertMult / 50)
	dir[1] = (dir[1] > TargetVel[1] - clamp or dir[1] < TargetVel[1] + clamp) and math.Approach(dir[1], TargetVel[1], accel) or dir[1]
	dir[2] = (dir[2] > TargetVel[2] - clamp or dir[2] < TargetVel[2] + clamp) and math.Approach(dir[2], TargetVel[2], accel) or dir[2]

	if ShootPos[3] < TargetPos[3] then
		dir[3] = (dir[3] > TargetVel[3] - vclamp or dir[3] < TargetVel[3] + vclamp) and math.Approach(dir[3], TargetVel[3], vaccel) or dir[3]
	end

	mv:SetVelocity(dir)
	ply:SetEyeAngles(Angle(0,kidnapper:EyeAngles().y,0))
end)

hook.Add("canKeysUnlock", "DarkRP.Police", function(ply, ent)
	print(MRS.GetPlyRank(ply, "NYPD"))
	if ply:Team() == TEAM_WARDEN and MRS.GetPlyRank(ply, "NYPD") < 2 then
		return false
	end
end)