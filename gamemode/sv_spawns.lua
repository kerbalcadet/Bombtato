local bspawns = {}
local tspawns = {}
local dbgspawns = {}

local function SortSpawns(bomb, spawns)
    local tbl = spawns
    local dists = {}
    for k, v in pairs(spawns) do
       dists[v] = (v:GetPos() - bomb:GetPos()):LengthSqr()     
    end
    
    table.sort(tbl, function(a, b) return dists[a] < dists[b] end)
    return tbl
end

local function GetFurthestSpawn(spawns, bombs)
    local maxdist, maxindex = 0, 1

    for spindex, spawn in pairs(spawns) do
        local dist = 0

        for _, bomb in pairs(bombs) do
            dist = dist + bomb:GetPos():Distance(spawn:GetPos())
        end

        if dist > maxdist then
            maxdist = dist
            maxindex = spindex
        end
    end

    return maxindex
end

function BOMB:InitSpawns()
    -- init
    table.Empty(bspawns)
    table.Empty(tspawns)
    table.Empty(dbgspawns)

    local spawns = ents.FindByClass("info_player_*")
    local nt = BOMB_NUMTEAMS:GetInt()
    -- end init

    -- set bomb spawns
    for i = 1, nt do
        local rti = BOMB:GetTeams()[i]
        local spi, sp

        if table.IsEmpty(bspawns) then
            spi = math.random(1, #spawns)
        else
            spi = GetFurthestSpawn(spawns, bspawns)
        end

        sp = spawns[spi]
        
        --table.insert(bspawns, rti, sp)
        bspawns[rti] = sp
        table.remove(spawns, spi)
    end
    -- end set bomb spawns

    -- set spectator spawns (all but bomb spawns)
    table.insert(tspawns, TEAM_SPECTATOR, {})
    for _, spawn in pairs(spawns) do table.insert(tspawns[TEAM_SPECTATOR], spawn) end
    -- end set spectator spawns

    -- set team spawns
    local ti = 1

    while(not table.IsEmpty(spawns)) do
        local rti = BOMB:GetTeams()[ti]
        local dtable = SortSpawns(bspawns[rti], spawns)
                
        if not tspawns[rti] then tspawns[rti] = {} end
        
        table.insert(tspawns[rti], dtable[1])
        table.remove(spawns, table.KeyFromValue(spawns, dtable[1]))

        ti = ti % nt + 1
    end
    -- end set team spawns
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
                local rti = BOMB:GetTeams()[i]

                if not dbgspawns[rti] then dbgspawns[rti] = {} end
                for j = 1, #(tsp[rti]) do
                    if tsp[rti][j] == spawn then
                        spmdl:SetColor(team.GetColor(rti))
                        table.insert(dbgspawns[rti], spmdl)
                        break
                    end
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

function BOMB:DelTeamSpawns(teamindex)
    table.Empty(tspawns[teamindex]) -- we don't actually remove the table, because that shifts the other team spawn tables by index and messes up the other teams' spawnpoints
    if BOMB_DBG_SPAWNS:GetBool() then
        for _, spmdl in pairs(dbgspawns[teamindex]) do
            spmdl:Remove()
        end
        table.Empty(dbgspawns[teamindex]) -- same story here as ^
    end
end