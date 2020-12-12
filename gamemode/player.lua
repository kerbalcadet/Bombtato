local function SelectTeam(ply)
    for k, v in pairs(ACTIVETEAMS) do
        if team.NumPlayers(ACTIVETEAMS[1]) == team.NumPlayers(ACTIVETEAMS[#ACTIVETEAMS]) or (team.NumPlayers(v) < team.NumPlayers(v - 1)) then ply:SetTeam(v) break end
    end
end

function GM:PlayerInitialSpawn(ply)
    SelectTeam(ply)
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

    local pteam = ply:Team()
    if not table.HasValue(ACTIVETEAMS, pteam) then
        SelectTeam(ply)
        pteam = ply:Team()
    end

    ply:SetModel("models/player/police.mdl")
    -- thanks to https://github.com/TheOnly8Z/sbtm/blob/master/lua/sbtm/sh_util.lua
    local pcolor = team.GetColor(pteam)
    local pcolorv =  Vector(pcolor.r/255, pcolor.g/255, pcolor.b/255)
    ply:SetPlayerColor(pcolorv)
    
    ply:SendLua([[chat.AddText(team.GetColor(]]..pteam..[[), "team "..team.GetName(]]..pteam..[[))]])
end
