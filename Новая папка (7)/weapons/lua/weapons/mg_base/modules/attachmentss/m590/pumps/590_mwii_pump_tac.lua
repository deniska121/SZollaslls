-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\attachmentss\\m590\\pumps\\590_mwii_pump_tac.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ATTACHMENT.Base = "att_pump"
ATTACHMENT.Model = Model("models/590_dqr/weapon_mossberg_590a1_12g_bolt_lod0_def.mdl")

function ATTACHMENT:OverrideMaterial(path, mat)
	if mat == "handguard_590_mossberg_590a1_std_lod0" then
		return "m590_dqr/", "handguard_590_mossberg_590a1_std_red"
	end

	return path, mat
end