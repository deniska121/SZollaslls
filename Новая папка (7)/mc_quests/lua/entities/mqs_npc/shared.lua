-- "addons\\mc_quests\\lua\\entities\\mqs_npc\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
ENT.Type = "ai"
ENT.Base = "base_anim"
ENT.PrintName = "MQS Quest NPC"
ENT.Author = "Mactavish"
ENT.Spawnable = false
ENT.AdminSpawnable = true

function ENT:SetupDataTables()
	self:NetworkVar("String", 0, "Namer")
	self:NetworkVar("Int", 1, "UID")
end