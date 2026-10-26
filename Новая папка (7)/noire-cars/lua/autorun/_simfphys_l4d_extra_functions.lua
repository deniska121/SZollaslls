if CLIENT and not file.Exists( "autorun/__simfphys_randys_extra_functions.lua", "LUA" ) then
    local convar = CreateClientConVar( "cl_l4d2simf_warn", "0", true, true )
    if convar:GetInt() == 0 then
        chat.AddText( Color( 150, 150, 255 ), "[Simfphys] L4D2 Vehicles: The shared functions addon is not installed! Please check the addon's required items. This message will not show up again" )
        convar:SetInt( 1 )
    end
end

--this code is reformatted by Redox on Discord, thank you Redox, very cool