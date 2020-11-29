AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include "shared.lua"

function ENT:Initialize()
    self:SetModel("models/props_junk/TrashDumpster01a.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetMaterial("phoenix_storms/concrete1", true)
    self:SetUseType(CONTINUOUS_USE)
    
    self:SetFuse(BOMB_FUSE)
    self:SetArmed(false)
    self:SetArming(false)
    self.last = 0

    local timername = "Fuse"..tostring(self)

    timer.Create(timername, 1, 0, function()
        if not self:IsValid() then return end
        
        local Fuse = self:GetFuse()
        if Fuse > 1 then self:SetFuse(Fuse - 1)
        else 
            self:Detonate()
            timer.Destroy(timername)
         end    
    end
    )
    timer.Pause(timername)

    local phys = self:GetPhysicsObject()
    if(IsValid(phys)) then
        phys:Wake()
    end

    AddBomb(self)
end

function ENT:SpawnFunction(ply, tr, class)
    if not tr.Hit then return end

    local ent = ents.Create(class)
    ent:Spawn()
    ent:SetPos(tr.HitPos)

    if ply then ent:SetColor(team.GetColor(ply:Team())) end
    self.team = team.GetName(ply:Team())

    return ent

end

function ENT:Use(activator, caller)
    if not caller:IsValid() or not caller:IsPlayer() then return end
    local arming = self:GetArming()
    local armed = self:GetArmed()
    local delay = CurTime() - self.last > 0.1

    if not arming then 
        self.last = CurTime()
        self.AInit = self.last
        self:SetArming(true)
    elseif CurTime() - self.AInit > BOMB_ARMTIME then 
        if not delay then
            self:SetArmed(not armed)
            timer.Toggle("Fuse"..tostring(self))
        end 
        self:SetArming(false)
    elseif  delay then
        self:SetArming(false)
    end

    self.last = CurTime()
end

function ENT:Detonate()
    DelBomb(self)
    
    self:SetColor(Color(50, 50, 50))

    util.BlastDamage(game.GetWorld(), self, self:GetPos() + Vector(0, 0, 20), BOMB_DMGRAD, 1000)
    self:Ignite(10, BOMB_DMGRAD)
end
