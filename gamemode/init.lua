AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("config/fonts.lua")

include("shared.lua")
include("player.lua")
include("config/commands.lua")
include("config/config.lua")
include("gamelogic.lua")
include("sound.lua")

math.randomseed(CurTime())