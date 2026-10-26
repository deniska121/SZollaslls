--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/weapons/gmod_tool/stools/nlight.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Construction"
TOOL.Name = "Лампочка"

TOOL.Information = {
	{
		name = "left"
	},
}

cleanup.Register("lights")

if CLIENT then
	language.Add("Tool.nlight.name", "Лампочка")
	language.Add("Tool.nlight.desc", "Создает простую лампочку для освещения")
	language.Add("Tool.nlight.left", "ЛКМ - Создать")
end

local function checkPos(ply, vec)
	if checkRights(ply) then return true end

	for _, territory in pairs(Territories.list) do
		if territory:IsInsideV(vec) then
			if not territory:AllowedPropSpawn(ply) then return false end

			return true
		end
	end

	return false
end

function TOOL:LeftClick(trace, attach)
	if (IsValid(trace.Entity) and trace.Entity:IsPlayer()) then return false end
	if (CLIENT) then return true end
	if not checkPos(self:GetOwner(), trace.HitPos) then return true end

	local ply = self:GetOwner()
	local pos, ang = trace.HitPos + trace.HitNormal, trace.HitNormal:Angle() - Angle(90, 0, 0)

	if (not self:GetSWEP():CheckLimit("lights")) then return false end

	local lamp = MakeNLight(ply, {
		Pos = pos,
		Angle = ang
	})

	undo.Create("Light")
	undo.AddEntity(lamp)
	undo.SetPlayer(ply)
	undo.Finish()

	return true
end

if (SERVER) then
	function MakeNLight(pl, Data)
		if (IsValid(pl) and not pl:CheckLimit("lights")) then return false end
		local lamp = ents.Create("ny_light")
		if (not IsValid(lamp)) then return end
		duplicator.DoGeneric(lamp, Data)
		lamp:Spawn()
		DoPropSpawnedEffect(lamp)
		duplicator.DoGenericPhysics(lamp, pl, Data)
		lamp.on = true

		if (IsValid(pl)) then
			pl:AddCount("lights", lamp)
			pl:AddCleanup("lights", lamp)
		end

		return lamp
	end

	duplicator.RegisterEntityClass("ny_light", MakeNLight, "on", "Data")
end

function TOOL:UpdateGhostLight(ent, pl)
	if (not IsValid(ent)) then return end
	local trace = pl:GetEyeTrace()

	if (not trace.Hit or IsValid(trace.Entity) and (trace.Entity:IsPlayer() or trace.Entity:GetClass() == "gmod_light")) then
		ent:SetNoDraw(true)

		return
	end

	ent:SetPos(trace.HitPos + trace.HitNormal)
	ent:SetAngles(trace.HitNormal:Angle() - Angle(90, 0, 0))
	ent:SetNoDraw(false)
end

function TOOL:Think()
	if (not IsValid(self.GhostEntity) or self.GhostEntity:GetModel() ~= "models/props/de_inferno/ceiling_light.mdl") then
		self:MakeGhostEntity("models/props/de_inferno/ceiling_light.mdl", vector_origin, angle_zero)
	end

	self:UpdateGhostLight(self.GhostEntity, self:GetOwner())
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Description = "Создаёт лампочку для освещения."
	})
end