--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/simp_phys_lmao/lua/simfphys/client/tab.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

CreateClientConVar("noire_car_hidesprites", "0", true, false)
CreateClientConVar("noire_car_frontlamps", "1", true, false)
CreateClientConVar("noire_car_rearlamps", "1", true, false)
CreateClientConVar("noire_car_shadows", "0", true, false)
CreateClientConVar("noire_car_skidmarks", "1", true, false)
CreateClientConVar("noire_car_smokeon", "1", true, false)

local cicons = {
    ["Гос департамент"] = "icon16/shield.png",
    ["Гражданские"] = "icon16/car.png",
    ["Другое"] = "icon16/package.png",
    ["Премиум"] = "icon16/car_add.png",
    ["Промышленные"] = "icon16/lorry.png",
    ["Сервисы"] = "icon16/lorry_flatbed.png",
}

hook.Add("SimfphysPopulateVehicles", "AddEntityContent", function(pnlContent, tree, node)
    local Categorised = {}

    local Vehicles = list.Get("simfphys_vehicles")

    if Vehicles then
        for k, v in pairs(Vehicles) do
            v.Category = v.Category or "Other"
            Categorised[v.Category] = Categorised[v.Category] or {}
            v.ClassName = k
            v.PrintName = v.Name
            table.insert(Categorised[v.Category], v)
        end
    end

    for CategoryName, v in SortedPairs(Categorised) do
        -- Add a node to the tree
        node = tree:AddNode(CategoryName, cicons[CategoryName] or "icon16/bricks.png")

        -- When we click on the node - populate it using this function
        node.DoPopulate = function(self)
            -- If we've already populated it - forget it.
            if self.PropPanel then return end
            -- Create the container panel
            self.PropPanel = vgui.Create("ContentContainer", pnlContent)
            self.PropPanel:SetVisible(false)
            self.PropPanel:SetTriggerSpawnlistChange(false)

            for k, ent in SortedPairsByMemberValue(v, "PrintName") do
                spawnmenu.CreateContentIcon("simfphys_vehicles", self.PropPanel, {
                    nicename = ent.PrintName or ent.ClassName,
                    spawnname = ent.ClassName,
                    material = "entities/" .. ent.ClassName .. ".png",
                    admin = ent.AdminOnly
                })
            end
        end

        node.DoClick = function(self)
            self:DoPopulate()
            pnlContent:SwitchPanel(self.PropPanel)
        end
    end

    local FirstNode = tree:Root():GetChildNode(0)

    if IsValid(FirstNode) then
        FirstNode:InternalDoClick()
    end
end)

-- spawnmenu.AddCreationTab("Транспорт", function()
--     local ctrl = vgui.Create("SpawnmenuContentPanel")
--     ctrl:CallPopulateHook("SimfphysPopulateVehicles")

--     return ctrl
-- end, "icon16/lorry.png", 50)

spawnmenu.AddContentType("simfphys_vehicles", function(container, obj)
    if not obj.material then return end
    if not obj.nicename then return end
    if not obj.spawnname then return end
    local icon = vgui.Create("ContentIcon", container)
    icon:SetContentType("simfphys_vehicles")
    icon:SetSpawnName(obj.spawnname)
    icon:SetName(obj.nicename)
    icon:SetMaterial(obj.material)
    icon:SetAdminOnly(obj.admin)
    icon:SetColor(Color(0, 0, 0, 255))

    icon.DoClick = function()
        RunConsoleCommand("simfphys_spawnvehicle", obj.spawnname)
        surface.PlaySound("ui/buttonclickrelease.wav")
    end

    icon.OpenMenu = function()
        local menu = DermaMenu()

        menu:AddOption("Copy to Clipboard", function()
            SetClipboardText(obj.spawnname)
        end)

        menu:Open()
    end

    if IsValid(container) then
        container:Add(icon)
    end

    return icon
end)