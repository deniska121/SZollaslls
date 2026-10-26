AddCSLuaFile()

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
    ["models/GTA5/fire1.mdl"] = true,
    ["models/GTA5/fire2.mdl"] = true,
    
}

local esu_models = {
    ["models/player/riot.mdl"] = true,
    ["models/player/swat.mdl"] = true,
    ["models/player/urban.mdl"] = true,
    ["models/player/gasmask.mdl"] = true,
}

local function isa(p)
    if not IsValid(p) then return false end
    if p:GetNWBool("detective", false) then return true end
    return cm[string.lower(p:GetModel() or "")] == true
end

local function iu(ply)
    if not IsValid(ply) then return true end
    if not ply:Alive() then return true end
    if ply:GetNWBool("UnconsciousInVehicle", false) then return true end
    if IsValid(ply:GetNWEntity("Ragdoll")) then return true end
    return false
end

if SERVER then
    util.AddNetworkString("RP_Chat_Net")
    util.AddNetworkString("ToggleRadio")
    util.AddNetworkString("RP_Radio_Chat")
    util.AddNetworkString("911Call")
    util.AddNetworkString("911Accept")
    util.AddNetworkString("911Close")
    util.AddNetworkString("911Update")
    util.AddNetworkString("911Remove")
    util.AddNetworkString("OpenPoliceMenu")
    util.AddNetworkString("911Unassign")
    util.AddNetworkString("Sync911")
    util.AddNetworkString("RadioVoiceStart")
    util.AddNetworkString("RadioVoiceEnd")
    util.AddNetworkString("RadioChannelChange")
    util.AddNetworkString("RadioPanic")
    util.AddNetworkString("RadioPanicNotify")
    util.AddNetworkString("RadioChannelChanged")

    local nato = {"Adam","Boy","Charles","David","Eddie","Frank","George","Henry","Ida","John","King","Larry","Mike","Nora","Oscar","Peter","Queen","Robert","Sam","Thomas","Union","Victor","William","X-Ray","Yellow","Zebra"}
    local uc = {}
    local dc = 0
    local esu_counter = 0

    local function ac(ply)
        if not isa(ply) then return end
        local sid = ply:SteamID64()
        local model = string.lower(ply:GetModel() or "")
        local old_model = ply.LastModel or ""
        if model == old_model and uc[sid] then return end
        ply.LastModel = model
        uc[sid] = nil
        local code = ""
        if ply:GetNWBool("detective", false) then
            dc = dc + 1
            code = "92-Squad-"..dc
        elseif esu_models[model] then
            esu_counter = esu_counter + 1
            code = "6-ESU-"..esu_counter
        else
            local pool = {}
            for _, v in ipairs(nato) do
                local taken = false
                for _, c in pairs(uc) do
                    if c == "92-"..v then taken = true break end
                end
                if not taken then table.insert(pool, v) end
            end
            if #pool > 0 then
                code = "92-"..pool[math.random(1, #pool)]
            else
                code = "92-Unit-"..math.random(100, 999)
            end
        end
        uc[sid] = code
        ply:SetNWString("u_code", code)
    end

    hook.Add("PlayerSpawn", "a_c_s", function(ply)
        if isa(ply) then
            ac(ply)
        end
        ply:SetNWString("v_mode", "n")
        ply:SetNWFloat("v_dst", 500)
        ply:SetNWString("v_pfx", "")
        ply:SetNWInt("RadioChannel", 1)
        ply:SetNWFloat("PanicCooldown", 0)
    end)

    hook.Add("PlayerSetModel", "UpdateCodeOnModelChange", function(ply)
        if IsValid(ply) and isa(ply) then
            ac(ply)
        end
    end)

    timer.Create("CheckCodes", 5, 0, function()
        for _, ply in ipairs(player.GetAll()) do
            if isa(ply) and (ply:GetNWString("u_code") == "") then
                ac(ply)
            end
        end
    end)

    hook.Add("PlayerDisconnected", "r_c", function(ply)
        uc[ply:SteamID64()] = nil
    end)

    local cid = 0
    local c911 = {}

    local function gc()
        local c = {}
        for _, v in ipairs(player.GetAll()) do
            if isa(v) then table.insert(c, v) end
        end
        return c
    end

    local function srp(p, d, ...)
        local a = {...}
        local ps = p:GetPos()
        local r = {}
        for _, v in ipairs(player.GetAll()) do
            if v:GetPos():Distance(ps) <= d then table.insert(r, v) end
        end
        if #r == 0 then return end
        net.Start("RP_Chat_Net")
        net.WriteUInt(#a, 8)
        for _, v in ipairs(a) do
            if IsColor(v) then
                net.WriteBool(true)
                net.WriteColor(v)
            else
                net.WriteBool(false)
                net.WriteString(tostring(v))
            end
        end
        net.Send(r)
    end

    local function src(s, t)
        local c = {}
        for _, v in ipairs(player.GetAll()) do
            if isa(v) then table.insert(c, v) end
        end
        if #c == 0 then return end
        net.Start("RP_Radio_Chat")
        net.WriteEntity(s)
        net.WriteString(t)
        net.Send(c)
    end

    local function s911(ply)
        if not isa(ply) then return end
        local tbl = {}
        for id, call in pairs(c911) do
            local officer_ids = {}
            for ent_idx, _ in pairs(call.officers or {}) do
                table.insert(officer_ids, ent_idx)
            end
            table.insert(tbl, {id = id, c = call.name, r = call.r, p = call.p, t = call.tm, officers = officer_ids})
        end
        net.Start("Sync911")
        net.WriteUInt(#tbl, 16)
        for _, v in ipairs(tbl) do
            net.WriteUInt(v.id, 16)
            net.WriteString(v.c)
            net.WriteString(v.r)
            net.WriteVector(v.p)
            net.WriteUInt(v.t, 32)
            net.WriteUInt(#v.officers, 8)
            for _, eid in ipairs(v.officers) do
                net.WriteUInt(eid, 16)
            end
        end
        net.Send(ply)
    end

    hook.Add("PlayerInitialSpawn", "Sync911OnJoin", function(ply)
        if isa(ply) then
            timer.Simple(0.5, function() s911(ply) end)
        end
    end)

    hook.Add("PlayerSpawn", "Sync911OnSpawn", function(ply)
        if isa(ply) then
            timer.Simple(0.5, function() if IsValid(ply) then s911(ply) end end)
        end
    end)

    hook.Add("DoPlayerDeath", "TurnOffRadioOnDeath", function(ply)
        if IsValid(ply) then
            ply:SetNWBool("r_on", false)
        end
    end)

    net.Receive("ToggleRadio", function(l, p)
        if not isa(p) or iu(p) then return end
        p.n_rt = p.n_rt or 0
        if CurTime() < p.n_rt then return end
        p.n_rt = CurTime() + 0.5
        p:SetNWBool("r_on", not p:GetNWBool("r_on", false))
    end)

    net.Receive("RadioChannelChange", function(len, ply)
        local channel = net.ReadUInt(8)
        if channel >= 1 and channel <= 3 then
            ply:SetNWInt("RadioChannel", channel)
            net.Start("RadioChannelChanged")
            net.WriteUInt(channel, 8)
            net.Send(ply)
        end
    end)

    net.Receive("RadioPanic", function(len, ply)
        if not IsValid(ply) or not ply:Alive() then return end
        if iu(ply) then return end
        if not isa(ply) then return end

        local cooldown = ply:GetNWFloat("PanicCooldown", 0)
        if CurTime() < cooldown then return end

        ply:SetNWFloat("PanicCooldown", CurTime() + 35)

        local pos = ply:GetPos()
        local code = ply:GetNWString("u_code", ply:Nick())

        local recipients = {}
        for _, v in ipairs(player.GetAll()) do
            if isa(v) and not iu(v) then
                table.insert(recipients, v)
            end
        end

        if #recipients > 0 then
            net.Start("RadioPanicNotify")
            net.WriteVector(pos)
            net.WriteString(code)
            net.WriteEntity(ply)
            net.Send(recipients)
        end
    end)

    hook.Add("PlayerCanHearPlayersVoice", "RadioChannelCheck", function(listener, talker)
        if not IsValid(talker) or not IsValid(listener) then return end
        if iu(talker) or iu(listener) then return end

        if isa(talker) and isa(listener) and talker:GetNWBool("r_on", false) then
            local tChan = talker:GetNWInt("RadioChannel", 1)
            local lChan = listener:GetNWInt("RadioChannel", 1)
            if tChan != lChan then
                return false
            end
        end
    end, 100)

    net.Receive("911Accept", function(l, p)
        if not isa(p) or iu(p) then return end
        local i = net.ReadUInt(16)
        if c911[i] then
            c911[i].officers = c911[i].officers or {}
            c911[i].officers[p:EntIndex()] = true
            local officer_ids = {}
            for eid, _ in pairs(c911[i].officers) do table.insert(officer_ids, eid) end
            net.Start("911Update")
            net.WriteUInt(i, 16)
            net.WriteUInt(#officer_ids, 8)
            for _, eid in ipairs(officer_ids) do net.WriteUInt(eid, 16) end
            net.Send(gc())
        end
    end)

    net.Receive("911Close", function(l, p)
        if not isa(p) or iu(p) then return end
        local i = net.ReadUInt(16)
        if c911[i] and c911[i].officers and c911[i].officers[p:EntIndex()] then
            net.Start("911Remove")
            net.WriteUInt(i, 16)
            net.WriteString(p:GetNWString("u_code", p:Nick()))
            net.WriteString(c911[i].r)
            net.Send(gc())
            c911[i] = nil
        else
            p:ChatPrint("Вы не приняли этот вызов или он уже закрыт.")
        end
    end)

    net.Receive("911Unassign", function(l, p)
        if not isa(p) or iu(p) then return end
        local i = net.ReadUInt(16)
        if c911[i] and c911[i].officers and c911[i].officers[p:EntIndex()] then
            c911[i].officers[p:EntIndex()] = nil
            net.Start("911Unassign")
            net.WriteUInt(i, 16)
            net.WriteString(p:GetNWString("u_code", p:Nick()))
            net.Send(gc())
        end
    end)

    concommand.Add("policemenu", function(ply, cmd, args)
        if IsValid(ply) and isa(ply) then
            net.Start("OpenPoliceMenu")
            net.Send(ply)
        end
    end)

    concommand.Add("detective", function(ply, cmd, args)
        if not IsValid(ply) or not ply:Alive() then return end
        local new = not ply:GetNWBool("detective", false)
        ply:SetNWBool("detective", new)
        if new then
            ply:ChatPrint("Тыкрутой")
            ac(ply)
            s911(ply)
        else
            ply:ChatPrint("Тынекрутой")
            ply:SetNWBool("r_on", false)
            uc[ply:SteamID64()] = nil
            ply:SetNWString("u_code", "")
        end
    end)

    hook.Add("PlayerCanHearPlayersVoice", "Voice_UnconAndRadio", function(listener, talker)
        if not IsValid(talker) or not IsValid(listener) then return false end
        if iu(talker) then return false end
        if isa(talker) and talker:GetNWBool("r_on", false) and isa(listener) then
            return true, false
        end
        local dst = talker:GetNWFloat("v_dst", 500)
        local d = talker:GetPos():Distance(listener:GetPos())
        if d <= dst then return true, true end
        return false
    end)

    hook.Add("PlayerStartVoice", "Voice_StartBlock", function(ply)
        if IsValid(ply) and iu(ply) then return false end
    end)

    net.Receive("RadioVoiceStart", function(len, ply)
        local talker = net.ReadEntity()
        if not IsValid(talker) then return end
        if isa(talker) and talker:GetNWBool("r_on", false) and not iu(talker) then
            local recipients = {}
            for _, v in ipairs(player.GetAll()) do
                if isa(v) then table.insert(recipients, v) end
            end
            if #recipients > 0 then
                net.Start("RadioVoiceStart")
                net.WriteEntity(talker)
                net.Send(recipients)
            end
        end
    end)

    net.Receive("RadioVoiceEnd", function(len, ply)
        local talker = net.ReadEntity()
        if not IsValid(talker) then return end
        if isa(talker) and talker:GetNWBool("r_on", false) and not iu(talker) then
            local recipients = {}
            for _, v in ipairs(player.GetAll()) do
                if isa(v) then table.insert(recipients, v) end
            end
            if #recipients > 0 then
                net.Start("RadioVoiceEnd")
                net.WriteEntity(talker)
                net.Send(recipients)
            end
        end
    end)

    hook.Add("PlayerSay", "v_ch", function(p, t)
        if not p:Alive() or iu(p) then return "" end
        local tr = string.Trim(t)
        local l = string.lower(tr)
        local n = p:Nick()
        local pc = team.GetColor(p:Team()) or Color(46, 204, 113)

        if l == "/y" then
            p:SetNWString("v_mode", "y")
            p:SetNWFloat("v_dst", 1500)
            p:SetNWString("v_pfx", "(Кричит) ")
            return ""
        elseif l == "/w" then
            p:SetNWString("v_mode", "w")
            p:SetNWFloat("v_dst", 150)
            p:SetNWString("v_pfx", "(Шёпотом) ")
            return ""
        elseif l == "/n" then
            p:SetNWString("v_mode", "n")
            p:SetNWFloat("v_dst", 500)
            p:SetNWString("v_pfx", "")
            return ""
        end

        local mode = p:GetNWString("v_mode", "n")
        local dst = p:GetNWFloat("v_dst", 500)
        local msg = tr

        if string.sub(l, 1, 3) == "/y " then
            mode = "y"; dst = 1500; msg = string.sub(tr, 4)
        elseif string.sub(l, 1, 3) == "/w " then
            mode = "w"; dst = 150; msg = string.sub(tr, 4)
        end

        local a = string.Explode(" ", msg)
        local c = string.lower(a[1] or "")

        if c == "/911" or c == "/911anon" then
            local anon = (c == "/911anon")
            table.remove(a, 1)
            local r = table.concat(a, " ")
            if r == "" then r = "Не указана" end
            cid = cid + 1
            local name = anon and "Неизвестный" or p:Nick()
            c911[cid] = { name = name, r = r, p = p:GetPos(), officers = {}, tm = os.time() }
            net.Start("911Call")
            net.WriteUInt(cid, 16)
            net.WriteString(name)
            net.WriteString(r)
            net.WriteVector(p:GetPos())
            net.WriteUInt(os.time(), 32)
            net.Send(gc())
            p:ChatPrint(anon and "Анонимный вызов 911 отправлен" or "Вызов 911 отправлен")
            return ""
        end

        local ml = string.lower(msg)
        if ml == "/me" or string.sub(ml, 1, 4) == "/me " then
            local ac = ml == "/me" and "" or string.sub(msg, 5)
            srp(p, 500, Color(211, 84, 0), n .. " " .. ac)
            return ""
        elseif ml == "/do" or string.sub(ml, 1, 4) == "/do " then
            local ac = ml == "/do" and "" or string.sub(msg, 5)
            srp(p, 500, Color(41, 128, 185), ac .. " (" .. n .. ")")
            return ""
        elseif ml == "/try" or string.sub(ml, 1, 5) == "/try " then
            local ac = ml == "/try" and "" or string.sub(msg, 6)
            local res = math.random(1, 2) == 1 and " [Удачно]" or " [Неудачно]"
            local rc = res == " [Удачно]" and Color(46, 204, 113) or Color(231, 76, 60)
            srp(p, 500, Color(241, 196, 15), n .. " " .. ac, rc, res)
            return ""
        elseif ml == "/it" or string.sub(ml, 1, 4) == "/it " then
            local ac = ml == "/it" and "" or string.sub(msg, 5)
            srp(p, 500, Color(22, 160, 133), ac)
            return ""
        elseif ml == "/roll" or string.sub(ml, 1, 6) == "/roll " then
            srp(p, 500, Color(155, 89, 182), n .. " бросил " .. math.random(1, 100) .. " (1-100)")
            return ""
        end

        if mode == "n" and isa(p) and p:GetNWBool("r_on", false) then
            src(p, msg)
            return ""
        end

        if mode == "y" then
            srp(p, dst, Color(231, 76, 60), "(Кричит) ", pc, n, Color(255, 255, 255), ": " .. msg)
        elseif mode == "w" then
            srp(p, dst, Color(149, 165, 166), "(Шепотом) ", pc, n, Color(189, 195, 199), ": " .. msg)
        else
            srp(p, dst, pc, n, Color(255, 255, 255), ": " .. msg)
        end
        return ""
    end)
end

if CLIENT then
    surface.CreateFont("rf_ui", { font = "Tahoma", size = 16, weight = 700, antialias = true })
    surface.CreateFont("mf_t", { font = "Roboto", size = 22, weight = 600, antialias = true })
    surface.CreateFont("mf_i", { font = "Roboto", size = 16, weight = 500, antialias = true })
    surface.CreateFont("mf_s", { font = "Roboto", size = 12, weight = 400, antialias = true })
    surface.CreateFont("nf_f", { font = "Tahoma", size = 18, weight = 600, antialias = true })

    local a911 = {}
    local panicMarkers = {}

    local function FormatTime(seconds)
        if seconds < 60 then return seconds .. " сек. назад"
        elseif seconds < 3600 then return math.floor(seconds / 60) .. " мин. назад"
        else
            local hours = math.floor(seconds / 3600)
            local mins = math.floor((seconds % 3600) / 60)
            if mins > 0 then return hours .. " ч. " .. mins .. " мин. назад"
            else return hours .. " ч. назад" end
        end
    end

    net.Receive("Sync911", function()
        local count = net.ReadUInt(16)
        a911 = {}
        for i = 1, count do
            local id = net.ReadUInt(16)
            local c = net.ReadString()
            local r = net.ReadString()
            local p = net.ReadVector()
            local t = net.ReadUInt(32)
            local o_cnt = net.ReadUInt(8)
            local officers = {}
            for j = 1, o_cnt do
                local eid = net.ReadUInt(16)
                officers[eid] = true
            end
            table.insert(a911, { i = id, c = c, r = r, p = p, t = t, officers = officers })
        end
    end)

    net.Receive("911Call", function()
        local id = net.ReadUInt(16)
        local name = net.ReadString()
        local r = net.ReadString()
        local p = net.ReadVector()
        local ct = net.ReadUInt(32)
        table.insert(a911, 1, { i = id, c = name, r = r, p = p, t = ct, officers = {} })
        notification.AddLegacy("Поступил новый вызов 911", NOTIFY_GENERIC, 8)
        surface.PlaySound("radio/ground_short.wav")
    end)

    net.Receive("911Update", function()
        local id = net.ReadUInt(16)
        local o_cnt = net.ReadUInt(8)
        local officers = {}
        for i = 1, o_cnt do
            officers[net.ReadUInt(16)] = true
        end
        local old_call = nil
        local old_officers = {}
        for _, v in ipairs(a911) do
            if v.i == id then
                old_call = v
                old_officers = v.officers or {}
                v.officers = officers
                break
            end
        end
        if old_call then
            local added = {}
            for eid, _ in pairs(officers) do
                if not old_officers[eid] then table.insert(added, eid) end
            end
            if #added > 0 then
                local lp = LocalPlayer()
                for _, eid in ipairs(added) do
                    local pl = Entity(eid)
                    if IsValid(pl) then
                        notification.AddLegacy(pl:GetNWString("u_code", pl:Nick()) .. " Принял вызов #" .. id, NOTIFY_GENERIC, 8)
                    end
                end
                surface.PlaySound("radio/ground_short.wav")
            end
        end
    end)

    net.Receive("911Remove", function()
        local id = net.ReadUInt(16)
        local cl = net.ReadString()
        local r = net.ReadString()
        for i = #a911, 1, -1 do
            if a911[i].i == id then
                table.remove(a911, i)
                break
            end
        end
        notification.AddLegacy(cl .. " завершил вызов #" .. id .. " " .. r, NOTIFY_HINT, 8)
        surface.PlaySound("radio/ground_short.wav")
    end)

    net.Receive("911Unassign", function()
        local id = net.ReadUInt(16)
        local name = net.ReadString()
        for i = 1, #a911 do
            if a911[i].i == id then
                a911[i].officers = {}
                break
            end
        end
        notification.AddLegacy(name .. " открепился от вызова #" .. id, NOTIFY_HINT, 8)
        surface.PlaySound("radio/ground_short.wav")
    end)

    net.Receive("RadioChannelChanged", function()
        local channel = net.ReadUInt(8)
        surface.PlaySound("radio/blip_03.wav")
    end)

    net.Receive("RadioPanicNotify", function()
        local pos = net.ReadVector()
        local code = net.ReadString()
        local ply = net.ReadEntity()

        if not IsValid(ply) then return end

        LocalPlayer():EmitSound("radio/panic_01.wav", 50, 100, 0.3)

        table.insert(panicMarkers, { pos = pos, code = code, time = CurTime() })

        notification.AddLegacy("Лох " .. code .. " нажал кнопку паники.", NOTIFY_ERROR, 8)
    end)

    local a_tks = {}
    net.Receive("RadioVoiceStart", function()
        local ply = net.ReadEntity()
        if IsValid(ply) then
            if not a_tks[ply] then
                a_tks[ply] = true
                surface.PlaySound("") -- radio/blip_02.wav
            end
        end
    end)

    net.Receive("RadioVoiceEnd", function()
        local ply = net.ReadEntity()
        if IsValid(ply) then
            if a_tks[ply] then
                a_tks[ply] = nil
                surface.PlaySound("radio/blip_04.wav")
            end
        end
    end)

    net.Receive("RP_Chat_Net", function()
        local c = net.ReadUInt(8)
        local a = {}
        for i = 1, c do
            if net.ReadBool() then table.insert(a, net.ReadColor()) else table.insert(a, net.ReadString()) end
        end
        chat.AddText(unpack(a))
    end)

    net.Receive("RP_Radio_Chat", function()
        local s = net.ReadEntity()
        local t = net.ReadString()
        if IsValid(s) then
            local code = s:GetNWString("u_code", s:Nick())
            chat.AddText(Color(52, 152, 219), "[Рация] ", team.GetColor(s:Team()) or Color(255, 255, 255), code, Color(255, 255, 255), ": " .. t)
            surface.PlaySound("radio/ground_short.wav")
        end
    end)

    local function isa(p)
        if not IsValid(p) then return false end
        if p:GetNWBool("detective", false) then return true end
        return cm[string.lower(p:GetModel() or "")] == true
    end

    hook.Add("PlayerButtonDown", "c_rt", function(p, b)
        if not IsFirstTimePredicted() then return end
        if b == KEY_P then
            if vgui.CursorVisible() or (p.IsTyping and p:IsTyping()) then return end
            if not isa(p) or iu(p) then return end
            p.n_t = p.n_t or 0
            if CurTime() < p.n_t then return end
            p.n_t = CurTime() + 0.5
            net.Start("ToggleRadio")
            net.SendToServer()
            surface.PlaySound("radio/blip_02.wav")
        end
    end)

    hook.Add("PlayerStartVoice", "RadioVoiceNotify", function(ply)
        if not IsValid(ply) then return end
        if isa(ply) and ply:GetNWBool("r_on", false) and not iu(ply) then
            net.Start("RadioVoiceStart")
            net.WriteEntity(ply)
            net.SendToServer()
        end
    end)

    hook.Add("PlayerEndVoice", "RadioVoiceNotifyEnd", function(ply)
        if not IsValid(ply) then return end
        if isa(ply) and ply:GetNWBool("r_on", false) and not iu(ply) then
            net.Start("RadioVoiceEnd")
            net.WriteEntity(ply)
            net.SendToServer()
        end
    end)

    hook.Add("EntityRemoved", "rv_cl", function(e)
        if a_tks[e] then a_tks[e] = nil end
    end)

    hook.Add("HUDPaint", "c_rh", function()
        local ply = LocalPlayer()
        if not isa(ply) then return end

        for _, cl in ipairs(a911) do
            if (cl.officers or {})[ply:EntIndex()] and ply:GetPos():Distance(cl.p) > 200 then
                local s = cl.p:ToScreen()
                if s.visible then
                    local dst = math.Round(ply:GetPos():Distance(cl.p) * 0.01905)
                    draw.SimpleText("Вызов 911 (#" .. cl.i .. ")", "rf_ui", s.x, s.y - 15, Color(255, 100, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText(dst .. "м", "rf_ui", s.x, s.y + 2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end

        for i = #panicMarkers, 1, -1 do
            local marker = panicMarkers[i]
            if CurTime() - marker.time > 30 then
                table.remove(panicMarkers, i)
            else
                local s = marker.pos:ToScreen()
                if s.visible then
                    local dst = math.Round(ply:GetPos():Distance(marker.pos) * 0.01905)
                    MSD.DrawTexturedRect(s.x - 16, s.y - 40, 32, 32, MSD.PinPoints[8] or Material("msd/icons/alert-circle.png", "smooth"), Color(255, 0, 0, 255))
                    draw.SimpleText("Кнопка паники", "rf_ui", s.x, s.y - 10, Color(255, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                    draw.SimpleText(dst .. "м", "rf_ui", s.x, s.y + 12, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end

        local isOn = ply:GetNWBool("r_on", false)
        local count = 0
        local maxNameW = 0
        surface.SetFont("rf_ui")
        local tw_pered = surface.GetTextSize("Передача")
        local tw_channel = surface.GetTextSize("PD канал #" .. ply:GetNWInt("RadioChannel", 1))

        for k, _ in pairs(a_tks) do
            if IsValid(k) and k:GetNWBool("r_on", false) then
                count = count + 1
                surface.SetFont("rf_ui")
                local w = surface.GetTextSize(k:GetNWString("u_code", k:Nick()))
                if w > maxNameW then maxNameW = w end
            end
        end

        local mgn = 12
        local pbox_s = 16
        local dot_s = 10
        local rowH = 24

        local line1_w = mgn + pbox_s + 5 + tw_pered + 5 + dot_s + mgn
        local line2_w = mgn + tw_channel + mgn
        local line3_w = mgn + maxNameW + 5 + dot_s + mgn
        local boxW = math.max(line1_w, line2_w, line3_w) + 20

        local ry = ScrH() * 0.45
        local totalRows = 2 + count
        local boxH = totalRows * rowH + 15
        local rx = ScrW() - boxW - 20
        if ry + boxH > ScrH() then ry = ScrH() - boxH - 20 end

        draw.RoundedBox(4, rx, ry, boxW, boxH, Color(15, 15, 15, 230))

        local blk_x = rx + boxW - mgn - (pbox_s + 5 + tw_pered + 5 + dot_s)
        local pbox_x = blk_x
        local pbox_y = ry + 8
        draw.RoundedBox(0, pbox_x, pbox_y, pbox_s, pbox_s, Color(20, 20, 20, 255))
        draw.SimpleText("P", "rf_ui", pbox_x + pbox_s/2, pbox_y + pbox_s/2, Color(220, 220, 220), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

        local tx_x = blk_x + pbox_s + 5
        draw.SimpleText("Передача", "rf_ui", tx_x, ry + 17, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        local dot_x = tx_x + tw_pered + 5
        local dot_y = ry + 13
        local dotCol = isOn and Color(100, 255, 0) or Color(255, 0, 0)
        draw.RoundedBox(6, dot_x, dot_y, dot_s, dot_s, dotCol)

        local c_y = ry + 16 + rowH
        local ch_x = rx + boxW - mgn - tw_channel
        draw.SimpleText("PD канал #" .. ply:GetNWInt("RadioChannel", 1), "rf_ui", ch_x, c_y, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

        local ty = ry + 15 + (2 * rowH)
        for talker, _ in pairs(a_tks) do
            if IsValid(talker) and talker:GetNWBool("r_on", false) then
                local name = talker:GetNWString("u_code", talker:Nick())
                local y_center = ty + rowH/2 - 2
                draw.SimpleText(name, "rf_ui", rx + boxW - mgn - dot_s - 5, y_center, Color(255, 255, 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
                draw.RoundedBox(6, rx + boxW - mgn, y_center - 5, dot_s, dot_s, Color(100, 255, 0))
                ty = ty + rowH
            end
        end
    end)

    local p_m_p = nil
    local grad_mat = Material("gmodla/cd_2.png", "smooth")
    local folder_icon = Material("msd/icons/folder-open.png", "smooth")

    net.Receive("OpenPoliceMenu", function()
        if IsValid(p_m_p) then p_m_p:Remove() end

        local fw, fh = ScrW() * 0.55, ScrH() * 0.75
        local frame = vgui.Create("MSDSimpleFrame")
        frame:SetSize(fw, fh)
        frame:Center()
        frame:MakePopup()
        frame:SetDeleteOnClose(true)
        frame:SetDraggable(true)
        frame:SetSizable(false)
        frame:SetAlpha(0)
        frame:AlphaTo(255, 0.3)

        local topBar = vgui.Create("DPanel", frame)
        topBar:SetSize(fw, 55)
        topBar:SetPos(0, 0)
        topBar.Paint = function(s, w, h)
            surface.SetDrawColor(255, 255, 255)
            surface.SetMaterial(grad_mat)
            surface.DrawTexturedRect(0, 0, w, h)
            draw.RoundedBoxEx(MSD.Config.Rounded, 0, 0, w, h, Color(40, 10, 50, 180), true, true, false, false)
            MSD.DrawTexturedRect(15, 10, 35, 35, MSD.Icons48.police, color_white)
            draw.DrawText("Вызовы", "MSDFont.25", w / 2, 15, color_white, TEXT_ALIGN_CENTER)
        end

        MSD.IconButton(topBar, MSD.Icons48.cross, fw - 34, 10, 25, nil, MSD.Config.MainColor.p, function()
            frame:AlphaTo(0, 0.3, 0, function() frame:Remove() end)
        end)

        local listPanel = vgui.Create("MSDPanelList", frame)
        listPanel:SetPos(0, 55)
        listPanel:SetSize(fw * 0.35, fh - 55)
        listPanel:EnableVerticalScrollbar()
        listPanel:SetSpacing(4)
        listPanel:SetPadding(5)
        listPanel.Paint = function(s, w, h)
            draw.RoundedBoxEx(MSD.Config.Rounded, 0, 0, w, h, Color(25, 25, 25, 255), false, false, true, true)
        end

        local detailsPanel = vgui.Create("MSDPanelList", frame)
        detailsPanel:SetPos(fw * 0.35, 55)
        detailsPanel:SetSize(fw * 0.65, fh - 55)
        detailsPanel:EnableVerticalScrollbar()
        detailsPanel:SetSpacing(5)
        detailsPanel:SetPadding(15)
        detailsPanel.Paint = function(s, w, h)
            draw.RoundedBoxEx(MSD.Config.Rounded, 0, 0, w, h, Color(35, 35, 35, 255), false, false, false, true)
        end

        local selectedCall = nil

        local function addActionButton(text, icon, func)
            local btn = vgui.Create("DButton")
            btn:SetText("")
            btn:SetTall(45)
            btn:Dock(TOP)
            btn:DockMargin(0, 0, 0, 2)
            btn.Paint = function(s, w, h)
                local bg = s:IsHovered() and Color(50, 50, 50) or Color(30, 30, 30)
                draw.RoundedBox(0, 0, 0, w, h, bg)
                MSD.DrawTexturedRect(10, h / 2 - 12, 24, 24, icon, MSD.Text["d"])
                draw.DrawText(text, "MSDFont.18", 45, h / 2 - 9, MSD.Text["l"], TEXT_ALIGN_LEFT)
                surface.SetDrawColor(Color(60, 60, 60))
                surface.DrawLine(15, h - 1, w - 15, h - 1)
            end
            btn.DoClick = func
            detailsPanel:AddItem(btn)
            return btn
        end

        local function updateDetails(call)
            detailsPanel:Clear()
            if not call then
                local lbl = vgui.Create("DLabel")
                lbl:SetText("Выберите вызов из списка.")
                lbl:SetFont("MSDFont.20")
                lbl:SetTextColor(MSD.Text["a"])
                lbl:SetTall(40)
                lbl:Dock(TOP)
                detailsPanel:AddItem(lbl)
                return
            end

            local titlePanel = vgui.Create("DPanel")
            titlePanel:SetTall(50)
            titlePanel:Dock(TOP)
            titlePanel.Paint = function(s, w, h)
                surface.SetDrawColor(255, 255, 255)
                surface.SetMaterial(grad_mat)
                surface.DrawTexturedRect(0, 0, w, h)
                draw.RoundedBoxEx(MSD.Config.Rounded, 0, 0, w, h, Color(40, 10, 50, 180), true, true, false, false)
                draw.DrawText("Вызов № " .. call.i, "MSDFont.22", w / 2, h / 2 - 11, color_white, TEXT_ALIGN_CENTER)
            end
            detailsPanel:AddItem(titlePanel)

            local function addInfoLabel(text, color)
                local lbl = vgui.Create("DLabel")
                lbl:SetText(text)
                lbl:SetFont("MSDFont.18")
                lbl:SetTextColor(color)
                lbl:SetTall(25)
                lbl:Dock(TOP)
                detailsPanel:AddItem(lbl)
            end

            addInfoLabel("Заявитель: " .. call.c, Color(255, 200, 0))
            addInfoLabel("Причина: " .. call.r, Color(255, 200, 0))

            local df = os.time() - call.t
            addInfoLabel("Вызов поступил " .. FormatTime(df), MSD.Text["d"])

            addActionButton("Связаться с заявителем", MSD.Icons48.cellphone_text, function() end)
            addActionButton("Место вызова", MSD.Icons48.layers, function() end)

            local unitHeader = vgui.Create("DPanel")
            unitHeader:SetTall(30)
            unitHeader:Dock(TOP)
            unitHeader.Paint = function(s, w, h)
                draw.DrawText("Юниты на вызове:", "MSDFont.18", w / 2, h / 2 - 9, MSD.Text["a"], TEXT_ALIGN_CENTER)
            end
            detailsPanel:AddItem(unitHeader)

            local lp_eid = LocalPlayer():EntIndex()
            local assigned = false
            for eid, _ in pairs(call.officers or {}) do
                if eid == lp_eid then assigned = true end
                local pl = Entity(eid)
                if IsValid(pl) then
                    local lbl = vgui.Create("DLabel")
                    lbl:SetText(pl:GetNWString("u_code", pl:Nick()))
                    lbl:SetFont("MSDFont.18")
                    lbl:SetTextColor(MSD.Text["s"])
                    lbl:SetTall(22)
                    lbl:Dock(TOP)
                    detailsPanel:AddItem(lbl)
                end
            end

            if not assigned then
                addActionButton("Принять вызов", MSD.Icons48.check, function()
                    net.Start("911Accept")
                    net.WriteUInt(call.i, 16)
                    net.SendToServer()
                    frame:AlphaTo(0, 0.3, 0, function() frame:Remove() end)
                end)
            else
                addActionButton("Завершить вызов", MSD.Icons48.close_box, function()
                    net.Start("911Close")
                    net.WriteUInt(call.i, 16)
                    net.SendToServer()
                    frame:AlphaTo(0, 0.3, 0, function() frame:Remove() end)
                end)
                addActionButton("Открепиться", MSD.Icons48.exit_to_app, function()
                    net.Start("911Unassign")
                    net.WriteUInt(call.i, 16)
                    net.SendToServer()
                    frame:AlphaTo(0, 0.3, 0, function() frame:Remove() end)
                end)
            end
        end

        local function refreshList()
            listPanel:Clear()

            local searchHeader = vgui.Create("DPanel")
            searchHeader:SetTall(40)
            searchHeader:Dock(TOP)
            searchHeader.Paint = function(s, w, h)
                draw.RoundedBox(MSD.Config.Rounded, 5, 5, w - 10, h - 10, Color(40, 40, 40))
                MSD.DrawTexturedRect(10, 10, 20, 20, MSD.Icons48.search, MSD.Text["a"])
            end
            listPanel:AddItem(searchHeader)

            local activeHeader = vgui.Create("DPanel")
            activeHeader:SetTall(30)
            activeHeader:Dock(TOP)
            activeHeader.Paint = function(s, w, h)
                draw.DrawText("Активные вызовы", "MSDFont.16", w / 2, h / 2 - 8, MSD.Text["s"], TEXT_ALIGN_CENTER)
            end
            listPanel:AddItem(activeHeader)

            for _, call in ipairs(a911) do
                local btn = vgui.Create("DButton")
                btn:SetText("")
                btn:SetTall(55)
                btn:Dock(TOP)
                btn:DockMargin(2, 2, 2, 2)
                btn.call_data = call
                btn.Paint = function(s, w, h)
                    local isSelected = selectedCall and selectedCall.i == call.i
                    local isHovered = s:IsHovered()
                    local bg = isHovered and Color(50, 50, 50) or Color(25, 25, 25)
                    draw.RoundedBox(MSD.Config.Rounded, 0, 0, w, h, bg)

                    if isSelected then
                        draw.RoundedBoxEx(MSD.Config.Rounded, 0, 0, 6, h, Color(255, 165, 0), true, false, true, false)
                    end

                    draw.DrawText("[" .. call.i .. "] " .. call.r, "MSDFont.18", 10, 5, color_white, TEXT_ALIGN_LEFT)
                    local df = os.time() - call.t
                    draw.DrawText("Подано " .. FormatTime(df), "MSDFont.14", 10, 27, MSD.Text["a"], TEXT_ALIGN_LEFT)

                    MSD.DrawTexturedRect(w - 40, h / 2 - 12, 24, 24, folder_icon, MSD.Text["a"])
                end
                btn.DoClick = function()
                    selectedCall = call
                    updateDetails(call)
                end
                listPanel:AddItem(btn)
            end

            if #a911 == 0 then
                local emptyLbl = vgui.Create("DLabel")
                emptyLbl:SetText("Нет активных вызовов.")
                emptyLbl:SetFont("MSDFont.18")
                emptyLbl:SetTextColor(MSD.Text["a"])
                emptyLbl:SetTall(40)
                emptyLbl:Dock(TOP)
                listPanel:AddItem(emptyLbl)
            end
        end

        refreshList()

        selectedCall = nil
        updateDetails(nil)

        local refreshTimer = timer.Create("PoliceMenuRefresh", 2.0, 0, function()
            if IsValid(frame) then
                refreshList()
                if selectedCall then
                    local found = false
                    for _, c in ipairs(a911) do
                        if c.i == selectedCall.i then found = true break end
                    end
                    if not found then
                        selectedCall = nil
                        updateDetails(nil)
                    end
                end
            else
                timer.Remove("PoliceMenuRefresh")
            end
        end)

        frame.OnClose = function()
            timer.Remove("PoliceMenuRefresh")
        end

        p_m_p = frame
    end)
end