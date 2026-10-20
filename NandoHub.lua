-- NANDO HUB V5 — NEON ADVANCED
-- Para seu próprio jogo Roblox.
-- Instale como LocalScript em StarterPlayer > StarterPlayerScripts.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local oldGui = playerGui:FindFirstChild("NandoHubV5")
if oldGui then
    oldGui:Destroy()
end

local Themes = {
    {
        name = "ROXO NEON",
        main = Color3.fromRGB(164, 74, 255),
        glow = Color3.fromRGB(232, 90, 255)
    },
    {
        name = "AZUL CYBER",
        main = Color3.fromRGB(45, 175, 255),
        glow = Color3.fromRGB(80, 255, 255)
    },
    {
        name = "ROSA NEON",
        main = Color3.fromRGB(255, 65, 190),
        glow = Color3.fromRGB(255, 130, 230)
    },
    {
        name = "VERDE MATRIX",
        main = Color3.fromRGB(55, 255, 155),
        glow = Color3.fromRGB(160, 255, 200)
    },
}

local themeIndex = 1
local sizeIndex = 2

local sizes = {
    {name = "PEQUENO", size = UDim2.fromOffset(320, 250)},
    {name = "MÉDIO", size = UDim2.fromOffset(380, 290)},
    {name = "GRANDE", size = UDim2.fromOffset(440, 330)},
}

local theme = Themes[themeIndex]
local minimized = false
local activeTab = "INICIO"
local pulseEnabled = true
local uiTransparency = 0
local statusText = "Sistema pronto"

local function tween(obj, duration, props, style)
    local info = TweenInfo.new(
        duration,
        style or Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )

    local tw = TweenService:Create(obj, info, props)
    tw:Play()
    return tw
end

local gui = Instance.new("ScreenGui")
gui.Name = "NandoHubV5"
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local root = Instance.new("Frame")
root.Name = "MainPanel"
root.AnchorPoint = Vector2.new(0.5, 0.5)
root.Position = UDim2.fromScale(0.5, 0.5)
root.Size = sizes[sizeIndex].size
root.BackgroundColor3 = Color3.fromRGB(13, 12, 23)
root.BorderSizePixel = 0
root.ClipsDescendants = true
root.Parent = gui

Instance.new("UICorner", root).CornerRadius =
    UDim.new(0, 15)

local rootScale = Instance.new("UIScale")
rootScale.Scale = 0.86
rootScale.Parent = root

local rootStroke = Instance.new("UIStroke")
rootStroke.Name = "NeonBorder"
rootStroke.Thickness = 2
rootStroke.Color = theme.main
rootStroke.Transparency = 0.05
rootStroke.Parent = root

local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, 0, 0, 54)
header.BackgroundColor3 = Color3.fromRGB(25, 18, 42)
header.BorderSizePixel = 0
header.Parent = root

Instance.new("UICorner", header).CornerRadius =
    UDim.new(0, 15)

local headerCover = Instance.new("Frame")
headerCover.Position = UDim2.new(0, 0, 1, -14)
headerCover.Size = UDim2.new(1, 0, 0, 14)
headerCover.BackgroundColor3 = header.BackgroundColor3
headerCover.BorderSizePixel = 0
headerCover.Parent = header

local accentLine = Instance.new("Frame")
accentLine.Name = "AccentLine"
accentLine.Position = UDim2.new(0, 0, 1, -2)
accentLine.Size = UDim2.new(1, 0, 0, 2)
accentLine.BackgroundColor3 = theme.main
accentLine.BorderSizePixel = 0
accentLine.Parent = header

local title = Instance.new("TextLabel")
title.BackgroundTransparency = 1
title.Position = UDim2.fromOffset(15, 4)
title.Size = UDim2.new(1, -110, 0, 27)
title.Font = Enum.Font.GothamBlack
title.Text = "NANDO HUB"
title.TextColor3 = Color3.new(1, 1, 1)
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.BackgroundTransparency = 1
subtitle.Position = UDim2.fromOffset(16, 29)
subtitle.Size = UDim2.new(1, -115, 0, 16)
subtitle.Font = Enum.Font.GothamMedium
subtitle.Text = "V5  •  NEON ADVANCED"
subtitle.TextColor3 = theme.glow
subtitle.TextSize = 9
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

