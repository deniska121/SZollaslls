--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/cl_hooks.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- DO NOT EDIT ANYTHING HERE, UNLESS YOU KNOW WHAT YOU ARE DOING
local ply = LocalPlayer()
local snap = 0
local ScrW, ScrH = ScrW, ScrH
McPhone.key = 5

local function SwipeUp()
	if McPhone.UI and snap < CurTime() and (McPhone.key - 3) > 0 then
		McPhone.key = McPhone.key - 3
		snap = CurTime() + 0.2
		local but = McPhone.UI.Menu:GetItems()[McPhone.key]

		if IsValid(but) and not but.unused then
			but:OnCursorEntered()
			McPhone.UI.Menu:ScrollToChild(but)
		end
	end
end

McPhone.ClosePhone = function()
	if McPhone.UI and not McPhone.UI.Closing then
		McPhone.StopCall()
		McPhone.PlaySoundUI("toggle")
		snap = CurTime() + 1
		McPhone.UI:MoveTo(McPhone.UI:GetPos(), ScrH(), 0.2)
		McPhone.UI.Closing = CurTime() + 1
	end

	hook.Call("McPhone.Hook.ClosePhone", nil)
end

McPhone.GoBack = function()
	McPhone.StopCall()
	if not McPhone.UI then return end
	if McPhone.UI.Focus then
		McPhone.UI:MoveTo(McPhone.UI.Focus[1], McPhone.UI.Focus[2], 0.2)
		if McPhone.UI.Focus[3] then
			McPhone.UI.Focus[3]()
		end
		McPhone.UI.Focus = nil
	end
	if McPhone.UI.GoBack and snap < CurTime() then
		snap = CurTime() + 0.5
		McPhone.UI.GoBack()
		local but = McPhone.UI.Menu:GetItems()[McPhone.key]

		if IsValid(but) and not but.unused then
			but:OnCursorEntered()
		end

		if McPhone.UI.Menu.List then
			McPhone.key = 1
		else
			McPhone.key = 5
		end

		but = McPhone.UI.Menu:GetItems()[McPhone.key]

		if IsValid(but) and not but.unused then
			but:OnCursorEntered()
		end
	elseif snap < CurTime() then
		McPhone.ClosePhone()
	end
end

McPhone.OpenMainMenu = function()
	McPhone.StopCall()
	if not McPhone.UI then return end

	if McPhone.UI.MainMenuOpen then
		McPhone.UI.MainMenuOpen()
	end

	McPhone.UI.GoBack = false
end

local function SwipeDown()
	if McPhone.UI and snap < CurTime() and (McPhone.key + 3) <= #McPhone.UI.Menu:GetItems() then
		McPhone.key = McPhone.key + 3
		snap = CurTime() + 0.2
		local but = McPhone.UI.Menu:GetItems()[McPhone.key]

		if IsValid(but) and not but.unused then
			but:OnCursorEntered()
			McPhone.UI.Menu:ScrollToChild(but)
		end
	end
end

McPhone.EnterPress = function()
	if McPhone.UI and snap < CurTime() then
		snap = CurTime() + 0.2

		if McPhone.AcceptCall then
			McPhone.AcceptCall()
		end

		if McPhone.UI.Buttons.Middle[3] and not McPhone.UI.Buttons.Middle[4] then
			McPhone.UI.Buttons.Middle[3]()

			return
		end

		local but = McPhone.UI.Menu:GetItems()[McPhone.key]
		local supress

		if IsValid(but) and not but.unused then
			supress = but:DoClick()
		end

		if not supress then
			McPhone.key = 1
			but = McPhone.UI.Menu:GetItems()[McPhone.key]

			if IsValid(but) and not but.unused then
				but:OnCursorEntered()
			end
		end
	end
end

local function SwipeRight()
	if McPhone.UI and snap < CurTime() then
		if #McPhone.UI.Menu:GetItems() <= 1 then
			McPhone.UI.Menu:OnMouseWheeled(-1)
			return
		end
		McPhone.key = McPhone.key + 1

		if McPhone.key > #McPhone.UI.Menu:GetItems() then
			McPhone.key = 1
		end

		snap = CurTime() + 0.2
		local but = McPhone.UI.Menu:GetItems()[McPhone.key]

		if IsValid(but) and not but.unused then
			but:OnCursorEntered()
			McPhone.UI.Menu:ScrollToChild(but)
		end
	end
end

