--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/entities/entities/spawned_vendor/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

local glowMaterial = Material("sprites/glow04_noz")
local color_blue = Color(175, 253, 249)
local color_red = Color(255, 0, 0, 255)
local color_orange = Color(255, 125, 0, 255)
local color_green = Color(0, 255, 98)

function ENT:Initialize()
	local scale = Vector(1,1.05,1)

	local mat = Matrix()
	mat:Scale(scale)
	self:EnableMatrix("RenderMultiply", mat)
end

local color

function ENT:Draw()
	self:DrawModel()
	if self:GetPos():DistToSqr(LocalPlayer():GetPos()) > 20000 then return end

	local vtype = DarkRP.Vendors[self:GetVendorType()]
	if !vtype then return end

	render.SetMaterial(glowMaterial)

	local button = self:GetNearestButton()

	for k, v in pairs(vtype.buttons) do
		color = color_blue

		if button ~= k then
			color.a = color == color_red and 100 or 75
		else
			color = color_orange
		end

		if self:GetButton() and self:GetButton() == k then
			color = self:GetStocked() and color_green or color_red
		end

		render.DrawSprite(self:LocalToWorld(v.pos), 4, 4, color)
	end

end