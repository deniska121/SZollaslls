--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/weapons/event_item/shared.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if (SERVER) then
	AddCSLuaFile("shared.lua")
end

SWEP.PrintName = "Предмет"
SWEP.Base = "weapon_base"
SWEP.Author = "MacTavish"
SWEP.ViewModel = "models/weapons/c_realhands.mdl"
SWEP.WorldModel = "models/props_canal/mattpipe.mdl"
SWEP.ViewModelFOV = 70
SWEP.UseHands = true
SWEP.Primary.Ammo = "none"
SWEP.Spawnable = false
SWEP.AdminSpawnable = true
SWEP.DrawCrosshair = false
SWEP.HoldType = "normal"
SWEP.Slot = 7
SWEP.SwimDelay = 1
SWEP.Primary.Ammo = "none"
SWEP.Primary.Clipsize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.Clipsize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.DrawAmmo = false
SWEP.PlaySprintAnim = false
SWEP.PlayJumpAnim = false
SWEP.AutoSwitchTo = true
SWEP.AutoSwitchFrom = true
SWEP.EventItem = true

SWEP.HoldTypes = {
	["mop"] = "melee2",
	["box"] = "duel",
	["crate"] = "duel",
	["pallet"] = "duel",
	["bag"] = "grenade",
	["cbr"] = "slam",
	["tool"] = "slam",
	["trash"] = "slam",
	["trash2"] = "slam",
	["wheelchair"] = "duel",
	["tray"] = "duel",
	["tray_dirt"] = "duel",
	["case"] = "normal",
}

SWEP.CanHolster = {
	["case"] = true,
}

