--[[
Server Name: ✪ New York Noire | Атмосферный RP-сервер
Server IP:   46.174.50.110:27015
File Path:   gamemodes/darkrp/gamemode/modules/doorsystem/cl_interface.lua
		 __        __              __             ____     _                ____                __             __         
   _____/ /_____  / /__  ____     / /_  __  __   / __/____(_)__  ____  ____/ / /_  __     _____/ /____  ____ _/ /__  _____
  / ___/ __/ __ \/ / _ \/ __ \   / __ \/ / / /  / /_/ ___/ / _ \/ __ \/ __  / / / / /    / ___/ __/ _ \/ __ `/ / _ \/ ___/
 (__  ) /_/ /_/ / /  __/ / / /  / /_/ / /_/ /  / __/ /  / /  __/ / / / /_/ / / /_/ /    (__  ) /_/  __/ /_/ / /  __/ /    
/____/\__/\____/_/\___/_/ /_/  /_.___/\__, /  /_/ /_/  /_/\___/_/ /_/\__,_/_/\__, /____/____/\__/\___/\__,_/_/\___/_/     
                                     /____/                                 /____/_____/                                  
--]]

DarkRP.readNetDoorVar = DarkRP.stub{
    name = "readNetDoorVar",
    description = "Internal function. You probably shouldn't need this. DarkRP calls this function when reading DoorVar net messages. This function reads the net data for a specific DoorVar.",
    parameters = {
    },
    returns = {
        {
            name = "name",
            description = "The name of the DoorVar.",
            type = "string"
        },
        {
            name = "value",
            description = "The value of the DoorVar.",
            type = "any"
        }
    },
    metatable = DarkRP
}

DarkRP.ENTITY.drawOwnableInfo = DarkRP.stub{
    name = "drawOwnableInfo",
    description = "Draw the ownability information on a door or vehicle.",
    parameters = {
    },
    returns = {
    },
    metatable = DarkRP.ENTITY
}

DarkRP.hookStub{
    name = "HUDDrawDoorData",
    description = "Called when DarkRP is about to draw the door ownability information of a door or vehicle. Override this hook to ",
    parameters = {
        {
            name = "ent",
            description = "The door or vehicle of which the ownability information is about to be drawn.",
            type = "Entity"
        }
    },
    returns = {
        {
            name = "override",
            description = "Return true in your hook to disable the default drawing and use your own.",
            type = "boolean"
        }
    }
}
