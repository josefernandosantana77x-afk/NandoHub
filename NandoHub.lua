local Players = game:GetService("Players")
local player = Players.LocalPlayer

local old = player.PlayerGui:FindFirstChild("NandoHub")
if old then
    old:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "NandoHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = player:WaitForChild("PlayerGui")

local purple = Color3.fromRGB(160, 75, 255)
local dark = Color3.fromRGB(17, 15, 25)
local card = Color3.fromRGB(29, 24, 40)
local white = Color3.fromRGB(245, 240, 255)
local muted = Color3.fromRGB(175, 162, 195)

local function round(obj, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = obj
end

local function outline(obj, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.Transparency = 0.15
    s.Parent = obj
end

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 290, 0, 235)
main.Position = UDim2.new(0.5, -145, 0.5, -117)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Parent = gui
round(main, 14)
outline(main, purple, 1.5)

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 68)
top.BackgroundColor3 = card
top.BorderSizePixel = 0
top.Parent = main
round(top, 14)

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(15, 8)
title.Size = UDim2.new(1, -30, 0, 30)
title.BackgroundTransparency = 1
title.Text = "⚡ NANDO HUB"
title.TextColor3 = white
title.Font = Enum.Font.GothamBold
title.TextSize = 22
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(17, 39)
subtitle.Size = UDim2.new(1, -34, 0, 18)
subtitle.BackgroundTransparency = 1
subtitle.Text = "PROJECT DELTA  •  VERSION 2"
subtitle.TextColor3 = purple
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = top

local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(15, 82)
status.Size = UDim2.new(1, -30, 0, 38)
status.BackgroundColor3 = card
status.Text = "  ✦  Nando Hub iniciado!"
status.TextColor3 = white
status.Font = Enum.Font.Gotham
status.TextSize = 13
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = main
round(status, 8)

local button = Instance.new("TextButton")
button.Position = UDim2.fromOffset(15, 132)
button.Size = UDim2.new(1, -30, 0, 42)
button.BackgroundColor3 = purple
button.Text = "TESTAR PAINEL"
button.TextColor3 = white
button.Font = Enum.Font.GothamBold
button.TextSize = 14
button.AutoButtonColor = true
button.Parent = main
round(button, 9)

button.Activated:Connect(function()
    status.Text = "  ✓  Interface funcionando!"
end)

local footer = Instance.new("TextLabel")
footer.Position = UDim2.new(0, 0, 1, -26)
footer.Size = UDim2.new(1, 0, 0, 18)
footer.BackgroundTransparency = 1
footer.Text = "NANDO HUB  •  MOBILE"
footer.TextColor3 = muted
footer.Font = Enum.Font.Gotham
footer.TextSize = 10
footer.Parent = main
