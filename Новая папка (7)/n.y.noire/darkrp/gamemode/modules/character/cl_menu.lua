--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/character/cl_menu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local origin, angles, fov = Vector(0, 0, 0), Angle(0, 0, 0), 90
local SW, SH = ScrW(), ScrH()
local center_gradient = Material("gui/center_gradient.vtf", "smooth")
local color_red = Color(231, 0, 0)
local star = Material("gmodla/star2.png", "smooth")

local color_b50 = Color(0,0,0,150)
local color_w50 = Color(255,255,255,150)

MCR.FirstLoad = MCR.FirstLoad or 1

local unload_char = function(s, id, c_id)
	if (IsValid(s.Menu)) then
		s.Menu:Remove()
		s.Menu = nil
	end
	s.Menu = MSD.MenuOpen(false, s)
	s.Menu:AddOption("Удалить", function()
		net.Start("MCR.Select")
			net.WriteUInt(0, 3)
			net.WriteUInt(id, 3)
			net.WriteUInt(c_id, 16)
			net.WriteBool(false)
		net.SendToServer()
	end)
	local x, y = s:LocalToScreen(0, s:GetTall())
	s.Menu:SetMinimumWidth(s:GetWide())
	s.Menu:Open(x, y, false, s)
end

function MCR.Blur( panel, inn, density, alpha, x, y, w, h)
	local strength = (3 / inn) * density

	if w and h then
		MSD.DrawBlur(x, y, w, h, strength, nil, alpha)
	else
		MSD.BlurPanel(panel, strength, nil, nil, alpha)
	end
end

function MCR.CharacterButton(parent, x, y, wd, hd, text, func, color, text2, func2, func3)
	local button = vgui.Create("DButton")
	button:SetText("")

	if x and y then
		button:SetParent(parent)
		button:SetPos(x, y)
	end

	if x == "static" then
		button.StaticScale = { w = wd, fixed_h = hd, minw = 150, minh = hd}
	else
		button:SetSize(wd, hd)
	end

	button.alpha = 0
	button.text = text
	button.color_idle = color_white

	button.Paint = function(self, w, h)
		if self.hover and not self.disable then
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 0)
		end

		MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
		draw.DrawText(self.text, "Noire.30", 5, h / 2 - 5, MSD.ColorAlpha(self.color_idle, 250 - self.alpha * 250), TEXT_ALIGN_LEFT)

		if self.alpha > 0.01 then
			draw.DrawText(self.text, "Noire.30",5, h / 2 - 5, MSD.ColorAlpha(color or MSD.Config.MainColor["p"], self.alpha * 255), TEXT_ALIGN_LEFT)
		end

		if text2 then
			draw.DrawText(text2, "MSDFont.20", 5, 5, MSD.Text.d, TEXT_ALIGN_LEFT)
		end
	end

	button.OnCursorEntered = function(self)
		self.hover = true
		if func3 then func3(self) end
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	button.DoClick = function(self)
		if self.disable then return end
		func(self)
	end

	button.DoRightClick = function(self)
		if self.disable or not func2 then return end
		func2(self)
	end

	if not x or not y then
		parent:AddItem(button)
	end

	return button
end

local gmodla = Material("gmodla/logo_c2.png", "smooth")
local gmodla2 = Material("gmodla/logo_c1.png", "smooth")
local glass = Material("gmodla/glass.png", "smooth")

