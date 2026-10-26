--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/client/hud.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local Color = Color
local ScreenScale = ScreenScale
local math = math
local Material = Material
local table = table
local LocalPlayer = LocalPlayer
local string = string
local MRS = MRS
local CurTime = CurTime
--local os = os
local surface = surface
local render = render
local ScrW = ScrW
local ScrH = ScrH
local draw = draw
local MSD = MSD
local team = team
local pairs = pairs
local isfunction = isfunction
local FrameTime = FrameTime
local IsValid = IsValid
local Angle = Angle
local LerpAngle = LerpAngle
local cam = cam
local hook = hook
local player = player
local ipairs = ipairs
local notification = notification
local Lerp = Lerp
local timer = timer
local CreateSound = CreateSound
local Sound = Sound
local DrawMotionBlur = DrawMotionBlur
local util = util
local Vector = Vector
local DrawColorModify = DrawColorModify
local DrawTexturize = DrawTexturize
local GetConVar = GetConVar
local DarkRP = DarkRP
local tonumber = tonumber
local Either = Either
local input = input
local net = net
local DrawBloom = DrawBloom
local ptra
local sx, sy = ScrW(), ScrH()

CreateClientConVar("noire_hints", "1", true, false)

DarkRP.Hud = {}

DarkRP.Hud.Patern = {
	["main_l"] = Color(255,150,0), -- This is main HUD color
	["main_d"] = Color(155, 55, 40), -- Main color but darker
	["main_s"] = Color(245, 45, 70), -- This color used only in health bar as the second slider
	["sub_l"] = Color(255, 132, 0), -- Sub color (for armor and etc)
	["hunger"] = Color(128, 192, 76), -- Hunger bar and wallet color
	["red"] = Color(255, 55, 40), -- Red notifications
	["yellow"] = Color(255, 200, 40), -- Yellow notifications
	["blue"] = Color(0, 160, 250), -- Blue notifications
	["blue2"] = Color(13, 121, 209), -- Blue notifications
	["armor"] = Color(200, 200, 200), -- Blue notifications
	["shadow"] = Color(0, 0, 0, 100), -- Shadows
	["gray"] = Color(200, 200, 200, 100), -- Shadows
	["bgr"] = Color(0, 0, 0, 180), -- Same as shadows but darker
	["mbgr"] = Color(0, 0, 0, 150), -- Same as shadows but darker
	["bgr_d"] = Color(0, 0, 0, 220)
}

DarkRP.Hud.IconSize = ScreenScale(10) -- Scales hud to your screen. You can set a fixed value if you want (not recomended), just replace the ScreenScale(12) with 32 and it will set icons to a fixed value.
DarkRP.Hud.FondSize = math.Clamp(math.Round(DarkRP.Hud.IconSize / 4 + 12), 12, 52) -- Fond size for MSD can varry from 12 to 52.

DarkRP.Hud.BarSize = 0
DarkRP.Hud.WepBarSize = 0
DarkRP.Hud.Bars = {}

DarkRP.Hud.Materials = {
	["vignette"] = Material("gmodla/hud/vignette.png", "smooth"),
	["overlay"] = Material("gmodla/hud/overlay", "smooth"),
	["overlay_bleeding"] = Material("gmodla/hud/overlay_bleeding.png", "smooth"),
	["overlay_freezing"] = Material("gmodla/hud/overlay_freezing.png", "smooth"),
	["overlay_poisoned"] = Material("gmodla/hud/overlay_poisoned.png", "smooth"),
	["overlay_light"] = Material("gmodla/hud/overlay_light.png", "smooth"),
	["hun"] = Material("gmodla/hud/hun.png", "smooth"),
	["glass"] = Material("gmodla/hud/glass.png", "smooth"),
	["job"] = Material("gmodla/hud/job.png", "smooth"),
	["logo"] = Material("gmodla/logo_c3.png", "smooth"),
	["logo_c"] = Material("gmodla/servers/miami.png", "smooth"),
	["mike_n"] = Material("mike_n.png", "smooth"),
}

DarkRP.Hud.VoiceMat = {
	[1] = Material("mike_w.png", "smooth"),
	[2] = Material("mike_n.png", "smooth"),
	[3] = Material("mike_y.png", "smooth"),
}

DarkRP.Hud.VoiceText = {
	[1] = "Вы шепчете",
	[2] = "Вы говорите",
	[3] = "Вы кричите",
}

local HUD = DarkRP.Hud

function HUD.AddAnimatedBar(tbl)
	table.insert(HUD.Bars, tbl)
end

function HUD.AddTextBar(tbl)
	tbl.type = "text"
	table.insert(HUD.Bars, tbl)
end

HUD.AddAnimatedBar({
	icon_bg = MSD:Icon("heart_outline"),
	icon = MSD:Icon("heart"),
	max_icon = MSD:Icon("heart_flash"),
	no_icon = MSD:Icon("heart_broken"),
	smooth = 0,
	value = function()
		return LocalPlayer():Health() / 100
	end
})

HUD.AddAnimatedBar({
	check = function()
		if LocalPlayer():getDarkRPVar("energy") then
			return true
		end
		return false
	end,
	icon_bg = MSD:Icon("apple_outline"),
	icon = MSD:Icon("apple"),
	max_icon = MSD:Icon("apple"),
	no_icon = MSD:Icon("apple_outline"),
	no_text = false,
	smooth = 0,
	value = function()
		return LocalPlayer():getDarkRPVar("energy") / 250
	end
})

HUD.AddAnimatedBar({
	check = function()
		if LocalPlayer():getDarkRPVar("thirst") then
			return true
		end
		return false
	end,
	icon_bg = MSD:Icon("cup_outline"),
	icon = MSD:Icon("cup"),
	max_icon = MSD:Icon("cup"),
	no_icon = MSD:Icon("cup_outline"),
	no_text = false,
	smooth = 0,
	value = function()
		return LocalPlayer():getDarkRPVar("thirst") / 350
	end
})

HUD.AddTextBar({
	check = function()
		if LocalPlayer():Team() == 2 then return false end
		if MRS and MRS.GetNWdata(LocalPlayer(), "Group") then
			return false
		end
		return DarkRP and true or false
	end,
	icon = MSD:Icon("badge_account"),
	text = function()
		return LocalPlayer():getDarkRPVar("job") or ""
	end
})

--MRS
HUD.AddTextBar({
	check = function()
		if MRS and MRS.GetNWdata(LocalPlayer(), "Group") then
			return true
		end
		return false
	end,
	icon = function()
		local group = MRS.GetNWdata(LocalPlayer(), "Group")
		local rank = MRS.GetNWdata(LocalPlayer(), "Rank")
		if not MRS.Ranks[group] or not MRS.Ranks[group].ranks[rank] then return MSD:Icon("cansel") end
		if rank > 0 then
			rank = MRS.Ranks[group].ranks[rank]
		end
		if rank ~= 0 and rank.icon[1] and rank.icon[1] ~= "" then
			return MRS.GetRankIcon(rank.icon)
		end
		return MSD:Icon("file_document")
	end,
	text = function()
		local group = MRS.GetNWdata(LocalPlayer(), "Group")
		local rank = MRS.GetNWdata(LocalPlayer(), "Rank")
		if not MRS.Ranks[group] or not MRS.Ranks[group].ranks[rank] then return "None" end
		return MRS.Ranks[group].ranks[rank].name
	end
})

-- money
HUD.AddTextBar({
	check = function()
		return DarkRP and true or false
	end,
	icon = MSD:Icon("cash"),
	text = function()
		local money = LocalPlayer():getDarkRPVar("money") or 0
		local sal = LocalPlayer():getDarkRPVar("payday") or 0
		return string.Comma(money) .. "$" .. (sal > 0 and " + " .. string.Comma(sal) .. "$" or "")
	end
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():getDarkRPVar("armorVest")
	end,
	icon = function()
		if LocalPlayer():Armor() > 0 then
			return MSD:Icon("armor")
		else
			return MSD:Icon("armor_broken")
		end
	end
})

HUD.AddTextBar({
	check = function()
		if LocalPlayer():getDarkRPVar("cold") and LocalPlayer():getDarkRPVar("cold") > 0 then
			return true
		end
		return false
	end,
	icon = MSD:Icon("snowflake")
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():getDarkRPVar("smoke")
	end,
	icon = MSD:Icon("smoking_pipe")
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():getDarkRPVar("stamina")
	end,
	icon = MSD:Icon("lightning")
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():getDarkRPVar("focus")
	end,
	icon = MSD:Icon("meditation")
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():getDarkRPVar("hunger")
	end,
	icon = MSD:Icon("silverware")
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():getDarkRPVar("meds3")
	end,
	icon = MSD:Icon("bottle_tonic_plus")
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():getDarkRPVar("Arrested")
	end,
	text = function()
		return MSD.NiceTime(math.max(LocalPlayer():getDarkRPVar("Arrested") - CurTime(), 0))
	end,
	icon = Material("cyberhud/cuffs.png", "smooth")
})

HUD.AddTextBar({
	check = function()
		return GetConVar("hud_time"):GetBool()
	end,
	icon = nil,
	text = function()
		return os.date("%H:%M", os.time())
	end
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():IsSpeaking()
	end,
	text = function()
		return DarkRP.Hud.VoiceText[LocalPlayer():getDarkRPVar("voicedist")]
	end,
	icon = function()
		return DarkRP.Hud.VoiceMat[LocalPlayer():getDarkRPVar("voicedist")]
	end
})

HUD.AddTextBar({
	check = function()
		return LocalPlayer():HasGodMode()
	end,
	icon = MSD.PinPoints[6]
})


