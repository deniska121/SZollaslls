--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/cardealer/lua/mc_cardealer/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔══╗───╔╗╔══╗───────────╔╗──--
-- ║═╦╩╦╦╗║║║╔╗║╔═╦╦╦═╦╦═╦═╣╚╗─--
-- ║╔╣╬║╔╝║╚╣╠╣║║╬║╔╣╬╠╣╩╣═╣╔╣─--
-- ╚╝╚═╩╝─╚═╩╝╚╝║╔╩╝╚╦╝╠═╩═╩═╝─--
-- ─────────────╚╝───╚═╝───────--
-- ───── By Mactavish ─────────--
local ScrW, ScrH = ScrW, ScrH
local CarInventory = {}
local glass = Material("gmodla/glass.png", "smooth")
local color_b50 = Color(0,0,0,150)
local color_w50 = Color(255,255,255,150)

local function plate_color(col)
	if not col then col = "" end

	if McCD.Car and McCD.Car.rearplt and IsValid(McCD.Car.rearplt) then
		McCD.Car.rearplt:SetSubMaterial(0, col)
	end

	if McCD.Car and McCD.Car.frontplt and IsValid(McCD.Car.frontplt) then
		McCD.Car.frontplt:SetSubMaterial(0, col)
	end
end

function McCD.OpenLoadingScr()
	if McCD.LoadingScr then
		McCD.LoadingScr:Remove()
		McCD.LoadingScr = nil
	end

	McCD.LoadingScr = vgui.Create("MSDSimpleFrame")
	McCD.LoadingScr:SetDraggable(false)
	McCD.LoadingScr:SetAlpha(0)
	McCD.LoadingScr:MakePopup()
	McCD.LoadingScr:SetSize(ScrW(), ScrH())

	McCD.LoadingScr.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, color_black)
		draw.DrawText("Загрузка..", "MSDFont.24", w / 2, h / 2 - 7, color_white, TEXT_ALIGN_CENTER, 0)
	end

	McCD.LoadingScr.OnRemove = function()
		McCD.LoadingScr = nil
	end
end

local function CreateWheel(self, tbl, index, attachmentpos, height, fw)
	local fAng = self:GetAngles()
	local Up = self:GetUp()

	if fw then
		if istable(fw) then
			if fw[index] then
				fAng.r = fw[index]
			end
		else
			if index == 1 or index == 3 then
				fAng.p = 180
			end
		end
	else
		if index == 2 or index == 4 then
			fAng.r = 180
		end
	end

	if not McCD.Car.Weals then
		McCD.Car.Weals = {}
	end

	McCD.Car.Weals[index] = ClientsideModel((tbl.CustomWheelModel_R and (index == 3 or index == 4 or index == 5 or index == 6)) and tbl.CustomWheelModel_R or tbl.CustomWheelModel, RENDERGROUP_OPAQUE)
	McCD.Car.Weals[index]:SetPos(attachmentpos - Up * height)
	McCD.Car.Weals[index]:SetAngles(fAng)
	McCD.Car.Weals[index]:DrawModel()
end

local function setSubList(ent, lst)
	for k, v in pairs(lst) do
		ent:SetSubMaterial(k, v)
	end
end

local function clearSubList(ent)
	for k, v in pairs(ent:GetMaterials()) do
		ent:SetSubMaterial(k - 1, "")
	end
end

local function SetupWheelBones(ent, veh, tbl)
	local pass = 0

	if veh and veh.wheel_ang then
		pass = veh.wheel_ang
	end

	tbl = tbl.Members

	if tbl.CustomWheelPosFL then
		CreateWheel(ent, tbl, 1, ent:LocalToWorld(tbl.CustomWheelPosFL), pass, veh.fweels)
		CreateWheel(ent, tbl, 2, ent:LocalToWorld(tbl.CustomWheelPosFR), pass, veh.fweels)
		CreateWheel(ent, tbl, 3, ent:LocalToWorld(tbl.CustomWheelPosRL), pass, veh.fweels)
		CreateWheel(ent, tbl, 4, ent:LocalToWorld(tbl.CustomWheelPosRR), pass, veh.fweels)
	else
		ent:SetPoseParameter("vehicle_steer", 0)
		ent:SetPoseParameter("vehicle_wheel_fl_height", 0.5)
		ent:SetPoseParameter("vehicle_wheel_fr_height", 0.5)
		ent:SetPoseParameter("vehicle_wheel_rl_height", 0.5)
		ent:SetPoseParameter("vehicle_wheel_rr_height", 0.5)
	end
end

local function findSus(s)
	if s == 0 then
		return -1.2
	elseif s < 0 then
		return -2
	else
		return 0
	end
end

function McCD.ChangeSuspension(s, sveh, veh)
	if not McCD.Car then return end
	s = s or 0

	McCD.Car:SetPos(McCD.Config.TunePos + (sveh.garage_vect or Vector(0, 0, 0)))

	if McCD.Car.Weals then
		local carpos = McCD.Car:GetPos()
		carpos.z = carpos.z + findSus(s)
		McCD.Car:SetPos(carpos)

		for k, v in pairs(McCD.Car.Weals) do
			v:Remove()
		end

		SetupWheelBones(McCD.Car, sveh, veh)

		for k, v in pairs(McCD.Car.Weals) do
			local vp = v:GetPos()
			vp.z = vp.z - findSus(s)
			v:SetPos(vp)
		end
	end
end

local star = Material("gmodla/star2.png", "smooth")

