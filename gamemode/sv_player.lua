function GM:PlayerInitialSpawn(ply)
    BOMB:SelectTeam(ply)
end

function GM:PlayerSpawn(ply)
    ply:SetupHands()
    ply:SetWalkSpeed(300)
    ply:SetRunSpeed(400)
    ply:SetJumpPower(200)

    ply:Give("weapon_smg1")
    ply:Give("weapon_physcannon")
    ply:Give("weapon_crowbar")
    ply:GiveAmmo(100, "SMG1")

    --ply:SetModel("models/player/police.mdl")
    local pms = player_manager.AllValidModels()
    local validpms = {}
    for pmk, pmv in pairs(pms) do
        if string.match(pmk, "male") or string.match(pmk, "police") then table.insert(validpms, pmv) end
    end
    local pmv, pmk = table.Random(validpms)
    ply:SetModel(pmv)

    -- thanks to https://github.com/TheOnly8Z/sbtm/blob/master/lua/sbtm/sh_util.lua
    local pteam = ply:Team()
    local pcolor = team.GetColor(pteam)
    local pcolorv =  Vector(pcolor.r/255, pcolor.g/255, pcolor.b/255)
    ply:SetPlayerColor(pcolorv)
    
    ply:SendLua([[chat.AddText(team.GetColor(]]..pteam..[[), "team "..team.GetName(]]..pteam..[[))]])
end
