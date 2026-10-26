AddCSLuaFile()

if SERVER then
    util.AddNetworkString("med_heal_action")
    util.AddNetworkString("med_cpr_action")
    util.AddNetworkString("med_diagnose")
    util.AddNetworkString("med_saline")
end

if CLIENT then
    surface.CreateFont("med_font_radial", {
        font = "Roboto",
        size = 26,
        weight = 800,
        extended = true,
        antialiasing = true
    })
    
    surface.CreateFont("med_font_hud", {
        font = "Roboto",
        size = 20,
        weight = 600,
        extended = true,
        antialiasing = true
    })
    
    hook.Add("InputMouseApply", "med_mouse_lock_cl", function(cmd, x, y, ang)
        if LocalPlayer():GetNWFloat("MedLockTime", 0) > CurTime() then
            return true
        end
    end)
end

SWEP.PrintName = "Аптечка"
SWEP.Author = "нн / Mactavish"
SWEP.Purpose = "Зачем"
SWEP.Slot = 2
SWEP.SlotPos = 3
SWEP.Spawnable = true
SWEP.Category = "YetgStuff"
SWEP.NoireMedical = true
SWEP.DrawCrosshair = false


SWEP.ViewModel = Model("models/weapons/c_medkit.mdl")
SWEP.WorldModel = Model("models/w_models/weapons/w_eq_medkit.mdl")
SWEP.ViewModelFOV = 54
SWEP.UseHands = true
SWEP.ShowWorldModel = false

