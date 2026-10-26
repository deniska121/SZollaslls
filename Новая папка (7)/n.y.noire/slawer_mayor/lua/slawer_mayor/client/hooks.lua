--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/client/hooks.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local origin = Vector(0, 0, 0)
local originTo = Vector(0, 0, 0)

hook.Add("CalcView", "Slawer.Mayor:CalcView", function(ply, pos, angles, fov)
	if not LocalPlayer():Alive() or not IsValid(Slawer.Mayor.LookingTo) or LocalPlayer():GetPos():DistToSqr(Slawer.Mayor.LookingTo:GetPos()) > 40000 then
		if IsValid(Slawer.Mayor.Menu) then
			Slawer.Mayor.Menu:LoadLockScreen()
			Slawer.Mayor.Menu:Remove()
			LocalPlayer():SetNoDraw(false)
		end

		if Slawer.Mayor.EnabledClicker then
			gui.EnableScreenClicker(false)
			Slawer.Mayor.EnabledClicker = false
		end

		Slawer.Mayor.LookingTo = nil

		return
	end

	local view = {}
	local ang = Slawer.Mayor.LookingTo:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 180.3)
	ang:RotateAroundAxis(ang:Right(), -8)

	origin = Slawer.Mayor.LookingTo:GetPos() + Slawer.Mayor.LookingTo:GetForward() * 28 + Slawer.Mayor.LookingTo:GetUp() * 17.5
	originTo = Lerp(RealFrameTime() * 8, originTo, origin)
	view.origin = originTo
	view.angles = ang
	view.fov = fov
	view.drawviewer = true
	Slawer.Mayor.ViewOrigin = view.origin
	Slawer.Mayor.EnabledClicker = true
	gui.EnableScreenClicker(true)

	return view
end)

local intNext = 0

hook.Add("KeyPress", "Slawer.Mayor:KeyPress", function(p, k)
	if intNext > CurTime() then return end
	if not p:Alive() then return end

	if k == IN_USE then
		local ent = LocalPlayer():GetEyeTrace().Entity
		if not IsValid(ent) then return end

		if ent:GetClass() == "slawer_mayor_computer" and Slawer.Mayor:CanUseComp(ent) then
			if LocalPlayer():isCP() or LocalPlayer():isMayor() or LocalPlayer():isEMS() then
				Slawer.Mayor.LookingTo = ent

				if not IsValid(Slawer.Mayor.Menu) then
					Slawer.Mayor.Menu = vgui.Create("Slawer.Mayor:Menu")

					if ent:GetModel() == "models/unioncity2/props_unioncity/pd_deskscreen.mdl" then
						Slawer.Mayor.Menu.NYPD = true
						if ScrW() > 1024 then
							Slawer.Mayor.Menu:SetSize(1024, 678)
							Slawer.Mayor.Menu:Center()
						end
					end
					Slawer.Mayor.Menu:Unlock()
				end

				originTo = LocalPlayer():EyePos()
			else
				surface.PlaySound("win/dings.wav")
			end

			intNext = CurTime() + 0.5
		end
	end
end)

hook.Add("StartCommand", "Slawer.Mayor:RestrictMovingInComp", function(_, cmd)
	if IsValid(Slawer.Mayor.Menu) and IsValid(Slawer.Mayor.Menu.Lock) and Slawer.Mayor.Menu.Lock:GetTall() < 600 then
		cmd:ClearMovement()
	end
end)

local boards = {
	[1] = {Vector(2364,1219,158), Angle(180,0,-90), 0.4},
	[2] = {Vector(-7832,-975.63269042969,222), Angle(180,0,-90), 0.4},
	[3] = {Vector(3524,9859,414), Angle(0,0,90), 0.4},
}

local w, h = 700, 360

local mats = {
	Material("cityrp/stains.png", "smooth"),
	Material("cityrp/billboard.png", "smooth"),
	Material("cityrp/billboard2.png", "smooth"),
}

local dirtmat = {
	[1] = Material("cityrp/dirt.png", "smooth"),
	[2] = Material("cityrp/dirt1.png", "smooth"),
	[3] = Material("cityrp/dirt0.png", "smooth")
}

local convars = {
	[1] = GetConVar("bill_board_1"),
	[2] = GetConVar("bill_board_2"),
	[3] = GetConVar("bill_board_3")
}

hook.Add("PostDrawOpaqueRenderables", "VoteBane2", function(dp, ds)
	if ds then return end

	for i,br in pairs(boards) do
		if not convars[i] or convars[i]:GetString() == "" then continue end
		if not DarkRP.InRangeVector(br[1], LocalPlayer():GetPos(), 2600) then continue end

		cam.Start3D2D( br[1], br[2], br[3] )
			MSD.DrawTexturedRect(0, 0, w, h, MSD.ImgLib.GetMaterial(convars[i]:GetString()), color_white)
			MSD.DrawTexturedRect(0, 0, w, h, dirtmat[i], color_white)
			MSD.DrawTexturedRect(0, 0, w, h, mats[3], color_white)
			MSD.DrawTexturedRect(0, 0, w, h, mats[2], color_white)
			MSD.DrawTexturedRect(0, 0, w, h, mats[1], color_white)
		cam.End3D2D()
	end
end)