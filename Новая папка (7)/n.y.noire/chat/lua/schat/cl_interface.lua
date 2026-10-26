--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/chat/lua/schat/cl_interface.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

-- clear stuff when loading this script (helps during development)
if IsValid(SChat.frame) then
	chat.Close()
	SChat.frame:SetMouseInputEnabled(false)
	SChat.frame:SetKeyboardInputEnabled(false)
	SChat.frame:SetDeleteOnClose(true)
	SChat.frame:Close()
	SChat.chatBox = nil
	SChat.frame = nil
end

SChat.isOpen = false
SChat.isGamePaused = false
SChat.usingServerTheme = false
SChat.serverTheme = ''
-- keep track of the original functions
chat.DefaultOpen = chat.DefaultOpen or chat.Open
chat.DefaultClose = chat.DefaultClose or chat.Close
chat.DefaultAddText = chat.DefaultAddText or chat.AddText
chat.DefaultGetChatBoxPos = chat.DefaultGetChatBoxPos or chat.GetChatBoxPos
chat.DefaultGetChatBoxSize = chat.DefaultGetChatBoxSize or chat.GetChatBoxSize
local Settings = SChat.Settings
local Theme = SChat.Theme

local colors = {
	["bgr"] = Color(0, 0, 0, 180),
	["bgr_d"] = Color(0, 0, 0, 220),
	["main_l"] = Color(255, 150, 0)
}

SChat.Mods = {
	[1] = "",
	[2] = "/me ",
	[3] = "/do ",
	[4] = "/roll ",
	[5] = "/it ",
}

function SChat:CreatePanels()
	local cw, ch = math.max(ScrW() * 0.3, 400), ScrH() * 0.25
	self.frame = vgui.Create("MSDSimpleFrame")
	self.frame:SetSize(cw, ch)
	self.frame:SetDraggable(false)
	self.frame:SetSizable(false)
	self.frame:SetPos(15, (ScrH() - self.frame:GetTall()) - ScrH() * 0.177)
	self.chatBox = vgui.Create("SChatBox", self.frame)
	self.chatBox:SetFontSize(16)
	self.chatBox:SetPos(0, 0)
	self.chatBox:SetSize(cw, ch - 35)

	self.chatBox.OnPressEnter = function()
		self:OnPressEnter()
	end

	self.entryDock = vgui.Create("DPanel", self.frame)
	self.entryDock:SetPos(0, ch - 30)
	self.entryDock:SetSize(cw, 30)

	self.entryDock.Paint = function(s, w, h)
		MSDX.Draw(0, 0, 0, w, h, colors.bgr_d)
	end

	self.entry = vgui.Create("DTextEntry", self.entryDock)
	self.entry:SetFont("MSDFont.20")
	self.entry:SetDrawBorder(false)
	self.entry:SetPaintBackground(false)
	self.entry:SetMaximumCharCount(self.MAX_MESSAGE_LEN)
	self.entry:SetTabbingDisabled(true)
	self.entry:SetMultiline(false)
	self.entry:SetSize(cw, 30)
	self.entry:SetCursorColor(color_white)
	self.entry:SetHistoryEnabled(true)
	self.entry:SetDrawLanguageID(false)

	--self.entry.History = {}
	self.entry.OnChange = function(s)
		if s.GetText then
			local text = s:GetText() or ''
			local _, nLines = string.gsub(text, '\n', '\n')
			hook.Run('ChatTextChanged', text)
			nLines = math.Clamp(nLines + 1, 1, 5)
		end
	end

	self.entry.OnKeyCodeTyped = function(s, code)
		if code == KEY_ESCAPE then
			chat.Close()
		elseif code == KEY_F then
			if input.IsControlDown() then
				self.chatBox:FindText()
			end
		elseif code == KEY_ENTER and not input.IsShiftDown() then
			s:AddHistory(s:GetText())
			s.HistoryPos = 0
			self:OnPressEnter()

			return true
		elseif code == KEY_TAB and input.IsControlDown() and self.entry:GetText() == SChat.Mods[self.cyclecoms] then
			self:NormalMode()

			if self.cyclecoms >= #SChat.Mods then
				self.cyclecoms = 1
			else
				self.cyclecoms = self.cyclecoms + 1
			end

			self.entry:SetText(SChat.Mods[self.cyclecoms])
			self.entry:SetCaretPos(utf8.len(SChat.Mods[self.cyclecoms]))
		elseif code == KEY_TAB and not input.IsControlDown() then
			self:ChangeMOD()
		end

		if s.History then
			if (code == KEY_UP) then
				s.HistoryPos = s.HistoryPos - 1
				s:UpdateFromHistory()
			end

			if (code == KEY_DOWN) then
				s.HistoryPos = s.HistoryPos + 1
				s:UpdateFromHistory()
			end
		end
	end

	chat.GetChatBoxPos = function() return self.frame:GetPos() end
	chat.GetChatBoxSize = function() return self.frame:GetSize() end
	self:SetInputEnabled(false)
