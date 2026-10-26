--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/animprop.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Animated Props"
TOOL.Name = "Animated Props"
TOOL.Command = nil
TOOL.ConfigName = ""
TOOL.ClientConVar["modelname"] = "models/gman_high.mdl"
TOOL.ClientConVar["animationname"] = "tiefidget"
TOOL.ClientConVar["skinnum"] = "0"
TOOL.ClientConVar["scalenum"] = "1"
TOOL.ClientConVar["playback"] = "1"
TOOL.ClientConVar["bboxh"] = "75"
TOOL.ClientConVar["bboxw"] = "10"
TOOL.ClientConVar["selectname"] = "null"
TOOL.ClientConVar["selectnameconfirm"] = "null"
TOOL.ClientConVar["drawselectionhalo"] = "1"
TOOL.SelectedEnt = nil

if (CLIENT) then
	language.Add("tool.animprop.name", "Animated Props")
	language.Add("tool.animprop.desc", "Spawns animated characters and models")
	language.Add("tool.animprop.0", "Left: Spawn an animated prop. | Right: Get a model, or select an animated prop to modify it with the context menu. | Reload: Pause or unpause an animation.")
	language.Add("Undone_AnimatedProp", "Undone Animated Prop")
end

function TOOL:LeftClick(trace)
	if CLIENT then return true end
	local modelname = self:GetClientInfo("modelname")
	local animname = self:GetClientInfo("animationname")
	local skinnum = self:GetClientNumber("skinnum")
	local scalenum = self:GetClientNumber("scalenum")
	local playback = self:GetClientNumber("playback")
	local bboxh = self:GetClientNumber("bboxh")
	local bboxw = self:GetClientNumber("bboxw")
	local ply = self:GetOwner()

	if (trace.Entity:IsValid() and trace.Entity:GetClass() == "animprop_generic") then
		trace.Entity:SetModel(modelname)
		trace.Entity:SetModelScale(scalenum, 0)
		trace.Entity.MyModelScale = scalenum
		trace.Entity:SetSkin(skinnum)
		trace.Entity.MyAnim = animname
		trace.Entity.MyPlaybackRate = playback
		trace.Entity.IsPaused = false
		timer.Stop("AnimationPropTimer_" .. trace.Entity:EntIndex())
		trace.Entity:LoopAnimation()
		--call all of the pose parameters again so they don't reset themselves to 0
		trace.Entity:SetPoseParameter("aim_pitch", trace.Entity.StoredAimPitch)
		trace.Entity:SetPoseParameter("aim_yaw", trace.Entity.StoredAimYaw)
		trace.Entity:SetPoseParameter("body_pitch", trace.Entity.StoredAimPitch)
		trace.Entity:SetPoseParameter("body_yaw", trace.Entity.StoredAimYaw)
		trace.Entity:SetPoseParameter("move_scale", 1) --for the few models that use this
		trace.Entity:SetPoseParameter("move_x", trace.Entity.StoredMoveX)
		trace.Entity:SetPoseParameter("move_y", trace.Entity.StoredMoveY)
		trace.Entity:SetPoseParameter("move_yaw", trace.Entity.StoredMoveYaw)

		return true
	end

	if (trace.Entity:IsValid() and trace.Entity:GetClass() == "animprop_generic_physmodel" and trace.Entity.MyEntity:IsValid()) then
		trace.Entity.MyEntity:SetModel(modelname) --but we do it ourselves too, to sidestep some problems with changing from a model then back to it
		trace.Entity.ConfirmationModel = modelname --see above		
		trace.Entity:SetModel(modelname) --this is handled by the ent so tools other than this one can also change the model
		trace.Entity:SetSkin(skinnum) --this is handled by the ent so tools other than this one can also change the skin

		--only do this stuff if the prop we're changing isn't a tank
		if trace.Entity.MyEntity:GetClass() == "animprop_generic" then
			trace.Entity.MyEntity:SetModelScale(scalenum, 0)
			trace.Entity.MyEntity.MyModelScale = scalenum
			trace.Entity.MyEntity.MyAnim = animname
			trace.Entity.ConfirmationAnim = animname
			trace.Entity.MyEntity.MyPlaybackRate = playback
			trace.Entity.MyEntity.IsPaused = false
			timer.Stop("AnimationPropTimer_" .. trace.Entity.MyEntity:EntIndex())
			trace.Entity.MyEntity:LoopAnimation()
		end

		--call all of the pose parameters again so they don't reset themselves to 0
		trace.Entity.MyEntity:SetPoseParameter("aim_pitch", trace.Entity.MyEntity.StoredAimPitch)
		trace.Entity.MyEntity:SetPoseParameter("aim_yaw", trace.Entity.MyEntity.StoredAimYaw)
		trace.Entity.MyEntity:SetPoseParameter("body_pitch", trace.Entity.MyEntity.StoredAimPitch)
		trace.Entity.MyEntity:SetPoseParameter("body_yaw", trace.Entity.MyEntity.StoredAimYaw)
		trace.Entity.MyEntity:SetPoseParameter("move_scale", 1) --for the few models that use this
		trace.Entity.MyEntity:SetPoseParameter("move_x", trace.Entity.MyEntity.StoredMoveX)
		trace.Entity.MyEntity:SetPoseParameter("move_y", trace.Entity.MyEntity.StoredMoveY)
		trace.Entity.MyEntity:SetPoseParameter("move_yaw", trace.Entity.MyEntity.StoredMoveYaw)

		return true
	end

	--local angSpawn = trace.HitNormal:Angle()
	--angSpawn.p = angSpawn.p +90
	local lz = ((trace.HitPos - ply:GetPos()):GetNormal():Angle().y + 180) % 360
	local angSpawn = Angle(0, lz, 0)
	local thisanimprop = MakeAnimprop(ply, trace.HitPos, modelname, animname, skinnum, scalenum, playback, bboxh, bboxw, angSpawn, false, 0, nil, nil, nil, nil, nil, false, nil)
	undo.Create("AnimatedProp")
	undo.AddEntity(thisanimprop)
	undo.SetPlayer(ply)
	undo.Finish()

	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end
	local tr = trace

	if (trace.Entity:IsValid()) then
		--if we've clicked on something, but we already have something selected, deselect it first
		if (self.SelectedEnt ~= nil) and self.SelectedEnt:IsValid() then
			local owner = self:GetOwner()
			self:GetWeapon():SetNWEntity(1, NULL)
			self.SelectedEnt = nil
			owner:ConCommand("animprop_selectname 0\n") --set selectname to 0, so think empties the control panel's anim list
			--MsgN("selection changed to 0")
			self:RightClick(tr)

			return true
		end

		if (trace.Entity:GetClass() == "animprop_generic") then
			local model = trace.Entity:GetModel()
			local skin = trace.Entity:GetSkin()
			local owner = self:GetOwner()
			owner:ConCommand("animprop_modelname " .. model .. "\n")
			owner:ConCommand("animprop_skinnum " .. skin .. "\n")
			--also, copy everything else
			owner:ConCommand("animprop_animationname " .. trace.Entity.MyAnim .. "\n")
			owner:ConCommand("animprop_scalenum " .. trace.Entity.MyModelScale .. "\n")
			owner:ConCommand("animprop_playback " .. trace.Entity.MyPlaybackRate .. "\n")
			owner:ConCommand("animprop_bboxh " .. trace.Entity.BBoxHeight .. "\n")
			owner:ConCommand("animprop_bboxw " .. trace.Entity.BBoxWidth .. "\n")
			self:Message("Selected animated prop: " .. model)
			self:GetWeapon():SetNWEntity(1, tr.Entity)
			self.SelectedEnt = tr.Entity
			owner:ConCommand("animprop_selectname " .. trace.Entity:EntIndex() .. "\n") --set selectname to the entindex, so think refreshes the control panel's anim list
			--MsgN("selection changed to "..model.." with index "..trace.Entity:EntIndex())

			return true
		end

		if (trace.Entity:GetClass() == "animprop_generic_physmodel") and trace.Entity.MyEntity:IsValid() then
			local model = trace.Entity.MyEntity:GetModel()
			local skin = trace.Entity.MyEntity:GetSkin()
			local owner = self:GetOwner()
			owner:ConCommand("animprop_modelname " .. model .. "\n")
			owner:ConCommand("animprop_skinnum " .. skin .. "\n")
			--also, copy everything else
			owner:ConCommand("animprop_animationname " .. trace.Entity.MyEntity.MyAnim .. "\n")
			owner:ConCommand("animprop_scalenum " .. trace.Entity.MyEntity.MyModelScale .. "\n")
			owner:ConCommand("animprop_playback " .. trace.Entity.MyEntity.MyPlaybackRate .. "\n")
			owner:ConCommand("animprop_bboxh " .. trace.Entity.MyEntity.BBoxHeight .. "\n")
			owner:ConCommand("animprop_bboxw " .. trace.Entity.MyEntity.BBoxWidth .. "\n")
			self:Message("Selected animated prop: " .. model)
			self:GetWeapon():SetNWEntity(1, tr.Entity.MyEntity)
			self.SelectedEnt = tr.Entity.MyEntity
			owner:ConCommand("animprop_selectname " .. trace.Entity.MyEntity:EntIndex() .. "\n") --set selectname to the entindex, so think refreshes the control panel's anim list

			return true
		end

		if (trace.Entity:GetClass() == "prop_effect") then
			if (not trace.Entity.AttachedEntity:IsValid()) then return end
			local model = trace.Entity.AttachedEntity:GetModel()
			local skin = trace.Entity.AttachedEntity:GetSkin()
			local owner = self:GetOwner()
			owner:ConCommand("animprop_modelname " .. model .. "\n")
			owner:ConCommand("animprop_skinnum " .. skin .. "\n")
			self:Message("Copied model: " .. model)

			return true
		else
			if (trace.Entity:GetClass() ~= "animprop_generic") then
				local model = trace.Entity:GetModel()
				local skin = trace.Entity:GetSkin()
				local owner = self:GetOwner()

				if model then
					owner:ConCommand("animprop_modelname " .. model .. "\n")
					self:Message("Copied model: " .. model)
				end

				if skin then
					owner:ConCommand("animprop_skinnum " .. skin .. "\n")
				end

				return true
			end
		end
	else
		if not trace.Entity:IsValid() then
			local owner = self:GetOwner()

			--if we didn't click on anything then deselect
			if self.SelectedEnt and self.SelectedEnt:IsValid() then
				self:GetWeapon():SetNWEntity(1, NULL)
				self.SelectedEnt = nil
				owner:ConCommand("animprop_selectname 0\n") --set selectname to 0, so think empties the control panel's anim list
				--MsgN("selection changed to 0")

				return true
			end
		end
	end
