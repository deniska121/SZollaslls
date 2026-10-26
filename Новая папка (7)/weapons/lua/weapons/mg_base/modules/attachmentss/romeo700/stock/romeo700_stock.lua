-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\romeo700\\stock\\romeo700_stock.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_stock"
ATTACHMENT.Model = Model("models/noire/700.mdl")

function ATTACHMENT:OverrideMaterial(path, mat, weapon)
	if weapon:HasAttachment("romeo700_scope") and mat == "nam_m40" then return path, "nam_m40a1" end
	return path, mat
end