function HUD.Blur(x, y, w, h)
	MSD.DrawBlur(x, y, w, h, 3)
end

function HUD.DrawBG(x, y, w, h)
	MSDX.Draw(0, x, y, w, h, DarkRP.Hud.Patern["mbgr"])
end

function HUD.DrawBar(x, y)
	local b = 15
	local iy = y + 5

	MSDX.Draw(0, x, y, 5, HUD.IconSize + 10, MSD.Config.MainColor["p"])
	HUD.DrawBG(x + 5, y, HUD.BarSize, HUD.IconSize + 10)

	local logo = HUD.IconSize - 10

	MSD.DrawTexturedRect(x + b, iy + 5, logo * 5.7, logo, DarkRP.Hud.Materials.logo, color_white)
	b = b + logo * 5.7 + 5

	for id, e in pairs(HUD.Bars) do
		if e.check and not e.check() then continue end

		if e.type == "text" then
			if e.icon then
				MSD.DrawTexturedRect(x + b, iy, HUD.IconSize, HUD.IconSize, isfunction(e.icon) and e.icon() or e.icon, color_white)
				b = b + HUD.IconSize + 5
			else
				b = b + 5
			end

			if e.text then
				b = b + 5 + draw.SimpleText( e.text(), "MSDFont." .. HUD.FondSize, x + b, y + 5 + HUD.IconSize / 2, MSD.Text["l"], 0, 1)
			end
			continue
		end

		local value = e.value()
		if e.smooth then
			e.smooth = math.Approach(e.smooth, value, FrameTime() * 2)
			value = e.smooth
		end

		if value <= 1 and value > 0 then
			MSD.DrawTexturedRect(x + b, iy, HUD.IconSize, HUD.IconSize, e.icon_bg, MSD.Text["n"])

			local ip = math.Clamp(HUD.IconSize - HUD.IconSize * value, 0, HUD.IconSize)

			render.SetScissorRect(x + b, iy + ip, x + b + HUD.IconSize, iy + HUD.IconSize, true )
				MSD.DrawTexturedRect(x + b, iy, HUD.IconSize, HUD.IconSize, e.icon, color_white)
			render.SetScissorRect(0, 0, 0, 0, false )
		elseif value > 1 then
			MSD.DrawTexturedRect(x + b, iy, HUD.IconSize, HUD.IconSize, e.max_icon, color_white)
		elseif e.no_icon and value <= 0 then
			MSD.DrawTexturedRect(x + b, iy, HUD.IconSize, HUD.IconSize, e.no_icon, MSD.Text["a"])
		end

		if ( e.no_icon or value > 0 ) then
			b = b + HUD.IconSize + 5
			if not e.no_text then
				b = b + 5 + math.max( draw.SimpleText( math.max(math.Round(value * 100), 0) .. "%", "MSDFont." .. HUD.FondSize, x + b, y + 5 + HUD.IconSize / 2, MSD.Text["l"], 0, 1), 35)
			end
		end
	end

	HUD.BarSize = b
end

local wpicons = {
	["fire_hose"] = MSD.PinPoints[18],
	["fire_extinguisher"] = MSD.PinPoints[18],
	["lockpick"] = MSD:Icon("key_link"),
	["weapon_taser"] = MSD:Icon("lightning"),
	["mlw_tonfa"] = MSD:Icon("lightning"),
	["med_kit"] = MSD:Icon("heart_flash"),
	["med_pd"] = MSD:Icon("heart_flash"),
}

local firemods = {
	["Full Auto"] = MSD:Icon("ammo"),
	["3rnd Burst"] = MSD:Icon("ammo"),
	["Pump-Action"] = MSD:Icon("bulet_3"),
	["Break-Action"] = MSD:Icon("ammo_3_pare"),
}

local class_firemods = {
	["mwb_spapa12"] = MSD:Icon("ammo_3"),
	["mwb_marlin"] = MSD:Icon("bulet_2"),
}

local pisolcal = table.Copy(DarkRP.SingleWep.PistolWeps)
pisolcal["mwb_thompson"] = true
pisolcal["mwb_mac10"] = true
pisolcal["mwb_mp5"] = true
pisolcal["mwb_uzi"] = true

local function getWeaponIcon(wep)
	if not wep.Firemodes then return MSD:Icon("ammo") end
	local firemod = wep.Firemodes[wep:GetFiremode()]

	if not firemod then return MSD.Icons48.bulet end

	if pisolcal[wep:GetClass()] then
		if firemod.Name == "Full Auto" or firemod.Name == "3rnd Burst" then
			return MSD.Icons48.ammo_2
		end
		return MSD.Icons48.bulet_2
	end

	if class_firemods[wep:GetClass()] then
		return class_firemods[wep:GetClass()]
	end

	if firemods[firemod.Name] then
		return firemods[firemod.Name]
	end

	return MSD.Icons48.bulet
end

function HUD.DrawWeaponBar(x, y)
	local wep = LocalPlayer():GetActiveWeapon()
	HUD.WeaponBar = - HUD.IconSize
	if not IsValid(wep) then return end
	if LocalPlayer():InVehicle() then return end

	local clip = wep:Clip1() or 0
	if (wep:GetClass() == "weapon_physcannon") then return false end
	if not clip or clip < 0 then return false end

	local rb = 5
	local b = rb + 10
	local iy = y + 5

	HUD.DrawBG(x - HUD.WepBarSize, y, HUD.WepBarSize, HUD.IconSize + 10)
	MSDX.Draw(0, x - rb , y, rb, HUD.IconSize + 10, MSD.Config.TeamColor and team.GetColor(LocalPlayer():Team()) or MSD.Config.MainColor["p"])

	b = b + math.max( draw.SimpleText( clip, "MSDFont." .. HUD.FondSize, x - b, y + 5 + HUD.IconSize / 2, color_white, TEXT_ALIGN_RIGHT, 1 ), 35)
	b = b + HUD.IconSize
	MSD.DrawTexturedRect(x - b, iy, HUD.IconSize, HUD.IconSize, wpicons[wep:GetClass()] or getWeaponIcon(wep), MSD.Text["d"])

	HUD.WepBarSize = b + 10
	HUD.WeaponBar = 0
end

function HUD.DrawBackGroud(x, y, w, h, alpha)
	alpha = alpha or 1

	MSDX.Draw(0, x, y, w, h, MSD.ColorAlpha(color_black, 200 * alpha))
	MSDX.Draw(0, x - 5, y, 5, h, MSD.ColorAlpha(MSD.Config.MainColor["p"], 255 * alpha))
end

function HUD.DrawPlayerInfo(ply, name, text, x, y, Config, icon)
	local almp = ply.msdna or 1
	local w1, w2 = 0, 0
	local is, fs, fss = Config.IconSize, math.Clamp(Config.FontSize, 12, 42), Config.ShowGroup and math.Clamp(Config.FontSize - 8, 12, 42) or 0
	local ipos = Config.IconRight
	local mh = math.max(is, fs + fss)

	HUD.DrawBackGroud(x, y, ply.msdW, mh + 10, almp)

	if ply:IsPlayer() and ply:getDarkRPVar("Arrested") and MRS.GetNWdata(LocalPlayer(), "Group") and MRS.GetNWdata(LocalPlayer(), "Group") == "NYPD" then
		text = MSD.NiceTime(math.max(ply:getDarkRPVar("Arrested") - CurTime(), 0))
	end

	if Config.ShowGroup then
		w2 = draw.SimpleTextOutlined(text, "MSDFont." .. fss, ipos and 5 + x or x + 10 + is, y + fs / 2 + fss + 5, MSD.ColorAlpha(color_white, 255 * almp), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MSD.ColorAlpha(color_black, 255 * almp))
	end

	local grp = w2 > 0 and fs / 2 + 5 or (mh + 10) / 2
	w1 = draw.SimpleTextOutlined(name, "MSDFont." .. fs, ipos and 5 + x or x + 10 + is, y + grp, MSD.ColorAlpha(color_white, 255 * almp), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 1, MSD.ColorAlpha(color_black, 255 * almp))

	if ply:IsPlayer() and ply:IsSpeaking() then
		MSD.DrawTexturedRect(ipos and x + ply.msdW - is - 10 or x + 5, y + 5 + (mh / 2 - (is - 5) / 2), is - 5, is - 5, DarkRP.Hud.VoiceMat[ply:getDarkRPVar("voicedist")], MSD.ColorAlpha(color_white, 255 * almp))
	elseif ply:IsPlayer() and ply:IsTyping() then
		MSD.DrawTexturedRect(ipos and x + ply.msdW - is - 10 or x + 5, y + 5 + (mh / 2 - (is - 5) / 2), is - 5, is - 5, MSD:Icon("chat_processing"), MSD.ColorAlpha(color_white, 255 * almp))
	else
		MSD.DrawTexturedRect(ipos and x + ply.msdW - is - 5 or x + 5, y + 5 + (mh / 2 - is / 2), is, is, icon or MSD.Icons48.account, MSD.ColorAlpha(color_white, 255 * almp))
	end

	ply.msdW = math.max(w1, w2) + is + ( Config.HideName and 10 or 15 )
end

local rot = Angle(0, 0, 0)
local distx = 80
local disty = 200

local noremove = {
	["glasses01"] = true,
	["glasses02"] = true,
	["glasses03"] = true,
	["glasses04"] = true,
	["glasses05"] = true,
	["glasses06"] = true
}

