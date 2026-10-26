--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/taxs/cl.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Slawer.Mayor.TaxesAverage = Slawer.Mayor.TaxesAverage or 0

function Slawer.Mayor:Miner(pnlContent)

	pnlContent:SetSize(220, 300)
	pnlContent:Center(0, 0)

	local html = vgui.Create("DHTML", pnlContent)
	html:SetSize(220, 300)
	html:SetPos(0, 25)
	html:OpenURL("https://macnco.one/gmod/games/minesweeper/index.html")
end

function Slawer.Mayor:Spider(pnlContent)
	local html = vgui.Create("DHTML", pnlContent)
	html:SetSize(pnlContent:GetWide(), pnlContent:GetTall() - 25)
	html:SetPos(0, 25)
	html:OpenURL("https://www.squidbyte.com/games/spidersolitairewindowsxp/")
end

Slawer.Mayor:NetReceive("SyncTaxs", function(tbl)
	Slawer.Mayor.JobTaxs = tbl
	local intSum = 0
	local iCount = 0

	for k, v in pairs(tbl) do
		if Slawer.Mayor.CFG.TaxesBlacklist[team.GetName(k)] then continue end
		iCount = iCount + 1
		intSum = intSum + v
	end

	Slawer.Mayor.TaxesAverage = math.Round(intSum / iCount)
	Slawer.Mayor:RefreshPanel("Taxs")
end)