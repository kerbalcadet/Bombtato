function GM:PlayerInitialSpawn(ply)
    ply:SetTeam(math.random(1, 4))
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

    ply:SendLua([[chat.AddText(team.GetColor(]]..pteam..[[), "team "..team.GetName(]]..pteam..[[))]])
end
