--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/entities/pill_attachment_zed.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"

function ENT:Initialize()
    self:AddCallback("BuildBonePositions", self.BoneItUp)

    if SERVER then
        self:AddEffects(bit.bor(EF_BONEMERGE, EF_BONEMERGE_FASTCULL)) --fastcull seems to fix laggy bullshit garbage
    end

    self:GetParent():SetSubMaterial(0, "models/effects/vol_light001")
end

function ENT:BoneItUp(boneCount)
    local boneId = self:LookupBone("ValveBiped.Bip01_Head1")
    if not boneId then return end
    local matrix = self:GetBoneMatrix(boneId)
    if not matrix then return end
    matrix:Scale(Vector(.01, .01, .01))
    self:SetBoneMatrix(boneId, matrix)
end
