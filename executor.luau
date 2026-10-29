
--==================================================
-- FORCE EXECUTOR ULTIMATE
-- Roblox Studio | LocalScript
-- StarterPlayer > StarterPlayerScripts
--==================================================

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("ForceExecutor")
if old then old:Destroy() end

-- THEME
local C = {
    Background = Color3.fromRGB(10, 11, 15),
    Panel = Color3.fromRGB(18, 19, 25),
    Surface = Color3.fromRGB(27, 28, 35),
    Yellow = Color3.fromRGB(255, 198, 35),
    Gold = Color3.fromRGB(255, 225, 105),
    White = Color3.fromRGB(245, 245, 240),
    Muted = Color3.fromRGB(135, 137, 148),
    Green = Color3.fromRGB(117, 225, 157),
    Red = Color3.fromRGB(255, 103, 112),
}

local LOGO = "rbxassetid://78330806793206"

local function make(class, props, parent)
    local obj = Instance.new(class)
    for k, v in pairs(props) do
        obj[k] = v
    end
    obj.Parent = parent
    return obj
end

local function round(obj, radius)
    make("UICorner", {
        CornerRadius = UDim.new(0, radius)
    }, obj)
end

local function stroke(obj, color, thickness, transparency)
    return make("UIStroke", {
        Color = color,
        Thickness = thickness or 1,
        Transparency = transparency or 0
    }, obj)
end

local function animate(obj, duration, props, style, direction)
    local tw = TweenService:Create(obj, TweenInfo.new(duration, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out), props)
    tw:Play()
    return tw
end

local gui = make("ScreenGui", {
    Name = "ForceExecutor",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 20,
}, playerGui)

--==================================================
-- MAIN WINDOW
--==================================================

local main = make("CanvasGroup", {
    Name = "Main",
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.49),
    Size = UDim2.fromOffset(650, 440),
    BackgroundColor3 = C.Background,
    GroupTransparency = 0,
    Visible = false,
}, gui)
round(main, 16)

local mainStroke = stroke(main, C.Yellow, 1.3, 0.3)

local topGlow = make("Frame", {
    Position = UDim2.fromOffset(20, 0),
    Size = UDim2.new(1, -40, 0, 2),
    BackgroundColor3 = C.Yellow,
    BorderSizePixel = 0,
}, main)
round(topGlow, 2)

make("UIGradient", {
    Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 1),
        NumberSequenceKeypoint.new(0.5, 0),
        NumberSequenceKeypoint.new(1, 1),
    }),
    Color = ColorSequence.new(C.Yellow, C.Gold),
}, topGlow)

-- HEADER
local header = make("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, 0, 66),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0,
    Active = true,
}, main)
round(header, 15)

make("Frame", {
    Position = UDim2.new(0, 0, 1, -15),
    Size = UDim2.new(1, 0, 0, 15),
    BackgroundColor3 = C.Panel,
    BorderSizePixel = 0,
}, header)

make("Frame", {
    Position = UDim2.new(0, 0, 1, -1),
    Size = UDim2.new(1, 0, 0, 1),
    BackgroundColor3 = Color3.fromRGB(67, 57, 35),
    BorderSizePixel = 0,
}, header)

-- IMAGE LOGO
local logo = make("ImageLabel", {
    Name = "ForceLogo",
    Position = UDim2.fromOffset(17, 15),
    Size = UDim2.fromOffset(36, 36),
    BackgroundTransparency = 1,
    Image = LOGO,
    ScaleType = Enum.ScaleType.Fit,
    BorderSizePixel = 0,
}, header)

stroke(logo, C.Yellow, 1, 0.7)

