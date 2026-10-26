-- "addons\\weapons\\lua\\autorun\\mw_loader.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
local function IncludeDir(dir)
	dir = dir .. "/"
	local File, Directory = file.Find(dir .. "*", "LUA")

	for k, v in ipairs(File) do
		if string.EndsWith(v, ".lua") then
			AddCSLuaFile(dir .. v)
			include(dir .. v)
		end
	end

	for k, v in ipairs(Directory) do
		IncludeDir(dir .. v)
	end
end

CHAN_ATMO = 137
CHAN_REFLECTION = 138
CHAN_CASINGS = 139
CHAN_TRIGGER = 140
CHAN_MINIGUNFIRE = 141
CHAN_MAGAZINEDROP = 142
CHAN_WPNFOLEY = 143

IncludeDir("weapons/mg_base/modules/sounds")

local function safeInclude(f)
	AddCSLuaFile(f)
	include(f)

	return true
end

MW_ATTS = {}
MW_CASES = {}
MW_FACATTS = {
	["attachment_vm_pi_mike_barrel"]  = true,
	["attachment_vm_pi_mike_barsil"]  = true,
	["attachment_vm_pi_mike_barlight"]  = true,
	["attachment_vm_pi_mike_barauto"]  = true,
	["attachment_vm_sm_augolf_arbarrel"]  = true,
	["attachment_vm_sm_augolf_lmgbarrel"]  = true,
	["attachment_vm_sm_augolf_smgbarrel"]  = true,
	["att_vm_pi_cpapa_barrel01"]  = true,
	["att_vm_pi_cpapa_barrel_long"]  = true,
	["att_vm_pi_cpapa_barrel_short"]  = true,
	["attachment_vm_ar_akilo47_lmgstock"]  = true,
	["attachment_vm_ar_akilo47_smgstock_unfolded"]  = true,
	["attachment_vm_ar_akilo47_smgstock"]  = true,
	["attachment_vm_ar_akilo47_stockno"]  = true,
	["attachment_vm_ar_akilo47_custombarrel"]  = true,
	["attachment_vm_ar_akilo47_lmgbarrel_grip"]  = true,
	["attachment_vm_ar_akilo47_lmgbarrel"]  = true,
	["attachment_vm_ar_akilo47_smgbarcust"]  = true,
	["attachment_vm_ar_akilo47_bolt"]  = true,
	["attachment_vm_ar_akilo47_stock"]  = true,
	["attachment_vm_ar_akilo47_barrel"]  = true,
	["attachment_vm_ar_akilo74_stock"]  = true,
	["attachment_vm_ar_akilo74"]  = true,
	["attachment_vm_pi_mike_stockl"]  = true,
	["attachment_vm_pi_mike_stockh"]  = true,
	["att_bolt"]  = true,
	["ar15_bolt"]  = true,
	["attachment_vm_ar_mike16_bolt"]  = true,
	["attachment_vm_ar_mike4_bolt"]  = true,
	["attachment_vm_sh_charlie725_barrel"]  = true,
	["attachment_vm_sh_charlie725_barrel_sawnoff"]  = true,
	["attachment_vm_sh_charlie725_barrel_mid"]  = true,
	["attachment_vm_sh_charlie725_barrel_long"]  = true,
	["attachment_vm_sh_charlie725_stock"]  = true,
	["attachment_vm_sh_charlie725_stocklight"]  = true,
	["attachment_vm_sh_charlie725_stock_sawnoff"]  = true,
	["attachment_vm_sh_charlie725_stocktactical"]  = true,
	["att_reargrip_golf"]  = true,
	["att_vm_pi_golf18_slide_light"]  = true,
	["att_vm_pi_golf18_slide"]  = true,
	["att_vm_pi_golf21_receiver_v1"]  = true,
	["att_vm_pi_golf21_slide_long"]  = true,
	["attachment_vm_ar_mike4_stockno"]  = true,
	["attachment_vm_ar_mike4_stock_def"]  = true,
	["attachment_vm_ar_mike4_stock_v2"]  = true,
	["attachment_vm_sm_mpapa5_receiver"]  = true,
	["attachment_vm_sm_mpapa5_receiver_v2"]  = true,
	["attachment_vm_sm_mpapa5_barrel_suppressor"]  = true,
	["attachment_vm_sm_mpapa5_barrel"]  = true,
	["attachment_vm_sm_mpapa5_stock_fullstock"]  = true,
	["attachment_vm_sm_mpapa5_stock_nostock"]  = true,
	["attachment_vm_sm_mpapa5_stock"]  = true,
	["attachment_vm_ar_mike4_stock"]  = true,
	["attachment_vm_ar_mike4_customstock"]  = true,
	["attachment_vm_ar_mike4_barrel_def"]  = true,
	["attachment_vm_ar_mike4_barrel_v2"]  = true,
	["attachment_vm_ar_mike4_shortbarrel"]  = true,
	["attachment_vm_ar_mike4_barrel_v3_alt"]  = true,
	["attachment_vm_ar_mike4_barrel"]  = true,
	["attachment_vm_ar_mike4_barsil"]  = true,
	["attachment_vm_ar_mike4_custombarrel"]  = true,
	["attachment_vm_ar_mike4_receiver_def"]  = true,
	["attachment_vm_ar_mike4_receiver_black"]  = true,
	["attachment_vm_ar_scharlie_barrel"]  = true,
	["attachment_vm_ar_scharlie_barrel_pdw"]  = true,
	["attachment_vm_ar_scharlie_barrel_mid"]  = true,
	["attachment_vm_ar_scharlie_barrel_long"]  = true,
	["attachment_vm_ar_scharlie_stock"]  = true,
	["attachment_vm_ar_scharlie_stock_light"]  = true,
	["attachment_vm_ar_scharlie_stock_dmr"]  = true,
	["attachment_vm_sn_sbeta_barrel"]  = true,
	["attachment_vm_sn_sbeta_barshort"]  = true,
	["attachment_vm_sn_sbeta_barmid"]  = true,
	["attachment_vm_sn_sbeta_barlong"]  = true,
	["mac_longmuz_mac10"]  = true,
	["att_grip_mac10"]  = true,
	["attachment_vm_pi_tec9_bolt"]  = true,
	["mac_grip_mac10"]  = true,
	["pump_wood_2"]  = true,
	["590_eft_pump_590def"]  = true,
	["590_eft_pump_870def"]  = true,
	["590_eft_pump_590_wood"]  = true,
	["m500_stock"]  = true,
	["magpul_sga_stock"]  = true,
	["mwii_590_no_stock"]  = true,
	["590_eft_barrel"]  = true,
	["590_eft_barrel_v1"]  = true,
	["590_eft_barrel_v3"]  = true,
	["590_eft_barrel_v4"]  = true,
	["590_mwii_barrel_v1"]  = true,
	["590_mwii_barrel_v2"]  = true,
	["590_mwii_barrel_v3"]  = true,
	["590_eft_barrel_fg"]  = true,
	["590_eft_barrel_1897"]  = true,
	["attachment_sh_t9semiauto_stock"]  = true,
	["attachment_sh_t9semiauto_mixstock01"]  = true,
	["attachment_sh_t9semiauto_nostock"]  = true,
	["attachment_sh_t9semiauto_stalkerstock01"]  = true,
	["attachment_vm_sm_uzulu_stock"]  = true,
	["attachment_vm_sm_uzulu_stockh"]  = true,
	["attachment_vm_sm_uzulu_stock_folded"]  = true,
	["vm_thotel_stock_00"]  = true,
	["vm_thotel_stock_hv_00"]  = true,
	["vm_thotel_fg_00"]  = true,
	["vm_sm_thotel_angled_00"]  = true,
	["vm_thotel_barrel_00"]  = true,
	["vm_thotel_barrel_l_00"]  = true,
}

