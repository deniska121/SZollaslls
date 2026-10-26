--говно
if SERVER then
    util.AddNetworkString("UnloadWeapon")

    net.Receive("UnloadWeapon", function(len, ply)
        if not IsValid(ply) or not ply:Alive() then return end
        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) then return end
        if wep:GetClass() == "weapon_ebaniehands" then return end

        local clip1 = wep:Clip1()
        if clip1 > 0 then
            local ammoType = wep:GetPrimaryAmmoType()
            if ammoType ~= -1 then
                ply:SetAmmo(ply:GetAmmoCount(ammoType) + clip1, ammoType)
            end
            wep:SetClip1(0)
        end

        local clip2 = wep:Clip2()
        if clip2 > 0 then
            local ammoType = wep:GetSecondaryAmmoType()
            if ammoType ~= -1 then
                ply:SetAmmo(ply:GetAmmoCount(ammoType) + clip2, ammoType)
            end
            wep:SetClip2(0)
        end
    end)
end

if CLIENT then
    surface.CreateFont("F2MenuFont", {
        font = "Roboto",
        size = 18,
        weight = 700,
        antialias = true,
    })

    local cm = {
        ["models/cityrp/pm/nypd/male_01.mdl"] = true,
        ["models/cityrp/pm/nypd/male_02.mdl"] = true,
        ["models/cityrp/pm/nypd/male_03.mdl"] = true,
        ["models/cityrp/pm/nypd/male_04.mdl"] = true,
        ["models/cityrp/pm/nypd/male_05.mdl"] = true,
        ["models/cityrp/pm/nypd/male_06.mdl"] = true,
        ["models/cityrp/pm/nypd/male_07.mdl"] = true,
        ["models/cityrp/pm/nypd/male_08.mdl"] = true,
        ["models/cityrp/pm/nypd/male_09.mdl"] = true,
        ["models/player/riot.mdl"] = true,
        ["models/player/swat.mdl"] = true,
        ["models/player/urban.mdl"] = true,
        ["models/player/gasmask.mdl"] = true,
        ["models/player/group03m/male_01.mdl"] = true,
        ["models/player/group03m/male_02.mdl"] = true,
        ["models/player/group03m/male_03.mdl"] = true,
        ["models/player/group03m/male_04.mdl"] = true,
        ["models/player/group03m/male_05.mdl"] = true,
        ["models/player/group03m/male_06.mdl"] = true,
        ["models/player/group03m/male_07.mdl"] = true,
        ["models/player/group03m/male_08.mdl"] = true,
        ["models/player/group03m/male_09.mdl"] = true,
    }

    local function isa(p)
        if not IsValid(p) then return false end
        if p:GetNWBool("detective", false) then return true end
        return cm[string.lower(p:GetModel() or "")] == true
    end

    local excludedWeapons = {
        ["weapon_REALTASER"] = true,
        ["weapon_BetterMedkit"] = true,
        ["gmod_tool"] = true,
        ["weapon_physgun"] = true,
        ["simfphys_keys"] = true,
        ["guigui_handcuffed"] = true,
        ["guigui_handcuffs"] = true,
    }

    local anims = {
        { name = "Обычная", seq = "idle_all_01" },
        { name = "Альт1", seq = "idle_all_02" },
        { name = "Горбатый", seq = "idle_all_angry" },
        { name = "Испуган", seq = "idle_all_scared" },
        { name = "Альт2", seq = "LineIdle01" },
        { name = "РучкиСкрестил1", seq = "LineIdle02" },
        { name = "Вкармашки", seq = "LineIdle04" },
        { name = "КрутойДохуя", seq = "menu_combine" },
        { name = "РучкиСкрестил2", seq = "pose_standing_01" },
        { name = "РукиНаПоясе", seq = "pose_standing_02" },
    }

    local function isUnc(ply)
        if not IsValid(ply) then return true end
        if not ply:Alive() then return true end
        if ply:GetNWBool("Unconscious", false) then return true end
        if IsValid(ply:GetNWEntity("Ragdoll")) and ply:GetObserverMode() == OBS_MODE_CHASE then return true end
        if ply:GetNWBool("UnconsciousInVehicle", false) then return true end
        return false
    end

    local activeMenu = nil

    local function CloseMenu()
        if IsValid(activeMenu) then
            activeMenu:Remove()
            activeMenu = nil
        end
    end

    local function DrawFilledCircle(x, y, radius, color)
        local segments = 48
        local verts = {}
        for i = 0, segments do
            local a = math.rad(i * (360 / segments))
            table.insert(verts, { x = x + math.cos(a) * radius, y = y + math.sin(a) * radius } )
        end
        surface.SetDrawColor(color)
        draw.NoTexture()
        surface.DrawPoly(verts)
    end

    local function CreateRadialMenu(options, centerX, centerY, radius)
        CloseMenu()
        local menu = vgui.Create("EditablePanel")
        menu:SetSize(ScrW(), ScrH())
        menu:MakePopup()
        menu:SetMouseInputEnabled(true)
        menu:SetKeyboardInputEnabled(true)
        activeMenu = menu

        local cx, cy = centerX or ScrW() / 2, centerY or ScrH() / 2
        local rad = radius or 280
        local segments = #options
        local angle_step = 360 / segments
        local start_angle = -90

        local polys = {}
        for i = 1, segments do
            local a1 = math.rad(start_angle + (i - 1) * angle_step)
            local a2 = math.rad(start_angle + i * angle_step)
            local poly = { { x = cx, y = cy } }
            for a = a1, a2, math.rad(2) do
                table.insert(poly, { x = cx + math.cos(a) * rad, y = cy + math.sin(a) * rad })
            end
            table.insert(poly, { x = cx + math.cos(a2) * rad, y = cy + math.sin(a2) * rad })
            polys[i] = poly
        end

        local hoverIdx = nil
        local lastHover = nil

        function menu:Paint(w, h)
            local mx, my = gui.MouseX(), gui.MouseY()
            local dx, dy = mx - cx, my - cy
            local dist = math.sqrt(dx * dx + dy * dy)
            hoverIdx = nil
            if dist > 30 and dist < rad then
                local angle = math.deg(math.atan2(dy, dx))
                if angle < -90 then angle = angle + 360 end
                local idx = math.floor((angle - start_angle) / angle_step) + 1
                if idx >= 1 and idx <= segments then hoverIdx = idx end
            end

            if hoverIdx ~= lastHover then
                lastHover = hoverIdx
                if hoverIdx then
                    local ply = LocalPlayer()
                    if IsValid(ply) then
                        ply:EmitSound("piemenu_selectionchange.wav", 75, 100, 0.25)
                    end
                end
            end

            draw.NoTexture()
            for i = 1, segments do
                local col = (hoverIdx == i) and Color(50, 50, 50, 200) or Color(20, 20, 20, 160)
                surface.SetDrawColor(col)
                surface.DrawPoly(polys[i])
            end

            surface.SetDrawColor(80, 80, 80, 80)
            for i = 1, segments do
                local a = math.rad(start_angle + i * angle_step)
                surface.DrawLine(cx, cy, cx + math.cos(a) * rad, cy + math.sin(a) * rad)
            end

            DrawFilledCircle(cx, cy, 120, Color(10, 10, 10, 200))

            for i, opt in ipairs(options) do
                local a = math.rad(start_angle + (i - 1) * angle_step + angle_step / 2)
                local tx = cx + math.cos(a) * (rad * 0.75)
                local ty = cy + math.sin(a) * (rad * 0.75)
                local col = (hoverIdx == i) and Color(255, 255, 255) or Color(180, 180, 180)

                if opt.icon then
                    local iconSize = 32
                    local ix = cx + math.cos(a) * (rad * 0.55)
                    local iy = cy + math.sin(a) * (rad * 0.55)
                    MSD.DrawTexturedRect(ix - iconSize/2, iy - iconSize/2, iconSize, iconSize, opt.icon, col)
                end

                draw.SimpleText(opt.label, "F2MenuFont", tx, ty, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
            end
        end

        function menu:OnMousePressed(key)
            if key == MOUSE_LEFT and hoverIdx and hoverIdx >= 1 and hoverIdx <= segments then
                local opt = options[hoverIdx]
                if opt and opt.callback then
                    opt.callback()
                end
                self:Remove()
                activeMenu = nil
            else
                local ply = LocalPlayer()
                if IsValid(ply) then
                    ply:EmitSound("piemenu_cancel.wav", 75, 100, 0.25)
                end
                self:Remove()
                activeMenu = nil
            end
        end

        function menu:OnKeyCodePressed(key)
            if key == KEY_ESCAPE then
                local ply = LocalPlayer()
                if IsValid(ply) then
                    ply:EmitSound("piemenu_cancel.wav", 75, 100, 0.25)
                end
                self:Remove()
                activeMenu = nil
            end
        end

        function menu:OnRemove()
            activeMenu = nil
        end
    end

    local function OpenPoseMenu()
        local options = {}
        for _, anim in ipairs(anims) do
            table.insert(options, {
                label = anim.name,
                callback = function()
                    net.Start("pidle")
                    net.WriteString(anim.seq)
                    net.SendToServer()
                end
            })
        end
        CreateRadialMenu(options, nil, nil, 280)
    end

    local function OpenCharacterMenu()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end

        local options = {
            {
                label = "Сдаться",
                callback = function()
                    local current = ply:GetNWBool("SurrenderActive", false)
                    net.Start("surrtog")
                    net.WriteBool(not current)
                    net.SendToServer()
                end
            },
            {
                label = "Позы",
                callback = function()
                    OpenPoseMenu()
                end
            }
        }
        CreateRadialMenu(options, nil, nil, 280)
    end

    local function OpenWeaponMenu()
        local options = {
            {
                label = "Разрядить оружие",
                callback = function()
                    local ply = LocalPlayer()
                    net.Start("UnloadWeapon")
                    net.SendToServer()
                    ply:EmitSound("piemenu_select.wav", 75, 100, 0.25)
                end
            },
            {
                label = "Выбросить",
                callback = function()
                    RunConsoleCommand("+drop")
                    timer.Simple(0.05, function()
                        RunConsoleCommand("-drop")
                    end)
                    local ply = LocalPlayer()
                    if IsValid(ply) then
                        ply:EmitSound("piemenu_select.wav", 75, 100, 0.25)
                    end
                end
            }
        }
        CreateRadialMenu(options, nil, nil, 280)
    end

    local function OpenRadioMenu()
        local ply = LocalPlayer()
        if not isa(ply) then return end

        local options = {
            {
                label = "Вызовы",
                icon = MSD.Icons48.folder_open,
                callback = function()
                    RunConsoleCommand("policemenu")
                end
            },
            {
                label = "Каналы",
                icon = MSD.Icons48.cellphone_basic,
                callback = function()
                    local current = ply:GetNWInt("RadioChannel", 1)
                    local channelOptions = {
                        {
                            label = "PD Канал 1",
                            callback = function()
                                net.Start("RadioChannelChange")
                                net.WriteUInt(1, 8)
                                net.SendToServer()
                            end
                        },
                        {
                            label = "PD Канал 2",
                            callback = function()
                                net.Start("RadioChannelChange")
                                net.WriteUInt(2, 8)
                                net.SendToServer()
                            end
                        },
                        {
                            label = "PD Канал 3",
                            callback = function()
                                net.Start("RadioChannelChange") --ОНОНИХУЯНЕМЕНЯЕТБЛЯЯЯ
                                net.WriteUInt(3, 8)
                                net.SendToServer()
                            end
                        }
                    }
                    CreateRadialMenu(channelOptions, nil, nil, 280)
                end
            },
            {
                label = "Кнопка паники",
                icon = Material("msd/icons/alert-circle.png", "smooth"),
                callback = function()
                    net.Start("RadioPanic")
                    net.SendToServer()
                end
            }
        }
        CreateRadialMenu(options, nil, nil, 280)
    end

    local function OpenMainMenu()
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end
        if isUnc(ply) then return end
        if ply:GetNWBool("WakeUpActive", false) then return end
        if ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end

        local wep = ply:GetActiveWeapon()
        local categories = {}

        if isa(ply) then
            table.insert(categories, {
                label = "Рация",
                icon = MSD.Icons48.cellphone_basic,
                callback = function()
                    OpenRadioMenu()
                end
            })
        end

        if IsValid(wep) then
            local class = wep:GetClass()
            if class == "weapon_ebaniehands" then
                table.insert(categories, {
                    label = "Персонаж",
                    icon = MSD.Icons48.human_male,
                    callback = function()
                        OpenCharacterMenu()
                    end
                })
            elseif not excludedWeapons[class] then
                table.insert(categories, {
                    label = "Оружие",
                    icon = MSD.Icons48.pistol,
                    callback = function()
                        OpenWeaponMenu()
                    end
                })
            end
        end

        if #categories == 0 then return end

        CreateRadialMenu(categories, nil, nil, 280)
    end

    local f2WasDown = false
    local lastF2Time = 0

    hook.Add("Think", "F2Menu_Think", function()
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end
        if isUnc(ply) then return end
        if ply:GetNWBool("WakeUpActive", false) then return end
        if ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end

        if input.IsKeyDown(KEY_F2) then
            if not f2WasDown then
                f2WasDown = true
                if CurTime() - lastF2Time < 0.5 then return end
                lastF2Time = CurTime()

                if IsValid(activeMenu) then
                    CloseMenu()
                    return
                end

                OpenMainMenu()
            end
        else
            f2WasDown = false
        end
    end)

    hook.Add("PlayerSwitchWeapon", "F2Menu_CloseOnSwitch", function(ply, old, new)
        if IsValid(activeMenu) then
            CloseMenu()
        end
    end)

    hook.Add("PlayerJump", "F2Menu_CloseOnJump", function(ply)
        if IsValid(activeMenu) and ply == LocalPlayer() then
            CloseMenu()
        end
    end)
end