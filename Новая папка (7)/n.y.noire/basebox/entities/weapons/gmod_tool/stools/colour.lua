--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/entities/weapons/gmod_tool/stools/colour.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

TOOL.Category = "Render"
TOOL.Name = "#tool.colour.name"
TOOL.ClientConVar["r"] = 255
TOOL.ClientConVar["g"] = 255
TOOL.ClientConVar["b"] = 255
TOOL.ClientConVar["a"] = 255
TOOL.ClientConVar["mode"] = "0"
TOOL.ClientConVar["fx"] = "0"

TOOL.Information = {
	{
		name = "left"
	},
	{
		name = "right"
	},
	{
		name = "reload"
	}
}

local function SetColour(ply, ent, data)
	if (data.Color and data.Color.a < 255 and data.RenderMode == RENDERMODE_NORMAL) then
		data.RenderMode = RENDERMODE_TRANSCOLOR
	end

	if (data.Color) then
		ent:SetColor(Color(data.Color.r, data.Color.g, data.Color.b, data.Color.a))
	end

	if (data.RenderMode) then
		ent:SetRenderMode(data.RenderMode)
	end

	if (data.RenderFX) then
		ent:SetKeyValue("renderfx", data.RenderFX)
	end

	if (SERVER) then
		duplicator.StoreEntityModifier(ent, "colour", data)
	end
end

duplicator.RegisterEntityModifier("colour", SetColour)

function TOOL:LeftClick(trace)
	local ent = trace.Entity

	if (IsValid(ent.AttachedEntity)) then
		ent = ent.AttachedEntity
	end

	if (not IsValid(ent)) then return false end -- The entity is valid and isn't worldspawn
	if (CLIENT) then return true end
	local r = self:GetClientNumber("r", 0)
	local g = self:GetClientNumber("g", 0)
	local b = self:GetClientNumber("b", 0)
	local a = self:GetClientNumber("a", 0)
	local fx = self:GetClientNumber("fx", 0)
	local mode = self:GetClientNumber("mode", 0)

	SetColour(self:GetOwner(), ent, {
		Color = Color(r, g, b, a),
		RenderMode = mode,
		RenderFX = fx
	})

	return true
end

function TOOL:RightClick(trace)
	local ent = trace.Entity

	if (IsValid(ent.AttachedEntity)) then
		ent = ent.AttachedEntity
	end

	if (not IsValid(ent)) then return false end -- The entity is valid and isn't worldspawn
	if (CLIENT) then return true end
	local clr = ent:GetColor()
	self:GetOwner():ConCommand("colour_r " .. clr.r)
	self:GetOwner():ConCommand("colour_g " .. clr.g)
	self:GetOwner():ConCommand("colour_b " .. clr.b)
	self:GetOwner():ConCommand("colour_a " .. clr.a)
	self:GetOwner():ConCommand("colour_fx " .. ent:GetRenderFX())
	self:GetOwner():ConCommand("colour_mode " .. ent:GetRenderMode())

	return true
end

function TOOL:Reload(trace)
	local ent = trace.Entity

	if (IsValid(ent.AttachedEntity)) then
		ent = ent.AttachedEntity
	end

	if (not IsValid(ent)) then return false end -- The entity is valid and isn't worldspawn
	if (CLIENT) then return true end

	SetColour(self:GetOwner(), ent, {
		Color = Color(255, 255, 255, 255),
		RenderMode = 0,
		RenderFX = 0
	})

	return true
end

local ConVarsDefault = TOOL:BuildConVarList()
local forms

