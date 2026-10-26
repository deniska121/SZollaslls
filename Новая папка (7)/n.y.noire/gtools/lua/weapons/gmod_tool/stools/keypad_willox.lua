--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/keypad_willox.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if (SERVER) then
	CreateConVar("sbox_maxkeypads", 10)
end

TOOL.Category = "Construction"
TOOL.Name = "Кейпад"
TOOL.Command = nil
TOOL.ClientConVar["weld"] = "1"
TOOL.ClientConVar["freeze"] = "1"
TOOL.ClientConVar["password"] = ""
TOOL.ClientConVar["secure"] = "0"
TOOL.ClientConVar["repeats_granted"] = "0"
TOOL.ClientConVar["repeats_denied"] = "0"
TOOL.ClientConVar["length_granted"] = "0.1"
TOOL.ClientConVar["length_denied"] = "0.1"
TOOL.ClientConVar["delay_granted"] = "0"
TOOL.ClientConVar["delay_denied"] = "0"
TOOL.ClientConVar["init_delay_granted"] = "0"
TOOL.ClientConVar["init_delay_denied"] = "0"
TOOL.ClientConVar["key_granted"] = "0"
TOOL.ClientConVar["key_denied"] = "0"
cleanup.Register("keypads")

if (CLIENT) then
	language.Add("tool.keypad_willox.name", "Кодовый замок")
	language.Add("tool.keypad_willox.0", "ЛКМ - создать, ПКМ - обновить.")
	language.Add("tool.keypad_willox.desc", "Создать кодовый замок для усиленной защиты.")
	language.Add("Undone_Keypad", "Удален кейпад")
	language.Add("Cleanup_keypads", "Кейпады")
	language.Add("Cleaned_keypads", "Удалить все кейпады")
	language.Add("SBoxLimit_keypads", "Вы достигли лимита кодовых замков!")
end

local function checkPos(ply, vec)
	if checkRights(ply) then return true end

	for _, territory in pairs(Territories.list) do
		if territory:IsInsideV(vec) then
			if not territory:AllowedPropSpawn(ply) then
				return false
			end

			return true
		end
	end

	return false
end

function TOOL:SetupKeypad(ent, pass)
	local data = {
		Password = pass,
		RepeatsGranted = self:GetClientNumber("repeats_granted"),
		RepeatsDenied = self:GetClientNumber("repeats_denied"),
		LengthGranted = self:GetClientNumber("length_granted"),
		LengthDenied = self:GetClientNumber("length_denied"),
		DelayGranted = self:GetClientNumber("delay_granted"),
		DelayDenied = self:GetClientNumber("delay_denied"),
		InitDelayGranted = self:GetClientNumber("init_delay_granted"),
		InitDelayDenied = self:GetClientNumber("init_delay_denied"),
		KeyGranted = self:GetClientNumber("key_granted"),
		KeyDenied = self:GetClientNumber("key_denied"),
		Secure = tobool(self:GetClientNumber("secure")),
		Owner = self:GetOwner()
	}

	ent:SetData(data)
end

function TOOL:RightClick(tr)
	if (IsValid(tr.Entity) and tr.Entity:GetClass() ~= "keypad") then return false end
	if (CLIENT) then return true end
	local ply = self:GetOwner()

	if not checkPos(ply, tr.HitPos) then
		return true
	end

	local password = tonumber(ply:GetInfo("keypad_willox_password"))
	local trace_ent = tr.Entity

	if (password == nil or (string.len(tostring(password)) > 4) or (string.find(tostring(password), "0"))) then
		ply:PrintMessage(3, "Неверный пароль!")

		return false
	end

	if (trace_ent:GetClass() == "keypad" and trace_ent.KeypadData.Owner == ply) then
		self:SetupKeypad(trace_ent, password) -- validated password

		return true
	end
end

