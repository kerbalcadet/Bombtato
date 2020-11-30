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
        if not self:IsValid() or GAME_ENDED then return end
        
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

    if ply then 
        ent:SetColor(team.GetColor(ply:Team()))
        ent.team = team.GetName(ply:Team())
    end

    return ent

end

function ENT:Use(activator, caller)
    if GAME_ENDED then return end

    if not caller:IsValid() or not caller:IsPlayer() then return end

    local arming = self:GetArming()
    local armed = self:GetArmed()

    if not arming then 
        self.a_init = CurTime()
        self:SetArming(true)
    elseif CurTime() - self.a_init > BOMB_ARMTIME then 
        self:SetArmed(not armed)
        timer.Toggle("Fuse"..tostring(self)) 
        self:SetArming(false)
    end
    
    timer.Destroy("stoparming")
    timer.Create("stoparming", 0.1, 1, function() self:SetArming(false) end)
end

function ENT:Detonate()
    if GAME_ENDED then return end
    
    DelBomb(self)
    
    local husk = ents.Create("prop_physics")
    husk:SetModel("models/props_junk/TrashDumpster01a.mdl")
    husk:SetPos(self:GetPos() + Vector(0, 0, 10))
    husk:SetMaterial("phoenix_storms/concrete1")
    husk:SetColor(Color(50,50,50))
    husk:Spawn()

    self:Remove()    

    util.BlastDamage(game.GetWorld(), husk, husk:GetPos() + Vector(0, 0, 50), BOMB_DMGRAD, 200)
    husk:Ignite(10, BOMB_DMGRAD)
    
    local phys = husk:GetPhysicsObject()
    if not IsValid(phys) then return end

    phys:SetMass(800)
    phys:ApplyForceOffset(VectorRand(0, 30000) + Vector(0, 0, 150000), phys:GetPos() + phys:GetMassCenter() + VectorRand(-3, 3))
end
