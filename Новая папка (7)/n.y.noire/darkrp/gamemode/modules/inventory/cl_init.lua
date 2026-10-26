--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/inventory/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

McINV.inv = McINV.inv or {}
McINV.bank = McINV.bank or {}
McINV.Icons = {}
local star = Material("gmodla/star2.png", "smooth")
local glass = Material("gmodla/glass.png", "smooth")
local normal = Material("mqs/icons/box_open.png", "smooth")
local donate = Material("mqs/icons/box_open_star.png", "smooth")

for k, v in pairs(file.Find("materials/gmodla/inv/*", "GAME")) do
	local exp = string.Explode(".", v)
	McINV.Icons[exp[1]] = Material("materials/gmodla/inv/" .. v, "smooth")
end

local sklad_ds = [[Для доставки доступны предметы, оформленные в логистике недавно - не находящиеся на длительном хранении.]]

net.Receive("McINV.Set", function()
	local bytes_number = net.ReadUInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local st = net.ReadBool()
	local data = DarkRP.TableDecompress(compressed_data)
	McINV.inv = data

	if st then
		bytes_number = net.ReadUInt(32)
		compressed_data = net.ReadData(bytes_number)
		data = DarkRP.TableDecompress(compressed_data)

		McINV.bank = data

		if IsValid(McINV.BankUI) then
			McINV.BankUI.Update()
		end
	end

	if IsValid(McINV.InventoryUI) then
		McINV.InventoryUI.Update()
	end

	if IsValid(McINV.StorageUIPly) then
		McINV.StorageUIPly.Update()
	end

	hook.Call("UpdateInventory", nil, LocalPlayer(), st)
end)

net.Receive("McINV.StorageLookup", function()
	if IsValid(McINV.InventoryUI) then return end
	local ent = net.ReadEntity()
	if not IsValid(ent) then return end
	local bytes_number = net.ReadInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local bool = net.ReadBool()
	local inv = DarkRP.TableDecompress(compressed_data)

	if IsValid(McINV.StorageUI) and McINV.StorageUI.Ent == ent then
		McINV.StorageUI.Update(inv)

		return
	end

	ent.inv = inv

	if bool then
		McINV.CreateCraftingStorageUI(ent, inv)
	else
		local msg = net.ReadString() or ""
		McINV.CreateStorageUI(ent, inv, msg)
	end
end)

net.Receive("McINV.UpdateStorage", function()
	local ent = net.ReadEntity()
	local type = net.ReadString()

	if type == "remove" then
		if IsValid(McINV.StorageUI) and McINV.StorageUI.Ent == ent then
			McINV.StorageUI:Remove()
		end
		return
	end

	if type == "craft" then
		if IsValid(McINV.StorageUI) and McINV.StorageUI.Ent == ent then
			McINV.StorageUI.Update(ent.inv, true)
		end
		return
	end

	local bytes_number = net.ReadUInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local inv = DarkRP.TableDecompress(compressed_data)

	ent.inv = ent.inv or {}

	if type == "none" then
		ent.inv = inv
	else
		if not ent.inv or not ent.inv[type] then return end
		ent.inv[type] = inv
	end

	if IsValid(McINV.StorageUI) and McINV.StorageUI.Ent == ent then
		McINV.StorageUI.Update(ent.inv)
	end
end)

net.Receive("McINV.BuyFromEnt", function()
	local ent = net.ReadEntity()

	local bytes_number = net.ReadInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local data = DarkRP.TableDecompress(compressed_data)
	ent.inv = data

	McINV.StoreUIEnt(ent)
end)

net.Receive("McINV.OpenBank", function()
	McINV.CreateBankUI(net.ReadBool())
end)

function McINV.PutInStorage(ent, type, id)
	net.Start("McINV.Store")
	net.WriteBool(false)
	net.WriteString(type)
	net.WriteUInt(id, 16)
	net.WriteEntity(ent)
	net.SendToServer()
end

function McINV.PutInBank(type, id)
	net.Start("McINV.Store")
	net.WriteBool(true)
	net.WriteString(type)
	net.WriteUInt(id, 16)
	net.SendToServer()
end

function McINV.TakeFromBank(type, id)
	net.Start("McINV.Take")
	net.WriteBool(true)
	net.WriteString(type)
	net.WriteUInt(id, 16)
	net.SendToServer()
end

function McINV.DropFromBank(type, id)
	net.Start("McINV.Drop")
	net.WriteBool(true)
	net.WriteString(type)
	net.WriteUInt(id, 16)
	net.SendToServer()
end

function McINV.TakeFromStorage(ent, type, id)
	net.Start("McINV.Take")
	net.WriteBool(false)
	net.WriteString(type)
	net.WriteUInt(id, 16)
	net.WriteEntity(ent)
	net.SendToServer()
end

function McINV.DropFromStorage(ent, type, id)
	net.Start("McINV.Drop")
	net.WriteBool(false)
	net.WriteString(type)
	net.WriteUInt(id, 16)
	net.WriteEntity(ent)
	net.SendToServer()
end

local bp_icon = Material("gmodla/bp_s.png", "smooth")
local color_dim = Color(145, 168, 204)
local color_dim2 = Color(145, 168, 204, 120)

