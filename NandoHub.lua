-- NANDO HUB V5 | Vampire Life Edition
-- Protótipo de interface para Roblox Studio
-- Coloque como LocalScript em StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "NandoHubV5"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(280, 320)
main.Position = UDim2.new(0.5, -140, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(15, 12, 28)
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(170, 50, 255)
stroke.Thickness = 2
stroke.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 48)
title.BackgroundTransparency = 1
title.Text = "NANDO HUB V5"
title.TextColor3 = Color3.fromRGB(210, 100, 255)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 8)
layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Parent = main

title.LayoutOrder = 0

local function addButton(label, order, callback)
    local button = Instance.new("TextButton")
    button.Name = label:gsub("%s+", "")
    button.Size = UDim2.new(0.88, 0, 0, 38)
    button.BackgroundColor3 = Color3.fromRGB(40, 24, 62)
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Text = label
    button.TextScaled = true
    button.Font = Enum.Font.GothamMedium
    button.LayoutOrder = order
    button.Parent = main

    local round = Instance.new("UICorner")
    round.CornerRadius = UDim.new(0, 8)
    round.Parent = button

    button.Activated:Connect(function()
        callback(button)
    end)
end

local states = {}

local function addToggle(name, order)
    states[name] = false

    addButton(name .. ": OFF", order, function(button)
        states[name] = not states[name]
        button.Text = name .. (states[name] and ": ON" or ": OFF")
    end)
end

addToggle("Auto Farm NPC", 1)
addToggle("Farm Hunters", 2)
addToggle("Farm Lobos", 3)
addToggle("Speed Farm", 4)
addToggle("Speed Orb", 5)

addButton("FECHAR MENU", 6, function()
    gui.Enabled = false
end)
