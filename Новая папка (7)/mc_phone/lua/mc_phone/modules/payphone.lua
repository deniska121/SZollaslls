-- "addons\\mc_phone\\lua\\mc_phone\\modules\\payphone.lua"
-- Retrieved by https://github.com/lewisclark/glua-steal
McPhone.PayPhone = McPhone.PayPhone or {}
if SERVER then return end
local NewFont = surface.CreateFont
local ply = LocalPlayer()

NewFont("McPhone.LCD", {
	font = "DS Crystal",
	extended = true,
	size = 38,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Hand", {
	font = "Merriweather",
	extended = true,
	size = 24,
	antialias = true,
	weight = 500
})

NewFont("McPhone.Payphone", {
	font = "Roboto",
	extended = true,
	size = 45,
	antialias = true,
	weight = 800
})

NewFont("McPhone.PhoneBook", {
	font = "Merriweather",
	extended = true,
	size = 26,
	antialias = true,
	weight = 600
})

local function PayPhone_ListIcons(parent, text, func, text2)
	local buton = vgui.Create("DButton")
	buton.check = check
	buton:SetSize(256, 30)
	buton:SetText("")
	buton.text_pos = 0
	buton.text_dir = CurTime() + 2

	buton.DoClick = function(self)
		McPhone.PlaySoundUI("mcphone/button_payphone.wav")
		if func then
			func(self)
		end
	end

	buton.Paint = function(self, w, h)
		if self.hover then
			surface.SetDrawColor(McPhone.MainColors.shadow_200)
		else
			surface.SetDrawColor(McPhone.MainColors.shadow_100)
		end
		surface.DrawLine(0, h - 3, w, h - 3)
		draw.SimpleText(text, "McPhone.Hand", 5, 5, color_black, TEXT_ALIGN_LEFT)
		draw.SimpleText(text2 or "", "MSDFont.20", w - 5, 5, color_black, TEXT_ALIGN_RIGHT)
	end

	buton.OnCursorEntered = function(self, mute)
		self.hover = true
	end

	buton.OnCursorExited = function(self)
		self.hover = false
	end

	parent:AddItem(buton)

	return buton
end

local number = ""
local mats = {
	Material("vgui/mcphone/payphone.png", "smooth"),
	Material("vgui/mcphone/overlay.png", "smooth"),
	Material("vgui/mcphone/page.png", "smooth"),
	Material("vgui/mcphone/graf1.png", "smooth"),
	Material("vgui/mcphone/graf2.png", "smooth"),
}

local button_list = {
	{
		text = "1",
		x = 55,
		y = 240
	},
	{
		text = "2",
		x = 134,
		y = 240
	},
	{
		text = "3",
		x = 214,
		y = 240
	},
	{
		text = "4",
		x = 55,
		y = 320
	},
	{
		text = "5",
		x = 134,
		y = 320
	},
	{
		text = "6",
		x = 214,
		y = 320
	},
	{
		text = "7",
		x = 55,
		y = 400
	},
	{
		text = "8",
		x = 134,
		y = 400
	},
	{
		text = "9",
		x = 214,
		y = 400
	},
	{
		text = "*",
		x = 55,
		y = 480
	},
	{
		text = "0",
		x = 134,
		y = 480
	},
	{
		text = "#",
		x = 214,
		y = 480
	},
	{
		text = "×",
		x = 495,
		y = 87,
		func = function()
			McPhone.PayPhone.UI:Remove()
		end
	},
	{
		text = "☏",
		x = 425,
		y = 87,
		func = function()
			if number == McPhone.GetPhrase("enter_number") then return end
			McPhone.LastNumber = number
			local lastcall = McPhone.GetByNumber(number)

			if IsValid(lastcall) and lastcall ~= ply then
				McPhone.LastNumber = lastcall
				--McPhone.AddContacts(number, lastcall:Name())
			end

			net.Start("McPhone.CallStart")
			net.WriteString(number)
			net.WriteBool(false)
			net.SendToServer()
		end
	},
	{
		text = "Ⓧ",
		x = 134,
		y = 560,
		func = function()
			number = McPhone.GetPhrase("enter_number")
		end
	},
}

local but = {}
local but_s = {}
local pay_ent_list =  {}

for i = 1, 16 do
	but[i] = Material("vgui/mcphone/buttons/b" .. i .. ".png", "smooth")
	but_s[i] = Material("vgui/mcphone/buttons/b" .. i .. "s.png", "smooth")
end

local colors = {
	Color(0,0,0,200),
	Color(0,0,0,220),
}

local keycodes = {
	["1"] = 1,
	["2"] = 2,
	["3"] = 3,
	["4"] = 4,
	["5"] = 5,
	["6"] = 6,
	["7"] = 7,
	["8"] = 8,
	["9"] = 9,
	["*"] = 10,
	["0"] = 11,
	["#"] = 12,
}

