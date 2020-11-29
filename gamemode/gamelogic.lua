local bombs = {}
    
function AddBomb(bomb)
    table.insert(bombs, bomb)
end

function DelBomb(bomb)
    table.remove(bombs, table.KeyFromValue(bombs, bomb))
    if #bombs == 1 then End(bombs[1].team) end
end

function End(team)
    if team then PrintMessage(4, team.." has won!")
    else PrintMessage(4, "Round ended") end

    table.Empty(bombs)
    game.CleanUpMap(false)
end

function PrintBombs()               --TEMP
    print(table.ToString(bombs))
end