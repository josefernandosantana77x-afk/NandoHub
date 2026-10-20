
-- NANDO HUB V3
-- Interface para seu proprio jogo Roblox
-- LocalScript em StarterPlayerScripts

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("NandoHub")
if old then old:Destroy() end

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

local function outline(obj)
    local s = Instance.new("UIStroke")
    s.Color = purple
    s.Thickness = 1.5
    s.Transparency = 0.15
    s.Parent = obj
end

local gui = Instance.new("ScreenGui")
gui.Name = "NandoHub"
gui.ResetOnSpawn = false
gui.DisplayOrder = 999
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.fromOffset(290, 250)
main.Position = UDim2.new(0.5, -145, 0.5, -125)
main.BackgroundColor3 = dark
main.BorderSizePixel = 0
main.Parent = gui
round(main, 14)
outline(main)

-- Arrastar painel
local drag = Instance.new("UIDragDetector")
drag.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 68)
top.BackgroundColor3 = card
top.BorderSizePixel = 0
top.Parent = main
round(top, 14)

local title = Instance.new("TextLabel")
title.Position = UDim2.fromOffset(12, 7)
title.Size = UDim2.new(1, -58, 0, 30)
title.BackgroundTransparency = 1
title.Text = "⚡ NANDO HUB"
title.TextColor3 = white
title.Font = Enum.Font.GothamBold
title.TextSize = 21
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local subtitle = Instance.new("TextLabel")
subtitle.Position = UDim2.fromOffset(14, 39)
subtitle.Size = UDim2.new(1, -25, 0, 18)
subtitle.BackgroundTransparency = 1
subtitle.Text = "VERSION 3 • MOBILE"
subtitle.TextColor3 = purple
subtitle.Font = Enum.Font.GothamMedium
subtitle.TextSize = 10
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = top

local minimize = Instance.new("TextButton")
minimize.Size = UDim2.fromOffset(30, 30)
minimize.Position = UDim2.new(1, -38, 0, 10)
minimize.BackgroundColor3 = dark
minimize.Text = "−"
minimize.TextColor3 = white
minimize.TextSize = 22
minimize.Font = Enum.Font.GothamBold
minimize.Parent = top
round(minimize, 8)

local content = Instance.new("Frame")
content.Position = UDim2.fromOffset(10, 76)
content.Size = UDim2.new(1, -20, 1, -86)
content.BackgroundTransparency = 1
content.Parent = main

local tabBar = Instance.new("Frame")
tabBar.Size = UDim2.new(1, 0, 0, 34)
tabBar.BackgroundTransparency = 1
tabBar.Parent = content

local function makeTab(name, x)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(0.333, -4, 1, 0)
    b.Position = UDim2.new(x, 0, 0, 0)
    b.BackgroundColor3 = card
    b.Text = name
    b.TextColor3 = white
    b.TextSize = 11
    b.Font = Enum.Font.GothamBold
    b.Parent = tabBar
    round(b, 7)
    return b
end

local homeTab = makeTab("INICIO", 0)
local optionsTab = makeTab("OPCOES", 0.333)
local infoTab = makeTab("INFO", 0.666)

local page = Instance.new("Frame")
page.Position = UDim2.fromOffset(0, 42)
page.Size = UDim2.new(1, 0, 1, -42)
page.BackgroundColor3 = card
page.BorderSizePixel = 0
page.Parent = content
round(page, 9)

local status = Instance.new("TextLabel")
status.Position = UDim2.fromOffset(8, 8)
status.Size = UDim2.new(1, -16, 0, 36)
status.BackgroundTransparency = 1
status.Text = "Nando Hub iniciado!"
status.TextColor3 = white
status.TextSize = 12
status.Font = Enum.Font.Gotham
status.TextWrapped = true
status.Parent = page

local testButton = Instance.new("TextButton")
testButton.Position = UDim2.fromOffset(8, 48)
testButton.Size = UDim2.new(1, -16, 0, 34)
testButton.BackgroundColor3 = purple
testButton.Text = "TESTAR PAINEL"
testButton.TextColor3 = white
testButton.TextSize = 12
testButton.Font = Enum.Font.GothamBold
testButton.Parent = page
round(testButton, 8)

local minimized = false

minimize.Activated:Connect(function()
    minimized = not minimized
    content.Visible = not minimized
    main.Size = minimized
        and UDim2.fromOffset(290, 68)
        or UDim2.fromOffset(290, 250)
    minimize.Text = minimized and "+" or "−"
end)

testButton.Activated:Connect(function()
    status.Text = "Interface funcionando!"
end)

local function showPage(name)
    if name == "INICIO" then
        status.Text = "Bem-vindo ao NANDO HUB!"
        testButton.Visible = true
    elseif name == "OPCOES" then
        status.Text = "Opcoes da interface"
        testButton.Visible = false
    else
        status.Text = "NANDO HUB V3 | Mobile"
        testButton.Visible = false
    end

    homeTab.BackgroundColor3 =
        name == "INICIO" and purple or card
    optionsTab.BackgroundColor3 =
        name == "OPCOES" and purple or card
    infoTab.BackgroundColor3 =
        name == "INFO" and purple or card
end

homeTab.Activated:Connect(function()
    showPage("INICIO")
end)

optionsTab.Activated:Connect(function()
    showPage("OPCOES")
end)

infoTab.Activated:Connect(function()
    showPage("INFO")
end)

showPage("INICIO")
