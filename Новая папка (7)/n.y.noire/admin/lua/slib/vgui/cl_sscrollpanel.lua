--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/slib/vgui/cl_sscrollpanel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}

local elegantcol, maincol, maincol_5 = Color(255,255,255,3), slib.getTheme("maincolor"), slib.getTheme("maincolor", 5)

function PANEL:Init()
    local scr = self:GetVBar()
    scr:SetHideButtons(true)

    scr.Paint = function(_, w, h)
        surface.SetDrawColor(maincol)
        surface.DrawRect(0,0,w,h)
    end    
    scr.btnUp.Paint = function(_, w, h)end
    scr.btnDown.Paint = function(_, w, h)end
    scr.btnGrip.Paint = function(me, w, h)
        MSDX.Draw(h * .5, w * 0.5 - (w * 0.45 / 2), h * 0.03, w * 0.45, h - h * 0.06, elegantcol)
    end

    slib.wrapFunction(self, "SetSize", nil, function() return self end, true)
	slib.wrapFunction(self, "Center", nil, function() return self end, true)
	slib.wrapFunction(self, "SetPos", nil, function() return self end, true)
    slib.wrapFunction(self, "Dock", nil, function() return self end, true)
    slib.wrapFunction(self, "DockMargin", nil, function() return self end, true)
    slib.wrapFunction(self, "SetTall", nil, function() return self end, true)
end

function PANEL:Paint(w,h)
    if self.bg then
        surface.SetDrawColor(self.bg)
        surface.DrawRect(0,0,w,h)
    end
end

vgui.Register("SScrollPanel", PANEL, "DScrollPanel")