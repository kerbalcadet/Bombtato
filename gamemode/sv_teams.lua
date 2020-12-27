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