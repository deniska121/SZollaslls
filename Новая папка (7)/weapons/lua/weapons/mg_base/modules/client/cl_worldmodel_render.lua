AddCSLuaFile()

local function LookupBoneCached(ent, boneName)
    if (not IsValid(ent)) then return nil end
    if (ent.cachedBones == nil) then
        ent.cachedBones = {}
    end
    if (ent.cachedBones[boneName] == nil) then
        ent.cachedBones[boneName] = ent:LookupBone(boneName)
    end
    return ent.cachedBones[boneName]
end

function SWEP:RenderOverride(flags)
    if (IsValid(self.SpawnEffect)) then
        timer.Simple(0, function()
            if IsValid(self.SpawnEffect) then
                self.SpawnEffect:Remove()
            end
        end)
    end

    local hasReceiverAttachment = false
    local hasStockAttachment = false
    local receiverAtt = nil
    local stockAtt = nil
    
    for _, att in pairs(self:GetAllAttachmentsInUse()) do
        if (att.IsReceiverOverride or att.ReceiverOverride or att.Category == "Receiver" or att.Category == "Reciever") then
            hasReceiverAttachment = true
            receiverAtt = att
        end
        if (att.Category == "Stock" or att.IsStockOverride or att.StockOverride) then
            hasStockAttachment = true
            stockAtt = att
        end
    end

    -- ЕСЛИ ЕСТЬ ЗАМЕНА РИСИВЕРА - СКРЫВАЕМ ОРИГИНАЛЬНЫЙ РИСИВЕР
    if (hasReceiverAttachment and IsValid(self.m_WorldModel)) then
        local receiverBone = self:LookupBoneCached(self.m_WorldModel, "receiver") or 
                             self:LookupBoneCached(self.m_WorldModel, "Receiver") or
                             self:LookupBoneCached(self.m_WorldModel, "body") or
                             self:LookupBoneCached(self.m_WorldModel, "Body")
        if (receiverBone ~= nil and receiverBone > 0) then
            self.m_WorldModel:ManipulateBoneScale(receiverBone, Vector(0,0,0))
        end
    end

    -- ЕСЛИ ЕСТЬ ЗАМЕНА ПРИКЛАДА - СКРЫВАЕМ ОРИГИНАЛЬНЫЙ ПРИКЛАД
    if (hasStockAttachment and IsValid(self.m_WorldModel)) then
        local stockBone = self:LookupBoneCached(self.m_WorldModel, "stock") or 
                          self:LookupBoneCached(self.m_WorldModel, "Stock")
        if (stockBone ~= nil and stockBone > 0) then
            self.m_WorldModel:ManipulateBoneScale(stockBone, Vector(0,0,0))
        end
    end

    -- ЕСЛИ ЕСТЬ ЗАМЕНА РИСИВЕРА - РЕНДЕРИМ ТОЛЬКО АТТАЧМЕНТЫ (БЕЗ ОСНОВНОЙ МОДЕЛИ)
    if (hasReceiverAttachment and IsValid(self.m_WorldModel)) then
        for _, att in pairs(self:GetAllAttachmentsInUse()) do
            if (IsValid(att.m_TpModel) and not att.DisableWorldModelRender) then
                if (not IsValid(att.m_TpModel:GetParent()) or att.m_TpModel:GetParent() != self) then
                    att.m_TpModel:SetParent(self)
                    att.m_TpModel:AddEffects(EF_BONEMERGE)
                    att.m_TpModel:AddEffects(EF_BONEMERGE_FASTCULL)
                    att.m_TpModel:AddEffects(EF_PARENT_ANIMATES)
                    att.m_TpModel:AddEffects(EF_NOINTERP)
                end
                
                att.m_TpModel:SetupBones()
                
                if (att.Camo and att.Camo ~= "") then
                    local camoMat = Material(att.Camo, "smooth")
                    if (camoMat) then
                        att.m_TpModel:SetMaterial(camoMat)
                    end
                end
                
                att.m_TpModel:DrawModel(flags)

                if ((not att.RenderOverride and att.Render != nil) or att.WorldModelRender != nil) then
                    if (att.WorldModelRender != nil) then
                        att:WorldModelRender(self)
                    else
                        att:Render(self, att.m_TpModel)
                    end
                end
            end
        end
        
        self:RenderParticles(self.TpParticles)
        return
    end

    local bone = LookupBoneCached(self, self.WorldModelOffsets.Bone)

    if (bone != nil and bone > 0) then
        if (IsValid(self:GetOwner())) then
            self:ManipulateBoneAngles(bone, self.WorldModelOffsets.Angles)
            self:ManipulateBonePosition(bone, self.WorldModelOffsets.Pos)
        else
            self:ManipulateBoneAngles(bone, Angle(0,0,0))
            self:ManipulateBonePosition(bone, Vector(0,0,0))
        end
    end

    self:SetupBones()
    self:DrawModel(flags)

    for _, att in pairs(self:GetAllAttachmentsInUse()) do
        if (IsValid(att.m_TpModel) and not att.DisableWorldModelRender) then
            if (not IsValid(att.m_TpModel:GetParent()) or att.m_TpModel:GetParent() != self) then
                att.m_TpModel:SetParent(self)
                att.m_TpModel:AddEffects(EF_BONEMERGE)
                att.m_TpModel:AddEffects(EF_BONEMERGE_FASTCULL)
                att.m_TpModel:AddEffects(EF_PARENT_ANIMATES)
                att.m_TpModel:AddEffects(EF_NOINTERP)
            end
            
            att.m_TpModel:SetupBones()
            
            if (att.Camo and att.Camo ~= "") then
                local camoMat = Material(att.Camo, "smooth")
                if (camoMat) then
                    att.m_TpModel:SetMaterial(camoMat)
                end
            end
            
            att.m_TpModel:DrawModel(flags)

            if ((not att.RenderOverride and att.Render != nil) or att.WorldModelRender != nil) then
                if (att.WorldModelRender != nil) then
                    att:WorldModelRender(self)
                else
                    att:Render(self, att.m_TpModel)
                end
            end
        end
    end

    if (IsValid(self.m_WorldModel)) then
        if (self.Camo and self.Camo ~= "") then
            local camoMat = Material(self.Camo, "smooth")
            if (camoMat) then
                self.m_WorldModel:SetMaterial(camoMat)
            end
        end
        
        for i = 0, self.m_WorldModel:GetNumBodyGroups() - 1 do
            local bgName = self.m_WorldModel:GetBodygroupName(i)
            for _, att in pairs(self:GetAllAttachmentsInUse()) do
                if (att.AttachmentBodygroups and att.AttachmentBodygroups[bgName] != nil) then
                    self.m_WorldModel:SetBodygroup(i, att.AttachmentBodygroups[bgName])
                end
            end
        end
    end

    self:RenderParticles(self.TpParticles)
end

function SWEP:DrawWorldModel(flags)
    self:DrawModel(flags)
end

function SWEP:DrawWorldModelTranslucent(flags)
    self:DrawWorldModel(flags)
end