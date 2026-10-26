--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/slib/vgui/cl_splayerpanel.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}

local font = slib.createFont("Roboto", 15)
local textcolor, maincolor_7 = slib.getTheme("textcolor"), slib.getTheme("maincolor", 7)

function PANEL:Init()
    local tall = slib.getScaledSize(25, "y")
    self:SetTall(tall)
    self:Dock(TOP)

    self.playerImage = vgui.Create("AvatarImage", self)
    self.playerImage:SetSize(tall, tall)

    self:DockMargin(0, 0, 0, slib.getTheme("margin"))
    self:GetParent():DockPadding(slib.getTheme("margin"), slib.getTheme("margin"), slib.getTheme("margin"), slib.getTheme("margin"))
end

function PANEL:addButton(title, func)
    local bttn = vgui.Create("SButton", self)
    bttn:setTitle(title)
    :Dock(RIGHT)
    :DockMargin(0,slib.getTheme("margin"),slib.getTheme("margin"),slib.getTheme("margin"))

    bttn.DoClick = func

    return self
end

function PANEL:setPlayer(ply)
    self.ply = ply
    self.name = self.ply:SteamName()
    self.playerImage:SetPlayer(ply, 64)

    return self
end

function PANEL:Paint(w,h)
    if !self.ply then self:Remove() end

    surface.SetDrawColor(maincolor_7)
    surface.DrawRect(0, 0, w, h)

    if self.ply then
        draw.SimpleText(self.name, font, slib.getScaledSize(25, "y") + slib.getTheme("margin"), h * .5, textcolor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end
end

vgui.Register("SPlayerPanel", PANEL, "EditablePanel")