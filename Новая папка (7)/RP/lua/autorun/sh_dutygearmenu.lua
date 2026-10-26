local DutyCategories = {
    ["primary"] = {
        { name = "GLOCK-17", class = "mg_golf17_police" },
        { name = "Berreta M9", class = "mg_m9" },
        { name = "M1911", class = "mg_m1911" }
    },
    ["heavy"] = {
        { name = "AR-15", class = "mg_m4_police" },
        { name = "MP5", class = "mg_mp5" },
        { name = "MK 18 MOD 1", class = "mg_mk18_police" },
        { name = "MOSSBERG", class = "mg_590" },
        { name = "BEANBAG", class = "mg_beatdag" }
    },
    ["other"] = {
        { name = "TASER", class = "weapon_REALTASER" },
        { name = "MEDKIT", class = "weapon_bettermedkit" },
        { name = "Дубинка", class = "mlw_tonfa" },
        { name = "VEST", action = "toggle_vest" }
    }
}

local AllowedModels = {
    ["models/cityrp/pm/nypd/male_01.mdl"] = true,
    ["models/cityrp/pm/nypd/male_02.mdl"] = true,
    ["models/cityrp/pm/nypd/male_03.mdl"] = true,
    ["models/cityrp/pm/nypd/male_04.mdl"] = true,
    ["models/cityrp/pm/nypd/male_05.mdl"] = true,
    ["models/cityrp/pm/nypd/male_06.mdl"] = true,
    ["models/cityrp/pm/nypd/male_07.mdl"] = true,
    ["models/cityrp/pm/nypd/male_08.mdl"] = true,
    ["models/cityrp/pm/nypd/male_09.mdl"] = true,
    ["models/cityrp/pm/nypd/female_01.mdl"] = true,
    ["models/cityrp/pm/nypd/female_02.mdl"] = true,
    ["models/cityrp/pm/nypd/female_03.mdl"] = true,
    ["models/cityrp/pm/nypd/female_04.mdl"] = true,
    ["models/cityrp/pm/nypd/female_05.mdl"] = true,
    ["models/cityrp/pm/nypd/female_06.mdl"] = true,
}

local function isPolice(ply)
    if not IsValid(ply) then return false end
    if ply:GetNWBool("detective", false) then return true end
    return AllowedModels[string.lower(ply:GetModel() or "")] == true
end

local WepToCat = {}
for cat, list in pairs(DutyCategories) do
    for _, item in ipairs(list) do
        if item.class then
            WepToCat[item.class] = cat
        end
    end
end

if SERVER then
    util.AddNetworkString("LAZero_Duty_GiveWep")
    util.AddNetworkString("LAZero_Duty_GiveAmmo")
    util.AddNetworkString("LAZero_Duty_ToggleVest")
    util.AddNetworkString("LAZero_Duty_AmmoResult")

    net.Receive("LAZero_Duty_GiveWep", function(len, ply)
        if not IsValid(ply) or not ply:Alive() then return end
        if not isPolice(ply) then return end
        
        local class = net.ReadString()
        local targetCat = WepToCat[class]
        if not targetCat then return end

        if ply:HasWeapon(class) and targetCat == "heavy" then
            ply:StripWeapon(class)
            if ply:HasWeapon("weapon_ebaniehands") then
                ply:SelectWeapon("weapon_ebaniehands")
            end
            return
        end

        for _, w in ipairs(ply:GetWeapons()) do
            local wClass = w:GetClass()
            if WepToCat[wClass] == targetCat and wClass ~= class then
                ply:StripWeapon(wClass)
            end
        end

        if not ply:HasWeapon(class) then
            ply:Give(class)
        end
        
        ply:SelectWeapon(class)
    end)

    net.Receive("LAZero_Duty_ToggleVest", function(len, ply)
        if not IsValid(ply) or not ply:Alive() then return end
        if not isPolice(ply) then return end

        local armorBodygroup = ply:FindBodygroupByName("Armor")
        
        if armorBodygroup ~= -1 then
            local currentSubModel = ply:GetBodygroup(armorBodygroup)
            
            if currentSubModel == 2 then
                ply:SetBodygroup(armorBodygroup, 0)
                ply:SetArmor(0)
            else
                ply:SetBodygroup(armorBodygroup, 2)
                ply:SetArmor(50)
            end
        else
            ply:ChatPrint("Утвоеймодельки нету бодигруппы армора лох")
        end
    end)

    hook.Add("PlayerDeath", "LAZero_Duty_ResetCooldown", function(ply)
        ply.NextAmmoTime = 0
    end)

    net.Receive("LAZero_Duty_GiveAmmo", function(len, ply)
        if not IsValid(ply) or not ply:Alive() then return end
        if not isPolice(ply) then return end
        
        ply.NextAmmoTime = ply.NextAmmoTime or 0

        local success = false
        if CurTime() < ply.NextAmmoTime then
            local remain = math.ceil(ply.NextAmmoTime - CurTime())
            local minutes = math.floor(remain / 60)
            local seconds = remain % 60
            ply:ChatPrint(string.format("Кд %02d:%02d.", minutes, seconds))
            success = false
        else
            ply.NextAmmoTime = CurTime() + 300
            ply:GiveAmmo(120, "Pistol")   
            ply:GiveAmmo(25, "Buckshot") 
            ply:GiveAmmo(120, "AR2")      
            ply:GiveAmmo(120, "SMG1")     
            success = true
        end
        
        net.Start("LAZero_Duty_AmmoResult")
        net.WriteBool(success)
        net.Send(ply)
    end)
