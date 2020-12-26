local bspawns = {}
local tspawns = {}

local function SortSpawns(bomb, spawns)
    local tbl = spawns
    local dists = {}
    for k, v in pairs(spawns) do
       dists[v] = (v:GetPos() - bomb:GetPos()):LengthSqr()     
    end
    
    table.sort(tbl, function(a, b) return dists[a] < dists[b] end)
    return tbl
end

function BOMB:InitSpawns()
    table.Empty(bspawns)
    table.Empty(tspawns)

    local spawns = ents.FindByClass("info_player_*")
    local nt = BOMB_NUMTEAMS:GetInt()
    local spi = math.random(1, #spawns)
    local sp = spawns[spi]

    table.insert(bspawns, sp)
    table.remove(spawns, spi)

    local dtable = SortSpawns(bspawns[1], spawns)

    for i = 2, nt do
        local curspi = table.KeyFromValue(spawns, dtable[#dtable/(i - 1)])

        table.insert(bspawns, spawns[curspi])
        table.remove(spawns, curspi)
    end

    for i = 1, nt do
        dtable = SortSpawns(bspawns[i], spawns)

        for i = 1, #dtable/nt do
            -- placeholder to distribute tspawns
        end
    end
end

function BOMB:GetBombSpawns()
    return bspawns
end

function BOMB:GetTeamSpawns()
    return tspawns
end