--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/client/holsterwep.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function HolsterDraw(ply, wep, hdata, ovr)
	if not IsValid(wep) or not hdata then return end

	if not IsValid(wep.m_WorldModel) then
		if not wep.appliedfix then
			wep:RecreateClientsideModels(true)
			wep.appliedfix = true
		end
		return
	end

	local Bone = ply:LookupBone(hdata[1])

	if not Bone then return end

	local mat = ply:GetBoneMatrix(Bone)

	if not mat then return end

	if wep.WorldModelOffsets then
		local fix = wep:LookupBoneCached(wep.m_WorldModel, wep.WorldModelOffsets.Bone)
		if (fix ~= nil and fix > 0) then
			wep.m_WorldModel:ManipulateBoneAngles(fix, wep.WorldModelOffsets.Angles)
			wep.m_WorldModel:ManipulateBonePosition(fix, wep.WorldModelOffsets.Pos)
		end
	end

	local pos, ang = mat:GetTranslation(), mat:GetAngles()
	local newpos = VectorOffset(pos, hdata[2], ang)
	local newang = AddAngles(ang, hdata[3])

	wep.m_WorldModel:SetPos(newpos)
	wep.m_WorldModel:SetAngles(newang)
	wep.m_WorldModel:SetRenderOrigin(newpos)
	wep.m_WorldModel:SetRenderAngles(newang)
	wep.m_WorldModel:DrawModel()

	if wep.Customization and wep.m_WorldModel then
		wep:RenderWModels(wep.m_WorldModel)
	end

	if not wep.m_WorldModel.fixed then
		wep:DrawWorldModel()
	end
end

local weaponcosm = {
	["weapon_taser"] = {
		model = "models/realistic_police/taser/w_taser.mdl",
		b = "ValveBiped.Bip01_Pelvis",
		p = Vector(5, -6, 0),
		a = Angle(-90, -20, 50)
	},
	["mlw_tonfa"] = {
		model = "models/weapons/melee/w_tonfa.mdl",
		b = "ValveBiped.Bip01_Pelvis",
		p = Vector(13.715, -9.308, -6.37),
		a = Angle(-17.681, -38.165, 71.347)
	},
	["mlw_policelight"] = {
		model = "models/weapons/w_flashlight_zm.mdl",
		b = "ValveBiped.Bip01_Pelvis",
		p = Vector(-6.526, -3.02, -4.863),
		fp = Vector(-4.526, -3.02, -4.863),
		a = Angle(-1.823, -7.261, -65.725)
	},
	["med_kit"] = {
		model = "models/w_models/weapons/w_eq_medkit.mdl",
		mat = "models/w_models/eq_medkit/w_eq_medkit2",
		scale = Vector(0.5, 0.9, 0.9),
		b = "ValveBiped.Bip01_Pelvis",
		p = Vector(9, -2, -3),
		a = Angle(-0, 130, 0)
	},
	["med_pd"] = {
		model = "models/w_models/weapons/w_eq_medkit.mdl",
		scale = Vector(0.3, 0.7, 0.7),
		b = "ValveBiped.Bip01_Pelvis",
		p = Vector(8, -3, -5),
		fp = Vector(8, -3, -1),
		a = Angle(-0, 130, 0)
	},
	["weapon_ram"] = {
		model = "models/weapons/w_batteringram.mdl",
		b = "ValveBiped.Bip01_Spine2",
		p = Vector(2, 5, 3),
		a = Angle(90, 0, 0)
	},
	["weapon_axe"] = {
		model = "models/weapons/tfa_nmrih/w_me_fubar.mdl",
		b = "ValveBiped.Bip01_Spine2",
		p = Vector(5, 3, 7),
		a = Angle(180, -90, 0)
	}
}

local ranks_nypd = {
	[5] = "nypd/dt",
	[6] = "nypd/sgt",
	[7] = "nypd/lt",
	[8] = "nypd/cpt",
	[9] = "nypd/dins",
	[10] = "nypd/ins",
	[11] = "nypd/1star",
	[12] = "nypd/2star",
	[13] = "nypd/3star",
	[14] = "nypd/4star",
}

