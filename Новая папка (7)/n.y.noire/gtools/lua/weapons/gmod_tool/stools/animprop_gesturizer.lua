--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/animprop_gesturizer.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Animated Props"
TOOL.Name = "Anim - Gesturizer"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["animationname"] = "attackStand_ITEM1"
TOOL.ClientConVar["repeatrate"] = 1
TOOL.ClientConVar["selectname"] = "null"
TOOL.ClientConVar["selectnameconfirm"] = "null"
TOOL.ClientConVar["drawselectionhalo"] = "1"
TOOL.SelectedEnt = nil

if (CLIENT) then
	language.Add("tool.animprop_gesturizer.name", "Animated Props - Gesturizer")
	language.Add("tool.animprop_gesturizer.desc", "Layers a second animation over an animated prop. It's experimental, so expect problems - see the context menu!")
	language.Add("tool.animprop_gesturizer.0", "Right: Select a prop to choose its gesture with the context menu. | Reload: Make a prop stop gesturing.")
end

--function TOOL:LeftClick( trace )
--
--	if CLIENT then return true end
--	local ply = self:GetOwner()
--	local ent = trace.Entity
--	local animname	= self:GetClientInfo( "animationname" )
--
--	if ent:IsValid() then
--		local gesturesequence = ent:LookupSequence(animname)
--		local gesture = ent:GetSequenceActivity(gesturesequence)
--		ent:RestartGesture(gesture)
--		return true
--	end
--
--end
function TOOL:RightClick(trace)
	if CLIENT then return true end
	local tr = trace

	if (trace.Entity:IsValid()) then
		--if we've clicked on something, but we already have something selected, deselect it first
		if (self.SelectedEnt ~= nil) and self.SelectedEnt:IsValid() then
			local owner = self:GetOwner()
			self:GetWeapon():SetNWEntity(1, NULL)
			self.SelectedEnt = nil
			owner:ConCommand("animprop_gesturizer_selectname 0\n") --set selectname to 0, so think empties the control panel's anim list
			--MsgN("selection changed to 0")
			self:RightClick(tr)

			return true
		end

		if (trace.Entity:GetClass() == "animprop_generic") then
			local owner = self:GetOwner()

			if trace.Entity.GesturizerEntity then
				owner:ConCommand("animprop_gesturizer_animationname " .. trace.Entity.GesturizerEntity:GetAnimName() .. "\n")
				owner:ConCommand("animprop_gesturizer_repeatrate " .. trace.Entity.GesturizerEntity:GetRepeatRate() .. "\n")
			end

			self:GetWeapon():SetNWEntity(1, tr.Entity)
			self.SelectedEnt = tr.Entity
			owner:ConCommand("animprop_gesturizer_selectname " .. trace.Entity:EntIndex() .. "\n") --set selectname to the entindex, so think refreshes the control panel's anim list
			--MsgN("selection changed to "..model.." with index "..trace.Entity:EntIndex())

			return true
		end

		if (trace.Entity:GetClass() == "animprop_generic_physmodel") and trace.Entity.MyEntity:IsValid() then
			local owner = self:GetOwner()

			if trace.Entity.MyEntity.GesturizerEntity then
				owner:ConCommand("animprop_gesturizer_animationname " .. trace.Entity.MyEntity.GesturizerEntity:GetAnimName() .. "\n")
				owner:ConCommand("animprop_gesturizer_repeatrate " .. trace.Entity.MyEntity.GesturizerEntity:GetRepeatRate() .. "\n")
			end

			self:GetWeapon():SetNWEntity(1, tr.Entity.MyEntity)
			self.SelectedEnt = tr.Entity.MyEntity
			owner:ConCommand("animprop_gesturizer_selectname " .. trace.Entity.MyEntity:EntIndex() .. "\n") --set selectname to the entindex, so think refreshes the control panel's anim list

			return true
		end
	else
		if not trace.Entity:IsValid() then
			local owner = self:GetOwner()

			--if we didn't click on anything then deselect
			if self.SelectedEnt and self.SelectedEnt:IsValid() then
				self:GetWeapon():SetNWEntity(1, NULL)
				self.SelectedEnt = nil
				owner:ConCommand("animprop_gesturizer_selectname 0\n") --set selectname to 0, so think empties the control panel's anim list
				--MsgN("selection changed to 0")

				return true
			end
		end
	end