SWEP.VElements = {
	["mop"] = { type = "Model", model = "models/props_c17/pushbroom.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-8.832, -27.532, -7.792), angle = Angle(-180, -101.689, 52.597), size = Vector(1, 1, 1), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["box"] = { type = "Model", model = "models/props_junk/cardboard_box003a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-15.065, -34.806, -0.519), angle = Angle(-180, 75.973, -90), size = Vector(1, 1, 1), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["crate"] = { type = "Model", model = "models/props_junk/wood_crate003a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-11.558, -32.013, 0), angle = Angle(-180, -117.013, -90), size = Vector(1, 1, 1), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pallet"] = { type = "Model", model = "models/props/de_prodigy/wood_pallet_01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-8.165, -31.122, 1.447), angle = Angle(-0.232, -20.967, 83.37), size = Vector(1, 1, 1), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["bag"] = { type = "Model", model = "models/props_junk/petfoodbag01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-34.806, -34.806, -14.027), angle = Angle(-180, 73.636, 94.675), size = Vector(1, 1, 1), color = color_white, surpresslightning = false, material = "models/props/de_prodigy/concretebags", skin = 0, bodygroup = {} },
	["cbr"] = { type = "Model", model = "models/props_junk/CinderBlock01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-4.203, -14.494, -5.347), angle = Angle(-32.784, 63.705, 102.628), size = Vector(0.5, 0.5, 0.5), color = Color(187, 166, 107, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tool"] = { type = "Model", model = "models/props_c17/tools_pliers01a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-8.566, -18.71, -9.761), angle = Angle(-45.434, -97.416, -11.796), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["case"] = { type = "Model", model = "models/props_c17/BriefCase001a.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-0, -0, -0), angle = Angle(-45.434, -97.416, -11.796), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	--["trash"] = { type = "Model", model = "models/objects_city/trash_bag_01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(6.994, -13.112, -6.626), angle = Angle(180, 0, 0), size = Vector(1.026, 0.229, 0.726), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["trash"] = { type = "Model", model = "models/objects_city/trash_bag_01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-19.371, -16.642, -4.237), angle = Angle(-90.01, 0, 0), size = Vector(0.54, 0.54, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["trash2"] = { type = "Model", model = "models/objects_city/trash_bag_01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-19.371, -16.642, -4.237), angle = Angle(-90.01, 0, 0), size = Vector(0.54, 0.54, 0.54), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["wheelchair"] = { type = "Model", model = "models/atlantis/medical/wheelchair.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-30.855, -41.763, 0), angle = Angle(-90, 0, 36.897), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tray"] = { type = "Model", model = "models/props_equipment/surgicaltray_01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-6.481, -21.677, 0.108), angle = Angle(-7.173, 67.338, 88.623), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_equipment/surgical_tray_02", skin = 0, bodygroup = {} },
	["tray_dirt"] = { type = "Model", model = "models/props_equipment/surgicaltray_01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(-6.481, -21.677, 0.108), angle = Angle(-7.173, 67.338, 88.623), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.WElements = {
	["mop"] = { type = "Model", model = "models/props_c17/pushbroom.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.635, -0.519, 3.635), angle = Angle(10.649, -3.507, -45.312), size = Vector(0.755, 0.755, 0.755), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["box"] = { type = "Model", model = "models/props_junk/cardboard_box003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(-5.715, 12.1, -2), angle = Angle(-180, -180, -167.144), size = Vector(0.69, 0.649, 0.69), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["crate"] = { type = "Model", model = "models/props_junk/wood_crate003a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.992, 13.479, 0.108), angle = Angle(180, -2.988, -13.749), size = Vector(0.69, 0.649, 0.69), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["pallet"] = { type = "Model", model = "models/props/de_prodigy/wood_pallet_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.992, 13.479, 0.108), angle = Angle(78.603, -2.988, -13.749), size = Vector(0.69, 0.649, 0.69), color = color_white, surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["bag"] = { type = "Model", model = "models/props_junk/petfoodbag01.mdl", bone = "ValveBiped.Bip01_Spine4", rel = "", pos = Vector(0.5, -2, -5.715), angle = Angle(162.468, 162.468, 1.169), size = Vector(0.69, 0.649, 0.69), color = color_white, surpresslightning = false, material = "models/props/de_prodigy/concretebags", skin = 0, bodygroup = {} },
	["cbr"] = { type = "Model", model = "models/props_junk/CinderBlock01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(6.094, 5.021, 0), angle = Angle(0, 0, 0), size = Vector(0.771, 0.771, 0.771), color = Color(187, 166, 107, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tool"] = { type = "Model", model = "models/props_c17/tools_pliers01a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(2.894, 0, 0), angle = Angle(-32.757, 151.438, -83.237), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["case"] = { type = "Model", model = "models/props_c17/BriefCase001a.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(11, 1, 0), angle = Angle(90, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["trash"] = { type = "Model", model = "models/objects_city/trash_bag_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.36, 3.417, 21.354), angle = Angle(187, 0, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["trash2"] = { type = "Model", model = "models/objects_city/trash_bag_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.36, 3.417, 21.354), angle = Angle(187, 0, 0), size = Vector(0.7, 0.7, 0.7), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 1, bodygroup = {} },
	["wheelchair"] = { type = "Model", model = "models/atlantis/medical/wheelchair.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(5.383, 13.329, 19.454), angle = Angle(-180, -111.735, 2.941), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} },
	["tray"] = { type = "Model", model = "models/props_equipment/surgicaltray_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.311, 12.63, -1.142), angle = Angle(6.877, -20.591, -168.672), size = Vector(1.049, 1.049, 1.049), color = Color(255, 255, 255, 255), surpresslightning = false, material = "models/props_equipment/surgical_tray_02", skin = 0, bodygroup = {} },
	["tray_dirt"] = { type = "Model", model = "models/props_equipment/surgicaltray_01.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(4.311, 12.63, -1.142), angle = Angle(6.877, -20.591, -168.672), size = Vector(1.049, 1.049, 1.049), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

function SWEP:SetupDataTables()
	self:NetworkVar("String", 0, "Item")
end

function SWEP:Think()
	if (self:GetOwner():getDarkRPVar("unconscious") or self:GetOwner():getDarkRPVar("HandCuffed")) and (not self.lastpose or self.lastpose ~= "normal") then
		self:SetHoldType("normal")
		return
	end

	if not self.lastcheck or self.lastcheck < CurTime() or (not self.lastpose or self.lastpose ~= self.HoldTypes[self:GetItem()]) then
		self.lastcheck = CurTime() + 5
		self:SetHoldType(self.HoldTypes[self:GetItem()] or "normal")
	end
end

function SWEP:Holster(wp)
	if CLIENT and IsValid(self:GetOwner()) then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	if self:GetItem() and self.CanHolster[self:GetItem()] then
		return true
	end

	return IsValid(wp) and wp:GetClass() == "event_real" or false
end

function SWEP:Deploy()
	self:SetHoldType(self.HoldTypes[self:GetItem()] or "normal")
end

function SWEP:PrimaryAttack()
end

function SWEP:SecondaryAttack()
end

function SWEP:Initialize()
	if CLIENT then
		self.VElements = table.FullCopy(self.VElements)
		self.WElements = table.FullCopy(self.WElements)
		self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
		self:CreateModels(self.VElements)
		self:CreateModels(self.WElements)

		if IsValid(self:GetOwner()) then
			local vm = self:GetOwner():GetViewModel()

			if IsValid(vm) then
				self:ResetBonePositions(vm)

				if (self.ShowViewModel == nil or self.ShowViewModel) then
					vm:SetColor(color_white)
				else
					vm:SetColor(Color(255, 255, 255, 1))
					vm:SetMaterial("Debug/hsv")
				end
			end
		end
	end
end

function SWEP:OnRemove()
	self:Holster()
end

if SERVER then return end

SWEP.vRenderOrder = nil

function SWEP:ViewModelDrawn()
	if self:GetOwner():getDarkRPVar("unconscious") or self:GetOwner():getDarkRPVar("HandCuffed") then return end
	local vm = self:GetOwner():GetViewModel()
	if not IsValid(vm) then return end
	if (not self.VElements) then return end
	self:UpdateBonePositions(vm)

	if (not self.vRenderOrder) then
		self.vRenderOrder = {}

		for k, v in pairs(self.VElements) do
			if (v.type == "Model") then
				table.insert(self.vRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.vRenderOrder, k)
			end
		end
	end

	for k, name in ipairs(self.vRenderOrder) do

		if name ~= self:GetItem() then continue end

		local v = self.VElements[name]

		if (not v) then
			self.vRenderOrder = nil
			break
		end

		if (v.hide) then continue end
		local model = v.modelEnt
		local sprite = v.spriteMaterial
		if (not v.bone) then continue end
		local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
		if (not pos) then continue end

		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			--model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix("RenderMultiply", matrix)

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial(v.material)
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for i, o in pairs(v.bodygroup) do
					if (model:GetBodygroup(i) ~= o) then
						model:SetBodygroup(i, o)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
			render.SetBlend(v.color.a / 255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		elseif (v.type == "Sprite" and sprite) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
		elseif (v.type == "Quad" and v.draw_func) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			cam.Start3D2D(drawpos, ang, v.size)
			v.draw_func(self)
			cam.End3D2D()
		end
	end
end

SWEP.wRenderOrder = nil
SWEP.ShowWorldModel = false

function SWEP:DrawWorldModel()
	if self:GetOwner():getDarkRPVar("unconscious") or self:GetOwner():getDarkRPVar("HandCuffed") then return end
	if (not self.WElements) then return end

	if (not self.wRenderOrder) then
		self.wRenderOrder = {}

		for k, v in pairs(self.WElements) do
			if (v.type == "Model") then
				table.insert(self.wRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.wRenderOrder, k)
			end
		end
	end

	if (IsValid(self:GetOwner())) then
		bone_ent = self:GetOwner()
	else
		-- when the weapon is dropped
		bone_ent = self
	end

	for k, name in pairs(self.wRenderOrder) do

		if name ~= self:GetItem() then continue end

		local v = self.WElements[name]

		if (not v) then
			self.wRenderOrder = nil
			break
		end

		if (v.hide) then continue end
		local pos, ang

		if (v.bone) then
			pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent)
		else
			pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand")
		end

		if (not pos) then continue end
		local model = v.modelEnt
		local sprite = v.spriteMaterial

		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			--model:SetModelScale(v.size)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix("RenderMultiply", matrix)

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial(v.material)
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for i, o in pairs(v.bodygroup) do
					if (model:GetBodygroup(i) ~= o) then
						model:SetBodygroup(i, o)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
			render.SetBlend(v.color.a / 255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		elseif (v.type == "Sprite" and sprite) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
		elseif (v.type == "Quad" and v.draw_func) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			cam.Start3D2D(drawpos, ang, v.size)
			v.draw_func(self)
			cam.End3D2D()
		end
	end
end

function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
	local bone, pos, ang

	if (tab.rel and tab.rel ~= "") then
		local v = basetab[tab.rel]
		if (not v) then return end
		-- Technically, if there exists an element with the same name as a bone
		-- you can get in an infinite loop. Let's just hope nobody's that stupid.
		pos, ang = self:GetBoneOrientation(basetab, v, ent)
		if (not pos) then return end
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
	else
		bone = ent:LookupBone(bone_override or tab.bone)
		if (not bone) then return end
		pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
		local m = ent:GetBoneMatrix(bone)

		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		if (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and ent == self:GetOwner():GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r -- Fixes mirrored models
		end
	end

	return pos, ang
end

function SWEP:CreateModels(tab)
	if (not tab) then return end

	-- Create the clientside models here because Garry says we can't do it in the render hook
	for k, v in pairs(tab) do
		if (v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME")) then
			v.modelEnt = ClientsideModel(v.model, RENDERGROUP_OTHER)

			if (IsValid(v.modelEnt)) then
				v.modelEnt:SetPos(self:GetPos())
				v.modelEnt:SetAngles(self:GetAngles())
				v.modelEnt:SetParent(self)
				v.modelEnt:SetNoDraw(true)
				v.createdModel = v.model
			else
				v.modelEnt = nil
			end
		elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME")) then
			local name = v.sprite .. "-"

			local params = {
				["$basetexture"] = v.sprite
			}

			-- make sure we create a unique name based on the selected options
			local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

			for i, j in pairs(tocheck) do
				if (v[j]) then
					params["$" .. j] = 1
					name = name .. "1"
				else
					name = name .. "0"
				end
			end

			v.createdSprite = v.sprite
			v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
		end
	end
end

local allbones
local hasGarryFixedBoneScalingYet = false

function SWEP:UpdateBonePositions(vm)
	if self.ViewModelBoneMods then
		if (not vm:GetBoneCount()) then return end
		-- !! WORKAROUND !! //
		-- We need to check all model names :/
		local loopthrough = self.ViewModelBoneMods

		if (not hasGarryFixedBoneScalingYet) then
			allbones = {}

			for i = 0, vm:GetBoneCount() do
				local bonename = vm:GetBoneName(i)

				if (self.ViewModelBoneMods[bonename]) then
					allbones[bonename] = self.ViewModelBoneMods[bonename]
				else
					allbones[bonename] = {
						scale = Vector(1, 1, 1),
						pos = Vector(0, 0, 0),
						angle = Angle(0, 0, 0)
					}
				end
			end

			loopthrough = allbones
		end

		-- !! ----------- !! //
		for k, v in pairs(loopthrough) do
			local bone = vm:LookupBone(k)
			if (not bone) then continue end
			-- !! WORKAROUND !! //
			local s = Vector(v.scale.x, v.scale.y, v.scale.z)
			local p = Vector(v.pos.x, v.pos.y, v.pos.z)
			local ms = Vector(1, 1, 1)

			if (not hasGarryFixedBoneScalingYet) then
				local cur = vm:GetBoneParent(bone)

				while (cur >= 0) do
					local pscale = loopthrough[vm:GetBoneName(cur)].scale
					ms = ms * pscale
					cur = vm:GetBoneParent(cur)
				end
			end

			s = s * ms

			-- !! ----------- !! //
			if vm:GetManipulateBoneScale(bone) ~= s then
				vm:ManipulateBoneScale(bone, s)
			end

			if vm:GetManipulateBoneAngles(bone) ~= v.angle then
				vm:ManipulateBoneAngles(bone, v.angle)
			end

			if vm:GetManipulateBonePosition(bone) ~= p then
				vm:ManipulateBonePosition(bone, p)
			end
		end
	else
		self:ResetBonePositions(vm)
	end
end

function SWEP:ResetBonePositions(vm)
	if (not vm:GetBoneCount()) then return end

	for i = 0, vm:GetBoneCount() do
		vm:ManipulateBoneScale(i, Vector(1, 1, 1))
		vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
		vm:ManipulateBonePosition(i, Vector(0, 0, 0))
	end
end