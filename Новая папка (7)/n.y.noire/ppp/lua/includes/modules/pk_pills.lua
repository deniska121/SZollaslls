--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/ppp/lua/includes/modules/pk_pills.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
-- Module starts here... pk_pills.apply(ply, "rat", "force")
module("pk_pills", package.seeall)
-- Load files
file.CreateDir("pill_config")
local locked_perma = {}
local locked_game = {}

for k, v in pairs(util.KeyValuesToTable(file.Read("pill_config/permalocked.txt") or "")) do
	locked_perma[string.upper(k)] = v
end

-- Pack Registration
local packString = ""
local packs = {}
local currentPack

function packStart(name, id, icon)
	currentPack = {}
	currentPack.name = name
	currentPack.icon = icon or "icon16/pill.png"
	currentPack.headers = {}
	currentPack.items = {}
	table.insert(packs, currentPack)
	id = id:gsub("%W", "-"):lower()
	packString = packString .. id .. " "
end

function packRequireGame(name, id)
	--Assume server owners are not stupid.
	if CLIENT then
		if (id == -1) then
			table.insert(currentPack.headers, {
				type = "pill-info",
				heading = "Hello, World!",
				color = "#FF88FF",
				text = [[
				This pack requires content from the game ]] .. name .. [[, which does not appear to exist.
				You can try pretending that the game exists to fix this issue.
			]]
			})

			return
		end

		for _, v in pairs(engine.GetGames()) do
			if (v.depot == id) and not v.mounted then
				if v.installed then
					table.insert(currentPack.headers, {
						type = "pill-info",
						heading = "Warning!",
						color = "#C9B995",
						text = [[
							This pack requires content from the game ]] .. name .. [[, which appears to be installed but not mounted.
							You can mount the game using the gamepad icon in the bottom right corner of the main menu.
							You may need to restart the map or rejoin the server for this to work.
						]]
					})
				elseif v.owned then
					table.insert(currentPack.headers, {
						type = "pill-info",
						heading = "Warning!",
						color = "#C9B395",
						text = [[
							This pack requires content from the game ]] .. name .. [[, which you appear to own but is not installed.
							If you have issues with missing models or textures, install the game through Steam, then mount it through Gmod's main menu.
						]]
					})
				else
					table.insert(currentPack.headers, {
						type = "pill-info",
						heading = "Warning!",
						color = "#C99595",
						text = [[
							This pack requires content from the game ]] .. name .. [[, which you do not appear to own.
							You can buy it on Steam. If you <i>obtained</i> the content through other means, you can close this message.
						]]
					})
				end
			end
		end
	end
end

function hasPack(name)
	return table.HasValue(string.Explode(" ", packString), name)
end

function getPacks()
	return packString
end

-- Pill Registration
local forms = {}

function register(name, t)
	t.name = name

	if t.printName then
		table.insert(currentPack.items, {
			type = "pill",
			name = name,
			printName = t.printName
		})
	end

	if (t.sounds) then
		for _, s in pairs(t.sounds) do
			if (isstring(s)) then
				util.PrecacheSound(s)
			elseif (istable(s)) then
				for k, s2 in pairs(s) do
					if s2 == false then
						s[k] = nil
					else
						util.PrecacheSound(s2)
					end
				end
			end
		end
	end

	forms[name] = t
end

local function fixParent(name)
	local t = forms[name]
	local t_parent = forms[t.parent]

	if t_parent.parent then
		fixParent(t.parent)
	end

	t_parent = forms[t.parent]

	if t_parent then
		t_parent = table.Copy(t_parent)
		forms[name] = table.Merge(t_parent, t)
		t.parent = nil
	else
		print("Tried to inherit pill from non-existant '" .. t.parent .. "'. Make sure you register the parent first.")
	end
end

function getPillTable(typ)
	return forms[typ]
end

function getFormCount()
	return table.Count(forms)
end

function getRandomForm()
	local _, k = table.Random(forms)

	return k
end

hook.Add("Initialize", "pk_pill_finalize", function()
	for n, t in pairs(forms) do
		if t.parent then
			fixParent(n)
		end
	end
end)

-- Player to Pill Entity Mapping
function mapEnt(ply, ent)
	ply.pk_pill_ent = ent
end

