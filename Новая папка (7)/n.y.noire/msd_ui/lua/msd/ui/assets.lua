--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/assets.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

MSD.Icons48 = {
	cross = Material("msd/icons/cross.png", "smooth"),
	close_box = Material("msd/icons/close-box.png", "smooth"),
	close_thick = Material("msd/icons/close-thick.png", "smooth"),
	console = Material("msd/icons/console.png", "smooth"),
	check = Material("msd/icons/check.png", "smooth"),
	check_all = Material("msd/icons/check-all.png", "smooth"),
	check_bold = Material("msd/icons/check-bold.png", "smooth"),
	cog = Material("msd/icons/cog.png", "smooth"),
	web = Material("msd/icons/web.png", "smooth"),
	eye = Material("msd/icons/eye.png", "smooth"),
	police = Material("msd/icons/police.png", "smooth"),
	police_outline = Material("msd/icons/police-outline.png", "smooth"),
	box = Material("mqs/map_markers/b4.png", "smooth"),
	box_open = Material("mqs/icons/box_open.png", "smooth"),
	box_open_star = Material("mqs/icons/box_open_star.png", "smooth"),
	layers = Material("msd/icons/layers.png", "smooth"),
	layers_plus = Material("msd/icons/layers-plus.png", "smooth"),
	layers_remove = Material("msd/icons/layers-remove.png", "smooth"),
	briefcase = Material("msd/icons/briefcase.png", "smooth"),
	briefcase_check = Material("msd/icons/briefcase-check.png", "smooth"),
	account = Material("msd/icons/account.png", "smooth"),
	account_plus = Material("msd/icons/account-plus.png", "smooth"),
	account_edit = Material("msd/icons/account-edit.png", "smooth"),
	account_multiple = Material("msd/icons/account-multiple.png", "smooth"),
	account_convert = Material("msd/icons/account-convert.png", "smooth"),
	account_cowboy = Material("msd/icons/account-cowboy-hat.png", "smooth"),
	account_cash = Material("msd/icons/account-cash.png", "smooth"),
	arrow_up = Material("msd/icons/arrow_up.png", "smooth"),
	arrow_down = Material("msd/icons/arrow_down.png", "smooth"),
	arrow_left = Material("msd/icons/arrow-left-bold.png", "smooth"),
	arrow_right = Material("msd/icons/arrow-right-bold.png", "smooth"),
	folder_open = Material("msd/icons/folder-open.png", "smooth"),
	file_hidden = Material("msd/icons/file-hidden.png", "smooth"),
	file_document = Material("msd/icons/file-document.png", "smooth"),
	badge_account = Material("msd/icons/badge-account.png", "smooth"),
	badge_account_horizontal = Material("msd/icons/badge-account-horizontal.png", "smooth"),
	menu = Material("msd/icons/menu.png", "smooth"),
	dice = Material("msd/icons/dice.png", "smooth"),
	discord = Material("msd/icons/discord.png", "smooth"),
	exit_to_app = Material("msd/icons/exit-to-app.png", "smooth"),
	rank = Material("msd/icons/rank.png", "smooth"),
	rank_low = Material("msd/icons/rank_low.png", "smooth"),
	rank_sup = Material("msd/icons/rank_sup.png", "smooth"),
	engine = Material("msd/icons/engine.png", "smooth"),
	download = Material("msd/icons/download.png", "smooth"),
	download_circle = Material("msd/icons/download-circle.png", "smooth"),
	dot = Material("msd/icons/dot.png", "smooth"),
	pencil = Material("msd/icons/pencil.png", "smooth"),
	play = Material("msd/icons/play.png", "smooth"),
	plus = Material("msd/icons/plus.png", "smooth"),
	back = Material("msd/icons/back.png", "smooth"),
	cart = Material("msd/icons/cart.png", "smooth"),
	clipboard_arrow_up = Material("msd/icons/clipboard-arrow-up.png", "smooth"),
	calendar_check = Material("msd/icons/calendar-check.png", "smooth"),
	playlist_edit = Material("msd/icons/playlist-edit.png", "smooth"),
	seal = Material("msd/icons/seal.png", "smooth"),
	save = Material("msd/icons/content-save.png", "smooth"),
	copy = Material("msd/icons/content-copy.png", "smooth"),
	submit = Material("msd/icons/check-decagram.png", "smooth"),
	alert = Material("msd/icons/alert-circle.png", "smooth"),
	arrow_down_color = Material("msd/icons/arrow_down_color.png", "smooth"),
	pause_circle_outline = Material("msd/icons/pause-circle-outline.png", "smooth"),
	play_circle_outline = Material("msd/icons/play-circle-outline.png", "smooth"),
	stop_circle_outline = Material("msd/icons/stop-circle-outline.png", "smooth"),
	face_agent = Material("msd/icons/face-agent.png", "smooth"),
	swap = Material("msd/icons/swap.png", "smooth"),
	search = Material("mqs/map_markers/c4.png", "smooth"),
	tools = Material("mqs/map_markers/t1.png", "smooth"),
	human_female = Material("msd/icons/human-female.png", "smooth"),
	human_male = Material("msd/icons/human-male.png", "smooth"),
	human_female_dance = Material("msd/icons/human-female-dance.png", "smooth"),
	hand_peace_variant = Material("msd/icons/hand-peace-variant.png", "smooth"),
	hand_right = Material("msd/icons/hand-right.png", "smooth"),
	hand_okay = Material("msd/icons/hand-okay.png", "smooth"),
	hand_coin = Material("msd/icons/hand-coin.png", "smooth"),
	run = Material("msd/icons/run.png", "smooth"),
	key = Material("msd/icons/key-variant.png", "smooth"),
	key_arrow_right = Material("msd/icons/key-arrow-right.png", "smooth"),
	key_link = Material("msd/icons/key-link.png", "smooth"),
	key_plus = Material("msd/icons/key-plus.png", "smooth"),
	key_remove = Material("msd/icons/key-remove.png", "smooth"),
	key_star = Material("msd/icons/key-star.png", "smooth"),
	door = Material("msd/icons/door.png", "smooth"),
	car = Material("mqs/map_markers/v1.png", "smooth"),
	time = Material("mqs/map_markers/c5.png", "smooth"),
	cancel = Material("msd/icons/cancel.png", "smooth"),
	pistol = Material("msd/icons/pistol.png", "smooth"),
	pistol_remove = Material("mqs/icons/pistol_remove.png", "smooth"),
	reload = Material("msd/icons/reload.png", "smooth"),
	reload_alert = Material("msd/icons/reload-alert.png", "smooth"),
	gas_station = Material("msd/icons/gas-station.png", "smooth"),
	home = Material("msd/icons/home.png", "smooth"),
	heart = Material("msd/icons/cards-heart.png", "smooth"),
	heart_outline = Material("msd/icons/cards-heart-outline.png", "smooth"),
	heart_broken = Material("msd/icons/heart-broken.png", "smooth"),
	heart_flash = Material("msd/icons/heart-flash.png", "smooth"),
	skip_to = Material("msd/icons/debug-step-over.png", "smooth"),
	food = Material("msd/icons/food.png", "smooth"),
	food_off = Material("msd/icons/food-off-outline.png", "smooth"),
	food_outline = Material("msd/icons/food-outline.png", "smooth"),
	cash = Material("msd/icons/cash.png", "smooth"),
	hazard = Material("msd/icons/hazard-lights.png", "smooth"),
	magazine = Material("msd/icons/magazine-pistol.png", "smooth"),
	basket = Material("msd/icons/basket.png", "smooth"),
	cellphone = Material("msd/icons/cellphone.png", "smooth"),
	cellphone_basic = Material("msd/icons/cellphone-basic.png", "smooth"),
	cellphone_text = Material("msd/icons/cellphone-text.png", "smooth"),
	ammo = Material("mqs/icons/ammo.png", "smooth"),
	music_circle = Material("mqs/icons/music_circle.png", "smooth"),
	armor = Material("mqs/map_markers/a1.png", "smooth"),
	armor_outline = Material("mqs/map_markers/a2.png", "smooth"),
	armor_broken = Material("mqs/map_markers/a4.png", "smooth"),
	armor_flash = Material("mqs/map_markers/a5.png", "smooth"),
	apple = Material("msd/icons/food-apple.png", "smooth"),
	apple_outline = Material("msd/icons/food-apple-outline.png", "smooth"),
	briefcase_remove = Material("msd/icons/briefcase-remove.png", "smooth"),
	biohazard = Material("msd/icons/biohazard.png", "smooth"),
	snowflake = Material("msd/icons/snowflake.png", "smooth"),
	lightning = Material("msd/icons/lightning-bolt.png", "smooth"),
	beer = Material("msd/icons/glass-mug-variant.png", "smooth"),
	shopping = Material("msd/icons/shopping.png", "smooth"),
	silverware = Material("msd/icons/silverware-clean.png", "smooth"),
	compass_rose = Material("msd/icons/compass-rose.png", "smooth"),
	cup = Material("msd/icons/cup.png", "smooth"),
	cup_outline = Material("msd/icons/cup-outline.png", "smooth"),
	lacoin = Material("msd/icons/lacoin.png", "smooth"),
	steam = Material("msd/icons/steam.png", "smooth"),
	vk = Material("msd/icons/vk.png", "smooth"),
	logo_hud = Material("gmodla/logo_hud.png", "smooth"),
	lock = Material("msd/icons/lock.png", "smooth"),
	lock_open = Material("msd/icons/lock-open.png", "smooth"),
	diamond = Material("msd/icons/diamond-stone.png", "smooth"),
	baseball_diamond = Material("msd/icons/baseball-diamond.png", "smooth"),
}

