local function ChangePlayerModel(ply)
    --ply:SetModel("models/player/police.mdl")
    local pms = player_manager.AllValidModels()
    local validpms = {}
    for pmk, pmv in pairs(pms) do
        if string.match(pmk, "male") or string.match(pmk, "police") or string.match(pmv, "monk") then table.insert(validpms, pmv) end
    end
    local pmv, pmk = table.Random(validpms)
    ply:SetModel(pmv)
end

local function ChangePlayerColor(ply, pteam)
    -- thanks to https://github.com/TheOnly8Z/sbtm/blob/master/lua/sbtm/sh_util.lua
    local pcolor = team.GetColor(pteam)
    local pcolorv =  Vector(pcolor.r/255, pcolor.g/255, pcolor.b/255)
    ply:SetPlayerColor(pcolorv)
end

function GM:PlayerInitialSpawn(ply)
    ply:AllowFlashlight(true)
    ply:ShouldDropWeapon(true)
    
    BOMB:SelectTeam(ply)
    
    ChangePlayerModel(ply)
end

function GM:PlayerSpawn(ply)
    ply:SetupHands()
    ply:SetWalkSpeed(300)
    ply:SetRunSpeed(400)
    ply:SetJumpPower(200)

    ply:StripWeapons()
    ply:StripAmmo()

    if (ply:Team() >= 1) and (ply:Team() <= 4) then
        ply:GodDisable()
        ply:SetColor()

        ply:Give("weapon_smg1")
        ply:Give("weapon_physcannon")
        ply:Give("weapon_crowbar")
        ply:GiveAmmo(100, "SMG1")
        ply:GiveAmmo(3, "SMG1_Grenade")

        ChangePlayerColor(ply, ply:Team())
    end
end

function GM:PlayerChangedTeam(ply, oldteam, newteam)
    ChangePlayerColor(ply, newteam)
    if newteam ~= TEAM_SPECTATOR then ply:SendLua([[chat.AddText(team.GetColor(]]..newteam..[[), "team "..team.GetName(]]..newteam..[[))]]) end
end

function GM:PlayerSelectSpawn(ply)
    local validspawns = BOMB:GetTeamSpawns()[ply:Team()]
    
    return validspawns[math.random(1, #validspawns)]
end

function BOMB:MakeSpectator(ply)
    ply:SetTeam(TEAM_SPECTATOR)
    ply:GodEnable()
    ply:SetColor(Color(0, 0, 0, 0))
    ply:SetRenderMode(RENDERMODE_TRANSCOLOR)
    ply:Spawn()
end