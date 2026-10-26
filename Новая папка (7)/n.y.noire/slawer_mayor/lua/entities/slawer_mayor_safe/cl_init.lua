--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/entities/slawer_mayor_safe/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include( "shared.lua" )

function ENT:Draw()
	self:DrawModel()
end

function ENT:SetAnim( strAnim, intSpeed )
	local strSequence, intDuration = self:LookupSequence( strAnim )
	if intDuration > 0 then
		self:SetCycle( 0 )
		self:ResetSequence( strSequence )
		self:SetPlaybackRate( intSpeed )
		self:SetCycle( 0 )
	end
end

Slawer.Mayor:NetReceive("ToggleSafeAnim", function(tbl)
	if tbl.ent && IsValid(Entity(tbl.ent)) then
		Entity(tbl.ent):SetAnim(tbl.open && "open" || "close", 1)
	end
end)