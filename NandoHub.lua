-- NANDO HUB V5 | VAMPIRE LIFE EDITION
-- Interface profissional para Roblox Studio
-- LocalScript em StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("NandoHubV5")
if old then old:Destroy() end

local RED = Color3.fromRGB(190, 54, 66)
local BG = Color3.fromRGB(12, 12, 15)
local PANEL = Color3.fromRGB(20, 20, 24)
local ROW = Color3.fromRGB(25, 25, 30)
local WHITE = Color3.fromRGB(245, 245, 248)
local MUTED = Color3.fromRGB(150, 150, 160)

local gui = Instance.new("ScreenGui")
gui.Name = "NandoHubV5"
gui.ResetOnSpawn = false
gui.DisplayOrder = 20
gui.Parent = playerGui

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function corner(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function tween(obj, props)
    TweenService:Create(
        obj,
        TweenInfo.new(0.18, Enum.EasingStyle.Quad),
        props
    ):Play()
end

local main = make("Frame", {
    Name = "Main",
    Size = UDim2.new(0.88, 0, 0.76, 0),
    Position = UDim2.new(0.06, 0, 0.12, 0),
    BackgroundColor3 = BG,
    BorderSizePixel = 0,
    ClipsDescendants = true
}, gui)
corner(main, 14)

make("UISizeConstraint", {
    MinSize = Vector2.new(300, 300),
    MaxSize = Vector2.new(850, 650)
}, main)

make("UIStroke", {
    Color = Color3.fromRGB(55, 36, 42),
    Thickness = 1.4
}, main)

-- HEADER
local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 68),
    BackgroundColor3 = Color3.fromRGB(8, 8, 10),
    BorderSizePixel = 0
}, main)

local logo = make("Frame", {
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.new(0, 14, 0, 13),
    BackgroundColor3 = Color3.fromRGB(48, 19, 26)
}, header)
corner(logo, 10)

make("TextLabel", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    Text = "N",
    TextColor3 = RED,
    Font = Enum.Font.GothamBlack,
    TextSize = 28
}, logo)

make("TextLabel", {
    Position = UDim2.new(0, 66, 0, 10),
    Size = UDim2.new(1, -150, 0, 28),
    BackgroundTransparency = 1,
    Text = "NANDO HUB  [V5]",
    TextColor3 = WHITE,
    Font = Enum.Font.GothamBold,
    TextSize = 19,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

make("TextLabel", {
    Position = UDim2.new(0, 67, 0, 37),
    Size = UDim2.new(1, -150, 0, 19),
    BackgroundTransparency = 1,
    Text = "Vampire Life Edition",
    TextColor3 = MUTED,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left
}, header)

local close = make("TextButton", {
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.new(1, -49, 0, 12),
    BackgroundTransparency = 1,
    Text = "×",
    TextColor3 = RED,
    Font = Enum.Font.GothamMedium,
    TextSize = 32
}, header)

close.Activated:Connect(function()
    gui:Destroy()
end)

-- SIDEBAR
local sidebar = make("Frame", {
    Position = UDim2.new(0, 0, 0, 68),
    Size = UDim2.new(0, 145, 1, -68),
    BackgroundColor3 = Color3.fromRGB(15, 15, 18),
    BorderSizePixel = 0
}, main)

local sideLayout = make("UIListLayout", {
    Padding = UDim.new(0, 7),
    SortOrder = Enum.SortOrder.LayoutOrder
}, sidebar)

make("UIPadding", {
    PaddingTop = UDim.new(0, 14),
    PaddingLeft = UDim.new(0, 9),
    PaddingRight = UDim.new(0, 9)
}, sidebar)

-- CONTENT
local content = make("ScrollingFrame", {
    Position = UDim2.new(0, 153, 0, 78),
    Size = UDim2.new(1, -163, 1, -90),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = RED,
    CanvasSize = UDim2.new()
}, main)

local contentLayout = make("UIListLayout", {
    Padding = UDim.new(0, 9),
    SortOrder = Enum.SortOrder.LayoutOrder
}, content)

make("UIPadding", {
    PaddingTop = UDim.new(0, 4),
    PaddingRight = UDim.new(0, 8),
    PaddingBottom = UDim.new(0, 10)
}, content)

contentLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    content.CanvasSize = UDim2.new(
        0, 0, 0, contentLayout.AbsoluteContentSize.Y + 20
    )
end)

local pages = {}
local currentPage

local function createPage(name)
    local page = make("Frame", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 0),
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Visible = false
    }, content)

    make("UIListLayout", {
        Padding = UDim.new(0, 9),
        SortOrder = Enum.SortOrder.LayoutOrder
    }, page)

    pages[name] = page
    return page
end

local function showPage(name)
    currentPage = name

    for pageName, page in pairs(pages) do
        page.Visible = pageName == name
    end

    for _, item in ipairs(sidebar:GetChildren()) do
        if item:IsA("TextButton") then
            local selected = item.Name == name
            tween(item, {
                BackgroundColor3 = selected
                    and Color3.fromRGB(48, 19, 26)
                    or ROW,
                TextColor3 = selected and WHITE or MUTED
            })
        end
    end

    content.CanvasPosition = Vector2.new(0, 0)
end

local function section(page, title)
    make("TextLabel", {
        Size = UDim2.new(1, -4, 0, 26),
        BackgroundTransparency = 1,
        Text = string.upper(title),
        TextColor3 = RED,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
        TextXAlignment = Enum.TextXAlignment.Left
    }, page)
end

