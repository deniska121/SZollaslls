--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/basebox/gamemode/spawnmenu/contextmenu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

local PANEL = {}
AccessorFunc(PANEL, "m_bHangOpen", "HangOpen")

function PANEL:Init()
	self:SetWorldClicker(true)
	self.Canvas = vgui.Create("DCategoryList", self)
	self.m_bHangOpen = false
	self:Dock(FILL)
end

function PANEL:Open()
	self:SetHangOpen(false)

	-- If the spawn menu is open, try to close it..
	if (IsValid(g_SpawnMenu) and g_SpawnMenu:IsVisible()) then
		g_SpawnMenu:Close(true)
	end

	if (self:IsVisible()) then return end
	CloseDermaMenus()
	self:MakePopup()
	self:SetVisible(true)
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(true)
	RestoreCursorPosition()
	local bShouldShow = true

	-- TODO: Any situation in which we shouldn't show the tool menu on the context menu?
	-- Set up the active panel..
	if (bShouldShow and IsValid(spawnmenu.ActiveControlPanel())) then
		self.OldParent = spawnmenu.ActiveControlPanel():GetParent()
		self.OldPosX, self.OldPosY = spawnmenu.ActiveControlPanel():GetPos()
		spawnmenu.ActiveControlPanel():SetParent(self)
		self.Canvas:Clear()
		self.Canvas:AddItem(spawnmenu.ActiveControlPanel())
		self.Canvas:Rebuild()
		self.Canvas:SetVisible(true)
	else
		self.Canvas:SetVisible(false)
	end

	self:InvalidateLayout(true)
end

function PANEL:Close(bSkipAnim)
	if (self:GetHangOpen()) then
		self:SetHangOpen(false)

		return
	end

	RememberCursorPosition()
	CloseDermaMenus()
	self:SetKeyboardInputEnabled(false)
	self:SetMouseInputEnabled(false)
	self:SetAlpha(255)
	self:SetVisible(false)
	self:RestoreControlPanel()
end

function PANEL:PerformLayout()
	if (IsValid(spawnmenu.ActiveControlPanel())) then
		spawnmenu.ActiveControlPanel():InvalidateLayout(true)
		local Tall = math.min(spawnmenu.ActiveControlPanel():GetTall() + 10, ScrH() * 0.8)

		if (self.Canvas:GetTall() ~= Tall) then
			self.Canvas:SetTall(Tall)
		end

		if (self.Canvas:GetWide() ~= 320) then
			self.Canvas:SetWide(320)
		end

		self.Canvas:SetPos(ScrW() - self.Canvas:GetWide() - 50, ScrH() - 50 - Tall)
		self.Canvas:InvalidateLayout(true)
	end
end

function PANEL:StartKeyFocus(pPanel)
	self:SetKeyboardInputEnabled(true)
	self:SetHangOpen(true)
end

function PANEL:EndKeyFocus(pPanel)
	self:SetKeyboardInputEnabled(false)
end

function PANEL:RestoreControlPanel()
	-- Restore the active panel
	if (not spawnmenu.ActiveControlPanel()) then return end
	if (not self.OldParent) then return end
	spawnmenu.ActiveControlPanel():SetParent(self.OldParent)
	spawnmenu.ActiveControlPanel():SetPos(self.OldPosX, self.OldPosY)
	self.OldParent = nil
end

--
-- Note here: EditablePanel is important! Child panels won't be able to get
-- keyboard input if it's a DPanel or a Panel. You need to either have an EditablePanel
-- or a DFrame (which is derived from EditablePanel) as your first panel attached to the system.
--
vgui.Register("ContextMenu", PANEL, "EditablePanel")

