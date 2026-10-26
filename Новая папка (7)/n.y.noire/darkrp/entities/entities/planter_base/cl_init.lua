--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/planter_base/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local weed_states = {
	[1] = nil,
	[2] = function(mdl) mdl:SetMaterial("models/weed/prop_cannabis_leaf_dryprop_cannabis_leaf_a") end,
	[3] = function(mdl) mdl:SetMaterial("models/weed/prop_cannabis_leaf_dryprop_cannabis_leaf_b") end,
}

local coca_states = {
	[1] = function(mdl) mdl:SetColor(Color(255,221,176)) end,
	[2] = function(mdl) mdl:SetColor(Color(228,154,58)) end,
	[3] = function(mdl) mdl:SetColor(Color(194,98,35)) end,
}

local opium_states = {
	[1] = function(mdl) mdl:SetColor(Color(199,176,144)) end,
	[2] = function(mdl) mdl:SetColor(Color(172,131,73)) end,
	[3] = function(mdl) mdl:SetColor(Color(168,82,42)) end,
}

local seeds = {
	["seed_weed"] = {
		[1] = function(self)
			self.curmodel = "models/winningrook/weed/weed_plant_small.mdl"
			self.zoffset = 2
			self.startsize = 0.1
			self.sizedezire = 1
			self.bad_stage = weed_states
		end,
		[2] = function(self)
			self.curmodel = "models/winningrook/weed/weed_plant_medium.mdl"
			self.zoffset = 2
			self.startsize = 0.62
			self.sizedezire = 1
			self.bad_stage = weed_states
		end,
		[3] = function(self)
			self.curmodel = "models/winningrook/weed/weed_plant_large.mdl"
			self.zoffset = 2
			self.startsize = 0.7
			self.sizedezire = 1
			self.bad_stage = weed_states
		end
	},
	["seed_coca"] = {
		[1] = function(self)
			self.curmodel = "models/props/de_inferno/bushgreensmall.mdl"
			self.zoffset = 12
			self.startsize = 0.01
			self.sizedezire = 0.3
			self.bad_stage = coca_states
		end,
		[2] = function(self)
			self.curmodel = "models/props/de_inferno/bushgreensmall.mdl"
			self.zoffset = 12
			self.startsize = 0.3
			self.sizedezire = 0.8
			self.bad_stage = coca_states
		end,
		[3] = function(self)
			self.curmodel = "models/props/de_inferno/bushgreensmall.mdl"
			self.zoffset = 16
			self.startsize = 0.8
			self.sizedezire = 1.1
			self.bad_stage = coca_states
		end
	},
	["seed_opium"] = {
		[1] = function(self)
			self.curmodel = "models/props/de_inferno/fountain_bowl_p10.mdl"
			self.zoffset = 15
			self.startsize = 0.1
			self.sizedezire = 0.5
			self.bad_stage = opium_states
		end,
		[2] = function(self)
			self.curmodel = "models/props/de_inferno/fountain_bowl_p10.mdl"
			self.zoffset = 22
			self.startsize = 0.5
			self.sizedezire = 0.8
			self.bad_stage = opium_states
		end,
		[3] = function(self)
			self.curmodel = "models/props/de_inferno/potted_plant2_p1.mdl"
			self.zoffset = 3
			self.startsize = 0.6
			self.sizedezire = 1
			self.bad_stage = {
				[1] = function(mdl) mdl:SetColor(Color(199,176,144)) mdl:SetSubMaterial(1, "null") end,
				[2] = function(mdl) mdl:SetColor(Color(172,131,73)) mdl:SetSubMaterial(1, "null") end,
				[3] = function(mdl) mdl:SetColor(Color(168,82,42)) mdl:SetSubMaterial(1, "null") end,
			}
		end
	},
}