function unmapEnt(ply, ent)
	if ply.pk_pill_ent == ent then
		ply.pk_pill_ent = nil
	elseif IsValid(ply.pk_pill_ent) then
		return ply.pk_pill_ent.formTable.type
	end
end

function getMappedEnt(ply)
	return ply.pk_pill_ent
end

--[[Darkrp shit

	local function init_darkrp()
		if !DarkRP.createJob then error("No DarkRP job creation function!") end
		local TEAM_PILL = DarkRP.createJob("Pill Merchant", {
			color = Color(80, 40, 120, 255),
			model = "models/player/soldier_stripped.mdl",
			description = "This guy sells pills.",
			weapons = {},
			command = "pillmerchant",
			max = 2,
			salary = GAMEMODE.Config.normalsalary,
			admin = 0,
			vote = false
		})

		for name,tbl in pairs(forms) do
			if !tbl.printName or darkrp_costs[name]==-1 then continue end

			local mdl=tbl.model
			if !mdl then
				local opts = tbl.options&&tbl.options()
				if opts then
					mdl=opts[1].model
				end
			end
			if !mdl then mdl = "models/props_junk/watermelon01.mdl" end

			DarkRP.createEntity(tbl.printName.." Pill", {
				ent = "pill_worldent",
				model = mdl,
				price = darkrp_costs[name] or 1000,
				max = 10,
				cmd = "buypill_"..name,
				pill = name,
				allowed = {TEAM_PILL}
			})
		end
	end

	if SERVER then
		hook.Add("Initialize","pk_pill_init_darkrp",function()
			if DarkRP then
				if !file.Exists("pill_config/darkrp_costs.txt","DATA") then
					darkrp_costs={}
					for n,t in pairs(forms) do
						if t.userSpawn or !t.printName then continue end
						darkrp_costs[n]=t.default_rp_cost||-1
					end
					file.Write("pill_config/darkrp_costs.txt",util.TableToKeyValues(darkrp_costs))
				else
					local readfile = file.Read("pill_config/darkrp_costs.txt")
					if readfile=="DISABLE" then return end

					darkrp_costs = util.KeyValuesToTable(file.Read("pill_config/darkrp_costs.txt"))
				end

				init_darkrp(darkrp_costs)
			end
		end)
	else
		net.Receive("pk_pill_init_darkrp", function( len, pl )
			darkrp_costs = net.ReadTable()
			init_darkrp(darkrp_costs)
		end)
	end
]]
-- Concommands, Convars, etc.
if SERVER then
	concommand.Add("pk_pill_apply", function(ply, cmd, args, str)
		apply(ply, args[1], "user", tonumber(args[2]))
	end)

	concommand.Add("pk_pill_restore", function(ply, cmd, args, str)
		restore(ply)
	end)

	concommand.Add("pk_pill_restore_force", function(ply, cmd, args, str)
		if not ply:IsSuperAdmin() then return end
		restore(ply, true)
	end)

	concommand.Add("pk_pill_spawnent", function(ply, cmd, args, str)
		if not ply:IsSuperAdmin() then return end
		local tr = ply:GetEyeTrace()
		local e = ents.Create("pill_worldent")
		e:SetPos(tr.HitPos + tr.HitNormal * 5)
		e:SetPillForm(args[1])
		e:Spawn()
	end)

	concommand.Add("pk_pill_morphgun_select", function(ply, cmd, args, str)
		if not ply:IsSuperAdmin() then return end
		local pill = args[1]
		local wep = ply:GetWeapon("pill_wep_morphgun")

		if not IsValid(wep) then
			wep = ply:Give("pill_wep_morphgun")
		end

		if not IsValid(wep) then return end
		ply:SelectWeapon("pill_wep_morphgun")
		wep:SetForm(pill)
	end)
end

