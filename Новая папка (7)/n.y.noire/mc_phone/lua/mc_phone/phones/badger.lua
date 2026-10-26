--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/phones/badger.lua
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
local Theme = {}
Theme.ent = "mc_phone_bg"

Theme.Themes = {
	["Green"] = {
		["menu"] = Color(0, 120, 0),
		["buttons"] = Color(50, 200, 50),
		["phone"] = Color(20, 140, 30),
		["def_wp"] = "Default",
	},
	["Orange"] = {
		["menu"] = Color(240, 90, 0),
		["buttons"] = Color(255, 145, 40),
		["phone"] = Color(190, 120, 50),
		["def_wp"] = "Default",
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
		["def_wp"] = "Default",
	},
	["Grey"] = {
		["menu"] = Color(110, 110, 110),
		["buttons"] = Color(115, 115, 115),
		["phone"] = Color(100, 100, 100),
		["def_wp"] = "Default",
	},
	["Purple"] = {
		["menu"] = Color(50, 0, 110),
		["buttons"] = Color(190, 115, 235),
		["phone"] = Color(150, 0, 210),
		["def_wp"] = "Default",
	},
	["Pink"] = {
		["menu"] = Color(225, 0, 140),
		["buttons"] = Color(250, 110, 200),
		["phone"] = Color(185, 95, 155),
		["def_wp"] = "Default",
	},
}

Theme.WallPapers = {
	["None"] = "",
	["Default"] = "phone_wallpaper_badgerdefault.png",
	["Smoke"] = "phone_wallpaper_bittersweet_b.png",
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

McPhone.Badger = Theme

McPhone.PhoneTypes.Badger = {
	main_mat = Material("mc_phone/phone/bg/p.png", "smooth"),
	frame_mat = Material("mc_phone/phone/bg/f.png", "smooth"),
	size = {305, 526},
	spos = {25, 79},
	button_bg = "mc_phone/phone/screen_buttons.png",
	text_color = color_black,
	text_bg = color_white,
}

local text_pos = 0
local text_dir
local black_50 = Color(0, 0, 0, 50)
local black_150 = Color(0, 0, 0, 200)

McPhone.PhoneTypes.Badger.PaintTop = function(w, h, battery, b_collor)
	if McPhone.UI.Menu.List then
		MSDX.Draw(0, 0, 0, 256, 70, color_black)
		draw.SimpleText(McPhone.GetCurTime(), "McPhone.Main22", 10, 2, color_white, TEXT_ALIGN_LEFT)
		McPhone.DrawSignal(w - 36, 2, true)
		MSDX.Draw(0, 0, 25, 256, 44, McPhone.UserCfg.Theme["menu"])
		McPhone.DrawTexturedRect(0, 25, 256, 44, "gui/gradient_up", black_150)
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
	else
		if McPhone.UserCfg.WallPaper and McPhone.UserCfg.WallPaper ~= "" then
			McPhone.DrawTexturedRect(0, 0, 256, 325, "mc_phone/wp/" .. McPhone.UserCfg.WallPaper, McPhone.UserCfg.Theme["buttons"])
		else
			MSDX.Draw(0, 0, 0, 256, 325, color_black)
		end

		MSDX.Draw(0, 0, 0, 256, 32, black_150)
		MSDX.Draw(0, 0, 33, 256, 36, black_150)
		draw.SimpleText(McPhone.GetCurTime(), "McPhone.Main28", w / 2, 0, color_white, TEXT_ALIGN_CENTER)
		McPhone.DrawSignal(w - 36, 2, true)
		McPhone.DrawTexturedRect(7, 5, 30, 18, "mc_phone/icons/battery.png", color_white)
		MSDX.Draw(0, 14, 11, math.Clamp(battery / 100 * 14, 0, 14), 6, b_collor)
		draw.SimpleText(McPhone.UI.OpenedMenu, "McPhone.Main32", w / 2, 35, color_white, TEXT_ALIGN_CENTER, 2)
	end
end

local menu_replace = {
	["mc_phone/icons/main_menu/cloud.png"] = "mc_phone/icons/bg_menu/cloud.png",
	["mc_phone/icons/main_menu/cont.png"] = "mc_phone/icons/bg_menu/cont.png",
	["mc_phone/icons/main_menu/gps.png"] = "mc_phone/icons/bg_menu/gps.png",
	["mc_phone/icons/main_menu/job.png"] = "mc_phone/icons/bg_menu/job.png",
	["mc_phone/icons/main_menu/mail.png"] = "mc_phone/icons/bg_menu/mail.png",
	["mc_phone/icons/main_menu/sets.png"] = "mc_phone/icons/bg_menu/sets.png",
	["mc_phone/icons/main_menu/sms.png"] = "mc_phone/icons/bg_menu/sms.png",
	["mc_phone/icons/main_menu/web.png"] = "mc_phone/icons/bg_menu/web.png",
}

function McPhone.PhoneTypes.Badger.MainIcons(parent, icon, text, func, label)
	local hl_color = McPhone.UserCfg.Theme["buttons"]
	local bt_color = Color(255, 200, 0)

	if menu_replace[icon] then
		icon = menu_replace[icon]
	end

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
			MSDX.Draw(16, 3, 3, w - 6, h - 6, McPhone.Alpha(color_black, 55))
			MSDX.Draw(16, 6, 6, w - 12, h - 12, McPhone.Alpha(hl_color, 155))
		end

		surface.SetMaterial(icon)
		surface.SetDrawColor(color_white)
		surface.DrawTexturedRect(15, 15, 50, 50)

		if label and label > 0 then
			draw.SimpleTextOutlined(label, "McPhone.Main20", w - 12, 5, bt_color, TEXT_ALIGN_RIGHT, 2, 2, McPhone.Alpha(color_black, 55))
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