CreateConVar("bomb_fuse", 60, FCVAR_NONE, "Initial bomb fuse in seconds", 1)

cvars.AddChangeCallback("bomb_fuse", function(n, vo, vn)
    local num = tonumber(vn)
    if num then BOMB_FUSE = num
    else
        print([[server cvar "bomb_fuse" can only be set to numeric values]]) 
        GetConVar("bomb_fuse"):SetInt(BOMB_FUSE)
    end
end)

CreateConVar("bomb_armtime", "3", FCVAR_NONE, "Time in seconds to arm or defuse", 0.5)

cvars.AddChangeCallback("bomb_armtime", function(n, vo, vn)
    local num = tonumber(vn)
    if num then BOMB_ARMTIME = num
    else
        print([[server cvar "bomb_armtime" can only be set to numeric values]]) 
        GetConVar("bomb_armtime"):SetInt(BOMB_ARMTIME)
    end
end)

CreateConVar("bomb_dmgrad", "500", FCVAR_NONE, "Radius in units of bomb explosion", 0)

cvars.AddChangeCallback("bomb_dmgrad", function(n, vo, vn)
    local num = tonumber(vn)
    if num then BOMB_DMGRAD = num
    else
        print([[server cvar "bomb_dmgrad" can only be set to numeric values]]) 
        GetConVar("bomb_dmgrad"):SetInt(BOMB_ARMTIME)
    end
end)

concommand.Add("bomb_restart", function(ply, cmd, args)
    End()
end)