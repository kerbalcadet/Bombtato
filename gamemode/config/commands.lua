BOMB_FUSE = CreateConVar("bomb_fuse", 60, FCVAR_NONE, "Initial bomb fuse in seconds", 1)

BOMB_ARMTIME = CreateConVar("bomb_armtime", "3", FCVAR_NONE, "Time in seconds to arm or defuse", 0.5)
BOMB_DMGRAD = CreateConVar("bomb_dmgrad", "500", FCVAR_NONE, "Radius in units of bomb explosion", 0)
BOMB_NOTIFY = CreateConVar("bomb_notify", "1", FCVAR_NONE, "Notify team when bomb armed", 0, 1)
BOMB_TEAM_ARM = CreateConVar("bomb_team_arm", "0", FCVAR_NONE, "Allow bomb to be armed by own team", 0, 1)
BOMB_NUMTEAMS = CreateConVar("bomb_numteams", "4", FCVAR_NONE, "Number of teams", 2, 4)
BOMB_DBG_SPAWNS = CreateConVar("bomb_dbgspawns", "0", FCVAR_NONE, "Debug team spawn locations", 0, 1)

concommand.Add("bomb_restart", function(ply, cmd, args)
    BOMB:End()
end)

concommand.Add("bomb_teamchange", function(ply) --TEMP
    local curteam = ply:Team()

    repeat
        curteam = math.random(1, BOMB_NUMTEAMS:GetInt())
    until((curteam ~= ply:Team()) and (not table.IsEmpty(BOMB:GetTeamSpawns()[curteam])))

    ply:SetTeam(curteam)
end)