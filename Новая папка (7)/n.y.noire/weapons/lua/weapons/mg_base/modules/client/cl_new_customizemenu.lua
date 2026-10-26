--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/weapons/lua/weapons/mg_base/modules/client/cl_new_customizemenu.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

if (SERVER) then return end

local blocked = {
	["Perks"] = true,
	["Magazines"] = true,
}

--opening the menu if no mgbase_customize bind (context menu)
hook.Add("OnContextMenuOpen", "MW_ContextMenu", function()
	if (input.LookupBinding("mgbase_customize", false) == nil) then
		RunConsoleCommand("mgbase_customize")
	end
end)

local function closeCustomizationMenu()
	gui.EnableScreenClicker(false)

	if (IsValid(MW_CUSTOMIZEMENU)) then
		MW_CUSTOMIZEMENU:Remove()
	end
end

local function validWeapon(weapon)
	return IsValid(weapon) and weapon:GetOwner() == LocalPlayer() and weapon:IsCustomizing()
end

if (IsValid(MW_CUSTOMIZEMENU)) then
	MW_CUSTOMIZEMENU:Remove()
end

MW_CUSTOMIZEMENU = nil

local function GetDarkRPItem(att)
	if DarkRP.Junk[att] then return DarkRP.Junk[att] end
	if DarkRP.SameAtts[att] and DarkRP.Junk[DarkRP.SameAtts[att]] then return DarkRP.Junk[DarkRP.SameAtts[att]] end
	return
end

local glass = Material("gmodla/glass.png", "smooth")

