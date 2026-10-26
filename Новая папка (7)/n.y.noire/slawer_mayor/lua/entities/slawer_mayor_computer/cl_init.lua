--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_mayor/lua/entities/slawer_mayor_computer/cl_init.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

include("shared.lua")

function ENT:CreateMenu()
	Slawer.Mayor.Menu = vgui.Create("Slawer.Mayor:Menu")
end

function ENT:Draw()
	self:DrawModel()
end

function ENT:OnRemove()
	Slawer.Mayor.FocusEntry = nil

	if Slawer.Mayor.LookingTo then
		gui.EnableScreenClicker(false)
		Slawer.Mayor.LookingTo = nil
	end

	if IsValid(Slawer.Mayor.FakeTextEntry) then
		Slawer.Mayor.FakeTextEntry:Remove()
	end

	if IsValid(Slawer.Mayor.Menu) then
		Slawer.Mayor.Menu:Remove()
		LocalPlayer():SetNoDraw(false)
	end
end