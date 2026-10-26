--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/autorun/ppp_include/pill_headcrabs.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

local toilet = {
	[1] = Vector(-6136.0146484375, 13928.130859375, 172.45172119141),
	[2] = Vector(-5110.8784179688, 14016.465820313, 180.45172119141),
	[3] = Vector(-4087.9367675781, 14015.051757813, 180.45172119141),
	[4] = Vector(-2438.0886230469, 13856.71484375, 180.45172119141),
	[5] = Vector(-1415.4426269531, 13856.012695313, 180.45172119141),
	[6] = Vector(718.79321289063, 11321.15625, 180.45172119141),
	[7] = Vector(4034.8383789063, 10760.841796875, 212.45172119141),
	[8] = Vector(-4277.8940429688, 10782.7578125, 180.45172119141),
	[9] = Vector(-5304.9331054688, 10783.198242188, 180.45172119141),
	[10] = Vector(-6135.626953125, 10776.732421875, 172.45172119141),
	[11] = Vector(4647.4453125, 8028.142578125, 156.45172119141),
	[12] = Vector(4726.5698242188, 8027.3100585938, 156.45172119141),
	[13] = Vector(4803.2133789063, 8027.9311523438, 156.45172119141),
	[14] = Vector(8929.71875, 9384.0634765625, 216.68353271484),
	[15] = Vector(8930.5263671875, 9150.8828125, 216.68353271484),
	[16] = Vector(8931.279296875, 8921.166015625, 216.68353271484),
	[17] = Vector(9407.3916015625, 8918.578125, 216.68353271484),
	[18] = Vector(9404.923828125, 9150.5537109375, 216.68353271484),
	[19] = Vector(9406.9990234375, 9381.03515625, 216.68353271484),
	[20] = Vector(7217.9194335938, 5697.0361328125, 236.45172119141),
	[21] = Vector(7623.4033203125, 1959.7012939453, 780.45172119141),
	[22] = Vector(7158.8354492188, 438.92547607422, 780.45172119141),
	[23] = Vector(7221.6196289063, 1753.9948730469, 460.45172119141),
	[24] = Vector(7361.7260742188, 2298.5666503906, 460.45172119141),
	[25] = Vector(7362.27734375, 2298.033203125, 140.45170593262),
	[26] = Vector(7219.3759765625, 1754.8186035156, 141.6220703125),
	[27] = Vector(6080.2036132813, -4375.4272460938, -291.54827880859),
	[28] = Vector(2086.5747070313, 2573.4260253906, 708.99072265625),
	[29] = Vector(1928.5198974609, 3386.9895019531, 708.45172119141),
	[30] = Vector(1016.4685668945, 3301.5500488281, 708.99072265625),
	[31] = Vector(920.51385498047, 2571.3857421875, 708.99072265625),
	[32] = Vector(919.73223876953, 2572.6918945313, 444.99072265625),
	[33] = Vector(1015.9801635742, 3301.3081054688, 444.99072265625),
	[34] = Vector(1928.4039306641, 3386.3469238281, 444.45172119141),
	[35] = Vector(2087.6848144531, 2570.0825195313, 444.99072265625),
	[36] = Vector(2088.4641113281, 2571.8039550781, 180.45172119141),
	[37] = Vector(1927.0350341797, 3386.1586914063, 180.45172119141),
	[38] = Vector(1015.4360351563, 3300.5703125, 180.45172119141),
	[39] = Vector(918.55285644531, 2571.6245117188, 180.45172119141),
	[40] = Vector(1102.3162841797, 4647.4594726563, 572.45172119141),
	[41] = Vector(1145.384765625, 5213.6186523438, 572.45172119141),
	[42] = Vector(1143.3690185547, 5213.0014648438, 404.45172119141),
	[43] = Vector(1103.1502685547, 4648.9604492188, 404.20172119141),
	[44] = Vector(1103.0747070313, 4648.044921875, 235.95172119141),
	[45] = Vector(1143.7193603516, 5213.2587890625, 236.45172119141),
	[46] = Vector(1144.0098876953, 5212.67578125, 68.451713562012),
	[47] = Vector(1104.0660400391, 4648.2163085938, 67.951713562012),
	[48] = Vector(-3065.3864746094, 858.75305175781, -83.548286437988),
	[49] = Vector(-3892.1904296875, 1737.0059814453, -83.548278808594),
	[50] = Vector(-4276.5185546875, 1736.220703125, -83.548278808594),
	[51] = Vector(-4658.7763671875, 1736.1779785156, -83.548286437988),
	[52] = Vector(-4793.1245117188, 1736.2794189453, -83.548286437988),
	[53] = Vector(-4792.9028320313, 1737.9124755859, 92.451721191406),
	[54] = Vector(-4659.6665039063, 1737.4798583984, 92.451721191406),
	[55] = Vector(-4277.3671875, 1737.6881103516, 92.451705932617),
	[56] = Vector(-3892.7294921875, 1736.6743164063, 92.451721191406),
	[57] = Vector(-3064.7038574219, 857.67797851563, 92.451721191406),
	[58] = Vector(-7159.9775390625, 7189.708984375, 12.451713562012),
	[59] = Vector(-7159.8447265625, 7269.765625, 12.451721191406),
	[60] = Vector(-7161.4697265625, 7347.955078125, 12.451713562012),
	[61] = Vector(-8229.0537109375, 7348.4560546875, 12.451721191406),
	[62] = Vector(-8230.3720703125, 7268.5205078125, 12.451721191406),
	[63] = Vector(-8228.787109375, 7188.376953125, 12.451721191406),
	[64] = Vector(-11812.520507813, -10427.543945313, -238.91021728516),
	[65] = Vector(-11896.287109375, -10428.830078125, -238.91020202637),
	[66] = Vector(-11731.899414063, -10428.6875, -238.91023254395)
}

