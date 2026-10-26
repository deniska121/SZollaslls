--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/weapons/gmod_tool/stool.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ToolObj = {}
include("ghostentity.lua")
include("object.lua")

if (CLIENT) then
	include("stool_cl.lua")
end

function ToolObj:Create()
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.Mode = nil
	o.SWEP = nil
	o.Owner = nil
	o.ClientConVar = {}
	o.ServerConVar = {}
	o.Objects = {}
	o.Stage = 0
	o.Message = "start"
	o.LastMessage = 0
	o.AllowedCVar = 0

	return o
end

function ToolObj:CreateConVars()
	local mode = self:GetMode()

	if (CLIENT) then
		for cvar, default in pairs(self.ClientConVar) do
			CreateClientConVar(mode .. "_" .. cvar, default, true, true)
		end

		return
	end

	-- Note: I changed this from replicated because replicated convars don't work
	-- when they're created via Lua.
	if (SERVER) then
		self.AllowedCVar = CreateConVar("toolmode_allow_" .. mode, 1, FCVAR_NOTIFY)

		for cvar, default in pairs(self.ServerConVar) do
			CreateConVar(mode .. "_" .. cvar, default, FCVAR_ARCHIVE)
		end
	end
end

function ToolObj:GetServerInfo(property)
	local mode = self:GetMode()

	return GetConVarString(mode .. "_" .. property)
end

function ToolObj:BuildConVarList()
	local mode = self:GetMode()
	local convars = {}

	for k, v in pairs(self.ClientConVar) do
		convars[mode .. "_" .. k] = v
	end

	return convars
end

function ToolObj:GetClientInfo(property)
	return self:GetOwner():GetInfo(self:GetMode() .. "_" .. property)
end

function ToolObj:GetClientNumber(property, default)
	return self:GetOwner():GetInfoNum(self:GetMode() .. "_" .. property, tonumber(default) or 0)
end

function ToolObj:Allowed()
	if (CLIENT) then return true end

	return self.AllowedCVar:GetBool()
end

-- Now for all the ToolObj redirects
function ToolObj:Init()
end

function ToolObj:GetMode()
	return self.Mode
end

function ToolObj:GetSWEP()
	return self.SWEP
end

function ToolObj:GetOwner()
	return self:GetSWEP().Owner or self.Owner
end

function ToolObj:GetWeapon()
	return self:GetSWEP().Weapon or self.Weapon
end

function ToolObj:LeftClick()
	return false
end

function ToolObj:RightClick()
	return false
end

function ToolObj:Reload()
	self:ClearObjects()
end

function ToolObj:Deploy()
	self:ReleaseGhostEntity()

	return
end

function ToolObj:Holster()
	self:ReleaseGhostEntity()

	return
end

function ToolObj:Think()
	self:ReleaseGhostEntity()
end

--[[---------------------------------------------------------
	Checks the objects before any action is taken
	This is to make sure that the entities haven't been removed
-----------------------------------------------------------]]
function ToolObj:CheckObjects()
	for k, v in pairs(self.Objects) do
		if (not v.Ent:IsWorld() and not v.Ent:IsValid()) then
			self:ClearObjects()
		end
	end
end

local toolmodes = file.Find(SWEP.Folder .. "/stools/*.lua", "LUA")

for key, val in pairs(toolmodes) do
	local _, _, toolmode = string.find(val, "([%w_]*).lua")
	TOOL = ToolObj:Create()
	TOOL.Mode = toolmode
	AddCSLuaFile("stools/" .. val)
	include("stools/" .. val)
	TOOL:CreateConVars()
	SWEP.Tool[toolmode] = TOOL
	TOOL = nil
end

ToolObj = nil
if (SERVER) then return end
-- Keep the tool list handy
local TOOLS_LIST = SWEP.Tool

local allowed_tool = {
	["advdupe2"] = true,
	["remover"] = true,
	["stacker"] = true,
	["weld"] = true,
	["ledscreen"] = true,
	["shopscreen"] = true,
	["submaterial"] = true,
	["shareprops"] = true,
	["anydoor"] = true,
	["nocollide"] = true,
	["colour"] = true,
	["button"] = true,
	["precision"] = true,
	["nlight"] = true
}

-- Add the STOOLS to the tool menu
hook.Add("PopulateToolMenu", "AddSToolsToMenu", function()
	local permisson = sAdmin.hasPermission(LocalPlayer(), "propspawn")
	for ToolName, TOOL in pairs(TOOLS_LIST) do
		if not permisson and not allowed_tool[ToolName] then continue end

		local cat = TOOL.Category or "New Category"

		if not permisson then cat = "Инструменты" end

		if (TOOL.AddToMenu ~= false) then
			spawnmenu.AddToolMenuOption(TOOL.Tab or "Main", cat, ToolName, TOOL.Name or "#" .. ToolName, TOOL.Command or "gmod_tool " .. ToolName, TOOL.ConfigName or ToolName, TOOL.BuildCPanel)
		end
	end

	hook.Remove("PreDrawHalos", "PropertiesHover")
end)

--
-- Search
--
search.AddProvider(function(str)
	local list = {}

	for k, v in pairs(TOOLS_LIST) do
		local niceName = v.Name or "#" .. k

		if (niceName:StartWith("#")) then
			niceName = language.GetPhrase(niceName:sub(2))
		end

		if (not k:lower():find(str, nil, true) and not niceName:lower():find(str, nil, true)) then continue end

		local entry = {
			text = niceName,
			icon = spawnmenu.CreateContentIcon("tool", nil, {
				spawnname = k,
				nicename = v.Name or "#" .. k
			}),
			words = {k}
		}

		table.insert(list, entry)
		if (#list >= GetConVarNumber("sbox_search_maxresults") / 32) then break end
	end

	return list
end)

--
-- Tool spawnmenu icon
--
spawnmenu.AddContentType("tool", function(container, obj)
	if (not obj.spawnname) then return end
	local icon = vgui.Create("ContentIcon", container)
	icon:SetContentType("tool")
	icon:SetSpawnName(obj.spawnname)
	icon:SetName(obj.nicename or "#tool." .. obj.spawnname .. ".name")
	icon:SetMaterial("gui/tool.png")

	icon.DoClick = function()
		spawnmenu.ActivateTool(obj.spawnname)
		surface.PlaySound("ui/buttonclickrelease.wav")
	end

	icon.OpenMenu = function(icon)
		-- Do not allow removal from read only panels
		if (IsValid(icon:GetParent()) and icon:GetParent().GetReadOnly and icon:GetParent():GetReadOnly()) then return end
		local menu = DermaMenu()

		menu:AddOption("#spawnmenu.menu.delete", function()
			icon:Remove()
			hook.Run("SpawnlistContentChanged")
		end):SetIcon("icon16/bin_closed.png")

		menu:Open()
	end

	if (IsValid(container)) then
		container:Add(icon)
	end

	return icon
end)