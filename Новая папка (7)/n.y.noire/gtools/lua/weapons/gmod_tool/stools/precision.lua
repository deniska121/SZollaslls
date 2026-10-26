--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/precision.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Constraints"
TOOL.Name = "Точный инструмент"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["mode"] = "1"
TOOL.ClientConVar["user"] = "1"
TOOL.ClientConVar["forcelimit"] = "0"
TOOL.ClientConVar["freeze"] = "1"
TOOL.ClientConVar["nocollide"] = "1"
TOOL.ClientConVar["nocollideall"] = "0"
TOOL.ClientConVar["rotation"] = "15"
TOOL.ClientConVar["rotate"] = "1"
TOOL.ClientConVar["offset"] = "0"
TOOL.ClientConVar["torquelimit"] = "0"
TOOL.ClientConVar["friction"] = "0"
TOOL.ClientConVar["width"] = "1"
TOOL.ClientConVar["offsetpercent"] = "1"
TOOL.ClientConVar["removal"] = "0"
TOOL.ClientConVar["move"] = "1"
TOOL.ClientConVar["physdisable"] = "0"
TOOL.ClientConVar["ShadowDisable"] = "0"
TOOL.ClientConVar["allowphysgun"] = "0"
TOOL.ClientConVar["autorotate"] = "0"
TOOL.ClientConVar["entirecontrap"] = "0"
TOOL.ClientConVar["nudge"] = "25"
TOOL.ClientConVar["nudgepercent"] = "1"
TOOL.ClientConVar["disablesliderfix"] = "0"
--adv ballsocket
TOOL.ClientConVar["XRotMin"] = "-180"
TOOL.ClientConVar["XRotMax"] = "180"
TOOL.ClientConVar["YRotMin"] = "-180"
TOOL.ClientConVar["YRotMax"] = "180"
TOOL.ClientConVar["ZRotMin"] = "-180"
TOOL.ClientConVar["ZRotMax"] = "180"
TOOL.ClientConVar["XRotFric"] = "0"
TOOL.ClientConVar["YRotFric"] = "0"
TOOL.ClientConVar["ZRotFric"] = "0"
TOOL.ClientConVar["FreeMov"] = "0"
TOOL.ClientConVar["nudgeundo"] = "0"
TOOL.ClientConVar["moveundo"] = "1"
TOOL.ClientConVar["rotateundo"] = "1"
TOOL.inuse = nil
TOOL.axis = 0
TOOL.axisY = 0
TOOL.axisZ = 0
TOOL.realdegrees = 0
TOOL.lastdegrees = 0
TOOL.realdegreesY = 0
TOOL.lastdegreesY = 0
TOOL.realdegreesZ = 0
TOOL.lastdegreesZ = 0
TOOL.OldPos = 0
TOOL.axis2 = 0
TOOL.axisY2 = 0
TOOL.axisZ2 = 0
TOOL.realdegrees2 = 0
TOOL.lastdegrees2 = 0
TOOL.realdegrees2Y = 0
TOOL.lastdegrees2Y = 0
TOOL.realdegrees2Z = 0
TOOL.lastdegrees2Z = 0
TOOL.OldPos2 = 0
TOOL.SavedPos = Vector(0, 0, 1)

local player_doors = {
	["models/props_c17/door01_left.mdl"] = "models/props_ktwalls/default/kt_wall128_hole3.mdl",
	["models/props_c17/door02_double.mdl"] = "models/props_ktwalls/default/kt_wall128_hole3.mdl",
	["models/noirpropper/door1m.mdl"] = "models/props_ktwalls/default/kt_wall128_doorhole5.mdl",
	["models/noirpropper/door2m.mdl"] = "models/props_ktwalls/default/kt_wall128_doorhole5.mdl"
}

local door_pos = {
	["models/props_ktwalls/default/kt_wall128_doorhole5.mdl"] = Vector(0,-28,-12),
	["models/props_ktwalls/default/kt_wall128_hole3.mdl"] = Vector(0,-23,-10),
}

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

