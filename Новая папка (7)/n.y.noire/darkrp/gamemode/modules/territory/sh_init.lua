--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/territory/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if Territories then return end
Territories = Territories or {}
Territories.list = Territories.list or {}

local ter_list_dics = {}

function checkRights(ply)
	return sAdmin.hasPermission(ply, "propspawn")
end

TERRITORY_TYPE_BUYABLE = 0
TERRITORY_TYPE_PUBLIC = 1
TERRITORY_TYPE_TEAM = 2
TERRITORY_TYPE_JOB = 3

TERRITORY_TYPE_TABLE = {
	[0] = "TERRITORY_TYPE_BUYABLE",
	[1] = "TERRITORY_TYPE_PUBLIC",
	[2] = "TERRITORY_TYPE_TEAM",
	[3] = "TERRITORY_TYPE_JOB"
}

local TER_NON_COM = {
	["apartment"] = true,
	["big_house"] = true,
	["house"] = true
}

TERRITORY_PROPSPAWN_ALLOWED_EVERYONE = 0
TERRITORY_PROPSPAWN_ALLOWED_OWNERS = 1
TERRITORY_PROPSPAWN_ALLOWED_NOONE = 2

TERRITORY_PROPSPAWN_TABLE = {
	[0] = "TERRITORY_PROPSPAWN_ALLOWED_EVERYONE",
	[1] = "TERRITORY_PROPSPAWN_ALLOWED_OWNERS",
	[2] = "TERRITORY_PROPSPAWN_ALLOWED_NOONE"
}

TERRITORY_DOOR_ACTION_LOCK = 0
TERRITORY_DOOR_ACTION_UNLOCK = 1
TERRITORY_DOOR_ACTION_DEFAULT = 2

TERRITORY_DOOR_ACTION_TABLE = {
	[0] = "TERRITORY_DOOR_ACTION_LOCK",
	[1] = "TERRITORY_DOOR_ACTION_UNLOCK",
	[2] = "TERRITORY_DOOR_ACTION_DEFAULT"
}

