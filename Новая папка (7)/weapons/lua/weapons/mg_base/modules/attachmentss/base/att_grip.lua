-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\base\\att_grip.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_base"
ATTACHMENT.Name = "Default"
ATTACHMENT.Category = "Рукоятки"

function ATTACHMENT:ChangeRecoil(var, mul)
    return var < 0 && var / mul || var * mul
end