function HUD.HudPlayer(ply, Draw3D)
	if ply == LocalPlayer() or not ply:Alive() or ply:InVehicle() or ply:getDarkRPVar("unconscious") or LocalPlayer():InVehicle() or ply:getDarkRPVar("hidename") then return end
	if IsValid(pk_pills.getMappedEnt(ply)) or ply:GetMoveType() == MOVETYPE_NOCLIP then return end
	if not ply:IsBot() and sAdmin.cloakedPeople[ply:SteamID64()] then return end

	if ply:GetPos():DistToSqr(LocalPlayer():GetPos()) > MSD.Config.HUD.Dist ^ 2 then return end

	if not ply.msdW then ply.msdW = 0 end
	if not ply.msdna then ply.msdna = 0 end

	local pos = ply:GetShootPos()

	local head = ply:LookupBone("ValveBiped.Bip01_Head1")

	if head then
		pos = ply:GetBonePosition(head)
		pos.z = pos.z + 5
	else
		return
	end

	local _, rank = MRS.GetActiveRankData(ply)

	if ply:getDarkRPVar("showrank") then rank = nil end

	if ((rank and not rank.hidden) or (ply:IsSpeaking() or ply:IsTyping()) or ptra == ply) and not ply:Crouching() and not (ply:getDarkRPVar("face") and not noremove[ply:getDarkRPVar("face")]) then
		ply.msdna = Lerp(0.01, ply.msdna, 1)
	else
		ply.msdna = Lerp(0.05, ply.msdna, 0)
	end

	if ply.msdna < 0.01 then return end

	local pla = LocalPlayer():EyeAngles()

	rot = LerpAngle(FrameTime() * 7, rot, Angle(0, pla.y - 180, 0))

	local ang = Angle(0, rot.y, 0)
	ang:RotateAroundAxis(ang:Right(), -90)
	ang:RotateAroundAxis(ang:Up(), 90)

	cam.Start3D2D(pos, ang, 0.08)
		HUD.DrawPlayerInfo(ply, (rank and not rank.hidden) and string.Explode(" ", ply:FullName() or "")[2] or ply:Name(), (rank and not rank.hidden) and rank.name or "", distx, 200 - disty, MSD.Config.HUD, (rank and not rank.hidden) and MRS.GetRankIcon(rank.icon))
	cam.End3D2D()
end

hook.Add("PostDrawTranslucentRenderables", "DarkRP.PlayerHud", function(bDrawingSkybox, bDrawingDepth)
	if bDrawingDepth or (GetConVar("cl_drawhud"):GetInt() == 0 and LocalPlayer():IsSuperAdmin()) then return end
	for k,ply in pairs(player.GetAll()) do
		HUD.HudPlayer(ply, true)
	end
end)

local notifications = {}
local inventory = {}

local note_style = {
	[NOTIFY_ERROR] = {icon = MSD.Icons48.cross, color = Color(204, 15, 40)},
	[NOTIFY_UNDO] = {icon = MSD.Icons48.back, color = Color(54, 139, 230)},
	[NOTIFY_HINT] = {icon = Material("mqs/map_markers/r3.png", "smooth"), color = Color(0, 123, 255)},
	[NOTIFY_GENERIC] = {icon = MSD.Icons48.cog, color = Color(226, 147, 0)},
	[NOTIFY_CLEANUP] = {icon = MSD.Icons48.box_open, color = Color(128, 189, 255)},
	[5] = {icon = MSD.Icons48.cellphone_basic, color = Color(90, 148, 211)},
	[6] = {icon = MSD.Icons48.cellphone_basic, color = Color(226, 147, 0)},
	["loading"] = {icon = Material("mqs/map_markers/r1.png", "smooth"), color = Color(226, 147, 0)},
	["weapon"] = {icon = MSD.Icons48.hand_extended, color = Color(226, 147, 0)},
	["ammo"] = {icon = MSD.Icons48.ammo, color = Color(0, 123, 255)},
	["item"] = {icon = MSD.Icons48.hand_extended, color = Color(161, 216, 88)}
}

function notification.AddLegacy(text, type, time, id, cl)
	return table.insert(notifications, {
		x = 10,
		y = sy - (20 + HUD.IconSize) * 2,
		w = 100,
		h = 10 + HUD.IconSize,
		s = sub,
		progress = 0,
		text = text,
		id = id or #notifications + 1,
		type = type,
		time = CurTime() + time,
		cl = cl
	})
end

function notification.AddInventory(text, type, time, amount)
	if type == "ammo" then
		for k, v in pairs(inventory) do
			if v.type ~= type then continue end
			if v.text ~= text then continue end
			v.amount = v.amount + amount
			v.time = CurTime() + time
			return
		end
	end

	table.insert(inventory, {
		x = sx,
		y = sy - (20 + HUD.IconSize) * 2,
		w = 100,
		h = 10 + HUD.IconSize,
		s = sub,
		progress = 0,
		text = text,
		amount = amount,
		type = type,
		time = CurTime() + time,
	})
end

function notification.Kill(id)
	for k, v in ipairs(notifications) do
		if v.id == id then
			v.time = 0
		end
	end
end

function notification.AddProgress(id, text, frac, cl)
	for k, v in ipairs(notifications) do
		if v.id == id then
			v.text = text
			v.fraction = frac
			return
		end
	end
	lid = notification.AddLegacy(text, "loading", 9999, id, cl)
	notifications[lid].fraction = frac or 0
end

function HUD.DrawNotifications()
	for k, v in ipairs(notifications) do
		local is = math.max(0, 5)
		local n_locor = v.cl or (note_style[v.type] and note_style[v.type].color or color_white)
		HUD.DrawBG(v.x - (v.w - (v.progress * v.w)), v.y - (k - 1) * (v.h + 5), v.w, v.h, v.progress)
		v.w = draw.SimpleText( v.text, "MSDFont." .. HUD.FondSize, v.x - (v.w - (v.progress * v.w)) + 20 + HUD.IconSize, (v.y - (k - 1) * (v.h + 5)) + HUD.IconSize / 2 + 5, color_white, TEXT_ALIGN_LEFT, 1 ) + 25 + HUD.IconSize

		if note_style[v.type] then
			MSD.DrawTexturedRect(v.x - (v.w - (v.progress * v.w)) + 15, (v.y - (k - 1) * (v.h + 5)) + 5, HUD.IconSize, HUD.IconSize, note_style[v.type].icon, v.cl or note_style[v.type].color)
		end

		if v.fraction and v.fraction > 0 then
			MSDX.Draw(0, v.x - (v.w - (v.progress * v.w)), (v.y - (k - 1) * (v.h + 5)) + v.h - is, v.w * v.fraction, is, MSD.ColorAlpha(n_locor, 255 * v.progress))
		else
			MSDX.Draw(0, v.x - (v.w - (v.progress * v.w)), v.y - (k - 1) * (v.h + 5), is, v.h, MSD.ColorAlpha(n_locor, 255 * v.progress))
		end

		if v.time > CurTime() then
			v.progress = math.Approach(v.progress, 1, FrameTime() * 5)
		else
			v.progress = math.Approach(v.progress, 0, FrameTime() * 4)
		end

		if v.progress <= 0 and v.time < CurTime() then
			table.remove(notifications, k)
		end
	end

	for k, v in ipairs(inventory) do
		local is = 5
		local n_locor = note_style[v.type] and note_style[v.type].color or color_white
		HUD.DrawBG(v.x - (v.progress * v.w) - 10, v.y - (k - 1) * (v.h + 5), v.w, v.h, v.progress)
		v.w = draw.SimpleText( v.text .. " " .. (v.amount or ""), "MSDFont." .. HUD.FondSize, v.x - (v.progress * v.w) + 10 + HUD.IconSize - is, (v.y - (k - 1) * (v.h + 5)) + HUD.IconSize / 2 + 5, color_white, TEXT_ALIGN_LEFT, 1 ) + 25 + HUD.IconSize

		if note_style[v.type] then
			MSD.DrawTexturedRect(v.x - (v.progress * v.w) + 5 - is, (v.y - (k - 1) * (v.h + 5)) + 5, HUD.IconSize, HUD.IconSize, note_style[v.type].icon, note_style[v.type].color)
		end

		MSDX.Draw(0, v.x + (v.w - (v.progress * v.w)) - is - 10, v.y - (k - 1) * (v.h + 5), is, v.h, MSD.ColorAlpha(n_locor, 255 * v.progress))

		if v.time > CurTime() then
			v.progress = math.Approach(v.progress, 1, FrameTime() * 5)
		else
			v.progress = math.Approach(v.progress, 0, FrameTime() * 4)
		end

		if v.progress <= 0 and v.time < CurTime() then
			table.remove(inventory, k)
		end
	end
end

local marker = Material("msd/icons/run.png", "smooth")
local icon_color = Color(241, 88, 0)
local dist_m, alpha = 0, 0

function DarkRP.Hud.Marker(pos, cm)
	local pp = LocalPlayer():GetPos()
	if pp.z < -4500 then return end
	if pos:DistToSqr(pp) < 50000 then return end

	local screenpos = pos:ToScreen()
	local x, y = screenpos.x, screenpos.y - 50

	if x < sx / 4 or x > sx - sx / 4 then
		alpha = Lerp(FrameTime() * 7, alpha, 0)

		if x < 30 then
			x = 30
		end
	else
		alpha = Lerp(FrameTime() * 7, alpha, 1)
		dist_m = pp:Distance(pos) * 0.75 / 25.4
	end

	if y < 50 then
		y = 50
	end

	if x > sx - 48 then
		x = sx - 48
	end

	if y > sy - 48 then
		y = sy - 48
	end

	MSD.DrawTexturedRect(x - 24, y - 22, 48, 48, cm or marker, MSD.ColorAlpha(color_black, 100 + alpha * 125))
	MSD.DrawTexturedRect(x - 24, y - 24, 48, 48, cm or marker, MSD.ColorAlpha(icon_color, 100 + alpha * 125))
	draw.SimpleTextOutlined(math.floor(dist_m) .. " m", "MSDFont.25", x, y + 35, MSD.ColorAlpha(color_white, alpha * 200), TEXT_ALIGN_CENTER, 0, 1, MSD.ColorAlpha(color_black, alpha * 200))