local function rtable(top)
	return top[math.random(#top)]
end

function MCR.OpenLoadingMenu()
	local camera, progress = false, false
	local camera_time = 0

	local camera_state = #MCR.Config.Cams
	local camera_time_max = 15
	local reset = true

	local BounceAnim = MSD.Anim(1.1, "OutBounce")
	local PlayAnim = MSD.Anim(1.1)
	local ScrAnim = MSD.Anim(5)
	ScrAnim:Reverse()
	ScrAnim.Value = 1

	local Main = vgui.Create("DFrame")
	Main:SetSize(SW, SH)
	Main:SetTitle("")
	Main:SetVisible(true)
	Main:SetDraggable(false)
	Main:ShowCloseButton(false)
	Main:Center()
	Main:MakePopup()
	MCR.LocadingMenu = Main
	Main.OnClose = function(self)
		MCR.LocadingMenu = nil
		if not LocalPlayer():getDarkRPVar("BANNED") then
			net.Start("MCR.Camera")
			net.WriteInt(0, 3)
			net.SendToServer()
			MCR.OpenCharacterCreator()
		else
			MCR.OpenBanMenu()
		end
	end

	local inner = circles.New(CIRCLE_FILLED, 8, SW / 2, SH / 2)
	inner:SetMaterial(true)
	inner:SetColor(color_black)

	local outer = circles.New(CIRCLE_FILLED, 8, SW / 2, SH / 2)
	outer:SetMaterial(true)
	outer:SetColor(Color(0,0,0,200))

	Main.Paint = function(self, w, h)
		if not progress or not camera then
			MSDX.Draw(0, 0, 0, w, h, color_black)
		else
			MSDX.Draw(0, 0, h / 2 - 60, w, 180, color_b50)
			MCR.Blur(self, 2, 2, 255, 0, h / 2 - 60, w, 180)
		end

		if camera then
			MSDX.Draw(0, 0, 0, w, h, MSD.ColorAlpha(color_black, 255 * ScrAnim.Value))
		end

		if Main.Closing then
			PlayAnim:Play()
			BounceAnim:Play()

			outer:SetRadius(math.max(SW * PlayAnim.Value * 2, 1))
			outer()

			inner:SetRadius(math.max(SW * PlayAnim.Value, 1))
			inner()

			draw.DrawText("Нажмите ЛКМ чтобы продолжить", "Noire.32", w / 2, (h / 2 + 55) + ((h / 2 - 55) * BounceAnim.Value), MSD.ColorAlpha(color_white, 255 * (1 - PlayAnim.Value)), TEXT_ALIGN_CENTER)
		end

		self.ctime = math.Clamp((camera_time - CurTime()) / camera_time_max, 0, 1)
		surface.SetMaterial(gmodla)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(w / 2 - 200, h / 2 - 80, 400, 161)

		self.text = Main.Closing and "Загрузка.." or "Нажмите ЛКМ чтобы продолжить"
		MSD.ShadowText(self.text, "Noire.32", w / 2, h / 2 + 55, MSD.ColorAlpha(color_white, 100 + math.abs(math.sin(CurTime() * 3)) * 155), TEXT_ALIGN_CENTER, 2, color_b50)
	end

	local function CamChange()
		camera_time = CurTime() + camera_time_max

		if camera_state + 1 > #MCR.Config.Cams then
			camera_state = 1
		else
			camera_state = camera_state + 1
		end

		local cdata = MCR.Config.Cams[camera_state]
		net.Start("MCR.Camera")
		net.WriteInt(camera_state, 3)
		net.SendToServer()
		origin, angles, fov = cdata.st.pos, cdata.st.ang, cdata.st.fov
		reset = false
	end

	function PlayAnim:Done(reverced)
		Main:Close()
	end

	function ScrAnim:Done(reverced)
		self:Reverse()
		if not reverced then CamChange() self:Reset() end
	end

	Main.Think = function(self, w, h)
		if MCR.Sound and MCR.Sound:GetState() == GMOD_CHANNEL_STOPPED and MCR.Loaded then
			MCR.Sound:SetTime(0)
			MCR.Sound:Play()
		end

		if camera then
			ScrAnim:Play()

			local cdata_m = MCR.Config.Cams[camera_state]
			origin = LerpVector(FrameTime() * (cdata_m.ed.spd * 0.1), origin, cdata_m.ed.pos)
			angles = LerpAngle(FrameTime() * (cdata_m.ed.aspd * 0.1), angles, cdata_m.ed.ang)
			fov = Lerp(FrameTime() * (cdata_m.ed.spd * 0.1), fov, cdata_m.ed.fov)

			if not reset and (camera_time < CurTime()) and not Main.Closing then
				reset = true
				ScrAnim:Reset()
			end
		end
	end

	local EnterButton = vgui.Create("DButton", Main)
	EnterButton:SetText("")
	EnterButton:SetPos(0, 0)
	EnterButton:SetCursor("blank")
	EnterButton:SetSize(SW, SH)
	EnterButton.fader = 1
	EnterButton.Paint = function(self, w, h)
	end
	EnterButton.OnCursorEntered = function(self)
		self.hover = true
	end
	EnterButton.OnCursorExited = function(self)
		self.hover = false
	end
	EnterButton.DoClick = function()
		if not MCR.PlayerData or Main.Closing then return end
		if not progress then
			progress = true

			if (IsValid(MCR.Sound)) then
				MCR.Sound:Play()
				MCR.Sound:SetVolume(0.6)
				MCR.Loaded = true
			end

			ScrAnim:Reset()
			CamChange()
			camera = true
		else
			Main.Closing = true
			PlayAnim:Reset()
			BounceAnim:Reset()
		end
	end

	EnterButton.DoRightClick = function(self)
		self:DoClick()
	end

	sound.PlayURL("https://macnco.one/music/jazz/" .. math.random(4) .. ".mp3", "noblock noplay", function( station )
		if ( IsValid( station ) ) then
			MCR.Sound = station
		end
	end)
end

local function CreateDLight()
	if MCR.dlight then
		MCR.dlight.DieTime = CurTime() + FrameTime()
	end

	MCR.dlight = DynamicLight(LocalPlayer():EntIndex())
	MCR.dlight.r = 255
	MCR.dlight.g = 255
	MCR.dlight.b = 255
	MCR.dlight.Brightness = 3
	MCR.dlight.Pos = MCR.Config.CharP["main"][1] + Vector(0,0,120)
	MCR.dlight.Size = 100
	MCR.dlight.DieTime = CurTime() + 12000
end

local function AddPackPromo(p)
	local ipack = Glac.Packs[p]
	if not ipack then return end

	local pack = vgui.Create("DPanel")
	pack.StaticScale = { w = 1, fixed_h = 280, minw = 10, minh = 80}
	pack.Paint = function(self, w, h)
		if ipack.icon and not istable(ipack.icon) then
			local x, y = size, size
			if ipack.icon_size then
				x, y = ipack.icon_size[1], ipack.icon_size[2]
				local ar = y / x
				x, y = w, w * ar
				pack.StaticScale.fixed_h = w * ar
			end
			MSD.DrawTexturedRect(0, 0, x, y, ipack.icon, color_white)
		end
	end

	return pack
end

local char = {}

function MCR.CUModel(gn, model, eye, face, suit)
	if MCR.Char then
		MCR.Char:Remove()
	end

	if not model then
		model = gn == "female" and  math.random(6) or math.random(9)
		char.model = model
	end

	if not suit then
		suit = {}
		suit.top = rtable(MCR.randomtop[gn])
		suit.pants = rtable(MCR.randompants[gn])
		char.suit = suit
	end
	if not eye then eye = math.random(5) char.eye = eye end

	local smodel = "models/cityrp/pm/normal/" .. gn .. "_0" .. model .. ".mdl"

	if not util.IsValidModel(smodel) then return true end

	MCR.Char = ClientsideModel(smodel, RENDERGROUP_OPAQUE)
	MCR.Char:SetPos(MCR.Config.CharP["main"][1])
	MCR.Char:SetAngles(MCR.Config.CharP["main"][2])
	MCR.Char.suit = false
	MCR.Char:ResetSequence("pose_standing_02")
	MCR.Char:DrawModel()

	if not face then
		face = math.random(MCR.FaceRawMX[MCR.GetMDL(MCR.Char)])
		char.face = face
	end

	MCR.SetFaceMatID(MCR.Char, face)
	MCR.SetEyeMatID(MCR.Char, eye)

	MCR.ApplySkinData(MCR.Char, char)
end

function MCR.CreatePlayerModel(ply)

	if MCR.Char then
		MCR.Char:Remove()
	end

	MCR.Char = ClientsideModel(ply:GetModel(), RENDERGROUP_OPAQUE)
	MCR.Char:SetPos(MCR.Config.CharP["shop"][1])
	MCR.Char:SetAngles(MCR.Config.CharP["shop"][2])
	MCR.Char.suit = string.find(ply:GetModel(), "suit")

	MCR.Char:ResetSequence("pose_standing_02")
	MCR.Char:DrawModel()

	for k, skin in pairs(ply:GetMaterials()) do
		MCR.Char:SetSubMaterial(k - 1, ply:GetSubMaterial(k - 1))
	end

	for _, v in pairs(ply:GetBodyGroups()) do
		MCR.Char:SetBodygroup(v.id, ply:GetBodygroup(v.id))
	end
end

function MCR.RemoveCharacters()
	if not MCR.CharModels then return end
	for k,v in pairs(MCR.CharModels) do
		if IsValid(v) then
			v:Remove()
			MCR.CharModels[k] = nil
		end
	end
end

local standing_pose = {
	[1] = {"pose_standing_01", "pose_standing_02"},
	[2] = {"menu_combine", "menu_combine"},
	[3] = {"pose_standing_01", "pose_standing_02"}
}

function MCR.CreteCharacters()
	MCR.RemoveCharacters()
	if not MCR.CharModels then MCR.CharModels = {} end

	for k, data in pairs(MCR.PlayerData) do
		if not data then continue end


		MCR.CharModels[k] = ClientsideModel("models/cityrp/pm/normal/" .. data.gender .. "_0" .. data.model .. ".mdl", RENDERGROUP_OPAQUE)
		MCR.CharModels[k]:SetPos(MCR.Config.CharP[k][1])
		MCR.CharModels[k]:SetAngles(MCR.Config.CharP[k][2])

		MCR.SetFaceMatID(MCR.CharModels[k], data.face)
		MCR.SetEyeMatID(MCR.CharModels[k], data.eye)
		MCR.ApplySkinData(MCR.CharModels[k], data)

		MCR.CharModels[k]:ResetSequence(standing_pose[k][math.random(#standing_pose[k])])
		MCR.CharModels[k]:DrawModel()
	end
end

function MCR.OpenCharacterCreator()
	local gp = Vector(0,0,0)
	local cc = MCR.Config.MainCam
	local cm = MCR.Config.CharCam
	local chc = MCR.Config.CharC
	local cam_switch = false
	local cur_char = 1
	local switch_pos = 0
	local char1 = MCR.PlayerData[1]
	local char2 = MCR.PlayerData[2]
	local char3 = MCR.PlayerData[3]

	origin, angles, fov = cc.pos + gp, cc.ang, 75

	local cur_cc = {
		pos = origin,
		ang = angles,
		ang_change = 0.1
	}

	char = {
		model = "",
		name = "",
		sname = "",
		gender = "",
		eye = 1,
		face = 1,
		suit = {},
	}

	local pages = {}
	local DoSwitch = function()
	end

	local nextchange = 0
	local changeangl = Angle(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3))
	local focus_v = Vector(0,0,0)

	net.Start("MCR.AddPVS")
		net.WriteUInt(1, 4)
	net.SendToServer()

	local chb2, chb3

	local Main = vgui.Create("DFrame")
	Main:SetSize(SW, SH)
	Main:SetTitle("")
	Main:SetVisible(true)
	Main:SetDraggable(false)
	Main:ShowCloseButton(false)
	Main:Center()
	Main:MakePopup()
	MCR.LocadingMenu = Main
	Main.OnClose = function(self)
		DarkRP.UIEffects["blackScreen"]({true, false})

		if MCR.Sound then
			MCR.Sound:Stop()
			MCR.Sound = nil
		end

		if MCR.dlight then
			MCR.dlight.DieTime = CurTime() + FrameTime()
			MCR.dlight = nil
		end
		if IsValid(MCR.Char) then
			MCR.Char:Remove()
			MCR.Char = nil
		end
		MCR.RemoveCharacters()
		MCR.LocadingMenu = nil

		net.Start("MCR.AddPVS")
		net.WriteUInt(0, 4)
		net.SendToServer()
	end
	Main.Paint = function(self, w, h)
		if switch_pos > 0 then
			MSDX.Draw(0, 0, 0, w, h, MSD.ColorAlpha(color_black, math.min(switch_pos, 1) * 255))
		end
	end
	Main.Think = function(self, w, h)
		if MCR.Sound and MCR.Sound:GetState() == GMOD_CHANNEL_STOPPED and MCR.Loaded then
			MCR.Sound:SetTime(0)
			MCR.Sound:Play()
		end

		if cam_switch and switch_pos == 1.3 then
			cam_switch = false
			DoSwitch()
			net.Start("MCR.AddPVS")
				net.WriteUInt(cur_char, 4)
			net.SendToServer()
		end

		if cam_switch then
			switch_pos = math.Approach(switch_pos, 1.3, FrameTime() * 2)
		else
			switch_pos = math.Approach(switch_pos, 0, FrameTime() * 2)
		end

		if nextchange < CurTime() and not cur_cc.ang_changed then
			changeangl = Angle(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3))
			nextchange = CurTime() + math.random(2)
		end

		if cur_cc.ang_changed and cur_cc.ang_changed < CurTime() then
			cur_cc.ang_change = 0.1
			cur_cc.ang_changed = nil
		end

		angles = LerpAngle(FrameTime() * cur_cc.ang_change, angles, cur_cc.ang + changeangl)
		origin = LerpVector(FrameTime() * 2, origin, cur_cc.pos + focus_v)

		if MCR.Char then
			local mx, my = gui.MousePos()
			my = 1 - (SH - my) / (SH / 2)
			mx = 1 - (SW - mx) / (SW / 2)
			MCR.Char:SetEyeTarget(origin - Vector(0,mx * -20, my * 20) )

			local hd = MCR.Char:LookupBone("ValveBiped.Bip01_Head1")
			MCR.Char:ManipulateBoneAngles( hd, Angle(0,my * -7, mx * 7) )
		end

		local pt = sAdmin.mcTime(LocalPlayer())

		if IsValid(chb2) then
			if not char2 then
				if pt < MCR.Config.TimeNeed[2] then
					chb2.text = "Откроется через " .. sAdmin.formatTime(MCR.Config.TimeNeed[2] - pt, true)
					chb2.disable = true
				else
					chb2.disable = false
				end
			elseif LocalPlayer():getDarkRPVar("karma") and LocalPlayer():getDarkRPVar("karma") < 40 then
				chb2.text = "Заблокирован - низкий рассудок"
				chb2.disable = true
			elseif LocalPlayer():getDarkRPVar("gosban") then
				chb2.text = "Заблокирован - " .. sAdmin.formatTime(LocalPlayer():getDarkRPVar("gosban") - os.time(), true)
				chb2.disable = true
			elseif chb2.disable then
				chb2.text = char2.fname .. " " .. char2.sname
				chb2.disable = false
			end
		end

		if IsValid(chb3) then
			if not char3 then
				if pt < MCR.Config.TimeNeed[3] then
					chb3.text = "Откроется через " .. sAdmin.formatTime(MCR.Config.TimeNeed[3] - pt, true)
					chb3.disable = true
				else
					chb3.disable = false
				end
			elseif LocalPlayer():getDarkRPVar("karma") and LocalPlayer():getDarkRPVar("karma") < 40 then
				chb3.text = "Заблокирован - низкий рассудок"
				chb3.disable = true
			elseif LocalPlayer():getDarkRPVar("ganban") then
				chb3.text = "Заблокирован - " .. sAdmin.formatTime(LocalPlayer():getDarkRPVar("ganban") - os.time(), true)
				chb3.disable = true
			elseif chb3.disable then
				chb3.text = char3.fname .. " " .. char3.sname
				chb3.disable = false
			end
		end
	end
	Main.UpdateModel = function(gn, model_id, par)
		CreateDLight()
		local err = MCR.CUModel(gn)

		if err then
			local panel = vgui.Create("DPanel", Main)
			panel:SetSize(SW, SH)
			panel:Center()
			panel.Paint = function(self, w, h)
				MSD.Blur(self, 2, 2, 255)
				MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
				surface.SetDrawColor(0, 0, 0, 170)
				surface.SetMaterial(center_gradient)
				surface.DrawTexturedRectRotated(w / 2, h / 8, 250, w + 200, -90)
				local _, hd = draw.SimpleTextOutlined("Внимание", "MSDFont.Biger", w / 2, h / 8 - 50, color_red, TEXT_ALIGN_CENTER, 0, 1, color_black)

				draw.SimpleTextOutlined("У вас нет необходимого контента для игры!", "MSDFont.32", w / 2, h / 8 + hd - 50,  color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
				draw.SimpleTextOutlined("Загрузите контент и повторно подключитесь к серверу", "MSDFont.24", w / 2, h / 8 + hd - 15,  color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
			end

			MSD.ButtonIcon(panel, SW / 2 - SW / 6, SH / 2, SW / 3, 60, "Скачать контент", MSD.PinPoints[9], function() gui.OpenURL("https://steamcommunity.com/workshop/filedetails/?id=456384788") end)
			MSD.ButtonIcon(panel, SW / 2 - SW / 6, SH / 2 + 70, SW / 3, 60, "Отключиться", MSD.Icons48.cross, function() RunConsoleCommand("disconnect") end)
			return err
		end
	end

	local panel = vgui.Create("DPanel", Main)
	panel:SetSize(SW / 4.5, SH - SH / 3)
	panel:SetPos(50, 50)
	panel.text = "Выбор персонажа"
	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, 120, color_black)
		local logo_h = 90
		MSD.DrawTexturedRect(5, 0, logo_h * 1.91, logo_h, gmodla2, color_white)

		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 71, color_black, TEXT_ALIGN_RIGHT)
		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 70, color_white, TEXT_ALIGN_RIGHT)
		MSD.DrawTexturedRect(0, 0, w, 120, glass, color_w50)
	end

	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(panel:GetWide(), panel:GetTall() - 120)
	panel.Menu:SetPos(0, 120)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(true)
	panel.Menu:SetPadding(5)
	panel.Menu:SetSpacing(5)
	panel.Menu.IgnoreVbar = true
	panel.Menu.Paint = function(self, w, h)
		local ch = MCR.Config.Texts[cur_char or 1]
		local tw, hd, ht =  "", 0, self:GetCanvas():GetTall()
		if ch then
			tw, _, hd = MSD.TextWrap(ch.descr, "MSDFont.22", w - 20)
		end

		MSD.Blur(self, 2, 2, 255, 20, w, hd + ht + 20)
		MSDX.Draw(0, 0, 0, w, hd + ht + 20, color_b50)

		if ch then
			draw.DrawText(tw, "MSDFont.22", 10, ht + 10, color_black, TEXT_ALIGN_LEFT)
			draw.DrawText(tw, "MSDFont.22", 10, ht + 10, MSD.Text.d, TEXT_ALIGN_LEFT)
		end
	end

	panel.ExtraMenu = vgui.Create("MSDPanelList", Main)
	panel.ExtraMenu:SetSize(SW / 4.5, SH - SH / 3)
	panel.ExtraMenu:SetPos(SW - SW / 4.5 - 50, 50)
	panel.ExtraMenu:EnableVerticalScrollbar()
	panel.ExtraMenu:EnableHorizontal(true)
	panel.ExtraMenu:SetPadding(5)
	panel.ExtraMenu:SetSpacing(5)
	panel.ExtraMenu.IgnoreVbar = true
	panel.ExtraMenu.Paint = function(self, w, h)
		if #self:GetItems() < 1 then return end
		local ht = self:GetCanvas():GetTall()

		MSD.Blur(self, 2, 2, 255, 20, w, ht + 5)
		MSDX.Draw(0, 0, 0, w, ht + 5, color_b50)
	end

	pages["main"] = function()
		if IsValid(MCR.Char) then
			MCR.Char:Remove()
			MCR.Char = nil
		end

		char1 = MCR.PlayerData[1]
		char2 = MCR.PlayerData[2]
		char3 = MCR.PlayerData[3]

		MCR.CreteCharacters()

		panel.Menu:Clear()
		panel.ExtraMenu:Clear()

		if MCR.ExtraPlayerData then
			MSD.InfoHeader(panel.ExtraMenu, "Дополнительные персонажи")
			for id, data in pairs(MCR.ExtraPlayerData) do
				for c_id, chare in ipairs(data) do
					MCR.CharacterButton(panel.ExtraMenu, "static", nil, 1, 55, chare.fname .. " " .. chare.sname, function(s)
						net.Start("MCR.Select")
							net.WriteUInt(0, 3)
							net.WriteUInt(id, 3)
							net.WriteUInt(c_id, 16)
							net.WriteBool(true)
						net.SendToServer()
					end, MSD.Patern.MainColor["p"], MCR.Config.Texts[id].name, function(s)
						unload_char(s, id, c_id)
					end)
				end
			end
		end

		changeangl = Angle(0,0,0)
		cur_cc.ang_changed = CurTime() + 2
		cur_cc.ang_change = 2
		cur_cc.pos = cc.pos + gp
		cur_cc.ang = cc.ang
		cur_char = 1

		panel.text = "Выбор персонажа"

		local ch_tk = MQS.GetDataStored(LocalPlayer(), "mcr_change")
		local sv_tk = MQS.GetDataStored(LocalPlayer(), "mcr_save")

		local function rmc_char(s, chara, ids)
			if not chara or not (LocalPlayer():IsSuperAdmin() or ((ch_tk and ch_tk > 0) or (sv_tk and sv_tk > 0))) then return end
			if (IsValid(s.Menu)) then
				s.Menu:Remove()
				s.Menu = nil
			end
			s.Menu = MSD.MenuOpen(false, s)
			s.Menu:AddOption("Пересоздать персонажа", function()
				cam_switch = true
				cur_char = 4
				DoSwitch = function()
					origin = cm.pos
					angles = cm.ang
					pages["create"](ids)
				end
			end)
			if LocalPlayer():IsSuperAdmin() or (sv_tk and sv_tk > 0) then
				s.Menu:AddOption("Сохранить", function()
					local json_data = util.TableToJSON(chara, false)
					local compressed_data = util.Compress(json_data)
					local bytes_number = string.len(compressed_data)
					net.Start("MCR.Create")
						net.WriteUInt(ids, 3)
						net.WriteUInt(bytes_number, 32)
						net.WriteData(compressed_data)
						net.WriteBool(true)
					net.SendToServer()
				end)
			end
			local x, y = s:LocalToScreen(0, s:GetTall())
			s.Menu:SetMinimumWidth(s:GetWide())
			s.Menu:Open(x, y, false, s)
		end

		MCR.CharacterButton(panel.Menu, "static", nil, 1, 80, char1 and char1.fname .. " " .. char1.sname or "Создать персонажа", function(s)
			if cam_switch or s.disable then return end
			if char1 then
				net.Start("MCR.Select")
					net.WriteUInt(1, 3)
				net.SendToServer()
				Main:Close()
				return
			end
			cam_switch = true
			cur_char = 4
			DoSwitch = function()
				origin = cm.pos
				angles = cm.ang
				pages["create"](1)
			end
		end, MSD.Patern.MainColor["p"], MCR.Config.Texts[1].name, function(s)
			rmc_char(s, char1, 1)
		end, function()
			if cur_char ~= 1 and char1 and cur_char ~= 4 then
				cur_char = 1
				cam_switch = true
				DoSwitch = function()
					origin = chc[1][1]
					angles = chc[1][2]
					cur_cc.pos = chc[1][1]
					cur_cc.ang = chc[1][2]
				end
			end
		end)

		chb2 = MCR.CharacterButton(panel.Menu, "static", nil, 1, 80, char2 and char2.fname .. " " .. char2.sname or "Создать персонажа", function(s)
			if cam_switch or s.disable then return end
			if char2 then
				net.Start("MCR.Select")
					net.WriteUInt(2, 3)
				net.SendToServer()
				Main:Close()
				return
			end
			cam_switch = true
			cur_char = 4
			DoSwitch = function()
				origin = cm.pos
				angles = cm.ang
				pages["create"](2)
			end
		end, MSD.Clr.blue_dark, MCR.Config.Texts[2].name, function(s)
			rmc_char(s, char2, 2)
		end, function()
			if cur_char ~= 2 and char2 and cur_char ~= 4 then
				cur_char = 2
				cam_switch = true
				DoSwitch = function()
					origin = chc[2][1]
					angles = chc[2][2]
					cur_cc.pos = chc[2][1]
					cur_cc.ang = chc[2][2]
				end
			end
		end)

		chb3 = MCR.CharacterButton(panel.Menu, "static", nil, 1, 80, char3 and char3.fname .. " " .. char3.sname or "Создать персонажа", function(s)
			if cam_switch or s.disable then return end
			if char3  then
				net.Start("MCR.Select")
					net.WriteUInt(3, 3)
				net.SendToServer()
				Main:Close()
				return
			end
			cam_switch = true
			cur_char = 4
			DoSwitch = function()
				origin = cm.pos
				angles = cm.ang
				pages["create"](3)
			end
		end, MSD.Clr.red_dark, MCR.Config.Texts[3].name, function(s)
			rmc_char(s, char3, 3)
		end, function()
			if cur_char ~= 3 and char3 and cur_char ~= 4 then
				cur_char = 3
				cam_switch = true
				DoSwitch = function()
					origin = chc[3][1]
					angles = chc[3][2]
					cur_cc.pos = chc[3][1]
					cur_cc.ang = chc[3][2]
				end
			end
		end)

		if ch_tk and ch_tk > 0 then
			local token = vgui.Create("DPanel")
			token.StaticScale = { w = 1, fixed_h = 80, minw = 150, minh = 80}
			token.Paint = function(self, w, h)
				MSD.DrawTexturedRectRotated(CurTime() * 25 % 360, h / 2 + 5, h / 2, h - 10, h - 10, star, MSD.Patern.MainColor["p"])
				local s = h + 15
				local tw = MSD.TextWrap("У вас есть токен для пересоздания персонажа. Для применения нажмите ПКМ на нужного вам персонажа.", "MSDFont.20", w - s)
				MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
				draw.DrawText(tw, "MSDFont.20", s, 10, color_white, TEXT_ALIGN_LEFT)

				draw.SimpleTextOutlined(ch_tk, "MSDFont.36", h / 2 + 5, h / 2 - 18, color_white, TEXT_ALIGN_CENTER, 0, 2, color_black)
			end

			panel.Menu:AddItem(token)
		end

		if sv_tk and sv_tk > 0 then
			local token = vgui.Create("DPanel")
			token.StaticScale = { w = 1, fixed_h = 80, minw = 150, minh = 80}
			token.Paint = function(self, w, h)
				MSD.DrawTexturedRectRotated(CurTime() * 25 % 360, h / 2 + 5, h / 2, h - 10, h - 10, star, MSD.Patern.SubColor["s"])
				local s = h + 15
				local tw = MSD.TextWrap("У вас есть токен для сохранения персонажа. Для применения нажмите ПКМ на нужного вам персонажа.", "MSDFont.20", w - s)
				MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
				draw.DrawText(tw, "MSDFont.20", s, 10, color_white, TEXT_ALIGN_LEFT)

				draw.SimpleTextOutlined(sv_tk, "MSDFont.36", h / 2 + 5, h / 2 - 18, color_white, TEXT_ALIGN_CENTER, 0, 2, color_black)
			end

			panel.Menu:AddItem(token)
		end

	end

	pages["create"] = function(id)
		changeangl = Angle(0,0,0)
		cur_cc.ang_changed = CurTime() + 2
		cur_cc.ang_change = 2
		cur_cc.pos = cm.pos + gp
		cur_cc.ang = cm.ang

		MCR.RemoveCharacters()

		panel.Menu:Clear()
		panel.text = "Создание персонажа"

		MSD.InfoHeader(panel.Menu, "Пол персонажа")
		MSD.ButtonIcon(panel.Menu, "static", nil, 2, 60, "Женский", MSD.Icons48.human_female, function() char.gender = "female" Main.UpdateModel("female") end)
		MSD.ButtonIcon(panel.Menu, "static", nil, 2, 60, "Мужской", MSD.Icons48.human_male, function() char.gender = "male" Main.UpdateModel("male") end)

		MSD.Button(panel.Menu, "static", nil, 1, 60, "Далее", function()
			if cam_switch then return end
			if char.gender == "" or not IsValid(MCR.Char) then return end
			pages["create_2"](id)
		end)

		MSD.Button(panel.Menu, "static", nil, 1, 60, "Назад", function()
			if cam_switch then return end
			cam_switch = true
			DoSwitch = function()
				pages["main"]()
				char.gender = nil
				origin = cc.pos
				angles = cc.ang
			end
		end)
	end

	pages["create_2"] = function(id)
		panel.Menu:Clear()

		local maxc = char.gender == "male" and 9 or 6
		local maxf = MCR.FaceRawMX[MCR.GetMDL(MCR.Char)]
		local fsel, esel

		local function updCharModel(sf)
			MCR.CUModel(char.gender, char.model, 1, 1, char.suit)
			char.eye = 1
			sf.text = char.model .. "/" .. maxc
			maxf = MCR.FaceRawMX[MCR.GetMDL(MCR.Char)]
			char.face = math.random(maxf)
			fsel.text = char.face .. "/" .. maxf
			esel.text = "1/5"
			focus_v = Vector(0,0,0)
			MCR.SetFaceMatID(MCR.Char, char.face)
		end

		MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, "Внешность персонажа", char.model .. "/" .. maxc, MSD.Icons48["human_" .. char.gender], function(sf)
			char.model = char.model == maxc and 1 or char.model + 1
			updCharModel(sf)
		end,
		function(sf)
			char.model = char.model == 1 and maxc or char.model - 1
			updCharModel(sf)
		end)
		local eyef = Vector(-7,-1,5)
		fsel = MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, "Тип лица", char.face .. "/" .. maxf, MSD.Icons48.account, function(sf)
			char.face = char.face == maxf and 1 or char.face + 1
			MCR.SetFaceMatID(MCR.Char, char.face)
			sf.text = char.face .. "/" .. maxf
			focus_v = eyef
		end,
		function(sf)
			char.face = char.face == 1 and maxf or char.face - 1
			MCR.SetFaceMatID(MCR.Char, char.face)
			sf.text = char.face .. "/" .. maxf
			focus_v = eyef
		end)

		esel = MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, "Цвет глаз", char.eye .. "/5", MSD.Icons48.eye, function(sf)
			char.eye = char.eye == 5 and 1 or char.eye + 1
			MCR.SetEyeMatID(MCR.Char, char.eye)
			sf.text = char.eye .. "/5"
			focus_v = eyef
		end,
		function(sf)
			char.eye = char.eye == 1 and 5 or char.eye - 1
			MCR.SetEyeMatID(MCR.Char, char.eye)
			sf.text = char.eye .. "/5"
			focus_v = eyef
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Сменить одежду", MSD.Icons48.briefcase, function()
			char.suit.top = rtable(MCR.randomtop[char.gender])
			char.suit.pants = rtable(MCR.randompants[char.gender])
			MCR.SetShopID(MCR.Char, char.gender, "top", char.suit.top)
			MCR.SetShopID(MCR.Char, char.gender, "pants", char.suit.pants)
			focus_v = Vector(5,2,-12)
		end)

		MSD.Button(panel.Menu, "static", nil, 2, 60, "Назад", function()
			focus_v = Vector(0,0,0)
			pages["create"](id)
		end)
		MSD.Button(panel.Menu, "static", nil, 2, 60, "Далее", function()
			focus_v = Vector(0,0,0)
			char.fname, char.sname = MCR.GenerateName(char.gender, char.model, char.face)
			pages["create_3"](id)
		end)
	end

	pages["create_3"] = function(id)
		panel.Menu:Clear()

		local fname = MSD.TextEntry(panel.Menu, "static", nil, 1, 60, "Введите имя..", "Имя персонажа", char.fname, function(sf, value)
			if not MCR.CheckName(value) then sf.error = "Используйте только латинские буквы, не менее 3 и не более 16" char.fname = "" return else sf.error =  nil end char.fname = MCR.NiceName(value)
		end, true)
		local sname = MSD.TextEntry(panel.Menu, "static", nil, 1, 60, "Введите фамилию..", "Фамилия персонажа", char.sname, function(sf, value)
			if not MCR.CheckName(value) then sf.error = "Используйте только латинские буквы, не менее 3 и не более 16" char.sname = "" return  else sf.error =  nil end char.sname = MCR.NiceName(value, true)
		end, true)
		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Подобрать имя", MSD.Icons48.dice, function()
			char.fname, char.sname = MCR.GenerateName(char.gender, char.model, char.face)
			fname:SetText(char.fname)
			sname:SetText(char.sname)
		end)
		MSD.Button(panel.Menu, "static", nil, 2, 60, "Назад", function()
			focus_v = Vector(0,0,0)
			pages["create_2"](id)
		end)
		MSD.Button(panel.Menu, "static", nil, 2, 60, "Создать", function()
			if char.fname == "" or char.sname == "" then return end
			focus_v = Vector(0,0,0)
			local json_data = util.TableToJSON(char, false)
			local compressed_data = util.Compress(json_data)
			local bytes_number = string.len(compressed_data)

			net.Start("MCR.Create")
				net.WriteUInt(id, 3)
				net.WriteUInt(bytes_number, 32)
				net.WriteData(compressed_data)
				net.WriteBool(false)
			net.SendToServer()
		end)

		local discl = vgui.Create("DPanel")
		discl.StaticScale = { w = 1, fixed_h = 80, minw = 150, minh = 80}
		discl.Paint = function(self, w, h)
			MSD.DrawTexturedRectRotated(0, 45, 40, 70, 70, MSD.PinPoints[43], MSD.Patern.MainColor["p"])
			local tt, _, th = MSD.TextWrap("Имя и фамилия персонажа должны быть адекватными, должны сочетаться с игровым временем и сеттингом - Нью-Йорк начала 2000-х. Они не могут содержать нецензурную лексику, и не должны повторять имена известных людей/персонажей. Ваше имя не может повторять фамилию, и наоборот. Также запрещается делать одинаковых персонажей на двух и более ‘слотах’; разделение на типы персонажей имеется не просто так.", "MSDFont.18", w - 95)
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])
			draw.DrawText(tt, "MSDFont.18", 95, 10, color_white, TEXT_ALIGN_LEFT)

			if th + 15 > self.StaticScale.fixed_h then
				self.StaticScale.fixed_h = th + 15
			end
		end

		panel.Menu:AddItem(discl)
	end

	pages["main"]()

	MCR.LocadingMenu.Update = function()
		if cam_switch then return end
		cam_switch = true
		DoSwitch = function()
			pages["main"]()
			char.gender = nil
			origin = cc.pos
			angles = cc.ang
		end
	end

	local SWd, SWdw = SW / 20, SW / 20 + 10
	local SWdw0 = SWdw
	Main.overlay = vgui.Create("DPanel", Main)
	Main.overlay:SetSize(SW, SH)
	Main.overlay:SetPos(0, 0)
	Main.overlay.Paint = function(self, w, h)
		for i = 0, SWd - 1 do
			MSDX.Draw(0, SWd * i, 0, SWdw, h, color_black)
		end

		surface.SetMaterial(gmodla)
		surface.SetDrawColor(255,255,255,(SWdw / SWdw0) * 255)
		surface.DrawTexturedRect(w / 2 - 200, h / 2 - 80, 400, 161)

		SWdw = math.Approach(SWdw, 0, 100 * FrameTime())

		if SWdw < 1 then
			Main.overlay:Remove()
		end
	end
