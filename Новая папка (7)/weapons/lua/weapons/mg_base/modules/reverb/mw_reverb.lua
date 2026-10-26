AddCSLuaFile()

local dir = Vector(0, 0, 99999)
local REVERB_RESOLUTION = 0.25
local resolution = 1

function SWEP:IsOutside()
    if not IsValid(self:GetOwner()) then return true end

    local startpos = self:GetOwner():EyePos()
    local rays = {}

    local trace = {}
    trace.mask = MASK_SOLID_BRUSHONLY
    trace.start = startpos
    trace.endpos = trace.start + dir
    table.insert(rays, util.TraceLine(trace))

    if not rays[1].StartSolid and (rays[1].HitSky or rays[1].HitNoDraw) then return true end

    local lastr
    for r = 0.4, 0.2, (REVERB_RESOLUTION / resolution) * -0.5 do
        local hCos = math.sin(r * math.pi)
        for i = -1, 1, (REVERB_RESOLUTION / resolution) do
            if lastr and not rays[lastr].StartSolid and (rays[lastr].HitSky or rays[lastr].HitNoDraw) then return true end
            local sin = math.sin(i * math.pi) * hCos
            local cos = math.cos(i * math.pi) * hCos

            trace.endpos = startpos + Vector(sin, cos, math.cos(r * math.pi)) * 999999
            lastr = table.insert(rays, util.TraceLine(trace))
        end
    end

    return false
end

function SWEP:HandleReverb()
    if not IsValid(self:GetOwner()) or not IsFirstTimePredicted() then return end

    self:EmitSound(self.Primary.Sound)

    if self.Reverb == nil then return end
    local layer = ""
    local reflection = ""

    if self.Reverb.Sounds then
        local outside = self:IsOutside()

        if outside then
            layer = self.Reverb.Sounds.Outside.Layer
            reflection = self.Reverb.Sounds.Outside.Reflection
        else
            layer = self.Reverb.Sounds.Inside.Layer ~= nil and self.Reverb.Sounds.Inside.Layer or self.Reverb.Sounds.Inside
            reflection = self.Reverb.Sounds.Inside.Reflection ~= nil and self.Reverb.Sounds.Inside.Reflection or ""
        end

        if layer ~= "" then
            self:EmitSound(layer)
        end

        if reflection ~= "" then
            self:EmitSound(reflection)
        end
    end
end