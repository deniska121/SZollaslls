--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/stacker.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Construction"
TOOL.Name = "#Tool.stacker.name"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["nocollide"] = "0"
TOOL.ClientConVar["mode"] = "1"
TOOL.ClientConVar["dir"] = "1"
TOOL.ClientConVar["count"] = "1"
TOOL.ClientConVar["model"] = ""
TOOL.ClientConVar["offsetx"] = "0"
TOOL.ClientConVar["offsety"] = "0"
TOOL.ClientConVar["offsetz"] = "0"
TOOL.ClientConVar["rotp"] = "0"
TOOL.ClientConVar["roty"] = "0"
TOOL.ClientConVar["rotr"] = "0"

if SERVER then
	util.AddNetworkString("StackGhost")
	util.AddNetworkString("UnstackGhost")
end

if (CLIENT) then
	language.Add("Tool.stacker.name", "Стакер")
	language.Add("Tool.stacker.desc", "Копирует и создает новый проп относительно выдленного")
	language.Add("Tool.stacker.0", "Создать проп")
	language.Add("Undone_stacker", "Удален проп стакера")
end

function TOOL:Holster()
	self:ReleaseGhostStack()
end

function TOOL:Deploy()
	--	self.StackedEnts = {}
end

function TOOL:LeftClick(trace)
	if not trace.Entity or not trace.Entity:IsValid() or trace.Entity:GetClass() ~= "prop_physics" then return false end
	if CLIENT then return true end
	local NoCollide = self:GetClientNumber("nocollide") == 1
	local Mode = self:GetClientNumber("mode")
	local Dir = self:GetClientNumber("dir")
	local Count = 1
	local OffsetX = self:GetClientNumber("offsetx")
	local OffsetY = self:GetClientNumber("offsety")
	local OffsetZ = self:GetClientNumber("offsetz")
	local RotP = self:GetClientNumber("rotp")
	local RotY = self:GetClientNumber("roty")
	local RotR = self:GetClientNumber("rotr")
	local Offset = Vector(-0.5 + OffsetX, OffsetY, OffsetZ)
	local Rot = Angle(RotP, RotY, RotR)
	local ply = self:GetOwner()
	local Ent = trace.Entity
	local NewVec = Ent:GetPos()
	local NewAng = Ent:GetAngles()
	local LastEnt = Ent

	if Count <= 0 then return false end
	undo.Create("stacker")
	if (not self:GetSWEP():CheckLimit("props")) then return end
	StackDir, Height, ThisOffset = self:StackerCalcPos(LastEnt, Mode, Dir, Offset)
	NewVec = NewVec + StackDir * Height + ThisOffset
	NewAng = NewAng + Rot

	local canspawn = hook.Call("PlayerSpawnProp", GAMEMODE, ply, Ent:GetModel())

	if not canspawn then return false end

	local NewEnt = ents.Create("prop_physics")
	NewEnt:SetModel(Ent:GetModel())
	NewEnt:SetColor(Ent:GetColor())
	NewEnt:SetPos(NewVec)
	NewEnt:SetAngles(NewAng)
	NewEnt:Spawn()
	NewEnt:GetPhysicsObject():EnableMotion(false)

	if NoCollide then
		local NoCollideEnt = constraint.NoCollide(LastEnt, NewEnt, 0, 0)
		undo.AddEntity(NoCollideEnt)
	end

	LastEnt = NewEnt
	undo.AddEntity(NewEnt)
	ply:AddCount("props", NewEnt)
	ply:AddCleanup("props", NewEnt)

	if PropDefender and PropDefender.Player and PropDefender.Player.Give then
		PropDefender.Player.Give(ply, NewEnt, false)
	end

	undo.SetPlayer(ply)
	undo.Finish()

	hook.Call("PlayerSpawnedProp", GAMEMODE, ply, NewEnt:GetModel(), NewEnt)

	return true
end

