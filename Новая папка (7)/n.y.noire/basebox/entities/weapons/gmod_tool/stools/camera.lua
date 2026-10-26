--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/weapons/gmod_tool/stools/camera.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Render"
TOOL.Name = "#tool.camera.name"
TOOL.ClientConVar["locked"] = "0"
TOOL.ClientConVar["key"] = "37"
TOOL.ClientConVar["toggle"] = "1"

TOOL.Information = {
	{
		name = "left"
	},
	{
		name = "right"
	}
}

cleanup.Register("cameras")

local function CheckLimit(ply, key)
	-- TODO: Clientside prediction
	if (CLIENT) then return true end
	local found = false

	for id, camera in pairs(ents.FindByClass("gmod_cameraprop")) do
		if (not camera.controlkey or camera.controlkey ~= key) then continue end
		if (IsValid(camera:GetPlayer()) and ply ~= camera:GetPlayer()) then continue end
		found = true
		break
	end

	if (not found and not ply:CheckLimit("cameras")) then return false end

	return true
end

--lua_run for k,v in pairs(ents.FindByClass("gmod_cameraprop")) do v:Remove() end
local function MakeCamera(ply, key, locked, toggle, Data)
	if (IsValid(ply) and not CheckLimit(ply, key)) then return false end
	local ent = ents.Create("gmod_cameraprop")
	if (not IsValid(ent)) then return end
	duplicator.DoGeneric(ent, Data)

	if (key) then
		for id, camera in pairs(ents.FindByClass("gmod_cameraprop")) do
			if (not camera.controlkey or camera.controlkey ~= key) then continue end
			if (IsValid(ply) and IsValid(camera:GetPlayer()) and ply ~= camera:GetPlayer()) then continue end
			camera:Remove()
		end

		ent:SetKey(key)
		ent.controlkey = key
	end

	ent:SetPlayer(ply)
	ent.toggle = toggle
	ent.locked = locked
	ent:Spawn()
	DoPropSpawnedEffect(ent)
	ent:SetTracking(NULL, Vector(0))
	ent:SetLocked(locked)

	if (toggle == 1) then
		numpad.OnDown(ply, key, "Camera_Toggle", ent)
	else
		numpad.OnDown(ply, key, "Camera_On", ent)
		numpad.OnUp(ply, key, "Camera_Off", ent)
	end

	if (IsValid(ply)) then
		ply:AddCleanup("cameras", ent)
		ply:AddCount("cameras", ent)
	end

	return ent
end

duplicator.RegisterEntityClass("gmod_cameraprop", MakeCamera, "controlkey", "locked", "toggle", "Data")

function TOOL:LeftClick(trace)
	local ply = self:GetOwner()
	local key = self:GetClientNumber("key")
	if (key == -1) then return false end
	if (not CheckLimit(ply, key)) then return false end
	if (CLIENT) then return true end
	local locked = self:GetClientNumber("locked")
	local toggle = self:GetClientNumber("toggle")

	local ent = MakeCamera(ply, key, locked, toggle, {
		Pos = trace.StartPos,
		Angle = ply:EyeAngles()
	})

	undo.Create("Camera")
	undo.AddEntity(ent)
	undo.SetPlayer(ply)
	undo.Finish()

	return true, ent
end

function TOOL:RightClick(trace)
	local _, camera = self:LeftClick(trace, true)
	if (CLIENT) then return true end
	if (not IsValid(camera)) then return false end

	if (trace.Entity:IsWorld()) then
		trace.Entity = self:GetOwner()
		trace.HitPos = trace.Entity:GetPos()
	end

	-- We apply the view offset for players in camera entity
	if (trace.Entity:IsPlayer()) then
		trace.HitPos = trace.Entity:GetPos()
	end

	camera:SetTracking(trace.Entity, trace.Entity:WorldToLocal(trace.HitPos))

	return true
end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("ComboBox", {
		MenuButton = 1,
		Folder = "camera",
		Options = {
			["#preset.default"] = ConVarsDefault
		},
		CVars = table.GetKeys(ConVarsDefault)
	})

	CPanel:AddControl("Numpad", {
		Label = "#tool.camera.key",
		Command = "camera_key"
	})

	CPanel:AddControl("CheckBox", {
		Label = "#tool.camera.static",
		Command = "camera_locked",
		Help = true
	})

	CPanel:AddControl("CheckBox", {
		Label = "#tool.toggle",
		Command = "camera_toggle"
	})
end