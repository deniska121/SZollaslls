-- "addons\\mc_phone\\lua\\mc_phone\\modules\\camera.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
-- ╔═╗╔═╦═══╗╔═══╦╗────────────--
-- ║║╚╝║║╔═╗║║╔═╗║║────────────--
-- ║╔╗╔╗║║─╚╝║╚═╝║╚═╦══╦═╗╔══╗ --
-- ║║║║║║║─╔╗║╔══╣╔╗║╔╗║╔╗╣║═╣ --
-- ║║║║║║╚═╝║║║──║║║║╚╝║║║║║═╣ --
-- ╚╝╚╝╚╩═══╝╚╝──╚╝╚╩══╩╝╚╩══╝ --
-- ───── By Mactavish ─────────--
-- ────────────────────────────--
local module_id = 4
McPhone.Modules[module_id] = {}
McPhone.Modules[module_id].name = "Фото камера"
McPhone.Modules[module_id].icon = "mc_phone/icons/main_menu/cam.png"

McPhone.Modules[module_id].openMenu = function()
	if not McPhone.UI or not McPhone.UI.Menu then return end
	local m_list

	function m_list()
		McPhone.UI.Menu.ConvertToList()
		local frame = vgui.Create("DPanel")
		frame:SetSize(McPhone.UI.Menu:GetWide() - 14, McPhone.UI.Menu:GetTall())
		frame.unused = true
		local CamData, x, y = {}, 0, 0
		local origin, angles, nframe

		frame.Paint = function(self, w, h)
			x, y = self:LocalToScreen(0, 0)
			if not nframe then
				origin = LocalPlayer():GetShootPos()
				angles = LocalPlayer():EyeAngles()

				CamData.angles = angles
				CamData.origin = origin
				CamData.x = x
				CamData.y = y
				CamData.fov = 55
				CamData.drawviewmodel = false
				CamData.drawhud = false
				CamData.offcenter = false
				CamData.dopostprocess = false
				CamData.w = w
				CamData.h = h

				nframe = 0
			end

			if nframe then
				nframe = nframe + 1
				if nframe > ( 1 / FrameTime() ) / 6 then nframe = nil end
			end

			cam.Start2D()
			render.RenderView(CamData)
			surface.SetDrawColor(0, 0, 0, 255)
			surface.DrawLine(x + w / 3, y, x + w / 3, y + h)
			surface.DrawLine(x + (w / 3) * 2, y, x + (w / 3) * 2, y + h)
			surface.DrawLine(x, y + h / 3, x + w, y + h / 3)
			surface.DrawLine(x, y + (h / 3) * 2, x + w, y + (h / 3) * 2)
			cam.End2D()
		end

		McPhone.UI.Menu:AddItem(frame)

		McPhone.UI.Buttons.Left = {nil, nil, nil}

		McPhone.UI.Buttons.Middle = {
			"mc_phone/icons/buttons/id4.png", McPhone.MainColors["green"], function()
				if McPhone.camera then return end
				McPhone.UI:SetVisible(false)
				McPhone.camera = vgui.Create("DFrame")
				McPhone.camera:SetSize(ScrW(), ScrH())
				McPhone.camera:SetPos(0, 0)
				McPhone.camera:SetTitle("")
				McPhone.camera:SetDraggable(false)
				McPhone.camera:ShowCloseButton(false)
				origin = LocalPlayer():GetShootPos()
				angles = LocalPlayer():EyeAngles()

				CamData = {}
				CamData.angles = angles
				CamData.origin = origin
				CamData.drawviewmodel = false
				CamData.x = 0
				CamData.y = 0
				CamData.drawhud = false
				CamData.w = ScrW()
				CamData.h = ScrH()

				McPhone.camera.Paint = function(self, w, h)
					cam.Start2D()
					render.RenderView(CamData)
					cam.End2D()
					local lgw = 30 * 5.7
					MSD.DrawTexturedRect(ScrW() - lgw - 15, ScrH() - 55, lgw, 30, DarkRP.Hud.Materials.logo, color_white)

				end

				LocalPlayer():ConCommand("screenshot")

				timer.Simple(1, function()
					McPhone.UI:SetVisible(true)
					McPhone.camera:Remove()
					McPhone.camera = nil
				end)
			end
		}

		McPhone.UI.Buttons.Right = {"mc_phone/icons/buttons/id15.png", McPhone.MainColors["red"], nil}
	end

	m_list()
end