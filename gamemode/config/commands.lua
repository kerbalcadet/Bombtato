CreateConVar("bomb_fuse", 60, FCVAR_NONE, "Initial bomb fuse in seconds")

cvars.AddChangeCallback("bomb_fuse", function(n, vo, vn)
    local num = tonumber(vn)
    if num then BOMB_FUSE = vn
    else
        print([[server cvar "bomb_fuse" can only be set to numeric values]]) 
        GetConVar("bomb_fuse"):SetInt(BOMB_FUSE)
    end
end)

CreateConVar("bomb_armtime", "3", FCVAR_NONE, "Time in seconds to arm or defuse")

cvars.AddChangeCallback("bomb_armtime", function(n, vo, vn)
    local num = tonumber(vn)
    if num then BOMB_ARMTIME = vn
    else
        print([[server cvar "bomb_armtime" can only be set to numeric values]]) 
        GetConVar("bomb_armtime"):SetInt(BOMB_ARMTIME)
    end
end)