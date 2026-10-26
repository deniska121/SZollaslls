--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/autorun/slawer_mayor.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Slawer = Slawer or {}
Slawer.Mayor = Slawer.Mayor or {}
Slawer.Mayor.CFG = Slawer.Mayor.CFG or {}
Slawer.Mayor.Lang = Slawer.Mayor.Lang or {}

local strMainDir = "slawer_mayor/"

local function loadDirectory( strDir, strFileType )
    local tblFiles = file.Find( strMainDir .. strDir .. "*", "LUA" )

    for k, v in pairs( tblFiles ) do
        if strFileType == "server" then
            if SERVER then include( strMainDir .. strDir .. v ) end
        elseif strFileType == "client" then
            if SERVER then
                AddCSLuaFile( strMainDir .. strDir .. v )
            else
                include( strMainDir .. strDir .. v )
            end
        elseif strFileType == "shared" then
            if SERVER then AddCSLuaFile( strMainDir .. strDir .. v ) end
            include( strMainDir .. strDir .. v )
        end
    end
end

loadDirectory( "", "shared" )

function Slawer.Mayor:L(strTag)
    return Slawer.Mayor.Lang[Slawer.Mayor.CFG.Language][strTag] or strTag
end

loadDirectory( "shared/", "shared" )
loadDirectory( "languages/", "shared" )
loadDirectory( "client/", "client" )
loadDirectory( "client/vgui/", "client" )
loadDirectory( "client/vgui/elements/", "client" )
loadDirectory( "server/", "server" )

local _, tblDirs = file.Find(strMainDir .. "modules/*", "LUA")

for k, v in pairs(tblDirs) do
    if Slawer.Mayor.CFG.DisabledModules[v] then continue end

    for Fk, Fv in pairs(file.Find(strMainDir .. "modules/" .. v .. "/*", "LUA")) do
        local strFileDir = strMainDir .. "modules/" .. v .. "/" .. Fv
        if string.StartWith(Fv, "sv") then
            if SERVER then include( strFileDir ) end
        elseif string.StartWith(Fv, "cl") then
            if SERVER then
                AddCSLuaFile( strFileDir )
            else
                include( strFileDir )
            end
        elseif string.StartWith(Fv, "sh") then
            if SERVER then AddCSLuaFile( strFileDir ) end
            include( strFileDir )
        end
    end
end