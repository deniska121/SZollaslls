--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/language/sh_language.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local rp_languages = {}
local selectedLanguage = GetConVar("gmod_language"):GetString() -- Switch language by setting gmod_language to another language

function DarkRP.addLanguage(name, tbl)
	local old = rp_languages[name] or {}
	rp_languages[name] = tbl

	-- Merge the language with the translations added by DarkRP.addPhrase
	for k,v in pairs(old) do
		rp_languages[name][k] = v
	end
	LANGUAGE = rp_languages[name] -- backwards compatibility
end

function DarkRP.addPhrase(lang, name, phrase)
	rp_languages[lang] = rp_languages[lang]  or {}
	rp_languages[lang][name] = phrase
end

function DarkRP.getPhrase(name, ...)
	local langTable = rp_languages[selectedLanguage] or rp_languages.en

	if not langTable[name] then return name end

	return string.format(langTable[name] or rp_languages.en[name], ...)
end