end

function TOOL:Reload(trace)
	if CLIENT then return true end

	if (trace.Entity:IsValid()) then
		local traceent = nil

		if (trace.Entity:GetClass() == "animprop_generic_physmodel") then
			if (not trace.Entity.MyEntity:IsValid()) then return end
			traceent = trace.Entity.MyEntity
		else
			traceent = trace.Entity
		end

		for _, asdf in pairs(ents:GetAll()) do
			if asdf:GetClass() == "gesturizerent" and asdf:GetTargetEnt() == traceent then
				asdf:Remove()
				traceent.GesturizerEntity = nil
			end
		end

		duplicator.ClearEntityModifier(traceent, "GesturizerEntity")

		return true
	end
end

function TOOL:Think()
	local animname = self:GetClientInfo("animationname")
	local repeatrate = self:GetClientNumber("repeatrate")
	local select = self:GetClientNumber("selectname")
	local selectcon = self:GetClientNumber("selectnameconfirm")

	--update the control panel if selectname's been changed
	if CLIENT then
		if select ~= selectcon then
			local ent = self:GetWeapon():GetNWEntity(1)
			--it takes a while for the client to realize the NWentity has been changed - longer than it takes for it to receive the new value for the convar selectname
			--these 3 checks stop it from updating the control panel until we're sure the NWentity and selectname are referring to the same thing
			if not ent:IsValid() and select ~= 0 then return end --MsgN("THINK: (keep thinking) NWent = null, selectname = not null!")
			if select == 0 and ent:IsValid() then return end --MsgN("THINK: (keep thinking) NWent = not null, selectname = null!")

			if ent:IsValid() then
				local index1 = select
				local index2 = ent:EntIndex()
				if index1 ~= index2 then return end --MsgN("THINK: (keep thinking) Indices are wrong! (NWent "..index2.." != selectname "..index1..")")
			end

			--if ent:IsValid() then MsgN("THINK: Ent DOES exist, updating cpanel") end
			--if !ent:IsValid() then MsgN("THINK: Ent DOESN'T exist, updating cpanel") end	
			self:UpdateControlPanel(ent)
		end

		return true
	end

	--if selectedent doesn't exist then stop here
	if not IsValid(self.SelectedEnt) then
		--if selectedent stopped existing (i.e. because it got removed) then set selectname to 0
		if select ~= 0 then
			--MsgN("set selectname to 0 because selectedent stopped existing")
			RunConsoleCommand("animprop_gesturizer_selectname", 0)
		end

		return
	end

	--update the gesture
	if self.SelectedEnt:GetClass() == "animprop_generic" then
		if not self.SelectedEnt.GesturizerEntity then
			GiveGesturizerEntity(self:GetOwner(), self.SelectedEnt, {
				AnimName = animname,
				RepeatRate = repeatrate
			})

			return
		end

		if self.SelectedEnt.GesturizerEntity:GetAnimName() ~= animname or self.SelectedEnt.GesturizerEntity:GetRepeatRate() ~= repeatrate then
			GiveGesturizerEntity(self:GetOwner(), self.SelectedEnt, {
				AnimName = animname,
				RepeatRate = repeatrate
			})
		end
	end
end

function TOOL:DrawHUD()
	if self:GetClientNumber("drawselectionhalo") == 1 then
		local ent = self:GetWeapon():GetNWEntity(1)

		if ent:IsValid() then
			halo.Add({ent}, Color(255, 255, 189 + math.cos(RealTime() * 4) * 17, 255), 2.3, 2.3, 1, true, false)
		end
	end
end

function TOOL:Holster()
	local owner = self:GetOwner()

	if self.SelectedEnt and self.SelectedEnt:IsValid() then
		self:GetWeapon():SetNWEntity(1, NULL)
		self.SelectedEnt = nil
		owner:ConCommand("animprop_gesturizer_selectname 0\n") --set selectname to 0, so think empties the control panel's anim list
		--MsgN("selection changed to 0 because tool was holstered")
	end
