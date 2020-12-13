AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("../content/fonts.lua")

include("shared.lua")
include("player.lua")
include("config/commands.lua")
include("config/config.lua")
include("gamelogic.lua")
include("../content/sound.lua")

math.randomseed(CurTime())

function GM:Initialize()
    BOMB:SetActiveTeams()
end