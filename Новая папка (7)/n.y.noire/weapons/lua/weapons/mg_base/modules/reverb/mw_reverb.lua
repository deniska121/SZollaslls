--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/reverb/mw_reverb.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

AddCSLuaFile()

local dir = Vector(0, 0, 99999)
local REVERB_RESOLUTION = 0.25
local resolution = 1


function SWEP:IsOutside()

	local startpos = self:GetOwner():EyePos()
	local rays = {}

	local trace = {}
	trace.mask = MASK_SOLID_BRUSHONLY
	trace.start = startpos
	trace.endpos = trace.start + dir
	table.insert(rays, util.TraceLine(trace))

	if not rays[1].StartSolid and (rays[1].HitSky or rays[1].HitNoDraw) then return true end

	local lastr
	for r = 0.4, 0.2, (REVERB_RESOLUTION / resolution) * -0.5 do
		local hCos = math.sin(r * math.pi)
		for i = -1, 1, (REVERB_RESOLUTION / resolution) do
			if lastr and not rays[lastr].StartSolid and (rays[lastr].HitSky or rays[lastr].HitNoDraw) then return true end
			local sin = math.sin(i * math.pi) * hCos
			local cos = math.cos(i * math.pi) * hCos

			trace.endpos = startpos + Vector(sin, cos, math.cos(r * math.pi)) * 999999
			lastr = table.insert(rays, util.TraceLine(trace))
		end
	end

	return false
end

function SWEP:HandleReverb()
	if (not IsValid(self:GetOwner()) or not IsFirstTimePredicted()) then return end

	self:EmitSound(self.Primary.Sound)

	if (self.Reverb == nil) then return end
	local layer = ""
	local reflection = ""

	if self.Reverb.Sounds then
		local outside = self:IsOutside()

		if (outside) then
			layer = self.Reverb.Sounds.Outside.Layer
			reflection = self.Reverb.Sounds.Outside.Reflection
		else
			layer = self.Reverb.Sounds.Inside.Layer ~= nil and self.Reverb.Sounds.Inside.Layer or self.Reverb.Sounds.Inside
			reflection = self.Reverb.Sounds.Inside.Reflection ~= nil and self.Reverb.Sounds.Inside.Reflection or ""
		end

		if self.DistSound and outside and SERVER then
			DarkRP.UIEffect(nil, "DistSound", {self:GetOwner():GetPos(), self.DistSound, self.Primary.Sound})
		end

		if layer ~= "" then
			self:EmitSound(layer)
		end

		if reflection ~= "" then
			self:EmitSound(reflection)
		end
	end
end