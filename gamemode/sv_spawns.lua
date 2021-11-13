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
    --for _, ent in pairs(ents.FindByClass( "info_player_*" )) do ent:Remove() end

    -- init
    table.Empty(bspawns)
    table.Empty(tspawns)
    table.Empty(dbgspawns)

    -- new junk
    -- many maps don't have enough spawns to 'spread the wealth' among bombs and spawns for every team
    -- others (e.g. CS maps) are only two sided and ends up with pairs (or more) of bomb and team spawns right next to each other
    -- without making custom spawns manually, we can instead use all walkable parts of the map as potential spawns, identified by the CNavAreas (from the NAV mesh)
    -- of course, generally there are multiple-thousand CNavAreas, so we want to cull them quite a bit. ~20 spawns a team seems good, no?
    -- there are other issues with inaccessible areas being marked as walkable in less-developed nav meshes that will need to be solved, but this is a start
    -- also need to work out how to properly angle the bombs when spawned, and more importantly, ensure they are not blocking key traversal areas (e.g. being placed in
    -- in the middle of staircases as seen in gm_devtown)
    local navareas, spawns = navmesh.GetAllNavAreas(), {}
    local maxspawns = BOMB_NUMTEAMS:GetInt()*20
    local tracer = math.ceil(#navareas/maxspawns)

    for i, na in ipairs(navareas) do
        if i % tracer == 0 and na:GetAdjacentCount() > 1 then
            local newspawn = ents.Create("info_player_start")
            newspawn:SetPos(na:GetCenter())
            newspawn:DropToFloor()
            newspawn:Spawn()
            table.insert(spawns, newspawn)
        end
    end
    -- end new junk

    math.randomseed(CurTime())
    local nt = BOMB_NUMTEAMS:GetInt()
    local spi = math.random(1, #spawns)
    local sp = spawns[spi]
    -- end init

    -- set bomb spawns
    table.insert(bspawns, sp)
    table.remove(spawns, spi)

    local dtable = SortSpawns(bspawns[1], spawns)

    for i = 2, nt do
        local curspi = GetFurthestSpawn(spawns, bspawns)

        table.insert(bspawns, spawns[curspi])
        table.remove(spawns, curspi)
    end
    -- end set bomb spawns

    -- set spectator spawns (all but bomb spawns)
    table.insert(tspawns, TEAM_SPECTATOR, {})
    for _, spawn in pairs(spawns) do table.insert(tspawns[TEAM_SPECTATOR], spawn) end
    -- end set spectator spawns

    -- set team spawns
    local ti = 1
    while(not table.IsEmpty(spawns)) do
        if not tspawns[ti] then tspawns[ti] = {} end
        dtable = SortSpawns(bspawns[ti], spawns)
        table.insert(tspawns[ti], dtable[1])
        table.remove(spawns, table.KeyFromValue(spawns, dtable[1]))
        ti = ti % nt + 1
    end
    -- end set team spawns
end

function BOMB:DebugSpawns()
    local spmdls = ents.FindByClass("bt_dbg_sp")

    if(#spmdls > 0) then
        -- delete debug spawn models
        for _, spmdl in pairs(spmdls) do spmdl:Remove() end
    else
        local tsp = BOMB:GetTeamSpawns()
        
        for i = 1, BOMB_NUMTEAMS:GetInt(), 1 do
            for _, sp in pairs(tsp[i]) do
                local spmdl = ents.Create("bt_dbg_sp")
                spmdl:SVSpawn(sp, i)
            end
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