--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/carradio/lua/wcarradio/cl_carstereo.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local function Media_Stop(media)
	if media.Stop then
		media:Stop()
	else
		media:stop()
	end
end

local function Media_SetVolume(media, vol)
	if media.SetVolume then
		media:SetVolume(vol)
	else
		media:setVolume(vol * 0.5)
	end
end

local Entity = FindMetaTable("Entity")
-- Potential Car Set
-- Set of cars that can play music and can potentially be heard by localplayer
local PCS = wyozicr._PCS or {}
wyozicr._PCS = PCS

function Entity:WCR_RadioStop()
	if not self.WCR_Player then return end
	Media_Stop(self.WCR_Player)
	self.WCR_Player = nil
	self.WCR_PlayerCreated = nil
end

local cvar_debugpcs = CreateConVar("wyozicr_debugpcs", "0")

cvars.AddChangeCallback("wyozicr_debugpcs", function(a, b, c)
	if c == "1" then
		hook.Add("HUDPaint", "WCR_PCSDebugPaint", function()
			local i = 0

			for car, _ in pairs(PCS) do
				draw.SimpleText(tostring(car) .. ": " .. tostring(car.WCR_Player), "DermaDefaultBold", 10, 150 + i * 20, Color(255, 255, 255))
				i = i + 1
			end
		end)
	else
		hook.Remove("HUDPaint", "WCR_PCSDebugPaint")
	end
end, "debugpaint")

local function IsInRoom(pos1, pos2)
	local tracedata = {}
	tracedata.start = pos1 or pos2
	tracedata.endpos = pos1
	local trace = util.TraceLine(tracedata)

	return not trace.HitWorld
end

