--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/territory/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

CURRENT_TERRITORY = nil

timer.Create("terrtitoryThink", 1, 0, function()

	if not (IsValid(LocalPlayer()) and LocalPlayer():Alive()) then return end

	if CURRENT_TERRITORY then
		if not CURRENT_TERRITORY:IsInside(LocalPlayer()) then
			net.SendSingleMessage("territoryExit")
			if CURRENT_TERRITORY.onExitCL then
				CURRENT_TERRITORY.onExitCL(CURRENT_TERRITORY)
			end
			CURRENT_TERRITORY = nil
		end
	else
		for _, territory in pairs(Territories.list) do
			if territory:IsInside(LocalPlayer()) then
				CURRENT_TERRITORY = territory
				net.Start("territoryEnter")
				net.WriteString(territory.name)
				net.SendToServer()
				if territory.onEnterCL then
					territory.onEnterCL(territory)
				end
				break
			end
		end
	end
end)