function IsInPolygon(vertices, x, y, z, height)
	local intersectionCount = 0
	local x0 = vertices[#vertices].x - x
	local y0 = vertices[#vertices].y - y
	local min

	for i = 1, #vertices do
		if not min or vertices[i].z < min then
			min = vertices[i].z
		end

		local x1 = vertices[i].x - x
		local y1 = vertices[i].y - y

		if y0 > 0 and y1 <= 0 and x1 * y0 > y1 * x0 then
			intersectionCount = intersectionCount + 1
		end

		if y1 > 0 and y0 <= 0 and x0 * y1 > y0 * x1 then
			intersectionCount = intersectionCount + 1
		end

		x0 = x1
		y0 = y1
	end

	if z < min or z > min + height then return false end

	return (intersectionCount % 2) == 1
end

local playerMeta = FindMetaTable("Player")

function playerMeta:IsTerritoryMasterOwner(territory)
	return territory.buyable and territory.masterOwner == self
end

function playerMeta:IsTerritoryOwner(territory)
	if self:Team() == 0 then return false end
	return territory.buyable and territory.masterOwner == self or (territory.extraOwners and territory.extraOwners[self:AccountID()])
end

setmetatable(Territories, {
	__call = function(self, name) return self:Get(name) end
})

function Territories:New(name, type)
	local t
	if type == TERRITORY_TYPE_BUYABLE then
		t = table.Merge({
			name = name
		}, table.Copy(BuyableTerritory))
	elseif type == TERRITORY_TYPE_TEAM then
		t = table.Merge({
			name = name
		}, table.Copy(TeamTerritory))
	elseif type == TERRITORY_TYPE_JOB then
		t = table.Merge({
			name = name
		}, table.Copy(JobTerritory))
	elseif type == TERRITORY_TYPE_PUBLIC then
		t = table.Merge({
			name = name
		}, table.Copy(PublicTerritory))
	end

	self.list[name] = t
	t.type = type

	return t
end

function Territories:__call(name)
	return self.list[name]
end

function Territories:Get(name)
	return self.list[name]
end

local TERRITORY = {}
TERRITORY.printName = "Territory"
TERRITORY.doors = {}
TERRITORY.visitors = {}

function TERRITORY:Init()
	for k, v in pairs(self.doors) do
		if self.lockDoors == TERRITORY_DOOR_ACTION_UNLOCK then
			v:Fire("unlock", "", 0)
		elseif self.lockDoors == TERRITORY_DOOR_ACTION_LOCK then
			v:Fire("lock", "", 0)
		end
	end
end

function TERRITORY:DoorAction()
end

function TERRITORY:IsInsideV(vec)
	return IsInPolygon(self.coords, vec.x, vec.y, vec.z, self.height)
end

function TERRITORY:IsInside(ent)
	return IsInPolygon(self.coords, ent:GetPos().x, ent:GetPos().y, ent:GetPos().z, self.height)
end

function TERRITORY:OnInitialEnter(ply)
	ply.currentTerritory = self
	self.visitors[ply:UserID()] = true
	self:OnEnter(ply)

	if self.onEnterSV then
		self.onEnterSV(self, ply)
	end
end

function TERRITORY:OnInitialExit(ply)
	ply.currentTerritory = nil
	self.visitors[ply:UserID()] = nil
	self:OnExit(ply)

	if self.onEnterSV then
		self.onExitSV(self, ply)
	end
end

function TERRITORY:IsEmpty()
	for k, v in pairs(self.visitors) do
		if IsValid(Player(k)) then
			return false
		end
	end

	return true
end

function TERRITORY:OnEnter(ply)
	if self:AllowedPropSpawn(ply) then
		self:GiveWeapons(ply)
	end
	ply.LastTerritiry = self
end

function TERRITORY:OnExit(ply)
	if self:AllowedPropSpawn(ply) then
		self:StripWeapons(ply)
	end
end

function TERRITORY:StripWeapons(ply)
	if checkRights(ply) then return end

	ply:StripWeapon("weapon_physgun")
	ply:StripWeapon("gmod_tool")
end

function TERRITORY:GiveWeapons(ply)
	if checkRights(ply) then return end

	ply:Give("weapon_physgun")
	ply:Give("gmod_tool")
end

RP_TYPE = 0
RP_TYPE_ROBERRY = 1
RP_TYPE_PICKPOCKET = 2
RP_TYPE_LOCKPICK = 3
RP_TYPE_PROP_SPAWN = 4
RP_TYPE_ARREST = 5
RP_TYPE_SLUT = 6

function TERRITORY:RPAction(type, ply)
	return true
end

function TERRITORY:AllowedPropSpawn(ply)
	return self.propSpawn ~= TERRITORY_PROPSPAWN_ALLOWED_NOONE and (self.propSpawn == TERRITORY_PROPSPAWN_ALLOWED_OWNERS and ply:IsTerritoryOwner(self) or self.propSpawn == TERRITORY_PROPSPAWN_ALLOWED_EVERYONE)
end

function playerMeta:OwnedPrtCount(cur)
	if self:IsAdmin() then return 0 end

	local count = 0

	for k, v in pairs(Territories.list) do
		if self:IsTerritoryMasterOwner(v) then
			if not TER_NON_COM[cur.type] and not TER_NON_COM[v.type] then
				return 10
			end
			count = count + 1
		end
	end

	return count
end

BuyableTerritory = table.Merge({}, TERRITORY)
BuyableTerritory.price = 150
BuyableTerritory.masterOwner = nil
BuyableTerritory.isboutby = nil
BuyableTerritory.syndicate = nil
BuyableTerritory.extraOwners = {}
BuyableTerritory.buyable = true
BuyableTerritory.money = 0
BuyableTerritory.permaOwner = nil
BuyableTerritory.permaExtraOwners = {}
BuyableTerritory.warnings = 0
BuyableTerritory.propSpawn = nil

function BuyableTerritory:keysUnOwn(discon)
	for k, v in pairs(self.doors) do
		if not IsValid(v) or not v:isDoor() then continue end
		v:keysUnOwn()
		v:setKeysNonOwnable(true)
		DarkRP.updateDoorData(v, "owner")
		DarkRP.updateDoorData(v, "nonOwnable")
		v:Fire("Unlock", "", 0)
		v:Fire("Close", "", 0.1)
		v:Fire("Lock", "", 0.5)
	end

	if discon then
		ter_list_dics[self.name] = {CurTime() + 600, self.masterOwner:SteamID()}
	end

	self.propetytype = nil
	self.masterOwner = nil
	self.extraOwners = {}

	for k, v in pairs(self.visitors) do
		if IsValid(Player(k)) then
			self:StripWeapons(Player(k))
		end
	end

	if self.EntTable then
		for k, v in pairs(self.EntTable) do
			if IsValid(v) then
				v:Remove()
			end
		end

		self.EntTable = {}
	end

	TerritoriesInfoUpdate()
end

function BuyableTerritory:SetOwner(ply)

	self.masterOwner = ply

	for k, v in pairs(self.doors) do
		if not IsValid(v) then continue end
		v:setKeysNonOwnable(false)
		v:keysOwn(ply)
		v:setKeysTitle(nil)
		v:removeAllKeysExtraOwners()
		v:removeAllKeysAllowedToOwn()
		DarkRP.updateDoorData(v, "owner")
		DarkRP.updateDoorData(v, "nonOwnable")
		if v:GetClass() == "func_door" and not self.noDoorAction then
			v:Fire("unlock", "", 0)
			v:Fire("Open")
			v:Fire("Lock")
		end
	end

	return
end

function BuyableTerritory:Owned()
	return self.masterOwner or self.syndicate or self.permaOwner
end

function BuyableTerritory:DoorAction(e)
end

function BuyableTerritory:OnBuy(ply)
	if self:Owned() then return end

	local price = self.price

	if ter_list_dics[self.name] and ter_list_dics[self.name][1] > CurTime() then
		if ter_list_dics[self.name][2] ~= ply:SteamID() then
			return
		else
			price = 0
		end
	end

	if not ply:canAfford(price) then
		DarkRP.notify(ply, 1, 5, "У вас не хватает средств для покупки")
		return
	end

	if ply:OwnedPrtCount(self) > 2 then
		timer.Simple(math.random(5), function()
			if not IsValid(ply) then return end
			McPhone.NewMail("SkyLine Риелтор", "К сожалению, мы не смогли одобрить ваш запрос из-за ограничения на лимита на недвижимость этого типа.", ply)
		end)
		return
	end

	ply:addMoney(-price)

	DarkRP.log("property", ply, nil, "купил недвижимость " .. "[" .. (self.name or "null") .. "] " .. (self.printName or "null") .. " " ..  (self.printStr or "") .. " за $" .. price)
	if price > 0 then
		timer.Simple(10 + math.random(5) * 5, function()
			if not IsValid(ply) then return end
			McPhone.NewMail("SkyLine Риелтор", "Вы купили недвижимость " .. self.printName .. " за $" .. price .. ". Местоположение вашей недвижимости было добавлено к вам в GPS", ply)
			TerritoriesInfoUpdate(ply)
		end)
	else
		DarkRP.notify(ply, 0, 5, "Мы вернули ваше помещение без дополнительной платы")
	end

	self:SetOwner(ply)

	if self:IsInside(ply) then
		self:GiveWeapons(ply)
	end

	self.isboutby = ply

	if self.buySpawn then
		for _, v in ipairs(self.buySpawn) do
			local ent = ents.Create(v.e)
			ent:SetPos(v.p)
			ent:SetAngles(v.a)
			ent:Spawn()

			if IsValid(ent) then
				if self.EntTable then
					table.insert(self.EntTable, ent)
				else
					self.EntTable = {ent}
				end
			end
			ent:DrawShadow(false)

			if v.m then
				ent:SetModel(v.m)
				ent:PhysicsInit(SOLID_VPHYSICS)
			end

			local phys = ent:GetPhysicsObject()

			if IsValid( phys ) then
				phys:EnableMotion(false)
			end

			if v.sf then
				v.sf(ent, self)
			end
		end
	end
end

function BuyableTerritory:OnSell(ply)
	if not (ply:IsTerritoryMasterOwner(self)) then return end
	McPhone.NewMail("SkyLine Риелтор", "Вы продали недвижимость " .. self.printName .. " за $" .. self.price * 0.5 .. ".", ply)

	self.isboutby = nil
	ply:addMoney(self.price * 0.5)
	self:keysUnOwn()
	net.Start("TerritoryOnSellAdd")
	net.WriteString(self.name)
	net.Send(ply)
	TerritoriesInfoUpdate(ply)
	DarkRP.log("property", ply, nil, "продал недвижимость " .. "[" .. (self.name or "null") .. "] " .. (self.printName or "null") .. " " ..  (self.printStr or "") .. " за $" .. self.price * 0.5)
end

function BuyableTerritory:AddOwner(ply)
	self.extraOwners[ply:AccountID()] = true
	if self:IsInside(ply) then
		self:OnEnter(ply)
	end

	for k, v in pairs(self.doors) do
		v:addKeysDoorOwner(ply)
	end

	McPhone.NewMail("SkyLine Риелтор", "Вам выдали доступ к недвижимости " .. self.printName, ply)
end

function BuyableTerritory:RemoveOwner(ply)
	if CLIENT then return end
	self.extraOwners[ply:AccountID()] = nil

	if self:IsInside(ply) then
		self:OnExit(ply)
	end

	for k, v in pairs(self.doors) do
		v:removeKeysDoorOwner(ply)
	end
	McPhone.NewMail("SkyLine Риелтор", "У вас забрали доступ к недвижимости " .. self.printName, ply)
end

function BuyableTerritory:RPAction(tp, ply)
	return (tp == RP_TYPE_PROP_SPAWN and ply:IsTerritoryOwner(self)) or tp ~= RP_TYPE_PROP_SPAWN
end

TeamTerritory = table.Merge({}, TERRITORY)

function TeamTerritory:DoorAction(e)
	e:setDoorGroup(self.group)
end

function TeamTerritory:RPAction(tp, ply)
	return tp ~= RP_TYPE_PROP_SPAWN
end

JobTerritory = table.Merge({}, TERRITORY)

function JobTerritory:DoorAction(e)
end

function JobTerritory:RPAction(tp, ply)
	return tp ~= RP_TYPE_PROP_SPAWN
end

PublicTerritory = table.Merge({}, TERRITORY)

function PublicTerritory:RPAction(tp, ply)
	return tp == RP_TYPE_ARREST
end

function PublicTerritory:DoorAction(e)
end

local map = string.lower(game.GetMap())
map = "data/" .. map .. ".lua"

include(map)

if SERVER then
	AddCSLuaFile(map)
end