ENT.SeedPos = {
	[1] = Vector(-40, 17, 12),
	[2] = Vector(-20, -12, 12),
	[3] = Vector(20, 17, 12),
	[4] = Vector(44, -12, 12),
	[5] = Vector(44, 17, 12),
	[6] = Vector(-20, 17, 12),
	[7] = Vector(-40, -12, 12),
	[8] = Vector(0, 17, 12),
	[9] = Vector(20, -12, 12),
	[10] = Vector(0, -12, 12)
}

function ENT:Initialize()
	self.models = {}
	self.curseeds = ""

	self.startsize = 0
	self.sizedezire = 1
	self.olstate = -1
	self.curdying = 0
	self.time = 0
end

function ENT:ClearModels()
	for k, v in pairs(self.models) do
		if not IsValid(v) then continue end
		v:Remove()
	end

	self.mdlupd = nil
end

function ENT:GetMainStage()
	if self:GetStage() > 70 then
		return 3
	end
	if self:GetStage() > 35 then
		return 2
	end
	return 1
end

function ENT:GetCurStage()
	if self:GetStage() > 70 then
		return (self:GetStage() - 70) / 30
	end
	if self:GetStage() > 35 then
		return (self:GetStage() - 35) / 35
	end
	return self:GetStage() / 35
end

-- Applies the bad_stage cosmetic for the current dying stage to every
-- visual sub-prop. bad_stage entries may be nil (e.g. weed stage 1 is a no-op).
function ENT:ApplyDyingCosmetics()
	if not self.bad_stage then return end
	local dying = self:GetDyingStage()
	if dying <= 0 then return end

	local fn = self.bad_stage[dying]
	if not isfunction(fn) then return end

	for _, mdl in pairs(self.models) do
		if IsValid(mdl) then fn(mdl) end
	end
end

function ENT:CreateModels()
	if self.mdlupd then return end
	self.mdlupd = true

	seeds[self:GetSeeds()][self:GetMainStage()](self)
	local seed_pos = table.Copy(self.SeedPos)

	for k, v in pairs(seed_pos) do
		if self.zoffset then
			v.z = self.zoffset
			v.x = v.x + math.random(-1, 1)
			v.y = v.y + math.random(-1, 1)
		end

		if IsValid(self.models[k]) then self.models[k]:Remove() end

		self.models[k] = ents.CreateClientProp()
		self.models[k]:SetModel(self.curmodel)
		self.models[k]:InvalidateBoneCache()
		self.models[k]:SetMoveType(MOVETYPE_NONE)
		self.models[k]:SetParent(self)
		local ang = self:GetAngles()
		ang:RotateAroundAxis(ang:Up(), math.random(27) * 10)
		self.models[k].pos = v
		self.models[k]:SetPos(self:LocalToWorld(v))
		self.models[k]:SetAngles(ang)
		local mat = Matrix()
		mat:Scale(Vector(self.startsize, self.startsize, self.startsize))
		self.models[k]:EnableMatrix("RenderMultiply", mat)
		self.models[k]:Spawn()
	end

	-- Apply current dying cosmetic (if any) to the freshly spawned models.
	self:ApplyDyingCosmetics()
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:Think()
	if not DarkRP.InRange(self, LocalPlayer(), 1500) then
		self:ClearModels()
		return
	end

	if self:GetSeeds() ~= self.curseeds then
		self:ClearModels()
		self.curseeds = self:GetSeeds()
		self.curdying = 0
	end

	if not self.curstage or self.curstage ~= self:GetMainStage() then
		self.curstage = self:GetMainStage()
		self:ClearModels()
		self.curdying = 0
	end

	if self:GetSeeds() ~= "" then
		self:CreateModels()
	end

	if self:GetSeeds() == "" and self:GetWaterLevel() <= 0 then return end

	-- Re-apply dying cosmetics whenever the networked stage advances.
	if self:GetDyingStage() ~= self.curdying then
		self.curdying = self:GetDyingStage()
		self:ApplyDyingCosmetics()
	end

	self.size = Lerp(self:GetCurStage(), self.startsize, self.sizedezire)

	for k, v in pairs(self.models) do
		if not IsValid(v) then continue end

		if not IsValid(v:GetParent()) then
			self:ClearModels()
			return
		end

		local mat = Matrix()
		mat:Scale(Vector(self.size + k * 0.02, self.size + k * 0.02, self.size + k * 0.02))
		v:EnableMatrix("RenderMultiply", mat)
	end

	if self:GetStage() ~= self.olstate and self:GetSeeds() ~= "" then
		self.olstate = self:GetStage()
		self.time = CurTime()

		if self.osize then
			self.startsize = self.osize
			self.osize = nil
		end
	end

	self:NextThink(CurTime() + 1)

	return true
