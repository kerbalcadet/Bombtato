GM.Name = "Bombtato"
GM.Author = "rocketpanda40"
GM.Email = "N/A"
GM.Website = "N/A"

DeriveGamemode("base")

function GM:Initialize()
    self.BaseClass.Initialize(self)
end

team.SetUp(1, "Red", Color(255, 50, 50), 1)
team.SetUp(2, "Blue", Color(50, 50, 255), 1)
team.SetUp(3, "Green", Color(50, 255, 50), 1)
team.SetUp(4, "Yellow", Color(255, 255, 0), 1)
