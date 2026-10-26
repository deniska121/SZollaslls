--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/custom_assets.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MSD.RenderView = {}
MSD.Patern = {}
MSD.RenderView.Cur = nil
MSD.RenderView.Delay = 0
MSD.RenderView.Images = {}

local NewFont = surface.CreateFont

NewFont("Logo.M1", {
	font = "Snowstorm",
	extended = true,
	size = 55,
	weight = 500
})

NewFont("Logo.S1", {
	font = "Snowstorm Kraft",
	extended = true,
	size = 55,
	weight = 500
})

NewFont("Logo.N1", {
	font = "Five",
	extended = true,
	size = 55,
	weight = 500
})

function MSD.DrawMLogo(x, y)
	local sp = draw.SimpleTextOutlined("N.Y.", "Logo.M1", x, y, color_black, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, color_black)
	draw.SimpleText("N.Y.", "Logo.S1", x, y, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
	draw.SimpleText("NOIRE", "Logo.N1", x + sp, y, MSD.Config.MainColor.p, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
end

local function DrawKey(x, y, key, alpha)
	alpha = alpha or 200
	if not isstring(key) then return end
	key = string.upper(key)
	surface.SetFont("MSDFont.20")
	local w = surface.GetTextSize(key)
	MSDX.Draw(4, x + 2, y + 3, w + 8, 22, MSD.ColorAlpha(MSD.Theme.l, alpha))
	MSDX.Draw(4, x, y, w + 10, 25, MSD.ColorAlpha(MSD.Theme.d, alpha))
	draw.SimpleText(key, "MSDFont.20", x + 5, y + 3, MSD.ColorAlpha(color_white, alpha), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

	return w + 10
end

MSD.DrawKey = DrawKey

function MSD.DrawKeyIcon(x, y, key, w, alpha)
	alpha = alpha or 200
	w = w or 20
	MSDX.Draw(4, x, y, w + 8, w + 8, MSD.ColorAlpha(MSD.Theme.d, 210))
	MSD.DrawTexturedRect(x + 4, y + 4, w, w, key, MSD.ColorAlpha(color_white, alpha))

	return w + 5
end

MSD.Patern.SubColor = {
	["s"] = Color(0,77,173),
	["9"] = Color(0,77,173),
	["8"] = Color(0,107,204),
	["7"] = Color(0,125,222),
	["6"] = Color(0,143,241),
	["5"] = Color(0,157,255),
	["4"] = Color(58,172,255),
	["3"] = Color(97,187,254),
	["2"] = Color(143,206,255),
	["1"] = Color(187,225,254),
}

MSD.Patern.MainColor = {
	["p"] = Color(255,183,0),
	["9"] = Color(255,98,0),
	["8"] = Color(255,132,0),
	["7"] = Color(255,150,0),
	["6"] = Color(255,169,0),
	["5"] = Color(255,183,0),
	["4"] = Color(255,193,27),
	["3"] = Color(255,205,71),
	["2"] = Color(255,218,125),
	["1"] = Color(255,233,176),
}

function MSD.ShadowText(text, font, x, y, color, alingx, ss, scolor)
	draw.DrawText(text, font, x + (ss or 1), y + (ss or 1), scolor or color_black, alingx)
	draw.DrawText(text, font, x, y, color, alingx)
end

function MSD.PanelIcon(parent, text, icon, update)
	local panel = vgui.Create("DPanel")

	panel.StaticScale = {
		w = 1,
		fixed_h = 50,
		minw = 250,
		minh = 50
	}
	panel.text = text
	panel.update = update
	panel.icon = icon
	panel.Paint = function(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])
		draw.DrawText(self.text, "MSDFont.22", 48, h / 2 - 11, MSD.Text["s"], TEXT_ALIGN_LEFT)
		MSD.DrawTexturedRect(12, h / 2 - 12, 24, 24, self.icon, MSD.Text["l"])

		if self.update then self.update(self, w, h) end
	end

	parent:AddItem(panel)

	return panel
end

function MSD.BigButtonClean(parent, x, y, w, h, text, icon, func, color, color2, func2)
	local button = vgui.Create("DButton")
	button:SetText(text)

	if x and y then
		button:SetParent(parent)
		button:SetPos(x, y)
	end

	if x == "static" then
		button.StaticScale = {
			w = w,
			fixed_h = h,
			minw = 150,
			minh = h
		}
	else
		button:SetSize(w, h)
	end

	button.alpha = 0
	button.color_idle = color2

	button.Paint = function(self, wd, hd)
		if self.hover and not self.disable then
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 0)
		end

		if self.color_idle then
			if icon then MSD.DrawTexturedRect(wd / 2 - 24, hd / 2 - 36, 48, 48, icon, MSD.ColorAlpha(self.color_idle, 255 - self.alpha * 255)) end
			draw.DrawText(button:GetText(), "MSDFont.25", wd / 2, hd / 2 + 10, MSD.ColorAlpha(self.color_idle, 255 - self.alpha * 255), TEXT_ALIGN_CENTER)
		end

		if self.alpha > 0.01 then
			if icon then MSD.DrawTexturedRect(wd / 2 - 24, hd / 2 - 36, 48, 48, icon, MSD.ColorAlpha(color or MSD.Config.MainColor["p"], self.alpha * 255)) end
			draw.DrawText(button:GetText(), "MSDFont.25", wd / 2, hd / 2 + 10, MSD.ColorAlpha(color or MSD.Config.MainColor["p"], self.alpha * 255), TEXT_ALIGN_CENTER)
		end

		return true
	end

	button.OnCursorEntered = function(self)
		self.hover = true
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

if not file.Exists("msd_view", "DATA") then
	file.CreateDir("msd_view")
end

function MSD.RenderView.Get(id, pos, ang)
	local crc = util.CRC(id) .. ".png"
	if MSD.RenderView.Images[crc] then return MSD.RenderView.Images[crc] end

	if (file.Exists("msd_view/" .. crc, "DATA")) then
		MSD.RenderView.Images[crc] = Material("data/msd_view/" .. crc, "smooth noclamp")

		return MSD.RenderView.Images[crc]
	elseif not MSD.RenderView.Cur then
		MSD.RenderView.Cur = {id, pos, ang}
	end

	return MSD.ImgLib.NoMaterial
end

hook.Add( "PreRender", "MSD.RenderView", function()
	if not MSD then return end
	if not MSD.RenderView.Cur  then return end
	if MSD.RenderView.Delay > CurTime() then return end

	local id = MSD.RenderView.Cur[1]
	local pos = MSD.RenderView.Cur[2]
	local ang = MSD.RenderView.Cur[3]

	MSD.RenderView.Cur = nil
	MSD.RenderView.Delay = CurTime() + 0.05

	local view = {
		type	= "3D",
		origin	= pos,
		drawviewmodel	= false,
		angles	= ang,
		x		= 0,
		y		= 0,
		w		= 640,
		h		= 480,
		aspect	= 1,
		fov		= 90
	}
	render.ClearDepth()

	cam.Start( view )
		render.RenderView(view)
	cam.End()

	local imgdata = render.Capture( {
		format		=	"png",
		x			=	0,
		y			=	0,
		w			=	640,
		h			=	480,
		alpha		= false,
	} )
	file.Write( "msd_view/" .. util.CRC(id) .. ".png", imgdata )

end)

MSD.RenderModel = nil
MSD.RenderMaterial = nil
MSD.RenderColor = nil
MSD.RenderModelDelay = 0
MSD.IconRender = {}
MSD.IconRender.Images = {}

if not file.Exists("msd_render", "DATA") then
	file.CreateDir("msd_render")
end

if CLIENT and file.Exists("msd_icons", "DATA") then
	local filess = file.Find( "msd_icons/*", "DATA" )
	for _, name in pairs(filess) do
		file.Delete( "msd_icons/" .. name )
	end
end

function MSD.IconRender.Get(model, material, submat, color)
	local mat = material or ""

	if submat then
		for _, v in pairs(submat) do
			mat = mat .. v
		end
	end

	if color then
		mat = mat .. color.r .. color.g .. color.b
	end

	local crc = util.CRC(model .. mat) .. ".png"

	if MSD.IconRender.Images[crc] then return MSD.IconRender.Images[crc], crc end

	if (file.Exists("msd_render/" .. crc, "DATA")) then
		MSD.IconRender.Images[crc] = Material("data/msd_render/" .. crc, "smooth noclamp")
		return MSD.IconRender.Images[crc], crc
	elseif not MSD.RenderModel then
		if material then MSD.RenderMaterial = material end
		if submat then MSD.RenderSubMaterials = submat end
		if color then MSD.RenderColor = color end
		MSD.RenderModel = model
	end

	return MSD.ImgLib.NoMaterial, crc
end

hook.Add( "PreRender", "MSD.IconRender", function()
	if not MSD then return end

	if not MSD.RenderModel  then return end

	if MSD.RenderModelDelay > CurTime() then return end

	local vModel = MSD.RenderModel
	MSD.RenderModel = nil
	MSD.RenderModelDelay = CurTime() + 0.05

	local vModelEnt = ClientsideModel( vModel, RENDERGROUP_OTHER )

	if MSD.RenderSubMaterials then
		for k,v in pairs(MSD.RenderSubMaterials) do
			vModelEnt:SetSubMaterial(k, v)
		end
	end

	local mat = ""
	local mn, mx = vModelEnt:GetRenderBounds()

	local size = 0
	size = math.max(size, math.abs(mn.x) + math.abs(mx.x))
	size = math.max(size, math.abs(mn.y) + math.abs(mx.y))
	size = math.max(size, math.abs(mn.z) + math.abs(mx.z))
	local FOV = 55 - size

	local Size = mn - mx
	local Radius = Size:Length() * 0.5
	local CamDist = Radius / math.sin( math.rad( FOV ) / 2 ) -- Works out how far the camera has to be away based on radius + fov!
	local Center = LerpVector( 0.5, mx, mn )
	local CamPos = Center + Vector( -1, 0, 0.5 ):GetNormal() * CamDist
	local EyeAng = ( Center - CamPos ):GetNormal():Angle()

	local view = {
		type	= "3D",
		origin	= CamPos,
		angles	= EyeAng,
		x		= 0,
		y		= 0,
		w		= 128,
		h		= 128,
		aspect	= 1,
		fov		= FOV
	}
	render.UpdateRefractTexture()
	render.Clear(0, 0, 0, 0)
	render.SetWriteDepthToDestAlpha(false)
	--render.ClearDepth()
	render.SuppressEngineLighting( true )

	local BorderSize = math.min(CamDist * 0.05, 4)
	local Up = EyeAng:Up() * BorderSize
	local Right = EyeAng:Right() * BorderSize

	render.SetColorModulation( 1, 0.6, 0, 1 )
	render.MaterialOverride( Material( "models/debug/debugwhite" ) )
	for i = 0, math.pi * 2, 0.2 do
		view.origin = CamPos + Up * math.sin( i ) + Right * math.cos( i )

		cam.Start( view )
			render.Model( {
				model	= vModel,
				pos		= Vector(0,0,0),
				angle	= Angle(0,90,0)
			}, vModelEnt )
		cam.End()
	end
		-- Because we just messed up the depth
	render.ClearDepth()
	render.SetColorModulation( 0, 0, 0, 1 )

	-- Try to keep the border size consistent with zoom size
	BorderSize = math.min(CamDist * 0.03, 2)
	Up = EyeAng:Up() * BorderSize
	Right = EyeAng:Right() * BorderSize

	for i = 0, math.pi * 2, 0.2 do

		view.origin = CamPos + Up * math.sin( i ) + Right * math.cos( i )
		cam.Start( view )
			render.Model( {
				model	= vModel,
				pos		= Vector(0,0,0),
				angle	= Angle(0,90,0)
			}, vModelEnt )
		cam.End()

	end

	render.ClearDepth()

	view.origin = CamPos

	render.SetModelLighting( 0, 1, 1, 1 ) -- front
	render.SetModelLighting( 1, 1, 1, 1 ) -- behind
	render.SetModelLighting( 2, 1, 1, 1 ) -- right
	render.SetModelLighting( 3, 1, 1, 1 ) -- left
	render.SetModelLighting( 4, 2, 2, 2 ) -- top
	render.SetModelLighting( 5, 1, 1, 1 ) -- but
	render.MaterialOverride( nil )
	render.SetColorModulation( 1, 1, 1, 1 )

	cam.Start( view )
		if MSD.RenderColor then
			render.SetColorModulation(MSD.RenderColor.r / 255, MSD.RenderColor.g / 255, MSD.RenderColor.b / 255)
		end
		if MSD.RenderMaterial then
			render.MaterialOverride( Material(MSD.RenderMaterial) )
			mat = MSD.RenderMaterial
		end
		render.Model( {
			model	= vModel,
			pos		= Vector(0,0,0),
			angle	= Angle(0,90,0)
		}, vModelEnt )
		render.MaterialOverride( nil )
	cam.End()
	render.SuppressEngineLighting( false )
	render.SetColorModulation(1, 1, 1, 1)
	vModelEnt:Remove()

	if MSD.RenderSubMaterials then
		for _, v in pairs(MSD.RenderSubMaterials) do
			mat = mat .. v
		end
	end

	if MSD.RenderColor then
		mat = mat .. MSD.RenderColor.r .. MSD.RenderColor.g .. MSD.RenderColor.b
	end

	render.SetWriteDepthToDestAlpha(true)
	local jpegdata = render.Capture( {
		format		=	"png",
		x			=	0,
		y			=	0,
		w			=	128,
		h			=	128
	} )
	file.Write( "msd_render/" .. util.CRC(vModel .. mat) .. ".png", jpegdata )

	MSD.RenderMaterial = nil
	MSD.RenderSubMaterials = nil
	MSD.RenderColor = nil
end )

function MSD.InfoTextIcon(parent, text_big, text, icon, cl1)
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
		MSD.DrawTexturedRect(8, 8, 64, 64, icon, cl1 or color_white)
		draw.DrawText(text_big, "MSDFont.28", 80, 5, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)

		local ts, _, th = MSD.TextWrap(text, "MSDFont.20", w - 85)
		draw.DrawText(ts, "MSDFont.20", 80, 40, MSD.Text.l, TEXT_ALIGN_LEFT)

		self.StaticScale.fixed_h = math.max(80, th + 45)
	end

	parent:AddItem(panel)

	return panel
end

-- Shared popup shell: blurred backdrop with a centred box, a title bar and an optional close button
local popup_bg = Color(61, 61, 61)

local function PopupShell(parent, title, hide_clsBut)
	local panel

	if parent then
		panel = vgui.Create("DPanel")
		panel:SetAlpha(0)
		panel:AlphaTo(255, 0.3)
	else
		panel = vgui.Create("MSDSimpleFrame")
		panel:SetSize(ScrW(), ScrH())
		panel:MakePopup()
	end

	panel.Paint = function(self, w, h)
		MSD.Blur(self, 5, 5, 255, 50, w, h)
	end

	panel.Close = function()
		panel:AlphaTo(0, 0.3, 0, function()
			panel:Remove()
		end)
	end

	if parent then
		parent:AddToWorkSpace(panel)
	end

	local child = vgui.Create("DPanel", panel)
	child:SetSize(panel:GetWide() / 3, 135)
	child:Center()

	child.Paint = function(self, w, h)
		MSDX.Draw(0, 0, 0, w, h, popup_bg)
		MSDX.Draw(0, 0, 0, w, 40, MSD.Theme["d"])
		draw.DrawText(title, "MSDFont.20", 10, 10, color_white, TEXT_ALIGN_LEFT)
	end

	child.PerformLayout = function(self)
		child:Center()

		if child.clsBut then
			child.clsBut:SetPos(child:GetWide() - 38, 5)
		end
	end

	if not hide_clsBut then
		child.clsBut = MSD.IconButton(child, MSD.Icons48.cross, child:GetWide() - 38, 5, 32, nil, nil, function()
			panel:Close()
		end)
	end

	return panel, child
end

local function DockBottom(pnl, bottom)
	pnl:DockPadding(10, 5, 10, bottom)
	pnl:DockMargin(10, 5, 10, bottom)
	pnl:Dock(BOTTOM)
end

-- but_1 / but_2 = {text, func(button)}
function MSD.AskPopup(parent, title, hide_clsBut, but_1, but_2)
	local panel, child = PopupShell(parent, title, hide_clsBut)

	if but_1 then
		DockBottom(MSD.Button(child, 10, 50, child:GetWide() - 20, 30, but_1[1], function(self)
			panel:Close()
			but_1[2](self)
		end), 10)
	end

	if but_2 then
		DockBottom(MSD.Button(child, 10, 50, child:GetWide() - 20, 30, but_2[1], function(self)
			panel:Close()
			but_2[2](self)
		end), 5)
	end

	return panel, child
end

-- Text input; entry = {placeholder, func(textentry)} runs on Enter
function MSD.AskPopupEntr(parent, title, hide_clsBut, entry)
	local panel, child = PopupShell(parent, title, hide_clsBut)
	local entr

	if entry then
		entr = MSD.TextEntry(child, 10, 10, child:GetWide() - 20, 40, entry[1], nil, "", function(self)
			panel:Close()
			entry[2](self)
		end)

		DockBottom(entr, 10)
		entr:RequestFocus()
	end

	return panel, child, entr
end

-- Dropdown + confirm button; combo = {placeholder, button text, func(button)}.
-- Returns the DComboBox and the button: store the choice on the button (e.g. button.data) in OnSelect.
function MSD.AskPopupCombo(parent, title, hide_clsBut, combo)
	local panel, child = PopupShell(parent, title, hide_clsBut)
	local button, cbb

	if combo then
		button = MSD.Button(child, 10, 50, child:GetWide() - 20, 30, combo[2], function(self)
			panel:Close()
			combo[3](self)
		end)

		DockBottom(button, 5)

		cbb = MSD.ComboBox(child, 10, 10, child:GetWide() - 20, 30, nil, combo[1])
		DockBottom(cbb, 10)
	end

	return cbb, button, panel, child
end

function MSD.AskConfirmPopup(parent, question, acceptText, cancelText, acceptFunc)
	local panel
	local holdTime = 2

	if parent then
		panel = vgui.Create("DPanel")
		panel:SetAlpha(0)
		panel:AlphaTo(255, 0.3)
	else
		panel = vgui.Create("MSDSimpleFrame")
		panel:SetSize(ScrW(), ScrH())
		panel:MakePopup()
		panel:SetDraggable(false)
		panel:AlphaTo(255, 0.3)
	end

	panel.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
	end

	panel.Close = function()
		panel:AlphaTo(0, 0.3, 0, function()
			panel:Remove()
		end)
	end

	if parent then
		parent:AddToWorkSpace(panel)
	end

	local child = vgui.Create("DPanel", panel)
	child:SetSize(panel:GetWide() / 3, 180)
	child:Center()

	child.Paint = function(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["d"])
		draw.DrawText(MSD.TextWrap(question, "MSDFont.22", w - 20), "MSDFont.22", w / 2, 12, color_white, TEXT_ALIGN_CENTER)
	end

	-- Cancel button
	local cancelBut = vgui.Create("DButton", child)
	cancelBut:SetText(cancelText or "Cancel")
	cancelBut:SetSize(child:GetWide() / 2 - 15, 40)
	cancelBut:SetPos(10, 130)
	cancelBut.alpha = 0

	cancelBut.Paint = function(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])

		if self.hover then
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 0)
		end

		draw.DrawText(self:GetText(), "MSDFont.22", w / 2, h / 2 - 11, MSD.ColorAlpha(MSD.Text["s"], 255 - self.alpha * 255), TEXT_ALIGN_CENTER)
		draw.DrawText(self:GetText(), "MSDFont.22", w / 2, h / 2 - 11, MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 255), TEXT_ALIGN_CENTER)
		MSDX.Draw(0, MSD.Config.Rounded, h - 1, w - MSD.Config.Rounded * 2, 1, MSD.ColorAlpha(MSD.Text["n"], 255 - self.alpha * 255))
		MSDX.Draw(0, MSD.Config.Rounded, h - 1, w - MSD.Config.Rounded * 2, 1, MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 255))

		return true
	end

	cancelBut.OnCursorEntered = function(self) self.hover = true end
	cancelBut.OnCursorExited = function(self) self.hover = false end

	cancelBut.DoClick = function()
		MSD.UISnd("msd/ui/click.wav")
		panel.Close()
	end

	-- Accept (hold) button
	local acceptBut = vgui.Create("DButton", child)
	acceptBut:SetText(acceptText or "Accept")
	acceptBut:SetSize(child:GetWide() / 2 - 15, 40)
	acceptBut:SetPos(child:GetWide() / 2 + 5, 130)
	acceptBut.alpha = 0
	acceptBut.holdStart = nil
	acceptBut.holdProgress = 0
	acceptBut.holding = false
	acceptBut.Paint = function(self, w, h)
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Theme["l"])

		if self.hover then
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 1)
		else
			self.alpha = Lerp(FrameTime() * 5, self.alpha, 0)
		end

		-- Hold progress
		if self.holding and self.holdStart then
			self.holdProgress = math.Clamp((CurTime() - self.holdStart) / holdTime, 0, 1)

			if self.holdProgress >= 1 then
				self.holding = false
				self.holdStart = nil
				self.holdProgress = 0

				panel.Close()
				acceptFunc()

				return true
			end
		else
			self.holdProgress = Lerp(FrameTime() * 8, self.holdProgress, 0)
		end

		-- Progress bar fill
		if self.holdProgress > 0.01 then
			MSDX.Draw(MSD.Config.Rounded, 0, 0, w * self.holdProgress, h, MSD.ColorAlpha(MSD.Config.MainColor["p"], 80))
		end

		-- Text
		local textColor = self.holdProgress > 0.01 and color_white or MSD.ColorAlpha(MSD.Text["s"], 255 - self.alpha * 255)
		local textColorHover = MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 255)

		if self.holdProgress <= 0.01 then
			draw.DrawText(self:GetText(), "MSDFont.22", w / 2, h / 2 - 11, textColor, TEXT_ALIGN_CENTER)
			draw.DrawText(self:GetText(), "MSDFont.22", w / 2, h / 2 - 11, textColorHover, TEXT_ALIGN_CENTER)
		else
			draw.DrawText(self:GetText(), "MSDFont.22", w / 2, h / 2 - 11, color_white, TEXT_ALIGN_CENTER)
		end

		-- Bottom line
		local lineColor = self.holdProgress > 0.01 and MSD.Config.MainColor["p"] or MSD.ColorAlpha(MSD.Text["n"], 255 - self.alpha * 255)
		MSDX.Draw(0, MSD.Config.Rounded, h - 1, w - MSD.Config.Rounded * 2, 1, lineColor)

		if self.holdProgress <= 0.01 then
			MSDX.Draw(0, MSD.Config.Rounded, h - 1, w - MSD.Config.Rounded * 2, 1, MSD.ColorAlpha(MSD.Config.MainColor["p"], self.alpha * 255))
		end

		return true
	end
	acceptBut.OnCursorEntered = function(self) self.hover = true end
	acceptBut.OnCursorExited = function(self)
		self.hover = false
		self.holding = false
		self.holdStart = nil
	end
	acceptBut.OnMousePressed = function(self, keyCode)
		if keyCode == MOUSE_LEFT then
			self.holding = true
			self.holdStart = CurTime()
		end
	end
	acceptBut.OnMouseReleased = function(self, keyCode)
		if keyCode == MOUSE_LEFT then
			self.holding = false
			self.holdStart = nil
		end
	end
	acceptBut.DoClick = function() end

	return panel, child
