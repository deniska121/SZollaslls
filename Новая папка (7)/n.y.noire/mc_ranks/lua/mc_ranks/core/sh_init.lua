--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_ranks/lua/mc_ranks/core/sh_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- ╔═╗╔═╦═══╦═══╗───────────────────────
-- ║║╚╝║║╔═╗║╔═╗║───────────────────────
-- ║╔╗╔╗║╚═╝║╚══╗──By MacTavish <3──────
-- ║║║║║║╔╗╔╩══╗║───────────────────────
-- ║║║║║║║║╚╣╚═╝║───────────────────────
-- ╚╝╚╝╚╩╝╚═╩═══╝───────────────────────

local Ln = MSD.GetPhrase

MRS.PlayerStats["Salary bonus"] = {
	check = function()
		if not DarkRP then return true end
	end,
	data = {2,false,false},
	icon = Material("msd/icons/account-cash.png", "smooth"),
	apply = function(ply, data)
		if not MRS.GetSelfNWdata(ply, "SalaryBonus") then
			MRS.SetSelfNWdata(ply, "SalaryBonus", ply:getDarkRPVar("salary"))
		end
		if data[2] and not data[3] then
			ply:SetSelfDarkRPVar("salary", data[1])
			return
		end
		local sal = DarkRP.Teams[ply:Team()] and DarkRP.Teams[ply:Team()].salary or 0
		if data[3] then
			ply:SetSelfDarkRPVar("salary", sal * data[1])
			return
		end
		ply:SetSelfDarkRPVar("salary", sal + data[1])
	end,
	revoke = function(ply)
		if MRS.GetSelfNWdata(ply, "SalaryBonus") then
			ply:SetSelfDarkRPVar("salary", MRS.GetSelfNWdata(ply, "SalaryBonus"))
			MRS.SetSelfNWdata(ply, "SalaryBonus", nil)
		end
	end,
	uisize = 3,
	buildUI = function(panel, data)
		MSD.TextEntry(panel, "static", nil, 1, 50, Ln("e_number"), Ln("salary_value") .. ":", data[1], function(self, value)
			data[1] = tonumber(value) or 0
		end, true, nil, nil, true)
		local sld = MSD.DTextSlider(panel, "static", nil, 1, 50, Ln("salary_set"), Ln("salary_add"), data[2], function(self, value)
			data[2] = value
		end)
		sld.disabled = data[3]
		MSD.BoolSlider(panel, "static", nil, 1, 50, Ln("salary_multiply"), data[3], function(self, value)
			data[3] = value
			sld.disabled = value
		end)
	end
}