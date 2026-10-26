--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/admin/lua/slib/vgui/cl_sdropdown.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}

local hovercolor, margin = slib.getTheme("hovercolor"), slib.getTheme("margin")
local icon = MSD.Icons48.arrow_down

function PANEL:Init()
    self:setTitle("Select Option", TEXT_ALIGN_LEFT)
    self.iteration = 0
    self.options = {}

    self.close = vgui.Create("DButton")
    self.close:Dock(FILL)
    self.close:SetText("")
    self.close:SetVisible(false)

    self.close.Paint = function() end

    self.close.DoClick = function()
        self.close:SetVisible(false)
        if IsValid(self.droppedMenu) then
            self.droppedMenu:SetVisible(false)
        end

        if isfunction(self.onClose) then self.onClose(self) end
    end

    self.droppedMenu = vgui.Create("EditablePanel")
    self.droppedMenu:SetWide(self:GetWide())
    self.droppedMenu:SetVisible(false)
end

function PANEL:SetPlaceholder(str)
    self:setTitle(str, TEXT_ALIGN_LEFT)
end

function PANEL:OnRemove()
    if IsValid(self.droppedMenu) then self.droppedMenu:Remove() end
end

function PANEL:popupAlone()
    self:DoClick()

    local x, y = input.GetCursorPos()
    if !IsValid(self.droppedMenu) then return end
    self.droppedMenu:SetWide(self:GetWide())
    self.droppedMenu:SetPos(x, y)
    self.droppedMenu:MakePopup()
    self:SetVisible(false)

    self.onClose = function() self:Remove() end

    return self
end

function PANEL:addOption(val)
    local iteration = self.iteration
    self.options[iteration] = vgui.Create("SButton", self.droppedMenu)
    :Dock(TOP)
    :SetLinePos(0)

    if self.buttonh then
        self.options[iteration]:SetTall(self.buttonh)
    end

    if self.buttonfont then
        self.options[iteration].font = self.buttonfont
    end

    if self.buttonbg then
        self.options[iteration].bg = self.buttonbg
    end

    if self.buttonline then
        self.options[iteration].linepos = self.buttonline
    end

    if self.buttoncol then
        self.options[iteration].selCol = self.buttoncol
    end

    if self.buttonforce_accent then
        self.options[iteration].forcehover = true
    end

    self.options[iteration]:setTitle(val, TEXT_ALIGN_LEFT)
    
    local wide = self.options[iteration]:GetWide()

    self.options[iteration].accentheight = 1

    self.droppedMenu:InvalidateLayout(true)
    self.droppedMenu:SizeToChildren(false, true)

    self.options[iteration].DoClick = function(called)
        self.close.DoClick()
        self:setTitle(val, TEXT_ALIGN_LEFT, true)
        if isfunction(self.onValueChange) then
            self.onValueChange(val)
        end
    end
    
    if iteration == 0 then
        self.options[iteration].DoClick()
    end
    
    if wide > self:GetWide() then
        self:SetWide(wide)
    end
    
    self.iteration = self.iteration + 1

    return self
end

function PANEL:SelectOption(int)
    self.options[int].DoClick(true)

    return self
end

function PANEL:Reposition()
    local x, y = self:LocalToScreen(0,self:GetTall())
    if !IsValid(self.droppedMenu) then return end
    self.droppedMenu:SetWide(self:GetWide())
    self.droppedMenu:SetPos(x, y)
    self.droppedMenu:MakePopup()
end

function PANEL:DoClick()
    self.close:SetVisible(!self.droppedMenu:IsVisible())
    self.close:MakePopup()

    self.droppedMenu:SetVisible(!self.droppedMenu:IsVisible())

    self:Reposition()
end

function PANEL:OnSizeChanged()
    self:Reposition()
end

function PANEL:PaintOver(w,h)
    local size = h * .7
    local thickness = slib.getScaledSize(2, "X")

    draw.NoTexture()

    local wantedCol = self:IsHovered() and color_white or hovercolor

    surface.SetDrawColor(wantedCol)
    surface.SetMaterial(icon)
    surface.DrawTexturedRect(w - size - margin, h * .5 - size * .5, size, size)
end

vgui.Register("SDropDown", PANEL, "SButton")