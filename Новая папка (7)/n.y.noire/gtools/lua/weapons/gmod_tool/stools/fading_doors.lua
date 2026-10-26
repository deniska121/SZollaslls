--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/fading_doors.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

--[[
	~ Fading Door STool ~
	~ Based on Conna's, but this time it works. ~
	~ Lexi ~
	~ Modified and Workshopped by Zapk ~
--]]
--[[ Tool Related Settings ]]
--
TOOL.Category = "Construction"
TOOL.Name = "#Fading Door"
TOOL.ClientConVar["key"] = "5"
TOOL.ClientConVar["toggle"] = "0"
TOOL.ClientConVar["reversed"] = "0"

local function checkTrace(tr)
	return tr.Entity and tr.Entity:IsValid() and tr.Entity:GetClass() == "prop_physics" and not (tr.Entity:IsPlayer() or tr.Entity:IsNPC() or tr.Entity:IsVehicle() or tr.HitWorld)
end

if (CLIENT) then
	language.Add("Tool.fading_doors.name", "Fading Door")
	language.Add("Tool.fading_doors.desc", "Makes an object a Fading Door")
	language.Add("Tool.fading_doors.0", "Click on an object to make it a fading door.")
	language.Add("Undone_fading_door", "Fading Door Undone")

	function TOOL:BuildCPanel()
		self:AddControl("Header", {
			Text = "#Tool.fading_doors.name",
			Description = "#Tool.fading_doors.desc"
		})

		self:AddControl("CheckBox", {
			Label = "Start Faded",
			Command = "fading_doors_reversed"
		})

		self:AddControl("CheckBox", {
			Label = "Toggle",
			Command = "fading_doors_toggle"
		})

		self:AddControl("Numpad", {
			Label = "Button",
			ButtonSize = "22",
			Command = "fading_doors_key"
		})
	end

	TOOL.LeftClick = checkTrace

	return
end

umsg.PoolString("FadingDoorHurrah!")

local function fadeActivate(self)
	self.fadeActive = true
	self.fadeMaterial = self:GetMaterial()
	self:SetMaterial("null")
	self:DrawShadow(false)
	self:SetNotSolid(true)
	--self:SetCollisionGroup(COLLISION_GROUP_WORLD)
	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then
		self.fadeMoveable = phys:IsMoveable()
		phys:EnableMotion(false)
	end
end

local function fadeDeactivate(self)
	self.fadeActive = false
	self:SetMaterial(self.fadeMaterial or "")
	self:DrawShadow(true)
	self:SetNotSolid(false)
	--self:SetCollisionGroup(COLLISION_GROUP_NONE);
	local phys = self:GetPhysicsObject()

	if (IsValid(phys)) then
		phys:EnableMotion(self.fadeMoveable or false)
	end
end

local function fadeToggleActive(self)
	if (self.fadeActive) then
		self:fadeDeactivate()
	else
		self:fadeActivate()
	end
end

local function onUp(ply, ent)
	if (not (ent:IsValid() and ent.fadeToggleActive and not ent.fadeToggle)) then return end
	ent:fadeToggleActive()
end

numpad.Register("Fading Doors onUp", onUp)

local function onDown(ply, ent)
	if (not (ent:IsValid() and ent.fadeToggleActive)) then return end
	ent:fadeToggleActive()
end

numpad.Register("Fading Doors onDown", onDown)

local function onRemove(self)
	numpad.Remove(self.fadeUpNum)
	numpad.Remove(self.fadeDownNum)
end

local function dooEet(ply, ent, stuff)
	if (ent.isFadingDoor) then
		ent:fadeDeactivate()
		onRemove(ent)
	else
		ent.isFadingDoor = true
		ent.fadeActivate = fadeActivate
		ent.fadeDeactivate = fadeDeactivate
		ent.fadeToggleActive = fadeToggleActive
		ent:CallOnRemove("Fading Doors", onRemove)
	end

	ent.fadeUpNum = numpad.OnUp(ply, stuff.key, "Fading Doors onUp", ent)
	ent.fadeDownNum = numpad.OnDown(ply, stuff.key, "Fading Doors onDown", ent)
	ent.fadeToggle = true

	if (stuff.reversed) then
		ent:fadeActivate()
	end

	duplicator.StoreEntityModifier(ent, "Fading Door", stuff)

	return true
end

duplicator.RegisterEntityModifier("Fading Door", dooEet)

if (not FadingDoor) then
	local function legacy(ply, ent, data)
		return dooEet(ply, ent, {
			key = data.Key;
			toggle = data.Toggle;
			reversed = data.Inverse;
		})
	end

	duplicator.RegisterEntityModifier("FadingDoor", legacy)
end

local function doUndo(undoData, ent)
	if not IsValid(ent) then return end
	onRemove(ent)
	ent:fadeDeactivate()
	ent.isFadingDoor = false
end

function TOOL:LeftClick(tr)
	if (not checkTrace(tr)) then return false end
	local ent = tr.Entity
	local ply = self:GetOwner()

	dooEet(ply, ent, {
		key = self:GetClientNumber("key");
		toggle = self:GetClientNumber("toggle") == 1;
		reversed = self:GetClientNumber("reversed") == 1;
	})

	undo.Create("fading_door")
	undo.AddFunction(doUndo, ent)
	undo.SetPlayer(ply)
	undo.Finish()

	return true
end