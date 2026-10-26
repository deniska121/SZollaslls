if SERVER then
	local newHealth = 7500

	local function tweakVehicle(ent)
		if not IsValid(ent) then return end
		if ent:GetClass() != "gmod_sent_vehicle_fphysics_base" then return end

		ent:SetMaxHealth(newHealth)
		ent:SetHealth(newHealth)
		ent.m_iHealth = newHealth
		ent.Health = newHealth
		ent:SetNWInt("MaxHealth", newHealth)
		ent:SetNWInt("Health", newHealth)

		if ent.VehicleTable and ent.VehicleTable.Members then
			ent.VehicleTable.Members.MaxHealth = newHealth
			ent.VehicleTable.Members.Health = newHealth
		end
	end

	local function applyToAll()
		for _, ent in ipairs(ents.FindByClass("gmod_sent_vehicle_fphysics_base")) do
			tweakVehicle(ent)
		end
	end

	hook.Add("PlayerSpawnedVehicle", "simfphys_tweak", function(ply, ent)
		local delays = {0.1, 0.5, 1, 2, 3, 5}
		for _, d in ipairs(delays) do
			timer.Simple(d, function() if IsValid(ent) then tweakVehicle(ent) end end)
		end
	end)

	hook.Add("PostEntitySpawn", "simfphys_tweak_spawn", function(ent)
		if ent:GetClass() == "gmod_sent_vehicle_fphysics_base" then
			local delays = {0.1, 0.5, 1, 2, 3, 5}
			for _, d in ipairs(delays) do
				timer.Simple(d, function() if IsValid(ent) then tweakVehicle(ent) end end)
			end
		end
	end)

	timer.Simple(0.5, applyToAll)
	timer.Simple(1, applyToAll)
end