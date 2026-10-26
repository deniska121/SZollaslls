if SERVER then
    util.AddNetworkString("KillEffect")
    
    hook.Add("EntityTakeDamage", "KillEffectOnDamage", function(target, dmginfo)
        if not IsValid(target) or not target:IsPlayer() then return end
        if not target:Alive() then return end
        
        local attacker = dmginfo:GetAttacker()
        if not IsValid(attacker) or not attacker:IsPlayer() then return end
        if attacker == target then return end
        
        local newHealth = target:Health() - dmginfo:GetDamage()
        if newHealth <= 0 then
            timer.Simple(0.05, function()
                if IsValid(attacker) then
                    net.Start("KillEffect")
                    net.Send(attacker)
                end
            end)
        end
    end)
    
    hook.Add("PlayerDeath", "KillEffectOnDeath", function(victim, inflictor, attacker)
        if not IsValid(attacker) or not attacker:IsPlayer() then return end
        if attacker == victim then return end
        
        timer.Simple(0.05, function()
            if IsValid(attacker) then
                net.Start("KillEffect")
                net.Send(attacker)
            end
        end)
    end)
    
    hook.Add("DoPlayerDeath", "KillEffectOnDoDeath", function(victim, attacker, dmginfo)
        if not IsValid(attacker) or not attacker:IsPlayer() then return end
        if attacker == victim then return end
        
        timer.Simple(0.05, function()
            if IsValid(attacker) then
                net.Start("KillEffect")
                net.Send(attacker)
            end
        end)
    end)
    
    local lastHealth = {}
    
    hook.Add("Think", "KillEffectTracker", function()
        for _, ply in ipairs(player.GetAll()) do
            if IsValid(ply) then
                local steamID = ply:SteamID()
                local health = ply:Health()
                local alive = ply:Alive()
                
                if lastHealth[steamID] and lastHealth[steamID].alive and not alive then
                    local attacker = lastHealth[steamID].lastAttacker
                    if IsValid(attacker) and attacker:IsPlayer() and attacker != ply then
                        timer.Simple(0.05, function()
                            if IsValid(attacker) then
                                net.Start("KillEffect")
                                net.Send(attacker)
                            end
                        end)
                    end
                end
                
                lastHealth[steamID] = {
                    alive = alive,
                    health = health,
                    lastAttacker = ply.LastAttacker or lastHealth[steamID] and lastHealth[steamID].lastAttacker
                }
            end
        end
    end)
    
    hook.Add("EntityTakeDamage", "KillEffectStoreAttacker", function(target, dmginfo)
        if not IsValid(target) or not target:IsPlayer() then return end
        local attacker = dmginfo:GetAttacker()
        if IsValid(attacker) and attacker:IsPlayer() then
            target.LastAttacker = attacker
            local steamID = target:SteamID()
            if lastHealth[steamID] then
                lastHealth[steamID].lastAttacker = attacker
            end
        end
    end)
    
    return
end

if CLIENT then
    local effectActive = false
    local effectStart = 0
    local effectDuration = 1.2
    local effectEnabled = true
    local mat = Material("msd/vignette.png", "nocull smooth")
    
    concommand.Add("chyst", function()
        effectEnabled = not effectEnabled
    end)
    
    net.Receive("KillEffect", function()
        if not effectEnabled then return end
        effectActive = true
        effectStart = CurTime()
    end)
    
    hook.Add("RenderScreenspaceEffects", "DrawKillEffect", function()
        if not effectActive then return end
        
        local elapsed = CurTime() - effectStart
        if elapsed > effectDuration then
            effectActive = false
            return
        end
        
        local progress = elapsed / effectDuration
        local alpha = (1 - progress) * 255
        
        local w, h = ScrW(), ScrH()
        
        surface.SetMaterial(mat)
        surface.SetDrawColor(255, 0, 0, alpha)
        surface.DrawTexturedRect(0, 0, w, h)
    end)
end