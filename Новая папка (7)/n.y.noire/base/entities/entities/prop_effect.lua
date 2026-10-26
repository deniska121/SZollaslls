--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/entities/entities/prop_effect.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


AddCSLuaFile()

if ( CLIENT ) then
	CreateConVar( "cl_draweffectrings", "1", 0, "Should the green effect rings be visible?" )
end

ENT.Type = "anim"

ENT.Spawnable = false

function ENT:Initialize()


	if ( SERVER ) then

		self.AttachedEntity = ents.Create( "prop_dynamic" )
		self.AttachedEntity:SetModel( self:GetModel() )
		self.AttachedEntity:SetAngles( self:GetAngles() )
		self.AttachedEntity:SetPos( self:GetPos() )
		self.AttachedEntity:SetSkin( self:GetSkin() )
		self.AttachedEntity:Spawn()
		self.AttachedEntity:SetParent( self )
		self.AttachedEntity:DrawShadow( false )

		self:SetModel( "models/hunter/plates/plate.mdl" )

		self:DeleteOnRemove( self.AttachedEntity )
		self.AttachedEntity:DeleteOnRemove( self )
		self:SetSolid( SOLID_VPHYSICS )
		self:SetMoveType( MOVETYPE_NONE )

		-- Set up our physics object here
		local phys = self:GetPhysicsObject()
		if ( IsValid( phys ) ) then
			phys:EnableGravity( false )
			phys:EnableDrag( false )
			phys:EnableMotion( false )
		end

		self:DrawShadow( false )
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )

	else

		local tab = ents.FindByClassAndParent( "prop_dynamic", self )
		if ( tab && IsValid( tab[ 1 ] ) ) then self.AttachedEntity = tab[ 1 ] end

	end

end

if CLIENT then

local Mat = CreateMaterial("ering1", "unlitGeneric", {
	["$basetexture"] = "models/debug/debugwhite",
})

function ENT:Draw( flags )

	local isDepthPass = ( bit.band( flags, STUDIO_SSAODEPTHTEXTURE ) != 0 || bit.band( flags, STUDIO_SHADOWDEPTHTEXTURE ) != 0 )
	if ( isDepthPass ) then return end

	if ( halo.RenderedEntity() == self ) then
		self.AttachedEntity:DrawModel( flags )
		return
	end

	if ( GetConVarNumber( "cl_draweffectrings" ) == 0 ) then return end

	local ply = LocalPlayer()
	local wep = ply:GetActiveWeapon()
	if ( !IsValid( wep ) ) then return end

	local weapon_name = wep:GetClass()
	if ( weapon_name != "weapon_physgun" && weapon_name != "gmod_tool" ) then
		return
	end

	render.ModelMaterialOverride(Mat)
	if ( self:BeingLookedAtByLocalPlayer() ) then
		render.SetColorModulation(0.329, 0.706, 0.878)
	else
		render.SetColorModulation(0.176, 1, 0.176)
	end
	render.SetBlend(1)
	self:DrawModel()
	render.SetColorModulation(1, 1, 1)
	render.ModelMaterialOverride()
	render.SetBlend(1)

end

end

-- Copied from base_gmodentity.lua
ENT.MaxWorldTipDistance = 256
function ENT:BeingLookedAtByLocalPlayer()
	local ply = LocalPlayer()
	if ( !IsValid( ply ) ) then return false end

	local view = ply:GetViewEntity()
	local dist = self.MaxWorldTipDistance
	dist = dist * dist

	-- If we're spectating a player, perform an eye trace
	if ( view:IsPlayer() ) then
		return view:EyePos():DistToSqr( self:GetPos() ) <= dist && view:GetEyeTrace().Entity == self
	end

	-- If we're not spectating a player, perform a manual trace from the entity's position
	local pos = view:GetPos()

	if ( pos:DistToSqr( self:GetPos() ) <= dist ) then
		return util.TraceLine( {
			start = pos,
			endpos = pos + ( view:GetAngles():Forward() * dist ),
			filter = view
		} ).Entity == self
	end

	return false
end

function ENT:PhysicsUpdate( physobj )

	if ( CLIENT ) then return end

	-- Don't do anything if the player isn't holding us
	if ( !self:IsPlayerHolding() && !self:IsConstrained() ) then

		physobj:SetVelocity( vector_origin )
		physobj:Sleep()

	end

end

function ENT:OnEntityCopyTableFinish( tab )

	-- We need to store the model of the attached entity
	-- Not the one we have here.
	tab.Model = self.AttachedEntity:GetModel()

	-- Store the attached entity's table so we can restore it after being pasted
	tab.AttachedEntityInfo = table.Copy( duplicator.CopyEntTable( self.AttachedEntity ) )
	tab.AttachedEntityInfo.Pos = nil -- Don't even save angles and position, we are a parented entity
	tab.AttachedEntityInfo.Angle = nil

	-- Do NOT store the attached entity itself in our table!
	-- Otherwise, if we copy-paste the prop with the duplicator, its AttachedEntity value will point towards the original prop's attached entity instead, and that'll break stuff
	tab.AttachedEntity = nil

end

function ENT:PostEntityPaste( ply )

	-- Restore the attached entity using the information we've saved
	if ( IsValid( self.AttachedEntity ) && self.AttachedEntityInfo ) then

		-- Apply skin, bodygroups, bone manipulator, etc.
		duplicator.DoGeneric( self.AttachedEntity, self.AttachedEntityInfo )

		if ( self.AttachedEntityInfo.EntityMods ) then
			self.AttachedEntity.EntityMods = table.Copy( self.AttachedEntityInfo.EntityMods )
			duplicator.ApplyEntityModifiers( ply, self.AttachedEntity )
		end

		if ( self.AttachedEntityInfo.BoneMods ) then
			self.AttachedEntity.BoneMods = table.Copy( self.AttachedEntityInfo.BoneMods )
			duplicator.ApplyBoneModifiers( ply, self.AttachedEntity )
		end

		self.AttachedEntityInfo = nil

	end

end
