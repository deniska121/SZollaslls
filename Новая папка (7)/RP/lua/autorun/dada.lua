if CLIENT then
    local cv_enabled = CreateClientConVar("hands_enable", 1)
    local cv_autoscale = CreateClientConVar("hands_autoscale", 1)
    local cv_autoscale_lerp = CreateClientConVar("hands_autoscale_lerp", 0.5)
    local cv_exscale = CreateClientConVar("hands_exscale", 0.1)
    local cv_nextthink = CreateClientConVar("hands_nextthink", 0.5)
    local cv_enableshoulder = CreateClientConVar("hands_enableshoulder", 1)
    local cv_infscl = CreateClientConVar("hands_infscl", 0)

    local myfunkinhugeval = math.huge

    local function is_female(pmdl)
        if not pmdl then return false end
        pmdl = pmdl:lower()
        return string.find(pmdl, "female") ~= nil
    end

    local function is_custom(pmdl)
        if not pmdl then return false end
        if is_female(pmdl) then return false end
        if string.find(pmdl, "models/cityrp/pm/nypd/") then return true end
        if string.find(pmdl, "models/cityrp/pm/normal/") then return true end
        if string.find(pmdl, "models/cityrp/pm/suit/") then return true end
        return false
    end

    local function is_normal(pmdl)
        if not pmdl then return false end
        pmdl = pmdl:lower()
        return string.find(pmdl, "models/cityrp/pm/normal/male_") ~= nil
    end

    local function apply_sleeves_to_entity(ent, topid)
        if not IsValid(ent) then return end
        local mats = ent:GetMaterials()
        if not mats then return end
        if topid <= 1 then
            for i = 1, #mats do ent:SetSubMaterial(i-1, nil) end
            return
        end
        local tex = "gbskins/outfit/top_" .. topid
        for k, v in ipairs(mats) do
            local n = v:lower()
            local isTop = (n:find("top") or n:find("shirt") or n:find("body") or n:find("suit") or n:find("vest") or n:find("jacket"))
                and not (n:find("face") or n:find("head") or n:find("pants") or n:find("legs") or n:find("boots") or n:find("feet"))
            if isTop then
                ent:SetSubMaterial(k-1, tex)
            end
        end
    end

    local function clear_submaterials(ent)
        if not IsValid(ent) then return end
        local mats = ent:GetMaterials()
        if not mats then return end
        for i = 1, #mats do ent:SetSubMaterial(i-1, nil) end
    end

    local function Check(ch, i)
        local shoulder = cv_enableshoulder:GetInt()
        local name = ch:GetBoneName(i)

        if string.find(name,"Shoulder") then
            return shoulder > 0
        elseif string.find(name,"Trapezius") then
            return shoulder > 1
        end

        local lArm = ch:LookupBone("ValveBiped.Bip01_L_UpperArm")
        local rArm = ch:LookupBone("ValveBiped.Bip01_R_UpperArm")

        while (i and i ~= -1) do
            if i == lArm or i == rArm then return true end
            i = ch:GetBoneParent(i)
        end

        return false
    end

    local function calcBaseScale(ent)
        local bone1 = ent:LookupBone("ValveBiped.Bip01_R_UpperArm")
        local bone2 = ent:LookupBone("ValveBiped.Bip01_R_Forearm")
        local bone3 = ent:LookupBone("ValveBiped.Bip01_R_Hand")
        if not bone1 or not bone2 or not bone3 then return 1 end

        local bp2 = ent:GetBonePosition(bone2)
        local dist1 = ent:GetBonePosition(bone1):Distance(bp2)
        local dist2 = bp2:Distance(ent:GetBonePosition(bone3))

        if dist1 == 0 or dist2 == 0 then return 1 end

        return Lerp(cv_autoscale_lerp:GetFloat(), 11.69 / dist1, 11.48 / dist2)
    end

    local function apply_to_hands(ply)
        if not IsValid(ply) then return end
        local pmdl = ply:GetModel()
        if not is_custom(pmdl) then return end

        local h = ply:GetHands()
        if not IsValid(h) then return end

        local tgt = "models/cityrp/pm/c_arms.mdl"
        if h:GetModel() ~= tgt then
            h:SetModel(tgt)
        end

        local handsbg = 0
        if string.find(pmdl, "nypd") then
            handsbg = 2
        elseif string.find(pmdl, "/suit/") then
            handsbg = 1
        end

        local armsbg = 0
        if string.find(pmdl, "male") then
            armsbg = 1
        end

        local idxh = h:FindBodygroupByName("hands")
        if idxh then h:SetBodygroup(idxh, handsbg) end
        local idxa = h:FindBodygroupByName("arms")
        if idxa then h:SetBodygroup(idxa, armsbg) end

        if is_normal(pmdl) then
            local topid = ply:GetNWInt("top_id", 1)
            apply_sleeves_to_entity(h, topid)
        else
            clear_submaterials(h)
        end
    end

    local function apply_to_model(ply)
        if not IsValid(ply) then return end
        local pmdl = ply:GetModel()

        local handsbg = 0
        if string.find(pmdl, "nypd") then
            handsbg = 2
        elseif string.find(pmdl, "/suit/") then
            handsbg = 1
        end

        local armsbg = 0
        if string.find(pmdl, "male") then
            armsbg = 1
        end

        local idxh = ply:FindBodygroupByName("hands")
        if idxh then ply:SetBodygroup(idxh, handsbg) end
        local idxa = ply:FindBodygroupByName("arms")
        if idxa then ply:SetBodygroup(idxa, armsbg) end
    end

    local function buildbonepos(ent,nb)
        if not cv_enabled:GetBool() then return end

        local p = LocalPlayer()
        if not IsValid(p) then return end
        if ent ~= p:GetHands() then return end

        local baseScale = calcBaseScale(p)
        local d = 1 + (baseScale - 1) * (1 + cv_exscale:GetFloat())
        local posDlt = p:EyePos() - p:GetAimVector() * 100

        for i = 0, nb - 1 do
            local mat = ent:GetBoneMatrix(i)
            if not mat then continue end

            if not Check(ent, i) then
                mat:Scale(cv_infscl:GetBool() and Vector(myfunkinhugeval,myfunkinhugeval,myfunkinhugeval) or Vector(0,0,0))
                mat:SetTranslation(posDlt)
            elseif cv_autoscale:GetBool() then
                local scale = mat:GetScale()
                scale:Mul(d)
                mat:Scale(scale)
            end
            ent:SetBoneMatrix(i, mat)
        end
    end

    local function mainfunc()
        if not cv_enabled:GetBool() then return end

        local p = LocalPlayer()
        if not IsValid(p) then return end
        if not is_custom(p:GetModel()) then return end

        local hands = p:GetHands()
        if not IsValid(hands) then return end

        hands:SetModel(p:GetModel())

        if not hands.hands_callback then
            hands.hands_callback = hands:AddCallback("BuildBonePositions", buildbonepos)
        end

        for i = 0, p:GetNumBodyGroups() do
            hands:SetBodygroup(i, p:GetBodygroup(i))
        end

        apply_to_hands(p)
    end

    timer.Create("hands_maintain", cv_nextthink:GetFloat(), 0, mainfunc)

    local function schedule_update(ply, delays)
        if not IsValid(ply) then return end
        for _, delay in ipairs(delays) do
            timer.Simple(delay, function()
                if IsValid(ply) and is_custom(ply:GetModel()) then
                    mainfunc()
                end
            end)
        end
    end

    hook.Add("VehicleExit", "hands_veh_exit", function(ply, vehicle)
        if ply == LocalPlayer() then
            schedule_update(ply, {0.01, 0.03, 0.05, 0.1, 0.15, 0.2, 0.3, 0.5, 0.7, 1.0, 1.5, 2.0, 3.0})
        end
    end)

    hook.Add("PlayerEnteredVehicle", "hands_veh_enter", function(ply, vehicle, role)
        if ply == LocalPlayer() then
            timer.Simple(0.1, function()
                if IsValid(ply) and is_custom(ply:GetModel()) then
                    mainfunc()
                end
            end)
        end
    end)

    hook.Add("PlayerSetHandsModel", "hands_override", function(ply, ent)
        if not IsValid(ply) then return end
        if is_custom(ply:GetModel()) then
            timer.Simple(0.01, function()
                if IsValid(ply) then mainfunc() end
            end)
            timer.Simple(0.05, function()
                if IsValid(ply) then mainfunc() end
            end)
        end
    end)

    hook.Add("PlayerSpawn", "hands_spawn", function(ply)
        if ply == LocalPlayer() then
            schedule_update(ply, {0.05, 0.1, 0.2, 0.5})
        end
    end)

    hook.Add("PlayerSwitchWeapon", "hands_wep", function(ply, old, new)
        if ply == LocalPlayer() and is_custom(ply:GetModel()) then
            timer.Simple(0.01, function()
                if IsValid(ply) then mainfunc() end
            end)
            timer.Simple(0.05, function()
                if IsValid(ply) then mainfunc() end
            end)
        end
    end)

    local justExited = false
    local exitTime = 0

    hook.Add("VehicleExit", "hands_exit_track", function(ply, vehicle)
        if ply == LocalPlayer() then
            justExited = true
            exitTime = CurTime()
        end
    end)

    hook.Add("Think", "hands_exit_think", function()
        local ply = LocalPlayer()
        if not IsValid(ply) then return end
        if not is_custom(ply:GetModel()) then return end
        if not justExited then return end

        if CurTime() - exitTime < 3.0 then
            mainfunc()
        else
            justExited = false
        end
    end)

    hook.Add("PreDrawViewModel", "hands_predraw", function()
        local ply = LocalPlayer()
        if IsValid(ply) and is_custom(ply:GetModel()) then
            mainfunc()
        end
    end)

    local playerCache = {}
    hook.Add("Think", "hands_cache", function()
        for _, ply in ipairs(player.GetAll()) do
            if not IsValid(ply) then continue end
            local cmdl = ply:GetModel()
            local ctop = ply:GetNWInt("top_id", 0)
            local h = ply:GetHands()
            local inVeh = ply:InVehicle()
            local cache = playerCache[ply]
            if not cache then
                cache = { model = "", top = 0, hands = NULL, inVehicle = false }
                playerCache[ply] = cache
            end
            if cmdl ~= cache.model or ctop ~= cache.top or h ~= cache.hands or inVeh ~= cache.inVehicle then
                cache.model = cmdl
                cache.top = ctop
                cache.hands = h
                cache.inVehicle = inVeh
                if cv_enabled:GetBool() then
                    mainfunc()
                end
            end
        end
    end)

    hook.Add("PlayerDisconnected", "hands_disconnect", function(ply)
        playerCache[ply] = nil
    end)

    local lastBodygroupUpdate = 0
    hook.Add("Think", "hands_bodygroup", function()
        if CurTime() < lastBodygroupUpdate + 0.2 then return end
        lastBodygroupUpdate = CurTime()
        for _, ply in ipairs(player.GetAll()) do
            if IsValid(ply) and is_custom(ply:GetModel()) and ply ~= LocalPlayer() then
                apply_to_model(ply)
            end
        end
    end)

    hook.Add("DoPlayerDeath", "hands_death", function(ply, attacker, dmginfo)
        if ply == LocalPlayer() then
            timer.Simple(0.1, function()
                if IsValid(ply) and is_custom(ply:GetModel()) then
                    mainfunc()
                end
            end)
        end
    end)
end