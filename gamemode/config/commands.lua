local function CVValid(inp, cvar, gvar)
    local num = tonumber(inp)
    if num then return num
    else
        print("server cvar "..cvar.." can only be set to numeric values") 
        return gvar
    end
end

CreateConVar("bomb_fuse", 60, FCVAR_NONE, "Initial bomb fuse in seconds", 1)

cvars.AddChangeCallback("bomb_fuse", function(n, vo, vn)
    BOMB_FUSE = CVValid(vn, "bomb_fuse", BOMB_FUSE)
end)

CreateConVar("bomb_armtime", "3", FCVAR_NONE, "Time in seconds to arm or defuse", 0.5)

cvars.AddChangeCallback("bomb_armtime", function(n, vo, vn)
    BOMB_ARMTIME = CVValid(vn, "bomb_armtime", BOMB_ARMTIME)
end)

CreateConVar("bomb_dmgrad", "500", FCVAR_NONE, "Radius in units of bomb explosion", 0)

cvars.AddChangeCallback("bomb_dmgrad", function(n, vo, vn)
    BOMB_DMGRAD = CVValid(vn, "bomb_dmgrad", BOMB_DMGRAD)
end)

CreateConVar("bomb_notify", "1", FCVAR_NONE, "Notify team when bomb armed", 0, 1)

cvars.AddChangeCallback("bomb_notify", function(n, vo, vn)
    BOMB_NOTIFY = CVValid(vn, "bomb_notify", BOMB_NOTIFY)
end)

CreateConVar("bomb_team_arm", "0", FCVAR_NONE, "Allow bomb to be armed by own team", 0, 1)

cvars.AddChangeCallback("bomb_team_arm", function(n, vo, vn)
    BOMB_TEAM_ARM = CVValid(vn, "bomb_team_arm", BOMB_TEAM_ARM)
end)

concommand.Add("bomb_restart", function(ply, cmd, args)
    End()
end)

concommand.Add("bomb_teamchange", function(ply) --TEMP
    local curteam = ply:Team()

    repeat
        curteam = math.random(1, 4)
    until(curteam ~= ply:Team())

    ply:SetTeam(curteam)
end)