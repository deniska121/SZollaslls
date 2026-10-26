-- "addons\\mc_phone\\lua\\mc_phone\\sh_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- DO NOT EDIT ANYTHING HERE, UNLESS YOU KNOW WHAT YOU ARE DOING
-- Here you can create easter eggs :)
function McPhone.CanUsePhone(ply, is_payphone, incoming)
	if not ply:Alive() or (not is_payphone and not McPhone.HasPhone(ply)) then return false end
	if IsValid(ply.MCSInUse) then return false end
	if ply:getDarkRPVar("unconscious") or ply:getDarkRPVar("HandCuffed") then return false end
	--if then return false end
	if SERVER and not is_payphone and ply.McPhoneData and ply.McPhoneData.Sleep then return false end

	if not is_payphone then
		return not hook.Call("McPhone.Hook.BlockPhone", nil, ply, incoming)
	else
		return not hook.Call("McPhone.Hook.BlockPayPhone", nil, ply)
	end
end

function McPhone.HasPhone(ply)
	return McINV.GetPhone(ply)
end

McPhone.ExtraNumbers = {}

McPhone.ExtraNumbersFunc = {}

McPhone.ExtraNumbers["7465489"] = {
	delay = 3,
	icon = "nope.png",
	nicename = "PINK GUY",
	sound = {"http://macnco.one/sounds/eybossfum.mp3", true},
}

McPhone.ExtraNumbers["5552222"] = {
	delay = 6,
	icon = "nope.png",
	nicename = "5552222",
	sound = {"http://macnco.one/sounds/Niko.mp3", true},
	incoming = {"http://macnco.one/sounds/roman.mp3", true},
}

McPhone.ExtraNumbers["212355"] = {
	delay = 14.7,
	icon = "nope.png",
	nicename = "Public phone",
	sound = {"http://macnco.one/gmod/vo/p/UCT0.mp3", true},
	incoming = {"noire/call3.wav", false},
}

McPhone.ExtraNumbers["031137906"] = {
	delay = 3,
	icon = "nope.png",
	nicename = "Unknown",
	sound = {"http://macnco.one/gmod/vo/wtf.mp3", true},
}

McPhone.ExtraNumbers["555423478"] = {
	delay = 30,
	icon = "nope.png",
	nicename = "Classic Nails",
	sound = {{"http://macnco.one/gmod/vo/p/Classic Nails/CN1.mp3", "http://macnco.one/gmod/vo/p/Classic Nails/CN2.mp3", "http://macnco.one/gmod/vo/p/Classic Nails/CN3.mp3", "http://macnco.one/gmod/vo/p/Classic Nails/CN4.mp3",}, true},
}

McPhone.ExtraNumbers["88005553535"] = {
	delay = 12,
	icon = "nope.png",
	nicename = "+78005553535",
	sound = {"http://macnco.one/sounds/88005553535.mp3", true},
}

McPhone.ExtraNumbers["5551990"] = {
	delay = 60,
	icon = "nope.png",
	nicename = "Big Bill Hell's Cars",
	sound = {"http://macnco.one/sounds/big_bill.mp3", true},
}

McPhone.ExtraNumbers["55573235"] = {
	delay = 60,
	icon = "nope.png",
	nicename = "555-REBEL",
	sound = {"http://macnco.one/cityrp/phonesound/rnvcalldenied.mp3", true},
}

McPhone.ExtraNumbers["9523877"] = {
	delay = 1.4,
	icon = {"mc_phone/icons/contact.png", true},
	icon_call = "mc_phone/icons/contact.png",
	nicename = "Дилер Дезз",
	addtocontacts = true,
	checkNumber = function(ply)
		if ply:Team() ~= TEAM_GANG then return true end
	end,
	sound = {"https://macnco.one/gmod/vo/dezth/extra_dialogues/phone.mp3", true},
	func = "dealer",
	delay_func = "dealer",
}

McPhone.ExtraNumbers["5553232"] = {
	delay = 2,
	icon = {"mc_phone/icons/contact.png", true},
	icon_call = "mc_phone/icons/contact.png",
	nicename = "Регистратура(?)",
	addtocontacts = true,
	checkNumber = function(ply)
		if (ply:Team() ~= TEAM_POLICE and ply:Team() ~= TEAM_DETECTIVE) or not ply.MQSdata.Stored["police"] or ply.MQSdata.Stored["police"] ~= 1 then return true end
	end,
	sound = {"https://macnco.one/gmod/vo/yes.mp3", true},
	func = "police",
	delay_func = "police",
}