local function applyEntChange(ply, ent, ref)
	if not ref then return end

	ent:SetModel(ref.model)

	ent.pos = ref.pos
	ent.ang = ref.ang

	if ref.scale then
		ent.scale = ref.scale
	end

	if ref.mat then
		ent:SetMaterial(ref.mat)
	end

	if ref.color then
		ent.color = ref.color
	end

	if ref.submat then
		for k, v in pairs(ref.submat) do
			ent:SetSubMaterial(k, v)
		end
	end

	if ref.pms and ref.pms[MCR.GetMDL(ply)] then
		local pmdata = ref.pms[MCR.GetMDL(ply)]

		if pmdata[1] then ent.pos = pmdata[1] end
		if pmdata[2] then ent.ang = pmdata[2] end
		if pmdata[3] then ent.scale = pmdata[3] end
	end
end

local bgal = {
	[1] = true,
	[2] = true
}

local function checkBGRs(ply)
	return string.find(ply:GetModel(), "suit/male") and bgal[ply:GetBodygroup(1)]
end

nypdg = {
	["NYPD"] = true,
	["NYPD Traffic"] = true
}

local cosmetics = {
	{
		check = function(ply)
			return ply:getDarkRPVar("mouth") and MCR.Attachments.smoking[ply:getDarkRPVar("mouth")]
		end,
		model = "models/mordeciga/mordes/oldcigshib.mdl",
		att = "mouth",
		rag_no = true,
		head_check = true,
		p = Vector(),
		a = Angle(),
		customfunc = function(ply, ent, _, _, saved)
			applyEntChange(ply, ent, saved and MCR.Attachments.smoking[saved["mouth"]] or MCR.Attachments.smoking[ply:getDarkRPVar("mouth")])
		end
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("face") and MCR.Attachments.face[ply:getDarkRPVar("face")]
		end,
		model = "models/props_interiors/pot01a.mdl",
		att = "eyes",
		head_check = true,
		p = Vector(),
		a = Angle(),
		customfunc = function(ply, ent, _, _, saved)
			applyEntChange(ply, ent, saved and MCR.Attachments.face[saved["face"]] or MCR.Attachments.face[ply:getDarkRPVar("face")])
		end
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("head") and MCR.Attachments.head[ply:getDarkRPVar("head")]
		end,
		model = "models/props_interiors/pot02a.mdl",
		att = "eyes",
		head_check = true,
		p = Vector(),
		a = Angle(),
		customfunc = function(ply, ent,  _, _, saved)
			applyEntChange(ply, ent, saved and MCR.Attachments.head[saved["head"]] or MCR.Attachments.head[ply:getDarkRPVar("head")])
		end
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("bag") and ply:getDarkRPVar("bag") >= 4 and not (ply:isCP() or ply:isEMS())
		end,
		model = "models/cityrp/bags/male_bag.mdl",
		model_f = "models/cityrp/bags/female_bag.mdl",
		merge = true
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("bag") and (ply:getDarkRPVar("bag") >= 2 and ply:getDarkRPVar("bag") < 4) and not (ply:isCP() or ply:isEMS()) and not ply:getDarkRPVar("vest")
		end,
		model = "models/cityrp/bags/male_satchel.mdl",
		model_f = "models/cityrp/bags/female_satchel.mdl",
		merge = true
	},
	{
		check = function(ply)
			return ply:Team() == 6 and not ply:getDarkRPVar("showrank") and MRS.GetNWdata(ply, "Group") and MRS.GetNWdata(ply, "Group") == "NYPD" and not checkBGRs(ply)
		end,
		model = "models/cityrp/nypd/badge_nouf2.mdl",
		model_f = "models/cityrp/nypd/badge_nouf2_f.mdl",
		customfunc = function(ply, ent, item, pent)
			if IsValid(pent) then ply = pent end
			local rank = MRS.GetNWdata(ply, "Rank")

			if not rank or not ply:IsPlayer() then return end

			if ranks_nypd[rank] then
				ent:SetSubMaterial(1, ranks_nypd[rank])
			end
		end,
		merge = true
	},
	{
		check = function(ply)
			return not ply:getDarkRPVar("showrank") and ply:Team() ~= 6 and MRS.GetNWdata(ply, "Group") and nypdg[MRS.GetNWdata(ply, "Group")] and MRS.GetNWdata(ply, "Rank") and MRS.GetNWdata(ply, "Rank") > 1
		end,
		model = "models/cityrp/nypd/badge_nypd.mdl",
		customfunc = function(ply, ent, item, pent)
			if IsValid(pent) then ply = pent end
			if not ply:IsPlayer() then return end
			local rank = MRS.GetNWdata(ply, "Rank")

			if ply:Team() == TEAM_TRAFFIC then
				ent:SetSubMaterial(1, "nypd/traf")
				ent:SetSubMaterial(0, "nypd/lether_alt")
				return
			end

			if not rank or not ply:IsPlayer() then return end

			if ply:GetBodygroup(1) > 2 then
				ent.pos = Vector(-1.4,-8.4,4)
			end

			if ply:Team() == 5 then
				ent:SetSubMaterial(1, "nypd/poaux")
			end

			if rank < 4 then return end

			if ranks_nypd[rank] then
				ent:SetSubMaterial(1, ranks_nypd[rank])
				ent:SetSubMaterial(2, "models/gmodbest/acc/rank4")
			end

			local medals = MCR.GetMedals(ply)
			local ci = 1
			for i = 1, 10 do
				if not medals or ci > 4 then break end
				if not medals[tostring(i)] then continue end
				ent:SetBodygroup(ci, 1)
				ent:SetSubMaterial(2 + ci, "nypd/" .. MCR.Medals[tostring(i)])
				ci = ci + 1
			end

			ent:SetBodygroup(ci, 1)
			ent:SetSubMaterial(2 + ci, "nypd/medal1")
		end,
		b = "ValveBiped.Bip01_Spine4",
		p = Vector(-1,-7.3,3),
		fp = Vector(-3,-6.8,3),
		a = Angle(150,0,80),
		fa = Angle(135,0,80)
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("scba") and ply:getDarkRPVar("scba") == 1
		end,
		model = "models/cityrp/fdny/fire_suit.mdl",
		merge = true,
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("scba") and ply:getDarkRPVar("scba") == 2
		end,
		model = "models/player/swat.mdl",
		merge = true,
		submat = {
			[0] = "gbskins/esu/ct_gign",
			[1] = "gbskins/esu/ct_gign_glass",
		},
		customfunc = function(ply, ent)
			local rank = MRS.GetPlyRank(ply, "NYPD")

			if rank == 6 then
				ent:SetSubMaterial(0, "gbskins/esu/ct_gigns")
			end
		end
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("scba") and ply:getDarkRPVar("scba") == 3
		end,
		model = "models/player/urban.mdl",
		merge = true,
		submat = {
			[0] = "gbskins/esu/ct_fbi",
		},
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("scba") and ply:getDarkRPVar("scba") == 4
		end,
		model = "models/cityrp/fdny/fire_suit.mdl",
		merge = true,
		submat = {
			[4] = "null",
		},
	},
	{
		check = function(ply)
			return ply:Team() == 6 and not ply:getDarkRPVar("showrank") and MRS.GetNWdata(ply, "Group") and MRS.GetNWdata(ply, "Group") == "NYPD" and checkBGRs(ply)
		end,
		model = "models/cityrp/nypd/badge_nypd.mdl",
		customfunc = function(ply, ent, item, pent)
			if IsValid(pent) then ply = pent end
			local rank = MRS.GetNWdata(ply, "Rank")

			if not rank or not ply:IsPlayer() then return end

			if ranks_nypd[rank] then
				ent:SetSubMaterial(1, ranks_nypd[rank])
				ent:SetSubMaterial(2, "null")
			end
		end,
		b = "ValveBiped.Bip01_Spine",
		p = Vector(-1.061, -7.845, -1.643),
		a = Angle(180, 0, 90)
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("HandCuffed")
		end,
		model = "models/weapons/spy/cuffs_wm.mdl",
		model_f = "models/weapons/spy/cuffs_wm_f.mdl",
		merge = true,
	},
	{
		check = function(ply)
			return ply.smdr and ply.smdr[1] > CurTime()
		end,
		model = "models/props_junk/garbage_plasticcup002a.mdl",
		b = "ValveBiped.Bip01_R_Hand",
		p = Vector(5,2,0),
		a = Angle(0,180,0),
		customfunc = function(ply, ent, _, _, saved)
			if not ply or not ply.smdr then return end
			ent:SetModel(ply.smdr[2])
			ent:SetMaterial(ply.smdr[3])
		end
	},
	{
		check = function(ply)
			return ply.smdl and ply.smdl[1] > CurTime()
		end,
		model = "models/props_junk/garbage_plasticcup002a.mdl",
		b = "ValveBiped.Bip01_L_Hand",
		p = Vector(5,2,0),
		a = Angle(0,0,0),
		customfunc = function(ply, ent, _, _, saved)
			ent:SetModel(ply.smdl[2])
			ent:SetMaterial(ply.smdl[3])
		end
	},
	{
		check = function(ply)
			return ply:getDarkRPVar("vest") and ply:getDarkRPVar("vest") == "vest01" and not ply:getDarkRPVar("armorVest") and not string.find(ply:GetModel(), "suit/")
		end,
		model = "models/cityrp/bags/male_vest.mdl",
		model_f = "models/cityrp/bags/female_vest.mdl",
		merge = true,
	},
}

