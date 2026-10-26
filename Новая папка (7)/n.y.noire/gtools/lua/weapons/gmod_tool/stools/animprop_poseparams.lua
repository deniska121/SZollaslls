--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/animprop_poseparams.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Animated Props"
TOOL.Name = "Anim - Pose Params"
TOOL.Command = nil
TOOL.ConfigName = nil

TOOL.ClientConVar["aimpitch"] = "0"
TOOL.ClientConVar["aimyaw"] = "0"
TOOL.ClientConVar["invert"] = "0"
TOOL.ClientConVar["limityaw"] = "0"

TOOL.ClientConVar["movex"] = "1"
TOOL.ClientConVar["movey"] = "0"
TOOL.ClientConVar["moveyaw"] = "0"

TOOL.ClientConVar[ "drawselectionhalo" ] = "1"

TOOL.SelectedEnt = nil

if CLIENT then
	language.Add( "tool.animprop_poseparams.name", "Animated Props - Pose Parameters" )
	language.Add( "tool.animprop_poseparams.desc", "Change where characters are facing and control their walk animations" )
	language.Add( "tool.animprop_poseparams.0", "Right click to select an animated prop. Left click to aim the selected prop, or use the context menu to control other options. Right click away to deselect." )
end

function TOOL:LeftClick(tr)
	if (CLIENT) then return true end
	
	if self.SelectedEnt and self.SelectedEnt:IsValid() then
		local resultoffset = ( 60 * self.SelectedEnt:GetModelScale() )

		local resultinvert = 180
		local yawmultiplier = 1
		if (tonumber(self:GetClientInfo("invert")) == 0) then resultinvert = 180 end
		if (tonumber(self:GetClientInfo("invert")) == 1) then resultinvert = -180 end
		if (tonumber(self:GetClientInfo("limityaw")) == 0) then yawmultiplier = 1 end
		if (tonumber(self:GetClientInfo("limityaw")) == 1) then yawmultiplier = 0.5 end

		local off = tr.HitPos - ( self.SelectedEnt:GetPos() + Vector(0,0,resultoffset) )
		local sAng = self.SelectedEnt:GetAngles()
		local sFw = sAng:Forward()
		local sRt = sAng:Right()
		local sUp = sAng:Up()
			
		local rOff = off:Dot(sRt)
		local fOff = off:Dot(sFw)
		local uOff = off:Dot(sUp)
		self.SelectedEnt:SetPoseParameter("body_yaw",(math.atan2(rOff,fOff) * (resultinvert * yawmultiplier) / math.pi))
		self.SelectedEnt:SetPoseParameter("body_pitch",(math.atan2(uOff,(off - uOff * sUp):Length()) * resultinvert / math.pi))

		self.SelectedEnt:SetPoseParameter("aim_yaw",(math.atan2(rOff,fOff) * (resultinvert * yawmultiplier) / math.pi))
		self.SelectedEnt:SetPoseParameter("aim_pitch",(math.atan2(uOff,(off - uOff * sUp):Length()) * resultinvert / math.pi))

		self.SelectedEnt.StoredAimYaw = (math.atan2(rOff,fOff) * (resultinvert * yawmultiplier) / math.pi)
		self.SelectedEnt.StoredAimPitch = (math.atan2(uOff,(off - uOff * sUp):Length()) * resultinvert / math.pi)
		self:GetOwner():ConCommand("animprop_poseparams_aimyaw "..self.SelectedEnt.StoredAimYaw.."\n")
		self:GetOwner():ConCommand("animprop_poseparams_aimpitch "..self.SelectedEnt.StoredAimPitch.."\n")

	end
	return true
end

function TOOL:RightClick(trace)
	if CLIENT then return true end

	local tr = trace
	//if we clicked on an animprop, then select it
	if tr.Entity && tr.Entity:IsValid() && tr.Entity:GetClass() == "animprop_generic" then
		self:GetWeapon():SetNWEntity( 1, tr.Entity )
		self.SelectedEnt = tr.Entity

		local owner = self:GetOwner()
		owner:ConCommand("animprop_poseparams_movex "..trace.Entity.StoredMoveX.."\n")
		owner:ConCommand("animprop_poseparams_movey "..trace.Entity.StoredMoveY.."\n")
		owner:ConCommand("animprop_poseparams_moveyaw "..trace.Entity.StoredMoveYaw.."\n")
		owner:ConCommand("animprop_poseparams_aimyaw "..trace.Entity.StoredAimYaw.."\n")
		owner:ConCommand("animprop_poseparams_aimpitch "..trace.Entity.StoredAimPitch.."\n")
		return true
	end
	//if we clicked on an animprop_physmodel, then select its animprop
	if tr.Entity && tr.Entity:IsValid() && tr.Entity:GetClass() == "animprop_generic_physmodel" && tr.Entity.MyEntity:IsValid() then
		self:GetWeapon():SetNWEntity( 1, tr.Entity.MyEntity )
		self.SelectedEnt = tr.Entity.MyEntity

		local owner = self:GetOwner()
		owner:ConCommand("animprop_poseparams_movex "..trace.Entity.MyEntity.StoredMoveX.."\n")
		owner:ConCommand("animprop_poseparams_movey "..trace.Entity.MyEntity.StoredMoveY.."\n")
		owner:ConCommand("animprop_poseparams_moveyaw "..trace.Entity.MyEntity.StoredMoveYaw.."\n")
		owner:ConCommand("animprop_poseparams_aimyaw "..trace.Entity.MyEntity.StoredAimYaw.."\n")
		owner:ConCommand("animprop_poseparams_aimpitch "..trace.Entity.MyEntity.StoredAimPitch.."\n")
		return true
	end
	//if we didn't click on anything, then deselect
	if !tr.Entity:IsValid() then
		if self.SelectedEnt and self.SelectedEnt:IsValid() then
			self:GetWeapon():SetNWEntity( 1, NULL )
			self.SelectedEnt = nil
			return true
		end
	end
