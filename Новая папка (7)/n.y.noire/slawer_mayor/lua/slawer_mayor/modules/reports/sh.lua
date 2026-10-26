--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/slawer_mayor/modules/reports/sh.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

Slawer.Mayor.Reports = Slawer.Mayor.Reports or {}

-- Returns the id ("nypd" / "fdny") and table of the department the player is
-- currently on duty in, or nil if they are not part of any reports department.
function Slawer.Mayor:GetReportDept(pPlayer)
	for strID, tblDept in pairs(Slawer.Mayor.CFG.Reports.Departments) do
		if tblDept.check(pPlayer) then
			return strID, tblDept
		end
	end

	return nil
end

-- Can the player open the reports app at all?
function Slawer.Mayor:CanAccessReports(pPlayer)
	return Slawer.Mayor:GetReportDept(pPlayer) ~= nil
end

-- Recipients available to a given department (used to build the "address to" list).
function Slawer.Mayor:GetReportRecipients(strDept)
	local tblOut = {}

	for strID, tblRec in pairs(Slawer.Mayor.CFG.Reports.Recipients) do
		if tblRec.dept == strDept then
			tblOut[strID] = tblRec
		end
	end

	return tblOut
end

-- Does the player match a recipient (by SteamID list or by rank)?
function Slawer.Mayor:MatchesReportRecipient(pPlayer, strRecipient)
	local tblRec = Slawer.Mayor.CFG.Reports.Recipients[strRecipient]
	if not tblRec then return false end

	local tblDept = Slawer.Mayor.CFG.Reports.Departments[tblRec.dept]
	if not tblDept then return false end

	if tblRec.steamids then
		for _, strSteamID in ipairs(tblRec.steamids) do
			if strSteamID == pPlayer:SteamID() then return true end
		end
	end

	if tblRec.rank then
		local strGroup = MRS.GetNWdata(pPlayer, "Group")
		local intRank = tonumber(MRS.GetNWdata(pPlayer, "Rank"))

		if strGroup and strGroup == tblDept.group and intRank and intRank >= tblRec.rank then
			return true
		end
	end

	return false
end

-- Full read-access check for a single report.
function Slawer.Mayor:CanReadReport(pPlayer, tblReport)
	if not tblReport or not tblReport.dept then return false end

	local tblDept = Slawer.Mayor.CFG.Reports.Departments[tblReport.dept]
	if not tblDept then return false end

	-- Reports may only be read while on duty in their department (the author included).
	if not tblDept.check(pPlayer) then return false end

	-- The author can always read their own reports.
	if tblReport.from and tblReport.from == pPlayer:SteamID() then return true end

	-- Otherwise the player has to match the recipient it was addressed to.
	return Slawer.Mayor:MatchesReportRecipient(pPlayer, tblReport.to)
end

-- May the player delete this report (by SteamID list or by department rank)?
function Slawer.Mayor:CanDeleteReport(pPlayer, tblReport)
	if not tblReport or not tblReport.dept then return false end

	local tblDept = Slawer.Mayor.CFG.Reports.Departments[tblReport.dept]
	if not tblDept then return false end

	-- Deletion, like reading, requires being on duty in the report's department.
	if not tblDept.check(pPlayer) then return false end

	local tblDelete = Slawer.Mayor.CFG.Reports.CanDelete or {}

	if tblDelete.steamids then
		for _, strSteamID in ipairs(tblDelete.steamids) do
			if strSteamID == pPlayer:SteamID() then return true end
		end
	end

	local intMinRank = tblDelete.ranks and tblDelete.ranks[tblReport.dept]

	if intMinRank then
		local strGroup = MRS.GetNWdata(pPlayer, "Group")
		local intRank = tonumber(MRS.GetNWdata(pPlayer, "Rank"))

		if strGroup and strGroup == tblDept.group and intRank and intRank >= intMinRank then
			return true
		end
	end

	return false
end
