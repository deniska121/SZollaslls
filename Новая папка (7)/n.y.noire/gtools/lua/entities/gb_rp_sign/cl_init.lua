--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/gb_rp_sign/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local tc = Color(0,0,0,225)

local fonts = {
	[1] = "MSDFont.16",
	[2] = "MSDFontB.16",
	[3] = "MSDFont.22",
	[4] = "MSDFontB.22",
	[5] = "SF1S1",
	[6] = "SF1S2",
	[7] = "SF2S1",
	[8] = "SF2S2",
	[9] = "SF5S2",
	[10] = "SF6S2",
}

function ENT:Initialize()
	self.frame = vgui.Create("DPanel")
	self.frame:SetSize(230, 135)
	self.frame.t = self:GetText()
	self.frame.oldtext = ""
	self.frame.f = "MSDFontB.16"
	self.frame:SetPaintedManually(true)

	self.frame.Paint = function(s, w, h)
		if s.ot ~= s.t or s.ow ~= w then
			s.t, s.tw, s.th = MSD.TextWrap(s.t, s.f, w - 10)
			s.ot = s.t
			s.ow = w
		end
		surface.DisableClipping(false)
			draw.DrawText(s.t, s.f, w / 2, h / 2 - s.th / 2, tc, TEXT_ALIGN_CENTER)
		surface.DisableClipping(true)
	end
end

local drawType = {
	[1] = function(self)
		local Pos = self:GetPos()
		local Ang = self:GetAngles()

		if self.frame and not self.frame.resized then
			self.frame.resized = true
			self.frame:SetSize(135, 230)
		end

		Ang:RotateAroundAxis(Ang:Right(), -90)
		Ang:RotateAroundAxis(Ang:Up(), 90)

		cam.Start3D2D(Pos + Ang:Up() * 0.45 - Ang:Right() * 11.5 + Ang:Forward() * -6.7, Ang, 0.1)
			self.frame:PaintManual()
		cam.End3D2D()
	end,
	[2] = function(self)
		local Pos = self:GetPos()
		local Ang = self:GetAngles()

		if self.frame and not self.frame.resized then
			self.frame.resized = true
			self.frame:SetSize(230, 135)
		end

		Ang:RotateAroundAxis(Ang:Right(), -90)

		cam.Start3D2D(Pos + Ang:Up() * 0.45 - Ang:Right() * 6.7 + Ang:Forward() * -11.5, Ang, 0.1)
			self.frame:PaintManual()
		cam.End3D2D()
	end,
}

function ENT:Draw()
	self:DrawModel()

	if IsValid(self.frame) then
		self.frame.t = self:GetText()
		self.frame.f = fonts[self:GetFont()]
	end

	if drawType[self:GetType()] then
		drawType[self:GetType()](self)
	end
end