-- Spawnmenu
if CLIENT then
	local icon_restricted = Material("icon16/lock.png")

	spawnmenu.AddContentType("pill", function(container, obj)
		if (not obj.name) then return end
		if (not obj.printName) then return end
		local icon = vgui.Create("ContentIcon", container)
		icon:SetContentType("pill")
		icon:SetName(obj.printName)
		icon:SetMaterial("pills/" .. obj.name .. ".png")

		icon.DoClick = function()
			RunConsoleCommand("pk_pill_apply", obj.name)
			surface.PlaySound("ui/buttonclickrelease.wav")
		end

		icon.OpenMenu = function(icon)
			local menu = DermaMenu()
			local formTable = getPillTable(obj.name)

			menu:AddOption("Copy Type to Clipboard", function()
				SetClipboardText(obj.name)
			end):SetImage("icon16/page_copy.png")

			if (formTable.options) then
				menu:AddOption("Use with Skin...", function()
					local pickerWindow = vgui.Create("DFrame")
					pickerWindow:SetSize(606, 400)
					pickerWindow:Center()
					pickerWindow:SetTitle("Pill Skin Picker")
					pickerWindow:SetVisible(true)
					pickerWindow:SetDraggable(true)
					pickerWindow:ShowCloseButton(true)
					pickerWindow:MakePopup()
					local picker = vgui.Create("DPanelSelect", pickerWindow)
					picker:SetPos(0, 24)
					picker:SetSize(606, 376)

					for n, opt in pairs(formTable.options()) do
						local mdl = opt.icon or opt.model or formTable.model
						local skin = opt.skin or formTable.skin or 0
						local icon = vgui.Create("SpawnIcon")
						icon:SetModel(mdl, skin)
						icon:SetSize(64, 64)
						icon:SetTooltip(mdl)

						function icon:OnMousePressed(code)
							if code == MOUSE_LEFT then
								RunConsoleCommand("pk_pill_apply", obj.name, n)
								pickerWindow:Close()
							end
						end

						picker:AddPanel(icon)
					end
				end):SetImage("icon16/palette.png")
			end

			if LocalPlayer():IsSuperAdmin() then
				menu:AddSpacer()

				if not formTable.userSpawn then
					menu:AddOption("Spawn to World", function()
						RunConsoleCommand("pk_pill_spawnent", obj.name)
					end):SetImage("icon16/pill_go.png")

					menu:AddOption("Use with Morphgun", function()
						RunConsoleCommand("pk_pill_morphgun_select", obj.name)
					end):SetImage("icon16/lightning_go.png")
				end

				if LocalPlayer():IsSuperAdmin() then
					if pk_pills._restricted[obj.name] then
						menu:AddOption("Remove Restriction", function()
							RunConsoleCommand("pk_pill_restrict", obj.name, "off")
						end):SetImage("icon16/lock_delete.png")
					else
						menu:AddOption("Restrict to Admins", function()
							RunConsoleCommand("pk_pill_restrict", obj.name, "on")
						end):SetImage("icon16/lock_add.png")
					end
				end
			end

			menu:Open()
		end

		icon.PaintOver = function(self, w, h)
			if pk_pills._restricted[obj.name] then
				surface.SetMaterial(icon_restricted)
				surface.DrawTexturedRect(self.Border + 8, self.Border + 8, 16, 16)
			end
		end

		if (IsValid(container)) then
			container:Add(icon)
		end

		return icon
	end)

	spawnmenu.AddContentType("pill-info", function(container, obj)
		if (not obj.text) then return end
		local html = vgui.Create("DHTML", container)
		html:SetSize(256, 256)
		html:SetAllowLua(true)
		html:SetHTML("<style>body {background-color: " .. (obj.color or "gray") .. "; font-family: ariel; border: 6px double black; margin: 0; padding: 6px;} b {font-size: 20px; margin: 0;}</style><b>" .. (obj.heading or "") .. "</b> " .. obj.text .. "<hr><button onclick=\"console.log('RUNLUA:SELF:Remove()')\">Close</button>")

		if (IsValid(container)) then
			container:Add(html)
		end

		return html
	end)

	spawnmenu.AddCreationTab("Pills", function()
		local ctrl = vgui.Create("SpawnmenuContentPanel")

		local tree = ctrl.ContentNavBar.Tree
		local node_morphs = tree:AddNode("Categories", "icon16/folder.png")

		for _, pack in pairs(packs) do
			local node = node_morphs:AddNode(isstring(pack.name) and pack.name or "", isstring(pack.icon) and pack.icon)

			node.DoPopulate = function(self)
				-- If we've already populated it - forget it.
				if (self.SpawnPanel) then return end
				-- Create the container panel
				self.SpawnPanel = vgui.Create("ContentContainer", ctrl)
				self.SpawnPanel:SetVisible(false)
				self.SpawnPanel:SetTriggerSpawnlistChange(false)

				-- warnings
				for _, item in pairs(pack.headers) do
					spawnmenu.CreateContentIcon(item.type, self.SpawnPanel, item)
				end

				-- icons
				for _, item in SortedPairsByMemberValue(pack.items, "printName") do
					spawnmenu.CreateContentIcon(item.type, self.SpawnPanel, item)
				end
			end

			-- If we click on the node populate it and switch to it.
			node.DoClick = function(self)
				self:DoPopulate()
				ctrl:SwitchPanel(self.SpawnPanel)
			end
		end

		node_morphs:SetExpanded(true)

		return ctrl
	end, "icon16/pill_go.png", 60)