CLIENT_GAR = CLIENT_GAR or {}

local att, i, pos, ang, model

local function MergedRenderOverride(self, flags)
	local parent = self:GetParent()
	if not IsValid(parent) then return end

	if parent:IsPlayer() and (not parent:Alive() or parent:GetNoDraw() or parent:getDarkRPVar("unconscious")) then
		return
	end

	self:DrawModel(flags)
end

local function ItemDraw(ply, id, item, pent, saved)
	model = ply.cosmetics[id]

	if item.head_check then
		local head = ply:LookupBone("ValveBiped.Bip01_Head1")

		if head and ply:GetManipulateBoneScale(head) == Vector(0,0,0) then return end
	end
	if not IsValid(model) then
		local ent = ClientsideModel(isfunction(item.model) and item.model(ply) or ((item.model_f and string.find(ply:GetModel(), "female")) and item.model_f or item.model))
		ent:SetNoDraw(true)
		ent:SetParent(ply)

		if item.mat then
			ent:SetMaterial(item.mat)
		end

		if item.submat then
			for k, v in pairs(item.submat) do
				ent:SetSubMaterial(k, v)
			end
		end
		ply.cosmetics[id] = ent
		ent:SetupBones()

		if item.merge then
			ent:SetNoDraw(false)
			ent:AddEffects(EF_BONEMERGE)
			ent:AddEffects(EF_BONEMERGE_FASTCULL)
			ent:AddEffects(EF_PARENT_ANIMATES)
			ent.RenderOverride = MergedRenderOverride
		end

		if item.customfunc then
			item.customfunc(pent or ply, ent, item, pent, saved)
			item.loaded = CurTime() + 5
		end

		local plyscale = ply:GetModelScale()

		if ((item.scale or ent.scale) and (item.scale or ent.scale) ~= Vector(1, 1, 1)) or plyscale ~= 1 then
			local mat = Matrix()
			plyscale = (item.scale or ent.scale or Vector(1,1,1)) * Vector(plyscale, plyscale, plyscale)
			mat:Scale(plyscale)
			ent:EnableMatrix("RenderMultiply", mat)
		end

		table.insert(CLIENT_GAR, ent)
		return
	end

	if item.customfunc and (not item.loaded or item.loaded < CurTime()) then
		item.customfunc(pent or ply, model, item, pent, saved)
		item.loaded = CurTime() + 1
	end

	if item.b then
		local b = ply:LookupBone(item.b)
		if not b then return end
		local mat = ply:GetBoneMatrix(b)
		if not mat then return end
		pos, ang = mat:GetTranslation(), mat:GetAngles()
	end

	if item.att then
		i = ply:LookupAttachment(item.att)
		if not i then return end
		att = ply:GetAttachment(i)
		if not att then return end
		pos, ang = att.Pos, att.Ang
	end

	if not item.merge and pos then
		local mpos, mang = item.p, item.a

		if item.fp and string.find(ply:GetModel(), "female") then
			mpos = item.fp
		end

		if item.fa and string.find(ply:GetModel(), "female") then
			mang = item.fa
		end

		if model.pos then
			mpos = model.pos
		end

		if model.ang then
			mang = model.ang
		end

		pos = pos + ang:Forward() * mpos.x + ang:Right() * mpos.y + ang:Up() * mpos.z

		ang:RotateAroundAxis(ang:Up(), mang.p)
		ang:RotateAroundAxis(ang:Right(), mang.y)
		ang:RotateAroundAxis(ang:Forward(), mang.r)

		model:SetPos(pos)
		model:SetAngles(ang)
		model:SetRenderOrigin(pos)
		model:SetRenderAngles(ang)

		if model.color then
			render.SetColorModulation(model.color.r / 255, model.color.g / 255, model.color.b / 255)
		end
		model:DrawModel()
		if model.color then
			render.SetColorModulation(1, 1, 1)
		end
	end

	if item.merge then
		if model.nodraw then
			model:SetNoDraw(false)
		end
		model.lastd = CurTime()
		if model:GetParent() == NULL then
			model:SetParent(ply)
			model:AddEffects(EF_BONEMERGE)
			model:AddEffects(EF_BONEMERGE_FASTCULL)
			model:AddEffects(EF_PARENT_ANIMATES)
		end
	end
