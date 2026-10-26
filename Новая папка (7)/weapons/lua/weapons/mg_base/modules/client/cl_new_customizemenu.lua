if (SERVER) then return end

local blocked = {
    ["Perks"] = true,
}

hook.Add("OnContextMenuOpen", "MW_ContextMenu", function()
    if (input.LookupBinding("mgbase_customize", false) == nil) then
        RunConsoleCommand("mgbase_customize")
    end
end)

local function closeCustomizationMenu()
    gui.EnableScreenClicker(false)
    if (IsValid(MW_CUSTOMIZEMENU)) then
        MW_CUSTOMIZEMENU:Remove()
    end
end

local function validWeapon(weapon)
    return IsValid(weapon) and weapon:GetOwner() == LocalPlayer() and weapon:IsCustomizing()
end

if (IsValid(MW_CUSTOMIZEMENU)) then
    MW_CUSTOMIZEMENU:Remove()
end

MW_CUSTOMIZEMENU = nil

local glass = Material("gmodla/glass.png", "smooth")

surface.CreateFont("MW_Handwritten", {
    font = "Permanent Marker",
    size = 38,
    weight = 900,
    antialias = true,
    shadow = true,
})

surface.CreateFont("MW_HandwrittenTitle", {
    font = "Permanent Marker",
    size = 24,
    weight = 700,
    antialias = true,
    shadow = true,
})

surface.CreateFont("MW_Handwritten_Small", {
    font = "Permanent Marker",
    size = 24,
    weight = 400,
    antialias = true,
    shadow = true,
})

