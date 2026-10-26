--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/entities/base_gmodentity.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


AddCSLuaFile()
DEFINE_BASECLASS( "base_anim" )

ENT.Spawnable = false

if ( CLIENT ) then
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

	function ENT:Think()
		local text = self:GetOverlayText()

		if ( text != "" && self:BeingLookedAtByLocalPlayer() && !self:GetNoDraw() ) then
			AddWorldTip( self:EntIndex(), text, 0.5, self:GetPos(), self )

			--halo.Add( { self }, color_white, 1, 1, 1, true, true )
		end
	end
end

function ENT:SetOverlayText( text )
	self:SetNWString( "GModOverlayText", text )
end

function ENT:GetOverlayText()

	local txt = self:GetNWString( "GModOverlayText" )

	if ( txt == "" ) then
		return ""
	end

	if ( game.SinglePlayer() ) then
		return txt
	end

	local PlayerName = self:GetPlayerName()

	return txt .. "\n(" .. PlayerName .. ")"

end

function ENT:SetPlayer( ply )

	self.Founder = ply

	if ( IsValid( ply ) ) then

		self:SetNWString( "FounderName", ply:Nick() )
		self.FounderSID = ply:SteamID64()
		self.FounderIndex = ply:UniqueID()

	else

		self:SetNWString( "FounderName", "" )
		self.FounderSID = nil
		self.FounderIndex = nil

	end

end

function ENT:GetPlayer()

	if ( self.Founder == nil ) then

		-- SetPlayer has not been called
		return NULL

	elseif ( IsValid( self.Founder ) ) then

		-- Normal operations
		return self.Founder

	end

	-- See if the player has left the server then rejoined
	local ply = player.GetBySteamID64( self.FounderSID )
	if ( not IsValid( ply ) ) then

		-- Oh well
		return NULL

	end

	-- Save us the check next time
	self:SetPlayer( ply )
	return ply

end

function ENT:GetPlayerIndex()

	return self.FounderIndex or 0

end

function ENT:GetPlayerSteamID()

	return self.FounderSID or ""

end

function ENT:GetPlayerName()

	local ply = self:GetPlayer()
	if ( IsValid( ply ) ) then
		return ply:Nick()
	end

	return self:GetNWString( "FounderName" )

end
