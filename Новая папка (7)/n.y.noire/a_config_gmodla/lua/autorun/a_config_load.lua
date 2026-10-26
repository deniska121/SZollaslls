--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/a_config_gmodla/lua/autorun/a_config_load.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

game.AddParticles( "particles/southside_rain.pcf" )
game.AddParticles( "particles/pfx_redux.pcf" )
game.AddParticles( "particles/explosion_fx_ins.pcf" )
PrecacheParticleSystem( "rain_player" )
PrecacheParticleSystem("[3]leaves_env")
PrecacheParticleSystem( "ins_RPG_explosion" )

if SERVER then
	AddCSLuaFile()
	local f = file.Find("city_extentions/*", "LUA")

	for k, v in pairs(f) do
		if string.StartWith(v, "sh_") then
			include("city_extentions/" .. v)
			AddCSLuaFile("city_extentions/" .. v)
		elseif string.StartWith(v, "sv_") then
			include("city_extentions/" .. v)
		elseif string.StartWith(v, "cl_") then
			AddCSLuaFile("city_extentions/" .. v)
		end
	end

	for _, v in ipairs(file.Find("clprops/*", "LUA")) do
		AddCSLuaFile("clprops/" .. v)
	end

	resource.AddWorkshop("2828740865")
	--resource.AddWorkshop("2848976209")
	resource.AddWorkshop("3741312678") -- p2
	resource.AddWorkshop("2848966362")
	resource.AddWorkshop("2689168958")
	resource.AddWorkshop("2011745721")
	resource.AddWorkshop("2486994157")
	resource.AddWorkshop("3311853453")

	resource.AddWorkshop("3601450491") -- map

	return
end

client_list = {}

local f = file.Find("city_extentions/*", "LUA")

for k, v in pairs(f) do
	if string.StartWith(v, "sh_") then
		include("city_extentions/" .. v)
	elseif string.StartWith(v, "cl_") then
		include("city_extentions/" .. v)
	end
end

for _, v in ipairs(file.Find("clprops/*", "LUA")) do
	include("clprops/" .. v)
end

client_mdls = client_mdls or {}
client_mdls_anim = client_mdls_anim or {}
client_mdls_think = client_mdls_think or {}

client_presets = client_presets or {}
client_loaded = client_loaded or {}

local function assemblCLModel(mdl, k, v)
	if k and v then
		mdl.id = k
		mdl.data = v
	else
		k = mdl.id
		v = mdl.data
	end

	if not k or not v then return end

	mdl:SetPos(v.pos)
	mdl:SetAngles(v.ang)
	if v.anm then
		mdl:ResetSequence(v.anm)
		mdl:ResetSequenceInfo()
		mdl:SetPlaybackRate( v.pbs or 1 )
	end

	if v.skin then
		mdl:SetSkin(v.skin)
	end

	if v.lit then
		debugoverlay.Text(v.pos, "HERE " .. v.lit, 12)
	end

	mdl:SetMaterial(v.mat or "")

	if v.col then
		mdl:SetColor(v.col)
	end

	if v.smt then
		for i, m in pairs(v.smt) do
			mdl:SetSubMaterial(i, m)
		end
	end

	if v.bgr then
		for i, m in pairs(v.bgr) do
			mdl:SetBodygroup(i, m)
		end
	end

	if v.scale then
		local matrix = Matrix()
		matrix:Scale(v.scale)
		mdl:EnableMatrix("RenderMultiply", matrix)
	end

	mdl:SetIK(false)
	mdl:SetCycle(0)
end

local function spawnCLModels()
	local scene_mdls = {}
	for k, v in pairs(client_mdls) do
		if IsValid(v) then
			if v.scene then
				table.insert(scene_mdls, v)
				continue
			end
			v:Remove()
		end
	end

	client_mdls = {}
	client_mdls_anim = {}
	client_mdls_think = {}

	for k, v in pairs(client_list) do
		local mdl = ClientsideModel(v.mdl, RENDERGROUP_OPAQUE)
		assemblCLModel(mdl, k, v)
		local id = table.insert(client_mdls, mdl)

		if v.anm then
			table.insert(client_mdls_anim, mdl)
		end

		if v.think then
			table.insert(client_mdls_think, {id, v})
		end
	end

	for k, v in ipairs(scene_mdls) do
		table.insert(client_mdls, v)
	end
end

if GAMEMODE then
	spawnCLModels()
end

hook.Add("InitPostEntity", "spawnCLModels", function()
	timer.Simple(10, function()
		spawnCLModels()
	end)

	timer.Simple(60, function()
		spawnCLModels()
	end)
end)

local mid_map = Vector(0,0,0)

hook.Add("Think", "DecorProps", function()
	for _, v in ipairs(client_mdls) do
		if not IsValid(v) then continue end
		if v.data and v:GetPos() == mid_map then assemblCLModel(v) end
	end

	for _, v in ipairs(client_mdls_anim) do
		if not IsValid(v) then continue end
		if v:GetPos():DistToSqr(LocalPlayer():GetPos()) > 800000 then continue end
		v:FrameAdvance(math.cos(RealTime()))
		if v:GetCycle() == 1 then
			v:SetCycle(0)
		end
	end

	for k, v in pairs(client_mdls_think) do
		if v.next and v.next > CurTime() then continue end
		--if v[2].pos:DistToSqr(LocalPlayer():GetPos()) > 800000 then continue end
		v.next = v[2].delay + CurTime()
		local mdl = client_mdls[v[1]]
		v[2].think(mdl)
	end
end)

local function RemoveTabs()
	if sAdmin.hasPermission(LocalPlayer(), "propspawn") then return end

	for k, v in pairs(g_SpawnMenu.CreateMenu.Items) do
		if k ~= 1 then
			g_SpawnMenu.CreateMenu:CloseTab(v.Tab, true)
			RemoveTabs()
		end
	end

	for k, v in pairs(g_SpawnMenu.ToolMenu.Items) do
		if k ~= 1 and (v.Name and v.Name ~= "Настройки") then
			g_SpawnMenu.ToolMenu:CloseTab(v.Tab, true)
			RemoveTabs()
		end
	end
end

hook.Add("SpawnMenuOpen", "TabsRemover", function()
	RemoveTabs()
end)