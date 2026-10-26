-- "addons\\mc_phone\\lua\\mc_phone\\sh_language.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
-- DO NOT EDIT ANYTHING HERE, UNLESS YOU KNOW WHAT YOU ARE DOING
local files = file.Find("mc_phone/language/*", "LUA")

for k, v in pairs(files) do
    if (SERVER) then
        include("mc_phone/language/" .. v)
        AddCSLuaFile("mc_phone/language/" .. v)
        MsgC(Color(0, 0, 255), "[McPhone] " .. v .. " language found\n")
    else
        include("mc_phone/language/" .. v)
    end
end

function McPhone.GetPhrase(name, ...)
   -- local lang = McPhone.Language[McPhone.Config.Language] or McPhone.Language["ru"]
    local lang = McPhone.Language["ru"]
    local prase = lang[name]

    if not prase then
        prase = McPhone.Language["en"][name]
    end

    if not prase then return name end

    return string.format(prase, ...)
end