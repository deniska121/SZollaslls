-- "addons\\weapons\\lua\\weapons\\mg_base\\modules\\client\\cl_hud.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
AddCSLuaFile()
if (SERVER) then return end

hook.Add( "PlayerBindPress", "MWwpFlashlight", function( ply, bind, pressed )
	if bind ~= "impulse 100" then return end

	local w = ply:GetActiveWeapon()

	if IsValid(w) and w.IsMWwp then
		if w:GetFlashlightAttachment() then
			LocalPlayer():ConCommand( "flashlight" )
		elseif w:GetLaser() then
			LocalPlayer():ConCommand( "lasertoggle" )
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
	if (self:GetOwner():InVehicle()) then return end

	if self:GetBreathingDelta() and self:GetBreathingDelta() < 1 then
		surface.SetMaterial(Material("msd/vignette.png", "smooth"))
		surface.SetDrawColor(0, 0, 0, (1 - self:GetBreathingDelta()) * 255)
		surface.DrawTexturedRect(0, 0, ScrW(), ScrH())
	end

	if not self:GetHasPumped() and self:Clip1() > 0 then
		local x, y =  ScrW() * 0.5, ScrH() * 0.8
		local sp = draw.SimpleTextOutlined("Дозарядить патрон", "MSDFont.20", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		MSD.DrawKey(x + sp / 2 + 10, y - 3, "ЛКМ")
	elseif self:GetMalfunction() and self.missfire and self.missfire > CurTime() then
		local x, y =  ScrW() * 0.5, ScrH() * 0.8
		local sp = draw.SimpleTextOutlined("Устранить осечку", "MSDFont.20", x, y, clrs.m, TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP, 2, clrs.d)
		MSD.DrawKey(x + sp / 2 + 10, y - 3, input.LookupBinding("+reload"))
	end
end

function SWEP:DrawBinding(x, y, bind)
	local key = string.upper(input.LookupBinding(bind) or "KEY NOT BOUND: " .. bind)
	local scale = ScrH() / 1080
	local size = 26 * scale
	surface.SetFont("mgbase_command")
	local w = math.max(surface.GetTextSize(key) + 10 * scale, size)
	draw.RoundedBox(4, x - (w * 0.5 - 1), y - (size * 0.5 * scale - 1), w, size * scale, Color(0, 0, 0, 150))
	draw.SimpleText(key, "mgbase_command", x, y, Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)

	return w * 0.5 + (5 * scale)
end

function SWEP:DrawCommands()
	if self:GetIsCustomizing() then return end

	local scale = ScrH() / 1080
	local x, y = ScrW() * 0.7, ScrH() * 0.5

	surface.SetAlphaMultiplier(self:GetAimDelta())

	if (self:CanChangeAimMode()) then
		local w = self:DrawBinding(x, y, "+use")
		draw.SimpleTextOutlined("x 2: Прицел", "mgbase_commandSecondary", x + w, y, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
	end

	x, y = ScrW() * 0.5, ScrH() * 0.7

	if (self:GetSight() ~= nil and self:GetSight().Optic ~= nil and self:GetAimModeDelta() <= self.m_hybridSwitchThreshold and not self:GetOwner():KeyDown(IN_SPEED) and GetConVar("mgbase_sv_breathing"):GetInt() > 0) then
		self:DrawBinding(x, y, "+speed")
		draw.SimpleTextOutlined("Дыхание", "mgbase_commandSecondary", x, y + (30 * scale), Color(255, 255, 255, 200), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
	end

	surface.SetAlphaMultiplier(1)

	if self:GetFlashlightAttachment() ~= nil then
		surface.SetFont("mgbase_commandSecondary")
		local tw = surface.GetTextSize(": FLASHLIGHT") * 0.5
		x, y = ScrW() * 0.5 - tw - 7, ScrH() * 0.9 - 150
		--if (self:CanChangeAimMode()) then
		local w = self:DrawBinding(x, y, "impulse 100")
		draw.SimpleTextOutlined(": Фонарь", "mgbase_commandSecondary", x + w, y, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
	elseif self:GetLaser() ~= nil then
		surface.SetFont("mgbase_commandSecondary")
		local tw = surface.GetTextSize(": FLASHLIGHT") * 0.5
		x, y = ScrW() * 0.5 - tw - 7, ScrH() * 0.9 - 150
		--if (self:CanChangeAimMode()) then
		local w = self:DrawBinding(x, y, "impulse 100")
		draw.SimpleTextOutlined(": Лазер", "mgbase_commandSecondary", x + w, y, Color(255, 255, 255, 200), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 20))
	end
end

function SWEP:CanDrawCrosshair()
	return not self:GetIsReloading() and not self:GetIsSprinting() and not self:GetIsHolstering() and not self:IsDrawing() and CurTime() > self:GetNextMeleeTime()
end

function SWEP:HUDShouldDraw(name)
	return true
end

--FONTS
local function CreateFonts()
	local scale = ScrH() / 1080

	surface.CreateFont("mgbase_firemode", {
		font = "BioSansW05-Light",
		size = 30 * scale,
		weight = 0
	})

	surface.CreateFont("mgbase_statName", {
		font = "BioSansW05-Light",
		size = 24,
		weight = 0
	})

	surface.CreateFont("mgbase_stat", {
		font = "BioSansW05-Light",
		size = 22,
		weight = 0
	})

	surface.CreateFont("mgbase_control", {
		font = "BioSansW05-Light",
		size = 22,
		weight = 0
	})

	surface.CreateFont("mgbase_statPositive", {
		font = "BioSansW05-Light",
		size = 22,
		weight = 0,
		blursize = 2
	})

	surface.CreateFont("mgbase_firemode_alt", {
		font = "BioSansW05-Light",
		size = 24 * scale,
		weight = 0
	})

	surface.CreateFont("mgbase_attSlot", {
		font = "Conduit ITC",
		size = 24 * scale,
		weight = 500
	})

	surface.CreateFont("mgbase_attSlotMenu", {
		font = "Conduit ITC",
		size = 24,
		weight = 500
	})

	surface.CreateFont("mgbase_attSlotAttachmentInUse", {
		font = "BioSansW05-Light",
		size = 24,
		weight = 0
	})

	surface.CreateFont("mgbase_attSlotAttachmentInUse_IsCosmetic", {
		font = "Conduit ITC",
		size = 20,
		weight = 500
	})

	surface.CreateFont("mgbase_attSlotAttachmentInUse:hover", {
		font = "BioSansW05-Light",
		size = 24,
		weight = 0,
		blursize = 1
	})

	surface.CreateFont("mgbase_attSlotMenu:hover", {
		font = "Conduit ITC",
		size = 24,
		weight = 500,
		blursize = 2
	})

	surface.CreateFont("mgbase_utilityButton", {
		font = "BioSansW05-Light",
		size = 32,
		weight = 0
	})

	surface.CreateFont("mgbase_utilityButton:hover", {
		font = "BioSansW05-Light",
		size = 32,
		weight = 0,
		blursize = 1
	})

	surface.CreateFont("mgbase_attSlotMenu", {
		font = "Conduit ITC",
		size = 24,
		weight = 500
	})

	surface.CreateFont("mgbase_attName", {
		font = "Conduit ITC",
		size = 24 * scale,
		weight = 500
	})

	surface.CreateFont("mgbase_attTitle", {
		font = "BioSansW05-Light",
		size = 60 * scale,
		weight = 0
	})

	surface.CreateFont("mgbase_attTitle_blur", {
		font = "BioSansW05-Light",
		size = 60 * scale,
		weight = 0,
		blursize = 3
	})

	surface.CreateFont("mgbase_attWeaponName", {
		font = "Conduit ITC",
		size = 36 * scale,
		weight = 500
	})

	surface.CreateFont("mgbase_command", {
		font = "BioSansW05-Light",
		size = 26 * scale,
		weight = 500
	})

	surface.CreateFont("mgbase_commandSecondary", {
		font = "BioSansW05-Light",
		size = 22 * scale,
		weight = 500
	})

	surface.CreateFont("mgbase_presetSpawnMethod", {
		font = "BioSansW05-Light",
		size = 24,
		weight = 0
	})

	surface.CreateFont("mgbase_presetSpawnMethod_child", {
		font = "BioSansW05-Light",
		size = 20,
		weight = 0
	})
end

hook.Add("OnScreenSizeChanged", "MW_UpdateFonts", CreateFonts)
CreateFonts()
