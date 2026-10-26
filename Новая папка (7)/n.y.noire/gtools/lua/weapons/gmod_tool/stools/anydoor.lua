--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/anydoor.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
TOOL.Category = "Construction"
TOOL.Name = "Раздвижные двери"
TOOL.ClientConVar["dir"] = "1"
TOOL.ClientConVar["rot"] = "1"

TOOL.Information = {
	{
		name = "left",
		stage = 0
	},
	{
		name = "right",
		stage = 0
	}
}

cleanup.Register("anydoor")

if CLIENT then
	language.Add("Tool.anydoor.name", "Раздвижные двери")
	language.Add("Tool.anydoor.desc", "Превращает проп в раздвижную дверь")
	language.Add("Tool.anydoor.left", "ЛКМ - для превращения пропа в раздвижную дверь")
	language.Add("Tool.anydoor.right", "ПКМ - для превращения пропа в дверь на петлях")
	language.Add("Undone_anydoor_door", "Дверь удалена")
	language.Add("SBoxLimit_anydoor", "Лимит дверей")
end

if (SERVER) then
	if (not ConVarExists("sbox_maxanydoor")) then
		CreateConVar("sbox_maxanydoor", 7, {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Maximum number of anydoor which can be created by users.")
	end

	hook.Add("PlayerUse", "Anydoor.PlayerUse", function(ply, ent)
		if not ent.AnyDoor then return end
		if ent.lastuse and ent.lastuse > CurTime() then return end
		ent.lastuse = CurTime() + 1

		if not ent.IsUnLocked then
			ent:EmitSound("Noire.DoorLocked")
			ent:Fire("SetAnimation", "locked")
			return
		end

		if (ent:GetClass() == "func_movelinear") then
			local startPos = ent.worldStartPos
			local endPos = ent.worldEndPos

			if (ent:GetPos():DistToSqr(startPos) <= 100) then
				ent:Fire("Open")

				return true
			elseif (ent:GetPos():DistToSqr(endPos) <= 100) then
				ent:Fire("Close")

				return true
			end
		elseif (IsValid(ent:GetParent())) then
			if (ent:GetParent():GetClass() == "func_movelinear") then
				ent = ent:GetParent()
				local startPos = ent.worldStartPos
				local endPos = ent.worldEndPos

				if (ent:GetPos():DistToSqr(startPos) <= 100) then
					ent:Fire("Open")

					return true
				elseif (ent:GetPos():DistToSqr(endPos) <= 100) then
					ent:Fire("Close")

					return true
				end
			elseif (ent:GetParent():GetClass() == "prop_door_rotating") then
				ent = ent:GetParent()
				if not ent.IsUnLocked then return end
				ent:Fire("Toggle")
				if IsValid(ent.link) then
					ent.link:Fire("Toggle")
				end
				return true
			end
		elseif (ent:GetClass() == "prop_door_rotating") then
			ent:Fire("Toggle")
			if IsValid(ent.link) then
				ent.link:Fire("Toggle")
			end
			return true
		end
	end)
end

function TOOL:StackerCalcPos(lastent, dir)
	local forward = Vector(1, 0, 0):Angle()
	local ang = lastent:GetAngles()
	local lower, upper = lastent:WorldSpaceAABB()
	local glower = lastent:OBBMins()
	local gupper = lastent:OBBMaxs()
	local stackdir = Vector(0, 0, 1)
	local height = math.abs(upper.z - lower.z)
	forward = ang

	if dir == 1 then
		stackdir = forward:Up()
		height = math.abs(gupper.z - glower.z)
	elseif dir == 2 then
		stackdir = forward:Up() * -1
		height = math.abs(gupper.z - glower.z)
	elseif dir == 3 then
		stackdir = forward:Forward()
		height = math.abs(gupper.x - glower.x)
	elseif dir == 4 then
		stackdir = forward:Forward() * -1
		height = math.abs(gupper.x - glower.x)
	elseif dir == 5 then
		stackdir = forward:Right()
		height = math.abs(gupper.y - glower.y)
	elseif dir == 6 then
		stackdir = forward:Right() * -1
		height = math.abs(gupper.y - glower.y)
	end

	return stackdir, height
end

function TOOL:LeftClick(trace)
	if (not IsValid(trace.Entity)) then return false end
	if (trace.Entity:IsPlayer()) then return false end
	if CLIENT then return true end

	if (trace.Entity:GetClass() == "prop_physics") then
		if (not self:GetOwner():CheckLimit("anydoor")) then return false end
		local bUseLocalAng = tobool(self:GetClientInfo("local"))

		if (not bUseLocalAng) then
			baseAng = angle_zero
		end

		local ent = trace.Entity
		if IsValid(ent:GetParent()) or ent.AnyDoor then return end
		local anydoors = ents.Create("func_movelinear")
		anydoors:SetPos(ent:GetPos())
		anydoors:SetAngles(ent:GetAngles())
		anydoors:SetModel(ent:GetModel())
		anydoors:Spawn()
		anydoors:SetMoveType(MOVETYPE_PUSH)
		local name = "zanydoor_" .. ent:EntIndex()
		anydoors:SetName(name)
		anydoors:SetKeyValue("OnFullyOpen", name .. ",Shake")
		anydoors:SetKeyValue("OnFullyClosed", name .. ",Shake")
		anydoors:SetKeyValue("startsound", "Noire.DoorSlide01")
		anydoors:SetKeyValue("stopsound", "Noire.DoorSlideStop01")
		local pos = ent:GetPos()
		anydoors:SetSaveValue("m_vecPosition1", tostring(pos))
		anydoors.startPos = anydoors:WorldToLocal(pos)
		anydoors.worldStartPos = pos
		anydoors.AnyDoor = true
		local NewVec = ent:GetPos()
		local NewAng = ent:GetAngles()
		local stackdir, height = self:StackerCalcPos(ent, self:GetClientNumber( "dir" ))
		NewVec = NewVec + stackdir * height + stackdir * -5
		NewAng = NewAng
		pos = NewVec

		anydoors:SetSaveValue("m_vecPosition2", tostring(pos))
		anydoors.endPos = anydoors:WorldToLocal(pos)
		anydoors.worldEndPos = pos
		anydoors:Fire("SetSpeed", "100")
		anydoors:Fire("movedir", "100")
		anydoors.movespeed = 100

		anydoors:SetNoDraw(true)
		anydoors.IsUnLocked = true

		ent:SetParent(anydoors)
		ent:SetNotSolid(true)
		ent.AnyDoor = true

		anydoors:keysOwn(self:GetOwner())

		undo.Create("AnyDoor")
		undo.AddEntity(anydoors)
		undo.SetPlayer(self:GetOwner())
		undo.SetCustomUndoText("Undone AnyDoor")
		undo.Finish()
		self:GetOwner():AddCount("anydoor", anydoors)
		if self:GetOwner().Buddies then
			for k,v in pairs(self:GetOwner().Buddies) do
				if IsValid(k) and v.PlayerUse then
					anydoors:addKeysDoorOwner(k)
				end
			end
		end
	end
end

local player_doors = {
	["models/props_doors/door03_slotted_left.mdl"] = true,
	["models/props_c17/door01_left.mdl"] = true,
	["models/props_c17/door02_double.mdl"] = true,
	["models/noirpropper/door1m.mdl"] = true,
	["models/noirpropper/door2m.mdl"] = true
}

function TOOL:RightClick(trace)
	if (not IsValid(trace.Entity)) then return false end
	if (trace.Entity:IsPlayer()) then return false end
	if CLIENT then return true end

	if (trace.Entity:GetClass() == "prop_physics") then
		if not self:GetOwner():IsAdmin() and not player_doors[trace.Entity:GetModel()] then return false end
		if (not self:GetOwner():CheckLimit("anydoor")) then return false end
		local bUseLocalAng = tobool(self:GetClientInfo("local"))

		if (not bUseLocalAng) then
			baseAng = angle_zero
		end

		local ent = trace.Entity
		if IsValid(ent:GetParent()) or ent.AnyDoor then return end

		local anydoors = ents.Create("prop_door_rotating")
		anydoors:SetPos(ent:GetPos())
		anydoors:SetAngles(ent:GetAngles())
		anydoors:SetModel(ent:GetModel())
		anydoors:SetMaterial(ent:GetMaterial())
		anydoors:SetSkin(ent:GetSkin())
		anydoors:SetColor(ent:GetColor())
		anydoors:Spawn()
		anydoors:SetKeyValue("hardware", "1")
		anydoors:SetKeyValue("distance", "90")
		anydoors:SetKeyValue("speed", "100")
		anydoors:SetKeyValue("returndelay", "-1")
		anydoors:SetKeyValue("spawnflags", "32768")
		anydoors:SetKeyValue("forceclosed", "1")
		anydoors:SetKeyValue("soundcloseoverride", "Noire.DoorClosed02")
		anydoors:SetKeyValue("soundmoveoverride", "Noire.DoorOpen03")
		anydoors:SetKeyValue("soundopenoverride", "Noire.DoorStop")
		anydoors:SetKeyValue("opendir", tostring(self:GetClientNumber("rot") or "1"))

		for k, _ in pairs(ent:GetMaterials()) do
			anydoors:SetSubMaterial(k - 1, ent:GetSubMaterial(k - 1))
		end
		anydoors.AnyDoor = true
		anydoors.IsUnLocked = true
		ent:Remove()

		undo.Create("AnyDoor")
		undo.AddEntity(anydoors)
		undo.SetPlayer(self:GetOwner())
		undo.SetCustomUndoText("Undone AnyDoor")
		undo.Finish()
		self:GetOwner():AddCount("anydoor", anydoors)
		anydoors:keysOwn(self:GetOwner())
		if self:GetOwner().Buddies then
			for k,v in pairs(self:GetOwner().Buddies) do
				if IsValid(k) and v.PlayerUse then
					anydoors:addKeysDoorOwner(k)
				end
			end
		end

		if player_doors[anydoors:GetModel()] then
			anydoors:SetBodygroup(1, 1)
		end
	end

	if (trace.Entity:GetClass() == "prop_door_rotating") and self:GetOwner():IsAdmin() then
		trace.Entity:SetKeyValue("opendir", tostring(self:GetClientNumber("rot") or "1"))
	end

	return false
end

local opendirv = {
	["1"] = "2",
	["2"] = "1",
}

function TOOL:Reload(trace)
	if (not IsValid(trace.Entity)) then return false end
	if not self:GetOwner():IsAdmin() then return false end
	if CLIENT then return true end

	if trace.Entity:GetClass() == "prop_physics" then trace.Entity.MakeDoor = true end

	if not IsValid(trace.Entity) or not trace.Entity.AnyDoor or trace.Entity:GetClass() ~= "prop_door_rotating" then return end

	if IsValid(self.mainent) and self.mainent ~= trace.Entity then
		trace.Entity:SetKeyValue("opendir", opendirv[self.mainent:GetKeyValues()["opendir"]] or "1")
		self.mainent.link = trace.Entity
		trace.Entity.link = self.mainent
		return
	end

	if IsValid(self.mainent) then
		self.mainent = nil
		return
	end
	self.mainent = trace.Entity
end

if (SERVER) then
	function TOOL:Think()
	end
end

function TOOL:Holster()
	self:ClearObjects()
end

function TOOL:UpdateGhostAnyDoor(player, ent)
	if (not IsValid(ent)) then return end
	local trace = player:GetEyeTrace()

	if (not IsValid(trace.Entity) or trace.Entity:GetClass() ~= "prop_physics") then
		ent:SetNoDraw(true)

		return
	end

	ent:SetModel(trace.Entity:GetModel())
	ent:SetAngles(trace.Entity:GetAngles())
	local bUseLocalAng = tobool(self:GetClientInfo("local"))

	if (not bUseLocalAng) then
		baseAng = angle_zero
	end

	local NewVec = trace.Entity:GetPos()
	local NewAng = trace.Entity:GetAngles()

	local stackdir, height = self:StackerCalcPos(trace.Entity, self:GetClientNumber( "dir" ))
	NewVec = NewVec + stackdir * height + stackdir * -5
	NewAng = NewAng
	ent:SetPos(NewVec)
	ent:SetAngles(NewAng)
	ent:SetNoDraw(false)
end

function TOOL:Think()
	local trace = self:GetOwner():GetEyeTrace()

	if (not IsValid(self.GhostEntity)) then
		self:MakeGhostEntity(trace.Entity:GetModel(), Vector(0, 0, 0), Angle(0, 0, 0))
	end

	self:UpdateGhostAnyDoor(self:GetOwner(), self.GhostEntity)
end

--[[
	Control Panel
]]
function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Description = "Раздвижные двери"
	})

	local params = {Label = "Направление", MenuButton = "0", Options = {}}
	params.Options["Вверх"] = {anydoor_dir = "1"}
	params.Options["Вниз"] = {anydoor_dir = "2"}
	params.Options["Вперёд"] = {anydoor_dir = "3"}
	params.Options["Назад"] = {anydoor_dir = "4"}
	params.Options["Вправо"] = {anydoor_dir = "5"}
	params.Options["Влево"] = {anydoor_dir = "6"}
	CPanel:AddControl( "ComboBox", params )

	CPanel:AddControl("Header", {
		Description = "Двери на петлях"
	})

	local params2 = {Label = "Направление", MenuButton = "0", Options = {}}
	params2.Options["Вперёд"] = {anydoor_rot = "1"}
	params2.Options["Назад"] = {anydoor_rot = "2"}
	CPanel:AddControl( "ComboBox", params2 )
end