local activeteams = {}

hook.Add("CreateTeams", "BOMB", function()
    local p = 250
    local s = 75

    team.SetUp(1, "Red", Color(p, s, s), 1)
    team.SetUp(2, "Blue", Color(s, s, p), 1)
    team.SetUp(3, "Green", Color(s, p, s), 1)
    team.SetUp(4, "Yellow", Color(p, p, s), 1)
end)

function BOMB:SelectTeam(ply)
    for i = 1, BOMB_NUMTEAMS do
        if (team.NumPlayers(1) == team.NumPlayers(BOMB_NUMTEAMS)) or (team.NumPlayers(i) < team.NumPlayers(i - 1)) then ply:SetTeam(i) break end
    end
end