McPhone.ExtraNumbers["911"] = {
	delay = 3,
	icon = {"mc_phone/icons/contacts/char_call911.png", true},
	icon_call = "mc_phone/icons/contacts/char_call911.png",
	nicename = McPhone.GetPhrase("char_911"),
	addtocontacts = true,
	sound = {{"http://macnco.one/gmod/vo/p/911/1.mp3", "http://macnco.one/gmod/vo/p/911/2.mp3", "http://macnco.one/gmod/vo/p/911/3.mp3", "http://macnco.one/gmod/vo/p/911/4.mp3", "http://macnco.one/gmod/vo/p/911/5.mp3"}, true},
	func = "911",
	delay_func = "911_check",
}

McPhone.ExtraNumbers["5553867"] = {
	delay = 6,
	icon = {"mc_phone/icons/contacts/char_mechanic.png", true},
	icon_call = "mc_phone/icons/contacts/char_mechanic.png",
	nicename = "Сервис автомеханика",
	addtocontacts = true,
	checkNumber = function(ply)
		if ply:Team() == TEAM_CAR then return true end
		if #team.GetPlayers(TEAM_CAR) < 1 then return true end
	end,
	sound = {{"http://macnco.one/gmod/vo/p/Mechanic/M1.mp3", "http://macnco.one/gmod/vo/p/Mechanic/M2.mp3", "http://macnco.one/gmod/vo/p/Mechanic/M3.mp3", "http://macnco.one/gmod/vo/p/Mechanic/M4.mp3", "http://macnco.one/gmod/vo/p/Mechanic/M5.mp3"}, true},
	func = "5553867",
}

McPhone.ExtraNumbers["2227777777"] = {
	delay = 6,
	icon = "nope.png",
	nicename = "Self Storage",
	sound = {{"http://macnco.one/gmod/vo/p/Self Storage/SS1.mp3", "http://macnco.one/gmod/vo/p/Self Storage/SS2.mp3", "http://macnco.one/gmod/vo/p/Self Storage/SS3.mp3", "http://macnco.one/gmod/vo/p/Self Storage/SS4.mp3"}, true},
	func = "2227777777",
}

McPhone.ExtraNumbers["5551313"] = {
	delay = 13,
	icon = "nope.png",
	nicename = "Curry in a Hurry",
	sound = {{"http://macnco.one/gmod/vo/p/Curry in a Hurry/CH1.mp3", "http://macnco.one/gmod/vo/p/Curry in a Hurry/CH2.mp3", "http://macnco.one/gmod/vo/p/Curry in a Hurry/CH3.mp3", "http://macnco.one/gmod/vo/p/Curry in a Hurry/CH4.mp3", "http://macnco.one/gmod/vo/p/Curry in a Hurry/CH5.mp3"}, true},
}

McPhone.ExtraNumbers["5550254"] = {
	delay = 10,
	icon = "nope.png",
	nicename = "5550254",
	sound = {{"http://macnco.one/gmod/vo/p/Cleaners/C1.mp3", "http://macnco.one/gmod/vo/p/Cleaners/C2.mp3", "http://macnco.one/gmod/vo/p/Cleaners/C3.mp3", "http://macnco.one/gmod/vo/p/Cleaners/C4.mp3"}, true},
}

McPhone.ExtraNumbers["5556453"] = {
	delay = 16,
	icon = "nope.png",
	nicename = "5556453",
	sound = {{"http://macnco.one/gmod/vo/p/Handyman/H1.mp3", "http://macnco.one/gmod/vo/p/Handyman/H2.mp3", "http://macnco.one/gmod/vo/p/Handyman/H3.mp3", "http://macnco.one/gmod/vo/p/Handyman/H4.mp3"}, true},
}

