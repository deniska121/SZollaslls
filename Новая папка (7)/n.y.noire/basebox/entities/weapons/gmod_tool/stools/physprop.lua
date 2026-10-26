--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/weapons/gmod_tool/stools/physprop.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Construction"
TOOL.Name = "#tool.physprop.name"
TOOL.ClientConVar["gravity_toggle"] = "1"
TOOL.ClientConVar["material"] = "metal_bouncy"

TOOL.Information = {
	{
		name = "left"
	}
}

local function doUndo(undoData, ent)
	if not IsValid(ent) then return end
	ent:SetNotSolid(false)
end

function TOOL:LeftClick(trace)
	if (not IsValid(trace.Entity)) then return false end
	if (trace.Entity:IsPlayer() or trace.Entity:IsWorld()) then return false end
	-- Make sure there's a physics object to manipulate
	if (SERVER and not util.IsValidPhysicsObject(trace.Entity, trace.PhysicsBone)) then return false end
	-- Client can bail out here and assume we're going ahead
	if (CLIENT) then return true end

	if self:GetOwner():IsAdmin() and self:GetOwner():KeyDown(IN_SPEED) then
		trace.Entity:SetNotSolid(true)

		undo.Create("nosolid")
		undo.AddFunction(doUndo, trace.Entity)
		undo.SetPlayer(self:GetOwner())
		undo.Finish()

		return true
	end
	-- Get the entity/bone from the trace
	local ent = trace.Entity
	local Bone = trace.PhysicsBone
	-- Get client's CVars
	local gravity = self:GetClientNumber("gravity_toggle") == 1
	local material = self:GetClientInfo("material")

	-- Set the properties
	construct.SetPhysProp(self:GetOwner(), ent, Bone, nil, {
		GravityToggle = gravity,
		Material = material
	})

	DoPropSpawnedEffect(ent)

	return true
end

function TOOL:RightClick(trace)
	if not self:GetOwner():IsAdmin() then return end
	if (not IsValid(trace.Entity)) then return false end
	if (trace.Entity:IsPlayer() or trace.Entity:IsWorld()) then return false end
	if (CLIENT) then return true end
	if not IsValid(self.parrent) or self.parrent == trace.Entity then return end
	trace.Entity:SetParent(self.parrent)
	if self.parrent.AnyDoor then
		trace.Entity.AnyDoor = true
		trace.Entity.IsUnLocked = true
	end
	if self:GetClientNumber("gravity_toggle") == 0 then
		trace.Entity:GetPhysicsObject():EnableDrag(false)
		trace.Entity:GetPhysicsObject():EnableMotion(false)
		trace.Entity:SetNotSolid(true)
	end
	trace.Entity:GetPhysicsObject():SetMass(1)

	return true
end

function TOOL:Reload( trace )
	if not self:GetOwner():IsAdmin() then return end
	if (not IsValid(trace.Entity)) then return false end
	if (trace.Entity:IsPlayer() or trace.Entity:IsWorld()) then return false end
	if (CLIENT) then return true end

	self.parrent = trace.Entity
	return true
end

local ConVarsDefault = TOOL:BuildConVarList()

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("ComboBox", {
		MenuButton = 1,
		Folder = "physprop",
		Options = {
			["#preset.default"] = ConVarsDefault
		},
		CVars = table.GetKeys(ConVarsDefault)
	})

	CPanel:AddControl("ListBox", {
		Label = "#tool.physprop.material",
		Options = list.Get("PhysicsMaterials")
	})

	CPanel:AddControl("CheckBox", {
		Label = "#tool.physprop.gravity",
		Command = "physprop_gravity_toggle"
	})
end

list.Set("PhysicsMaterials", "#physprop.metalbouncy", {
	physprop_material = "metal_bouncy"
})

list.Set("PhysicsMaterials", "#physprop.metal", {
	physprop_material = "metal"
})

list.Set("PhysicsMaterials", "#physprop.dirt", {
	physprop_material = "dirt"
})

list.Set("PhysicsMaterials", "#physprop.slime", {
	physprop_material = "slipperyslime"
})

list.Set("PhysicsMaterials", "#physprop.wood", {
	physprop_material = "wood"
})

list.Set("PhysicsMaterials", "#physprop.glass", {
	physprop_material = "glass"
})

list.Set("PhysicsMaterials", "#physprop.concrete", {
	physprop_material = "concrete_block"
})

list.Set("PhysicsMaterials", "#physprop.ice", {
	physprop_material = "ice"
})

list.Set("PhysicsMaterials", "#physprop.rubber", {
	physprop_material = "rubber"
})

list.Set("PhysicsMaterials", "#physprop.paper", {
	physprop_material = "paper"
})

list.Set("PhysicsMaterials", "#physprop.flesh", {
	physprop_material = "zombieflesh"
})

list.Set("PhysicsMaterials", "#physprop.superice", {
	physprop_material = "gmod_ice"
})

list.Set("PhysicsMaterials", "#physprop.superbouncy", {
	physprop_material = "gmod_bouncy"
})