function GetAttachmentBaseClass(base)
	MW_ATTS[base] = MW_ATTS[base] or {}

	return MW_ATTS[base]
end

function LoadAttachment(path, fileName)
	ATTACHMENT = {}
	safeInclude(path .. fileName)
	local name = string.Replace(fileName, ".lua", "")
	ATTACHMENT.ClassName = name
	ATTACHMENT.Folder = path
	table.Merge(GetAttachmentBaseClass(name), table.Copy(ATTACHMENT))
end

local function loadAttachments(dir)
	dir = dir .. "/"
	local File, Directory = file.Find(dir .. "*", "LUA")

	for k, v in ipairs(File) do
		if (string.EndsWith(v, ".lua")) then
			LoadAttachment(dir, v)
		end
	end

	for k, v in ipairs(Directory) do
		loadAttachments(dir .. v)
	end
end

loadAttachments("weapons/mg_base/modules/attachmentss")

local function checkBaseClassInAttachments()
	for name, att in pairs(MW_ATTS) do
		if (istable(name)) then
			MW_ATTS[name] = nil
		end

		if (name ~= "att_base") then
			if (att.Base == nil) then
				MW_ATTS[name] = nil
			end

			if (att.Base == name) then
				MW_ATTS[name] = nil
			end

			if (MW_ATTS[att.Base] == nil) then
				MW_ATTS[name] = nil
			end
		end
	end
end

checkBaseClassInAttachments()

local function inherit(current, base)
	for k, v in pairs(base) do
		if (not istable(v)) then
			if (current[k] == nil) then
				current[k] = v
			end
		else
			if (current[k] == nil) then
				current[k] = {}
			end

			inherit(current[k], v)
		end
	end
end

function DoAttachmentInheritance(att)
	local baseClass = MW_ATTS[att.Base]

	while (baseClass ~= nil) do
		inherit(att, baseClass)
		baseClass = MW_ATTS[baseClass.Base]
	end
end

local function finishAttachments()
	for name, att in pairs(MW_ATTS) do
		DoAttachmentInheritance(att)
	end
end
finishAttachments()

hook.Call("MW19_OnAssetsLoaded")