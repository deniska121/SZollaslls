AddCSLuaFile()

if CLIENT and not MSD then
    MSD = {
        Theme = { d = Color(20,20,20,255), l = Color(40,40,40,255) },
        Config = { MainColor = { p = Color(255,150,0) }, Rounded = 4 },
        Text = { l = Color(255,255,255), d = Color(200,200,200), n = Color(150,150,150), a = Color(100,100,100) },
        Materials = { gradient = Material("gui/gradient") },
        Icons48 = { dot = Material("icon16/bullet_go.png") }
    }
    function MSD.MenuButton(parent, icon, width, height, text, func)
        local btn = vgui.Create("DButton", parent)
        btn:SetText(text)
        btn:SetSize(parent:GetWide() - 10, 50)
        btn.DoClick = func
        parent:AddItem(btn)
        return btn
    end
    function MSD.Blur(self, x, y, w, h) end
    function MSD.ColorAlpha(cl, alpha)
        if not cl then return Color(255,255,255,255) end
        return Color(cl.r, cl.g, cl.b, alpha)
    end
    function MSD.DrawTexturedRect(x, y, w, h, mat, cl)
        if surface and surface.SetDrawColor and surface.SetMaterial then
            surface.SetDrawColor(cl or color_white)
            surface.SetMaterial(mat)
            surface.DrawTexturedRect(x, y, w, h)
        end
    end
    function MSD.DrawKey(x, y, text)
        if draw and draw.SimpleTextOutlined then
            draw.SimpleTextOutlined(text, "MSDFont.16", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, color_black)
        end
    end
end

if not MW_CASES then MW_CASES = {} end

-- Расширение для игроков (без LocalPlayer в shared)
local plyMeta = FindMetaTable("Player")
if not plyMeta then
    plyMeta = {}
end

-- ПРОСТАЯ СИСТЕМА ПЕРЕЗАРЯДКИ (без инвентаря)

if surface and surface.CreateFont then
    surface.CreateFont("SF3S5", { font = "Roboto", size = 24, weight = 500 })
    surface.CreateFont("GmodLA.Hand", { font = "Roboto", size = 18, weight = 400 })
    surface.CreateFont("MSDFont.16", { font = "Roboto", size = 16, weight = 400 })
    surface.CreateFont("MSDFont.20", { font = "Roboto", size = 20, weight = 400 })
    surface.CreateFont("MSDFont.24", { font = "Roboto", size = 24, weight = 500 })
    surface.CreateFont("MSDFont.26", { font = "Roboto", size = 26, weight = 500 })
    surface.CreateFont("MSDFont.32", { font = "Roboto", size = 32, weight = 500 })
end
