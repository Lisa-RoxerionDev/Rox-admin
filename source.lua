-- ROX ADMIN SCRIPT v1.0
-- by Lisa-RoxerionDev

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Willkommens-Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Rox Admin";
    Text = "Willkommen " .. LocalPlayer.Name .. "!";
    Duration = 5;
})

-- GUI erstellen
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoxAdminGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

-- Haupt-Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Runde Ecken
local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 10)
Corner.Parent = MainFrame

-- Titel-Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

-- Titel-Text
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 10, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔧 ROX ADMIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Command Input
local CommandBox = Instance.new("TextBox")
CommandBox.Size = UDim2.new(1, -20, 0, 35)
CommandBox.Position = UDim2.new(0, 10, 1, -45)
CommandBox.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandBox.PlaceholderText = "Befehl eingeben (z.B. speed 100)..."
CommandBox.Text = ""
CommandBox.TextSize = 14
CommandBox.Font = Enum.Font.Gotham
CommandBox.ClearTextOnFocus = false
CommandBox.Parent = MainFrame

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 5)
BoxCorner.Parent = CommandBox

-- Output/Log Frame
local LogFrame = Instance.new("ScrollingFrame")
LogFrame.Size = UDim2.new(1, -20, 1, -100)
LogFrame.Position = UDim2.new(0, 10, 0, 50)
LogFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
LogFrame.BorderSizePixel = 0
LogFrame.ScrollBarThickness = 6
LogFrame.Parent = MainFrame

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 5)
LogCorner.Parent = LogFrame

local LogList = Instance.new("UIListLayout")
LogList.Padding = UDim.new(0, 5)
LogList.Parent = LogFrame

-- Log Funktion
local function addLog(text, color)
    local LogLabel = Instance.new("TextLabel")
    LogLabel.Size = UDim2.new(1, -10, 0, 20)
    LogLabel.BackgroundTransparency = 1
    LogLabel.Text = "• " .. text
    LogLabel.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    LogLabel.TextSize = 13
    LogLabel.Font = Enum.Font.Gotham
    LogLabel.TextXAlignment = Enum.TextXAlignment.Left
    LogLabel.Parent = LogFrame
    
    LogFrame.CanvasSize = UDim2.new(0, 0, 0, LogList.AbsoluteContentSize.Y)
end

-- Commands System
local Commands = {}
local Loops = {}

-- Speed Command
Commands.speed = function(args)
    local speed = tonumber(args[1]) or 16
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = speed
        addLog("Speed auf " .. speed .. " gesetzt", Color3.fromRGB(0, 255, 0))
    else
        addLog("Fehler: Character nicht gefunden", Color3.fromRGB(255, 0, 0))
    end
end

-- Jump Command
Commands.jump = function(args)
    local power = tonumber(args[1]) or 50
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = power
        addLog("Jump Power auf " .. power .. " gesetzt", Color3.fromRGB(0, 255, 0))
    else
        addLog("Fehler: Character nicht gefunden", Color3.fromRGB(255, 0, 0))
    end
end

-- God Mode Command
Commands.god = function(args)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.MaxHealth = math.huge
        LocalPlayer.Character.Humanoid.Health = math.huge
        addLog("God Mode aktiviert", Color3.fromRGB(0, 255, 0))
    else
        addLog("Fehler: Character nicht gefunden", Color3.fromRGB(255, 0, 0))
    end
end

