--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/mc_quests/lua/entities/mqs_ent/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Quest Item"
ENT.Author = "Mactavish"

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "CModel")
	self:NetworkVar("Entity", 0, "TPly")
	self:NetworkVar("Entity", 1, "Reroot")
	self:NetworkVar("Bool", 0, "Distractible")
	self:NetworkVar("Bool", 1, "EnablePhys")
	self:NetworkVar("Bool", 2, "ShowPointer")
	self:NetworkVar("Bool", 3, "PA")
	self:NetworkVar("Int", 0, "UseHold")
	self:NetworkVar("Float", 0, "PickProgress")
	self:NetworkVar("Float", 1, "HP")
end

function ENT:CreateLoopingSound(id, path, level, replay, parent)
	local snd = self.sounds[id]

	if not snd then
		snd = CreateSound(parent or self, path)
		snd:SetSoundLevel(level)
		self.sounds[id] = snd

		if replay then
			snd:Play()
		end
	end

	return snd
end

function ENT:CreateFastSound(id, path, level, parent)
	local snd = self.sounds[id]

	if snd then
		snd:Stop()
	end

	snd = CreateSound(parent or self, path)
	snd:SetSoundLevel(level)
	self.sounds[id] = snd

	return snd
end

function ENT:StopLoopSounds(id)
	local snd = self.sounds[id]

	if snd then
		snd:Stop()
		self.sounds[id] = nil
	end
end