local function openCustomizationMenu(weapon)
	gui.EnableScreenClicker(true)
	MW_CUSTOMIZEMENU = vgui.Create("MSDSimpleFrame")

	local menu = MW_CUSTOMIZEMENU

	local SW, SH = ScrW(), ScrH()

	menu:SetSize(SW, SH)
	menu:Center()
	menu:SetAlpha(1)
	menu:AlphaTo(255, 0.5)
	menu.AlphaDelta = 0

	function menu:Paint(w, h)
		if (not validWeapon(weapon)) then return end

		if (not LocalPlayer():KeyDown(IN_USE)) then
			self.AlphaDelta = Lerp(math.min(10 * RealFrameTime(), 1), self.AlphaDelta, 1)
		else
			self.AlphaDelta = Lerp(math.min(10 * RealFrameTime(), 1), self.AlphaDelta, 0)
		end
	end

	function menu:Think()
		if (not validWeapon(weapon)) then
			closeCustomizationMenu()
			self:Remove()
		end
	end

	local categories = {}

	for slot, atts in pairs(weapon.Customization) do
		for ind, attClass in pairs(atts) do
			if (ind <= 1) then continue end
			if (MW_ATTS[attClass] == nil) then continue end
			local att = weapon:GetStoredAttachment(attClass)
			local category = att.Category
			if (category == nil) then continue end
			categories[category] = (categories[category] or 0) + ((weapon:IsAttachmentAllowed(att) and weapon:AllowedToAttach(ind, attClass, att.Category)) and 1 or 0)
		end
	end

	menu.page = vgui.Create("DPanel", menu)
	menu.page:SetSize(440, SH - SH / 6)
	menu.page:SetPos(15, 15)
	menu.page.text = ""

	function menu.page:Paint(w, h)
		MSD.Blur(self, 2, 2, 255, 0, w, h)
		MSDX.Draw(0, 0, 0, w, h, MSD.Theme.d)
		MSDX.Draw(0, 0, 0, w, 120, MSD.Theme.d)

		MSD.ShadowText(weapon.PrintName, "SF3S5", 10, 5, MSD.Config.MainColor["p"], TEXT_ALIGN_LEFT, 2)

		draw.DrawText(self.text, "GmodLA.Hand", w - 5, 71, color_black, TEXT_ALIGN_RIGHT)
		draw.DrawText(self.text, "GmodLA.Hand", w - 5, 70, color_white, TEXT_ALIGN_RIGHT)
	end

	menu.canvas = vgui.Create("MSDPanelList", menu.page)
	menu.canvas:SetSize(menu.page:GetWide(), menu.page:GetTall() - 120)
	menu.canvas:SetPos(0, 120)
	menu.canvas:SetSpacing(2)
	menu.canvas:SetPadding(0)
	menu.canvas:EnableVerticalScrollbar()
	menu.canvas:EnableHorizontal(true)

	menu.canvas.mainMenu = function()
		menu.page.text = "Доступные модификации"
		menu.canvas:Clear()
		for categoryName, count in SortedPairs(categories) do
			if blocked[categoryName] then continue end

			MSD.MenuButton(menu.canvas, MSD.Icons48.dot, nil, nil, 500, 50, categoryName, function(self)
				menu.canvas.slotMenu(categoryName)
			end)
		end
	end

	menu.canvas.slotMenu = function(categoryName)
		menu.page.text = categoryName
		menu.canvas:Clear()

		MSD.MenuButton(menu.canvas, MSD.Icons48.arrow_left, nil, nil, 500, 50, "Назад", function(self)
			menu.canvas.mainMenu()
		end)

		local atts = {}

		for slot, attachmentClasses in pairs(weapon.Customization) do
			for i, attachmentClass in pairs(attachmentClasses) do
				if (MW_ATTS[attachmentClass] == nil) then continue end
				local att = table.Copy(weapon:GetStoredAttachment(attachmentClass))

				local attachmentInUse = weapon:GetAttachmentInUseForSlot(slot)

				if att.Category == categoryName and (i > 1 or (attachmentInUse and DarkRP.InterCAT[att.ClassName])) and MW_ATTS[attachmentClass] ~= nil then
					atts[#atts + 1] = att
				end
			end
		end

		for atindx, attachment in pairs(atts) do
			if DarkRP.RestrictedAT and DarkRP.RestrictedAT[attachment.ClassName] then continue end

			local panel = vgui.Create("DButton")
			panel.StaticScale = {w = 1, fixed_h = 80, minw = 250, minh = 50}
			panel.IsAnItem = GetDarkRPItem(attachment.ClassName)

			if panel.IsAnItem then
				panel.HasItem = LocalPlayer():HaveItem(INV_JUNK, attachment.ClassName) > 0 or LocalPlayer():HaveItem(INV_JUNK, DarkRP.SameAtts[attachment.ClassName]) > 0
			end

			local attachmentInUse

			for slot, atc in pairs(weapon:GetAllAttachmentsInUse()) do
				if (atc.Category == categoryName) then
					attachmentInUse = atc
					break
				end
			end

			panel.IsInUse = attachmentInUse and attachmentInUse.ClassName == attachment.ClassName
			panel.IsAllowed = weapon:IsAttachmentAllowed(attachment) and weapon:AllowedToAttach(atindx, attachment.ClassName, categoryName)
			local blocker = weapon:GetBlockerAttachment(attachment)
			panel.Paint = function(self, w, h)
				if (not validWeapon(weapon)) then return end
				self.IsInUse = weapon:inUseBySlot(categoryName) and weapon:inUseBySlot(categoryName).ClassName == attachment.ClassName
				MSDX.Draw(0, 0, 0, w, h, MSD.Theme["d"])

				MSDX.Draw(0, 0, 0, 5, h, MSD.Patern.MainColor["p"])
				if self.IsInUse then
					MSD.DrawTexturedRect(0, 0, w, h, MSD.Materials.gradient, MSD.ColorAlpha(MSD.Patern.MainColor["8"], 55))
				end

				MSD.ShadowText(attachment.Name, "MSDFont.26", 15, 5, MSD.Text.s, TEXT_ALIGN_LEFT)

				if blocker then
					draw.DrawText("Блокируется: " .. blocker.Name, "MSDFont.16", 15, 58, DarkRP.Hud.Patern["red"], TEXT_ALIGN_LEFT)
				end

				if self.IsAnItem and not self.HasItem and not self.IsInUse then
					draw.DrawText("Требуется: " .. self.IsAnItem.name, "MSDFont.16", 15, 38, DarkRP.Hud.Patern["red"], TEXT_ALIGN_LEFT)
				end

				if not self.IsAllowed then
					MSD.DrawTexturedRect(0, 0, w, h, glass, color_white)
				end

				if attachment.UseJunk and DarkRP.Junk[attachment.UseJunk] then
					draw.DrawText("Требуется: " .. DarkRP.Junk[attachment.UseJunk].name, "MSDFont.16", 15, 38, DarkRP.Hud.Patern["red"], TEXT_ALIGN_LEFT)
				end

				return true
			end

			panel.DoClick = function(self)
				if not self.IsAllowed then return end
				local slotInUse = 1
				local indexInUse = 1

				for slot, a in pairs(weapon.Customization) do
					for i, att in pairs(a) do
						if (att == attachment.ClassName) then
							slotInUse = slot
							indexInUse = i
							break
						end
					end
				end

				net.Start("mgbase_customize_att")
				net.WriteInt(slotInUse, 8)
				net.WriteInt(indexInUse, 8)
				net.WriteEntity(weapon)
				net.SendToServer()
			end

			function panel:DoRightClick()
				SetClipboardText(attachment.ClassName)
			end
			menu.canvas:AddItem(panel)
		end
	end


	menu.canvas.mainMenu()

end

function SWEP:CustomizationMenu()
	if (self:IsCustomizing()) then
		openCustomizationMenu(self)
	end
end