end

local voiceover
local paneleffect
local cooldown = 0
local que

function MSD.VoiceOver(text, panel)
	if que then return end

	if IsValid(voiceover) then
		voiceover:Stop()
		voiceover = nil
	end
	local url = "http://tts.voicetech.yandex.net/tts?&format=wav&lang=ru_RU&speed=1.2&speaker=kolya&text=" .. urlencode(text)

	paneleffect = panel
	que = true
	sound.PlayURL(url, "noplay", function(station, eid, err)
		que = false
		if IsValid(station) and IsValid(panel) then
			station:Play()
			voiceover = station
		end
	end)
end

function MSD.InfoTextF1(parent, text, wide, font, novo)
	font = font or "MSDFont.22"
	local panel = vgui.Create("DPanel")
	local ts, _, th = MSD.TextWrap(text, font, wide - 30)

	panel.StaticScale = {
		w = 1,
		fixed_h = th + 10,
		minw = 250,
		minh = th
	}

	panel.Paint = function(self, w, h)
		if IsValid(paneleffect) and paneleffect == self then
			local vv = IsValid(voiceover)
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
			if vv then MSDX.Draw(0, 0, h - 2, w, 2, MSD.Config.MainColor["p"]) end
		end

		draw.DrawText(ts, font, 5, 0, MSD.Text.d, TEXT_ALIGN_LEFT)
	end

	panel.OnRemove = function()
		if IsValid(voiceover) then
			voiceover:Stop()
			voiceover = nil
		end
	end

	parent:AddItem(panel)

	if not novo then
		MSD.IconButton(panel, MSD.Icons48.face_agent, wide - 24, 3, 24, nil, nil, function()
			if cooldown > CurTime() then return end
			cooldown = CurTime() + .1
			MSD.VoiceOver(text, panel)
		end)
	end

	return panel
