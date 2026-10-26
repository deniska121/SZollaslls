--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

GM.Version = "3.0.0"
GM.Name = "DarkRP"
GM.Author = "By - Mactavish"
DeriveGamemode("basebox")

local pmeta = FindMetaTable("Player")
pmeta.SteamName = pmeta.SteamName or pmeta.Name

function pmeta:Name()
	return self.DarkRPVars and self:getDarkRPVar("dsname") or self:SteamName()
end

pmeta.Nick = pmeta.Name
pmeta.GetName = pmeta.GetName

function pmeta:FullName()
	return self.DarkRPVars and self:getDarkRPVar("rpname") or self:SteamName()
end

local gfol = GM.FolderName .. "/gamemode/"
local fol = ""

local function LoadModules()
	local root = GM.FolderName .. "/gamemode/modules/"
	local _, folders = file.Find(root .. "*", "LUA")

	for _, folder in SortedPairs(folders, true) do
		if GM.Config.DisabledModules[folder] then continue end

		for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
			if File == "sh_interface.lua" then continue end
			include(root .. folder .. "/" .. File)
		end

		for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
			if File == "cl_interface.lua" then continue end
			include(root .. folder .. "/" .. File)
		end
	end
end

GM.Config = {}
include("sh_interfaceloader.lua")
include("config.lua")
include("playervars/sh_init.lua")
include("playervars/cl_init.lua")
include("shared/player_class.lua")
include("shared/animations.lua")
include("shared/commands.lua")
include("shared/entity.lua")
include("shared/MakeThings.lua")
include("shared/Workarounds.lua")
include("shared.lua")

fol = gfol .. "spawnlist/"
local spawnlist = file.Find(fol .. "*", "LUA")

for k, v in pairs(spawnlist) do
	include(fol .. v)
end

fol = gfol .. "client/"
local clientf = file.Find(fol .. "*", "LUA")

for k, v in pairs(clientf) do
	include(fol .. v)
end

LoadModules()
DarkRP.finish()
DarkRP.HudHint = function() end

function GM:DrawDeathNotice(x, y)
	return
end

local not_sounds = {
	[NOTIFY_ERROR] = "msd/ui/error.wav",
	[NOTIFY_UNDO] = "buttons/lightswitch2.wav",
	[NOTIFY_HINT] = "hint.wav",
	[NOTIFY_GENERIC] = "msd/ui/return.wav",
	[NOTIFY_CLEANUP] = "msd/ui/return.wav",
	[5] = "radio/commander.wav",
}

function DarkRP.notify(msgtype, len, msg)
	GAMEMODE:AddNotify(msg, msgtype, len)
	MSD.PlaySnd(not_sounds[msgtype] or "hint.wav")
end

net.Receive("GLA.Notify", function()
	local msg = net.ReadString()
	local msgtype = net.ReadUInt(4)
	local len = net.ReadUInt(12)
	DarkRP.notify(msgtype, len, msg)
end)

local hideElements = {
	["CHudHealth"] = true,
	["CHudBattery"] = true,
	["CHudCloseCaption"] = true,
	["CHudAmmo"] = true,
	["CHudSuitPower"] = true,
	["CHudSecondaryAmmo"] = true,
	["CHudDeathNotice"] = true,
	["CHudDamageIndicator"] = true,
	["CHudHintDisplay"] = true,
	["CHudWeaponSelection"] = true,
	["CHudGeiger"] = true,
	["CHudPoisonDamageIndicator"] = true,
	["CHudSquadStatus"] = true,
	["CHudZoom"] = true,
	["CHUDAutoAim"] = true,
	["CHUDQuickInfo"] = true,
}

function GM:HUDShouldDraw(name)
	if hideElements[name] then return false end
	if name == "NetGraph" and not LocalPlayer():IsSuperAdmin() then return false end

	return true
end

function GM:HUDDrawTargetID()
	return false
end

function GM:findPlayer(info)
	if not info or info == "" then return nil end
	local pls = player.GetAll()

	for k = 1, #pls do
		local v = pls[k]
		if tonumber(info) == v:UserID() then return v end
		if info == v:SteamID() then return v end
		if string.find(string.lower(v:SteamName()), string.lower(tostring(info)), 1, true) ~= nil then return v end
		if string.find(string.lower(v:FullName()), string.lower(tostring(info)), 1, true) ~= nil then return v end
	end

	return nil
end

local GUIToggled = false

function GM:ShowHelp()
	RunConsoleCommand("gmodla_f1")
end

local mouseX, mouseY = ScrW() / 2, ScrH() / 2

function GM:ShowSpare1()
	GUIToggled = not GUIToggled

	if GUIToggled then
		gui.SetMousePos(mouseX, mouseY)
	else
		mouseX, mouseY = gui.MousePos()
	end

	gui.EnableScreenClicker(GUIToggled)
end

