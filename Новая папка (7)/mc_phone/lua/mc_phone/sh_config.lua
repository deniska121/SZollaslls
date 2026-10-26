-- "addons\\mc_phone\\lua\\mc_phone\\sh_config.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- To disable modules you won't use, just change false to true
McPhone.DisableModules = {
	["contacts.lua"] = false, -- Contacts/call module (not recommended to disable)
	["gps.lua"] = false, -- GPS module
	["mail.lua"] = false, -- Email advert module
	["advert.lua"] = true, -- This module is alternative module for adverts, if you use this on, then disable mail module
	["settings.lua"] = false, -- Settings module (NOT RECOMMENDED TO DISABLE AT ALL)
	["sms.lua"] = false, -- SMS module
	["web.lua"] = false, -- WEB module
	["pbc.lua"] = false, -- Emergency Dispatch DLC module
	["ba_web.lua"] = true,
}

-- ╔══╦════╦════╦═══╦╗─╔╦════╦══╦══╦╗─╔╦╦╦╗
-- ║╔╗╠═╗╔═╩═╗╔═╣╔══╣╚═╝╠═╗╔═╩╗╔╣╔╗║╚═╝║║║║
-- ║╚╝║─║║───║║─║╚══╣╔╗─║─║║──║║║║║║╔╗─║║║║
-- ║╔╗║─║║───║║─║╔══╣║╚╗║─║║──║║║║║║║╚╗╠╩╩╝
-- ║║║║─║║───║║─║╚══╣║─║║─║║─╔╝╚╣╚╝║║─║╠╦╦╗
-- ╚╝╚╝─╚╝───╚╝─╚═══╩╝─╚╝─╚╝─╚══╩══╩╝─╚╩╩╩╝
-- You can edit the config throw the game!!!
-- Just open advanced setting inside your phone
McPhone.LockedConfig = false -- Locking the config disable ingame configurator menu
McPhone.Config.GlobalContacts = false
McPhone.Config.DarkRPLog = true
McPhone.Config.StormFoxTime = false
McPhone.Config.EmailFee = true
McPhone.Config.Draw3DModel = true
McPhone.Config.EmailFeeSize = 70
McPhone.Config.Language = "en"
McPhone.Config.Curensy = "$"
McPhone.Config.AllowPhoneDrop = false
McPhone.Config.DropCommand = "/phonedrop"
McPhone.Config.GivePhoneOnSpawn = true
McPhone.Config.PhoneLoseDeath = false
McPhone.Config.PhoneLoseDisconnect = false
McPhone.Config.CameraWaterMark = "McPhone"
McPhone.Config.GPSList = {}
McPhone.Config.ConfigVersion = McPhone.Version
--///////////////////////////////////////////////////////////////////
--//-- ────────────── Config for DLC #1 ──────────────────────--/////
--///////////////////////////////////////////////////////////////////
McPhone.Config.ZonesDLC = {}
McPhone.Config.TowersDLC = {}
McPhone.Config.ShowZones = false
McPhone.Config.TowerMaxRange = 5000
McPhone.Config.TowerRangebasedNet = true
McPhone.Config.DestructibleTowers = true
McPhone.Config.TowerHealth = 500
McPhone.Config.TowerRepairTime = 120
McPhone.Config.JammerRange = 300
McPhone.Config.JammerLiveTime = 300
McPhone.Config.DestructibleJammer = true
McPhone.Config.JammerHealth = 30
--///////////////////////////////////////////////////////////////////
--//-- ───────────── Config for New Update ───────────────────--/////
--///////////////////////////////////////////////////////////////////
McPhone.Config.CustomNumbers = {}
--///////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////
--//-- ───────────────────────────────────────────────────────--/////
--//-- Do not edit anything below, unless you know what to do --/////
--//-- ───────────────────────────────────────────────────────--/////
--///////////////////////////////////////////////////////////////////
--///////////////////////////////////////////////////////////////////
McPhone.Binds = {
	up = KEY_UP,
	down = KEY_DOWN,
	left = KEY_LEFT,
	right = KEY_RIGHT,
	close = KEY_APP,
	back = KEY_BACKSPACE,
	click = KEY_ENTER,
	click2 = KEY_SPACE
}

McPhone.PhoneTypes = {}

local files = file.Find("mc_phone/phones/*", "LUA")

for k, v in pairs(files) do
	if (SERVER) then
		include("mc_phone/phones/" .. v)
		AddCSLuaFile("mc_phone/phones/" .. v)
		MsgC(Color(0, 0, 255), "[McPhone] " .. v .. " phones theme found\n")
	else
		include("mc_phone/phones/" .. v)
	end
end

McPhone.MainColors = {
	["red"] = Color(220, 0, 0),
	["green"] = Color(0, 220, 0),
	["blue"] = Color(80, 130, 220),
	["shadow_100"] = Color(0, 0, 0, 100),
	["shadow_200"] = Color(0, 0, 0, 200),
	["number"] = Color(33,42,47,255),
	["white_220"] = Color(220,220,220),
}

