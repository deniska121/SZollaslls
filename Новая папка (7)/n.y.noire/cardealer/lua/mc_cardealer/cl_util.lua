--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/cardealer/lua/mc_cardealer/cl_util.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔══╗───╔╗╔══╗───────────╔╗──--
-- ║═╦╩╦╦╗║║║╔╗║╔═╦╦╦═╦╦═╦═╣╚╗─--
-- ║╔╣╬║╔╝║╚╣╠╣║║╬║╔╣╬╠╣╩╣═╣╔╣─--
-- ╚╝╚═╩╝─╚═╩╝╚╝║╔╩╝╚╦╝╠═╩═╩═╝─--
-- ─────────────╚╝───╚═╝───────--
-- ───── By Mactavish ─────────--
local ply = LocalPlayer()
local ScrW, ScrH = ScrW, ScrH
local NewFont = surface.CreateFont

NewFont("McCD.Sub1", {
	font = "mr_NeonAbsoluteSansG",
	extended = true,
	size = 62,
	antialias = true,
	weight = 800
})


function McCD.Blur(panel, inn, density, alpha, w, h)
	MSD.BlurPanel(panel, (3 / inn) * density, w, h, alpha)
end

function McCD.Underglow(ent, cl)
	if (not ent.neondata) then
		local center = ent:OBBCenter()
		local mins = ent:OBBMins()
		local maxs = ent:OBBMaxs()

		local s = mins.x > mins.y

		ent.neondata = {
			Vector(center.x, center.y, mins.z + 15),
			Vector(s and center.x or Lerp(0.5, mins.x, center.x), s and Lerp(0.5, mins.y, center.y) or center.y, mins.z + 15),
			Vector(s and center.x or Lerp(0.5, maxs.x, center.x), s and Lerp(0.5, maxs.y, center.y) or center.y, mins.z + 15),
		}

		ent.ndl = {}
	end

	for i, v in ipairs(ent.neondata) do
		if IsValid(ent.ndl[i]) then
			ent.ndl[i].pos = ent:LocalToWorld(v)
			ent.ndl[i].DieTime = CurTime() + 0.3
			continue
		end
		ent.ndl[i] = DynamicLight(512 + ent:EntIndex() + i)
		ent.ndl[i].pos = ent:LocalToWorld(v)
		ent.ndl[i].nomodel = true
		ent.ndl[i].brightness = 7
		ent.ndl[i].Decay = 1000
		ent.ndl[i].Size = 100
		ent.ndl[i].DieTime = CurTime()  + 0.3
		ent.ndl[i].r, ent.ndl[i].g, ent.ndl[i].b = cl.r, cl.g, cl.b
	end
end

function McCD.PlaySound(snd)
	if McCD.Sound then
		McCD.Sound:Stop()
	end

	McCD.Sound = nil
	McCD.Sound = CreateSound(ply, snd)
	McCD.Sound:PlayEx(0.3, 100)
end