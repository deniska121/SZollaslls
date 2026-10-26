-- "addons\\weapons\\lua\\weapons\\mg_base\\shared.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
--ArachnitCZ is cool and awesome and perfect and epic and he beat me and ViperCZ
AddCSLuaFile()


function clearBaseClass(t)
	t.BaseClass = nil

	for i, v in pairs(t) do
		if (istable(v)) then
			clearBaseClass(v)
		end
	end
end

function SWEP:GetStoredAttachment(ind)
	if (istable(ind)) then
		PrintTable(ind)
		error("Something went wrong when loading an attachment! Probably still using old customization method (read above for info).")
	end

	if (MW_ATTS[ind] == nil) then
		error("Attachment " .. (ind ~= nil and ind or "none") .. " is missing!")
	end

	return MW_ATTS[ind]
end

SWEP.Category = "MG"
SWEP.IsMWwp = true
SWEP.Spawnable = false
SWEP.AdminOnly = false
SWEP.PrintName = "Base Weapon"
SWEP.Base = "weapon_base"
SWEP.BounceWeaponIcon = false
SWEP.m_WeaponDeploySpeed = 12 --fastest it can be because Think freezes when weapon is drawing
SWEP.ViewModel = "models/weapons/c_arms.mdl"
SWEP.VModel = "models/weapons/v_357.mdl"
SWEP.RenderGroup = RENDERGROUP_OPAQUE
SWEP.RenderMode = RENDERMODE_ENVIROMENTAL
SWEP.ViewModelFlip = false
SWEP.ViewModelFOV = 64
SWEP.WorldModel = "models/weapons/w_357.mdl"
SWEP.AutoSwitchFrom = false
SWEP.AutoSwitchTo = false
SWEP.BobScale = 0
SWEP.SwayScale = 100
SWEP.DrawAmmo = true
SWEP.DrawCrosshair = false
SWEP.UseHands = false
SWEP.Primary.DefaultClip = 0
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Ammo = -1
SWEP.Resource = .001
SWEP.MalfunctionClear = "Equip"
SWEP.DontHide = false
SWEP.Unloader = {
	["mag_remove"] = 1,
	["skip_cycle"] = 0.5,
	["anim"] = "Reload_Empty",
}

--modules: 
-- shared
include("modules/shared/sh_think.lua")
include("modules/shared/sh_sprint_behaviour.lua")
include("modules/shared/sh_datatables.lua")
include("modules/shared/sh_aim_behaviour.lua")
include("modules/shared/sh_reload_behaviour.lua")
include("modules/shared/sh_melee_behaviour.lua")
include("modules/shared/sh_firemode_behaviour.lua")
include("modules/shared/sh_primaryattack_behaviour.lua")
include("modules/shared/sh_holdtypes.lua")
include("modules/shared/sh_customization.lua")
include("modules/shared/sh_stats.lua")
-- client
include("modules/client/cl_anim_think.lua")
include("modules/client/cl_calcviewmodelview.lua")
include("modules/client/cl_calcview.lua")
include("modules/client/cl_viewmodel_render.lua")
include("modules/client/cl_worldmodel_render.lua")
include("modules/client/cl_viewmodel_blur.lua")
--include("modules/client/cl_viewmodel_blur_bokeh.lua")
include("modules/client/cl_rigs.lua")
include("modules/client/cl_hud.lua")
include("modules/client/cl_spawnmenu.lua")
include("modules/client/cl_new_customizemenu.lua")
-- reverb
include("modules/reverb/mw_reverb.lua")
game.AddParticles("particles/ac_mw_handguns.pcf")
game.AddParticles("particles/mw19_attachments.pcf")
PrecacheParticleSystem("flashlight_mw19")

