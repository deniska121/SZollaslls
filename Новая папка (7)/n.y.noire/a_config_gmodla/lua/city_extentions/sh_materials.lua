--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/a_config_gmodla/lua/city_extentions/sh_materials.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

SW = SW or {}

local replace_mats = {
	["tools/toolsnodraw"] = "phoenix_storms/trains/track_plateside",
	["unioncity/misc/pd_wallsticker"] = "replace/pdsticker2",
	["unioncity2/decals/courtstuff"] = "replace/courtstuff",
	["models/uc2/propper/gas_station_logo"] = "replace/gas_station_logo",
	["models/uc2/propper/gas_station_prices"] = "replace/gas_station_prices",
	["models/uc2/props_rooftop/billboard_a"] = "replace/billboard_a",
	["models/uc2/props_rooftop/billboard_b"] = "replace/billboard_b",
	["models/uc2/props_rooftop/billboard_e"] = "replace/billboard_e",
	["models/uc2/props_rooftop/billboard_c"] = "replace/billboard_c",
	["models/uc2/props_rooftop/billboard_h"] = "replace/billboard_h",
	["models/uc2/props_rooftop/billboard_g"] = "replace/billboard_g",
	["models/uc2/props_rooftop/billboard_f"] = "replace/billboard_f",
	["models/uc2/props_fastfood/kitchen03"] = "replace/kitchen03",
	["models/uc2/props_stores/magazinerack"] = "gbskins/magazinerack",
	["models/uc2/propper/votebane"] = "replace/votebane",
	["models/uc2/propper/standingbill02"] = "replace/standingbill02",
	["models/props/commercial/cigarettedisplay"] = "replace/cigarettedisplay",
	["models/noirrebuild/signimpound/impoundsign"] = "replace/impoundsign",
	["models/props_stores/candyboxes"] = "replace/candyboxes",
	--fall
	["models/uc2/props_skybox/distanttrees"] = "replace/fall/distanttrees",
	["models/uc2/props_skybox/treelinedistant"] = "replace/fall/treelinedistant",
	["models/uc2/propper/treeline_a"] = "replace/fall/treeline_a",
	["models/uc2/props_skybox/treeline_a"] = "replace/fall/treeline_a",
	["models/uc2/props_foliage/oaktreeleaves_d"] = "replace/fall/oaktreeleaves_d",
	["models/uc2/props_foliage/bush02"] = "replace/fall/bush02",
	["models/uc2/props_skybox/grass"] = "replace/fall/grass",
	["unioncity2/floors/grass"] = "replace/fall/grass",
	["unioncity2/floors/parkcobbles"] = "replace/fall/grass",
	["unioncity2/floors/parkdirttograss"] = "unioncity2/floors/dirt",
	["models/uc2/propper/hedgerow"] = "replace/fall/hedgerow",
	["models/uc2/propper/bush01"] = "replace/fall/hedgerow",
}

--["unioncity2/floors/townhousepath"] = "replace/wet/floors/townhousepath",
local second_mats = {
	["unioncity2/floors/parkdirttograss"] = "replace/fall/grass",
}

