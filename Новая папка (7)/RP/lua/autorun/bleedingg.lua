if SERVER then
    util.AddNetworkString("BleedDecalParticles")
end

Bleeds = Bleeds or {}

local function BloodDecal(ent)
    if not IsValid(ent) then return end

    local target = ent
    if ent:IsPlayer() and IsValid(ent:GetNWEntity("Ragdoll")) then
        target = ent:GetNWEntity("Ragdoll")
    end

    local start = target:WorldSpaceCenter()
    local trace = util.TraceLine({
        start = start,
        endpos = start - Vector(0, 0, 200),
        filter = {ent, target}
    })
    
    if trace.Hit then
        util.Decal("Blood", trace.HitPos + trace.HitNormal, trace.HitPos - trace.HitNormal, target)
    end
end

local function Bleed(ent)
    if not IsValid(ent) or not (ent:IsPlayer() or ent:IsNPC()) then return end
    if ent:IsPlayer() and ent:Armor() > 0 then
        if math.random() >= 0.6 then return end
    end

    if Bleeds[ent] then
        Bleeds[ent].hits = Bleeds[ent].hits + 1
        Bleeds[ent].last = CurTime()
    else
        Bleeds[ent] = {
            hits = 1,
            last = CurTime(),
            nextDmg = CurTime() + 6,
            nextDecal = CurTime() + 3.5
        }
        if ent:IsPlayer() then
            ent:SetNWFloat("BleedTime", CurTime())
        end
    end
end

hook.Add("EntityTakeDamage", "BleedTakeDmg", function(target, dmg)
    if not IsValid(target) then return end
    if dmg:IsBulletDamage() or dmg:IsDamageType(DMG_BUCKSHOT) or dmg:IsDamageType(DMG_SLASH) then
        if target:IsPlayer() and target:Armor() > 0 then
            if math.random() >= 0.3 then return end
        end
        Bleed(target)
    end
end)

hook.Add("Think", "BleedSysLoop", function()
    for ent, data in pairs(Bleeds) do
        if not IsValid(ent) then
            Bleeds[ent] = nil
            if ent and ent:IsPlayer() then ent:SetNWFloat("BleedTime", 0) end
        else
            if ent:IsPlayer() and ent:Health() >= ent:GetMaxHealth() then
                Bleeds[ent] = nil
                ent:SetNWFloat("BleedTime", 0)
            else
                local ko = false
                if ent:IsPlayer() then
                    ko = IsValid(ent:GetNWEntity("Ragdoll")) or ent:GetNWBool("UnconsciousInVehicle", false)
                end

                if not ko and ent:Health() > 0 then
                    if CurTime() >= data.nextDmg then
                        if ent:IsPlayer() then
                            local hp = ent:Health() - 4
                            if hp <= 0 then ent:Kill() else ent:SetHealth(hp) end
                        else
                            ent:TakeDamage(4, game.GetWorld(), game.GetWorld())
                        end
                        data.nextDmg = CurTime() + 6
                    end
                end

                if CurTime() >= data.nextDecal then
                    BloodDecal(ent)
                    data.nextDecal = CurTime() + 3.5
                    if ent:IsPlayer() then
                        net.Start("BleedDecalParticles")
                        net.WriteEntity(ent)
                        net.Broadcast()
                    end
                end

     

                if CurTime() - data.last > 40 then
                    Bleeds[ent] = nil
                    if ent:IsPlayer() then ent:SetNWFloat("BleedTime", 0) end
                end
            end
        end
    end
end)

if CLIENT then
    local function SpawnBloodDrops(ply)
        if not IsValid(ply) or not ply:IsPlayer() or not ply:Alive() then return end
        local emitter = ParticleEmitter(ply:GetPos())
        if not emitter then return end

        local attach = ply:LookupAttachment("stomach")
        local pos = ply:GetPos() + Vector(0, 0, 20)
        if attach and attach > 0 then
            local att = ply:GetAttachment(attach)
            if att and att.Pos then pos = att.Pos end
        else
            local chest = ply:LookupAttachment("chest")
            if chest and chest > 0 then
                local att = ply:GetAttachment(chest)
                if att and att.Pos then pos = att.Pos - Vector(0, 0, 15) end
            end
        end

        emitter:SetPos(pos)

        local numParticles = 4
        local spacing = 3
        for i = 1, numParticles do
            local offset = i * spacing
            local pPos = pos + Vector(0, 0, -offset)
            local particle = emitter:Add("decals/blood1", pPos)
            if particle then
                particle:SetVelocity(VectorRand() * 8 + Vector(0, 0, -90))
                particle:SetLifeTime(0)
                particle:SetDieTime(math.Rand(0.8, 1.5))
                particle:SetStartAlpha(180)
                particle:SetEndAlpha(0)
                particle:SetStartSize(math.Rand(2, 4))
                particle:SetEndSize(1)
                particle:SetRoll(math.Rand(-10, 10))
                particle:SetColor(180, 20, 20)
                particle:SetGravity(Vector(0, 0, -250))
            end
        end
        emitter:Finish()
    end

    net.Receive("BleedDecalParticles", function()
        local ply = net.ReadEntity()
        SpawnBloodDrops(ply)
    end)
end