--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/carradio/lua/wcarradio/sh_wcr_config.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- List of car models in which carradio is disabled
wyozicr.DisabledModels = {"path/to/carmodel.mdl"}

-- Whether we should override stations below with Wyozi Home Kit: Media Pack stations, if they exist
wyozicr.UseHomeKitStations = true

-- List of stations. See below for instructions
wyozicr.Stations = {
	{
		Name = "First Amendment Tracks",
		Link = "http://194.67.93.33:8010/radio.mp3",
		Icon = "https://macnco.one/cityrp/radio/com/1.png"
	},
	{
		Name = "Outlet Forkers FM",
		Link = "http://194.67.93.33:8020/radio.mp3",
		Icon = "https://macnco.one/cityrp/radio/com/2.png"
	},
	{
		Name = "Let's Rock New York",
		Link = "http://194.67.93.33:8030/radio.mp3",
		Icon = "https://macnco.one/cityrp/radio/com/3.png"
	},
	{
		Name = "Neonlight 98.3",
		Link = "http://194.67.93.33:8050/radio.mp3",
		Icon = "https://macnco.one/cityrp/radio/com/4.png"
	},
	{
		Name = "Protospective",
		Link = "http://194.67.93.33:8040/radio.mp3",
		Icon = "https://macnco.one/cityrp/radio/com/5.png"
	},
	{
		Name = "Noire.FM",
		Link = "http://194.67.93.33:8000/radio.mp3",
		Icon = "https://macnco.one/cityrp/radio/com/6.png"
	},
	{
		Name = "RedNeck Voice",
		Link = "http://194.67.93.33:8060/radio.mp3",
		Icon = "https://macnco.one/cityrp/radio/com/7.png"
	},
}