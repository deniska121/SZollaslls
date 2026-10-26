--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/shared/commands.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DarkRP.SingleWep = {}

DarkRP.SingleWep.PistolWeps = {
	["mwb_357"] = true,
	["mwb_deagle"] = true,
	["mwb_m1911"] = true,
	["mwb_sw4506"] = true,
	["mwb_pm"] = true,
	["mwb_m9"] = true,
	["mwb_93r"] = true,
	["mwb_glock21"] = true,
	["mwb_glock17"] = true,
	["mwb_glock19"] = true,
	["mwb_p220"] = true,
	["mwb_tec9"] = true,
	["police_glock"] = true,
	["police_sw"] = true,
	["police_m1911"] = true,
	["police_p320"] = true,
	["mwb_93r"] = true
}

DarkRP.SingleWep.RifleWeps = {
	["mwb_akm"] = true,
	["mwb_ak74"] = true,
	["mwb_ak74u"] = true,
	["mwb_spapa12"] = true,
	["mwb_m590"] = true,
	["mwb_ithaca"] = true,
	["mwb_mk17"] = true,
	["mwb_marlin"] = true,
	["mwb_kar98"] = true,
	["mwb_c725"] = true,
	["mwb_mp5"] = true,
	["mwb_m4"] = true,
	["mwb_m4a1"] = true,
	["mwb_uzi"] = true,
	["mwb_thompson"] = true,
	["mwb_mac10"] = true,
	["mwb_aug"] = true,
	["mwb_auga2"] = true,
	["police_beanbag"] = true,
	["police_m590"] = true,
	["police_mp5"] = true,
	["police_m4"] = true,
	["police_mk18"] = true,
	["police_mk20"] = true
}

DarkRP.SingleWep.MeleeWeps = {
	["weapon_crowbar"] = true,
	["weapon_fish"] = true,
	["weapon_molotov"] = true,
	["lockpick"] = true,
	["mlw_bat"] = true,
	["mlw_pickaxe"] = true,
	["mlw_club"] = true,
	["mlw_sledge"] = true,
	["mlw_crowbar"] = true,
	["mlw_briefcase"] = true,
	["mlw_spade"] = true,
	["mlw_machete"] = true,
	["mlw_knife"] = true,
	["mlw_fireaxe"] = true,
	["mlw_hatchet"] = true,
	["mlw_pipe"] = true,
	["mlw_torch"] = true,
	["mlw_hammer"] = true,
}

DarkRP.SingleWep.AllWeps = {}

DarkRP.SingleWep.FireArms = {}

table.Merge( DarkRP.SingleWep.FireArms, DarkRP.SingleWep.PistolWeps )
table.Merge( DarkRP.SingleWep.FireArms, DarkRP.SingleWep.RifleWeps )

table.Merge( DarkRP.SingleWep.AllWeps, DarkRP.SingleWep.PistolWeps )
table.Merge( DarkRP.SingleWep.AllWeps, DarkRP.SingleWep.RifleWeps )
table.Merge( DarkRP.SingleWep.AllWeps, DarkRP.SingleWep.MeleeWeps )

DarkRP.SingleWep.DisallowDrop = {
	["police_glock"] = true,
	["police_sw"] = true,
	["police_m1911"] = true,
	["weapon_taser"] = true,
	["mlw_tonfa"] = true,
	["mlw_policelight"] = true,
	["weapon_ram"] = true,
	["med_kit"] = true,
	["med_pd"] = true,
	["weapon_jail"] = true,
	["police_beanbag"] = true,
	["police_m590"] = true,
	["police_mp5"] = true,
	["police_m4"] = true,
	["police_mk18"] = true,
	["police_mk20"] = true,
}

local meta = FindMetaTable("Player")

function meta:HasPistol(filter)
	for _, wep in pairs(self:GetWeapons()) do
		if wep == filter then continue end
		if (wep.SlotType and wep.SlotType == 2) or (not wep.SlotType and DarkRP.SingleWep.PistolWeps[wep:GetClass()]) then return wep end
	end

	return false
end

function meta:HasRifle(filter)
	for _, wep in pairs(self:GetWeapons()) do
		if wep == filter then continue end
		if (wep.SlotType and wep.SlotType == 1) or (not wep.SlotType and DarkRP.SingleWep.RifleWeps[wep:GetClass()]) then return wep end
	end

	return false
end

function meta:HasMelee(filter)
	for _, wep in pairs(self:GetWeapons()) do
		if wep == filter then continue end
		if DarkRP.SingleWep.MeleeWeps[wep:GetClass()] then return wep end
	end

	return false
end

function DarkRP.IsUniformPolice(ply)
	local t = ply:Team()
	return t == TEAM_POLICE or t == TEAM_WARDEN or t == TEAM_SWAT or t == TEAM_POLICESV
end

function DarkRP.CanConcealWeapon(wep)
	return DarkRP.SingleWep.PistolWeps[wep:GetClass()] and not wep.DontHide
end

function DarkRP.IsWeaponConcealed(ply, wep)
	return DarkRP.CanConcealWeapon(wep) and ((MCR.HasTatoo(ply, "a1") and not DarkRP.IsUniformPolice(ply)) or wep:GetNWBool("HiddenWep"))