end

//function TOOL:Reload(tr)
//end



function TOOL:DrawHUD()
	if self:GetClientNumber( "drawselectionhalo" ) == 1 then
		//local ent = self.SelectedEnt
		local ent = self:GetWeapon():GetNWEntity( 1 )
		if ent:IsValid() then
			halo.Add( {ent}, Color(255, 255, 189 + math.cos( RealTime() * 4 ) * 17, 255), 2.3, 2.3, 1, true, false )
		end
	end
end



function TOOL:Think()
	if ( !IsValid(self.SelectedEnt) ) then return end
	self.SelectedEnt:SetPoseParameter("move_x",self:GetClientInfo("movex"))
	self.SelectedEnt:SetPoseParameter("move_y",self:GetClientInfo("movey"))
	self.SelectedEnt:SetPoseParameter("move_yaw",self:GetClientInfo("moveyaw"))

	self.SelectedEnt.StoredMoveX = tonumber(self:GetClientInfo("movex"))
	self.SelectedEnt.StoredMoveY = tonumber(self:GetClientInfo("movey"))
	self.SelectedEnt.StoredMoveYaw = tonumber(self:GetClientInfo("moveyaw"))

	self.SelectedEnt:SetPoseParameter("aim_pitch",self:GetClientInfo("aimpitch"))
	self.SelectedEnt:SetPoseParameter("aim_yaw",self:GetClientInfo("aimyaw"))
	self.SelectedEnt:SetPoseParameter("body_pitch",self:GetClientInfo("aimpitch"))
	self.SelectedEnt:SetPoseParameter("body_yaw",self:GetClientInfo("aimyaw"))

	self.SelectedEnt.StoredAimPitch = tonumber(self:GetClientInfo("aimpitch"))
	self.SelectedEnt.StoredAimYaw = tonumber(self:GetClientInfo("aimyaw"))
end

function TOOL:Holster()
	if self.SelectedEnt and self.SelectedEnt:IsValid() then
		self:GetWeapon():SetNWEntity( 1, NULL )
		self.SelectedEnt = nil
	end
end

function TOOL.BuildCPanel(panel)
	panel:AddControl("Header", {
		Text = "Animated Props - Pose Parameters", 
		Description	= ""
	})

	panel:AddControl("Slider", {
		Label = "Aim Pitch (up, down)",
	 	Type = "Float",
		Min = "-89.99",
		Max = "89.99",
		Description = "", 
		Command = "animprop_poseparams_aimpitch"
	})
	panel:AddControl("Slider", {
		Label = "Aim Yaw (left, right)",
	 	Type = "Float",
		Min = "-44.99",
		Max = "44.99",
		Description = "", 
		Command = "animprop_poseparams_aimyaw"
	})

	panel:AddControl( "Label", { Text = "With a prop selected, either left click or use these sliders to control where the character is aiming.", Description	= "" }  )

	panel:AddControl( "Label", { Text = "", Description	= "" }  )

	panel:AddControl("CheckBox", {Label = "Invert?", Description = "", Command = "animprop_poseparams_invert"})
	panel:AddControl( "Label", { Text = "If the model seems to be aiming 'backwards', try checking this. For example, this should be used for HL2 characters and GMod players, but not TF2 players.", Description	= "" }  )
	panel:AddControl("CheckBox", {Label = "Limit Yaw?", Description = "", Command = "animprop_poseparams_limityaw"})
	panel:AddControl( "Label", { Text = "If the model is aiming too far to the left or right, check this.", Description	= "" }  )

	panel:AddControl( "Label", { Text = "", Description	= "" }  )
	panel:AddControl( "Label", { Text = "", Description	= "" }  )

	panel:AddControl("Slider", {
		Label = "Move X (forward, back)",
	 	Type = "Float",
		Min = "-1",
		Max = "1",
		Description = "", 
		Command = "animprop_poseparams_movex"
	})
	panel:AddControl("Slider", {
		Label = "Move Y (left, right)",
	 	Type = "Float",
		Min = "-1",
		Max = "1",
		Description = "", 
		Command = "animprop_poseparams_movey"
	})
	panel:AddControl("Slider", {
		Label = "Move Yaw (all directions)",
	 	Type = "Float",
		Min = "-179",
		Max = "180",
		Description = "", 
		Command = "animprop_poseparams_moveyaw"
	})
	panel:AddControl( "Label", { Text = "If the prop is using a move animation, control what direction it's moving in. Generally, players use Move X and Y, while NPCs use Move Yaw, but there are exceptions, so if one doesn't work then try the other.", Description	= "" }  )

	panel:AddControl( "Label", { Text = "", Description	= "" }  )
	panel:AddControl( "Label", { Text = "", Description	= "" }  )

	panel:AddControl("CheckBox", {
		Label = "Draw selection halo",
		Description = "", 
		Command = "animprop_poseparams_drawselectionhalo"
	})
end