end

function MCR.OpenBanMenu()
	local gp = Vector(0,0,0)
	local cc = {
		pos = Vector(4045.5480957031, -7956.0170898438, 829.79779052734),
		ang = Angle(-0.9215390086174, -121.24108886719, 0)
	}
	local cam_switch = false
	local switch_pos = 0

	origin, angles, fov = cc.pos + gp, cc.ang, 45

	local cur_cc = {
		pos = origin,
		ang = angles,
		ang_change = 0.1
	}

	local changeangl = Angle(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3))
	local focus_v = Vector(0,0,0)
	local color_bg = Color(0, 0, 0, 200)
	local bantimer = LocalPlayer():getDarkRPVar("BANNED") or os.time() + 500000

	local Main = vgui.Create("DFrame")
	Main:SetSize(SW, SH)
	Main:SetTitle("")
	Main:SetVisible(true)
	Main:SetDraggable(false)
	Main:ShowCloseButton(false)
	Main:Center()
	Main:MakePopup()

	MCR.LocadingMenu = Main
	Main.OnClose = function(self)
		MCR.LocadingMenu = nil
		if MCR.Sound then
			MCR.Sound:Stop()
			MCR.Sound = nil
		end
	end
	Main.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, color_bg)

		surface.SetDrawColor(color_bg)
		surface.SetMaterial(center_gradient)
		surface.DrawTexturedRectRotated(w / 2, h / 8, 250, w + 200, -90)
		MSD.ShadowText("Ваш аккаунт заблокирован", "SF3S7", w / 2, h / 8 - 30, color_red, TEXT_ALIGN_CENTER, 2)

		draw.SimpleTextOutlined("Ваш аккаунт заблокирован на " .. sAdmin.formatTime(bantimer - os.time()), "MSDFont.32", w / 2, h / 8 + 50,  color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)

		if switch_pos > 0 then
			MSDX.Draw(0, 0, 0, w, h, MSD.ColorAlpha(color_black, math.min(switch_pos, 1) * 255))
		end
	end
	Main.Think = function(self, w, h)
		if MCR.Sound and MCR.Sound:GetState() == GMOD_CHANNEL_STOPPED and MCR.Loaded then
			MCR.Sound:SetTime(0)
			MCR.Sound:Play()
		end

		if cam_switch then
			switch_pos = math.Approach(switch_pos, 1.3, FrameTime() * 2)
		else
			switch_pos = math.Approach(switch_pos, 0, FrameTime() * 2)
		end

		angles = LerpAngle(FrameTime() * cur_cc.ang_change, angles, cur_cc.ang + changeangl)
		origin = LerpVector(FrameTime() * 2, origin, cur_cc.pos + focus_v)
	end

	local panel = vgui.Create("DPanel", Main)
	panel:SetSize(SW / 4.5, SH - 350)
	panel:SetPos(50, 350)
	panel.Paint = function(self, w, h)
	end

	local ch = [[Вы можете пожертвовать средства проекту и разблокировать аккаунт за полученные кредиты. Снятие блокировки таким образом возможно только со сроком до 60 дней.
Приобретение токена на снятие блокировки осуществляется во вкладке "другое" раздела особых услуг.

Снятие блокировки за кредиты не отменяет ваши проступки. За последующие нарушения вы можете получить двойное наказание без предупреждения.


Потраченные кредиты на снятие блокировки не будут возвращены. Никто не обязывает вас тратить средства - и уж тем более нарушать правила.]]

	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(panel:GetWide(), panel:GetTall())
	panel.Menu:SetPos(0, 0)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(true)
	panel.Menu:SetPadding(5)
	panel.Menu:SetSpacing(5)
	panel.Menu.IgnoreVbar = true
	panel.Menu.Paint = function(self, w, h)
		local hd, ht = 0, self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd + ht + 20)
		MSDX.Draw(0, 0, 0, w, hd + ht + 20, color_b50)
	end

	if MCR.BANINFO then
		MSD.InfoHeader(panel.Menu, "Причина блокировки:")
		MSD.InfoText(panel.Menu, MCR.BANINFO.reason, "MSDFont.22")
		MSD.InfoHeader(panel.Menu, "")
	end

	MSD.InfoText(panel.Menu, ch, "MSDFont.22")

	MSD.Button(panel.Menu, "static", nil, 1, 50, "Особые услуги", function()
		MSD.OpenDonate()
	end)

	local SWd, SWdw = SW / 20, SW / 20 + 10
	local SWdw0 = SWdw
	Main.overlay = vgui.Create("DPanel", Main)
	Main.overlay:SetSize(SW, SH)
	Main.overlay:SetPos(0, 0)
	Main.overlay.Paint = function(self, w, h)
		for i = 0, SWd - 1 do
			MSDX.Draw(0, SWd * i, 0, SWdw, h, color_black)
		end

		surface.SetMaterial(gmodla)
		surface.SetDrawColor(255,255,255,(SWdw / SWdw0) * 255)
		surface.DrawTexturedRect(w / 2 - 200, h / 2 - 80, 400, 161)

		SWdw = math.Approach(SWdw, 0, 100 * FrameTime())

		if SWdw < 1 then
			Main.overlay:Remove()
		end
	end
