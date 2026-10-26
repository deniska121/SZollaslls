--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/docs/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local extra_license = {
	[9] = {"Лицензия оружейного мастера", [[
Данный документ подтверждает подлинность лицензирования указанного ниже лица на контрактной основе в качестве профессии 'Оружейный мастер'.

На время действия контракта, указанное лицо имеет право на:
• производство оружия; 
• владение оружием в целях продажи без регистрации на имя лицензиата - только на имя магазина;
• обращение с оружием, не согласованным с муниципальным оружейным положением, с целью выполнения федерального контракта.

Лицензиат обязывается регистрировать продаваемое оружие на имя покупателя через запрос в базу данных NLR.
]]},
	[17] = {"Лицензия фармацевта", [[
Данный документ подтверждает подлинность лицензирования указанного ниже лица на контрактной основе в качестве профессии 'Фармацевт'.

На время действия контракта, указанное лицо имеет право на:
• производство и продажу общеизвестных медицинских изделий;
• оборот контролируемых субстанций под строгим надзором с внутренним учётом каждого миллиграмма курируемых веществ;
• обслуживание клиентов медицинских центров согласно выписанному рецепту.
]]}
}

local red = Color(228, 17, 17)

local colors = {
	[1] = Color(0, 0, 0, 200),
	[2] = Color(0, 0, 0, 180),
	[3] = Color(0, 0, 0, 225),
}

local tycolor = {
	["header"] = colors[1],
	["subheader"] = colors[1],
	["text"] = colors[2],
	["subtext"] = colors[2],
}

local tyfont = {
	["header"] = "McPhone.PhoneBook",
	["subheader"] = "MSDFontB.22",
	["text"] = "MSDFont.22",
	["subtext"] = "MSDFont.16",
}

local pass = Material("gmodla/NLR.png", "smooth")

local idcards = {
	[0] = Material("gmodla/NLR_ARMY.png", "smooth"),
	[1] = Material("gmodla/NLR_PD.png", "smooth"),
	[2] = Material("gmodla/NLR_FD.png", "smooth"),
	[3] = Material("vgui/page.png", "smooth"),
	[4] = Material("vgui/stamp.png", "smooth"),
	[5] = Material("gmodla/NLR_FBI.png", "smooth"),
	[6] = Material("vgui/mcphone/page.png", "smooth"),
	[7] = Material("gmodla/NLR_LYR.png", "smooth"),
}

local idcard_over = Material("gmodla/NLR_PD_Over.png", "smooth")
local pcn = Color(31, 31, 50)