end

-- NW Strings
if SERVER then
	util.AddNetworkString("pk_pill_filtercam")
	util.AddNetworkString("pk_pill_morphsound")
	--util.AddNetworkString("pk_pill_init_darkrp")
else
	net.Receive("pk_pill_filtercam", function(len, pl)
		local pill = net.ReadEntity()
		local filtered = net.ReadEntity()

		if IsValid(pill) and IsValid(filtered) then
			table.insert(pill.camTraceFilter, filtered)
		end
	end)
end

-- Apply/Restore
if SERVER then
	--[[
		Modes:
		DEFAULT - Force, but don't change locking settings
		user - Obey restrictions
		force - force, change locking settings
		lock-life - force until death
		lock-map - force until map restart
		lock-perma - force forever
	]]
	function apply(ply, name, mode, option)
		if CLIENT then return end
		t = forms[name]

		if not t then
			print("Player '" .. ply:Name() .. "' attempted to use nonexistent pill '" .. name .. "'.")
			ply:PrintMessage(HUD_PRINTCONSOLE, "Attempted to use nonexistent pill '" .. name .. "'.")

			return
		end

		local old = getMappedEnt(ply)

		if not ply:Alive() and not IsValid(old) then
			ply:ChatPrint("You are DEAD! Dead people can't use pill!")

			return
		end

		local locked
		local overridePos
		local overrideAng

		--restriction logic
		if mode == "user" then
			local success = true

			if not t.printName then
				ply:ChatPrint("You cannot use this pill directly.")
				success = false
			end

			--admin_restrict
			if not ply:IsSuperAdmin() then
				success = false
			end

			if success and pk_pills._restricted[name] and not ply:IsSuperAdmin() then
				ply:ChatPrint("You must be an Admin to use this pill.")
				success = false
			end

			if IsValid(old) and old.locked then
				if locked_perma[ply:SteamID()] then
					ply:ChatPrint("You are locked in your current pill -- FOREVER!")
				elseif locked_game[ply:SteamID()] then
					ply:ChatPrint("You are locked in your current pill until the map changes.")
				else
					ply:ChatPrint("You are locked in your current pill until you die.")
				end

				success = false
			end

			if t.type == "phys" and t.userSpawn then
				local tr

				if IsValid(old) and old.formTable.type == "phys" then
					tr = util.QuickTrace(old:GetPos(), ply:EyeAngles():Forward() * 99999, old)
				else
					tr = ply:GetEyeTrace()
				end

				if t.userSpawn.type == "ceiling" then
					if tr.HitNormal.z < -.8 and not tr.HitSky then
						overridePos = tr.HitPos + tr.HitNormal * (t.userSpawn.offset or 0)
					else
						success = false
						ply:ChatPrint("You need to be looking at a ceiling to use this pill.")
					end
				elseif t.userSpawn.type == "wall" then
					if not tr.HitSky then
						overridePos = tr.HitPos + tr.HitNormal * (t.userSpawn.offset or 0)
						overrideAng = tr.HitNormal:Angle()

						if t.userSpawn.ang then
							overrideAng = overrideAng + t.userSpawn.ang
						end
					else
						success = false
						ply:ChatPrint("You need to be looking at a wall to use this pill.")
					end
				end
			end

			net.Start("pk_pill_morphsound")
			net.WriteBit(success)
			net.Send(ply)
			if not success then return end
		elseif mode ~= nil then
			--anything that can change locks
			if mode == "lock-map" then
				locked_game[ply:SteamID()] = name
			else
				locked_game[ply:SteamID()] = nil
			end

			if mode == "lock-perma" then
				locked_perma[ply:SteamID()] = name
			else
				locked_perma[ply:SteamID()] = nil
			end

			file.Write("pill_config/permalocked.txt", util.TableToKeyValues(locked_perma, "permalocked"))

			if mode ~= "force" then
				locked = true
			end
		end

		local e

		if t.type == "phys" then
			e = ents.Create("pill_ent_phys")

			if overridePos then
				e:SetPos(overridePos)
				--elseif old&&old.formTable&&old.formTable.type=="phys" then
				--	e:SetPos(old:LocalToWorld(t.spawnOffset or Vector(0,0,60)))
			else
				e:SetPos(ply:LocalToWorld(t.spawnOffset or Vector(0, 0, 60)))
			end

			if overrideAng then
				e:SetAngles(overrideAng)
			else
				local angs = ply:EyeAngles()
				angs.p = 0
				e:SetAngles(angs)
			end
		elseif t.type == "ply" then
			e = ents.Create("pill_ent_costume")

			if old and old.formTable.type == "phys" then
				local angs = ply:EyeAngles()
				ply:Spawn()
				ply:SetEyeAngles(angs)
				ply:SetPos(old:GetPos())
			end
		else
			ply:ChatPrint("WARNING: Attempted to use invalid pill type.")

			return
		end

		local oldvel

		if IsValid(old) and old.formTable.type == "phys" then
			local phys = old:GetPhysicsObject()
			oldvel = IsValid(phys) and phys:GetVelocity() or Vector(0, 0, 0)
		else
			oldvel = ply:GetVelocity()
		end

		--Remove old AFTER we had a chance to set the new
		if IsValid(old) then
			old:Remove()
		end

		e:SetPillForm(name)
		e:SetPillUser(ply)
		e.locked = locked
		e.option = option
		e:Spawn()
		e:Activate()

		--if mode=="user" then
		if t.type == "phys" then
			--ply:SetLocalVelocity(oldvel)
			--else
			local phys = e:GetPhysicsObject()

			if IsValid(phys) then
				phys:SetVelocity(oldvel)
			end
		end

		--end
		if t.type ~= "ply" then
			ply:SetLocalVelocity(Vector(0, 0, 0))
		end

		return e
	end

	local driveModes = {}

	function getDrive(typ)
		return driveModes[typ]
	end

	function registerDrive(name, t)
		driveModes[name] = t
	end
