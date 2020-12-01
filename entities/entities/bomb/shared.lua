ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.Category = "Bombtato"
ENT.PrintName = "Bomb"
ENT.Author = "rocketpanda40"
ENT.Purpose = "goes explodey"
ENT.Spawnable = true

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "Fuse")
    self:NetworkVar("Bool", 0, "Armed")
    self:NetworkVar("Bool", 1, "Arming")
    self:NetworkVar("Int", 1, "Team")
end
