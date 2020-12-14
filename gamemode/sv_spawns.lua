local bspawns = {}
local tspawns = {}

function BOMB:InitSpawns()
    bspawns = {}
    tspawns = {}
    local spawns = ents.FindByClass("info_player_*")
    local sn = BOMB_NUMTEAMS:GetInt()

    for i=1, sn do
        local n = math.random(1, #spawns)
        local s = spawns[n]

        table.insert(bspawns, s)
        table.remove(spawns, n)
        s.bteam = i
    end

    PrintTable(bspawns)
end

function BOMB:GetBombSpawns()
    return bspawns
end

function BOMB:GetTeamSpawns()
    return tspawns
end