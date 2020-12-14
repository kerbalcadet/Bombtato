local activeteams = {}

function BOMB:SelectTeam(ply)
    for i = 1, BOMB_NUMTEAMS:GetInt() do
        if (team.NumPlayers(1) == team.NumPlayers(BOMB_NUMTEAMS:GetInt())) or (team.NumPlayers(i) < team.NumPlayers(i - 1)) then ply:SetTeam(i) break end
    end
end