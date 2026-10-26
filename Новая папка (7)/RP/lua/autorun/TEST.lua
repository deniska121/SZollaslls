local faceConfig = {
    ["male_01"] = { prefix = "van_facemap", max = 17 },
    ["male_02"] = { prefix = "ted_facemap", max = 29 },
    ["male_03"] = { prefix = "joe_facemap", max = 23 },
    ["male_04"] = { prefix = "eric_facemap", max = 27 },
    ["male_05"] = { prefix = "art_facemap", max = 21 },
    ["male_06"] = { prefix = "sandro_facemap", max = 23 },
    ["male_07"] = { prefix = "mike_facemap", max = 24 },
    ["male_08"] = { prefix = "ted_facemap", max = 29 },
    ["male_09"] = { prefix = "erdim_facemap", max = 20 },
}

local function chkMdl(e)
    if not IsValid(e) then return false end
    local m = e:GetModel()
    if not m or m == "" then return false end
    m = m:lower():gsub("\\", "/")
    return m:find("c_arms") or (not m:find("female") and (m:find("male") or m:find("citizen") or m:find("group")))
end

local function isNormal(e)
    if not IsValid(e) then return false end
    local m = e:GetModel()
    if not m then return false end
    m = m:lower()
    return m:find("cityrp/pm/normal/male_") ~= nil
end

local function isNYPD(e)
    if not IsValid(e) then return false end
    local m = e:GetModel()
    if not m then return false end
    m = m:lower()
    return m:find("cityrp/pm/nypd/male_") ~= nil
end

local function isSuit(e)
    if not IsValid(e) then return false end
    local m = e:GetModel()
    if not m then return false end
    m = m:lower()
    return m:find("cityrp/pm/suit/") ~= nil
end

local function getFaceCfg(e)
    if not IsValid(e) then return end
    local m = e:GetModel()
    if not m or m == "" then return end
    m = m:lower()
    for k, v in pairs(faceConfig) do
        if m:find(k) then return v end
    end
end

local function resetSubs(e)
    if not IsValid(e) then return end
    local mats = e:GetMaterials()
    if not mats then return end
    for i = 1, #mats do e:SetSubMaterial(i-1, nil) end
end

local function getTorsoGroup(e)
    if not IsValid(e) then return 0 end
    local bgs = e:GetBodyGroups()
    for _, bg in ipairs(bgs) do
        if bg.name:lower() == "torso" then
            return e:GetBodygroup(bg.id)
        end
    end
    return 0
end

local function getTopTex(e, topid)
    if not IsValid(e) then return nil end
    if isNormal(e) and getTorsoGroup(e) == 2 then
        if topid <= 1 then return nil end
        local map = {
            [2] = "taxi",
            [3] = "worker",
            [4] = "bus",
            [5] = "deliver",
            [6] = "food",
            [7] = "mail",
            [8] = "pantic",
            [9] = "ff",
        }
        local name = map[topid]
        if name then
            return "models/gmodbest/suit/jobs/" .. name
        else
            return nil
        end
    else
        if topid > 1 then
            return "gbskins/outfit/top_" .. topid
        else
            return nil
        end
    end
end

local function applyLegacy(e, cid, fid)
    if not IsValid(e) then return end
    local mats = e:GetMaterials()
    if not mats then return end
    if (cid <= 1 and fid <= 1) or not chkMdl(e) then
        resetSubs(e)
        return
    end
    local faceCfg = getFaceCfg(e)
    for k, v in ipairs(mats) do
        local n = v:lower()
        local isCloth = n:find("sheet") or n:find("cloth") or n:find("suit") or n:find("body") or n:find("rebel") or n:find("refugee") or n:find("medic")
        local isFace = (n:find("facemap") or n:find("face") or n:find("head") or n:find("cylmap")) and not (n:find("eye") or n:find("pupil") or n:find("mouth") or n:find("teeth") or n:find("hair") or n:find("skin") or n:find("hand"))
        if isCloth and not isFace then
            e:SetSubMaterial(k - 1, cid > 1 and ("gbskins/male/sheet_" .. cid) or nil)
        elseif isFace then
            e:SetSubMaterial(k - 1, (fid > 1 and faceCfg) and ("models/gmodbest/citizens/facemaps/" .. faceCfg.prefix .. fid) or nil)
        end
    end
end

local function applyNormal(e, top, pants, boots, fid)
    if not IsValid(e) then return end
    local mats = e:GetMaterials()
    if not mats then return end
    if (top <= 1 and pants <= 1 and boots <= 1 and fid <= 1) or not isNormal(e) then
        resetSubs(e)
        return
    end
    local faceCfg = getFaceCfg(e)
    for k, v in ipairs(mats) do
        local n = v:lower()
        local isTop = (n:find("top") or n:find("shirt") or n:find("body") or n:find("suit") or n:find("vest") or n:find("jacket")) and not (n:find("face") or n:find("head") or n:find("pants") or n:find("legs") or n:find("boots") or n:find("feet"))
        local isPants = n:find("pants") or n:find("legs") or n:find("jeans") or n:find("trousers") or n:find("bottom")
        local isBoots = n:find("boots") or n:find("feet") or n:find("shoes") or n:find("foot")
        local isFace = (n:find("facemap") or n:find("face") or n:find("head") or n:find("cylmap")) and not (n:find("eye") or n:find("pupil") or n:find("mouth") or n:find("teeth") or n:find("hair") or n:find("skin") or n:find("hand"))
        if isTop then
            e:SetSubMaterial(k - 1, getTopTex(e, top))
        elseif isPants then
            e:SetSubMaterial(k - 1, pants > 1 and ("gbskins/outfit/pants_" .. pants) or nil)
        elseif isBoots then
            e:SetSubMaterial(k - 1, boots > 1 and ("gbskins/outfit/boots_" .. boots) or nil)
        elseif isFace then
            e:SetSubMaterial(k - 1, (fid > 1 and faceCfg) and ("models/gmodbest/citizens/facemaps/" .. faceCfg.prefix .. fid) or nil)
        end
    end
end

local function applyNYPD(e, shirt, hat, fid)
    if not IsValid(e) then return end
    if not isNYPD(e) then return end
    resetSubs(e)
    if shirt <= 1 and hat <= 1 and fid <= 1 then return end
    local mats = e:GetMaterials()
    if not mats then return end
    local faceCfg = getFaceCfg(e)
    for k, v in ipairs(mats) do
        local n = v:lower()
        local isShirt = (n:find("top") or n:find("shirt") or n:find("body") or n:find("suit") or n:find("vest") or n:find("jacket"))
            and not (n:find("face") or n:find("head") or n:find("pants") or n:find("legs") or n:find("boots") or n:find("feet") or n:find("hat") or n:find("cap") or n:find("helmet"))
        local isHat = n:find("hat") or n:find("cap") or n:find("helmet") or n:find("headgear")
        local isFace = (n:find("facemap") or n:find("face") or n:find("head") or n:find("cylmap"))
            and not (n:find("eye") or n:find("pupil") or n:find("mouth") or n:find("teeth") or n:find("hair") or n:find("skin") or n:find("hand"))
        if isShirt then
            local tex = nil
            if shirt == 1 then tex = nil
            elseif shirt == 2 then tex = "models/gmodbest/suit/male/topc"
            else tex = "models/gmodbest/suit/male/top2" end
            e:SetSubMaterial(k - 1, tex)
        elseif isHat then
            local tex = nil
            if hat == 1 then tex = nil
            elseif hat == 2 then tex = "models/gmodbest/acc/hat_02"
            elseif hat == 3 then tex = "models/gmodbest/acc/hat_03"
            else tex = "models/gmodbest/acc/hat_01" end
            e:SetSubMaterial(k - 1, tex)
        elseif isFace then
            e:SetSubMaterial(k - 1, (fid > 1 and faceCfg) and ("models/gmodbest/citizens/facemaps/" .. faceCfg.prefix .. fid) or nil)
        end
    end
end

local function applySuit(e, suitid, fid)
    if not IsValid(e) then return end
    if not isSuit(e) then return end
    resetSubs(e)
    if suitid <= 1 and fid <= 1 then return end
    local mats = e:GetMaterials()
    if not mats then return end
    local faceCfg = getFaceCfg(e)
    local m = e:GetModel():lower()
    local gender = m:find("female") and "female" or "male"
    local suitTex = suitid > 1 and ("models/gmodbest/suit/" .. gender .. "/suit_sheet" .. suitid) or nil
    for k, v in ipairs(mats) do
        local n = v:lower()
        local isCloth = n:find("sheet") or n:find("cloth") or n:find("suit") or n:find("body") or n:find("rebel") or n:find("refugee") or n:find("medic")
        local isFace = (n:find("facemap") or n:find("face") or n:find("head") or n:find("cylmap")) and not (n:find("eye") or n:find("pupil") or n:find("mouth") or n:find("teeth") or n:find("hair") or n:find("skin") or n:find("hand"))
        if isCloth and not isFace then
            e:SetSubMaterial(k - 1, suitTex)
        elseif isFace then
            e:SetSubMaterial(k - 1, (fid > 1 and faceCfg) and ("models/gmodbest/citizens/facemaps/" .. faceCfg.prefix .. fid) or nil)
        end
    end
end

local function applyCust(e, params)
    if not IsValid(e) then return end
    if isSuit(e) then
        applySuit(e, params.suit or 1, params.face or 1)
    elseif isNYPD(e) then
        applyNYPD(e, params.shirt or 1, params.hat or 1, params.face or 1)
    elseif isNormal(e) then
        applyNormal(e, params.top or 1, params.pants or 1, params.boots or 1, params.face or 1)
    elseif chkMdl(e) then
        applyLegacy(e, params.clth or 1, params.face or 1)
    else
        resetSubs(e)
    end
end