end

function TOOL:UpdateControlPanel(ent, index)
	if SERVER then return end
	local select = self:GetClientNumber("selectname", 0)
	local panel = controlpanel.Get("animprop_gesturizer")

	if (not panel) then
		MsgN("CPANEL DOES NOT EXIST!")

		return
	end

	panel:ClearControls()
	self.BuildCPanel(panel, ent)
	RunConsoleCommand("animprop_gesturizer_selectnameconfirm", select)
end

if (SERVER) then
	function GiveGesturizerEntity(ply, ent, Data)
		if ent.GesturizerEntity then
			if (not ent.GesturizerEntity.SetAnimName) then return end
			ent.GesturizerEntity:SetTargetEnt(ent)
			ent.GesturizerEntity:SetAnimName(Data.AnimName)
			ent.GesturizerEntity:SetRepeatRate(Data.RepeatRate)
		end

		if not ent.GesturizerEntity then
			ent.GesturizerEntity = ents.Create("gesturizerent")
			ent.GesturizerEntity:SetTargetEnt(ent)
			ent.GesturizerEntity:SetAnimName(Data.AnimName)
			ent.GesturizerEntity:SetRepeatRate(Data.RepeatRate)
			ent.GesturizerEntity:Spawn()
			ent.GesturizerEntity:Activate()
		end

		duplicator.StoreEntityModifier(ent, "GesturizerEntity", Data)
	end

	duplicator.RegisterEntityModifier("GesturizerEntity", GiveGesturizerEntity)
end

function TOOL.BuildCPanel(panel, ent)
	panel:AddControl("Header", {
		Text = "Gesturizer",
		Description = ""
	})

	panel:AddControl("Label", {
		Text = "Due to a bug in how GMod handles gestures, all animations played by this tool will move at double speed, and as far as I can tell, there's no way to fix it. They should still look fine in screenshots, though, so this tool isn't completely pointless!",
		Description = ""
	})

	panel:AddControl("Label", {
		Text = "",
		Description = ""
	})

	panel:AddControl("Label", {
		Text = "",
		Description = ""
	})

	if ent and ent ~= NULL and ent:IsValid() then
		--MsgN("CPANEL: Ent DOES exist, populating anim list")
		local animlist = {
			Label = "Animation",
			Height = 250,
			Options = {}
		}

		for _, anm in SortedPairsByValue(ent:GetSequenceList()) do
			--cut out the anims that aren't useable as gestures because they don't have activities
			if ent:GetSequenceActivity(ent:LookupSequence(anm)) ~= -1 then
				animlist.Options[anm] = {
					animprop_gesturizer_animationname = anm
				}
			end
		end

		--PrintTable( ent:GetSequenceList() )
		panel:AddControl("ListBox", animlist)
	else
		--MsgN("CPANEL: Ent DOESN'T exist, emptying anim list")
		local animlist = {
			Label = "Animation",
			Height = 35,
			Options = {}
		}

		animlist.Options["(no animated prop selected)"] = {}
		panel:AddControl("ListBox", animlist)
	end

	panel:AddControl("TextBox", {
		Label = "",
		Description = "",
		MaxLength = 255,
		Text = "stuff",
		Command = "animprop_gesturizer_animationname",
	})

	panel:AddControl("Label", {
		Text = "Right click an animated prop to select it and get a list of all animations that can be used as gestures.",
		Description = ""
	})

	panel:AddControl("Label", {
		Text = "",
		Description = ""
	})

	panel:AddControl("Slider", {
		Label = "Repeat Rate",
		Type = "Float",
		Min = "0.25",
		Max = "5",
		Description = "",
		Command = "animprop_gesturizer_repeatrate"
	})

	panel:AddControl("Label", {
		Text = "How often the gesture repeats itself.",
		Description = ""
	})

	panel:AddControl("Label", {
		Text = "",
		Description = ""
	})

	panel:AddControl("Label", {
		Text = "",
		Description = ""
	})

	panel:AddControl("CheckBox", {
		Label = "Draw selection halo",
		Description = "",
		Command = "animprop_gesturizer_drawselectionhalo"
	})
end