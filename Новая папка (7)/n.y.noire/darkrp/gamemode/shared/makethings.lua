--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/shared/makethings.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local team_cl =  Color(255,150,0)

local jobByCmd = {}
sound.AddSoundOverrides("scripts/day.txt")
function DarkRP.createJob(name, team_table)
	local CustomTeam = team_table
	CustomTeam.name = name
	CustomTeam.color = team_cl

	jobByCmd[team_table.command] = table.insert(DarkRP.Teams, CustomTeam)
	team.SetUp(#DarkRP.Teams, name, team_cl)
	local Team = #DarkRP.Teams

	return Team
end

function DarkRP.getJobByCommand(cmd)
	if not jobByCmd[cmd] then return nil, nil end
	return DarkRP.Teams[jobByCmd[cmd]], jobByCmd[cmd]
end

RPExtraTeamDoors = {}
RPExtraTeamDoorIDs = {}
local maxTeamDoorID = 0

function AddDoorGroup(name, ...)
	RPExtraTeamDoors[name] = {}

	for k,v in ipairs({...}) do
		RPExtraTeamDoors[name][v] = true
	end

	maxTeamDoorID = maxTeamDoorID + 1
	RPExtraTeamDoorIDs[name] = maxTeamDoorID
end

function DarkRP.createShipment(name, customShipment)
	customShipment.name = name
	customShipment.allowed = customShipment.allowed or {}

	DarkRP.Weapons[customShipment.entity] = customShipment
	util.PrecacheModel(customShipment.model)
end

function DarkRP.createEntity(name, tblEnt)
	if type(tblEnt.allowed) == "number" then
		tblEnt.allowed = {tblEnt.allowed}
	end

	tblEnt.name = name
	DarkRP.Entities[tblEnt.ent] = tblEnt
end

function DarkRP.PlayerBuyItem(ply, ctype, class, count, bank, web, cprice)
	if CLIENT then
		net.Start("DarkRP.PlayerBuyItem")
			net.WriteString(ctype)
			net.WriteString(class)
			net.WriteUInt(math.Clamp(count,0,100), 7)
			net.WriteBool(bank)
		net.SendToServer()
		return
	end

	count = count or 1
	if not IsValid(ply) then return end

	if not DarkRP[ctype] then return end

	local ent_data = table.Copy(DarkRP[ctype][class])
	if not ent_data then return end

	if not web and not (not ent_data.shop or ent_data.shop ~= "rdm" or ent_data.shop ~= "green") then
		return
	end

	if ent_data.nonbuy then
		return
	end

	if not web then
		local nosh = true
		for _,v in ipairs(ents.FindInSphere( ply:GetPos(), 300 )) do
			if v:GetClass() ~= "mcs_npc" or not v.vendor then continue end
			nosh = nil
		end

		if nosh then return end
	end

	if ent_data.job and not ent_data.job[ply:Team()] then
		DarkRP.notify(ply, 1, 4, "Вы не можете это купить")
		return
	end

	local tax = 0

	if ent_data.sell_empty then
		ent_data.dt = {
			Ammo = 0
		}
	end

	cprice, tax = McINV.Tax(cprice or (ent_data.price or 1), McINV.DarkRPTypes[ctype], ent_data)
	cprice = cprice * count
	tax = tax * count

	local prox_w = ent_data.weight

	if ent_data.uses then
		prox_w = ent_data.uses * ent_data.weight + (ent_data.conwht or 0)
	end

	local hasspace = bank and ply:HaveBankSpace(prox_w * count or 0) or ply:HaveSpace(prox_w * count or 0)

	if not hasspace then
		DarkRP.notify(ply, 1, 4, "У вас нет места")
		return
	end

	if not ply:canAfford(cprice) then
		DarkRP.notify(ply, 1, 4, "У вас недостаточно средств")
		return
	end

	if ent_data.xp and ply:JobXP(ent_data.xp[1]) < (ent_data.xp[2] * count) then
		DarkRP.notify(ply, 1, 4, "У вас недостаточно очков опыта")
		return
	end

	if bank then
		if Slawer.Mayor.GetTickets(ply) > 4 then
			McPhone.NewMail("Bank of Union", "Транзакция не удалась: ваша карта заблокирована.\n\nОплатите действующие штрафы и попробуйте снова. В случае удержания блокировки карты после оплаты штрафов - обратитесь в отделение, где вы оформляли карту.\n\nВаш Bank of Union.", ply)
			return
		end

		McPhone.NewMail("WC Logistics", "Ваш заказ был оформлен, ожидайте доставки.\nДетали заказа:\n" .. ent_data.name .. " | " .. count .. " шт.\nЦена: " .. cprice .. "$", ply)

		local logistic = (math.Rand(20, 28) * 10) - Slawer.Mayor:GetUpgradeLevel(2) * 35
		timer.Simple(logistic, function()
			if not IsValid(ply) then return end

			if not ply:HaveBankSpace(prox_w * count or 0) then
				McPhone.NewMail("WC Logistics", "Ваш заказ был отменён. Посылка была возвращена со склада из за отсутствия места у вас в хранилище", ply)

				return
			end

			if not ply:canAfford(cprice) or (ent_data.xp and ply:JobXP(ent_data.xp[1]) < ent_data.xp[2]) then
				McPhone.NewMail("WC Logistics", "Ваш заказ был отменён. У вас недостаточно средств что бы оплатить заказ.", ply)

				return
			end

			if tax > 0 then
				Slawer.Mayor:AddFunds(tax)
			end

			ply:addMoney(-cprice)
			if ent_data.xp then
				ply:JobXPAdd(ent_data.xp[1], -ent_data.xp[2])
			end

			ent_data.dltime = os.time() + (9600 - logistic)

			for i = 1, count do
				McINV.AddCustomItem(ply, ctype, class, ent_data, true)
			end

			McPhone.NewMail("WC Logistics", "Ваш заказ прибыл! Вы можете забрать свой заказ из вашего хранилища в любое время", ply)
			DarkRP.log("money", ply, nil, "купил " .. ent_data.name .. " за $" .. cprice, nil, count)

			local mb
			for _, v in ipairs(ents.FindByClass("mailbox")) do
				if not v:CanLoot(ply) then continue end

				if not mb or mb:DistToSqr(ply:GetPos()) > v:GetPos():DistToSqr(ply:GetPos()) then
					mb = v:GetPos()
				end
			end

			if mb then
				McPhone.ToggleGPS(ply, "Доставка", mb)
			end
		end)

		return
	end

	if tax > 0 then
		Slawer.Mayor:AddFunds(tax)
	end
	ply:addMoney(-cprice)

	if ent_data.xp then
		ply:JobXPAdd(ent_data.xp[1], -(ent_data.xp[2] * count))
	end

	DarkRP.notify(ply, 0, 4, "Вы купили " .. ent_data.name .. " | " .. count .. " шт. за " .. cprice .. "$")
	DarkRP.log("money", ply, nil, "купил " .. ent_data.name .. " за $" .. cprice, nil, count)
	for i = 1, count do
		McINV.AddCustomItem(ply, ctype, class, ent_data)
	end
end