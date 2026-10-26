--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/fdny_locker.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Шкафчик"
ENT.Author = "Mactavish"
ENT.Spawnable = true

if SERVER then
	function ENT:Initialize()
		self:SetModel("models/props_train_station/clothes_locker_01.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_VPHYSICS)
		self:SetSolid(SOLID_VPHYSICS)
		self:DrawShadow(false)
		local phys = self:GetPhysicsObject()
		phys:Wake()
	end

	function ENT:Use(ply)
		if not IsValid(ply) or ply:Team() ~= 14 or not DarkRP.IsHoldingKeys(ply) then return end
		if DarkRP.UseDelay(ply, 4) then return end

		self:EmitSound("doors/door_metal_thin_open1.wav")

		DarkRP.ForceAnimation(ply, "pickup", 3)
		timer.Simple(1.3, function()
			if not IsValid(ply) or ply:Team() ~= 14 then return end

			if (ply:getDarkRPVar("armorVest") and ply:getDarkRPVar("armorVest") == 3)  then
				ply:EmitSound("viper/weapons/akilo47/wfoly_ar_akilo47_reload_empty_twist.ogg")
				ply:StripWeapon("fire_extinguisher")
				ply:StripWeapon("weapon_axe")
				MCR.SetSCBA(ply, false)
			else
				ply:EmitSound("viper/weapons/akilo47/wfoly_ar_akilo47_reload_empty_twist.ogg")
				MCR.SetSCBA(ply, true)
				local wep = ply:Give("fire_extinguisher")
				wep.GivenByTeam = true

				local rank = MRS.GetPlyRank(ply, "FDNY")

				if rank > 3 then
					local w = ply:Give("weapon_axe")
					w.GivenByTeam = true
				end
			end

			ply:SetDarkRPVar("fanim_n", "")
			DarkRP.UIEffect(nil, "anim_keys", {type = "usekeys", ply = ply:UserID()})
		end)
	end
end