local function addToggle(page, title, description)
    local card = make("Frame", {
        Size = UDim2.new(1, -4, 0, 72),
        BackgroundColor3 = ROW,
        BorderSizePixel = 0
    }, page)
    corner(card, 9)

    make("TextLabel", {
        Position = UDim2.new(0, 13, 0, 10),
        Size = UDim2.new(1, -80, 0, 22),
        BackgroundTransparency = 1,
        Text = title,
        TextColor3 = WHITE,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    make("TextLabel", {
        Position = UDim2.new(0, 13, 0, 34),
        Size = UDim2.new(1, -80, 0, 29),
        BackgroundTransparency = 1,
        Text = description or "Configuração do módulo",
        TextColor3 = MUTED,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top
    }, card)

    local switch = make("TextButton", {
        Size = UDim2.fromOffset(42, 24),
        Position = UDim2.new(1, -54, 0.5, -12),
        BackgroundColor3 = Color3.fromRGB(57, 57, 62),
        Text = "",
        AutoButtonColor = false
    }, card)
    corner(switch, 15)

    local knob = make("Frame", {
        Size = UDim2.fromOffset(18, 18),
        Position = UDim2.new(0, 3, 0.5, -9),
        BackgroundColor3 = WHITE,
        BorderSizePixel = 0
    }, switch)
    corner(knob, 12)

    local enabled = false

    switch.Activated:Connect(function()
        enabled = not enabled

        tween(switch, {
            BackgroundColor3 = enabled and RED
                or Color3.fromRGB(57, 57, 62)
        })

        tween(knob, {
            Position = enabled
                and UDim2.new(1, -21, 0.5, -9)
                or UDim2.new(0, 3, 0.5, -9)
        })

        -- Estado apenas visual; nenhuma ação de farm é executada.
        card:SetAttribute("Enabled", enabled)
    end)

    return card
end

local function addAction(page, title, description)
    local card = make("TextButton", {
        Size = UDim2.new(1, -4, 0, 62),
        BackgroundColor3 = ROW,
        Text = "",
        AutoButtonColor = false
    }, page)
    corner(card, 9)

    make("TextLabel", {
        Position = UDim2.new(0, 13, 0, 9),
        Size = UDim2.new(1, -30, 0, 22),
        BackgroundTransparency = 1,
        Text = title .. "   ›",
        TextColor3 = WHITE,
        Font = Enum.Font.GothamBold,
        TextSize = 13,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    make("TextLabel", {
        Position = UDim2.new(0, 13, 0, 33),
        Size = UDim2.new(1, -25, 0, 18),
        BackgroundTransparency = 1,
        Text = description or "Abrir configuração",
        TextColor3 = MUTED,
        Font = Enum.Font.Gotham,
        TextSize = 10,
        TextXAlignment = Enum.TextXAlignment.Left
    }, card)

    return card
end

local farm = createPage("Farm")
section(farm, "Farm")
addToggle(farm, "Auto Farm NPC", "Módulo de teste para NPCs")
addToggle(farm, "Farm Hunters", "Seleção de Hunters humanos")
addToggle(farm, "Farm Lobos", "Seleção de lobos")
addToggle(farm, "Speed Farm", "Configuração de movimentação")
addToggle(farm, "Speed Orb", "Módulo de teste de coleta de orbes")

local system = createPage("System")
section(system, "System")
addToggle(system, "Anti Ragdoll", "Disponível somente se implementado no jogo próprio")
addToggle(system, "Anti Hibernation", "Opção de demonstração")
addAction(system, "Restaurar configurações", "Voltar aos valores padrão")

local server = createPage("Server")
section(server, "Server")
addAction(server, "Informações do servidor", "Painel informativo")
addAction(server, "Estado da conexão", "Verificação visual")

local others = createPage("Others")
section(others, "Others")
addToggle(others, "Interface compacta", "Alternar densidade visual")
addToggle(others, "Animações", "Configuração visual do menu")

local utilities = createPage("Utilities")
section(utilities, "Utilities")
addAction(utilities, "Reiniciar interface", "Reconstruir o menu")
addAction(utilities, "Sobre o NANDO HUB", "Vampire Life Edition")

local esp = createPage("Esp")
section(esp, "ESP")
addToggle(esp, "ESP de NPCs", "Demonstração de seleção de NPCs")
addToggle(esp, "ESP de Hunters", "Módulo visual a integrar no jogo próprio")
addToggle(esp, "ESP de orbes", "Demonstração visual")

local playerPage = createPage("Player")
section(playerPage, "Player")
addAction(playerPage, "Informações do jogador", player.Name)
addToggle(playerPage, "Menu móvel", "Controle visual do painel")

local tabs = {
    {"Farm", "◉  Farm"},
    {"System", "⬡  System"},
    {"Server", "▤  Server"},
    {"Others", "☻  Others"},
    {"Utilities", "⚗  Utilities"},
    {"Esp", "◎  ESP"},
    {"Player", "♙  Player"}
}

for i, data in ipairs(tabs) do
    local name, label = data[1], data[2]

    local button = make("TextButton", {
        Name = name,
        Size = UDim2.new(1, 0, 0, 43),
        BackgroundColor3 = ROW,
        Text = label,
        TextColor3 = MUTED,
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        LayoutOrder = i,
        AutoButtonColor = false
    }, sidebar)
    corner(button, 7)

    make("UIPadding", {
        PaddingLeft = UDim.new(0, 9)
    }, button)

    button.Activated:Connect(function()
        showPage(name)
    end)
end

showPage("Farm")

-- Arrastar o painel pelo cabeçalho, inclusive com mouse.
local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch
    ) then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)

print("NANDO HUB V5 carregado.")