local function SwipeLeft()
	if McPhone.UI and snap < CurTime() then
		if #McPhone.UI.Menu:GetItems() <= 1 then
			McPhone.UI.Menu:OnMouseWheeled(1)
			return
		end
		McPhone.key = McPhone.key - 1

		if McPhone.key < 1 then
			McPhone.key = #McPhone.UI.Menu:GetItems()
		end

		snap = CurTime() + 0.2
		local but = McPhone.UI.Menu:GetItems()[McPhone.key]

		if IsValid(but) and not but.unused then
			but:OnCursorEntered()
			McPhone.UI.Menu:ScrollToChild(but)
		end
	end
end

local function MiddlePress()
	if McPhone.UI.Buttons.Left[3] and snap < CurTime() then
		snap = CurTime() + 0.2
		McPhone.UI.Buttons.Left[3]()
		McPhone.key = 1
		local but = McPhone.UI.Menu:GetItems()[McPhone.key]

		if IsValid(but) and not but.unused then
			but:OnCursorEntered()
		end
	end
end

local press_d = 0
local open, c_p, o_p
CreateClientConVar("pradio_key", KEY_P, true, false)

local ct = {
	"class",
	"phone_type",
	"model",
	"name",
}

local function compare(a, b)
	for _, v in ipairs(ct) do
		if a[v] ~= b[v] then
			return false
		end
	end

	return true
end

hook.Add("Think", "McPhone.Think", function()
	local CT = CurTime()
	open, c_p = McPhone.HasPhone(ply)

	if McPhone.OnCall and McPhone.UI and isnumber(McPhone.OnCall) and McPhone.OnCall < CT then
		McPhone.OpenMainMenu()
	end

	if c_p and o_p and c_p ~= o_p and compare(c_p, o_p) then
		o_p = c_p
	end

	if McPhone.UI and (not McPhone.CanUsePhone(ply) or (c_p and o_p and c_p ~= o_p)) then
		McPhone.ClosePhone()
		snap = CT + 0.2
		o_p = nil
		return
	end

	if ply:IsTyping() then return end
	if gui.IsConsoleVisible() then return end
	if gui.MousePos() > 0 then return end

	if GAMEMODE.RadioTeams[LocalPlayer():Team()] and LocalPlayer():getDarkRPVar("rc_on") and press_d + 1 < CT and input.IsKeyDown(GetConVar("pradio_key"):GetInt() or KEY_P) then
		net.Start("Police.Radio")
		net.WriteUInt(LocalPlayer():getDarkRPVar("rc_speek") and 4 or 3, 3)
		net.SendToServer()
		press_d = CT
	end

	if not open then return end
	o_p = c_p

	if (input.IsKeyDown(McPhone.UserCfg.Binds.up) or (not McPhone.UI and McPhone.UserCfg.UseMouse and input.IsMouseDown(McPhone.UserCfg.MiddlePress))) and snap < CT then
		if not McPhone.UI then
			McPhone.LoadAddons()
			McPhone.Open(1)
			snap = CT + 0.2
		else
			if McPhone.UI and McPhone.UI.Menu then
				if McPhone.UI.Menu.List then
					SwipeLeft()
				else
					SwipeUp()
				end
			end
		end
	end

	if McPhone.UI and McPhone.UI.Menu and not McPhone.UI.Closing then
		if (input.IsKeyDown(McPhone.UserCfg.Binds.back)) and snap < CT then
			McPhone.GoBack()
		end

		if (input.IsKeyDown(McPhone.UserCfg.Binds.click)) and snap < CT then
			McPhone.EnterPress()
		end

		if (input.IsKeyDown(McPhone.UserCfg.Binds.right)) and snap < CT then
			SwipeRight()
		end

		if (input.IsKeyDown(McPhone.UserCfg.Binds.left)) and snap < CT then
			SwipeLeft()
		end

		if (input.IsKeyDown(McPhone.UserCfg.Binds.click2) or (McPhone.UserCfg.UseMouse and input.IsMouseDown(McPhone.UserCfg.MiddlePress))) and snap < CT then
			MiddlePress()
		end

		if (input.IsKeyDown(McPhone.UserCfg.Binds.down)) and snap < CT then
			if McPhone.UI.Menu.List then
				SwipeRight()
			else
				SwipeDown()
			end
		end
	end

	if (input.IsKeyDown(McPhone.UserCfg.Binds.close) or input.IsKeyDown(KEY_ESCAPE)) and snap < CT then
		McPhone.ClosePhone()
	end
end)