function TOOL:LeftClick(trace)
	local iNum = self:NumObjects()

	if (iNum == 0) then
		trace.Entity:SetMoveType(MOVETYPE_VPHYSICS)
	end

	local Phys = trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone)

	if (iNum < 2) then
		if (SERVER and not util.IsValidPhysicsObject(trace.Entity, trace.PhysicsBone) and (not trace.Entity:GetParent():IsValid() or not self:GetClientNumber("removal") == 1 or self:GetClientNumber("mode") ~= 9)) then
			if not (self:GetClientNumber("mode") < 4 and iNum == 0) then return false end
		end

		if (trace.Entity:IsPlayer()) then return false end

		if (SERVER and not Phys:IsValid() and (not trace.Entity:GetParent():IsValid() or not self:GetClientNumber("removal") == 1 or self:GetClientNumber("mode") ~= 9)) then
			if not (self:GetClientNumber("mode") < 4 and iNum == 0) then return false end
		end
	end

	if (iNum > 1) then
		self:ClearObjects()

		return true
	end

	if (iNum == 0) then
		if (not trace.Entity:IsValid()) then return false end

		if (self:GetClientNumber("Move") == 0 and self:GetClientNumber("mode") ~= 3) or self:GetClientNumber("mode") < 3 then
			if self:GetClientNumber("mode") == 2 then
				if (CLIENT) then return true end

				local oldposu = trace.Entity:GetPos()
				local oldangles = trace.Entity:GetAngles()

				local function MoveUndo(Undo, Entity, olp, ola)
					if Entity:IsValid() then
						Entity:SetAngles(ola)
						Entity:SetPos(olp)
					end
				end

				if (self:GetClientNumber("rotateundo")) then
					undo.Create("Precision_Rotate")
					undo.SetPlayer(self:GetOwner())
					undo.AddFunction(MoveUndo, trace.Entity, oldposu, oldangles)
					undo.Finish()
				end

				Phys:EnableMotion(false)
				local rotation = self:GetClientNumber("rotation")

				if (inuse == nil or inuse == self:GetOwner():GetName()) then
					inuse = self:GetOwner():GetName()
					axis = trace.HitNormal
					axisY = axis:Cross(trace.Entity:GetUp())

					if self:WithinABit(axisY, Vector(0, 0, 0)) then
						axisY = axis:Cross(trace.Entity:GetForward())
					end

					axisZ = axisY:Cross(axis)
					realdegrees = 0
					lastdegrees = -((rotation / 2) % rotation)
					realdegreesY = 0
					lastdegreesY = -((rotation / 2) % rotation)
					realdegreesZ = 0
					lastdegreesZ = -((rotation / 2) % rotation)
					OldPos = trace.HitPos
				else
					--inuse2 = self:GetOwner():GetName()
					axis2 = trace.HitNormal
					axis2Y = axis2:Cross(trace.Entity:GetUp())

					if self:WithinABit(axis2Y, Vector(0, 0, 0)) then
						axis2Y = axis2:Cross(trace.Entity:GetForward())
					end

					axis2Z = trace.Entity:GetUp() --axis2Y:Cross(axis2)
					realdegrees2 = 0
					lastdegrees2 = -((rotation / 2) % rotation)
					realdegrees2Y = 0
					lastdegrees2Y = -((rotation / 2) % rotation)
					realdegrees2Z = 0
					lastdegrees2Z = -((rotation / 2) % rotation)
					OldPos2 = trace.HitPos
				end

				self:SetObject(iNum + 2, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal)
			elseif (self:GetClientNumber("mode") == 1) then
				return true
			end
		end
	end

	self:SetObject(iNum + 1, trace.Entity, trace.HitPos, Phys, trace.PhysicsBone, trace.HitNormal)

	if (iNum == 1) then
		if (self:GetEnt(1) == self:GetEnt(2)) then
			SavedPos = self:GetPos(2)
		end

		local offset = self:GetClientNumber("offset")
		local move = (self:GetClientNumber("move") == 1 and self:GetClientNumber("mode") > 2) or self:GetClientNumber("mode") == 3
		local mode = self:GetClientNumber("mode")

		local rotate = (self:GetClientNumber("rotate") == 1 and mode > 1 and ((self:GetClientNumber("move") == 1 and mode > 2) or mode == 3)) or mode == 2

		if (move and mode < 4) then
			if (CLIENT) then
				self:ReleaseGhostEntity()

				return true
			end

			-- Get information we're about to use
			local Norm1, Norm2 = self:GetNormal(1), self:GetNormal(2)
			local Phys1 = self:GetPhys(1)
			local Ang1, Ang2 = Norm1:Angle(), (Norm2 * -1):Angle()

			if self:GetClientNumber("autorotate") == 1 then
				Ang2.p = (math.Round(Ang2.p / 45)) * 45
				Ang2.r = (math.Round(Ang2.r / 45)) * 45
				Ang2.y = (math.Round(Ang2.y / 45)) * 45
				Norm2 = Ang2:Forward() * -1
			end

			local oldposu = self:GetEnt(1):GetPos()
			local oldangles = self:GetEnt(1):GetAngles()

			local function MoveUndo(Undo, Entity, a, b)
				if Entity:IsValid() then
					Entity:SetAngles(b)
					Entity:SetPos(a)
				end
			end

			if self:GetClientNumber("moveundo") == 1 then
				undo.Create("Precision Move")
				undo.SetPlayer(self:GetOwner())
				undo.AddFunction(MoveUndo, self:GetEnt(1), oldposu, oldangles)
				undo.Finish()
			end

			local rotation = self:GetClientNumber("rotation")

			--Set axies for rotation mode directions
			if ((self:GetClientNumber("rotate") == 1 and mode ~= 1) or mode == 2) then
				if (inuse == nil or inuse == self:GetOwner():GetName()) then
					inuse = self:GetOwner():GetName()
					axis = Norm2
					axisY = axis:Cross(Vector(0, 1, 0))

					if self:WithinABit(axisY, Vector(0, 0, 0)) then
						axisY = axis:Cross(Vector(0, 0, 1))
					end

					axisY:Normalize()
					axisZ = axisY:Cross(axis)
					axisZ:Normalize()
					realdegrees = 0
					lastdegrees = -((rotation / 2) % rotation)
					realdegreesY = 0
					lastdegreesY = -((rotation / 2) % rotation)
					realdegreesZ = 0
					lastdegreesZ = -((rotation / 2) % rotation)
				else
					axis2 = Norm2
					axis2Y = axis2:Cross(Vector(0, 1, 0))

					if self:WithinABit(axis2Y, Vector(0, 0, 0)) then
						axis2Y = axis2:Cross(Vector(0, 0, 1))
					end

					axis2Y:Normalize()
					axis2Z = axis2Y:Cross(axis2)
					axis2Z:Normalize()
					realdegrees2 = 0
					lastdegrees2 = -((rotation / 2) % rotation)
					realdegrees2Y = 0
					lastdegrees2Y = -((rotation / 2) % rotation)
					realdegrees2Z = 0
					lastdegrees2Z = -((rotation / 2) % rotation)
				end
			else
				if (inuse == nil or inuse == self:GetOwner():GetName()) then
					inuse = self:GetOwner():GetName()
					axis = Norm2
					axisY = axis:Cross(Vector(0, 1, 0))

					if self:WithinABit(axisY, Vector(0, 0, 0)) then
						axisY = axis:Cross(Vector(0, 0, 1))
					end

					axisY:Normalize()
					axisZ = axisY:Cross(axis)
					axisZ:Normalize()
				else
					axis2 = Norm2
					axis2Y = axis2:Cross(Vector(0, 1, 0))

					if self:WithinABit(axis2Y, Vector(0, 0, 0)) then
						axis2Y = axis2:Cross(Vector(0, 0, 1))
					end

					axis2Y:Normalize()
					axis2Z = axis2Y:Cross(axis2)
					axis2Z:Normalize()
				end
			end

			local TargetAngle = Phys1:AlignAngles(Ang1, Ang2) --Get angle Phys1 would be at if difference between Ang1 and Ang2 was added

			if self:GetClientNumber("autorotate") == 1 then
				TargetAngle.p = (math.Round(TargetAngle.p / 45)) * 45
				TargetAngle.r = (math.Round(TargetAngle.r / 45)) * 45
				TargetAngle.y = (math.Round(TargetAngle.y / 45)) * 45
			end

			local NewOffset = offset
			local offsetpercent = self:GetClientNumber("offsetpercent") == 1

			if (offsetpercent) then
				local Ent2 = self:GetEnt(2)
				local glower = Ent2:OBBMins()
				local gupper = Ent2:OBBMaxs()
				local height = math.abs(gupper.z - glower.z) - 0.5

				if self:WithinABit(Norm2, Ent2:GetForward()) then
					height = math.abs(gupper.x - glower.x) - 0.5
				elseif self:WithinABit(Norm2, Ent2:GetRight()) then
					height = math.abs(gupper.y - glower.y) - 0.5
				end

				NewOffset = NewOffset / 100
				NewOffset = NewOffset * height
			end

			Norm2 = Norm2 * (-0.0625 + NewOffset)
			local TargetPos = self:GetPos(2) + (Phys1:GetPos() - self:GetPos(1)) + Norm2
			if not checkPos(self:GetOwner(), TargetPos) then return false end

			if self:GetOwner():KeyDown(IN_SPEED) and player_doors[self:GetEnt(1):GetModel()] and IsValid(trace.Entity) and trace.Entity:GetModel() == player_doors[self:GetEnt(1):GetModel()] then
				Phys1:SetAngles(trace.Entity:GetAngles())
				Phys1:SetPos(trace.Entity:LocalToWorld(door_pos[trace.Entity:GetModel()]))
				Phys1:EnableMotion(false)
				Phys1:Wake()

				self:ReleaseGhostEntity()
				self:ClearObjects()
				rotate = false
				self:SetStage(0)
				return
			else
				Phys1:SetAngles(TargetAngle)
				Phys1:SetPos(TargetPos)
				Phys1:EnableMotion(false)
				Phys1:Wake()
			end
		end

		self:ReleaseGhostEntity()

		--here be third click
		if (rotate and mode < 4) then
			self:SetStage(iNum + 1)

			if (inuse == nil or inuse == self:GetOwner():GetName()) then
				inuse = self:GetOwner():GetName()
			end
		end
	else
		local move = (self:GetClientNumber("move") == 1 and self:GetClientNumber("mode") > 2) or self:GetClientNumber("mode") == 3

		if (move) then
			self:StartGhostEntity(trace.Entity)
		end

		self:SetStage(iNum + 1)
	end

	return true
