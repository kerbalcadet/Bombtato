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
    --init
    
    bspawns = {}
    tspawns = {}
    local spawns = ents.FindByClass("info_player_*")
    local sn = BOMB_NUMTEAMS:GetInt()

    for i=1, sn do
        local n = math.random(1, #spawns)
        local s = spawns[n]

        table.insert(bspawns, s)
    end

    --distribute bombs

    for i = 1, 5 do
        if #spawns < BOMB_NUMTEAMS:GetInt() then break end

        for j = 1, #bspawns do
            local sortall = SortSpawns(bspawns[j], spawns)
            local sortbmb = SortSpawns(bspawns[j], bspawns)
            local n = math.Round(#sortall/#bspawns + 1)

            table.insert(bspawns, sortall[n])
            table.remove(bspawns, table.KeyFromValue(bspawns, sortbmb[1]))
        end
    end
end

function BOMB:GetBombSpawns()
    return bspawns
end

function BOMB:GetTeamSpawns()
    return tspawns
end