GM.Name = "Bombtato"
GM.Author = "rocketpanda40"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("sandbox")

hook.Add("CreateTeams", "BOMB", function()
    local p = 250
    local s = 75

    team.SetUp(1, "Red", Color(p, s, s), 1)
    team.SetUp(2, "Blue", Color(s, s, p), 1)
    team.SetUp(3, "Green", Color(s, p, s), 1)
    team.SetUp(4, "Yellow", Color(p, p, s), 1)
end)

BOMB = GM