end

function SChat:AppendAtCaret(text)
	if not self.isOpen then return end
	local caretPos = self.entry:GetCaretPos()
	local oldText = self.entry:GetText()
	local newText = oldText:sub(1, caretPos) .. text .. oldText:sub(caretPos + 1)

	if string.len(newText) < self.entry:GetMaximumCharCount() then
		self.entry:SetText(newText)
		self.entry:SetCaretPos(caretPos + text:len())
	else
		surface.PlaySound('resource/warning.wav')
	end
end

function SChat:OnPressEnter()
	if not self.isOpen then return end
	local text = self.CleanupString(self.entry:GetText())

	if string.len(text) > 0 then
		net.Start('schat.say', false)
		net.WriteUInt(self.teamMode, 4)
		net.WriteString(text)
		net.SendToServer()
	end

	chat.Close()
end

function SChat:SuggestServerTheme()
	if IsValid(self.btnSuggest) then
		self.btnSuggest:Remove()
		self.btnSuggest = nil
	end

	if self.serverTheme == '' then return end
	self:CloseExtraPanels()
	self.btnSuggest = vgui.Create('DImageButton', self.entryDock)
	self.btnSuggest:SetImage('icon16/asterisk_yellow.png')
	self.btnSuggest:SetTooltip('Server Theme')
	self.btnSuggest:SetStretchToFit(false)
	self.btnSuggest:SetWide(22)
	self.btnSuggest:Dock(RIGHT)

	self.btnSuggest.DoClick = function()
		Derma_Query('This server has a custom theme.\nDo you want to use it?', 'Server Theme', 'Yes', function()
			local success, errMsg = Theme:Import(self.serverTheme)

			if success then
				self.usingServerTheme = true
				self:ApplyTheme(true)
				self.btnSuggest:Remove()
				self.btnSuggest = nil
			else
				Derma_Message('Error: ' .. errMsg, 'Failed to apply the server theme', 'OK')
			end
		end, 'No')
	end
end

function SChat:OpenContextMenu(data, isLink)
end

function SChat:CreateSidePanel(title, showCloseButton)
	self:CloseExtraPanels()
	local chatX, chatY, chatW, chatH = self.frame:GetBounds()
	chatH = math.Clamp(chatH, 280, 400)
	local pnl = vgui.Create('DFrame')
	pnl:SetSize(250, chatH)
	pnl:SetPos(chatX + chatW + 5, chatY)
	pnl:SetTitle(title)
	pnl:ShowCloseButton(showCloseButton)
	pnl:SetDeleteOnClose(true)
	pnl:MakePopup()

	pnl.Paint = function(s, w, h)
		MSDX.Draw(4, 0, 0, w, h, Theme.background)
		MSDX.Draw(4, 0, 0, w, 25, Color(0, 0, 0, 200))
	end

	pnl.OnKeyCodePressed = function(_, code)
		if code == KEY_ENTER then
			self.entry:OnKeyCodeTyped(KEY_ENTER)
		end
	end

	return pnl
end

function SChat:CloseExtraPanels()
	CloseDermaMenus()

	if IsValid(Theme.customFrame) then
		Theme.customFrame:Close()
	end
end

function SChat:ApplyTheme(invalidate)
	self.frame:DockPadding(Theme.padding, Theme.padding + 24, Theme.padding, Theme.padding)
	self.entry:SetTextColor(Theme.input)
	self.entry:SetCursorColor(Theme.input)
	self.entry:SetHighlightColor(Theme.highlight)
	self.entryDock._backgroundColor = Theme.input_background
	self.chatBox:SetHighlightColor(Theme.highlight)
	self.chatBox:SetBackgroundColor(Theme.input_background)

	if invalidate then
		self.frame:InvalidateChildren(false)
	end
