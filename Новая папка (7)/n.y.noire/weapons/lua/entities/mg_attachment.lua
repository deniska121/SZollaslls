--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/entities/mg_attachment.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()
ENT.Type = "anim"
ENT.RenderGroup = RENDERGROUP_OTHER

function ENT:SetupDataTables()
	self:NetworkVar("Int", 0, "Slot")
	self:NetworkVar("Int", 1, "Index")
end

function ENT:Initialize()
	if (not IsValid(self:GetOwner())) then
		return
	end

	self:AddEFlags(EFL_KEEP_ON_RECREATE_ENTITIES)
	self:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)
	self:AddEFlags(EFL_NO_THINK_FUNCTION)
	self:AddEFlags(EFL_NO_GAME_PHYSICS_SIMULATION)
	self:AddEFlags(EFL_DONTBLOCKLOS)
	self:AddEFlags(EFL_DONTWALKON)
	self:AddEFlags(EFL_NO_DISSOLVE)
	self:AddEFlags(EFL_NO_PHYSCANNON_INTERACTION)
	self:AddEFlags(EFL_NO_DAMAGE_FORCES)
	self:AddFlags(FL_NOTARGET)
	self:AddFlags(FL_DONTTOUCH)
	self:AddFlags(FL_STEPMOVEMENT)
	self:SetNoDraw(true)
	self:SetMoveType(MOVETYPE_NONE)
	self:SetSolid(SOLID_NONE)
	local weapon = self:GetOwner()

	if (SERVER) then
		for _, child in pairs(weapon:GetChildren()) do
			if (child:GetClass() == "mg_attachment" and child:GetSlot() == self:GetSlot() and child ~= self) then
				child:Remove()
			end
		end
	end

	if not weapon.Attach then timer.Simple(5, function()
		if not IsValid(weapon) or not IsValid(self) then return end
		weapon:Attach(self:GetSlot(), self:GetIndex())
	end) return end

	weapon:Attach(self:GetSlot(), self:GetIndex())
end