make("TextLabel", {
    Position = UDim2.fromOffset(64, 11),
    Size = UDim2.fromOffset(260, 24),
    BackgroundTransparency = 1,
    Text = "FORCE",
    TextColor3 = C.White,
    TextSize = 19,
    Font = Enum.Font.GothamBlack,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

make("TextLabel", {
    Position = UDim2.fromOffset(65, 36),
    Size = UDim2.fromOffset(280, 16),
    BackgroundTransparency = 1,
    Text = "● LUAU",
    TextColor3 = C.Muted,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

local dot = make("Frame", {
    Position = UDim2.new(1, -174, 0, 27),
    Size = UDim2.fromOffset(7, 7),
    BackgroundColor3 = C.Green,
    BorderSizePixel = 0,
}, header)
round(dot, 10)

make("TextLabel", {
    Position = UDim2.new(1, -162, 0, 20),
    Size = UDim2.fromOffset(76, 20),
    BackgroundTransparency = 1,
    Text = "CLIENT",
    TextColor3 = C.Green,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, header)

-- BUTTON FACTORY
local function button(parent, text, size, position, color, textColor)
    local b = make("TextButton", {
        Size = size,
        Position = position,
        BackgroundColor3 = color,
        BorderSizePixel = 0,
        Text = text,
        TextColor3 = textColor or C.White,
        TextSize = 13,
        Font = Enum.Font.GothamBold,
        AutoButtonColor = false,
    }, parent)
    round(b, 9)

    local outline = stroke(b, Color3.new(1, 1, 1), 1, 0.94)

    b.MouseEnter:Connect(function()
        animate(b, 0.16, {
            BackgroundColor3 = color:Lerp(Color3.new(1, 1, 1), 0.1)
        })
        animate(outline, 0.16, {Transparency = 0.72})
    end)

    b.MouseLeave:Connect(function()
        animate(b, 0.2, {BackgroundColor3 = color})
        animate(outline, 0.2, {Transparency = 0.94})
    end)

    b.Activated:Connect(function()
        local original = b.Size
        animate(b, 0.08, {
            Size = UDim2.new(
                original.X.Scale, original.X.Offset - 2,
                original.Y.Scale, original.Y.Offset - 2
            )
        })

        task.delay(0.09, function()
            if b.Parent then
                animate(b, 0.15, {Size = original})
            end
        end)
    end)

    return b
end

local minimize = button(
    header, "—",
    UDim2.fromOffset(32, 30),
    UDim2.new(1, -78, 0, 18),
    C.Surface
)

local close = button(
    header, "×",
    UDim2.fromOffset(32, 30),
    UDim2.new(1, -39, 0, 18),
    Color3.fromRGB(75, 36, 35),
    C.Red
)

-- EDITOR TITLE
make("TextLabel", {
    Position = UDim2.fromOffset(20, 80),
    Size = UDim2.fromOffset(200, 20),
    BackgroundTransparency = 1,
    Text = "SCRIPT EDITOR",
    TextColor3 = C.White,
    TextSize = 11,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
}, main)

local language = make("TextLabel", {
    Position = UDim2.new(1, -102, 0, 79),
    Size = UDim2.fromOffset(82, 22),
    BackgroundColor3 = Color3.fromRGB(47, 39, 22),
    Text = "● LUAU",
    TextColor3 = C.Yellow,
    TextSize = 10,
    Font = Enum.Font.GothamBold,
}, main)
round(language, 6)

-- EDITOR
local editorPanel = make("Frame", {
    Position = UDim2.fromOffset(18, 108),
    Size = UDim2.new(1, -36, 0, 236),
    BackgroundColor3 = Color3.fromRGB(15, 16, 21),
    BorderSizePixel = 0,
}, main)
round(editorPanel, 10)
stroke(editorPanel, Color3.fromRGB(55, 53, 44), 1, 0.2)

local lineNumbers = make("TextLabel", {
    Size = UDim2.new(0, 42, 1, 0),
    BackgroundColor3 = Color3.fromRGB(20, 21, 27),
    Text = "",
    TextColor3 = Color3.fromRGB(100, 100, 96),
    TextSize = 13,
    Font = Enum.Font.Code,
    TextYAlignment = Enum.TextYAlignment.Top,
    BorderSizePixel = 0,
}, editorPanel)
round(lineNumbers, 0)

make("Frame", {
    Position = UDim2.fromOffset(42, 0),
    Size = UDim2.new(0, 1, 1, 0),
    BackgroundColor3 = Color3.fromRGB(48, 46, 39),
    BorderSizePixel = 0,
}, editorPanel)

local editor = make("TextBox", {
    Name = "Editor",
    Position = UDim2.fromOffset(51, 12),
    Size = UDim2.new(1, -62, 1, -24),
    BackgroundTransparency = 1,
    ClearTextOnFocus = false,
    MultiLine = true,
    TextWrapped = false,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    Font = Enum.Font.Code,
    TextSize = 14,
    TextColor3 = Color3.fromRGB(235, 221, 181),
    PlaceholderColor3 = C.Muted,
    PlaceholderText = "-- Write your Luau here...",
    Text = "print('Hello from FORCE!')",
}, editorPanel)

-- ACTIONS / OUTPUT
local execute = button(
    main, "▶    EXECUTE",
    UDim2.fromOffset(170, 40),
    UDim2.fromOffset(18, 356),
    C.Yellow, C.Background
)

local clear = button(
    main, "●    CLEAR",
    UDim2.fromOffset(115, 40),
    UDim2.fromOffset(198, 356),
    C.Surface
)

local output = make("TextLabel", {
    Position = UDim2.fromOffset(330, 357),
    Size = UDim2.new(1, -350, 0, 38),
    BackgroundTransparency = 1,
    Text = "● READY",
    TextColor3 = C.Green,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Center,
}, main)

-- Safe allowlisted demo commands

execute.Activated:Connect(function()
    local string = editor.Text
    loadstring(tostring(string))()
end)

clear.Activated:Connect(function()
    editor.Text = ""
    output.Text = "● CLEARED\nEditor is empty"
    output.TextColor3 = C.Yellow
end)

--==================================================
-- SMOOTH DRAGGING: MOUSE + TOUCH
--==================================================

local dragging = false
local dragStart
local startPosition
local dragInput
local targetPosition
local dragConnection

header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        dragging = true
        dragStart = input.Position
        startPosition = main.Position
        targetPosition = main.Position

        if dragConnection then
            dragConnection:Disconnect()
        end

        dragConnection = RunService.RenderStepped:Connect(function(dt)
            if not dragging or not targetPosition then return end
            local alpha = 1 - math.exp(-22 * dt)
            main.Position = main.Position:Lerp(targetPosition, alpha)
        end)

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
                if dragConnection then
                    dragConnection:Disconnect()
                    dragConnection = nil
                end
            end
        end)
    end
end)

header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        local delta = input.Position - dragStart
        targetPosition = UDim2.new(
            startPosition.X.Scale,
            startPosition.X.Offset + delta.X,
            startPosition.Y.Scale,
            startPosition.Y.Offset + delta.Y
        )
    end
end)

-- MINIMIZE / RESTORE
local restore = button(
    gui, "⚡ FORCE",
    UDim2.fromOffset(125, 42),
    UDim2.new(0, 20, 0.5, 0),
    C.Yellow, C.Background
)
restore.AnchorPoint = Vector2.new(0, 0.5)
restore.Visible = false

local minimized = false

minimize.Activated:Connect(function()
    if minimized then return end
    minimized = true

    local tw = animate(main, 0.24, {
        Size = UDim2.fromOffset(650, 0),
        GroupTransparency = 1,
    })

    tw.Completed:Once(function()
        if not gui.Parent then return end
        main.Visible = false
        main.Size = UDim2.fromOffset(650, 440)
        main.GroupTransparency = 0
        restore.Visible = true
        restore.Size = UDim2.fromOffset(30, 42)

        animate(restore, 0.25, {
            Size = UDim2.fromOffset(125, 42),
        }, Enum.EasingStyle.Back)
    end)
end)

restore.Activated:Connect(function()
    if not minimized then return end
    minimized = false
    restore.Visible = false
    main.Visible = true
    main.Size = UDim2.fromOffset(580, 390)
    main.GroupTransparency = 1

    animate(main, 0.42, {
        Size = UDim2.fromOffset(650, 440),
        GroupTransparency = 0,
    }, Enum.EasingStyle.Back)
end)

-- CLOSE
local closing = false

close.Activated:Connect(function()
    if closing then return end
    closing = true

    local tw = animate(main, 0.3, {
        Size = UDim2.fromOffset(580, 0),
        GroupTransparency = 1,
        Rotation = 2,
    }, Enum.EasingStyle.Back)

    tw.Completed:Once(function()
        gui:Destroy()
    end)
end)

--==================================================
-- INTRO: F + X COLLISION / IMPACT / LOGO
--==================================================

local intro = make("CanvasGroup", {
    Name = "ForceIntro",
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = C.Background,
    GroupTransparency = 0,
    ZIndex = 100,
}, gui)

local function introLetter(name, text, x)
    return make("TextLabel", {
        Name = name,
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.new(0.5, x, 0.5, 0),
        Size = UDim2.fromOffset(92, 112),
        BackgroundTransparency = 1,
        Text = text,
        TextColor3 = C.Yellow,
        TextSize = 84,
        Font = Enum.Font.GothamBlack,
        ZIndex = 103,
    }, intro)
end

local F = introLetter("LetterF", "F", -230)
local X = introLetter("LetterX", "X", 230)

local introTitle = make("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 100),
    Size = UDim2.fromOffset(380, 38),
    BackgroundTransparency = 1,
    Text = "FORCE",
    TextColor3 = C.White,
    TextTransparency = 1,
    TextSize = 29,
    Font = Enum.Font.GothamBlack,
    ZIndex = 105,
}, intro)

local subtitle = make("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 129),
    Size = UDim2.fromOffset(350, 22),
    BackgroundTransparency = 1,
    Text = "From Exploiters, for Exploiters",
    TextColor3 = C.Muted,
    TextTransparency = 1,
    TextSize = 10,
    Font = Enum.Font.Code,
    ZIndex = 105,
}, intro)