end

--set breakout to true to break out of any locks
--returns true if the player was using a pill
--shared because it goes in the noclip function, I guess
function restore(ply, breakout)
	local ent = getMappedEnt(ply)

	if IsValid(ent) then
		if SERVER then
			if ent.locked and not breakout then
				if locked_perma[ply:SteamID()] then
					ply:ChatPrint("You are locked in your current pill -- FOREVER!")
				elseif locked_game[ply:SteamID()] then
					ply:ChatPrint("You are locked in your current pill until the map changes.")
				else
					ply:ChatPrint("You are locked in your current pill until you die.")
				end
			else
				ent.notDead = true
				ent:Remove()
			end

			if not breakout then
				net.Start("pk_pill_morphsound")
				net.WriteBit(ent.notDead)
				net.Send(ply)
			else
				locked_game[ply:SteamID()] = nil
				locked_perma[ply:SteamID()] = nil
				file.Write("pill_config/permalocked.txt", util.TableToKeyValues(locked_perma, "permalocked"))
			end
		end

		return true
	end
end

-- This crap is entirely for MorphDM.
if SERVER then
	function pk_pills.handeDeathCommon(ent)
		--ent:EmitSound("npc/scanner/scanner_explode_crash2.wav")
	end
end

-- THEM HOOKS
if SERVER then
	hook.Add("KeyPress", "pk_pill_keypress", function(ply, key)
		local ent = getMappedEnt(ply)

		if IsValid(ent) then
			ent:DoKeyPress(ply, key)
		end
	end)

	hook.Add("PlayerSwitchFlashlight", "pk_pill_flashlight", function(ply, on)
		local ent = getMappedEnt(ply)

		if IsValid(ent) and on then
			if ent.formTable.flashlight and not ent.animFreeze then
				ent.formTable.flashlight(ply, ent)
			end

			return false
		end
	end)

	hook.Add("SetupPlayerVisibility", "pk_pill_pvs", function(ply)
		if IsValid(getMappedEnt(ply)) and getMappedEnt(ply).formTable.type == "phys" then
			AddOriginToPVS(getMappedEnt(ply):GetPos())
		end
	end)

	hook.Add("PlayerDeathThink", "pk_pill_nospawn", function(ply)
		if getMappedEnt(ply) then return false end
	end)

	hook.Add("DoAnimationEvent", "pk_pill_triggerAnims", function(ply, event, data)
		if IsValid(getMappedEnt(ply)) and getMappedEnt(ply).formTable.type == "ply" then
			if event == PLAYERANIMEVENT_JUMP then
				getMappedEnt(ply):PillAnim("jump")
				getMappedEnt(ply):DoJump()
			end

			if event == PLAYERANIMEVENT_ATTACK_PRIMARY then
				getMappedEnt(ply):PillGesture("attack")
			end

			if event == PLAYERANIMEVENT_ATTACK_SECONDARY then
				getMappedEnt(ply):PillGesture("attack2")
			end

			if event == PLAYERANIMEVENT_RELOAD then
				getMappedEnt(ply):PillGesture("reload")
			end
		end
	end)

	hook.Add("OnPlayerHitGround", "pk_pill_hitground", function(ply)
		local ent = getMappedEnt(ply)

		if IsValid(ent) then
			if ent.formTable.land then
				ent.formTable.land(ply, ent)
				ent:PillSound("land")
			end

			if ent.formTable.noFallDamage or ent.formTable.type == "phys" then return true end
		end
	end)

	hook.Add("DoPlayerDeath", "pk_pill_death", function(ply)
		if IsValid(getMappedEnt(ply)) then
			if SERVER then
				getMappedEnt(ply):PillDie()
			end

			return false
		end
	end)

	hook.Add("PlayerCanPickupWeapon", "pk_pill_pickupWeapon", function(ply, wep)
		if IsValid(getMappedEnt(ply)) then
			return false
		end
	end)

	hook.Add("PlayerSpawn", "pk_pill_force_on_spawn", function(ply)
		local forcedType = locked_perma[ply:SteamID()] or locked_game[ply:SteamID()]

		if forcedType then
			local e = apply(ply, forcedType)

			if IsValid(e) then
				e.locked = true
			end

			return
		end
	end)

	hook.Add("SetPlayerSpeed", "pk_pill_speed_enforcer", function(ply, walk, run)
		if IsValid(getMappedEnt(ply)) then return false end
	end)
