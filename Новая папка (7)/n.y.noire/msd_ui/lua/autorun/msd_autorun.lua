--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/autorun/msd_autorun.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ┏━┓┏━┳━━━┳━━━┓───────────────────────
-- ┃┃┗┛┃┃┏━┓┣┓┏┓┃───────────────────────
-- ┃┏┓┏┓┃┗━━┓┃┃┃┃──By MacTavish <3──────
-- ┃┃┃┃┃┣━━┓┃┃┃┃┃───────────────────────
-- ┃┃┃┃┃┃┗━┛┣┛┗┛┃───────────────────────
-- ┗┛┗┛┗┻━━━┻━━━┛───────────────────────

-- MIT License

-- Copyright (c) 2021 Ayden Mactavish

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

if MSD and MSD.Version ~= "1.0.3" then MsgC( Color(255, 8, 0), "[MSD] Another version of MSD detacted\n" ) return end

MSD = {}
MSD.Version = "1.0.3"
MSD.Config = {}
MSD.Modules = {}
MSD.AdminModules = {}
MSD.ModuleIds = {}
MSD.Language = {}

if SERVER then
	util.AddNetworkString( "MSD.GetConfigData" )
	util.AddNetworkString( "MSD.SaveConfig" )
end

function MSD.Load()
	MsgC( Color(174, 0, 255), "[MSD] Initialization started\n" )
	if !file.Exists("msd_data", "DATA") then
		file.CreateDir("msd_data")
		MsgC( Color(174, 0, 255), "[MSD] Server DATA Dir created \n" )
	end

	MsgC( Color(174, 0, 255), "[MSD] Initialization started\n" )

	if SERVER then
		include("msd/sh_config.lua")
		include("msd/sh_language.lua")
		AddCSLuaFile("msd/sh_config.lua")
		AddCSLuaFile("msd/sh_language.lua")

		local f = file.Find( "msd/ui/*", "LUA" )
		for k,v in ipairs( f ) do
			AddCSLuaFile( "msd/ui/" .. v )
		end

	else
		include("msd/sh_config.lua")
		include("msd/sh_language.lua")
		MSDX = include("msd/ui/rndx.lua")

		local f = file.Find( "msd/ui/*", "LUA" )
		for k,v in ipairs( f ) do
			if v ~= "rndx.lua" then
				include( "msd/ui/" .. v )
			end
		end

		list.Set( "DesktopWindows", "MSDModulesSetup", {
			title		= "Настройки",
			icon		= "cyberhud/mac_n_co.png",
			width		= 960,
			height		= 700,
			onewindow	= true,
			init		= function( icon, window )
				window:Close()
				icon.Window = MSD.OpenMenuManager(g_ContextMenu)
			end
		} )

		list.Set( "DesktopWindows", "MSDAdminMenu", {
			title		= "Панель MM",
			icon		= "cyberhud/guard.png",
			width		= 960,
			height		= 700,
			onewindow	= true,
			init		= function( icon, window )
				window:Close()
				icon.Window = MSD.OpenAdminMenu(g_ContextMenu)
			end
		} )
	end

	MsgC( Color(174, 0, 255), "[MSD] Initialization done\n" )
end

MSD.Load()