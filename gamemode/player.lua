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

    -- ply:SetTeam(math.random(1, 4))
    local pteam = ply:Team()
    if not table.HasValue(ACTIVETEAMS, pteam) then
        SelectTeam(ply)
        pteam = ply:Team()
    end

    ply:SendLua([[chat.AddText(team.GetColor(]]..pteam..[[), "team "..team.GetName(]]..pteam..[[))]])
end