CreateConVar("mgbase_sv_pvpdamage", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "PvP damage multiplier", 0, 5)
CreateConVar("mgbase_sv_pvedamage", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "PvE damage multiplier", 0, 5)
CreateConVar("mgbase_sv_recoil", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Recoil multiplier", 0, 5)
CreateConVar("mgbase_sv_range", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Range multiplier", 0, 10)
CreateConVar("mgbase_sv_accuracy", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Accuracy multiplier", 0.01, 5)
CreateConVar("mgbase_sv_customization", "1", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Allow gun customization.", 0, 1)
CreateConVar("mgbase_sv_customization_limit", "0", {FCVAR_ARCHIVE, FCVAR_NOTIFY, FCVAR_REPLICATED}, "Attachments limit.", 0)
CreateConVar("mgbase_sv_aimassist", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Attachments limit.", 0, 1)
CreateConVar("mgbase_sv_breathing", "1", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Scope breathing.", 0, 1)
CreateConVar("mgbase_sv_full_penetration", "0", {FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Enables a more detailed penetration model.", 0, 1)
CreateConVar("mgbase_debug_reverb", "0", FCVAR_REPLICATED, "Show reverb.", 0, 1)
CreateConVar("mgbase_debug_range", "0", FCVAR_REPLICATED, "Show range at hit location.", 0, 1)
CreateConVar("mgbase_debug_projectiles", "0", FCVAR_REPLICATED, "Show projectiles info.", 0, 1)

SWEP.DistSound = "Reflection_Pistol.Distance"

function SWEP:PostAttachment(attachment)
	--do stuff on the gun
end

function SWEP:LookupBoneCached(model, name)
	if (model.cachedBones == nil) then
		model.cachedBones = {}
	end

	if (model.cachedBones[name] == nil) then
		model.cachedBones[name] = model:LookupBone(name)
	end

	return model.cachedBones[name]
end

function SWEP:RecreateClientsideModels(bAtts)
	if (not IsValid(self.m_ViewModel)) then
		self.m_ViewModel = ClientsideModel(self.VModel, self.RenderGroup)
		self.m_ViewModel:SetRenderMode(self.RenderMode)
		--self.m_ViewModel:SetPredictable(true)
		self.m_ViewModel:SetOwner(self)
		--self.m_ViewModel:SetMoveType(MOVETYPE_NONE)   
	end

	if (not IsValid(self.m_WorldModel)) then
		self.m_WorldModel = ClientsideModel(self.WorldModel, self.RenderGroup)
		self.m_WorldModel:SetRenderMode(self.RenderMode)
		--self.m_WorldModel:SetPredictable(true)
		self.m_WorldModel:SetOwner(self)
		--self.m_WorldModel:SetMoveType(MOVETYPE_NONE)
	end

	self:EnableDrawWorkaroundForNextFrame() --for some spectacular reason the viewmodel jumps to 25% of its draw animation when switching guns correctly

	if (bAtts) then
		--create models:
		for slot, attachment in pairs(self:GetAllAttachmentsInUse()) do
			self:CreateAttachmentModel(attachment)
			attachment:Init(self)
		end

		--bodygroups:
		for slot, att in pairs(self:GetAllAttachmentsInUse()) do
			if (att.Bodygroups ~= nil) then
				for bg, v in pairs(att.Bodygroups) do
					self:DoBodygroup(bg, v)
				end
			end
		end
	end
end

function SWEP:CreateAttachmentEntity(attachmentClass)
	if (CLIENT) then return end
	local att = ents.Create("mg_attachment")
	att:SetOwner(self)
	att:SetIndex(1)

	for slot, atts in pairs(self.Customization) do
		for ind, attachmentCls in pairs(atts) do
			if (attachmentClass == attachmentCls) then
				att:SetSlot(slot)
				att:SetIndex(ind)
				break
			end
		end
	end

	att:Spawn()
	att:SetPos(self:GetPos())
	att:SetParent(self)
	self:DeleteOnRemove(att)
end

function SWEP:CreateAttachmentForUse(attachmentClass)
	if (MW_ATTS[attachmentClass] == nil) then return end
	local slot = nil

	for s, atts in pairs(self.Customization) do
		--kinda slow whatever
		if (table.HasValue(atts, attachmentClass)) then
			slot = s
			break
		end
	end

	if (slot == nil) then return end
	local oldAtt = self:GetAttachmentInUseForSlot(slot)
	if (oldAtt ~= nil and oldAtt.ClassName == attachmentClass) then return end

	--it could be nil if we are customizing for the first time (just spawned)
	if (oldAtt ~= nil) then
		oldAtt:OnRemove(self)
	end

	local att = table.Copy(self:GetStoredAttachment(attachmentClass))

	if not self:IsAttachmentAllowed(attachmentClass) and att.SwapTo then
		att = table.Copy(self:GetStoredAttachment(att.SwapTo))
	end
	att.Slot = slot
	att.Index = 1

	for ind, attClass in pairs(self.Customization[slot]) do
		if (attClass == att.ClassName) then
			att.Index = ind
		end
	end

	self.m_CustomizationInUse[slot] = att

	return att
end

function SWEP:CreateAttachmentForEnts(attachmentClass, ent)
	if (MW_ATTS[attachmentClass] == nil) then return end
	local slot = nil

	for s, atts in pairs(self.Customization) do
		--kinda slow whatever
		if (table.HasValue(atts, attachmentClass)) then
			slot = s
			break
		end
	end

	if (slot == nil) then return end
	local att = table.Copy(MW_ATTS[attachmentClass])
	att.Slot = slot
	att.SlotName = attachmentClass
	att.Index = 1

	for ind, attClass in pairs(self.Customization[slot]) do
		if (attClass == att.ClassName) then
			att.Index = ind
		end
	end

	ent.m_CustomizationInUse[slot] = att

	return att
end

function SWEP:Initialize()
	self.m_bInitialized = true
	self.m_bHolstered = false
	self.m_bDrawn = false
	self.m_seqIndex = "INIT"
	self.m_nextSeqIndex = "INIT"
	self.m_OriginalViewModelFOV = self.ViewModelFOV
	self.bCustomize = false
	self.m_hybridSwitchThreshold = 0.4
	--self:SetNeedsToEquip(true)
	self:SetIsHolstering(false)
	self:SetNextHolsterTime(0)
	self:SetBreathingDelta(1)
	self:SetGunState(1)
	self:SetHasPumped(true)
	self:SetHasRunOutOfBreath(false)

	if self.NoPumpSycle then
		self:SetHasPumped(false)
	end

	if self.DidPumped ~= nil then
		self:SetHasPumped(self.DidPumped)
	end

	if CLIENT then
		self:RecreateClientsideModels(false)

		self.Camera = {
			Shake = 0,
			Fov = 0,
			LerpReloadFov = 0,
			LerpReloadBlur = 0,
			LerpCustomization = 0,
			LerpBreathing = Angle(0, 0, 0)
		}

		self.Particles = {}
		self.TpParticles = {}
		self.CantedReloadDisableDelta = 1
		self.m_AimModeDeltaLerp = Vector(0, 0, 0)
		self.m_AimModeDeltaVelocity = Vector(0, 0, 0)

		self.ViewModelVars = {
			LerpAimDelta = 0,
			LerpAimPos = Vector(0, 0, 0),
			LerpAimAngles = Angle(0, 0, 0),
			LerpJogOffset = 0,
			LerpJog = 0,
			LerpWalk = 0,
			bWasJogging = false,
			bJogging = false,
			bWasCrouching = false,
			LerpForward = 0,
			LerpRight = 0,
			LerpCustomizationPlayback = 1,
			bWasOnGroundAnim = false,
			Sway = {
				X = {
					Sway = 0,
					Direction = 0,
					Ang = 0,
					Lerp = 0
				},
				PosX = {
					Sway = 0,
					Direction = 0,
					Ang = 0,
					Lerp = 0
				},
				Y = {
					Sway = 0,
					Direction = 0,
					Ang = 0,
					Lerp = 0
				},
				PosY = {
					Sway = 0,
					Direction = 0,
					Ang = 0,
					Lerp = 0
				},
				PosForward = {
					Sway = 0,
					Direction = 0,
					Ang = 0,
					Lerp = 0
				}
			},
			Jump = {
				Velocity = 0,
				bWasOnGround = true,
				Force = 0,
				ForceZ = 0,
				Time = 0,
				Lerp = 0,
				LerpZ = 0
			},
			Recoil = {
				Translation = Vector(0, 0, 0),
				Rotation = Angle(0, 0, 0)
			},
			LerpCrouch = Vector(0, 0, 0)
		}

		self.MouseX = ScrW() * 0.5
		self.MouseY = ScrH() * 0.5
		self.ViewModelMouseX = ScrW() * 0.5
		self.ViewModelMouseY = ScrH() * 0.5

		self.GripPoseParameter = {
			PoseParameter = nil,
			Target = 1,
			Lerp = 1
		}

		self.GripPoseParameter2 = {
			PoseParameter = nil,
			Target = 1,
			Lerp = 1
		}

		self.m_bHasLoadedPreset = false
	end

	self.LastReverbState = true
	self.ValuesToRemove = {}
	self.StatBreadcrumbs = {}

	self.m_SmokeData = {
		Current = 0,
		bHasTriggered = false,
	}

	self:SetFiremode(1)

	if (self.Customization ~= nil) then
		self.m_CustomizationInUse = {}

		for slot, atts in pairs(self.Customization) do
			self:CreateAttachmentForUse(atts[1])
		end

		--there's no need to create entities in this stage
		self:BuildCustomizedGun()
	end

	if self.PostInit then
		self:PostInit()
	end
end

function SWEP:LoadSpawnPreset()
	if not IsFirstTimePredicted() then return end
	if self.m_bHasLoadedPreset and not self.att_saved then return end
	local CT = CurTime()
	self.loadtimerpersets = self.loadtimerpersets or CT + 0.2

	if self.att_saved and self.loadtimerpersets < CT then
		for k, atts in pairs(self.att_saved) do
			if (not self:HasAttachment(atts.m_Index)) then
				if (CLIENT) then
					net.Start("mgbase_customize_att")
					net.WriteInt(1, 8)
					net.WriteInt(atts.m_Index, 8)
					net.WriteEntity(self)
					net.SendToServer()
				else
					self:CreateAttachmentEntity(atts.m_Index)
				end
			end
		end

		self.att_saved = nil
	end

	self.m_bHasLoadedPreset = true
end

function SWEP:SecondaryAttack()
end

function SWEP:OnDrop()
	--self:SetNeedsToEquip(true)
end

function SWEP:EnableDrawWorkaroundForNextFrame()
	if (SERVER and game.SinglePlayer()) then
		self:CallOnClient("_drawworkaround", true)

		return
	end

	self:_drawworkaround(true)
end

function SWEP:_drawworkaround(v)
	self.m_drawWorkaround = v
end

function SWEP:Deploy(fromFallback)
	--self:GetOwner():SetCanZoom(false)

	fromFallback = fromFallback or false
	local seqIndex = "Draw"

	if SERVER and self.gunstate and self.gunstate == 0 then
		self:SetMalfunction(true)
	end

	-- if (self:GetNeedsToEquip() and self.Animations["Equip"]) then
	-- 	seqIndex = "Equip"
	-- end

	if (IsFirstTimePredicted() or game.SinglePlayer()) then
		self:PlayViewModelAnimation(seqIndex, fromFallback)

		if (not fromFallback) then
			self:EnableDrawWorkaroundForNextFrame()
		end
	end

	self:SetNextDrawTime(CurTime() + self:GetAnimLength(seqIndex))
	self:SetIsHolstering(false)
	self:SetBurstRounds(0)
	self:SetFlashlight(false)
	self:SetLaserIsOn(false)
	self:PlayerGesture(GESTURE_SLOT_CUSTOM, self.HoldTypes[self.HoldType].Draw)
	self.m_bDrawn = true
	self.m_bHolstered = false
	self:SetBreathingDelta(1)
	self:SetHasRunOutOfBreath(false)
	--meme marine
	self:SetShouldHoldType(true)
	-- timer.Simple(1, function()
	-- 	if not IsValid(self) then return end
	-- 	if self.att_saved then
	-- 		for k, atts in pairs(self.att_saved) do
	-- 			self:CreateAttachmentEntity(atts.m_Index)
	-- 		end
	-- 		self.att_saved = nil
	-- 	end
	-- end)

	return true
end

function SWEP:Holster(weapon, fromFallback)
	if (not self:GetIsHolstering() or fromFallback) then
		if (IsFirstTimePredicted()) then
			self:PlayViewModelAnimation("Holster", fromFallback)
		end

		self:SetIsHolstering(true)
		self:SetIsReloading(false)
		self:SetBurstRounds(0)
		self:SetNextHolsterTime(CurTime() + self:GetAnimLength("Holster"))
	end

	self:SetNextWeapon(weapon)
	self.m_bHolstered = true
	self.m_bDrawn = false
	self:SetCustomization(false)
	self:StopCustomizing()
	self:SetToggleAim(false)

	if (IsValid(self:GetOwner()) and self:GetOwner():GetMoveType() == MOVETYPE_LADDER) then return false end --ttt calls holster when dropping (but no owner)

	return CurTime() >= self:GetNextHolsterTime() or self:IsDrawing() or not IsValid(weapon)
end

function SWEP:OnRestore()
	self:SetNextReloadTime(0)
	self:SetNextPrimaryFire(0)
	self:SetNextSprintTime(0)
	self:SetNextMagTime(0)
	self:SetAimDelta(0)
	self:SetAimModeDelta(0)
	self:SetNextInspectTime(0)
	self:SetNextFiremodeTime(0)
	self:SetNextMeleeTime(0)
	self:SetTriggerDelta(0)
	self:SetHasFilledMag(true)
	self:SetMalfunction(false)
	--self:SetNeedsToEquip(false)
	self:SetIsReloading(false)
	self:SetIsHolstering(false)
	self:SetIsAiming(false)
	self:SetIsSprinting(false)
	self:SetIsTrigger(false)
	self:SetHasShotAfterTrigger(false)
	self:SetIsCustomizing(false)
	self:SetToggleAim(false)
	self:SetSafety(false)
	self:SetNextWeapon(NULL)
	self:SetSprayRounds(0)
	self:SetBurstRounds(0)
	self:SetPenetrationCount(0)
	self:SetNextDrawTime(0)
end

function SWEP:OnRemove()
	if (CLIENT) then
		for _, att in pairs(self:GetAllAttachmentsInUse()) do
			att:OnRemove(self)
		end

		for i, particle in pairs(self.Particles) do
			if not IsValid(particle) then continue end
			particle:StopEmissionAndDestroyImmediately()
		end

		self:RemoveModels(self.m_ViewModel)
		self:RemoveModels(self.m_WorldModel)
	end
end

function SWEP:RemoveModels(ent)
	if (not IsValid(self) or not IsValid(ent)) then return end

	for i, c in pairs(ent:GetChildren()) do
		self:RemoveModels(c)
	end

	if (ent:EntIndex() <= -1) then
		ent:Remove()
	end
end

function SWEP:PlayViewModelAnimation(seqIndex, compensate, cycle, force)
	compensate = compensate or false
	force = force or false
	cycle = cycle or 0
	if (not IsValid(self)) then return end
	if (self.Animations[seqIndex] == nil) then return end

	if seqIndex == "Inspect" and self.NoMagCheck and self:HasAttachment("att_ammo") then
		seqIndex = self.NoMagCheck
	end

	if seqIndex == "Inspect" and self:Clip1() == 0 and self.Animations["Inspect_empty"] then
		seqIndex = "Inspect_empty"
	end

	self.m_seqIndex = seqIndex

	--if not self.Animations[seqIndex].Reverced then
	self.m_nextSeqIndex = self.Animations[seqIndex].NextSequence
	--end

	if (self.Animations[seqIndex].m_animIndex == nil) then
		self.Animations[seqIndex].m_animIndex = 0
	end

	self.Animations[seqIndex].m_animIndex = self.Animations[seqIndex].m_animIndex + 1

	if (self.Animations[seqIndex].m_animIndex > #self.Animations[seqIndex].Sequences) then
		self.Animations[seqIndex].m_animIndex = 1
	end

	if SERVER then
		net.Start("mgbase_anim", true)
		net.WriteString(seqIndex)
		net.WriteEntity(self)
		net.WriteBool(force)
		net.WriteFloat(cycle)
		net.Broadcast()
	end

	if CLIENT then
		if (not IsValid(self.m_ViewModel)) then return end
		--self:EnableGrip()
		--self:EnableGrip2()
		local anims = self.Animations[seqIndex].Sequences

		if (anims ~= nil) then
			self.m_ViewModel:ResetSequence(anims[self.Animations[seqIndex].m_animIndex])
		end

		local dur = self.m_ViewModel:SequenceDuration()
		--lag compensation
		local baseCycle = self.Animations[seqIndex].StartCycle or 0

		if self.Animations[seqIndex].Reverced then
			baseCycle = 0.9
		end

		if (compensate and not game.SinglePlayer()) then
			local rate = math.min(LocalPlayer():Ping() / (dur * 1000), 1)
			self.m_ViewModel:SetCycle(baseCycle + rate)
		else
			self.m_ViewModel:SetCycle(cycle == 0 and baseCycle or cycle)
		end

		self.m_ViewModel:SetPlaybackRate(self.Animations[seqIndex].Fps / 30)

		if (self.Animations[seqIndex].Events) then
			local len = self.m_ViewModel:SequenceDuration()

			for i, event in pairs(self.Animations[seqIndex].Events) do

				event.m_bFired = false
				local delta = math.min(event.Time / len, 1)

				if (cycle > delta) then
					event.m_bFired = true
				end
			end

			self:AnimationEvents()
		end
	end
end

function SWEP:GetAnimLength(seqIndex, length)
	if (self.Animations[seqIndex] == nil) then
		error(seqIndex .. " does not exist on the weapon's animation list!")
	end

	length = length or self.Animations[seqIndex].Length
	local pb = self.Animations[seqIndex].Fps / 30

	return length / pb
end

function SWEP:IsDrawing()
	return CurTime() < self:GetNextDrawTime()
end

function SWEP:GetTracerOrigin()
	if not IsValid(self.m_ViewModel) then return Vector(0,0,0) end
	local attData = self.m_ViewModel:GetAttachment(self.m_ViewModel:LookupAttachment("muzzle"))

	return attData.Pos + (attData.Ang:Forward() * -15)
end

function SWEP:PlayerGesture(slot, anim)
	if (CLIENT and IsFirstTimePredicted()) then
		self:GetOwner():AnimRestartGesture(slot, anim, true)
	end

	if SERVER then
		net.Start("mgbase_tpanim", true)
		net.WriteUInt(slot, 2)
		net.WriteInt(anim, 12)
		net.WriteEntity(self:GetOwner())

		if (game.SinglePlayer()) then
			net.Send(self:GetOwner())
		else
			net.SendOmit(self:GetOwner())
		end
	end
end

function SWEP:IsCustomizing()
	return self:GetIsCustomizing()
end

function SWEP:SetCustomization(state)
	self:SetNWBool("mgbase_att", state)
end

function SWEP:OnReloaded()
	if (self.Customization ~= nil) then
		self:BuildCustomizedGun()
	else
		if (self.Firemodes ~= nil) then
			self:ApplyFiremode(self:GetFiremode())
		end
	end
	--self:SetAimMode(1)
end

function SWEP:DeepObjectCopy(defaults, tbl)
	--self:SetHoldType("duel") --setting something people wont normally use
	--defaults = weapons.get(class)
	--tbl = {}
	for i, v in pairs(defaults) do
		if (not istable(v) and not isvector(v) and not isangle(v)) then
			tbl[i] = v
		elseif (isvector(v)) then
			--if (tbl[i] == nil) then
			tbl[i] = Vector(0, 0, 0)
			--end
			tbl[i]:Set(v)
		elseif (isangle(v)) then
			-- if (tbl[i] == nil) then
			tbl[i] = Angle(0, 0, 0)
			--end
			tbl[i].p = v.p
			tbl[i].y = v.y
			tbl[i].r = v.r
		else
			if (tbl[i] == nil) then
				tbl[i] = {}
			end

			self:DeepObjectCopy(v, tbl[i])
		end
	end
end

function SWEP:RemoveValue(valIndex)
	self.ValuesToRemove[#self.ValuesToRemove + 1] = valIndex
end

function SWEP:FireAnimationEvent(pos, ang, event, options)
end

--meme marine
local LastHoldType = nil

function SWEP:SetShouldHoldType(force)
	if (not IsValid(self:GetOwner())) then return end
	local ht = "Idle"

	if (self:GetIsAiming()) then
		ht = "Aim"
	elseif self:GetIsSprinting() or self:GetIsHolstering() or self:GetSafety() then
		ht = "Down"
	end

	local fullht = "fist"
	local crouching = self:GetOwner():Crouching() or self:GetOwner():KeyDown(IN_DUCK)

	-- self:SetHoldType(crouching && self.HoldTypes[self.HoldType][ht].Crouching || self.HoldTypes[self.HoldType][ht].Standing)
	if crouching then
		fullht = self.HoldTypes[self.HoldType][ht].Crouching
	else
		fullht = self.HoldTypes[self.HoldType][ht].Standing
	end

	if LastHoldType ~= fullht or force then
		self:SetHoldType(fullht)
	end

	LastHoldType = fullht
end