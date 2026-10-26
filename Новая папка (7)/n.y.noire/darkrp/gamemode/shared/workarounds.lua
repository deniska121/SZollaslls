--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/shared/workarounds.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function net.SendSingleMessage(name, ply)
	if CLIENT then
		net.Start(name)
		net.SendToServer()
	else
		if ply then
			net.Start(name)
			net.Send(ply)
		else
			net.Start(name)
			net.Broadcast()
		end
	end
end

function AddAngles(Ang1, Ang2)
	local Ang1Copy = Ang1
	Ang1Copy:RotateAroundAxis(Ang1Copy:Forward(), Ang2.p)
	Ang1Copy:RotateAroundAxis(Ang1Copy:Up(), Ang2.y)
	Ang1Copy:RotateAroundAxis(Ang1Copy:Right(), Ang2.r)

	return Ang1Copy
end

function VectorOffset(pos, offset, ang)
	local newpos = Vector()
	newpos:Set(pos + ang:Forward() * offset.x + ang:Right() * offset.y + ang:Up() * offset.z)

	return newpos
end

function DarkRP.DeathTime()
	local dt = GAMEMODE.Config.respawntime
	local med = #team.GetPlayers(TEAM_REF)

	if med > 0 then
		dt = dt + 30 * math.min(med, 3)
	end

	return math.max(dt, 0)
end

function DarkRP.HasGunlicense(ply)
	if not ply.inv or not ply.inv.junk then return false end

	for _,item in pairs(ply.inv.junk) do
		if not item or not item.docid then continue end
		if not item.name or item.name ~= "Разрешение на ношение" then continue end
		if item.docid.id and item.docid.id == DarkRP.PassId(ply) then return true end
	end

	return string.find(ply:getDarkRPVar("HasGunlicense") or "", "Оружие")
end

function DarkRP.HasBnslicense(ply)
	if not ply.inv or not ply.inv.junk then return false end

	for _,item in pairs(ply.inv.junk) do
		if not item or not item.docid then continue end
		if not item.name or item.name ~= "Лицензия на бизнес" then continue end
		if item.docid.id and item.docid.id == DarkRP.PassId(ply) then return true end
	end

	return false
end

local keys_class = {
	["keys"] = true,
	["event_real"] = true,
	["mlw_briefcase"] = true,
	["mlw_briefcase_ex"] = true,
}

function DarkRP.IsHoldingKeys(ply)
	if not IsValid(ply) then return false end
	local wp = ply:GetActiveWeapon()
	if not IsValid(wp) then return true end
	if IsValid(wp) and keys_class[wp:GetClass()] then return true end

	return false
end

function DarkRP.IsHolding(ply, gun)
	if not IsValid(ply) then return false end
	local wp = ply:GetActiveWeapon()
	if IsValid(wp) and wp:GetClass() == gun then return true end

	return false
end

function DarkRP.IsOutside(pos)
	local trace = {}
	trace.start = pos
	trace.endpos = trace.start + Vector(0, 0, 99999)
	trace.mask = MASK_SOLID_BRUSHONLY
	local tr = util.TraceLine(trace)
	if (tr.StartSolid) then return false end
	if (tr.HitSky or tr.HitNoDraw) then return true end

	return false
end

function DarkRP.IsOutsideEnt(ent)
	local mins = ent:LocalToWorld(ent:OBBMins())
	local maxs = ent:LocalToWorld(ent:OBBMaxs())
	local startpos = ent:GetPos()
	local rays = {}

	local trace = {}
	trace.mask = MASK_SOLID_BRUSHONLY
	trace.start = startpos
	trace.endpos = trace.start + Vector(0, 0, 99999)
	table.insert(rays, util.TraceLine(trace))

	trace.start = mins + Vector(0,0,5)
	trace.endpos = trace.start + Vector(0, 0, 99999)
	table.insert(rays, util.TraceLine(trace))

	trace.start = maxs
	trace.endpos = trace.start + Vector(0, 0, 99999)
	table.insert(rays, util.TraceLine(trace))

	for _, tr in ipairs(rays) do
		if (tr.StartSolid) then continue end
		if (tr.HitSky or tr.HitNoDraw) then return true end
	end

	return false
end