MSD.Materials = {
	vignette = Material("msd/vignette.png", "smooth"),
	gradient = Material("gui/gradient", "smooth"),
	gradient_right = Material("msd/gradient_right.png", "smooth"),
	gradient_center = Material("gui/center_gradient", "smooth"),
}

MSD.PinPoints = {
	[0] = Material("mqs/icons/pin.png", "smooth"),
}

local files = file.Find("materials/mqs/map_markers/*", "GAME")

for k, v in pairs(files) do
	MSD.PinPoints[k] = Material("mqs/map_markers/" .. v, "smooth")
end

MSD.Icons48.info_big = Material("info.png", "smooth")
MSD.Icons48.cuffs = Material("cyberhud/cuffs.png", "smooth")

MSD.Materials.logo = Material("gmodla/logo_c2.png", "smooth")
MSD.Materials.icon_bg = Material("msd/icon_bg.png", "smooth")

local f = file.Find("materials/msd/icons/auto/*", "GAME")

for k, v in pairs(f) do
	MSD.Icons48[string.Replace(string.Replace(v, ".png", ""), "-", "_")] = Material("msd/icons/auto/" .. v, "smooth")
end

MSD.ColorPresets = {Color(255, 20, 20), Color(255, 115, 0), Color(210, 255, 0), Color(0, 170, 25), Color(0, 155, 255), Color(0, 100, 200), Color(135, 0, 255), Color(255, 0, 100),}