end

local hint = nil

local hints = {
	{check = function() if LocalPlayer():getDarkRPVar("sit_x", true) then return true end return false end, hint = "Чтобы встать нажмите [Пробел] + [E]"},
	{check = function() if LocalPlayer().ischanging and LocalPlayer().ischanging:DistToSqr(LocalPlayer():GetPos()) > 50000 then return true end return false end, hint = "Для смены персонажа следуйте в укромное место"},
	{check = function() if LocalPlayer().ischanging and LocalPlayer().ischanging:DistToSqr(LocalPlayer():GetPos()) < 50000 then return true end return false end, hint = "Подождите несколько секунд"},
	{check = function() return LocalPlayer():getDarkRPVar("Player.Drag") end, hint = "Вы ведете за собой игрока. Нажмите [E] чтобы отпустить его."},
	{class = "player", check = function(ent) return ent:getDarkRPVar("HandCuffed") end, hint = "Игрок в наручниках, Нажмите [E] чтобы вести его за собой"},
	{check = function() return LocalPlayer():getDarkRPVar("overs") end, hint = "Вы перегружены! Освободите инвентарь!", cl = Color(168,0,0)},
}

timer.Create("HudHints", 1, 0, function()
	if not IsValid(LocalPlayer()) then return end

	local ent = LocalPlayer():GetEyeTrace().Entity

	for k, v in ipairs(hints) do
		if not v.class and v.check() then
			notification.AddProgress("hint", v.hint, nil, v.cl)
			hint = v.hint
			return
		end

		if IsValid(ent) and ent:IsPlayer() then
			ptra = ent
		else
			ptra = nil
		end

		if IsValid(ent) and v.class == ent:GetClass() and ent:GetPos():DistToSqr(LocalPlayer():GetPos()) < 30000 and v.check(ent) then
			notification.AddProgress("hint", v.hint, nil, v.cl)
			hint = v.hint
			return
		end
	end

	if hint then
		hint = nil
		notification.Kill("hint")
	end
end)

DarkRP.Hud.BlodStainSize = math.Clamp(ScreenScale(170), 100, 512)
DarkRP.Hud.DoKill = function() end

local function AddSuppression(amount)
	if not LocalPlayer().Supression then
		LocalPlayer().Supression = 0
	end

	LocalPlayer().Supression = math.min(LocalPlayer().Supression + amount, 10)
end

local tab = {
	["$pp_colour_addr"] = 0,
	["$pp_colour_addg"] = 0,
	["$pp_colour_addb"] = 0,
	["$pp_colour_inv"] = 0,
	["$pp_colour_brightness"] = 0,
	["$pp_colour_contrast"] = 1,
	["$pp_colour_colour"] = 1,
	["$pp_colour_mulr"] = 0,
	["$pp_colour_mulg"] = 0,
	["$pp_colour_mulb"] = 0
}

local hp = 100
local mhp = 100
local alc = 0
local karma = 100
local blood = 100
local red = 0
local relax, anti, shock = 0, 0, 0
local lc, addict
local bluref = 0
local last_add = 0

local function addBlurFX(amount)
	if last_add > CurTime() then return end
	last_add = CurTime() + 1
	bluref = math.Clamp(bluref + amount, 0, 100)
end

DarkRP.Hud.Overlays = {
	["scba"] = Material("gmodla/hud/gasmask_screen.png", "smooth"),
	["gasmask"] = Material("gmodla/hud/gasmask_screen.png", "smooth"),
	["weldingmask"] = Material("gmodla/hud/weldingmask_screen.png", "smooth"),
	["glasses01"] = Material("gmodla/hud/UI.Background.Transparent.Radial.png", "smooth"),
	["glasses03"] = Material("gmodla/hud/UI.Background.Transparent.Radial.png", "smooth"),
	["glasses04"] = Material("gmodla/hud/UI.Background.Transparent.Radial.png", "smooth"),
	["glasses05"] = Material("gmodla/hud/UI.Background.Transparent.Radial.png", "smooth"),
	["glasses06"] = Material("gmodla/hud/UI.Background.Transparent.Radial.png", "smooth"),
}

DarkRP.Hud.OverlaysColor = {
	["glasses01"] = Color(13,14,36,255),
	["glasses03"] = Color(13,14,36,255),
	["glasses04"] = Color(27,27,27),
	["glasses05"] = Color(58,59,68, 100),
	["glasses06"] = Color(27,27,27, 100),
}

function DarkRP.Hud.VitalSigns()
	lc = LocalPlayer()
	hp = lc:Health()
	alc = lc:getDarkRPVar("alcohol") or 0
	karma = lc:getDarkRPVar("karma") or 0
	blood = lc:getDarkRPVar("blood") or 0
	oxygen = lc:getDarkRPVar("deoxygen") or 0
	addict = lc:getDarkRPVar("addict")
	local supres = lc.Supression or 0

	local chp = math.Clamp(hp / mhp, 0, 1) * 100

	if not DarkRP.Hud.HeartBeat then
		DarkRP.Hud.HeartBeat = CreateSound(lc, Sound("player/heartbeat1.wav"))
	end

	if not DarkRP.Hud.BreathSnd then
		DarkRP.Hud.BreathSnd = CreateSound(lc, Sound("player/breathe1.wav"))
	end

	if lc:getDarkRPVar("shock") then
		shock = 1
	end

	if lc:getDarkRPVar("relax") then
		relax = math.Approach(relax, 1, FrameTime() * 0.05)
		if anti > 0 then
			anti = math.Approach(anti, 0, FrameTime() * 0.05)
		end
	elseif relax > 0 then
		relax = math.Approach(relax, 0, FrameTime() * 0.05)
	end

	if chp <= 75 then
		red = 155 - chp / 75 * 155
	else
		red = 0
	end

	if lc:getDarkRPVar("face") and DarkRP.Hud.Overlays[lc:getDarkRPVar("face")] then
		surface.SetMaterial(DarkRP.Hud.Overlays[lc:getDarkRPVar("face")])
		surface.SetDrawColor(DarkRP.Hud.OverlaysColor[lc:getDarkRPVar("face")] or color_white)
		surface.DrawTexturedRect(0, 0, sx, sy)
	end

	if lc:getDarkRPVar("scba") and lc:getDarkRPVar("scba") == 1 then
		surface.SetMaterial(DarkRP.Hud.Overlays["scba"])
		surface.SetDrawColor(DarkRP.Hud.OverlaysColor["scba"] or color_white)
		surface.DrawTexturedRect(0, 0, sx, sy)
	end

	if lc:getDarkRPVar("fracture") and lc:GetVelocity():Length2DSqr() > 300 then
		util.ScreenShake( Vector(1, 0, 0), 1, 1, 1, 1 )
		red = red + math.abs(math.sin(CurTime()) * 100)
	end

	if chp <= 5 then
		util.ScreenShake( Vector(0, 0, 0), 1, 1, 1, 1 )
		addBlurFX(2)
	end

	if lc:getDarkRPVar("bleeding") then
		red = red + math.abs(math.sin(CurTime()) * 50)
		addBlurFX(1)
	end

	if bluref > 0 then
		DrawMotionBlur(0.2, 0.2, bluref / 100)
		addBlurFX(-10)
	end

	if (chp < 30 and chp > 0) or supres > 5 then
		if not DarkRP.Hud.HeartBeat:IsPlaying() then
			DarkRP.Hud.HeartBeat:Play()
			DarkRP.Hud.HeartBeat:ChangePitch(120, 0)
		end
		DarkRP.Hud.HeartBeat:ChangeVolume(0.7 - (chp / 100), 0)
	else
		DarkRP.Hud.HeartBeat:Stop()
	end

	if oxygen > 0 then
		surface.SetMaterial(DarkRP.Hud.Materials["vignette"])
		surface.SetDrawColor(0, 0, 0, (oxygen / 100) * 255)
		surface.DrawTexturedRect(0, 0, sx, sy)

		if oxygen > 30 then
			if not DarkRP.Hud.BreathSnd:IsPlaying() then
				DarkRP.Hud.BreathSnd:Play()
				DarkRP.Hud.BreathSnd:ChangePitch(100, 0)
			end
			DarkRP.Hud.BreathSnd:ChangeVolume(oxygen / 100, 0)
		else
			DarkRP.Hud.BreathSnd:Stop()
		end
	else
		DarkRP.Hud.BreathSnd:Stop()
	end

	if supres > 0 then
		if supres > 3 and not DarkRP.Hud.Materials["overlay_light"]:IsError() then
			surface.SetMaterial(DarkRP.Hud.Materials["overlay_light"])
			surface.SetDrawColor(0, 0, 0, (lc.Supression - 3) / 3 * 255)
			surface.DrawTexturedRect(0, 0, sx, sy)
		end

		lc.Supression = math.Approach(lc.Supression, 0, 0.05)
	end

	if blood < 95 then
		tab["$pp_colour_colour"] = chp / 95
	end

	if addict and addict > 0 then
		if relax == 0 then
			anti = math.Approach(anti, 1, FrameTime() * 0.05)
		end
		local odd = (addict / 200)
		tab["$pp_colour_colour"] = 1 - (odd * anti)
		surface.SetMaterial(DarkRP.Hud.Materials["vignette"])
		surface.SetDrawColor(0, 0, 0, 255 * odd * anti)
		surface.DrawTexturedRect(0, 0, sx, sy)
	end

	if relax > 0 then
		karma = math.max(karma, 30 * relax)

		if lc:getDarkRPVar("morph") or lc:getDarkRPVar("coca") or lc:getDarkRPVar("heroin") then
			DrawSharpen(relax, relax)
		end

		if lc:getDarkRPVar("heroin") then
		 	DrawMaterialOverlay( "effects/strider_pinch_dudv", math.sin(CurTime()) * relax / 100 )
		end

		if lc:getDarkRPVar("meth") then
			DrawBloom( math.max(1 - relax, 0.5), 3, 12 * relax, 22, 5, relax, 0.05, 0.5, 1 )
		end

		if lc:getDarkRPVar("meth") then
			DrawBloom( math.max(1 - relax, 0.5), 3, 12 * relax, 22, 5, relax, 0.05, 0.5, 1 )
		end

		if lc:getDarkRPVar("heroin") then
			tab["$pp_colour_colour"] = math.Clamp(math.sin(CurTime()) * relax * 2, tab["$pp_colour_colour"] - relax * 2, 2)
		else
			tab["$pp_colour_colour"] = math.max(tab["$pp_colour_colour"], (1.1 + math.abs(math.sin(CurTime()))) * relax)
		end
	end

	if tab["$pp_colour_colour"] ~= 1 then
		DrawColorModify(tab)
	end

	if karma < 50 then
		DrawBloom( 0.3 + karma / 120, 2, 0, 5, 1, 0, 1, 1, 1 )
	end

	if alc > 0 then
		DrawMotionBlur(0.2, alc / 150, 0.1)
		DrawToyTown((alc / 150) * 7, ScrH() / 2)
	end

	if shock > 0 then
		local shk = math.abs(math.sin(CurTime()))
		surface.SetMaterial(DarkRP.Hud.Materials["overlay_light"])
		surface.SetDrawColor(161, 43, 22, shk * 255 * shock)
		surface.DrawTexturedRect(0, 0, sx, sy)
		DrawMotionBlur(0.2, ( 1.1 - shk ) * shock, 0.1)
		shock = math.Approach(shock, 0, FrameTime() * 0.2)
	end

	if red > 0 and not DarkRP.Hud.Materials["overlay_bleeding"]:IsError() then
		surface.SetDrawColor(255, 255, 255, red )
		surface.SetMaterial(DarkRP.Hud.Materials["overlay_bleeding"])
		surface.DrawTexturedRect(0, 0, sx, sy)
	end

	if lc:getDarkRPVar("cold") and lc:getDarkRPVar("cold") > 1 and not DarkRP.Hud.Materials["overlay_freezing"]:IsError() then
		surface.SetDrawColor(255, 255, 255, lc:getDarkRPVar("cold") * 2 )
		surface.SetMaterial(DarkRP.Hud.Materials["overlay_freezing"])
		surface.DrawTexturedRect(0, 0, sx, sy)
	end

	if lc:Toxity() > 5 then
		surface.SetDrawColor(255, 255, 255, 50 + 50 * math.abs(math.sin(CurTime())) )
		surface.SetMaterial(DarkRP.Hud.Materials["overlay_poisoned"])
		surface.DrawTexturedRect(0, 0, sx, sy)
	end

	local veh = lc:GetSimfphys()

	if IsValid(veh) and veh.speed then
		local spd = math.Clamp(veh.speed - 350000, 0, 550000) / 550000
		surface.SetMaterial(DarkRP.Hud.Materials["vignette"])
		surface.SetDrawColor(0, 0, 0, 255 * spd )
		surface.DrawTexturedRect(0, 0, sx, sy)
		DrawToyTown(2, (ScrH() / 2) * spd)
	end

	if tab["$pp_colour_colour"] ~= 1 then
		tab["$pp_colour_colour"] = 1
	end