function McPhone.PayPhone.OpenMenu(pay_ent)
	if not McPhone.CanUsePhone(ply, true) or McPhone.UI or McPhone.PayPhone.UI then
		net.Start("McPhone.PayPhone")
		net.WriteEntity(pay_ent)
		net.SendToServer()
		return
	end

	if not pay_ent_list[pay_ent] then
		pay_ent_list[pay_ent] = mats[math.random(4, 5)]
	end

	local text_pos = 0
	local text_dir, no_message
	local disable_buts = false
	number = McPhone.GetPhrase("enter_number")

	McPhone.PayPhone.UI = vgui.Create("DPanel")
	McPhone.PayPhone.UI:SetSize(ScrW(), ScrH())
	gui.EnableScreenClicker(true)
	McPhone.PayPhone.UI.Paint = function(self, w, h)
		Derma_DrawBackgroundBlur(self, self.startTime)
	end

	local phone = vgui.Create("DPanel", McPhone.PayPhone.UI)
	phone:SetSize(600, 800)
	phone:Center()
	phone.Paint = function(self, w, h)
		MSD.DrawTexturedRect(0, 0, w, h, mats[1], color_white)
		MSD.DrawTexturedRect(0, 0, w, h, pay_ent_list[pay_ent], color_white)
	end

	local panel = vgui.Create("DPanel", phone)
	panel:SetPos(50, 87)
	panel:SetSize(370, 73)
	panel.Paint = function(self, w, h)
		local text = number
		surface.SetFont("McPhone.LCD")
		local tw = surface.GetTextSize(text)

		if tw > w then
			if text_dir and isnumber(text_dir) and text_dir < CurTime() then
				text_dir = nil
			end

			if text_pos > w - tw - 50 and not text_dir then
				text_pos = math.Approach(text_pos, w - tw - 50, FrameTime() * 70)
			else
				if text_pos >= 10 and not isnumber(text_dir) then
					text_dir = CurTime() + 2
				else
					text_pos = math.Approach(text_pos, 10, FrameTime() * 70)
				end

				if not text_dir then
					text_dir = true
				end
			end

			draw.SimpleText(text, "McPhone.LCD", text_pos, 17, colors[1], TEXT_ALIGN_LEFT, 2)
		else
			draw.SimpleText(text, "McPhone.LCD", w / 2, 17, colors[1], TEXT_ALIGN_CENTER, 2)
		end
	end

	local overlay = vgui.Create("DPanel", McPhone.PayPhone.UI)
	overlay:SetSize(600, 800)
	overlay:Center()
	overlay.Paint = function(self, w, h)
		MSD.DrawTexturedRect(0, 0, w, h, mats[2], color_white)
	end
	McPhone.PayPhone.UI.DilePos = 0
	McPhone.PayPhone.UI.DileTime = 0
	McPhone.PayPhone.UI.Think = function(self)
		if McPhone.UI or McPhone.PreCache then
			no_message = true
			McPhone.PayPhone.UI:Remove()
		end

		if not McPhone.CanUsePhone(ply, true) or not pay_ent or not IsValid(pay_ent) then
			McPhone.PayPhone.UI:Remove()
		end

		if pay_ent and IsValid(pay_ent) and pay_ent:GetPos():DistToSqr(ply:GetPos()) > 5005 then
			McPhone.PayPhone.UI:Remove()
		end

		if dilenumber and self.DileTime < CurTime() then
			self.DileTime = CurTime() + 0.3
			self.DilePos = self.DilePos + 1

			if self.DilePos > string.len(dilenumber) then
				dilenumber = nil
				self.DilePos = 0
				return
			end
			McPhone.PayPhone.UI.Buts[keycodes[string.sub(dilenumber, self.DilePos, self.DilePos)]]:DoClick()
		end
	end

	function McPhone.PayPhone.UI:OnRemove()
		McPhone.PayPhone.UI = nil
		McPhone.PayPhone.Menu = nil
		gui.EnableScreenClicker(false)
		if not McPhone.UI and not McPhone.PreCache then
			McPhone.StopCall()
		end

		net.Start("McPhone.PayPhone")
		net.WriteEntity(pay_ent)
		net.SendToServer()

		if not no_message and McPhone.Sound then
			McPhone.Sound:Stop()
			McPhone.Sound = nil
		end

		if not no_message or (no_message and not McPhone.UI) then
			net.Start("McPhone.PhoneStatus")
			net.WriteUInt(0, 3)
			net.SendToServer()
		else
			net.Start("McPhone.PhoneStatus")
			net.WriteUInt(1, 3)
			net.WriteBool(true)
			net.SendToServer()
		end
	end

	McPhone.PayPhone.UI.Update = function(status)
		if status == "Busy" or status == "No Signal" then
			timer.Simple(3, function()
				if IsValid(McPhone.PayPhone.UI) then
					number = McPhone.GetPhrase("enter_number")
					disable_buts = false
				end
			end)
		end

		number = string.upper(McPhone.GetPhrase(status))
		disable_buts = true

		if status == "Not available" then
			timer.Simple(3, function()
				if IsValid(McPhone.PayPhone.UI) then
					number = McPhone.GetPhrase("enter_number")
					disable_buts = false
				end
			end)
		end
	end

	McPhone.PayPhone.UI.OpenedMenu = ""
	local phonebook = vgui.Create("MSDSimpleFrame", McPhone.PayPhone.UI)
	phonebook:SetSize(400, 600)
	phonebook:SetPos(ScrW() / 2 + 100, ScrH() / 2 - 100)
	phonebook.Paint = function(self, w, h)
		MSD.DrawTexturedRect(0, 0, w, h, mats[3], color_white)
		draw.SimpleText("Справочник", "McPhone.PhoneBook", 25, 35, colors[2], TEXT_ALIGN_LEFT)
	end

	local contacts = vgui.Create("MSDPanelList", phonebook)
	contacts:SetPos(25, 75)
	contacts:SetSize(350, 500)
	contacts:EnableHorizontal(false)
	contacts:EnableVerticalScrollbar()
	contacts:SetSpacing(0)
	contacts.Paint = function(self, w, h) end
	local m_manage
	McPhone.PayPhone.UI.Menu = contacts
	McPhone.PayPhone.UI.Buts = {}
	contacts.ConvertToList = function()
		contacts:Clear()
	end
	contacts.ConvertToMenu = function()
		contacts:Clear()
	end

	function m_manage()
		contacts:Clear(true)

		if McPhone.ExtraNumbers then
			for k, v in pairs(McPhone.ExtraNumbers) do
				if not v.addtocontacts then continue end
				if v.checkNumber and v.checkNumber(LocalPlayer()) then continue end
				PayPhone_ListIcons(contacts, v.nicename, function()
					if disable_buts or dilenumber then return end
					--local nb = k
					-- McPhone.LastNumber = nb
					-- local lastcall = nb

					-- if lastcall then
					-- 	McPhone.LastNumber = lastcall
					-- end
					number = ""
					dilenumber = k
				end, k)
			end
		end

		for k, v in pairs(McPhone.Contacts) do
			local pl = McPhone.GetByNumber(k)

			PayPhone_ListIcons(contacts, (pl and IsValid(pl)) and pl:Name() or v, function()
				if disable_buts or dilenumber then return end
				--number = k
				--McPhone.LastNumber = number
				number = ""
				dilenumber = k
				-- net.Start("McPhone.CallStart")
				-- net.WriteString(number)
				-- net.WriteBool(false)
				-- net.SendToServer()
			end, k)
		end
	end
	function McPhone.PayPhone.UI.GoBack()
		number = McPhone.GetPhrase("enter_number")
		m_manage()
	end
	m_manage()

	for k, v in pairs(button_list) do
		local buton = vgui.Create("DButton", overlay)
		buton:SetSize(68, 68)
		buton:SetPos(v.x, v.y)
		buton:SetText("")
		buton.click = 0
		buton.DoClick = function(self)
			if disable_buts and not v.func then return end
			self.click = CurTime() + 0.1
			if not snd then
				McPhone.PlaySoundUI("mcphone/but_press.wav")
			end

			if not v.func then
				if number == McPhone.GetPhrase("enter_number") then
					number = v.text
				else
					number = number .. v.text
				end

				return
			end

			v.func(self)
		end

		buton.spaser = 0
		McPhone.PayPhone.UI.Buts[k] = buton
		buton.Paint = function(s, w, h)
			if s.click and s.click > CurTime() then
				MSD.DrawTexturedRect(0, 0, w, h, but_s[k], color_white)
				draw.SimpleText(v.text, "McPhone.Payphone", w / 2, h / 2 - 21, colors[2], TEXT_ALIGN_CENTER)
			else
				MSD.DrawTexturedRect(0, 0, w, h, but[k], color_white)
				draw.SimpleText(v.text, "McPhone.Payphone", w / 2, h / 2 - 22, colors[1], TEXT_ALIGN_CENTER)
			end
		end
	end
end

net.Receive("McPhone.PayPhone", function(msg)
	local ent = net.ReadEntity()

	if ent and IsValid(ent) then
		McPhone.PayPhone.OpenMenu(ent)
	end
end)

hook.Add("McPhone.Hook.ClosePhone", "McPhone.PayPhone.ClosePhone", function()
	if McPhone.PayPhone and McPhone.PayPhone.UI then
		McPhone.PayPhone.UI:Remove()
	end
end)