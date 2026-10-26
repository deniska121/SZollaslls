-- "addons\\mc_phone\\lua\\mc_phone\\phones\\mcphone.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local Theme = {}
Theme.ent = "mc_phone"

Theme.Themes = {
	["Green"] = {
		["menu"] = Color(0, 120, 0),
		["buttons"] = Color(50, 200, 50),
		["phone"] = Color(20, 140, 30),
		["def_wp"] = "Green Glow",
	},
	["Orange"] = {
		["menu"] = Color(240, 90, 0),
		["buttons"] = Color(255, 145, 40),
		["phone"] = Color(190, 120, 50),
		["def_wp"] = "Orange Halftone",
	},
	["Blue"] = {
		["menu"] = Color(134, 172, 234),
		["buttons"] = Color(0, 175, 240),
		["phone"] = Color(80, 130, 200),
		["def_wp"] = "Default",
	},
	["Red"] = {
		["menu"] = Color(170, 0, 0),
		["buttons"] = Color(130, 0, 0),
		["phone"] = Color(110, 20, 20),
		["def_wp"] = "Red Triangles",
	},
	["Grey"] = {
		["menu"] = Color(110, 110, 110),
		["buttons"] = Color(115, 115, 115),
		["phone"] = Color(100, 100, 100),
		["def_wp"] = "None",
	},
	["Purple"] = {
		["menu"] = Color(50, 0, 110),
		["buttons"] = Color(190, 115, 235),
		["phone"] = Color(150, 0, 210),
		["def_wp"] = "Purple Glow",
	},
	["Pink"] = {
		["menu"] = Color(225, 0, 140),
		["buttons"] = Color(250, 110, 200),
		["phone"] = Color(185, 95, 155),
		["def_wp"] = "Purple Tartan",
	},
}

Theme.WallPapers = {
	["None"] = "",
	["Default"] = "phone_wallpaper_McPhonedefault.png",
	["Blue Shards"] = "phone_wallpaper_blueshards.png",
	["Blue Angles"] = "phone_wallpaper_blueangles.png",
	["Blue Circles"] = "phone_wallpaper_bluecircles.png",
	["Diamonds"] = "phone_wallpaper_diamonds.png",
	["Green Glow"] = "phone_wallpaper_greenglow.png",
	["Green Shards"] = "phone_wallpaper_greenshards.png",
	["Green Squares"] = "phone_wallpaper_greensquares.png",
	["Green Triangles"] = "phone_wallpaper_greentriangles.png",
	["Orange 8bit"] = "phone_wallpaper_orange8bit.png",
	["Orange Halftone"] = "phone_wallpaper_orangehalftone.png",
	["Orange Herringbone"] = "phone_wallpaper_orangeherringbone.png",
	["Orange Triangles"] = "phone_wallpaper_orangetriangles.png",
	["Red Triangles"] = "phone_wallpaper_redtriangles.png",
	["Purple Glow"] = "phone_wallpaper_purpleglow.png",
	["Purple Tartan"] = "phone_wallpaper_purpletartan.png",
}

Theme.Ringtone = {
	[1] = "tone_1.wav",
	[2] = "tone_2.wav",
	[3] = "tone_3.wav",
	[4] = "tone_4.wav",
	[5] = "tone_5.wav",
	[6] = "tone_6.wav",
	[7] = "tone_7.wav",
	[8] = "tone_8.wav",
	[9] = "tone_9.wav",
	["Silent"] = "",
}

McPhone.McPhone = Theme

McPhone.PhoneTypes.McPhone = {
	main_mat = Material("mc_phone/phone/p.png", "smooth"),
	frame_mat = Material("mc_phone/phone/f.png", "smooth"),
	size = {296, 510},
	spos = {20, 71},
	button_bg = "mc_phone/phone/screen_buttons.png",
	text_color = color_black,
	text_bg = color_white,
}

local text_pos = 0
local text_dir
local black_50 = Color(0, 0, 0, 50)

