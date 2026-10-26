--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/hungermod/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

GM.Config.thirstspeed = 0.3
GM.Config.thirst = 0.3
GM.Config.hungerspeed = 1
GM.Config.starverate = 2

local meta = FindMetaTable("Player")

function meta:Thirst()
	return self:getDarkRPVar("thirst") or 0
end

function meta:Energy()
	return self:getDarkRPVar("energy") or 0
end

function meta:HasStamina(pers)
	if MCR.HasTatoo(self, "a7") then
		return true
	end

	if DarkRP.GasMask(self, true) then
		pers = pers * 2
	end

	if self:Thirst() >= pers and self:Energy() >= math.Round(pers / 2) then
		return true
	end

	return false
end

function meta:Toxity()
	return self:getDarkRPVar("toxity") or 0
end

function meta:CanConsume()
	if self.eatdelay and self.eatdelay > CurTime() then return false end

	if self:getDarkRPVar("mouth") or (self:getDarkRPVar("face") and MCR.NoConsume[self:getDarkRPVar("face")]) or (self:getDarkRPVar("scba") and self:getDarkRPVar("scba") == 1) then
		DarkRP.notify(self, 1, 2, "Вы не можете использовать это с сигаретой или закрытым лицом")
		self.eatdelay = CurTime() + 2

		return false
	end

	return true
end

function DarkRP.GasMask(ply, s)
	if ply:getDarkRPVar("scba") and ply:getDarkRPVar("scba") ~= 4 and not s then return true end
	if ply:getDarkRPVar("face") and ply:getDarkRPVar("face") == "gasmask" then return true end

	return false
end

DarkRP.FoodSounds = {
	["can"] = "eating_and_drinking/can.wav",
	["soda"] = "eating_and_drinking/soda.wav",
	["whater"] = "eating_and_drinking/drinking.wav",
	["crunch"] = "eating_and_drinking/crunchy.wav",
	["crunch2"] = "eating_and_drinking/crunchy_double.wav",
	["chips"] = "eating_and_drinking/chips.wav",
	["eating"] = "eating_and_drinking/eating.wav",
	["eating2"] = "eating_and_drinking/eating_long.wav",
	["beer"] = "eating_and_drinking/beerbottle.wav",
	["champagne"] = "eating_and_drinking/champagne.wav",
	["straw"] = "eating_and_drinking/straw.wav",
}

function DarkRP.SpawnFood(class, pos, ang, food)
	food = food or DarkRP.Food[class]

	if not food then return false end

	local ent = ents.Create("spawned_food")
	ent:SetPos(pos)
	if ang then
		ent:SetAngles(ang)
	end
	ent:Spawn()
	ent:SetModel(food.model)
	ent:PhysicsInit(SOLID_VPHYSICS)
	ent:SetMoveType(MOVETYPE_VPHYSICS)
	local phys = ent:GetPhysicsObject()
	phys:Wake()

	if food.material then
		ent:SetMaterial(food.material)
	end

	if food.submat then
		for k,v in pairs(food.submat) do
			ent:SetSubMaterial(k, v)
		end
	end

	if food.bgr then
		for k,v in pairs(food.bgr) do
			ent:SetBodygroup(k, v)
		end
	end

	ent.weight = food.weight
	ent.name = food.name

	if food.btime then
		ent.mt = os.time() + food.btime
	end

	if food.uses then
		ent:Setuses(food.uses)
		ent.weight = food.uses * food.weight + (food.conwht or 0)
	end

	ent:Seteclass(class)

	return ent
end

hook.Add( "StartCommand", "Player.Prevent", function( ply, cmd )
	if ply:Alive() and (ply:getDarkRPVar("shock") or ply:getDarkRPVar("HandCuffed")) then
		local CT = CurTime()

		if ply.Shocked and ply.Shocked >= CT then
			cmd:RemoveKey(IN_ATTACK)
			cmd:RemoveKey(IN_ATTACK2)
			cmd:RemoveKey(IN_RELOAD)
			return
		end

		if not ply.Shocked or ply.Shocked + 0.5 < CT then ply.Shocked = CT + math.Rand(0.5,1.5) end
	end
end)

if CLIENT then
	hook.Add( "AdjustMouseSensitivity", "Player.Prevent", function( sen )
		if LocalPlayer():getDarkRPVar("shock") then
			return 0.1
		end
	end)

	local ad
	local lj = 0
	hook.Add("CreateMove", "HungerMode.CreateMove", function(move)
		if LocalPlayer():GetMoveType() == MOVETYPE_NOCLIP or IsValid(LocalPlayer().pk_pill_ent) then return end

		local gn = LocalPlayer():IsOnGround()
		local CT = CurTime()

		if move:KeyDown(IN_DUCK) and not gn then
			ad = true
		end

		if ad then
			move:AddKey(IN_DUCK)
		end

		if ad and gn then
			ad = nil
		end

		if lj > CT or LocalPlayer():getDarkRPVar("fracture") or LocalPlayer():getDarkRPVar("shock") then
			move:RemoveKey(IN_JUMP)
		end

		if move:KeyDown(IN_JUMP) and not LocalPlayer():OnGround() then
			lj = CT + 1
		end
	end)
end