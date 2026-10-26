--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/sh_net.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Glac.NetName = "Glac.Net"

local MESSAGES = {
	"Sync",				-- credit balance
	"Buy",				-- string item key, int(10) menu hue
	"BuyReward",		-- uint(8) episode, uint(8) reward index
	"CheckDonations",	-- claim paid donations
	"Credits",			-- int(32) balance
	"Result",			-- uint(2) Glac.RESULT_*, then the item (see cl_glac.lua)
	"CaseOpen",			-- int(10) menu hue; the drop follows as a Result
	"Suit",				-- uint(32) item, string part, int(10) hue
	"Reload",			-- rebuild items after a server-side reload
}

local BITS = 4
assert(#MESSAGES < 2 ^ BITS, "[Glac] too many net messages for " .. BITS .. " bits")

Glac.RESULT_FAIL = 1
Glac.RESULT_ITEM = 2
Glac.RESULT_REWARD = 3

Glac.NetIds = {}

for id, name in ipairs(MESSAGES) do
	Glac.NetIds[name] = id
end

Glac.NetHandlers = Glac.NetHandlers or {}

if SERVER then
	util.AddNetworkString(Glac.NetName)
end

function Glac.NetStart(name)
	net.Start(Glac.NetName)
	net.WriteUInt(Glac.NetIds[name], BITS)
end

function Glac.NetReceive(name, fn)
	Glac.NetHandlers[Glac.NetIds[name]] = fn
end

net.Receive(Glac.NetName, function(len, ply)
	local handler = Glac.NetHandlers[net.ReadUInt(BITS)]

	if handler then
		handler(ply, len)
	end
end)
