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
    
    self:SetFuse(BOMB_FUSE:GetInt())
    self:SetArmed(false)
    self:SetArming(false)

    local timername = "Fuse"..tostring(self)

    timer.Create(timername, 1, 0, function()
        if not self:IsValid() or tobool(BOMB:GameOver()) then return end
        
        local Fuse = self:GetFuse()
        if Fuse > 1 then self:SetFuse(Fuse - 1)
        else
            self:Detonate()
            timer.Destroy(timername)
         end

         if Fuse % 2 == 0 then self:EmitSound("tick") end
    end
    )
    timer.Pause(timername)

    local phys = self:GetPhysicsObject()
    if(IsValid(phys)) then
        phys:Wake()
    end

    BOMB:AddBomb(self)
end

function ENT:SpawnFunction(ply, tr, class)       --TEMP
    if not tr.Hit then return end

    local ent = ents.Create(class)
    ent:Spawn()
    ent:SetPos(tr.HitPos)
    ent:SetAngles(Angle(0, ply:GetAimVector():Angle().yaw - 180, 0))

    if ply then 
        ent:SetColor(team.GetColor(ply:Team()))
        ent:SetTeam(ply:Team())
    end

    return ent

end

function ENT:RoundSpawn(team, spawn)
    ent:Spawn()
    ent:SetPos(spawn:GetPos())
    ent:SetAngles(spawn:GetAngles())
    ent:SetTeam(team)
    ent:SetColor(team.GetColor(team))
end

function ENT:Use(activator, caller)                                 --arm/disarm
    if tobool(BOMB:GameOver()) then return end

    if not caller:IsValid() or not caller:IsPlayer() then return end

    local arming = self:GetArming()
    local armed = self:GetArmed()
    local sameteam = caller:Team() == self:GetTeam()

    if (armed and sameteam) or (not armed and (not sameteam or BOMB_TEAM_ARM:GetBool())) then

        if not arming then 
            self.a_init = CurTime()
            self:SetArming(true)
            --self.cursnd = self:StartLoopingSound("arming")

        elseif CurTime() - self.a_init > BOMB_ARMTIME:GetInt() then
            self:SetArmed(not armed)
            self:SetArming(false)
            timer.Toggle("Fuse"..tostring(self))
            timer.Destroy("stoparming")
            timer.Simple(0.2, function()
                self:EmitSound(self:GetArmed() and "armed" or "defused")
            end)

            if BOMB_NOTIFY:GetBool() and self:GetArmed() then
                for k, ply in pairs(team.GetPlayers(self:GetTeam())) do
                    ply:PrintMessage(HUD_PRINTCENTER, "Your bomb is Armed!")
                end
            end
        end
    end

    timer.Destroy("stoparming")
    timer.Create("stoparming", 0.1, 1, function() 
        self:SetArming(false)
        if self.cursnd then self:StopLoopingSound(self.cursnd) end
     end)
end

function ENT:Detonate()
    if tobool(BOMB:GameOver()) then return end
    
    BOMB:DelBomb(self)
    
    local husk = ents.Create("prop_physics")
    husk:SetModel("models/props_junk/TrashDumpster01a.mdl")
    husk:SetPos(self:GetPos() + Vector(0, 0, 10))
    husk:SetMaterial("phoenix_storms/concrete1")
    husk:SetColor(Color(50,50,50))
    husk:Spawn()

    self:Remove()    

    local data = EffectData()
    data:SetOrigin(husk:GetPos())
    data:SetFlags(0x4)
    util.Effect("Explosion", data)
    util.ScreenShake(husk:GetPos(), 10, 10, 2, 2000)
    util.ScreenShake(husk:GetPos(), 3, 10, 2, 5000)
    husk:EmitSound("ambient/explosions/explode_1.wav", 85, 100, 1)
    husk:EmitSound("ambient/explosions/exp3.wav", 120, 130, 1)
    util.BlastDamage(game.GetWorld(), husk, husk:GetPos() + Vector(0, 0, 50), BOMB_DMGRAD:GetInt(), 200)
    husk:Ignite(10, BOMB_DMGRAD:GetInt()/2)
    
    local phys = husk:GetPhysicsObject()
    if not IsValid(phys) then return end

    phys:SetMass(800)
    phys:ApplyForceOffset(VectorRand(0, 30000) + Vector(0, 0, 220000), phys:GetPos() + phys:GetMassCenter() + VectorRand(-2, 2))
end


function ENT:Think()
    if self:GetArming() then self.cursnd = self:StartLoopingSound("arming") end
end

function ENT:OnRemove()
    if not table.IsEmpty(BOMB:GetBombs()) then BOMB:DelBomb(self) end
end