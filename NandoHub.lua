
-- NANDO HUB V6 | BBC STYLE
-- Interface mobile para o teu próprio jogo Roblox
-- Coloca como LocalScript em StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("NANDO_HUB_V6")
if old then old:Destroy() end

local C = {
    BG = Color3.fromRGB(7, 7, 9),
    PANEL = Color3.fromRGB(16, 16, 19),
    ROW = Color3.fromRGB(23, 23, 26),
    ORANGE = Color3.fromRGB(255, 145, 0),
    WHITE = Color3.fromRGB(245, 245, 245),
    GREY = Color3.fromRGB(135, 135, 140),
    GREEN = Color3.fromRGB(65, 220, 130),
}

local settings = {
    ["FOV Visual"] = true,
    ["Mostrar FPS"] = true,
    ["Mostrar Ping"] = true,
    ["Tema RGB"] = false,
    ["Zoom Visual"] = false,
    ["Nomes de teste"] = false,
    ["Animações"] = true,
    ["Som dos botões"] = false,
}

local gui = Instance.new("ScreenGui")
gui.Name = "NANDO_HUB_V6"
gui.ResetOnSpawn = false
gui.DisplayOrder = 100
gui.Parent = playerGui

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do obj[k] = v end
    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function outline(obj, color, thickness)
    return make("UIStroke", {
        Color = color or C.ORANGE,
        Thickness = thickness or 1
    }, obj)
end

-- Botão flutuante
local opener = make("TextButton", {
    Name = "OpenNando",
    Size = UDim2.fromOffset(58, 58),
    Position = UDim2.new(0, 12, 0.4, 0),
    BackgroundColor3 = C.BG,
    Text = "N",
    TextColor3 = C.ORANGE,
    TextSize = 28,
    Font = Enum.Font.GothamBlack,
    Active = true,
}, gui)
round(opener, 29)
outline(opener, C.ORANGE, 2)

-- Painel principal
local panel = make("Frame", {
    Name = "Main",
    Size = UDim2.new(0.94, 0, 0.78, 0),
    Position = UDim2.new(0.03, 0, 0.11, 0),
    BackgroundColor3 = C.BG,
    Visible = true,
    Active = true,
    ClipsDescendants = true,
}, gui)
round(panel, 9)
local border = outline(panel, C.ORANGE, 1.5)

make("UISizeConstraint", {
    MinSize = Vector2.new(300, 340),
    MaxSize = Vector2.new(760, 620),
}, panel)

opener.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)

-- Arrastar o painel pelo cabeçalho
local header = make("Frame", {
    Size = UDim2.new(1, 0, 0, 58),
    BackgroundColor3 = C.BG,
    Active = true,
}, panel)

local dragging = false
local dragStart, initialPos

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        initialPos = panel.Position
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and (
        input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseMovement
    ) then
        local delta = input.Position - dragStart
        panel.Position = UDim2.new(
            initialPos.X.Scale,
            initialPos.X.Offset + delta.X,
            initialPos.Y.Scale,
            initialPos.Y.Offset + delta.Y
        )
    end
end)

UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch
        or input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

