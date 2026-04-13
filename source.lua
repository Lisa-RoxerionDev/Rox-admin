-- Universal Admin System v1.0
-- Schwebender Ball UI inspiriert von Infinite Yield

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- Konfiguration
local CONFIG = {
    PREFIX = ";",
    BALL_SIZE = 60,
    BALL_COLOR = Color3.fromRGB(0, 170, 255),
    ANIMATION_SPEED = 0.3
}

-- UI Erstellung
local function createUI()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "UniversalAdmin"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Schwebender Ball
    local Ball = Instance.new("Frame")
    Ball.Name = "FloatingBall"
    Ball.Size = UDim2.new(0, CONFIG.BALL_SIZE, 0, CONFIG.BALL_SIZE)
    Ball.Position = UDim2.new(0.5, 0, 0.1, 0)
    Ball.AnchorPoint = Vector2.new(0.5, 0.5)
    Ball.BackgroundColor3 = CONFIG.BALL_COLOR
    Ball.BorderSizePixel = 0
    Ball.Active = true
    Ball.Draggable = true
    Ball.Parent = ScreenGui
    
    local BallCorner = Instance.new("UICorner")
    BallCorner.CornerRadius = UDim.new(1, 0)
    BallCorner.Parent = Ball
    
    -- Glow Effekt
    local Glow = Instance.new("ImageLabel")
    Glow.Name = "Glow"
    Glow.Size = UDim2.new(1.4, 0, 1.4, 0)
    Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Glow.AnchorPoint = Vector2.new(0.5, 0.5)
    Glow.BackgroundTransparency = 1
    Glow.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
    Glow.ImageColor3 = CONFIG.BALL_COLOR
    Glow.ImageTransparency = 0.7
    Glow.Parent = Ball
    
    -- Icon
    local Icon = Instance.new("TextLabel")
    Icon.Size = UDim2.new(1, 0, 1, 0)
    Icon.BackgroundTransparency = 1
    Icon.Text = "⚡"
    Icon.TextColor3 = Color3.new(1, 1, 1)
    Icon.TextSize = 32
    Icon.Font = Enum.Font.GothamBold
    Icon.Parent = Ball
    
    -- Command Window
    local CommandWindow = Instance.new("Frame")
    CommandWindow.Name = "CommandWindow"
    CommandWindow.Size = UDim2.new(0, 450, 0, 350)
    CommandWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
    CommandWindow.AnchorPoint = Vector2.new(0.5, 0.5)
    CommandWindow.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    CommandWindow.BorderSizePixel = 0
    CommandWindow.Visible = false
    CommandWindow.Parent = ScreenGui
    
    local WindowCorner = Instance.new("UICorner")
    WindowCorner.CornerRadius = UDim.new(0, 10)
    WindowCorner.Parent = CommandWindow
    
    -- Titlebar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 40)
    TitleBar.BackgroundColor3 = CONFIG.BALL_COLOR
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = CommandWindow
    
    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 10)
    TitleCorner.Parent = TitleBar
    
    local TitleBottomCover = Instance.new("Frame")
    TitleBottomCover.Size = UDim2.new(1, 0, 0, 10)
    TitleBottomCover.Position = UDim2.new(0, 0, 1, -10)
    TitleBottomCover.BackgroundColor3 = CONFIG.BALL_COLOR
    TitleBottomCover.BorderSizePixel = 0
    TitleBottomCover.Parent = TitleBar
    
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 1, 0)
    Title.Position = UDim2.new(0, 10, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = "Universal Admin"
    Title.TextColor3 = Color3.new(1, 1, 1)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = TitleBar
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 30, 0, 30)
    CloseButton.Position = UDim2.new(1, -35, 0.5, 0)
    CloseButton.AnchorPoint = Vector2.new(0, 0.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.new(1, 1, 1)
    CloseButton.TextSize = 24
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BorderSizePixel = 0
    CloseButton.Parent = TitleBar
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(1, 0)
    CloseCorner.Parent = CloseButton
    
    -- Command Input
    local CommandInput = Instance.new("TextBox")
    CommandInput.Name = "CommandInput"
    CommandInput.Size = UDim2.new(1, -20, 0, 35)
    CommandInput.Position = UDim2.new(0, 10, 0, 50)
    CommandInput.BackgroundColor3 = Color3.fromRGB(35, 35, 40)
    CommandInput.BorderSizePixel = 0
    CommandInput.PlaceholderText = "Befehl eingeben (z.B. ;fly, ;speed 100)..."
    CommandInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    CommandInput.Text = ""
    CommandInput.TextColor3 = Color3.new(1, 1, 1)
    CommandInput.TextSize = 14
    CommandInput.Font = Enum.Font.Gotham
    CommandInput.TextXAlignment = Enum.TextXAlignment.Left
    CommandInput.ClearTextOnFocus = false
    CommandInput.Parent = CommandWindow
    
    local InputCorner = Instance.new("UICorner")
    InputCorner.CornerRadius = UDim.new(0, 6)
    InputCorner.Parent = CommandInput
    
    -- Output ScrollingFrame
    local Output = Instance.new("ScrollingFrame")
    Output.Name = "Output"
    Output.Size = UDim2.new(1, -20, 1, -100)
    Output.Position = UDim2.new(0, 10, 0, 95)
    Output.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
    Output.BorderSizePixel = 0
    Output.ScrollBarThickness = 4
    Output.CanvasSize = UDim2.new(0, 0, 0, 0)
    Output.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Output.Parent = CommandWindow
    
    local OutputCorner = Instance.new("UICorner")
    OutputCorner.CornerRadius = UDim.new(0, 6)
    OutputCorner.Parent = Output
    
    local OutputList = Instance.new("UIListLayout")
    OutputList.Padding = UDim.new(0, 5)
    OutputList.Parent = Output
    
    local OutputPadding = Instance.new("UIPadding")
    OutputPadding.PaddingLeft = UDim.new(0, 10)
    OutputPadding.PaddingRight = UDim.new(0, 10)
    OutputPadding.PaddingTop = UDim.new(0, 10)
    OutputPadding.PaddingBottom = UDim.new(0, 10)
    OutputPadding.Parent = Output
    
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    
    return ScreenGui, Ball, CommandWindow, CommandInput, Output, CloseButton
end

-- Logging System
local function addLog(outputFrame, message, color)
    color = color or Color3.fromRGB(255, 255, 255)
    
    local LogLabel = Instance.new("TextLabel")
    LogLabel.Size = UDim2.new(1, 0, 0, 20)
    LogLabel.BackgroundTransparency = 1
    LogLabel.Text = "[" .. os.date("%H:%M:%S") .. "] " .. message
    LogLabel.TextColor3 = color
    LogLabel.TextSize = 13
    LogLabel.Font = Enum.Font.Code
    LogLabel.TextXAlignment = Enum.TextXAlignment.Left
    LogLabel.TextWrapped = true
    LogLabel.AutomaticSize = Enum.AutomaticSize.Y
    LogLabel.Parent = outputFrame
end

-- Admin Commands
local Commands = {}
local FlyEnabled = false
local NoClipEnabled = false
local FlySpeed = 50

Commands.fly = {
    Description = "Aktiviert Flug-Modus",
    Execute = function(args, output)
        FlyEnabled = not FlyEnabled
        if FlyEnabled then
            local character = LocalPlayer.Character
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local rootPart = humanoid and humanoid.RootPart
            
            if rootPart then
                local BV = Instance.new("BodyVelocity")
                BV.Name = "FlyVelocity"
                BV.MaxForce = Vector3.new(9e9, 9e9, 9e9)
                BV.Velocity = Vector3.new(0, 0, 0)
                BV.Parent = rootPart
                
                local BG = Instance.new("BodyGyro")
                BG.Name = "FlyGyro"
                BG.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
                BG.CFrame = rootPart.CFrame
                BG.Parent = rootPart
                
                addLog(output, "Flug aktiviert! WASD zum Fliegen, Q/E für hoch/runter", Color3.fromRGB(0, 255, 0))
            end
        else
            local character = LocalPlayer.Character
            if character then
                local rootPart = character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    if rootPart:FindFirstChild("FlyVelocity") then rootPart.FlyVelocity:Destroy() end
                    if rootPart:FindFirstChild("FlyGyro") then rootPart.FlyGyro:Destroy() end
                end
            end
            addLog(output, "Flug deaktiviert", Color3.fromRGB(255, 150, 0))
        end
    end
}

Commands.speed = {
    Description = "Setzt Laufgeschwindigkeit (Standard: 16)",
    Execute = function(args, output)
        local speed = tonumber(args[1]) or 16
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.WalkSpeed = speed
            addLog(output, "Geschwindigkeit auf " .. speed .. " gesetzt", Color3.fromRGB(0, 255, 0))
        end
    end
}

Commands.jump = {
    Description = "Setzt Sprunghöhe (Standard: 50)",
    Execute = function(args, output)
        local power = tonumber(args[1]) or 50
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.JumpPower = power
            addLog(output, "Sprungkraft auf " .. power .. " gesetzt", Color3.fromRGB(0, 255, 0))
        end
    end
}

Commands.noclip = {
    Description = "Durchgehen durch Wände",
    Execute = function(args, output)
        NoClipEnabled = not NoClipEnabled
        addLog(output, "NoClip " .. (NoClipEnabled and "aktiviert" or "deaktiviert"), 
               NoClipEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 150, 0))
    end
}

