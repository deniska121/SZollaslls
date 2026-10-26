-- "addons\\weapons\\lua\\entities\\mg_slug\\cl_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
include("shared.lua")

local base = baseclass.Get(ENT.Base)

function ENT:DrawTracer()
    if (GetViewEntity() == self:GetOwner()) then
        base.DrawTracer(self)
    end
end