if SERVER then
    SingleWeapon = {}
    
    SingleWeapon.Pistols = {
        ["mwb_357"] = true,
        ["mwb_deagle"] = true,
        ["mwb_m1911"] = true,
        ["mwb_pm"] = true,
        ["mwb_m9"] = true,
        ["mwb_93r"] = true,
        ["mwb_glock21"] = true,
        ["mwb_glock17"] = true,
        ["mwb_glock19"] = true,
        ["mwb_p220"] = true,
        ["mwb_tec9"] = true,
        ["weapon_taser"] = true,
    }
    
    SingleWeapon.Rifles = {
        ["mwb_akm"] = true,
        ["mwb_ak74"] = true,
        ["mwb_ak74u"] = true,
        ["mwb_spapa12"] = true,
        ["mwb_m590"] = true,
        ["mwb_ithaca"] = true,
        ["mwb_mk17"] = true,
        ["mwb_marlin"] = true,
        ["mwb_kar98"] = true,
        ["mwb_c725"] = true,
        ["mwb_mp5"] = true,
        ["mwb_m4"] = true,
        ["mwb_m4a1"] = true,
        ["mwb_uzi"] = true,
        ["mwb_thompson"] = true,
        ["mwb_mac10"] = true,
        ["mwb_aug"] = true,
        ["mwb_auga2"] = true,
        ["weapon_shotgun"] = true,
        ["weapon_smg"] = true,
        ["weapon_ar2"] = true,
    }
    
    SingleWeapon.Melee = {
        ["weapon_crowbar"] = true,
        ["weapon_fish"] = true,
        ["weapon_molotov"] = true,
        ["lockpick"] = true,
        ["mlw_bat"] = true,
        ["mlw_pickaxe"] = true,
        ["mlw_club"] = true,
        ["mlw_sledge"] = true,
        ["mlw_crowbar"] = true,
        ["mlw_briefcase"] = true,
        ["mlw_spade"] = true,
        ["mlw_machete"] = true,
        ["mlw_knife"] = true,
        ["mlw_fireaxe"] = true,
        ["mlw_hatchet"] = true,
        ["mlw_pipe"] = true,
        ["mlw_hammer"] = true,
        ["mlw_tonfa"] = true,
    }
    
    SingleWeapon.DisallowDrop = {
        ["weapon_ebaniehands"] = true,
        ["mlw_tonfa"] = true,
    }
    
    SingleWeapon.All = {}
    table.Merge(SingleWeapon.All, SingleWeapon.Pistols)
    table.Merge(SingleWeapon.All, SingleWeapon.Rifles)
    table.Merge(SingleWeapon.All, SingleWeapon.Melee)
    
    function SingleWeapon.HasType(ply, list, exclude)
        for _, wep in ipairs(ply:GetWeapons()) do
            if IsValid(wep) and wep ~= exclude then
                if list[wep:GetClass()] then
                    return wep
                end
            end
        end
        return false
    end
    
    function SingleWeapon.DropWeapon(ply, wep)
        if not IsValid(ply) or not IsValid(wep) then return false end
        if SingleWeapon.DisallowDrop[wep:GetClass()] then return false end
        
        local class = wep:GetClass()
        local clip1 = wep:Clip1()
        local clip2 = wep:Clip2()
        
        ply:StripWeapon(class)
        
        local droppedWep = ents.Create(class)
        if not IsValid(droppedWep) then return false end
        
        local eyePos = ply:EyePos()
        local forward = ply:EyeAngles():Forward()
        local dropPos = eyePos + forward * 40 + Vector(0, 0, -10)
        
        local tr = util.TraceHull({
            start = eyePos,
            endpos = dropPos,
            filter = ply,
            mins = Vector(-8, -8, -8),
            maxs = Vector(8, 8, 8)
        })
        
        if tr.Hit then
            local offsets = {
                Vector(0, 0, 15),
                Vector(0, 15, 0),
                Vector(0, -15, 0),
                Vector(15, 0, 0),
                Vector(-15, 0, 0)
            }
            for _, off in ipairs(offsets) do
                local testPos = dropPos + off
                local testTr = util.TraceHull({
                    start = eyePos,
                    endpos = testPos,
                    filter = ply,
                    mins = Vector(-8, -8, -8),
                    maxs = Vector(8, 8, 8)
                })
                if not testTr.Hit then
                    dropPos = testPos
                    break
                end
            end
        end
        
        droppedWep:SetPos(dropPos)
        droppedWep:SetAngles(Angle(0, ply:EyeAngles().yaw, 0))
        droppedWep:Spawn()
        droppedWep:Activate()
        
        if droppedWep.SetClip1 and clip1 and clip1 > 0 then
            droppedWep:SetClip1(clip1)
        end
        if droppedWep.SetClip2 and clip2 and clip2 > 0 then
            droppedWep:SetClip2(clip2)
        end
        
        local phys = droppedWep:GetPhysicsObject()
        if IsValid(phys) then
            local vel = Vector(
                math.random(-20, 20),
                math.random(-20, 20),
                math.random(10, 30)
            )
            phys:SetVelocity(vel)
            phys:Wake()
        end
        
        return true
    end
    
    hook.Add("PlayerSwitchWeapon", "SingleWeapon_Switch", function(ply, oldWep, newWep)
        if not IsValid(ply) or not IsValid(newWep) then return end
        if not IsValid(oldWep) then return end
        
        local newClass = newWep:GetClass()
        
        if not SingleWeapon.All[newClass] then return end
        if SingleWeapon.DisallowDrop[newClass] then return end
        
        local weaponToDrop = nil
        
        if SingleWeapon.Pistols[newClass] then
            weaponToDrop = SingleWeapon.HasType(ply, SingleWeapon.Pistols, newWep)
        elseif SingleWeapon.Rifles[newClass] then
            weaponToDrop = SingleWeapon.HasType(ply, SingleWeapon.Rifles, newWep)
        elseif SingleWeapon.Melee[newClass] then
            weaponToDrop = SingleWeapon.HasType(ply, SingleWeapon.Melee, newWep)
        end
        
        if IsValid(weaponToDrop) and weaponToDrop ~= newWep then
            timer.Simple(0.1, function()
                if IsValid(ply) and IsValid(weaponToDrop) then
                    SingleWeapon.DropWeapon(ply, weaponToDrop)
                end
            end)
        end
    end)
    
    concommand.Add("+drop", function(ply)
        if not IsValid(ply) then return end
        local active = ply:GetActiveWeapon()
        if IsValid(active) and SingleWeapon.All[active:GetClass()] then
            if not SingleWeapon.DisallowDrop[active:GetClass()] then
                SingleWeapon.DropWeapon(ply, active)
            end
        end
    end)
    
    concommand.Add("-drop", function(ply) end)
end

if CLIENT then
    hook.Add("Initialize", "SetEjectBrass", function()
        RunConsoleCommand("cl_ejectbrass", "0")
    end)
end