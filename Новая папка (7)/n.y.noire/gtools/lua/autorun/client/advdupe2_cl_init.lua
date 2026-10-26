--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/autorun/client/advdupe2_cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AdvDupe2 = {
	Version = "1.1.0",
	Revision = 51,
	InfoText = {},
	DataFolder = "advdupe2",
	FileRenameTryLimit = 256,
	ProgressBar = {}
}

if(!file.Exists(AdvDupe2.DataFolder, "DATA"))then
	file.CreateDir(AdvDupe2.DataFolder)
end

include "advdupe2/file_browser.lua"
include "advdupe2/sh_codec.lua"
include "advdupe2/cl_file.lua"
include "advdupe2/cl_ghost.lua"

function AdvDupe2.Notify(msg,typ,dur)
	surface.PlaySound(typ == 1 and "buttons/button10.wav" or "ambient/water/drip1.wav")
	GAMEMODE:AddNotify(msg, typ or NOTIFY_GENERIC, dur or 5)
	//if not game.SinglePlayer() then
		print("[AdvDupe2Notify]\t"..msg)
	//end
end

net.Receive("AdvDupe2Notify", function()
	AdvDupe2.Notify(net.ReadString(), net.ReadUInt(8), net.ReadFloat())
end)