function TOOL:StackerCalcPos(lastent, mode, dir, offset)
	local forward = Vector(1, 0, 0):Angle()
	--local pos = lastent:GetPos()
	local ang = lastent:GetAngles()
	local lower, upper = lastent:WorldSpaceAABB()
	local glower = lastent:OBBMins()
	local gupper = lastent:OBBMaxs()
	local stackdir = Vector(0, 0, 1)
	local height = math.abs(upper.z - lower.z)

	-- Relative to world
	if mode == 1 then
		if dir == 1 then
			stackdir = forward:Up()
			height = math.abs(upper.z - lower.z)
		elseif dir == 2 then
			stackdir = forward:Up() * -1
			height = math.abs(upper.z - lower.z)
		elseif dir == 3 then
			stackdir = forward:Forward()
			height = math.abs(upper.x - lower.x)
		elseif dir == 4 then
			stackdir = forward:Forward() * -1
			height = math.abs(upper.x - lower.x)
		elseif dir == 5 then
			stackdir = forward:Right()
			height = math.abs(upper.y - lower.y)
		elseif dir == 6 then
			stackdir = forward:Right() * -1
			height = math.abs(upper.y - lower.y)
		end
	elseif mode == 2 then
		-- Relative to prop
		forward = ang

		if dir == 1 then
			stackdir = forward:Up()
			offset = forward:Up() * offset.X + forward:Forward() * -1 * offset.Z + forward:Right() * offset.Y
			height = math.abs(gupper.z - glower.z)
		elseif dir == 2 then
			stackdir = forward:Up() * -1
			offset = forward:Up() * -1 * offset.X + forward:Forward() * offset.Z + forward:Right() * offset.Y
			height = math.abs(gupper.z - glower.z)
		elseif dir == 3 then
			stackdir = forward:Forward()
			offset = forward:Forward() * offset.X + forward:Up() * offset.Z + forward:Right() * offset.Y
			height = math.abs(gupper.x - glower.x)
		elseif dir == 4 then
			stackdir = forward:Forward() * -1
			offset = forward:Forward() * -1 * offset.X + forward:Up() * offset.Z + forward:Right() * -1 * offset.Y
			height = math.abs(gupper.x - glower.x)
		elseif dir == 5 then
			stackdir = forward:Right()
			offset = forward:Right() * offset.X + forward:Up() * offset.Z + forward:Forward() * -1 * offset.Y
			height = math.abs(gupper.y - glower.y)
		elseif dir == 6 then
			stackdir = forward:Right() * -1
			offset = forward:Right() * -1 * offset.X + forward:Up() * offset.Z + forward:Forward() * offset.Y
			height = math.abs(gupper.y - glower.y)
		end
	end

	return stackdir, height, offset
end

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Checkbox", {
		Label = "Отключить столкновение",
		Command = "stacker_nocollide"
	})

	local params = {
		Label = "Относительно:",
		MenuButton = "0",
		Options = {}
	}

	params.Options["Миру"] = {
		stacker_mode = "1"
	}

	params.Options["Пропу"] = {
		stacker_mode = "2"
	}

	CPanel:AddControl("ComboBox", params)

	params = {
		Label = "Направление",
		MenuButton = "0",
		Options = {}
	}

	params.Options["↑ Вверх"] = {
		stacker_dir = "1"
	}

	params.Options["↓ Вниз"] = {
		stacker_dir = "2"
	}

	params.Options["➚ Вперед"] = {
		stacker_dir = "3"
	}

	params.Options["↙ Назад"] = {
		stacker_dir = "4"
	}

	params.Options["→ Направо"] = {
		stacker_dir = "5"
	}

	params.Options["← Налево"] = {
		stacker_dir = "6"
	}

	-- local frame = vgui.Create("DPanel")
	-- frame:SetSize(CPanel:GetWide(), 150)
	-- CPanel:AddItem(frame)
	CPanel:AddControl("ComboBox", params)

	CPanel:AddControl("Button", {
		Label = "Сбросить",
		Command = "stacker_resetoffsets",
		Text = "Reset"
	})

	CPanel:AddControl("Slider", {
		Label = "Смещение X (вперед/назад)",
		Type = "Float",
		Min = -1000,
		Max = 1000,
		Value = 0,
		Command = "stacker_offsetx"
	})

	CPanel:AddControl("Slider", {
		Label = "Смещение Y (вправо/влево)",
		Type = "Float",
		Min = -1000,
		Max = 1000,
		Value = 0,
		Command = "stacker_offsety"
	})

	CPanel:AddControl("Slider", {
		Label = "Смещение Z (вверх/вниз)",
		Type = "Float",
		Min = -1000,
		Max = 1000,
		Value = 0,
		Command = "stacker_offsetz"
	})

	CPanel:AddControl("Slider", {
		Label = "Повернуть (Шаг)",
		Type = "Float",
		Min = -360,
		Max = 360,
		Value = 0,
		Command = "stacker_rotp"
	})

	CPanel:AddControl("Slider", {
		Label = "Повернуть (Рыскание)",
		Type = "Float",
		Min = -360,
		Max = 360,
		Value = 0,
		Command = "stacker_roty"
	})

	CPanel:AddControl("Slider", {
		Label = "Повернуть (Крен)",
		Type = "Float",
		Min = -360,
		Max = 360,
		Value = 0,
		Command = "stacker_rotr"
	})
end

if (CLIENT) then
	local function ResetOffsets(ply, command, arguments)
		LocalPlayer():ConCommand("stacker_offsetx 0\n")
		LocalPlayer():ConCommand("stacker_offsety 0\n")
		LocalPlayer():ConCommand("stacker_offsetz 0\n")
		LocalPlayer():ConCommand("stacker_rotp 0\n")
		LocalPlayer():ConCommand("stacker_roty 0\n")
		LocalPlayer():ConCommand("stacker_rotr 0\n")
	end

	concommand.Add("stacker_resetoffsets", ResetOffsets)