end

if MCR.FirstLoad == 1 then
	MCR.FirstLoad = 0
	MCR.OpenLoadingMenu()
end

hook.Add("RenderScene", "GmodLA.Cams", function()
	if MCR.LocadingMenu then
		if IsValid(MCR.Char) then
			MCR.Char:DrawModel()
		end

		if MCR.LocadingMenu.camd then
			origin = MCR.LocadingMenu.camd.o
			angles = MCR.LocadingMenu.camd.a
			fov = MCR.LocadingMenu.camd.f
		end

		render.Clear( 0, 0, 0, 255 )
		local view = {}
		view.x = 0
		view.y = 0
		view.w = ScrW()
		view.h = ScrH()
		view.angles = angles
		view.fov = fov
		view.origin = origin
		view.drawviewmodel = false
		render.RenderView( view )

		return true
	end
end)

hook.Add("HUDShouldDraw", "GmodLA.HUDShouldDraINTRO", function()
	if MCR.LocadingMenu then return false end
end)

hook.Add( "InitPostEntity", "MCR.Fetch", function()
	sql.Query( "CREATE TABLE IF NOT EXISTS player_c_data ( id TEXT, stat INTEGER )" )

	sql.Query("DELETE FROM player_c_data WHERE id=" .. sql.SQLStr(tostring(LocalPlayer():SteamID())) )
	sql.Query("INSERT INTO player_c_data VALUES(" .. sql.SQLStr(tostring(LocalPlayer():SteamID())) .. ", " .. 1 .. ")")

	local result = sql.Query("SELECT * FROM player_c_data")

	local ch_list = {}

	if result and istable(result) and #result > 0 then
		for _, ch in pairs(result) do
			if not ch.id then continue end
			ch_list[ch.id] = true
		end
	end

	ch_list = util.TableToJSON(ch_list)

	net.Start( "MCR.Fetch" )
		net.WriteString(ch_list)
	net.SendToServer()
end )

