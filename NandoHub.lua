-- NANDO HUB V4
-- Interface visual para seu proprio jogo no Roblox Studio.
-- Instale como LocalScript em StarterPlayer > StarterPlayerScripts.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("NandoHubV4")
if oldGui then
    oldGui:Destroy()
end

local COLORS = {
    Purple = Color3.fromRGB(145, 55, 255),
    Pink = Color3.fromRGB(255, 55, 210),
    Blue = Color3.fromRGB(55, 170, 255),
    Green = Color3.fromRGB(60, 255, 170),
}

local accentNames = {"Roxo", "Rosa", "Azul", "Verde"}
local accentKeys = {"Purple", "Pink", "Blue", "Green"}
local accentIndex = 1
local scaleIndex = 2
local scales = {
    {name = "Pequeno", size = UDim2.fromOffset(330, 245)},
    {name = "Médio", size = UDim2.fromOffset(380, 285)},
    {name = "Grande", size = UDim2.fromOffset(430, 325)},
}

local accent = COLORS[accentKeys[accentIndex]]
local minimized = false
local currentTab = "INICIO"

local gui = Instance.new("ScreenGui")
gui.Name = "NandoHubV4"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local root = Instance.new("Frame")
root.Name = "Main"
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.Size = scales[scaleIndex].size
root.BackgroundColor3 = Color3.fromRGB(15, 12, 24)
root.BorderSizePixel = 0
root.ClipsDescendants = true
root.Parent = gui

local rootCorner = Instance.new("UICorner")
rootCorner.CornerRadius = UDim.new(0, 12)
rootCorner.Parent = root

local rootStroke = Instance.new("UIStroke")
rootStroke.Color = accent
rootStroke.Thickness = 2
rootStroke.Parent = root

local rootScale = Instance.new("UIScale")
rootScale.Scale = 0.88
rootScale.Parent = root

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 48)
header.BackgroundColor3 = Color3.fromRGB(25, 18, 39)
header.BorderSizePixel = 0
header.Parent = root

local title = Instance.new("TextLabel")
title.Name = "Title"
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(14, 0)
title.Size = UDim2.new(1, -110, 1, 0)
title.Font = Enum.Font.GothamBold
title.Text = "NANDO HUB  V4"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextSize = 17
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local minimizeButton = Instance.new("TextButton")
minimizeButton.Name = "Minimize"
minimizeButton.Size = UDim2.fromOffset(34, 30)
minimizeButton.Position = UDim2.new(1, -43, 0, 9)
minimizeButton.BackgroundColor3 = accent
minimizeButton.Text = "—"
minimizeButton.TextColor3 = Color3.new(1, 1, 1)
minimizeButton.TextSize = 20
minimizeButton.Font = Enum.Font.GothamBold
minimizeButton.Parent = header
Instance.new("UICorner", minimizeButton).CornerRadius = UDim.new(0, 7)

local nav = Instance.new("Frame")
nav.Name = "Navigation"
nav.Position = UDim2.fromOffset(10, 57)
nav.Size = UDim2.new(1, -20, 0, 36)
nav.BackgroundTransparency = 1
nav.Parent = root

local navLayout = Instance.new("UIListLayout")
navLayout.FillDirection = Enum.FillDirection.Horizontal
navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
navLayout.VerticalAlignment = Enum.VerticalAlignment.Center
navLayout.Padding = UDim.new(0, 6)
navLayout.Parent = nav

local content = Instance.new("Frame")
content.Name = "Content"
content.Position = UDim2.fromOffset(10, 101)
content.Size = UDim2.new(1, -20, 1, -111)
content.BackgroundColor3 = Color3.fromRGB(22, 18, 33)
content.BorderSizePixel = 0
content.Parent = root
Instance.new("UICorner", content).CornerRadius = UDim.new(0, 9)

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 12)
contentPadding.PaddingBottom = UDim.new(0, 10)
contentPadding.PaddingLeft = UDim.new(0, 12)
contentPadding.PaddingRight = UDim.new(0, 12)
contentPadding.Parent = content

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 8)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local statusLabel
local tabButtons = {}
local renderTab

local function tween(instance, duration, properties)
    local t = TweenService:Create(instance, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties)
    t:Play()
    return t
end

local function updateAccent()
    accent = COLORS[accentKeys[accentIndex]]
    rootStroke.Color = accent
    minimizeButton.BackgroundColor3 = accent
    for _, button in ipairs(tabButtons) do
        if button:GetAttribute("TabName") == currentTab then
            button.BackgroundColor3 = accent
        end
    end
    if statusLabel then
        statusLabel.TextColor3 = accent
    end
end

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if not child:IsA("UIPadding") and not child:IsA("UIListLayout") then
            child:Destroy()
        end
    end
    statusLabel = nil
end

local function makeLabel(text, height)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, height or 28)
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Color3.fromRGB(230, 225, 240)
    label.TextSize = 14
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content
    return label
end

