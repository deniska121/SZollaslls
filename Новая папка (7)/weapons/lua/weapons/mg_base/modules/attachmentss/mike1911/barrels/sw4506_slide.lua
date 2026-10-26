-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\mike1911\\barrels\\sw4506_slide.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_barrel"
ATTACHMENT.Model = Model("models/viper/mw/attachments/sw4506_slide_v2.mdl")
ATTACHMENT.Name = "S&W 4506"
local BaseClass = GetAttachmentBaseClass(ATTACHMENT.Base)

ATTACHMENT.ExcludedCategories = {"Дуло"}

function ATTACHMENT:Stats(weapon)
	BaseClass.Stats(self, weapon)
	weapon.Primary.Sound = Sound("MW19_SW659.Fire")
	weapon.PrintName = "S&W 4506"

	weapon.UseMags = {
		["1911_7"] = {1, 3},
	}
end

ATTACHMENT.CosmeticChange = true