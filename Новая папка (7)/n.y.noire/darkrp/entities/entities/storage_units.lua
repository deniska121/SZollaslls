--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/storage_units.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.PrintName = "Barnacle Tongue"
ENT.units = {
	[1] = Vector(12,-332,0),
	[2] = Vector(12,-225,0),
	[3] = Vector(12,-112,0),
	[4] = Vector(12,0,0),
	[5] = Vector(12,112,0),
	[6] = Vector(12,225,0),
	[7] = Vector(12,332,0),
}

function ENT:Initialize()
	if SERVER then
		self:SetModel("models/hunter/plates/plate3x16.mdl")
		self:PhysicsInit(SOLID_VPHYSICS)
		self:SetMoveType(MOVETYPE_NONE)
		self:SetNoDraw(true)
	end
end

if CLIENT then return end

function ENT:Use(ply)
	if DarkRP.UseDelay(ply, 2) then return end

	local sp = ply:GetEyeTrace().HitPos
	local found

	for id, unit in ipairs(self.units) do
		if sp and not DarkRP.InRangeVector(sp, self:LocalToWorld(unit), 50) then continue end
		found = id
	end

	if not found then return end

	if not ply.sunitkey or ply.sunitkey ~= found then return end

	ply:EmitSound("doors/door_metal_gate_move1.wav")
	DarkRP.ForceAnimation(ply, "pickup", 1.5)

	timer.Simple(1, function()
		if not IsValid(ply) then return end
		ply:EmitSound("doors/door_metal_gate_close1.wav")
		net.Start("McINV.OpenBank")
			net.WriteBool(false)
		net.Send(ply)
	end)
end