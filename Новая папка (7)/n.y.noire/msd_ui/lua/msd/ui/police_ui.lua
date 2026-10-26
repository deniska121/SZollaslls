--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/police_ui.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local LoadoutUI = {}
loadout_weapons = loadout_weapons or {}
given_weapons = given_weapons or {}

local colors = {
	["bg"] = Color(0, 0, 0, 100),
	["bg_light"] = Color(217, 200, 255, 7),
	["bg_main"] = Color(50, 50, 50, 150),
}

local equipment_id = {
	[1] = {"Тяжелое оружие", "PrimaryWeps", "primary"},
	[2] = {"Пистолет", "SecondaryWeps", "secondary"},
	[3] = {"Снаряжение", "SidearmWeps", "sidearm"},
	[4] = {"Снаряжение", "Gear1", "gear1"},
	[5] = {"Экипировка", "Gear2", "gear2"},
	[6] = {"Снаряжение", "Gear3", "gear3"},
}

function LoadoutUI.BigButton(parent, x, y, w, h, text, icon, func, text2, tr, color, func2)

	local pnl = vgui.Create("DPanel")
	if x and y then
		pnl:SetParent(parent)
		pnl:SetPos(x, y)
	end
	if x == "static" then
		pnl.StaticScale = { w = w, fixed_h = h, minw = 150, minh = h }
	else
		pnl:SetSize(w, h)
	end
	pnl.Paint = function()
	end

	pnl.SetCustomModel = function(mdl) end

	local button = vgui.Create("DButton", pnl)
	button:SetText("")
	button.alpha = 0
	button.color_idle = color_white
	button.text = text
	button.text2 = text2
	button.Paint = function(self, wd, hd)
		if self.hover and not self.disable then
			self.alpha = Lerp(FrameTime() * 7, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 7, self.alpha, 0)
		end

		MSDX.Draw(0, 0, 0, wd, hd, MSD.Theme["d"])

		-- if not pnl.Iconmdl then
		local is = pnl.mat and 148 or 48

		if pnl.mat and isstring(pnl.mat) then
			pnl.cachemat = pnl.mat
		end

		if pnl.cachemat then
			pnl.mat =  MSD.ImgLib.GetMaterial(pnl.cachemat)
		end

		MSD.DrawTexturedRect(math.max(hd / 2 - is / 2, 25), hd / 2 - is / 2, is, is, pnl.mat or icon, self.color_idle)
		-- else
		MSDX.Draw(0, 0, 0, wd * self.alpha, hd, MSD.Theme["l"])
		--end
		draw.DrawText(button.text, "MSDFont.28", wd / 3, hd / 2 - 16, MSD.ColorAlpha(self.color_idle, 255 - self.alpha * 255), TEXT_ALIGN_LEFT, 1)
		if self.text2 then draw.DrawText(self.text2, "MSDFont.22", wd / 3, hd / 2 + 16, self.color_idle, TEXT_ALIGN_LEFT) end

		if self.alpha > 0.01 then
			draw.DrawText(button.text, "MSDFont.28", wd / 3, hd / 2 - 16, MSD.ColorAlpha(color or MSD.Config.MainColor["p"], self.alpha * 255), TEXT_ALIGN_LEFT, 1)
		end
	end
	button.OnCursorEntered = function(self) self.hover = true end
	button.OnCursorExited = function(self) self.hover = false end
	button.DoClick = function(self) if self.disable then return end func(self) end
	button.DoRightClick = function(self) if self.disable or not func2 then return end func2(self) end
	pnl.button = button
	function pnl:PerformLayout()
		self.button:StretchToParent( 0, 0, 0, 0 )
	end
	if not x or not y then parent:AddItem(pnl) end
	return pnl
end

