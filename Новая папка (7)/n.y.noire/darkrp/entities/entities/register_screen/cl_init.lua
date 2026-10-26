--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/register_screen/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

function ENT:Draw()
	self:DrawModel()
end

function ENT:ClearModel()
	if IsValid(self.model) then self.model:Remove() end
end

function ENT:OnRemove()
	self:ClearModel()
end

local r_menu

local function CreateManagMenu(ent, base)
	if not LocalPlayer():IsFreeman() then return end

	if IsValid(r_menu) then return end

	local SW, SH = ScrW(), 210
	SW = SW / 3

	r_menu = vgui.Create("MSDSimpleFrame")
	r_menu:SetSize(SW, SH)
	r_menu:SetDraggable(false)
	r_menu:Center()
	r_menu:MakePopup()
	r_menu:SetAlpha(1)
	r_menu:AlphaTo(255, 0.3)
	r_menu.Think = function(self)
		if not IsValid(ent) or not IsValid(base) or not LocalPlayer():IsFreeman() or LocalPlayer():GetPos():DistToSqr(base:GetPos()) > 90000 then
			self:Close()
		end
	end
	r_menu.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)

		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Управление " .. ent:GetStorageName(), "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	MSD.CloseButtonIcon(r_menu, SW - 160, 5, 150, 40, "Закрыть", function()
		r_menu:Close()
	end)

	r_menu.list = vgui.Create("MSDPanelList", r_menu)
	r_menu.list:SetSize(SW - 10, SH - 55)
	r_menu.list:SetPos(5, 55)
	r_menu.list:EnableVerticalScrollbar()
	r_menu.list:EnableHorizontal(true)
	r_menu.list:SetSpacing(2)
	r_menu.list.IgnoreVbar = true

	local name = ent:GetStorageName()

	MSD.TextEntry(r_menu.list, "static", nil, 1, 50, "", "Название магазина:", name, function(self, value)
		name = utf8.sub(value,0,20)
	end, true)

	local price = math.Round(ent:GetCustomPrice() * 100)

	MSD.TextEntry(r_menu.list, "static", nil, 1, 50, "", "Наценка на товар в процентах: (макс. 200%)", price, function(self, value)
		price = tonumber(value) or 0
	end, true, nil, nil, true)

	MSD.Button(r_menu.list, "static", nil, 1, 50, "Сохранить", function()
		net.Start("McINV.RegisterNer")
			net.WriteUInt(1, 2)
			net.WriteEntity(ent)
			net.WriteString(name)
			net.WriteFloat(math.Round(price / 100, 2) )
		net.SendToServer()
		r_menu:Close()
	end)
end

local function createList(parent, x, y, w, h)
	local plist = vgui.Create("MSDPanelList", parent)
	plist:SetSize(w, h)
	plist:SetPos(x, y)
	plist:EnableVerticalScrollbar()
	plist:EnableHorizontal(true)
	plist:SetSpacing(2)
	plist.sliderColor = Color(252, 81, 1, 70)
	plist.IgnoreVbar = true

	return plist
end

