function BOMB:SelectTeam(ply)
    local nt = BOMB_NUMTEAMS:GetInt()
    local plys = player.GetAll()
    local ti = 1

    while(not table.IsEmpty(plys)) do
        plys[1]:SetTeam(ti)
        table.remove(plys, 1)
        ti = ti % nt + 1
    end
end

function BOMB:RemoveTeam(teamindex)
    BOMB:DelTeamSpawns(teamindex)
    for _, ply in pairs(team.GetPlayers(teamindex)) do BOMB:MakeSpectator(ply) end
end

function GM:PlayerShouldTakeDamage(ply, attacker)
    if BOMB_TEAMKILL:GetBool() or (ply:Team() ~= attacker:Team()) then return true
    else return false
    end
end
