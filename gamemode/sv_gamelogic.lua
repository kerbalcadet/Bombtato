local gameover = false

function BOMB:GameOver() return gameover end

function BOMB:Start()
    BOMB:InitSpawns()
    BOMB:SpawnBombs()

    for _, ply in pairs(player.GetAll()) do
        BOMB:SelectTeam(ply)
        ply:Spawn()
    end

    gameover = false
end

function BOMB:End(teamindex)
    if teamindex then PrintMessage(4, team.GetName(teamindex).." has won!")
    else PrintMessage(4, "Round ended") end

    gameover = true

    timer.Simple(10, function()
        BOMB:EmptyBombs()

        game.CleanUpMap(false)

        for _, ply in pairs(player.GetAll()) do ply:SetTeam(TEAM_SPECTATOR) end
        BOMB:Start()
    end)
end