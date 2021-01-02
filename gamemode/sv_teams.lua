local teams = {}

function BOMB:GetTeams() return teams end

function BOMB:InitTeams()
    table.Empty(teams)
    
    local nt = BOMB_NUMTEAMS:GetInt()
    local allteams = {1, 2, 3, 4}

    for i = 1, nt do
        local ti = math.random(1, #allteams)
        local t = allteams[ti]

        table.insert(teams, t)
        table.remove(allteams, ti)
    end
end

function BOMB:SelectTeam(ply)
    local nt = BOMB_NUMTEAMS:GetInt()
    local plys = player.GetAll()
    local ti = 1

    while(not table.IsEmpty(plys)) do
        plys[1]:SetTeam(teams[ti])
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
