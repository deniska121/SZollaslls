--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/health/lua/mc_haes/core/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function MES.OpenMenuCheck()
	if IsValid(MSD.RadialMenu) then return end
	MSD.RadialMenu = vgui.Create("MSD.RadialMenu")

	local panel = MSD.RadialMenu
	panel:SetSize(700, 700)
	panel:MakePopup()
	panel:Center()

	panel.KeyThink = function()
		if input.IsMouseDown(MOUSE_RIGHT) then
			panel.Close()
		end
	end

	panel.Close = function()
		MSD.RadialMenu:Remove()
		MSD.RadialMenu = nil
		MSD.PlaySnd("msd/ui/click.wav")
	end

	panel.Page = {}

	panel.OpenPage = function(id)
		page = panel.Page[id]
		if not page then return end
		MSD.PlaySnd("msd/ui/toggle.wav")
		panel.actions = page
		panel:Build()
	end

	panel.Page["main"] = {}

	for k, v in pairs(MES.List) do
		table.insert(panel.Page["main"], {
			v[2], function()
				RunConsoleCommand("mes.check", k)
				panel.Close()
			end
		})
	end

	panel.OpenPage("main")
end

function MES.OpenMenuApply()
	if IsValid(MSD.RadialMenu) then return end
	MSD.RadialMenu = vgui.Create("MSD.RadialMenu")

	local panel = MSD.RadialMenu
	panel:SetSize(700, 700)
	panel:MakePopup()
	panel:Center()
	panel.inittime = CurTime() + 1

	panel.KeyThink = function()
		if panel.inittime < CurTime() and input.IsMouseDown(MOUSE_RIGHT) then
			panel.Close()
		end
	end

	panel.Close = function()
		MSD.RadialMenu:Remove()
		MSD.RadialMenu = nil
		surface.PlaySound("piemenu_select.wav")
	end

	panel.Page = {}

	panel.OpenPage = function(id)
		page = panel.Page[id]
		if not page then return end
		surface.PlaySound("piemenu_open.wav")
		panel.actions = page
		panel:Build()
	end

	panel.Page["main"] = {}

	for k, v in pairs(MES.ListHeal) do
		if MES.ListHealRest[k] and (LocalPlayer():Team() ~= 13 or MRS.GetPlyRank(LocalPlayer(), "FDNY") < 3) then continue end
		table.insert(panel.Page["main"], {
			v[1], function()
				RunConsoleCommand("mes.apply", k)
				panel.Close()
			end
		})
	end

	panel.OpenPage("main")
end

local inprogress = false

local sw, sh = ScrW(), ScrH()
local w, h = sw / 6, sh / 12
local x, y = sw / 2 - w / 2, sh / 2 + h * 2

local dx, dy, dw, dh, pp, pos, tm

local am = Material("gmodla/hud/hudarrow.png", "smooth")

local pat = {
	Color(228,112,45),
	Color(175,49,49),
	Color(63,72,80,255),
	Color(0,0,0,148),
}

local alt = {
	Color(175,49,49),
	Color(228,112,45),
	Color(175,49,49),
	Color(0,0,0,148),
}

local cls = table.Copy(pat)

--Obtained values
local sp = 2
local ps = 2
local hold
local tmr = 0.5
local stm = 0
local trms = 0

hook.Add("DrawOverlay", "SkillCheck", function()
	if not inprogress then return end

	tm = math.Clamp(((stm + trms) - CurTime()) / tmr, 0, 1)
	surface.SetDrawColor(cls[3])
	surface.DrawOutlinedRect(x - 2, y - 2, w + 4, h + 4, 2)
	surface.DrawOutlinedRect(x - 2, y - h / 3 - 2, w + 4, h / 3, 2)
	MSDX.Draw(0, x, y - h / 3, w, h / 3 - 4, cls[4])
	MSDX.Draw(0, x, y - h / 3, w * tm, h / 3 - 4, cls[1])

	for i = 0, 19 do
		dx, dy, dw, dh = x + i * (w / 20), y, w / 20, h
		local cl = cls[2]

		if (i >= sp - 1 and i < sp) and LocalPlayer():getDarkRPVar("energy") > 250 then
			cl = cls[3]
		end

		MSDX.Draw(0, dx, dy, dw, dh, (i >= sp and i < sp + ps) and cls[1] or cl)

		surface.SetDrawColor(cls[4])
		surface.DrawOutlinedRect(dx, dy, dw, dh, 1)
	end
	pp = dw * 3

	if not hold or not pos then
		pos = (1 - math.cos(CurTime() * 4)) / 2
	end

	MSD.DrawTexturedRect(x + (w * pos) - pp / 2, y + h - pp / 4, pp, pp, am, color_white)

	if tm <= 0 then
		inprogress = nil
	end
end)

local lcc = 0

hook.Add("PlayerBindPress", "SkillCheck", function(ply, bind)
	if not inprogress then return end

	if ( string.find( bind, "attack" ) ) then
		if lcc < CurTime() then
			lcc = CurTime() + 0.2
			hold = true
			net.Start("SC.Noire")
				net.WriteFloat(pos)
				net.WriteFloat(CurTime())
			net.SendToServer()
		end

		return true
	end
end)

net.Receive("SC.Noire", function()
	local typ = net.ReadUInt(2)

	if typ == 1 then
		inprogress = nil
		return
	end

	if typ == 0 then
		inprogress = true
		sp = net.ReadUInt(5)
		ps = net.ReadUInt(5)
		tmr = net.ReadUInt(12)
		stm = net.ReadFloat()

		trms = tmr
		hold = nil
		if net.ReadBool() then
			cls = table.Copy(alt)
		else
			cls = table.Copy(pat)
		end
	end
end)