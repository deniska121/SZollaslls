--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   addons/slawer_elections/lua/slawer_elections/client/functions.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

function Slawer.Elections:DisplayPopup()
    if IsValid(Slawer.Elections.Popup) then return end
    Slawer.Elections.Popup = vgui.Create("Slawer.Elections:Popup")
end

function Slawer.Elections:ClosePopup()
    if IsValid(Slawer.Elections.Popup) then
        Slawer.Elections.Popup:Remove()
    end
end

function Slawer.Elections:ShowVotingMenu()
    if IsValid(Slawer.Elections.VotingMenu) then
        Slawer.Elections.VotingMenu:Remove()
    end

    Slawer.Elections.VotingMenu = vgui.Create("Slawer.Elections:Voting")
    Slawer.Elections.VotingMenu:Populate(Slawer.Elections.Candidates)
end