net.Receive("MCR.Fetch", function()
	MCR.PlayerData = net.ReadTable()
	MCR.OuttitData = net.ReadTable()

	if net.ReadBool() then
		local bytes_number = net.ReadInt(32)
		local compressed_data = net.ReadData(bytes_number)
		local json_data = util.Decompress(compressed_data)
		MCR.ExtraPlayerData = util.JSONToTable(json_data)
	else
		MCR.ExtraPlayerData = nil
	end

	if MCR.LocadingMenu and MCR.LocadingMenu.Update then MCR.LocadingMenu.Update() end
end)

local cur_shirt = 1

local function applyBG(ent, ch, data, part)
	if string.StartsWith(part, "suit") then
		if not MCR.Char.suit then
			MCR.Char:SetModel(string.Replace(MCR.Char:GetModel(), "normal", "suit"))
			MCR.Char.suit = true
			MCR.Char:ResetSequence("pose_standing_02")

			for k, s in pairs(MCR.Char:GetMaterials()) do
				MCR.Char:SetSubMaterial(k - 1, "")
			end

			MCR.SetFaceMatID(MCR.Char, ch.face)
			MCR.SetEyeMatID(MCR.Char, ch.eye)
			MCR.SetMatID(MCR.Char, ch.gender, "shirt", ch.suit.shirt or 1)
			MCR.SetMatID(MCR.Char, ch.gender, "suit", ch.suit.suit or 1)
			MCR.SetMatID(MCR.Char, ch.gender, "spants", ch.suit.spants or 1)
		end
		if ch.gender == "male" then
			ent:SetBodygroup(1, tonumber(string.sub(part,5,5)) or 0)
		else
			ent:SetBodygroup(2, math.Clamp(tonumber(string.sub(part,5,5)) or 0, 0, 1))
		end
		return
	end

	if MCR.Char.suit then
		MCR.Char:SetModel(string.Replace(MCR.Char:GetModel(), "suit", "normal"))
		MCR.Char.suit = false
		MCR.Char:ResetSequence("pose_standing_02")

		for k, s in pairs(MCR.Char:GetMaterials()) do
			MCR.Char:SetSubMaterial(k - 1, "")
		end

		MCR.SetFaceMatID(MCR.Char, ch.face)
		MCR.SetEyeMatID(MCR.Char, ch.eye)
		MCR.SetMatID(MCR.Char, ch.gender, "top", ch.suit.top or 1)
		MCR.SetMatID(MCR.Char, ch.gender, "pants", ch.suit.pants or 1)
		MCR.SetMatID(MCR.Char, ch.gender, "boots", ch.suit.boots or 1)
	end

	if data.f and MCR.shop.bgs[data.f] then
		ent:SetBodygroup(MCR.shop.bgs[data.f][1], MCR.shop.bgs[data.f][2])
	end

	if ch.gender == "female" then
		if part == "wboots" or part == "coat" then
			ent:SetBodygroup(2, 1)
		elseif part == "boots" or part == "pants" then
			ent:SetBodygroup(2, 0)
		end
	end