local minimize = Instance.new("TextButton")
minimize.Name = "MinimizeButton"
minimize.Size = UDim2.fromOffset(34, 32)
minimize.Position = UDim2.new(1, -44, 0, 11)
minimize.BackgroundColor3 = theme.main
minimize.BorderSizePixel = 0
minimize.Text = "—"
minimize.TextColor3 = Color3.new(1, 1, 1)
minimize.TextSize = 20
minimize.Font = Enum.Font.GothamBlack
minimize.Parent = header

Instance.new("UICorner", minimize).CornerRadius =
    UDim.new(0, 8)

local nav = Instance.new("Frame")
nav.Name = "Navigation"
nav.Position = UDim2.fromOffset(10, 64)
nav.Size = UDim2.new(1, -20, 0, 34)
nav.BackgroundTransparency = 1
nav.Parent = root

local navLayout = Instance.new("UIListLayout")
navLayout.FillDirection = Enum.FillDirection.Horizontal
navLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
navLayout.VerticalAlignment = Enum.VerticalAlignment.Center
navLayout.Padding = UDim.new(0, 5)
navLayout.Parent = nav

local content = Instance.new("ScrollingFrame")
content.Name = "Content"
content.Position = UDim2.fromOffset(10, 106)
content.Size = UDim2.new(1, -20, 1, -116)
content.BackgroundColor3 = Color3.fromRGB(20, 17, 32)
content.BorderSizePixel = 0
content.ScrollBarThickness = 3
content.ScrollBarImageColor3 = theme.main
content.CanvasSize = UDim2.new(0, 0, 0, 0)
content.AutomaticCanvasSize = Enum.AutomaticSize.Y
content.ScrollingDirection = Enum.ScrollingDirection.Y
content.Parent = root

Instance.new("UICorner", content).CornerRadius =
    UDim.new(0, 10)

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 12)
contentPadding.PaddingBottom = UDim.new(0, 12)
contentPadding.PaddingLeft = UDim.new(0, 12)
contentPadding.PaddingRight = UDim.new(0, 12)
contentPadding.Parent = content

local contentLayout = Instance.new("UIListLayout")
contentLayout.Padding = UDim.new(0, 8)
contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
contentLayout.Parent = content

local tabButtons = {}
local statusLabel

local function applyTheme()
    theme = Themes[themeIndex]

    rootStroke.Color = theme.main
    accentLine.BackgroundColor3 = theme.main
    minimize.BackgroundColor3 = theme.main
    subtitle.TextColor3 = theme.glow
    content.ScrollBarImageColor3 = theme.main

    for _, button in ipairs(tabButtons) do
        if button:GetAttribute("TabName") == activeTab then
            button.BackgroundColor3 = theme.main
        else
            button.BackgroundColor3 =
                Color3.fromRGB(42, 32, 61)
        end
    end

    for _, item in ipairs(content:GetChildren()) do
        if item:IsA("TextButton") then
            local stroke = item:FindFirstChildOfClass("UIStroke")
            if stroke then
                stroke.Color = theme.main
            end
        elseif item:IsA("TextLabel")
            and item.Name == "StatusLabel" then
            item.TextColor3 = theme.glow
        end
    end
end

local function setStatus(text)
    statusText = text

    if statusLabel and statusLabel.Parent then
        statusLabel.Text = "●  " .. statusText
    end
end

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child ~= contentPadding
            and child ~= contentLayout then
            child:Destroy()
        end
    end

    statusLabel = nil
end

local function makeLabel(text, height, isHeading)
    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 0, height or 28)
    label.Font = isHeading and
        Enum.Font.GothamBold or Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = isHeading and theme.glow
        or Color3.fromRGB(224, 220, 237)
    label.TextSize = isHeading and 15 or 13
    label.TextWrapped = true
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = content

    return label
end