MSD.Theme = {
	["d_na"] = Color(25, 25, 26),
	["d"] = Color(0, 5, 10, 165),
	["m"] = Color(0, 5, 10, 120),
	["l"] = Color(0, 5, 10, 85),
}

MSD.Text = {
	["a"] = Color(150, 150, 150, 200),
	["n"] = Color(150, 150, 150),
	["d"] = Color(220, 220, 220),
	["s"] = Color(235, 235, 235),
	["m"] = Color(245, 245, 245),
	["l"] = Color(255, 255, 255),
}

MSD.Clr = {
	["red"] = Color(200, 0, 0),
	["red_dark"] = Color(157, 18, 18),
	["green"] = Color(90, 180, 20),
	["blue_dark"] = Color(0, 77, 173),
}

local NewFont = surface.CreateFont

for i = 0, 40 do
	NewFont("MSDFont." .. 12 + i, {
		font = "AdihausDIN",
		extended = true,
		size = 12 + i,
		weight = 500
	})
end

for i = 0, 20 do
	NewFont("MSDFontB." .. 16 + i, {
		font = "AdihausDIN",
		extended = true,
		size = 16 + i,
		weight = 800
	})
end

-- Roboto hint text used by vehicle and melee weapon prompts (was MMD's "M_Roboto")
NewFont("MSDRoboto.20", {
	font = "Roboto",
	extended = true,
	size = 20,
	weight = 500
})

NewFont("MSDFont.Big", {
	font = "AdihausDIN",
	extended = true,
	size = 45,
	weight = 500
})

NewFont("MSDFont.Biger", {
	font = "AdihausDIN",
	extended = true,
	size = 55,
	weight = 500
})

function MSD.DrawBG(panel, w, h)
	if MSD.Config.Blur then
		MSD.Blur(panel, 1, 3, 255, 250 - MSD.Config.BgrColor.r, w, h)
	else
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.Config.BgrColor)
	end