McPhone.ExtraNumbers["5558752089"] = {
	delay = 17,
	icon = "nope.png",
	nicename = "Heating Supplies",
	sound = {{"http://macnco.one/gmod/vo/p/Heating Supplies/HS1.mp3", "http://macnco.one/gmod/vo/p/Heating Supplies/HS2.mp3", "http://macnco.one/gmod/vo/p/Heating Supplies/HS3.mp3", "http://macnco.one/gmod/vo/p/Heating Supplies/HS4.mp3"}, true},
}
McPhone.ExtraNumbers["5558373077"] = McPhone.ExtraNumbers["5558752089"]
McPhone.ExtraNumbers["5554762962"] = McPhone.ExtraNumbers["5558752089"]

McPhone.ExtraNumbers["5550119"] = {
	delay = 42,
	icon = "nope.png",
	nicename = "Hytex Corp",
	sound = {{"http://macnco.one/gmod/vo/p/Hytex/Hy1.mp3", "http://macnco.one/gmod/vo/p/Hytex/Hy2.mp3"}, true},
}

McPhone.ExtraNumbers["5555550198"] = {
	delay = 17,
	icon = "nope.png",
	nicename = "5550198",
	sound = {{"http://macnco.one/gmod/vo/p/Lucci/L1.mp3", "http://macnco.one/gmod/vo/p/Lucci/L2.mp3", "http://macnco.one/gmod/vo/p/Lucci/L3.mp3"}, true},
}
McPhone.ExtraNumbers["5550198"] = McPhone.ExtraNumbers["5555550198"]

McPhone.ExtraNumbers["5558672"] = {
	delay = 25,
	icon = "nope.png",
	nicename = "OSA Wholesale",
	sound = {{"http://macnco.one/gmod/vo/p/OSA Wholesale/OSA1.mp3", "http://macnco.one/gmod/vo/p/OSA Wholesale/OSA2.mp3", "http://macnco.one/gmod/vo/p/OSA Wholesale/OSA3.mp3", "http://macnco.one/gmod/vo/p/OSA Wholesale/OSA4.mp3", "http://macnco.one/gmod/vo/p/OSA Wholesale/OSA5.mp3"}, true},
}
McPhone.ExtraNumbers["5558673"] = McPhone.ExtraNumbers["5558672"]

McPhone.ExtraNumbers["5551155"] = {
	delay = 28,
	icon = "nope.png",
	nicename = "Sommers Real Estate",
	sound = {{"http://macnco.one/gmod/vo/p/Sommers Real Estate/SRE1.mp3", "http://macnco.one/gmod/vo/p/Sommers Real Estate/SRE2.mp3", "http://macnco.one/gmod/vo/p/Sommers Real Estate/SRE3.mp3", "http://macnco.one/gmod/vo/p/Sommers Real Estate/SRE4.mp3", "http://macnco.one/gmod/vo/p/Sommers Real Estate/SRE5.mp3"}, true},
}

McPhone.ExtraNumbers["5554321"] = {
	delay = 20,
	icon = "nope.png",
	nicename = "5554321",
	sound = {{"http://macnco.one/gmod/vo/p/Wine Liquor/T1.mp3", "http://macnco.one/gmod/vo/p/Toast/T2.mp3", "http://macnco.one/gmod/vo/p/Toast/T3.mp3", "http://macnco.one/gmod/vo/p/Toast/T4.mp3", "http://macnco.one/gmod/vo/p/Toast/T5.mp3"}, true},
}

McPhone.ExtraNumbers["5555050"] = {
	delay = 33,
	icon = "nope.png",
	nicename = "5555050",
	sound = {{"http://macnco.one/gmod/vo/p/Wine Liquor/WL1.mp3", "http://macnco.one/gmod/vo/p/Wine Liquor/WL2.mp3", "http://macnco.one/gmod/vo/p/Wine Liquor/WL3.mp3", "http://macnco.one/gmod/vo/p/Wine Liquor/WL4.mp3", "http://macnco.one/gmod/vo/p/Wine Liquor/WL5.mp3"}, true},
}

McPhone.ExtraNumbers["5555550"] = {
	delay = 33,
	icon = "nope.png",
	nicename = "5555550",
	sound = {"http://macnco.one/gmod/vo/p/Wine Liquor/WL5.mp3", true},
}

