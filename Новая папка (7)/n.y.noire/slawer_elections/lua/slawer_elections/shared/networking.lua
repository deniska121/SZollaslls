--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_elections/lua/slawer_elections/shared/networking.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if SERVER then
	util.AddNetworkString("Slawer.Elections")
end

Slawer.Elections.NetsList = Slawer.Elections.NetsList or {}

function Slawer.Elections:NetReceive(strName, fnCallback)
	Slawer.Elections.NetsList[strName] = fnCallback
end

function Slawer.Elections:NetStart(strName, tblToSend, pTo)
	local tbl, iLen = Slawer.Elections:Compress(tblToSend)
	net.Start("Slawer.Elections")
	net.WriteString(strName)
	net.WriteUInt(iLen, 32)
	net.WriteData(tbl, iLen)

	if SERVER then
		if pTo and IsValid(pTo) then
			net.Send(pTo)
		else
			net.Broadcast()
		end
	else
		net.SendToServer()
	end
end

net.Receive("Slawer.Elections", function(_, pSender)
	local strName = net.ReadString()
	if not Slawer.Elections.NetsList[strName] then return end

	-- net delay
	if SERVER then
		pSender.SlawerElectionsNets = pSender.SlawerElectionsNets or {}
		if (pSender.SlawerElectionsNets[strName] or 0) > CurTime() then return end
		pSender.SlawerElectionsNets[strName] = CurTime() + 0.1
	end

	local iLen = net.ReadUInt(32)
	local tCompressed = net.ReadData(iLen)
	local tblToSend = Slawer.Elections:Decompress(tCompressed)

	if SERVER then
		Slawer.Elections.NetsList[strName](pSender, tblToSend)
	else
		Slawer.Elections.NetsList[strName](tblToSend)
	end
end)