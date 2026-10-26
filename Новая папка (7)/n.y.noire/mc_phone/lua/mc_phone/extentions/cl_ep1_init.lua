--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_phone/lua/mc_phone/extentions/cl_ep1_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local ply = LocalPlayer()

if timer.Exists("McPhone.SignalChange") then
	timer.Remove("McPhone.SignalChange")
end

timer.Create("McPhone.SignalChange.CL", 1, 0, function()
	local newsignal = McPhone.SignalStrength or 0
	if McPhone.Signal == newsignal then return end

	if McPhone.Signal > newsignal then
		McPhone.Signal = McPhone.Signal - 1
	else
		McPhone.Signal = McPhone.Signal + 1
	end
end)

local zonecl = {Color(0, 0, 0, 55), Color(0, 0, 175, 55), Color(0, 175, 0, 55), Color(175, 0, 0, 55),}

hook.Add("PostDrawTranslucentRenderables", "McPhone.SignalDebug", function()
	local max_dd = McPhone.Config.TowerMaxRange ^ 2

	if McPhone.Config.ShowZones and ply:IsSuperAdmin() then
		for k, v in pairs(ents.FindByClass("mc_antenna")) do
			if v:GetDestroyed() then continue end
			if v:GetPos():DistToSqr(ply:GetPos()) > max_dd * 2 then continue end
			render.SetColorMaterial()
			render.DrawSphere(v:GetPos(), McPhone.Config.TowerMaxRange, 30, 30, zonecl[1])
			render.DrawSphere(v:GetPos(), -McPhone.Config.TowerMaxRange, 30, 30, zonecl[4])
			if v:GetPos():DistToSqr(ply:GetPos()) > max_dd then continue end
			render.DrawSphere(v:GetPos(), McPhone.Config.TowerMaxRange / 3, 30, 30, zonecl[1])
			render.DrawSphere(v:GetPos(), -McPhone.Config.TowerMaxRange / 3, 30, 30, zonecl[2])
			render.DrawSphere(v:GetPos(), McPhone.Config.TowerMaxRange / 3 * 2, 30, 30, zonecl[1])
			render.DrawSphere(v:GetPos(), -McPhone.Config.TowerMaxRange / 3 * 2, 30, 30, zonecl[3])
		end

		for k, v in pairs(ents.FindByClass("mc_jammer")) do
			if not v:GetActive() then continue end
			if v:GetPos():DistToSqr(ply:GetPos()) > max_dd / 3 then continue end
			render.SetColorMaterial()
			render.DrawSphere(v:GetPos(), McPhone.Config.JammerRange, 30, 30, zonecl[1])
			render.DrawSphere(v:GetPos(), -McPhone.Config.JammerRange, 30, 30, zonecl[1])
		end
	end
end)

net.Receive("McPhone.SignalChange", function()
	local signal = net.ReadInt(3)
	McPhone.SignalStrength = math.Clamp(signal, 0, 3)

	if McPhone.SignalStrength == 0 then
		McPhone.UpdateWeb()
	end
end)

net.Receive("McPhone.NoSignal", function()
	McPhone.CallNoSignal()
end)

hook.Add("MCR.OnSelect", "SendMessage", function(c_id)
	McPhone.GetContacts()
	McPhone.GetSMS()

	if c_id ~= 3 then return end
	local sms = LocalPlayer():GetPData("dezzintro", 0)

	if sms == 0 then
		timer.Simple(math.random(3) * 10, function()
			McPhone.SendSMS("Дилер Дезз", [[Йоу. Как и договаривались: с меня устройство, с тебя результаты. Будет что 'интересное' - звони, номер уже в контактах. К телефону не привязывайся.]])
		end)
		LocalPlayer():SetPData("dezzintro", 1)
	end
end)