end

function TOOL:Reload(trace)
	if CLIENT then return true end
	local ply = self:GetOwner()

	if (trace.Entity:IsValid() and trace.Entity:GetClass() == "animprop_generic") then
		if trace.Entity.IsPaused == false then
			trace.Entity.IsPaused = true
			local pauseframe = trace.Entity:GetCycle()
			trace.Entity.PauseFrame = pauseframe
			timer.Stop("AnimationPropTimer_" .. trace.Entity:EntIndex())

			return true
		end

		if trace.Entity.IsPaused == true then
			trace.Entity.IsPaused = false
			timer.Stop("AnimationPropTimer_" .. trace.Entity:EntIndex())
			trace.Entity:LoopAnimation()

			return true
		end
	end

	if (trace.Entity:IsValid() and trace.Entity:GetClass() == "animprop_generic_physmodel" and trace.Entity.MyEntity:IsValid()) then
		if trace.Entity.MyEntity.IsPaused == false then
			trace.Entity.MyEntity.IsPaused = true
			local pauseframe = trace.Entity.MyEntity:GetCycle()
			trace.Entity.MyEntity.PauseFrame = pauseframe
			timer.Stop("AnimationPropTimer_" .. trace.Entity.MyEntity:EntIndex())

			return true
		end

		if trace.Entity.MyEntity.IsPaused == true then
			trace.Entity.MyEntity.IsPaused = false
			timer.Stop("AnimationPropTimer_" .. trace.Entity.MyEntity:EntIndex())
			trace.Entity.MyEntity:LoopAnimation()

			return true
		end
	end