end

function MSD.InfoTextButton(parent, text, wide, func, font)
	font = font or "MSDFont.22"

	local ts, _, th = MSD.TextWrap(text, font, wide - 30)

	local panel = vgui.Create("DButton")
	panel:SetText("")
	panel.hovered = false
	panel.alpha = 0
	panel.StaticScale = {
		w = 1,
		fixed_h = th + 10,
		minw = 250,
		minh = th
	}

	panel.Paint = function(self, w, h)

		if self.hover then
			MSDX.Draw(0, 0, 0, w, h, MSD.Theme.l)
		end

		MSDX.Draw(0, 0, 0, self.hover and 3 or 2, h, MSD.Config.MainColor["p"])

		draw.DrawText(ts, font, 7, 0, MSD.Text.d, TEXT_ALIGN_LEFT)
		return true
	end

	panel.OnRemove = function()
		if IsValid(voiceover) then
			voiceover:Stop()
			voiceover = nil
		end
	end

	panel.DoClick = func

	panel.OnCursorEntered = function(self)
		self.hover = true
	end

	panel.OnCursorExited = function(self)
		self.hover = false
	end

	panel.DoRightClick = func

	parent:AddItem(panel)
	return panel
end

function MSD.UISnd(snd)
end

function MSD.PlaySnd(snd, vol)
	sound.PlayFile("sound/" .. snd, "noplay", function(stn, ec, er)
		if (IsValid(stn)) then
			stn:Play()
			stn:SetVolume(vol or 1)
		else
			print("[MCS] Error playing sound", snd, ec, er)
		end
	end)
