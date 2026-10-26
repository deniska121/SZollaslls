--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/language/sh_interface.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DarkRP.addLanguage = DarkRP.stub{
	name = "addLanguage",
	description = "Create a language/translation.",
	parameters = {
		{
			name = "Language name",
			description = "The short name of the language (\"en\" is English). Make sure the language name fits a possible value for gmod_language!",
			type = "string",
			optional = false
		},
		{
			name = "Language contents",
			description = "A table that contains the translation sentences. Look at sh_english.lua for an example.",
			type = "table",
			optional = false
		}
	},
	returns = {
	},
	metatable = DarkRP
}

DarkRP.addPhrase = DarkRP.stub{
	name = "addPhrase",
	description = "Add a phrase to the existing translation",
	parameters = {
		{
			name = "Language name",
			description = "The short name of the language (\"en\" is English). Make sure the language name fits a possible value for gmod_language!",
			type = "string",
			optional = false
		},
		{
			name = "key",
			description = "The name of the translated phrase.",
			type = "string",
			optional = false
		},
		{
			name = "translation",
			description = "The translation of the phrase.",
			type = "string",
			optional = false
		}
	},
	returns = {
	},
	metatable = DarkRP
}

DarkRP.getPhrase = DarkRP.stub{
	name = "getPhrase",
	description = "Get a phrase from the selected language",
	parameters = {
		{
			name = "key",
			description = "The name of the translated phrase.",
			type = "string",
			optional = false
		},
		{
			name = "Phrase parameters",
			description = "Some phrases need extra information, like in \"PLAYERNAME just won the lottery!\". Not filling in the phrase parameters will cause errors",
			type = "vararg",
			optional = false
		}
	},
	returns = {
		{
			name = "phrase",
			description = "The formatted phrase.",
			type = "string"
		}
	},
	metatable = DarkRP
}