end

function DarkRP.Hud.Door()
end

local center_gradient = Material("gui/center_gradient.vtf", "smooth")
local color_red = Color(231, 0, 0)
local color_green = Color(121, 206, 10)

local radio_h = 0
local radio_channel = {
	[1] = "PD канал #1",
	[2] = "PD канал #2",
	[3] = "PD канал #3",
	[4] = "FD канал #1",
	[5] = "FD канал #2",
	[6] = "FD канал #3",
	[10] = "COM канал",
}

local str, fadestr, hintcv = nil, 0, GetConVar("noire_hints"):GetInt()

function DarkRP.Hud.Information()
	hintcv = GetConVar("noire_hints"):GetInt()

	if CURRENT_TERRITORY then
		if fadestr < 1 then
			str = CURRENT_TERRITORY
			fadestr = math.Approach(fadestr, 1, FrameTime() * 2)
		end
	else
		fadestr = math.Approach(fadestr, 0, FrameTime() * 2)
	end

	local q = MQS.HasQuest(LocalPlayer()) and MQS.HudWide and MQS.HudWide + 50 or 0

	if fadestr > 0 then
		MSD.ShadowText(str.printName, "Noire.30", 15 + q, 35, MSD.ColorAlpha(color_white, fadestr * 255), TEXT_ALIGN_LEFT, 2, MSD.ColorAlpha(color_black, fadestr * 255))
		if str.printStr then
			MSD.ShadowText(str.printStr, "MSDFont.22", 15 + q, 15, MSD.ColorAlpha(color_white, fadestr * 255), TEXT_ALIGN_LEFT, 1,  MSD.ColorAlpha(color_black, fadestr * 255))
		end
	end

	if hintcv > 0 then
		draw.SimpleTextOutlined("F1 - Меню помощи   F2 - Меню действий   F3 - Курсор   F4 - Основное игровое меню", "MSDFont.16", sx - 15, 5, DarkRP.Hud.Patern["armor"], TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 1, DarkRP.Hud.Patern["shadow"])

		if LocalPlayer():IsTyping() then
			local x, y = chat.GetChatBoxPos()
			draw.SimpleTextOutlined("TAB - переключение между ООС и IC чатом", "MSDFont.16", x, y - 5, DarkRP.Hud.Patern["armor"], TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, DarkRP.Hud.Patern["shadow"])
			draw.SimpleTextOutlined("CTRL+TAB - Смена режимов чата", "MSDFont.16", x, y - 22, DarkRP.Hud.Patern["armor"], TEXT_ALIGN_LEFT, TEXT_ALIGN_BOTTOM, 1, DarkRP.Hud.Patern["shadow"])
		end

	end

	if GAMEMODE.RadioTeams[LocalPlayer():Team()] and LocalPlayer():getDarkRPVar("rc_on") == true then

		if not DarkRP.RadioSND then
			DarkRP.RadioSND = CreateSound(LocalPlayer(), Sound("radio/ground_cut.wav"))
		end

		MSDX.Draw(0, sx - 150, sy / 2, 150, radio_h, DarkRP.Hud.Patern["mbgr"])
		MSD.DrawTexturedRect(sx - 39, sy / 2 + 2, 32, 32, MSD.Icons48.dot, LocalPlayer():getDarkRPVar("rc_speek") and color_green or color_red)
		local sp = draw.SimpleText("Передача", "MSDFont.22", sx - 39, sy / 2 + 5, color_white, TEXT_ALIGN_RIGHT, 0)
		MSD.DrawKey(sx - 64 - sp, sy / 2 + 5, input.GetKeyName(GetConVar("pradio_key"):GetInt() or KEY_P), 150)
		draw.SimpleText(radio_channel[LocalPlayer():getDarkRPVar("rc")] or "Нет питания", "MSDFont.20", sx - 15, sy / 2 + 36, color_white, TEXT_ALIGN_RIGHT, 0)

		local i = 0
		for v,_ in pairs(DarkRP.RadioCH) do
			if not IsValid(v) then DarkRP.RadioCH[v] = nil continue end
			local name = DarkRP.Police.Units[v:UserID()]
			MSD.DrawTexturedRect(sx - 39, sy / 2 + 60 + i * 32, 32, 32, MSD.Icons48.dot, color_green)
			draw.SimpleText(name and name or v:FullName(), "MSDFont.20", sx - 39, sy / 2 + 65 + i * 32, color_white, TEXT_ALIGN_RIGHT, 0)
			i = i + 1
		end

		if i > 0 and not DarkRP.RadioSND:IsPlaying() then
			DarkRP.RadioSND:PlayEx(0, 100)
		elseif i < 1 and DarkRP.RadioSND:IsPlaying() then
			DarkRP.RadioSND:Stop()
		end

		if DarkRP.RadioSND:IsPlaying() then
			DarkRP.RadioSND:ChangeVolume(Lerp(FrameTime() * 5, DarkRP.RadioSND:GetVolume(), 1), 0)
		end

		radio_h = 65 + i * 32
	elseif DarkRP.RadioSND then
		DarkRP.RadioSND:Stop()
		DarkRP.RadioSND = nil
	end

	if LocalPlayer().ischanging then
		surface.SetDrawColor(0, 0, 0, 170)
		surface.SetMaterial(center_gradient)
		surface.DrawTexturedRectRotated(sx / 2, sy / 8, 250, sx + 200, -90)
		local _, h = draw.SimpleTextOutlined("Внимание", "MSDFont.Biger", sx / 2, sy / 8 - 50, color_red, TEXT_ALIGN_CENTER, 0, 1, color_black)

		draw.SimpleTextOutlined("При смене персонажа все ваши личные вещи и постройки будут удалены!", "MSDFont.32", sx / 2, sy / 8 + h - 50,  color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
		draw.SimpleTextOutlined("Ваше активное оружие пропадёт. Администрация не несёт ответственности за такую пропажу.", "MSDFont.32", sx / 2, sy / 8 + h - 20,  color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)
		draw.SimpleTextOutlined("Для отмены смены персонажа нажмите на кнопку повторно", "MSDFont.24", sx / 2, sy / 8 + h + 15,  color_white, TEXT_ALIGN_CENTER, 0, 1, color_black)

		if LocalPlayer():getDarkRPVar("payday") and LocalPlayer():getDarkRPVar("payday") > 0 then
			draw.SimpleTextOutlined("Вы не забрали зарплату! Воспользуйтесь ближайшим банкоматом!", "MSDFont.24", sx / 2, sy / 8 + h + 45,  color_red, TEXT_ALIGN_CENTER, 0, 1, color_black)
		end
	end
end

local blackscr = 1
local dt = 0
local dtg, prog = 0, 0
local owr =  Material("pp/texturize/plain.png")

function DarkRP.Hud.DeathScreen()
	if DarkRP.Hud.BreathSnd then
		DarkRP.Hud.BreathSnd:Stop()
	end

	if DarkRP.Hud.HeartBeat then
		DarkRP.Hud.HeartBeat:Stop()
	end

	dtg = DarkRP.DeathTime()

	if blackscr > 0 then
		if blackscr == 1 then
			dt = CurTime() + dtg
		end
		blackscr = math.Approach(blackscr, 0, FrameTime() * 0.05)
	end

	surface.SetDrawColor(color_black)
	surface.DrawRect(0, 0, sx, sy)

	prog = ((dt - CurTime()) / dtg)

	draw.SimpleTextOutlined("F1 - сообщить о нарушении", "MSDFont.28", 25, 10, MSD.Text.d, TEXT_ALIGN_LEFT, 0, 2, color_black)

	if LocalPlayer():getDarkRPVar("KT") then
		draw.SimpleTextOutlined("ID: " .. LocalPlayer():getDarkRPVar("KT"), "MSDFont.28", sx / 2, 10, MSD.Text.d, TEXT_ALIGN_CENTER, 0, 2, color_black)
	end

	draw.SimpleTextOutlined("ВЫ МЕРТВЫ", "Noire.Big", sx / 2, sy / 2 - 100, color_white, TEXT_ALIGN_CENTER, 0, 2, color_black)
	MSDX.Draw(0, sx / 2 - 200, sy / 2, math.max(400 * prog, 0), 5, color_white)

	if prog < 0.5 and prog > 0  and LocalPlayer():getDarkRPVar("karma") > 40 then
		draw.SimpleTextOutlined("Вы можете возродиться заранее засчёт вреда рассудку.", "MSDFont.28",sx / 2, sy / 2 + 50, color_white, TEXT_ALIGN_CENTER, 0, 2, color_black)
		draw.SimpleTextOutlined("Ради возрождения без последствий - дождитесь исчезновения полоски ожидания", "MSDFont.24",sx / 2, sy / 2 + 90, color_white, TEXT_ALIGN_CENTER, 0, 2, color_black)
	elseif #team.GetPlayers(13) > 0 and LocalPlayer():Team() ~= 13 then
		draw.SimpleTextOutlined("Возможно, парамедики смогут вас спасти", "MSDFont.28",sx / 2, sy / 2 + 50, color_white, TEXT_ALIGN_CENTER, 0, 2, color_black)
	end
end

function DarkRP.Hud.UnConscious()
	surface.SetDrawColor(MSD.ColorAlpha(color_black, 200 + 50 * math.abs(math.sin(CurTime() * 0.5)) ))
	surface.DrawRect(0, 0, sx, sy)
	DrawTexturize(1,owr)
	if not DarkRP.Hud.Materials["overlay_light"]:IsError() then
		surface.SetMaterial(DarkRP.Hud.Materials["overlay_light"])
		surface.SetDrawColor(color_black)
		surface.DrawTexturedRect(0, 0, sx, sy)
	end

	draw.SimpleTextOutlined("ВЫ БЕЗ СОЗНАНИЯ", "Noire.Big", sx / 2, sy / 2 - 100, color_white, TEXT_ALIGN_CENTER, 0, 2, color_black)
end

local mapmatr

function DarkRP.Hud.PushMask(mask)
	render.ClearStencil()
	render.SetStencilEnable(true)
	render.SetStencilWriteMask(1)
	render.SetStencilTestMask(1)
	render.SetStencilFailOperation(STENCILOPERATION_REPLACE)
	render.SetStencilPassOperation(STENCILOPERATION_ZERO)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_NEVER)
	render.SetStencilReferenceValue(1)
	mask()
	render.SetStencilFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilPassOperation(STENCILOPERATION_REPLACE)
	render.SetStencilZFailOperation(STENCILOPERATION_ZERO)
	render.SetStencilCompareFunction(STENCILCOMPARISONFUNCTION_EQUAL)
	render.SetStencilReferenceValue(1)