end

function MSD.Anim(time, ease)
	local ANIM = {}
	ANIM.D = time
	ANIM.P = 0
	ANIM.Value = 0
	ANIM.From = 0
	ANIM.To = 1
	ANIM.E = ease
	ANIM.Stoped = false

	function ANIM:Lerp()
		if self.E and math.ease[ANIM.E] then
			return Lerp(math.ease[ANIM.E](self.P),self.From,self.To)
		end

		return Lerp(self.P,self.From,self.To)
	end

	function ANIM:Reset()
		self.S = CurTime()
		self.Stoped = nil
	end

	function ANIM:Start()
		if not self.Stoped and self.S then return end
		self.S = CurTime()
	end

	function ANIM:Done(reverced) end

	function ANIM:Finish()
		if self.Stoped then return end
		self.Value = self.To
		self.Stoped = true
		ANIM:Done(self.From > self.To)
	end

	function ANIM:Play()
		if not self.S or self.S + self.D < CurTime() then self:Finish() return end
		self.P = ( CurTime() - self.S ) / self.D
		self.Value = self:Lerp()
	end

	function ANIM:Reverse()
		self.From, self.To = self.To, self.From
	end

	function ANIM:FadeIn()
		self.From, self.To = 0, 1
	end

	function ANIM:FadeOut()
		self.From, self.To = 1, 0
	end

	function ANIM:Stop()
		self.S = nil
	end

	function ANIM:InProgress()
		return self.S and self.S + self.D > CurTime()
	end

	return ANIM