local barBack = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 157),
    Size = UDim2.fromOffset(210, 3),
    BackgroundColor3 = C.Surface,
    BorderSizePixel = 0,
    ZIndex = 102,
}, intro)
round(barBack, 3)

local bar = make("Frame", {
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = C.Yellow,
    BorderSizePixel = 0,
    ZIndex = 103,
}, barBack)
round(bar, 3)

local function makeBurst()
    local flash = make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(8, 8),
        BackgroundColor3 = C.Gold,
        BackgroundTransparency = 0.05,
        BorderSizePixel = 0,
        ZIndex = 108,
    }, intro)
    round(flash, 100)

    animate(flash, 0.38, {
        Size = UDim2.fromOffset(220, 220),
        BackgroundTransparency = 1,
    }, Enum.EasingStyle.Quint)

    local wave = make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(10, 10),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ZIndex = 107,
    }, intro)
    round(wave, 100)

    local outline = stroke(wave, C.Yellow, 3, 0.05)

    animate(wave, 0.48, {
        Size = UDim2.fromOffset(260, 260),
    }, Enum.EasingStyle.Quint)

    animate(outline, 0.48, {
        Transparency = 1,
        Thickness = 0.5,
    })

    for i = 1, 16 do
        local angle = math.pi * 2 * i / 16
        local distance = math.random(65, 145)

        local particle = make("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5),
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(5, 5),
            BackgroundColor3 = i % 3 == 0 and C.Gold or C.Yellow,
            BorderSizePixel = 0,
            ZIndex = 109,
        }, intro)
        round(particle, 100)

        animate(particle, 0.48, {
            Position = UDim2.new(
                0.5, math.cos(angle) * distance,
                0.5, math.sin(angle) * distance
            ),
            BackgroundTransparency = 1,
            Size = UDim2.fromOffset(1, 1),
        }, Enum.EasingStyle.Quint)

        task.delay(0.6, function()
            if particle.Parent then particle:Destroy() end
        end)
    end