end

function TOOL:UpdateGhostStack(ent)
	if (not ent or not ent:IsValid() or not self:CheckGhostStack()) then return end
	local mode = self:GetClientNumber("mode")
	local dir = self:GetClientNumber("dir")
	local offsetx = self:GetClientNumber("offsetx")
	local offsety = self:GetClientNumber("offsety")
	local offsetz = self:GetClientNumber("offsetz")
	local rotp = self:GetClientNumber("rotp")
	local roty = self:GetClientNumber("roty")
	local rotr = self:GetClientNumber("rotr")
	local offset = Vector(-0.5 + offsetx, offsety, offsetz)
	local rot = Angle(rotp, roty, rotr)
	local NewEnt = ent
	local NewVec = NewEnt:GetPos()
	local NewAng = NewEnt:GetAngles()
	local stackdir, height, thisoffset

	for k, v in pairs(self.GhostStack) do
		if k == 1 or (mode == 2) then
			stackdir, height, thisoffset = self:StackerCalcPos(NewEnt, mode, dir, offset)
		end

		NewVec = NewVec + stackdir * height + thisoffset
		NewAng = NewAng + rot
		v:SetAngles(NewAng)
		v:SetPos(NewVec)
		v:SetNoDraw(false)
		NewEnt = v
		--SimpleAdmin:Broadcast(k .. ": " .. tostring(NewAng) .. " : " .. tostring(NewVec) .. " : " .. tostring(v) .. ".")
	end
end

--Returns if stack is ok
function TOOL:CheckGhostStack()
	if not self.GhostStack then return false end

	for k, v in pairs(self.GhostStack) do
		if (not v or not v:IsValid()) then return false end --if something in the table doesn't exist or it's a null entity tell em it's not ok
	end

	return true
end

function TOOL:IsInGhostStack(ent)
	if not self.GhostStack then return false end

	for k, v in pairs(self.GhostStack) do
		if (ent == v) then return true end
	end

	return false
end

function TOOL:CreateGhostStack(prop, pos, ang)
	if (self.GhostStack) then
		self:ReleaseGhostStack()
	end

	self.GhostStack = {}
	if SERVER then return false end
	local Count = 1

	for i = 1, Count do
		local Ghost
		Ghost = ents.CreateClientProp(prop)

		if (not Ghost:IsValid()) then
			Ghost = nil

			return
		end

		Ghost:SetModel(prop)
		Ghost:SetPos(pos)
		Ghost:SetAngles(ang)
		Ghost:Spawn()
		Ghost:SetSolid(SOLID_VPHYSICS)
		Ghost:SetMoveType(MOVETYPE_NONE)
		Ghost:SetNotSolid(true)
		Ghost:SetRenderMode(RENDERMODE_TRANSALPHA)
		Ghost:SetColor(Color(255, 255, 255, 150))
		table.insert(self.GhostStack, Ghost)
	end

	return true
end

function TOOL:ReleaseGhostStack()
	if not self.GhostStack then return end

	for k, v in pairs(self.GhostStack) do
		if not v or not v:IsValid() then continue end
		v:Remove()
	end

	table.Empty(self.GhostStack)
end

function TOOL:Think()
	local ply = self:GetOwner()
	local trace = ply:GetEyeTrace()
	local stacked = false

	if (IsValid(trace.Entity) and trace.Hit and trace.Entity:GetClass() == "prop_physics") then
		self.NewEnt = trace.Entity

		if (self.NewEnt:IsValid() and self.NewEnt ~= self.LastEnt) then
			--SimpleAdmin:Broadcast("Creating new stack.")
			stacked = self:CreateGhostStack(self.NewEnt:GetModel(), Vector(0, 0, 0), Angle(0, 0, 0))

			if stacked then
				self.LastEnt = self.NewEnt
			end
		end

		if (not self:CheckGhostStack()) then
			--SimpleAdmin:Broadcast("Releasing old stack.")
			self:ReleaseGhostStack()
			self.LastEnt = nil
		end
	elseif ((IsValid(trace.Entity) and trace.Entity:GetClass() ~= "prop_physics" and self.LastEnt ~= nil) or not IsValid(trace.Entity)) then
		--SimpleAdmin:Broadcast("Releasing old stack.")
		self:ReleaseGhostStack()
		self.LastEnt = nil
	end

	if (self.LastEnt ~= nil and self.LastEnt:IsValid()) then
		--SimpleAdmin:Broadcast("Updating old stack.")
		self:UpdateGhostStack(self.LastEnt)
	end
end

function StackGhost()
	local tbl = net.ReadTable()
	GhostStack = tbl[1]
end

net.Receive("StackGhost", StackGhost)

function UnstackGhost()
	if not GhostStack then return end
	table.Empty(GhostStack)
end

net.Receive("UnstackGhost", UnstackGhost)