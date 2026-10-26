--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/gb_rp_sign_big/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

ShopFront = ShopFront or {}

for i = 1, 30 do
	surface.CreateFont("SF1S" .. i , {
		font = "Merriweather Black",
		extended = true,
		size = i * 10,
		weight = 100,
		antialias = true
	})

	surface.CreateFont("SF2S" .. i , {
		font = "Merriweather Bold Italic",
		extended = true,
		size = i * 10,
		weight = 100,
		antialias = true
	})

	surface.CreateFont("SF3S" .. i , {
		font = "No Continue [RUS by Daymarius]",
		extended = true,
		size = i * 10,
		weight = 800,
		antialias = true
	})

	surface.CreateFont("SF4S" .. i , {
		font = "BERNIER Shade",
		extended = true,
		size = i * 10,
		weight = 100,
		antialias = true
	})

	surface.CreateFont("SF5S" .. i , {
		font = "Brahms Gotisch Cyr",
		extended = true,
		size = i * 10,
		weight = 100,
		antialias = true
	})

	surface.CreateFont("SF6S" .. i , {
		font = "Consuela",
		extended = true,
		size = i * 10,
		weight = 100,
		antialias = true
	})
end

local mats = {
	Material("cityrp/stains.png", "smooth"),
	Material("cityrp/lumhd.png", "smooth"),
}

local dirtmat = {
	[1] = Material("cityrp/dirt.png", "smooth"),
	[2] = Material("cityrp/dirt1.png", "smooth"),
	[3] = Material("cityrp/dirt0.png", "smooth")
}

local prsts = {
	Color(206,206,206),
	Color(39,39,39),
	Color(122,187,224),
	Color(9,82,177),
	Color(5,109,5),
	Color(6,138,87),
	Color(230,199,64),
	Color(209,104,5),
	Color(177,29,9),
	Color(114,68,158),
}

ShopFront.Colors = prsts

local function drawText(t, f, x, y, c1, a1, a2, c2, ot, sd)
	if ot then
		draw.SimpleTextOutlined(t, f, x, y, c2, a1, a2, ot, c1)
		return
	end
	if sd then
		draw.SimpleText(t, f, x + sd, y + sd, color_black, a1, a2)
	end

	draw.SimpleText(t, f, x, y, c1, a1, a2)
end

ShopFront.Paint = {
	[1] = function(self, w, h, c1, c2)
		draw.RoundedBox(0, 0, 0, w, h, c1)
		drawText(self.text, self.font, w / 2, 0, c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f1out, self.f1sd)
		drawText(self.stext, self.sfont, w / 2, self.f1h - 10, c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f2out, self.f2sd)
	end,
	[2] = function(self, w, h, c1, c2)
		draw.RoundedBox(0, 0, 0, w, h, c1)
		drawText(self.text, self.font, w / 2, 0, c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f1out, self.f1sd)

		draw.RoundedBox(0, 0, self.f1h, w, h - self.f1h, c2)
		drawText(self.stext, self.sfont, w / 2, self.f1h + math.max((h - self.f1h - self.f2h) / 2, 0), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c2, self.f2out, self.f2sd)
	end,
	[3] = function(self, w, h, c1, c2)
		draw.RoundedBox(0, 0, 0, w, h, c1)
		drawText(self.text, self.font, w / 2, 0, c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f1out, self.f1sd)

		draw.RoundedBox(16, (w - self.f2w) / 2 - 10, self.f1h + math.max((h - self.f1h - self.f2h) / 2, 0), self.f2w + 20, self.f2h, c2)
		drawText(self.stext, self.sfont, w / 2, self.f1h + math.max((h - self.f1h - self.f2h) / 2, 0), c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f2out, self.f2sd)
	end,
	[4] = function(self, w, h, c1, c2)
		draw.RoundedBox(0, 0, 0, w, h, c1)
		drawText(self.text, self.font, w / 2, 0, c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f1out, self.f1sd)

		draw.RoundedBox(0, 0, self.f1h + 5, w, self.f2h, c2)
		drawText(self.stext, self.sfont, w / 2, self.f1h, c1, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f2out, self.f2sd)
	end,
	[5] = function(self, w, h, c1, c2)
		draw.RoundedBox(0, 0, 0, w, h, c1)
		drawText(self.text, self.font, w / 2,  h / 2 + self.f1h / 4, c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, c1, self.f1out, self.f1sd)
		drawText(self.stext, self.sfont, w / 2, math.max((h - self.f1h - self.f2h) / 2, 0), c2, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, c1, self.f2out, self.f2sd)
	end,
}

