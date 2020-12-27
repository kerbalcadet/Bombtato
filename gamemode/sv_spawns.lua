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
        local curspi = table.KeyFromValue(spawns, dtable[math.floor(#dtable/(i - 1))])

        table.insert(bspawns, spawns[curspi])
        table.remove(spawns, curspi)
    end

    local ti = 1
    while(not table.IsEmpty(spawns)) do
        if not tspawns[ti] then tspawns[ti] = {} end
        dtable = SortSpawns(bspawns[ti], spawns)
        table.insert(tspawns[ti], dtable[1])
        table.remove(spawns, table.KeyFromValue(spawns, dtable[1]))
        ti = ti % nt + 1
    end
end

function BOMB:DebugSpawns()
    -- spawn a colored monolith at each valid team spawn with the color of the team allowed to use it
    local tsp = BOMB:GetTeamSpawns()

    for _, spawn in pairs(ents.FindByClass("info_player_*")) do
        if not table.HasValue(bspawns, spawn) then
            local spmdl = ents.Create("prop_physics")
            spmdl:PhysicsInit(SOLID_NONE)
            spmdl:SetCollisionGroup(COLLISION_GROUP_WORLD)
            spmdl:SetPos(spawn:GetPos())
            spmdl:SetModel("models/props_wasteland/medbridge_post01.mdl")
            spmdl:SetMaterial("models/debug/debugwhite")

            for i = 1, #tsp do
                for j = 1, #(tsp[i]) do
                    if tsp[i][j] == spawn then spmdl:SetColor(team.GetColor(i)) break end
                end
            end
            
            spmdl:Spawn()
        end
    end
end

function BOMB:GetBombSpawns()
    return bspawns
end

function BOMB:GetTeamSpawns()
    return tspawns
end