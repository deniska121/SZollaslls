--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/submaterial.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Render"
TOOL.Name = "Материалы" --"#tool.material.name"

if CLIENT then
	language.Add("tool.submaterial.name", "Материалы")
	language.Add("tool.submaterial.desc", "Позволяет заменить материалы объекта.")
	language.Add("tool.submaterial.0", "Колесо мыши: выбор материала | ЛКМ: Применить | ПКМ: Сбросить | R: Скопировать путь | Зажать SHIFT: доп. опции")
	language.Add("tool.submaterial.1", "ЛКМ: Сменить материал на предыдущий | ПКМ: Сменить материал на следующий | R: Обновить материал ")
	language.Add("tool.submaterial.help", "Выберете материал")
end

TOOL.ClientConVar["override"] = "debug/env_cubemap_model"
TOOL.ClientConVar["index"] = 0

--
-- Duplicator function
--
local function SetSubMaterial(Player, Entity, Data)
	if (SERVER) then
		local Mats = Entity:GetMaterials()
		local MatCount = table.Count(Mats)

		for i = 0, MatCount - 1 do
			local si = "SubMaterialOverride_" .. tostring(i)

			-- Block exploitable material in multiplayer and remove empty strings
			if Data[si] and ((not game.SinglePlayer() and string.lower(Data[si]) == "pp/copy") or Data[si] == "") then
				Data[si] = nil
			end

			Entity:SetSubMaterial(i, Data[si] or "")
		end

		duplicator.ClearEntityModifier(Entity, "submaterial")

		if (table.Count(Data) > 0) then
			duplicator.StoreEntityModifier(Entity, "submaterial", Data)
		end
	end

	return true
end

duplicator.RegisterEntityModifier("submaterial", SetSubMaterial)

local function UpdateSubMat(Player, Entity, Index, Material)
	local Mats = Entity:GetMaterials()
	local MatCount = table.Count(Mats)
	if Index < 0 or Index >= MatCount then return end
	local Data = {}

	for i = 0, MatCount - 1 do
		local mat = Entity:GetSubMaterial(i)

		if i == Index then
			mat = Material
		end

		if mat and mat ~= "" then
			Data["SubMaterialOverride_" .. tostring(i)] = mat
		end
	end

	return SetSubMaterial(Player, Entity, Data)
end

-- Original set material funct
local function SetMaterial(Player, Entity, Data)
	if (SERVER) then
		--
		-- Make sure this is in the 'allowed' list in multiplayer - to stop people using exploits
		--
		--if ( !game.SinglePlayer() && !list.Contains( "OverrideMaterials", Data.MaterialOverride ) && Data.MaterialOverride != "" ) then return end
		if not Data.MaterialOverride or (Data.MaterialOverride and (not game.SinglePlayer() and string.lower(Data.MaterialOverride) == "pp/copy")) then return end
		Entity:SetMaterial(Data.MaterialOverride)
		duplicator.StoreEntityModifier(Entity, "material", Data)
	end

	return true
end

