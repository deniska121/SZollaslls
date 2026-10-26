-- addons/weapons/lua/weapons/mg_base/modules/shared/sh_melee_behaviour.lua

AddCSLuaFile()

function SWEP:CanMelee()
    return not self:GetIsSprinting() and not self:GetIsHolstering() and not self:IsDrawing() and CurTime() > self:GetNextPrimaryFire() and CurTime() > self:GetNextSprintTime() and not self:IsCustomizing()
end

function SWEP:DoMelee()
    self:SetIsReloading(false)

    local range = self.Animations["Melee"].Range or 50
    local hit = false

    local meleeDuration = self:GetAnimLength("Melee_Hit", self.Animations["Melee_Hit"].Length or 0.5) + 0.3
    self:SetNWFloat("MeleeLockTime", CurTime() + meleeDuration)

    if SERVER then
        self:GetOwner():SetWalkSpeed(self:GetOwner():GetWalkSpeed() * 0.3)
        self:GetOwner():SetRunSpeed(self:GetOwner():GetRunSpeed() * 0.3)
    end

    local tr = util.TraceLine({
        start = self:GetOwner():GetShootPos(),
        endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * range,
        filter = self:GetOwner(),
        mask = MASK_SHOT_HULL
    })

    if not IsValid(tr.Entity) then
        tr = util.TraceHull({
            start = self:GetOwner():GetShootPos(),
            endpos = self:GetOwner():GetShootPos() + self:GetOwner():GetAimVector() * range,
            filter = self:GetOwner(),
            mins = Vector(-10, -10, -8),
            maxs = Vector(10, 10, 8),
            mask = MASK_SHOT_HULL
        })
    end

    local scale = 0.2

    if SERVER then
        if IsValid(tr.Entity) and (tr.Entity:IsNPC() or tr.Entity:IsPlayer()) and tr.Entity:Health() > 0 then
            local dmginfo = DamageInfo()
            local attacker = self:GetOwner()

            if not IsValid(attacker) then
                attacker = self
            end

            local damage = self.Animations["Melee_Hit"].Damage / 2 or 10
            local isHeadshot = (tr.HitGroup == 1 or tr.HitGroup == HITGROUP_HEAD)
            local isPlayer = tr.Entity:IsPlayer()
            local isMeleeWeapon = self:GetClass() == "weapon_ebaniehands" or self.HoldType == "melee" or self.HoldType == "melee2"
            local isButtstock = self:GetClass() ~= "weapon_ebaniehands" and not isMeleeWeapon

            dmginfo:SetAttacker(attacker)
            dmginfo:SetInflictor(self)

            if isHeadshot and isPlayer and not isButtstock then
                damage = damage * 2.5
                dmginfo:SetDamage(damage)
                dmginfo:SetDamageForce(self:GetOwner():GetUp() * 8158 * scale + self:GetOwner():GetForward() * 15012 * scale)
                dmginfo:SetDamageType(DMG_CLUB + DMG_BULLET)

                SuppressHostEvents(NULL)
                tr.Entity:TakeDamageInfo(dmginfo)
                SuppressHostEvents(self:GetOwner())

                local ply = tr.Entity
                if IsValid(ply) and ply:IsPlayer() and ply:Alive() and ply:Health() > 0 then
                    if Sleep and type(Sleep) == "function" then
                        Sleep(ply, 25)
                    end
                end

                hit = true
                local headPos = tr.Entity:GetPos() + Vector(0, 0, 64)
                local effectdata = EffectData()
                effectdata:SetOrigin(headPos)
                effectdata:SetScale(6)
                util.Effect("bloodspray", effectdata)
                util.Effect("BloodImpact", effectdata)

            elseif isHeadshot and isPlayer and isButtstock then
                dmginfo:SetDamage(damage)
                dmginfo:SetDamageForce(self:GetOwner():GetUp() * 5158 * scale + self:GetOwner():GetForward() * 10012 * scale)
                dmginfo:SetDamageType(DMG_CLUB)

                SuppressHostEvents(NULL)
                tr.Entity:TakeDamageInfo(dmginfo)
                SuppressHostEvents(self:GetOwner())

                local ply = tr.Entity
                if IsValid(ply) and ply:IsPlayer() and ply:Alive() and ply:Health() > 0 then
                    if Sleep and type(Sleep) == "function" then
                        Sleep(ply, 20 + math.random(5, 15))
                    end
                end

                hit = true

            elseif isPlayer and not isButtstock then
                dmginfo:SetDamage(damage)
                dmginfo:SetDamageForce(self:GetOwner():GetUp() * 5158 * scale + self:GetOwner():GetForward() * 10012 * scale)
                dmginfo:SetDamageType(DMG_CLUB)

                SuppressHostEvents(NULL)
                tr.Entity:TakeDamageInfo(dmginfo)
                SuppressHostEvents(self:GetOwner())

                if tr.Entity:Health() > 0 and tr.Entity:Health() < 30 then
                    local ply = tr.Entity
                    if IsValid(ply) and ply:IsPlayer() and ply:Alive() then
                        if Sleep and type(Sleep) == "function" then
                            Sleep(ply, 20 + math.random(5, 15))
                        end
                    end
                end

                hit = true

            elseif isPlayer and isButtstock then
                local reducedDamage = damage * 0.3
                dmginfo:SetDamage(reducedDamage)
                dmginfo:SetDamageForce(self:GetOwner():GetUp() * 3000 * scale + self:GetOwner():GetForward() * 5000 * scale)
                dmginfo:SetDamageType(DMG_CLUB)

                SuppressHostEvents(NULL)
                tr.Entity:TakeDamageInfo(dmginfo)
                SuppressHostEvents(self:GetOwner())

                if tr.Entity:Health() > 0 and tr.Entity:Health() < 15 then
                    local ply = tr.Entity
                    if IsValid(ply) and ply:IsPlayer() and ply:Alive() then
                        if Sleep and type(Sleep) == "function" then
                            Sleep(ply, 15 + math.random(5, 10))
                        end
                    end
                end

                hit = true

            else
                dmginfo:SetDamage(damage)
                dmginfo:SetDamageForce(self:GetOwner():GetUp() * 5158 * scale + self:GetOwner():GetForward() * 10012 * scale)
                dmginfo:SetDamageType(DMG_CLUB)

                SuppressHostEvents(NULL)
                tr.Entity:TakeDamageInfo(dmginfo)
                SuppressHostEvents(self:GetOwner())
                hit = true
            end

        else
            self:FireBullets({
                Src = self:GetOwner():EyePos(),
                Dir = self:GetOwner():EyeAngles():Forward(),
                Distance = range,
                HullSize = 0,
                Tracer = 0,
                Callback = function(attacker, btr, dmgInfo)
                    dmgInfo:SetDamage(self.Animations["Melee_Hit"].Damage / 4 or 5)
                    dmgInfo:SetInflictor(self)
                    dmgInfo:SetAttacker(self:GetOwner())
                    dmgInfo:SetDamagePosition(btr.HitPos)
                    dmgInfo:SetDamageForce(self:GetOwner():EyeAngles():Forward() * ((self.Animations["Melee_Hit"].Damage / 2 or 10) * 50))
                    dmgInfo:SetDamageType(DMG_CLUB)
                    hit = true
                end
            })
        end

        if IsValid(tr.Entity) then
            local phys = tr.Entity:GetPhysicsObject()
            if IsValid(phys) then
                phys:ApplyForceOffset(self:GetOwner():GetAimVector() * 80 * phys:GetMass() * scale, tr.HitPos)
            end
        end
    end

    if hit then
        local hitDuration = self:GetAnimLength("Melee_Hit", self.Animations["Melee_Hit"].Length or 0.5) + 0.3
        self:SetNextMeleeTime(CurTime() + hitDuration)

        if IsFirstTimePredicted() then
            self:PlayViewModelAnimation("Melee_Hit")
        end

        self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.HoldTypes[self.HoldType].Melee or ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2)
        self:EmitSound("weapons/knife/knife_slash1.wav")
    else
        local missDuration = self:GetAnimLength("Melee", self.Animations["Melee"].Length or 0.5) + 0.3
        self:SetNextMeleeTime(CurTime() + missDuration)

        if IsFirstTimePredicted() then
            self:PlayViewModelAnimation("Melee")
        end

        self:PlayerGesture(GESTURE_SLOT_ATTACK_AND_RELOAD, self.HoldTypes[self.HoldType].Melee or ACT_HL2MP_GESTURE_RANGE_ATTACK_MELEE2)
        self:EmitSound("weapons/knife/knife_slash2.wav")
    end

    timer.Simple(meleeDuration, function()
        if IsValid(self) and IsValid(self:GetOwner()) then
            local ply = self:GetOwner()
            ply:SetWalkSpeed(ply:GetInfoNum("cl_forwardspeed", 150))
            ply:SetRunSpeed(ply:GetInfoNum("cl_sidespeed", 150))
            self:SetNWFloat("MeleeLockTime", 0)
        end
    end)
end

function SWEP:MeleeBehaviourModule()
    if game.SinglePlayer() and CLIENT then return end

    if (self:GetOwner():KeyDown(IN_USE) or self.Melee) and self:GetOwner():KeyPressed(IN_ATTACK) then
        self:SetSafety(false)
        self:SetShouldHoldType(true)
        if self:CanMelee() and CurTime() > self:GetNextMeleeTime() then
            self:DoMelee()
        end
    end
end

if CLIENT then
    hook.Add("StartCommand", "MeleeSlowCommand", function(ply, cmd)
        if not IsValid(ply) then return end
        local wep = ply:GetActiveWeapon()
        if not IsValid(wep) then return end

        local lockTime = wep:GetNWFloat("MeleeLockTime", 0)
        if lockTime > CurTime() then
            cmd:SetForwardMove(cmd:GetForwardMove() * 0.3)
            cmd:SetSideMove(cmd:GetSideMove() * 0.3)
        end
    end)
end