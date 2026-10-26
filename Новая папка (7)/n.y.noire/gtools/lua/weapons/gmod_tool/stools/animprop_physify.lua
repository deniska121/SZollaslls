--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/weapons/gmod_tool/stools/animprop_physify.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Animated Props"
TOOL.Name = "Anim - Give Physics"
TOOL.Command = nil
TOOL.ConfigName = "" 
 
TOOL.ClientConVar[ "usesamemodel" ] = "0"
TOOL.ClientConVar[ "premademodelsize" ] = "3"


if ( CLIENT ) then
	language.Add( "tool.animprop_physify.name", "Animated Props - Give Physics" )
	language.Add( "tool.animprop_physify.desc", "Attaches physics models to animated props, so they can be welded, moved around, and more" )
	language.Add( "tool.animprop_physify.0", "Click an animated prop to give it a physics model" )
end


function TOOL:LeftClick( trace )

	local ply = self:GetOwner()

	if ( trace.Entity:IsValid() && trace.Entity:GetClass() == "animprop_generic" ) then
		self:PhysifyAnimprop(trace.Entity)
		return true
	end

end


function TOOL:PhysifyAnimprop(ent)
	if !ent:IsValid() then return end
	if (ent.IsPhysified == true) then return end

	if CLIENT then return true end

	local oldangle = ent:GetAngles()
	ent:SetAngles(Angle(0,0,0))

	ent:PhysicsInit( SOLID_VPHYSICS )
	ent:SetMoveType( MOVETYPE_VPHYSICS )
	ent:SetSolid( SOLID_NONE )
	constraint.AdvBallsocket(ent, game.GetWorld(), ent:GetPhysicsObjectNum(1), NULL, ent:GetPos(), Vector(0,0,0), 0, 0, -180, -180, -180, 180, 180, 180, 0, 0, 0, 1, 1) //nocollide it with the world
	ent.IsPhysified = true

	local physent = ents.Create( "animprop_generic_physmodel" )
	if (!physent:IsValid()) then return false end

	physent:SetPlayer( ply )
	//physent:SetPos( ent:GetPos() )
	//physent:SetAngles( ent:GetAngles() )



	local useownmodel = self:GetClientNumber( "usesamemodel" )

	if useownmodel == 0 then
		local modelsize = self:GetClientNumber( "premademodelsize" )
		if modelsize == 1 then		//headcrab size
			physent:SetModel( "models/hunter/blocks/cube05x05x05.mdl" )
			physent:SetPos( ent:GetPos() + Vector(0,0,12) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		end
		if modelsize == 2 then		//small size
			physent:SetModel( "models/hunter/blocks/cube05x1x05.mdl" )
			physent:SetPos( ent:GetPos() + Vector(0,0,24) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		end
		if modelsize == 3 then		//normal character size
			physent:SetModel( "models/hunter/blocks/cube05x105x05.mdl" )
			physent:SetPos( ent:GetPos() + Vector(0,0,36) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		end
		if modelsize == 4 then		//d0g size
			physent:SetModel( "models/hunter/blocks/cube075x2x075.mdl" )
			physent:SetPos( ent:GetPos() + Vector(8,5,48) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		end
		if modelsize == 5 then		//giant robot size
			physent:SetModel( "models/hunter/blocks/cube1x3x1.mdl" )
			physent:SetPos( ent:GetPos() + Vector(10,0,72) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		end
		if modelsize == 6 then		//very large size
			physent:SetModel( "models/hunter/blocks/cube4x6x4.mdl" )
			physent:SetPos( ent:GetPos() + Vector(16,50,144) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		end
		if modelsize == 7 then		//absurdly huge size
			physent:SetModel( "models/hunter/blocks/cube8x8x8.mdl" )
			physent:SetPos( ent:GetPos() + Vector(32,130,192) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		end
	else
		if !util.IsValidPhysicsObject(ent, 0) then
			if SERVER then
				self:GetOwner():SendLua("GAMEMODE:AddNotify('ERROR: Tried to use a model WITHOUT PHYSICS as a physics model! Go turn off Use Own Model!', NOTIFY_ERROR, 10)")
				self:GetOwner():SendLua("surface.PlaySound('buttons/button10.wav')")
			end
			physent:SetModel( "models/hunter/blocks/cube05x05x05.mdl" )
			physent:SetPos( ent:GetPos() + Vector(0,0,12) )
			physent:SetAngles( ent:GetAngles() + Angle(0,0,90) )
		else
			physent:SetModel( ent:GetModel() )
			physent:SetPos( ent:GetPos() )
			physent:SetAngles( ent:GetAngles() )
		end
	end

	physent:SetSkin(ent:GetSkin())
	physent.MyStoredModel = physent:GetModel()

	local uniqueid = 0
	uniqueid = math.random()
	ent.ConfirmationID = uniqueid
	physent.ConfirmationID = uniqueid
	//MsgN(physent.ConfirmationID) MsgN(ent.ConfirmationID)

	physent.ConfirmationModel = ent:GetModel()
	physent.ConfirmationAnim = ent.MyAnim
	physent.ConfirmationSkin = ent:GetSkin()

	ent:DeleteOnRemove(physent)
	physent:Spawn()
	physent:Activate()

	constraint.NoCollide(physent, ent, 0, 0)
	//constraint.Weld( physent, ent, 0, 0, 0)  //pretty buggy, causes animprop to jiggle around for some reason
	ent:SetParent(physent)

	physent:SetAngles(physent:GetAngles() + oldangle)

end
 

function TOOL.BuildCPanel( panel )

	panel:AddControl("Header", { 
		Text = "Animated Props - Give Physics", 
		Description = "" 
	})

	panel:AddControl( "Label", { Text = "Once you physify a prop, you won't be able to affect the animated model itself with anything besides the Animated Prop tools. If you want to, say, bonemerge something to it, do that BEFORE you give it physics.", Description	= "" }  )

	panel:AddControl( "Label", { Text = "", Description = "" }  )
	panel:AddControl( "Label", { Text = "", Description = "" }  )

	panel:AddControl("Slider", {
		Label = "Physics Model Size",
		Type = "Integer",
		Min = "1",
		Max = "7",
		Description = "", 
		Command = "animprop_physify_premademodelsize"
	})
	panel:AddControl( "Label", { Text = "1 - Headcrab size", Description = "" }  )
	panel:AddControl( "Label", { Text = "2 - Small character size", Description = "" }  )
	panel:AddControl( "Label", { Text = "3 - Normal character size", Description = "" }  )
	panel:AddControl( "Label", { Text = "4 - D0g size", Description = "" }  )
	panel:AddControl( "Label", { Text = "5 - Giant robot size", Description = "" }  )
	panel:AddControl( "Label", { Text = "6 - Very large size", Description = "" }  )
	panel:AddControl( "Label", { Text = "7 - Absurdly huge size", Description = "" }  )

	panel:AddControl( "Label", { Text = "", Description = "" }  )

	panel:AddControl( "CheckBox", {Label = "Use own model?", Description = "", Command = "animprop_physify_usesamemodel"})
	panel:AddControl( "Label", { Text = "Select this to use the prop itself as a phys model instead of a generic PHX block. Do NOT use with ragdolls!", Description	= "" }  )

	panel:AddControl( "Label", { Text = "", Description = "" }  )
	panel:AddControl( "Label", { Text = "", Description = "" }  )

	panel:AddControl( "Label", { Text = "WARNING: If you use this tool on a model without physics, it will not be able to dupe or save correctly. Physify effects at your own risk!", Description	= "" }  )

end