--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/simfphys/client/lighting.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- local mat = Material("sprites/light_ignorez")
-- local mat2 = Material("sprites/light_glow02_add_noz")

-- if file.Exists("materials/sprites/glow_headlight_ignorez.vmt", "GAME") then
-- 	mat2 = Material("sprites/glow_headlight_ignorez")
-- end

local function bc(ent)
	return ent:GetBattery() > 15
end

local mat2 = Material("l4d/corona")
local mat = Material("l4d/corona")
local SpritesDisabled = false
local FrontProjectedLights = true
local RearProjectedLights = true
local Shadows = false
local vtable = istable(vtable) and vtable or {}

cvars.AddChangeCallback("noire_car_hidesprites", function(convar, oldValue, newValue)
	SpritesDisabled = (tonumber(newValue) ~= 0)
end)

cvars.AddChangeCallback("noire_car_frontlamps", function(convar, oldValue, newValue)
	FrontProjectedLights = (tonumber(newValue) ~= 0)
end)

cvars.AddChangeCallback("noire_car_rearlamps", function(convar, oldValue, newValue)
	RearProjectedLights = (tonumber(newValue) ~= 0)
end)

cvars.AddChangeCallback("noire_car_shadows", function(convar, oldValue, newValue)
	Shadows = (tonumber(newValue) ~= 0)
end)

SpritesDisabled = GetConVar("noire_car_hidesprites"):GetBool()
FrontProjectedLights = GetConVar("noire_car_frontlamps"):GetBool()
RearProjectedLights = GetConVar("noire_car_rearlamps"):GetBool()
Shadows = GetConVar("noire_car_shadows"):GetBool()

local function BodyGroupIsValid(bodygroups, entity)
	for index, groups in pairs(bodygroups) do
		local mygroup = entity:GetBodygroup(index)

		for g_index = 1, table.Count(groups) do
			if (mygroup == groups[g_index]) then return true end
		end
	end

	return false
end

local function UpdateSubMats(ent, Lowbeam, Highbeam, IsBraking, IsReversing)
	if not istable(ent.SubMaterials) then return end

	if ent.SubMaterials.turnsignals then
		local IsTurningLeft = ent.signal_left and bc(ent)
		local IsTurningRight = ent.signal_right and bc(ent)
		local IsFlashing = ent:GetFlasher() == 1

		if ent.WasTurningLeft ~= IsTurningLeft or ent.WasTurningRight ~= IsTurningRight or ent.WasFlashing ~= IsFlashing then
			if ent.SubMaterials.turnsignals.left then
				for k, v in pairs(ent.SubMaterials.turnsignals.left) do
					local smat = (IsFlashing and IsTurningLeft) and v or ""
					ent:SetSubMaterial(k, smat)
				end
			end

			if ent.SubMaterials.turnsignals.right then
				for k, v in pairs(ent.SubMaterials.turnsignals.right) do
					local smat = (IsFlashing and IsTurningRight) and v or ""
					ent:SetSubMaterial(k, smat)
				end
			end

			ent.WasTurningLeft = IsTurningLeft
			ent.WasTurningRight = IsTurningRight
			ent.WasFlashing = IsFlashing
		end
	end

	if ent.WasReversing == IsReversing and ent.WasBraking == IsBraking and ent.WasLowbeam == Lowbeam and ent.WasHighbeam == Highbeam then return end

	if Lowbeam then
		if Highbeam then
			if ent.SubMaterials.on_highbeam then
				if not IsReversing and not IsBraking then
					if ent.SubMaterials.on_highbeam.Base then
						for k, v in pairs(ent.SubMaterials.on_highbeam.Base) do
							ent:SetSubMaterial(k, v)
						end
					end
				elseif IsBraking then
					if IsReversing then
						if ent.SubMaterials.on_highbeam.Brake_Reverse then
							for k, v in pairs(ent.SubMaterials.on_highbeam.Brake_Reverse) do
								ent:SetSubMaterial(k, v)
							end
						end
					else
						if ent.SubMaterials.on_highbeam.Brake then
							for k, v in pairs(ent.SubMaterials.on_highbeam.Brake) do
								ent:SetSubMaterial(k, v)
							end
						end
					end
				else
					if ent.SubMaterials.on_highbeam.Reverse then
						for k, v in pairs(ent.SubMaterials.on_highbeam.Reverse) do
							ent:SetSubMaterial(k, v)
						end
					end
				end
			end
		else
			if ent.SubMaterials.on_lowbeam then
				if not IsReversing and not IsBraking then
					if ent.SubMaterials.on_lowbeam.Base then
						for k, v in pairs(ent.SubMaterials.on_lowbeam.Base) do
							ent:SetSubMaterial(k, v)
						end
					end
				elseif IsBraking then
					if IsReversing then
						if ent.SubMaterials.on_lowbeam.Brake_Reverse then
							for k, v in pairs(ent.SubMaterials.on_lowbeam.Brake_Reverse) do
								ent:SetSubMaterial(k, v)
							end
						end
					else
						if ent.SubMaterials.on_lowbeam.Brake then
							for k, v in pairs(ent.SubMaterials.on_lowbeam.Brake) do
								ent:SetSubMaterial(k, v)
							end
						end
					end
				else
					if ent.SubMaterials.on_lowbeam.Reverse then
						for k, v in pairs(ent.SubMaterials.on_lowbeam.Reverse) do
							ent:SetSubMaterial(k, v)
						end
					end
				end
			end
		end
	else
		if ent.SubMaterials.off then
			if not IsReversing and not IsBraking then
				if ent.SubMaterials.off.Base then
					for k, v in pairs(ent.SubMaterials.off.Base) do
						ent:SetSubMaterial(k, v)
					end
				end
			elseif IsBraking then
				if IsReversing then
					if ent.SubMaterials.off.Brake_Reverse then
						for k, v in pairs(ent.SubMaterials.off.Brake_Reverse) do
							ent:SetSubMaterial(k, v)
						end
					end
				else
					if ent.SubMaterials.off.Brake then
						for k, v in pairs(ent.SubMaterials.off.Brake) do
							ent:SetSubMaterial(k, v)
						end
					end
				end
			else
				if ent.SubMaterials.off.Reverse then
					for k, v in pairs(ent.SubMaterials.off.Reverse) do
						ent:SetSubMaterial(k, v)
					end
				end
			end
		end
	end

	ent.WasReversing = IsReversing
	ent.WasBraking = IsBraking
	ent.WasLowbeam = Lowbeam
	ent.WasHighbeam = Highbeam