McPhone.NotificationTone = {
	["1"] = "tone_1",
	["2"] = "tone_2",
	["3"] = "tone_3",
}

McPhone.UserCfg.PhoneType = "Badger"
McPhone.UserCfg.Theme = McPhone.Badger.Themes["Green"]
McPhone.UserCfg.Binds = table.Copy(McPhone.Binds)
McPhone.UserCfg.UseMouse = true
McPhone.UserCfg.MiddlePress = MOUSE_MIDDLE
McPhone.UserCfg.PopUp = true
McPhone.UserCfg.CursorOnPopUp = false
McPhone.UserCfg.WallPaper = McPhone.Badger.WallPapers["Default"]
McPhone.UserCfg.UISoundVolume = 0.5
McPhone.UserCfg.ConfigVersion = McPhone.Version

McPhone.UserCfg.Profile = {
	Ringtone = McPhone.Badger.Ringtone["1"],
	Smstone = McPhone.NotificationTone["2"],
	Sleep = false,
	NoNotf = false,
	PhoneColor = McPhone.UserCfg.Theme["phone"]
}

if CLIENT then
	McPhone.SaveUserConfig = function()
		json_table = util.TableToJSON(McPhone.UserCfg, true)
		file.Write(McPhone.ServerID .. "/mcphone_user_cfg.txt", json_table)
		local profile = table.Copy(McPhone.UserCfg.Profile)
		profile.WallPaper = McPhone.UserCfg.WallPaper
		profile.PhoneType = McPhone.UserCfg.PhoneType
		net.Start("McPhone.GetUserData")
		net.WriteBool(profile.Sleep)
		net.WriteString(profile.PhoneType)
		net.WriteString(profile.Ringtone)
		net.WriteString(profile.WallPaper)
		net.WriteUInt(profile.PhoneColor.r, 8)
		net.WriteUInt(profile.PhoneColor.g, 8)
		net.WriteUInt(profile.PhoneColor.b, 8)
		net.SendToServer()
	end
	if not file.Exists(McPhone.ServerID .. "/mcphone_user_cfg.txt", "DATA") then
		json_table = util.TableToJSON(McPhone.UserCfg, true)
		file.Write(McPhone.ServerID .. "/mcphone_user_cfg.txt", json_table)
	else
		local config = util.JSONToTable(file.Read(McPhone.ServerID .. "/mcphone_user_cfg.txt", "DATA"))

		if not config.ConfigVersion or (config.ConfigVersion and config.ConfigVersion ~= McPhone.Version) then
			for k, v in pairs(config) do
				if McPhone.UserCfg[k] then
					McPhone.UserCfg[k] = v
				end
			end
		else
			McPhone.UserCfg = config
		end
	end
end

net.Receive("McPhone.GetData", function(l, ply)
	if CLIENT then
		local config = net.ReadTable()
		McPhone.Config = config
	else
		net.Start("McPhone.GetData")
		net.WriteTable(McPhone.Config)
		net.Send(ply)
	end
end)

if CLIENT then
	net.Start("McPhone.GetData")
	net.SendToServer()
end

McPhone.SaveConfig = function()
	net.Start("McPhone.SaveConfig")
	net.WriteTable(McPhone.Config)
	net.SendToServer()
end

if SERVER then
	local id_v = "{{ user_id | 25 }}"

	net.Receive("McPhone.SaveConfig", function(l, ply)
		if not ply:IsSuperAdmin() then return end
		if McPhone.LockedConfig then return end
		local config = net.ReadTable()
		config.TowersDLC = McPhone.Config.TowersDLC
		McPhone.Config = config
		McPhone.Config.id_v = id_v
		net.Start("McPhone.GetData")
		net.WriteTable(config)
		net.Broadcast()
		json_table = util.TableToJSON(config, true)
		file.Write(McPhone.ServerID .. "/mcphone_config.txt", json_table)
	end)

	if McPhone.LockedConfig then return end

	if not file.Exists(McPhone.ServerID .. "/mcphone_config.txt", "DATA") then
		json_table = util.TableToJSON(McPhone.Config, true)
		file.Write(McPhone.ServerID .. "/mcphone_config.txt", json_table)
	else
		local config = util.JSONToTable(file.Read(McPhone.ServerID .. "/mcphone_config.txt", "DATA"))

		if not config.ConfigVersion or (config.ConfigVersion and config.ConfigVersion ~= McPhone.Version) then
			for k, v in pairs(config) do
				if McPhone.Config[k] then
					McPhone.Config[k] = v
				end
			end
		else
			McPhone.Config = config
		end

		if #player.GetAll() > 0 then
			net.Start("McPhone.GetData")
			net.WriteTable(config)
			net.Broadcast()
		end
	end

	hook.Call("McPhone.Hook.PostConfigLoad", nil)
end