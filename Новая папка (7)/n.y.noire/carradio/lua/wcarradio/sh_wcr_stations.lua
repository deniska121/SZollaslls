--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/carradio/lua/wcarradio/sh_wcr_stations.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

wyozicr.AllStations = {}

timer.Create("WyoziCR_UpdateStations", 1, 0, function()
	table.Empty(wyozicr.AllStations)

	if wyozicr.UseHomeKitStations and whk and whk.RadioStations then
		table.Add(wyozicr.AllStations, whk.RadioStations)
	else
		table.Add(wyozicr.AllStations, wyozicr.Stations)
	end

	local ctrls = ents.FindByClass("wdj_mastercontroller")
	table.sort(ctrls, function(a,b) return a:EntIndex() < b:EntIndex() end)

	for _,e in pairs(ctrls) do
		local name
		if e.GetChannelNameFormatted then
			name = e:GetChannelNameFormatted()
		else
			name = "Radio Ch. " .. e:GetChannel()
		end
		table.insert(wyozicr.AllStations, {
			Name = name,
			WDJ_Channel = e:GetChannel()
		})
	end
end)