end

function SChat:SetInputEnabled(enable)
	for _, pnl in ipairs(self.frame:GetChildren()) do
		if pnl == self.chatBox or pnl == self.frame.btnMaxim or pnl == self.frame.btnClose or pnl == self.frame.btnMinim then continue end
		pnl:SetVisible(enable)
	end

	self.chatBox:SetDisplayMode(enable and 'main' or 'temp')
end

function SChat:AppendMessage(contents)
	if not IsValid(self.frame) then
		self:CreatePanels()
	end

	self.chatBox:AppendContents(contents)
end

local schatAddText = function(...)
	SChat:AppendMessage({...})

	chat.DefaultAddText(...)
end

local schatClose = function()
	if not IsValid(SChat.frame) then return end
	SChat:CloseExtraPanels()
	SChat:SetInputEnabled(false)
	SChat.isOpen = false
	SChat.frame:SetMouseInputEnabled(false)
	SChat.frame:SetKeyboardInputEnabled(false)
	SChat.chatBox:ClearSelection()
	SChat.entry:SetText('')
	gui.EnableScreenClicker(false)
	hook.Run('FinishChat')
	hook.Run('ChatTextChanged', '')
	net.Start('schat.istyping', false)
	net.WriteBool(false)
	net.SendToServer()
end

local col = Color(120, 137, 143, 255)
local col2 = Color(163, 163, 163)
local col3 = Color(211, 219, 223)

function SChat:ChangeMOD()
	SChat.teamMode = SChat.teamMode + 1

	if SChat.teamMode > 1 then
		SChat.teamMode = 0
	end

	if SChat.teamMode == 1 then
		SChat.entry:SetPlaceholderText('LOOC')
		SChat.entry:SetTextColor(col3)
		SChat.entry:SetPlaceholderColor(col3)
	elseif SChat.teamMode == 2 then
		SChat.entry:SetPlaceholderText('LOOC')
		SChat.entry:SetTextColor(col)
		SChat.entry:SetPlaceholderColor(col2)
	else
		SChat.entry:SetPlaceholderText('Чат')
		SChat.entry:SetPlaceholderColor(colors.main_l)
		SChat.entry:SetTextColor(color_white)
	end
end

function SChat:NormalMode()
	SChat.teamMode = 0
	SChat.entry:SetPlaceholderText('Чат')
	SChat.entry:SetPlaceholderColor(colors.main_l)
	SChat.entry:SetTextColor(color_white)
end

local schatOpen = function()
	if not IsValid(SChat.frame) then
		SChat:CreatePanels()
	end

	-- Update the 'Say' label and the color of the text entry 
	if SChat.teamMode == 1 then
		SChat.entry:SetPlaceholderText('LOOC')
		SChat.entry:SetTextColor(col3)
		SChat.entry:SetPlaceholderColor(col3)
	elseif SChat.teamMode == 2 then
		SChat.entry:SetPlaceholderText('LOOC')
		SChat.entry:SetTextColor(col)
		SChat.entry:SetPlaceholderColor(col2)
	else
		SChat.entry:SetPlaceholderText('Чат')
		SChat.entry:SetPlaceholderColor(colors.main_l)
		SChat.entry:SetTextColor(color_white)
	end

	SChat.isOpen = true
	SChat:SetInputEnabled(true)
	-- MakePopup calls the input functions so we dont need to call those
	-- (refering to SetMouseInputEnabled/SetKeyboardInputEnabled)
	SChat.cyclecoms = 1
	SChat.frame:MakePopup()
	SChat.entry:RequestFocus()
	--SChat.entryDock:SetTall(20)
	SChat.chatBox:ScrollToBottom()
	-- make sure other addons know we are chatting
	hook.Run('StartChat')
	net.Start('schat.istyping', false)
	net.WriteBool(true)
	net.SendToServer()
end

local cl = Color(236, 195, 157)

local hide_chat = {
	['joinleave'] = true,
	['namechange'] = true,
	['servermsg'] = true,
	['teamchange'] = true,
}

local function schat_ChatText(_, _, text, textType)
	if hide_chat[textType] then return true end

	if textType ~= 'chat' then
		SChat:AppendMessage({cl, text})

		return true
	end
