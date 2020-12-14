include("shared.lua")

function ENT:Draw()
    self:DrawModel()

    local Ang = self:GetAngles()
    Ang:RotateAroundAxis(Ang:Up(), 90)
    Ang:RotateAroundAxis(Ang:Forward(), 90)
    local Pos = self:GetPos()
    local Border = 8

    surface.SetFont("FONT")
    local Fuse = self:GetFuse()
    local FW = surface.GetTextSize(Fuse)

    surface.SetFont("FONTSMALL")
    local Sameteam = LocalPlayer():Team() == self:GetTeam()
    local Armed = self:GetArmed()
    local AStr = ""
    if Sameteam then 
        AStr = Armed and "Hold E to defuse" or "Safe!"
    else AStr = Armed and "Armed!" or "Hold E to arm" end
    local AW = surface.GetTextSize(AStr)

    cam.Start3D2D(Pos + self:GetForward()*20 + self:GetUp()*15, Ang, 0.1)
        draw.WordBox(Border, -FW/2 - Border, 0, Fuse, "FONT", Color(25, 25, 25, 20), Color(255, 255, 255, 255))
        draw.WordBox(Border, -AW/2 - Border, 115, AStr, "FONTSMALL", Color(25, 25, 25, 20), Color(255, 255, 255, 255))
    cam.End3D2D()
end