McPhone.ExtraNumbers["5553344"] = {
	delay = 10,
	icon = "nope.png",
	nicename = "5553344",
	sound = {{"http://macnco.one/gmod/vo/p/Drake Parking/D1.mp3", "http://macnco.one/gmod/vo/p/Drake Parking/D2.mp3", "http://macnco.one/gmod/vo/p/Drake Parking/D3.mp3", "http://macnco.one/gmod/vo/p/Drake Parking/D4.mp3", "http://macnco.one/gmod/vo/p/Drake Parking/D5.mp3"}, true},
}

McPhone.ExtraNumbers["8008124211"] = {
	delay = 8,
	icon = "nope.png",
	nicename = "8008124211",
	sound = {{"http://macnco.one/gmod/vo/p/OSHA/OSHA1.mp3", "http://macnco.one/gmod/vo/p/OSHA/OSHA2.mp3", "http://macnco.one/gmod/vo/p/OSHA/OSHA3.mp3"}, true},
}
McPhone.ExtraNumbers["8005551957"] = McPhone.ExtraNumbers["8008124211"]

McPhone.ExtraNumbers["8788700"] = {
	delay = 10,
	icon = "nope.png",
	nicename = "8788700",
	sound = {"http://macnco.one/gmod/vo/p/Pest1.mp3", true},
}

McPhone.ExtraNumbers["15005050139"] = {
	delay = 10,
	icon = "nope.png",
	nicename = "15005050139",
	sound = {"http://macnco.one/gmod/vo/p/Pest1.mp3", true},
}

McPhone.ExtraNumbers["5550523"] = {
	delay = 10,
	icon = "nope.png",
	nicename = "15005050139",
	sound = {"http://macnco.one/gmod/vo/p/Pest1.mp3", true},
}

McPhone.ExtraNumbers["0"] = {
	delay = 13,
	icon = "nope.png",
	nicename = "0",
	delay_func = "0",
	sound = {"http://macnco.one/gmod/vo/p/UCT0.mp3", true},
}

McPhone.ExtraNumbers["nomoney"] = {
	delay = 6,
	icon = "nope.png",
	nicename = "Нет средств",
	sound = {"http://macnco.one/gmod/vo/p/NM.mp3", true},
}

police_call = {
	"Убийство",
	"Ограбление",
	"Нарушение порядка",
	"Проникновение на тер.",
	"Помощь",
	"Нарушение закона",
	"Особый случай",
}

McPhone.ExtraNumbersFunc["0"] = function(pPlayer, ph)
	if not ph then return true end
end

McPhone.ExtraNumbersFunc["911"] = function()
	local lmenu = (IsValid(McPhone.UI) and McPhone.UI) or (McPhone.PayPhone and IsValid(McPhone.PayPhone.UI) and McPhone.PayPhone.UI)
	if not IsValid(lmenu) or not lmenu.Menu then return end
	local back = lmenu.GoBack
	lmenu.Menu.ConvertToList()
	lmenu.OpenedMenu = McPhone.GetPhrase("char_911")

	local function police()
		lmenu.Menu:Clear()

		for _, v in ipairs(police_call) do
			McPhone.ListNoIcons(lmenu.Menu, v, function()
				net.Start("services_request")
					net.WriteString("NYPD")
					net.WriteString(v)
				net.SendToServer()
				back()
			end, true)
		end
	end

	McPhone.ListSimple(lmenu.Menu, "Полиция", "", "mc_phone/icons/settings/id_3.png", function()
		police()
	end, true)

	McPhone.ListSimple(lmenu.Menu, "Скорая помощь", "", "mc_phone/icons/buttons/id16.png", function()
		net.Start("services_request")
			net.WriteString("FDNY")
			net.WriteString("Запрос скорой медицинской помощи")
		net.SendToServer()
		back()
	end, true)

	McPhone.ListSimple(lmenu.Menu, "Пожарные", "", "mc_phone/icons/buttons/id12.png", function()
		net.Start("services_request")
			net.WriteString("FDNY")
			net.WriteString("Возгорание, пожар")
		net.SendToServer()
		back()
	end, true)

	McPhone.SetKey(1, true)
end

