--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/entities/boom_box.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

ENT.Type = "anim"
ENT.Base = "base_edit"
ENT.PrintName = "BoomBox"
ENT.Author = "Mac"
ENT.Spawnable = false
ENT.AdminSpawnable = false

function ENT:SetupDataTables()
	self:NetworkVar("Entity",0,"owning_ent")
	self:NetworkVar("Float",0,"StartTime")
	self:NetworkVar("Float",1,"Volume", { KeyName = "Volume", Edit = { type = "Float", min = 0, max = 3, order = 3 } })
	self:NetworkVar("Float", 2, "VStart", { KeyName = "Start", Edit = { type = "Float", min = 200, max = 100000, order = 1 } } )
	self:NetworkVar("Float", 3, "VEnd", { KeyName = "End", Edit = { type = "Float", min = 300, max = 1000000, order = 2 } } )
	self:NetworkVar("String",0,"URL", { KeyName = "URL", Edit = { type = "String" , order = 4} })
	self:NetworkVar("Bool",0,"Playing", { KeyName = "Playing", Edit = { type = "Boolean" , order = 5} })
end

if CLIENT then
	function ENT:Think()
		if self:GetPlaying() and not IsValid(self.sound) and not self.sounnset then
			self.sounnset = true
			sound.PlayURL( self:GetURL(), "3d noblock", function( station )
				if ( IsValid( station ) ) then
					station:SetPos( self:GetPos() )
					station:Play()
					station:SetVolume(self:GetVolume())
					station:SetTime(CurTime() - self:GetStartTime())
					self.sound = station
					self.sounnset = nil
					print("boob BOX!")
				else
					self.sounnset = nil
					print("boob BOX!")
				end
			end )
		end

		if IsValid(self.sound) then
			self.sound:SetPos( self:GetPos() )

			if not self.vend or self:GetVEnd() ~= self.vend then
				self.sound:Set3DFadeDistance( self:GetVStart(), self:GetVEnd() )
				self.vend = self:GetVEnd()
			end

			if self:GetVolume() ~= self.sound:GetVolume() then
				self.sound:SetVolume(self:GetVolume())
			end

			if self.sound:GetState() == GMOD_CHANNEL_STOPPED then
				self.sound:SetTime(0)
				self.sound:Play()
			end
		end

		if not self:GetPlaying() and IsValid(self.sound) then
			self.sound:Stop()
			self.sound = nil
			self.sounnset = nil
		end
	end

	function ENT:OnRemove()
		if IsValid(self.sound) then
			self.sound:Stop()
			self.sound = nil
			self.sounnset = nil
		end
	end

	-- local g = Color( 0, 175, 67, 100)
	-- local r = Color( 204, 109, 0, 100)
	-- function ENT:Draw()
	-- 	self:DrawModel()
	-- 	render.SetColorMaterial()
	-- 	render.DrawSphere( self:GetPos(), self:GetVStart(), 30, 30, g)
	-- 	render.DrawSphere( self:GetPos(), -self:GetVStart(), 30, 30, g)

	-- 	render.DrawSphere( self:GetPos(), self:GetVEnd(), 30, 30, r)
	-- 	render.DrawSphere( self:GetPos(), -self:GetVEnd(), 30, 30, r)
	-- end

	return
end

--McPhone.SendSMS("Аноним", "УБЛЮДКИ ИЗ МАТЕЛЯ эти критины спиздили мой товар кто найдет мои таблетки в мотели и пришьет всех этих уебанов получит от меня 10000 зеленых После дела отправлю смс", nil, team.GetPlayers(TEAM_GANG))
--McPhone.SendSMS("Аноним", "БЫСТРЕЕ БЛЯТЬ", nil, team.GetPlayers(TEAM_GANG))

function ENT:Initialize()
	self:SetModel("models/uc/props_club/floor_speaker.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:SetSolid(SOLID_VPHYSICS)
	self:DrawShadow(false)
	self:SetPlaying(false)
	self:SetVolume(1)
	self:SetVStart(200)
	self:SetVEnd(10000)

	local phys = self:GetPhysicsObject()

	if (phys:IsValid()) then
		phys:Wake()
	end
end

function ENT:Use(activator)
	if self.UseDelay and self.UseDelay > CurTime() then return end
	self.UseDelay = CurTime() + 1
	--self:SetPlaying(false)
end

concommand.Add("boombox_play", function(ply, cmd, args)
	if DarkRP.NetDelay(ply, 1) then return end
	if not args[1] then return end

	local ent = ply:GetEyeTrace().Entity

	if not IsValid(ent) or ent:GetClass() ~= "edit_sky" then return end

	if ent:GetPlaying() then
		ent:SetPlaying(false)
		return
	end

	ent:SetPlaying(true)
	ent:SetURL(args[1])

	local time = args[2] and tonumber(args[2]) or 0
	ent:SetStartTime(CurTime() + time)
end)

concommand.Add("boombox_volume", function(ply, cmd, args)
	if DarkRP.NetDelay(ply, 1) then return end
	if not args[1] then return end

	local ent = ply:GetEyeTrace().Entity

	if not IsValid(ent) or ent:GetClass() ~= "edit_sky" then return end

	local vol = args[1] and tonumber(args[1]) or 0

	ent:SetVolume(math.Clamp(vol, 0, 3))
end)