function BOMB:InitTeams()
    local colors = {}

    for i = 1, BOMB_NUMTEAMS:GetInt() do
        repeat
            color = GetRandomColor()
        until(not table.HasValue(colors, color))

        table.insert(colors, color)

        team.SetUp(i, color[1], color[2], true)
    end
end

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