--and we will override it because original function eats most of materials even not exploitable! :(
duplicator.RegisterEntityModifier("material", SetMaterial)

local pathcache = {}

local function isnumericEnd(str, add)
	if not isstring(str) then return end
	local sp, ep = string.find( str, "[0-9]", -3)

	if not sp then return end

	local nc = 0
	local zs = false
	for k in string.gmatch( string.sub(str, sp), "[0-9]" ) do
		if k == "0" and nc == 0 then
			zs = true
		end
		nc = nc + 1
	end

	local nnt = string.sub(str, 1, sp - 1)
	local n = tonumber(string.sub(str, sp, ep + nc))
	local nn = n + add

	if nn < 10 and not zs and pathcache[nnt] then
		zs = true
	end

	if nn >= 0 then
		n = nn
	end

	if n > 9 and zs then zs = false end

	if zs and not pathcache[nnt] then
		pathcache[nnt] = true
	end

	return nnt .. (zs and "0" or ""), n
end

--
-- Left click applies the current material
--
function TOOL:LeftClick(trace)
	if (not IsValid(trace.Entity)) then return end
	if (CLIENT) then return true end
	local ent = trace.Entity

	if (IsValid(ent.AttachedEntity)) then
		ent = ent.AttachedEntity
	end

	if ent:GetClass() == "gmod_cameraprop" then
		ent = self:GetOwner()
	end

	local mat = self:GetClientInfo("override")
	local index = self:GetClientNumber("index", 0)

	if mat == "matsys_regressiontest/background" then
		mat = "models/props_canal/canal_bridge_railing_01a"
	end

	if self:GetOwner():KeyDown(IN_SPEED) then
		local sub = ent:GetSubMaterial(index - 1)
		if sub == "" then
			sub = ent:GetMaterials()[index]
		end

		local mpth, num = isnumericEnd(sub, -1)
		if mpth and num then
			ent:SetSubMaterial(index - 1, mpth .. num)
			return
		end

		return true
	end

	if index < 1 then
		SetMaterial(self:GetOwner(), ent, {
			MaterialOverride = mat
		})
	else
		UpdateSubMat(self:GetOwner(), ent, index - 1, mat)
	end

	return true
end

--
-- Right click reverts the material
--
function TOOL:RightClick(trace)
	if (not IsValid(trace.Entity)) then return end
	if (CLIENT) then return true end
	local ent = trace.Entity

	if (IsValid(ent.AttachedEntity)) then
		ent = ent.AttachedEntity
	end

	if ent:GetClass() == "gmod_cameraprop" then
		ent = self:GetOwner()
	end

	local index = self:GetClientNumber("index", 0)

	if self:GetOwner():KeyDown(IN_SPEED) then
		local sub = ent:GetSubMaterial(index - 1)
		if sub == "" then
			sub = ent:GetMaterials()[index]
		end

		local mpth, num = isnumericEnd(sub, 1)
		if mpth and num then
			ent:SetSubMaterial(index - 1, mpth .. num)
			return
		end

		return true
	end

	if index < 1 then
		SetMaterial(self:GetOwner(), ent, {
			MaterialOverride = ""
		})
	else
		UpdateSubMat(self:GetOwner(), ent, index - 1, "")
	end

	return true
end


----- Damn Dirty fix... Thx for Wire Advanced tool developer
local function get_active_tool(ply, tool)
	-- find toolgun
	local activeWep = ply:GetActiveWeapon()
	if not IsValid(activeWep) or activeWep:GetClass() ~= "gmod_tool" or activeWep.Mode ~= tool then return end

	return activeWep:GetToolObject(tool)
end

-----------------------------
if CLIENT then
	TOOL.AimEnt = nil
	TOOL.HudData = {}
	TOOL.SelIndx = 1
	TOOL.ToolMatString = ""

	function TOOL:Reload(trace)
		if (not IsValid(trace.Entity)) then return end
		--if ( CLIENT ) then return true end
		local ent = trace.Entity

		if (IsValid(ent.AttachedEntity)) then
			ent = ent.AttachedEntity
		end

		if ent:GetClass() == "gmod_cameraprop" then
			ent = self:GetOwner()
		end

		--local index = self:GetClientNumber( "index" , 0)
		local mat = self.HudData.EntCurMatString --""

		if not mat or mat ~= "" then
			RunConsoleCommand("submaterial_override", mat)
		end

		if self:GetOwner():KeyDown(IN_SPEED) and CLIENT then
			RunConsoleCommand("mat_reloadmaterial", mat)
			RunConsoleCommand("mat_reloadtexture", mat)
		end

		return true
	end

	function TOOL:Scroll(trace, dir)
		if not IsValid(self.AimEnt) then return end
		local Mats = self.AimEnt:GetMaterials()
		local MatCount = table.Count(Mats)
		self.SelIndx = self.SelIndx + dir

		if (self.SelIndx < 0) then
			self.SelIndx = MatCount
		end

		if (self.SelIndx > MatCount) then
			self.SelIndx = 0
		end

		RunConsoleCommand("submaterial_index", tostring(self.SelIndx))
		--self.HudData.EntCurMat=Material(self.AimEnt:GetMaterials()[self.SelIndx])

		return true
	end

	function TOOL:ScrollUp(trace)
		return self:Scroll(trace, -1)
	end

	function TOOL:ScrollDown(trace)
		return self:Scroll(trace, 1)
	end

	---- Thx wire_adv dev again...
	local function hookfunc(ply, bind, pressed)
		if not pressed then return end

		if bind == "invnext" then
			local st = get_active_tool(ply, "submaterial")
			if not st then return end

			return st:ScrollDown(ply:GetEyeTraceNoCursor())
		elseif bind == "invprev" then
			local st = get_active_tool(ply, "submaterial")
			if not st then return end

			return st:ScrollUp(ply:GetEyeTraceNoCursor())
		end
	end

	-- wtfgarry (have to have a delay in single player or the hook won't get added)
	if game.SinglePlayer() then
		timer.Simple(5, function()
			hook.Add("PlayerBindPress", "submat_tool_playerbindpress", hookfunc)
		end)
	else
		hook.Add("PlayerBindPress", "submat_tool_playerbindpress", hookfunc)
	end

	--------------------------------------------------
	local function FixVertexLitMaterial(Mat)
		--
		-- If it's a vertexlitgeneric material we need to change it to be
		-- UnlitGeneric so it doesn't go dark when we enter a dark room
		-- and flicker all about
		--
		if not Mat then return Mat end
		local strImage = Mat:GetName()

		if (string.find(Mat:GetShader(), "VertexLitGeneric") or string.find(Mat:GetShader(), "Cable")) then
			local t = Mat:GetString("$basetexture")

			if (t) then
				local params = {}
				params["$basetexture"] = t
				params["$vertexcolor"] = 1
				params["$vertexalpha"] = 1
				Mat = CreateMaterial(strImage .. "_hud_fx", "UnlitGeneric", params)
			end
		end

		return Mat
	end

	function TOOL:Think()
		self:SetStage(self:GetOwner():KeyDown(IN_SPEED) and 1 or 0)


		local ent = LocalPlayer():GetEyeTraceNoCursor().Entity

		if (IsValid(ent.AttachedEntity)) then
			ent = ent.AttachedEntity
		end

		if ent:GetClass() == "gmod_cameraprop" then
			ent = self:GetOwner()
		end

		if self.AimEnt ~= ent then
			self.AimEnt = ent

			if IsValid(self.AimEnt) then
				if self.AimEnt.AttachedEntity and IsValid(self.AimEnt.AttachedEntity) then
					self.AimEnt = self.AimEnt.AttachedEntity
				end
				self.SelIndx = 0
				RunConsoleCommand("submaterial_index", tostring(self.SelIndx))
				self.HudData.Mats = self.AimEnt:GetMaterials()
			end
		end

		if IsValid(self.AimEnt) then
			self.HudData.CurMats = table.Copy(self.HudData.Mats)
			self.HudData.OvrMats = {}
			local MatCount = table.Count(self.HudData.Mats)

			for i = 1, MatCount do
				local mat = self.AimEnt:GetSubMaterial(i - 1)

				if mat and mat ~= "" then
					self.HudData.OvrMats[i] = mat
				end
			end

			table.Merge(self.HudData.CurMats, self.HudData.OvrMats)
			self.HudData.GlobalMat = self.AimEnt:GetMaterial()
			local EntCurMatString = self.HudData.GlobalMat
			local EntOrigMatString = self.HudData.GlobalMat

			if self.SelIndx > 0 then
				EntCurMatString = self.HudData.CurMats[self.SelIndx]
				EntOrigMatString = self.HudData.Mats[self.SelIndx]
			end

			if self.HudData.EntCurMatString ~= EntCurMatString then
				self.HudData.EntCurMatString = EntCurMatString
				self.HudData.EntCurMat = FixVertexLitMaterial(Material(EntCurMatString))
			end

			if self.HudData.EntOrigMatString ~= EntOrigMatString then
				self.HudData.EntOrigMatString = EntOrigMatString
				self.HudData.EntOrigMat = FixVertexLitMaterial(Material(EntOrigMatString))
			end
		end

		if IsValid(self.AimEnt) and self.ToolMatString ~= GetConVar("submaterial_override"):GetString() then
			self.ToolMatString = GetConVar("submaterial_override"):GetString()
			self.HudData.ToolMat = FixVertexLitMaterial(Material(self.ToolMatString))
		end
	end

	function TOOL:DrawHUD()
		if IsValid(self.AimEnt) then
			---- List
			local Rg = ScrW() / 2 - 50
			local MaxW = 0
			local TextH = 0
			surface.SetFont("ChatFont")
			local Hdr = tostring(self.AimEnt) .. ": " .. tostring(table.Count(self.HudData.Mats)) .. " materials"
			MaxW, TextH = surface.GetTextSize(Hdr)
			local HdrH = TextH + 5

			for _, s in pairs(self.HudData.CurMats) do
				local ts, _ = surface.GetTextSize(s)

				if MaxW < ts then
					MaxW = ts
				end
			end

			local LH = 4 * 2 + HdrH + TextH * (1 + table.Count(self.HudData.Mats))
			local LW = 4 * 2 + MaxW
			local LL = Rg - LW
			local LT = ScrH() / 2 - LH / 2
			surface.SetDrawColor(Color(64, 64, 95, 191))
			--surface.SetMaterial(self.HudData.EntCurMat)
			surface.DrawRect(LL, LT, LW, LH)
			surface.SetTextColor(Color(255, 255, 255, 255))
			surface.SetTextPos(LL + 4, LT + 4)
			surface.DrawText(Hdr)
			surface.SetDrawColor(Color(255, 255, 255, 255))
			surface.DrawLine(LL + 3, LT + 4 + TextH + 3, Rg - 3, LT + 4 + TextH + 3)
			surface.SetDrawColor(Color(0, 127, 0, 191))
			surface.DrawRect(LL + 3, LT + 4 + HdrH + TextH * self.SelIndx, LW - 3 - 3, TextH)
			local s = "<none>"

			if not self.HudData.GlobalMat or self.HudData.GlobalMat == "" then
				surface.SetTextColor(Color(255, 255, 255, 255))
			else
				surface.SetTextColor(Color(0, 0, 255, 255))
				s = self.HudData.GlobalMat
			end

			surface.SetTextPos(LL + 4, LT + 4 + HdrH)
			surface.DrawText(s)

			for i, st in pairs(self.HudData.CurMats) do
				if self.HudData.OvrMats[i] then
					surface.SetTextColor(Color(255, 0, 0, 255))
				else
					surface.SetTextColor(Color(255, 255, 255, 255))
				end

				surface.SetTextPos(LL + 4, LT + 4 + HdrH + TextH * i)
				surface.DrawText(st)
			end

			---- Info box
			--local MaxW = 0
			local StrToolInfo = "Tool material:"
			local StrOrigMatInfo = "Model original material:"
			local StrCurMatInfo = "Model current material:"
			MaxW, _ = surface.GetTextSize(StrToolInfo)
			local ts, _ = surface.GetTextSize(StrOrigMatInfo)

			if MaxW < ts then
				MaxW = ts
			end

			ts, _ = surface.GetTextSize(StrCurMatInfo)

			if MaxW < ts then
				MaxW = ts
			end

			ts, _ = surface.GetTextSize(self.ToolMatString)

			if MaxW < ts then
				MaxW = ts
			end

			ts, _ = surface.GetTextSize(self.HudData.EntOrigMatString)

			if MaxW < ts then
				MaxW = ts
			end

			ts, _ = surface.GetTextSize(self.HudData.EntCurMatString)

			if MaxW < ts then
				MaxW = ts
			end

			local IL = ScrW() / 2 + 50
			local IH = 4 * 4 + 64 * 3
			local IT = ScrH() / 2 - IH / 2
			surface.SetDrawColor(Color(64, 64, 95, 191))
			surface.DrawRect(IL, IT, 76 + MaxW, IH) -- 4+64+4+MaxW+4
			surface.SetTextColor(Color(255, 255, 255, 255))
			surface.SetDrawColor(Color(255, 255, 255, 255))

			if self.HudData.ToolMat then
				surface.SetMaterial(self.HudData.ToolMat)
				surface.DrawTexturedRect(IL + 4, IT + 4, 64, 64)
			end

			surface.SetTextPos(IL + 4 + 64 + 4, IT + 8)
			surface.DrawText(StrToolInfo)
			surface.SetTextPos(IL + 4 + 64 + 4, IT + 8 + TextH)
			surface.DrawText(self.ToolMatString)
			surface.SetTextPos(IL + 4 + 64 + 4, IT + 8 + TextH * 2)
			surface.DrawText(self.SelIndx == 0 and "[Global]" or "Index: " .. self.SelIndx - 1)

			if self.HudData.EntOrigMat then
				surface.SetMaterial(self.HudData.EntOrigMat)
				surface.DrawTexturedRect(IL + 4, IT + 4 + (64 + 4), 64, 64)
			end

			surface.SetTextPos(IL + 4 + 64 + 4, IT + 8 + 64 + 4)
			surface.DrawText(StrOrigMatInfo)
			surface.SetTextPos(IL + 4 + 64 + 4, IT + 8 + 64 + 4 + TextH)
			surface.DrawText(self.HudData.EntOrigMatString)

			if self.HudData.EntCurMat then
				surface.SetMaterial(self.HudData.EntCurMat)
				surface.DrawTexturedRect(IL + 4, IT + 4 + (64 + 4) * 2, 64, 64)
			end

			surface.SetTextPos(IL + 4 + 64 + 4, IT + 8 + (64 + 4) * 2)
			surface.DrawText(StrCurMatInfo)
			surface.SetTextPos(IL + 4 + 64 + 4, IT + 8 + (64 + 4) * 2 + TextH)
			surface.DrawText(self.HudData.EntCurMatString)
		end
	end
end

local matlist = {
	["Стены"] = {"models/scene_building/shared/concreteceiling001a", "models/scene_building/shared/concreteceiling003a", "models/scene_building/shared/concreteceiling004a", "models/scene_building/shared/concretefloor005a", "models/scene_building/shared/concretefloor010a", "models/scene_building/shared/concretefloor012a", "models/scene_building/shared/concretefloor016a", "models/scene_building/shared/concretefloor026a", "models/scene_building/shared/concretewall002c", "models/scene_building/shared/concretewall037d", "models/scene_building/shared/plasterceiling006a", "models/scene_building/shared/plasterceiling007a", "models/scene_building/shared/plasterceiling008a_c17", "models/scene_building/shared/plasterwall016a", "models/scene_building/shared/plasterwall032c", "models/scene_building/shared/plasterwall042c_c17", "models/scene_building/shared/plasterwall044d", "models/scene_building/shared/plasterwall047b", "models/scene_building/shared/plasterwallpaper005a", "models/props_building_details/courtyard_template001c_bars", "kt_walls/kt_skin2", "walls/blue01", "walls/blue05c", "walls/blue08", "walls/pdchiefwall", "walls/wall_grey01", "walls/green01", "walls/red01", "walls/brownpurple01", "walls/wallpaper01", "walls/wallpaper02", "walls/wallpaper03", "walls/wallpaper05", "walls/shopwall01a", "walls/shopwall02a", "walls/shopwall03a", "walls/shopwall04a", "walls/wallpaper_brownblue01", "walls/wallpaper_brownblue02", "walls/wallpaper_greencross", "walls/wall01", "walls/wall02", "walls/wall02b", "walls/wall02c", "walls/woodpanel01a", "walls/woodpanel01b", "walls/woodpanel01c", "walls/woodwall02", "walls/aptcorridor01", "walls/aptcorridor02", "walls/aptcorridor03", "walls/aptlobbywall", "walls/bar_wall", "walls/barwall", "phoenix_storms/concrete0", "phoenix_storms/concrete1", "phoenix_storms/concrete2", "phoenix_storms/concrete3", "models/props_buildings/destroyedbuilldingwall01a", "models/props_buildings/plasterwall021a", "models/props_debris/building_template010a", "models/props_debris/building_template022j", "models/props_debris/concretewall019a", "models/props_debris/plasterceiling008a", "models/props_debris/plasterwall009d", "models/props_debris/plasterwall021a", "models/props_debris/plasterwall034a", "models/props_debris/plasterwall034d", "models/props_debris/plasterwall039c", "models/props_debris/plasterwall040c", "models/scene_building/shared/plasticceiling002a", "models/props_wasteland/concretewall064b", "models/props_wasteland/concretewall066a", "models/props/CS_militia/milceil001",},
	["Напольные покрытия"] = {"models/scene_building/shared/carpetfloor004a", "models/scene_building/shared/mudfloor004a", "models/props_debris/composite_debris", "models/props_debris/concretefloor013a", "models/props_debris/concretefloor020a", "models/props_wasteland/concretefloor010a", "models/props/de_inferno/tileroof01",},
	["Метал"] = {"models/props_interiors/metalfence007a", "models/props_c17/metalladder001", "models/props_c17/metalladder002", "models/props_c17/metalladder003", "models/props_canal/canal_bridge_railing_01a", "models/props_canal/canal_bridge_railing_01b", "models/props_canal/canal_bridge_railing_01c", "models/props_canal/metalcrate001d", "models/props_canal/metalwall005b", "models/props_combine/metal_combinebridge001", "models/props_debris/metalwall001a", "models/gibs/metalgibs/metal_gibs", "models/scene_building/shared/metalgrate013b", "models/props_lab/door_klab01", "models/props_pipes/GutterMetal01a", "models/props_pipes/destroyedpipes01a", "models/props_pipes/pipemetal001a", "models/props_pipes/pipeset_metal02", "models/props_pipes/pipesystem01a_skin1", "models/props_pipes/pipesystem01a_skin2", "models/props_vents/borealis_vent001", "models/props_vents/borealis_vent001b", "models/props_vents/borealis_vent001c", "models/props_wasteland/metal_tram001a", "models/props_wasteland/quarryobjects01", "models/props_wasteland/tugboat01", "models/props_wasteland/tugboat02", "phoenix_storms/Fender_chrome", "phoenix_storms/Future_vents", "phoenix_storms/gear", "phoenix_storms/gear_top", "phoenix_storms/grey_chrome", "phoenix_storms/indentTiles2", "phoenix_storms/iron_rails", "phoenix_storms/mat/mat_phx_carbonfiber", "phoenix_storms/mat/mat_phx_carbonfiber2", "phoenix_storms/metalfence004a", "phoenix_storms/middle", "phoenix_storms/pack2/chrome", "phoenix_storms/pro_gear_top2", "phoenix_storms/side", "phoenix_storms/simplyMetallic1", "phoenix_storms/simplyMetallic2", "phoenix_storms/spheremappy", "phoenix_storms/trains/track_beamtop", "phoenix_storms/trains/track_plate", "phoenix_storms/trains/track_plateside", "models/props/cs_assault/fireescapefloor", "models/props/cs_assault/metal_stairs1", "models/props/cs_assault/pylon",},
	["Камень - кирпич - бетон"] = {"models/scene_building/shared/brickwall017b", "models/scene_building/shared/stonewall017a", "models/scene_building/shared/stonewall017c", "models/scene_building/shared/stonewall025a", "models/scene_building/shared/stonewall025c", "models/scene_building/shared/stonewall044a", "models/scene_building/shared/stonewall044c", "models/scene_building/shared/stonewall051a", "models/scene_building/shared/stonewall051b", "walls/warewall", "walls/warewall_b", "walls/whitebrick01", "models/props/de_nuke/pipeset_metal", "walls/barbrick", "models/props_animated_breakable/smokestack/brickwall002a", "models/props_canal/rock_riverbed01a", "models/XQM/CinderBlock_Tex", "models/props/de_inferno/infflra", "models/props/de_inferno/infflrd", "models/uc2/propper/warefloor02_wet", "models/uc2/propper/warefloor02_vault", "models/uc2/propper/warefloor02",},
	["Дерево"] = {"models/scene_building/shared/woodbeam002a", "models/scene_building/shared/woodfloor001a", "models/scene_building/shared/woodfloor007a_c17", "kt_walls/kt_skin4", "models/gibs/woodgibs/woodgibs01", "models/gibs/woodgibs/woodgibs02", "models/gibs/woodgibs/woodgibs03", "models/XQM//WoodTexture_1", "models/props_foliage/driftwood_01a", "models/props_foliage/oak_tree01", "models/props_wasteland/wood_fence01a", "models/props_wasteland/wood_fence01a_skin2", "models/XQM/WoodPlankTexture", "phoenix_storms/Fender_wood", "phoenix_storms/trains/track_beamside", "phoenix_storms/white_brushes", "phoenix_storms/wood_dome", "phoenix_storms/wood_side", "models/props/CS_militia/roofbeams01", "models/props/CS_militia/roofbeams02", "models/props/CS_militia/roofbeams03", "models/props/CS_militia/RoofEdges", "models/props/de_inferno/woodfloor008a", "models/uc/propper/urban_woodfloor01", "models/uc2/propper/woodstairs", "models/uc2/propper/woodfloor01", "models/uc2/propper/white_housewall2", "models/uc2/propper/woodcounter01", "models/uc2/propper/af_plywood_01",},
	["Плитка"] = {"models/scene_building/shared/tilefloor001a", "models/scene_building/shared/tilefloor012b", "models/scene_building/shared/tilewall009d", "models/scene_building/shared/citadel_tilefloor016a", "models/props_debris/tilefloor001c", "phoenix_storms/pack2/train_floor", "walls/kitchenwall",},
	["Стекло"] = {"models/dog/eyeglass", "models/props_c17/frostedglass_01a", "models/props_combine/citadel_cable", "phoenix_storms/window", "models/props/cs_assault/moneywrap", "models/props/cs_assault/moneywrap02", "models/props/de_inferno/offwndwb_break",},
	["Другое"] = {"models/uc2/propper/alleygaradoor", "models/uc2/propper/7twelvestripe", "models/props_c17/furniturefabric001a", "models/props_c17/furniturefabric002a", "models/props_c17/furnituremetal001a", "models/XQM//Deg360", "models/combine_scanner/scanner_eye", "models/debug/debugwhite", "kt_walls/kt_skin1", "models/props_canal/canalmap_sheet", "models/props_canal/coastmap_sheet", "models/props_wasteland/dirtwall001a", "models/props_wasteland/rockcliff02a", "models/props_wasteland/rockcliff02b", "models/props_wasteland/rockcliff02c", "models/props_wasteland/rockcliff04a", "models/props_wasteland/rockgranite02a", "models/weapons/v_crossbow/rebar_glow", "models/weapons/v_crowbar/crowbar_cyl", "models/XQM/BoxFull_diffuse", "models/XQM/CellShadedCamo_diffuse", "models/dav0r/hoverball", "phoenix_storms/Fender_white", "phoenix_storms/egg", "phoenix_storms/mrref2", "phoenix_storms/mat/mat_phx_metallic", "phoenix_storms/mat/mat_phx_metallic2", "phoenix_storms/mat/mat_phx_plastic", "phoenix_storms/mat/mat_phx_plastic2", "phoenix_storms/metal_plate", "phoenix_storms/metal_wheel", "phoenix_storms/metalbox", "phoenix_storms/metalbox2", "phoenix_storms/pack2/interior_sides", "phoenix_storms/potato", "phoenix_storms/ps_grass", "phoenix_storms/road", "phoenix_storms/roadside", "phoenix_storms/smallwheel", "models/uc2/propper/curtains02", "models/uc2/propper/curtains03", "models/uc2/propper/curtains04", "models/uc2/propper/curtains05",},
	["Вода"] = {"models/spawn_effect", "models/shadertest/predator",},
	["Флаги"] = {"gbskins/flags/usa", "gbskins/flags/ny", "gbskins/flags/rebel", "gbskins/flags/italy", "models/uc2/propper/bar_irishflag",},
	["Старые материалы"] = {"models/props/cs_assault/dollar", "models/props/cs_assault/moneytop", "models/props/cs_office/screen", "models/props/cs_office/snowmana", "models/props/cs_office/clouds", "models/cs_italy/light_orange", "phoenix_storms/white_fps", "phoenix_storms/wire/pcb_blue", "phoenix_storms/wire/pcb_green", "phoenix_storms/wire/pcb_red", "phoenix_storms/tiles2", "phoenix_storms/top", "phoenix_storms/torpedo", "models/props_lab/warp_sheet", "models/props_lab/xencrystal_sheet", "models/props_c17/gate_door02a", "models/effects/portalrift_sheet", "models/effects/slimebubble_sheet", "models/effects/sp	lode1_sheet", "models/effects/splode_sheet", "models/XQM//LightLinesGB", "models/XQM//LightLinesRed", "models/XQM//SquaredMat", "models/airboat/airboat_blur02", "models/alyx/emptool_glow", "models/antlion/antlion_innards", "models/barnacle/roots", "models/combine_advisor/body9", "models/combine_advisor/mask", "models/player/player_chrome1", "models/props_combine/com_shield001a", "models/props_combine/combine_interface_disp", "models/props_combine/combine_monitorbay_disp", "models/props_combine/pipes01", "models/props_combine/pipes03", "models/props_combine/prtl_sky_sheet", "models/props_combine/stasisfield_beam", "models/props_lab/Tank_Glass001", "models/props_lab/cornerunit_cloud", "models/props_lab/security_screens", "models/props_lab/security_screens2", "models/XQM/JetBody2TailPiece_diffuse", "models/XQM/PoleX1_diffuse", "models/XQM/Rails/gumball_1", "models/XQM/SquaredMatInverted", "phoenix_storms/FuturisticTrackRamp_1-2", "phoenix_storms/OfficeWindow_1-1", "phoenix_storms/Pro_gear_side", "phoenix_storms/black_brushes", "phoenix_storms/black_chrome", "phoenix_storms/blue_steel", "phoenix_storms/camera", "phoenix_storms/car_tire", "phoenix_storms/checkers_map", "phoenix_storms/cigar", "phoenix_storms/construct/concrete_barrier00", "phoenix_storms/construct/concrete_barrier2_00", "phoenix_storms/construct/concrete_pipe_00", "phoenix_storms/heli", "phoenix_storms/grey_steel", "phoenix_storms/output_jack", "phoenix_storms/scrnspace", "phoenix_storms/t_light", "phoenix_storms/thruster",},
	["UC2"] = {},
	["UC"] = {},
	["NoirePropper"] = {}
}

local restrict = {
	["Старые материалы"] = true,
	["UC2"] = true,
	["UC"] = true,
	["NoirePropper"] = true,
}

local favorites = {}
local history = {}
local history_2 = {}

if file.Exists("submat_fav.dat", "DATA") then
	favorites = util.JSONToTable(file.Read("submat_fav.dat", "DATA"))
else
	file.Write("submat_fav.dat", "[]")
end

function TOOL.BuildCPanel(CPanel)
	for k, v in pairs(file.Find("materials/models/uc/propper/*", "BSP")) do
		table.insert(matlist["UC"], "models/uc/propper/" .. string.Explode(".", v)[1])
	end

	for k, v in pairs(file.Find("materials/models/uc2/propper/*", "BSP")) do
		table.insert(matlist["UC2"], "models/uc2/propper/" .. string.Explode(".", v)[1])
	end

	local path = "materials/models/noirpropper/"
	local files, directories = file.Find(path .. "*", "GAME")

	for k, v in pairs(files) do
		table.insert(matlist["NoirePropper"], "models/noirpropper/" .. string.Explode(".", v)[1])
	end

	for _, n in pairs(directories) do
		for k, v in pairs(file.Find(path .. n .. "/*", "GAME")) do
			table.insert(matlist["NoirePropper"], "models/noirpropper/" .. n .. "/" .. string.Explode(".", v)[1])
		end
	end

	CPanel:AddControl("Header", {
		Description = "Путь к материалу:"
	})

	local fnd1 = vgui.Create("MSDPanelList")
	fnd1:SetSize(CPanel:GetWide(), 50)
	fnd1:EnableVerticalScrollbar()
	fnd1:SetSpacing(2)
	fnd1:EnableHorizontal(true)
	CPanel:AddItem(fnd1)

	TextBox = vgui.Create("DTextEntry")
	TextBox:SetUpdateOnType(true)
	TextBox:SetSize(50, 20)

	TextBox:SetMultiline(false)
	TextBox:SetConVar("submaterial_override")
	TextBox:SetValue(GetConVar("submaterial_override"):GetString())
	TextBox.PerformLayout = function(self)
		self:SetSize(fnd1:GetWide(), 20)
	end
	fnd1:AddItem(TextBox)

	local MatList2 = vgui.Create("ControlPanel")
	MatList2:SetLabel("Избранное")
	MatList2:SetExpanded(false)
	CPanel:AddPanel(MatList2)
	local populateMatList2

	populateMatList2 = function()
		MatList2:Clear()
		local lst = MatList2:MatSelect("submaterial_override", favorites, true, 64, 64)
		function lst:OnRightClick(button)
			local menu = DermaMenu()
			menu:AddOption( "#spawnmenu.menu.copy", function() SetClipboardText( button.Value ) end ):SetIcon( "icon16/page_copy.png" )
			menu:AddOption( "#spawnmenu.menu.delete", function() table.RemoveByValue(favorites, button.Value) populateMatList2() end ):SetIcon( "icon16/cross.png" )
			menu:Open()
		end
	end
	populateMatList2()

	local MatList3 = vgui.Create("ControlPanel")
	MatList3:SetLabel("История")
	MatList3:SetExpanded(false)
	CPanel:AddPanel(MatList3)
	local populateMatList3

	populateMatList3 = function()
		MatList3:Clear()
		local lst = MatList3:MatSelect("submaterial_override", history, true, 64, 64)
		function lst:OnRightClick(button)
			local menu = DermaMenu()
			menu:AddOption( "#spawnmenu.menu.copy", function() SetClipboardText( button.Value ) end ):SetIcon( "icon16/page_copy.png" )
			menu:Open()
		end
	end
	populateMatList3()


	cvars.AddChangeCallback("submaterial_override", function(convar_name, value_old, mat)
		if not Material(mat):IsError() and not history_2[mat] then
			table.insert(history, 1, mat)
			history_2[mat] = true
			populateMatList3()
		end
	end, "history")

	local copubut = vgui.Create("DButton")
	copubut:SetText("")
	copubut:SetSize(20, 20)
	copubut:SetIcon("icon16/page.png")
	function copubut:DoClick()
		SetClipboardText(GetConVar("submaterial_override"):GetString())
	end
	fnd1:AddItem(copubut)

	local button = vgui.Create("DButton")
	button:SetText("")
	button:SetSize(20, 20)
	button:SetIcon("icon16/star.png")
	function button:DoClick()
		local mat = GetConVar("submaterial_override"):GetString()

		if not Material(mat):IsError() then
			table.insert(favorites, mat)
			file.Write("submat_fav.dat", util.TableToJSON(favorites))
			populateMatList2()
		end
	end
	fnd1:AddItem(button)

	local alpha = vgui.Create("DButton")
	alpha:SetText("")
	alpha:SetSize(20, 20)
	alpha:SetIcon("icon16/shading.png")
	function alpha:DoClick()
		RunConsoleCommand("submaterial_override", "null")
	end
	fnd1:AddItem(alpha)


	for name, mlist in pairs(matlist) do
		if restrict[name] and not sAdmin.hasPermission(LocalPlayer(), "propspawn") then continue end
		local MatList = vgui.Create("ControlPanel")
		MatList:SetLabel(name)
		MatList:SetExpanded(false)
		CPanel:AddPanel(MatList)
		local nat = MatList:MatSelect("submaterial_override", mlist, true, 64, 64)
		function nat:OnRightClick(b)
			local menu = DermaMenu()
			menu:AddOption( "#spawnmenu.menu.copy", function() SetClipboardText( b.Value ) end ):SetIcon( "icon16/page_copy.png" )
			menu:AddOption( "В избранное", function()
				table.insert(favorites, b.Value)
				file.Write("submat_fav.dat", util.TableToJSON(favorites))
				populateMatList2()
			end ):SetIcon( "icon16/star.png" )
			menu:Open()
		end
	end
end