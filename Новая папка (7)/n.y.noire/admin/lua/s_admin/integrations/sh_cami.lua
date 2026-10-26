--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/s_admin/integrations/sh_cami.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

timer.Simple(.1, function()
    for k,v in pairs(CAMI.GetPrivileges and CAMI.GetPrivileges() or {}) do
        sAdmin.registerPermission(v.Name or k, "CAMI", false, true)
    end
end)

hook.Add("CAMI.OnPrivilegeRegistered", "sA:RegisterPrivlege", function(priv)
    sAdmin.registerPermission(istable(priv) and priv.Name or priv, "CAMI", false, true)
end)

hook.Add("CAMI.PlayerHasAccess", "sA:HasAccess", function(ply, privname, cb)
    local result = sAdmin.hasPermission(ply, privname)
    if cb then
        cb(result)
    end

    return result, "N/A"
end)