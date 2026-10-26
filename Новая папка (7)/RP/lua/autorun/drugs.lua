if CLIENT then return end

Drugs = Drugs or {}
Horrors = Horrors or {}
Horrors2 = Horrors2 or {}
Son = Son or {}

hook.Add("Think", "DrugSysLoop", function()
    for ply, wake in pairs(Drugs) do
        if not IsValid(ply) or not ply:Alive() then
            Drugs[ply] = nil
        elseif CurTime() >= wake then
            Drugs[ply] = nil
            ply:SetNWFloat("DrugTime", 0)
            if Sleep then Sleep(ply, 20) end
        end
    end

    for ply, wake in pairs(Horrors) do
        if not IsValid(ply) or not ply:Alive() then
            Horrors[ply] = nil
        elseif CurTime() >= wake then
            Horrors[ply] = nil
            ply:SetNWFloat("HorrorTime", 0)
            ply:SetNWFloat("HorrorDuration", 0)
            if Sleep then Sleep(ply, 30) end
        end
    end

    for ply, wake in pairs(Horrors2) do
        if not IsValid(ply) or not ply:Alive() then
            Horrors2[ply] = nil
        elseif CurTime() >= wake then
            Horrors2[ply] = nil
            ply:SetNWFloat("Horror2Time", 0)
            ply:SetNWFloat("Horror2Duration", 0)
            if Sleep then Sleep(ply, 30) end
        end
    end

    for ply, wake in pairs(Son) do
        if not IsValid(ply) or not ply:Alive() then
            Son[ply] = nil
        elseif CurTime() >= wake then
            Son[ply] = nil
            ply:SetNWFloat("SonTime", 0)
            ply:SetNWFloat("SonDuration", 0)
        end
    end
end)