McPhone.PhoneTypes.McPhone.PaintTop = function(w, h, battery, b_collor)
	draw.RoundedBox(0, 0, 0, 256, 70, color_black)
	McPhone.DrawTexturedRect(w - 32, 3, 30, 18, "mc_phone/icons/battery.png", color_white)
	draw.RoundedBox(0, w - 25, 9, math.Clamp(battery / 100 * 14, 0, 14), 6, b_collor)
	draw.SimpleText(McPhone.GetCurTime(), "McPhone.Main22", w / 2 - 1, 2, color_white, TEXT_ALIGN_CENTER)
	McPhone.DrawSignal(0, 0)
	draw.RoundedBox(0, 0, 25, 256, 44, McPhone.UserCfg.Theme["menu"])
	draw.RoundedBox(0, 0, 49, 256, 20, Color(0, 0, 0, 100))

	if McPhone.UserCfg.WallPaper and McPhone.UserCfg.WallPaper ~= "" then
		McPhone.DrawTexturedRect(0, 69, 256, 256, "mc_phone/wp/" .. McPhone.UserCfg.WallPaper, color_white)
	else
		draw.RoundedBox(0, 0, 69, 256, 256, color_black)
	end

	local text = McPhone.UI.OpenedMenu
	surface.SetFont("McPhone.Main38")
	local tw = surface.GetTextSize(text)

	if tw > w then
		if text_dir and isnumber(text_dir) and text_dir < CurTime() then
			text_dir = nil
		end

		if text_pos > w - tw - 50 and not text_dir then
			text_pos = math.Approach(text_pos, w - tw - 50, FrameTime() * 70)
		else
			if text_pos >= 10 and not isnumber(text_dir) then
				text_dir = CurTime() + 2
			else
				text_pos = math.Approach(text_pos, 10, FrameTime() * 70)
			end

			if not text_dir then
				text_dir = true
			end
		end

		draw.SimpleTextOutlined(McPhone.UI.OpenedMenu, "McPhone.Main38", text_pos, 25, color_white, TEXT_ALIGN_LEFT, 2, 2, black_50)
	else
		draw.SimpleTextOutlined(McPhone.UI.OpenedMenu, "McPhone.Main38", w / 2, 25, color_white, TEXT_ALIGN_CENTER, 2, 2, black_50)
	end
end

function McPhone.PhoneTypes.McPhone.MainIcons(parent, icon, text, func, label)
	local alpha, a = 0, 0

	if isstring(icon) then
		icon = Material(icon, "smooth")
	end

	local buton = vgui.Create("DButton")
	buton:SetSize(80, 80)
	buton:SetText("")

	buton.DoClick = function(self)
		McPhone.PlaySoundUI("open")

		if func then
			func(self)
		end
	end

	buton.Paint = function(self, w, h)
		if self.hover then
			alpha = Lerp(0.05, alpha, 100)
			a = 10
		else
			alpha = Lerp(0.05, alpha, 0)
			a = 0
		end

		draw.RoundedBox(8, 8, 8, 64, 64, Color(255, 255, 255, alpha))
		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(15 - a / 2, 15 - a / 2, 50 + a, 50 + a)

		if label and label > 0 then
			surface.SetFont("McPhone.Main20")
			local tw = surface.GetTextSize(label)
			local wh = 18

			if tw > wh - 10 then
				wh = tw + 10
			end

			draw.RoundedBox(12, 5, 5, wh, 18, Color(255, 0, 0))
			draw.SimpleText(label, "McPhone.Main20", 10, 2, color_white, TEXT_ALIGN_LEFT)
		end
	end

	buton.OnCursorEntered = function(self, mute)
		if not mute then
			McPhone.PlaySoundUI("click")
		end

		self.hover = true

		if McPhone.UI then
			McPhone.UI.OpenedMenu = text
		end

		for k, v in pairs(parent:GetItems()) do
			if v == self then continue end
			if v.unused then continue end
			v:OnCursorExited()
		end
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(buton)
end