local function CreateRegisterMenu(base, ent)
	if not LocalPlayer():IsFreeman() then return end

	if IsValid(r_menu) then return end

	local SW, SH = ScrW() * 0.6, ScrH() * 0.8

	DarkRP.ViewFocus = {
		ent = ent,
		ang = 180,
		point = Vector(4.47,0.14,3),
		drawp = true,
		fade = false
	}

	r_menu = vgui.Create("MSDSimpleFrame")
	r_menu:SetSize(SW, SH)
	r_menu:SetDraggable(false)
	r_menu:Center()
	r_menu:MakePopup()
	r_menu:SetAlpha(1)
	r_menu:AlphaTo(255, 0.3)
	r_menu.Think = function(self)
		if not IsValid(ent) or not IsValid(base) or not LocalPlayer():IsFreeman() or LocalPlayer():GetPos():DistToSqr(base:GetPos()) > 90000 then
			self:Close()
		end
	end
	r_menu.Paint = function(self, w, h)
		MSD.Blur(self, 5, 5, 255, 20, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)

		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Регистрация оружия ", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	r_menu.OnClose = function(self, w, h)
		if DarkRP.ViewFocus then
			DarkRP.ViewFocus.fade = true
		end
	end

	MSD.CloseButtonIcon(r_menu, SW - 160, 5, 150, 40, "Закрыть", function()
		r_menu:Close()
	end)

	r_menu.list = createList(r_menu, SW / 2, 70, SW / 2 - 10, SH - 70)
	local dlist = createList(r_menu, 5, 70, SW / 2 - 10, SH - 70)

	r_menu.LoadData = function(id, item)
		dlist:Clear()
		MSD.Header(dlist, item.name or "Оружие")

		if item.register and item.register.id then
			MSD.InfoHeader(dlist, "Серийный номер: " .. item.register.id)
		else
			MSD.InfoHeader(dlist, "Оружия нет в базе данных US N.L.R.")
		end

		if item.register and item.register.passid ~= DarkRP.CharacterID(LocalPlayer()) then
			MSD.InfoHeader(dlist, "Оружие успешно зарегистрировано в базе данных US N.L.R.")
			return
		end

		passes = {}

		for k,v in ipairs(player.GetAll()) do
			passes[DarkRP.PassId(v)] = true
		end

		if not item.register or item.register.passid == DarkRP.CharacterID(LocalPlayer()) then
			MSD.InfoHeader(dlist, "Введите номер паспорта на который хотите зарегистрировать оружие")

			local name = ""
			MSD.TextEntry(dlist, "static", nil, 1, 50, "", "Номер паспорта:", "", function(self, value)
				value = tonumber(value)
				if not value then
					name = ""
					self.error = "Номер не верный"
					return
				end
				name = string.sub(value,0,12)
				self.error = nil

				if not passes[name] then
					self.error = "Номер не найден"
				end

			end, true, nil, nil, true)

			MSD.Button(dlist, "static", nil, 1, 50, "Подать заявление $" .. McINV.WeaponTax(item), function()
				if name == "" then return end
				net.Start("McINV.RegisterNer")
					net.WriteUInt(2, 2)
					net.WriteEntity(base)
					net.WriteUInt(id, 10)
					net.WriteString(name)
				net.SendToServer()
				r_menu:Close()
			end)
		end
	end

	McINV.StorageUI = r_menu
	local type = INV_WEAPON
	r_menu.Update = function(inv)
		r_menu.list:Clear()

		for id, item in pairs(inv[type]) do
			if not DarkRP.SingleWep.FireArms[item.class] then continue end
			local entt = McINV.GetItem(type, item.class)

			local btn = McINV.InventoryItem(r_menu.list, entt, type, item, function(self)
				r_menu.LoadData(id, item)
			end, nil, McINV.Tax(entt.price or 0, type, item))
			btn.main.mat = MSD:Icon("file_document")

			hook.Call("InventoryStorageUI", nil, ent, type, item, id, btn, r_menu.list)
		end

	end

	r_menu.Update(base.inv)
end

local CarPartList = {
	{class = "parts_hull",    name = "Кузов / шасси"},
	{class = "parts_engine",  name = "Двигатель"},
	{class = "parts_glass",   name = "Стёкла"},
	{class = "parts_battery", name = "Аккумулятор", fixed = true},
}