function GM:ShowSpare2()
	RunConsoleCommand("gmodla_f4")
end

DarkRP.RadioCH = {}

function GM:PlayerStartVoice(ply)
	local lp = LocalPlayer()

	if ply.CanRadio and ply:CanRadio(lp) then
		surface.PlaySound("radio/blip_03.wav")
		DarkRP.RadioCH[ply] = true
	end

	return true
end

function GM:PlayerEndVoice(ply)
	local lp = LocalPlayer()

	DarkRP.RadioCH[ply] = nil

	if ply.CanRadio and ply:CanRadio(lp) then
		surface.PlaySound("radio/blip_04.wav")
	end

	self.BaseClass:PlayerEndVoice(ply)
end

function GM:OnPlayerChat()
end

local FKeyBinds = {
	["gm_showhelp"] = "ShowHelp",
	["gm_showteam"] = "ShowTeam",
	["gm_showspare1"] = "ShowSpare1",
	["gm_showspare2"] = "ShowSpare2"
}

function GM:PlayerBindPress(ply, bind, pressed)
	local bnd = string.match(string.lower(bind), "gm_[a-z]+[12]?")

	if bnd and FKeyBinds[bnd] and GAMEMODE[FKeyBinds[bnd]] then
		GAMEMODE[FKeyBinds[bnd]](GAMEMODE)
	end

	return
end

net.Receive("DarkRP_DoorData", function()
	local bytes_number = net.ReadInt(32)
	local compressed_data = net.ReadData(bytes_number)
	local data = DarkRP.TableDecompress(compressed_data)

	for index, ddata in pairs(data) do
		local door = Entity(index)
		if not IsValid(door) or not ddata then continue end

		if ddata.teamOwn then
			local tdata = {}

			for k, v in pairs(string.Explode("\n", ddata.teamOwn or "")) do
				if v and v ~= "" then
					tdata[tonumber(v)] = true
				end
			end

			ddata.teamOwn = tdata
		else
			ddata.teamOwn = nil
		end

		door.doorData = ddata
	end
end)

function GM:InitPostEntity()
	RunConsoleCommand("_sendDarkRPvars")
	RunConsoleCommand("violence_hblood", 0)

	--RunConsoleCommand("_sendAllDoorData")
	timer.Create("DarkRPCheckifitcamethrough", 15, 0, function()
		for k, v in pairs(player.GetAll()) do
			if v.DarkRPVars and v:getDarkRPVar("rpname") then continue end
			RunConsoleCommand("_sendDarkRPvars")

			return
		end
	end)

	net.Start("sA:Networking")
	net.WriteUInt(3, 3)
	net.WriteUInt(0, 2)
	net.SendToServer()
	net.Start("DarkRP.PlayerLoaded")
	net.SendToServer()
	hook.Call("TeamChanged", GAMEMODE, 1, 1)
end

function GM:TeamChanged(before, after)
	return
end

local function OnChangedTeam()
	hook.Call("TeamChanged", GAMEMODE, net.ReadInt(12), net.ReadInt(12))
end

net.Receive("OnChangedTeam", OnChangedTeam)

local function charWrap(text, pxWidth)
	local total = 0

	text = text:gsub(".", function(char)
		total = total + surface.GetTextSize(char)

		-- Wrap around when the max width is reached
		if total >= pxWidth then
			total = 0

			return "\n" .. char
		end

		return char
	end)

	return text, total
end

function DarkRP.TextWrap(text, font, pxWidth)
	local total = 0
	surface.SetFont(font)
	local spaceSize = surface.GetTextSize(' ')

	text = text:gsub("(%s?%w+)", function(word)
		local char = string.sub(word, 1, 1)

		if char == "\n" then
			total = 0
		end

		local wordlen = surface.GetTextSize(word)
		total = total + wordlen

		-- Wrap around when the max width is reached
		-- Split the word if the word is too big
		if wordlen >= pxWidth then
			local splitWord, splitPoint = charWrap(word, pxWidth)
			total = splitPoint

			return splitWord
		elseif total < pxWidth then
			return word
		end

		-- Split before the word
		if char == ' ' then
			total = wordlen - spaceSize

			return '\n' .. string.sub(word, 2)
		end

		total = wordlen

		return "\n" .. word
	end)

	return text
end

timer.Create("DarkRPCheckifitcamethrough", 15, 0, function()
	for _, v in ipairs(player.GetAll()) do
		if v:getDarkRPVar("money") then continue end
		RunConsoleCommand("_sendDarkRPvars")

		return
	end

	timer.Remove("DarkRPCheckifitcamethrough")
end)

timer.Remove("HintSystem_OpeningMenu")
timer.Remove("HintSystem_Annoy1")
timer.Remove("HintSystem_Annoy2")
RunConsoleCommand("cl_ejectbrass", 0)

DarkRPLoaded = DarkRPLoaded or true