end

local function ManageProjTextures()
	if vtable then
		for a, ent in pairs(vtable) do
			if IsValid(ent) then
				local vel = ent:GetVelocity() * RealFrameTime()

				ent.triggers = {
					[1] = ent:GetLightsEnabled() and bc(ent),
					[2] = ent:GetLampsEnabled() > 1 and bc(ent),
					[3] = ent:GetFogLightsEnabled() and bc(ent),
					[4] = ent:GetIsBraking() and bc(ent),
					[5] = ent:GetGear() == 1 and bc(ent),
					[6] = ent.signal_left and bc(ent),
					[7] = ent.signal_right and bc(ent),
					[8] = ent:GetIsBraking() and bc(ent),
					[9] = ent:GetIsBraking() and bc(ent),
					[10] = ent:GetLampsEnabled() > 0 and bc(ent),
				}

				UpdateSubMats(ent, ent.triggers[1], ent.triggers[2], ent.triggers[4], ent.triggers[5])

				if ent.triggers[3] then
					McCD.Underglow(ent, McCD.Config.Neon[ent:GetNW2Int("MccD.Neon", 1)][2])
				end

				for i, proj in pairs(ent.Projtexts) do
					local trigger = ent.triggers[proj.trigger]
					local enable = ent:GetLampsEnabled() > 0 and bc(ent)

					if proj.Damaged or (proj.trigger == 2 and not FrontProjectedLights) or (proj.trigger == 4 and not RearProjectedLights) then
						trigger = false
						enable = false
					end

					if ent.HasSpecialTurnSignals and proj.trigger == 4 and (ent.triggers[6] or ent.triggers[7]) then
						trigger = false
					end

					if proj.Active ~= enable then
						proj.Active = enable

						if enable then
							proj.istriggered = trigger
							local thelamp = ProjectedTexture()
							thelamp:SetBrightness(1)
							thelamp:SetTexture(proj.mat)
							thelamp:SetColor(proj.col)
							thelamp:SetEnableShadows(Shadows)
							thelamp:SetFarZ(proj.FarZ)
							thelamp:SetNearZ(proj.NearZ)
							thelamp:SetFOV(proj.Fov)
							proj.projector = thelamp
						else
							if IsValid(proj.projector) then
								proj.projector:Remove()
								proj.projector = nil
							end
						end
					end

					if IsValid(proj.projector) then
						local pos = ent:LocalToWorld(proj.pos)
						local ang = ent:LocalToWorldAngles(proj.ang)
						trigger = ent:GetLampsEnabled() == 2
						if proj.istriggered ~= trigger then
							proj.istriggered = trigger

							if proj.ontrigger.brightness then
								local brightness = trigger and proj.ontrigger.brightness or proj.brightness
								proj.projector:SetBrightness(brightness)
							end

							if proj.ontrigger.mat then
								local smat = trigger and proj.ontrigger.mat or proj.mat
								proj.projector:SetTexture(smat)
							end

							if proj.ontrigger.FarZ then
								local FarZ = trigger and proj.ontrigger.FarZ or proj.FarZ
								proj.projector:SetFarZ(FarZ)
							end
						end

						proj.projector:SetPos(pos + vel)
						proj.projector:SetAngles(ang)
						proj.projector:Update()
					end
				end
			else
				vtable[a] = nil
			end
		end
	end