function TOOL.BuildCPanel(CPanel)
	CPanel:AddControl("Header", {
		Description = "#tool.colour.desc"
	})

	CPanel:AddControl("ComboBox", {
		MenuButton = 1,
		Folder = "colour",
		Options = {
			["#preset.default"] = ConVarsDefault
		},
		CVars = table.GetKeys(ConVarsDefault)
	})

	CPanel:AddControl("Color", {
		Label = "#tool.colour.color",
		Red = "colour_r",
		Green = "colour_g",
		Blue = "colour_b",
		Alpha = "colour_a"
	})

	CPanel:AddControl("ListBox", {
		Label = "#tool.colour.mode",
		Options = list.Get("RenderModes")
	})

	CPanel:AddControl("ListBox", {
		Label = "#tool.colour.fx",
		Options = list.Get("RenderFX")
	})

	if not forms then
		forms = {}

		local hsv = {
			lows = {},
			drks = {},
			clrs = {},
		}

		for k, v in pairs(McCD.Config.TuneColors) do
			local h, s, vl = ColorToHSV(v[1])

			local clv = {v[1], v[2], k, h, s, vl}

			if s <= 0.2 then
				table.insert(hsv.lows, clv)
				continue
			end

			if vl <= 0.3 then
				table.insert(hsv.drks, clv)
				continue
			end

			table.insert(hsv.clrs, clv)
		end

		table.sort(hsv.lows, function(a, b) return a[6] > b[6] end)
		table.sort(hsv.drks, function(a, b) return a[4] > b[4] end)
		table.sort(hsv.clrs, function(a, b) return a[4] > b[4] end)
		table.Add(forms, hsv.lows)
		table.Add(forms, hsv.drks)
		table.Add(forms, hsv.clrs)
	end

	local fnd1 = vgui.Create("MSDPanelList")
	fnd1:SetSize(CPanel:GetWide(), 500)
	fnd1:EnableVerticalScrollbar()
	fnd1:SetSpacing(2)
	fnd1:EnableHorizontal(true)
	CPanel:AddItem(fnd1)

	for _, v in pairs(forms) do
		local a = MSD.IconButton(fnd1, MSD.Icons48.card, "static", nil, 32, v[1], v[1], function()
			RunConsoleCommand("colour_r", v[1].r)
			RunConsoleCommand("colour_g", v[1].g)
			RunConsoleCommand("colour_b", v[1].b)
			RunConsoleCommand("colour_a", 255)
		end, function(s, w, h)
			MSD.DrawTexturedRect(1, 1, w, h, s.mat, color_black, 2, color_black)
		end)

		a.DoRightClick = function(...)
			SetClipboardText("Color(" .. v[1].r .. ", " .. v[1].g .. ", " .. v[1].b .. ")")
		end
	end
end

list.Set("RenderModes", "#rendermode.normal", {
	colour_mode = 0
})

list.Set("RenderModes", "#rendermode.transcolor", {
	colour_mode = 1
})

list.Set("RenderModes", "#rendermode.transtexture", {
	colour_mode = 2
})

list.Set("RenderModes", "#rendermode.glow", {
	colour_mode = 3
})

list.Set("RenderModes", "#rendermode.transalpha", {
	colour_mode = 4
})

list.Set("RenderModes", "#rendermode.transadd", {
	colour_mode = 5
})

list.Set("RenderModes", "#rendermode.transalphaadd", {
	colour_mode = 8
})

list.Set("RenderModes", "#rendermode.worldglow", {
	colour_mode = 9
})

list.Set("RenderFX", "#renderfx.none", {
	colour_fx = 0
})

list.Set("RenderFX", "#renderfx.pulseslow", {
	colour_fx = 1
})

list.Set("RenderFX", "#renderfx.pulsefast", {
	colour_fx = 2
})

list.Set("RenderFX", "#renderfx.pulseslowwide", {
	colour_fx = 3
})

list.Set("RenderFX", "#renderfx.pulsefastwide", {
	colour_fx = 4
})

list.Set("RenderFX", "#renderfx.fadeslow", {
	colour_fx = 5
})

list.Set("RenderFX", "#renderfx.fadefast", {
	colour_fx = 6
})

list.Set("RenderFX", "#renderfx.solidslow", {
	colour_fx = 7
})

list.Set("RenderFX", "#renderfx.solidfast", {
	colour_fx = 8
})

list.Set("RenderFX", "#renderfx.strobeslow", {
	colour_fx = 9
})

list.Set("RenderFX", "#renderfx.strobefast", {
	colour_fx = 10
})

list.Set("RenderFX", "#renderfx.strobefaster", {
	colour_fx = 11
})

list.Set("RenderFX", "#renderfx.flickerslow", {
	colour_fx = 12
})

list.Set("RenderFX", "#renderfx.flickerfast", {
	colour_fx = 13
})

list.Set("RenderFX", "#renderfx.distort", {
	colour_fx = 15
})

list.Set("RenderFX", "#renderfx.hologram", {
	colour_fx = 16
})

list.Set("RenderFX", "#renderfx.pulsefastwider", {
	colour_fx = 24
})