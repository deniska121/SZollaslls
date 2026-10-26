--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/ledscreen.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Construction"
TOOL.Name = "Таблички"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["text"] = ""
TOOL.ClientConVar["type"] = 1
TOOL.ClientConVar["font"] = 1
TOOL.ClientConVar["model"] = 1

if (SERVER) then
	CreateConVar("sbox_maxledscreens", 7)
end

cleanup.Register("ledscreens")

TOOL.Information = {
	{
		name = "left"
	}
}

if (CLIENT) then
	language.Add("Tool.ledscreen.name", "Таблички")
	language.Add("Tool.ledscreen.desc", "Создает таблички")
	language.Add("Tool.ledscreen.left", "Создать табличку")
	language.Add("Undone.ledscreens", "Удалена табличка")
	language.Add("Undone_ledscreens", "Удалена табличка")
	language.Add("Cleanup.ledscreens", "Таблички")
	language.Add("Cleanup_ledscreens", "Таблички")
	language.Add("Cleaned.ledscreens", "Cleaned up all ledscreens")
	language.Add("Cleaned_ledscreens", "Cleaned up all ledscreens")
	language.Add("SBoxLimit.ledscreens", "Лимит табличек")
	language.Add("SBoxLimit_ledscreens", "Лимит табличек")
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

function TOOL:LeftClick(tr)
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local Ply = self:GetOwner()

	if not checkPos(Ply, tr.HitPos) then
		return true
	end

	local angle = tr.HitNormal:Angle()
	local SpawnPos = tr.HitPos
	if not (self:GetWeapon():CheckLimit("ledscreens")) then return false end

	local TextScreen = ents.Create("gb_rp_sign")
	TextScreen:SetPos(SpawnPos)
	TextScreen:Spawn()
	TextScreen:SetMaterial("gbskins/sign/a" .. math.Clamp(self:GetClientInfo("model"), 1, 4))

	local stype = math.Clamp(self:GetClientInfo("type"), 1, 2)
	if stype == 2 then
		angle:RotateAroundAxis(tr.HitNormal:Angle():Forward(), 90)
	end

	TextScreen:SetAngles(angle)
	TextScreen:SetText(self:GetClientInfo("text"))
	TextScreen:SetType(stype)
	TextScreen:SetFont(math.Clamp(self:GetClientInfo("font"), 1, 10))
	TextScreen:Activate()
	local Phys = TextScreen:GetPhysicsObject()
	Phys:EnableMotion(false)
	undo.Create("ledscreens")
	undo.AddEntity(TextScreen)
	undo.SetPlayer(Ply)
	undo.Finish()
	Ply:AddCount("ledscreens", TextScreen)
	Ply:AddCleanup("ledscreens", TextScreen)

	return true
end

function TOOL:RightClick(tr)
	if (CLIENT) then return true end
end

function TOOL:Reload(tr)
	if not IsValid(tr.Entity) then return false end
	local TraceEnt = tr.Entity

	if (TraceEnt:IsValid() and TraceEnt:GetClass() == "gb_rp_sign") and CLIENT then
		RunConsoleCommand("ledscreen_text", TraceEnt:GetText())
		RunConsoleCommand("ledscreen_type", TraceEnt:GetType())
		RunConsoleCommand("ledscreen_font", TraceEnt:GetFont())
	end

	return true
end

if SERVER then return end

local TextBox
local slider = {}

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Text = "#Tool.ledscreen.name"
	})

	slider[1] = vgui.Create("DNumSlider")
	slider[1]:SetText("Вертикально / Горизонтально")
	slider[1]:SetMinMax(1, 2)
	slider[1]:SetDecimals(0)
	slider[1]:SetValue(1)
	slider[1]:SetConVar("ledscreen_type")
	CPanel:AddItem(slider[1])

	slider[2] = vgui.Create("DNumSlider")
	slider[2]:SetText("Шрифт")
	slider[2]:SetMinMax(1, 10)
	slider[2]:SetDecimals(0)
	slider[2]:SetValue(1)
	slider[2]:SetConVar("ledscreen_font")
	CPanel:AddItem(slider[2])

	slider[3] = vgui.Create("DNumSlider")
	slider[3]:SetText("Скин")
	slider[3]:SetMinMax(1, 4)
	slider[3]:SetDecimals(0)
	slider[3]:SetValue(1)
	slider[3]:SetConVar("ledscreen_model")
	CPanel:AddItem(slider[3])

	TextBox = vgui.Create("DTextEntry")
	TextBox:SetUpdateOnType(true)
	TextBox:SetHeight(500)

	TextBox:SetMultiline(true)
	TextBox:SetConVar("ledscreen_text")
	TextBox:SetValue(GetConVar("ledscreen_text"):GetString())
	CPanel:AddItem(TextBox)
end