end

function MSD.DrawTexturedOutlined(x, y, w, h, mat, color, outlinewidth, ocolor)
	if isstring(mat) then
		mat = Material(mat)
	end

	surface.SetMaterial(mat)
	surface.SetDrawColor(ocolor)
	local steps = ( outlinewidth * 2 ) / 3
	if ( steps < 1 ) then steps = 1 end

	for _x = -outlinewidth, outlinewidth, steps do
		for _y = -outlinewidth, outlinewidth, steps do
			surface.DrawTexturedRect(x + _x, y + _y, w, h)
		end
	end

	surface.SetDrawColor(color)
	surface.DrawTexturedRect(x, y, w, h)
end

local cached_mat = {}

local function GetCachedMat(path)
	local mat = cached_mat[path]
	if not mat then
		mat = Material(path, "smooth")
		cached_mat[path] = mat
	end
	return mat
end

function MSD.DrawTexturedRect(x, y, w, h, mat, color)
	if isstring(mat) then
		mat = GetCachedMat(mat)
	end

	if not mat then return end -- missing icon: skip it instead of erroring every frame

	surface.SetDrawColor(color)
	surface.SetMaterial(mat)
	surface.DrawTexturedRect(x, y, w, h)
end

function MSD.DrawTexturedRectRotated(rot, x, y, w, h, mat, color)
	if isstring(mat) then
		mat = GetCachedMat(mat)
	end

	if not mat then return end -- missing icon: skip it instead of erroring every frame

	surface.SetDrawColor(color)
	surface.SetMaterial(mat)
	surface.DrawTexturedRectRotated(x, y, w, h, rot)
end

function MSD.DrawTexturedRectOfRot(rot, x, y, w, h, mat, color)
	if isstring(mat) then
		mat = GetCachedMat(mat)
	end

	if not mat then return end -- missing icon: skip it instead of erroring every frame

	surface.SetDrawColor(color)
	surface.SetMaterial(mat)
	surface.DrawTexturedRectRotated(x + w / 2, y + h / 2, w, h, rot)
end

local color_meta = FindMetaTable("Color")

function MSD.ColorAlpha(cl, al)
	return setmetatable({r = cl.r, g = cl.g, b = cl.b, a = al}, color_meta)
end

-- Opaque blend from -> to by t (0..1). Replaces drawing the same thing twice with opposing alphas;
-- returns the input color untouched (no allocation) when the animation is at rest.
function MSD.CrossColor(t, from, to)
	if t <= 0.004 then
		if from.a == 255 then return from end
		t = 0
	elseif t >= 0.996 then
		if to.a == 255 then return to end
		t = 1
	end

	return setmetatable({
		r = from.r + (to.r - from.r) * t,
		g = from.g + (to.g - from.g) * t,
		b = from.b + (to.b - from.b) * t,
		a = 255
	}, color_meta)