end

function DarkRP.Hud.PopMask()
	render.SetStencilEnable(false)
	render.ClearStencil()
end

local pcpt = {}

function DarkRP.Hud.GetPolly(w, h, px, py)
	if pcpt["p" .. w .. h] then
		return pcpt["p" .. w .. h]
	end

	local poly = {}
	local x, y = w / 2, h / 2

	for angle = 1, 360 do
		local rad = math.rad(angle)
		local cos = math.cos(rad) * y
		local sin = math.sin(rad) * y

		poly[#poly + 1] = {
			x = px + x + cos,
			y = py + y + sin
		}
	end
	pcpt["p" .. w .. h] = poly
	return poly
end

local lerpzoom = 0
local mp

function DarkRP.Hud.RenderMap(px, py, size)
	mp = IsValid(LocalPlayer():GetSimfphys()) and LocalPlayer():GetSimfphys() or LocalPlayer()

	if DarkRP.LocalMM and IsValid(DarkRP.LocalMM) then
		mapmatr = Matrix()
		lerpzoom = Lerp(FrameTime(), lerpzoom, math.min(mp:GetVelocity():Length2DSqr() / 160000, 1))
		local scale = (1.3 - (1 - size / 300) * 0.3) - (0.6 * lerpzoom)

		local center = DarkRP.LocalMM:GetWide() / 2 * scale - size / 2
		mapmatr:Translate(Vector(px - center, py - center))
		mapmatr:Rotate(Angle(0, 0, 0))
		mapmatr:Scale(Vector(scale, scale, scale))

		DarkRP.Hud.PushMask(function()
			local poly = DarkRP.Hud.GetPolly(size, size, px, py)
			draw.NoTexture()
			surface.SetDrawColor(255, 255, 255)
			surface.DrawPoly(poly)
		end)

		cam.PushModelMatrix(mapmatr)
		DarkRP.LocalMM:PaintManual()
		cam.PopModelMatrix()

		MSD.DrawTexturedRect(px, py, size, size, MSD.Materials.vignette, color_black)

		DarkRP.Hud.PopMask()
	end
end

function GM:HUDPaint()
	--MSD.DrawTexturedRect(sx / 2 - 8, sy / 2 - 8, 16, 16, MSD.Icons48.dot, color_white)

	if not IsValid(LocalPlayer()) or (GetConVar("cl_drawhud"):GetInt() == 0 and LocalPlayer():IsSuperAdmin()) or LocalPlayer():Team() == 0 then return end
	if LocalPlayer():GetMoveType() == 2 and LocalPlayer():GetViewEntity() == LocalPlayer() and not util.IsInWorld(EyePos()) then surface.SetDrawColor(color_black) surface.DrawRect(0, 0, sx, sy) end
	if not LocalPlayer():Alive() then DarkRP.Hud.DeathScreen() return end
	if LocalPlayer():getDarkRPVar("unconscious") and LocalPlayer():getDarkRPVar("unconscious") > 9 then DarkRP.Hud.UnConscious() return end

	DarkRP.Hud.VitalSigns()
	DarkRP.Hud.RenderMap(sx - 277, 30, 250)
	DarkRP.Hud.DoKill()

	local y = sy - (20 + DarkRP.Hud.IconSize)
	DarkRP.Hud.DrawBar(10, y)
	DarkRP.Hud.DrawWeaponBar(sx - 10, y)

	DarkRP.Hud.WeaponSelector()
	DarkRP.Hud.Door()
	DarkRP.HudHint()
	DarkRP.Hud.Information()

	if VehicleHUD then
		VehicleHUD()
	end

	if LocalPlayer().ischanging then
		DarkRP.Hud.Marker(LocalPlayer().ischanging)
	end

	if blackscr ~= 1 then blackscr = 1 end
end

hook.Add("DrawOverlay", "DrawNotifications", function()
	if GetConVar("developer"):GetBool() and not gui.IsConsoleVisible() and not LocalPlayer():IsSuperAdmin() then
		surface.SetDrawColor(color_black)
		surface.DrawRect(0, 0, ScrW(), ScrH())

		draw.SimpleText("Чтобы продолжить игру пропишите в консоль developer 0", "MSDFont.28", sx / 2, 10, MSD.Text.d, TEXT_ALIGN_CENTER, 0)
		RunConsoleCommand("developer", 0)
		return
	end

	if not GetConVar("r_3dsky"):GetBool() and not gui.IsConsoleVisible() then
		surface.SetDrawColor(color_black)
		surface.DrawRect(0, 0, ScrW(), ScrH())

		draw.SimpleText("Чтобы продолжить игру пропишите в консоль r_3dsky 1", "MSDFont.32", sx / 2, sy / 2, MSD.Text.d, TEXT_ALIGN_CENTER, 0)
		RunConsoleCommand("r_3dsky", 1)
		return
	end

	if IsValid(MCS.Dialogue) or IsValid(esc.Menu) or (IsValid(MCR.LocadingMenu) and not MCR.LocadingMenu.Allow) or GetConVar("cl_drawhud"):GetInt() == 0 then return end
	DarkRP.Hud.DrawNotifications()
end)