function LoadoutUI.Create()
	if IsValid(LoadoutUI.Menu) then
		LoadoutUI.Menu:Close()

		return
	end

	local inArmorry = DarkRP.InsideArmory(LocalPlayer())

	local SW, SH = ScrW(), ScrH()

	LoadoutUI.Menu = vgui.Create("MSDSimpleFrame")
	LoadoutUI.Menu:SetSize(SW, SH)
	LoadoutUI.Menu:SetDraggable(false)
	LoadoutUI.Menu:Center()
	LoadoutUI.Menu:MakePopup()
	LoadoutUI.Menu:SetAlpha(1)
	LoadoutUI.Menu:AlphaTo(255, 0.3)

	LoadoutUI.Menu.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
		MSDX.Draw(0, 0, 0, w, h, colors["bg_light"])

		MSDX.Draw(0, 0, 0, w, 50, MSD.Theme.l)
		draw.DrawText("Разгрузка", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
	end

	local menu = LoadoutUI.Menu

	MSD.CloseButtonIcon(menu, SW - 160, 5, 150, 40, "Закрыть", function()
		LoadoutUI.Menu:Close()
	end)

	local rank = MRS.GetNWdata(LocalPlayer(), "Rank") or 1
	local mpw = SW / 3 - 15
	menu.player = vgui.Create("DModelPanel", menu)
	menu.player:SetSize(mpw, SH - 50)
	menu.player:SetPos(10 + mpw, 50)
	menu.player:SetFOV(28)
	menu.player:SetCamPos(Vector(0, 0, 0))
	menu.player:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
	menu.player:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
	menu.player:SetAmbientLight(Vector(-64, -64, -64))
	menu.player:SetAnimated(true)
	menu.player.Angles = Angle(0, 0, 0)
	menu.player:SetLookAt(Vector(-100, 0, -22))
	menu.player.UpdatePM = function(delay)
		if delay then
			timer.Simple(delay, function()
				if not IsValid(menu) then return end
				menu.player.UpdatePM()
			end)
		end
		menu.player:SetModel(LocalPlayer():GetModel() or "models/player/arctic.mdl")
		menu.player.Entity:ResetSequence("menu_combine")
		menu.player.Entity:SetPos(Vector(-100, 0, -61))

		for _, v in pairs(LocalPlayer():GetBodyGroups()) do
			menu.player.Entity:SetBodygroup(v.id, LocalPlayer():GetBodygroup(v.id))
		end

		for id, skin in pairs(LocalPlayer():GetMaterials()) do
			menu.player.Entity:SetSubMaterial(id - 1, LocalPlayer():GetSubMaterial(id - 1))
		end
	end
	menu.player.UpdatePM()
	menu.player:SetCursor( "arrow" )
	function menu.player:LayoutEntity(ent)
		if (self.bAnimated) then
			self:RunAnimation()
		end
		ent:SetAngles(self.Angles)
	end
	function menu.player:Think()
		local ent_color = self:GetColor()
		ent_color.a = menu:GetAlpha()
	end

	menu.loadout = vgui.Create("MSDPanelList", menu)
	menu.loadout:SetSize(mpw, SH - 70)
	menu.loadout:SetPos(5, 70)
	menu.loadout:EnableVerticalScrollbar()
	menu.loadout:EnableHorizontal(true)
	menu.loadout:SetSpacing(2)
	menu.loadout.IgnoreVbar = true
	menu.loadout.Populate = function()

		given_weapons = {
			primary = false,
			secondary = false,
			sidearm = false
		}

		for id, _ in pairs(DarkRP.Police.PrimaryWeps) do
			if LocalPlayer():HasWeapon(id) then
				given_weapons.primary = id
				break
			end
		end
		for id, _ in pairs(DarkRP.Police.SecondaryWeps) do
			if LocalPlayer():HasWeapon(id) then
				given_weapons.secondary = id
				break
			end
		end
		for id, _ in pairs(DarkRP.Police.SidearmWeps) do
			if LocalPlayer():HasWeapon(id) then
				given_weapons.sidearm = id
				break
			end
		end
		for id, _ in pairs(DarkRP.Police.Gear1) do
			if LocalPlayer():HasWeapon(id) then
				given_weapons.gear1 = id
				break
			end
		end

		menu.loadout:Clear()

		MSD.Header(menu.loadout, "Ваша разгрузка")

		if MRS.GetSData(nil, "exam_gun", 0) < 1 and rank < 5 then
			MSD.InfoTextF1(menu.loadout, "Выбор доступного снаряжения ограничен. Для разблокировки новых предметов экипировки необходимо пройти соответствующий экзамен.", menu.loadout:GetWide() - 5, "MSDFont.26", true)
		end

		if MRS.GetSData(nil, "exam_gun", 0) >= 2 or rank > 5 then
			local pnl = LoadoutUI.BigButton(menu.loadout, "static", nil, 1, 150, "Тяжелое оружие", inArmorry and MSD.Icons48.layers_plus or MSD.Icons48.cross, function()
				if not inArmorry then return end
				menu.buymenuOpen(1)
			end)
			if given_weapons.primary and DarkRP.Police.PrimaryWeps[given_weapons.primary] then
				pnl.mat = DarkRP.Police.PrimaryWeps[given_weapons.primary].Icon
				pnl.button.text = DarkRP.Police.PrimaryWeps[given_weapons.primary].Name
			end

			pnl = LoadoutUI.BigButton(menu.loadout, "static", nil, 1, 150, "Пистолет", inArmorry and MSD.Icons48.layers_plus or MSD.Icons48.cross, function()
				if not inArmorry then return end
				menu.buymenuOpen(2)
			end)
			if given_weapons.secondary and DarkRP.Police.SecondaryWeps[given_weapons.secondary] then
				pnl.mat = DarkRP.Police.SecondaryWeps[given_weapons.secondary].Icon
				pnl.button.text = DarkRP.Police.SecondaryWeps[given_weapons.secondary].Name
			end
		end

		if MRS.GetSData(nil, "exam_gun", 0) >= 1 or rank > 5 then
			pnl = LoadoutUI.BigButton(menu.loadout, "static", nil, 1, 150, "Снаряжение", MSD.Icons48.layers_plus, function()
				menu.buymenuOpen(3)
			end)
			if given_weapons.sidearm and DarkRP.Police.SidearmWeps[given_weapons.sidearm] then
				pnl.mat = DarkRP.Police.SidearmWeps[given_weapons.sidearm].Icon
				pnl.button.text = DarkRP.Police.SidearmWeps[given_weapons.sidearm].Name
			end

			pnl = LoadoutUI.BigButton(menu.loadout, "static", nil, 1, 150, "Снаряжение", MSD.Icons48.layers_plus, function()
				menu.buymenuOpen(4)
			end)
			if given_weapons.gear1 and DarkRP.Police.Gear1[given_weapons.gear1] then
				pnl.mat = DarkRP.Police.Gear1[given_weapons.gear1].Icon
				pnl.button.text = DarkRP.Police.Gear1[given_weapons.gear1].Name
			end

			LoadoutUI.BigButton(menu.loadout, "static", nil, 2, 150, "Амуниция", inArmorry and MSD.Icons48.ammo or MSD.Icons48.cross, function()
				if not inArmorry then return end
				net.Start("LoadoutGiveAmmo")
				net.SendToServer()
			end, nil, true)
		end

		LoadoutUI.BigButton(menu.loadout, "static", nil, (MRS.GetSData(nil, "exam_gun", 0) >= 1 or rank > 5) and 2 or 1, 150, "Другое", MSD.Icons48.cuffs, function()
			menu.buymenuOpen(5)
		end, nil, true)

	end

	function menu.buymenuOpen(sid)
		if IsValid(menu.buymenu) then
			menu.buymenu.lastsid = sid
			menu.buymenu.Populate(sid)
			return
		end

		menu.player:MoveTo(SW - mpw - 5, 70, 0.3)

		menu.buymenu = vgui.Create("MSDPanelList", menu)
		menu.buymenu:SetSize(mpw, SH - 70)
		menu.buymenu:SetPos(10 + mpw, 70)
		menu.buymenu:EnableVerticalScrollbar()
		menu.buymenu:EnableHorizontal(true)
		menu.buymenu:SetSpacing(2)
		menu.buymenu:SetAlpha(1)
		menu.buymenu.IgnoreVbar = true
		menu.buymenu.lastsid = sid
		menu.buymenu.Populate = function(gid)
			menu.buymenu:Clear()

			if not gid then gid = menu.buymenu.lastsid end
			MSD.Header(menu.buymenu, equipment_id[gid][1])

			if gid == 5 then
				LoadoutUI.BigButton(menu.buymenu, "static", nil, 1, 150, "Бронежилет", MSD.Icons48.armor, function()
					menu.player.UpdatePM(1)
					net.Start("LoadoutArmor")
						net.WriteUInt(0, 2)
					net.SendToServer()
				end)

				LoadoutUI.BigButton(menu.buymenu, "static", nil, 1, 150, "Наручники", MSD.Icons48.cuffs, function()
					net.Start("LoadoutGive")
						net.WriteString("cuffs")
						net.WriteString("")
					net.SendToServer()
				end)

				if LocalPlayer():Team() == 6 then return end

				-- LoadoutUI.BigButton(menu.buymenu, "static", nil, 1, 150, "Куртка", MSD.Icons48.briefcase, function()
				-- 	menu.player.UpdatePM(1)
				-- 	net.Start("LoadoutArmor")
				-- 		net.WriteUInt(1, 2)
				-- 	net.SendToServer()
				-- end)

				if rank > 7 then
					LoadoutUI.BigButton(menu.buymenu, "static", nil, 1, 150, "Пиджак", MSD.Icons48.briefcase, function()
						menu.player.UpdatePM(1)
						net.Start("LoadoutArmor")
							net.WriteUInt(2, 2)
						net.SendToServer()
					end)
				end

				return
			end

			for k,v in pairs(DarkRP.Police[equipment_id[gid][2]]) do
				if v.AllowedTeams and not v.AllowedTeams[LocalPlayer():Team()] then continue end
				if not table.HasValue(given_weapons, k) and v.Level and Slawer.Mayor:GetUpgradeLevel(v.ML or 1) < v.Level then continue end
				if v.SHCheck and not v.SHCheck(LocalPlayer()) then continue end

				pnl = LoadoutUI.BigButton(menu.buymenu, "static", nil, 1, 150, v.Name, MSD.Icons48.swap, function()
					net.Start("LoadoutGive")
					net.WriteString(equipment_id[gid][2])
					net.WriteString(k)
					net.SendToServer()
				end, table.HasValue(given_weapons, k) and "Вернуть" or ((v.Price > 0 and rank < 2) and "Залог $" .. v.Price or ""))
				pnl.mat = v.Icon
			end

		end

		menu.buymenu.BuyStuff = function(gid)
			menu.buymenu:Clear()

			MSD.Header(menu.buymenu, equipment_id[gid][1])

			for k,v in pairs(DarkRP.Police[equipment_id[gid][2]]) do
				if v.AllowedTeams and not v.AllowedTeams[LocalPlayer():Team()] then continue end
				if table.HasValue(loadout_weapons, k) then continue end

				pnl = LoadoutUI.BigButton(menu.buymenu, "static", nil, 1, 150, v.Name, MSD.Icons48.swap, function()
					net.Start("JLoadOut_BuyItem")
					net.WriteString(k)
					net.WriteInt(gid, 8)
					net.SendToServer()
				end, v.Price .. "$", not LocalPlayer():canAfford(v.Price) and Color(255,0,0) or false)
				pnl.mat = v.Icon
			end
		end

		menu.buymenu:AlphaTo(255, 0.3, 0.1)
		menu.buymenu.Populate(sid)
	end

	menu.loadout:Populate()

	function LoadoutUI.Menu.Update()
		if IsValid(menu.loadout) then
			menu.loadout.Populate()
		end
		if IsValid(menu.buymenu) then
			menu.buymenu.Populate()
		end
	end
end

net.Receive("LoadoutCliebt", function()
	if IsValid(LoadoutUI.Menu) then LoadoutUI.Menu.Update() end
end)

MSD.Loadout = LoadoutUI