function DarkRP.OpenPassport(ply)
	if IsValid(DarkRP.Passport) then
		DarkRP.Passport:Remove()
	end

	local w, h = 530, 321
	local id = DarkRP.PassId(ply)
	local ser = "TYPE: " .. string.sub(ply:AccountID(), 3, 4)
	local pn = string.Explode(" ", ply:FullName())
	local name = string.upper(pn[1])
	local sur = string.upper(pn[2])
	local gen = ply:getDarkRPVar("gender") == "female" and "ЖЕН." or "МУЖ."
	local panel = vgui.Create("MSDSimpleFrame")
	panel:SetSize(w, h)
	panel:SetPos(50, 50)
	DarkRP.Passport = panel
	panel:SetDraggable(true)

	panel.clsBut = MSD.IconButton(panel, MSD.Icons48.close_thick, panel:GetWide() - 25, 10, 25, red, color_white, function()
		panel:Remove()
	end)

	panel.clsBut = MSD.IconButton(panel, MSD.Icons48.copy, panel:GetWide() - 25, 40, 25, MSD.Config.MainColor.p, color_white, function()
		SetClipboardText(id)
	end)

	panel.Think = function(self)
		if not LocalPlayer():IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) or input.IsKeyDown(KEY_DELETE) then
			self:Close()
		end
	end

	panel.Paint = function(self, wd, hd)
		wd = wd - 30
		MSD.DrawTexturedRect(wd + 6, 11, 25, 25, MSD.Icons48.close_thick, color_black)
		MSD.DrawTexturedRect(wd + 6, 41, 25, 25, MSD.Icons48.copy, color_black)
		MSD.DrawTexturedRect(0, 0, wd, hd, pass, color_white)
		draw.DrawText("ID: " .. id, "MSDFont.25", 26, 50, color_white, TEXT_ALIGN_LEFT)
		draw.DrawText(ser, "MSDFont.25", 26, 75, color_white, TEXT_ALIGN_LEFT)
		local sp = draw.SimpleText("Фамилия: ", "MSDFontB.25", 26, 115, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(sur, "Moster.28", 26 + sp, 115, pcn, TEXT_ALIGN_LEFT)
		sp = draw.SimpleText("Имя: ", "MSDFontB.25", 26, 140, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(name, "Moster.28", 26 + sp, 140, pcn, TEXT_ALIGN_LEFT)
		sp = draw.SimpleText("Пол: ", "MSDFontB.25", 26, 165, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(gen, "Moster.28", 26 + sp, 165, pcn, TEXT_ALIGN_LEFT)
		draw.SimpleText(ply:getDarkRPVar("age") or "", "Moster.28", 26, 190, pcn, TEXT_ALIGN_LEFT)
		--draw.DrawText(st and "Лиц. на " .. st or "НЕТ", "Moster.28", 26, 215, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(id, "Moster.28", 401, 250, pcn, TEXT_ALIGN_CENTER)
	end

	local icon = vgui.Create("DModelPanel", panel)
	icon:SetPos(335, 81)
	icon:SetSize(132, 164)
	icon:SetFOV(8)
	icon:SetModel(ply:GetModel())
	icon.Entity:ResetSequence(0)
	icon.Entity:SetPos(Vector(0, 0, -26))
	icon.Entity:SetAngles(Angle(0, 45, 0))

	for _, v in pairs(ply:GetBodyGroups()) do
		icon.Entity:SetBodygroup(v.id, ply:GetBodygroup(v.id))
	end

	for k, skin in pairs(ply:GetMaterials()) do
		icon.Entity:SetSubMaterial(k - 1, ply:GetSubMaterial(k - 1))
	end

	function icon:LayoutEntity(ent)
		return
	end

	if not extra_license[ply:Team()] then return end
	local ltable = extra_license[ply:Team()]
	local ltext = MSD.TextWrap(ltable[2], "MSDFont.22", 370)
	local license = vgui.Create("MSDSimpleFrame")
	license:SetSize(400, 600)
	license:SetPos(150, 350)

	license.Paint = function(self, wd, hd)
		MSD.DrawTexturedRect(0, 0, wd, hd, idcards[3], color_white)
		draw.SimpleText(ltable[1], "McPhone.PhoneBook", 25, 35, colors[1], TEXT_ALIGN_LEFT)
		draw.DrawText(ltext, "MSDFont.22", 25, 77, colors[1], TEXT_ALIGN_LEFT)
		draw.DrawText("Лицензиат: " .. name .. " " .. sur, "MSDFontB.22", 25, 480, colors[1], TEXT_ALIGN_LEFT)
		draw.DrawText("Паспорт " .. id, "MSDFontB.22", 25, 505, colors[1], TEXT_ALIGN_LEFT)
		draw.DrawText("Контракт заключён с: World Corp", "MSDFontB.22", 25, 530, colors[2], TEXT_ALIGN_LEFT)
		draw.DrawText("Документ не является разрешением на бизнес.\nНарушение условий контракта аннулирует лицензию.", "MSDFont.16", 25, hd - 46, colors[2], TEXT_ALIGN_LEFT)
		MSD.DrawTexturedRect(0, 0, wd, hd, idcards[4], color_white)
	end

	license.clsBut = MSD.IconButton(license, MSD.Icons48.close_thick, license:GetWide() - 70, 10, 25, red, MSD.Config.MainColor.p, function()
		license:Remove()
	end)
end

function DarkRP.OpenExtraLicense(url, name, sur, gen, id, id2, wep)
	local ltable = {}
	local page = idcards[3]

	http.Fetch(url, function(body, size, headers, code)
		ltable = util.JSONToTable(body)

		for _, v in pairs(ltable) do
			if v.type == "ypage" then
				page = idcards[6]
			end

			if v.color then
				v.color = Color(v.color[1], v.color[2], v.color[3])
			else
				v.color = tycolor[v.type] or colors[1]
			end

			v.font = v.font or tyfont[v.type]

			if v.format then
				v.cont = string.Replace(v.cont, "%name%", name)
				v.cont = string.Replace(v.cont, "%sur%", sur)
				v.cont = string.Replace(v.cont, "%id%", id)
				v.cont = string.Replace(v.cont, "%id2%", id2)
				v.cont = string.Replace(v.cont, "%gen%", gen)
				v.cont = string.Replace(v.cont, "%wep%", wep)
				v.cont, v.sw, v.sh = MSD.TextWrap(v.cont, v.font or "MSDFontB.22", 370)
			end

			if tyfont[v.type] and not v.sh then
				surface.SetFont(v.font or "MSDFontB.22")
				v.sw, v.sh = surface.GetTextSize(v.cont)
			end

			if v.type == "stamp" then
				if not v.W then
					v.W = 100
				end

				if not v.H then
					v.H = 100
				end

				if not v.X then
					v.X = 310
				end

				if not v.Y then
					v.Y = 530
				end

				if not v.R then
					v.R = 50
				end
			end
		end
	end)

	local license = vgui.Create("MSDSimpleFrame")
	license:SetSize(400, 600)
	license:SetPos(510, 390)

	license.Paint = function(self, wd, hd)
		MSD.DrawTexturedRect(0, 0, wd, hd, page, color_white)
		local th = 35

		for _, v in pairs(ltable) do
			if tyfont[v.type] then
				draw.DrawText(v.cont, v.font, 25, th, v.color, TEXT_ALIGN_LEFT)
				th = (v.sh or 0) + th
			end

			if v.type == "stamp" then
				MSD.DrawTexturedRectRotated(v.R, v.X, v.Y, v.W, v.H, MSD.ImgLib.GetMaterial(v.cont), v.color)
			end
		end
	end

	license.clsBut = MSD.IconButton(license, MSD.Icons48.close_thick, license:GetWide() - 70, 10, 25, red, MSD.Config.MainColor.p, function()
		license:Remove()
	end)
end

function DarkRP.LoadDock(data)
	if data.type == "extra" then
		DarkRP.OpenExtraLicense(data.url, data.name, data.sname, data.gender, data.id, data.id2, data.wep)
	end
end

local law = [[Защита народа является наивысшим приоритетом адвокатской палаты штата.
Только активные члены палаты имеют право на юридическую практику.]]

local ids = {
	["NYPD"] = function(self, w, h, wd, hd, ply, id, name, sur, ri, group, rank)
		MSD.DrawTexturedRect(0, 0, wd, hd, idcards[1], color_white)
		--MSD.DrawTexturedRect(71, 170, 32, 32, ri.icon, color_white)
		MSD.DrawTexturedRect(24, 37, 132, 132, MSD.ImgLib.GetMaterial(MRS.Ranks[group].icon), color_white)
		draw.DrawText("NYPD", "MSDFontB.29", 90, 175, MSD.Text.d, TEXT_ALIGN_CENTER)
		draw.DrawText("ID: " .. string.sub(id, 1, 5) .. "293", "MSDFontB.25", 20, h - 83, pcn, TEXT_ALIGN_LEFT)
		local rankn, _, ht = MSD.TextWrap(utf8.upper(ri.name), "MSDFontB.29", wd - 40)
		MSD.ShadowText(rankn, "MSDFontB.29", 20, 215, pcn, TEXT_ALIGN_LEFT, 1, MSD.Theme.l)
		draw.DrawText(sur, "MSDFontB.25", 20, 215 + ht, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(name, "MSDFontB.25", 20, 238 + ht, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText("ЗНАЧОК: " .. string.sub(id, 2, 5), "MSDFontB.25", 20, 335, pcn, TEXT_ALIGN_LEFT)
	end,
	["FDNY"] = function(self, w, h, wd, hd, ply, id, name, sur, ri, group, rank)
		MSD.DrawTexturedRect(0, 0, wd, hd, idcards[2], color_white)
		MSD.DrawTexturedRect(24, 37, 132, 132, MSD.ImgLib.GetMaterial(MRS.Ranks[group].icon), color_white)
		draw.DrawText("FDNY", "MSDFontB.29", 90, 175, MSD.Text.d, TEXT_ALIGN_CENTER)
		draw.DrawText("ID: 96" .. string.sub(ply:SteamID64(), 12, 17), "MSDFontB.25", 20, h - 83, pcn, TEXT_ALIGN_LEFT)
		local rankn, _, ht = MSD.TextWrap(utf8.upper(ri.name), "MSDFontB.29", wd - 40)
		MSD.ShadowText(rankn, "MSDFontB.29", 20, 215, pcn, TEXT_ALIGN_LEFT, 1, MSD.Theme.l)
		draw.DrawText(sur, "MSDFontB.25", 20, 215 + ht, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(name, "MSDFontB.25", 20, 238 + ht, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText("ЗНАЧОК: " .. string.sub(id, 5, 6), "MSDFontB.25", 20, 335, pcn, TEXT_ALIGN_LEFT)
	end,
	["FBI"] = function(self, w, h, wd, hd, ply, id, name, sur, ri, group, rank)
		MSD.DrawTexturedRect(0, 0, wd, hd, idcards[5], color_white)
		draw.DrawText("ID: " .. string.sub(id, 2, 5), "MSDFontB.25", w - 85, 50, MSD.Text.l, TEXT_ALIGN_RIGHT)
		draw.DrawText(ri.srt_name, "MSDFontB.25", 26, 115, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(utf8.upper(ri.name), "MSDFontB.29", 26, 165, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(sur, "MSDFontB.29", 26, 190, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(name, "MSDFontB.29", 26, 215, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(string.sub(id, 3, 5) .. ":" .. string.sub(ply:SteamID64(), 10, 17), "MSDFontB.25", 26, 250, pcn, TEXT_ALIGN_LEFT)
	end,
	["NYC LD"] = function(self, w, h, wd, hd, ply, id, name, sur, ri, group, rank)
		if not self.rtext then
			self.rtext = MSD.TextWrap(utf8.upper(ri.name), "MSDFont.22", 220)
		end

		MSD.DrawTexturedRect(0, 0, wd, hd, idcards[7], color_white)
		draw.DrawText("NEW YORK STATE BAR", "MSDFontB.32", 25, 20, color_white, TEXT_ALIGN_LEFT)
		draw.DrawText(self.rtext or "", "MSDFontB.25", 26, 115, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(string.sub(id, 3, 5) .. ":" .. string.sub(ply:SteamID64(), 10, 17), "MSDFontB.25", 26, 75, color_white, TEXT_ALIGN_LEFT)
		draw.DrawText(sur, "MSDFontB.29", 26, 165, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(name, "MSDFontB.29", 26, 190, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(name, "MSDFontB.29", 26, 190, pcn, TEXT_ALIGN_LEFT)
		draw.DrawText(law, "MSDFont.16", 20, 245, pcn, TEXT_ALIGN_LEFT)
	end,
	["other"] = function(self, w, h, wd, hd, ply, id, name, sur, ri, group, rank)
		MSD.DrawTexturedRect(0, 0, wd, hd, idcards[0], color_white)
		MSD.DrawTexturedRect(24, 40, 132, 132, MSD.ImgLib.GetMaterial(MRS.Ranks[group].icon), color_white)
		draw.DrawText("ID: " .. string.sub(id, 2, 5) .. "2903", "MSDFontB.25", 20, h - 50, MSD.Text.n, TEXT_ALIGN_LEFT)
		local rankn, _, ht = MSD.TextWrap(utf8.upper(ri.name), "MSDFontB.29", wd - 40)
		MSD.ShadowText(rankn, "MSDFontB.29", 20, 215, MSD.Text.d, TEXT_ALIGN_LEFT, 1, MSD.Theme.l)
		draw.DrawText(sur, "MSDFontB.25", 20, 215 + ht, MSD.Text.d, TEXT_ALIGN_LEFT)
		draw.DrawText(name, "MSDFontB.25", 20, 238 + ht, MSD.Text.d, TEXT_ALIGN_LEFT)
		draw.DrawText(string.sub(id, 3, 5) .. ":" .. string.sub(ply:SteamID64(), 10, 17), "MSDFont.25", 20, 335, MSD.Text.d, TEXT_ALIGN_LEFT)
	end,
}

local custom_sizes = {
	["FBI"] = {500, 321, 335, 81, 132, 164},
	["NYC LD"] = {500, 321, 335, 81, 132, 164}
}

function DarkRP.OpenPDid(ply)
	if IsValid(DarkRP.Passport) then
		DarkRP.Passport:Remove()
	end

	local group = MRS.GetNWdata(ply, "Group")
	local rank = MRS.GetNWdata(ply, "Rank")
	if not MRS.Ranks[group] or not MRS.Ranks[group].ranks[rank] then return end
	local ri = MRS.Ranks[group].ranks[rank]
	local w, h = 321, 500

	if custom_sizes[group] then
		w, h = custom_sizes[group][1], custom_sizes[group][2]
	end

	local id = ply:AccountID()
	local pn = string.Explode(" ", ply:FullName())
	local name = string.upper(pn[1])
	local sur = string.upper(pn[2])
	local panel = vgui.Create("MSDSimpleFrame")
	panel:SetSize(w, h)
	panel:SetPos(50, 50)
	DarkRP.Passport = panel
	panel:SetDraggable(true)

	panel.Think = function(self)
		if not LocalPlayer():IsUnrestrained() or input.IsKeyDown(KEY_ESCAPE) or input.IsKeyDown(KEY_DELETE) then
			self:Close()
		end
	end

	panel.Paint = function(self, wd, hd)
		if ids[group] then
			ids[group](self, w, h, wd, hd, ply, id, name, sur, ri, group, rank)
		else
			ids["other"](self, w, h, wd, hd, ply, id, name, sur, ri, group, rank)
		end
	end

	local icon = vgui.Create("DModelPanel", panel)

	if custom_sizes[group] then
		icon:SetPos(custom_sizes[group][3], custom_sizes[group][4])
		icon:SetSize(custom_sizes[group][5], custom_sizes[group][6])
	else
		icon:SetPos(167, 38)
		icon:SetSize(131, 164)
	end

	icon:SetFOV(8)
	icon:SetModel(ply:GetModel())
	icon.Entity:ResetSequence(0)
	icon.Entity:SetPos(Vector(0, 0, -26))
	icon.Entity:SetAngles(Angle(0, 45, 0))

	for _, v in pairs(ply:GetBodyGroups()) do
		icon.Entity:SetBodygroup(v.id, ply:GetBodygroup(v.id))
	end

	for k, skin in pairs(ply:GetMaterials()) do
		icon.Entity:SetSubMaterial(k - 1, ply:GetSubMaterial(k - 1))
	end

	function icon:LayoutEntity(ent)
		return
	end

	local over = vgui.Create("DPanel", panel)
	over:SetSize(w, h)
	over:SetPos(0, 0)

	over.Paint = function(self, wd, hd)
		if custom_sizes[group] then return end
		MSD.DrawTexturedRect(0, 0, wd, hd, idcard_over, color_white)
	end

	panel.clsBut = MSD.IconButton(over, MSD.Icons48.close_thick, panel:GetWide() - 32, 10, 25, red, MSD.Config.MainColor.p, function()
		panel:Remove()
	end)
end