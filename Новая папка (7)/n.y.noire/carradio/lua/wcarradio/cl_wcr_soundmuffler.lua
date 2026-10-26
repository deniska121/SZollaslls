--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/carradio/lua/wcarradio/cl_wcr_soundmuffler.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


local wcr_mufflesounds = CreateConVar("wyozicr_mufflesounds", "1", FCVAR_ARCHIVE)

hook.Remove("Think", "WCR_SoundMuffler", function()
	-- VCMod exists, shouldn't use our own implementation
	local lveh = LocalPlayer():GetVehicle()

	local muffled = wyozicr.SoundMuffled

	-- Check if vehicle is valid and CarEntity is valid (ie. CarRadio UI is drawn for this vehicle)
	local shouldbemuffled = IsValid(lveh) and IsValid(lveh:WCR_GetCarEntity()) and wcr_mufflesounds:GetBool()

	if muffled ~= shouldbemuffled then
		LocalPlayer():SetDSP(shouldbemuffled and 31 or 0, false)
		wyozicr.SoundMuffled = shouldbemuffled
	end
end)