end

local suits = {
	["allsuit"] = true,
	["suit"] = true,
	["shirt"] = true,
	["spants"] = true,
}

function MCR.OpenShop()
	if MCR.LocadingMenu then
		MCR.LocadingMenu:Close()
		return
	end

	local gp = Vector(0,0,0)
	local cc = MCR.Config.ShopCam
	local showpoints

	origin, angles, fov = cc.pos + gp, cc.ang, 75

	local cur_cc = {
		pos = origin,
		ang = angles,
		ang_change = 0.1
	}

	local pages = {}

	local nextchange = 0
	local changeangl = Angle(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3))
	local focus_v = Vector(0,0,0)
	local focus_fov = 0
	local press = 0
	local gender = LocalPlayer():getDarkRPVar("gender")
	local shop = MCR.shop
	local focus_top = Vector(0,0,-1)
	local focus_pants = Vector(0,0,-25)
	local focus_boots = Vector(0,0,-35)
	local ch = MCR.PlayerData[LocalPlayer():getDarkRPVar("character") or 1]
	local suit = ch.suit
	ch.data = ch.data or {}
	local pmc = {
		top = suit.top,
		pants = suit.pants,
		boots = suit.boots,
		wboots = suit.wboots,
		milpants = suit.milpants,
		coat = suit.coat,
		suit = suit.suit,
		shirt = suit.shirt,
		spants = suit.spants,
		insuit = suit.insuit or 1
	}

	cur_shirt = suit.shirt

	MCR.CreatePlayerModel(LocalPlayer())

	local Main = vgui.Create("DFrame")
	Main:SetSize(SW, SH)
	Main:SetTitle("")
	Main:SetVisible(true)
	Main:SetDraggable(false)
	Main:ShowCloseButton(false)
	Main:Center()
	Main:MakePopup()
	Main.Outfit = true

	MCR.LocadingMenu = Main
	Main.OnClose = function(self)
		if MCR.Sound then
			MCR.Sound:Stop()
			MCR.Sound = nil
		end
		if MCR.dlight then
			MCR.dlight.DieTime = CurTime() + FrameTime()
			MCR.dlight = nil
		end
		if IsValid(MCR.Char) then
			MCR.Char:Remove()
			MCR.Char = nil
		end

		MCR.LocadingMenu = nil

		net.Start("MCR.AddPVS")
		net.WriteUInt(0, 4)
		net.SendToServer()
	end
	Main.Paint = function(self, w, h)
		MSD.DrawTexturedRectOfRot(180, -9, 0, w + 10, 41, MSD.Materials.gradient, color_black)
		draw.SimpleTextOutlined("↑ ↓ - Смена позы персонажа     ← → - Вращать персонажа", "MSDFont.16", w - 5, h - 25, DarkRP.Hud.Patern["armor"], TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, DarkRP.Hud.Patern["shadow"])
	end
	Main.Think = function(self, w, h)
		if MCR.Sound and MCR.Sound:GetState() == GMOD_CHANNEL_STOPPED and MCR.Loaded then
			MCR.Sound:SetTime(0)
			MCR.Sound:Play()
		end

		if nextchange < CurTime() and not cur_cc.ang_changed then
			changeangl = Angle(math.Rand(-3, 3), math.Rand(-3, 3), math.Rand(-3, 3))
			nextchange = CurTime() + math.random(2)
		end

		if cur_cc.ang_changed and cur_cc.ang_changed < CurTime() then
			cur_cc.ang_change = 0.1
			cur_cc.ang_changed = nil
		end

		angles = LerpAngle(FrameTime() * cur_cc.ang_change, angles, cur_cc.ang + changeangl)
		origin = LerpVector(FrameTime() * 2, origin, cur_cc.pos + focus_v)
		fov = Lerp(FrameTime() * 2, fov, 75 + focus_fov)

		if MCR.Char then
			if input.IsKeyDown(KEY_RIGHT) then

				local ang = MCR.Char:GetAngles()
				ang.y = ang.y + 1
				MCR.Char:SetAngles(ang)
			end

			if input.IsKeyDown(KEY_LEFT) then
				local ang = MCR.Char:GetAngles()
				ang.y = ang.y - 1
				MCR.Char:SetAngles(ang)
			end

			if (input.IsKeyDown(KEY_UP) or input.IsKeyDown(KEY_DOWN)) and (not press or press < CurTime()) then
				press = CurTime() + 0.3
				MCR.Char:ResetSequence("pose_standing_0" .. math.random(4))
			end

			local mx, my = gui.MousePos()
			my = 1 - (SH - my) / (SH / 2)
			mx = 1 - (SW - mx) / (SW / 2)
			MCR.Char:SetEyeTarget(origin - Vector(0,mx * -20, my * 20) )

			local hd = MCR.Char:LookupBone("ValveBiped.Bip01_Head1")
			MCR.Char:ManipulateBoneAngles( hd, Angle(0,my * -7, mx * 7) )
		end
	end

	local panel = vgui.Create("DPanel", Main)
	panel:SetSize(SW / 4.5, SH - SH / 6)
	panel:SetPos(50, 50)
	panel.text = "Магазин одежды"
	panel.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, 120, color_black)
		local logo_h = 100
		MSD.DrawTexturedRect(5, 0, logo_h * 1.91, logo_h, gmodla2, color_white)

		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 71, color_black, TEXT_ALIGN_RIGHT)
		draw.DrawText(panel.text, "GmodLA.Hand", w - 5, 70, color_white, TEXT_ALIGN_RIGHT)
		MSD.DrawTexturedRect(0, 0, w, 120, glass, color_w50)
	end

	panel.Menu = vgui.Create("MSDPanelList", panel)
	panel.Menu:SetSize(panel:GetWide(), panel:GetTall() - 120)
	panel.Menu:SetPos(0, 120)
	panel.Menu:EnableVerticalScrollbar()
	panel.Menu:EnableHorizontal(true)
	panel.Menu:SetPadding(5)
	panel.Menu:SetSpacing(5)
	panel.Menu.IgnoreVbar = true
	panel.Menu.Paint = function(self, w, h)
		local hd = self:GetCanvas():GetTall()
		MSD.Blur(self, 2, 2, 255, 20, w, hd)
		MSDX.Draw(0, 0, 0, w, hd, color_b50)
	end

	panel.Sub = vgui.Create("MSDPanelList", Main)
	panel.Sub:SetSize(panel:GetWide(), panel:GetTall() - 100)
	panel.Sub:SetPos(SW - panel:GetWide() - 15, 50)
	panel.Sub:EnableVerticalScrollbar()
	panel.Sub:EnableHorizontal(true)
	panel.Sub:SetPadding(5)
	panel.Sub:SetSpacing(5)
	panel.Sub.text = ""
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
			draw.DrawText("$" .. string.Comma(money), "MSDFont.32", w - 15, 5, color_white, TEXT_ALIGN_RIGHT)
			if showpoints then
				draw.DrawText(string.Comma(math.Round(Glac.Credits)) .. " ¤", "MSDFont.30", w - 15, 35, color_white, TEXT_ALIGN_RIGHT)
			end
		end

		panel.Sub:AddItem(pnl)
	end

	panel.BackSub = vgui.Create("MSDPanelList", Main)
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

	MSD.CloseButtonIcon(Main, ScrW() - 220, 0, 210, 37, "Закрыть", function()
		Main:Close()
	end)

	panel.Sub.Update = function(type, sid, id, item, has, eq, nobuy)
		panel.Sub:Clear()
		panel.Sub:SetBasic()
		panel.BackSub:Clear()
		panel.Sub.text = ""

		MSD.ButtonIcon(panel.BackSub, "static", nil, 1, 60, "Назад", MSD.Icons48.arrow_left, function()
			pages["main"]()
			MCR.CreatePlayerModel(LocalPlayer())
		end)

		if not item then return end

		panel.Sub.text = item.name

		if suits[type] then
			local maxc = gender == "male" and 6 or 2

			local function suitButton(sf)
				applyBG(MCR.Char, ch, nil, "suit" .. pmc.insuit - 1)
				sf.text = pmc.insuit .. "/" .. maxc
				if pmc.insuit > 4 then
					MCR.SetMatID(MCR.Char, gender, "tn", cur_shirt)
					if not MQS.GetSData(nil, "d_packhotline") and not IsValid(panel.Sub.promo) then
						panel.Sub.promo = AddPackPromo("d_packhotline")
						panel.Sub:AddItem(panel.Sub.promo)
						if IsValid(panel.Sub.buyB) then
							panel.Sub.buyB:SetVisible(false)
						end
					end
				else
					MCR.SetMatID(MCR.Char, gender, "shirt", cur_shirt)
					if IsValid(panel.Sub.promo) then
						panel.Sub.promo:Remove()
					end
					if IsValid(panel.Sub.buyB) then
						panel.Sub.buyB:SetVisible(true)
					end
				end
			end

			MSD.ButtonIconText(panel.Sub, "static", nil, 1, 60, "Вариация костюма", pmc.insuit .. "/" .. maxc, MSD.Icons48.account_tie_hat, function(sf)
				pmc.insuit = pmc.insuit == maxc and 1 or pmc.insuit + 1
				suitButton(sf)
			end,
			function(sf)
				pmc.insuit = pmc.insuit == 1 and maxc or pmc.insuit - 1
				suitButton(sf)
			end)
		end

		if eq then return end

		showpoints = item.don

		local price = item.price or 600
		local buy = has and "Надеть" or (item.don and "Разблокировать за ¤" or "Купить за $") .. price
		if item.pack then
			has = MQS.GetSData(nil, item.pack)
			buy = "Надеть"
			if not has then
				panel.Sub:AddItem(AddPackPromo(item.pack))
				return
			end
		end

		if nobuy and not has then return end
		if ((not item.don and not LocalPlayer():canAfford(price)) or (item.don and Glac.Credits < price)) and not has then return end

		panel.Sub.buyB = MSD.ButtonIcon(panel.Sub, "static", nil, 1, 60, buy, has and MSD.Icons48.hand_right or MSD.Icons48.cash, function()
			if pmc.insuit > 4 and not MQS.GetSData(LocalPlayer(), "d_packhotline") then
				pmc.insuit = 1
				applyBG(MCR.Char, ch, nil, "suit" .. pmc.insuit - 1)
			end

			net.Start("MCR.Outfit")
				net.WriteString(type)
				net.WriteUInt(sid, 8)
				if pmc.insuit then
					net.WriteUInt(pmc.insuit, 3)
				end
			net.SendToServer()

			if type == "allsuit" then
				pmc["shirt"] = id
				pmc["spants"] = id
				MCR.SetMatID(MCR.Char, gender, "shirt", id)
				MCR.SetMatID(MCR.Char, gender, "spants", id)
				type = "suit"
			end

			pmc[type] = id
			MCR.SetMatID(MCR.Char, gender, type, id)

			if pmc.insuit > 4 then
				MCR.SetMatID(MCR.Char, gender, "tn", id)
			end
			panel.Sub.Update()
		end)
	end

	pages["main"] = function()
		focus_v = Vector(0,0,0)
		focus_fov = 10
		panel.Sub:Clear()
		panel.Menu:Clear()

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Теплые куртки", MSD.Icons48.dot, function()
			pages["top"]("wc")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Куртки", MSD.Icons48.dot, function()
			pages["top"]("c")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Футболки", MSD.Icons48.dot, function()
			pages["top"]("s")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Поло", MSD.Icons48.dot, function()
			pages["top"]("p")
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Штаны", MSD.Icons48.dot, function()
			pages["pants"](2, 0)
		end)
		if ch.gender == "female" then
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Зауженные штаны", MSD.Icons48.dot, function()
				pages["coat"](2, 2)
			end)
			MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Высокие сапоги", MSD.Icons48.dot, function()
				pages["wboots"](2, 2)
			end)
		end
		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Обувь", MSD.Icons48.dot, function()
			pages["boots"](2, 0)
		end)

		MSD.InfoHeader(panel.Menu, "Премиум")

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Костюмы", MSD.Icons48.dot, function()
			pages["allsuit"](1, 3)
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Пиджаки", MSD.Icons48.dot, function()
			pages["suit"](1, 3)
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Рубашки", MSD.Icons48.dot, function()
			pages["shirt"](1, 3)
		end)

		MSD.ButtonIcon(panel.Menu, "static", nil, 1, 60, "Брюки", MSD.Icons48.dot, function()
			pages["spants"](2, ch.gender == "female" and 3 or 2)
		end)
	end

	pages["top"] = function(filter, slive, bid)
		focus_v = focus_top
		focus_fov = -15
		panel.Menu:Clear()
		panel.Sub.Update()
		for k,v in SortedPairsByMemberValue(shop.top, "name") do
			if v.f ~= filter then continue end
			if v.only and v.only ~= ch.gender then continue end
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["top"] and MCR.OuttitData["top"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			local price = has and "КУПЛЕНО" or ((v.don and "¤" or "$") .. (v.price or 600))
			if v.pack then price = "" end
			local but = MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, price, has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("top", k, v.id, v, has, pmc.top == v.id, slive, bid)
				applyBG(MCR.Char, ch, v, "top")
				MCR.SetMatID(MCR.Char, gender, "top", v.id)
			end)
			if (v.cp or v.f == "wc") and bid ~= 1 then
				but.bgpaint = function(self, wd, hd)
					surface.SetFont("MSDFont.22")
					local s = surface.GetTextSize(self:GetText())
					MSD.DrawTexturedRect(52 + s, hd / 2 - 12, 24, 24, MSD.Icons48.snowflake_thermometer, MSD.Text["n"])
				end
			end
		end
	end

	pages["pants"] = function()
		focus_v = focus_pants
		focus_fov = -15
		panel.Menu:Clear()
		panel.Sub.Update()

		for k,v in SortedPairsByMemberValue(shop.pants, "name") do
			if v.only and v.only ~= ch.gender then continue end
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["pants"] and MCR.OuttitData["pants"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			local price = has and "КУПЛЕНО" or ((v.don and "¤" or "$") .. (v.price or 600))
			if v.pack then price = "" end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, price, has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("pants", k, v.id, v, has, pmc.pants == v.id)
				applyBG(MCR.Char, ch, v, "pants")
				MCR.SetMatID(MCR.Char, gender, "pants", v.id)
			end)
		end
	end

	pages["coat"] = function()
		focus_v = focus_pants
		focus_fov = -15
		panel.Menu:Clear()
		panel.Sub.Update()

		for k,v in SortedPairsByMemberValue(shop.coat, "name") do
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["coat"] and MCR.OuttitData["coat"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			local price = has and "КУПЛЕНО" or ((v.don and "¤" or "$") .. (v.price or 600))
			if v.pack then price = "" end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, price, has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("coat", k, v.id, v, has, pmc.coat == v.id)
				applyBG(MCR.Char, ch, v, "coat")
				MCR.SetMatID(MCR.Char, gender, "coat", v.id)
			end)
		end
	end

	pages["wboots"] = function()
		focus_v = focus_boots
		focus_fov = -15
		panel.Menu:Clear()
		panel.Sub.Update()
		for k,v in SortedPairsByMemberValue(shop.wboots, "name") do
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["wboots"] and MCR.OuttitData["wboots"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			local price = has and "КУПЛЕНО" or ((v.don and "¤" or "$") .. (v.price or 600))
			if v.pack then price = "" end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, price, has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("wboots", k, v.id, v, has, pmc.wboots == v.id)
				applyBG(MCR.Char, ch, v, "wboots")
				MCR.SetMatID(MCR.Char, gender, "wboots", v.id)
			end)
		end
	end

	pages["boots"] = function()
		focus_v = focus_boots
		focus_fov = -25
		panel.Menu:Clear()
		panel.Sub.Update()
		for k,v in SortedPairsByMemberValue(shop.boots, "name") do
			if v.only and v.only ~= ch.gender then continue end
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["boots"] and MCR.OuttitData["boots"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			local price = has and "КУПЛЕНО" or ((v.don and "¤" or "$") .. (v.price or 600))
			if v.pack then price = "" end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, price, has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("boots", k, v.id, v, has, pmc.boots == v.id)
				applyBG(MCR.Char, ch, v, "boots")
				MCR.SetMatID(MCR.Char, gender, "boots", v.id)
			end)
		end
	end

	pages["suit"] = function()
		focus_v = focus_top
		focus_fov = -15
		panel.Menu:Clear()
		panel.Sub.Update()

		for k,v in SortedPairsByMemberValue(shop.suit, "price") do
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["suit"] and MCR.OuttitData["suit"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, has and "КУПЛЕНО" or "", has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("suit", k, v.id, v, has, pmc.suit == v.id, true)
				applyBG(MCR.Char, ch, v, "suit" .. pmc.insuit - 1)
				MCR.SetMatID(MCR.Char, gender, "suit", v.id)
			end)
		end
	end

	pages["shirt"] = function()
		focus_v = focus_top
		focus_fov = -15
		panel.Menu:Clear()
		panel.Sub.Update()

		for k,v in SortedPairsByMemberValue(shop.shirt, "price") do
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["suit"] and MCR.OuttitData["suit"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, has and "КУПЛЕНО" or "", has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("shirt", k, v.id, v, has, pmc.shirt == v.id, true)
				applyBG(MCR.Char, ch, v, "suit" .. pmc.insuit - 1)
				cur_shirt = v.id
				if pmc.insuit > 4 then
					MCR.SetMatID(MCR.Char, gender, "tn", v.id)
				else
					MCR.SetMatID(MCR.Char, gender, "shirt", v.id)
				end
			end)
		end
	end

	pages["spants"] = function()
		focus_v = focus_pants
		focus_fov = -15
		panel.Menu:Clear()
		panel.Sub.Update()

		for k,v in SortedPairsByMemberValue(shop.spants, "price") do
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["suit"] and MCR.OuttitData["suit"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, has and "КУПЛЕНО" or "", has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("spants", k, v.id, v, has, pmc.spants == v.id, true)
				applyBG(MCR.Char, ch, v, "suit" .. pmc.insuit - 1)
				MCR.SetMatID(MCR.Char, gender, "spants", v.id)
			end)
		end
	end

	pages["allsuit"] = function()
		focus_v = Vector(0,0,-10)
		focus_fov = 15
		panel.Menu:Clear()
		panel.Sub.Update()

		for k,v in SortedPairsByMemberValue(shop.suit, "price") do
			local buy = v.don and MSD.PinPoints[49] or MSD.Icons48.cash
			local has = MCR.OuttitData["suit"] and MCR.OuttitData["suit"][k]
			if v.noshow and not MQS.GetSData(nil, v.pack) then continue end
			local price = has and "КУПЛЕНО" or ((v.don and "¤" or "$") .. (v.price or 600))
			if v.pack then price = "" end
			MSD.ButtonIconText(panel.Menu, "static", nil, 1, 60, v.name, price, has and MSD.Icons48.submit or buy, function(sf)
				panel.Sub.Update("allsuit", k, v.id, v, has, pmc.shirt == v.id and pmc.shirt == v.id and pmc.suit == v.id)
				applyBG(MCR.Char, ch, v, "suit" .. pmc.insuit - 1)
				MCR.SetMatID(MCR.Char, gender, "suit", v.id)
				MCR.SetMatID(MCR.Char, gender, "spants", v.id)
				cur_shirt = v.id
				if pmc.insuit > 4 then
					MCR.SetMatID(MCR.Char, gender, "tn", v.id)
				else
					MCR.SetMatID(MCR.Char, gender, "shirt", v.id)
				end
			end)
		end
	end

	pages["main"]()

	MCR.LocadingMenu.Update = function()
		ch = MCR.PlayerData[LocalPlayer():getDarkRPVar("character") or 1]
	end
end

net.Receive("MCR.OnSelect", function()
	hook.Call("MCR.OnSelect", nil, net.ReadUInt(3))
end)