end

hook.Add("PlayerSwitchWeapon", "DarkRP.HiddenWeapon", function(ply, wep, nwep)
	if IsValid(nwep) and nwep:GetNWBool("HiddenWep") then return true end
end)


if (SERVER) then
	hook.Add("PlayerCanPickupWeapon", "DarkRP.SingleWep.PlayerCanPickupWeapon", function(ply, wep)
		wep.invPickTime = CurTime()

		if (DarkRP.SingleWep.PistolWeps[wep:GetClass()] or DarkRP.SingleWep.RifleWeps[wep:GetClass()]) and sAdmin.mcTime(ply) < MCR.Config.TimeNeed[3] then
			if not ply.notetimer or CurTime() > ply.notetimer then
				DarkRP.notify(ply, 1, 4, "Оружие будет доспуно после разблокировки персонажа 'Нелегал'.")
				ply.notetimer = CurTime() + 5
			end

			return false
		end

		if (DarkRP.SingleWep.PistolWeps[wep:GetClass()] or DarkRP.SingleWep.RifleWeps[wep:GetClass()]) and ply:getDarkRPVar("karma") and ply:getDarkRPVar("karma") < (ply:getDarkRPVar("character") and ply:getDarkRPVar("character") == 1 and 80 or 10) then
			if not ply.notetimer or CurTime() > ply.notetimer then
				DarkRP.notify(ply, 1, 4, "Оружие доставляет дискомфорт вашему шаткому рассудку.")
				ply.notetimer = CurTime() + 5
			end

			return false
		end

		if MCR.HasTatoo(ply, "a8") and DarkRP.SingleWep.AllWeps[wep:GetClass()] then
			local aw = ply:GetActiveWeapon()

			if IsValid(aw) and DarkRP.SingleWep.AllWeps[aw:GetClass()] then
				if not ply.notetimer or CurTime() > ply.notetimer then
					DarkRP.notify(ply, 1, 4, "У вас уже есть оружие")
					ply.notetimer = CurTime() + 5
				end
				return false
			end

			return true
		end

		if (wep.SlotType and wep.SlotType == 2) or (not wep.SlotType and DarkRP.SingleWep.PistolWeps[wep:GetClass()]) then
			if ply:HasPistol() then
				if not ply.notetimer or CurTime() > ply.notetimer then
					DarkRP.notify(ply, 1, 4, "У вас уже есть легкое оружие")
					ply.notetimer = CurTime() + 5
				end

				return false
			end
		elseif (wep.SlotType and wep.SlotType == 1) or (not wep.SlotType and DarkRP.SingleWep.RifleWeps[wep:GetClass()]) then
			if ply:HasRifle() then
				if not ply.notetimer or CurTime() > ply.notetimer then
					DarkRP.notify(ply, 1, 4, "У вас уже есть оружие за спиной")
					ply.notetimer = CurTime() + 5
				end

				return false
			end
		elseif DarkRP.SingleWep.MeleeWeps[wep:GetClass()] then
			if ply:HasMelee() then
				if not ply.notetimer or CurTime() > ply.notetimer then
					DarkRP.notify(ply, 1, 4, "У вас уже есть холодное оружие")
					ply.notetimer = CurTime() + 5
				end

				return false
			end
		end
	end)

	hook.Add( "PlayerSwitchWeapon", "DarkRP.SingleWep.DropOnChange", function( ply, wep, nwep )
		if IsValid(nwep) then
			local class = nwep:GetClass()

			if DarkRP.SingleWep.AllWeps[class] then
				ply.lastRPWeapon = class
			else
				timer.Simple(0.1, function()
					if not IsValid(ply) then return end
					ply.lastRPWeapon = class
				end)
			end
		end

		if not IsValid(wep) or wep.Droping or DarkRP.SingleWep.DisallowDrop[wep:GetClass()] then return end

		--if MCR.HasTatoo(ply, "a8") then
			if (wep.SlotType and wep.SlotType == 2) or (not wep.SlotType and DarkRP.SingleWep.PistolWeps[wep:GetClass()]) then
				if ply:HasPistol(wep) then
					wep.Droping = true
					ply:DropDRPWeapon(wep)
					return
				end
			elseif (wep.SlotType and wep.SlotType == 1) or (not wep.SlotType and DarkRP.SingleWep.RifleWeps[wep:GetClass()]) then
				if ply:HasRifle(wep) then
					wep.Droping = true
					ply:DropDRPWeapon(wep)
					return
				end
			end
		--end

		if DarkRP.SingleWep.MeleeWeps[wep:GetClass()] and not wep.MQS_weapon then
			wep.Droping = true
			DarkRP.DropHeldWeapon(ply, wep)

			if IsValid(wep) and ply:HasWeapon(wep:GetClass()) then
				ply:DropDRPWeapon(wep)
			end
			return
		end

		if not wep.GivenByTeam and ply:isCP() and DarkRP.SingleWep.FireArms[wep:GetClass()] and not ply:IsSuperAdmin() then
			wep.Droping = true
			ply:DropDRPWeapon(wep)
			return
		end

		if ply.insuit and DarkRP.SingleWep.RifleWeps[wep:GetClass()] then
			wep.Droping = true
			ply:DropDRPWeapon(wep)
			DarkRP.notify(ply, 1, 4, "Вы не можете убрать тяжёлое оружие за спину, будучи в костюме!")
		end
	end)
