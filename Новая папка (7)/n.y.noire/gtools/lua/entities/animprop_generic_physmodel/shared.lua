--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/animprop_generic_physmodel/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile("shared.lua")

ENT.Type 			= "anim"
ENT.Base 			= "base_gmodentity"
ENT.PrintName			= "Animated Prop Physmodel"
ENT.Author			= ""
ENT.Category			= "Animated Props"

ENT.RenderGroup			= RENDERGROUP_NONE

ENT.Spawnable			= false
ENT.AdminSpawnable		= false

ENT.MyEntity			= nil
ENT.MyStoredModel		= ""
ENT.FoundAnimprop		= false

//At the moment an animprop is physified, both it and its physmodel are given a unique, random ID number. When the two entities are duped, the game only lets the physmodel 
//reconnect to an animprop with a matching ID, so that if there are multiple animprops and physmodels constrained together, only the correct entities get paired up. The chance
//of two pairs of entities getting the same ID is less than one in a quadrillion, but just in case (lol), I also left in this old system that matches up Model, Anim, and Skin,
//that I went and coded before I came up with the idea for the random number ID. (What have I got to lose by keeping it, right?)
ENT.ConfirmationID		= 0
ENT.ConfirmationModel		= ""
ENT.ConfirmationAnim		= ""
ENT.ConfirmationSkin		= 0




function ENT:Initialize()

	if SERVER then
		//self:SetModel( "models/hunter/blocks/cube05x1x05.mdl" )
		//self.MyStoredModel = self:GetModel()

		self:PhysicsInit( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_VPHYSICS )
		self:SetSolid( SOLID_VPHYSICS )

		if util.IsValidPhysicsObject(self, 0) then self:GetPhysicsObject():EnableMotion(false) end   //freeze this ent until we've found our animprop, so it isn't misaligned
	end

	self:SetNoDraw(true)

end

function ENT:Think()

	if self:GetModel() != self.MyStoredModel then self:SetModel(self.MyStoredModel) end

	if self.FoundAnimprop == true then return end
	if CLIENT then return end
	for _, Entity in pairs( constraint.GetAllConstrainedEntities( self ) ) do
		if (Entity:GetClass() == "animprop_generic" or "animprop_spawntank" or "animprop_spawntank_moving" or "animprop_spawntank_deploy") and (Entity.IsPhysified == true)
		and Entity.ConfirmationID == self.ConfirmationID and Entity:GetModel() == self.ConfirmationModel and Entity.MyAnim == self.ConfirmationAnim and Entity:GetSkin() == self.ConfirmationSkin then
			Entity:SetParent(self)
			Entity:DeleteOnRemove(self)
			if util.IsValidPhysicsObject(self, 0) then self:GetPhysicsObject():EnableMotion(true) end
			self.MyEntity = Entity
			self.FoundAnimprop = true	//stop searching for our animprop

			//randomize our confirmationid, so if we get duped, the dupe will have a different id than the original
			local uniqueid = 0
			uniqueid = math.random()
			Entity.ConfirmationID = uniqueid
			self.ConfirmationID = uniqueid
			//MsgN(self.ConfirmationID) MsgN(Entity.ConfirmationID)
		end
	end

end




if SERVER then
function DupeAnimpropPhysmodel( ply, data, Pos, Angle, model, confirmmodel, confirmanim, confirmskin, confirmid )

	local dupedent = ents.Create( "animprop_generic_physmodel" )
	if (!dupedent:IsValid()) then return false end

	duplicator.DoGeneric( dupedent, data )
	dupedent:SetPlayer( ply )
	dupedent.MyStoredModel = model

	dupedent.ConfirmationID	= confirmid
	dupedent.ConfirmationModel = confirmmodel
	dupedent.ConfirmationAnim = confirmanim
	dupedent.ConfirmationSkin = confirmskin

	dupedent:Spawn()
	dupedent:Activate()

	return dupedent

end
end




duplicator.RegisterEntityClass( "animprop_generic_physmodel", DupeAnimpropPhysmodel, "Data", "Pos", "Angle", "Model", "ConfirmationModel", "ConfirmationAnim", "ConfirmationSkin", "ConfirmationID" )




if CLIENT then

language.Add("animprop_generic_physmodel", "Animated Prop Physmodel")

end