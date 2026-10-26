--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/autorun/mw_matproxy.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if SERVER then return end

local function findParentGun(ent)
	local parent = ent:GetOwner()

	while (IsValid(parent) and not parent:IsWeapon()) do
		parent = parent:GetOwner()
	end

	return parent
end

local envmaptint = "$envmaptint"
local envmap = "$envmap"

matproxy.Add({
	name = "MwEnvMapTint",
	init = function(self, mat, values)
		local color = {1, 1, 1}

		if (values.color ~= nil) then
			color = string.Explode(" ", string.Replace(string.Replace(values.color, "[", ""), "]", ""))
		end

		self.min = values.min
		self.max = values.max
		self.colorV = Vector(color[1], color[2], color[3])
		self.envmap = values.envmap or "viper/shared/envmaps/mw19_shoothouse_cubemap_hdr"
	end,
	bind = function(self, mat, ent)
		if (not IsValid(ent)) then return end
		local parent = findParentGun(ent)
		if (IsValid(parent) and parent:GetNoDraw()) then return end
		local c = render.GetLightColor(ent:GetPos())
		local luminance = (c.x * 0.2126) + (c.y * 0.7152) + (c.z * 0.0722)
		ent.m_MwEnvMapTint = Lerp(10 * FrameTime(), ent.m_MwEnvMapTint or 0, luminance - 0.008)
		mat:SetVector(envmaptint, self.colorV * Lerp(ent.m_MwEnvMapTint, self.min, self.max))
		mat:SetTexture(envmap, self.envmap)
	end
})

matproxy.Add({
	name = "MwCamo",
	init = function(self, mat, values) end,
	bind = function(self, mat, ent) end
})

--[[if (!IsValid(ent)) then return end

		mat:SetInt("$detailblendmode", 0)
		mat:SetFloat("$detailblendfactor", 0)

		if (ent.mw_Camo == nil || ent.mw_Camo == "") then return end

		mat:SetInt("$detailblendmode", 4)
		mat:SetFloat("$detailblendfactor", 1)
		mat:SetTexture("$detail",  ent.mw_Camo)]]
matproxy.Add({
	name = "MwSight",
	init = function(self, mat, values) end,
	bind = function(self, mat, ent)
		if (not IsValid(ent)) then return end

		if (ent.mw_Aim == nil) then
			mat:SetInt("$cloakpassenabled", 0)
			mat:SetFloat("$cloakfactor", 0)
		else
			mat:SetInt("$cloakpassenabled", 1)
			mat:SetFloat("$cloakfactor", math.Round(ent.mw_Aim))
		end
	end
})