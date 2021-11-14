local bspawns = {}
local tspawns = {}
local dbgspawns = {}

local function SortSpawns(bomb, spawns)
    local tbl, dists = spawns, {}

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

-- many maps don't have enough spawns to 'spread the wealth' among bombs and spawns for every team
-- others (e.g. CS maps) are only two sided and ends up with pairs (or more) of bomb and team spawns right next to each other
-- without making custom spawns manually, we can instead use all walkable parts of the map as potential spawns, identified by the CNavAreas (from the NAV mesh)
-- of course, generally there are multiple-thousand CNavAreas, so we want to cull them quite a bit. ~20 spawns a team seems good, no?
-- there are other issues with inaccessible areas being marked as walkable in less-developed nav meshes that will need to be solved, but this is a start
-- also need to work out how to properly angle the bombs when spawned, and more importantly, ensure they are not blocking key traversal areas (e.g. being placed in
-- in the middle of staircases as seen in gm_devtown)
local function GetPotentialSpawns(nt)
    local navareas, spawns = navmesh.GetAllNavAreas(), {}
    
    for _, na in pairs(navareas) do
        if (na:GetAdjacentCount() > 1) and (not na:IsUnderwater()) then table.insert(spawns, na) end
    end

    table.CopyFromTo(spawns, navareas)
    table.Empty(spawns)

    local tracer = math.ceil(#navareas / (nt*20))

    for i, na in pairs(navareas) do
        if i % tracer == 0 then
            local newspawn = ents.Create("info_player_start")
            newspawn:SetPos(na:GetCenter())
            newspawn:DropToFloor()
            newspawn:Spawn()
            table.insert(spawns, newspawn)
        end
    end

    return spawns
end

function BOMB:InitSpawns()
    -- init
    math.randomseed(CurTime())

    table.Empty(bspawns)
    table.Empty(tspawns)
    table.Empty(dbgspawns)
    -- end init

    local nt = BOMB_NUMTEAMS:GetInt()
    local spawns = GetPotentialSpawns(nt)
    
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

    for _, ent in pairs(ents.FindByClass( "info_player_*" )) do 
        if ent:CreatedByMap() then ent:Remove() end
    end
end

function BOMB:DebugSpawns()
    local spmdls = ents.FindByClass("bt_dbg_sp")

    if(#spmdls > 0) then
        -- delete debug spawn models
        for _, spmdl in pairs(spmdls) do spmdl:Remove() end
    else
        local tsp = BOMB:GetTeamSpawns()
        
        for i = 1, BOMB_NUMTEAMS:GetInt(), 1 do
            dbgspawns[i] = {}

            for _, sp in pairs(tsp[i]) do
                local spmdl = ents.Create("bt_dbg_sp")
                spmdl:SVSpawn(sp, i)
                table.insert(dbgspawns[i], spmdl)
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
    if not table.IsEmpty(dbgspawns[teamindex]) then
        for _, spmdl in pairs(dbgspawns[teamindex]) do
            spmdl:Remove()
        end
        table.Empty(dbgspawns[teamindex]) -- same story here as ^
    end
end