local w, h = 820, 391

function ENT:Draw()
	if not DarkRP.InRange(LocalPlayer(), self, 2900) then return end
	self:DrawModel()

	if not self.dirt then
		self.dirt = dirtmat[math.random(#dirtmat)]
	end

	if not self.font then
		self.text = self:GetT1()
		self.stext = self:GetT2()
		self.f1 = self:GetF1()
		self.f2 = self:GetF2()
		self.style = self:GetST()
		self.cl1 = self:GetC1()
		self.cl2 = self:GetC2()

		self.f1out = self:GetO1() and self:GetO1() > 0 and math.Clamp(self:GetO1(), 0, 8)
		self.f1sd = self:GetS1() and self:GetS1() > 0 and math.Clamp(self:GetS1(), 0, 8)
		self.f2out = self:GetO2() and self:GetO2() > 0 and math.Clamp(self:GetO2(), 0, 8)
		self.f2sd = self:GetS2() and self:GetS2() > 0 and math.Clamp(self:GetS2(), 0, 8)

		if utf8.len(self.text) > 50 then self.text = utf8.sub(self.text, 1, 50) end
		if utf8.len(self.stext) > 50 then self.stext = utf8.sub(self.stext, 1, 50) end

		local f = ""
		for i = 0, 29 do
			if self.font and self.sfont then break end

			f = "SF" .. math.Clamp(self:GetF1(), 1, 6) .. "S" .. 30 - i
			surface.SetFont(f)
			local wd1, hd1 = surface.GetTextSize(self.text)

			if wd1 <= w - 20 and not self.font then
				self.font = f
				self.f1w, self.f1h = wd1, hd1
			end

			f = "SF" .. math.Clamp(self:GetF2(), 1, 6) .. "S" .. 30 - i
			surface.SetFont(f)
			local wd2, hd2 = surface.GetTextSize(self.stext)

			if i > 15 and wd2 <= w - 20 and not self.sfont and hd1 + hd2 < h then
				self.sfont = f
				self.f2w, self.f2h = wd2, hd2
			end
		end
	end

	local Pos = self:GetPos()
	local Ang = self:GetAngles()
	local CT = CurTime()

	Ang:RotateAroundAxis(Ang:Up(), self:GetForward():Dot(EyePos() - Pos) > 0 and 90 or -90)
	Ang:RotateAroundAxis(Ang:Forward(), 90)

	cam.Start3D2D(Pos + Ang:Up() * 3 - Ang:Right() * 38 + Ang:Forward() * -78, Ang, 0.19)
		if ShopFront.Paint[self.style] then
			ShopFront.Paint[self.style](self, w, h, prsts[self.cl1] or prsts[1], prsts[self.cl2] or prsts[2])
		else
			ShopFront.Paint[1](self, w, h, prsts[self.cl1] or prsts[1], prsts[self.cl2] or prsts[2])
		end

		MSD.DrawTexturedRect(0, 0, w, h, self.dirt or dirt[1], color_white)
		MSD.DrawTexturedRect(0, 0, w, h, mats[2], color_white)
		MSD.DrawTexturedRect(0, 0, w, h, mats[1], color_white)

		if DarkRP.InRange(LocalPlayer(), self, 900) and (not self.nextef or self.nextef < CT) then
			draw.RoundedBox(0, 0, 0, w, h, MSD.ColorAlpha(color_black, math.random(3, 8) * 10))

			if not self.nextef or self.nextef + math.random(3) < CT then
				self.nextef = CT + math.random(2, 60)
			end
		end
	cam.End3D2D()
end