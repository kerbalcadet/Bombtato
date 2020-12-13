AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("../content/fonts.lua")
AddCSLuaFile("sh_teams.lua")

include("shared.lua")
include("player.lua")
include("config/commands.lua")
include("config/config.lua")
include("gamelogic.lua")
include("../content/sound.lua")
include("sh_teams.lua")

math.randomseed(CurTime())

function GM:Initialize()
    BOMB:SetActiveTeams()
end