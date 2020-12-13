AddCSLuaFile("../content/fonts.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("sh_gamemode.lua")
AddCSLuaFile("sh_teams.lua")

include("../content/sound.lua")
include("config/commands.lua")
include("config/config.lua")
include("sh_gamemode.lua")
include("sh_teams.lua")
include("sv_bombs.lua")
include("sv_gamelogic.lua")
include("sv_player.lua")

function GM:Initialize()
    math.randomseed(CurTime())
end