end

function TOOL:WithinABit(v1, v2)
	local tol = 0.1
	local da = v1.x - v2.x
	local db = v1.y - v2.y
	local dc = v1.z - v2.z

	if da < tol and da > -tol and db < tol and db > -tol and dc < tol and dc > -tol then
		return true
	else
		da = v1.x + v2.x
		db = v1.y + v2.y
		dc = v1.z + v2.z

		if da < tol and da > -tol and db < tol and db > -tol and dc < tol and dc > -tol then
			return true
		else
			return false
		end
	end
end

if (SERVER) then
	function GetAllEnts(Ent, OrderedEntList, EntsTab, ConstsTab)
		if (Ent and Ent:IsValid()) and (not EntsTab[Ent:EntIndex()]) then
			EntsTab[Ent:EntIndex()] = Ent
			table.insert(OrderedEntList, Ent)
			if (not constraint.HasConstraints(Ent)) then return OrderedEntList end

			for key, ConstraintEntity in pairs(Ent.Constraints) do
				if (not ConstsTab[ConstraintEntity]) then
					ConstsTab[ConstraintEntity] = true
					local ConstTable = ConstraintEntity:GetTable()

					for i = 1, 6 do
						local e = ConstTable["Ent" .. i]

						if (e and e:IsValid()) and (not EntsTab[e:EntIndex()]) then
							GetAllEnts(e, OrderedEntList, EntsTab, ConstsTab)
						end
					end
				end
			end
		end

		return OrderedEntList
	end

	function GetAllConstraints(EntsTab)
		local ConstsTab = {}

		for key, Ent in pairs(EntsTab) do
			if (Ent and Ent:IsValid()) then
				local MyTable = constraint.GetTable(Ent)

				for _, Constraint in pairs(MyTable) do
					if (not ConstsTab[Constraint.Constraint]) then
						ConstsTab[Constraint.Constraint] = Constraint
					end
				end
			end
		end

		return ConstsTab
	end