local function makeButton(text, callback)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 36)
    button.BackgroundColor3 = Color3.fromRGB(42, 32, 61)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamSemibold
    button.Text = text
    button.TextColor3 = Color3.fromRGB(248, 246, 255)
    button.TextSize = 12
    button.TextWrapped = true
    button.AutoButtonColor = false
    button.Parent = content

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 8)

    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.main
    stroke.Thickness = 1
    stroke.Transparency = 0.48
    stroke.Parent = button

    button.MouseEnter:Connect(function()
        tween(button, 0.15, {
            BackgroundColor3 = Color3.fromRGB(58, 40, 82)
        })

        tween(stroke, 0.15, {
            Transparency = 0.05,
            Thickness = 1.5
        })
    end)

    button.MouseLeave:Connect(function()
        tween(button, 0.15, {
            BackgroundColor3 = Color3.fromRGB(42, 32, 61)
        })

        tween(stroke, 0.15, {
            Transparency = 0.48,
            Thickness = 1
        })
    end)

    button.Activated:Connect(function()
        tween(button, 0.08, {
            BackgroundColor3 = theme.main
        })

        task.delay(0.12, function()
            if button.Parent then
                tween(button, 0.16, {
                    BackgroundColor3 = Color3.fromRGB(42, 32, 61)
                })
            end
        end)

        if callback then
            callback()
        end
    end)

    return button
end

local renderTab

