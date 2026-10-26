if SERVER then
    util.AddNetworkString("OpenLoading")
    util.AddNetworkString("CameraUpdate")

    local dataDir = "names_data/"

    hook.Add("Initialize", "EnsureDataFolders", function()
        if not file.Exists(dataDir, "DATA") then
            file.CreateDir("names_data")
        end
    end)

    local function GetNames()
        local path = dataDir .. "names.json"
        if file.Exists(path, "DATA") then
            local data = file.Read(path, "DATA")
            if data and data ~= "" then
                return util.JSONToTable(data) or {}
            end
        end
        return {}
    end

    local function SaveNames(data)
        local path = dataDir .. "names.json"
        file.Write(path, util.TableToJSON(data))
    end

    local function GenerateName()
        local names = GetNames()
        
        if not names.first or type(names.first) ~= "table" or #names.first == 0 then
            names.first = {
                "James", "John", "Robert", "Michael", "William", "David", "Richard", "Joseph", "Thomas", "Charles",
                "Mary", "Patricia", "Jennifer", "Linda", "Barbara", "Elizabeth", "Susan", "Jessica", "Sarah", "Karen",
                "Daniel", "Matthew", "Anthony", "Mark", "Donald", "Steven", "Paul", "Andrew", "Joshua", "Kenneth",
                "Kevin", "Brian", "George", "Timothy", "Ronald", "Edward", "Jason", "Jeffrey", "Ryan", "Jacob",
                "Gary", "Nicholas", "Eric", "Jonathan", "Stephen", "Larry", "Justin", "Scott", "Brandon", "Benjamin",
                "Samuel", "Gregory", "Frank", "Alexander", "Patrick", "Jack", "Dennis", "Jerry", "Tyler", "Aaron",
                "Amanda", "Melissa", "Michelle", "Kimberly", "Amy", "Angela", "Heather", "Kathleen", "Rebecca", "Laura",
                "Emma", "Olivia", "Ava", "Sophia", "Mia", "Charlotte", "Amelia", "Harper", "Evelyn", "Abigail",
                "Noah", "Liam", "Mason", "Ethan", "Logan", "Aiden", "Carter", "Oliver", "Lucas", "Muhammad"
            }
            SaveNames(names)
        end
        
        local first = names.first[math.random(#names.first)]
        return first
    end

    local function GetRandomModel()
        local models = {
            "models/player/group01/male_01.mdl",
            "models/player/group01/male_02.mdl",
            "models/player/group01/male_03.mdl",
            "models/player/group01/male_04.mdl",
            "models/player/group01/male_05.mdl",
            "models/player/group01/male_06.mdl",
            "models/player/group01/male_07.mdl",
            "models/player/group01/male_08.mdl",
            "models/player/group01/male_09.mdl",
            "models/player/group01/female_01.mdl",
            "models/player/group01/female_02.mdl",
            "models/player/group01/female_03.mdl",
            "models/player/group01/female_04.mdl",
            "models/player/group01/female_05.mdl",
            "models/player/group01/female_06.mdl"
        }
        return models[math.random(#models)]
    end

    local function SetRandomName(ply)
        if not IsValid(ply) then return end
        local fname = GenerateName()
        ply:SetName(fname)
        ply:SetNWString("FullName", fname)
        return fname
    end

    hook.Add("PlayerSpawn", "SpawnHandler", function(ply)
        if not IsValid(ply) then return end

        local currentName = ply:GetNWString("FullName", "")
        if currentName == "" then
            SetRandomName(ply)
        else
            ply:SetName(currentName)
        end

        local model = GetRandomModel()
        if util.IsValidModel(model) then
            ply:SetModel(model)
        end

        ply:SetSlowWalkSpeed(60)
        ply:SetWalkSpeed(120)
        ply:SetRunSpeed(200)

        timer.Simple(0.2, function()
            if IsValid(ply) then
                ply:StripWeapons()
                local hands = ply:Give("weapon_ebaniehands")
                if IsValid(hands) then
                    ply:SelectWeapon("weapon_ebaniehands")
                end
            end
        end)

        if ply.FirstSpawn == nil then
            ply.FirstSpawn = true
            timer.Simple(0.5, function()
                if IsValid(ply) then
                    net.Start("OpenLoading")
                    net.Send(ply)
                end
            end)
        end
    end)

    hook.Add("PlayerDeath", "ResetOnDeath", function(ply)
        timer.Simple(1.0, function()
            if IsValid(ply) then
                SetRandomName(ply)
                local model = GetRandomModel()
                if util.IsValidModel(model) then
                    ply:SetModel(model)
                end
                ply:SetSlowWalkSpeed(60)
                ply:SetWalkSpeed(120)
                ply:SetRunSpeed(200)
            end
        end)
    end)

    hook.Add("PlayerInitialSpawn", "InitTriggerReset", function(ply)
        ply.FirstSpawn = nil
    end)

    hook.Add("PlayerInitialSpawn", "SetNameOnJoin", function(ply)
        timer.Simple(0.5, function()
            if IsValid(ply) then
                local name = ply:GetNWString("FullName", "")
                if name ~= "" then
                    ply:SetName(name)
                end
            end
        end)
    end)

    concommand.Add("chars", function(ply)
        if IsValid(ply) then
            net.Start("OpenLoading")
            net.Send(ply)
        end
    end)
end

if CLIENT then
    surface.CreateFont("LoadingBig", { font = "Roboto", size = 32, weight = 700 })
    surface.CreateFont("NameBig", { font = "Roboto", size = 48, weight = 900 })
    surface.CreateFont("SubBig", { font = "Roboto", size = 24, weight = 700 })

    local gmodla = Material("gmodla/logo_c2.png", "smooth")
    local blur = Material("pp/blurscreen")
    local color_b50 = Color(0,0,0,150)
    local color_black = Color(0, 0, 0)
    local color_white = Color(255, 255, 255)

    local SW, SH = ScrW(), ScrH()
    local origin, angles, fov = Vector(0,0,0), Angle(0,0,0), 90
    local isOpen = false

    Config = Config or {}
    Config.Cams = {
        [1] = {
            st = { pos = Vector(815.33795166016, -4290.3120117188, 981.59234619141), ang = Angle(-0.57916700839996, -131.41290283203, 0), fov = 25, spd = 1, aspd = 1 },
            ed = { pos = Vector(815.33795166016, -4290.3120117188, 981.59234619141), ang = Angle(-5.7195725440979, -80.07663726807, 0), fov = 75, spd = 1, aspd = 1 },
        },
        [2] = {
            st = { pos = Vector(-1228.9605712891, 3637.3056640625, 421.50433349609), ang = Angle(-47.226600646973, 90, 0), fov = 45, spd = 1, aspd = 1 },
            ed = { pos = Vector(-1228.9605712891, 3637.3056640625, 421.50433349609), ang = Angle(14.255506515503, 90, 0), fov = 120, spd = 1, aspd = 1 },
        },
        [3] = {
            st = { pos = Vector(1924.6267089844, 369.74279785156, 403.95388793945), ang = Angle(20.561576843262, 155.43455505371, 0), fov = 65, spd = 1, aspd = 1 },
            ed = { pos = Vector(2124.0249023438, 533.54272460938, 536.03662109375), ang = Angle(4.1992945671082, 69.133949279785, 0), fov = 45, spd = 1, aspd = 1 },
        },
        [4] = {
            st = { pos = Vector(3085.1787109375, 9277.8115234375, 321.4450378418), ang = Angle(0, 180, 0), fov = 90, spd = 1, aspd = 1 },
            ed = { pos = Vector(5764.91796875, 9272.7080078125, 369.86752319336), ang = Angle(0, 180, 0), fov = 30, spd = 1, aspd = 1 },
        },
        [5] = {
            st = { pos = Vector(-7670.3090820313, 6595.26171875, 48.525058746338), ang = Angle(0, -90, 60), fov = 90, spd = 1, aspd = 1 },
            ed = { pos = Vector(-7670.3090820313, 6595.26171875, 48.525058746338), ang = Angle(0, -90, -20), fov = 45, spd = 1, aspd = 1 },
        },
    }

    local viewBob = 0
    local viewBobSpeed = 1
    local targetViewBob = 0
    local currentViewBob = 0
    local duckOffset = 0
    local targetDuckOffset = 0
    local currentDuckOffset = 0
    local lastPos = Vector(0,0,0)

    function Blur(panel, inn, density, alpha, x, y, w, h)
        local px, py = panel:LocalToScreen(0, 0)
        x, y = panel:LocalToScreen(x, y)
        surface.SetDrawColor(255, 255, 255, alpha)
        surface.SetMaterial(blur)
        for i = 1, 3 do
            blur:SetFloat("$blur", (i / inn) * density)
            blur:Recompute()
            render.UpdateScreenEffectTexture()
            if w and h then
                render.SetScissorRect(x, y, x + w, y + h, true)
                surface.DrawTexturedRect(px, py, ScrW(), ScrH())
                render.SetScissorRect(0, 0, 0, 0, false)
            else
                surface.DrawTexturedRect(x, y, ScrW(), ScrH())
            end
        end
    end

    function OpenLoadingMenu()
        if isOpen then return end
        isOpen = true

        local camera, progress = false, false
        local camera_time = CurTime() + 0.1
        local camera_state = 1
        local camera_time_max = 15
        local reset = true

        local Main = vgui.Create("DFrame")
        Main:SetSize(SW, SH)
        Main:SetTitle("")
        Main:SetVisible(true)
        Main:SetDraggable(false)
        Main:ShowCloseButton(false)
        Main:Center()
        Main:MakePopup()
        LoadingMenu = Main

        Main.OnClose = function(self)
            isOpen = false
            LoadingMenu = nil
            viewBob = 0
            currentViewBob = 0
            duckOffset = 0
            currentDuckOffset = 0
        end

        Main.Paint = function(self, w, h)
            if not progress or not camera then
                draw.RoundedBox(0, 0, 0, w, h, color_black)
            else
                draw.RoundedBox(0, 0, h / 2 - 60, w, 180, color_b50)
                Blur(self, 2, 2, 255, 0, h / 2 - 60, w, 180)
            end

            if camera then
                local alpha = 255
                if camera_time > CurTime() then
                    alpha = 255 * (1 - (camera_time - CurTime()) / camera_time_max)
                end
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, alpha))
            end

            if Main.Closing then
                draw.RoundedBox(0, 0, 0, w, h, Color(0, 0, 0, 255 * (1 - (camera_time - CurTime()) / camera_time_max)))
                draw.DrawText("Загрузка..", "LoadingBig", w / 2, (h / 2 + 55), Color(255, 255, 255, 255 * (1 - (camera_time - CurTime()) / camera_time_max)), TEXT_ALIGN_CENTER)
            end

            surface.SetMaterial(gmodla)
            surface.SetDrawColor(color_white)
            surface.DrawTexturedRect(w / 2 - 200, h / 2 - 80, 400, 161)

            self.text = Main.Closing and "Загрузка.." or "Нажмите ЛКМ чтобы продолжить"
            draw.DrawText(self.text, "LoadingBig", w / 2 + 2, h / 2 + 57, Color(0, 0, 0, 150), TEXT_ALIGN_CENTER)
            draw.DrawText(self.text, "LoadingBig", w / 2, h / 2 + 55, Color(255, 255, 255, 100 + math.abs(math.sin(CurTime() * 3)) * 155), TEXT_ALIGN_CENTER)
        end

        local function CamChange()
            camera_time = CurTime() + camera_time_max
            if camera_state + 1 > #Config.Cams then
                camera_state = 1
            else
                camera_state = camera_state + 1
            end
            local cdata = Config.Cams[camera_state]
            if cdata then
                origin = cdata.st.pos
                angles = cdata.st.ang
                fov = cdata.st.fov
                reset = false

                net.Start("CameraUpdate")
                    net.WriteUInt(camera_state, 4)
                net.SendToServer()
            end
        end

        Main.Think = function(self, w, h)
            if camera and not Main.Closing then
                local cdata_m = Config.Cams[camera_state]
                if cdata_m then
                    local ply = LocalPlayer()
                    if IsValid(ply) then
                        local vel = ply:GetVelocity()
                        local speed = vel:Length()
                        local isMoving = speed > 10
                        local isRunning = speed > 150
                        local isDucking = ply:KeyDown(IN_DUCK)
                        local isWalking = ply:KeyDown(IN_WALK)

                        local basePos = cdata_m.ed.pos
                        local baseAng = cdata_m.ed.ang
                        local plyPos = ply:GetPos()

                        local newPos = Vector(basePos.x + plyPos.x, basePos.y + plyPos.y, basePos.z + plyPos.z)

                        if isMoving and not isDucking then
                            local bobSpeed = isRunning and 8 or (isWalking and 4 or 6)
                            targetViewBob = isRunning and 2.5 or (isWalking and 1.0 or 1.8)
                            viewBobSpeed = bobSpeed
                        else
                            targetViewBob = 0
                            viewBobSpeed = 1
                        end

                        if isDucking then
                            targetDuckOffset = -20
                        else
                            targetDuckOffset = 0
                        end

                        currentViewBob = Lerp(FrameTime() * 6, currentViewBob, targetViewBob)
                        currentDuckOffset = Lerp(FrameTime() * 4, currentDuckOffset, targetDuckOffset)

                        if isMoving and not isDucking then
                            viewBob = viewBob + FrameTime() * viewBobSpeed
                        else
                            viewBob = viewBob + FrameTime() * 1
                        end

                        local bobOffset = math.sin(viewBob) * currentViewBob
                        local bobOffsetZ = math.abs(math.cos(viewBob * 0.5)) * currentViewBob * 0.3

                        newPos.z = newPos.z + currentDuckOffset + bobOffsetZ
                        local newAng = Angle(baseAng.pitch + bobOffset * 0.3, baseAng.yaw, baseAng.roll)

                        origin = LerpVector(FrameTime() * (cdata_m.ed.spd * 0.1), origin, newPos)
                        angles = LerpAngle(FrameTime() * (cdata_m.ed.aspd * 0.1), angles, newAng)
                        fov = Lerp(FrameTime() * (cdata_m.ed.spd * 0.1), fov, cdata_m.ed.fov)

                        lastPos = plyPos
                    else
                        origin = LerpVector(FrameTime() * (cdata_m.ed.spd * 0.1), origin, cdata_m.ed.pos)
                        angles = LerpAngle(FrameTime() * (cdata_m.ed.aspd * 0.1), angles, cdata_m.ed.ang)
                        fov = Lerp(FrameTime() * (cdata_m.ed.spd * 0.1), fov, cdata_m.ed.fov)
                    end

                    if not reset and (camera_time < CurTime()) and not Main.Closing then
                        reset = true
                        CamChange()
                    end
                end
            end
        end

        local EnterButton = vgui.Create("DButton", Main)
        EnterButton:SetText("")
        EnterButton:SetPos(0, 0)
        EnterButton:SetCursor("blank")
        EnterButton:SetSize(SW, SH)
        EnterButton.Paint = function(self, w, h) end

        EnterButton.DoClick = function()
            if not progress then
                progress = true
                CamChange()
                camera = true
            else
                Main.Closing = true
                timer.Simple(1.5, function()
                    if IsValid(Main) then
                        Main:Close()
                    end
                end)
            end
        end

        EnterButton.DoRightClick = function(self)
            self:DoClick()
        end
    end

    net.Receive("OpenLoading", function()
        OpenLoadingMenu()
    end)

    hook.Add("RenderScene", "LoadingCams", function()
        if LoadingMenu then
            render.Clear(0, 0, 0, 255)
            local view = {
                x = 0, y = 0, w = ScrW(), h = ScrH(),
                angles = angles, fov = fov, origin = origin,
                drawviewmodel = false
            }
            render.RenderView(view)
            return true
        end
    end)

    hook.Add("HUDShouldDraw", "HUDShouldDraw", function()
        if LoadingMenu then return false end
    end)

    concommand.Add("loading", function()
        if IsValid(LoadingMenu) then return end
        OpenLoadingMenu()
    end)
end