end

function MSD.NiceTime( seconds )

	if ( seconds == nil ) then return "пару минут" end

	if ( seconds < 60 ) then
		local t = math.floor( seconds )
		return t .. " сек."
	end

	if ( seconds < 60 * 60 ) then
		local t = math.floor( seconds / 60 )
		return t .. " мин."
	end

	if ( seconds < 60 * 60 * 24 ) then
		local t = math.floor( seconds / (60 * 60) )
		local m = math.floor( (seconds - t * 60 * 60 ) / 60 )
		return t .. " ч. " .. m .. " мин."
	end

	if ( seconds < 60 * 60 * 24 * 7 ) then
		local t = math.floor( seconds / ( 60 * 60 * 24 ) )
		return t .. " д."
	end

	if ( seconds < 60 * 60 * 24 * 365 ) then
		local t = math.floor( seconds / ( 60 * 60 * 24 * 7 ) )
		return t .. " нед."
	end

	local t = math.floor( seconds / ( 60 * 60 * 24 * 365 ) )
	return t .. " г."

end

function MSD.DropIcon(parent, mat, s, color, func, descr)
	local button = vgui.Create("DButton")

	button.StaticScale = {
		w = s,
		h_w = true,
		minw = 64
	}

	button:SetSize(s, s)
	button:SetText("")
	button.hovered = false
	button.alpha = 0
	button.mat = mat
	button.bgpaint = bg
	button.showdsc = true
	button.descr = descr

	button.Paint = function(self, w, h)

		MSD.DrawTexturedRect(0, 0, w, h, self.mat, color_white)

		surface.SetDrawColor(color)
		surface.DrawOutlinedRect(0,0,w,h,3)

		return true
	end

	button.DoClick = function(...)
		MSD.UISnd("msd/ui/click.wav")
		func(...)
	end

	button.OnCursorEntered = function(self)
		self.hover = true
	end

	button.OnCursorExited = function(self)
		self.hover = false
	end

	button.DoRightClick = function(...)
		MSD.UISnd("msd/ui/click.wav")
		func(...)
	end

	parent:AddItem(button)


	return button
end

-- Left-rounded strip (only the left corners were ever drawn by the old texture-corner version)
function MSD.RoundedBoxEx( bordersize, x, y, w, h, color )
	if ( bordersize <= 0 ) then
		MSDX.Draw( 0, x, y, w, h, color )
		return
	end

	bordersize = math.min( bordersize, math.floor( w / 2 ), math.floor( h / 2 ) )
	MSDX.Draw( bordersize, x, y, bordersize, h, color, MSDX.NO_TR + MSDX.NO_BR )
end