renderTab = function(tabName)
    activeTab = tabName
    clearContent()

    if tabName == "INICIO" then
        makeLabel("BEM-VINDO AO V5", 24, true)

        makeLabel(
            "Visual cyberpunk, bordas neon e controles rápidos.",
            38
        )

        makeButton("TESTAR ANIMAÇÃO", function()
            tween(rootScale, 0.12, {
                Scale = 1.035
            }, Enum.EasingStyle.Back)

            task.delay(0.15, function()
                if rootScale.Parent then
                    tween(rootScale, 0.22, {
                        Scale = 1
                    })
                end
            end)

            setStatus("Animação funcionando!")
        end)

        makeButton("TESTAR NOTIFICAÇÃO", function()
            setStatus(
                "Tudo certo! NANDO HUB V5 está ativo."
            )
        end)

        statusLabel = makeLabel(
            "●  " .. statusText, 24
        )
        statusLabel.Name = "StatusLabel"
        statusLabel.TextColor3 = theme.glow

    elseif tabName == "OPÇÕES" then
        makeLabel("ATALHOS VISUAIS", 24, true)

        makeButton(
            "Efeito de brilho: "
                .. (pulseEnabled and "LIGADO" or "DESLIGADO"),
            function()
                pulseEnabled = not pulseEnabled
                setStatus(
                    "Efeito de brilho "
                    .. (pulseEnabled and "ligado." or "desligado.")
                )
                renderTab("OPÇÕES")
            end
        )

        makeButton("Centralizar painel", function()
            root.Position = UDim2.fromScale(0.5, 0.5)
            setStatus("Painel centralizado.")
        end)

        makeButton("Restaurar aparência padrão", function()
            themeIndex = 1
            sizeIndex = 2
            uiTransparency = 0
            root.Size = sizes[sizeIndex].size
            root.BackgroundTransparency = uiTransparency
            applyTheme()
            setStatus("Aparência padrão restaurada.")
            renderTab("OPÇÕES")
        end)

        statusLabel = makeLabel(
            "●  " .. statusText, 24
        )
        statusLabel.Name = "StatusLabel"
        statusLabel.TextColor3 = theme.glow

    elseif tabName == "CONFIG" then
        makeLabel("APARÊNCIA DO PAINEL", 24, true)

        makeButton(
            "Tema: " .. theme.name .. "  •  trocar",
            function()
                themeIndex = (themeIndex % #Themes) + 1
                applyTheme()
                renderTab("CONFIG")
            end
        )

        makeButton(
            "Tamanho: " .. sizes[sizeIndex].name
                .. "  •  trocar",
            function()
                sizeIndex = (sizeIndex % #sizes) + 1
                root.Size = sizes[sizeIndex].size
                renderTab("CONFIG")
            end
        )

        makeButton(
            "Transparência: "
                .. tostring(math.floor(uiTransparency * 100))
                .. "%  •  trocar",
            function()
                local levels = {0, 0.08, 0.16, 0.24}
                local nextIndex = 1

                for i, level in ipairs(levels) do
                    if math.abs(level - uiTransparency) < 0.001 then
                        nextIndex = (i % #levels) + 1
                        break
                    end
                end

                uiTransparency = levels[nextIndex]

                tween(root, 0.18, {
                    BackgroundTransparency = uiTransparency
                })

                setStatus("Transparência atualizada.")
                renderTab("CONFIG")
            end
        )

        makeLabel(
            "As preferências ficam ativas durante esta sessão.",
            34
        )

        statusLabel = makeLabel(
            "●  " .. statusText, 24
        )
        statusLabel.Name = "StatusLabel"
        statusLabel.TextColor3 = theme.glow

    elseif tabName == "INFO" then
        makeLabel("NANDO HUB V5", 24, true)

        makeLabel(
            "Versão visual com neon avançado, temas, tamanho "
                .. "ajustável, transparência, painel arrastável "
                .. "e minimizar/restaurar.",
            76
        )

        makeLabel(
            "Este painel é uma base visual para funções "
                .. "autorizadas do seu próprio jogo.",
            54
        )

        statusLabel = makeLabel(
            "●  " .. statusText, 24
        )
        statusLabel.Name = "StatusLabel"
        statusLabel.TextColor3 = theme.glow
    end

    applyTheme()
end

local function makeTab(name, width)
    local button = Instance.new("TextButton")
    button.Name = "Tab_" .. name
    button.Size = UDim2.new(width, -4, 1, 0)
    button.BackgroundColor3 = Color3.fromRGB(42, 32, 61)
    button.BorderSizePixel = 0
    button.Font = Enum.Font.GothamBold
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.TextSize = 10
    button.Parent = nav

    Instance.new("UICorner", button).CornerRadius =
        UDim.new(0, 7)

    button:SetAttribute("TabName", name)
    table.insert(tabButtons, button)

    button.Activated:Connect(function()
        renderTab(name)
    end)
end

makeTab("INICIO", 0.25)
makeTab("OPÇÕES", 0.25)
makeTab("CONFIG", 0.25)
makeTab("INFO", 0.25)

minimize.Activated:Connect(function()
    minimized = not minimized

    if minimized then
        nav.Visible = false
        content.Visible = false
        root.ClipsDescendants = false

        tween(root, 0.2, {
            Size = UDim2.fromOffset(215, 54)
        })

        minimize.Text = "+"
    else
        root.ClipsDescendants = true
        nav.Visible = true
        content.Visible = true
        root.Size = sizes[sizeIndex].size
        minimize.Text = "—"
    end
end)

-- Arrastar pelo cabeçalho com mouse ou toque.
local dragging = false
local dragStart
local startPosition
local activeDragInput

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = root.Position
        activeDragInput = input

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging then
        local isMouseMove =
            input.UserInputType == Enum.UserInputType.MouseMovement

        local isTouchMove =
            input.UserInputType == Enum.UserInputType.Touch
            and activeDragInput == input

        if isMouseMove or isTouchMove then
            local delta = input.Position - dragStart

            root.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end
end)

-- Pulso neon contínuo; pode ser desligado na aba OPÇÕES.
task.spawn(function()
    while gui.Parent do
        if pulseEnabled then
            tween(rootStroke, 0.85, {
                Transparency = 0.35,
                Thickness = 3
            })

            tween(accentLine, 0.85, {
                BackgroundTransparency = 0.2
            })

            task.wait(0.85)

            if not gui.Parent then
                break
            end

            tween(rootStroke, 0.85, {
                Transparency = 0.02,
                Thickness = 2
            })

            tween(accentLine, 0.85, {
                BackgroundTransparency = 0
            })

            task.wait(0.85)
        else
            task.wait(0.25)
        end
    end
end)

renderTab("INICIO")

tween(rootScale, 0.38, {
    Scale = 1
}, Enum.EasingStyle.Back)

print("NANDO HUB V5 carregado com sucesso.")