local trees = {Vector(-6794.435546875, -1266.505859375, -102.90075683594), Vector(-5781.611328125, -1252.1987304688, -56.75212097168), Vector(-4949.7470703125, -1192.6088867188, 38.681243896484), Vector(-5238.15234375, 138.9867401123, 75.373947143555), Vector(-5234.306640625, 467.54547119141, 41.512252807617), Vector(-5241.3510742188, 846.90832519531, 57.905242919922), Vector(-5254.7993164063, 1483.6329345703, 87.265464782715), Vector(-6199.5771484375, 2004.5756835938, 61.313140869141), Vector(-7943.2260742188, 2616.2211914063, 60.365295410156), Vector(-8023.1206054688, 3125.904296875, 50.004531860352), Vector(-8034.4477539063, 3447.2429199219, 108.19229125977), Vector(-9807.701171875, 2494.6435546875, 125.37826538086), Vector(-4832.2666015625, 2788.8161621094, 101.1775894165), Vector(-3843.3947753906, 2836.8073730469, 52.282775878906), Vector(-3171.8173828125, 2882.0534667969, 35.854248046875), Vector(-3582.9912109375, 4228.7172851563, 25.561664581299), Vector(-3101.9799804688, 4244.1879882813, 30.977638244629), Vector(-1904.5756835938, 4222.0502929688, -2.1727066040039), Vector(-3970.4477539063, 5616.80859375, 197.99488830566), Vector(-344.57565307617, 4217.822265625, -3.8909120559692), Vector(731.85772705078, 4987.2670898438, 81.340629577637), Vector(779.81433105469, 5900.7216796875, 111.02507781982), Vector(28.799411773682, 6922.0380859375, 186.13285827637), Vector(1076.0715332031, 6924.9287109375, 151.83958435059), Vector(1927.5316162109, 5229.5717773438, 135.94567871094), Vector(2403.4321289063, 4188.6674804688, 31.787868499756), Vector(3672.2077636719, 3580.5756835938, 47.676246643066), Vector(4135.6254882813, 4980.5166015625, 56.93034362793), Vector(4234.6455078125, 3147.298828125, 57.673622131348), Vector(5747.4243164063, 4230.1020507813, 23.727458953857), Vector(5898.3872070313, 4690.701171875, 65.092781066895), Vector(6732.0649414063, 3380.3642578125, 59.310249328613), Vector(6075.4243164063, 2421.2888183594, -25.998983383179), Vector(5211.2255859375, 1958.240234375, 20.752338409424), Vector(5462.349609375, 1144.185546875, -5.1855010986328), Vector(4730.1376953125, -281.84091186523, 19.37645149231), Vector(4357.9145507813, -335.22381591797, 2.4012041091919), Vector(3664.5522460938, -972.79412841797, 26.328586578369), Vector(4853.8666992188, -2077.0109863281, 92.859878540039), Vector(7583.998046875, 127.42877197266, 32.985668182373), Vector(8062.322265625, 2035.0325927734, 19.674713134766), Vector(5731.1899414063, -3868.4372558594, -104.49028015137), Vector(4584.1420898438, -3602.5812988281, -101.22208404541), Vector(2449.3913574219, -3640.9157714844, -153.32946777344), Vector(1925.6939697266, -2352.8532714844, -2.5722208023071), Vector(961.60632324219, -2238.591796875, -27.492052078247), Vector(-1018.4306640625, -3656.2287597656, -159.34170532227), Vector(-4564.0600585938, -3372.4851074219, -159.53590393066), Vector(-3431.0031738281, -2332.970703125, 39.686416625977), Vector(-3493.2263183594, -280.18579101563, -3.701048374176), Vector(-3254.8325195313, 612.20935058594, 43.46212387085), Vector(-2200.5756835938, 1837.5034179688, 5.5734901428223), Vector(-1849.9633789063, 445.99261474609, 15.347137451172), Vector(-1850.1118164063, 83.4267578125, 31.764427185059), Vector(805.9052734375, -1222.6628417969, 7.0378818511963), Vector(947.02410888672, -2216.6240234375, -14.732201099396), Vector(2111.12109375, -1160.2342529297, 10.855436325073), Vector(2453.8576660156, -280.77456665039, -1.8443698883057), Vector(2323.6079101563, 275.93438720703, 30.347099304199), Vector(1880.8978271484, 281.93630981445, 34.736339569092), Vector(1015.5313110352, 303.83837890625, 56.174591064453), Vector(1028.9799804688, 590.65106201172, 46.104568481445), Vector(1025.3041992188, 1007.9343261719, 58.075912475586), Vector(1870.9963378906, 1022.7716064453, 32.615688323975), Vector(2327.3757324219, 1054.4478759766, 39.586921691895), Vector(2423.1303710938, 2033.8341064453, -1.7094354629517), Vector(844.57580566406, 2027.4340820313, -5.5348434448242), Vector(2441.2985839844, 2508.8076171875, 25.631851196289), Vector(2454.6423339844, 2952.0634765625, 66.016845703125), Vector(3443.0163574219, 5919.9584960938, 121.00256347656), Vector(5715.4243164063, 5900.4116210938, 227.66593933105), Vector(8871.423828125, 5946.5727539063, 115.46038818359), Vector(9141.904296875, 5701.9780273438, 124.4174041748), Vector(8881.46875, 5180.5756835938, 87.35457611084), Vector(5283.12890625, 8968.6953125, 230.12573242188), Vector(5963.6098632813, 9829.12109375, 234.85307312012), Vector(3499.3210449219, 8988.5751953125, 225.93254089355), Vector(3594.5773925781, 8505.9150390625, 252.19143676758), Vector(4213.5053710938, 9882.302734375, 272.55023193359), Vector(3182.060546875, 9914.869140625, 281.3772277832), Vector(2663.4243164063, 8116.18359375, 173.86032104492), Vector(1847.4963378906, 8032.7353515625, 229.79476928711), Vector(2059.638671875, 7163.1303710938, 139.40487670898), Vector(-977.38159179688, 7815.814453125, 162.73745727539), Vector(-1935.3756103516, 7611.6411132813, 235.82312011719), Vector(-1963.1380615234, 8059.88671875, 222.00857543945), Vector(-1929.8244628906, 8618.6513671875, 241.42286682129), Vector(-3139.5913085938, 8630.9541015625, 218.4453125), Vector(-3155.9885253906, 8079.4365234375, 237.92121887207), Vector(-3791.9672851563, 7997.6508789063, 246.39166259766), Vector(-3303.2026367188, 7499.8930664063, 243.49630737305), Vector(-3960.4448242188, 9929.1865234375, 295.92202758789), Vector(-3968.9033203125, 10452.974609375, 337.86672973633), Vector(-2564.5869140625, 9880.5625, 237.93280029297), Vector(-2014.6732177734, 9883.9208984375, 246.17135620117), Vector(-1440.3865966797, 9861.037109375, 232.25030517578), Vector(-268.330078125, 9890.6259765625, 206.47175598145), Vector(-254.44895935059, 10443.010742188, 247.07965087891), Vector(165.82382202148, 11028.37890625, 247.42895507813), Vector(203.53558349609, 11783.55859375, 230.20208740234), Vector(884.42407226563, 11708.599609375, 225.67544555664), Vector(1419.7069091797, 11686.186523438, 276.78671264648), Vector(1748.2891845703, 11117.263671875, 207.17526245117), Vector(239.96038818359, 8980.5751953125, 217.46797180176), Vector(505.10076904297, 8704.21875, 257.50451660156), Vector(-448.6330871582, 7674.794921875, 254.06860351563), Vector(2983.5212402344, 10946.918945313, 255.16775512695), Vector(3368.1088867188, 11099.655273438, 257.66659545898), Vector(-449.79577636719, 13992.262695313, 268.96536254883), Vector(-1467.9143066406, 12962.549804688, 256.12982177734), Vector(-2526.8127441406, 12967.994140625, 223.20581054688), Vector(-1434.2907714844, 11230.16796875, 213.95355224609), Vector(-2404.701171875, 11212.897460938, 235.61206054688), Vector(-4123.1420898438, 11789.6953125, 259.45034790039), Vector(-5163.8852539063, 11770.463867188, 269.7737121582), Vector(-6315.4282226563, 11792.48046875, 266.75662231445), Vector(-6939.0571289063, 11244.905273438, 271.03225708008), Vector(-6966.8823242188, 13439.051757813, 265.52285766602), Vector(-6391.673828125, 13030.890625, 269.13717651367), Vector(-5200.5205078125, 12998.173828125, 270.84524536133), Vector(-4198.2890625, 13013.723632813, 269.41186523438), Vector(-3744.701171875, 13518.020507813, 244.00630187988), Vector(-8575.96875, -1021.3597412109, 277.14083862305), Vector(-13989.73828125, -9514.6669921875, -54.641399383545), Vector(-13544.779296875, -9442.9921875, -57.093360900879), Vector(-13247.096679688, -11058.01953125, -97.248291015625), Vector(-12355.07421875, -10657.551757813, -133.93780517578), Vector(-11505.90625, -10638.01953125, -155.35279846191), Vector(-11440.34375, -9364.322265625, -194.36712646484), Vector(-12423.671875, -9293.578125, -198.52880859375), Vector(-14620.483398438, -11247.96875, 232.76644897461)}