end

local seedNames = {
	["seed_weed"] = "Марихуана",
	["seed_coca"] = "Кока",
	["seed_opium"] = "Опиум",
}

local clrs = {
	green = Color(50, 200, 80),
	blue = Color(60, 160, 255),
	orange = Color(255, 150, 0),
	red = Color(255, 60, 60),
	dark_green = Color(30, 140, 50),
	dark_blue = Color(30, 100, 200),
}

function ENT:OpenMenu()
	if IsValid(self.planterMenu) then self.planterMenu:Close() return end

	local ent = self
	local menuW, menuH = 340, 430

	local menu = vgui.Create("MSDSimpleFrame")
	menu:SetSize(menuW, menuH)
	menu:Center()
	menu:MakePopup()
	menu:SetDraggable(true)
	menu:SetAlpha(0)
	menu:AlphaTo(255, 0.3)
	self.planterMenu = menu

	menu.Paint = function(s, w, h)
		MSD.Blur(s, 2, 2, 255, 50, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["d"])
		local sp = draw.SimpleText("Грядка", "MSDFont.25", 15, 12, color_white, TEXT_ALIGN_LEFT)
		draw.DrawText(" | Очки опыта: " .. LocalPlayer():JobXP("planter"), "MSDFont.21", 15 + sp, 17, color_white, TEXT_ALIGN_LEFT)
	end

	menu.OnClose = function()
		ent.planterMenu = nil
	end

	MSD.IconButton(menu, MSD.Icons48.cross, menuW - 38, 12, 25, nil, MSD.Config.MainColor["r"], function()
		menu:Close()
	end)

	local plist = vgui.Create("MSDPanelList", menu)
	plist:SetPos(0, 52)
	plist:SetSize(menuW, menuH - 52)
	plist:SetSpacing(8)
	plist:SetPadding(10)

	-- Seed type info
	local seedInfo = vgui.Create("DPanel")
	seedInfo:SetTall(30)
	seedInfo.Paint = function(s, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
		local seedType = ent:GetSeeds()
		local name = seedNames[seedType] or "Нет семян"
		MSD.DrawTexturedRect(8, h / 2 - 10, 20, 20, MSD.Icons48.sprout, clrs.green)
		draw.DrawText("Растение: " .. name, "MSDFont.20", 34, h / 2 - 10, color_white, TEXT_ALIGN_LEFT)
	end
	plist:AddItem(seedInfo)

	-- Growth progress bar
	local growthBar = vgui.Create("DPanel")
	growthBar:SetTall(50)
	growthBar.Paint = function(s, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
		MSD.DrawTexturedRect(8, 6, 20, 20, MSD.Icons48.arrow_up, clrs.green)
		draw.DrawText("Рост", "MSDFont.20", 34, 5, color_white, TEXT_ALIGN_LEFT)

		local stage = ent:GetStage()
		local pct = math.Clamp(stage / ent.GrowStageMax, 0, 1)
		local barX, barY, barW, barH = 10, 30, w - 20, 12

		MSDX.Draw(4, barX, barY, barW, barH, Color(30, 30, 30, 200))

		if pct > 0 then
			local barColor = stage >= ent.GrowStageMax and clrs.green or clrs.orange
			MSDX.Draw(4, barX, barY, barW * pct, barH, barColor)
		end

		draw.DrawText(math.floor(stage) .. "%", "MSDFont.16", barX + barW - 2, barY - 1, MSD.Text["d"], TEXT_ALIGN_RIGHT)
	end
	plist:AddItem(growthBar)

	-- Water level bar with a single recommended figure for the current seed.
	local waterBar = vgui.Create("DPanel")
	waterBar:SetTall(50)
	waterBar.Paint = function(s, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
		MSD.DrawTexturedRect(8, 6, 20, 20, MSD.Icons48.cup, clrs.blue)

		local recommended = ent:GetRecommendedHydration()
		local header = "Вода"
		if recommended then
			header = header .. "  (Реком: ~" .. recommended .. ")"
		end
		draw.DrawText(header, "MSDFont.20", 34, 5, color_white, TEXT_ALIGN_LEFT)

		local water = ent:GetWaterLevel()
		local pct = math.Clamp(water / 100, 0, 1)
		local barX, barY, barW, barH = 10, 30, w - 20, 12

		MSDX.Draw(4, barX, barY, barW, barH, Color(30, 30, 30, 200))

		if pct > 0 then
			local inRange = ent:IsHydrationOptimal()
			local barColor = inRange and clrs.blue or clrs.red
			MSDX.Draw(4, barX, barY, barW * pct, barH, barColor)
		end

		draw.DrawText(math.floor(water) .. " / 100", "MSDFont.16", barX + barW - 2, barY - 1, MSD.Text["d"], TEXT_ALIGN_RIGHT)
	end
	plist:AddItem(waterBar)

	-- Status info
	local statusPanel = vgui.Create("DPanel")
	statusPanel:SetTall(30)
	statusPanel.Paint = function(s, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])

		local stage = ent:GetStage()
		local water = ent:GetWaterLevel()
		local seedType = ent:GetSeeds()

		local status, statusColor
		if ent:IsDying() then
			status = ent:GetDyingStage() >= ent.MaxDyingStage and "Мёртво" or "Гибнет"
			statusColor = clrs.red
		elseif seedType == "" then
			status = "Нужны семена"
			statusColor = MSD.Text["n"]
		elseif stage >= ent.GrowStageMax then
			status = "Готово к сбору"
			statusColor = clrs.green
		elseif water <= 0 then
			status = "Нужна вода"
			statusColor = clrs.red
		elseif not ent:IsHydrationOptimal() then
			status = "Плохая гидратация"
			statusColor = clrs.orange
		else
			status = "Растёт..."
			statusColor = clrs.orange
		end

		MSD.DrawTexturedRect(8, h / 2 - 10, 20, 20, MSD.Icons48.alert, statusColor)
		draw.DrawText("Статус: " .. status, "MSDFont.20", 34, h / 2 - 10, statusColor, TEXT_ALIGN_LEFT)
	end
	plist:AddItem(statusPanel)

	-- Harvest button. Enabled only when the plant can actually be harvested
	-- (fully grown, has seeds, and is not dying).
	local harvestBtn = MSD.ButtonIcon(plist, "static", nil, 1, 45, "Собрать урожай", MSD.Icons48.carrot, function(s)
		if not ent:CanHarvest() then return end

		net.Start("PlanterAction")
			net.WriteEntity(ent)
			net.WriteUInt(0, 2)
		net.SendToServer()

		menu:Close()
	end)
	harvestBtn:SetTall(50)
	harvestBtn.Think = function(s)
		s.disabled = not ent:CanHarvest()
	end

	-- Remove button: always available, resets the planter for a new seed.
	local remBut = MSD.ButtonIcon(plist, "static", nil, 1, 45, "Выкопать растение", MSD.Icons48.hand_extended, function(s)
		net.Start("PlanterAction")
			net.WriteEntity(ent)
			net.WriteUInt(1, 2)
		net.SendToServer()

		menu:Close()
	end)
	remBut:SetTall(50)

	menu.Think = function(s)
		if not IsValid(ent) or not DarkRP.InRange(ent, LocalPlayer(), 200) then
			s:Close()
		end
	end
end

function ENT:OnRemove()
	if IsValid(self.planterMenu) then self.planterMenu:Close() end
	self:ClearModels()
end