else
	hook.Add("ShouldDrawLocalPlayer", "pk_pill_thirdperson", function()
		if getMappedEnt(LocalPlayer()) then return true end
	end)
end

-- Shared hooks 
hook.Add("PhysgunPickup", "pk_pill_nograb", function(ply, ent)
	if ent:GetClass() == "pill_ent_phys" then
		if ply:IsSuperAdmin() then
			return true
		else
			return false
		end
	end
end)

hook.Add("SetupMove", "pk_pill_movemod", function(ply, mv, cmd)
	local ent = getMappedEnt(ply)

	if IsValid(ent) then
		if ent.formTable.moveMod then
			ent.formTable.moveMod(ply, ent, mv, cmd)
		end

		if ent.GetChargeTime and ent:GetChargeTime() ~= 0 then
			local charge = ent.formTable.charge
			--check if we should continue
			local vel = mv:GetVelocity()

			if ent:GetChargeTime() + .1 < CurTime() and vel:Length() < charge.vel * .8 then
				print("uncharge")
				ent:SetChargeTime(0)
				ent:PillLoopStop("charge")
			else
				local angs = ent:GetChargeAngs()
				ply:SetEyeAngles(angs)
				mv:SetVelocity(angs:Forward() * charge.vel)
			end
		end
	end
end)

include("ppp_includes/util.lua")
include("ppp_includes/nocompat.lua")
include("ppp_includes/console.lua")
include("ppp_includes/restricted.lua")
include("ppp_includes/locomotion.lua")