if SERVER then
    util.AddNetworkString("clth_set")
    util.AddNetworkString("clth_set_full")
    util.AddNetworkString("clth_set_nypd")
    util.AddNetworkString("clth_set_suit")

    local function checkAndApply(p)
        if not IsValid(p) then return end
        if not chkMdl(p) and not isNormal(p) and not isNYPD(p) and not isSuit(p) then
            p:SetNWInt("clth_id", 1)
            p:SetNWInt("face_id", 1)
            p:SetNWInt("top_id", 1)
            p:SetNWInt("pants_id", 1)
            p:SetNWInt("boots_id", 1)
            p:SetNWInt("shirt_id", 1)
            p:SetNWInt("hat_id", 1)
            p:SetNWInt("suit_id", 1)
            resetSubs(p)
            return
        end
        if isSuit(p) then
            local suit = p:GetNWInt("suit_id", 1)
            local face = p:GetNWInt("face_id", 1)
            applySuit(p, suit, face)
        elseif isNYPD(p) then
            local shirt = p:GetNWInt("shirt_id", 1)
            local hat = p:GetNWInt("hat_id", 1)
            local face = p:GetNWInt("face_id", 1)
            applyNYPD(p, shirt, hat, face)
        elseif isNormal(p) then
            local top = p:GetNWInt("top_id", 1)
            local pants = p:GetNWInt("pants_id", 1)
            local boots = p:GetNWInt("boots_id", 1)
            local face = p:GetNWInt("face_id", 1)
            applyNormal(p, top, pants, boots, face)
        else
            local cid = p:GetNWInt("clth_id", 1)
            local fid = p:GetNWInt("face_id", 1)
            applyLegacy(p, cid, fid)
        end
    end

    net.Receive("clth_set", function(len, p)
        if not IsValid(p) then return end
        if not chkMdl(p) and not isNormal(p) and not isNYPD(p) and not isSuit(p) then
            p:SetNWInt("clth_id", 1)
            p:SetNWInt("face_id", 1)
            p:SetNWInt("top_id", 1)
            p:SetNWInt("pants_id", 1)
            p:SetNWInt("boots_id", 1)
            p:SetNWInt("shirt_id", 1)
            p:SetNWInt("hat_id", 1)
            p:SetNWInt("suit_id", 1)
            resetSubs(p)
            p:ChatPrint("Лее брат твоя моделька не поддерживает эту кастомизацию (Обычные модельки используй)")
            return
        end
        local cid = net.ReadInt(16)
        local fid = net.ReadInt(16)
        if cid < 1 then cid = 1 end
        local faceCfg = getFaceCfg(p)
        local maxFace = faceCfg and faceCfg.max or 1
        if fid < 1 or fid > maxFace then fid = 1 end
        p:SetNWInt("clth_id", cid)
        p:SetNWInt("face_id", fid)
        applyLegacy(p, cid, fid)
    end)

    net.Receive("clth_set_full", function(len, p)
        if not IsValid(p) then return end
        if not isNormal(p) then
            p:ChatPrint("Эта кастомизация только для нормальных моделей а ты лох ну для тех катори нуар ты знаеш типа да")
            return
        end
        local top = net.ReadInt(16)
        local pants = net.ReadInt(16)
        local boots = net.ReadInt(16)
        local face = net.ReadInt(16)
        local isJacket = getTorsoGroup(p) == 2
        local maxTop = isJacket and 9 or 169
        if top < 1 or top > maxTop then top = 1 end
        if pants < 1 or pants > 200 then pants = 1 end
        if boots < 1 or boots > 90 then boots = 1 end
        local faceCfg = getFaceCfg(p)
        local maxFace = faceCfg and faceCfg.max or 1
        if face < 1 or face > maxFace then face = 1 end
        p:SetNWInt("top_id", top)
        p:SetNWInt("pants_id", pants)
        p:SetNWInt("boots_id", boots)
        p:SetNWInt("face_id", face)
        applyNormal(p, top, pants, boots, face)
    end)

    net.Receive("clth_set_nypd", function(len, p)
        if not IsValid(p) then return end
        if not isNYPD(p) then
            p:ChatPrint("nypd маделька толька")
            return
        end
        local shirt = net.ReadInt(8)
        local hat = net.ReadInt(8)
        local face = net.ReadInt(16)
        if shirt < 1 or shirt > 2 then shirt = 1 end
        if hat < 1 or hat > 3 then hat = 1 end
        local faceCfg = getFaceCfg(p)
        local maxFace = faceCfg and faceCfg.max or 1
        if face < 1 or face > maxFace then face = 1 end
        p:SetNWInt("shirt_id", shirt)
        p:SetNWInt("hat_id", hat)
        p:SetNWInt("face_id", face)
        applyNYPD(p, shirt, hat, face)
    end)

    net.Receive("clth_set_suit", function(len, p)
        if not IsValid(p) then return end
        if not isSuit(p) then
            p:ChatPrint("только для крутыхкостюм моделей")
            return
        end
        local suit = net.ReadInt(16)
        local face = net.ReadInt(16)
        if suit < 1 or suit > 23 then suit = 1 end
        local faceCfg = getFaceCfg(p)
        local maxFace = faceCfg and faceCfg.max or 1
        if face < 1 or face > maxFace then face = 1 end
        p:SetNWInt("suit_id", suit)
        p:SetNWInt("face_id", face)
        applySuit(p, suit, face)
    end)

    hook.Add("PlayerSpawn", "clth_spw", function(p)
        timer.Simple(0.2, function() checkAndApply(p) end)
    end)

    hook.Add("Think", "clth_srv_mon", function()
        for _, p in ipairs(player.GetAll()) do
            if IsValid(p) then
                if p.LST_M ~= p:GetModel() then
                    p.LST_M = p:GetModel()
                    checkAndApply(p)
                end
                local r = p:GetNWEntity("Ragdoll")
                if IsValid(r) and r:GetClass() == "prop_ragdoll" and not r.ClthInit then
                    r.ClthInit = true
                    if isSuit(p) then
                        local suit = p:GetNWInt("suit_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_suit_id", suit)
                        r:SetNWInt("rag_face_id", face)
                        applySuit(r, suit, face)
                    elseif isNYPD(p) then
                        local shirt = p:GetNWInt("shirt_id", 1)
                        local hat = p:GetNWInt("hat_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_shirt_id", shirt)
                        r:SetNWInt("rag_hat_id", hat)
                        r:SetNWInt("rag_face_id", face)
                        applyNYPD(r, shirt, hat, face)
                    elseif isNormal(p) then
                        local top = p:GetNWInt("top_id", 1)
                        local pants = p:GetNWInt("pants_id", 1)
                        local boots = p:GetNWInt("boots_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_top_id", top)
                        r:SetNWInt("rag_pants_id", pants)
                        r:SetNWInt("rag_boots_id", boots)
                        r:SetNWInt("rag_face_id", face)
                        applyNormal(r, top, pants, boots, face)
                    else
                        local cid = p:GetNWInt("clth_id", 1)
                        local fid = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_clth_id", cid)
                        r:SetNWInt("rag_face_id", fid)
                        applyLegacy(r, cid, fid)
                    end
                end
            end
        end
    end)

    local em = FindMetaTable("Entity")
    if em and not em.OldSetModel then
        em.OldSetModel = em.SetModel
        function em:SetModel(m)
            self:OldSetModel(m)
            if self:IsPlayer() then
                timer.Simple(0.1, function() checkAndApply(self) end)
            end
        end
    end

    hook.Add("PlayerDeath", "clth_dth", function(p)
        if not chkMdl(p) and not isNormal(p) and not isNYPD(p) and not isSuit(p) then return end
        timer.Simple(0.05, function()
            if IsValid(p) then
                local r = p:GetRagdollEntity()
                if IsValid(r) then
                    if isSuit(p) then
                        local suit = p:GetNWInt("suit_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_suit_id", suit)
                        r:SetNWInt("rag_face_id", face)
                        applySuit(r, suit, face)
                    elseif isNYPD(p) then
                        local shirt = p:GetNWInt("shirt_id", 1)
                        local hat = p:GetNWInt("hat_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_shirt_id", shirt)
                        r:SetNWInt("rag_hat_id", hat)
                        r:SetNWInt("rag_face_id", face)
                        applyNYPD(r, shirt, hat, face)
                    elseif isNormal(p) then
                        local top = p:GetNWInt("top_id", 1)
                        local pants = p:GetNWInt("pants_id", 1)
                        local boots = p:GetNWInt("boots_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_top_id", top)
                        r:SetNWInt("rag_pants_id", pants)
                        r:SetNWInt("rag_boots_id", boots)
                        r:SetNWInt("rag_face_id", face)
                        applyNormal(r, top, pants, boots, face)
                    else
                        local cid = p:GetNWInt("clth_id", 1)
                        local fid = p:GetNWInt("face_id", 1)
                        r:SetNWInt("rag_clth_id", cid)
                        r:SetNWInt("rag_face_id", fid)
                        applyLegacy(r, cid, fid)
                    end
                end
            end
        end)
    end)
end