function McCD.InfoTextIcon(parent, text_big, text, icon, cl1, per)
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 80,
		minw = 250,
		minh = 80
	}

	panel.Paint = function(self, w, h)
		if self.hidden then
			self.StaticScale.fixed_h = 1
			return
		end

		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
		MSD.DrawTexturedRectRotated( CurTime() * 25 % 360, 40, 40, 64, 64, star, MSD.ColorAlpha(HSLToColor(360 * math.abs(math.sin(CurTime())), 0.89, 0.57), 55))
		draw.DrawText(text_big, "MSDFont.28", 80, 5, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
		draw.SimpleTextOutlined(per .. "%", "MSDFontB.28", 40, 38, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)

		local ts, _, th = MSD.TextWrap(text, "MSDFont.20", w - 85)
		draw.DrawText(ts, "MSDFont.20", 80, 40, MSD.Text.l, TEXT_ALIGN_LEFT)

		self.StaticScale.fixed_h = math.max(80, th + 45)
	end

	parent:AddItem(panel)

	return panel
end

local function AttachLicensePlates(veh, sveh)
	if not sveh.uniqueid then return end

	if not McCD.Car.Extras then McCD.Car.Extras = {} end

	if veh.Members and veh.Members.LPMountFront then
		McCD.Car.frontplt = ClientsideModel("models/cityrp/license_nyc.mdl", RENDERGROUP_OPAQUE)
		McCD.Car.frontplt:SetAngles(McCD.Car:GetAngles())
		McCD.Car.frontplt:SetColor(color_black)

		if veh.Members.LPRotateFront then
			McCD.Car.frontplt:SetAngles(McCD.Car:GetAngles() + veh.Members.LPRotateFront)
		end

		McCD.Car.frontplt:SetPos(McCD.Car:LocalToWorld(veh.Members.LPMountFront))
		McCD.Car.frontplt:SetParent(McCD.Car)
		McCD.Car.frontplt:Spawn()

		REN.SetLicensePlateNumber(McCD.Car.frontplt, sveh.uniqueid)

		table.insert(McCD.Car.Extras, McCD.Car.frontplt)
	end

	if veh.Members and veh.Members.LPMountRear then
		McCD.Car.rearplt = ClientsideModel("models/cityrp/license_nyc.mdl", RENDERGROUP_OPAQUE)
		McCD.Car.rearplt:SetAngles(McCD.Car:GetAngles())
		local angles = McCD.Car.rearplt:GetAngles()
		if veh.Members.LPRotateRear then angles = angles + veh.Members.LPRotateRear end
		angles:RotateAroundAxis(McCD.Car.rearplt:GetUp(), 180)
		McCD.Car.rearplt:SetAngles(angles)
		McCD.Car.rearplt:SetColor(color_black)
		McCD.Car.rearplt:SetPos(McCD.Car:LocalToWorld(veh.Members.LPMountRear))
		McCD.Car.rearplt:SetParent(McCD.Car)
		McCD.Car.rearplt:Spawn()

		REN.SetLicensePlateNumber(McCD.Car.rearplt, sveh.uniqueid)
		table.insert(McCD.Car.Extras, McCD.Car.rearplt)
	end

	plate_color(McCD.Config.Plates[sveh.plates or 0][2])
end

function McCD.CarSpawn(veh, sveh, cveh)
	if McCD.Car and McCD.Car.Weals then
		for k, v in pairs(McCD.Car.Weals) do
			v:Remove()
		end
	end

	if McCD.Car and McCD.Car.Extras then
		for k, v in pairs(McCD.Car.Extras) do
			v:Remove()
		end
	end

	if McCD.Car then
		McCD.Car:Remove()
	end

	if McCD.CarSub then
		McCD.CarSub:Remove()
		McCD.CarSub = nil
	end

	McCD.Car = ents.CreateClientProp(veh.Model)
	McCD.Car:SetModel(veh.Model)
	McCD.Car:SetPos(McCD.Config.TunePos + sveh.garage_vect)
	McCD.Car:SetAngles(sveh.garage_angle)
	McCD.Car.ph = McCD.Car:GetPhysicsObject()
	if IsValid(McCD.Car.ph) then
		McCD.Car.ph:EnableMotion( false )
	end

	if sveh.color and sveh.color[1] then
		sveh.color = sveh.color[1]
	end

	McCD.Car:SetColor(sveh.color or color_white)
	McCD.Car:SetSkin(sveh.skin or 0)
	if cveh and cveh.skins_pack and sveh.skin_pack and cveh.skins_pack[sveh.skin_pack] then
		setSubList(McCD.Car, cveh.skins_pack[sveh.skin_pack])
	end
	if veh.Members and veh.Members.Attachments then
		if not McCD.Car.Extras then McCD.Car.Extras = {} end
		for k, v in pairs(veh.Members.Attachments) do
			McCD.Car.Extras[k] = ClientsideModel(v.model, RENDERGROUP_OPAQUE)
			McCD.Car.Extras[k]:SetPos(McCD.Car:LocalToWorld(v.pos))
			McCD.Car.Extras[k]:SetAngles(McCD.Car:LocalToWorldAngles(v.ang))
			McCD.Car.Extras[k]:SetParent(McCD.Car)
			McCD.Car.Extras[k]:Spawn()
			McCD.Car.Extras[k]:SetNoDraw(false)
			if v.useVehicleColor then
				McCD.Car.Extras[k]:SetColor(sveh.color)
			end

			if v.color then
				McCD.Car.Extras[k]:SetColor(v.color)
			end
		end
	end

	if sveh.bodygroups then
		for k, v in pairs(sveh.bodygroups) do
			McCD.Car:SetBodygroup(k, v)
		end
	end

	SetupWheelBones(McCD.Car, sveh, veh)


	McCD.ChangeSuspension(sveh.suspension, sveh, veh)

	AttachLicensePlates(veh, sveh)
end

local VehicleList = list.Get("simfphys_vehicles")
local car_table, car_class, car_spawnlist, car_shop, id_tuneprice, id_tunecred, last_car
local neon_glow = 0
local subcar_sync = 0

function McCD.OpenGarage(buy)
	DarkRP.UIEffects["blackScreen"]({false, true})
	if IsValid(McCD.Menu) then McCD.Menu:Close() end

	local SW, SH = ScrW(), ScrH()
	last_car = 1
	id_tuneprice = 0
	id_tunecred = 0

	if buy then
		local rdm = McCD.Config.Prew_car[math.random(#McCD.Config.Prew_car)]
		car_table = McCD.Cars[rdm]
		car_table.color = McCD.Config.CarColors[math.random(#McCD.Config.CarColors)][1]
		car_class = rdm
		car_shop = car_table
		car_spawnlist = VehicleList[car_class]
	else
		car_table = CarInventory[1]
		car_class = car_table.entity
		car_spawnlist = VehicleList[car_class]

		if McCD.Cars[car_class] then
			car_shop = McCD.Cars[car_class]
		end
	end

	car_table.garage_vect = (car_shop and car_shop.garage_vect) or car_table.garage_vect or Vector(0, 0, 0)
	car_table.garage_angle = (car_shop and car_shop.garage_angle) or car_table.garage_angle or Angle(0, -90, 0)

	McCD.CarSpawn(car_spawnlist, car_table, car_shop)

	local s_and = Angle(25, 180, 0)
	local mcam = {
		cang = s_and,
		nang = s_and,
		ang = s_and,
		sang = s_and,
		fpos = McCD.Config.TunePos,
		spos = 4,
		pdel = 0,
		dist = 100,
		ndist = 100,
		zoom = car_table.garage_zoom or 30,
	}
	local cta = Angle(0, -135, 0)
	local pos_to
	local function changeView(pos, zoom)
		if pos < 1 then
			pos = #McCD.Config.CamPoses
		elseif pos > #McCD.Config.CamPoses then
			pos = 1
		end

		mcam.spos = pos
		mcam.nang = McCD.Config.CamPoses[mcam.spos]
		mcam.sang = McCD.Config.CamPoses[mcam.spos]

		if zoom then
			if zoom < mcam.zoom then
				zoom = mcam.zoom
			elseif zoom > 100 then
				zoom = 100
			end

			mcam.ndist = zoom
		end
	end

	local main = vgui.Create("DFrame")
	main:SetSize(SW, SH)
	main:SetPos(0, 0)
	main:ShowCloseButton(false)
	main:SetDraggable(false)
	main:SetTitle("")
	main:MakePopup()
	McCD.Menu = main
	main.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, color_black)
		if not McCD.Car then return end
		if isangle(mcam.nang) then mcam.cang = LerpAngle(FrameTime() * 2, mcam.cang, mcam.nang) end
		mcam.dist = Lerp(FrameTime() * 2, mcam.dist, mcam.ndist)

		if isangle(mcam.nang) then
			local look_pos = McCD.Car:GetPos()
			mcam.fpos = look_pos + ((cta + mcam.cang):Up() * (50 + mcam.dist)) + ((cta + mcam.cang):Forward() * (0 + mcam.dist)) + ((cta + mcam.cang):Right() * (25 + mcam.dist))
		else
			mcam.fpos = mcam.nang
		end

		if not pos_to then pos_to = mcam.fpos end
		pos_to = LerpVector(FrameTime() * 3, pos_to, mcam.fpos)
		mcam.ang = LerpAngle(FrameTime() * 2, mcam.ang, mcam.sang)

		cam.Start2D()
		local CamData = {}
		CamData.angles = mcam.ang
		CamData.origin = pos_to
		CamData.drawviewmodel = false
		CamData.x = 0
		CamData.y = 0
		CamData.fov = 90
		CamData.drawhud = false
		CamData.w = ScrW()
		CamData.h = ScrH()
		render.RenderView(CamData)
		cam.End2D()

		MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.vignette, color_black)
		MSD.DrawTexturedRectOfRot(180, -9, 0, w + 10, 41, MSD.Materials.gradient, color_black)

		if car_table and car_table.wcitimer and car_table.wcitimer > os.time() then
			MSDX.Draw(0, 0, h / 2 - 60, w, 180, color_b50)
			MCR.Blur(self, 2, 2, 255, 0, h / 2 - 60, w, 180)
			draw.SimpleTextOutlined("Автомобиль потерян. Пожалуйста подождите, пока его вернут в гараж", "MSDFont.36", w / 2, h / 2, color_white, TEXT_ALIGN_CENTER, 1, 1, color_black)
		end
		draw.SimpleTextOutlined("↑ ↓ - Масштаб камеры     ← → - Вращать камеру", "MSDFont.16", w - 5, h - 25, DarkRP.Hud.Patern["armor"], TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, DarkRP.Hud.Patern["shadow"])
	end
	main.Think = function(self)
		if McCD.Car and neon_glow and neon_glow ~= 0 and McCD.Config.Neon[neon_glow] then
			McCD.Underglow(McCD.Car, McCD.Config.Neon[neon_glow][2])
		end

		if McCD.Car and McCD.Car.effect and McCD.Car.effectT > CurTime() then
			for i, w in pairs(McCD.Car.Weals) do
				local effectdata = EffectData()
				effectdata:SetOrigin(w:GetPos())
				effectdata:SetNormal(McCD.Car:GetForward() * -1)
				effectdata:SetMagnitude(0.7)
				effectdata:SetRadius(15)
				effectdata:SetStart(McCD.Car.effect)
				effectdata:SetEntity(NULL)
				util.Effect("simfphys_tiresmoke", effectdata)
			end
		end

		if McCD.Car and McCD.CarSub and subcar_sync < CurTime() then
			McCD.CarSub:SetMaterial(McCD.Car:GetMaterial())
			McCD.CarSub:SetColor(McCD.Car:GetColor())
			McCD.CarSub:SetSkin(McCD.Car:GetSkin())
			local bgroupstring = "0"

			for k2, v2 in pairs(McCD.Car:GetBodyGroups()) do
				bgroupstring = bgroupstring .. McCD.Car:GetBodygroup(k2)
			end

			McCD.CarSub:SetBodyGroups(bgroupstring)
			subcar_sync = CurTime() + 0.5
		end

		if input.IsKeyDown(KEY_RIGHT) and (not mcam.pdel or mcam.pdel < CurTime()) then
			mcam.pdel = CurTime() + 0.3
			mcam.spos = mcam.spos + 1

			if mcam.spos > #McCD.Config.CamPoses then
				mcam.spos = 1
			end

			if not isangle(mcam.nang) then mcam.spos = 5 end

			mcam.nang = McCD.Config.CamPoses[mcam.spos]
			mcam.sang = McCD.Config.CamPoses[mcam.spos]
		end

		if input.IsKeyDown(KEY_LEFT) and (not mcam.pdel or mcam.pdel < CurTime()) then
			mcam.pdel = CurTime() + 0.3
			mcam.spos = mcam.spos - 1

			if mcam.spos < 1 then
				mcam.spos = #McCD.Config.CamPoses
			end

			if not isangle(mcam.nang) then mcam.spos = 5 end

			mcam.nang = McCD.Config.CamPoses[mcam.spos]
			mcam.sang = McCD.Config.CamPoses[mcam.spos]
		end

		if input.IsKeyDown(KEY_UP) and (not mcam.pdel or mcam.pdel < CurTime()) then
			mcam.pdel = CurTime() + 0.1

			if mcam.ndist > mcam.zoom then
				mcam.ndist = mcam.ndist - 10
			end
		end

		if input.IsKeyDown(KEY_DOWN) and (not mcam.pdel or mcam.pdel < CurTime()) then
			mcam.pdel = CurTime() + 0.1

			if mcam.ndist < 130 then
				mcam.ndist = mcam.ndist + 10
			end
		end

		if input.IsKeyDown(KEY_TAB) and (not mcam.pdel or mcam.pdel < CurTime()) then
			mcam.pdel = CurTime() + 0.1
		end
	end
	main.OnClose = function()
		if McCD.Car and McCD.Car.Weals then
			for k, v in pairs(McCD.Car.Weals) do
				v:Remove()
			end
		end

		if McCD.Car and McCD.Car.Extras then
			for k, v in pairs(McCD.Car.Extras) do
				v:Remove()
			end
		end

		if McCD.Car then
			McCD.Car:Remove()
		end

		if McCD.CarSub then
			McCD.CarSub:Remove()
			McCD.CarSub = nil
		end

		McCD.Car = nil

		if McCD.Sound then
			McCD.Sound:Stop()
			McCD.Sound = nil
		end
	end

	local panel = vgui.Create("DPanel", main)
	panel:SetSize(SW / 4.5, SH - SH / 6)
	panel:SetPos(50, 50)
	panel.text = "Автосалон"
	panel.page = {}
	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, 120, color_black)
		local sp = draw.SimpleText("USED ", "McCD.Sub1", 5, 5, MSD.Config.MainColor.p, TEXT_ALIGN_LEFT)
		draw.DrawText("CARS", "McCD.Sub1", 5 + sp, 5, MSD.ColorAlpha(MSD.Config.MainColor.p, math.random(150,255)), TEXT_ALIGN_LEFT)

		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 71, color_black, TEXT_ALIGN_RIGHT)
		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 70, color_white, TEXT_ALIGN_RIGHT)
		MSD.DrawTexturedRect(0, 0, w, 120, glass, color_w50)
	end
	main.panel = panel
	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(panel:GetWide(), panel:GetTall() - 120)
	panel.Menu:SetPos(0, 120)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(true)
	panel.Menu:SetPadding(5)
	panel.Menu:SetSpacing(5)
	panel.Menu.IgnoreVbar = true
	panel.Menu.HideVbar = true
	panel.Menu.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd)
		MSDX.Draw(0, 0, 0, w, hd, color_b50)
	end

	panel.Sub = vgui.Create("MSDPanelList", main)
	panel.Sub:SetSize(panel:GetWide(), 360)
	panel.Sub:SetPos(SW - panel:GetWide() - 15, 50)
	panel.Sub:EnableVerticalScrollbar()
	panel.Sub:EnableHorizontal(true)
	panel.Sub:SetPadding(5)
	panel.Sub:SetSpacing(5)
	panel.Sub.text = car_shop and car_shop.name or ""
	panel.Sub.IgnoreVbar = true
	panel.Sub.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd)
		MSDX.Draw(0, 0, 0, w, hd, color_b50)
	end
	panel.Sub.SetBasic = function()
		local pnl = vgui.Create("DPanel")
		pnl.fond = "GmodLA.Hand"
		pnl.StaticScale = {
			w = 1,
			fixed_h = 120,
			minw = 50,
			minh = 60
		}
		pnl.Paint = function(self, w, h)
			MSDX.Draw(0, 0, 0, w, h, color_black)
			MSD.DrawTexturedRect(0, 0, w, h, glass, color_w50)

			if not self.text or panel.Sub.text ~= self.text then
				self.text = panel.Sub.text
				surface.SetFont("GmodLA.Hand")
				if surface.GetTextSize(self.text) > w then
					self.fond = "GmodLA.HandSM"
				else
					self.fond = "GmodLA.Hand"
				end
			end

			draw.DrawText(self.text, self.fond, 5, 71, color_black, TEXT_ALIGN_LEFT)
			draw.DrawText(self.text, self.fond, 5, 70, color_white, TEXT_ALIGN_LEFT)
			local money = LocalPlayer():getDarkRPVar("money") or 0
			local mw = draw.SimpleText("$" .. string.Comma(money), "MSDFont.32", w - 15, 5, color_white, TEXT_ALIGN_RIGHT)
			local mwc = draw.SimpleText(string.Comma(math.Round(Glac.Credits)) .. " ¤", "MSDFont.30", w - 15, 35, color_white, TEXT_ALIGN_RIGHT)

			if id_tuneprice > 0 then
				draw.DrawText("$" .. string.Comma(id_tuneprice), "MSDFont.30", w - 25 - mw, 5, id_tuneprice <= money and DarkRP.Hud.Patern["hunger"] or DarkRP.Hud.Patern["main_d"], TEXT_ALIGN_RIGHT)
			end

			if id_tunecred > 0 then
				draw.DrawText(string.Comma(id_tunecred) .. "¤", "MSDFont.30", w - 25 - mwc, 35, id_tunecred <= Glac.Credits and DarkRP.Hud.Patern["hunger"] or DarkRP.Hud.Patern["main_d"], TEXT_ALIGN_RIGHT)
			end
		end

		panel.Sub:AddItem(pnl)
	end

	panel.BackSub = vgui.Create("MSDPanelList", main)
	panel.BackSub:SetSize(panel:GetWide(), 160)
	panel.BackSub:SetPos(50, 60 + panel:GetTall())
	panel.BackSub:EnableVerticalScrollbar()
	panel.BackSub:EnableHorizontal(true)
	panel.BackSub:SetPadding(5)
	panel.BackSub:SetSpacing(5)
	panel.BackSub.IgnoreVbar = true
	panel.BackSub.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd)
		MSDX.Draw(0, 0, 0, w, hd, color_b50)
	end

	MSD.CloseButtonIcon(main, ScrW() - 220, 0, 210, 37, "Закрыть", function()
		main:Close()
	end)

	panel.backpage = "main"
	panel.OpenPage = function(page, ...)
		id_tuneprice = 0
		id_tunecred = 0
		panel.curpage = page
		panel.Menu.Update()
		if not panel.page[page] then
			page = "main"
		end
		panel.page[page](...)
	end

	panel.Menu.Update = function()
		panel.Menu:Clear()
		panel.Sub:Clear()
		panel.Sub:SetBasic()
		panel.BackSub:Clear()

		if not panel.curpage or panel.curpage == "main" then return end

		MSD.ButtonIcon(panel.BackSub, "static", nil, 1, 60, "Назад", MSD.Icons48.arrow_left, function()
			if panel.backfunc then
				panel.backfunc()
				panel.backfunc = nil
			end
			panel.OpenPage(panel.backpage)
		end)
	end

	panel.page["main"] = function()
		panel.text = "Автосалон"
		changeView(2, 120)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Автопарк", MSD.Icons48.car, function(sf)
			panel.OpenPage("cars", "all")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Премиум автопарк", MSD.Icons48.car_sports, function(sf)
			panel.OpenPage("cars", "prem")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Купленные авто", MSD.Icons48.key, function(sf)
			net.Start("McCD.Msg")
				net.WriteUInt(0,3)
				net.WriteBool(true)
			net.SendToServer()
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Гараж", MSD.PinPoints[60], function(sf)
			net.Start("McCD.Msg")
				net.WriteUInt(0,3)
				net.WriteBool(false)
			net.SendToServer()
		end)
	end

	panel.page["cars"] = function(prem)
		prem = prem or panel.filter
		panel.backpage = "main"
		panel.filter = prem
		for e, v in SortedPairsByMemberValue(McCD.Cars, "price") do
			if v.nobuy then continue end
			if prem ~= "prem" and v.donate then continue end
			if prem == "prem" and not v.donate then continue end

			local price = v.donate and v.price * McCD.Config.Discount or v.price
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, v.donate and price .. "¤" or "$" .. string.Comma(price) .. "  ", v.donate and MSD.PinPoints[49] or MSD.Icons48.car, function(sf)
				panel.OpenPage("opencar", e, v)
			end)
		end
	end

	panel.page["opencar"] = function(e, v)
		changeView(2, 130)

		if v.donate then
			id_tunecred = v.price
		else
			id_tuneprice = v.price
		end

		local colorid = math.random(#McCD.Config.CarColors)
		panel.text = v.name
		panel.backpage = "cars"

		local listv = VehicleList[e]
		if not listv then return end
		v.garage_vect = v.garage_vect or Vector(0, 0, 0)
		v.garage_angle = v.garage_angle or Angle(0, -90, 0)
		McCD.CarSpawn(listv, v)
		local price = v.donate and v.price * McCD.Config.Discount or v.price
		panel.Sub.text = v.name
		panel.Sub:Clear()
		panel.Sub:SetBasic()
		MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, v.donate and "Разблокировать машину" or "Купить машину", v.donate and price .. "¤" or "$" .. string.Comma(price), v.donate and MSD.Icons48.key or MSD.Icons48.cash, function(sf)
				net.Start("McCD.Msg")
				net.WriteUInt(1,3)
				net.WriteString(e)
				net.WriteFloat(colorid or 1)
				net.SendToServer()
				id_tuneprice = 0
			panel.OpenPage("main")
		end)

		local palette = v.palette or McCD.Config.CarColors

		for k, d in SortedPairs(palette) do
			local b = MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, d[2] or "Цвет #" .. k, "", MSD.Icons48.format_paint, function()
			 	McCD.Car:SetColor(d[1])
			 	colorid = k
			end, nil, d[1])
			b.bgpaint = function(self, wd, hd)
				MSD.DrawTexturedOutlined(12, hd / 2 - 12, 24, 24, MSD.Icons48.format_paint, color_black, 2, color_black)
			end
		end

		McCD.Car:SetColor(palette[colorid][1])
	end

	panel.page["carsell"] = function()
		prem = prem or panel.filter
		panel.backpage = "main"
		panel.text = "Купленные машины " .. #CarInventory .. " из " .. 5 + (MQS.GetDataStored(LocalPlayer(), "car_slots") or 0)

		for e, v in pairs(CarInventory) do
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, v.name, v.donate and MSD.PinPoints[49] or MSD.Icons48.car, function(sf)
				local listv = VehicleList[v.entity]
				if not listv then return end
				car_shop = McCD.Cars[v.entity]
				car_table = v
				car_spawnlist = listv
				v.garage_vect = (car_shop and car_shop.garage_vect) or v.garage_vect or Vector(0, 0, 0)
				v.garage_angle = (car_shop and car_shop.garage_angle) or v.garage_angle or Angle(0, -90, 0)

				McCD.CarSpawn(listv, v, McCD.Cars[v.entity])

				panel.Sub.text = v.name
				panel.Sub:Clear()
				panel.Sub:SetBasic()

				if car_table and car_table.wcitimer and car_table.wcitimer > os.time() then return end
				if v.nocase then return end
				if v.donate then
					MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Обменять машину",  "¤" .. string.Comma(math.Round(v.refundprice / 2)) , MSD.Icons48.hand_extended, function()
						MSD.AskConfirmPopup(nil, "Вы уверены что хотите обменять машину на " .. string.Comma(math.Round(v.refundprice / 2)) .. "¤?", "Обменять машину", "Отмена", function()
							net.Start("McCD.Msg")
							net.WriteUInt(2,3)
							net.WriteUInt(e, 32)
							net.WriteBool(true)
							net.SendToServer()
							panel.OpenPage("main")
						end)
					end)

					MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Продать машину",  "$" .. string.Comma(math.Round(v.refundprice * 150 / 2)) , MSD.Icons48.cash, function()
						MSD.AskConfirmPopup(nil, "Вы уверены что хотите продать машину на $" .. string.Comma(math.Round(v.refundprice * 150 / 2)) .. "?", "Продать машину", "Отмена", function()
							net.Start("McCD.Msg")
							net.WriteUInt(2,3)
							net.WriteUInt(e, 32)
							net.WriteBool(false)
							net.SendToServer()
							panel.OpenPage("main")
						end)
					end)
				else
					MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Продать машину",  "$" .. string.Comma(v.refundprice) , MSD.Icons48.cash, function()
						MSD.AskConfirmPopup(nil, "Вы уверены что хотите продать машину на $" .. string.Comma(v.refundprice) .. "?", "Продать машину", "Отмена", function()
							net.Start("McCD.Msg")
							net.WriteUInt(2,3)
							net.WriteUInt(e, 32)
							net.SendToServer()
							panel.OpenPage("main")
						end)
					end)
				end
			end)
		end
	end

	panel.page["garage"] = function()
		changeView(2, 130)
		prem = prem or panel.filter
		panel.backpage = "main"
		panel.text = "Гараж " .. #CarInventory .. " из " .. 5 + (MQS.GetDataStored(LocalPlayer(), "car_slots") or 0)

		for e, v in pairs(CarInventory) do
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, v.name, v.donate and MSD.PinPoints[49] or MSD.Icons48.car, function(sf)
				local listv = VehicleList[v.entity]
				if not listv then return end
				car_shop = McCD.Cars[v.entity]
				v.garage_vect = (car_shop and car_shop.garage_vect) or v.garage_vect or Vector(0, 0, 0)
				v.garage_angle = (car_shop and car_shop.garage_angle) or v.garage_angle or Angle(0, -90, 0)
				car_table = v
				last_car = e
				car_spawnlist = listv

				McCD.CarSpawn(listv, v, McCD.Cars[v.entity])

				panel.Sub.text = v.name
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				if car_table and car_table.wcitimer and car_table.wcitimer > os.time() then return end
				for _, c in pairs(ents.FindByClass("prop_vehicle_jeep")) do
					if c:GetNWString("McCD.UniqueId") == car_table.uniqueid then return end
				end
				MSD.ButtonIcon(panel.Sub, "static", nil, 1, 60, "Конфигуратор", MSD.PinPoints[59], function()
					panel.OpenPage("tune")
				end)
				MSD.ButtonIcon(panel.Sub, "static", nil, 1, 60, "Вывезти из гаража", MSD.PinPoints[66], function()
					net.Start("McCD.Msg")
					net.WriteUInt(4,3)
					net.WriteUInt(e, 16)
					net.SendToServer()
					main:Close()
				end)
			end)
		end
	end

	panel.page["tune"] = function()
		changeView(2, 180)
		panel.text = car_table.name
		panel.Sub.text = car_table.name
		panel.backpage = "garage"

		MSD.InfoHeader(panel.Menu, "Кузов")

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Покраска", MSD.Icons48.spray, function()
			panel.OpenPage("paint")
		end)

		if (not car_table.noskin and McCD.Car:SkinCount() >= 2) or car_shop.skins_pack then
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Покрытие", MSD.Icons48.layers, function()
				panel.OpenPage("skins")
			end)
		end

		if car_shop.cantune then
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Конфигурация кузова", MSD.Icons48.car_sports, function()
				panel.OpenPage("body")
			end)
		end

		MSD.InfoHeader(panel.Menu, "Производительность")

		if not car_table.tuneblock then
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Настройка двигателя", MSD.Icons48.engine, function()
				panel.OpenPage("engine")
			end)

			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Тормозная система", MSD.Icons48.car_brake_idle, function()
				panel.OpenPage("brakes")
			end)
		end

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Подвеска", MSD.Icons48.suspension, function()
			panel.OpenPage("suspension")
		end)

		MSD.InfoHeader(panel.Menu, "Другое")

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Клаксон", MSD.Icons48.bugle, function()
			panel.OpenPage("bugle")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Дым от шин", MSD.Icons48.smoke, function()
			panel.OpenPage("smoke")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Номерные знаки", MSD.Icons48.card_multiple_outline, function()
			panel.OpenPage("plate")
		end)

		if not car_table.tuneblock then
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Подсветка", MSD.Icons48.lightbulb_fluorescent_tube_outline, function()
				panel.OpenPage("neon")
			end)
		end
	end

	panel.page["paint"] = function()
		changeView(2, 180)
		local color_cache = McCD.Car:GetColor()
		panel.text = "Покраска"
		panel.backpage = "tune"
		panel.backfunc = function()
			McCD.Car:SetColor(color_cache)
		end

		if not McCD.Config.TuneColorsForm then
			McCD.Config.TuneColorsForm = {}
			local hsv = {
				lows = {},
				drks = {},
				clrs = {},
			}

			for k, v in pairs(McCD.Config.TuneColors) do
				local h, s, vl = ColorToHSV(v[1])
				local clv = {v[1], v[2], k, h, s, vl}

				if s <= 0.2 then
					table.insert(hsv.lows, clv)
					continue
				end

				if vl <= 0.3 then
					table.insert(hsv.drks, clv)
					continue
				end

				table.insert(hsv.clrs, clv)
			end

			table.sort(hsv.lows, function(a, b) return a[6] > b[6] end)
			table.sort(hsv.drks, function(a, b) return a[4] > b[4] end)
			table.sort(hsv.clrs, function(a, b) return a[4] > b[4] end)

			table.Add(McCD.Config.TuneColorsForm, hsv.lows)
			table.Add(McCD.Config.TuneColorsForm, hsv.drks)
			table.Add(McCD.Config.TuneColorsForm, hsv.clrs)
		end

		for _, v in pairs(McCD.Config.TuneColorsForm) do
			MSD.IconButton(panel.Menu, MSD.Icons48.card, "static", nil, 32, v[1], v[1], function()
				McCD.Car:SetColor(v[1])
				id_tuneprice = v[2]

				panel.Sub:Clear()
				panel.Sub:SetBasic()
				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(v[2]), MSD.Icons48.spray, function()
					if not LocalPlayer():canAfford(id_tuneprice) then return end
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("color")
					net.WriteUInt(v[3], 16)
					net.SendToServer()
					id_tuneprice = 0
					color_cache = McCD.Car:GetColor()
					car_table.color = v[1]
					surface.PlaySound("mc_cardealer/paint.wav")
				end)
			end, function(s, w, h)
				MSD.DrawTexturedRect(1, 1, w, h, s.mat, color_black, 2, color_black)
			end)
		end
	end

	panel.page["skins"] = function()
		changeView(2, 180)
		local pack_cache = car_table.skin_pack
		local skin_cache = McCD.Car:GetSkin()
		panel.text = "Покрытие"
		panel.backpage = "tune"
		panel.backfunc = function()
			clearSubList(McCD.Car)
			car_table.skin_pack = pack_cache
			McCD.Car:SetSkin(skin_cache)

			if pack_cache and car_shop.skins_pack[pack_cache] then
				setSubList(McCD.Car, car_shop.skins_pack[pack_cache])
			end
		end

		if not car_table.noskin and McCD.Car:SkinCount() >= 2 then
			MSD.InfoHeader(panel.Menu, "Вариации покрытия")

			for i = 0, McCD.Car:SkinCount() - 1 do
			if car_table.allowed_skins and not car_table.allowed_skins[i] then continue end
				MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, "Вариация #" .. i  + 1, skin_cache == i and "ВЫБРАНО" or "", MSD.Icons48.card_multiple, function()
					McCD.Car:SetSkin(i)
					panel.Sub.text =  "Вариация #" .. i  + 1
					id_tuneprice = 0
					panel.Sub:Clear()
					panel.Sub:SetBasic()
					MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "БЕЗ ОПЛАТЫ", MSD.PinPoints[59], function()
						net.Start("McCD.Msg")
						net.WriteUInt(3,3)
						net.WriteFloat(last_car)
						net.WriteString("skin")
						net.WriteFloat(McCD.Car:GetSkin())
						net.SendToServer()
						skin_cache = McCD.Car:GetSkin()
						car_table.skin = McCD.Car:GetSkin()
						surface.PlaySound("mc_cardealer/fix.wav")
						clearSubList(McCD.Car)
						if pack_cache and car_shop.skins_pack[pack_cache] then
							setSubList(McCD.Car, car_shop.skins_pack[pack_cache])
						end
						panel.OpenPage("skins")
					end)
				end)
			end
		end

		if car_shop.skins_pack then
			MSD.InfoHeader(panel.Menu, "Типы покрытия")

			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, "По умолчанию", not  car_table.skin_pack and "ВЫБРАНО" or "", MSD.Icons48.layers_remove, function()
				clearSubList(McCD.Car)
				car_table.skin_pack = nil

				id_tuneprice = 0
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text =  "По умолчанию"
				if not pack_cache then return end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "БЕЗ ОПЛАТЫ", MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("skin_pack")
					net.WriteString("")
					net.SendToServer()
					clearSubList(McCD.Car)
					pack_cache = nil
					surface.PlaySound("mc_cardealer/fix.wav")
					McCD.Car:SetSkin(skin_cache)
					panel.OpenPage("skins")
				end)
			end)

			for k,v in pairs(car_shop.skins_pack) do
				--local has = MQS.GetSData(nil, k) and "НЕТ ДОСТУПА" or ""
				MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, McCD.SkinNames[k] or k, car_table.skin_pack == k and "ВЫБРАНО" or "", MSD.Icons48.layers, function()
					setSubList(McCD.Car, v)
					panel.Sub.text =  McCD.SkinNames[k] or k
					id_tuneprice = 0
					panel.Sub:Clear()
					panel.Sub:SetBasic()

					if not MQS.GetSData(nil, k) then return end

					MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "БЕЗ ОПЛАТЫ", MSD.PinPoints[59], function()
						net.Start("McCD.Msg")
						net.WriteUInt(3,3)
						net.WriteFloat(last_car)
						net.WriteString("skin_pack")
						net.WriteString(k)
						net.SendToServer()
						car_table.skin_pack = k
						pack_cache = car_table.skin_pack
						setSubList(McCD.Car, v)
						id_tuneprice = 0
						surface.PlaySound("mc_cardealer/fix.wav")
						McCD.Car:SetSkin(skin_cache)
						panel.OpenPage("skins")
					end)
				end)
			end
		end
	end

	panel.page["body"] = function()
		changeView(2, 180)
		local bg_cache = {}
		local bg_change = {}
		local updatemenu
		for k, v in pairs(McCD.Car:GetBodyGroups()) do
			if v.num < 2 then continue end
			bg_cache[v.id] = McCD.Car:GetBodygroup(v.id)
		end

		panel.text = "Конфигурация кузова"
		panel.backpage = "tune"
		panel.backfunc = function()
			for k, v in pairs(bg_cache) do
				McCD.Car:SetBodygroup(k, v)
			end
		end

		updatemenu = function()
			panel.Sub:Clear()
			panel.Sub:SetBasic()

			if not car_table.unlockedbg then
				id_tuneprice = 0
				id_tunecred = 750
				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Разблокировать кастомизацию", "750¤", MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("unlockgbs")
					net.SendToServer()
					id_tunecred = 0
					if Glac.Credits >= 750 then
						car_table.unlockedbg = true
						surface.PlaySound("mqs/done/4.mp3")
					end
					panel.OpenPage("body")
				end)
				return
			end

			if table.Count(bg_change) < 1 or id_tuneprice == 0 then return end

			MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(id_tuneprice), MSD.PinPoints[59], function()
				if not LocalPlayer():canAfford(id_tuneprice) then return end
				local bg_done = {}

				for a, b in pairs(McCD.Car:GetBodyGroups()) do
					if b.num < 2 then continue end
					bg_done[b.id] = McCD.Car:GetBodygroup(b.id)
				end

				net.Start("McCD.Msg")
				net.WriteUInt(3,3)
				net.WriteFloat(last_car)
				net.WriteString("bodygroups")
				net.WriteTable(bg_done)
				net.WriteFloat(table.Count(bg_change))
				net.SendToServer()
				id_tuneprice = 0
				bg_cache = bg_done
				car_table.bodygroups = bg_done
				surface.PlaySound("mc_cardealer/fix.wav")
				updatemenu()
			end)
		end

		for k, v in pairs(McCD.Car:GetBodyGroups()) do
			if v.num < 2 then continue end
			if car_table.baned_bg and car_table.baned_bg[v.id] then continue end
			if McCD.Config.BannedBodyGroup[v.name] then continue end

			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, McCD.Config.BodyGroupNames[v.name] and McCD.Config.BodyGroupNames[v.name][1] or v.name, McCD.Car:GetBodygroup(v.id) + 1 .. "/" .. v.num, MSD.PinPoints[59], function(s)
				local bg = McCD.Car:GetBodygroup(v.id)
				bg = bg + 1

				if bg > v.num - 1 then
					bg = 0
				end

				if car_table.baned_bgs and car_table.baned_bgs[v.id] and car_table.baned_bgs[v.id][bg] then
					bg = bg + 1

					if bg > v.num - 1 then
						bg = 0
					end
				end

				s.text = bg + 1 .. "/" .. v.num

				if bg_cache[v.id] ~= bg then
					bg_change[v.id] = bg
				else
					bg_change[v.id] = nil
				end

				if McCD.Config.BodyGroupNames[v.name] and McCD.Config.BodyGroupNames[v.name][2] then
					changeView(McCD.Config.BodyGroupNames[v.name][2], McCD.Config.BodyGroupNames[v.name][3])
				end

				id_tuneprice = table.Count(bg_change) * McCD.Config.BodyGroupPrice
				McCD.Car:SetBodygroup(v.id, bg)

				updatemenu()
			end)

			updatemenu()
		end
	end

	panel.page["engine"] = function()
		changeView(2, 100)
		local nitro_cache = car_table.nitro or 0
		panel.text = "Настройка двигателя"
		panel.backpage = "tune"
		panel.backfunc = function()
			car_table.nitro = nitro_cache
		end

		for k, v in pairs(McCD.Config.Nitro) do
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, McCD.Config.NitroNames[k], nitro_cache == k and "ВЫБРАНО" or "$" .. string.Comma(v), MSD.Icons48.engine, function()
				id_tuneprice = v
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text = McCD.Config.NitroNames[k]

				if k > 0 then
					local pnl = vgui.Create("DPanel")
					pnl.StaticScale = {w = 1, fixed_h = 60, minw = 50, minh = 60}
					pnl.Paint = function(self, w, h)
						draw.DrawText("Максимальная тяга +" .. 2 * k .. "%", "MSDFont.20", 48, 6, MSD.Text["s"], TEXT_ALIGN_LEFT)
						MSD.DrawTexturedRect(12, 5, 24, 24, MSD.Icons48.arrow_up, MSD.Clr["green"])

						if k < 2 then return end

						draw.DrawText("Сцепление -" .. 3 * k .. "%", "MSDFont.20", 48, 34, MSD.Text["s"], TEXT_ALIGN_LEFT)
						MSD.DrawTexturedRect(12, 34, 24, 24, MSD.Icons48.arrow_down, MSD.Clr["red"])
					end
					panel.Sub:AddItem(pnl)
				end

				if nitro_cache == k then return end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(id_tuneprice), MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("nitro")
					net.WriteFloat(k)
					net.SendToServer()
					id_tuneprice = 0
					car_table.nitro = k
					surface.PlaySound("mc_cardealer/fix.wav")
					panel.OpenPage("engine")
				end)
			end)
		end
	end

	panel.page["brakes"] = function()
		changeView(4, 100)
		local nitro_cache = car_table.breaks or 0
		panel.text = "Тормозная система"
		panel.backpage = "tune"
		panel.backfunc = function()
			car_table.breaks = nitro_cache
		end

		for k, v in pairs(McCD.Config.Breaks) do
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, McCD.Config.BreaksNames[k], nitro_cache == k and "ВЫБРАНО" or "$" .. string.Comma(v), MSD.Icons48.car_brake_idle, function()
				id_tuneprice = v
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text = McCD.Config.BreaksNames[k]

				if nitro_cache == k then return end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(id_tuneprice), MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("breaks")
					net.WriteFloat(k)
					net.SendToServer()
					id_tuneprice = 0
					car_table.breaks = k
					surface.PlaySound("mc_cardealer/fix.wav")
					panel.OpenPage("brakes")
				end)
			end)
		end
	end

	panel.page["suspension"] = function()
		changeView(4, 100)
		local suspension_cache = car_table.suspension or 0
		if not car_table.suspension then car_table.suspension = 0 end
		panel.text = "Подвеска"
		panel.backpage = "tune"
		panel.backfunc = function()
			car_table.suspension = suspension_cache
			McCD.ChangeSuspension(suspension_cache, car_table, car_spawnlist)
		end

		for k, v in pairs(McCD.Config.Suspension) do
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v[2], car_table.suspension == v[1] and "ВЫБРАНО" or "$" .. string.Comma(v[3]), MSD.Icons48.suspension, function()
				id_tuneprice = v[3]
				McCD.ChangeSuspension(v[1], car_table, car_spawnlist)
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text = v[2]

				if suspension_cache == v[1] then id_tuneprice = 0 return end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(id_tuneprice), MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("suspension")
					net.WriteFloat(k)
					net.SendToServer()
					id_tuneprice = 0
					car_table.suspension = v[1]
					suspension_cache = v[1]
					surface.PlaySound("mc_cardealer/fix.wav")
					panel.OpenPage("suspension")
					panel.backfunc = nil
				end)
			end)
		end
	end

	panel.page["bugle"] = function()
		changeView(2, 60)
		local horn_cache = car_table.horn or 0
		if not car_table.horn then car_table.horn = 1 end
		panel.text = "Клаксон"
		panel.backpage = "tune"
		panel.backfunc = function()
			car_table.horn = horn_cache
			if McCD.Sound then
				McCD.Sound:Stop()
				McCD.Sound = nil
			end
		end

		for k, v in pairs(McCD.Config.Horns) do
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v[1], car_table.horn == k and "ВЫБРАНО" or "$" .. string.Comma(v[3]), MSD.Icons48.bugle, function()
				id_tuneprice = v[3]
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text = v[1]

				if McCD.Sound and car_table.horn == k then
					McCD.Sound:Stop()
					McCD.Sound = nil
				else
					McCD.PlaySound(v[2])
				end

				car_table.horn = k

				if horn_cache == k then id_tuneprice = 0 return end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(id_tuneprice), MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("horn")
					net.WriteFloat(k)
					net.SendToServer()
					id_tuneprice = 0
					car_table.horn = k
					horn_cache = k
					surface.PlaySound("mc_cardealer/fix.wav")
					panel.OpenPage("bugle")
				end)
			end)
		end
	end

	panel.page["smoke"] = function()
		changeView(2, 60)
		local horn_cache = car_table.smoke or 0
		if not car_table.smoke then car_table.smoke = 0 end
		panel.text = "Дым от шин"
		panel.backpage = "tune"
		panel.backfunc = function()
			car_table.smoke = horn_cache
			if McCD.Sound then
				McCD.Sound:Stop()
				McCD.Sound = nil
			end
		end

		for k, v in SortedPairs(McCD.Config.Smoke) do
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v[1], car_table.smoke == k and "ВЫБРАНО" or "$" .. string.Comma(McCD.Config.TireSmokePrice), MSD.Icons48.smoke, function()
				id_tuneprice = McCD.Config.TireSmokePrice
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text = v[1]

				car_table.smoke = k

				if McCD.Car.Weals and k ~= 0 then
					McCD.Car.effect = Vector(v[2].r, v[2].g, v[2].b)
					McCD.Car.effectT = CurTime() + 0.2
				end

				if horn_cache == k then id_tuneprice = 0 return end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(id_tuneprice), MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("smoke")
					net.WriteFloat(k)
					net.SendToServer()
					id_tuneprice = 0
					car_table.smoke = k
					horn_cache = k
					surface.PlaySound("vcmod/air_wrench_long.wav")
					panel.OpenPage("smoke")
				end)
			end, nil, v[2])
		end
	end

	panel.page["neon"] = function()
		changeView(1, 120)
		local horn_cache = car_table.neon or 0
		if not car_table.neon then car_table.neon = 0 end
		panel.text = "Подсветка"
		panel.backpage = "tune"
		panel.backfunc = function()
			car_table.neon = horn_cache
			neon_glow = nil
		end

		neon_glow = car_table.neon

		for k, v in SortedPairs(McCD.Config.Neon) do
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v[1], car_table.neon == k and "ВЫБРАНО" or "", v[1] == "Нет" and MSD.Icons48.lightbulb_fluorescent_tube_outline or MSD.Icons48.lightbulb_fluorescent_tube, function()
				id_tunecred = McCD.Config.NeonPrice
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text = v[1]

				car_table.neon = k
				neon_glow = k

				if horn_cache == k then id_tunecred = 0 return end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", McCD.Config.NeonPrice .. "¤", MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("neon")
					net.WriteFloat(k)
					net.SendToServer()
					id_tunecred = 0
					car_table.neon = k
					horn_cache = k
					surface.PlaySound("mc_cardealer/fix.wav")
					panel.OpenPage("neon")
				end)
			end, nil, v[2])
		end
	end

	panel.page["plate"] = function()
		mcam.cang = McCD.Config.CamPoses[5]
		if IsValid(McCD.Car) and McCD.Car.rearplt and IsValid(McCD.Car.rearplt) then
			local ang = McCD.Car.rearplt:GetAngles()
			mcam.nang = McCD.Car.rearplt:GetPos() - ang:Forward() * -50
			ang:RotateAroundAxis(ang:Forward(), 180)
			ang:RotateAroundAxis(ang:Right(), 180)
			mcam.sang = ang
			mcam.ndist = 100
		else
			changeView(5, 100)
		end
		local horn_cache = car_table.plates or 0
		if not car_table.plates then car_table.plates = 0 end
		panel.text = "Номерные знаки"
		panel.backpage = "tune"
		panel.backfunc = function()
			car_table.plates = horn_cache
			plate_color(McCD.Config.Plates[horn_cache][2])
		end

		local capd = car_table.lpcd and car_table.lpcd > os.time()

		MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, "Сменить номер на случайный", capd and MSD.NiceTime(car_table.lpcd - os.time()) or "$" .. string.Comma(McCD.Config.RandomPlate), MSD.Icons48.cached, function()
			if capd then return end
			id_tuneprice = McCD.Config.RandomPlate
			panel.Sub:Clear()
			panel.Sub:SetBasic()
			panel.Sub.text = "Сменить номер на случайный"

			MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", "$" .. string.Comma(McCD.Config.RandomPlate), MSD.PinPoints[59], function()
				net.Start("McCD.Msg")
				net.WriteUInt(3,3)
				net.WriteFloat(last_car)
				net.WriteString("plate_gen")
				net.SendToServer()
				id_tuneprice = 0
				surface.PlaySound("mc_cardealer/fix.wav")
				panel.OpenPage("plate")
			end)
		end)

		for k, v in SortedPairs(McCD.Config.Plates) do
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v[1], car_table.plates == k and "ВЫБРАНО" or v[3] .. "¤", MSD.Icons48.card_multiple, function()
				id_tunecred = v[3]
				panel.Sub:Clear()
				panel.Sub:SetBasic()
				panel.Sub.text = v[1]

				car_table.plates = k
				plate_color(v[2])
				if horn_cache == k then id_tunecred = 0 return end
				if k == 0 then id_tunecred = 0 end

				MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Применить изменения", k == 0 and "БЕЗ ОПЛАТЫ" or v[3] .. "¤", MSD.PinPoints[59], function()
					net.Start("McCD.Msg")
					net.WriteUInt(3,3)
					net.WriteFloat(last_car)
					net.WriteString("plates")
					net.WriteFloat(k)
					net.SendToServer()
					id_tunecred = 0
					car_table.plates = k
					horn_cache = k
					surface.PlaySound("mc_cardealer/fix.wav")
					panel.OpenPage("plate")
				end)
			end)
		end
	end

	if buy then
		panel.OpenPage("main")
	else
		panel.OpenPage("garage")
	end

end

function McCD.Garage()
	local cars = net.ReadTable()
	local bool = net.ReadBool()

	if cars then
		CarInventory = cars
	end

	if not cars or #cars < 1 then return end

	if bool then
		if not IsValid(McCD.Menu) then return end
		McCD.Menu.panel.OpenPage("carsell")
	else
		if IsValid(McCD.Menu) then
			McCD.Menu.panel.OpenPage("garage")
		else
			McCD.OpenGarage(false)
		end
	end
end

function McCD.GarageUpdate()
	local cars = net.ReadTable()
	if cars then
		CarInventory = cars
	end

	local b = net.ReadFloat()

	local ccar = CarInventory[b]

	car_table = ccar

	if IsValid(McCD.Car) then
		if IsValid(McCD.Car.rearplt) then REN.SetLicensePlateNumber(McCD.Car.rearplt, ccar.uniqueid) end
		if IsValid(McCD.Car.frontplt) then REN.SetLicensePlateNumber(McCD.Car.frontplt, ccar.uniqueid) end
	end

end

net.Receive("McCD.Msg", function()
	local b = net.ReadString()

	if McCD[b] then
		McCD[b]()
	end
end)