-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\client\\cl_viewmodel_blur.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()

function SWEP:ViewModelBlurModule()
    if (!IsValid(self:GetOwner())) then
        return
    end

    local bPixelShaders2 = render.SupportsPixelShaders_2_0()

    if (!bPixelShaders2) then
        return
    end

   -- self:ViewBlur()
end

function SWEP:ViewBlur()
end