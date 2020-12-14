local bombs = {}

function BOMB:AddBomb(bomb)
    table.insert(bombs, bomb)
end

function BOMB:DelBomb(bomb)
    local tmp = {}
    for k, v in pairs(bombs) do
        if IsValid(v) then table.insert(tmp, v) end
    end
    bombs = tmp

    if #bombs <= 1 then BOMB:End(bombs[1]:GetTeam()) return end

    table.remove(bombs, table.KeyFromValue(bombs, bomb))
    if #bombs <= 1 then BOMB:End(bombs[1]:GetTeam()) end
end

function BOMB:EmptyBombs() table.Empty(bombs) end

function BOMB:GetBombs() return bombs end

function BOMB:SpawnBombs()
    for i = 1, BOMB_NUMTEAMS:GetInt() do
        local spawn = BOMB:GetBombSpawns()[i]
        if not spawn then print("could not find spawn for spawn #"..i) end

        local bomb = ents.Create("bt_bomb")
        bomb:SVSpawn(spawn, i)
    end
end