function CreateContextMenu()
	if (not hook.Run("ContextMenuEnabled")) then return end

	if (IsValid(g_ContextMenu)) then
		g_ContextMenu:Remove()
		g_ContextMenu = nil
	end

	g_ContextMenu = vgui.Create("ContextMenu")
	if (not IsValid(g_ContextMenu)) then return end
	g_ContextMenu:SetVisible(false)

	--
	-- We're blocking clicks to the world - but we don't want to
	-- so feed clicks to the proper functions..
	--
	g_ContextMenu.OnMousePressed = function(p, code)
		hook.Run("GUIMousePressed", code, gui.ScreenToVector(gui.MousePos()))
	end

	g_ContextMenu.OnMouseReleased = function(p, code)
		hook.Run("GUIMouseReleased", code, gui.ScreenToVector(gui.MousePos()))
	end

	hook.Run("ContextMenuCreated", g_ContextMenu)
	local IconLayout = g_ContextMenu:Add("DIconLayout")
	IconLayout:SetBorder(8)
	IconLayout:SetSpaceX(8)
	IconLayout:SetSpaceY(8)
	IconLayout:SetLayoutDir(LEFT)
	IconLayout:SetWorldClicker(true)
	IconLayout:SetStretchWidth(true)
	IconLayout:SetStretchHeight(false) -- No infinite re-layouts
	IconLayout:Dock(LEFT)

	-- This overrides DIconLayout's OnMousePressed (which is inherited from DPanel), but we don't care about that in this case
	IconLayout.OnMousePressed = function(s, ...)
		s:GetParent():OnMousePressed(...)
	end

	for k, v in pairs(list.Get("DesktopWindows")) do
		local icon = IconLayout:Add("DButton")
		icon:SetText("")
		icon:SetSize(80, 82)
		icon.Paint = function() end
		local image = icon:Add("DImage")
		image:SetImage(v.icon)
		image:SetSize(64, 64)
		image:Dock(TOP)
		image:DockMargin(8, 0, 8, 0)
		local label = icon:Add("DLabel")
		label:Dock(BOTTOM)
		label:SetText(v.title)
		label:SetContentAlignment(5)
		label:SetTextColor(color_white)
		label:SetExpensiveShadow(1, Color(0, 0, 0, 200))

		icon.DoClick = function()
			--
			-- v might have changed using autorefresh so grab it again
			--
			local newv = list.Get("DesktopWindows")[k]

			if (v.onewindow and IsValid(icon.Window)) then
				icon.Window:Center()

				return
			end

			-- Make the window
			icon.Window = g_ContextMenu:Add("DFrame")
			icon.Window:SetSize(newv.width, newv.height)
			icon.Window:SetTitle(newv.title)
			icon.Window:Center()
			newv.init(icon, icon.Window)
		end
	end
end

function GM:OnContextMenuOpen()
	-- Let the gamemode decide whether we should open or not..
	if (not hook.Call("ContextMenuOpen", self)) then return end

	if (IsValid(g_ContextMenu) and not g_ContextMenu:IsVisible()) then
		g_ContextMenu:Open()
		--menubar.ParentTo( g_ContextMenu )
	end

	hook.Call("ContextMenuOpened", self)
	hook.Remove("PreDrawHalos", "PropertiesHover")
	--
end

function GM:OnContextMenuClose()
	if (IsValid(g_ContextMenu)) then
		g_ContextMenu:Close()
	end

	hook.Call("ContextMenuClosed", self)
end

concommand.Add("menu_update", function()
	CreateContextMenu()
end)

local lastEyePos = vector_origin

hook.Add("PreDrawHalos", "PropertiesHoverNew", function()
	if (not IsValid(vgui.GetHoveredPanel()) or not vgui.GetHoveredPanel():IsWorldClicker()) then return end
	lastEyePos = EyePos()
	properties.GetHovered(lastEyePos, LocalPlayer():GetAimVector())
end)

hook.Add("GUIMousePressed", "PropertiesClick", function(code, vector)
	if (not IsValid(vgui.GetHoveredPanel()) or not vgui.GetHoveredPanel():IsWorldClicker()) then return end

	if (code == MOUSE_RIGHT and not input.IsButtonDown(MOUSE_LEFT)) then
		properties.OnScreenClick(lastEyePos, vector)
	end
end)
local wasPressed = false

hook.Add("PreventScreenClicks", "PropertiesPreventClicks", function()
	if (not input.IsButtonDown(MOUSE_RIGHT)) then
		wasPressed = false
	end

	if (wasPressed and input.IsButtonDown(MOUSE_RIGHT) and not input.IsButtonDown(MOUSE_LEFT)) then return true end
	if (not IsValid(vgui.GetHoveredPanel()) or not vgui.GetHoveredPanel():IsWorldClicker()) then return end
	local ply = LocalPlayer()
	if (not IsValid(ply)) then return end

	if (input.IsButtonDown(MOUSE_RIGHT) and not input.IsButtonDown(MOUSE_LEFT)) then

		local hovered = properties.GetHovered(lastEyePos, ply:GetAimVector())

		if (IsValid(hovered)) then
			wasPressed = true
			return true
		end
	end
end)