SWEP.ViewModelBoneMods = {
	["medkit_bone"] = { scale = Vector(0.009, 0.009, 0.009), pos = Vector(0, 0, 0), angle = Angle(0, 0, 0) }
}
SWEP.VElements = {
	["model"] = { type = "Model", model = "models/w_models/weapons/w_eq_medkit.mdl", bone = "medkit_bone", rel = "", pos = Vector(-4.921, 0.312, -1.691), angle = Angle(-86.319, 0, 0), size = Vector(1, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}
SWEP.WElements = {
	["model"] = { type = "Model", model = "models/w_models/weapons/w_eq_medkit.mdl", bone = "ValveBiped.Bip01_R_Hand", rel = "", pos = Vector(3.295, 1.128, 0), angle = Angle(4.052, 14.89, 100.022), size = Vector(0.656, 1, 1), color = Color(255, 255, 255, 255), surpresslightning = false, material = "", skin = 0, bodygroup = {} }
}

SWEP.Primary.ClipSize = 40
SWEP.Primary.DefaultClip = 40
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = ""

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = ""

SWEP.HoldType = "slam"
SWEP.HealRange = 100
SWEP.AmmoRegenRate = 3
SWEP.AmmoRegenAmount = 1

local function get_tgt(ent)
    if not IsValid(ent) then return nil end
    if ent:IsPlayer() then return ent end
    if ent:GetClass() == "prop_ragdoll" then
        for _, p in ipairs(player.GetAll()) do
            if p:GetNWEntity("Ragdoll") == ent then
                return p
            end
        end
    end
    return nil
end

function SWEP:SetupDataTables()
    self:NetworkVar("Float", 0, "LastAmmoRegen")
    self:NetworkVar("Float", 1, "NextIdle")
end

function SWEP:Initialize()
    self:SetHoldType(self.HoldType)
    self:SetLastAmmoRegen(CurTime())
    
    if CLIENT then
        self.AmmoDisplay = { Draw = true, PrimaryClip = 0 }
        
        self.VElements = table.FullCopy(self.VElements)
        self.WElements = table.FullCopy(self.WElements)
        self.ViewModelBoneMods = table.FullCopy(self.ViewModelBoneMods)
        self:CreateModels(self.VElements)
        self:CreateModels(self.WElements)

        if IsValid(self:GetOwner()) then
            local vm = self:GetOwner():GetViewModel()
            if IsValid(vm) then
                self:ResetBonePositions(vm)
                if (self.ShowViewModel == nil or self.ShowViewModel) then
                    vm:SetColor(color_white)
                else
                    vm:SetColor(Color(255, 255, 255, 1))
                    vm:SetMaterial("null")
                end
            end
        end
    end
end

function SWEP:Deploy()
    self:Regen(false)
    return true
end

if CLIENT then
    function SWEP:OpenRadialMenu(options)
        local ply = self:GetOwner()
        ply:EmitSound("piemenu_open.wav", 75, 100, 0.25)
        
        local menu = vgui.Create("EditablePanel")
        menu:SetSize(ScrW(), ScrH())
        menu:MakePopup()
        
        local cx, cy = ScrW() / 2, ScrH() / 2
        local radius_outer = 240
        local radius_inner = 95
        local segments = #options
        local angle_step = 360 / segments
        local start_angle = -90 - (angle_step / 2)
        
        local polys_outer = {}
        for i = 1, segments do
            local a1 = math.rad(start_angle + (i-1)*angle_step)
            local a2 = math.rad(start_angle + i*angle_step)
            local poly = {{ x = cx, y = cy }}
            for a = a1, a2, math.rad(2) do
                table.insert(poly, { x = cx + math.cos(a) * radius_outer, y = cy + math.sin(a) * radius_outer })
            end
            table.insert(poly, { x = cx + math.cos(a2) * radius_outer, y = cy + math.sin(a2) * radius_outer })
            polys_outer[i] = poly
        end
        
        local poly_inner = {}
        for a = 0, math.rad(360), math.rad(5) do
            table.insert(poly_inner, { x = cx + math.cos(a) * radius_inner, y = cy + math.sin(a) * radius_inner })
        end
        
        local hover_idx = nil
        local last_hover_idx = nil
        
        function menu:Paint(w, h)
            local mx, my = gui.MouseX(), gui.MouseY()
            local dx, dy = mx - cx, my - cy
            local dist = math.sqrt(dx*dx + dy*dy)
            hover_idx = nil
            
            if dist > radius_inner and dist < radius_outer then
                local angle = math.deg(math.atan2(dy, dx))
                if angle < start_angle then angle = angle + 360 end
                local idx = math.floor((angle - start_angle) / angle_step) + 1
                if idx >= 1 and idx <= segments then
                    hover_idx = idx
                end
            end
            
            if hover_idx ~= last_hover_idx then
                last_hover_idx = hover_idx
                if hover_idx ~= nil then
                    ply:EmitSound("piemenu_selectionchange.wav", 75, 100, 0.25)
                end
            end
            
            draw.NoTexture()
            for i = 1, segments do
                local col = (hover_idx == i) and Color(0, 0, 0, 200) or Color(20, 20, 20, 160)
                surface.SetDrawColor(col)
                surface.DrawPoly(polys_outer[i])
            end
            
            surface.SetDrawColor(15, 15, 15, 250)
            surface.DrawPoly(poly_inner)
            
            surface.SetDrawColor(0, 0, 0, 255)
            for i = 1, segments do
                local a = math.rad(start_angle + i*angle_step)
                surface.DrawLine(cx, cy, cx + math.cos(a)*radius_outer, cy + math.sin(a)*radius_outer)
            end
            
            for i = 1, segments do
                local a = math.rad(start_angle + (i-1)*angle_step + angle_step/2)
                local tx = cx + math.cos(a) * (radius_outer * 0.65)
                local ty = cy + math.sin(a) * (radius_outer * 0.65)
                
                local is_hovered = (hover_idx == i)
                local col = is_hovered and Color(255, 170, 0) or Color(200, 200, 200)
                
                draw.SimpleText(options[i].name, "med_font_hud", tx, ty, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                
                if is_hovered then
                    draw.SimpleText(options[i].name, "med_font_radial", cx, cy, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
                end
            end
        end
        
        function menu:OnMousePressed(key)
            if key == MOUSE_LEFT and hover_idx then
                ply:EmitSound("piemenu_select.wav", 75, 100, 0.25)
                self:Remove()
                options[hover_idx].action()
            else
                ply:EmitSound("piemenu_cancel.wav", 75, 100, 0.25)
                self:Remove()
            end
        end
        
        function menu:OnKeyCodePressed(key)
            if key == KEY_ESCAPE then
                ply:EmitSound("piemenu_cancel.wav", 75, 100, 0.25)
                self:Remove()
            end
        end
    end
end

function SWEP:PrimaryAttack()
    if SERVER then return end
    local ply = self:GetOwner()
    if not IsValid(ply) or ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end
    
    local tr = util.TraceLine({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * self.HealRange,
        filter = ply
    })
    
    local tgt = get_tgt(tr.Entity)
    if not IsValid(tgt) or not tgt:IsPlayer() then return end

    self:OpenRadialMenu({
        { name = "Общее состояние", action = function()
            net.Start("med_diagnose")
            net.WriteEntity(tgt)
            net.SendToServer()
        end},
        { name = "Перелом руки", action = function()
            ply:ChatPrint("Переломов рук нет.")
        end},
        { name = "Воздействия", action = function()
            ply:ChatPrint("Воздействия не обнаружены.")
        end},
        { name = "Перелом ноги", action = function()
            ply:ChatPrint("Переломов ног нет.")
        end}
    })
end

function SWEP:SecondaryAttack()
    if SERVER then return end
    local ply = self:GetOwner()
    if not IsValid(ply) or ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end
    
    local tr = util.TraceLine({
        start = ply:GetShootPos(),
        endpos = ply:GetShootPos() + ply:GetAimVector() * self.HealRange,
        filter = ply
    })
    
    local ent = tr.Entity
    local tgt = get_tgt(ent)
    if not IsValid(tgt) or not tgt:IsPlayer() then return end

    self:OpenRadialMenu({
        { name = "Использовать Бинты", action = function()
            if tgt:GetNWFloat("BleedTime", 0) > 0 then
                net.Start("med_heal_action")
                net.WriteEntity(tgt)
                net.SendToServer()
            end
        end},
        { name = "Начать СЛР", action = function()
            local is_dead = not tgt:Alive() and IsValid(ent) and ent:GetClass() == "prop_ragdoll"
            if is_dead then
                if ent:GetNWBool("HeadExploded", false) then
                    ply:ChatPrint("У типа бошки нету.")
                elseif Downed and Downed[tgt] ~= nil then
                    ply:ChatPrint("СЛР ничем не поможет")
                else
                    net.Start("med_cpr_action")
                    net.WriteEntity(tgt)
                    net.WriteEntity(ent)
                    net.SendToServer()
                end
            end
        end},
        { name = "Ввести Физраствор", action = function()
            if tgt:GetNWFloat("BloodLoss", 0) > 0 then
                net.Start("med_saline")
                net.WriteEntity(tgt)
                net.SendToServer()
            else
                ply:ChatPrint("Кровьнормальнобрат.")
            end
        end}
    })
end

function SWEP:Reload() end

function SWEP:Think()
    self:Regen(true)
    self:Idle()

    local owner = self:GetOwner()
    if IsValid(owner) then
        if owner:GetNWFloat("MedLockTime", 0) > CurTime() then
            if self:GetHoldType() ~= "normal" then self:SetHoldType("normal") end
        else
            if self:GetHoldType() ~= "slam" then self:SetHoldType("slam") end
        end
    end
end

function SWEP:Regen(keepaligned)
    local curtime = CurTime()
    local lastregen = self:GetLastAmmoRegen()
    local timepassed = curtime - lastregen
    local regenrate = self.AmmoRegenRate
    if timepassed < regenrate then return false end
    local ammo = self:Clip1()
    local maxammo = self.Primary.ClipSize
    if ammo >= maxammo then return false end
    if regenrate > 0 then
        self:SetClip1(math.min(ammo + math.floor(timepassed / regenrate) * self.AmmoRegenAmount, maxammo))
        self:SetLastAmmoRegen(keepaligned == true and curtime + timepassed % regenrate or curtime)
    else
        self:SetClip1(maxammo)
        self:SetLastAmmoRegen(curtime)
    end
    return true
end

function SWEP:Idle()
    local curtime = CurTime()
    if curtime < self:GetNextIdle() then return false end
    self:SendWeaponAnim(ACT_VM_IDLE)
    self:SetNextIdle(curtime + self:SequenceDuration())
    return true
end

hook.Add("StartCommand", "med_movement_lock", function(ply, cmd)
    if ply:GetNWFloat("MedLockTime", 0) > CurTime() then
        cmd:ClearMovement()
        cmd:SetForwardMove(0)
        cmd:SetSideMove(0)
        cmd:SetUpMove(0)
        
        local lockAng = ply:GetNWAngle("MedLockAngles", Angle(0, 0, 0))
        if lockAng and lockAng ~= Angle(0, 0, 0) then
            cmd:SetViewAngles(lockAng)
        end

        local buttons = cmd:GetButtons()
        buttons = bit.bor(buttons, IN_DUCK)
        buttons = bit.band(buttons, bit.bnot(IN_JUMP))
        buttons = bit.band(buttons, bit.bnot(IN_SPEED))
        cmd:SetButtons(buttons)
    end
end)

hook.Add("SetupMove", "med_movement_freeze", function(ply, mv, cmd)
    if ply:GetNWFloat("MedLockTime", 0) > CurTime() then
        mv:SetMaxClientSpeed(0)
        mv:SetMaxSpeed(0)
        mv:SetVelocity(Vector(0, 0, 0))
        
        local buttons = mv:GetButtons()
        buttons = bit.bor(buttons, IN_DUCK)
        buttons = bit.band(buttons, bit.bnot(IN_JUMP))
        buttons = bit.band(buttons, bit.bnot(IN_SPEED))
        mv:SetButtons(buttons)
    end
end)

if SERVER then
    hook.Add("Think", "med_bloodloss_update", function()
        for _, ply in ipairs(player.GetAll()) do
            if IsValid(ply) and ply:Alive() then
                local bleedTime = ply:GetNWFloat("BleedTime", 0)
                local bloodLoss = ply:GetNWFloat("BloodLoss", 0)
                if bleedTime > 0 then
                    bloodLoss = math.min(100, bloodLoss + 0.5 * FrameTime())
                    ply:SetNWFloat("BloodLoss", bloodLoss)
                end
            end
        end
    end)

    net.Receive("med_heal_action", function(len, ply)
        local wep = ply:GetActiveWeapon()
		if not ply:Alive() or NoireSandbox.IsUnconscious(ply) or ply:GetNWBool("HandCuffed", false) or ply:GetNWFloat("MedLockTime", 0) > CurTime() or not IsValid(wep) or not wep.NoireMedical then return end
        if not IsValid(wep) or wep:Clip1() < 5 then return end
        local tgt = net.ReadEntity()
        if not IsValid(tgt) or not tgt:IsPlayer() then return end
        
        if tgt:GetNWFloat("BleedTime", 0) <= 0 then return end
        
        local ent = tgt:GetNWEntity("Ragdoll")
        local pos = IsValid(ent) and ent:GetPos() or tgt:GetPos()
        if ply:GetShootPos():Distance(pos) > 130 then return end
        
        wep:SetClip1(wep:Clip1() - 5)
        if Bleeds then Bleeds[tgt] = nil end
        
        tgt:SetNWFloat("BleedTime", 0)
        tgt:EmitSound("bandage/heal.mp3", 75, 100, 1, CHAN_AUTO)
        
        ply:SetNWFloat("MedLockTime", CurTime() + 4)
        ply:SetNWAngle("MedLockAngles", ply:EyeAngles())
        ply:ConCommand("say /me Накладывает бинты на человека")
    end)

    net.Receive("med_cpr_action", function(len, ply)
        local wep = ply:GetActiveWeapon()
		if not ply:Alive() or NoireSandbox.IsUnconscious(ply) or ply:GetNWBool("HandCuffed", false) or not IsValid(wep) or not wep.NoireMedical then return end
        if not IsValid(wep) or wep:Clip1() < 5 then return end
        local tgt = net.ReadEntity()
        local rag = net.ReadEntity()
        
        if not IsValid(tgt) or not tgt:IsPlayer() or tgt:Alive() then return end
        if not IsValid(rag) or rag:GetClass() ~= "prop_ragdoll" then return end
		if tgt:GetNWEntity("Ragdoll") ~= rag then return end
        if rag:GetNWBool("HeadExploded", false) then return end
        if ply:GetShootPos():Distance(rag:GetPos()) > 130 then return end
        if ply:GetNWFloat("MedLockTime", 0) > CurTime() then return end
        
        if Downed and Downed[tgt] then
            ply:ChatPrint("СЛР ничем не поможет")
            return
        end

        rag.CPRCount = rag.CPRCount or 0

        if rag.CPRCount >= 9 then
            ply:ChatPrint("Тело уже холодное, тут ничем не помочь.")
            return
        end

        if rag.CPRCount == 0 and (CurTime() - rag:GetCreationTime() > 180) then
            ply:ChatPrint("Пострадавший мертв.")
            return
        end

        wep:SetClip1(math.max(0, wep:Clip1() - 5))
        
        ply:SetNWFloat("MedLockTime", CurTime() + 11)
        ply:SetNWAngle("MedLockAngles", ply:EyeAngles())
        ply:EmitSound("bandage/breathLong.wav", 75, 100, 1, CHAN_AUTO)
        ply:ConCommand("say /me Приступает к СЛР")

        rag.CPRCount = rag.CPRCount + 1

        timer.Simple(11, function()
            if not IsValid(ply) or not IsValid(tgt) or not IsValid(rag) then return end
            if tgt:Alive() or rag:GetNWBool("HeadExploded", false) then return end
            if Downed and Downed[tgt] then return end

            if math.random(1, 100) <= 30 then
                local savedInv = DeathInventory[tgt] and table.Copy(DeathInventory[tgt]) or {}

                rag:SetNWBool("Dead", false)
                rag:SetNWEntity("Owner", tgt)
                tgt:Spawn()

                timer.Simple(0.2, function()
                    if not IsValid(tgt) or not IsValid(rag) then return end
                    tgt:SetPos(rag:GetPos())
                    tgt:SetNWEntity("Ragdoll", rag)

                    local wake = math.random(1, 2) == 1 and 60 or 180
                    local hp = math.random(7, 20)

                    local inv = savedInv
                    local weps = inv.weps or {}
                    local ammo = inv.ammo or {}
                    local hands = inv.hands or false
                    local plyColor = inv.plyColor

                    if Downed then
                        Downed[tgt] = {
                            ragdoll = rag,
                            hp = hp,
                            wakeTime = CurTime() + wake,
                            weps = weps,
                            ammo = ammo,
                            hands = hands,
                            plyColor = plyColor,
                            pos = rag:GetPos(),
                            ang = rag:GetAngles()
                        }
                    end

                    if plyColor then tgt:SetPlayerColor(plyColor) end

                    tgt:Spectate(OBS_MODE_CHASE)
                    tgt:SpectateEntity(rag)
                    tgt:StripWeapons()
                    tgt:StripAmmo()
                    tgt:SetHealth(hp)
                    tgt:SetDSP(14, false)
                end)
            end
        end)
    end)

    net.Receive("med_diagnose", function(len, ply)
		local wep = ply:GetActiveWeapon()
		if not ply:Alive() or NoireSandbox.IsUnconscious(ply) or ply:GetNWBool("HandCuffed", false) or not IsValid(wep) or not wep.NoireMedical then return end
        local tgt = net.ReadEntity()
        if not IsValid(tgt) or not tgt:IsPlayer() then return end
		local rag = tgt:GetNWEntity("Ragdoll")
		if ply:GetShootPos():Distance(IsValid(rag) and rag:GetPos() or tgt:GetPos()) > 130 then return end
        
        local msg = ""
        local hp = tgt:Health()
        local maxhp = tgt:GetMaxHealth()
        local pct = math.floor((hp / maxhp) * 100)
        msg = "Общее здоровье: " .. pct .. "%."
        
        local bleedTime = tgt:GetNWFloat("BleedTime", 0)
        if bleedTime > 0 then
            msg = msg .. " Внешнее кровотечение."
        end
        
        local bloodLoss = tgt:GetNWFloat("BloodLoss", 0)
        if bloodLoss > 0 then
            if bloodLoss >= 30 then
                msg = msg .. " Возможна сильная потеря крови."
            elseif bloodLoss >= 15 then
                msg = msg .. " Возможно малокровие."
            end
        end
        
        if not tgt:Alive() then
            msg = msg .. " Нет дыхания. Пульс отсутствует или слабый."
        else
            if tgt:GetNWBool("Unconscious", false) or IsValid(tgt:GetNWEntity("Ragdoll")) then
                msg = msg .. " Без сознания."
            end
        end
        
        ply:ChatPrint(msg)
    end)

    net.Receive("med_saline", function(len, ply)
        local wep = ply:GetActiveWeapon()
		if not ply:Alive() or NoireSandbox.IsUnconscious(ply) or ply:GetNWBool("HandCuffed", false) or ply:GetNWFloat("MedLockTime", 0) > CurTime() or not IsValid(wep) or not wep.NoireMedical then return end
        if not IsValid(wep) or wep:Clip1() < 10 then 
            ply:ChatPrint("Не хватает медикаментов")
            return 
        end
        local tgt = net.ReadEntity()
        if not IsValid(tgt) or not tgt:IsPlayer() then return end
        
        local bloodLoss = tgt:GetNWFloat("BloodLoss", 0)
        if bloodLoss <= 0 then
            ply:ChatPrint("Кровьнормальнобрат.")
            return
        end
        
        local ent = tgt:GetNWEntity("Ragdoll")
        local pos = IsValid(ent) and ent:GetPos() or tgt:GetPos()
        if ply:GetShootPos():Distance(pos) > 130 then return end
        
        wep:SetClip1(wep:Clip1() - 10)
        local newLoss = math.max(0, bloodLoss - 30)
        tgt:SetNWFloat("BloodLoss", newLoss)
        
        ply:SetNWFloat("MedLockTime", CurTime() + 3.6)
        ply:SetNWAngle("MedLockAngles", ply:EyeAngles())
        ply:EmitSound("bandage/noiresounds/player/use/syringe.wav", 75, 100, 1, CHAN_AUTO)
        ply:ConCommand("say /me Ввел препарат человеку")
        
        if tgt:Alive() then
            local newhp = math.min(tgt:Health() + 1, tgt:GetMaxHealth())
            tgt:SetHealth(newhp)
        end
    end)
end

if SERVER then return end

function SWEP:CustomAmmoDisplay()
    local display = self.AmmoDisplay
    display.PrimaryClip = self:Clip1()
    return display
end

hook.Add("CalcView", "MedkitImmersiveView", function(ply, pos, ang, fov)
    if ply:Alive() and ply:GetNWFloat("MedLockTime", 0) > CurTime() then
        local eyes = ply:LookupAttachment("eyes")
        if eyes and eyes > 0 then
            local attach = ply:GetAttachment(eyes)
            if attach and attach.Pos then
                local bAng = attach.Ang
                bAng:RotateAroundAxis(bAng:Right(), -10)
                return {
                    origin = attach.Pos + bAng:Forward() * 2,
                    angles = bAng,
                    fov = fov,
                    drawviewer = true
                }
            end
        end
    end
end)

hook.Add("CalcMainActivity", "MedkitAnimOverride", function(ply)
    if ply:GetNWFloat("MedLockTime", 0) > CurTime() then
        local seq = ply:LookupSequence("roofidle1")
        if seq and seq >= 0 then 
            return ACT_HL2MP_IDLE, seq 
        end
    end
end)

hook.Add("UpdateAnimation", "MedkitAnimUpdateOverride", function(ply)
    if ply:GetNWFloat("MedLockTime", 0) > CurTime() then
        local seq = ply:LookupSequence("roofidle1")
        if seq and seq >= 0 then
            ply:SetSequence(seq)
            return true
        end
    end
end)


local clrs = {
	m = Color(255, 255, 255, 200),
	s = Color(127, 127, 127, 150),
	d = Color(0, 0, 0, 20),
	r = Color(255, 0, 0),
}

function SWEP:DrawHUD()
    local ply = self:GetOwner()
    if not IsValid(ply) then return end
    
    if NoireSandbox.IsUnconscious(ply) then return end
    
	local x, y = ScrW() / 2, ScrH() * 0.8
	
	local sp1 = draw.SimpleTextOutlined("Осмотреть человека", "med_font_hud", x, y + 3, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
	if MSD and MSD.DrawKey then 
        MSD.DrawKey(x - sp1 / 2 - 55, y, "ЛКМ", 155) 
    else
        draw.SimpleTextOutlined("[ЛКМ]", "med_font_hud", x - sp1 / 2 - 35, y + 3, clrs.s, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 2, clrs.d)
    end
    
	local sp2 = draw.SimpleTextOutlined("Применить аптечку", "med_font_hud", x, y + 33, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
	if MSD and MSD.DrawKey then 
        MSD.DrawKey(x - sp2 / 2 - 55, y + 30, "ПКМ", 155) 
    else
        draw.SimpleTextOutlined("[ПКМ]", "med_font_hud", x - sp2 / 2 - 35, y + 33, clrs.s, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, 2, clrs.d)
    end
end
SWEP.vRenderOrder = nil

function SWEP:ViewModelDrawn()
    local ply = self:GetOwner()
    if not IsValid(ply) then return end
	if NoireSandbox.IsUnconscious(ply) or ply:GetNWBool("HandCuffed", false) then return end
	
    local vm = ply:GetViewModel()
	if not IsValid(vm) then return end
	if (not self.VElements) then return end
	self:UpdateBonePositions(vm)

	if (not self.vRenderOrder) then
		self.vRenderOrder = {}

		for k, v in pairs(self.VElements) do
			if (v.type == "Model") then
				table.insert(self.vRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.vRenderOrder, k)
			end
		end
	end

	for k, name in ipairs(self.vRenderOrder) do
		local v = self.VElements[name]

		if (not v) then
			self.vRenderOrder = nil
			break
		end

		if (v.hide) then continue end
		local model = v.modelEnt
		local sprite = v.spriteMaterial
		if (not v.bone) then continue end
		local pos, ang = self:GetBoneOrientation(self.VElements, v, vm)
		if (not pos) then continue end

		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix("RenderMultiply", matrix)

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial(v.material)
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for i, o in pairs(v.bodygroup) do
					if (model:GetBodygroup(i) ~= o) then
						model:SetBodygroup(i, o)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
			render.SetBlend(v.color.a / 255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		elseif (v.type == "Sprite" and sprite) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
		elseif (v.type == "Quad" and v.draw_func) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			cam.Start3D2D(drawpos, ang, v.size)
			v.draw_func(self)
			cam.End3D2D()
		end
	end
end

SWEP.wRenderOrder = nil

function SWEP:DrawWorldModel()
    local ply = self:GetOwner()
    if IsValid(ply) and (NoireSandbox.IsUnconscious(ply) or ply:GetNWBool("HandCuffed", false)) then return end
	if (not self.WElements) then return end

	if (not self.wRenderOrder) then
		self.wRenderOrder = {}

		for k, v in pairs(self.WElements) do
			if (v.type == "Model") then
				table.insert(self.wRenderOrder, 1, k)
			elseif (v.type == "Sprite" or v.type == "Quad") then
				table.insert(self.wRenderOrder, k)
			end
		end
	end

	local bone_ent
	if (IsValid(self:GetOwner())) then
		bone_ent = self:GetOwner()
	else
		bone_ent = self
	end

	for k, name in pairs(self.wRenderOrder) do
		local v = self.WElements[name]

		if (not v) then
			self.wRenderOrder = nil
			break
		end

		if (v.hide) then continue end
		local pos, ang

		if (v.bone) then
			pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent)
		else
			pos, ang = self:GetBoneOrientation(self.WElements, v, bone_ent, "ValveBiped.Bip01_R_Hand")
		end

		if (not pos) then continue end
		local model = v.modelEnt
		local sprite = v.spriteMaterial

		if (v.type == "Model" and IsValid(model)) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z)
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix("RenderMultiply", matrix)

			if (v.material == "") then
				model:SetMaterial("")
			elseif (model:GetMaterial() ~= v.material) then
				model:SetMaterial(v.material)
			end

			if (v.skin and v.skin ~= model:GetSkin()) then
				model:SetSkin(v.skin)
			end

			if (v.bodygroup) then
				for i, o in pairs(v.bodygroup) do
					if (model:GetBodygroup(i) ~= o) then
						model:SetBodygroup(i, o)
					end
				end
			end

			if (v.surpresslightning) then
				render.SuppressEngineLighting(true)
			end

			render.SetColorModulation(v.color.r / 255, v.color.g / 255, v.color.b / 255)
			render.SetBlend(v.color.a / 255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)

			if (v.surpresslightning) then
				render.SuppressEngineLighting(false)
			end
		elseif (v.type == "Sprite" and sprite) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			render.SetMaterial(sprite)
			render.DrawSprite(drawpos, v.size.x, v.size.y, v.color)
		elseif (v.type == "Quad" and v.draw_func) then
			local drawpos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			cam.Start3D2D(drawpos, ang, v.size)
			v.draw_func(self)
			cam.End3D2D()
		end
	end
end

function SWEP:GetBoneOrientation(basetab, tab, ent, bone_override)
	local bone, pos, ang

	if (tab.rel and tab.rel ~= "") then
		local v = basetab[tab.rel]
		if (not v) then return end
		pos, ang = self:GetBoneOrientation(basetab, v, ent)
		if (not pos) then return end
		pos = pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z
		ang:RotateAroundAxis(ang:Up(), v.angle.y)
		ang:RotateAroundAxis(ang:Right(), v.angle.p)
		ang:RotateAroundAxis(ang:Forward(), v.angle.r)
	else
		bone = ent:LookupBone(bone_override or tab.bone)
		if (not bone) then return end
		pos, ang = Vector(0, 0, 0), Angle(0, 0, 0)
		local m = ent:GetBoneMatrix(bone)

		if (m) then
			pos, ang = m:GetTranslation(), m:GetAngles()
		end

		if (IsValid(self:GetOwner()) and self:GetOwner():IsPlayer() and ent == self:GetOwner():GetViewModel() and self.ViewModelFlip) then
			ang.r = -ang.r
		end
	end

	return pos, ang
end

function SWEP:CreateModels(tab)
	if (not tab) then return end

	for k, v in pairs(tab) do
		if (v.type == "Model" and v.model and v.model ~= "" and (not IsValid(v.modelEnt) or v.createdModel ~= v.model) and string.find(v.model, ".mdl") and file.Exists(v.model, "GAME")) then
			v.modelEnt = ClientsideModel(v.model, RENDERGROUP_OTHER)

			if (IsValid(v.modelEnt)) then
				v.modelEnt:SetPos(self:GetPos())
				v.modelEnt:SetAngles(self:GetAngles())
				v.modelEnt:SetParent(self)
				v.modelEnt:SetNoDraw(true)
				v.createdModel = v.model
			else
				v.modelEnt = nil
			end
		elseif (v.type == "Sprite" and v.sprite and v.sprite ~= "" and (not v.spriteMaterial or v.createdSprite ~= v.sprite) and file.Exists("materials/" .. v.sprite .. ".vmt", "GAME")) then
			local name = v.sprite .. "-"

			local params = {
				["$basetexture"] = v.sprite
			}

			local tocheck = {"nocull", "additive", "vertexalpha", "vertexcolor", "ignorez"}

			for i, j in pairs(tocheck) do
				if (v[j]) then
					params["$" .. j] = 1
					name = name .. "1"
				else
					name = name .. "0"
				end
			end

			v.createdSprite = v.sprite
			v.spriteMaterial = CreateMaterial(name, "UnlitGeneric", params)
		end
	end
end

local allbones
local hasGarryFixedBoneScalingYet = false

function SWEP:UpdateBonePositions(vm)
	if self.ViewModelBoneMods then
		if (not vm:GetBoneCount()) then return end
		local loopthrough = self.ViewModelBoneMods

		if (not hasGarryFixedBoneScalingYet) then
			allbones = {}

			for i = 0, vm:GetBoneCount() do
				local bonename = vm:GetBoneName(i)

				if (self.ViewModelBoneMods[bonename]) then
					allbones[bonename] = self.ViewModelBoneMods[bonename]
				else
					allbones[bonename] = {
						scale = Vector(1, 1, 1),
						pos = Vector(0, 0, 0),
						angle = Angle(0, 0, 0)
					}
				end
			end

			loopthrough = allbones
		end

		for k, v in pairs(loopthrough) do
			local bone = vm:LookupBone(k)
			if (not bone) then continue end
			local s = Vector(v.scale.x, v.scale.y, v.scale.z)
			local p = Vector(v.pos.x, v.pos.y, v.pos.z)
			local ms = Vector(1, 1, 1)

			if (not hasGarryFixedBoneScalingYet) then
				local cur = vm:GetBoneParent(bone)

				while (cur >= 0) do
					local pscale = loopthrough[vm:GetBoneName(cur)].scale
					ms = ms * pscale
					cur = vm:GetBoneParent(cur)
				end
			end

			s = s * ms

			if vm:GetManipulateBoneScale(bone) ~= s then
				vm:ManipulateBoneScale(bone, s)
			end

			if vm:GetManipulateBoneAngles(bone) ~= v.angle then
				vm:ManipulateBoneAngles(bone, v.angle)
			end

			if vm:GetManipulateBonePosition(bone) ~= p then
				vm:ManipulateBonePosition(bone, p)
			end
		end
	else
		self:ResetBonePositions(vm)
	end
end

function SWEP:ResetBonePositions(vm)
	if (not vm:GetBoneCount()) then return end

	for i = 0, vm:GetBoneCount() do
		vm:ManipulateBoneScale(i, Vector(1, 1, 1))
		vm:ManipulateBoneAngles(i, Angle(0, 0, 0))
		vm:ManipulateBonePosition(i, Vector(0, 0, 0))
	end
end

function SWEP:Holster()
	if CLIENT and IsValid(self:GetOwner()) then
		local vm = self:GetOwner():GetViewModel()

		if IsValid(vm) then
			self:ResetBonePositions(vm)
		end
	end

	return true
end

function SWEP:OnRemove()
	self:Holster()
end
