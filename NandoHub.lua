local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "NandoHub"
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.fromOffset(280, 160)
frame.Position = UDim2.new(0.5, -140, 0.5, -80)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
frame.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 55)
title.BackgroundTransparency = 1
title.Text = "NANDO HUB"
title.TextColor3 = Color3.fromRGB(180, 120, 255)
title.TextSize = 24
title.Font = Enum.Font.GothamBold
title.Parent = frame

gui.Parent = player:WaitForChild("PlayerGui")
