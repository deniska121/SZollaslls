if SERVER then
	util.AddNetworkString("PlayDistSound")
	util.AddNetworkString("RequestDistSound")
	
	net.Receive("RequestDistSound", function(len, ply)
		local soundPath = net.ReadString()
		local pos = net.ReadVector()
		local dist = net.ReadFloat()
		local volume = net.ReadFloat()
		local isLocal = net.ReadBool()
		
		net.Start("PlayDistSound")
			net.WriteString(soundPath)
			net.WriteVector(pos)
			net.WriteFloat(dist)
			net.WriteFloat(volume)
			net.WriteBool(isLocal)
			net.WriteEntity(ply)
		net.Broadcast()
	end)
	
else
	local DistSoundData = {
		["Reflection_Pistol.Distance"] = {
			Outside = {
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_01.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_02.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_03.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_04.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_05.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_ext_dist_lr_06.ogg",
			},
			Inside = {
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_int_01.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_int_02.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_int_03.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_int_04.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_int_05.ogg",
				"viper/shared/reflection/pistol/weap_pist_ref_urb/weap_refl_pistol_urb_int_06.ogg",
			},
			Dist = 50000,
			MinDist = 1500,
		},
		["Reflection_AR.Distance"] = {
			Outside = {
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_01.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_02.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_03.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_04.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_05.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_06.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_07.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_ext_dist_lr_08.ogg",
			},
			Inside = {
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_01.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_02.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_03.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_04.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_05.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_06.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_07.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_ar_urb_int_08.ogg",
			},
			Dist = 70000,
			MinDist = 2000,
		},
		["Reflection_AR.Sup.Distance"] = {
			Outside = {
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_01.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_02.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_03.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_04.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_05.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_ext_dist_lr_06.ogg",
			},
			Inside = {
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_int_01.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_int_02.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_int_03.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_int_04.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_int_05.ogg",
				"viper/shared/reflection/ar/weap_refl_ar_urb/weap_refl_arsup_urb_int_06.ogg",
			},
			Dist = 50000,
			MinDist = 1500,
		},
		["Reflection_Sniper.Distance"] = {
			Outside = {
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_01.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_02.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_03.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_04.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_05.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_06.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_07.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_ext_dist_lr_08.ogg",
			},
			Inside = {
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_01.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_02.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_03.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_04.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_05.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_06.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_07.ogg",
				"viper/shared/reflection/sniper/weap_refl_sniper_urb/weap_refl_sniper_urb_int_08.ogg",
			},
			Dist = 90000,
			MinDist = 3000,
		},
		["Explosion_Medium"] = {
			Outside = {
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_01.ogg",
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_02.ogg",
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_03.ogg",
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_atmo_04.ogg",
			},
			Inside = {
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_int_01.ogg",
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_int_02.ogg",
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_int_03.ogg",
				"viper/shared/atmo/launchers/weap_rpapa7_fire_plr_int_04.ogg",
			},
			Dist = 130000,
			MinDist = 5000,
		},
	}

	local NO_DIST_SOUND_RADIUS = 2000

	local function IsOutside(ply)
		if not IsValid(ply) then return true end
		
		local start = ply:EyePos()
		
		local trace = util.TraceLine({
			start = start,
			endpos = start + Vector(0, 0, 99999),
			mask = MASK_SOLID_BRUSHONLY
		})
		
		if trace.HitSky or trace.HitNoDraw then return true end
		
		for r = 0.4, 0.2, -0.05 do
			local hCos = math.sin(r * math.pi)
			for i = -1, 1, 0.25 do
				local sin = math.sin(i * math.pi) * hCos
				local cos = math.cos(i * math.pi) * hCos
				local dir = Vector(sin, cos, math.cos(r * math.pi))
				local tr = util.TraceLine({
					start = start,
					endpos = start + dir * 99999,
					mask = MASK_SOLID_BRUSHONLY
				})
				if tr.HitSky or tr.HitNoDraw then return true end
			end
		end
		
		return false
	end

	local function RequestDistSound(soundPath, pos, dist, volume, isLocal)
		net.Start("RequestDistSound")
			net.WriteString(soundPath)
			net.WriteVector(pos)
			net.WriteFloat(dist)
			net.WriteFloat(volume)
			net.WriteBool(isLocal)
		net.SendToServer()
	end

	net.Receive("PlayDistSound", function()
		local soundPath = net.ReadString()
		local pos = net.ReadVector()
		local dist = net.ReadFloat()
		local volume = net.ReadFloat()
		local isLocal = net.ReadBool()
		local shooter = net.ReadEntity()
		
		local localPly = LocalPlayer()
		if not IsValid(localPly) then return end
		
		local distance = pos:Distance(localPly:GetPos())
		if distance > dist then return end
		if distance <= 15 then return end
		
		if isLocal and localPly == shooter then return end
		
		local minDist = DistSoundData[soundKey] and DistSoundData[soundKey].MinDist or 1500
		
		local finalVolume = volume
		
		if distance < minDist then
			local factor = distance / minDist
			finalVolume = volume * factor
			if finalVolume < 0.01 then return end
		end
		
		sound.PlayFile("sound/" .. soundPath, "3d noblock", function(station, errCode, errStr)
			if IsValid(station) then
				station:SetPos(pos)
				station:SetVolume(finalVolume)
				station:Set3DFadeDistance(1000, dist)
			end
		end)
	end)

	hook.Add("EntityFireBullets", "DistSoundOnShoot", function(attacker, data)
		if not IsValid(attacker) or not attacker:IsPlayer() then return end
		
		local ply = attacker
		local wep = ply:GetActiveWeapon()
		if not IsValid(wep) then return end
		
		local soundKey = wep.DistSound or wep.Reverb
		if not soundKey then return end
		
		local soundData = DistSoundData[soundKey]
		if not soundData then return end
		
		local pos = ply:GetPos()
		local distance = pos:Length() or 0
		
		if distance < NO_DIST_SOUND_RADIUS then return end
		
		local outside = IsOutside(ply)
		local soundList = outside and soundData.Outside or soundData.Inside
		if not soundList or #soundList == 0 then return end
		
		local soundPath = soundList[math.random(1, #soundList)]
		if not soundPath then return end
		
		local dist = soundData.Dist or 50000
		local volume = 5.4
		local isLocal = (ply == LocalPlayer())
		
		RequestDistSound(soundPath, pos, dist, volume, isLocal)
	end)

	function AddDistSound(key, data)
		DistSoundData[key] = data
	end
end