McPhone.ExtraNumbersFunc["5553867"] = function(pPlayer)
	local lmenu = (IsValid(McPhone.UI) and McPhone.UI) or (McPhone.PayPhone and IsValid(McPhone.PayPhone.UI) and McPhone.PayPhone.UI)
	if not IsValid(lmenu) or not lmenu.Menu then return end
	local back = lmenu.GoBack
	lmenu.Menu.ConvertToList()
	lmenu.OpenedMenu = "Сервис автомеханика"

	McPhone.ListSimple(lmenu.Menu, "Связаться с механиком", "", "mc_phone/icons/buttons/id17.png", function()
		back()
		for k, tower in RandomPairs(team.GetPlayers(TEAM_CAR)) do
			if not tower:Alive() then continue end
			net.Start("McPhone.CallStart")
			net.WriteString(McPhone.NumberChar(tower))
			net.WriteBool(true)
			net.WriteString("5553867")
			net.SendToServer()
		end
	end, true)

	McPhone.SetKey(1, true)
end

McPhone.ExtraNumbersFunc["2227777777"] = function(pPlayer)
	local lmenu = (IsValid(McPhone.UI) and McPhone.UI) or (McPhone.PayPhone and IsValid(McPhone.PayPhone.UI) and McPhone.PayPhone.UI)
	if not IsValid(lmenu) or not lmenu.Menu then return end
	local back = lmenu.GoBack
	lmenu.Menu.ConvertToList()
	lmenu.OpenedMenu = "Self Storage"

	for i = 1,5 do
		McPhone.ListSimple(lmenu.Menu, "Арендовать Юнит " .. i, "$50", "mc_phone/icons/buttons/id2.png", function()
			net.Start("territoryBuy") net.WriteString("garage_unit_" .. i) net.SendToServer()
			back()
		end, true)
	end

	McPhone.ListSimple(lmenu.Menu, "Арендовать Юнит 7", "$50", "mc_phone/icons/buttons/id2.png", function()
		net.Start("territoryBuy") net.WriteString("garage_unit_7") net.SendToServer()
		back()
	end, true)

	McPhone.SetKey(1, true)
end

local crype_table = {
	"criminal_rob_jewelry",
	"criminal_2_flat",
	"criminal_3_threat",
	"criminal_4_drug",
	"criminal_5_car",
	"criminal_6_dirty",
	"criminal_escapism",
	"criminal_8_revelation",
	"criminal_radiant_1"
}

local police_table = {
	"police_1_paint",
	"police_2_car",
	"police_3_drugs",
	"police_4_partner",
	"police_story_threat",
	"police_6_unit",
	"police_7_strange",
	"police_8_illusion",
	"police_9_hope",
	"police_10_escapism",
	"police_radiant_1",
}

McPhone.ExtraNumbersFunc["dealer"] = function()
	local lmenu = (IsValid(McPhone.UI) and McPhone.UI) or (McPhone.PayPhone and IsValid(McPhone.PayPhone.UI) and McPhone.PayPhone.UI)
	if not IsValid(lmenu) or not lmenu.Menu then return end
	local back = lmenu.GoBack
	lmenu.Menu.ConvertToList()
	lmenu.OpenedMenu = "Дезз"

	function m_sets()
		lmenu.Menu:Clear(true)
		McPhone.StopSound()
		lmenu.OpenedMenu = "Задания"

		for _,id in pairs(crype_table) do
			if not MQS.CanStartTask(id) or not MQS.Quests[id] then continue end
			McPhone.ListIcons(lmenu.Menu, "mc_phone/icons/settings/id_2.png", MQS.Quests[id].name, false, function()
				net.Start("MQS.StartTask")
				net.WriteString(id)
				net.SendToServer()
				back()
			end)
		end
	end

	McPhone.ListSimple(lmenu.Menu, "Нужно встретиться", "", "mc_phone/icons/settings/id_3.png", function()
		net.Start("MCS.Dialogue")
			net.ReadUInt(0, 15)
		net.SendToServer()
		back()
	end, true)

	if LocalPlayer().MQSdata.Stored["dezz"] and LocalPlayer().MQSdata.Stored["dezz"] == 4 and game.GetMap() ~= "rp_southside" then
		McPhone.ListSimple(lmenu.Menu, "Задания", "", "mc_phone/icons/settings/id_2.png", function()
			m_sets()
		end, true)
	end

	McPhone.SetKey(1, true)