function DarkRP.IsInRoom(listener, talker)
	local tracedata = {}
	tracedata.start = talker.GetShootPos and talker:GetShootPos() or talker:GetPos()
	tracedata.endpos = listener:GetShootPos()
	local trace = util.TraceLine(tracedata)

	return not trace.HitWorld
end

function DarkRP.InRange(ent1, ent2, range)
	return ent1:GetPos():DistToSqr(ent2:GetPos()) <= range ^ 2
end

function DarkRP.InRangeVector(v1, v2, range)
	return v1:DistToSqr(v2) <= range ^ 2
end

function DarkRP.InsidePDs(ply)
	for _, pos in pairs(GAMEMODE.Config.PDs) do
		if DarkRP.InRangeVector(pos[1], ply:GetPos(), pos[2]) then return true end
	end

	return false
end

function DarkRP.InsideArmory(ply)
	for _, pos in pairs(GAMEMODE.Config.PoliceArmory) do
		if DarkRP.InRangeVector(pos[1], ply:GetPos(), pos[2]) then return true end
	end

	return false
end

local entity = FindMetaTable("Entity")
local EmitSound = entity.EmitSound

function entity:EmitSound(sound, ...)
	if string.find(sound, "??", 0, true) then return end

	return EmitSound(self, sound, ...)
end

function DarkRP.getAvailableVehicles()
	local vehicles = list.Get("Vehicles")

	for k, v in pairs(list.Get("SCarsList") or {}) do
		vehicles[v.PrintName] = {
			Name = v.PrintName,
			Class = v.ClassName,
			Model = v.CarModel
		}
	end

	return vehicles
end

function DarkRP.toInt(value)
	value = tonumber(value)

	return value and math.floor(value)
end

function DarkRP.DeCasteljauBezier(p1, c1, c2, p2, t)
	local a = LerpVector(p1, c1, t)
	local b = LerpVector(c1, c2, t)
	local c = LerpVector(c2, p2, t)
	p1 = LerpVector(a, b, t)
	p2 = LerpVector(b, c, t)

	return LerpVector(p1, p2, t)
end

-- Bernstein
function DarkRP.BernsteinBezier(p1, c1, c2, p2, t)
	return p1 * (-t ^ 3 + 3 * t ^ 2 - 3 * t + 1) + c1 * (3 * t ^ 3 - 6 * t ^ 2 + 3 * t) + c2 * (-3 * t ^ 3 + 3 * t ^ 2) + p2 * t ^ 3
end

-- Polynomial Coefficients
function DarkRP.PolynomialBezier(p1, c1, c2, p2, t)
	return p1 + t * (-3 * p1 + 3 * c1) + t ^ 2 * (3 * p1 - 6 * c1 + 3 * c2) + t ^ 3 * (-p1 + 3 * c1 - 3 * c2 + p2)
end

local function DEC_36(IN)
	local B, K, OUT, I, D = 36, "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ", "", 0

	while IN > 0 do
		I = I + 1
		IN, D = math.floor(IN / B), math.fmod(IN, B) + 1
		OUT = string.sub(K, D, D) .. OUT
	end

	return OUT
end

local function DEC_26(IN)
	local B, K, OUT, I, D = 26, "ABCDEFGHIJKLMNOPQRSTUVWXYZ", "", 0

	while IN > 0 do
		I = I + 1
		IN, D = math.floor(IN / B), math.fmod(IN, B) + 1
		OUT = string.sub(K, D, D) .. OUT
	end

	return OUT
end

local function DEC_N(IN)
	local B, K, OUT, I, D = 10, "0123456789", "", 0

	while IN > 0 do
		I = I + 1
		IN, D = math.floor(IN / B), math.fmod(IN, B) + 1
		OUT = string.sub(K, D, D) .. OUT
	end

	return OUT
end

function DarkRP.GenerateHash(str)
	str = os.time() .. str .. math.floor(math.random() * 9)
	str = str:sub(1, 24)
	local num = 1

	for i = 1, 24 do
		num = num * ((tonumber(str:sub(i, i)) or 0) + 0.5) + i
	end

	local _str = DEC_36(num / 24 / 36)
	_str = _str:reverse():sub(1, 5):reverse()

	if #_str < 5 then
		for i = 1, 5 - #_str do
			_str = DEC_36(math.random() * 35) .. _str
		end
	end

	return _str