local pipes = {
	[1] = Vector(4295.4038085938, 7062.3686523438, -289.96875),
	[2] = Vector(2823.7644042969, 5320.2583007813, -473.96875),
	[3] = Vector(-3247.0314941406, 6023.7573242188, -369.96875),
	[4] = Vector(-1118.6304931641, 4032.900390625, -473.96875),
	[5] = Vector(-2562.1662597656, 1008.8309936523, -521.96875),
	[6] = Vector(708.58581542969, 2399.5383300781, -521.96875),
	[7] = Vector(4222.3647460938, 1921.5355224609, -521.96875),
	[8] = Vector(4412.4775390625, 2609.470703125, -521.96875),
	[9] = Vector(3346.1235351563, 4033.6467285156, -473.96875)
}

pk_pills.register("rat", {
	printName = "Rat",
	side = "harmless",
	type = "ply",
	model = "models/rat.mdl",
	default_rp_cost = 6000,
	camera = {
		offset = Vector(0, 0, 5),
		dist = 40
	},
	hull = Vector(10, 10, 10),
	anims = {
		default = {
			idle = "lookaround",
			walk = "run1",
			attack = "attack",
			swim = "drown",
			eat = "idle01",
		}
	},
	sounds = {
		bite = pk_pills.helpers.makeList("rat/rat_bite_0#.wav", 3),
		eat = pk_pills.helpers.makeList("rat/rat_idle_0#.wav", 3),
		water = pk_pills.helpers.makeList("ambient/water/water_splash#.wav", 3)
	},
	moveSpeed = {
		walk = 100,
		run = 300
	},
	jumpPower = 250,
	jump = function(ply, ent)
	end,
	attack = {
		mode = "trigger",
		func = function(ply, ent)
			local CT = CurTime()
			if (ent.delay and ent.delay > CT) then return end
			ent.delay = CT + 1

			ent:PillAnim("attack", true)
			ent:PillSound("bite")

			-- local trace = util.TraceLine({
			-- 	start = ply:EyePos(),
			-- 	endpos = ply:EyePos() + ply:EyeAngles():Forward() * 10,
			-- 	filter = {ent, ply}
			-- })

			local sp = ent:GetPos() + Vector(0,0,10)
			local trace = util.TraceHull( {
				start = sp,
				endpos = sp + ( ply:GetAimVector() * 100 ),
				filter = {ent, ply},
				mins = Vector( -10, -10, -10 ),
				maxs = Vector( 10, 10, 10 ),
				mask = MASK_SHOT_HULL
			} )

			if IsValid(trace.Entity) then
				local crabbed = trace.Entity

				if crabbed:GetClass() == "spawned_food" then
					crabbed:Use(ply, ent)
				else
					if ply:Thirst() > 5 then
						ply:TakeThirst(5, true)
					else
						return
					end
					crabbed:TakeDamage(ent.formTable.biteDmg, ply, ply)
				end

				ent.canBite = nil
			end
		end
	},
	attack2 = {
		mode = "trigger",
		func = function(ply, ent)

			local CT = CurTime()
			if (ent.tpdelay and ent.tpdelay > CT) then return end
			ent.tpdelay = CT + 5

			ent:PillAnim("eat", true)
			ent:PillSound("eat")
			ent.EatPos = ent.EatPos or {}

			if ply:IsOnGround() and ply:Energy() >= 100 and ply:Health() < 20 then
				ply:TakeEnergy(100)

				timer.Simple(3, function()
					if not IsValid(ent) then return end

					if ply:Health() < 10 then
						ply:SetHealth(10)
					end
				end)

				timer.Simple(5, function()
					if not IsValid(ent) then return end
					ply:SetHealth(20)
				end)
				return
			end

			-- if ply.currentTerritory and ply.currentTerritory.name == "underground" then
			-- 	ply:AddThirst(20)
			-- end

			--for k,v in pairs(GAMEMODE.Config.Trash) do
				--if not DarkRP.InRangeVector(ply:GetPos(), v, 100) then continue end
				--if ent.EatPos[k] and ent.EatPos[k] > CurTime() then return end
				--ent.EatPos[k] = CurTime() + 120
				ply:AddEnergy(math.random(7,9) * 5)
				ply:AddThirst(math.random(3,5) * 5)
				--return
			--end

			for k,v in pairs(pipes) do
				if not DarkRP.InRangeVector(ply:GetPos(), v, 30) then continue end
				local rand = toilet[math.random(#toilet)]

				local ef = EffectData()
				ef:SetOrigin( ply:GetPos() )
				util.Effect( "gunshotsplash", ef )

				ply:SetPos(rand + Vector(0,0,20))
				ent:PillSound("water")

				return
			end

			for k,v in pairs(toilet) do
				if not DarkRP.InRangeVector(ply:GetPos(), v, 30) then continue end
				local rand = pipes[math.random(#pipes)]

				local ef = EffectData()
				ef:SetOrigin( ply:GetPos() )
				util.Effect( "gunshotsplash", ef )

				ply:SetPos(rand + Vector(0,0,30))
				ent:PillSound("water")
				return
			end
		end
	},
	glideThink = function(ply, ent)
	end,
	land = function(ply, ent)
		ent.canBite = nil
	end,
	biteDmg = 5,
	health = 20
})

pk_pills.register("rato", {
	parent = "rat",
	printName = "Rato",
	skin = 1,
	model = "models/rat.mdl",
})