-- Teleport Command
Commands.tp = function(args)
    local targetName = args[1]
    if not targetName then
        addLog("Fehler: Spielername fehlt", Color3.fromRGB(255, 0, 0))
        return
    end
    
    local target = nil
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name:lower():sub(1, #targetName) == targetName:lower() then
            target = player
            break
        end
    end
    
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            addLog("Zu " .. target.Name .. " teleportiert", Color3.fromRGB(0, 255, 0))
        end
    else
        addLog("Fehler: Spieler nicht gefunden", Color3.fromRGB(255, 0, 0))
    end
end

-- Fly Command
Commands.fly = function(args)
    if Loops.flying then
        addLog("Fly bereits aktiv", Color3.fromRGB(255, 255, 0))
        return
    end
    
    local speed = tonumber(args[1]) or 50
    
    Loops.flying = RunService.Heartbeat:Connect(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local cam = workspace.CurrentCamera
            
            hrp.Velocity = Vector3.new(0, 0, 0)
            
            local movement = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                movement = movement + (cam.CFrame.LookVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                movement = movement - (cam.CFrame.LookVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                movement = movement - (cam.CFrame.RightVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                movement = movement + (cam.CFrame.RightVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
                movement = movement + Vector3.new(0, speed, 0)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
                movement = movement - Vector3.new(0, speed, 0)
            end
            
            hrp.CFrame = hrp.CFrame + movement * 0.1
        end
    end)
    
    addLog("Fly aktiviert (Speed: " .. speed .. ")", Color3.fromRGB(0, 255, 0))
end

-- Unfly Command
Commands.unfly = function(args)
    if Loops.flying then
        Loops.flying:Disconnect()
        Loops.flying = nil
        addLog("Fly deaktiviert", Color3.fromRGB(0, 255, 0))
    else
        addLog("Fly ist nicht aktiv", Color3.fromRGB(255, 255, 0))
    end
end

-- NoClip Command
Commands.noclip = function(args)
    if Loops.noclip then
        addLog("NoClip bereits aktiv", Color3.fromRGB(255, 255, 0))
        return
    end
    
    Loops.noclip = RunService.Stepped:Connect(function()
        if LocalPlayer.Character then
            for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
    
    addLog("NoClip aktiviert", Color3.fromRGB(0, 255, 0))
end

-- Clip Command
Commands.clip = function(args)
    if Loops.noclip then
        Loops.noclip:Disconnect()
        Loops.noclip = nil
        addLog("NoClip deaktiviert", Color3.fromRGB(0, 255, 0))
    else
        addLog("NoClip ist nicht aktiv", Color3.fromRGB(255, 255, 0))
    end
end

-- Reset Command
Commands.reset = function(args)
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.Health = 0
        addLog("Character resettet", Color3.fromRGB(0, 255, 0))
    end
end

-- Help Command
Commands.help = function(args)
    addLog("=== ROX ADMIN BEFEHLE ===", Color3.fromRGB(255, 255, 0))
    addLog("speed [zahl] - Ändert Geschwindigkeit", Color3.fromRGB(150, 150, 255))
    addLog("jump [zahl] - Ändert Jump Power", Color3.fromRGB(150, 150, 255))
    addLog("god - God Mode", Color3.fromRGB(150, 150, 255))
    addLog("tp [spieler] - Teleportiere zu Spieler", Color3.fromRGB(150, 150, 255))
    addLog("fly [speed] - Aktiviert Fly", Color3.fromRGB(150, 150, 255))
    addLog("unfly - Deaktiviert Fly", Color3.fromRGB(150, 150, 255))
    addLog("noclip - Aktiviert NoClip", Color3.fromRGB(150, 150, 255))
    addLog("clip - Deaktiviert NoClip", Color3.fromRGB(150, 150, 255))
    addLog("reset - Resettet Character", Color3.fromRGB(150, 150, 255))
end

-- Command Parser
local function executeCommand(input)
    local parts = string.split(input, " ")
    local cmd = parts[1]:lower()
    table.remove(parts, 1)
    
    if Commands[cmd] then
        Commands[cmd](parts)
    else
        addLog("Unbekannter Befehl: " .. cmd, Color3.fromRGB(255, 0, 0))
        addLog("Nutze 'help' für alle Befehle", Color3.fromRGB(255, 255, 0))
    end
end

-- Input Handler
CommandBox.FocusLost:Connect(function(enterPressed)
    if enterPressed and CommandBox.Text ~= "" then
        executeCommand(CommandBox.Text)
        CommandBox.Text = ""
    end
end)

-- Willkommens-Nachricht
addLog("Rox Admin geladen!", Color3.fromRGB(0, 255, 255))
addLog("Nutze 'help' für alle Befehle", Color3.fromRGB(255, 255, 0))

print("Rox Admin v1.0 erfolgreich geladen!")