end

function TOOL:Think()
	local modelname = self:GetClientInfo("modelname")
	local animname = self:GetClientInfo("animationname")
	local skinnum = self:GetClientNumber("skinnum")
	local scalenum = self:GetClientNumber("scalenum")
	local playback = self:GetClientNumber("playback")
	local bboxh = self:GetClientNumber("bboxh")
	local bboxw = self:GetClientNumber("bboxw")
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
		if select ~= 0 and CLIENT then
			--MsgN("set selectname to 0 because selectedent stopped existing")
			RunConsoleCommand("animprop_selectname", 0)
		end

		return
	end

	local function RedoPoseParams()
		--call all of the pose parameters again so they don't reset themselves to 0
		self.SelectedEnt:SetPoseParameter("aim_pitch", self.SelectedEnt.StoredAimPitch)
		self.SelectedEnt:SetPoseParameter("aim_yaw", self.SelectedEnt.StoredAimYaw)
		self.SelectedEnt:SetPoseParameter("body_pitch", self.SelectedEnt.StoredAimPitch)
		self.SelectedEnt:SetPoseParameter("body_yaw", self.SelectedEnt.StoredAimYaw)
		self.SelectedEnt:SetPoseParameter("move_scale", 1) --for the few models that use this
		self.SelectedEnt:SetPoseParameter("move_x", self.SelectedEnt.StoredMoveX)
		self.SelectedEnt:SetPoseParameter("move_y", self.SelectedEnt.StoredMoveY)
		self.SelectedEnt:SetPoseParameter("move_yaw", self.SelectedEnt.StoredMoveYaw)
	end

	if self.SelectedEnt:GetModel() ~= modelname then
		self.SelectedEnt:SetModel(modelname)

		if self.SelectedEnt.IsPhysified == true and self.SelectedEnt:GetParent():IsValid() then
			self.SelectedEnt:GetParent():SetModel(modelname)
			self.SelectedEnt:GetParent().ConfirmationModel = modelname
		end

		timer.Stop("AnimationPropTimer_" .. self.SelectedEnt:EntIndex())
		self.SelectedEnt:LoopAnimation()
		self.SelectedEnt.IsPaused = false
		RedoPoseParams()
	end

	if self.SelectedEnt:GetSkin() ~= skinnum then
		if self.SelectedEnt.IsPhysified == true and self.SelectedEnt:GetParent():IsValid() then
			self.SelectedEnt:GetParent():SetSkin(skinnum)
		else
			self.SelectedEnt:SetSkin(skinnum)
		end
	end

	--only do this stuff if the prop we're changing isn't a tank
	if self.SelectedEnt:GetClass() == "animprop_generic" then
		if self.SelectedEnt.MyModelScale ~= scalenum then
			self.SelectedEnt:SetModelScale(scalenum, 0)
			self.SelectedEnt.MyModelScale = scalenum
		end

		if self.SelectedEnt.MyAnim ~= animname then
			self.SelectedEnt.MyAnim = animname
			timer.Stop("AnimationPropTimer_" .. self.SelectedEnt:EntIndex())
			self.SelectedEnt:LoopAnimation()
			self.SelectedEnt.IsPaused = false

			if self.SelectedEnt.IsPhysified == true and self.SelectedEnt:GetParent():IsValid() then
				self.SelectedEnt:GetParent().ConfirmationAnim = animname
			end

			RedoPoseParams()
		end

		if self.SelectedEnt.MyPlaybackRate ~= playback then
			self.SelectedEnt.MyPlaybackRate = playback
			timer.Stop("AnimationPropTimer_" .. self.SelectedEnt:EntIndex())
			self.SelectedEnt:LoopAnimation()
			self.SelectedEnt.IsPaused = false
			RedoPoseParams()
		end
	end