local pos0 = Vector(-13267.506835938, -10751.491210938, 145.5347442627)
local color_mats = {}

local mod_mat = {
	["unioncity2/floors/checkered_floor"] = function(mat)
		mat = Material(mat)
		mat:SetVector("$reflectivity", Vector(1, 1, 1))
	end
}

SW.Leaves = SW.Leaves or {}
SW.Sound = nil
SW.VolumeMultiplier = 1
SW.SoundVolume = 0
SW.SkyboxVisible = false
SW.IsOutsideFrame = false
SW.Frame = 0

if CLIENT then
	local CubemapMats
	local rot = 0

	local function ChangeSkyTexture(skybox)
		CubemapMats = {Material(skybox .. "ft"), Material(skybox .. "rt"), Material(skybox .. "bk"), Material(skybox .. "lf"), Material(skybox .. "up"), Material(skybox .. "dn"),}

		local rt = GetRenderTarget("skybox_foggation_renderation", ScrW(), ScrH())
		render.PushRenderTarget(rt)
		render.Clear(0, 0, 0, 0)
		cam.Start2D()
		surface.SetDrawColor(255, 255, 255, 255)
		surface.SetMaterial(CubemapMats[1])
		surface.DrawTexturedRect(0, 0, ScrW() * 0.25, ScrH())
		surface.SetMaterial(CubemapMats[2])
		surface.DrawTexturedRect(ScrW() * 0.25, 0, ScrW() * 0.25, ScrH())
		surface.SetMaterial(CubemapMats[3])
		surface.DrawTexturedRect(ScrW() * 0.5, 0, ScrW() * 0.25, ScrH())
		surface.SetMaterial(CubemapMats[4])
		surface.DrawTexturedRect(ScrW() * 0.75, 0, ScrW() * 0.25, ScrH())
		cam.End2D()
		render.CapturePixels()
		render.PopRenderTarget()
	end

	local sblist = {
		{"skybox/sky_fema_hdr", -130},
		{"skybox/sky_benzyn_hdr", 0},
		{"skybox/sky_day03_04_hdr", 45},
		{"skybox/sky_day01_01_hdr", -60},
		{"skybox/sky_day02_06_hdr", 160},
		{"skybox/sky_day02_07_hdr", 210},
	}

	local size = 16
	local matr = Matrix()
	local sky = 1
	local rainfx = false

	local function RaplaceTextures()
		for k, v in pairs(mod_mat) do
			v(k)
		end

		for k, v in pairs(replace_mats) do
			local mat = Material(k)
			mat:SetTexture("$basetexture", v)

			if second_mats[k] then
				mat:SetTexture("$basetexture2", second_mats[k] or "")
			end

			if color_mats[k] then
				mat:SetVector("$color2", color_mats[k])
			end
		end

		sky = GetGlobalVar("Sky_Box", 1)

		if sky > 0 and sblist[sky] then
			ChangeSkyTexture(sblist[sky][1])
			rot = sblist[sky][2]
		end
	end

	if GAMEMODE then
		RaplaceTextures()
	end

	hook.Add("InitPostEntity", "second_mats_replacer", function()
		RaplaceTextures()

		timer.Simple(10, function()
			RaplaceTextures()
		end)

		timer.Simple(60, function()
			RaplaceTextures()
		end)
	end)

	hook.Add("PostDraw2DSkyBox", "SkyRandomizer", function()
		if not CubemapMats then return end
		matr:SetAngles(Angle(0, rot, 0))
		matr:SetTranslation(EyePos())
		cam.Start3D(EyePos(), RenderAngles())
		cam.PushModelMatrix(matr)
		render.OverrideDepthEnable(false, true)
		render.SetMaterial(CubemapMats[1])
		render.DrawQuadEasy(Vector(1, 0, 0) * size, Vector(-1, 0, 0), size * 2, size * 2, color_white, 180)
		render.SetMaterial(CubemapMats[4])
		render.DrawQuadEasy(Vector(0, -1, 0) * size, Vector(0, 1, 0), size * 2, size * 2, color_white, 180)
		render.SetMaterial(CubemapMats[3])
		render.DrawQuadEasy(Vector(-1, 0, 0) * size, Vector(1, 0, 0), size * 2, size * 2, color_white, 180)
		render.SetMaterial(CubemapMats[2])
		render.DrawQuadEasy(Vector(0, 1, 0) * size, Vector(0, -1, 0), size * 2, size * 2, color_white, 180)
		render.SetMaterial(CubemapMats[5])
		render.DrawQuadEasy(Vector(0, 0, 1) * size, Vector(0, 0, -1), size * 2, size * 2, color_white, 270)
		render.SetMaterial(CubemapMats[6])
		render.DrawQuadEasy(Vector(0, 0, -1) * size, Vector(0, 0, 1), size * 2, size * 2, color_white, 90)
		render.OverrideDepthEnable(false, false)
		cam.PopModelMatrix()
		cam.End3D()
	end)

	local skyeffects = {
		[1] = function()
			DrawBloom(0, 0.12, 5, 11.28, 2, 3.27, 1, 1, 1)
		end,
		[2] = function()
			DrawBloom(0, 0.17, 3.6, 1.8, 1, 1.32, 0.9, 0.57, 0.01)
		end,
	}

	hook.Add("RenderScreenspaceEffects", "SkyRandomizer", function()
		if skyeffects[sky] then
			skyeffects[sky]()
		end
	end)

	CreateClientConVar("fall_rain", "1", true, false)
	CreateClientConVar("fall_maxleaves", "3", true, false)
	CreateClientConVar("fall_timer", "10", true, false)

	net.Receive("S2C_Union_Spawn", function()
		local lply = LocalPlayer()
		if not IsValid(lply) or not GetConVar("fall_rain"):GetBool() then return end

		for i = 1, 5 do
			ParticleEffect("rain_player", lply:GetPos(), Angle(0, 0, 0), lply)
		end
	end)

	timer.Create("FallEffect", GetConVar("fall_timer"):GetInt(), 0, function()
		if not IsValid(LocalPlayer()) or not IsValid(LocalPlayer():GetViewEntity()) then return end

		if game.GetMap() == "rp_southside" then
			timer.Remove("FallEffect")

			return
		end

		local emiting_pos = {}
		local limit = math.Clamp(GetConVar("fall_maxleaves"):GetInt() or 1, 1, 10)
		local vp = LocalPlayer():GetViewEntity():GetPos()

		for _, v in ipairs(trees) do
			if DarkRP.InRangeVector(vp, v, 1200) then
				table.insert(emiting_pos, v + Vector(0, 0, 120))
				if #emiting_pos >= limit then break end
			end
		end

		if SW.Leaves[limit] then
			for i, v in ipairs(emiting_pos) do
				if not IsValid(SW.Leaves[i]) then continue end
				SW.Leaves[i]:SetControlPoint(0, v)
				SW.Leaves[i]:SetControlPointOrientation(0, Angle(90, 90, 90))
			end

			return
		end

		for i = 1, limit do
			if SW.Leaves[i] then
				SW.Leaves[i]:StopEmission(false, true)
			end

			SW.Leaves[i] = CreateParticleSystemNoEntity("[3]leaves_env", emiting_pos[i] and emiting_pos[i] or pos0, Angle(0, math.random(180), 0))
		end
	end)

	timer.Remove("PlayerBreath", 5, 0, function()
		for _, ent in ipairs(player.GetAll()) do
			if not IsValid(ent) or not DarkRP.InRange(ent, LocalPlayer(), 300) then return end

			timer.Simple(math.Rand(0, 2), function()
				if not IsValid(ent) or not ent:Alive() or ent:getDarkRPVar("unconscious") or ent:WaterLevel() > 0 or not DarkRP.IsOutside(ent:GetPos()) then return end
				if ent:GetMoveType() == MOVETYPE_NOCLIP or IsValid(ent.pk_pill_ent) then return end
				local i = ent:LookupAttachment("mouth")
				if not i then return end
				local att = ent:GetAttachment(i)
				if not att then return end
				local pos, ang = att.Pos, att.Ang

				if not ent.hookah_ef then
					ent.hookah_ef = ParticleEmitter(ent:GetPos())
				end

				if ent.hookah_ef then
					local particle = ent.hookah_ef:Add("particle/particle_smokegrenade", pos)
					particle:SetVelocity(ang:Forward() * 5)
					particle:SetDieTime(math.Rand(2, 3))
					particle:SetStartAlpha(77)
					particle:SetEndAlpha(0)
					particle:SetColor(255, 255, 255)
					particle:SetStartSize(math.random(1, 2))
					particle:SetEndSize(math.random(3, 6))
					particle:SetRoll(math.Rand(0, 360))
					particle:SetAirResistance(90)
					particle:SetGravity(VectorRand() * 2 + ang:Forward() * math.random(3, 5))
				end
			end)
		end
	end)

	local fog = 155

	hook.Add("SetupWorldFog", "SW.SetupWorldFog", function()
		if not rainfx or (CURRENT_TERRITORY and CURRENT_TERRITORY.nozone) then return end
		render.FogMode(MATERIAL_FOG_LINEAR)
		-- render.FogStart(100)
		-- render.FogEnd(5250)
		render.FogStart(0)
		render.FogEnd(3250)
		render.FogMaxDensity(.3)
		render.FogColor(fog, fog, fog)

		return true
	end)

	hook.Add("SetupSkyboxFog", "SW.SetupSkyboxFog", function()
		if not rainfx or (CURRENT_TERRITORY and CURRENT_TERRITORY.nozone) then return end
		render.FogMode(MATERIAL_FOG_LINEAR)
		render.FogStart(0)
		--render.FogEnd(300)
		render.FogEnd(1)
		render.FogMaxDensity(.3)
		render.FogColor(fog, fog, fog)

		return true
	end)
end