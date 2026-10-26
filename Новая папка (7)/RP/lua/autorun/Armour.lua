if SERVER then
    hook.Add("PlayerFootstep", "armor_footstep", function(ply)
        if IsValid(ply) and ply:Alive() and ply:Armor() > 0 then
            ply:EmitSound("player/sfx/step"..math.random(1,10)..".wav", 75, 100)
        end
    end)
end