function Entity:WCR_RadioThink(isLocalCar, isThirdperson)
	local car = self

	if not IsValid(car) or car:IsDormant() then
		car:WCR_RadioStop()
		return
	end

	local isPlaying = IsValid(car.WCR_Player)
	local shouldPlay = car:WCR_HasRadioCapability()
	local station = car:WCR_GetChannel()
	local stat = wyozicr.AllStations and wyozicr.AllStations[station]
	local isWDJ = stat and stat.WDJ_Channel ~= nil
	local url = stat and stat.Link

	-- Make sure we're not trying to play nil
	if (not url or url == "") and (not stat or not stat.WDJ_Channel) then
		shouldPlay = false
		PCS[car] = nil

		if cvar_debugpcs:GetBool() then
			print(car, " nil url; PCS removed")
		end
	end

	-- If we're not sitting inside the car, need to do some additional checks to
	-- check if we really should play radio
	if not isLocalCar and shouldPlay then
		local carpos = car:LocalToWorld(car:OBBCenter())
		local req_dist = car:GetNW2Int("radio_dist", 512)

		local play_outside = not isWDJ and carpos:DistToSqr(LocalPlayer():EyePos()) < req_dist ^ 2 and IsInRoom(LocalPlayer():GetShootPos(), carpos)

		if not play_outside then
			shouldPlay = false
		end
	end

	-- shouldPlay cannot change after this point
	-- if it's false, terminate early
	if not shouldPlay then
		if isPlaying then
			car:WCR_RadioStop()
		end

		return
	end

	-- Check if URL has changed. WDJ media needs some extra magic code to work
	local hasUrlChanged = car.WCR_Url ~= url

	if isWDJ then
		local master = wdj.GetMaster(stat.WDJ_Channel)
		hasUrlChanged = IsValid(master) and (not IsValid(car.WCR_Player) or type(car.WCR_Player) ~= "table" or car.WCR_Player:getUrl() ~= master:GetCurMedia())
	end

	local should3D = not isLocalCar or isThirdperson
	local has3DChanged = not isWDJ and IsValid(car.WCR_Player) and car.WCR_Player:Is3D() ~= should3D

	if isPlaying and not shouldPlay then
		MsgN("[WyoziCR] Stopping #" .. station .. " (car: " .. tostring(car) .. " - url: " .. tostring(stereourl) .. ")")
		car:WCR_RadioStop()
	elseif shouldPlay and (hasUrlChanged or has3DChanged or not isPlaying) and not car.WCR_StartingStereo then
		local only3DChanged = has3DChanged and not hasUrlChanged and isPlaying

		if IsValid(car.WCR_Player) and not only3DChanged then
			car:WCR_RadioStop()
		end

		if isWDJ then
			local master = wdj.GetMaster(stat.WDJ_Channel)

			if IsValid(master) then
				local link = master:GetCurMedia()

				if link ~= "" and link ~= "--loading" then
					MsgN(string.format("[WyoziCR] Loading WDJ station #%d (car: %s - url: %s)", station, tostring(car), tostring(url)))
					local elapsed = CurTime() - (master:GetCurMediaStarted() or CurTime())
					local service = wdj.medialib.load("media").guessService(link)
					local mediaclip = service:load(link)
					mediaclip:seek(elapsed)
					mediaclip:play()
					car.WCR_Player = mediaclip
					car.WCR_PlayerCreated = CurTime()
					car.WCR_Url = nil
				end
			end
		else
			if hasUrlChanged then
				car.WCR_PlayAttempts = 0
			end

			if car.WCR_PlayAttempts >= 2 then return end
			MsgN(string.format("[WyoziCR] Loading station #%d (car: %s - url: %s)", station, tostring(car), tostring(url)))
			car.WCR_StartingStereo = true
			car.WCR_Url = url

			sound.PlayURL(url, "3d", function(chan, err, errstr)
				if IsValid(car.WCR_Player) and only3DChanged then
					car:WCR_RadioStop()
				end

				if not IsValid(chan) then
					MsgN(string.format("[WyoziCR] Loading stream failed: %s", errstr))
					car.WCR_PlayAttempts = (car.WCR_PlayAttempts or 0) + 1
					car.WCR_StartingStereo = false

					return
				end

				if not IsValid(car) then
					MsgN("[WyoziCR] Associated car removed during stream load")
					chan:Stop()

					return
				end
				car.WCR_StartingStereo = false
				car.WCR_Player = chan
				car.WCR_PlayerCreated = CurTime()
				car.WCR_PlayAttempts = 0
			end)
		end
	end

	if IsValid(car.WCR_Player) then
		local volumemul = 3

		-- if BASS, we need to set position
		if not isWDJ then
			if car.WCR_Player:Is3D() then
				if isLocalCar then
					car.WCR_Player:SetPos(LocalPlayer():EyePos())
					car.WCR_Player:Set3DFadeDistance(200, 1000000000)
				else
					local pos = car:LocalToWorld(car:OBBCenter())
					local req_dist = car:GetNW2Int("radio_dist", 512)
					car.WCR_Player:SetPos(pos)
					car.WCR_Player:Set3DFadeDistance(req_dist / 2, req_dist)
					local dist = pos:DistToSqr(LocalPlayer():EyePos())
					req_dist = req_dist ^ 2
					volumemul = volumemul * ((req_dist - dist) / req_dist)
				end
			else
				volumemul = volumemul * 0.5
			end
		end

		local vol = car:GetNW2Float("radio_vol", 0.3)
		vol = math.Clamp(vol * volumemul, 0, 3)
		Media_SetVolume(car.WCR_Player, vol)
	end
end

hook.Add("EntityNetworkedVarChanged", "WCR_RadioChangeListener", function(ent, name, oldval, newval)
	if name == "wcr_chan" then
		PCS[ent] = true

		if cvar_debugpcs:GetBool() then
			print(ent, " chanchange; PCS updated")
		end
	end
end)

hook.Add("NetworkEntityCreated", "WCR_PCSAdd", function(ent)
	if ent:WCR_IsCarEntity() then
		-- add entity to car think
		PCS[ent] = true

		if cvar_debugpcs:GetBool() then
			print(ent, " netentcreate; PCS updated")
		end
	end
end)

hook.Add("NotifyShouldTransmit", "WCR_PCSUpdater", function(ent, shouldTransmit)
	if ent:WCR_IsCarEntity() and shouldTransmit then
		PCS[ent] = true

		if cvar_debugpcs:GetBool() then
			print(ent, " NST; PCS updated")
		end
	end
end)

hook.Add("Think", "WCR_ActiveRadioUpdater", function()
	local localVeh = LocalPlayer():GetVehicle()
	localVeh = IsValid(localVeh) and localVeh:WCR_GetCarEntity()
	local isThirdperson = IsValid(localVeh) and (not localVeh.GetThirdPersonMode or localVeh:GetThirdPersonMode())
	for car, _ in pairs(PCS) do
		local isLocalCar = localVeh == car
		car:WCR_RadioThink(isLocalCar, isThirdperson)
	end
end)

hook.Add("EntityRemoved", "WCR_RadioCleanup", function(ent)
	if IsValid(ent.WCR_Player) then
		Media_Stop(ent.WCR_Player)
	end
end)