-- "addons\\mc_phone\\lua\\mc_phone\\extentions\\sh_ep1_init.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--╔═╗╔═╦═══╦═══╦╗─────────────────╔╗──────────────────────────╔╗───╔╗───
--║║╚╝║║╔═╗║╔═╗║║────────────────╔╝╚╗─────────────────────────║║──╔╝║───
--║╔╗╔╗║║─╚╣╚═╝║╚═╦══╦═╗╔══╗╔══╦╗╠╗╔╬══╦═╗╔══╦╦══╦═╗─╔══╦══╦══╣║╔╗╚╗║───
--║║║║║║║─╔╣╔══╣╔╗║╔╗║╔╗╣║═╣║║═╬╬╬╣║║║═╣╔╗╣══╬╣╔╗║╔╗╗║╔╗║╔╗║╔═╣╚╝╝─║║───
--║║║║║║╚═╝║║──║║║║╚╝║║║║║═╣║║═╬╬╬╣╚╣║═╣║║╠══║║╚╝║║║║║╚╝║╔╗║╚═╣╔╗╗╔╝╚╗──
--╚╝╚╝╚╩═══╩╝──╚╝╚╩══╩╝╚╩══╝╚══╩╝╚╩═╩══╩╝╚╩══╩╩══╩╝╚╝║╔═╩╝╚╩══╩╝╚╝╚══╝──
--───────────────────────────────────────────────────║║─────────────────
--────────────────────────── By Mactavish ──────────────────────────────
McPhone.EP1 = McPhone.EP1 or {}

function McPhone.IsPlayerInBox(ply, vec1, vec2)
    local pos = ply:GetPos()
    local min = Vector(math.min(vec1.x, vec2.x), math.min(vec1.y, vec2.y), math.min(vec1.z, vec2.z))
    local max = Vector(math.max(vec1.x, vec2.x), math.max(vec1.y, vec2.y), math.max(vec1.z, vec2.z))

    if pos.z > max.z or pos.z < min.z then
        return false
    elseif pos.y > max.y or pos.y < min.y then
        return false
    elseif pos.x > max.x or pos.x < min.x then
        return false
    end

    return true
end