local function makeButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(43, 32, 61)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 13
    button.AutoButtonColor = true
    button.Parent = content
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)
    local stroke = Instance.new("UIStroke")
    stroke.Color = accent
    stroke.Transparency = 0.55
    stroke.Thickness = 1
    stroke.Parent = button

    button.Activated:Connect(function()
        tween(button, 0.12, {BackgroundColor3 = accent})
        task.delay(0.14, function()
            if button.Parent then
                tween(button, 0.18, {BackgroundColor3 = Color3.fromRGB(43, 32, 61)})
            end
        end)
        if callback then callback() end
    end)
    return button
end

local function setStatus(message)
    if statusLabel and statusLabel.Parent then
        statusLabel.Text = "● " .. message
    end
end

renderTab = function(tabName)
    currentTab = tabName
    clearContent()

    if tabName == "INICIO" then
        makeLabel("Bem-vindo ao NANDO HUB V4!", 28)
        makeLabel("Interface visual com efeitos neon e opções de aparência.", 42)
        makeButton("TESTAR PAINEL", function()
            setStatus("Painel funcionando!")
        end)
        statusLabel = makeLabel("● Sistema pronto", 24)
        statusLabel.TextColor3 = accent
    elseif tabName == "OPÇÕES" then
        makeLabel("OPÇÕES DO PAINEL", 28)
        makeButton("Mostrar mensagem de teste", function()
            setStatus("Botão de teste funcionando.")
        end)
        statusLabel = makeLabel("● Pronto para usar", 24)
        statusLabel.TextColor3 = accent
    elseif tabName == "CONFIG" then
        makeLabel("PERSONALIZAÇÃO", 24)
        makeButton("Cor: " .. accentNames[accentIndex] .. "  •  trocar cor", function()
            accentIndex = (accentIndex % #accentKeys) + 1
            updateAccent()
            renderTab("CONFIG")
        end)
        makeButton("Tamanho: " .. scales[scaleIndex].name .. "  •  trocar tamanho", function()
            scaleIndex = (scaleIndex % #scales) + 1
            root.Size = scales[scaleIndex].size
            renderTab("CONFIG")
        end)
        makeButton("Reproduzir animação neon", function()
            local original = rootScale.Scale
            tween(rootScale, 0.18, {Scale = original + 0.05})
            task.delay(0.2, function()
                if rootScale.Parent then tween(rootScale, 0.22, {Scale = original}) end
            end)
            setStatus("Animação reproduzida!")
        end)
        statusLabel = makeLabel("● Configurações salvas nesta sessão", 24)
        statusLabel.TextColor3 = accent
    elseif tabName == "INFO" then
        makeLabel("NANDO HUB V4", 26)
        makeLabel("Interface demonstrativa para seu próprio jogo Roblox.", 44)
        makeLabel("Use o Roblox Studio para adicionar funções autorizadas do seu jogo.", 48)
        statusLabel = makeLabel("● V4 • Neon / cores / tamanho", 24)
        statusLabel.TextColor3 = accent
    end

    for _, button in ipairs(tabButtons) do
        if button:GetAttribute("TabName") == currentTab then
            button.BackgroundColor3 = accent
        else
            button.BackgroundColor3 = Color3.fromRGB(43, 32, 61)
        end
    end
end

local function makeTab(name)
    local button = Instance.new("TextButton")
    button.Name = "Tab_" .. name
    button.Size = UDim2.new(0.25, -5, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(43, 32, 61)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.Text = name
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.TextSize = 11
    button.Parent = nav
    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 7)
    button:SetAttribute("TabName", name)
    table.insert(tabButtons, button)
    button.Activated:Connect(function()
        renderTab(name)
    end)
end

makeTab("INICIO")
makeTab("OPÇÕES")
makeTab("CONFIG")
makeTab("INFO")

minimizeButton.Activated:Connect(function()
    minimized = not minimized
    if minimized then
        nav.Visible = false
        content.Visible = false
        root.ClipsDescendants = false
        tween(root, 0.2, {Size = UDim2.fromOffset(210, 48)})
        minimizeButton.Text = "+"
        title.Text = "NANDO HUB V4"
    else
        root.ClipsDescendants = true
        nav.Visible = true
        content.Visible = true
        root.Size = scales[scaleIndex].size
        minimizeButton.Text = "—"
    end
end)

-- Arrastar pelo cabeçalho, inclusive em telas touch.
local dragging = false
local dragInput
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = root.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input == dragInput or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        root.Position = UDim2.new(
            startPosition.X.Scale, startPosition.X.Offset + delta.X,
            startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
        )
    end
end)

-- Brilho neon pulsante.
task.spawn(function()
    while gui.Parent do
        tween(rootStroke, 0.9, {Transparency = 0.45, Thickness = 3})
        task.wait(0.9)
        if not gui.Parent then break end
        tween(rootStroke, 0.9, {Transparency = 0, Thickness = 2})
        task.wait(0.9)
    end
end)

renderTab("INICIO")
tween(rootScale, 0.35, {Scale = 1})
print("NANDO HUB V4 carregado.")
