--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/glac/lua/glac/sh_core.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Glac.Items = Glac.Items or {}
Glac.ItemList = Glac.ItemList or {}
Glac.Cases = Glac.Cases or {}
Glac.Packs = Glac.Packs or {}
Glac.Builders = Glac.Builders or {}

function Glac.AddItem(key, item)
	item.key = key

	if Glac.Items[key] then
		for i, v in ipairs(Glac.ItemList) do
			if v.key == key then
				Glac.ItemList[i] = item
				break
			end
		end
	else
		table.insert(Glac.ItemList, item)
	end

	Glac.Items[key] = item

	if item.Category == "Pack" then
		Glac.Packs[key] = item
	end

	return item
end

function Glac.AddCase(id, item)
	item.is_case = id
	Glac.AddItem(id, item)
	Glac.Cases[id] = {}

	return item
end

function Glac.AddDrop(caseId, key, chance)
	table.insert(Glac.Cases[caseId], {item = key, chance = chance})
end

function Glac.GetPrice(item, ply)
	return item.priceUpdater and item.priceUpdater(ply) or item.Price
end

-- Sorts case drops, most common first, and returns chance -> colour (common cyan, rare towards red).
-- Safe with no drops, a single drop, or equal chances.
function Glac.SortDrops(drop)
	local low, high

	for _, d in ipairs(drop) do
		low = math.min(low or d.chance, d.chance)
		high = math.max(high or d.chance, d.chance)
	end

	table.sort(drop, function(a, b) return a.chance > b.chance end)

	local step = (high and high > low) and 210 / (high - low) or 0

	return function(chance)
		return HSLToColor(180 + (high - chance) * step, 0.89, 0.57)
	end
end

function Glac.FormatCredits(num)
	return string.Comma(num) .. " ¤"
end

function Glac.GetCredits(ply)
	if CLIENT then
		return Glac.Credits or 0
	end

	return ply.GlacCredits or 0
end

function Glac.Once(flag)
	return function(ply)
		return not MQS.GetDataStored(ply, flag)
	end
end

function Glac.GiveBankItem(ply, inv, item, count)
	for _ = 1, count or 1 do
		ply:AddBankItem(inv, item)
	end
end

function Glac.AddCarSlot(ply)
	local slots = MQS.GetDataStored(ply, "car_slots") or 0
	MQS.SetNWStoredData(ply, "car_slots", math.max(slots, 0) + 1)
end

function Glac.Rebuild()
	Glac.Items, Glac.ItemList, Glac.Cases, Glac.Packs = {}, {}, {}, {}

	for _, builder in ipairs(Glac.Builders) do
		local ok, err = pcall(builder.fn)

		if not ok then
			ErrorNoHalt("[Glac] config '" .. builder.name .. "' failed: " .. tostring(err) .. "\n")
		end
	end

	Glac.Ready = true
	hook.Run("Glac.Loaded")
end

function Glac.QueueRebuild()
	if not Glac.Ready then return end

	timer.Create("Glac.Rebuild", 0, 1, Glac.Rebuild)
end

function Glac.RegisterConfig(name, fn)
	for _, builder in ipairs(Glac.Builders) do
		if builder.name == name then
			builder.fn = fn
			Glac.QueueRebuild()
			return
		end
	end

	table.insert(Glac.Builders, {name = name, fn = fn})
	Glac.QueueRebuild()
end

hook.Add("InitPostEntity", "Glac.Load", function()
	timer.Simple(10, Glac.Rebuild)
end)