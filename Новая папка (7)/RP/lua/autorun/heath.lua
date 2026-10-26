if CLIENT then
    local heartBeatSound = nil
    local shakeTimer = 0
    local heartBeatTimer = 0
    
    hook.Add("Think", "LowHealth_Heartbeat", function()
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then
            if heartBeatSound then
                heartBeatSound:Stop()
                heartBeatSound = nil
            end
            return
        end
        
        local hp = ply:Health()
        local maxHp = ply:GetMaxHealth() or 100
        local hpPercent = (hp / maxHp) * 100
        
        if hpPercent < 20 then
            if not heartBeatSound then
                heartBeatSound = CreateSound(ply, "headshot/heartbeat.wav")
                if heartBeatSound then
                    heartBeatSound:Play()
                end
            end
            if heartBeatSound then
                if not heartBeatSound:IsPlaying() then
                    heartBeatSound:Play()
                end
                local volume = 0.3 + (1 - hpPercent / 20) * 0.7
                local pitch = 70 + (1 - hpPercent / 20) * 50
                heartBeatSound:ChangeVolume(math.Clamp(volume, 0.1, 1), 0)
                heartBeatSound:ChangePitch(math.Clamp(pitch, 50, 150), 0)
            end
        else
            if heartBeatSound then
                heartBeatSound:Stop()
                heartBeatSound = nil
            end
        end
    end)
    
    hook.Add("Think", "LowHealth_ScreenShake", function()
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end
        
        local hp = ply:Health()
        local maxHp = ply:GetMaxHealth() or 100
        local hpPercent = (hp / maxHp) * 100
        local isMoving = ply:GetVelocity():Length2DSqr() > 100
        
        if hpPercent < 15 then
            if shakeTimer < CurTime() then
                local amp = 1.0 + (1 - hpPercent / 15) * 3.0
                util.ScreenShake(Vector(0,0,0), amp, amp * 0.8, 0.5, 1)
                shakeTimer = CurTime() + 0.02
            end
        elseif hpPercent < 40 and isMoving then
            if shakeTimer < CurTime() then
                local intensity = (1 - hpPercent / 40) * 2.5
                local amp = 0.5 + intensity
                util.ScreenShake(Vector(0,0,0), amp, amp * 0.5, 0.25 + intensity * 0.2, 0.5)
                shakeTimer = CurTime() + 0.05
            end
        end
    end)
    
    hook.Add("RenderScreenspaceEffects", "LowHealth_VisualEffects", function()
        local ply = LocalPlayer()
        if not IsValid(ply) or not ply:Alive() then return end
        
        local hp = ply:Health()
        local maxHp = ply:GetMaxHealth() or 100
        local hpPercent = (hp / maxHp) * 100
        
        if hpPercent < 40 then
            local intensity = 1 - (hpPercent / 40)
            local redIntensity = intensity * 0.5
            
            local tab = {
                ["$pp_colour_addr"] = redIntensity * 0.4,
                ["$pp_colour_addg"] = 0,
                ["$pp_colour_addb"] = 0,
                ["$pp_colour_brightness"] = -intensity * 0.2,
                ["$pp_colour_contrast"] = 1 + intensity * 0.5,
                ["$pp_colour_colour"] = 1 - intensity * 0.5,
                ["$pp_colour_mulr"] = 0,
                ["$pp_colour_mulg"] = 0,
                ["$pp_colour_mulb"] = 0
            }
            DrawColorModify(tab)
            
            if hpPercent < 20 then
                local blurIntensity = (1 - hpPercent / 20) * 0.6
                DrawMotionBlur(0.4, blurIntensity, 0.03)
            end
            
            local vignetteMat = Material("gui/gradient")
            if vignetteMat then
                surface.SetMaterial(vignetteMat)
                surface.SetDrawColor(0, 0, 0, (1 - hpPercent / 40) * 180)
                surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
            end
        end
    end)
    
    hook.Add("HUDShouldDraw", "LowHealth_HideCrosshair", function(name)
        if name == "CHudCrosshair" then
            local ply = LocalPlayer()
            if IsValid(ply) and ply:Alive() then
                local hp = ply:Health()
                local maxHp = ply:GetMaxHealth() or 100
                local hpPercent = (hp / maxHp) * 100
                
                if hpPercent < 15 then
                    return false
                end
            end
        end
    end)
    
    hook.Add("StartCommand", "LowHealth_Slowdown", function(ply, cmd)
        if not IsValid(ply) or not ply:Alive() then return end
        
        local hp = ply:Health()
        local maxHp = ply:GetMaxHealth() or 100
        local hpPercent = (hp / maxHp) * 100
        
        if hpPercent < 15 then
            local speedMul = 0.2 + (hpPercent / 15) * 0.5
            cmd:SetForwardMove(cmd:GetForwardMove() * speedMul)
            cmd:SetSideMove(cmd:GetSideMove() * speedMul)
        end
    end)
end