local function openCustomizationMenu(weapon)
    gui.EnableScreenClicker(true)
    MW_CUSTOMIZEMENU = vgui.Create("MSDSimpleFrame")
    local menu = MW_CUSTOMIZEMENU
    local SW, SH = ScrW(), ScrH()
    menu:SetSize(SW, SH)
    menu:Center()
    menu:SetAlpha(1)
    menu:AlphaTo(255, 0.5)
    menu.AlphaDelta = 0

    function menu:Paint(w, h)
        if (not validWeapon(weapon)) then return end
        if (not LocalPlayer():KeyDown(IN_USE)) then
            self.AlphaDelta = Lerp(math.min(10 * RealFrameTime(), 1), self.AlphaDelta, 1)
        else
            self.AlphaDelta = Lerp(math.min(10 * RealFrameTime(), 1), self.AlphaDelta, 0)
        end
    end

    function menu:Think()
        if (not validWeapon(weapon)) then
            closeCustomizationMenu()
            self:Remove()
        end
    end

    local categories = {}
    for slot, atts in pairs(weapon.Customization) do
        for ind, attClass in pairs(atts) do
            if (ind <= 1) then continue end
            if (MW_ATTS[attClass] == nil) then continue end
            local att = weapon:GetStoredAttachment(attClass)
            local category = att.Category
            if (category == nil) then continue end
            categories[category] = (categories[category] or 0) + ((weapon:IsAttachmentAllowed(att) and weapon:AllowedToAttach(ind, attClass, att.Category)) and 1 or 0)
        end
    end

    menu.page = vgui.Create("DPanel", menu)
    menu.page:SetSize(440, SH - SH / 6)
    menu.page:SetPos(15, 15)
    menu.page.text = ""

    function menu.page:Paint(w, h)
        MSD.Blur(self, 2, 2, 255, 0, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MSD.Theme.d)
        draw.RoundedBox(0, 0, 0, w, 120, MSD.Theme.d)
        
        draw.DrawText(weapon.PrintName, "MW_Handwritten", 12, 12, color_black, TEXT_ALIGN_LEFT)
        draw.DrawText(weapon.PrintName, "MW_Handwritten", 10, 10, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT)
        
        draw.DrawText(self.text, "MW_HandwrittenTitle", w - 5, 71, color_black, TEXT_ALIGN_RIGHT)
        draw.DrawText(self.text, "MW_HandwrittenTitle", w - 5, 70, Color(255, 255, 255, 200), TEXT_ALIGN_RIGHT)
    end

    menu.canvas = vgui.Create("MSDPanelList", menu.page)
    menu.canvas:SetSize(menu.page:GetWide(), menu.page:GetTall() - 120)
    menu.canvas:SetPos(0, 120)
    menu.canvas:SetSpacing(2)
    menu.canvas:SetPadding(0)
    menu.canvas:EnableVerticalScrollbar()
    menu.canvas:EnableHorizontal(true)

    menu.canvas.mainMenu = function()
        menu.page.text = "Доступные модификации"
        menu.canvas:Clear()
        for categoryName, count in SortedPairs(categories) do
            if blocked[categoryName] then continue end
            MSD.MenuButton(menu.canvas, MSD.Icons48.dot, nil, nil, 500, 50, categoryName, function(self)
                menu.canvas.slotMenu(categoryName)
            end)
        end
    end

    menu.canvas.slotMenu = function(categoryName)
        menu.page.text = categoryName
        menu.canvas:Clear()
        MSD.MenuButton(menu.canvas, MSD.Icons48.arrow_left, nil, nil, 500, 50, "Назад", function(self)
            menu.canvas.mainMenu()
        end)
        local atts = {}
        for slot, attachmentClasses in pairs(weapon.Customization) do
            for i, attachmentClass in pairs(attachmentClasses) do
                if (MW_ATTS[attachmentClass] == nil) then continue end
                local att = table.Copy(weapon:GetStoredAttachment(attachmentClass))
                local attachmentInUse = weapon:GetAttachmentInUseForSlot(slot)
                if att.Category == categoryName and (i > 1 or (attachmentInUse)) and MW_ATTS[attachmentClass] ~= nil then
                    atts[#atts + 1] = att
                end
            end
        end
        for atindx, attachment in pairs(atts) do
            local panel = vgui.Create("DButton")
            panel.StaticScale = {w = 1, fixed_h = 80, minw = 250, minh = 50}
            panel.IsAnItem = false
            panel.HasItem = true
            
            local attachmentInUse
            for slot, atc in pairs(weapon:GetAllAttachmentsInUse()) do
                if (atc.Category == categoryName) then
                    attachmentInUse = atc
                    break
                end
            end
            panel.IsInUse = attachmentInUse and attachmentInUse.ClassName == attachment.ClassName
            panel.IsAllowed = weapon:IsAttachmentAllowed(attachment) and weapon:AllowedToAttach(atindx, attachment.ClassName, categoryName)
            local blocker = weapon:GetBlockerAttachment(attachment)
            panel.Paint = function(self, w, h)
                if (not validWeapon(weapon)) then return end
                self.IsInUse = weapon:inUseBySlot(categoryName) and weapon:inUseBySlot(categoryName).ClassName == attachment.ClassName
                draw.RoundedBox(0, 0, 0, w, h, MSD.Theme["d"])
                draw.RoundedBox(0, 0, 0, 5, h, MSD.Config.MainColor["p"])
                if self.IsInUse then
                    MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.gradient, MSD.ColorAlpha(MSD.Config.MainColor["p"], 55))
                end
                draw.DrawText(attachment.Name, "MW_Handwritten_Small", 16, 10, color_black, TEXT_ALIGN_LEFT)
                draw.DrawText(attachment.Name, "MW_Handwritten_Small", 15, 8, MSD.Text["l"], TEXT_ALIGN_LEFT)
                if blocker then
                    draw.DrawText("Блокируется: " .. blocker.Name, "MSDFont.16", 15, 58, Color(255, 55, 40), TEXT_ALIGN_LEFT)
                end
                if not self.IsAllowed then
                    MSD.DrawTexturedRect(0, 0, w, h, glass, color_white)
                end
                return true
            end
            panel.DoClick = function(self)
                if not self.IsAllowed then return end
                local slotInUse = 1
                local indexInUse = 1
                for slot, a in pairs(weapon.Customization) do
                    for i, att in pairs(a) do
                        if (att == attachment.ClassName) then
                            slotInUse = slot
                            indexInUse = i
                            break
                        end
                    end
                end
                net.Start("mgbase_customize_att")
                net.WriteInt(slotInUse, 8)
                net.WriteInt(indexInUse, 8)
                net.WriteEntity(weapon)
                net.SendToServer()
            end
            function panel:DoRightClick()
                SetClipboardText(attachment.ClassName)
            end
            menu.canvas:AddItem(panel)
        end
    end

    menu.canvas.mainMenu()
end

function SWEP:CustomizationMenu()
    if (self:IsCustomizing()) then
        openCustomizationMenu(self)
    end
end