end

hook.Add("Think", "BoneMergeFixHELP", function()
	for k, ent in ipairs(CLIENT_GAR) do
		if IsValid(ent) and ent.lastd and ent.lastd < CurTime() then
			ent.nodraw = true
			ent.lastd = nil
			ent:SetNoDraw(true)
		end

		if not IsValid(ent) or ent == NULL or not IsValid(ent:GetParent()) or ent:GetParent() == NULL then
			if IsValid(ent) then
				ent:Remove()
			end
			table.remove(CLIENT_GAR, k)
			break
		end
	end
end)

local resrock = true

hook.Add("PostPlayerDraw", "SwbHolsterDraw", function(ply)
	if not ply or not IsValid(ply) or not ply:Alive() or ply:getDarkRPVar("unconscious") then return end
	if IsValid(ply.pk_pill_ent) then return end
	if not ply.cosmetics then
		ply.cosmetics = {}
	end

	for id, item in ipairs(cosmetics) do
		if not item.check(ply) or resrock then
			if IsValid(ply.cosmetics[id]) then
				SafeRemoveEntity(ply.cosmetics[id])
			end
			continue
		end
		ItemDraw(ply, id, item)
	end

	resrock = nil

	if ply:InVehicle() or not DarkRP.InRange(ply, LocalPlayer(), 500) then return end

	for _, wep in ipairs(ply:GetWeapons()) do
		if IsValid(wep) and wep ~= ply:GetActiveWeapon() then
			if DarkRP.IsWeaponConcealed(ply, wep) then continue end
			if GAMEMODE.Config.HolsterData[wep:GetClass()] or wep.HolsterData then
				HolsterDraw(ply, wep, wep.HolsterData or GAMEMODE.Config.HolsterData[wep:GetClass()], false)
			elseif weaponcosm[wep:GetClass()] then
				ItemDraw(ply, wep:GetClass(), weaponcosm[wep:GetClass()])
			end
			continue
		end
	end
end)

function DarkRP.ClientCosmet(ent, tbl, saved)
	if not ent.cosmetics then
		ent.cosmetics = {}
	end

	for id, item in ipairs(cosmetics) do
		if not tbl[id] or item.rag_no then
			continue
		end
		ItemDraw(ent, id, item, IsValid(ent.SelfPlayer) and ent.SelfPlayer or nil, saved)
	end
end

hook.Add("PlayerFootstep", "Police.PlayerFootstep", function(ply, ps, foot, s, volume, filter)
	if IsValid(ply.pk_pill_ent) then
		ply.pk_pill_ent:PillSound("step", ps)
		return true
	end

	if ply:Armor() > 1 and ply:getDarkRPVar("armorVest") then
		ply:EmitSound("player/sfx/step" .. math.random(foot == 1 and 6 or 1, foot == 1 and 10 or 5) .. ".wav", 65, 100, 1)
	end
end)