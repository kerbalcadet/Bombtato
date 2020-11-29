GAME_ENDED = false

local bombs = {}
    
function AddBomb(bomb)
    table.insert(bombs, bomb)
end

function DelBomb(bomb)
    for k, v in pairs(bombs) do
        if not IsValid(v) then table.remove(bombs, k) end
    end
    if #bombs <= 1 then End(bombs[1].team) return end

    table.remove(bombs, table.KeyFromValue(bombs, bomb))
    if #bombs <= 1 then End(bombs[1].team) end
end

function End(team)
    if team then PrintMessage(4, team.." has won!")
    else PrintMessage(4, "Round ended") end

    GAME_ENDED = true

    timer.Simple(10, function()
        table.Empty(bombs)
        game.CleanUpMap(false)
        GAME_ENDED = false
    end)
end

function PrintBombs()               --TEMP
    print(table.ToString(bombs))
end