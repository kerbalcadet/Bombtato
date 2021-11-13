AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include "shared.lua"

local contents = {}

function ENT:Initialize()
    self:SetModel("models/Items/BoxMRounds.mdl")
    self:PhysicsInit(SOLID_NONE)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_NONE)
end

function ENT:SVSpawn(pos)
    self:Spawn()
    self:SetPos(pos)

    constraint.Keepupright(self, self:GetAngles(), 0, 99999)
end

function ENT:Touch(ent)
    if ent:IsValid() and ent:IsPlayer() then
        for ammid, ammamt in pairs(self:GetContents()) do
            ent:GiveAmmo(ammamt, ammid, false)
        end
    end

    self:Remove()
end

function ENT:SetContents(ammo)
    table.Empty(contents)
    table.CopyFromTo(ammo, contents)
end

function ENT:GetContents()
    return contents
end