if CLIENT then
    surface.CreateFont("ClthTitle", { font = "Roboto", size = 20, weight = 800, extended = true })
    surface.CreateFont("ClthText", { font = "Roboto", size = 15, weight = 700, extended = true })

    local menu = nil

    local function syncArms(p, id)
        if not IsValid(p) then return end
        p.m_tNAHForcedSMats = {}
        if id <= 1 or not chkMdl(p) then return end
        local mats = p:GetMaterials()
        if not mats then return end
        for k, v in ipairs(mats) do
            local n = v:lower()
            local isCloth = n:find("sheet") or n:find("cloth") or n:find("suit") or n:find("body") or n:find("rebel") or n:find("refugee")
            local isExcl = n:find("facemap") or n:find("face") or n:find("head") or n:find("cylmap") or n:find("eye") or n:find("pupil") or n:find("mouth") or n:find("teeth") or n:find("hair") or n:find("skin") or n:find("hand")
            p.m_tNAHForcedSMats[k] = (isCloth and not isExcl) and ("gbskins/male/sheet_" .. id) or ""
        end
    end

    local function applyToEntity(e, params)
        if not IsValid(e) then return end
        if isSuit(e) then
            applySuit(e, params.suit or 1, params.face or 1)
        elseif isNYPD(e) then
            applyNYPD(e, params.shirt or 1, params.hat or 1, params.face or 1)
        elseif isNormal(e) then
            applyNormal(e, params.top or 1, params.pants or 1, params.boots or 1, params.face or 1)
        elseif chkMdl(e) then
            applyLegacy(e, params.clth or 1, params.face or 1)
        else
            resetSubs(e)
        end
    end

    function upd_hnd(ply)
        if not IsValid(ply) or ply ~= LocalPlayer() then return end
        local h = ply:GetHands()
        if not IsValid(h) then return end
        if not isNormal(ply) then return end
        local top = ply:GetNWInt("top_id", 1)
        local tex = getTopTex(ply, top)
        local mats = h:GetMaterials()
        if not mats then return end
        for k, v in ipairs(mats) do
            local n = v:lower()
            local isTop = (n:find("top") or n:find("shirt") or n:find("body") or n:find("suit") or n:find("vest") or n:find("jacket"))
                and not (n:find("face") or n:find("head") or n:find("pants") or n:find("legs") or n:find("boots") or n:find("feet"))
            if isTop then
                h:SetSubMaterial(k-1, tex)
            end
        end
    end

    local function apply_sleeves_to_vm(vm, ply, topid)
        if not IsValid(vm) then return end
        local mats = vm:GetMaterials()
        if not mats then return end
        local tex = getTopTex(ply, topid)
        if not tex then
            for i = 1, #mats do vm:SetSubMaterial(i-1, nil) end
            return
        end
        for k, v in ipairs(mats) do
            local n = v:lower()
            local isTop = (n:find("top") or n:find("shirt") or n:find("body") or n:find("suit") or n:find("vest") or n:find("jacket"))
                and not (n:find("face") or n:find("head") or n:find("pants") or n:find("legs") or n:find("boots") or n:find("feet"))
            if isTop then
                vm:SetSubMaterial(k-1, tex)
            end
        end
    end

    hook.Add("PreDrawViewModel", "clth_mw_sleeves", function(vm, ply, weapon)
        if not IsValid(ply) or ply ~= LocalPlayer() then return end
        if not isNormal(ply) then return end
        if not IsValid(weapon) or not weapons.IsBasedOn(weapon:GetClass(), "mg_base") then return end
        local top = ply:GetNWInt("top_id", 1)
        apply_sleeves_to_vm(vm, ply, top)
    end)

    hook.Add("CreateClientsideRagdoll", "clth_rag_cl", function(p, r)
        if IsValid(p) and IsValid(r) then
            if isSuit(p) then
                local suit = p:GetNWInt("suit_id", 1)
                local face = p:GetNWInt("face_id", 1)
                r:SetNWInt("rag_suit_id", suit)
                r:SetNWInt("rag_face_id", face)
                timer.Simple(0, function() if IsValid(r) then applySuit(r, suit, face) end end)
            elseif isNYPD(p) then
                local shirt = p:GetNWInt("shirt_id", 1)
                local hat = p:GetNWInt("hat_id", 1)
                local face = p:GetNWInt("face_id", 1)
                r:SetNWInt("rag_shirt_id", shirt)
                r:SetNWInt("rag_hat_id", hat)
                r:SetNWInt("rag_face_id", face)
                timer.Simple(0, function() if IsValid(r) then applyNYPD(r, shirt, hat, face) end end)
            elseif isNormal(p) then
                local top = p:GetNWInt("top_id", 1)
                local pants = p:GetNWInt("pants_id", 1)
                local boots = p:GetNWInt("boots_id", 1)
                local face = p:GetNWInt("face_id", 1)
                r:SetNWInt("rag_top_id", top)
                r:SetNWInt("rag_pants_id", pants)
                r:SetNWInt("rag_boots_id", boots)
                r:SetNWInt("rag_face_id", face)
                timer.Simple(0, function() if IsValid(r) then applyNormal(r, top, pants, boots, face) end end)
            elseif chkMdl(p) then
                local cid = p:GetNWInt("clth_id", 1)
                local fid = p:GetNWInt("face_id", 1)
                r:SetNWInt("rag_clth_id", cid)
                r:SetNWInt("rag_face_id", fid)
                timer.Simple(0, function() if IsValid(r) then applyLegacy(r, cid, fid) end end)
            end
        end
    end)

    hook.Add("Think", "clth_cl_mon", function()
        for _, p in ipairs(player.GetAll()) do
            if IsValid(p) then
                if p.LST_MC ~= p:GetModel() then
                    p.LST_MC = p:GetModel()
                    if not chkMdl(p) and not isNormal(p) and not isNYPD(p) and not isSuit(p) then
                        resetSubs(p)
                        if p == LocalPlayer() then
                            syncArms(p, 1)
                            if IsValid(menu) then
                                menu:Close()
                                chat.AddText(Color(255,50,50), "Лее брат твоя моделька не поддерживает эту кастомизацию (Обычные модельки используй)")
                            end
                        end
                    elseif isSuit(p) then
                        local suit = p:GetNWInt("suit_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        applySuit(p, suit, face)
                    elseif isNYPD(p) then
                        local shirt = p:GetNWInt("shirt_id", 1)
                        local hat = p:GetNWInt("hat_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        applyNYPD(p, shirt, hat, face)
                    elseif isNormal(p) then
                        local top = p:GetNWInt("top_id", 1)
                        local pants = p:GetNWInt("pants_id", 1)
                        local boots = p:GetNWInt("boots_id", 1)
                        local face = p:GetNWInt("face_id", 1)
                        applyNormal(p, top, pants, boots, face)
                        if p == LocalPlayer() then
                            upd_hnd(p)
                        end
                    else
                        local cid = p:GetNWInt("clth_id", 1)
                        local fid = p:GetNWInt("face_id", 1)
                        applyLegacy(p, cid, fid)
                        if p == LocalPlayer() then syncArms(p, cid) end
                    end
                end
                local r = p:GetNWEntity("Ragdoll")
                if IsValid(r) then
                    if isSuit(p) then
                        local rs = r:GetNWInt("rag_suit_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        if rs > 0 or rf > 0 then
                            if r.LST_S != rs or r.LST_F != rf then
                                r.LST_S, r.LST_F = rs, rf
                                applySuit(r, rs, rf)
                            end
                        elseif not r.LST_S then
                            local ps = p:GetNWInt("suit_id", 1)
                            local pf = p:GetNWInt("face_id", 1)
                            r.LST_S, r.LST_F = ps, pf
                            timer.Simple(0, function() if IsValid(r) then applySuit(r, ps, pf) end end)
                        end
                    elseif isNYPD(p) then
                        local rs = r:GetNWInt("rag_shirt_id", 0)
                        local rh = r:GetNWInt("rag_hat_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        if rs > 0 or rh > 0 or rf > 0 then
                            if r.LST_S != rs or r.LST_H != rh or r.LST_F != rf then
                                r.LST_S, r.LST_H, r.LST_F = rs, rh, rf
                                applyNYPD(r, rs, rh, rf)
                            end
                        elseif not r.LST_S then
                            local ps = p:GetNWInt("shirt_id", 1)
                            local ph = p:GetNWInt("hat_id", 1)
                            local pf = p:GetNWInt("face_id", 1)
                            r.LST_S, r.LST_H, r.LST_F = ps, ph, pf
                            timer.Simple(0, function() if IsValid(r) then applyNYPD(r, ps, ph, pf) end end)
                        end
                    elseif isNormal(p) then
                        local rt = r:GetNWInt("rag_top_id", 0)
                        local rp = r:GetNWInt("rag_pants_id", 0)
                        local rb = r:GetNWInt("rag_boots_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        if rt > 0 or rp > 0 or rb > 0 or rf > 0 then
                            if r.LST_T != rt or r.LST_P != rp or r.LST_B != rb or r.LST_F != rf then
                                r.LST_T, r.LST_P, r.LST_B, r.LST_F = rt, rp, rb, rf
                                applyNormal(r, rt, rp, rb, rf)
                            end
                        elseif not r.LST_T then
                            local pt = p:GetNWInt("top_id", 1)
                            local pp = p:GetNWInt("pants_id", 1)
                            local pb = p:GetNWInt("boots_id", 1)
                            local pf = p:GetNWInt("face_id", 1)
                            r.LST_T, r.LST_P, r.LST_B, r.LST_F = pt, pp, pb, pf
                            timer.Simple(0, function() if IsValid(r) then applyNormal(r, pt, pp, pb, pf) end end)
                        end
                    else
                        local rc = r:GetNWInt("rag_clth_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        if rc > 0 or rf > 0 then
                            if r.LST_C != rc or r.LST_F != rf then
                                r.LST_C, r.LST_F = rc, rf
                                applyLegacy(r, rc, rf)
                            end
                        elseif not r.LST_C then
                            local pc = p:GetNWInt("clth_id", 1)
                            local pf = p:GetNWInt("face_id", 1)
                            r.LST_C, r.LST_F = pc, pf
                            timer.Simple(0, function() if IsValid(r) then applyLegacy(r, pc, pf) end end)
                        end
                    end
                end
            end
        end
    end)

    hook.Add("EntityNetworkedVarChanged", "clth_snc", function(e, n, o, nw)
        if e:IsPlayer() then
            if n == "suit_id" then
                if isSuit(e) then
                    local suit = e:GetNWInt("suit_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applySuit(e, suit, face)
                end
            elseif n == "top_id" or n == "pants_id" or n == "boots_id" or n == "face_id" then
                if isSuit(e) then
                    local suit = e:GetNWInt("suit_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applySuit(e, suit, face)
                elseif not isNormal(e) then
                    if n == "face_id" then
                        local fid = e:GetNWInt("face_id", 1)
                        applyLegacy(e, e:GetNWInt("clth_id", 1), fid)
                    end
                    return
                else
                    local top = e:GetNWInt("top_id", 1)
                    local pants = e:GetNWInt("pants_id", 1)
                    local boots = e:GetNWInt("boots_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applyNormal(e, top, pants, boots, face)
                    if e == LocalPlayer() then
                        upd_hnd(e)
                    end
                end
            elseif n == "clth_id" then
                if isSuit(e) or isNormal(e) or isNYPD(e) then return end
                local cid = e:GetNWInt("clth_id", 1)
                local fid = e:GetNWInt("face_id", 1)
                applyLegacy(e, cid, fid)
                if e == LocalPlayer() then syncArms(e, cid) end
            elseif n == "face_id" then
                if isSuit(e) then
                    local suit = e:GetNWInt("suit_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applySuit(e, suit, face)
                elseif isNormal(e) then
                    local top = e:GetNWInt("top_id", 1)
                    local pants = e:GetNWInt("pants_id", 1)
                    local boots = e:GetNWInt("boots_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applyNormal(e, top, pants, boots, face)
                    if e == LocalPlayer() then
                        upd_hnd(e)
                    end
                elseif isNYPD(e) then
                    local shirt = e:GetNWInt("shirt_id", 1)
                    local hat = e:GetNWInt("hat_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applyNYPD(e, shirt, hat, face)
                else
                    local cid = e:GetNWInt("clth_id", 1)
                    local fid = e:GetNWInt("face_id", 1)
                    applyLegacy(e, cid, fid)
                end
            elseif n == "shirt_id" or n == "hat_id" then
                if isNYPD(e) then
                    local shirt = e:GetNWInt("shirt_id", 1)
                    local hat = e:GetNWInt("hat_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applyNYPD(e, shirt, hat, face)
                end
            end
        end
    end)

    hook.Add("NotifyShouldTransmit", "clth_pvs", function(e, t)
        if t and IsValid(e) then
            if e:IsPlayer() then
                if not chkMdl(e) and not isNormal(e) and not isNYPD(e) and not isSuit(e) then return end
                if isSuit(e) then
                    local suit = e:GetNWInt("suit_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applySuit(e, suit, face)
                    local r = e:GetNWEntity("Ragdoll")
                    if IsValid(r) then
                        local rs = r:GetNWInt("rag_suit_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        applySuit(r, rs > 0 and rs or suit, rf > 0 and rf or face)
                    end
                elseif isNYPD(e) then
                    local shirt = e:GetNWInt("shirt_id", 1)
                    local hat = e:GetNWInt("hat_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applyNYPD(e, shirt, hat, face)
                    local r = e:GetNWEntity("Ragdoll")
                    if IsValid(r) then
                        local rs = r:GetNWInt("rag_shirt_id", 0)
                        local rh = r:GetNWInt("rag_hat_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        applyNYPD(r, rs > 0 and rs or shirt, rh > 0 and rh or hat, rf > 0 and rf or face)
                    end
                elseif isNormal(e) then
                    local top = e:GetNWInt("top_id", 1)
                    local pants = e:GetNWInt("pants_id", 1)
                    local boots = e:GetNWInt("boots_id", 1)
                    local face = e:GetNWInt("face_id", 1)
                    applyNormal(e, top, pants, boots, face)
                    local r = e:GetNWEntity("Ragdoll")
                    if IsValid(r) then
                        local rt = r:GetNWInt("rag_top_id", 0)
                        local rp = r:GetNWInt("rag_pants_id", 0)
                        local rb = r:GetNWInt("rag_boots_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        applyNormal(r, rt > 0 and rt or top, rp > 0 and rp or pants, rb > 0 and rb or boots, rf > 0 and rf or face)
                    end
                else
                    local cid = e:GetNWInt("clth_id", 1)
                    local fid = e:GetNWInt("face_id", 1)
                    applyLegacy(e, cid, fid)
                    if e == LocalPlayer() then syncArms(e, cid) end
                    local r = e:GetNWEntity("Ragdoll")
                    if IsValid(r) then
                        local rc = r:GetNWInt("rag_clth_id", 0)
                        local rf = r:GetNWInt("rag_face_id", 0)
                        applyLegacy(r, rc > 0 and rc or cid, rf > 0 and rf or fid)
                    end
                end
            elseif e:GetClass() == "prop_ragdoll" then
                if isSuit(e) then
                    applySuit(e, e:GetNWInt("rag_suit_id", 0), e:GetNWInt("rag_face_id", 0))
                elseif isNYPD(e) then
                    applyNYPD(e, e:GetNWInt("rag_shirt_id", 0), e:GetNWInt("rag_hat_id", 0), e:GetNWInt("rag_face_id", 0))
                elseif isNormal(e) then
                    applyNormal(e, e:GetNWInt("rag_top_id", 0), e:GetNWInt("rag_pants_id", 0), e:GetNWInt("rag_boots_id", 0), e:GetNWInt("rag_face_id", 0))
                else
                    applyLegacy(e, e:GetNWInt("rag_clth_id", 0), e:GetNWInt("rag_face_id", 0))
                end
            end
        end
    end)

    hook.Add("PreDrawPlayerHands", "clth_hnd", function(h, vm, p)
        if not IsValid(p) then return end
        if isSuit(p) then
            local suit = p:GetNWInt("suit_id", 1)
            if suit > 1 then
                local m = p:GetModel():lower()
                local gender = m:find("female") and "female" or "male"
                local tex = "models/gmodbest/suit/" .. gender .. "/suit_sheet" .. suit
                local mats = h:GetMaterials()
                if mats then
                    for k, v in ipairs(mats) do
                        local n = v:lower()
                        local isCloth = n:find("sheet") or n:find("cloth") or n:find("suit") or n:find("body") or n:find("rebel") or n:find("refugee") or n:find("medic")
                        local isFace = (n:find("facemap") or n:find("face") or n:find("head") or n:find("cylmap")) and not (n:find("eye") or n:find("pupil") or n:find("mouth") or n:find("teeth") or n:find("hair") or n:find("skin") or n:find("hand"))
                        if isCloth and not isFace then
                            h:SetSubMaterial(k-1, tex)
                        end
                    end
                end
            else
                local mats = h:GetMaterials()
                if mats then
                    for i = 1, #mats do h:SetSubMaterial(i-1, nil) end
                end
            end
        elseif chkMdl(p) and not isNormal(p) and not isNYPD(p) then
            local id = p:GetNWInt("clth_id", 1)
            if id > 1 then applyLegacy(h, id, 1) end
        elseif isNormal(p) then
            local top = p:GetNWInt("top_id", 1)
            local tex = getTopTex(p, top)
            local mats = h:GetMaterials()
            if mats then
                if tex then
                    for k, v in ipairs(mats) do
                        local n = v:lower()
                        local isTop = (n:find("top") or n:find("shirt") or n:find("body") or n:find("suit") or n:find("vest") or n:find("jacket"))
                            and not (n:find("face") or n:find("head") or n:find("pants") or n:find("legs") or n:find("boots") or n:find("feet"))
                        if isTop then
                            h:SetSubMaterial(k-1, tex)
                        end
                    end
                else
                    for i = 1, #mats do h:SetSubMaterial(i-1, nil) end
                end
            end
        end
    end)

    local function createSuitMenu(p)
        if IsValid(menu) then menu:Close() end
        local curSuit = p:GetNWInt("suit_id", 1)
        local curFace = p:GetNWInt("face_id", 1)
        local faceCfg = getFaceCfg(p)

        menu = vgui.Create("DFrame")
        local f = menu
        f:SetSize(850, 620)
        f:Center()
        f:SetTitle("")
        f:MakePopup()
        f:ShowCloseButton(false)

        f.Paint = function(s,w,h)
            draw.RoundedBox(12,0,0,w,h,Color(24,24,28,255))
            draw.RoundedBoxEx(12,0,0,w,50,Color(145,25,25),true,true,false,false)
            draw.SimpleText("Костюмы", "ClthTitle", 20, 25, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local close = vgui.Create("DButton", f)
        close:SetSize(35,35)
        close:SetPos(850-45,7)
        close:SetText("✕")
        close:SetFont("ClthTitle")
        close.Paint = function(s,w,h) s:SetTextColor(s:IsHovered() and Color(255,100,100) or Color(240,240,240)) end
        close.DoClick = function() f:Close() end

        local pvl = vgui.Create("DPanel", f)
        pvl:SetSize(360,490)
        pvl:SetPos(15,60)
        pvl.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255)) surface.SetDrawColor(45,45,50) surface.DrawOutlinedRect(0,0,w,h,1) end

        local mp = vgui.Create("DModelPanel", pvl)
        mp:Dock(FILL)
        mp:SetModel(p:GetModel())
        mp:SetFOV(28)
        mp:SetCamPos(Vector(5, 0, 0))
        mp:SetLookAt(Vector(-100, 0, -22))
        mp:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
        mp:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
        mp:SetAmbientLight(Vector(-64, -64, -64))
        mp:SetAnimated(true)

        local ent = mp:GetEntity()
        local rotY = 0
        local lastX = 0
        if IsValid(ent) then
            for _, bg in ipairs(p:GetBodyGroups()) do
                ent:SetBodygroup(bg.id, p:GetBodygroup(bg.id))
            end
            ent:SetPos(Vector(-100, 0, -61))
            ent:ResetSequence("menu_combine")
            applySuit(ent, curSuit, curFace)
            function mp:LayoutEntity(e)
                if self.Hovered and input.IsMouseDown(MOUSE_LEFT) then
                    if not self.B_Pressed then
                        self.B_Pressed = true
                        lastX = gui.MouseX()
                    else
                        local curX = gui.MouseX()
                        rotY = rotY + (curX - lastX) * 0.75
                        lastX = curX
                    end
                else
                    self.B_Pressed = false
                end
                e:SetAngles(Angle(0, rotY, 0))
            end
        end

        local function sendUpdate()
            net.Start("clth_set_suit")
            net.WriteInt(curSuit, 16)
            net.WriteInt(curFace, 16)
            net.SendToServer()
        end

        local quickBar = vgui.Create("DPanel", f)
        quickBar:SetSize(360,45)
        quickBar:SetPos(15,565)
        quickBar.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255)) surface.SetDrawColor(45,45,50) surface.DrawOutlinedRect(0,0,w,h,1) end

        local suitLabel = vgui.Create("DLabel", quickBar)
        suitLabel:SetSize(200,35)
        suitLabel:SetPos(80,5)
        suitLabel:SetText("Костюм: #"..curSuit)
        suitLabel:SetFont("ClthTitle")
        suitLabel:SetTextColor(Color(235,235,235))
        suitLabel:SetContentAlignment(5)

        local tabSuit = vgui.Create("DButton", f)
        tabSuit:SetSize(215,40)
        tabSuit:SetPos(390,60)
        tabSuit:SetText("КОСТЮМ")
        tabSuit:SetFont("ClthTitle")
        local tabFace = vgui.Create("DButton", f)
        tabFace:SetSize(215,40)
        tabFace:SetPos(620,60)
        tabFace:SetText("ЛИЦА")
        tabFace:SetFont("ClthTitle")
        if not faceCfg then tabFace:SetEnabled(false) tabFace:SetAlpha(50) end

        local searchSuit = vgui.Create("DTextEntry", f)
        searchSuit:SetSize(445,35)
        searchSuit:SetPos(390,110)
        searchSuit:SetPlaceholderText("Поиск")
        searchSuit:SetFont("ClthText")
        searchSuit:SetTextColor(Color(255,255,255))
        searchSuit.Paint = function(s,w,h)
            draw.RoundedBox(6,0,0,w,h,Color(16,16,18,255))
            surface.SetDrawColor(45,45,50)
            surface.DrawOutlinedRect(0,0,w,h,1)
            s:DrawTextEntryText(s:GetTextColor(), s:GetHighlightColor(), s:GetCursorColor())
        end

        local scrlSuit = vgui.Create("DScrollPanel", f)
        scrlSuit:SetSize(445,400)
        scrlSuit:SetPos(390,155)
        local scrlFace = vgui.Create("DScrollPanel", f)
        scrlFace:SetSize(445,445)
        scrlFace:SetPos(390,110)
        scrlFace:SetVisible(false)

        local function styleScroll(sbar)
            sbar:SetWide(6)
            sbar.Paint = nil
            sbar.btnUp.Paint = nil
            sbar.btnDown.Paint = nil
            sbar.btnGrip.Paint = function(s,w,h) draw.RoundedBox(3,0,0,w,h,Color(65,65,70)) end
        end
        styleScroll(scrlSuit:GetVBar())
        styleScroll(scrlFace:GetVBar())

        local gridSuit = vgui.Create("DIconLayout", scrlSuit)
        gridSuit:Dock(FILL)
        gridSuit:SetSpaceX(8)
        gridSuit:SetSpaceY(8)
        local gridFace = vgui.Create("DIconLayout", scrlFace)
        gridFace:Dock(FILL)
        gridFace:SetSpaceX(8)
        gridFace:SetSpaceY(8)

        local activeTab = "suit"
        local function updateTabs()
            tabSuit.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="suit" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
            tabFace.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="face" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
        end
        updateTabs()

        tabSuit.DoClick = function() activeTab="suit" scrlSuit:SetVisible(true) scrlFace:SetVisible(false) searchSuit:SetVisible(true) updateTabs() end
        tabFace.DoClick = function() if not faceCfg then return end activeTab="face" scrlSuit:SetVisible(false) scrlFace:SetVisible(true) searchSuit:SetVisible(false) updateTabs() end

        local function updateSelection(newSuit, newFace)
            if newSuit then curSuit = math.Clamp(newSuit, 1, 23) suitLabel:SetText("Костюм: #"..curSuit) end
            if newFace and faceCfg then curFace = math.Clamp(newFace, 1, faceCfg.max) end
            if IsValid(ent) then applySuit(ent, curSuit, curFace) end
            sendUpdate()
        end

        searchSuit.OnTextChanged = function(s)
            local txt = s:GetText()
            local val = tonumber(txt)
            if val and val >= 1 and val <= 23 then updateSelection(val, nil) end
            for i=1,23 do
                if suitTiles[i] then
                    suitTiles[i]:SetVisible(txt=="" or tostring(i):find(txt,1,true))
                end
            end
            gridSuit:Layout()
        end

        mp.OnMouseWheeled = function(s, delta)
            local nextID = curSuit + (delta > 0 and 1 or -1)
            if nextID > 23 then nextID = 1 elseif nextID < 1 then nextID = 23 end
            updateSelection(nextID, nil)
        end

        f.OnKeyCodePressed = function(s, key)
            if key == KEY_LEFT then
                local nextID = curSuit - 1
                if nextID < 1 then nextID = 23 end
                updateSelection(nextID, nil)
            elseif key == KEY_RIGHT then
                local nextID = curSuit + 1
                if nextID > 23 then nextID = 1 end
                updateSelection(nextID, nil)
            end
        end

        local btnPrev = vgui.Create("DButton", quickBar)
        btnPrev:SetSize(45,35)
        btnPrev:SetPos(5,5)
        btnPrev:SetText("◀")
        btnPrev:SetFont("ClthTitle")
        btnPrev:SetTextColor(Color(255,255,255))
        btnPrev.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,s:IsHovered() and Color(145,25,25) or Color(34,34,40)) end
        btnPrev.DoClick = function()
            local nextID = curSuit - 1
            if nextID < 1 then nextID = 23 end
            updateSelection(nextID, nil)
        end

        local btnNext = vgui.Create("DButton", quickBar)
        btnNext:SetSize(45,35)
        btnNext:SetPos(360-50,5)
        btnNext:SetText("▶")
        btnNext:SetFont("ClthTitle")
        btnNext:SetTextColor(Color(255,255,255))
        btnNext.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,s:IsHovered() and Color(145,25,25) or Color(34,34,40)) end
        btnNext.DoClick = function()
            local nextID = curSuit + 1
            if nextID > 23 then nextID = 1 end
            updateSelection(nextID, nil)
        end

        local suitTiles = {}
        for i=1,23 do
            local tile = gridSuit:Add("DButton")
            tile:SetSize(77,75)
            tile:SetText("")
            suitTiles[i] = tile
            tile.Paint = function(s,w,h)
                local sel = (curSuit == i)
                draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                draw.SimpleText(i, "ClthTitle", w/2, h/2, Color(245,245,245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if sel then surface.SetDrawColor(255,255,255,120) surface.DrawOutlinedRect(0,0,w,h,2) end
            end
            tile.DoClick = function() updateSelection(i, nil) end
        end

        if faceCfg then
            for i=1, faceCfg.max do
                local tile = gridFace:Add("DButton")
                tile:SetSize(77,75)
                tile:SetText("")
                local subMP = vgui.Create("DModelPanel", tile)
                subMP:Dock(FILL)
                subMP:SetModel(p:GetModel())
                subMP:SetCamPos(Vector(45,0,63))
                subMP:SetLookAt(Vector(0,0,63))
                subMP:SetFOV(28)
                subMP:SetMouseInputEnabled(false)
                function subMP:LayoutEntity(e) e:SetAngles(Angle(0,0,0)) end
                local subE = subMP:GetEntity()
                if IsValid(subE) then applySuit(subE, 1, i) end
                tile.Paint = function(s,w,h)
                    local sel = (curFace == i)
                    draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                    if sel then surface.SetDrawColor(255,255,255,180) surface.DrawOutlinedRect(0,0,w,h,2) end
                end
                tile.DoClick = function() updateSelection(nil, i) end
            end
        end

        local btnRand = vgui.Create("DButton", f)
        btnRand:SetSize(445,45)
        btnRand:SetPos(390,565)
        btnRand:SetText("Random")
        btnRand:SetFont("ClthTitle")
        btnRand:SetTextColor(Color(255,255,255))
        btnRand.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,s:IsHovered() and Color(185,35,35) or Color(145,25,25)) end
        btnRand.DoClick = function()
            local rs = math.random(1,23)
            local rf = faceCfg and math.random(1, faceCfg.max) or 1
            updateSelection(rs, rf)
        end
    end

    local function createNYPDMenu(p)
        if IsValid(menu) then menu:Close() end
        local curShirt = p:GetNWInt("shirt_id", 1)
        local curHat = p:GetNWInt("hat_id", 1)
        local curFace = p:GetNWInt("face_id", 1)
        local faceCfg = getFaceCfg(p)

        menu = vgui.Create("DFrame")
        local f = menu
        f:SetSize(850, 620)
        f:Center()
        f:SetTitle("")
        f:MakePopup()
        f:ShowCloseButton(false)

        f.Paint = function(s,w,h)
            draw.RoundedBox(12,0,0,w,h,Color(24,24,28,255))
            draw.RoundedBoxEx(12,0,0,w,50,Color(145,25,25),true,true,false,false)
            draw.SimpleText("Нупд скинчики", "ClthTitle", 20, 25, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local close = vgui.Create("DButton", f)
        close:SetSize(35,35)
        close:SetPos(850-45,7)
        close:SetText("✕")
        close:SetFont("ClthTitle")
        close.Paint = function(s,w,h) s:SetTextColor(s:IsHovered() and Color(255,100,100) or Color(240,240,240)) end
        close.DoClick = function() f:Close() end

        local pvl = vgui.Create("DPanel", f)
        pvl:SetSize(360,490)
        pvl:SetPos(15,60)
        pvl.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255)) surface.SetDrawColor(45,45,50) surface.DrawOutlinedRect(0,0,w,h,1) end

        local mp = vgui.Create("DModelPanel", pvl)
        mp:Dock(FILL)
        mp:SetModel(p:GetModel())
        mp:SetFOV(28)
        mp:SetCamPos(Vector(5, 0, 0))
        mp:SetLookAt(Vector(-100, 0, -22))
        mp:SetDirectionalLight(BOX_RIGHT, Color(255, 160, 80, 255))
        mp:SetDirectionalLight(BOX_LEFT, Color(80, 160, 255, 255))
        mp:SetAmbientLight(Vector(-64, -64, -64))
        mp:SetAnimated(true)

        local ent = mp:GetEntity()
        local rotY = 0
        local lastX = 0
        if IsValid(ent) then
            for _, bg in ipairs(p:GetBodyGroups()) do
                ent:SetBodygroup(bg.id, p:GetBodygroup(bg.id))
            end
            ent:SetPos(Vector(-100, 0, -61))
            ent:ResetSequence("menu_combine")
            applyNYPD(ent, curShirt, curHat, curFace)
            function mp:LayoutEntity(e)
                if self.Hovered and input.IsMouseDown(MOUSE_LEFT) then
                    if not self.B_Pressed then
                        self.B_Pressed = true
                        lastX = gui.MouseX()
                    else
                        local curX = gui.MouseX()
                        rotY = rotY + (curX - lastX) * 0.75
                        lastX = curX
                    end
                else
                    self.B_Pressed = false
                end
                e:SetAngles(Angle(0, rotY, 0))
            end
        end

        local function sendUpdate()
            net.Start("clth_set_nypd")
            net.WriteInt(curShirt, 8)
            net.WriteInt(curHat, 8)
            net.WriteInt(curFace, 16)
            net.SendToServer()
        end

        local quickBar = vgui.Create("DPanel", f)
        quickBar:SetSize(360,45)
        quickBar:SetPos(15,565)
        quickBar.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255)) surface.SetDrawColor(45,45,50) surface.DrawOutlinedRect(0,0,w,h,1) end

        local shirtLabel = vgui.Create("DLabel", quickBar)
        shirtLabel:SetSize(120,35)
        shirtLabel:SetPos(5,5)
        shirtLabel:SetText("Рубашка: #"..curShirt)
        shirtLabel:SetFont("ClthTitle")
        shirtLabel:SetTextColor(Color(235,235,235))
        shirtLabel:SetContentAlignment(5)

        local hatLabel = vgui.Create("DLabel", quickBar)
        hatLabel:SetSize(120,35)
        hatLabel:SetPos(130,5)
        hatLabel:SetText("Фуражкаблять: #"..curHat)
        hatLabel:SetFont("ClthTitle")
        hatLabel:SetTextColor(Color(235,235,235))
        hatLabel:SetContentAlignment(5)

        local tabShirt = vgui.Create("DButton", f)
        tabShirt:SetSize(200,40)
        tabShirt:SetPos(390,60)
        tabShirt:SetText("Рубашка")
        tabShirt:SetFont("ClthTitle")
        local tabHat = vgui.Create("DButton", f)
        tabHat:SetSize(200,40)
        tabHat:SetPos(600,60)
        tabHat:SetText("Фуражкаблять")
        tabHat:SetFont("ClthTitle")
        local tabFace = vgui.Create("DButton", f)
        tabFace:SetSize(200,40)
        tabFace:SetPos(600,110)
        tabFace:SetText("Лица")
        tabFace:SetFont("ClthTitle")
        if not faceCfg then tabFace:SetEnabled(false) tabFace:SetAlpha(50) end

        local scrlShirt = vgui.Create("DScrollPanel", f)
        scrlShirt:SetSize(445,430)
        scrlShirt:SetPos(390,160)
        local scrlHat = vgui.Create("DScrollPanel", f)
        scrlHat:SetSize(445,430)
        scrlHat:SetPos(390,160)
        scrlHat:SetVisible(false)
        local scrlFace = vgui.Create("DScrollPanel", f)
        scrlFace:SetSize(445,430)
        scrlFace:SetPos(390,160)
        scrlFace:SetVisible(false)

        local function styleScroll(sbar)
            sbar:SetWide(6)
            sbar.Paint = nil
            sbar.btnUp.Paint = nil
            sbar.btnDown.Paint = nil
            sbar.btnGrip.Paint = function(s,w,h) draw.RoundedBox(3,0,0,w,h,Color(65,65,70)) end
        end
        styleScroll(scrlShirt:GetVBar())
        styleScroll(scrlHat:GetVBar())
        styleScroll(scrlFace:GetVBar())

        local gridShirt = vgui.Create("DIconLayout", scrlShirt)
        gridShirt:Dock(FILL)
        gridShirt:SetSpaceX(8)
        gridShirt:SetSpaceY(8)
        local gridHat = vgui.Create("DIconLayout", scrlHat)
        gridHat:Dock(FILL)
        gridHat:SetSpaceX(8)
        gridHat:SetSpaceY(8)
        local gridFace = vgui.Create("DIconLayout", scrlFace)
        gridFace:Dock(FILL)
        gridFace:SetSpaceX(8)
        gridFace:SetSpaceY(8)

        local activeTab = "shirt"
        local function updateTabs()
            tabShirt.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="shirt" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
            tabHat.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="hat" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
            tabFace.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="face" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
        end
        updateTabs()

        tabShirt.DoClick = function() activeTab="shirt" scrlShirt:SetVisible(true) scrlHat:SetVisible(false) scrlFace:SetVisible(false) updateTabs() end
        tabHat.DoClick = function() activeTab="hat" scrlShirt:SetVisible(false) scrlHat:SetVisible(true) scrlFace:SetVisible(false) updateTabs() end
        tabFace.DoClick = function() if not faceCfg then return end activeTab="face" scrlShirt:SetVisible(false) scrlHat:SetVisible(false) scrlFace:SetVisible(true) updateTabs() end

        local function updateAll()
            if IsValid(ent) then
                for _, bg in ipairs(p:GetBodyGroups()) do
                    ent:SetBodygroup(bg.id, p:GetBodygroup(bg.id))
                end
                applyNYPD(ent, curShirt, curHat, curFace)
            end
            shirtLabel:SetText("Рубашка: #"..curShirt)
            hatLabel:SetText("Фуражкаблять: #"..curHat)
            sendUpdate()
        end

        local shirtTiles = {}
        for i=1,2 do
            local tile = gridShirt:Add("DButton")
            tile:SetSize(70,70)
            tile:SetText("")
            shirtTiles[i] = tile
            tile.Paint = function(s,w,h)
                local sel = (curShirt == i)
                draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                draw.SimpleText(i, "ClthTitle", w/2, h/2, Color(245,245,245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if sel then surface.SetDrawColor(255,255,255,120) surface.DrawOutlinedRect(0,0,w,h,2) end
            end
            tile.DoClick = function() curShirt = i updateAll() end
        end

        local hatTiles = {}
        for i=1,3 do
            local tile = gridHat:Add("DButton")
            tile:SetSize(70,70)
            tile:SetText("")
            hatTiles[i] = tile
            tile.Paint = function(s,w,h)
                local sel = (curHat == i)
                draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                draw.SimpleText(i, "ClthTitle", w/2, h/2, Color(245,245,245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if sel then surface.SetDrawColor(255,255,255,120) surface.DrawOutlinedRect(0,0,w,h,2) end
            end
            tile.DoClick = function() curHat = i updateAll() end
        end

        if faceCfg then
            for i=1, faceCfg.max do
                local tile = gridFace:Add("DButton")
                tile:SetSize(70,70)
                tile:SetText("")
                local subMP = vgui.Create("DModelPanel", tile)
                subMP:Dock(FILL)
                subMP:SetModel(p:GetModel())
                subMP:SetCamPos(Vector(45,0,63))
                subMP:SetLookAt(Vector(0,0,63))
                subMP:SetFOV(28)
                subMP:SetMouseInputEnabled(false)
                function subMP:LayoutEntity(e) e:SetAngles(Angle(0,0,0)) end
                local subE = subMP:GetEntity()
                if IsValid(subE) then
                    for _, bg in ipairs(p:GetBodyGroups()) do
                        subE:SetBodygroup(bg.id, p:GetBodygroup(bg.id))
                    end
                    applyNYPD(subE, 1, 1, i)
                end
                tile.Paint = function(s,w,h)
                    local sel = (curFace == i)
                    draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                    if sel then surface.SetDrawColor(255,255,255,180) surface.DrawOutlinedRect(0,0,w,h,2) end
                end
                tile.DoClick = function() curFace = i updateAll() end
            end
        end

        local btnRand = vgui.Create("DButton", f)
        btnRand:SetSize(445,45)
        btnRand:SetPos(390,595)
        btnRand:SetText("Random")
        btnRand:SetFont("ClthTitle")
        btnRand:SetTextColor(Color(255,255,255))
        btnRand.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,s:IsHovered() and Color(185,35,35) or Color(145,25,25)) end
        btnRand.DoClick = function()
            curShirt = math.random(1,2)
            curHat = math.random(1,3)
            curFace = faceCfg and math.random(1, faceCfg.max) or 1
            updateAll()
        end

        f.OnKeyCodePressed = function(s, key)
            if key == KEY_LEFT then
                if activeTab == "shirt" then curShirt = (curShirt - 1 < 1) and 2 or curShirt - 1
                elseif activeTab == "hat" then curHat = (curHat - 1 < 1) and 3 or curHat - 1
                elseif activeTab == "face" and faceCfg then curFace = (curFace - 1 < 1) and faceCfg.max or curFace - 1 end
                updateAll()
            elseif key == KEY_RIGHT then
                if activeTab == "shirt" then curShirt = (curShirt + 1 > 2) and 1 or curShirt + 1
                elseif activeTab == "hat" then curHat = (curHat + 1 > 3) and 1 or curHat + 1
                elseif activeTab == "face" and faceCfg then curFace = (curFace + 1 > faceCfg.max) and 1 or curFace + 1 end
                updateAll()
            end
        end

        mp.OnMouseWheeled = function(s, delta)
            if activeTab == "shirt" then
                curShirt = curShirt + (delta > 0 and 1 or -1)
                if curShirt > 2 then curShirt = 1 elseif curShirt < 1 then curShirt = 2 end
            elseif activeTab == "hat" then
                curHat = curHat + (delta > 0 and 1 or -1)
                if curHat > 3 then curHat = 1 elseif curHat < 1 then curHat = 3 end
            elseif activeTab == "face" and faceCfg then
                curFace = curFace + (delta > 0 and 1 or -1)
                if curFace > faceCfg.max then curFace = 1 elseif curFace < 1 then curFace = faceCfg.max end
            end
            updateAll()
        end
    end

    local function createNormalMenu(p)
        if IsValid(menu) then menu:Close() end
        local curTop = p:GetNWInt("top_id", 1)
        local curPants = p:GetNWInt("pants_id", 1)
        local curBoots = p:GetNWInt("boots_id", 1)
        local curFace = p:GetNWInt("face_id", 1)
        local faceCfg = getFaceCfg(p)

        local isJacket = getTorsoGroup(p) == 2
        local maxTop = isJacket and 9 or 169
        local topLabelText = isJacket and "КурткаЯхз" or "Верх"

        menu = vgui.Create("DFrame")
        local f = menu
        f:SetSize(900, 650)
        f:Center()
        f:SetTitle("")
        f:MakePopup()
        f:ShowCloseButton(false)

        f.Paint = function(s, w, h)
            draw.RoundedBox(12, 0, 0, w, h, Color(24,24,28,255))
            draw.RoundedBoxEx(12, 0, 0, w, 50, Color(145,25,25), true, true, false, false)
            draw.SimpleText("Мой говорящий том тест", "ClthTitle", 20, 25, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local close = vgui.Create("DButton", f)
        close:SetSize(35,35)
        close:SetPos(900-45,7)
        close:SetText("✕")
        close:SetFont("ClthTitle")
        close.Paint = function(s,w,h) s:SetTextColor(s:IsHovered() and Color(255,100,100) or Color(240,240,240)) end
        close.DoClick = function() f:Close() end

        local pvl = vgui.Create("DPanel", f)
        pvl:SetSize(380, 520)
        pvl:SetPos(15, 60)
        pvl.Paint = function(s,w,h)
            draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255))
            surface.SetDrawColor(45,45,50)
            surface.DrawOutlinedRect(0,0,w,h,1)
        end

        local mp = vgui.Create("DModelPanel", pvl)
        mp:Dock(FILL)
        mp:SetModel(p:GetModel())
        mp:SetCamPos(Vector(68,0,42))
        mp:SetLookAt(Vector(0,0,38))
        mp:SetFOV(46)
        local ent = mp:GetEntity()
        local rotY = 0
        local lastX = 0
        if IsValid(ent) then
            -- Копируем бодигруппы с игрока
            for _, bg in ipairs(p:GetBodyGroups()) do
                ent:SetBodygroup(bg.id, p:GetBodygroup(bg.id))
            end
            applyNormal(ent, curTop, curPants, curBoots, curFace)
            function mp:LayoutEntity(e)
                e:SetSequence(e:LookupSequence("idle_all_01") or 1)
                if self.Hovered and input.IsMouseDown(MOUSE_LEFT) then
                    if not self.B_Pressed then
                        self.B_Pressed = true
                        lastX = gui.MouseX()
                    else
                        local curX = gui.MouseX()
                        rotY = rotY + (curX - lastX) * 0.75
                        lastX = curX
                    end
                else
                    self.B_Pressed = false
                end
                e:SetAngles(Angle(0, rotY, 0))
            end
        end

        local function sendUpdate()
            net.Start("clth_set_full")
            net.WriteInt(curTop, 16)
            net.WriteInt(curPants, 16)
            net.WriteInt(curBoots, 16)
            net.WriteInt(curFace, 16)
            net.SendToServer()
        end

        local quickBar = vgui.Create("DPanel", f)
        quickBar:SetSize(380, 45)
        quickBar:SetPos(15, 595)
        quickBar.Paint = function(s,w,h)
            draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255))
            surface.SetDrawColor(45,45,50)
            surface.DrawOutlinedRect(0,0,w,h,1)
        end

        local lblTop = vgui.Create("DLabel", quickBar)
        lblTop:SetSize(120, 35)
        lblTop:SetPos(10,5)
        lblTop:SetText(topLabelText..": #"..curTop)
        lblTop:SetFont("ClthTitle")
        lblTop:SetTextColor(Color(235,235,235))
        lblTop:SetContentAlignment(5)

        local lblPants = vgui.Create("DLabel", quickBar)
        lblPants:SetSize(120, 35)
        lblPants:SetPos(130,5)
        lblPants:SetText("Штаны: #"..curPants)
        lblPants:SetFont("ClthTitle")
        lblPants:SetTextColor(Color(235,235,235))
        lblPants:SetContentAlignment(5)

        local lblBoots = vgui.Create("DLabel", quickBar)
        lblBoots:SetSize(120, 35)
        lblBoots:SetPos(250,5)
        lblBoots:SetText("Ботинки: #"..curBoots)
        lblBoots:SetFont("ClthTitle")
        lblBoots:SetTextColor(Color(235,235,235))
        lblBoots:SetContentAlignment(5)

        local tabTop = vgui.Create("DButton", f)
        tabTop:SetSize(150, 40)
        tabTop:SetPos(410, 60)
        tabTop:SetText(topLabelText)
        tabTop:SetFont("ClthTitle")
        local tabPants = vgui.Create("DButton", f)
        tabPants:SetSize(150, 40)
        tabPants:SetPos(570, 60)
        tabPants:SetText("Штаны")
        tabPants:SetFont("ClthTitle")
        local tabBoots = vgui.Create("DButton", f)
        tabBoots:SetSize(150, 40)
        tabBoots:SetPos(730, 60)
        tabBoots:SetText("Ботинки")
        tabBoots:SetFont("ClthTitle")
        local tabFace = vgui.Create("DButton", f)
        tabFace:SetSize(150, 40)
        tabFace:SetPos(410, 110)
        tabFace:SetText("Лица")
        tabFace:SetFont("ClthTitle")
        if not faceCfg then tabFace:SetEnabled(false) tabFace:SetAlpha(50) end

        local scrlTop = vgui.Create("DScrollPanel", f)
        scrlTop:SetSize(475, 430)
        scrlTop:SetPos(410, 160)
        local scrlPants = vgui.Create("DScrollPanel", f)
        scrlPants:SetSize(475, 430)
        scrlPants:SetPos(410, 160)
        scrlPants:SetVisible(false)
        local scrlBoots = vgui.Create("DScrollPanel", f)
        scrlBoots:SetSize(475, 430)
        scrlBoots:SetPos(410, 160)
        scrlBoots:SetVisible(false)
        local scrlFace = vgui.Create("DScrollPanel", f)
        scrlFace:SetSize(475, 430)
        scrlFace:SetPos(410, 160)
        scrlFace:SetVisible(false)

        local function styleScroll(sbar)
            sbar:SetWide(6)
            sbar.Paint = nil
            sbar.btnUp.Paint = nil
            sbar.btnDown.Paint = nil
            sbar.btnGrip.Paint = function(s,w,h) draw.RoundedBox(3,0,0,w,h,Color(65,65,70)) end
        end
        styleScroll(scrlTop:GetVBar())
        styleScroll(scrlPants:GetVBar())
        styleScroll(scrlBoots:GetVBar())
        styleScroll(scrlFace:GetVBar())

        local gridTop = vgui.Create("DIconLayout", scrlTop)
        gridTop:Dock(FILL)
        gridTop:SetSpaceX(8)
        gridTop:SetSpaceY(8)
        local gridPants = vgui.Create("DIconLayout", scrlPants)
        gridPants:Dock(FILL)
        gridPants:SetSpaceX(8)
        gridPants:SetSpaceY(8)
        local gridBoots = vgui.Create("DIconLayout", scrlBoots)
        gridBoots:Dock(FILL)
        gridBoots:SetSpaceX(8)
        gridBoots:SetSpaceY(8)
        local gridFace = vgui.Create("DIconLayout", scrlFace)
        gridFace:Dock(FILL)
        gridFace:SetSpaceX(8)
        gridFace:SetSpaceY(8)

        local activeTab = "top"
        local function updateTabs()
            tabTop.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="top" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
            tabPants.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="pants" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
            tabBoots.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="boots" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
            tabFace.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="face" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
        end
        updateTabs()

        tabTop.DoClick = function() activeTab="top" scrlTop:SetVisible(true) scrlPants:SetVisible(false) scrlBoots:SetVisible(false) scrlFace:SetVisible(false) updateTabs() end
        tabPants.DoClick = function() activeTab="pants" scrlTop:SetVisible(false) scrlPants:SetVisible(true) scrlBoots:SetVisible(false) scrlFace:SetVisible(false) updateTabs() end
        tabBoots.DoClick = function() activeTab="boots" scrlTop:SetVisible(false) scrlPants:SetVisible(false) scrlBoots:SetVisible(true) scrlFace:SetVisible(false) updateTabs() end
        tabFace.DoClick = function() if not faceCfg then return end activeTab="face" scrlTop:SetVisible(false) scrlPants:SetVisible(false) scrlBoots:SetVisible(false) scrlFace:SetVisible(true) updateTabs() end

        local function updateAll()
            if IsValid(ent) then
                -- Обновляем бодигруппы при смене скина (на случай, если они изменились)
                for _, bg in ipairs(p:GetBodyGroups()) do
                    ent:SetBodygroup(bg.id, p:GetBodygroup(bg.id))
                end
                applyNormal(ent, curTop, curPants, curBoots, curFace)
            end
            lblTop:SetText(topLabelText..": #"..curTop)
            lblPants:SetText("Штаны: #"..curPants)
            lblBoots:SetText("Ботинки: #"..curBoots)
            sendUpdate()
        end

        local topTiles = {}
        for i=1, maxTop do
            local tile = gridTop:Add("DButton")
            tile:SetSize(70, 70)
            tile:SetText("")
            topTiles[i] = tile
            tile.Paint = function(s,w,h)
                local sel = (curTop == i)
                draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                draw.SimpleText(i, "ClthTitle", w/2, h/2, Color(245,245,245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if sel then surface.SetDrawColor(255,255,255,120) surface.DrawOutlinedRect(0,0,w,h,2) end
            end
            tile.DoClick = function() curTop = i updateAll() end
        end

        local pantsTiles = {}
        for i=1,200 do
            local tile = gridPants:Add("DButton")
            tile:SetSize(70, 70)
            tile:SetText("")
            pantsTiles[i] = tile
            tile.Paint = function(s,w,h)
                local sel = (curPants == i)
                draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                draw.SimpleText(i, "ClthTitle", w/2, h/2, Color(245,245,245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if sel then surface.SetDrawColor(255,255,255,120) surface.DrawOutlinedRect(0,0,w,h,2) end
            end
            tile.DoClick = function() curPants = i updateAll() end
        end

        local bootsTiles = {}
        for i=1,90 do
            local tile = gridBoots:Add("DButton")
            tile:SetSize(70, 70)
            tile:SetText("")
            bootsTiles[i] = tile
            tile.Paint = function(s,w,h)
                local sel = (curBoots == i)
                draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                draw.SimpleText(i, "ClthTitle", w/2, h/2, Color(245,245,245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if sel then surface.SetDrawColor(255,255,255,120) surface.DrawOutlinedRect(0,0,w,h,2) end
            end
            tile.DoClick = function() curBoots = i updateAll() end
        end

        if faceCfg then
            for i=1, faceCfg.max do
                local tile = gridFace:Add("DButton")
                tile:SetSize(70, 70)
                tile:SetText("")
                local subMP = vgui.Create("DModelPanel", tile)
                subMP:Dock(FILL)
                subMP:SetModel(p:GetModel())
                subMP:SetCamPos(Vector(45,0,63))
                subMP:SetLookAt(Vector(0,0,63))
                subMP:SetFOV(28)
                subMP:SetMouseInputEnabled(false)
                function subMP:LayoutEntity(e) e:SetAngles(Angle(0,0,0)) end
                local subE = subMP:GetEntity()
                if IsValid(subE) then
                    for _, bg in ipairs(p:GetBodyGroups()) do
                        subE:SetBodygroup(bg.id, p:GetBodygroup(bg.id))
                    end
                    applyNormal(subE, 1, 1, 1, i)
                end
                tile.Paint = function(s,w,h)
                    local sel = (curFace == i)
                    draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                    if sel then surface.SetDrawColor(255,255,255,180) surface.DrawOutlinedRect(0,0,w,h,2) end
                end
                tile.DoClick = function() curFace = i updateAll() end
            end
        end

        local btnRand = vgui.Create("DButton", f)
        btnRand:SetSize(475, 45)
        btnRand:SetPos(410, 595)
        btnRand:SetText("Random")
        btnRand:SetFont("ClthTitle")
        btnRand:SetTextColor(Color(255,255,255))
        btnRand.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,s:IsHovered() and Color(185,35,35) or Color(145,25,25)) end
        btnRand.DoClick = function()
            curTop = math.random(1, maxTop)
            curPants = math.random(1,200)
            curBoots = math.random(1,90)
            curFace = faceCfg and math.random(1, faceCfg.max) or 1
            updateAll()
        end

        f.OnKeyCodePressed = function(s, key)
            if key == KEY_LEFT then
                if activeTab == "top" then curTop = (curTop - 1 < 1) and maxTop or curTop - 1
                elseif activeTab == "pants" then curPants = (curPants - 1 < 1) and 200 or curPants - 1
                elseif activeTab == "boots" then curBoots = (curBoots - 1 < 1) and 90 or curBoots - 1
                elseif activeTab == "face" and faceCfg then curFace = (curFace - 1 < 1) and faceCfg.max or curFace - 1 end
                updateAll()
            elseif key == KEY_RIGHT then
                if activeTab == "top" then curTop = (curTop + 1 > maxTop) and 1 or curTop + 1
                elseif activeTab == "pants" then curPants = (curPants + 1 > 200) and 1 or curPants + 1
                elseif activeTab == "boots" then curBoots = (curBoots + 1 > 90) and 1 or curBoots + 1
                elseif activeTab == "face" and faceCfg then curFace = (curFace + 1 > faceCfg.max) and 1 or curFace + 1 end
                updateAll()
            end
        end

        mp.OnMouseWheeled = function(s, delta)
            if activeTab == "top" then
                curTop = curTop + (delta > 0 and 1 or -1)
                if curTop > maxTop then curTop = 1 elseif curTop < 1 then curTop = maxTop end
            elseif activeTab == "pants" then
                curPants = curPants + (delta > 0 and 1 or -1)
                if curPants > 200 then curPants = 1 elseif curPants < 1 then curPants = 200 end
            elseif activeTab == "boots" then
                curBoots = curBoots + (delta > 0 and 1 or -1)
                if curBoots > 90 then curBoots = 1 elseif curBoots < 1 then curBoots = 90 end
            elseif activeTab == "face" and faceCfg then
                curFace = curFace + (delta > 0 and 1 or -1)
                if curFace > faceCfg.max then curFace = 1 elseif curFace < 1 then curFace = faceCfg.max end
            end
            updateAll()
        end
    end

    local function createLegacyMenu(p)
        if IsValid(menu) then menu:Close() end
        local curClth = p:GetNWInt("clth_id", 1)
        local curFace = p:GetNWInt("face_id", 1)
        local faceCfg = getFaceCfg(p)

        menu = vgui.Create("DFrame")
        local f = menu
        f:SetSize(850, 620)
        f:Center()
        f:SetTitle("")
        f:MakePopup()
        f:ShowCloseButton(false)

        f.Paint = function(s,w,h)
            draw.RoundedBox(12,0,0,w,h,Color(24,24,28,255))
            draw.RoundedBoxEx(12,0,0,w,50,Color(145,25,25),true,true,false,false)
            draw.SimpleText("Мой говорящий том", "ClthTitle", 20, 25, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
        end

        local close = vgui.Create("DButton", f)
        close:SetSize(35,35)
        close:SetPos(850-45,7)
        close:SetText("✕")
        close:SetFont("ClthTitle")
        close.Paint = function(s,w,h) s:SetTextColor(s:IsHovered() and Color(255,100,100) or Color(240,240,240)) end
        close.DoClick = function() f:Close() end

        local pvl = vgui.Create("DPanel", f)
        pvl:SetSize(360,490)
        pvl:SetPos(15,60)
        pvl.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255)) surface.SetDrawColor(45,45,50) surface.DrawOutlinedRect(0,0,w,h,1) end

        local mp = vgui.Create("DModelPanel", pvl)
        mp:Dock(FILL)
        mp:SetModel(p:GetModel())
        mp:SetCamPos(Vector(68,0,42))
        mp:SetLookAt(Vector(0,0,38))
        mp:SetFOV(46)
        local ent = mp:GetEntity()
        local rotY = 0
        local lastX = 0
        if IsValid(ent) then
            applyLegacy(ent, curClth, curFace)
            function mp:LayoutEntity(e)
                e:SetSequence(e:LookupSequence("idle_all_01") or 1)
                if self.Hovered and input.IsMouseDown(MOUSE_LEFT) then
                    if not self.B_Pressed then
                        self.B_Pressed = true
                        lastX = gui.MouseX()
                    else
                        local curX = gui.MouseX()
                        rotY = rotY + (curX - lastX) * 0.75
                        lastX = curX
                    end
                else
                    self.B_Pressed = false
                end
                e:SetAngles(Angle(0, rotY, 0))
            end
        end

        local function sendUpdate()
            net.Start("clth_set")
            net.WriteInt(curClth, 16)
            net.WriteInt(curFace, 16)
            net.SendToServer()
        end

        local quickBar = vgui.Create("DPanel", f)
        quickBar:SetSize(360,45)
        quickBar:SetPos(15,565)
        quickBar.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,Color(16,16,18,255)) surface.SetDrawColor(45,45,50) surface.DrawOutlinedRect(0,0,w,h,1) end

        local clthLabel = vgui.Create("DLabel", quickBar)
        clthLabel:SetSize(200,35)
        clthLabel:SetPos(80,5)
        clthLabel:SetText("Одежда: #"..curClth)
        clthLabel:SetFont("ClthTitle")
        clthLabel:SetTextColor(Color(235,235,235))
        clthLabel:SetContentAlignment(5)

        local tabClth = vgui.Create("DButton", f)
        tabClth:SetSize(215,40)
        tabClth:SetPos(390,60)
        tabClth:SetText("ОДЕЖДА")
        tabClth:SetFont("ClthTitle")
        local tabFace = vgui.Create("DButton", f)
        tabFace:SetSize(215,40)
        tabFace:SetPos(620,60)
        tabFace:SetText("ЛИЦА")
        tabFace:SetFont("ClthTitle")
        if not faceCfg then tabFace:SetEnabled(false) tabFace:SetAlpha(50) end

        local searchClth = vgui.Create("DTextEntry", f)
        searchClth:SetSize(445,35)
        searchClth:SetPos(390,110)
        searchClth:SetPlaceholderText("Поискнахуй")
        searchClth:SetFont("ClthText")
        searchClth:SetTextColor(Color(255,255,255))
        searchClth.Paint = function(s,w,h)
            draw.RoundedBox(6,0,0,w,h,Color(16,16,18,255))
            surface.SetDrawColor(45,45,50)
            surface.DrawOutlinedRect(0,0,w,h,1)
            s:DrawTextEntryText(s:GetTextColor(), s:GetHighlightColor(), s:GetCursorColor())
        end

        local scrlClth = vgui.Create("DScrollPanel", f)
        scrlClth:SetSize(445,400)
        scrlClth:SetPos(390,155)
        local scrlFace = vgui.Create("DScrollPanel", f)
        scrlFace:SetSize(445,445)
        scrlFace:SetPos(390,110)
        scrlFace:SetVisible(false)

        local function styleScroll(sbar)
            sbar:SetWide(6)
            sbar.Paint = nil
            sbar.btnUp.Paint = nil
            sbar.btnDown.Paint = nil
            sbar.btnGrip.Paint = function(s,w,h) draw.RoundedBox(3,0,0,w,h,Color(65,65,70)) end
        end
        styleScroll(scrlClth:GetVBar())
        styleScroll(scrlFace:GetVBar())

        local gridClth = vgui.Create("DIconLayout", scrlClth)
        gridClth:Dock(FILL)
        gridClth:SetSpaceX(8)
        gridClth:SetSpaceY(8)
        local gridFace = vgui.Create("DIconLayout", scrlFace)
        gridFace:Dock(FILL)
        gridFace:SetSpaceX(8)
        gridFace:SetSpaceY(8)

        local activeTab = "clth"
        local function updateTabs()
            tabClth.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="clth" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
            tabFace.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,activeTab=="face" and Color(145,25,25) or Color(36,36,42)) s:SetTextColor(Color(255,255,255)) end
        end
        updateTabs()

        tabClth.DoClick = function() activeTab="clth" scrlClth:SetVisible(true) scrlFace:SetVisible(false) searchClth:SetVisible(true) updateTabs() end
        tabFace.DoClick = function() if not faceCfg then return end activeTab="face" scrlClth:SetVisible(false) scrlFace:SetVisible(true) searchClth:SetVisible(false) updateTabs() end

        local function updateSelection(newClth, newFace)
            if newClth then curClth = math.Clamp(newClth, 1, 205) clthLabel:SetText("Одежда: #"..curClth) end
            if newFace and faceCfg then curFace = math.Clamp(newFace, 1, faceCfg.max) end
            if IsValid(ent) then applyLegacy(ent, curClth, curFace) end
            sendUpdate()
            syncArms(p, curClth)
        end

        searchClth.OnTextChanged = function(s)
            local txt = s:GetText()
            local val = tonumber(txt)
            if val and val >= 1 and val <= 205 then updateSelection(val, nil) end
            for i=1,205 do
                if clthTiles[i] then
                    clthTiles[i]:SetVisible(txt=="" or tostring(i):find(txt,1,true))
                end
            end
            gridClth:Layout()
        end

        mp.OnMouseWheeled = function(s, delta)
            local nextID = curClth + (delta > 0 and 1 or -1)
            if nextID > 205 then nextID = 1 elseif nextID < 1 then nextID = 205 end
            updateSelection(nextID, nil)
        end

        f.OnKeyCodePressed = function(s, key)
            if key == KEY_LEFT then
                local nextID = curClth - 1
                if nextID < 1 then nextID = 205 end
                updateSelection(nextID, nil)
            elseif key == KEY_RIGHT then
                local nextID = curClth + 1
                if nextID > 205 then nextID = 1 end
                updateSelection(nextID, nil)
            end
        end

        local btnPrev = vgui.Create("DButton", quickBar)
        btnPrev:SetSize(45,35)
        btnPrev:SetPos(5,5)
        btnPrev:SetText("◀")
        btnPrev:SetFont("ClthTitle")
        btnPrev:SetTextColor(Color(255,255,255))
        btnPrev.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,s:IsHovered() and Color(145,25,25) or Color(34,34,40)) end
        btnPrev.DoClick = function()
            local nextID = curClth - 1
            if nextID < 1 then nextID = 205 end
            updateSelection(nextID, nil)
        end

        local btnNext = vgui.Create("DButton", quickBar)
        btnNext:SetSize(45,35)
        btnNext:SetPos(360-50,5)
        btnNext:SetText("▶")
        btnNext:SetFont("ClthTitle")
        btnNext:SetTextColor(Color(255,255,255))
        btnNext.Paint = function(s,w,h) draw.RoundedBox(6,0,0,w,h,s:IsHovered() and Color(145,25,25) or Color(34,34,40)) end
        btnNext.DoClick = function()
            local nextID = curClth + 1
            if nextID > 205 then nextID = 1 end
            updateSelection(nextID, nil)
        end

        local clthTiles = {}
        for i=1,205 do
            local tile = gridClth:Add("DButton")
            tile:SetSize(77,75)
            tile:SetText("")
            clthTiles[i] = tile
            tile.Paint = function(s,w,h)
                local sel = (curClth == i)
                draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                draw.SimpleText(i, "ClthTitle", w/2, h/2, Color(245,245,245), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                if sel then surface.SetDrawColor(255,255,255,120) surface.DrawOutlinedRect(0,0,w,h,2) end
            end
            tile.DoClick = function() updateSelection(i, nil) end
        end

        if faceCfg then
            for i=1, faceCfg.max do
                local tile = gridFace:Add("DButton")
                tile:SetSize(77,75)
                tile:SetText("")
                local subMP = vgui.Create("DModelPanel", tile)
                subMP:Dock(FILL)
                subMP:SetModel(p:GetModel())
                subMP:SetCamPos(Vector(45,0,63))
                subMP:SetLookAt(Vector(0,0,63))
                subMP:SetFOV(28)
                subMP:SetMouseInputEnabled(false)
                function subMP:LayoutEntity(e) e:SetAngles(Angle(0,0,0)) end
                local subE = subMP:GetEntity()
                if IsValid(subE) then applyLegacy(subE, 1, i) end
                tile.Paint = function(s,w,h)
                    local sel = (curFace == i)
                    draw.RoundedBox(8,0,0,w,h,sel and Color(165,30,30) or (s:IsHovered() and Color(52,52,60) or Color(34,34,40)))
                    if sel then surface.SetDrawColor(255,255,255,180) surface.DrawOutlinedRect(0,0,w,h,2) end
                end
                tile.DoClick = function() updateSelection(nil, i) end
            end
        end

        local btnRand = vgui.Create("DButton", f)
        btnRand:SetSize(445,45)
        btnRand:SetPos(390,565)
        btnRand:SetText("Random")
        btnRand:SetFont("ClthTitle")
        btnRand:SetTextColor(Color(255,255,255))
        btnRand.Paint = function(s,w,h) draw.RoundedBox(8,0,0,w,h,s:IsHovered() and Color(185,35,35) or Color(145,25,25)) end
        btnRand.DoClick = function()
            local rc = math.random(1,205)
            local rf = faceCfg and math.random(1, faceCfg.max) or 1
            updateSelection(rc, rf)
        end
    end

    local function openM()
        local p = LocalPlayer()
        if not IsValid(p) then return end
        if not chkMdl(p) and not isNormal(p) and not isNYPD(p) and not isSuit(p) then
            chat.AddText(Color(255,50,50), "Лее брат твоя моделька не поддерживает эту кастомизацию (Обычные модельки используй)")
            return
        end
        if isSuit(p) then
            createSuitMenu(p)
        elseif isNYPD(p) then
            createNYPDMenu(p)
        elseif isNormal(p) then
            createNormalMenu(p)
        else
            createLegacyMenu(p)
        end
    end
    concommand.Add("clothesomagadd", openM)
end