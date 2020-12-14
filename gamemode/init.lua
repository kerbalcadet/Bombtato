AddCSLuaFile("../content/fonts.lua")
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("sh_gamemode.lua")

include("../content/sound.lua")
include("config/commands.lua")
include("sh_gamemode.lua")
include("sv_bombs.lua")
include("sv_gamelogic.lua")
include("sv_player.lua")
include("sv_teams.lua")

function GM:Initialize()
    math.randomseed(CurTime())
    BOMB:Start()
end