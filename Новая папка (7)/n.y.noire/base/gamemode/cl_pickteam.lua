--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/base/gamemode/cl_pickteam.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]


--[[---------------------------------------------------------
   Name: gamemode:ShowTeam()
   Desc:
-----------------------------------------------------------]]
function GM:ShowTeam()

	if ( IsValid( self.TeamSelectFrame ) ) then return end
	
	-- Simple team selection box
	self.TeamSelectFrame = vgui.Create( "DFrame" )
	self.TeamSelectFrame:SetTitle( "Pick Team" )
	
	local AllTeams = team.GetAllTeams()
	local y = 30
	for ID, TeamInfo in pairs ( AllTeams ) do
	
		if ( ID != TEAM_CONNECTING && ID != TEAM_UNASSIGNED ) then
	
			local Team = vgui.Create( "DButton", self.TeamSelectFrame )
			function Team.DoClick() self:HideTeam() RunConsoleCommand( "changeteam", ID ) end
			Team:SetPos( 10, y )
			Team:SetSize( 130, 20 )
			Team:SetText( TeamInfo.Name )
			
			if ( IsValid( LocalPlayer() ) && LocalPlayer():Team() == ID ) then
				Team:SetEnabled( false )
			end
			
			y = y + 30
		
		end
		
	end

	if ( GAMEMODE.AllowAutoTeam ) then
	
		local Team = vgui.Create( "DButton", self.TeamSelectFrame )
		function Team.DoClick() self:HideTeam() RunConsoleCommand( "autoteam" ) end
		Team:SetPos( 10, y )
		Team:SetSize( 130, 20 )
		Team:SetText( "Auto" )
		y = y + 30
	
	end
	
	self.TeamSelectFrame:SetSize( 150, y )
	self.TeamSelectFrame:Center()
	self.TeamSelectFrame:MakePopup()
	self.TeamSelectFrame:SetKeyboardInputEnabled( false )

end

--[[---------------------------------------------------------
   Name: gamemode:HideTeam()
   Desc:
-----------------------------------------------------------]]
function GM:HideTeam()

	if ( IsValid(self.TeamSelectFrame) ) then
		self.TeamSelectFrame:Remove()
		self.TeamSelectFrame = nil
	end

end
