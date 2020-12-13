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

    if #bombs <= 1 then End(bombs[1]:GetTeam()) return end

    table.remove(bombs, table.KeyFromValue(bombs, bomb))
    if #bombs <= 1 then End(bombs[1]:GetTeam()) end
end

function BOMB:EmptyBombs() table.Empty(bombs) end

function BOMB:GetBombs() return bombs end
