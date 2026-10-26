--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/autorun/sadmin_loader.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if slib and slib.loadFolder then
	slib.loadFolder("s_admin/", true, {
		{"s_admin/", "sh_sadmin_config.lua"},
		{"s_admin/core/", "sh_utils.lua"}
	}, {
		{"s_admin/integrations/", "sh_cami.lua"},
		{"s_admin/", "cl_quickaccess.lua"},
		{"s_admin/integrations/", "sv_logging.lua"}
	})
end

hook.Add("slib:loadedUtils", "sA:Init_sAdmin", function()
	slib.loadFolder("s_admin/", true, {
		{"s_admin/", "sh_sadmin_config.lua"},
		{"s_admin/core/", "sh_utils.lua"}
	}, {
		{"s_admin/integrations/", "sh_cami.lua"},
		{"s_admin/", "cl_quickaccess.lua"},
		{"s_admin/integrations/", "sv_logging.lua"}
	})
end)