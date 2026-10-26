--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/gtools/lua/entities/gesturizerent.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

ENT.Base 			= "base_gmodentity"
ENT.PrintName			= "Gesturizer Entity"
ENT.Author			= ""

ENT.Spawnable			= false
ENT.AdminSpawnable		= false
ENT.RenderGroup			= RENDERGROUP_NONE




function ENT:SetupDataTables()

	self:NetworkVar( "Entity", 0, "TargetEnt" );
	self:NetworkVar( "String", 0, "AnimName" );
	self:NetworkVar( "Float", 1, "RepeatRate" );

end




function ENT:Initialize()

	local target = self:GetTargetEnt()

	self:SetNoDraw(true)

	if self:GetRepeatRate() > 0 then
		self.NextRepeat = 0
	else
		//someone was dumb and set it to never repeat, so let's play the gesture once and then delete ourselves
		self:PlayGesture(true)
	end
end




function ENT:Think()

	//if SERVER then return end

	if self:GetRepeatRate() > 0 then
		if !( self.NextRepeat > CurTime() ) then
			self:PlayGesture(false)
			self.NextRepeat = CurTime() + self:GetRepeatRate()
		end
	end
	
	self:NextThink(CurTime())
	return true

end




function ENT:PlayGesture(shouldweremoveourselves)

	if CLIENT then return end

	local target = self:GetTargetEnt()
	local animname	= self:GetAnimName()
	if animname == nil or !target:IsValid() then self:Remove() return end

	local gesturesequence = target:LookupSequence(animname)
	local gesture = target:GetSequenceActivity(gesturesequence)
	target:RestartGesture(gesture)

	//if shouldweremoveourselves == true then
	//	remove ourselves, remove the entity modifier from our target
	//end

end

//prevents the entity from being duplicated
duplicator.RegisterEntityClass( "gesturizerent", function( ply, data )
    //PrintTable( data )
    //duplicator.GenericDuplicatorFunction( ply, data )
end, "Data" )