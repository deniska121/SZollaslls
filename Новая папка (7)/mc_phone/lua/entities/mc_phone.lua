-- "addons\\mc_phone\\lua\\entities\\mc_phone.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Mc Phone"
ENT.Author = "Mactavish"
ENT.Category = "McPhone"
ENT.Spawnable = true
ENT.AdminOnly = true
ENT.AdminSpawnable = false
if CLIENT then return end

function ENT:Initialize()
	self:SetModel("models/mactavish/mactavish_phone.mdl")
	self:SetColor(Color(80, 130, 200))
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	local phys = self:GetPhysicsObject()
	phys:Wake()

	self.profile = {
		Ringtone = McPhone.Bloom.Ringtone["3"],
		Smstone = McPhone.NotificationTone["1"],
		Sleep = false,
		NoNotf = false,
		PhoneColor = Color(80, 130, 200),
		WallPaper = "phone_wallpaper_McPhonedefault.png",
		PhoneType = "McPhone"
	}
end
