--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/shared/networking.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if SERVER then util.AddNetworkString("Slawer.Mayor") util.AddNetworkString("MayourAnsw") end

CreateConVar( "bill_board_1", "", FCVAR_REPLICATED)
CreateConVar( "bill_board_2", "", FCVAR_REPLICATED)
CreateConVar( "bill_board_3", "", FCVAR_REPLICATED)

Slawer.Mayor.NetsList = Slawer.Mayor.NetsList or {}

function Slawer.Mayor:NetReceive(strName, fnCallback)
	Slawer.Mayor.NetsList[strName] = fnCallback
end

function Slawer.Mayor:NetStart(strName, tblToSend, pTo)
	net.Start("Slawer.Mayor")
		net.WriteString(strName)
		if tblToSend then
			net.WriteBool(true)
			local cd, bn = DarkRP.TableCompress(tblToSend)
			net.WriteInt(bn, 32)
			net.WriteData(cd, bn)
		else
			net.WriteBool(false)
		end

	if SERVER then
		if pTo then
			net.Send(pTo)
		else
			net.Broadcast()
		end
	else
		net.SendToServer()
	end
end

net.Receive("Slawer.Mayor", function(_, pSender)
	if SERVER then
		if pSender.lastMayorNetSent and pSender.lastMayorNetSent > CurTime() then return end
		pSender.lastMayorNetSent = CurTime() + 0.2
	end
	local strName = net.ReadString()
	local tblToSend = {}
	if net.ReadBool() then
		local bytes_number = net.ReadInt(32)
		local compressed_data = net.ReadData(bytes_number)
		tblToSend = DarkRP.TableDecompress(compressed_data)
	end
	if !Slawer.Mayor.NetsList[strName] then return end
	if SERVER then
		Slawer.Mayor.NetsList[strName](pSender, tblToSend)
	else
		Slawer.Mayor.NetsList[strName](tblToSend)
	end
end)