end

local res_walk = {
	["weapon_ram"] = true,
	["weapon_axe"] = true,
	["fire_hose"] = true
}

local res_jump = {
	["weapon_ram"] = true,
}

local runpenalty = {
	["mwb_ak74u"] = 0.96,
	["mwb_ak74"] = 0.93,
	["mwb_akm"] = 0.93,
	["mwb_m4"] = 0.93,
	["mwb_m4a1"] = 0.93,
	["mwb_aug"] = 0.93,
	["mwb_auga2"] = 0.93,
	["mwb_mk17"] = 0.93,
	["mwb_kar98"] = 0.83,
	["mwb_marlin"] = 0.9,
	["mwb_uzi"] = 0.93,
	["mwb_thompson"] = 0.93,
	["mwb_mp5"] = 0.98,
	["mwb_mac10"] = 0.96,
	["mwb_tec9"] = 0.96,
	["mwb_c725"] = 0.92,
	["mwb_m590"] = 0.92,
	["mwb_ithaca"] = 0.92,
	["mwb_spapa12"] = 0.8,
	["weapon_ram"] = 0.7,
}

hook.Add("Move", "HC_Move", function(ply, d)
	if ply:getDarkRPVar("unconscious") then d:SetVelocity(Vector()) return end

	if ply:GetMoveType() == MOVETYPE_NOCLIP or IsValid(ply.pk_pill_ent) then return end

	local CT = CurTime()
	local cm = ply:Crouching() and 0.5 or 1

	if ply:Crouching() then
		d:SetMaxSpeed(90)
	end

	if ply:getDarkRPVar("fanim") and ply:getDarkRPVar("fanim") + (CLIENT and 1 or 0) > CT then
		d:SetMaxSpeed(0)
		return
	end

	local wep = ply:GetActiveWeapon()

	if IsValid(wep) and wep.Handcuffs and CT < wep.ArrestTime then
		d:SetMaxSpeed(0)
		return
	end

	if ply:getDarkRPVar("deoxygen") and ply:getDarkRPVar("deoxygen") > 50 then
		d:SetMaxSpeed(d:GetMaxSpeed() * math.max(1 - (ply:getDarkRPVar("deoxygen") - 50) / 50, 0.5) )
	end

	if ply:Armor() > 0 or ply:getDarkRPVar("armorVest") then
		d:SetMaxSpeed(d:GetMaxSpeed() * 0.9)
	end

	if ply:getDarkRPVar("overs") then
		d:SetMaxSpeed(d:GetMaxSpeed() * 0.5)
	end

	if ply:getDarkRPVar("Player.Drag") then
		d:SetMaxSpeed(30 * cm)
		return
	end

	if ply:getDarkRPVar("dragging") then
		d:SetMaxSpeed(d:GetMaxSpeed() * (ply:getDarkRPVar("dragging") * 0.1) * cm)
		return
	end

	if (ply:WaterLevel() > 0 or (IsValid(wep) and wep.EventItem) or ply:Health() < 30 or ply:getDarkRPVar("shock") or (ply:getDarkRPVar("fracture") and not ply:getDarkRPVar("morph"))) and d:GetMaxSpeed() > 70 then
		d:SetMaxSpeed(70 * cm)
		return
	end

	if IsValid(wep) and (res_walk[wep:GetClass()] or wep.runpenalty) then
		if res_jump[wep:GetClass()] then d:SetButtons(bit.band(d:GetButtons(), bit.bnot(IN_JUMP))) end
		d:SetMaxSpeed(math.min(d:GetMaxSpeed() * 0.5, 100) * cm)
		return
	end

	if ply:getDarkRPVar("meth") then
		d:SetMaxSpeed(400)
	end

	if ply.LastDamage and ply.LastDamage + 0.3 > CT and not ply:getDarkRPVar("coca") and not ply:getDarkRPVar("heroin") then
		d:SetMaxSpeed(math.max(0.01, d:GetMaxSpeed() * 0.1))
		d:SetMaxClientSpeed(math.max(0.01, d:GetMaxClientSpeed() * 0.1))
	end

	local f = d:GetAngles()
	f.p = 0
	f = f:Forward() * 0.9

	if d:GetVelocity():Dot(f) < 1 then
		d:SetMaxSpeed(math.min(d:GetMaxSpeed() * 0.5, 100))
	end

	for _, w in pairs(ply:GetWeapons()) do
		if runpenalty[w:GetClass()] then
			d:SetMaxSpeed(d:GetMaxSpeed() * runpenalty[w:GetClass()])
		end
	end

	d:SetMaxSpeed(d:GetMaxSpeed() * (ply:getDarkRPVar("bag") and 1 - ply:getDarkRPVar("bag") / 40 or 1) * cm)
end)