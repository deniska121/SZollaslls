AddCSLuaFile()

if SERVER then
    return
end

local friend = Color(165, 165, 165, 35)

local function OpenScoreboard()
    if IsValid(MSD.Scoreboard) then
        MSD.Scoreboard:Remove()
        MSD.Scoreboard = nil
        return
    end

    local localPly = LocalPlayer()
    local playerCount = #player.GetAll()
    
    MSD.Scoreboard = vgui.Create("DFrame")
    MSD.Scoreboard:SetSize(ScrW() * 0.35, ScrH())
    MSD.Scoreboard:SetPos(0, 0)
    MSD.Scoreboard:MakePopup()
    MSD.Scoreboard:SetAlpha(1)
    MSD.Scoreboard:AlphaTo(255, 0.2)
    MSD.Scoreboard:SetDraggable(false)
    MSD.Scoreboard:ShowCloseButton(false)
    MSD.Scoreboard:SetTitle("")

    MSD.Scoreboard.Paint = function(self, w, h)
        MSD.Blur(self, 2, 2, 155, 155, w, h)
        draw.RoundedBox(0, 0, 0, w, h, MSD.Theme.d)
        draw.RoundedBox(0, 0, 0, w, 40, MSD.Theme.l)
        draw.SimpleText("игроки (" .. playerCount .. ")", "MSDFont.25", 15, 20, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
    end

    MSD.Scoreboard.OnKeyCodePressed = function(self, key)
        if key == KEY_ESCAPE or key == KEY_TAB then
            self:Remove()
            MSD.Scoreboard = nil
        end
    end

    local scroll = vgui.Create("MSDPanelList", MSD.Scoreboard)
    scroll:SetSize(MSD.Scoreboard:GetWide() - 20, MSD.Scoreboard:GetTall() - 60)
    scroll:SetPos(10, 50)
    scroll:EnableVerticalScrollbar()
    scroll:EnableHorizontal(true)
    scroll:SetSpacing(2)
    scroll.IgnoreVbar = true

    local function AddPlayer(ply)
        if not IsValid(ply) then return end

        local btn = vgui.Create("DButton", scroll)
        btn:SetSize(scroll:GetWide() - 20, 45)
        btn:SetText("")
        
        local isLocal = (ply == localPly)
        local isConnecting = (ply:Team() == 0)

        btn.Paint = function(self, w, h)
            if not IsValid(ply) then return end
            
            draw.RoundedBox(0, 0, 0, w, h, MSD.Theme["l"])
            
            if isLocal then
                draw.RoundedBox(0, 0, 0, w, h, Color(255, 255, 255, 30))
            end
            
            local avatar = MSD.ImgLib.GetAvatar(ply:SteamID64())
            if avatar then
                surface.SetMaterial(MSD.ImgLib.GetMaterial(avatar, true))
                surface.SetDrawColor(255, 255, 255, 255)
                surface.DrawTexturedRect(4, 4, 37, 37)
            end
            
            local playerName = ply:Nick() or ply:Name() or "Unknown"
            local nameColor = Color(255, 255, 255, 200)
            if isLocal then
                nameColor = Color(255, 255, 255)
            end
            
            draw.SimpleText(playerName, "MSDFont.20", 48, 22, nameColor, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            
            if isConnecting then
                draw.SimpleText("ПОДКЛЮЧАЕТСЯ", "MSDFont.14", 48, 36, Color(255, 200, 0, 200), TEXT_ALIGN_LEFT)
            else
                if IsValid(ply) then
                    local job = team.GetName(ply:Team()) or ""
                    if job ~= "" then
                        draw.SimpleText(job, "MSDFont.14", 48, 36, MSD.Text["n"], TEXT_ALIGN_LEFT)
                    end
                end
            end
        end

        scroll:AddItem(btn)
    end

    local players = {}
    for _, ply in ipairs(player.GetAll()) do
        if IsValid(ply) then
            table.insert(players, ply)
        end
    end
    
    table.sort(players, function(a, b)
        local aConn = a:Team() == 0
        local bConn = b:Team() == 0
        if aConn and not bConn then return true end
        if not aConn and bConn then return false end
        return a:Name() < b:Name()
    end)

    local hasConnecting = false
    local hasPlayers = false
    
    for _, ply in ipairs(players) do
        if ply:Team() == 0 then
            hasConnecting = true
        else
            hasPlayers = true
        end
    end

    if hasConnecting then
        local header = vgui.Create("DPanel", scroll)
        header:SetSize(scroll:GetWide() - 20, 25)
        header.Paint = function(self, w, h)
            draw.SimpleText("ПОДКЛЮЧАЮТСЯ", "MSDFont.14", 15, 12, Color(255, 200, 0, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end
        scroll:AddItem(header)
        
        for _, ply in ipairs(players) do
            if ply:Team() == 0 then
                AddPlayer(ply)
            end
        end
    end

    if hasPlayers then
        for _, ply in ipairs(players) do
            if ply:Team() ~= 0 then
                AddPlayer(ply)
            end
        end
    end

    if #players == 0 then
        local empty = vgui.Create("DPanel", scroll)
        empty:SetSize(scroll:GetWide() - 20, 60)
        empty.Paint = function(self, w, h)
            draw.SimpleText("На сервере нет игроков", "MSDFont.18", w / 2, h / 2, Color(150, 150, 150, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
        scroll:AddItem(empty)
    end

    MSD.Scoreboard.OnClose = function()
        MSD.Scoreboard = nil
    end
end

hook.Add("ScoreboardShow", "MSD_Scoreboard", function()
    OpenScoreboard()
    return true
end)

hook.Add("ScoreboardHide", "MSD_Scoreboard_Hide", function()
    if IsValid(MSD.Scoreboard) then
        MSD.Scoreboard:Remove()
        MSD.Scoreboard = nil
    end
end)

hook.Add("PlayerBindPress", "MSD_Tab", function(ply, bind, pressed)
    if bind == "+scoreboard" then
        if pressed then
            OpenScoreboard()
        else
            if IsValid(MSD.Scoreboard) then
                MSD.Scoreboard:Remove()
                MSD.Scoreboard = nil
            end
        end
        return true
    end
end)

hook.Add("HUDShouldDraw", "MSD_HideDefaultScoreboard", function(name)
    if name == "CHudScoreboard" then
        return false
    end
end)