local function CreateCarRegisterMenu(base, ent)
	if not LocalPlayer():IsFreeman() then return end
	if LocalPlayer():Team() ~= TEAM_CAR then return end

	if IsValid(r_menu) then return end

	local SW, SH = ScrW() * 0.6, ScrH() * 0.8

	DarkRP.ViewFocus = {
		ent = ent,
		ang = 180,
		point = Vector(4.47,0.14,3),
		drawp = true,
		fade = false
	}

	r_menu = vgui.Create("MSDSimpleFrame")
	r_menu:SetSize(SW, SH)
	r_menu:SetDraggable(false)
	r_menu:Center()
	r_menu:MakePopup()
	r_menu:SetAlpha(1)
	r_menu:AlphaTo(255, 0.3)
	r_menu.Think = function(self)
		if not IsValid(ent) or not IsValid(base) or not LocalPlayer():IsFreeman() or LocalPlayer():GetPos():DistToSqr(base:GetPos()) > 90000 then
			self:Close()
		end
	end
	r_menu.Paint = function(self, w, h)
		MSD.Blur(self, 5, 5, 255, 20, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)

		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Заказ автозапчастей | Очки опыта: " .. LocalPlayer():JobXP("car"), "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	r_menu.OnClose = function(self, w, h)
		if DarkRP.ViewFocus then
			DarkRP.ViewFocus.fade = true
		end
	end

	MSD.CloseButtonIcon(r_menu, SW - 160, 5, 150, 40, "Закрыть", function()
		r_menu:Close()
	end)

	local dlist = createList(r_menu, 5, 70, SW / 2 - 10, SH - 70)
	r_menu.list = createList(r_menu, SW / 2, 70, SW / 2 - 10, SH - 70)

	local function FindCars()
		local cars = {}
		for _, v in ipairs(ents.FindInSphere(base:GetPos(), base.CarPartScanRange or 1500)) do
			if v:GetClass() ~= "gmod_sent_vehicle_fphysics_base" then continue end
			table.insert(cars, v)
		end
		table.sort(cars, function(a, b)
			return a:GetPos():DistToSqr(base:GetPos()) < b:GetPos():DistToSqr(base:GetPos())
		end)
		return cars
	end

	r_menu.LoadParts = function(car)
		r_menu.list:Clear()
		MSD.Header(r_menu.list, "Запчасти")

		local cd
		if IsValid(car) and McCD and McCD.Cars then
			cd = McCD.Cars[car:GetSpawn_List()]
		end

		local carprice
		if cd and cd.price then
			carprice = cd.donate and cd.price * 150 or cd.price
		end

		if IsValid(car) then
			MSD.InfoHeader(r_menu.list, "Модель: " .. (cd and cd.name or car:GetSpawn_List() or "неизвестна"))
		else
			MSD.InfoHeader(r_menu.list, "Выберите авто для заказа запчастей")
		end

		local mults = base.CarPartMult or {}

		for _, part in ipairs(CarPartList) do
			local data = DarkRP.Junk[part.class]
			if not data then continue end

			local raw
			if part.fixed then
				raw = data.price
			else
				if not IsValid(car) then continue end
				local mult = mults[part.class]
				if not mult then continue end
				if carprice then
					raw = math.Round(carprice * mult)
				else
					raw = data.price
				end
			end

			local price = McINV.Tax(raw)

			MSD.Button(r_menu.list, "static", nil, 1, 50, part.name .. " — $" .. price, function()
				if not part.fixed and not IsValid(car) then return end

				net.Start("CarParts.Order")
					net.WriteEntity(base)
					net.WriteString(part.class)
					net.WriteEntity(part.fixed and NULL or car)
				net.SendToServer()
				r_menu:Close()
			end)
		end
	end

	r_menu.Update = function()
		dlist:Clear()
		MSD.Header(dlist, "Автотранспорт в радиусе")

		local cars = FindCars()

		if #cars == 0 then
			MSD.InfoHeader(dlist, "Рядом нет автотранспорта.")
		end

		for _, car in ipairs(cars) do
			local cd = McCD and McCD.Cars and McCD.Cars[car:GetSpawn_List()]
			local label = (cd and cd.name or car:GetSpawn_List() or "Авто")

			if not cd then continue end

			MSD.Button(dlist, "static", nil, 1, 50, label, function()
				r_menu.LoadParts(car)
			end)
		end

		MSD.Button(dlist, "static", nil, 1, 50, "Обновить список", function()
			r_menu.Update()
		end)

		r_menu.LoadParts(nil)
	end

	r_menu.Update()
end

net.Receive("McINV.RegisterNer", function()
	local base = net.ReadEntity()
	local ent = net.ReadEntity()
	local gunedit = net.ReadUInt(2)

	if gunedit == 2 then
		CreateCarRegisterMenu(base, ent)
		return
	end

	if gunedit == 1 then
		local bytes_number = net.ReadInt(32)
		local compressed_data = net.ReadData(bytes_number)
		local data = DarkRP.TableDecompress(compressed_data)
		base.inv = data

		CreateRegisterMenu(base, ent)
		return
	end

	CreateManagMenu(base, ent)
end)