end

function DarkRP.GenLPlate(str)
	str = os.time() .. str .. math.floor(math.random() * 9)
	str = str:sub(1, 24)
	local num = 1

	for i = 1, 24 do
		num = num * ((tonumber(str:sub(i, i)) or 0) + 0.5) + i
	end

	local let = DEC_26(num / 12 / 26)
	let = let:reverse():sub(1, 3):reverse()

	if #let < 3 then
		for i = 1, 3 - #let do
			let = DEC_26(math.random() * 25) .. let
		end
	end

	local nms = DEC_N(num / 8 / 10)
	nms = nms:reverse():sub(1, 3):reverse()

	if #nms < 4 then
		for i = 1, 4 - #nms do
			nms = DEC_N(math.random() * 9) .. nms
		end
	end

	return let .. "@" .. nms
end

local wp_data = {
	"DefaultMag",
	"EjectCaseNum",
	"register",
	"SlotType",
	"CurRevolve",
	"RevolveData",
	"wskin"
}

function DarkRP.CopyGunDate(from, to)
	for _,d in ipairs(wp_data) do
		to[d] = from[d]
	end

	if SERVER and isentity(to) and to.ApplyWSkin then
		to:ApplyWSkin()
	end
end

function DarkRP.GetWeaponSkin(class, skin)
	if not skin or skin == "" then return end
	local wp = weapons.Get(class)
	return wp and wp.Skins and wp.Skins[skin]
end

function DarkRP.ApplyWeaponSkin(ent, class, skin)
	local data = DarkRP.GetWeaponSkin(class, skin)
	if not data then return end

	if data.wm_material then
		ent:SetMaterial(data.wm_material)
	end

	if data.wm_submaterials then
		for i, mat in pairs(data.wm_submaterials) do
			ent:SetSubMaterial(i, mat)
		end
	end
end

function DarkRP.CharacterID(ply)
	if ply:IsBot() then return ply:EntIndex() end

	return tostring(util.CRC(ply:AccountID() .. (ply:getDarkRPVar("character") or 1) + 25) + util.CRC(ply:FullName()))
end

function DarkRP.PassId(ply)
	if ply:IsBot() then return ply:EntIndex() end

	return tostring(util.CRC(ply:AccountID() .. (ply:getDarkRPVar("character") or 1) + 25) + util.CRC(os.date("%W", os.time()) .. ply:FullName()))
end

function DarkRP.findBYPassID(id)
	for k,v in ipairs(player.GetAll()) do
		if DarkRP.PassId(v) == id then return v end
	end

	return nil
end

function DarkRP.findBYCharacterID(id)
	for k,v in ipairs(player.GetAll()) do
		if DarkRP.CharacterID(v) == id then return v end
	end

	return nil
end

local pblock = {
	["collision"] = true,
	["bonemanipulate"] = true,
	["drive"] = true,
	["gravity"] = true,
	["keepupright"] = true,
	["extinguish"] = true,
	["npc_bigger"] = true,
	["npc_smaller"] = true,
	["ignite"] = true
}

hook.Add("CanProperty", "DarkRP.CanProperty", function(ply, property, ent)
	if ply:IsSuperAdmin() then return end
	if pblock[property] and not ply:IsAdmin() then return false end
	if property == "remover" and not DarkRP.IsHolding(ply, "gmod_tool") and not ply:IsAdmin() then return false end
	if IsValid(ent) and ent:MapCreationID() > 0 then return false end
	if IsValid(ent) and ent:GetClass() ~= "prop_physics" then return false end
end)

game.AddDecal("Blood.Stain1", "decals/bloodstain_001")
game.AddDecal("Blood.Stain2", "decals/bloodstain_002")
game.AddDecal("Blood.Stain3", "decals/bloodstain_101")
game.AddDecal("Blood.Stain5", "decals/bloodstain_003")
game.AddDecal("Blood.Stain6", "decals/bloodstain_003b")
game.AddDecal("Vomit", "decals/bloodstain_201")

sound.Add({
	name = "Player.DrownStart",
	channel = CHAN_VOICE,
	volume = 1.0,
	level = SNDLVL_75dB,
	sound = "npc/overwatch/radiovoice/_comma.wav"
})

local upd_weapons = {
	["weapon_molotov"] = true,
	["arrest_stick"] = true
}