end

local function SetupProjectedTextures(ent, vehiclelist)
	ent.Projtexts = {}
	local proj_col = vehiclelist.ColoredLights or (vehiclelist.ModernLights and Color(215, 240, 255) or Color(220, 205, 160))

	if isvector(vehiclelist.L_HeadLampPos) and isangle(vehiclelist.L_HeadLampAng) then
		ent.Projtexts["FL"] = {
			trigger = 2,
			ontrigger = {
				mat = "effects/flashlight/headlight_highbeam",
				FarZ = 2000,
				brightness = 2,
			},
			pos = vehiclelist.L_HeadLampPos,
			ang = vehiclelist.L_HeadLampAng,
			mat = "effects/flashlight/headlight_lowbeam",
			col = proj_col,
			brightness = 1,
			FarZ = 750,
			NearZ = 45,
			Fov = 65,
		}
	end

	if isvector(vehiclelist.R_HeadLampPos) and isangle(vehiclelist.R_HeadLampAng) then
		ent.Projtexts["FR"] = {
			trigger = 2,
			ontrigger = {
				mat = "effects/flashlight/headlight_highbeam",
				FarZ = 2000,
				brightness = 2,
			},
			pos = vehiclelist.R_HeadLampPos,
			ang = vehiclelist.R_HeadLampAng,
			mat = "effects/flashlight/headlight_lowbeam",
			col = proj_col,
			brightness = 1,
			FarZ = 750,
			NearZ = 45,
			Fov = 65,
		}
	end

	if isvector(vehiclelist.L_RearLampPos) and isangle(vehiclelist.L_RearLampAng) then
		ent.Projtexts["RL"] = {
			trigger = 4,
			ontrigger = {
				brightness = 1,
			},
			pos = vehiclelist.L_RearLampPos,
			ang = vehiclelist.L_RearLampAng,
			mat = "effects/flashlight/soft",
			col = Color(30, 0, 0),
			brightness = 0.2,
			FarZ = 80,
			NearZ = 45,
			Fov = 140,
		}
	end

	if isvector(vehiclelist.R_RearLampPos) and isangle(vehiclelist.R_RearLampAng) then
		ent.Projtexts["RR"] = {
			trigger = 4,
			ontrigger = {
				brightness = 1,
			},
			pos = vehiclelist.R_RearLampPos,
			ang = vehiclelist.R_RearLampAng,
			mat = "effects/flashlight/soft",
			col = Color(30, 0, 0),
			brightness = 0.2,
			FarZ = 80,
			NearZ = 45,
			Fov = 140,
		}
	end

	ent:CallOnRemove("remove_projected_textures", function(vehicle)
		for i, proj in pairs(ent.Projtexts) do
			local thelamp = proj.projector

			if IsValid(thelamp) then
				thelamp:Remove()
			end
		end
	end)
end