Commands.god = {
    Description = "Unbegrenzte Gesundheit",
    Execute = function(args, output)
        local character = LocalPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        
        if humanoid then
            humanoid.MaxHealth = math.huge
            humanoid.Health = math.huge
            addLog(output, "God-Modus aktiviert", Color3.fromRGB(255, 215, 0))
        end
    end
}

Commands.tp = {
    Description = "Teleportiert zu Spieler (;tp Spielername)",
    Execute = function(args, output)
        if not args[1] then
            addLog(output, "Fehler: Spielername fehlt", Color3.fromRGB(255, 0, 0))
            return
        end
        
        local targetName = args[1]:lower()
        local target = nil
        
        for _, player in pairs(Players:GetPlayers()) do
            if player.Name:lower():sub(1, #targetName) == targetName then
                target = player
                break
            end
        end
        
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
                addLog(output, "Teleportiert zu " .. target.Name, Color3.fromRGB(0, 255, 0))
            end
        else
            addLog(output, "Spieler nicht gefunden", Color3.fromRGB(255, 0, 0))
        end
    end
}

Commands.respawn = {
    Description = "Respawnt deinen Charakter",
    Execute = function(args, output)
        local character = LocalPlayer.Character
        if character then
            character:BreakJoints()
            addLog(output, "Respawning...", Color3.fromRGB(255, 255, 0))
        end
    end
}

Commands.cmds = {
    Description = "Zeigt alle Befehle",
    Execute = function(args, output)
        addLog(output, "=== Verfügbare Befehle ===", Color3.fromRGB(0, 170, 255))
        for name, cmd in pairs(Commands) do
            addLog(output, CONFIG.PREFIX .. name .. " - " .. cmd.Description, Color3.fromRGB(200, 200, 200))
        end
    end
}

Commands.clear = {
    Description = "Löscht Output",
    Execute = function(args, output)
        for _, child in pairs(output:GetChildren()) do
            if child:IsA("TextLabel") then
                child