end

McPhone.ExtraNumbersFunc["police"] = function()
	local lmenu = (IsValid(McPhone.UI) and McPhone.UI) or (McPhone.PayPhone and IsValid(McPhone.PayPhone.UI) and McPhone.PayPhone.UI)
	if not IsValid(lmenu) or not lmenu.Menu then return end
	local back = lmenu.GoBack
	lmenu.Menu.ConvertToList()
	lmenu.OpenedMenu = "Кто это вообще?"

	function m_sets()
		lmenu.Menu:Clear(true)
		McPhone.StopSound()
		lmenu.OpenedMenu = "Задания"

		for _,id in pairs(police_table) do
			if not MQS.CanStartTask(id) or not MQS.Quests[id] then continue end
			McPhone.ListIcons(lmenu.Menu, "mc_phone/icons/settings/id_2.png", MQS.Quests[id].name, false, function()
				net.Start("MQS.StartTask")
				net.WriteString(id)
				net.SendToServer()
				back()
			end)
		end
	end

	if LocalPlayer().MQSdata.Stored["police"] and LocalPlayer().MQSdata.Stored["police"] == 1 and game.GetMap() ~= "rp_southside" then
		McPhone.ListSimple(lmenu.Menu, "Задания", "", "mc_phone/icons/settings/id_2.png", function()
			m_sets()
		end, true)
	end

	McPhone.SetKey(1, true)
end

if SERVER then
	McPhone.ExtraNumbersFunc["911_check"] = function()
		return false
	end

	McPhone.ExtraNumbersFunc["police"] = function(caller)
		if not caller:isCP() or caller:isWanted() or caller:isArrested() or MQS.HasQuest(caller) then
			return true
		end

		return false
	end

	McPhone.ExtraNumbersFunc["dealer"] = function(caller)
		if caller:Team() ~= TEAM_GANG then return true end

		if caller:isWanted() or caller:isArrested() or MQS.HasQuest(caller) then
			return true
		end

		if caller.MQSdata.Stored["dezz"] and caller.MQSdata.Stored["dezz"] < 0 then
			return true
		end

		if IsValid(MCS.Dealler) and DarkRP.InRange(caller, MCS.Dealler, 2000) then
			return true
		end

		if caller.HasDillerInfo and caller.HasDillerInfo > CurTime() then
			return true
		end

		return false
	end
end

function McPhone.LoadAddons()

end

if SERVER then
	hook.Add("PostGamemodeLoaded", "McPhone.LoadAddons", function()
		McPhone.LoadAddons()
	end)
end

if GAMEMODE then
	McPhone.LoadAddons()
end

function McPhone.GetCurTime()
	local time = "00:00"
	time = os.date("%H:%M", os.time())

	if McPhone.Config.StormFoxTime and StormFox then
		time = StormFox.GetRealTime(nil, false)
	end

	return time
end

function McPhone.NumberChar(ply)
	if not ply then return "0" end
	local str = util.CRC(ply:AccountID() .. (ply:getDarkRPVar("character") or 1) .. ply:FullName())
	str = str:sub(1, 7)

	return str
end

function McPhone.GetByCharNumber(number)
	for _,ply in ipairs(player.GetAll()) do
		if IsValid(ply) and tostring(McPhone.NumberChar(ply)) == tostring(number) then
			return ply
		end
	end
end

function McPhone.GetByNumber(number)
	if McPhone.ExtraNumbers[number] then return McPhone.ExtraNumbers[number] end

	return McPhone.GetByCharNumber(number)
end

function McPhone.AddContacts(number, name, show)
	if SERVER then
		if not IsValid(show) then return end
		net.Start("McPhone.Comtact")
			net.WriteString(number)
			net.WriteString(name)
		net.Send(show)
		return
	end

	number = tostring(number)

	if McPhone.Contacts[number] then
		if McPhone.Contacts[number] ~= name then
			McPhone.Contacts[number] = name
		end

		return
	end

	if not number or not name then return end
	McPhone.Contacts[number] = name
	local num_name = nil

	if show then
		num_name = name
	end

	McPhone.Notify(McPhone.GetPhrase("new_сontact"), num_name)
	McPhone.UpdateContacts()
end