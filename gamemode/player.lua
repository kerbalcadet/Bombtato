function GM:PlayerInitialSpawn(ply)
    ply:SetTeam(math.Rand(1, 4))
end

function GM:PlayerSpawn(ply)
    ply:SetupHands()
    ply:SetWalkSpeed(300)
    ply:SetRunSpeed(500)
    ply:SetJumpPower(200)

    ply:Give("weapon_smg1")
    ply:Give("weapon_physcannon")
    ply:Give("weapon_crowbar")
    ply:GiveAmmo(100, "SMG1")

    ply:SendLua([[chat.AddText(team.GetColor(ply:Team()), "team "..team.GetName(ply:Team()))]])
end
