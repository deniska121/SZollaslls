--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/police_station/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local logo1 = Material("gmodla/cd_1.png", "smooth")
local logo2 = Material("gmodla/cd_2.png", "smooth")
local cl_bl_100 = Color(0, 0, 0, 100)
local GovUI = {}

GovUI.Cam = {
	pos = Vector(0, 0, 0),
	ang = Angle(0, 0, 0),
	fov = 110,
	state = 1,
	rotate = 210,
	laste_change = 0,
	state_change = 10,
}

function ENT:Initialize()
	self.AllowedTeams = {}

	local tp = self:GetType()

	for k, v in pairs(GovCars.Cars) do
		if tp ~= v.type then continue end
		for t,b in pairs(v.teams) do
			self.AllowedTeams[t] = b
		end
	end
end

local function CreateWheel(self, tbl, index, attachmentpos, height, swap_y)
	local fAng = self:GetAngles()
	local Up = self:GetUp()

	if index == 2 or index == 4 then
		fAng.r = 180
	end

	if not GovUI.Car.Weals then
		GovUI.Car.Weals = {}
	end

	GovUI.Car.Weals[index] = ClientsideModel((tbl.CustomWheelModel_R and (index == 3 or index == 4 or index == 5 or index == 6)) and tbl.CustomWheelModel_R or tbl.CustomWheelModel, RENDERGROUP_OPAQUE)
	GovUI.Car.Weals[index]:SetPos(attachmentpos - Up * height)
	GovUI.Car.Weals[index]:SetAngles(fAng)
	GovUI.Car.Weals[index]:DrawModel()
end

function GovUI.CarSpawn(veh, sveh, spawn)
	if GovUI.Car and GovUI.Car.Weals then
		for k, v in pairs(GovUI.Car.Weals) do
			v:Remove()
		end
	end

	if GovUI.Car then
		GovUI.Car:Remove()
	end
	sveh.pos_extra = sveh.pos_extra or Vector(0,0,0)
	sveh.ang_extra = sveh.ang_extra or Angle(0,0,0)
	GovUI.Car = ClientsideModel(veh.Model, RENDERGROUP_OPAQUE)
	GovUI.Car:SetPos(spawn[1] + sveh.pos_extra)
	GovUI.Car:SetAngles(spawn[2] + sveh.ang_extra)
	GovUI.Car:DrawModel()
	GovUI.Car.Pov = sveh.Pov or 0
	GovUI.Car:DrawShadow(true)

	if sveh.color then
		GovUI.Car:SetColor(sveh.color)
	end

	GovUI.Car:SetSkin(sveh.skin or 0)

	if sveh.bodygroups then
		for k, v in pairs(sveh.bodygroups) do
			GovUI.Car:SetBodygroup(k, v)
		end
	end

	local ent = GovUI.Car
	veh = veh.Members
	CreateWheel(ent, veh, 1, ent:LocalToWorld(veh.CustomWheelPosFL), 1, 1)
	CreateWheel(ent, veh, 2, ent:LocalToWorld(veh.CustomWheelPosFR), 1, 1)
	CreateWheel(ent, veh, 3, ent:LocalToWorld(veh.CustomWheelPosRL), 1, 1)
	CreateWheel(ent, veh, 4, ent:LocalToWorld(veh.CustomWheelPosRR), 1, 1)
end