make("TextLabel", {
    Size = UDim2.new(0, 190, 1, 0),
    Position = UDim2.fromOffset(14, 0),
    BackgroundTransparency = 1,
    Text = "NANDO HUB",
    TextColor3 = C.WHITE,
    TextSize = 23,
    Font = Enum.Font.GothamMedium,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local v6 = make("TextLabel", {
    Size = UDim2.fromOffset(36, 32),
    Position = UDim2.fromOffset(166, 13),
    BackgroundColor3 = C.ORANGE,
    Text = "V6",
    TextColor3 = C.BG,
    TextSize = 15,
    Font = Enum.Font.GothamBlack,
}, header)
round(v6, 7)

local close = make("TextButton", {
    Size = UDim2.fromOffset(42, 42),
    Position = UDim2.new(1, -47, 0, 7),
    BackgroundColor3 = C.ROW,
    Text = "×",
    TextColor3 = C.WHITE,
    TextSize = 28,
}, header)
round(close, 7)
close.Activated:Connect(function()
    panel.Visible = false
end)

-- Barra lateral
local sidebar = make("Frame", {
    Size = UDim2.new(0, 116, 1, -64),
    Position = UDim2.fromOffset(0, 58),
    BackgroundColor3 = C.BG,
}, panel)

make("UIListLayout", {
    Padding = UDim.new(0, 5),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, sidebar)

make("UIPadding", {
    PaddingTop = UDim.new(0, 9),
    PaddingLeft = UDim.new(0, 7),
    PaddingRight = UDim.new(0, 5),
}, sidebar)

-- Conteúdo da aba
local content = make("ScrollingFrame", {
    Name = "TabContent",
    Size = UDim2.new(1, -125, 1, -68),
    Position = UDim2.new(0, 120, 0, 62),
    BackgroundColor3 = C.BG,
    BorderSizePixel = 0,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = C.ORANGE,
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    CanvasSize = UDim2.new(),
}, panel)

make("UIPadding", {
    PaddingTop = UDim.new(0, 6),
    PaddingLeft = UDim.new(0, 5),
    PaddingRight = UDim.new(0, 5),
    PaddingBottom = UDim.new(0, 10),
}, content)

make("UIListLayout", {
    Padding = UDim.new(0, 6),
    SortOrder = Enum.SortOrder.LayoutOrder,
}, content)

local function clearContent()
    for _, child in ipairs(content:GetChildren()) do
        if child:IsA("GuiObject")
            and not child:IsA("UIListLayout")
            and not child:IsA("UIPadding") then
            child:Destroy()
        end
    end
end

local function section(text)
    local label = make("TextLabel", {
        Size = UDim2.new(1, -5, 0, 31),
        BackgroundTransparency = 1,
        Text = text:upper(),
        TextColor3 = C.GREY,
        TextSize = 13,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, content)

    make("Frame", {
        Size = UDim2.new(1, -5, 0, 1),
        BackgroundColor3 = C.ROW,
        BorderSizePixel = 0,
    }, content)

    return label
end

local function toggle(label, key, callback)
    local row = make("Frame", {
        Size = UDim2.new(1, -5, 0, 43),
        BackgroundColor3 = C.BG,
    }, content)

    local text = make("TextLabel", {
        Size = UDim2.new(1, -72, 1, 0),
        Position = UDim2.fromOffset(8, 0),
        BackgroundTransparency = 1,
        Text = label,
        TextColor3 = C.WHITE,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)

    local button = make("TextButton", {
        Size = UDim2.fromOffset(43, 23),
        Position = UDim2.new(1, -51, 0.5, -11),
        BackgroundColor3 = settings[key] and C.ORANGE or C.ROW,
        Text = "",
        AutoButtonColor = false,
    }, row)
    round(button, 15)

    local knob = make("Frame", {
        Size = UDim2.fromOffset(17, 17),
        Position = settings[key]
            and UDim2.new(1, -20, 0.5, -8)
            or UDim2.new(0, 3, 0.5, -8),
        BackgroundColor3 = C.WHITE,
    }, button)
    round(knob, 12)

    button.Activated:Connect(function()
        settings[key] = not settings[key]

        local enabled = settings[key]
        TweenService:Create(button, TweenInfo.new(0.15), {
            BackgroundColor3 = enabled and C.ORANGE or C.ROW
        }):Play()

        TweenService:Create(knob, TweenInfo.new(0.15), {
            Position = enabled
                and UDim2.new(1, -20, 0.5, -8)
                or UDim2.new(0, 3, 0.5, -8)
        }):Play()

        if callback then callback(enabled) end
    end)

    return row
end

local function slider(label, min, max, initial, callback)
    local row = make("Frame", {
        Size = UDim2.new(1, -5, 0, 67),
        BackgroundColor3 = C.BG,
    }, content)

    local value = initial
    local title = make("TextLabel", {
        Size = UDim2.new(1, -10, 0, 28),
        Position = UDim2.fromOffset(5, 0),
        BackgroundTransparency = 1,
        Text = label .. "     " .. tostring(value),
        TextColor3 = C.WHITE,
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
    }, row)

    local bar = make("TextButton", {
        Size = UDim2.new(1, -18, 0, 8),
        Position = UDim2.fromOffset(9, 43),
        BackgroundColor3 = C.ROW,
        Text = "",
        AutoButtonColor = false,
    }, row)
    round(bar, 5)

    local fill = make("Frame", {
        Size = UDim2.new((value - min) / (max - min), 0, 1, 0),
        BackgroundColor3 = C.ORANGE,
    }, bar)
    round(fill, 5)

    local dot = make("Frame", {
        Size = UDim2.fromOffset(16, 16),
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new((value - min) / (max - min), 0, 0.5, 0),
        BackgroundColor3 = C.BG,
    }, bar)
    round(dot, 10)
    outline(dot, C.ORANGE, 3)

    local function update(input)
        local ratio = math.clamp(
            (input.Position.X - bar.AbsolutePosition.X)
                / bar.AbsoluteSize.X, 0, 1
        )
        value = math.floor(min + (max - min) * ratio)
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        dot.Position = UDim2.new(ratio, 0, 0.5, 0)
        title.Text = label .. "     " .. tostring(value)
        if callback then callback(value) end
    end

    bar.Activated:Connect(function()
        title.Text = label .. "     " .. tostring(value)
    end)

    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch
            or input.UserInputType == Enum.UserInputType.MouseButton1 then
            update(input)
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if UIS:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
            and input.UserInputType == Enum.UserInputType.MouseMovement then
            -- O arrasto do slider é ativado ao tocar na barra.
        end
    end)

    return row
end

local tabs = {
    {name = "VISUALS", icon = "◉"},
    {name = "PLAYER", icon = "♟"},
    {name = "CAMERA", icon = "◎"},
    {name = "WORLD", icon = "◇"},
    {name = "MISC", icon = "⚙"},
    {name = "CONFIG", icon = "▤"},
}

local selectedTab = "PLAYER"
local renderTab

for _, tabData in ipairs(tabs) do
    local tab = make("TextButton", {
        Size = UDim2.new(1, -2, 0, 42),
        BackgroundColor3 = tabData.name == selectedTab
            and Color3.fromRGB(75, 43, 8) or C.BG,
        Text = tabData.icon .. " " .. tabData.name,
        TextColor3 = tabData.name == selectedTab and C.WHITE or C.GREY,
        TextSize = 10,
        Font = Enum.Font.GothamMedium,
        TextXAlignment = Enum.TextXAlignment.Left,
        AutoButtonColor = false,
    }, sidebar)
    round(tab, 5)

    tab.Activated:Connect(function()
        selectedTab = tabData.name

        for _, sibling in ipairs(sidebar:GetChildren()) do
            if sibling:IsA("TextButton") then
                local active = sibling == tab
                sibling.BackgroundColor3 = active
                    and Color3.fromRGB(75, 43, 8) or C.BG
                sibling.TextColor3 = active and C.WHITE or C.GREY
            end
        end

        renderTab(selectedTab)
    end)
end

renderTab = function(name)
    clearContent()

    if name == "VISUALS" then
        section("Visual Settings")
        toggle("FOV Circle (visual)", "FOV Visual")
        toggle("Show FPS", "Mostrar FPS")
        toggle("Show Ping", "Mostrar Ping")
        toggle("RGB Theme", "Tema RGB")
        toggle("Show Test Names", "Nomes de teste")

    elseif name == "PLAYER" then
        section("Player Settings")
        toggle("Visual Zoom", "Zoom Visual")
        section("Movement")
        make("TextLabel", {
            Size = UDim2.new(1, -5, 0, 42),
            BackgroundTransparency = 1,
            Text = "Personaliza controles do teu próprio jogo.",
            TextColor3 = C.GREY,
            TextSize = 12,
            TextWrapped = true,
        }, content)

    elseif name == "CAMERA" then
        section("Field Of View")
        slider("FOV Visual", 40, 120, 75)
        slider("Zoom Visual", 1, 10, 5)
        section("Camera")
        make("TextLabel", {
            Size = UDim2.new(1, -5, 0, 40),
            BackgroundTransparency = 1,
            Text = "Estes sliders são demonstrativos.",
            TextColor3 = C.GREY,
            TextSize = 12,
        }, content)

    elseif name == "WORLD" then
        section("World")
        make("TextLabel", {
            Size = UDim2.new(1, -5, 0, 55),
            BackgroundTransparency = 1,
            Text = "Espaço para marcadores e recursos do teu próprio jogo.",
            TextColor3 = C.GREY,
            TextWrapped = true,
            TextSize = 12,
        }, content)

    elseif name == "MISC" then
        section("Miscellaneous")
        toggle("Animations", "Animações")
        toggle("Button Sounds", "Som dos botões")

    elseif name == "CONFIG" then
        section("Configuration")
        local save = make("TextButton", {
            Size = UDim2.new(1, -5, 0, 42),
            BackgroundColor3 = C.ROW,
            Text = "SAVE SETTINGS",
            TextColor3 = C.ORANGE,
            TextSize = 13,
            Font = Enum.Font.GothamBold,
        }, content)
        round(save, 6)

        local info = make("TextLabel", {
            Size = UDim2.new(1, -5, 0, 45),
            BackgroundTransparency = 1,
            Text = "As configurações ficam na memória desta sessão.",
            TextColor3 = C.GREY,
            TextSize = 11,
            TextWrapped = true,
        }, content)

        save.Activated:Connect(function()
            _G.NANDO_HUB_V6_SETTINGS = table.clone(settings)
            info.Text = "Configurações copiadas para a memória!"
            info.TextColor3 = C.GREEN
        end)
    end
end

renderTab(selectedTab)

-- Indicadores de FPS
local status = make("TextLabel", {
    Size = UDim2.new(0, 150, 0, 25),
    Position = UDim2.new(1, -158, 0, 5),
    BackgroundColor3 = C.BG,
    BackgroundTransparency = 0.15,
    TextColor3 = C.ORANGE,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    Text = "NANDO V6",
}, gui)
round(status, 5)

local frames, elapsed, fps = 0, 0, 0

RunService.RenderStepped:Connect(function(dt)
    frames += 1
    elapsed += dt

    if elapsed >= 1 then
        fps = math.floor(frames / elapsed)
        frames, elapsed = 0, 0

        if settings["Mostrar FPS"] then
            status.Text = "NANDO V6 | FPS: " .. fps
        else
            status.Text = "NANDO HUB V6"
        end
    end

    if settings["Tema RGB"] then
        local color = Color3.fromHSV((os.clock() * 0.15) % 1, 1, 1)
        border.Color = color
        opener.TextColor3 = color
        v6.BackgroundColor3 = color
    else
        border.Color = C.ORANGE
        opener.TextColor3 = C.ORANGE
        v6.BackgroundColor3 = C.ORANGE
    end
end)

print("NANDO HUB V6 carregado!")