end

if CLIENT then
    local DutyUI = {}

    local function UpdatePlayerModel(panel, delay)
        if delay then
            timer.Simple(delay, function()
                if not IsValid(panel) then return end
                UpdatePlayerModel(panel)
            end)
            return
        end
        if not IsValid(panel) then return end
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        panel:SetModel(ply:GetModel() or "models/player/arctic.mdl")
        panel.Entity:ResetSequence("menu_combine")
        panel.Entity:SetPos(Vector(-100, 0, -61))
        for _, v in pairs(ply:GetBodyGroups()) do
            panel.Entity:SetBodygroup(v.id, ply:GetBodygroup(v.id))
        end
        for id, skin in pairs(ply:GetMaterials()) do
            panel.Entity:SetSubMaterial(id - 1, ply:GetSubMaterial(id - 1))
        end
    end

    function OpenDutyMenu()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        if not isPolice(ply) then
            ply:ChatPrint("Насменусначалобегом")
            return
        end

        if IsValid(DutyUI.Frame) then
            DutyUI.Frame:Close()
            return
        end

        local SW, SH = ScrW(), ScrH()
        local frame = vgui.Create("MSDSimpleFrame")
        frame:SetSize(SW, SH)
        frame:SetDraggable(false)
        frame:Center()
        frame:MakePopup()
        frame:SetAlpha(0)
        frame:AlphaTo(255, 0.3)

        frame.Paint = function(self, w, h)
            Derma_DrawBackgroundBlur(self, self.startTime)
            draw.RoundedBox(0, 0, 0, w, h, Color(217, 200, 255, 7))
            draw.RoundedBox(0, 0, 0, w, 50, MSD.Theme.l)
            draw.DrawText("Разгрузка", "MSDFont.25", 12, 12, color_white, TEXT_ALIGN_LEFT)
        end

        local closeBtn = vgui.Create("DButton", frame)
        closeBtn:SetSize(40, 40)
        closeBtn:SetPos(frame:GetWide() - 44, 5)
        closeBtn:SetText("X")
        closeBtn:SetFont("MSDFont.25")
        closeBtn:SetTextColor(Color(255,255,255))
        closeBtn.Paint = function(self, w, h)
            if self:IsHovered() then
                draw.RoundedBox(4, 0, 0, w, h, Color(255, 50, 50, 200))
            else
                draw.RoundedBox(4, 0, 0, w, h, Color(0,0,0,0))
            end
        end
        closeBtn.DoClick = function()
            frame:AlphaTo(0, 0.2, 0, function()
                if IsValid(frame) then frame:Close() end
            end)
        end

        local mpw = SW / 3 - 15

        local loadoutPanel = vgui.Create("MSDPanelList", frame)
        loadoutPanel:SetSize(mpw, SH - 70)
        loadoutPanel:SetPos(5, 70)
        loadoutPanel:EnableVerticalScrollbar()
        loadoutPanel:EnableHorizontal(true)
        loadoutPanel:SetSpacing(2)
        loadoutPanel.IgnoreVbar = true

        local playerPanel = vgui.Create("DModelPanel", frame)
        playerPanel:SetSize(mpw, SH - 50)
        playerPanel:SetPos(10 + mpw, 50)
        playerPanel:SetFOV(28)
        playerPanel:SetCamPos(Vector(0, 0, 0))
        playerPanel:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
        playerPanel:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
        playerPanel:SetAmbientLight(Vector(-64, -64, -64))
        playerPanel:SetAnimated(true)
        playerPanel.Angles = Angle(0, 0, 0)
        playerPanel:SetLookAt(Vector(-100, 0, -22))
        UpdatePlayerModel(playerPanel)

        playerPanel:SetCursor("arrow")
        function playerPanel:DragMousePress()
            self.PressX, self.PressY = gui.MousePos()
            self.Pressed = true
        end
        function playerPanel:DragMouseRelease()
            self.Pressed = false
        end
        function playerPanel:LayoutEntity(ent)
            if self.Pressed then
                local mx = gui.MousePos()
                self.Angles = self.Angles - Angle(0, (self.PressX or mx) - mx, 0)
                self.PressX, self.PressY = gui.MousePos()
            end
            ent:SetAngles(self.Angles)
        end

        local subMenu = nil

        local function OpenSubMenu(catId)
            if IsValid(subMenu) then
                subMenu:Remove()
                subMenu = nil
                playerPanel:MoveTo(10 + mpw, 50, 0.3)
                return
            end

            local items = DutyCategories[catId]
            if not items then return end

            playerPanel:MoveTo(SW - mpw - 5, 70, 0.3)

            subMenu = vgui.Create("MSDPanelList", frame)
            subMenu:SetSize(mpw, SH - 70)
            subMenu:SetPos(10 + mpw, 70)
            subMenu:EnableVerticalScrollbar()
            subMenu:EnableHorizontal(true)
            subMenu:SetSpacing(2)
            subMenu.IgnoreVbar = true

            MSD.Header(subMenu, string.upper(catId) .. " WEAPONS")

            for _, item in ipairs(items) do
                MSD.Button(subMenu, "static", nil, 1, 70, item.name, function()
                    if item.action == "toggle_vest" then
                        net.Start("LAZero_Duty_ToggleVest")
                        net.SendToServer()
                        surface.PlaySound("items/ammo_pickup.wav")
                        timer.Simple(0.5, function()
                            if IsValid(playerPanel) then
                                UpdatePlayerModel(playerPanel)
                            end
                        end)
                    elseif item.class then
                        net.Start("LAZero_Duty_GiveWep")
                        net.WriteString(item.class)
                        net.SendToServer()
                        surface.PlaySound("piemenu_select.wav")
                    end
                end)
            end

            MSD.Button(subMenu, "static", nil, 1, 70, "Назад", function()
                if IsValid(subMenu) then
                    subMenu:Remove()
                    subMenu = nil
                    playerPanel:MoveTo(10 + mpw, 50, 0.3)
                end
            end)
        end

        local function AddCategoryButton(text, catId)
            MSD.Button(loadoutPanel, "static", nil, 1, 95, text, function()
                OpenSubMenu(catId)
            end)
        end

        AddCategoryButton("PRIMARY WEAPON", "primary")
        AddCategoryButton("HEAVY WEAPON", "heavy")
        AddCategoryButton("OTHER", "other")

        MSD.Button(loadoutPanel, "static", nil, 1, 95, "GET AMMO'S", function()
            net.Start("LAZero_Duty_GiveAmmo")
            net.SendToServer()
        end)

        net.Receive("LAZero_Duty_AmmoResult", function() end)

        DutyUI.Frame = frame
        DutyUI.PlayerPanel = playerPanel
        DutyUI.SubMenu = subMenu
    end

    concommand.Add("dutygearmenu", OpenDutyMenu)
end