function McINV.BluePrint(parent, item, ent, id)
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 128,
		minw = 250,
		minh = 128
	}
	panel.descr = ent.class

	local h = 128

	panel.Paint = function(self, w, hd)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, hd, MSD.Theme["l"])

		if item.unlock and item.unlock > sAdmin.mcTime(LocalPlayer()) then
			draw.DrawText(item.name, "MSDFont.26", h + 10, 0, color_dim, TEXT_ALIGN_LEFT)
			draw.DrawText("Будет доступно через: " .. sAdmin.formatTime(item.unlock - sAdmin.mcTime(LocalPlayer())), "MSDFont.22", h + 10, 28, color_dim, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(0, 0, h, h, bp_icon, color_dim2)
			MSD.DrawTexturedRect(h / 2 - 24, h / 2 - 24, 48, 48, MSD.Icons48.time, color_dim2)

			return
		end

		if item.pack and not MQS.GetSData(nil, item.pack) then
			local pack = Glac.Packs[item.pack]
			draw.DrawText(item.name, "MSDFont.26", h + 10, 0, color_dim, TEXT_ALIGN_LEFT)
			draw.DrawText("Требуется набор: " .. (pack and pack.Name or item.pack), "MSDFont.22", h + 10, 28, color_dim, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRect(0, 0, h, h, bp_icon, color_dim2)
			MSD.DrawTexturedRect(h / 2 - 24, h / 2 - 24, 48, 48, MSD.Icons48.lock, color_dim2)

			return
		end

		if item.xp and ent.XPTable and not LocalPlayer():JobXPOpen(ent.XPTable, id) then
			draw.DrawText(item.name, "MSDFont.26", h + 10, 0, color_dim, TEXT_ALIGN_LEFT)
			draw.DrawText("Требуется очков для открытия: " .. (tonumber(item.xp) and item.xp or item.time * 4), "MSDFont.22", h + 10, 28, color_dim, TEXT_ALIGN_LEFT)
			if item.requiredbp and ent.BluePrints[item.requiredbp] then
				draw.DrawText("Требуется изучить: " .. ent.BluePrints[item.requiredbp].name, "MSDFont.22", h + 10, 54, color_dim, TEXT_ALIGN_LEFT)
			end
			MSD.DrawTexturedRect(0, 0, h, h, bp_icon, color_dim2)
			--MSD.DrawTexturedRect(h / 2 - 24, h / 2 - 24, 48, 48, MSD.Icons48.lock, color_dim2)

			return
		end

		MSD.DrawTexturedRect(0, 0, h, hd, bp_icon, color_white)
		draw.DrawText(item.name, "MSDFont.26", h + 10, 0, color_white, TEXT_ALIGN_LEFT)
		local tp = 0

		if item.products and item.products[1] then
			local prod = table.Copy(item.products[1])
			local it = table.Copy(McINV.GetItem(prod.type, prod.class))
			if prod.extras then
				for k, v in pairs(prod.extras) do
					it[k] = v
				end
			end
			MSD.DrawTexturedRect(4, 4, 120, 120, McINV.Icons[prod.class] or MSD.IconRender.Get(it.model or "models/props_junk/CinderBlock01a.mdl", it.material, it.submat, item.color), MSD.ColorAlpha(color_white, self.cbtn and 255 - 255 * self.cbtn.alpha or 1) )
		end

		for i, cp in pairs(item.componets) do
			tp = 26 + (i - 1) * 25
			local cp_item = McINV.GetItem(cp.type, cp.class)

			draw.DrawText(cp.printName or (ent.SameClassesName and ent.SameClassesName[cp.class] or (cp_item and cp_item.name or "!" .. cp.class)), "MSDFont.22", h + 10, tp, MSD.Text.d, TEXT_ALIGN_LEFT)

			if cp.dont_use then
				local ic = ent:GetItemCount(cp.type, cp.class)
				local cl = ic >= cp.count and MSD.Patern.MainColor.p or MSD.Patern.MainColor["9"]
				MSD.DrawTexturedRect(w - 34, tp, 24, 24, ic >= cp.count and MSD.Icons48.submit or MSD.Icons48.cross, cl)
				MSDX.Draw(0, 138, tp + 23, w - 148, 2, MSD.ColorAlpha(cl, 100))
			else
				local ic = ent:GetItemCount(cp.type, cp.class, nil, not cp.ignuses, cp.consume, cp.check)

				if ent.SameClasses and ent.SameClasses[cp.class] then
					for enc, _ in pairs(ent.SameClasses[cp.class]) do
						ic = ic + ent:GetItemCount(cp.type, enc, nil, not cp.ignuses, cp.consume, cp.check)
					end
				end

				local pr = ic / cp.count
				draw.DrawText(ic .. "/" .. cp.count, "MSDFont.22", w - 10, tp, MSD.Config.MainColor["p"], TEXT_ALIGN_RIGHT)
				local wd = w - 148
				MSDX.Draw(0, 138, tp + 23, wd, 2, MSD.ColorAlpha(MSD.Patern.MainColor["9"], 100))
				MSDX.Draw(0, 138, tp + 23, math.min(wd, wd * pr), 2, MSD.Patern.MainColor.p)
			end
		end

		tp = tp + 25

		if item.price then
			local cl = LocalPlayer():canAfford(item.price) and MSD.Patern.MainColor.p or MSD.Patern.MainColor["9"]
			draw.DrawText("Затраты на производство", "MSDFont.22", h + 10, tp, color_white, TEXT_ALIGN_LEFT)
			draw.DrawText(math.Round(item.price) .. "$", "MSDFont.22", w - 10, tp, MSD.Config.MainColor["p"], TEXT_ALIGN_RIGHT)
			MSDX.Draw(0, 138, tp + 23, w - 148, 2, cl)
		end

		if item.mintemp and item.failtemp then
			local max = item.time
			local maxw = w - 148
			local difer = (item.failtemp - item.mintemp) * 2
			local step = difer
			draw.DrawText("Шкала охлаждения", "MSDFont.16", h + 10, hd - 20, MSD.Text.n, TEXT_ALIGN_LEFT)
			MSDX.Draw(0, 138, hd - 3, maxw, 2, MSD.ColorAlpha(MSD.Patern.MainColor["9"], 100))
			while step < max do
				local dif = (step / item.time) * maxw

				if dif + 10 > maxw then dif = dif - 5 end
				MSDX.Draw(0, 138 + dif - 5, hd - 3, 10, 2, MSD.Config.MainColor["p"])
				step = step + (difer > 60 and 60 or 30)
			end
		end
	end

	if (not item.unlock or item.unlock < sAdmin.mcTime(LocalPlayer())) and (not item.xp or not ent.XPTable or LocalPlayer():JobXPOpen(ent.XPTable, id)) and (not item.pack or MQS.GetSData(nil, item.pack)) then
		panel.cbtn = MSD.BigButtonClean(panel, 0, 0, 128, 128, "Начать", MSD.Icons48.cog, function()
			net.Start("McINV.StartCraft")
			net.WriteString(id)
			net.WriteEntity(ent)
			net.SendToServer()
		end, color_white, not item.products and color_dim)

		if #item.componets > 3 and (item.mintemp or item.failtemp) or #item.componets > 4 then
			panel.StaticScale.fixed_h = 26 + (#item.componets) * 25 + ((item.mintemp or item.failtemp) and 25 or 0)
		end
	end

	if item.xp and ent.XPTable and not LocalPlayer():JobXPOpen(ent.XPTable, id) then
		panel.cbtn = MSD.BigButtonClean(panel, 0, 0, 128, 128, "", LocalPlayer():JobXP(ent.XPTable) >= (tonumber(item.xp) and item.xp or item.time * 4) and MSD.Icons48.lock_open or MSD.Icons48.lock, function()
			net.Start("McINV.Upgrade")
			net.WriteString(id)
			net.WriteEntity(ent)
			net.SendToServer()
		end, LocalPlayer():JobXP(ent.XPTable) >= (tonumber(item.xp) and item.xp or item.time * 4) and color_white or color_dim, color_dim)
	end

	parent:AddItem(panel)

	return panel
end

local ammo_icon = Material("mqs/icons/ammo.png", "smooth")
local stack_icon = Material("msd/icons/layers.png", "smooth")
local drop_icon = Material("mqs/map_markers/b3.png", "smooth")
local stack_icon2 = Material("mqs/map_markers/b1.png", "smooth")

local item_types = {
	[INV_WEAPON] = MSD.Patern.SubColor["8"],
	[INV_AMMO] = MSD.Patern.SubColor["6"],
	[INV_JUNK] = MSD.Patern.MainColor["3"],
	[INV_FOOD] = MSD.Patern.MainColor["8"],
}

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

local function createFrame(w, h)
	local pframe = vgui.Create("MSDSimpleFrame")
	pframe:SetSize(w, h)
	pframe:SetDraggable(false)
	pframe:Center()
	pframe:MakePopup()
	pframe:SetAlpha(1)
	pframe:AlphaTo(255, 0.3)

	return pframe
end
local bgc = Color(0,0,0)

hook.Add("DrawOverlay", "McINV.Desc", function()
	local x, y = input.GetCursorPos()
	if x < 1 then return end

	local pn = vgui.GetHoveredPanel()

	if IsValid(pn) and pn.descr and (DarkRP.Decriptions[pn.descr] or pn.showdsc) then
		local pref = ""
		if pn.register then
			pref = "Серийный номер: " .. pn.register.id .. "\n"
		end
		local txt, w, h = MSD.TextWrap(pref .. (DarkRP.Decriptions[pn.descr] or pn.descr), "MSDFont.20", 490)
		MSDX.Draw(0, x, y + 25, w + 10, h, bgc)
		draw.DrawText(txt, "MSDFont.20", x + 5, y + 25, MSD.Text.d, TEXT_ALIGN_LEFT)
	end
end)

local gunstates = {
	{"Хорошее", 0.9},
	{"В норме", 0.7},
	{"Ранее использованное", 0.4},
	{"Давно не обслуженное", 0.2},
	{"Убитое", 0},
}

local lab = {
	["drugs"] = "Оч. опыта лаботаторного стола:",
	["cook"] = "Оч. опыта кулинара:",
	["car"] = "Оч. опыта механика:",
	["alc"] = "Оч. опыта бармена:",
	["guns"] = "Оч. опыта оружейного мастера",
	["pharm"] = "Оч. опыта фармацевта:",
	["fdny"] = "Оч. опыта FDNY:",
	["planter"] = "Оч. опыта грядки:",
}

function McINV.InventoryItem(parent, ent, type, item, func, func2, sprice, customicon, funcm)
	if not LocalPlayer():IsUnrestrained() then return end
	local button = vgui.Create("DPanel")
	button:SetSize(100, 60)

	button.StaticScale = {
		w = 1,
		fixed_h = 60,
		minw = 250,
		minh = 60
	}

	button.fade = 0
	button.count = math.max(item.dt and tonumber(item.dt.uses or 1) or 1, 1)

	button.descr = item.class
	button.register = item.register

	if item.gunstate then
		for _, v in ipairs(gunstates) do
			if item.gunstate >= v[2] then
				button.gstate = v[1]
				break
			end
		end
	end
	button.dname = item.name or (ent and ent.name or "Удалённый предмет")
	button.dweight = (item.weight or (ent and ent.weight or 1)) .. " кг"

	button.Paint = function(self, w, h)
		if (self.main and self.main.hover) or (self.sub and self.sub.hover) then
			self.fade = Lerp(FrameTime() * 7, self.fade, 1)
		else
			self.fade = Lerp(FrameTime() * 7, self.fade, 0)
		end

		MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
		MSDX.Draw(0, 0, 0, 5, h, item_types[type] or MSD.Patern.MainColor["p"])
		draw.SimpleText(self.dname, "MSDFont.22", h + 15, 5, MSD.ColorAlpha(MSD.Text.d, 255 - self.fade * 255), TEXT_ALIGN_LEFT)
		draw.DrawText(self.dname, "MSDFont.22", h + 15, 5, MSD.ColorAlpha(MSD.Patern.MainColor["p"], self.fade * 255), TEXT_ALIGN_LEFT)
		local wd = draw.SimpleText(self.dweight, "MSDFont.20", h + 15, 30, MSD.Text.s, TEXT_ALIGN_LEFT)

		if self.gstate and not self.IgnoreState then
			MSD.DrawTexturedRect(h + 22 + wd, 31, 16, 16, MSD.Icons48.cog, MSD.Text.d)
			draw.SimpleText(self.gstate, "MSDFont.20", h + 45 + wd, 30, MSD.Text.d, TEXT_ALIGN_LEFT)
		end

		if self.count > 1 and (not item.dt or not item.dt.uses or (item.dt.uses and self.count ~= item.dt.uses)) then
			MSD.DrawTexturedRect(h + 22 + wd, 31, 16, 16, stack_icon, MSD.Text.d)
			draw.SimpleText("x " .. self.count, "MSDFont.20", h + 45 + wd, 30, MSD.Text.d, TEXT_ALIGN_LEFT)
		elseif item.dt and item.dt.Ammo then
			MSD.DrawTexturedRect(h + 22 + wd, 31, 16, 16, ammo_icon, MSD.Text.d)
			draw.SimpleText(item.dt.Ammo, "MSDFont.20", h + 45 + wd, 30, MSD.Text.d, TEXT_ALIGN_LEFT)
		elseif item.dt and item.dt.uses and item.dt.uses > 1 then
			MSD.DrawTexturedRect(h + 22 + wd, 31, 16, 16, stack_icon2, MSD.Text.d)
			draw.SimpleText(item.dt.uses, "MSDFont.20", h + 45 + wd, 30, MSD.Text.d, TEXT_ALIGN_LEFT)
		elseif item.mt then
			if item.mt > os.stime() then
				MSD.DrawTexturedRect(h + 22 + wd, 31, 16, 16, MSD.Icons48.silverware, MSD.Text.d)
			elseif ent and ent.btime and item.mt + ent.btime * 5 < os.stime() then
				MSD.DrawTexturedRect(h + 22 + wd, 31, 16, 16, MSD.Icons48.food_off, MSD.Text.d)
			end
		end

		MSD.DrawTexturedRect(10, 5, h - 10, h - 10, McINV.Icons[item.class] or MSD.IconRender.Get(item.model or "models/props_junk/CinderBlock01a.mdl", item.material, item.submat or ent and ent.submat, item.color or ent and ent.color), color_white)

		if self.locked then
			MSD.DrawTexturedRect(0, 0, w, h, glass, color_white)
			return
		end

		if sprice then
			if item.xp then
				if LocalPlayer():JobXP(item.xp[1]) < item.xp[2] then
					MSD.DrawTexturedRect(0, 0, w, h, glass, color_white)
					draw.SimpleText("Нет в наличии", "MSDFontB.32", w - 25, 15, MSD.Text.n, TEXT_ALIGN_RIGHT)
					return
				end
				draw.SimpleText("$" .. math.Round(sprice), "MSDFontB.22", w - 70, 5, MSD.Text.d, TEXT_ALIGN_RIGHT)
				local sps = draw.SimpleText(item.xp[2], "MSDFontB.22", w - 70, 30, MSD.Text.d, TEXT_ALIGN_RIGHT)
				draw.SimpleText(lab[item.xp[1]] .. " ", "MSDFont.22", w - 70 - sps, 30, MSD.Text.d, TEXT_ALIGN_RIGHT)
			else
				draw.SimpleText("$" .. math.Round(sprice), "MSDFont.32", w - 70, 15, MSD.Text.d, TEXT_ALIGN_RIGHT)
			end

		end
	end

	button.DoRightClick = function(self)
		self:DoClick()
	end

	if sprice and item.xp and LocalPlayer():JobXP(item.xp[1]) < item.xp[2] then
		parent:AddItem(button)
		return button
	end

	local but_main = MSD.IconButton(button, sprice and MSD.Icons48.cash or drop_icon, 5, 5, 46, nil, nil, func)
	but_main:DockMargin(14, 14, 14, 14)
	but_main:DockPadding(14, 14, 14, 14)
	but_main:Dock(RIGHT)
	but_main:SetSize(32, 32)
	button.main = but_main
	but_main.DoRightClick = function()
		if funcm then funcm() end
	end

	if func2 then
		local but_sub = MSD.IconButton(button, customicon or MSD.Icons48.swap, 5, 5, 46, nil, nil, func2)
		but_sub:DockMargin(14, 14, 14, 14)
		but_sub:DockPadding(14, 14, 14, 14)
		but_sub:Dock(RIGHT)
		but_sub:SetSize(32, 32)
		button.sub = but_sub
	end

	parent:AddItem(button)

	return button
end

function McINV.InventoryCraft(parent, ent, type, item, func, func2)
	local button = vgui.Create("DPanel")
	button:SetSize(100, 60)

	button.StaticScale = {
		w = 1,
		fixed_h = 60,
		minw = 250,
		minh = 60
	}

	button.fade = 0

	button.Paint = function(self, w, h)
		if (self.main and self.main.hover) or (self.sub and self.sub.hover) then
			self.fade = Lerp(FrameTime() * 7, self.fade, 1)
		else
			self.fade = Lerp(FrameTime() * 7, self.fade, 0)
		end

		MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
		MSDX.Draw(0, 0, 0, 5, h, type == INV_WEAPON and MSD.Patern.SubColor["8"] or MSD.Patern.MainColor["8"])
		draw.SimpleText(item.name or ent.name, "MSDFont.22", h + 15, 5, MSD.ColorAlpha(MSD.Text.d, 255 - self.fade * 255), TEXT_ALIGN_LEFT)
		draw.DrawText(item.name or ent.name, "MSDFont.22", h + 15, 5, MSD.ColorAlpha(MSD.Patern.MainColor["p"], self.fade * 255), TEXT_ALIGN_LEFT)
		local wd = draw.SimpleText((item.weight or ent.weight) .. " кг", "MSDFont.20", h + 15, 30, MSD.Text.s, TEXT_ALIGN_LEFT)

		if item.dt and item.dt.Ammo then
			MSD.DrawTexturedRect(h + 22 + wd, 31, 16, 16, ammo_icon, MSD.Text.d)
			draw.SimpleText(item.dt.Ammo, "MSDFont.20", h + 45 + wd, 30, MSD.Text.d, TEXT_ALIGN_LEFT)
		end

		MSD.DrawTexturedRect(10, 5, h - 10, h - 10, McINV.Icons[item.class] or MSD.IconRender.Get(item.model or "models/props_junk/CinderBlock01a.mdl"), color_white)
	end

	button.DoRightClick = function(self)
		self:DoClick()
	end

	parent:AddItem(button)

	return button
end

function McINV.CreateStorageUI(ent, inv_ent, msg)
	if not LocalPlayer():IsUnrestrained() then return end

	if IsValid(McINV.StorageUI) then
		McINV.StorageUI:Close()

		return
	end

	local SW, SH = ScrW(), ScrH()
	SW, SH = SW - SW / 3, SH - SH / 6
	local name = ent.GetStorageName and ent:GetStorageName() or "Инвентарь"
	name = name ~= "" and name or "Контейнер"

	McINV.StorageUI = createFrame(SW, SH)
	McINV.StorageUI.Ent = ent

	McINV.StorageUI.Think = function(self)
		if not IsValid(ent) or not LocalPlayer():IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) or not McINV.CanLoot(LocalPlayer(), ent) then
			self:Close()
		end
	end

	McINV.StorageUI.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText(name, "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	local menu = McINV.StorageUI

	MSD.CloseButtonIcon(menu, SW - 160, 5, 150, 40, "Закрыть", function()
		menu:Close()
	end)

	menu.list = createList(menu, 5, 70, SW / 2 - 15, SH - 70)

	McINV.StorageUI.Update = function(inv)
		menu.list:Clear()
		menu.list.stacks = {}
		local space = (ent.GetSpace and ent:GetSpace() or (ent:GetDefaultSpace() or 0))

		MSD.Header(menu.list, "Содержимое - " .. McINV.GetSpace(inv) .. " / " .. space .. " кг", nil, nil, function(s, w, h)
			local pr = McINV.GetSpace(inv) / space
			MSDX.Draw(0, 0, h - 5, w, 5, MSD.Patern.MainColor["9"])
			MSDX.Draw(0, 0, h - 5, w * pr, 5, MSD.Patern.MainColor.p)
		end)

		if msg and msg ~= "" then
			local panel = vgui.Create("DPanel")
			panel.StaticScale = {w = 1, fixed_h = 70, minw = 250, minh = 70 }
			panel.Paint = function(self, w, h)
				if not self.text or w ~= self.lw then
					self.text, self.fw, self.fh = MSD.TextWrap(msg, "MSDFont.22", w - 15)
					self.lw = w
				end
				MSDX.Draw(0, 0, 0, 5, h, MSD.Patern.MainColor.p)
				draw.DrawText(self.text, "MSDFont.22", 10, 5, MSD.Text.d, TEXT_ALIGN_LEFT)
				if self.fh and self.fh + 10 ~= h then
					self.StaticScale.fixed_h = self.fh + 10
				end
			end
			menu.list:AddItem(panel)
		end

		for type, ilist in pairs(inv) do
			for id, item in pairs(ilist) do
				local entt = McINV.GetItem(type, item.class)

				if type ~= INV_WEAPON and item.dt and not item.dt.Ammo and item.dt.eclass and menu.list.stacks[item.name] then
					menu.list.stacks[item.name].count = menu.list.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
					continue
				end

				local btn = McINV.InventoryItem(menu.list, entt, type, item, function(self)
					McINV.DropFromStorage(ent, type, id)
				end, function()
					McINV.TakeFromStorage(ent, type, id)
				end)

				hook.Call("InventoryStorageUI", nil, ent, type, item, id, btn, menu.list)

				if not ent.policeEvidnce and type ~= INV_WEAPON and item.dt and item.dt.eclass then
					menu.list.stacks[item.name] = btn
				end
			end
		end
	end

	McINV.StorageUI.Update(inv_ent)
	menu.list_ply = createList(menu, SW / 2 + 5, 70, SW / 2 - 15, SH - 70)

	menu.list_ply.Update = function()
		menu.list_ply:Clear()
		menu.list_ply.stacks = {}

		MSD.Header(menu.list_ply, "Ваш инвентарь - " .. McINV.GetSpace(McINV.inv) .. " / " .. LocalPlayer():GetDefaultSpace() .. " кг", nil, nil, function(s, w, h)
			local pr = McINV.GetSpace(McINV.inv) / LocalPlayer():GetDefaultSpace()
			MSDX.Draw(0, 0, h - 5, w, 5, MSD.Patern.MainColor["9"])
			MSDX.Draw(0, 0, h - 5, w * pr, 5, MSD.Patern.MainColor.p)
		end)

		for type, ilist in pairs(McINV.inv) do
			for id, item in pairs(ilist) do
				local entt = McINV.GetItem(type, item.class)

				if type ~= INV_WEAPON and item.dt and not item.dt.Ammo and item.dt.eclass and menu.list_ply.stacks[item.name] then
					menu.list_ply.stacks[item.name].count = menu.list_ply.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
					continue
				end

				local btn = McINV.InventoryItem(menu.list_ply, entt, type, item, function(self)
					RunConsoleCommand("Inventory.Drop", type, id)
				end, function()
					McINV.PutInStorage(ent, type, id)
				end, nil, nil, function()
					RunConsoleCommand("Inventory.Drop", type, id, " ", 1)
				end)

				if type ~= INV_WEAPON and item.dt and item.dt.eclass then
					menu.list_ply.stacks[item.name] = btn
				end
			end
		end
	end

	menu.list_ply.Update()
	McINV.StorageUIPly = menu.list_ply
end

local focusPoints = {
	["models/props_wasteland/controlroom_desk001b.mdl"] = {Vector(18.61, -1.67, 16.84), 180},
	["models/props_wasteland/kitchen_stove001a.mdl"] = {Vector(14.19, 3.28, 39.52), 180},
	["models/mosi/fallout4/furniture/workstations/workshopbench.mdl"] = {Vector(-29.86, -2.05, 35.76), 180},
	["models/noire/alcset.mdl"] = {Vector(25.82,-78.69,-9.58), 180},
	["models/noire/labset.mdl"] = {Vector(-10.08,7.99,-4.14), 180},
	["models/h4_prop_h4_table_isl_02a.mdl"] = {Vector(2.07,0.36,37.79), 180},
}

function McINV.CreateCraftingStorageUI(ent, inv_ent)
	if not LocalPlayer():IsUnrestrained() then return end

	if IsValid(McINV.StorageUI) then
		McINV.StorageUI:Close()

		return
	end

	local SW, SH = ScrW(), ScrH()
	SW, SH = SW - SW / 6, SH - SH / 6
	local name = ent.GetStorageName and ent:GetStorageName() or "Инвентарь"
	name = name ~= "" and name or "Контейнер"
	local fcam = focusPoints[ent:GetModel()]

	if fcam then
		DarkRP.ViewFocus = {
			ent = ent,
			ang = fcam[2],
			point = fcam[1],
			drawp = true,
			fade = false
		}
	end

	McINV.StorageUI = createFrame(SW, SH)
	McINV.StorageUI.Ent = ent

	McINV.StorageUI.Think = function(self)
		if not IsValid(ent) or not LocalPlayer():IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) or not McINV.CanLoot(LocalPlayer(), ent) then
			self:Close()
		end
	end

	McINV.StorageUI.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		local wd = draw.SimpleText(name, "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)

		if IsValid(ent) and ent.XPTable then
			draw.SimpleText(" | Очки опыта: " .. LocalPlayer():JobXP(ent.XPTable), "MSDFont.25", wd + 12, 12, color_white, TEXT_ALIGN_LEFT)
		end
	end

	McINV.StorageUI.OnClose = function(self, w, h)
		if DarkRP.ViewFocus then
			DarkRP.ViewFocus.fade = true
		end
	end

	local menu = McINV.StorageUI

	MSD.CloseButtonIcon(menu, SW - 160, 5, 150, 40, "Закрыть", function()
		menu:Close()
	end)

	menu.craft = createList(menu, 5, 70, SW / 3 - 15, SH - 125)

	menu.craft.Update = function(filter)
		menu.craft:Clear()
		menu.filter = filter
		if not ent.BluePrints then return end

		if filter and filter ~= "" and filter ~= " " then
			MSD.Header(menu.craft, "Поиск", function()
				menu.craft.Update()
			end)

			for k, v in SortedPairsByMemberValue(ent.BluePrints, ent.SortBy or "price") do
				if k == "BaseClass" then continue end
				if not string.find(utf8.search(v.name), utf8.search(filter)) then continue end

				if ent.TeamLimit and team.GetName(LocalPlayer():Team()) ~= ent.TeamLimit and not v.nolimit then continue end
				McINV.BluePrint(menu.craft, v, ent, k)
			end

			return
		end

		MSD.Header(menu.craft, "Рецепты крафта")

		if ent.TeamLimit and team.GetName(LocalPlayer():Team()) ~= ent.TeamLimit then
			for k, v in SortedPairsByMemberValue(ent.BluePrints, ent.SortBy or "price") do
				if not v.nolimit then continue end
				if k == "BaseClass" then continue end
				McINV.BluePrint(menu.craft, v, ent, k)
			end
			return
		end

		local catlist = {}
		for k, v in SortedPairsByMemberValue(ent.BluePrints, ent.SortBy or "price") do
			if v.category then catlist[v.category] = true continue end
			if k == "BaseClass" then continue end
			McINV.BluePrint(menu.craft, v, ent, k)
		end

		for k, _ in SortedPairs(catlist) do
			MSD.ButtonIcon(menu.craft, "static", nil, 1, 50, k, MSD.Icons48.dot, function()
				menu.craft:Clear()

				MSD.Header(menu.craft, k, function()
					menu.craft.Update()
				end)

				for id, v in SortedPairsByMemberValue(ent.BluePrints, ent.SortBy or "price") do
					if not v.category or v.category ~= k then continue end
					if id == "BaseClass" then continue end
					McINV.BluePrint(menu.craft, v, ent, id)
				end
			end)
		end
	end

	MSD.TextEntry(menu, 5, SH - 50, SW / 3 - 17, 45, "Поиск...", "", "", function(self, value)
		menu.craft.Update(value)
	end, true)

	menu.craft.Update()

	menu.list = createList(menu, SW / 3 + 5, 70, SW / 3 - 15, SH - 70)

	McINV.StorageUI.Update = function(inv, crf)
		if crf then
			menu.craft.Update(menu.filter)
		end

		ent.inv = inv
		menu.list:Clear()
		menu.list.stacks = {}
		local space = (ent.GetSpace and ent:GetSpace() or (ent:GetDefaultSpace() or 0))

		MSD.Header(menu.list, "Содержимое - " .. McINV.GetSpace(inv) .. " / " .. space .. " кг", nil, nil, function(s, w, h)
			local pr = McINV.GetSpace(inv) / space
			MSDX.Draw(0, 0, h - 5, w, 5, MSD.Patern.MainColor["9"])
			MSDX.Draw(0, 0, h - 5, w * pr, 5, MSD.Patern.MainColor.p)
		end)

		for type, ilist in pairs(inv) do
			for id, item in pairs(ilist) do
				local entt = McINV.GetItem(type, item.class)

				if type ~= INV_WEAPON and item.dt and not item.dt.Ammo and item.dt.eclass and menu.list.stacks[item.name] then
					menu.list.stacks[item.name].count = menu.list.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
					continue
				end

				local btn = McINV.InventoryItem(menu.list, entt, type, item, function(self)
					McINV.DropFromStorage(ent, type, id)
				end, function()
					McINV.TakeFromStorage(ent, type, id)
				end)

				if type ~= INV_WEAPON and item.dt and item.dt.eclass then
					menu.list.stacks[item.name] = btn
				end
			end
		end

		if ent.GetCrafting and ent:GetCrafting() then
			if IsValid(menu.overlay) then
				menu.overlay:Remove()

				return
			end

			local id = ent:GetCraftingItem()
			local spin = 0
			local item = ent.BluePrints[id]
			menu.overlay, menu.crafting = MSD.WorkSpacePanel(menu, "", 2.5, 6, false)
			menu.crafting.clsBut:Remove()
			menu.crafting.clsBut = nil

			menu.crafting.Paint = function(self, w, h)
				local pr = (CurTime() - ent:GetCraftStart()) / ent:GetCraftDelay()

				if not ent:GetStopCraft() then
					spin = math.sin(CurTime()) * 360
				end

				MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["d"])
				MSD.DrawTexturedRect(0, 0, h, h, bp_icon, color_white)
				draw.DrawText(item.name, "MSDFont.32", h + 10, 0, color_white, TEXT_ALIGN_LEFT)
				draw.DrawText(string.FormattedTime(ent:GetCraftDelay() - (CurTime() - ent:GetCraftStart()), "%02i:%02i"), "MSDFont.32", h + 10, h - 52, MSD.Text.d, TEXT_ALIGN_LEFT)

				if item.mintemp or item.failtemp then
					local sp = 0

					if item.mintemp then
						sp = draw.SimpleText(item.mintemp .. "°C min ", "MSDFont.32", h + 10, h - 80, MSD.Patern.SubColor["9"], TEXT_ALIGN_LEFT)
					end

					sp = sp + draw.SimpleText("| " .. ent:GetTemp() .. "°C | ", "MSDFont.32", sp + h + 10, h - 80, MSD.Text.d, TEXT_ALIGN_LEFT)

					if item.failtemp then
						draw.DrawText(item.failtemp .. "°C max", "MSDFont.32", sp + h + 10, h - 80, MSD.Patern.MainColor["9"], TEXT_ALIGN_LEFT)
					end
				end

				MSD.DrawTexturedRectRotated(spin, h / 2, h / 2 - 24, 48, 48, MSD.Icons48.cog, color_white)
				MSDX.Draw(0, h, h - 10, w - h, 10, MSD.Patern.MainColor["9"])
				MSDX.Draw(0, h, h - 10, (w - h) * pr, 10, MSD.Patern.MainColor.p)
			end

			if item.mintemp or item.failtemp then
				MSD.BigButtonClean(menu.crafting, 0, 0, menu.crafting:GetTall(), menu.crafting:GetTall(), "Охладить 30°", nil, function()
					net.Start("McINV.ToggleCraft")
					net.WriteEntity(ent)
					net.SendToServer()
				end, color_white, color_dim)
			end

			return
		end

		if IsValid(menu.overlay) then
			menu.overlay:Remove()
		end
	end

	McINV.StorageUI.Update(inv_ent)

	menu.list_ply = createList(menu, (SW / 3) * 2 + 5, 70, SW / 3 - 15, SH - 70)

	menu.list_ply.Update = function()
		menu.list_ply:Clear()
		menu.list_ply.stacks = {}

		MSD.Header(menu.list_ply, "Ваш инвентарь - " .. McINV.GetSpace(McINV.inv) .. " / " .. LocalPlayer():GetDefaultSpace() .. " кг", nil, nil, function(s, w, h)
			local pr = McINV.GetSpace(McINV.inv) / LocalPlayer():GetDefaultSpace()
			MSDX.Draw(0, 0, h - 5, w, 5, MSD.Patern.MainColor["9"])
			MSDX.Draw(0, 0, h - 5, w * pr, 5, MSD.Patern.MainColor.p)
		end)

		for type, ilist in pairs(McINV.inv) do
			for id, item in pairs(ilist) do
				local entt = McINV.GetItem(type, item.class)

				if type ~= INV_WEAPON and item.dt and not item.dt.Ammo and item.dt.eclass and menu.list_ply.stacks[item.name] then
					menu.list_ply.stacks[item.name].count = menu.list_ply.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
					continue
				end

				local btn = McINV.InventoryItem(menu.list_ply, entt, type, item, function(self)
					RunConsoleCommand("Inventory.Drop", type, id)
				end, function()
					McINV.PutInStorage(ent, type, id)
				end, nil, nil, function()
					RunConsoleCommand("Inventory.Drop", type, id, " ", 1)
				end)

				if type ~= INV_WEAPON and item.dt and item.dt.eclass then
					menu.list_ply.stacks[item.name] = btn
				end
			end
		end
	end

	menu.list_ply.Update()
	McINV.StorageUIPly = menu.list_ply
end

function McINV.CreateBankUI(noput)
	if not LocalPlayer():IsFreeman() then return end

	if IsValid(McINV.BankUI) then
		McINV.BankUI:Close()

		return
	end

	local SW, SH = ScrW(), ScrH()
	SW, SH = SW - SW / 3, SH - SH / 6
	local name = noput and "Доставка" or "Ваше хранилище"
	McINV.BankUI = createFrame(SW, SH)
	McINV.BankUI.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText(name, "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	local menu = McINV.BankUI

	MSD.CloseButtonIcon(menu, SW - 160, 5, 150, 40, "Закрыть", function()
		menu:Close()
	end)

	menu.list = createList(menu, 5, 70, SW / 2 - 15, SH - 70)

	local sort = true

	McINV.BankUI.Update = function(inv)
		menu.list_ply.Update()
		menu.list:Clear()
		menu.list.stacks = {}

		MSD.Header(menu.list, "Содержимое - " .. McINV.GetSpace(McINV.bank) .. " / " .. LocalPlayer():getDarkRPVar("bankspace") .. " кг", function()
			sort = not sort
			McINV.BankUI.Update(inv)
		end, sort and MSD.Icons48.card_multiple_outline or MSD.Icons48.card_multiple, function(s, w, h)
			local pr = McINV.GetSpace(McINV.bank) / LocalPlayer():getDarkRPVar("bankspace")
			MSDX.Draw(0, 0, h - 5, w, 5, MSD.Patern.MainColor["9"])
			MSDX.Draw(0, 0, h - 5, w * pr, 5, MSD.Patern.MainColor.p)
		end)

		if noput then
			local panel = vgui.Create("DPanel")
			panel.StaticScale = {w = 1, fixed_h = 70, minw = 250, minh = 70 }
			panel.Paint = function(self, w, h)
				if not self.text or w ~= self.lw then
					self.text, self.fw, self.fh = MSD.TextWrap(sklad_ds, "MSDFont.22", w - 15)
					self.lw = w
				end
				MSDX.Draw(0, 0, 0, 5, h, MSD.Patern.MainColor.p)
				draw.DrawText(self.text, "MSDFont.22", 10, 5, MSD.Text.d, TEXT_ALIGN_LEFT)
				if self.fh and self.fh + 10 ~= h then
					self.StaticScale.fixed_h = self.fh + 10
				end
			end
			menu.list:AddItem(panel)
		end

		for type, ilist in pairs(McINV.bank) do
			if noput and (type == INV_WEAPON or type == INV_AMMO) then continue end
			for id, item in pairs(ilist) do
				if noput and McINV.LimitedMailItems[item.class] then continue end
				local entt = McINV.GetItem(type, item.class)
				if noput and (not item.dltime or item.dltime < os.stime()) then continue end

				if sort and type ~= INV_WEAPON and item.dt and item.dt.eclass and menu.list.stacks[item.name] then
					menu.list.stacks[item.name].count = menu.list.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
					continue
				end

				local btn = McINV.InventoryItem(menu.list, entt, type, item, function(self)
					McINV.TakeFromBank(type, id)
				end)

				if type == INV_WEAPON then
					btn.IgnoreState = true
				end

				btn.main.mat = MSD.Icons48.arrow_right

				if sort and type ~= INV_WEAPON and item.dt and item.dt.eclass then
					menu.list.stacks[item.name] = btn
				end
			end
		end
	end

	menu.list_ply = createList(menu, SW / 2 + 5, 70, SW / 2 - 15, SH - 70)
	menu.sort = true
	menu.list_ply.Update = function()
		menu.list_ply:Clear()
		menu.list_ply.stacks = {}

		MSD.Header(menu.list_ply, "Ваш инвентарь - " .. McINV.GetSpace(McINV.inv) .. " / " .. LocalPlayer():GetDefaultSpace() .. " кг", function()
			menu.sort = not menu.sort
			menu.list_ply.Update()
		end, menu.sort and MSD.Icons48.card_multiple_outline or MSD.Icons48.card_multiple, function(s, w, h)
			local pr = McINV.GetSpace(McINV.inv) / LocalPlayer():GetDefaultSpace()
			MSDX.Draw(0, 0, h - 5, w, 5, MSD.Patern.MainColor["9"])
			MSDX.Draw(0, 0, h - 5, w * pr, 5, MSD.Patern.MainColor.p)
		end)

		for type, ilist in pairs(McINV.inv) do
			for id, item in pairs(ilist) do
				local entt = McINV.GetItem(type, item.class)

				if menu.sort and type ~= INV_WEAPON and item.dt and item.dt.eclass and menu.list_ply.stacks[item.name] then
					menu.list_ply.stacks[item.name].count = menu.list_ply.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
					continue
				end

				local btn = McINV.InventoryItem(menu.list_ply, entt, type, item, function(self)
					RunConsoleCommand("Inventory.Drop", type, id)
				end, not noput and function()
					McINV.PutInBank(type, id)
				end, nil, nil, function()
					RunConsoleCommand("Inventory.Drop", type, id, " ", 1)
				end)

				if menu.sort and type ~= INV_WEAPON and item.dt and item.dt.eclass then
					menu.list_ply.stacks[item.name] = btn
				end
			end
		end
	end

	McINV.BankUI.Update(inv_ent)
	McINV.StorageUIPly = menu.list_ply
end

local sort = true

function McINV.StoreUIEnt(ent)
	if not LocalPlayer():IsUnrestrained() then return end

	if IsValid(McINV.StorageUI) then
		McINV.StorageUI:Close()
		return
	end

	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 2, SH - SH / 6
	local name = ent.GetStorageName and ent:GetStorageName() or "Инвентарь"
	name = name ~= "" and name or "Контейнер"
	McINV.StorageUI = createFrame(SW, SH)
	McINV.StorageUI.Ent = ent

	McINV.StorageUI.Think = function(self)
		if not IsValid(ent) or not LocalPlayer():IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end

	McINV.StorageUI.Paint = function(self, w, h)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText(name, "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	local menu = McINV.StorageUI

	MSD.CloseButtonIcon(menu, SW - 160, 5, 150, 40, "Закрыть", function()
		menu:Close()
	end)

	menu.list = createList(menu, 5, 55, SW - 10, SH - 55)

	McINV.StorageUI.Update = function(inv)
		menu.list:Clear()
		menu.list.stacks = {}
		if not inv then return end
		for type, ilist in pairs(inv) do
			if not ent.SellTypes[type] then continue end

			for id, item in pairs(ilist) do
				local entt = McINV.GetItem(type, item.class)

				if not entt or entt.noresell then continue end

				if sort and type ~= INV_WEAPON and item.dt and not item.dt.Ammo and item.dt.eclass and menu.list.stacks[item.name] then
					menu.list.stacks[item.name].count = menu.list.stacks[item.name].count + (item.dt and math.max(item.dt.uses or 1, 1) or 1)
					continue
				end

				local price = McINV.Tax(entt.price or 0, type, item)
				local btn = McINV.InventoryItem(menu.list, entt, type, item, function(self)
					net.Start("McINV.BuyFromEnt")
						net.WriteEntity(ent)
						net.WriteString(type)
						net.WriteInt(id, 16)
					net.SendToServer()
				end, nil, math.max(price + price * ent:GetCustomPrice(), 1))

				if sort and type ~= INV_WEAPON and item.dt and item.dt.eclass then
					menu.list.stacks[item.name] = btn
				end
			end
		end
	end

	McINV.StorageUI.Update(ent.inv)

	MSD.IconButton(menu, MSD.Icons48.menu, SW - 180, 5, 40, nil, nil, function()
		if DarkRP.PressDelay(0.3) then return end
		sort = not sort
		McINV.StorageUI.Update(ent.inv)
	end)
end

function McINV.StorageUpgrade()
	if not LocalPlayer():IsUnrestrained() then return end

	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 2, SH - SH / 10

	local menu = createFrame(SW, SH)
	menu.Think = function(self)
		if not LocalPlayer():IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end
	menu.Paint = function(self, w, h)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Улучшения", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	MSD.CloseButtonIcon(menu, SW - 160, 5, 150, 40, "Закрыть", function()
		menu:Close()
	end)

	menu.list = createList(menu, 5, 55, SW - 10, SH - 55)

	local bank = LocalPlayer():getDarkRPVar("bankspace")

	for k, v in SortedPairs(McINV.BankPlanes) do
		local panel = vgui.Create("DPanel")
		panel.StaticScale = {
			w = 1,
			h = 6,
			minw = 150,
			minh = 150
		}

		panel.fade = 0

		panel.Paint = function(self, w, h)
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
			if k <= bank then
				MSD.DrawTexturedRect(0, 0, w, h, glass, color_white)
				draw.DrawText(v.descr .. " план уже активен", "MSDFont.32", w / 2, h / 2 - 16, MSD.Text.d, TEXT_ALIGN_CENTER)
				return
			end

			if v.need and bank < v.need then
				MSD.DrawTexturedRect(0, 0, w, h, glass, color_white)
				draw.DrawText("Для активации плана " .. v.descr .. " требуется план " .. McINV.BankPlanes[v.need].descr, "MSDFont.25", w / 2, h / 2 - 16, MSD.Text.d, TEXT_ALIGN_CENTER)
				return
			end

			MSD.DrawTexturedRect(0, 0, w, h, glass, MSD.ColorAlpha(color_white, 25))
			draw.DrawText("План: " .. v.descr, "MSDFont.30", h, 12, color_white, TEXT_ALIGN_LEFT)
			draw.DrawText("Увеличение хранилища до " .. k .. " кг", "MSDFont.26", h, 42, color_white, TEXT_ALIGN_LEFT)
			MSD.DrawTexturedRectRotated(v.donate and CurTime() * 25 % 360 or 0, h / 2 + 5, h / 2, h - 10, h - 10, star, v.cl)
			MSD.DrawTexturedRectRotated(0, h / 2 + 5, h / 2, 48, 48, v.donate and donate or normal, color_white)
			if panel.btn and not panel.btn.sized and h >= 150 then
				panel.btn:SetPos(h, h - 55)
				panel.btn.sized = true
			end
		end

		if not (v.need and bank < v.need) and k > bank then
			panel.btn = MSD.Button(panel, 0, 0, 300, 50, v.donate and "Разблокировать за: " .. v.donate .. "¤" or "Купить за: $" .. string.Comma(v.price), function()
				net.Start("McINV.UpgradeBank")
				net.WriteUInt(k, 8)
				net.SendToServer()
				menu:Close()
			end, true)
		end

		menu.list:AddItem(panel)
	end
end

function McINV.StoreUINpc(stype)
	if not LocalPlayer():IsUnrestrained() then return end

	if IsValid(McINV.StorageUI) then
		McINV.StorageUI:Close()
		return
	end

	local shop_craft = {}
	local shop_food = {}
	local shop_junk = {}
	local shop_ents = {}
	local shop_weps = {}

	for k,v in pairs(DarkRP.Weapons) do
		if v.shop ~= stype then continue end
		if v.job and not v.job[LocalPlayer():Team()] then continue end
		shop_weps[k] = v
	end

	for k,v in pairs(DarkRP.Entities) do
		if v.shop ~= stype then continue end
		if v.job and not v.job[LocalPlayer():Team()] then continue end
		shop_ents[k] = v
	end

	for k,v in pairs(DarkRP.Stations) do
		if v.shop ~= stype then continue end
		if v.job and not v.job[LocalPlayer():Team()] then continue end
		shop_craft[k] = v
	end

	for k,v in pairs(DarkRP.Food) do
		if v.shop ~= stype then continue end
		if v.job and not v.job[LocalPlayer():Team()] then continue end
		shop_food[k] = v
	end

	for k,v in pairs(DarkRP.Junk) do
		if v.shop ~= stype then continue end
		if v.job and not v.job[LocalPlayer():Team()] then continue end
		shop_junk[k] = v
	end

	local SW, SH = ScrW(), ScrH()
	SW, SH = SW / 2, SH - SH / 6
	local name = "Магазин"

	McINV.StorageUI = createFrame(SW, SH)
	McINV.StorageUI.Think = function(self)
		if not LocalPlayer():IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) then
			self:Close()
		end
	end

	McINV.StorageUI.Paint = function(self, w, h)
		MSD.Blur(self, 2, 2, 155, 155, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText(name, "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	local menu = McINV.StorageUI

	MSD.CloseButtonIcon(menu, SW - 160, 5, 150, 40, "Закрыть", function()
		menu:Close()
	end)

	menu.list = createList(menu, 5, 55, SW - 10, SH - 55)

	McINV.StorageUI.Update = function()
		menu.list:Clear()
		menu.list.stacks = {}

		for class, item in SortedPairsByMemberValue(shop_weps, "name") do
			local price = McINV.Tax(item.price or 0)
			item.class = class
			McINV.InventoryItem(menu.list, item, INV_WEAPON, item, function(self)
				DarkRP.PlayerBuyItem(nil, "Weapons", class, 1, false)
			end, nil, math.Round(price))
		end

		for class, item in SortedPairsByMemberValue(shop_ents, "name") do
			local price = McINV.Tax(item.price or 0)
			item.class = class
			McINV.InventoryItem(menu.list, item, INV_ENTITY, item, function(self)
				DarkRP.PlayerBuyItem(nil, "Entities", class, 1, false)
			end, nil, math.Round(price))
		end

		for class, item in SortedPairsByMemberValue(shop_craft, "name") do
			local price = McINV.Tax(item.price or 0)
			item.class = class
			McINV.InventoryItem(menu.list, item, "Stations", item, function(self)
				DarkRP.PlayerBuyItem(nil, "Stations", class, 1, false)
			end, nil, math.Round(price))
		end

		for class, item in SortedPairsByMemberValue(shop_food, "name") do
			local entt = McINV.GetItem(INV_FOOD, class)
			item.class = class
			local price = McINV.Tax(entt.price or 0)
			McINV.InventoryItem(menu.list, entt, INV_FOOD, item, function(self)
				DarkRP.PlayerBuyItem(nil, "Food", class, 1, false)
			end, nil, math.Round(price))
		end

		for class, item in SortedPairsByMemberValue(shop_junk, "name") do
			local entt = McINV.GetItem(INV_JUNK, class)
			item.class = class
			local price = McINV.Tax(entt.price or 0)
			McINV.InventoryItem(menu.list, entt, INV_JUNK, item, function(self)
				DarkRP.PlayerBuyItem(nil, "Junk", class, 1, false)
			end, nil, math.Round(price))
		end

	end

	McINV.StorageUI.Update()
end

hook.Add( "PlayerBindPress", "StorageUI.PlayerBindPress", function()
	if IsValid(McINV.StorageUI) then
		return true
	end
end )

function McINV.AddCustomItem(e, type, class, data, bank)
	if McINV.DarkRPTypes[type] then type = McINV.DarkRPTypes[type] end

	local item = table.Copy(data)

	item.class = class
	item.dt = {
		eclass = class
	}

	if type == "Stations" then
		type = INV_ENTITY
		item.class = "spawned_shipment"
		item.dt.ename = data.name
		item.dt.DeployModel = data.model
		item.model = "models/props_junk/cardboard_box002a.mdl"
	end

	if data.uses then
		item.dt.uses = data.uses
		item.weight = data.uses * data.weight + (data.conwht or 0)
	end

	if data.btime then
		item.mt = os.time() + data.btime
	end

	if type == INV_AMMO then
		item.model = "models/props_lab/box01a.mdl"
		item.material = "cityrp/labs"
		item.dt.Ammo = data.sell_empty and 0 or data.ammo
		item.dt.eclass = class
		item.dt.ename = data.name
		item.dt.mmodel = data.model or ""

		if data.bul and data.ammo and not data.sell_empty then
			item.weight = data.weight + math.Round(data.ammo * data.bul, 2)
		end
	end

	return item
end