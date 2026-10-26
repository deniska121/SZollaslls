--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/chat/lua/autorun/sh_schat.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

SChat = SChat or {
	MAX_MESSAGE_LEN = 250,
	teamMode = 0,
	EVERYONE = 0,
	TEAM = 1,
	OOC = 2
}

-- You can override the 'CanSet' functions if you want.
-- Just make sure to do it both on SERVER and CLIENT
function SChat:CanSetServerTheme(ply)
	return ply:IsSuperAdmin()
end

function SChat:CanSetServerEmojis(ply)
	return ply:IsSuperAdmin()
end

function SChat.PrintF(str, ...)
	MsgC(Color(255, 60, 0), '[DarkRP] ', Color(235, 120, 26), string.format(str, ...), '\n')
end

-- trim functions and lookup table provided by EasyChat
local trim_lookup = {
	-- zero width chars
	[utf8.char(0x200b)] = '', -- ZERO WIDTH SPACE
	[utf8.char(0x200c)] = '', -- ZERO WIDTH NON JOINER
	[utf8.char(0x200d)] = '', -- ZERO WIDTH JOINER
	[utf8.char(0x2060)] = '', -- WORD JOINER
	-- spaces
	[utf8.char(0x00a0)] = ' ', -- NO BREAK SPACE
	[utf8.char(0x1680)] = '  ', -- OGHAM SPACE MARK
	[utf8.char(0x2000)] = '  ', -- EN QUAD
	[utf8.char(0x2001)] = '   ', -- EM QUAD
	[utf8.char(0x2002)] = '  ', -- EN SPACE
	[utf8.char(0x2003)] = '   ', -- EM SPACE
	[utf8.char(0x2004)] = ' ', -- THREE PER EM SPACE
	[utf8.char(0x2005)] = ' ', -- FOUR PER EM SPACE
	[utf8.char(0x2006)] = ' ', -- SIX PER EM SPACE
	[utf8.char(0x2007)] = '  ', -- FIGURE SPACE
	[utf8.char(0x2008)] = ' ', -- PUNCTUATION SPACE
	[utf8.char(0x2009)] = ' ', -- THIN SPACE
	[utf8.char(0x200a)] = ' ', -- HAIR SPACE
	[utf8.char(0x2028)] = '\n', -- LINE SEPARATOR
	[utf8.char(0x2029)] = '\n\n', -- PARAGRAPH SEPARATOR
	[utf8.char(0x202f)] = ' ', -- NARROW NO BREAK SPACE
	[utf8.char(0x205f)] = ' ', -- MEDIUM MATHEMATICAL SPACE
	[utf8.char(0x3000)] = '   ', -- IDEOGRAPHIC SPACE
	[utf8.char(0x03164)] = '  ', -- HANGUL FILLER
	[utf8.char(0x0e00aa)] = '', -- UNKNOWN CHAR MOST FONTS RENDER AS NOTHING
	[utf8.char(0x03)] = '^C', -- END OF TEXT
	[utf8.char(0x2067)] = '' -- Right-To-Left Isolate
}

function SChat.CleanupString(str)
	if not str then return '' end
	str = utf8.force(str)

	for unicode, replacement in pairs(trim_lookup) do
		str = str:gsub(unicode, replacement)
	end

	-- join multiple line breaks
	-- str = str:gsub('[\n]+', '\n')
	-- limit the number of line breaks
	local nBreaks = 0

	str = str:gsub('\n', function()
		nBreaks = nBreaks + 1

		if nBreaks > 10 then
			return ''
		else
			return '\n'
		end
	end)

	return str:Trim()
end

if SERVER then
	include('schat/sv_main.lua')
	AddCSLuaFile('schat/cl_js.lua')
	AddCSLuaFile('schat/cl_highlighter.lua')
	AddCSLuaFile('schat/cl_parser.lua')
	AddCSLuaFile('schat/cl_settings.lua')
	AddCSLuaFile('schat/cl_theme.lua')
	AddCSLuaFile('schat/cl_whitelist.lua')
	AddCSLuaFile('schat/cl_chatbox.lua')
	AddCSLuaFile('schat/cl_interface.lua')
end

if CLIENT then
	function SChat.InternalMessage(source, text)
		chat.AddText(color_white, '[', Color(243, 141, 7), source, color_white, '] ', text)
	end

	include('schat/cl_js.lua')
	include('schat/cl_highlighter.lua')
	include('schat/cl_parser.lua')
	include('schat/cl_settings.lua')
	include('schat/cl_theme.lua')
	include('schat/cl_whitelist.lua')
	include('schat/cl_chatbox.lua')
	include('schat/cl_interface.lua')
end