local function SetUpLights(vname, ent)
	ent.Sprites = {}
	local vehiclelist = list.Get("simfphys_lights")[vname]

	if not vehiclelist then
		ent.SubMaterials = false

		return
	end

	ent.LightsEMS = vehiclelist.ems_sprites or false

	local hl_col = vehiclelist.ModernLights and {215, 240, 255} or {220, 205, 160}

	SetupProjectedTextures(ent, vehiclelist)

	if not vehiclelist or not vehiclelist.SubMaterials then
		ent.SubMaterials = false
	else
		ent.SubMaterials = vehiclelist.SubMaterials
	end

	if istable(vehiclelist.ems_sprites) then
		ent.PixVisEMS = {}

		for i = 1, table.Count(vehiclelist.ems_sprites) do
			ent.PixVisEMS[i] = util.GetPixelVisibleHandle()
			ent.LightsEMS[i].material = ent.LightsEMS[i].material or mat2
		end
	end

	if istable(vehiclelist.Headlight_sprites) then
		for _, data in pairs(vehiclelist.Headlight_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 10

			if not isvector(data) then
				s.color = data.color and data.color or Color(hl_col[1], hl_col[2], hl_col[3], 255)
				s.material = data.material or mat2
				s.size = data.size and data.size or 16
				s.pos = data.pos

				if (data.OnBodyGroups) then
					s.bodygroups = data.OnBodyGroups
				end

				table.insert(ent.Sprites, s)
			else
				s.pos = data
				s.color = Color(hl_col[1], hl_col[2], hl_col[3], 255)
				s.material = mat
				s.size = 16
				table.insert(ent.Sprites, s)
				local s2 = {}
				s2.PixVis = util.GetPixelVisibleHandle()
				s2.trigger = s.trigger
				s2.pos = data
				s2.color = Color(hl_col[1], hl_col[2], hl_col[3], 150)
				s2.material = mat2
				s2.size = 64
				table.insert(ent.Sprites, s2)
			end
		end
	end

	if istable(vehiclelist.Rearlight_sprites) then
		for _, data in pairs(vehiclelist.Rearlight_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 1

			if not isvector(data) then
				s.color = data.color and data.color or Color(255, 0, 0, 125)
				s.material = data.material or mat2
				s.size = data.size and data.size or 16
				s.pos = data.pos

				if (data.OnBodyGroups) then
					s.bodygroups = data.OnBodyGroups
				end

				table.insert(ent.Sprites, s)
			else
				local s2 = {}
				s2.PixVis = util.GetPixelVisibleHandle()
				s2.trigger = s.trigger
				s2.pos = data
				s2.color = Color(255, 120, 0, 125)
				s2.material = mat2
				s2.size = 12
				table.insert(ent.Sprites, s2)
				s.pos = data
				s.color = Color(255, 0, 0, 90)
				s.material = mat
				s.size = 32
				table.insert(ent.Sprites, s)
			end
		end
	end

	if istable(vehiclelist.Brakelight_sprites) then
		for _, data in pairs(vehiclelist.Brakelight_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 4

			if not isvector(data) then
				s.color = data.color and data.color or Color(255, 0, 0, 125)
				s.material = data.material or mat2
				s.size = data.size and data.size or 16
				s.pos = data.pos

				if (data.OnBodyGroups) then
					s.bodygroups = data.OnBodyGroups
				end

				table.insert(ent.Sprites, s)
			else
				s.pos = data
				s.color = Color(255, 0, 0, 90)
				s.material = mat
				s.size = 32
				table.insert(ent.Sprites, s)
				local s2 = {}
				s2.PixVis = util.GetPixelVisibleHandle()
				s2.trigger = s.trigger
				s2.pos = data
				s2.color = Color(255, 120, 0, 125)
				s2.material = mat2
				s2.size = 12
				table.insert(ent.Sprites, s2)
			end
		end
	end

	if istable(vehiclelist.Reverselight_sprites) then
		for _, data in pairs(vehiclelist.Reverselight_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 5

			if not isvector(data) then
				s.color = data.color and data.color or Color(255, 255, 255, 255)
				s.material = data.material or mat2
				s.size = data.size and data.size or 16
				s.pos = data.pos

				if (data.OnBodyGroups) then
					s.bodygroups = data.OnBodyGroups
				end

				table.insert(ent.Sprites, s)
			else
				s.pos = data
				s.color = Color(255, 255, 255, 150)
				s.material = mat
				s.size = 12
				table.insert(ent.Sprites, s)
				local s2 = {}
				s2.PixVis = util.GetPixelVisibleHandle()
				s2.trigger = s.trigger
				s2.pos = data
				s2.color = Color(255, 255, 255, 80)
				s2.material = mat2
				s2.size = 25
				table.insert(ent.Sprites, s2)
			end
		end
	end

	if istable(vehiclelist.FrontMarker_sprites) then
		for _, data in pairs(vehiclelist.FrontMarker_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 1

			if isvector(data) then
				s.pos = data
				s.color = Color(200, 100, 0, 150)
				s.material = mat
				s.size = 12
				table.insert(ent.Sprites, s)
			end
		end
	end

	if istable(vehiclelist.RearMarker_sprites) then
		for _, data in pairs(vehiclelist.RearMarker_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 1

			if isvector(data) then
				s.pos = data
				s.color = Color(205, 0, 0, 150)
				s.material = mat
				s.size = 12
				table.insert(ent.Sprites, s)
			end
		end
	end

	if istable(vehiclelist.Headlamp_sprites) then
		for _, data in pairs(vehiclelist.Headlamp_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 2

			if not isvector(data) then
				s.color = data.color and data.color or Color(hl_col[1], hl_col[2], hl_col[3], 255)
				s.material = data.material or mat2
				s.size = data.size and data.size or 16
				s.pos = data.pos

				if (data.OnBodyGroups) then
					s.bodygroups = data.OnBodyGroups
				end

				table.insert(ent.Sprites, s)
			else
				s.pos = data
				s.color = Color(hl_col[1], hl_col[2], hl_col[3], 255)
				s.material = mat
				s.size = 16
				table.insert(ent.Sprites, s)
				local s2 = {}
				s2.PixVis = util.GetPixelVisibleHandle()
				s2.trigger = s.trigger
				s2.pos = data
				s2.color = Color(hl_col[1], hl_col[2], hl_col[3], 150)
				s2.material = mat2
				s2.size = 64
				table.insert(ent.Sprites, s2)
			end
		end
	end

	if istable(vehiclelist.FogLight_sprites) then
		for _, data in pairs(vehiclelist.FogLight_sprites) do
			local s = {}
			s.PixVis = util.GetPixelVisibleHandle()
			s.trigger = 3

			if not isvector(data) then
				s.color = data.color and data.color or Color(hl_col[1], hl_col[2], hl_col[3], 255)
				s.material = data.material or mat2
				s.size = data.size and data.size or 32
				s.pos = data.pos

				if (data.OnBodyGroups) then
					s.bodygroups = data.OnBodyGroups
				end

				table.insert(ent.Sprites, s)
			else
				s.pos = data
				s.color = Color(hl_col[1], hl_col[2], hl_col[3], 200)
				s.material = mat2
				s.size = 32
				table.insert(ent.Sprites, s)
			end
		end
	end

	if istable(vehiclelist.Turnsignal_sprites) then
		ent.HasTurnSignals = true

		if istable(vehiclelist.Turnsignal_sprites.Left) then
			for _, data in pairs(vehiclelist.Turnsignal_sprites.Left) do
				local s = {}
				s.PixVis = util.GetPixelVisibleHandle()
				s.trigger = 6

				if not isvector(data) then
					s.color = data.color and data.color or Color(200, 100, 0, 255)
					s.material = data.material or mat2
					s.size = data.size and data.size or 24
					s.pos = data.pos

					if (data.OnBodyGroups) then
						s.bodygroups = data.OnBodyGroups
					end

					table.insert(ent.Sprites, s)
				else
					s.pos = data
					s.color = Color(255, 150, 0, 150)
					s.material = mat
					s.size = 20
					table.insert(ent.Sprites, s)
					local s2 = {}
					s2.PixVis = util.GetPixelVisibleHandle()
					s2.trigger = s.trigger
					s2.pos = data
					s2.color = Color(200, 100, 0, 80)
					s2.material = mat2
					s2.size = 70
					table.insert(ent.Sprites, s2)
				end
			end
		end

		if istable(vehiclelist.Turnsignal_sprites.Right) then
			for _, data in pairs(vehiclelist.Turnsignal_sprites.Right) do
				local s = {}
				s.PixVis = util.GetPixelVisibleHandle()
				s.trigger = 7

				if not isvector(data) then
					s.color = data.color and data.color or Color(200, 100, 0, 255)
					s.material = data.material or mat2
					s.size = data.size and data.size or 24
					s.pos = data.pos

					if (data.OnBodyGroups) then
						s.bodygroups = data.OnBodyGroups
					end

					table.insert(ent.Sprites, s)
				else
					s.pos = data
					s.color = Color(255, 150, 0, 150)
					s.material = mat
					s.size = 20
					table.insert(ent.Sprites, s)
					local s2 = {}
					s2.PixVis = util.GetPixelVisibleHandle()
					s2.trigger = s.trigger
					s2.pos = data
					s2.color = Color(200, 100, 0, 80)
					s2.material = mat2
					s2.size = 70
					table.insert(ent.Sprites, s2)
				end
			end
		end

		if istable(vehiclelist.Turnsignal_sprites.TurnBrakeLeft) then
			ent.HasSpecialTurnSignals = true

			for _, data in pairs(vehiclelist.Turnsignal_sprites.TurnBrakeLeft) do
				local s = {}
				s.PixVis = util.GetPixelVisibleHandle()
				s.trigger = 8

				if not isvector(data) then
					s.color = data.color and data.color or Color(255, 0, 0, 125)
					s.material = data.material or mat2
					s.size = data.size and data.size or 16
					s.pos = data.pos

					if (data.OnBodyGroups) then
						s.bodygroups = data.OnBodyGroups
					end

					table.insert(ent.Sprites, s)
				else
					s.pos = data
					s.color = Color(255, 60, 0, 90)
					s.material = mat
					s.size = 40
					table.insert(ent.Sprites, s)
					local s2 = {}
					s2.PixVis = util.GetPixelVisibleHandle()
					s2.trigger = s.trigger
					s2.pos = data
					s2.color = Color(255, 120, 0, 125)
					s2.material = mat2
					s2.size = 16
					table.insert(ent.Sprites, s2)
				end
			end
		end

		if istable(vehiclelist.Turnsignal_sprites.TurnBrakeRight) then
			ent.HasSpecialTurnSignals = true

			for _, data in pairs(vehiclelist.Turnsignal_sprites.TurnBrakeRight) do
				local s = {}
				s.PixVis = util.GetPixelVisibleHandle()
				s.trigger = 9

				if not isvector(data) then
					s.color = data.color and data.color or Color(255, 0, 0, 125)
					s.material = data.material or mat2
					s.size = data.size and data.size or 16
					s.pos = data.pos

					if (data.OnBodyGroups) then
						s.bodygroups = data.OnBodyGroups
					end

					table.insert(ent.Sprites, s)
				else
					s.pos = data
					s.color = Color(255, 60, 0, 90)
					s.material = mat
					s.size = 40
					table.insert(ent.Sprites, s)
					local s2 = {}
					s2.PixVis = util.GetPixelVisibleHandle()
					s2.trigger = s.trigger
					s2.pos = data
					s2.color = Color(255, 120, 0, 125)
					s2.material = mat2
					s2.size = 16
					table.insert(ent.Sprites, s2)
				end
			end
		end
	end

	ent.EnableLights = true
	table.insert(vtable, ent)
end

local function CreateDLight(tab, i, index, cl, pos, ss)
	if IsValid(tab[i]) then
		tab[i].DieTime = CurTime() + 0.1
		tab[i].Pos = pos
		tab[i].r = cl.r
		tab[i].g = cl.g
		tab[i].b = cl.b
		tab[i].Size = cl.a + (ss and 0 or cl.a) or 255
		return
	end

	tab[i] = DynamicLight(index)
	tab[i].r = cl.r
	tab[i].g = cl.g
	tab[i].b = cl.b
	tab[i].Brightness = 1
	tab[i].Pos = pos
	tab[i].Size = ss and math.Clamp(cl.a / 2, 1, 100) or cl.a
	tab[i].nomodel = true
	tab[i].DieTime = CurTime() + 0.1
end

local col_a = Color(0, 0, 0, 0)

local function DrawEMSLights(ent, code)
	if not ent.LightsEMS then return end
	local Time = CurTime()

	if not ent.dems_cache then ent.dems_cache = {} end

	for i = 1, table.Count(ent.LightsEMS) do
		if ent.LightsEMS[i].Damaged then continue end
		if ent.LightsEMS[i].ucode and ent.LightsEMS[i].ucode > code then continue end
		if ent.LightsEMS[i].code and ent.LightsEMS[i].code ~= code then continue end

		local size = ent.LightsEMS[i].size
		local LightPos = ent:LocalToWorld(ent.LightsEMS[i].pos)
		local Visible = util.PixelVisible(LightPos, 4, ent.PixVisEMS[i])
		local matl = ent.LightsEMS[i].material
		local numcolors = table.Count(ent.LightsEMS[i].Colors)
		local s_v = true

		ent.LightsEMS[i].Timer = ent.LightsEMS[i].Timer or 0
		ent.LightsEMS[i].Index = ent.LightsEMS[i].Index or 0
		local col = ent.LightsEMS[i].Colors[ent.LightsEMS[i].Index]

		--if not col then continue end

		if numcolors > 1 and ent.LightsEMS[i].Timer < Time then
			ent.LightsEMS[i].Timer = Time + ent.LightsEMS[i].Speed
			ent.LightsEMS[i].Index = ent.LightsEMS[i].Index + 1

			if ent.LightsEMS[i].Index > numcolors then
				ent.LightsEMS[i].Index = 1
			end
		end

		if not ent.dems_cache[i] then ent.dems_cache[i] = {} end

		if ent.LightsEMS[i].OnBodyGroups then
			s_v = ent:BodyGroupIsValid(ent.LightsEMS[i].OnBodyGroups)
		end

		Visible = s_v and Visible or 0

		if s_v and col and col ~= col_a then
			CreateDLight(ent.dems_cache[i], i, i .. ent:EntIndex() .. ent.LightsEMS[i].Index, col, LightPos, false)
		end

		if Visible and Visible >= 0.6 and col and col ~= col_a then
			Visible = (Visible - 0.6) / 0.4
			render.SetMaterial(matl)
			render.DrawSprite(LightPos, size, size,  MSD.ColorAlpha(col, (col["a"] or 255) * Visible))
		end
	end
end

hook.Add("Think", "simfphys_lights_managment", function()
	ManageProjTextures()
end)

local function TrySetupLights(ent, attempt)
	if not IsValid(ent) then return end
	if ent:GetClass() ~= "gmod_sent_vehicle_fphysics_base" then return end
	if ent.EnableLights == true then return end

	-- NetworkVar accessors / networked string may not be ready yet when
	-- OnEntityCreated fires. Retry up to ~2s before giving up.
	attempt = attempt or 0
	if not isfunction(ent.GetLights_List) or (ent:GetLights_List() or "") == "" then
		if attempt < 10 then
			timer.Simple(0.2, function() TrySetupLights(ent, attempt + 1) end)
		end
		return
	end

	local listname = ent:GetLights_List()

	if listname ~= "no_lights" then
		SetUpLights(listname, ent)
	else
		ent.EnableLights = true
	end
end

-- Event-driven: react to new vehicles instead of scanning ents.FindByClass every 2s
hook.Add("OnEntityCreated", "simfphys_lights_setup", function(ent)
	timer.Simple(0.2, function() TrySetupLights(ent) end)
end)

hook.Add("NetworkEntityCreated", "simfphys_lights_setup_net", function(ent)
	timer.Simple(0.2, function() TrySetupLights(ent) end)
end)

-- Run once on load for any pre-existing vehicles (e.g. reload while connected)
timer.Simple(1, function()
	for _, ent in ipairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
		TrySetupLights(ent)
	end
end)

hook.Add("PostDrawTranslucentRenderables", "simfphys_draw_sprites", function(bDepth, bSkybox)
	if ( bSkybox ) then return end
	if not vtable then return end

	for i, ent in pairs(vtable) do
		if not IsValid(ent) then continue end
		local dist = LocalPlayer():GetPos():DistToSqr(ent:GetPos())
		if dist > 3000000 then continue end

		if ent:GetEMSEnabled() > 0 and bc(ent) then
			DrawEMSLights(ent, ent:GetEMSEnabled())
		end

		if SpritesDisabled then return end
		if not istable(ent.triggers) then return end

		if not ent.color_cache then ent.color_cache = {} end
		if not ent.d_cache then ent.d_cache = {} end

		for k, sprite in pairs(ent.Sprites) do
			if sprite.Damaged then continue end
			local regTrigger = ent.triggers[sprite.trigger]
			local typeSpecial = (sprite.trigger == 8 and ent.triggers[6]) or (sprite.trigger == 9 and ent.triggers[7])

			if typeSpecial then
				regTrigger = false
			end

			if regTrigger or typeSpecial then
				local LightPos = ent:LocalToWorld(sprite.pos)
				local Visible = util.PixelVisible(LightPos, 4, sprite.PixVis)
				local s_mat = sprite.material
				local s_size = sprite.size
				local s_v = true

				if sprite.trigger == 6 or sprite.trigger == 7 or typeSpecial then
					s_v = ent:GetFlasher() == 1
				end

				if sprite.bodygroups and s_v then
					s_v = BodyGroupIsValid(sprite.bodygroups, ent)
				end

				Visible = s_v and Visible or 0

				if s_v and ent.color_cache[k] then
					CreateDLight(ent.d_cache, k, k .. ent:EntIndex() .. k, ent.color_cache[k], LightPos, true)
				end

				if Visible and Visible >= 0.6 then
					Visible = (Visible - 0.6) / 0.4
					render.SetMaterial(s_mat)

					if not ent.color_cache[k] then ent.color_cache[k] = Color(sprite.color["r"], sprite.color["g"], sprite.color["b"], sprite.color["a"]) end

					local c_Alpha = ent.color_cache[k]["a"] * Visible

					render.DrawSprite(LightPos, s_size, s_size, MSD.ColorAlpha(ent.color_cache[k], c_Alpha))
				end
			end
		end
	end
end)

local glassimpact = Sound("Glass.BulletImpact")

local function spritedamage(length)
	if not simfphys.DamageEnabled then return end
	local veh = net.ReadEntity()
	if not IsValid(veh) then return end
	local pos = veh:LocalToWorld(net.ReadVector())
	local Rad = net.ReadBool() and 26 or 8
	local curtime = CurTime()
	veh.NextImpactsnd = veh.NextImpactsnd or 0

	if istable(veh.Sprites) then
		for i, sprite in pairs(veh.Sprites) do
			if not sprite.Damaged then
				local spritepos = veh:LocalToWorld(sprite.pos)
				local Dist = (spritepos - pos):Length()

				if Dist < Rad then
					veh.Sprites[i].Damaged = true

					if sprite.trigger >= 6 then
						veh.turnsignals_damaged = true
					end

					local effectdata = EffectData()
					effectdata:SetOrigin(spritepos)
					util.Effect("GlassImpact", effectdata, true, true)

					if veh.NextImpactsnd < curtime then
						veh.NextImpactsnd = curtime + 0.05
						sound.Play(glassimpact, spritepos, 75)
					end
				end
			end
		end
	end

	if istable(veh.Projtexts) then
		for i, proj in pairs(veh.Projtexts) do
			if not proj.Damaged then
				local lamppos = veh:LocalToWorld(proj.pos)
				local Dist = (lamppos - pos):Length()

				if Dist < Rad * 2 then
					veh.Projtexts[i].Damaged = true
				end
			end
		end
	end

	if istable(veh.LightsEMS) then
		for i = 1, table.Count(veh.LightsEMS) do
			if not veh.LightsEMS[i].Damaged then
				local spritepos = veh:LocalToWorld(veh.LightsEMS[i].pos)
				local Dist = (spritepos - pos):Length()

				if Dist < Rad then
					veh.LightsEMS[i].Damaged = true
					local effectdata = EffectData()
					effectdata:SetOrigin(spritepos)
					util.Effect("GlassImpact", effectdata, true, true)

					if veh.NextImpactsnd < curtime then
						veh.NextImpactsnd = curtime + 0.05
						sound.Play(glassimpact, spritepos, 75)
					end
				end
			end
		end
	end
end

net.Receive("simfphys_spritedamage", spritedamage)

local function spriterepair(length)
	local veh = net.ReadEntity()
	if not IsValid(veh) then return end
	veh.turnsignals_damaged = nil

	if istable(veh.Sprites) then
		for i, sprite in pairs(veh.Sprites) do
			veh.Sprites[i].Damaged = false
		end
	end

	if istable(veh.Projtexts) then
		for i, proj in pairs(veh.Projtexts) do
			veh.Projtexts[i].Damaged = false
		end
	end

	if istable(veh.LightsEMS) then
		for i = 1, table.Count(veh.LightsEMS) do
			veh.LightsEMS[i].Damaged = false
		end
	end
end

net.Receive("simfphys_lightsfixall", spriterepair)

net.Receive("simfphys_turnsignal", function(length)
	local ent = net.ReadEntity()
	local turnmode = net.ReadUInt(3)
	if not IsValid(ent) then return end

	if turnmode == 0 then
		ent.signal_left = false
		ent.signal_right = false
	end

	if turnmode == 1 then
		ent.signal_left = true
		ent.signal_right = true
	end

	if turnmode == 2 then
		ent.signal_left = true
		ent.signal_right = false
	end

	if turnmode == 3 then
		ent.signal_left = false
		ent.signal_right = true
	end
end)