end

-- Phase 1: collision
task.wait(0.25)

local mergeInfo = TweenInfo.new(
    0.72,
    Enum.EasingStyle.Quint,
    Enum.EasingDirection.InOut
)

local moveF = TweenService:Create(F, mergeInfo, {
    Position = UDim2.new(0.5, -8, 0.5, 0),
    Rotation = 12,
})

local moveX = TweenService:Create(X, mergeInfo, {
    Position = UDim2.new(0.5, 8, 0.5, 0),
    Rotation = -12,
})

moveF:Play()
moveX:Play()
moveX.Completed:Wait()

if not gui.Parent then return end

-- Phase 2: impact shockwave
makeBurst()

animate(F, 0.16, {
    Position = UDim2.new(0.5, -28, 0.5, 0),
    Rotation = -7,
    TextTransparency = 0.15,
})

animate(X, 0.16, {
    Position = UDim2.new(0.5, 28, 0.5, 0),
    Rotation = 7,
    TextTransparency = 0.15,
})

task.wait(0.18)

-- Phase 3: letters merge and disappear
animate(F, 0.32, {
    Position = UDim2.fromScale(0.5, 0.5),
    Rotation = 0,
    TextTransparency = 1,
}, Enum.EasingStyle.Back)

animate(X, 0.32, {
    Position = UDim2.fromScale(0.5, 0.5),
    Rotation = 0,
    TextTransparency = 1,
}, Enum.EasingStyle.Back)