end

function TOOL:Message(TextOriginal)
	local Text = string.Replace(TextOriginal, "\\", "/") --stops the message from erroring if the model path has backslashes in it for whatever reason

	if SERVER then
		self:GetOwner():SendLua("GAMEMODE:AddNotify('" .. Text .. "', NOTIFY_GENERIC, 2)")
		self:GetOwner():SendLua("surface.PlaySound('ambient/water/drip" .. math.random(1, 4) .. ".wav')")
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
		owner:ConCommand("animprop_selectname 0\n") --set selectname to 0, so think empties the control panel's anim list
		--MsgN("selection changed to 0 because tool was holstered")
	end
end

function TOOL:UpdateControlPanel(ent, index)
	if SERVER then return end
	local select = self:GetClientNumber("selectname", 0)
	local panel = controlpanel.Get("animprop")

	if (not panel) then
		MsgN("CPANEL DOES NOT EXIST!")

		return
	end

	panel:ClearControls()
	self.BuildCPanel(panel, ent)
	RunConsoleCommand("animprop_selectnameconfirm", select)
end

if (SERVER) then
	--this function should really be using a data table instead of like a million args
	function MakeAnimprop(ply, Pos, modelname, animname, skinnum, scalenum, playback, bboxh, bboxw, angle, isitpaused, pauseframe, storedaimpitch, storedaimyaw, storedmovex, storedmovey, storedmoveyaw, doesithavephysics, confirmid)
		local animprop = ents.Create("animprop_generic")
		if (not animprop:IsValid()) then return false end

		if (doesithavephysics ~= nil) then
			animprop.IsPhysified = doesithavephysics
		end

		animprop:SetPlayer(ply)
		animprop:SetPos(Pos)
		animprop:SetAngles(angle)
		animprop:SetModel(modelname)
		animprop:SetModelScale(scalenum, 0)
		animprop.MyModelScale = scalenum
		animprop:SetSkin(skinnum)
		animprop.BBoxHeight = bboxh
		animprop.BBoxWidth = bboxw
		animprop.MyAnim = animname
		animprop.MyPlaybackRate = playback
		animprop.IsPaused = isitpaused
		animprop.PauseFrame = pauseframe

		--these should only get called if we're duping
		if storedaimpitch then
			animprop.StoredAimPitch = storedaimpitch
		end

		if storedaimyaw then
			animprop.StoredAimYaw = storedaimyaw
		end

		if storedmovex then
			animprop.StoredMoveX = storedmovex
		end

		if storedmovey then
			animprop.StoredMoveY = storedmovey
		end

		if storedmoveyaw then
			animprop.StoredMoveYaw = storedmoveyaw
		end

		if confirmid then
			animprop.ConfirmationID = confirmid
		end

		animprop:Spawn()
		--for some reason, setting the type to "ai" to fix the eye posability made this stuff not work when being called by initialize. so, we're doing it all here instead.
		animprop:SetPoseParameter("aim_pitch", animprop.StoredAimPitch)
		animprop:SetPoseParameter("aim_yaw", animprop.StoredAimYaw)
		animprop:SetPoseParameter("body_pitch", animprop.StoredAimPitch)
		animprop:SetPoseParameter("body_yaw", animprop.StoredAimYaw)
		animprop:SetPoseParameter("move_scale", 1) --for the few models that use this
		animprop:SetPoseParameter("move_x", animprop.StoredMoveX)
		animprop:SetPoseParameter("move_y", animprop.StoredMoveY)
		animprop:SetPoseParameter("move_yaw", animprop.StoredMoveYaw)

		if (animprop.IsPaused == true) then
			animprop:ResetSequence(animprop:LookupSequence(animprop.MyAnim))
			animprop:SetCycle(animprop.PauseFrame)
			animprop:SetPlaybackRate(0)
		else
			animprop:LoopAnimation()
		end

		animprop:Activate()

		return animprop
	end

	duplicator.RegisterEntityClass("animprop_generic", function(ply, data)
		local ent = MakeAnimprop(ply, data.Pos, data.Model, data.MyAnim, data.Skin, data.MyModelScale, data.MyPlaybackRate, data.BBoxHeight, data.BBoxWidth, data.Angle, data.IsPaused, data.PauseFrame, data.StoredAimPitch, data.StoredAimYaw, data.StoredMoveX, data.StoredMoveY, data.StoredMoveYaw, data.IsPhysified, data.ConfirmationID)

		--PrintTable(data)
		if (data.Flex) then
			duplicator.DoFlex(ent, data.Flex, data.FlexScale)
		end

		if (data.BoneManip) then
			duplicator.DoBoneManipulator(ent, data.BoneManip)
		end

		if (data.ColGroup) then
			ent:SetCollisionGroup(data.ColGroup)
		end

		if (data.BodyG) then
			for k, v in pairs(data.BodyG) do
				ent:SetBodygroup(k, v)
			end
		end

		return ent
	end, "Data")