hook.Add("UpdateInventory", "InvChecker", function(ply)
	local wp = ply:GetActiveWeapon()

	if IsValid(wp) and upd_weapons[wp:GetClass()] then
		wp:Deploy()
	end

	if CLIENT then return end

	if ply:getDarkRPVar("overs") and ply:GetInvSpace() <= ply:getDarkRPVar("invspace") then
		ply:SetSelfDarkRPVar("overs", nil)
	end

	if not ply:getDarkRPVar("overs") and ply:GetInvSpace() > ply:getDarkRPVar("invspace") then
		ply:SetSelfDarkRPVar("overs", true)
	end
end)

if SERVER then
	util.AddNetworkString("os.stime")

	net.Receive("os.stime", function(_, ply)
		--if ply.ossynced then return end
		ply.ossynced = true
		net.Start("os.stime")
			net.WriteDouble(os.time())
		net.Send(ply)
	end)

	function os.stime()
		return os.time()
	end
else
	net.Receive("os.stime", function()
		os.offset = net.ReadDouble() - SysTime()
	end)

	function os.stime()
		if not os.offset then net.SendSingleMessage("os.stime") return os.time() end
		return math.floor(SysTime() + os.offset)
	end
end

if CLIENT then
	return
end

hook.Add("PropBreak", "drp_AntiExploit", function(attacker, ent)
	if IsValid(ent) and ent:GetPhysicsObject():IsValid() then
		constraint.RemoveAll(ent)
	end
end)

local allowedDoors = {
	["prop_dynamic"] = true,
	["prop_door_rotating"] = true,
	[""] = true
}

local notallowed = {
	["gb_rp_sign_big"] = true,
	["gb_rp_sign"] = true,
}

hook.Add("CanTool", "DoorExploit", function(ply, trace, tool)
	if IsValid(trace.Entity) and trace.Entity:MapCreationID() > 0 and not ply:IsSuperAdmin() then return false end
	if not sAdmin.hasPermission(ply, "propspawn") and IsValid(trace.Entity) and notallowed[trace.Entity:GetClass()] then return false end
	if not IsValid(ply:GetActiveWeapon()) or not ply:GetActiveWeapon().GetToolObject or not ply:GetActiveWeapon():GetToolObject() then return end
	tool = ply:GetActiveWeapon():GetToolObject()
	if not allowedDoors[string.lower(tool:GetClientInfo("door_class") or "")] then return false end
end)

hook.Add("PlayerSpawnedNPC", "ChangeClose", function(ply, ent)
	local isfemale = string.find(ent:GetModel(), "female")

	for i,mat in ipairs(ent:GetMaterials()) do
		if string.find(mat, "citizen_sheet") then
			ent:SetSubMaterial(i - 1, "gbskins/" .. (isfemale and "female" or "male") .. "/sheet_" .. math.random(isfemale and 26 or 60))
			break
		end
	end
end)

local hide_chat = {
	["joinleave"] = true,
	["namechange"] = true,
	["servermsg"] = true,
	["teamchange"] = true,
}

hook.Add("ChatText", "DarkRP.ChatText", function( i, n, t, type )
	if hide_chat[type] then
		return true
	end
end)

local MAX_DIST_SQR = 100 * 100 -- how far a dismount point may be from the player

hook.Add("KeyPress", "Parabellum_LadderDismount", function(ply, key)
	if key ~= IN_USE or ply:GetMoveType() ~= MOVETYPE_LADDER then return end
	local best, bestDist = nil, MAX_DIST_SQR

	for _, ent in ipairs(ents.FindByClass("info_ladder_dismount")) do
		local d = ent:GetPos():DistToSqr(ply:GetPos())

		if d < bestDist then
			best, bestDist = ent, d
		end
	end

	if not best then return end
	local pos = best:GetPos()

	local tr = util.TraceHull({
		start = pos,
		endpos = pos,
		mins = ply:OBBMins(),
		maxs = ply:OBBMaxs(),
		filter = ply,
		mask = MASK_PLAYERSOLID
	})

	if tr.StartSolid then return end -- spot is occupied
	ply:ExitLadder()
	ply:SetPos(pos)

	DarkRP.ForceAnimation(ply, "crouch_to_stand", nil, 0.5)
end)