-- Final logo appears
local introLogo = make("ImageLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(10, 10),
    BackgroundTransparency = 1,
    Image = LOGO,
    ScaleType = Enum.ScaleType.Fit,
    ImageTransparency = 1,
    ZIndex = 106,
}, intro)

animate(introLogo, 0.42, {
    Size = UDim2.fromOffset(100, 100),
    ImageTransparency = 0,
}, Enum.EasingStyle.Back)

animate(introTitle, 0.4, {TextTransparency = 0})
animate(subtitle, 0.4, {TextTransparency = 0})

animate(bar, 0.85, {
    Size = UDim2.new(1, 0, 1, 0),
}, Enum.EasingStyle.Quart)

task.wait(1)

if not gui.Parent then return end

-- Phase 4: dissolve intro
local fade = animate(intro, 0.4, {
    GroupTransparency = 1,
})
fade.Completed:Wait()

if not gui.Parent then return end
intro:Destroy()

-- Phase 5: reveal main menu
main.Visible = true
main.Size = UDim2.fromOffset(570, 385)
main.GroupTransparency = 1
main.Rotation = -2

animate(main, 0.55, {
    Size = UDim2.fromOffset(650, 440),
    GroupTransparency = 0,
    Rotation = 0,
}, Enum.EasingStyle.Back)

-- Ambient border glow
task.spawn(function()
    while gui.Parent do
        animate(mainStroke, 1.1, {
            Transparency = 0.08,
            Thickness = 1.8,
        })
        task.wait(1.1)

        if not gui.Parent then break end

        animate(mainStroke, 1.1, {
            Transparency = 0.35,
            Thickness = 1.2,
        })
        task.wait(1.1)
    end
end)

-- Subtle logo breathing
task.spawn(function()
    while gui.Parent do
        animate(logo, 1.2, {
            ImageColor3 = C.Gold,
        })
        task.wait(1.2)

        if not gui.Parent then break end

        animate(logo, 1.2, {
            ImageColor3 = Color3.new(1, 1, 1),
        })
        task.wait(1.2)
    end
end)
