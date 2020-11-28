AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
AddCSLuaFile("config/fonts.lua")

include("shared.lua")
include("player.lua")
include("config/config.lua")

math.randomseed(CurTime())