end

function TOOL.BuildCPanel(panel, ent)
	panel:AddControl("Header", {
		Text = "Animated Props",
		Description = ""
	})

	panel:AddControl("TextBox", {
		Label = "Model",
		Description = "",
		MaxLength = 255,
		Text = "stuff",
		Command = "animprop_modelname",
	})

	panel:AddControl("Label", {
		Text = "Right click on something to get its model.",
		Description = ""
	})

	if ent and ent ~= NULL and ent:IsValid() then
		--MsgN("CPANEL: Ent DOES exist, populating anim list")
		local animlist = {
			Label = "Animation",
			Height = 250,
			Options = {}
		}

		for _, anm in pairs(ent:GetSequenceList()) do
			if string.StartWith(string.lower(anm), "gesture_") then continue end
			if string.StartWith(string.lower(anm), "g_") then continue end
			if string.StartWith(string.lower(anm), "p_") then continue end
			if string.StartWith(string.lower(anm), "aimlayer_") then continue end
			if string.StartWith(string.lower(anm), "layer_") then continue end
			if string.StartWith(string.lower(anm), "b_") then continue end
			if string.StartWith(string.lower(anm), "bg_") then continue end
			if string.StartWith(string.lower(anm), "hg_") then continue end
			if string.StartWith(string.lower(anm), "range_") then continue end
			if string.StartWith(string.lower(anm), "reload_") then continue end
			if string.StartWith(string.lower(anm), "zombie_") then continue end

			animlist.Options[anm] = {
				animprop_animationname = anm
			}
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
		Command = "animprop_animationname",
	})

	panel:AddControl("Label", {
		Text = "Right click an animated prop to select it and get a list of all its animations.",
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

	panel:AddControl("Slider", {
		Label = "Skin",
		Type = "Integer",
		Min = "0",
		Max = "10",
		Description = "",
		Command = "animprop_skinnum"
	})

	panel:AddControl("Label", {
		Text = "On models with multiple skins, select which one to use.",
		Description = ""
	})

	panel:AddControl("Slider", {
		Label = "Scale",
		Type = "Float",
		Min = "0.0625",
		Max = "16",
		Description = "",
		Command = "animprop_scalenum"
	})

	panel:AddControl("Label", {
		Text = "Change the size of the model. While 1 is normal size, 0.5 is half, and 2 is double.",
		Description = ""
	})

	panel:AddControl("Slider", {
		Label = "Speed",
		Type = "Float",
		Min = "0",
		Max = "5",
		Description = "",
		Command = "animprop_playback"
	})

	panel:AddControl("Label", {
		Text = "Control how fast it animates. Again, 1 is normal, 0.5 is half, 2 is double.",
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

	panel:AddControl("Slider", {
		Label = "Height",
		Type = "Float",
		Min = "1",
		Max = "100",
		Description = "",
		Command = "animprop_bboxh"
	})

	panel:AddControl("Slider", {
		Label = "Width",
		Type = "Float",
		Min = "1",
		Max = "100",
		Description = "",
		Command = "animprop_bboxw"
	})

	panel:AddControl("Label", {
		Text = "Set the physical size of the prop. This does NOT affect its appearance, only how you collide with it and move it with the Physgun. 75 by 10 is a good size to use for most characters.",
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
		Command = "animprop_drawselectionhalo"
	})
end