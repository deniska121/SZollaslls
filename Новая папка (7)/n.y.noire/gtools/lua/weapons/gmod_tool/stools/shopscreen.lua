--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/shopscreen.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Construction"
TOOL.Name = "Рекламные панели"
TOOL.Command = nil
TOOL.ConfigName = ""
ShopFront = ShopFront or {}
local TextBox = {}
local TextBox2 = {}
local slider = {}

TOOL.ClientConVar["text"] = ""
TOOL.ClientConVar["subtext"] = ""
TOOL.ClientConVar["style"] = 1
TOOL.ClientConVar["fond1"] = 1
TOOL.ClientConVar["fond2"] = 1
TOOL.ClientConVar["cl1"] = 1
TOOL.ClientConVar["cl2"] = 2
TOOL.ClientConVar["out1"] = 0
TOOL.ClientConVar["out2"] = 0
TOOL.ClientConVar["sdw1"] = 0
TOOL.ClientConVar["sdw2"] = 0

if (SERVER) then
	CreateConVar("sbox_maxshopscreen", 3)
end

cleanup.Register("shopscreen")

TOOL.Information = {
	{
		name = "left"
	}
}

if (CLIENT) then
	language.Add("Tool.shopscreen.name", "Рекламные панели")
	language.Add("Tool.shopscreen.desc", "Создает рекламные панели")
	language.Add("Tool.shopscreen.left", "Создать панель")
	language.Add("Undone.shopscreen", "Undone shopscreen")
	language.Add("Undone_shopscreen", "Undone shopscreen")
	language.Add("Cleanup.shopscreen", "shopscreen")
	language.Add("Cleanup_shopscreen", "shopscreen")
	language.Add("Cleaned.shopscreen", "Cleaned up all shopscreen")
	language.Add("Cleaned_shopscreen", "Cleaned up all shopscreen")
	language.Add("SBoxLimit.shopscreen", "You've hit the shopscreen limit!")
	language.Add("SBoxLimit_shopscreen", "You've hit the shopscreen limit!")
end

local function checkPos(ply, vec)
	if checkRights(ply) then return true end

	for _, territory in pairs(Territories.list) do
		if territory:IsInsideV(vec) then
			if not territory:AllowedPropSpawn(ply) then
				return false
			end

			if not territory.propetytype then
				return false
			end

			return true
		end
	end

	return false
end

function TOOL:LeftClick(tr)
	if self.PlaceTime and self.PlaceTime + 1 > CurTime() then return false end
	if (tr.Entity:GetClass() == "player") then return false end
	if (CLIENT) then return true end

	local Ply = self:GetOwner()

	if not checkPos(Ply, tr.HitPos) then
		return true
	end

	local angle = tr.HitNormal:Angle()
	local SpawnPos = tr.HitPos

	if not Ply:IsAdmin() then
		for k,v in ipairs(ents.FindInSphere(SpawnPos, 750)) do
			if v:GetClass() == "gb_rp_sign_big" and v:CPPIGetOwner() == Ply then
				DarkRP.notify(Ply, 1, 5, "Рядом уже есть рекламная панель")
				return
			end
		end
	end

	local TraceEnt = tr.Entity

	if IsValid(TraceEnt) and TraceEnt:GetClass() == "gb_rp_sign_big" and TraceEnt:CPPIGetOwner() == Ply then
		SpawnPos = TraceEnt:GetPos()
		angle = TraceEnt:GetAngles()

		TraceEnt:Remove()
	end

	if not (self:GetWeapon():CheckLimit("shopscreen")) then return false end

	local TextScreen = ents.Create("gb_rp_sign_big")
	TextScreen:SetPos(SpawnPos)
	TextScreen:Spawn()
	TextScreen:SetAngles(angle)
	TextScreen:Activate()

	TextScreen:SetT1(self:GetClientInfo("text"))
	TextScreen:SetT2(self:GetClientInfo("subtext"))
	TextScreen:SetC1(tonumber(self:GetClientInfo("cl1")) or 1)
	TextScreen:SetC2(tonumber(self:GetClientInfo("cl2")) or 1)
	TextScreen:SetF1(tonumber(self:GetClientInfo("fond1")) or 1)
	TextScreen:SetF2(tonumber(self:GetClientInfo("fond2")) or 1)
	TextScreen:SetST(tonumber(self:GetClientInfo("style")) or 1)
	TextScreen:SetS1(tonumber(self:GetClientInfo("sdw1")) or 1)
	TextScreen:SetS2(tonumber(self:GetClientInfo("sdw2")) or 1)
	TextScreen:SetO1(tonumber(self:GetClientInfo("out1")) or 1)
	TextScreen:SetO2(tonumber(self:GetClientInfo("out2")) or 1)

	local Phys = TextScreen:GetPhysicsObject()
	Phys:EnableMotion(false)

	undo.Create("shopscreen")
	undo.AddEntity(TextScreen)
	undo.SetPlayer(Ply)
	undo.Finish()

	Ply:AddCount("shopscreen", TextScreen)
	Ply:AddCleanup("shopscreen", TextScreen)
	self.PlaceTime = CurTime()
	return true