end

local function schat_PlayerBindPress(_, bind, pressed)
	if not pressed then return end
	if bind ~= 'messagemode' and bind ~= 'messagemode2' then return end
	-- dont open if playable piano is blocking input
	if IsValid(LocalPlayer().Instrument) then return end
	-- dont open if Starfall is blocking input
	local existingBindHooks = hook.GetTable()['PlayerBindPress']
	if existingBindHooks['sf_keyboard_blockinput'] then return end
	-- dont open if anything else blocks input
	local block = hook.Run('SChat_BlockChatInput')
	if block == true then return end
	SChat.teamMode = (bind == 'messagemode2') and 1 or 0
	chat.Open()

	return true
end

local function schat_HUDShouldDraw(name)
	if name == 'CHudChat' then return false end
end

local function schat_Think()
	if not SChat.chatBox then return end

	-- hide the chat box if the game is paused
	if gui.IsGameUIVisible() then
		if SChat.isOpen then
			chat.Close()
		end

		if SChat.isGamePaused == false then
			SChat.isGamePaused = true
			SChat.chatBox:SetVisible(false)
		end
	else
		if SChat.isGamePaused == true then
			SChat.isGamePaused = false
			SChat.chatBox:SetVisible(true)
		end
	end
end

function SChat:Enable()
	chat.AddText = schatAddText
	chat.Close = schatClose
	chat.Open = schatOpen
	hook.Add('ChatText', 'schat_ChatText', schat_ChatText)
	hook.Add('PlayerBindPress', 'schat_PlayerBindPress', schat_PlayerBindPress)
	hook.Add('HUDShouldDraw', 'schat_HUDShouldDraw', schat_HUDShouldDraw)
	hook.Add('Think', 'schat_Think', schat_Think)

	if SChat.chatBox then
		SChat.chatBox:SetVisible(true)
	end
end

function SChat:Disable()
	hook.Remove('ChatText', 'schat_ChatText')
	hook.Remove('PlayerBindPress', 'schat_PlayerBindPress')
	hook.Remove('HUDShouldDraw', 'schat_HUDShouldDraw')
	hook.Remove('Think', 'schat_Think')
	chat.AddText = chat.DefaultAddText
	chat.Close = chat.DefaultClose
	chat.Open = chat.DefaultOpen

	if self.chatBox then
		self.chatBox:SetVisible(false)
	end
end

SChat:Enable()
-- remove existing temporary messages when cl_drawhud is 0
cvars.RemoveChangeCallback('schat_cl_drawhud_changed')

cvars.AddChangeCallback('cl_drawhud', function(_, _, newValue)
	if SChat.chatBox and newValue == '0' then
		SChat.chatBox:ClearTempMessages()
	end
end, 'schat_cl_drawhud_changed')

-- custom 'IsTyping' behavior
local PLY = FindMetaTable('Player')
PLY.DefaultIsTyping = PLY.DefaultIsTyping or PLY.IsTyping

function PLY:IsTyping()
	return self:GetNWBool('IsTyping', false)
end

-- received server theme
net.Receive('schat.set_theme', function()
	SChat.serverTheme = net.ReadString()

	if IsValid(SChat.frame) then
		SChat:SuggestServerTheme()
	end
end)

-- received server emojis
net.Receive('schat.set_emojis', function()
	Settings:ClearCustomEmojis()
	SChat.PrintF('Received emojis from the server.')
	local data = net.ReadString()

	if data ~= '' then
		data = util.JSONToTable(data)

		if data then
			for _, v in ipairs(data) do
				Settings:AddOnlineEmoji(v[1], v[2])
			end
		else
			SChat.PrintF('Failed to parse emojis from the server!')
		end
	end

	if IsValid(SChat.chatBox) then
		SChat.chatBox:UpdateEmojiPanel()
	end
end)

-- received a message
net.Receive('schat.say', function()
	local channel = net.ReadUInt(4)
	local text = net.ReadString()
	local ply = net.ReadEntity()
	if not IsValid(ply) then return end
	local isDead = not ply:Alive()

	if channel == 2 then
		text = '// ' .. text
	end

	hook.Run('OnPlayerChat', ply, text, channel == SChat.TEAM, isDead)
end)