DarkRP.Hud.WS = {}
DarkRP.Hud.WS.weapons = {}
DarkRP.Hud.WS.pcTime = 0
DarkRP.Hud.WS.alpha = 0
DarkRP.Hud.WS.alphaDelta = 0

DarkRP.Hud.WS.wepSlot = -1
DarkRP.Hud.WS.wepSel = 1
DarkRP.Hud.WS.wepSelDelta = 1
DarkRP.Hud.WS.wepSelOld = 1

local selTime = 0
local sel_W = 0

function DarkRP.Hud.WS.Precache(ply)
	if DarkRP.Hud.WS.pcTime < CurTime() then
		DarkRP.Hud.WS.weapons = {}

		for k, v in pairs(ply:GetWeapons()) do
			if (not DarkRP.Hud.WS.weapons[v:GetSlot() + 1]) then
				DarkRP.Hud.WS.weapons[v:GetSlot() + 1] = {}
			end

			DarkRP.Hud.WS.weapons[v:GetSlot() + 1][#DarkRP.Hud.WS.weapons[v:GetSlot() + 1] + 1] = v
		end

		DarkRP.Hud.WS.pcTime = CurTime() + 1
	end
end

function DarkRP.Hud.WeaponSelector()
	local ply = LocalPlayer()

	if not ply:Alive() or ply:InVehicle() or not ply:GetActiveWeapon().GetPrintName then return end

	local x, y = 15, sy / 4
	DarkRP.Hud.WS.alphaDelta = Lerp(FrameTime() * 5, DarkRP.Hud.WS.alphaDelta, DarkRP.Hud.WS.alpha)

	if DarkRP.Hud.WS.alphaDelta < 0.01 then return end

	DarkRP.Hud.WS.Precache(ply)

	local sp = 0

	for k, v in pairs(DarkRP.Hud.WS.weapons) do
		local st = ply:GetActiveWeapon():GetSlot() + 1 == k

		local sel_clr = st and DarkRP.Hud.Patern["main_l"] or color_white
		sel_clr = MSD.ColorAlpha(sel_clr, DarkRP.Hud.WS.alphaDelta * (DarkRP.Hud.WS.wepSlot == k and 255 or 100))
		MSDX.Draw(0, x, y + sp, 32, 32, MSD.ColorAlpha(DarkRP.Hud.Patern["bgr"], DarkRP.Hud.WS.alphaDelta * 200))
		MSDX.Draw(0, x, y + sp, 2, 32, sel_clr)
		draw.SimpleText(k, "MSDFont.24", x + 16, y + sp + 16, sel_clr, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

		DarkRP.Hud.WS.wepSelDelta = Lerp(FrameTime() * 3, DarkRP.Hud.WS.wepSelDelta, DarkRP.Hud.WS.wepSel)

		if DarkRP.Hud.WS.wepSlot == k then
			subW = 0

			for sk, sv in pairs(v) do
				if not IsValid(sv) then return end
				if (DarkRP.Hud.WS.wepSel > #v) then
					DarkRP.Hud.WS.wepSel = 1
				end

				if sk == DarkRP.Hud.WS.wepSel then continue end
				local pos_mp = (sk - DarkRP.Hud.WS.wepSelDelta) * 28

				if sk < DarkRP.Hud.WS.wepSel then
					pos_mp = (DarkRP.Hud.WS.wepSelDelta - sk) * 28 * -1
				end

				draw.SimpleTextOutlined(sv:GetPrintName(), "MSDFont.24", x + 55, y + sp + 16 + pos_mp, MSD.ColorAlpha(color_white, 120 * DarkRP.Hud.WS.alphaDelta), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, MSD.ColorAlpha(color_black, 50 * DarkRP.Hud.WS.alphaDelta))
			end
		end

		if v[DarkRP.Hud.WS.wepSel] and DarkRP.Hud.WS.wepSlot == k then
			MSDX.Draw(0, x + 45, y + sp, 12 + sel_W, 32, MSD.ColorAlpha(DarkRP.Hud.Patern["bgr"], DarkRP.Hud.WS.alphaDelta * 180))
			sel_W = draw.SimpleTextOutlined(v[DarkRP.Hud.WS.wepSel]:GetPrintName(), "MSDFont.28", x + 50, y + sp + 16, MSD.ColorAlpha(color_white, 255 * DarkRP.Hud.WS.alphaDelta), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, MSD.ColorAlpha(color_black, 80 * DarkRP.Hud.WS.alphaDelta))
			if (DarkRP.SingleWep.PistolWeps[v[DarkRP.Hud.WS.wepSel]:GetClass()] and not v[DarkRP.Hud.WS.wepSel].DontHide) and (MCR.HasTatoo(LocalPlayer(), "a1") or v[DarkRP.Hud.WS.wepSel]:GetNWBool("HiddenWep")) then
				MSD.DrawTexturedRect(x + 50 + sel_W + 5, y + sp + 4, 26, 26, MSD.Icons48.eye_off_custom, MSD.ColorAlpha(color_white, 255 * DarkRP.Hud.WS.alphaDelta))
				sel_W = sel_W + 35
			end
		end

		sp = sp + 35
	end

	if selTime < CurTime() then DarkRP.Hud.WS.alpha = 0 end
end

hook.Add("PlayerBindPress", "DarkRP.Hud.WeaponSelector", function(ply, bind, pressed)
	if ply:InVehicle() and ply:getDarkRPVar("unconscious") then return true end

	if not ply:Alive() then return end
	if McPhone.UI and not McPhone.UI.Closing then return end

	if bind:find("zoom") and (not ply.lastzoom or ply.lastzoom < CurTime()) then
		ply.lastzoom = CurTime() + 2.2
		DarkRP.higlightTattoo()
		RunConsoleCommand("say", "/look")
	end

	bind = bind:lower()

	if not pressed or not bind:find("invprev") and not bind:find("invnext") and not bind:find("slot") and not bind:find("attack") and not bind:find("jump") then
		return
	end

	if ply:getDarkRPVar("fanim") and ply:getDarkRPVar("fanim") > CurTime() then return true end

	local currentWeapon = ply:GetActiveWeapon()
	local bValid = IsValid(currentWeapon)

	local bTool

	if (ply:InVehicle() or (bValid and currentWeapon:GetClass() == "weapon_physgun" and ply:KeyDown(IN_ATTACK))) then
		return
	end

	if (bValid and currentWeapon:GetClass() == "gmod_tool") then
		local tool = ply:GetTool()
		bTool = tool and (tool.Scroll ~= nil)
	end

	local prew = bind:find("invprev")

	if bind:find("slot") then
		selTime = CurTime() + 2
		DarkRP.Hud.WS.alpha = 1
		if (tonumber(string.sub(bind, 5, 6)) == DarkRP.Hud.WS.wepSlot) then
			DarkRP.Hud.WS.wepSel = DarkRP.Hud.WS.wepSel + 1
		else
			DarkRP.Hud.WS.wepSel = 1
		end
		DarkRP.Hud.WS.wepSlot = tonumber(string.sub(bind, 5, 6))
		ply:EmitSound("common/talk.wav", 50, pitch or 180)
		return true
	elseif (bind:find("invnext") or prew) and not bTool and bValid then

		DarkRP.Hud.WS.alpha = 1
		slot_change = prew and -1 or 1

		if selTime < CurTime() then
			DarkRP.Hud.WS.wepSlot = currentWeapon:GetSlot() and currentWeapon:GetSlot() + 1 or 1 selTime = CurTime() + 2
			return true
		end

		DarkRP.Hud.WS.wepSel = DarkRP.Hud.WS.wepSel + slot_change

		DarkRP.Hud.WS.Precache(ply)
		local weapons = DarkRP.Hud.WS.weapons

		if (weapons[DarkRP.Hud.WS.wepSlot] and DarkRP.Hud.WS.wepSel > #weapons[DarkRP.Hud.WS.wepSlot] or DarkRP.Hud.WS.wepSel <= 0) then
			DarkRP.Hud.WS.wepSlot = DarkRP.Hud.WS.wepSlot + slot_change

			if weapons[DarkRP.Hud.WS.wepSlot] and prew then
				DarkRP.Hud.WS.wepSel = 1
				for k = DarkRP.Hud.WS.wepSlot, Either(prew, 0, 10), slot_change do
					if (weapons[k]) then
						DarkRP.Hud.WS.wepSel = Either(prew, #weapons[k], 1)
						break
					end
				end
			end
		end

		if (not weapons[DarkRP.Hud.WS.wepSlot]) then
			local b = false

			for k = DarkRP.Hud.WS.wepSlot, Either(prew, 0, 10), Either(prew, -1, 1) do
				if (weapons[k]) then
					DarkRP.Hud.WS.wepSlot = k
					DarkRP.Hud.WS.wepSel = Either(prew, #weapons[k], 1)
					b = true
					break
				end
			end

			if (not b) then
			 	DarkRP.Hud.WS.wepSlot = DarkRP.Hud.WS.wepSel < 1 and 1 or DarkRP.Hud.WS.wepSlot - 1
			 	DarkRP.Hud.WS.wepSel = DarkRP.Hud.WS.wepSel < 1 and 1 or DarkRP.Hud.WS.wepSel - 1
			end
		end

		selTime = CurTime() + 2
		ply:EmitSound("common/talk.wav", 50, pitch or 180)
		return true
	elseif bind:find("attack2") and DarkRP.Hud.WS.alpha > 0 then
		DarkRP.Hud.WS.alpha = 0
		return true
	elseif bind:find("attack") and DarkRP.Hud.WS.alpha > 0 then
		local weapon = DarkRP.Hud.WS.weapons[DarkRP.Hud.WS.wepSlot] and DarkRP.Hud.WS.weapons[DarkRP.Hud.WS.wepSlot][DarkRP.Hud.WS.wepSel] or nil
		if IsValid(weapon) then
			ply:EmitSound("HL2Player.Use")
			input.SelectWeapon(weapon)
			DarkRP.Hud.WS.alpha = 0
		end
		return true
	end

end)

local killcolor = Color(255, 115, 0)
local icon_doors = {
	["Открыто"] = MSD.Icons48.lock_open,
	["Закрыто"] = MSD.Icons48.lock
}

function DarkRP.Hud.DoorPrint(close)
	local startt = CurTime()
	local anim = 1

	DarkRP.Hud.Door = function()
		local x, y = sx / 2, sy * 0.55
		draw.SimpleTextOutlined(close, "MSDFont.20", x + 50, y + 3, MSD.ColorAlpha(color_white, anim * 250), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MSD.ColorAlpha(color_black, anim * 50))
		MSD.DrawTexturedRect(x + 2, y + 6, 24, 24, icon_doors[close] or MSD.Icons48.cog, MSD.ColorAlpha(color_black, anim * 250))
		MSD.DrawTexturedRect(x, y + 4, 24, 24, icon_doors[close] or MSD.Icons48.cog, MSD.ColorAlpha(color_white, anim * 250))

		if startt + 1 < CurTime() then
			anim = Lerp(FrameTime() * 6, anim, 0)
		end

		if startt + 2 < CurTime() then
			DarkRP.Hud.Door = function() end
		end
	end
end

local hitmark = Material("nyhit.png", "smooth")
function DarkRP.Hud.HitMark()
	local startt = CurTime()
	local anim = 1

	surface.PlaySound("viper/shared/melee/melee_world_fist_soft_plr_0" .. math.random(5) .. ".ogg")

	DarkRP.Hud.DoKill = function()
		local x, y = sx / 2, sy / 2
		MSD.DrawTexturedRect(x - 32, y - 32, 64, 64, hitmark, MSD.ColorAlpha(color_white, anim * 100))

		if startt + 0.2 < CurTime() then
			anim = Lerp(FrameTime() * 8, anim, 0)
		end

		if startt + 10 < CurTime() then
			DarkRP.Hud.DoKill = function() end
		end
	end
end

function DarkRP.Hud.BloomEf(cl, cmod)
	local startt = CurTime()
	local bloom = 1
	local anim = 0.5

	cmod = cmod or 35

	DarkRP.Hud.DoKill = function()
		bloom = math.Approach(bloom, 0, 0.01)

		if bloom > 0 then
			if not DarkRP.Hud.Materials["overlay_light"]:IsError() then
				MSD.DrawTexturedRect(0, 0, sx, sy, DarkRP.Hud.Materials["overlay_light"], MSD.ColorAlpha(cl, bloom * cmod))
			end
			DrawBloom(0, bloom, 11, 11, 11, 2, cl.r * 0.001, cl.g * 0.001, cl.b * 0.001)
		end

		if startt + 2 < CurTime() then
			anim = Lerp(FrameTime() * 3, anim, 0)
		else
			anim = Lerp(FrameTime() * 5, anim, 1)
		end

		if startt + 10 < CurTime() then
			DarkRP.Hud.DoKill = function() end
		end
	end
end

function DarkRP.Hud.SmokeEf()
	local startt = CurTime()
	local anim = 0.5

	DarkRP.Hud.DoKill = function()
		DrawSharpen( anim, anim )

		if startt + 5 < CurTime() then
			anim = Lerp(FrameTime() * 2, anim, 0)
		else
			anim = Lerp(FrameTime() * 2, anim, 1.1)
		end

		if startt + 10 < CurTime() then
			DarkRP.Hud.DoKill = function() end
		end
	end
end

net.Receive("DarkRP.Hud.Kill", function()
	DarkRP.Hud.BloomEf(killcolor)
end)

net.Receive("DarkRP.Hud.SelfHIT", function()
	util.ScreenShake( Vector(0,0,0), 10, 10, 0.5, 1 )
end)

net.Receive("DarkRP.Hud.Suppression", function()
	AddSuppression(3)
end)

net.Receive("DarkRP.Hud.Suppress", function()
	local atc = net.ReadEntity()
	local src = net.ReadVector()
	local ang = net.ReadAngle()
	local dst = net.ReadInt(32)

	local victim = LocalPlayer()
	local victimOrgin = victim:GetPos()
	--Get the position between the target's eyes and feet
	local myPos = victimOrgin + ((victim:EyePos() - victimOrgin) / 2)
	local targDistToSqr = myPos:DistToSqr(src)
	local aimatmeVector = myPos - src

	if targDistToSqr < (dst + 256) ^ 2 then
		local compareAng = aimatmeVector:Angle()
		local fireAng = ang
		local missAng = compareAng - fireAng
		missAng:Normalize()
		local missToSqr = (missAng.p ^ 2) + (missAng.y ^ 2)

		if (missToSqr <= 2025 and targDistToSqr <= 90000) or (targDistToSqr > 90000 and (missToSqr <= 8100 / (targDistToSqr / 5625))) then
			local trdata = {}

			trdata.start = src
			trdata.endpos = victim:EyePos()

			trdata.filter = {atc, victim}

			trdata.mask = MASK_SHOT --or MASK_BLOCKLOS_AND_NPCS
			local trace = util.TraceLine(trdata)

			if not trace.Hit then
				AddSuppression(1)
			end
		end
	end
end)

hook.Add("CalcView", "GB_CalcDeathView", function(ply, origin, angles, fov)
	if not ply:Alive() or ply:getDarkRPVar("unconscious") then
		if not IsValid(ply.DeathRagdoll) or not ply:Alive() then
			if ply:getDarkRPVar("unconscious") then return end
			return GAMEMODE.Config.DeathView
		end
		local atch = ply.DeathRagdoll:LookupAttachment("eyes")
		if atch < 1 then return dw end
		local eyes = ply.DeathRagdoll:GetAttachment(ply.DeathRagdoll:LookupAttachment("eyes"))
		local view = {
			origin = eyes.Pos,
			angles = eyes.Ang,
			fov = fov,
		}

		return view
	end
end)

DarkRP.MiniMap = {}
DarkRP.MiniMap.Scale = 794
DarkRP.MiniMap.Translate = Vector(0,-11,0)
DarkRP.MiniMap.Zoom = 0.9
DarkRP.MiniMap.Material = Material("gmodla/rp_southside.png", "smooth")
DarkRP.MiniMap.Material_sm = Material("gmodla/rp_southside_w.png", "smooth")

DarkRP.MiniMap.Blips = {
	{7022,5080, MSD.Icons48.hospital_box, "Медицинский центр"},
	{8182,8400, MSD.Icons48.police, "Полицейский участок"},
	{9478, 1554, MSD.Icons48.fire_extinguisher, "Пожарная станция"},
	{-2293, 10377, MSD.Icons48.shopping, "Магазин одежды"},
	{461, 13226, MSD.Icons48.gas_station, "Заправка"},
	{690, 14268, MSD.Icons48.cart, "Магазин"},
	{-5905, 1498, MSD.Icons48.cart},
	{-6963, 1617, MSD.Icons48.car, "Автосалон"},
	{-5933, 664, MSD.Icons48.gas_station},
	{-476, -5559, MSD.Icons48.box, "Хранилище"},
	{-1197, 5115, MSD.Icons48.web, "Бизнес-центр"},
	{-988, 2943, MSD.Icons48.currency_usd, "Банк"},
	{-7353, 6013, MSD.Icons48.glass_cocktail, "Клуб"},
	{2792, 5090, MSD.Icons48.town_hall, "Ратуша"},
	{1391, -1446, MSD.Icons48.tools, "Магазин хозтоваров"},
	{-466, 8746, MSD.Icons48.cards_club, "Тату салон"},
}
hook.Remove("PostDrawEffects", "RenderWidgets")

function GM:HUDWeaponPickedUp(wep)
	if not (IsValid(wep) and IsValid(LocalPlayer())) or (not LocalPlayer():Alive()) then return end
	if self.Config.DisallowDrop[wep:GetClass()] then return end
	notification.AddInventory("Вы подобрали предмет", "weapon", 5)
end

function GM:HUDItemPickedUp(itemname)
	if (not IsValid(LocalPlayer()) or not LocalPlayer():Alive()) then return end
	notification.AddInventory("Вы подобрали предмет", "weapon", 5)
end

function GM:HUDAmmoPickedUp(itemname, amount)
	if (not IsValid(LocalPlayer()) or not LocalPlayer():Alive()) then return end
	notification.AddInventory("Вы подобрали предмет", "weapon", 5)
end

function GM.DrawDeathNotice()
end

hook.Add( "OnScreenSizeChanged", "ChangeHudStats", function( oldWidth, oldHeight )
	sx, sy = ScrW(), ScrH()
end )