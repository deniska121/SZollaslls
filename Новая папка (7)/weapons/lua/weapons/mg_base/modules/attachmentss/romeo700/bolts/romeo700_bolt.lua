-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo700\\bolts\\romeo700_bolt.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_bolt"
ATTACHMENT.Model = Model("models/noire/700bolt.mdl")

ATTACHMENT.Bodygroups = {
	["sight"] = 2
}

function ATTACHMENT:OverrideWeaponMaterial(path, mat)
	return "", "null"
end