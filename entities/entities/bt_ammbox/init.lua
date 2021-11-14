AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include "shared.lua"

local contents = {}

function ENT:Initialize()
    self:SetModel("models/Items/BoxMRounds.mdl")
    self:SetSolid(SOLID_BBOX)
    self:SetTrigger(true)
    self:PhysWake()
    self:SetNotSolid(true)

    local timername = "lifetime"..tostring(self)

    timer.Create(timername, 15, 1, function()
        self:Remove()
    end)
end

function ENT:SVSpawn(pos)
    self:Spawn()
    self:SetPos(pos)
    self:DropToFloor()

    constraint.Keepupright(self, self:GetAngles(), 0, 99999)
end

function ENT:Touch(ent)
    if ent:IsValid() and ent:IsPlayer() then
        for ammid, ammamt in pairs(self:GetContents()) do
            ent:GiveAmmo(ammamt, ammid, false)
        end
    end

    timer.Remove("lifetime"..tostring(self))
    self:Remove()
end

function ENT:SetContents(ammo)
    table.Empty(contents)
    table.CopyFromTo(ammo, contents)
end

function ENT:GetContents()
    return contents
end