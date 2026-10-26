--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/core/sh_meta.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local meta = FindMetaTable("Player")

meta.oldIsAdmin = meta.oldIsAdmin or meta.IsAdmin

function meta:IsAdmin()
	local usergroup = self:GetUserGroup()
	if sAdmin.config["super_users"][self:SteamID64()] or usergroup == "admin" then return true end
	if sAdmin.usergroups and sAdmin.usergroups["admin"] and sAdmin.usergroups[usergroup] and sAdmin.usergroups[usergroup].permissions then
		local admin_immunity, ug_immunity = sAdmin.usergroups["admin"].permissions and sAdmin.usergroups["admin"].permissions.immunity or 0, sAdmin.usergroups[usergroup].permissions and sAdmin.usergroups[usergroup].permissions.immunity or 0

		return tonumber(ug_immunity) >= tonumber(admin_immunity)
	else
		return self:oldIsAdmin()
	end
end

meta.oldIsSuperAdmin = meta.oldIsSuperAdmin or meta.IsSuperAdmin

function meta:IsSuperAdmin()
	local usergroup = self:GetUserGroup()
	if sAdmin.config["super_users"][self:SteamID64()] or usergroup == "superadmin" then return true end
	if sAdmin.usergroups and sAdmin.usergroups["superadmin"] and sAdmin.usergroups[usergroup] and sAdmin.usergroups[usergroup].permissions then
		local sa_immunity, ug_immunity = sAdmin.usergroups["superadmin"].permissions and sAdmin.usergroups["superadmin"].permissions.immunity or 0, sAdmin.usergroups[usergroup].permissions and sAdmin.usergroups[usergroup].permissions.immunity or 0

		return tonumber(ug_immunity) >= tonumber(sa_immunity)
	else
		return self:oldIsSuperAdmin()
	end
end