end

-- Shader blur (MSDX / RNDX) replaces the old 3-pass pp/blurscreen loop.
-- `strength` keeps the old pp/blurscreen "$blur" scale. RNDX's kernel has a standard deviation of
-- ~8px per unit of intensity, while the old loop (passes at 1/3, 2/3 and 3/3 of $blur) came out at
-- roughly 1.25x its final $blur, so one unit of old strength is ~0.12 RNDX intensity.
MSD.BlurScale = 0.12

-- Alpha at or below this (50%) gives no blur; above it the blur ramps up to full strength at 255
MSD.BlurAlphaThreshold = 255 * 0.5

-- RNDX's blur shader ignores draw alpha, so alpha is applied to the blur strength instead:
-- alpha <= MSD.BlurAlphaThreshold = no blur, 255 = full `strength`.
-- The panel's own alpha (fades, AlphaTo) is combined with it the same way.
-- RNDX intensity for an old-scale strength, after alpha and the panel's own alpha; nil = draw nothing
local function BlurIntensity(strength, alpha)
	if not strength then return end

	local a = (alpha and math.Clamp(alpha, 0, 255) or 255) * surface.GetAlphaMultiplier()
	local threshold = MSD.BlurAlphaThreshold
	if a <= threshold then return end

	local intensity = strength * MSD.BlurScale * (a - threshold) / (255 - threshold)
	if intensity < 0.01 then return end -- under 0.1px of blur; not worth the two screen copies

	return intensity
end

function MSD.DrawBlur(x, y, w, h, strength, radius, alpha)
	local intensity = BlurIntensity(strength, alpha)
	if not intensity then return end

	MSDX().Rect(x, y, w, h):Rad(radius or 0):Blur(intensity):Draw()
end

-- Circular blur centred on x, y
function MSD.DrawBlurCircle(x, y, diameter, strength, alpha)
	local intensity = BlurIntensity(strength, alpha)
	if not intensity then return end

	MSDX().Circle(x, y, diameter):Blur(intensity):Draw()
end

-- Blurs the area behind a panel (its local 0,0,w,h), or the whole screen behind it when w/h are omitted
function MSD.BlurPanel(panel, strength, w, h, alpha)
	if w and h then
		return MSD.DrawBlur(0, 0, w, h, strength, nil, alpha)
	end

	local x, y = panel:LocalToScreen(0, 0)
	MSD.DrawBlur(-x, -y, ScrW(), ScrH(), strength, nil, alpha)
end

-- Old signature kept: final blur strength was (3 / inn) * density
function MSD.Blur(panel, inn, density, alpha, back_alpha, w, h)
	MSD.BlurPanel(panel, (3 / inn) * density, w, h, alpha)

	if back_alpha and back_alpha > 0 then
		MSDX.Draw(MSD.Config.Rounded, 0, 0, w, h, MSD.ColorAlpha(color_black, back_alpha))
	end
end

-- Converts draw.RoundedBoxEx corner booleans to MSDX corner flags
function MSD.CornerFlags(tl, tr, bl, br)
	return (tl and 0 or MSDX.NO_TL) + (tr and 0 or MSDX.NO_TR) + (bl and 0 or MSDX.NO_BL) + (br and 0 or MSDX.NO_BR)
end

-- Stock Derma background blur (used by many menus), rebuilt on the shader blur; same fade and tint
function Derma_DrawBackgroundBlur(panel, starttime)
	local fraction = 1

	if starttime then
		fraction = math.Clamp(SysTime() - starttime, 0, 1)
	end

	local x, y = panel:LocalToScreen(0, 0)
	local sw, sh = ScrW(), ScrH()
	local wasEnabled = DisableClipping(true)

	MSD.DrawBlur(-x, -y, sw, sh, 5 * fraction)

	surface.SetDrawColor(10, 10, 10, 200 * fraction)
	surface.DrawRect(-x, -y, sw, sh)

	DisableClipping(wasEnabled)
end