local phone_types = {
	[1] = {"models/mactavish/mactavish_phone.mdl", Vector(4.2, 1.3, -2.2), Angle(-5, -8, -30)},
	[2] = {"models/mactavish/bg_phone.mdl", Vector(4.5, 1, 1), Angle(-5, -8, -30)},
	[3] = {"models/mactavish/lm_phone.mdl", Vector(4.2, 0.8, 1), Angle(-5, -8, -30)},
	[4] = {"models/props_trainstation/payphone_reciever001a.mdl", Vector(-10, 4.2, -16.5), Angle(-30, 90, 20)},
	[5] = {"models/cityrp/se_phone.mdl", Vector(-3, -3, -1), Angle(-50, 180, -50)},
	[6] = {"models/cityrp/camphone.mdl", Vector(1, 4.5, 1), Angle(0, 30, 0)},
	[7] = {"models/props_electronics/cellphone-5.mdl", Vector(-2, -4.7, -3), Angle(-70, 180, -40)},
}

McPhone.AcitiveCheck = function(p)
	if IsValid(McPhone.OverlayMenu) and p == ply then return McPhone.OverlayMenu.PhoneType or 2 end

	return p:getDarkRPVar("McPhone.Active") or 0
end

hook.Add("PostPlayerDraw", "McPhone.PostPlayerDraw", function(Ply)
	if not McPhone.Config.Draw3DModel then return end
	if not Ply:IsValid() then return end

	if McPhone.AcitiveCheck(Ply) > 0 then
		local Source = IsValid(ovr) and ovr or Ply
		local Bone = Source:LookupBone("ValveBiped.Bip01_L_Hand")

		if not Bone then
			if Ply.McPhoneModel then
				Ply.McPhoneModel:Remove()
				Ply.McPhoneModel = nil
			end

			return
		end

		local mat = Source:GetBoneMatrix(Bone)
		local phone_t = phone_types[Ply:getDarkRPVar("McPhone.Type") or 5]

		if mat and phone_t then
			local pos, ang = mat:GetTranslation(), mat:GetAngles()
			local color = Ply:GetNW2Vector("McPhone.Color")

			if McPhone.AcitiveCheck(Ply) == 3 then
				phone_t = phone_types[4]
				color = nil
			end

			local pos2 = phone_t[2]
			local angle = phone_t[3]
			local LocalPhone = Ply.McPhoneModel
			ang:RotateAroundAxis(ang:Up(), angle.y)
			ang:RotateAroundAxis(ang:Right(), angle.p)
			ang:RotateAroundAxis(ang:Forward(), angle.r)

			if IsValid(LocalPhone) and phone_t[1] ~= LocalPhone:GetModel() then
				LocalPhone:Remove()
				Ply.McPhoneModel = nil
				LocalPhone = nil

				return
			end

			if not IsValid(LocalPhone) then
				LocalPhone = ClientsideModel(phone_t[1], RENDERGROUP_OPAQUE)
				LocalPhone:SetNoDraw(true)
				Ply.McPhoneModel = LocalPhone
			end

			LocalPhone:SetPos(pos + ang:Forward() * pos2.x + ang:Right() * pos2.y + ang:Up() * pos2.z)
			LocalPhone:SetAngles(ang)

			if color then
				LocalPhone:SetColor(Color(color.x, color.z, color.y))
				render.SetColorModulation(color.x / 255, color.z / 255, color.y / 255)
			end

			LocalPhone:DrawModel()
			render.SetColorModulation(1, 1, 1)
		else
			if IsValid(Ply.McPhoneModel) then
				Ply.McPhoneModel:Remove()
				Ply.McPhoneModel = nil
			end
		end
	elseif IsValid(Ply.McPhoneModel) then
		Ply.McPhoneModel:Remove()
		Ply.McPhoneModel = nil
	end
end)

McPhone.HudNotification = function() end
McPhone.HudGPS = function() end

