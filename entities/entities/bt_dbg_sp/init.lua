AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include "shared.lua"

function ENT:Initialize()
    self:SetModel("models/props_wasteland/medbridge_post01.mdl")
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_NONE)
    self:SetMaterial("models/debug/debugwhite", true)
end

function ENT:SVSpawn(spawn, steam)
    self:Spawn()
    self:SetPos(spawn:GetPos())
    self:SetAngles(spawn:GetAngles())
    self:SetColor(team.GetColor(steam))

    constraint.Keepupright(self, self:GetAngles(), 0, 99999)
end