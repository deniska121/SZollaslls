--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/autorun/ppp_include/pill_birds.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

pk_pills.register("bird_crow", {
	printName = "Crow",
	side = "harmless",
	type = "ply",
	model = "models/crow.mdl",
	default_rp_cost = 1000,
	camera = {
		offset = Vector(0, 0, 5),
		dist = 40
	},
	hull = Vector(10, 10, 10),
	anims = {
		default = {
			idle = "Idle01",
			walk = "Walk",
			run = "Run",
			glide = "Soar",
			fly = "Fly01",
			eat = "Eat_A",
			jump = "Takeoff"
		}
	},
	moveSpeed = {
		walk = 15,
		run = 40
	},
	health = 20,
	moveMod = function(ply, ent, mv, cmd)
		if not ply:IsOnGround() then
			local angs = mv:GetAngles()

			if cmd:KeyDown(IN_JUMP) then
				angs.p = -30
				mv:SetVelocity(angs:Forward() * 300)

				if SERVER then
					ent:PillAnimTick("fly")
					ent:PillLoopSound("fly")
				end
			elseif cmd:KeyDown(IN_DUCK) then
				angs.p = 30
				mv:SetVelocity(angs:Forward() * 300)

				if SERVER then
					ent:PillAnimTick("fly")
				end
			else
				angs.p = 10
				mv:SetVelocity(angs:Forward() * 500)

				if SERVER then
					ent:PillLoopStop("fly")
				end
			end
		end
	end,
	land = function(ply, ent)
		ent:PillLoopStop("fly")
	end,
	sounds = {
		vocalize = pk_pills.helpers.makeList("npc/crow/alert#.wav", 2, 3),
		poop = pk_pills.helpers.makeList("npc/antlion/shell_impact#.wav", 1, 3),
		loop_fly = "npc/crow/flap2.wav"
	},
	attack = {
		mode = "trigger",
		func = function(ply, ent)
			ent:PillSound("vocalize")
		end
	},
	attack2 = {
		mode = "trigger",
		func = function(ply, ent)
			if ply:IsOnGround() then
				ent:PillAnim("eat", true)
				ent.EatPos = ent.EatPos or {}

				for k, v in pairs(GAMEMODE.Config.Trash) do
					if not DarkRP.InRangeVector(ply:GetPos(), v, 100) then continue end
					if ent.EatPos[k] and ent.EatPos[k] > CurTime() then return end
					ent.EatPos[k] = CurTime() + 120
					ply:AddEnergy(math.random(7, 9) * 10)
					ply:AddThirst(math.random(3, 5) * 10)

					return
				end

				local sp = ent:GetPos() + Vector(0, 0, 10)

				local trace = util.TraceHull({
					start = sp,
					endpos = sp + (ply:GetAimVector() * 100),
					filter = {ent, ply},
					mins = Vector(-10, -10, -10),
					maxs = Vector(10, 10, 10),
					mask = MASK_SHOT_HULL
				})

				if IsValid(trace.Entity) then
					local crabbed = trace.Entity

					if crabbed:GetClass() == "spawned_food" then
						crabbed:Use(ply, ent)
					end

					return
				end

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
			else
				if ply:Energy() < 30 then return end
				ply:TakeEnergy(30)
				util.Decal("BirdPoop", ply:GetPos(), ply:GetPos() - Vector(0, 0, 9999), ply)
				ent:PillSound("poop")
			end
		end
	}
})

pk_pills.register("bird_pigeon", {
	parent = "bird_crow",
	printName = "Pigeon",
	model = "models/pigeon.mdl",
	sounds = {
		vocalize = pk_pills.helpers.makeList("ambient/creatures/pigeon_idle#.wav", 4)
	}
})

pk_pills.register("bird_seagull", {
	parent = "bird_crow",
	printName = "Seagull",
	model = "models/seagull.mdl",
	sounds = {
		vocalize = pk_pills.helpers.makeList("ambient/creatures/seagull_idle#.wav", 3)
	},
	flapSoundPitch = 50,
	anims = {
		default = {
			fly = "Fly"
		}
	},
	health = 50
})