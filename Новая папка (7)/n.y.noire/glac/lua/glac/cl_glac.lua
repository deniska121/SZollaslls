--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/cl_glac.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Glac.Credits = Glac.Credits or 0

function Glac.Buy(key, hue)
	Glac.NetStart("Buy")
	net.WriteString(key)
	net.WriteInt(hue or 100, 10)
	net.SendToServer()
end

function Glac.BuyReward(episode, index)
	Glac.NetStart("BuyReward")
	net.WriteUInt(episode, 8)
	net.WriteUInt(index, 8)
	net.SendToServer()
end

function Glac.CheckDonations()
	Glac.NetStart("CheckDonations")
	net.SendToServer()
end

Glac.NetReceive("Credits", function()
	Glac.Credits = net.ReadInt(32)
end)

Glac.NetReceive("Result", function()
	local res = {success = net.ReadUInt(2)}

	if res.success == Glac.RESULT_ITEM then
		res.item = net.ReadString()
		res.hsl = net.ReadInt(10)
	elseif res.success == Glac.RESULT_REWARD then
		res.episode = net.ReadUInt(8)
		res.item = net.ReadUInt(8)
		res.hsl = net.ReadInt(10)
	end

	hook.Run("Glac.Result", res)
end)

Glac.NetReceive("Suit", function()
	local item = net.ReadUInt(32)
	local part = net.ReadString()
	local hue = net.ReadInt(10)

	hook.Run("Glac.Result", {suit = true, item = item, part = part, hsl = hue})
end)

Glac.NetReceive("CaseOpen", function()
	hook.Run("Glac.CaseOpen", net.ReadInt(10))
end)

Glac.NetReceive("Reload", function()
	Glac.Rebuild()
end)

hook.Add("InitPostEntity", "Glac.Sync", function()
	Glac.NetStart("Sync")
	net.SendToServer()
end)