-- Same used in DarkRP, used it here so we can use it with any gamemodes
local function CharWrap(t, w, ow)
	local a = 0
	local len = utf8.len(t)

	for i = 1, len do
		local wf = string.subUTF8(t, 1, i)
		a = a + 1
		if surface.GetTextSize(wf) >= w then
			a = 0
			return wf .. "\n" .. CharWrap(string.subUTF8(t, i + 1, len), ow, ow), surface.GetTextSize(wf)
		end
	end

	return t
end

function MSD.TextWrap(text, font, w)
	local total = 0
	surface.SetFont(font)
	local spaceSize = surface.GetTextSize(' ')

	text = text:gsub("(%s?[%S]+)", function(word)
		local char = string.subUTF8(word, 1, 1)

		if char == "\n" or char == "\t" then
			total = 0
		end

		local wordlen = surface.GetTextSize(word)
		total = total + wordlen

		if wordlen >= w then
			local splitWord, splitPoint = CharWrap(word, w - (total - wordlen) - surface.GetTextSize("  "), w)
			total = splitPoint

			return splitWord
		elseif total < w then
			return word
		end

		if char == ' ' then
			total = wordlen - spaceSize

			return '\n' .. string.subUTF8(word, 2)
		end

		total = wordlen

		return '\n' .. word
	end)

	local w_end, h_end =  surface.GetTextSize(text)

	return text, w_end, h_end
end

-- Image Lib
MSD.ImgLib = {}
MSD.ImgLib.Images = {}
MSD.ImgLib.PreCacheStarted = {}
MSD.ImgLib.Avatars = {}
MSD.ImgLib.NoMaterial = Material("msd/icons/file-hidden.png", "smooth noclamp")

function MSD.ImgLib.GetMaterial(url, jpg)
	if url == "" then
		return MSD.ImgLib.NoMaterial
	end

	local crc = util.CRC(url) .. ".png"

	if jpg then
		crc = util.CRC(url) .. ".jpg"
	end

	if MSD.ImgLib.Images[crc] then return MSD.ImgLib.Images[crc] end

	if (file.Exists("msd_imgs/" .. crc, "DATA")) then
		MSD.ImgLib.Images[crc] = Material("data/msd_imgs/" .. crc, "smooth noclamp")

		return MSD.ImgLib.Images[crc]
	else
		return MSD.ImgLib.PreCacheMaterial(url, crc, jpg)
	end
end

function MSD.ImgLib.PreCacheMaterial(url, crc, jpg)
	if not crc then
		crc = util.CRC(url) .. ".png"
	end

	if not file.Exists("msd_imgs", "DATA") then
		file.CreateDir("msd_imgs")
	end

	if not MSD.ImgLib.PreCacheStarted[crc] then
		MSD.ImgLib.PreCacheStarted[crc] = true

		http.Fetch(url, function(body, size, headers, code)
			if not jpg and (body:find("^.PNG")) then
				file.Write("msd_imgs/" .. crc, body)
				MSD.ImgLib.Images[crc] = Material("data/msd_imgs/" .. crc, "smooth noclamp")

				return MSD.ImgLib.Images[crc]
			elseif jpg then
				file.Write("msd_imgs/" .. crc, body)
				MSD.ImgLib.Images[crc] = Material("data/msd_imgs/" .. crc, "smooth noclamp")
			else
				print("Image is not a PNG, url - " .. url)
			end
		end, function()
			print("Failed to get image, url - " .. url)
		end)
	end

	return MSD.ImgLib.NoMaterial
end

function MSD.ImgLib.GetAvatar(crc)
	crc = tostring(crc)
	if not MSD.ImgLib.Avatars[crc] then
		MSD.ImgLib.Avatars[crc] = ""

		http.Fetch("https://macnco.one/steamid/avatar.php?input=" .. crc, function(body, size, headers, code)
			MSD.ImgLib.Avatars[crc] = body
		end, function()
			print("Failed to get link, url - " .. url)
		end)
	end

	return MSD.ImgLib.Avatars[crc] or ""
end