function TOOL:LeftClick(tr)
	if (IsValid(tr.Entity) and tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end
	local ply = self:GetOwner()

	if not checkPos(ply, tr.HitPos) then
		return true
	end

	local password = self:GetClientNumber("password")
	local spawn_pos = tr.HitPos + tr.HitNormal
	local trace_ent = tr.Entity

	if (password == nil or (string.len(tostring(password)) > 4) or (string.find(tostring(password), "0"))) then
		ply:PrintMessage(3, "Неверный пароль!")

		return false
	end

	if (not self:GetWeapon():CheckLimit("keypads")) then return false end
	local ent = ents.Create("keypad")
	ent:SetPos(spawn_pos)
	ent:SetAngles(tr.HitNormal:Angle())
	ent:Spawn()
	ent:SetPlayer(ply)
	ent:SetAngles(tr.HitNormal:Angle())
	ent:Activate()
	local phys = ent:GetPhysicsObject() -- rely on this being valid
	self:SetupKeypad(ent, password)
	undo.Create("Keypad")

	if (util.tobool(self:GetClientNumber("freeze"))) then
		phys:EnableMotion(false)
	end

	if (util.tobool(self:GetClientNumber("weld"))) then
		phys:EnableMotion(false) -- The timer allows the keypad to fall slightly, no thanks

		timer.Simple(0, function()
			if (IsValid(ent) and IsValid(trace_ent)) then
				local weld = constraint.Weld(ent, trace_ent)
			end
		end)

		ent:GetPhysicsObject():EnableCollisions(false)
	end

	undo.AddEntity(ent)
	undo.SetPlayer(ply)
	undo.Finish()
	ply:AddCount("keypads", ent)
	ply:AddCleanup("keypads", ent)

	return true
end

if (CLIENT) then
	local function ResetSettings(ply)
		ply:ConCommand("keypad_willox_repeats_granted 0")
		ply:ConCommand("keypad_willox_repeats_denied 0")
		ply:ConCommand("keypad_willox_length_granted 0.1")
		ply:ConCommand("keypad_willox_length_denied 0.1")
		ply:ConCommand("keypad_willox_delay_granted 0")
		ply:ConCommand("keypad_willox_delay_denied 0")
		ply:ConCommand("keypad_willox_init_delay_granted 0")
		ply:ConCommand("keypad_willox_init_delay_denied 0")
	end

	concommand.Add("keypad_willox_reset", ResetSettings)

	function TOOL.BuildCPanel(CPanel)
		local r, l = CPanel:TextEntry("4-х значный пароль", "keypad_willox_password")
		r:SetTall(22)
		CPanel:ControlHelp("Возможные символы: 1-9")
		CPanel:CheckBox("Режим скрытия", "keypad_willox_secure")
		CPanel:CheckBox("Сварить", "keypad_willox_weld")
		CPanel:CheckBox("Заморозить", "keypad_willox_freeze")
		local ctrl = vgui.Create("CtrlNumPad", CPanel)
		ctrl:SetConVar1("keypad_willox_key_granted")
		ctrl:SetConVar2("Keypad_willox_key_denied")
		ctrl:SetLabel1("Доступ разрешен")
		ctrl:SetLabel2("Доступ запрещен")
		CPanel:AddPanel(ctrl)
		CPanel:Button("Обнулить настройки", "keypad_willox_reset")
		CPanel:Help("")
		CPanel:Help("Настройки при правильном вводе пароля")
		CPanel:NumSlider("Врямя задержки", "keypad_willox_length_granted", 0.1, 10, 2)
		CPanel:NumSlider("Начальная задержка", "keypad_willox_init_delay_granted", 0, 10, 2)
		CPanel:NumSlider("Задержка при множественном вводе", "keypad_willox_delay_granted", 0, 10, 2)
		CPanel:NumSlider("Дополнительные повторы", "keypad_willox_repeats_granted", 0, 5, 0)
		CPanel:Help("")
		CPanel:Help("Настройки при неправильном вводе пароля")
		CPanel:NumSlider("Врямя задержки", "keypad_willox_length_denied", 0.1, 10, 2)
		CPanel:NumSlider("Начальная задержка", "keypad_willox_init_delay_denied", 0, 10, 2)
		CPanel:NumSlider("Задержка при множественном вводе", "keypad_willox_delay_denied", 0, 10, 2)
		CPanel:NumSlider("Дополнительные повторы", "keypad_willox_repeats_denied", 0, 5, 0)
	end
end