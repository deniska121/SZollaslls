-- "addons\\mc_quests\\lua\\entities\\mqs_ent\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
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