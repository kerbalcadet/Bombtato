local teams = {}

function BOMB:GetTeams() return teams end

function BOMB:InitTeams()
    table.Empty(teams)
    
    local allteams, colors = {}, {}
    local nt = BOMB_NUMTEAMS:GetInt()

    for i = 1, nt do
        table.insert(allteams, i)

        repeat
            color = GetRandomColor()
        until(not table.HasValue(colors, color))

        table.insert(colors, color)

        team.SetUp(i, color[1], color[2], true)
    end

    for i = 1, nt do
        local ti = math.random(#allteams)
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