McPhone.ToggleGPS = function(name, pos)
	if McPhone.IsGPSOn then
		McPhone.IsGPSOn = nil
		McPhone.HudGPS = function() end

		if McPhone.GPSMenuRebuild and McPhone.UI then
			McPhone.GPSMenuRebuild()
		end

		McPhone.GPSMenuRebuild = nil
	else
		if not name or not pos then return end
		McPhone.IsGPSOn = name
		McPhone.GPSTimer = CurTime()
		local alpha = 0

		McPhone.HudGPS = function()
			if LocalPlayer():GetPos().z < -4500 then return end
			local dist = ply:GetPos():Distance(pos) * 0.75 / 25.4
			local screenpos = pos:ToScreen()
			local w = ScrW()
			local x, y = screenpos.x, screenpos.y - 50

			-- if dist < 20 then
			-- 	x, y = Lerp(1 - dist / 20, x, w / 2), Lerp(1 - dist / 20, y, 200)
			-- end
			if x < w / 4 or x > w - w / 4 then
				alpha = Lerp(FrameTime() * 7, alpha, 0)

				if x < 30 then
					x = 30
				end
			else
				alpha = Lerp(FrameTime() * 7, alpha, 255)
			end

			if y < 50 then
				y = 50
			end

			if x > ScrW() - 64 then
				x = ScrW() - 64
			end

			if y > ScrH() - 64 then
				y = ScrH() - 64
			end

			McPhone.DrawTexturedRect(x - 32, y - 30, 64, 64, "mc_phone/icons/gps.png", Color(0, 0, 0, 200))
			McPhone.DrawTexturedRect(x - 32, y - 32, 64, 64, "mc_phone/icons/gps.png", Color(255, 200, 100, 255))
			draw.SimpleTextOutlined(name, "McPhone.Main32", x + 30, y - 30, Color(255, 200, 100, alpha), TEXT_ALIGN_LEFT, 0, 1, Color(0, 0, 0, alpha))
			draw.SimpleTextOutlined(math.floor(dist) .. " m", "McPhone.Main28", x + 30, y, Color(255, 255, 255, alpha), TEXT_ALIGN_LEFT, 0, 1, Color(0, 0, 0, alpha))

			if dist < 5 and McPhone.GPSTimer + 5 < CurTime() then
				McPhone.ToggleGPS()
				McPhone.Notify("GPS", McPhone.GetPhrase("point_reached"), true)
			end
		end
	end
end

McPhone.SetGPS = function(name, pos)
	if McPhone.IsGPSOn then
		McPhone.IsGPSOn = nil
	end

	McPhone.ToggleGPS(name, pos)
end

hook.Add("HUDPaint", "McPhone.HUDPaint", function()
	McPhone.HudGPS()
end)

-- if McPhone.UI then
-- 	local w, h = ScrW(), ScrH()
-- 	local m = Matrix()
-- 	local center = Vector( w - McPhone.UI:GetWide() - 25, h - McPhone.UI:GetTall() + 25 )
-- 	m:Translate( center )
-- 	m:Rotate(Angle(0, 0, 0))
-- 	m:Scale(Vector(1, 1, 1))
-- 	--m:Translate( -center )
-- 	cam.PushModelMatrix( m )
-- 		McPhone.UI:PaintManual()
-- 	cam.PopModelMatrix()
-- end
hook.Add("DrawOverlay", "McPhone.HUDPaint", function()
	McPhone.HudNotification()
end)

local bind_block = {
	["+attack"] = true,
	["+attack2"] = true,
	["invprev"] = true,
	["invnext"] = true,
	["+jump"] = true,
}

hook.Add("PlayerBindPress", "McPhone.PlayerBindPress", function(Ply, bind, pressed)
	if McPhone.UI and not McPhone.UI.Closing then
		if gui.MousePos() > 0 then return end

		if McPhone.UI.Buttons.Left[3] and McPhone.UserCfg.Binds.click2 == KEY_SPACE then
			bind_block["+jump"] = true
		else
			bind_block["+jump"] = false
		end

		if bind_block[bind] and McPhone.UserCfg.UseMouse then
			if snap < CurTime() then
				if bind == "invprev" then
					SwipeLeft()
				end

				if bind == "invnext" then
					SwipeRight()
				end

				if bind == "+attack" then
					McPhone.EnterPress()
				end

				if bind == "+attack2" then
					McPhone.GoBack()
				end

				snap = CurTime() + 0.2
			end

			return true
		end
	end
end)

local spkmode = {
	[1] = 0.29,
	[2] = 0.78,
	[3] = 0.62,
}

hook.Add("UpdateAnimation", "McPhone.UpdateAnimation", function(Ply)
	if not McPhone.Config.Draw3DModel then return end
	Ply.PhoneGestureWeight = Ply.PhoneGestureWeight or 0
	if (Ply:IsPlayingTaunt()) then return end

	if Ply:getDarkRPVar("rc_speek") and ply:IsSpeaking() then
		Ply.PhoneGestureWeight = math.Approach(Ply.PhoneGestureWeight, 0.8, FrameTime() * 3)
	else
		Ply.PhoneGestureWeight = math.Approach(Ply.PhoneGestureWeight, spkmode[McPhone.AcitiveCheck(Ply)] or 0, FrameTime() * 1.5)
	end

	if (Ply.PhoneGestureWeight > 0) then
		Ply:AnimRestartGesture(GESTURE_SLOT_VCD, ACT_GMOD_IN_CHAT, true)
		Ply:AnimSetGestureWeight(GESTURE_SLOT_VCD, Ply.PhoneGestureWeight)
	end
end)