end

function TOOL:UpdateCustomGhost(ghost, player, offset)
	-- Ghost is identically buggy to that of easyweld...  welding two frozen props and two unfrozen props yields different ghosts even if identical allignment
	if (ghost == nil) then return end

	if (not ghost:IsValid()) then
		ghost = nil

		return
	end

	local tr = util.GetPlayerTrace(player, player:GetAimVector()) --REUPLOAD YOU STUPID WORKSHOP TOOL! (With 'Player' changing to 'player' it doesn't update the file :/)
	local trace = util.TraceLine(tr)
	if (not trace.Hit) then return end

	if self:GetOwner():KeyDown(IN_SPEED) and player_doors[self.GhostEntity:GetModel()] and IsValid(trace.Entity) and trace.Entity:GetModel() == player_doors[self.GhostEntity:GetModel()] then
		self.GhostEntity:SetAngles(trace.Entity:GetAngles())
		self.GhostEntity:SetPos(trace.Entity:LocalToWorld(door_pos[trace.Entity:GetModel()]))
		return
	end

	local Ang1, Ang2 = self:GetNormal(1):Angle(), (trace.HitNormal * -1):Angle()
	local TargetAngle = self:GetEnt(1):AlignAngles(Ang1, Ang2)
	self.GhostEntity:SetPos(self:GetEnt(1):GetPos())

	if self:GetClientNumber("autorotate") == 1 then
		TargetAngle.p = (math.Round(TargetAngle.p / 45)) * 45
		TargetAngle.r = (math.Round(TargetAngle.r / 45)) * 45
		TargetAngle.y = (math.Round(TargetAngle.y / 45)) * 45
	end

	self.GhostEntity:SetAngles(TargetAngle)
	local TraceNormal = trace.HitNormal
	local offsetpercent = self:GetClientNumber("offsetpercent") == 1
	local NewOffset = offset

	if (offsetpercent) then
		local glower = trace.Entity:OBBMins()
		local gupper = trace.Entity:OBBMaxs()
		local height = math.abs(gupper.z - glower.z) - 0.5

		if self:WithinABit(TraceNormal, trace.Entity:GetForward()) then
			height = math.abs(gupper.x - glower.x) - 0.5
		elseif self:WithinABit(TraceNormal, trace.Entity:GetRight()) then
			height = math.abs(gupper.y - glower.y) - 0.5
		end

		NewOffset = NewOffset / 100
		NewOffset = NewOffset * height
	end

	local TranslatedPos = ghost:LocalToWorld(self:GetLocalPos(1))
	local TargetPos = trace.HitPos + (self:GetEnt(1):GetPos() - TranslatedPos) + (TraceNormal * NewOffset)
	self.GhostEntity:SetPos(TargetPos)
end

function TOOL:Think()
	if (self:NumObjects() < 1) then return end
	local Ent1 = self:GetEnt(1)

	if SERVER and not Ent1:IsValid() then
		self:ClearObjects()
		return
	end

	if self:NumObjects() == 1 and self:GetClientNumber("mode") ~= 2 and self:GetClientNumber("mode") < 9 then
		if ((self:GetClientNumber("move") == 1 and self:GetClientNumber("mode") > 2) or self:GetClientNumber("mode") == 3) then
			local offset = self:GetClientNumber("offset")
			self:UpdateCustomGhost(self.GhostEntity, self:GetOwner(), offset)
		end
	else
		local rotate = (self:GetClientNumber("rotate") == 1 and self:GetClientNumber("mode") ~= 1) or self:GetClientNumber("mode") == 2

		if (SERVER and rotate) then
			local offset = self:GetClientNumber("offset")
			local Phys1 = self:GetPhys(1)
			local cmd = self:GetOwner():GetCurrentCommand()
			local rotation = self:GetClientNumber("rotation")

			if (rotation < 0.02) then
				rotation = 0.02
			end

			local degrees = cmd:GetMouseX() * 0.02
			local newdegrees = 0
			local changedegrees = 0
			local angle = 0

			if (self:GetOwner():KeyDown(IN_RELOAD)) then
				if (inuse == self:GetOwner():GetName()) then
					realdegreesY = realdegreesY + degrees
					newdegrees = realdegreesY - ((realdegreesY + (rotation / 2)) % rotation)
					changedegrees = lastdegreesY - newdegrees
					lastdegreesY = newdegrees
					angle = Phys1:RotateAroundAxis(axisY, changedegrees)
				else
					realdegrees2Y = realdegrees2Y + degrees
					newdegrees = realdegrees2Y - ((realdegrees2Y + (rotation / 2)) % rotation)
					changedegrees = lastdegrees2Y - newdegrees
					lastdegrees2Y = newdegrees
					angle = Phys1:RotateAroundAxis(axisY2, changedegrees)
				end
			elseif (self:GetOwner():KeyDown(IN_ATTACK2)) then
				if (inuse == self:GetOwner():GetName()) then
					realdegreesZ = realdegreesZ + degrees
					newdegrees = realdegreesZ - ((realdegreesZ + (rotation / 2)) % rotation)
					changedegrees = lastdegreesZ - newdegrees
					lastdegreesZ = newdegrees
					angle = Phys1:RotateAroundAxis(axisZ, changedegrees)
				else
					realdegrees2Z = realdegrees2Z + degrees
					newdegrees = realdegrees2Z - ((realdegrees2Z + (rotation / 2)) % rotation)
					changedegrees = lastdegrees2Z - newdegrees
					lastdegrees2Z = newdegrees
					angle = Phys1:RotateAroundAxis(axisZ2, changedegrees)
				end
			else
				if (inuse == self:GetOwner():GetName()) then
					realdegrees = realdegrees + degrees
					newdegrees = realdegrees - ((realdegrees + (rotation / 2)) % rotation)
					changedegrees = lastdegrees - newdegrees
					lastdegrees = newdegrees
					angle = Phys1:RotateAroundAxis(axis, changedegrees)
				else
					realdegrees2 = realdegrees2 + degrees
					newdegrees = realdegrees2 - ((realdegrees2 + (rotation / 2)) % rotation)
					changedegrees = lastdegrees2 - newdegrees
					lastdegrees2 = newdegrees
					angle = Phys1:RotateAroundAxis(axis2, changedegrees)
				end
			end

			Phys1:SetAngles(angle)

			if ((self:GetClientNumber("move") == 1 and self:GetClientNumber("mode") > 2) or self:GetClientNumber("mode") == 3) then
				local WPos2 = self:GetPos(2)
				local Ent2 = self:GetEnt(2)
				-- Move so spots join up
				local Norm2 = self:GetNormal(2)
				local NewOffset = offset
				local offsetpercent = self:GetClientNumber("offsetpercent") == 1

				if (offsetpercent) then
					local glower = Ent2:OBBMins()
					local gupper = Ent2:OBBMaxs()
					local height = math.abs(gupper.z - glower.z) - 0.5

					if self:WithinABit(Norm2, Ent2:GetForward()) then
						height = math.abs(gupper.x - glower.x) - 0.5
					elseif self:WithinABit(Norm2, Ent2:GetRight()) then
						height = math.abs(gupper.y - glower.y) - 0.5
					end

					NewOffset = NewOffset / 100
					NewOffset = NewOffset * height
				end

				Norm2 = Norm2 * (-0.0625 + NewOffset)
				local TargetPos = Vector(0, 0, 0)

				if (self:GetEnt(1) == self:GetEnt(2)) then
					TargetPos = SavedPos + (Phys1:GetPos() - self:GetPos(1)) + Norm2
				else
					TargetPos = WPos2 + (Phys1:GetPos() - self:GetPos(1)) + Norm2
				end

				if not checkPos(self:GetOwner(), TargetPos) then return end
				Phys1:SetPos(TargetPos)
			else
				-- Move so rotating on axis
				local TargetPos = (Phys1:GetPos() - self:GetPos(1))

				if (inuse == self:GetOwner():GetName()) then
					TargetPos = TargetPos + OldPos
				else
					TargetPos = TargetPos + OldPos2
				end

				if not checkPos(self:GetOwner(), TargetPos) then return end
				Phys1:SetPos(TargetPos)
			end

			Phys1:Wake()
		end
	end
end

function TOOL:Nudge(trace, direction)
	if (not trace.Entity:IsValid() or trace.Entity:IsPlayer()) then return false end
	local Phys1 = trace.Entity:GetPhysicsObjectNum(trace.PhysicsBone)
	local offset = self:GetClientNumber("nudge")

	local NewOffset = offset
	local offsetpercent = self:GetClientNumber("nudgepercent") == 1

	if (offsetpercent) then
		local glower = trace.Entity:OBBMins()
		local gupper = trace.Entity:OBBMaxs()
		local height = math.abs(gupper.z - glower.z) - 0.5

		if self:WithinABit(trace.HitNormal, trace.Entity:GetForward()) then
			height = math.abs(gupper.x - glower.x) - 0.5
		elseif self:WithinABit(trace.HitNormal, trace.Entity:GetRight()) then
			height = math.abs(gupper.y - glower.y) - 0.5
		end

		NewOffset = NewOffset / 100
		NewOffset = NewOffset * height
	end

	if (self:GetClientNumber("entirecontrap") == 1) then
		local NumApp = 0
		local TargetEnts = {}
		local EntsTab = {}
		local ConstsTab = {}
		GetAllEnts(trace.Entity, TargetEnts, EntsTab, ConstsTab)

		for key, CurrentEnt in pairs(TargetEnts) do
			if (CurrentEnt and CurrentEnt:IsValid()) then
				local CurrentPhys = CurrentEnt:GetPhysicsObject()

				if (CurrentPhys:IsValid()) then
					local TargetPos = CurrentPhys:GetPos() + trace.HitNormal * NewOffset * direction
					if not checkPos(self:GetOwner(), a) then return end
					CurrentPhys:SetPos(TargetPos)
					CurrentPhys:Wake()

					if (CurrentEnt:GetMoveType() == 0) then
						CurrentEnt:SetPos(TargetPos)
					end
				end
			end

			NumApp = NumApp + 1
		end
	else
		if (self:GetClientNumber("nudgeundo") == 1) then
			local oldpos = Phys1:GetPos()

			local function NudgeUndo(Undo, Entity, p)
				if trace.Entity:IsValid() then
					trace.Entity:SetPos(p)
				end
			end

			undo.Create("Precision PushPull")
			undo.SetPlayer(self:GetOwner())
			undo.AddFunction(NudgeUndo, trace.Entity, oldpos)
			undo.Finish()
		end

		local TargetPos = Phys1:GetPos() + trace.HitNormal * NewOffset * direction
		if not checkPos(self:GetOwner(), TargetPos) then return end
		Phys1:SetPos(TargetPos)
		Phys1:Wake()

		if (trace.Entity:GetMoveType() == 0) then
			trace.Entity:SetPos(TargetPos)
		end
	end

	return true
end

function TOOL:RightClick(trace)
	local rotate = self:GetClientNumber("rotate") == 1
	local mode = self:GetClientNumber("mode")

	if ((mode == 2 and self:NumObjects() == 1) or (rotate and self:NumObjects() == 2)) then
		if (CLIENT) then return false end
	else
		if (CLIENT) then return true end

		return self:Nudge(trace, -1)
	end
end

function TOOL:Reload(trace)
	local rotate = self:GetClientNumber("rotate") == 1
	local mode = self:GetClientNumber("mode")

	if ((mode == 2 and self:NumObjects() == 1) or (rotate and self:NumObjects() == 2)) then
		if (CLIENT) then return false end
	else
		if (CLIENT) then return true end

		return self:Nudge(trace, 1)
	end
end

if CLIENT then
	language.Add("Tool.precision.name", "Точный инструмент")
	language.Add("Tool.precision.desc", "Точно позиционирует объекты")
	language.Add("Tool.precision.0", "ЛКМ: Переместить | ПКМ: Толкать | R: Тянуть")
	language.Add("Tool.precision.1", "Выберите второй объект")
	language.Add("Tool.precision.2", "Вращайте предмет")

	language.Add("Undone.precision", "Отмена соединений предмета")
	language.Add("Undone.precision.nudge", "Отмена толкания предмета")
	language.Add("Undone.precision.rotate", "Отмена врещения предмета")
	language.Add("Undone.precision.move", "Отмена перемещения предмета")

	--local expandpresets = 0
	local function AddDefControls(Panel)
		Panel:ClearControls()

		Panel:AddControl("ComboBox", {
			Label = "#Presets",
			MenuButton = 1,
			Folder = "precision",
			Options = {},
			CVars = {
				[0] = "precision_offset",
				[1] = "precision_forcelimit",
				[2] = "precision_freeze",
				[3] = "precision_nocollide",
				[4] = "precision_nocollideall",
				[5] = "precision_rotation",
				[6] = "precision_rotate",
				[7] = "precision_torquelimit",
				[8] = "precision_friction",
				[9] = "precision_mode",
				[10] = "precision_width",
				[11] = "precision_offsetpercent",
				[12] = "precision_removal",
				[13] = "precision_move",
				[14] = "precision_physdisable",
				[15] = "precision_advballsocket",
				[16] = "precision_XRotMin",
				[17] = "precision_XRotMax",
				[18] = "precision_YRotMin",
				[19] = "precision_YRotMax",
				[20] = "precision_ZRotMin",
				[21] = "precision_ZRotMax",
				[22] = "precision_XRotFric",
				[23] = "precision_YRotFric",
				[24] = "precision_ZRotFric",
				[25] = "precision_FreeMov",
				[26] = "precision_ShadowDisable",
				[27] = "precision_allowphysgun",
				[28] = "precision_autorotate",
				[29] = "precision_massmode",
				[30] = "precision_nudge",
				[31] = "precision_nudgepercent",
				[32] = "precision_disablesliderfix"
			}
		})

		--Panel:AddControl( "Label", { Text = "Secondary attack pushes, Reload pulls by this amount:", Description	= "Phx 1x is 47.45, Small tiled cube is 11.8625 and thin is 3 exact units" }  )
		local slider = Panel:AddControl("Slider", {
			Label = "Единица толкания",
			Type = "Float",
			Min = 0.01,
			Max = 100,
			Command = "precision_nudge",
			Description = "Distance to push/pull props with altfire/reload"
		})

		slider:SetDecimals(4)

		local fnd1 = vgui.Create("MSDPanelList")
		fnd1:SetSize(Panel:GetWide(), 30)
		fnd1:EnableVerticalScrollbar()
		fnd1:EnableHorizontal(true)
		Panel:AddItem(fnd1)

		local bts = {
			0.01,
			0.1,
			1,
			5,
			10
		}
		for i = 1,5 do
			local button = vgui.Create("DButton")
			button:SetSize(25, 25)
			button:SetText(bts[i])
			button.StaticScale = {
				w = 5,
				fixed_h = 25,
				minw = 25,
				minh = 25
			}
			fnd1:AddItem(button)
			button.DoClick = function(self)
				RunConsoleCommand("precision_nudge", bts[i])
				slider:SetValue(bts[i])
			end
		end

		Panel:AddItem(Btn)

		Panel:AddControl("Checkbox", {
			Label = "Толкать исользуя проценты (%) исходя из размеров предмета",
			Command = "precision_nudgepercent",
			Description = "Unchecked = Exact units, Checked = takes % of width from target prop when pushing/pulling"
		})

		local user = LocalPlayer():GetInfoNum("precision_user", 0)
		local mode = LocalPlayer():GetInfoNum("precision_mode", 0)

		local list = vgui.Create("DListView")
		local height = 186 --All 10 shown

		if (user < 2) then
			height = 118 --6 shown
		elseif (user < 3) then
			height = 152 --8 shown
		end

		list:SetSize(30, height)
		--list:SizeToContents()
		list:AddColumn("Tool Mode")
		list:SetMultiSelect(false)

		function list:OnRowSelected(LineID, line)
			if mode ~= LineID then
				RunConsoleCommand("precision_setmode", LineID)
			end
		end

		list:AddLine(" 1  Пусто")

		if (mode == 2) then
			list:AddLine(" 2 ->Вращать<- (Вращение объекта без перемещения)")
		else
			list:AddLine(" 2   Вращать   (Вращение объекта без перемещения)")
		end

		if (mode == 3) then
			list:AddLine(" 3 ->Переместить<-")
		else
			list:AddLine(" 3   Переместить")
		end

		list:SortByColumn(1)
		Panel:AddItem(list)

		--[[Moving || mode == 3]]
		if (mode > 2 and mode <= 8) then
			Panel:AddControl("Checkbox", {
				Label = "Вращать предмет после перемещения",
				Command = "precision_rotate",
				Description = "Позволяет вращать объект после перемещения"
			})

			--Panel:AddControl( "Label", { Text = "This is the distance from touching of the targeted props after moving:", Description	= "Use 0 mostly, % takes the second prop's width." }  )
			Panel:AddControl("Slider", {
				Label = "Щель между объектами",
				Type = "Float",
				Min = 0,
				Max = 100,
				Command = "precision_offset",
				Description = "Дистанция между объектами после перемещения."
			})

			Panel:AddControl("Checkbox", {
				Label = "Щель в процентах (%) исходя из размеров предмета",
				Command = "precision_offsetpercent",
				Description = "Если не выбрано будет использовать юниты"
			})
		end

		Panel:AddControl("Slider", {
			Label = "Градусы вращения предмета",
			Type = "Float",
			Min = 0.02,
			Max = 90,
			Command = "precision_rotation",
			Description = "Rotation rotates by this amount at a time. No more guesswork. Min: 0.02 degrees"
		}):SetDecimals(4)


		Panel:AddControl("Checkbox", {
			Label = "Добавить толкание предмета в лист отмены",
			Command = "precision_nudgeundo",
			Description = "For if you're in danger of nudging somthing to where you can't reach it"
		})

		Panel:AddControl("Checkbox", {
			Label = "Добавить перемещение предмета в лист отмены",
			Command = "precision_moveundo",
			Description = "So you don't have to secondary fire with nocollide to undo mistakes"
		})

		Panel:AddControl("Checkbox", {
			Label = "Добавить вращение предмета в лист отмены",
			Command = "precision_rotateundo",
			Description = "So you can find the exact rotation value easier"
		})

	end

	local function precision_defaults()
		local mode = LocalPlayer():GetInfoNum("precision_mode", 3)

		if mode == 1 then
			RunConsoleCommand("precision_freeze", "1")
			RunConsoleCommand("precision_autorotate", "1")
			RunConsoleCommand("precision_ShadowDisable", "0")
			RunConsoleCommand("precision_nocollideall", "0")
			RunConsoleCommand("precision_physdisable", "0")
			RunConsoleCommand("precision_allowphysgun", "0")
			RunConsoleCommand("precision_entirecontrap", "0")
		elseif mode == 2 then
			RunConsoleCommand("precision_rotation", "15")
			RunConsoleCommand("precision_freeze", "1")
			RunConsoleCommand("precision_entirecontrap", "0")
		elseif mode == 3 then
			RunConsoleCommand("precision_rotate", "1")
			RunConsoleCommand("precision_offset", "0")
			RunConsoleCommand("precision_offsetpercent", "1")
			RunConsoleCommand("precision_rotation", "15")
			RunConsoleCommand("precision_freeze", "1")
			RunConsoleCommand("precision_nocollide", "1")
			RunConsoleCommand("precision_autorotate", "1")
			RunConsoleCommand("precision_entirecontrap", "0")
		end

		precision_updatecpanel()
	end
	concommand.Add("precision_defaultrestore", precision_defaults)

	function precision_setmode(player, tool, args)
		if LocalPlayer():GetInfoNum("precision_mode", 3) ~= args[1] then
			RunConsoleCommand("precision_mode", args[1])

			timer.Simple(0.05, function()
				precision_updatecpanel()
			end)
		end
	end

	concommand.Add("precision_setmode", precision_setmode)


	function precision_updatecpanel()
		local Panel = controlpanel.Get("precision")
		if (not Panel) then return end
		--custom panel building ( wtf does Panel:AddDefaultControls() get it's defaults from? )
		AddDefControls(Panel)
	end

	concommand.Add("precision_updatecpanel", precision_updatecpanel)

	function TOOL.BuildCPanel(Panel)
		AddDefControls(Panel)
	end

	function TOOL:FreezeMovement()
		local iNum = self:GetStage()

		if (iNum > 1) then
			return true
		elseif (iNum > 0 and self:GetClientNumber("mode") == 2) then
			return true
		end

		return false
	end
end

function TOOL:Holster()
	self:ClearObjects()
end