net.Receive("GovCars", function()
	local s_ent = net.ReadEntity()
	local gov_car = net.ReadEntity()
	local last_car, sveh, mainmenu, carmenu, carattent, errorstate
	local VehicleList = list.Get("simfphys_vehicles")
	if GovUI.Menu or not s_ent then return end

	if IsValid(GovUI.Car) then
		GovUI.Car:Remove()
	end

	GovUI.Car = nil

	local spawn = GovCars.Spwans[s_ent:GetSpawnPoint()]

	GovUI.Menu = vgui.Create("DFrame")
	GovUI.Menu:SetSize(ScrW(), ScrH())
	GovUI.Menu:Center()
	GovUI.Menu:MakePopup()
	GovUI.Menu:SetDraggable(false)
	GovUI.Menu:ShowCloseButton(false)
	GovUI.Menu:SetTitle("")

	MSD.CloseButtonIcon(GovUI.Menu, ScrW() - 220, 0, 210, 37, "Закрыть", function()
		GovUI.Menu.DoClose()
	end)
	GovUI.Menu.DoClose = function()
		GovUI.Menu:AlphaTo(0, 0.5, 0, function()
			GovUI.Menu:Close()
		end)
	end
	GovUI.Menu.OnClose = function()
		GovUI.Menu = nil

		if GovUI.Car then
			if GovUI.Car.Weals then
				for k, v in pairs(GovUI.Car.Weals) do
					v:Remove()
				end
			end

			GovUI.Car:Remove()
		end
	end
	GovUI.Menu.Paint = function(self, w, h)
		MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.vignette, color_black)
		MSD.DrawTexturedRectOfRot(180, -9, 0, w + 10, 41, MSD.Materials.gradient, color_black)
	end
	GovUI.Menu.Think = function()
		if gov_car and not IsValid(gov_car) then mainmenu() gov_car = nil end

		local ent = gov_car or GovUI.Car
		local ply = LocalPlayer()
		local sPos, sAng

		if not ent or errorstate then
			ent = ply
			sPos, sAng = spawn[1], spawn[2]
		else
			sPos, sAng = ent:GetPos(), ent:GetAngles()
		end

		if not sPos then return end
		sAng = Angle(0, ent:GetAngles().y, 0)

		if not GovUI.Menu.AnimInit then
			GovUI.Menu.AnimInit = true
			GovUI.Cam.pos = ply:EyePos()
			GovUI.Cam.ang = ply:GetAngles()
		end

		local pov = GovUI.Car and GovUI.Car.Pov or 10

		local tr = util.TraceLine({
			start = sPos,
			endpos = sPos + sAng:Up() * (100 + pov / 2) + sAng:Forward() * (150 + pov) - sAng:Right() * -100,
			filter = ent
		})

		sAng:RotateAroundAxis(sAng:Up(), -210)
		sAng:RotateAroundAxis(sAng:Right(), -30)
		GovUI.Cam.pos = LerpVector(FrameTime() * 3, GovUI.Cam.pos, tr.HitPos)
		GovUI.Cam.ang = LerpAngle(FrameTime() * 3, GovUI.Cam.ang, sAng)
		GovUI.Cam.fov = Lerp(FrameTime() * 3, GovUI.Cam.fov, 95)
	end

	local llogo = s_ent:GetBlinker() == 2 and logo2 or logo1

	local base = vgui.Create("DPanel", GovUI.Menu)
	base:SetSize(430, ScrH() - 60)
	base:SetPos(50, 50)
	base.text = s_ent:GetNameType()
	base.fond = "MSDFont.32"
	base.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, 100, color_black)
		MSD.DrawTexturedRect(0, 0, w, 100, llogo, color_white)
		local tw = draw.SimpleText(base.text, base.fond, 15, 50, color_white, TEXT_ALIGN_LEFT, 1)

		if tw + 15 > w then
			base.fond = "MSDFont.24"
		end
	end

	local clist = vgui.Create("MSDPanelList", base)
	clist.IgnoreVbar = true
	clist:SetPos(0, 100)
	clist:SetSize(430, ScrH() - 160)
	clist:EnableHorizontal(true)
	clist:EnableVerticalScrollbar(true)
	clist:SetSpacing(1)
	clist.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd)
		MSDX.Draw(0, 0, 0, w, hd, cl_bl_100)
	end

	function mainmenu()
		clist:Clear()
		base.text = s_ent:GetNameType() or ""
		base.fond = "MSDFont.32"

		for k, v in pairs(GovCars.Cars) do
			if not VehicleList[k] then continue end
			if v.type ~= s_ent:GetType() then continue end
			local lveh = VehicleList[k]

			MSD.ButtonIcon(clist, "static", nil, 1, 60, lveh.Name, MSD.Icons48.dot, function()
				last_car = v
				last_car.id = k
				sveh = v
				car_stats = table.Copy(lveh)
				cveh = nil
				GovUI.CarSpawn(lveh, sveh, spawn)
				carmenu()
			end)

		end
	end

	function carmenu()
		clist:Clear()
		base.text = car_stats.Name

		MSD.ButtonIcon(clist, "static", nil, 1, 60, "Назад", MSD.Icons48.arrow_left, function()
			mainmenu()
		end)

		local rank = MRS.GetNWdata(LocalPlayer(), "Rank") or 1
		if not last_car.teams[LocalPlayer():Team()] or (last_car.rank and last_car.rank > rank) or (last_car.exclus and not last_car.exclus[LocalPlayer():SteamID()]) then
			local tms = {}
			rank = MRS.Ranks[last_car.grop or "NYPD"].ranks[last_car.rank or 1]
			for k,v in pairs(last_car.teams) do
				table.insert(tms, k)
			end
			local et = vgui.Create("DPanel")
			et:SetSize(430, 90)
			et.Paint = function(self,w,h)
				if not car_stats then return end

				MSD.Blur( self, 5, 5, 255, 20, w, h )
				MSDX.Draw(0,0,0,w,h,cl_bl_100)

				draw.SimpleText( "Доступно для:", "MSDFont.22", 15, 10, color_white, TEXT_ALIGN_LEFT, 2)
				local last_w = 0
				for k,v in pairs(tms) do
					local spr = tms[k + 1] and ", " or ""
					last_w = last_w + draw.SimpleText( team.GetName(v) .. spr, "MSDFont.22", 15 + last_w, 35, color_white, TEXT_ALIGN_LEFT, 2)
				end

				if last_car.rank then
					local rn = draw.SimpleText( "Со звания " .. rank.name, "MSDFont.22", 15, 60, color_white, TEXT_ALIGN_LEFT, 2)
					MSD.DrawTexturedRect(15 + rn, 55, 32, 32, MRS.GetRankIcon(rank.icon), color_white)
				end
			end
			clist:AddItem(et)
		else
			MSD.ButtonIconText(clist, "static", nil, 1, 60, "Арендовать", last_car.price and (last_car.price .. "$") or (GovCars.Price .. "$"), MSD.Icons48.clipboard_arrow_up, function(sf)
				if not LocalPlayer():canAfford(last_car.price or GovCars.Price) then return end
				GovUI.Menu.DoClose()
				net.Start("GovCars")
					net.WriteString("SpawnCar")
					net.WriteString(last_car.id)
					net.WriteEntity(s_ent)
				net.SendToServer()
			end)
		end

	end

	local function fixcar()
		local carsm = vgui.Create("DPanel")
		carsm:SetSize(430, 95)
		carsm.Paint = function(self,w,h)
			MSDX.Draw(0,0,0,w,h,cl_bl_100)
			local MaxFuel = math.Round( gov_car:GetMaxFuel() , 1)
			local Fuel = math.Round( gov_car:GetFuel() , 1 )

			draw.SimpleText( "Топливо", "MSDFont.22", 15, 45, color_white, TEXT_ALIGN_LEFT, 2)

			MSDX.Draw(0,140,47,280,20,color_black)
			MSDX.Draw(0,140,47,math.Clamp(280 * (Fuel / MaxFuel),0,280),20,color_white)
		end
		clist:AddItem(carsm)
		MSD.ButtonIcon(clist, "static", nil, 1, 60, "Заправить топливо", MSD.Icons48.gas_station, function()
			GovUI.Menu.DoClose()
			net.Start("GovCars")
			net.WriteString("Fill")
			net.WriteEntity(s_ent)
			net.SendToServer()
		end)
		MSD.ButtonIcon(clist, "static", nil, 1, 60, "Убрать в гараж на тех. обслуживание", MSD.PinPoints[66], function()
			GovUI.Menu.DoClose()
			net.Start("GovCars")
			net.WriteString("RemoveCar")
			net.WriteEntity(s_ent)
			net.SendToServer()
		end)
	end

	local function errors()
		errorstate = true
		local carsm = vgui.Create("DPanel")
		carsm:SetSize(430, 100)
		carsm.Paint = function(self,w,h)
			draw.SimpleText( "У вас уже есть машина и она слишком далеко!", "MSDFont.20", 15, 10, color_white, TEXT_ALIGN_LEFT, 2)
			draw.SimpleText( "Если вы не можете вернуть машину в гараж,", "MSDFont.20", 15, 50, color_white, TEXT_ALIGN_LEFT, 2)
			draw.SimpleText( "вы можете запросить платный эвакуатор.", "MSDFont.20", 15, 70, color_white, TEXT_ALIGN_LEFT, 2)
		end
		clist:AddItem(carsm)

		MSD.ButtonIconText(clist, "static", nil, 1, 60, "Запросить эвакуатор",  GovCars.PriceTow .. "$", MSD.PinPoints[63], function(sf)
			if not LocalPlayer():canAfford(GovCars.Price) then return end
			GovUI.Menu.DoClose()
			net.Start("GovCars")
			net.WriteString("Tow")
			net.SendToServer()
		end)
	end

	function carattent()
		if IsValid(gov_car) and gov_car:GetPos():DistToSqr(s_ent:GetPos()) > GovCars.DistToCar then
			errors()
		else
			fixcar()
		end
	end

	if IsValid(gov_car) then carattent() else mainmenu() end
end)

hook.Add("HUDShouldDraw", "GovUI.HideHUD", function()
	if GovUI.Menu then return false end
end)

hook.Add("CalcView", "GovUI.CalcView", function(ply, pos, angles, fov)
	if GovUI.Menu then
		local view = {
			origin = GovUI.Cam.pos,
			angles = GovUI.Cam.ang,
			fov = GovUI.Cam.fov,
			drawviewer = true
		}

		return view
	else
		GovUI.Cam.fov = fov
	end
end)