end

function TOOL:RightClick(tr)
	return true
end

function TOOL:Reload(tr)
	return true
end

if SERVER then return end

local mats = {
	Material("cityrp/stains.png", "smooth"),
	Material("cityrp/lumhd.png", "smooth"),
}

local dirtmat = {
	[1] = Material("cityrp/dirt.png", "smooth"),
	[2] = Material("cityrp/dirt1.png", "smooth"),
	[3] = Material("cityrp/dirt0.png", "smooth")
}

local frame

function TOOL.BuildCPanel(CPanel)
	local prsts = ShopFront.Colors

	frame = vgui.Create("DPanel")
	frame:SetSize(CPanel:GetWide(), CPanel:GetWide() / 2.0971)
	if not frame.dirt then
		frame.dirt = dirtmat[math.random(#dirtmat)]
	end
	frame.style = 1
	frame.cl1 = GetConVar("shopscreen_cl1"):GetInt()
	frame.cl2 = GetConVar("shopscreen_cl2"):GetInt()

	frame.font = "SF" .. math.Clamp(GetConVar("shopscreen_fond1"):GetInt(), 1, 6) .. "S6"
	surface.SetFont(frame.font)
	frame.f1w, frame.f1h = 100, 90

	frame.sfont = "SF" .. math.Clamp(GetConVar("shopscreen_fond1"):GetInt(), 2, 6) .. "S3"
	frame.f2w, frame.f2h =  100, 30

	frame.Paint = function(self, w, h)
		self.text = TextBox:GetValue()
		self.stext = TextBox2:GetValue()
		self.style = GetConVar("shopscreen_style"):GetInt()
		self.f2w = w - 20
		local f1out = GetConVar("shopscreen_out1"):GetInt()
		local f2out = GetConVar("shopscreen_out2"):GetInt()
		local f1sd = GetConVar("shopscreen_sdw1"):GetInt()
		local f2sd = GetConVar("shopscreen_sdw2"):GetInt()

		self.f1out = f1out and f1out > 0 and math.Clamp(f1out, 0, 8)
		self.f2out = f2out and f2out > 0 and math.Clamp(f2out, 0, 8)
		self.f1sd = f1sd and f1sd > 0 and math.Clamp(f1sd, 0, 8)
		self.f2sd = f2sd and f2sd > 0 and math.Clamp(f2sd, 0, 8)

		if ShopFront.Paint[self.style] then
			ShopFront.Paint[self.style](self, w, h, prsts[self.cl1] or prsts[1], prsts[self.cl2] or prsts[2])
		else
			ShopFront.Paint[1](self, w, h, prsts[self.cl1] or prsts[1], prsts[self.cl2] or prsts[2])
		end

		MSD.DrawTexturedRect(0, 0, w, h, self.dirt or dirt[1], color_white)
		MSD.DrawTexturedRect(0, 0, w, h, mats[2], color_white)
		MSD.DrawTexturedRect(0, 0, w, h, mats[1], color_white)

		if h < 10 then
			self:SetSize(CPanel:GetWide(), CPanel:GetWide() / 2.0971)
		end
	end

	CPanel:AddItem(frame)

	slider[5] = vgui.Create("DNumSlider")
	slider[5]:SetText("Стиль")
	slider[5]:SetMinMax(1, 5)
	slider[5]:SetDecimals(0)
	slider[5]:SetValue(1)
	slider[5]:SetConVar("shopscreen_style")
	CPanel:AddItem(slider[5])

	CPanel:AddControl( "Label", { Text = "Верхний текст", Description = "" } )

	TextBox = vgui.Create("DTextEntry")
	TextBox:SetUpdateOnType(true)
	TextBox:SetEnterAllowed(true)
	TextBox:SetConVar("shopscreen_text")
	TextBox:SetValue(GetConVar("shopscreen_text"):GetString())
	CPanel:AddItem(TextBox)

	local cl1 = vgui.Create("MSDPanelList")
	cl1:SetSize(CPanel:GetWide(), 50)
	cl1:EnableVerticalScrollbar()
	cl1:EnableHorizontal(true)

	for id, cl in pairs(prsts) do
		MSD.ColorSelectBut(cl1, "static", nil, 5, 25, cl, function()
			RunConsoleCommand("shopscreen_cl2", id)
			frame.cl2 = id
		end)
	end
	CPanel:AddItem(cl1)

	local fnd1 = vgui.Create("MSDPanelList")
	fnd1:SetSize(CPanel:GetWide(), 70)
	fnd1:EnableVerticalScrollbar()
	fnd1:EnableHorizontal(true)
	CPanel:AddItem(fnd1)

	for i = 1,6 do
		local button = vgui.Create("DButton")
		button:SetSize(80, 20)
		button:SetText("")
		button.Paint = function(self, w, h)
			draw.SimpleText("Шрифт " .. i, "SF" .. math.Clamp(i, 1, 6) .. "S2", 2, h / 2, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		fnd1:AddItem(button)
		button.DoClick = function(self)
			frame.font = "SF" .. math.Clamp(i, 1, 6) .. "S6"
			RunConsoleCommand("shopscreen_fond1", i)
		end
	end

	slider[1] = vgui.Create("DNumSlider")
	slider[1]:SetText("Обводка")
	slider[1]:SetMinMax(0, 8)
	slider[1]:SetDecimals(0)
	slider[1]:SetValue(1)
	slider[1]:SetConVar("shopscreen_out1")
	CPanel:AddItem(slider[1])

	slider[2] = vgui.Create("DNumSlider")
	slider[2]:SetText("Тень")
	slider[2]:SetMinMax(0, 8)
	slider[2]:SetDecimals(0)
	slider[2]:SetValue(1)
	slider[2]:SetConVar("shopscreen_sdw1")
	CPanel:AddItem(slider[2])

	CPanel:AddControl( "Label", { Text = "Нижний текст", Description = "" 	} )

	TextBox2 = vgui.Create("DTextEntry")
	TextBox2:SetUpdateOnType(true)
	TextBox2:SetEnterAllowed(true)
	TextBox2:SetConVar("shopscreen_subtext")
	TextBox2:SetValue(GetConVar("shopscreen_subtext"):GetString())
	CPanel:AddItem(TextBox2)

	local cl2 = vgui.Create("MSDPanelList")
	cl2:SetSize(CPanel:GetWide(), 50)
	cl2:EnableVerticalScrollbar()
	cl2:EnableHorizontal(true)

	for id, cl in pairs(prsts) do
		MSD.ColorSelectBut(cl2, "static", nil, 5, 25, cl, function()
			RunConsoleCommand("shopscreen_cl1", id)
			frame.cl1 = id
		end)
	end
	CPanel:AddItem(cl2)

	local fnd2 = vgui.Create("MSDPanelList")
	fnd2:SetSize(CPanel:GetWide(), 70)
	fnd2:EnableVerticalScrollbar()
	fnd2:EnableHorizontal(true)
	CPanel:AddItem(fnd2)

	for i = 1,6 do
		local button = vgui.Create("DButton")
		button:SetSize(80, 20)
		button:SetText("")
		button.Paint = function(self, w, h)
			draw.SimpleText("Шрифт " .. i, "SF" .. math.Clamp(i, 1, 6) .. "S2", 2, h / 2, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		fnd2:AddItem(button)
		button.DoClick = function(self)
			frame.sfont = "SF" .. math.Clamp(i, 1, 6) .. "S3"
			RunConsoleCommand("shopscreen_fond2", i)
		end
	end

	slider[3] = vgui.Create("DNumSlider")
	slider[3]:SetText("Обводка")
	slider[3]:SetMinMax(0, 8)
	slider[3]:SetDecimals(0)
	slider[3]:SetValue(1)
	slider[3]:SetConVar("shopscreen_out2")
	CPanel:AddItem(slider[3])

	slider[4] = vgui.Create("DNumSlider")
	slider[4]:SetText("Тень")
	slider[4]:SetMinMax(0, 8)
	slider[4]:SetDecimals(0)
	slider[4]:SetValue(1)
	slider[4]:SetConVar("shopscreen_sdw2")
	CPanel:AddItem(slider[4])

end