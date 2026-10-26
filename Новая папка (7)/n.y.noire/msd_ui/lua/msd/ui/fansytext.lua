--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/msd_ui/lua/msd/ui/fansytext.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

PANEL = {}

function PANEL:Init()
	self.sepwide = 18 -- We cant run surface.GetTextSize if the panel is made too early
	self.chartall = 18

	self.lines = {}
	self.maxlines = false
	self.curwide = 0
	self.margin = 5
	self.maxwide = 0 --Max known curwide used
	self.fontInternal = false
	self.font = "DarkRP.Chat_18" --default font
	self.alphaD = 1
	self.bg = true
end

function PANEL:Paint(wd, hd)
	if self.bg then
		MSDX.Draw(0, 0, 0, self.maxwide + 10, hd, MSD.ColorAlpha(color_black, self.alphaD * 150))
	end

	local font = self.fontInternal or self.font
	local color = color_white

	if font then
		surface.SetFont(font)
	end

	local spacer, ctall = surface.GetTextSize(" ")
	self.sepwide = spacer
	self.chartall = ctall
	local liney = -ctall
	local w = 0

	for l_n = 1, #self.lines do
		l_v = self.lines[l_n]
		local lastx = 5


		for i_n = 1, #l_v do
			i_v = l_v[i_n]

			if i_v[1] == "text" then
				w = i_v[2].w
				self:PaintTextpart(i_v[2].text , font, lastx, 4 + liney + ctall, MSD.ColorAlpha(color, self.alphaD * 255))
			elseif i_v[1] == "image" then
				w = i_v[2].w
				surface.SetMaterial(i_v[2].mat)
				surface.SetDrawColor(255, 255, 255, self.alphaD * 255)
				surface.DrawTexturedRect(lastx, liney + i_v[2].h, i_v[2].w, i_v[2].h)
			elseif i_v[1] == "blank" then
				w = i_v[2].w
			elseif i_v[1] == "textcolor" then
				color = i_v[2]
				w = 0
			end

			lastx = lastx + w
			last_item = i_v
		end

		--liney = liney + h
		liney = liney + self.chartall
	end
end

--[[---------------------------------------------------------
   Name: Rebuild
-----------------------------------------------------------]]
function PANEL:Rebuild()
end

--[[---------------------------------------------------------
   Name: PerformLayout
-----------------------------------------------------------]]
function PANEL:_PerformLayout()
	if self.PerformLayout then
		self:PerformLayout()
	end

	self:SetTall(#self.lines * self.chartall + 8 or 7)
end

function PANEL:Clear()
	return self.pnlCanvas:Clear()
end

function PANEL:SetFontInternal(font)
	self:InsertFontChange(font)
	self.fontInternal = font
end

function PANEL:AppendItem(item)
	if type(item) == "string" then return self:AppendText(item) end

	if self.maxlines and #self.lines > self.maxlines then
		table.remove(self.lines, 1)
	end

	local wide = item[2].w
	if self.curwide + wide < self:GetWide() - self.margin * 2 then
		self.curwide = self.curwide + wide
		table.insert(self.lines[#self.lines], item)
		self.maxwide = math.max(self.curwide, self.maxwide)
	else
		table.insert(self.lines, {})
		self.maxwide = math.max(self.curwide, self.maxwide)
		self.curwide = wide
		table.insert(self.lines[#self.lines], item)
	end

	self:_PerformLayout()
end

function PANEL:AppendText(text)
	local etext = string.Explode("\n", text) --Split newlines in sections

	if self.fontInternal then
		surface.SetFont(self.fontInternal)
	else
		surface.SetFont(self.font)
	end

	--Loop lines
	for l, line in pairs(etext) do
		local parts = string.Explode(" ", line) --Split spaces, perhaps find another way to split seperators

		for n, part in pairs(parts) do
			local wide, tall = surface.GetTextSize(part)

			--I dont know why this is possible
			if part ~= "" and part ~= " " then
				self:AppendItem({
					"text", {
						text = part,
						w = wide,
						h = tall
					}
				})

				self:AppendItem({
					"blank", {
						w = 4,
						h = tall
					}
				})
			end
		end

		--Begin new line, except if it's the last line
		if l ~= #etext then
			self.maxwide = math.max(self.curwide, self.maxwide)
			self.lines[#self.lines + 1] = {}
			self.curwide = 0
		end
	end

	self.maxwide = math.max(self.curwide, self.maxwide)
	self:_PerformLayout()
end

function PANEL:AppendImage(info)
	self:AppendItem({"image", info})

	self:_PerformLayout()
end

function PANEL:InsertColorChange(r, g, b, a)
	if #self.lines == 0 then
		table.insert(self.lines, {})
	end

	table.insert(self.lines[#self.lines], {"textcolor", Color(r, g, b, a)})
end

function PANEL:InsertFontChange(font)
	if #self.lines == 0 then
		table.insert(self.lines, {})
	end

	table.insert(self.lines[#self.lines], {"font", font})

	surface.SetFont(font) --Fixme: Needed to calc following text widths, causes side effects!
end

function PANEL:PaintTextpart(text, font, x, y, colour)
	surface.SetFont(font)
	surface.SetTextPos(x, y)
	surface.SetTextColor(colour)
	surface.DrawText(text)
end

function PANEL:OnMouseReleased()
end

vgui.Register("DFancyText", PANEL)