-- ROX ADMIN v3.0 - COMPLETE VERSION
-- 50+ Commands with Buttons

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "✅ Rox Admin";
    Text = "Erfolgreich geladen!";
    Duration = 3;
})

-- ScreenGui Setup
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoxAdminV3"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

pcall(function()
    ScreenGui.Parent = game.CoreGui
end)

if ScreenGui.Parent ~= game.CoreGui then
    ScreenGui.Parent = LocalPlayer.PlayerGui
end

-- ==========================================
-- RUNDER TOGGLE BUTTON (LINKS MITTIG)
-- ==========================================

local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 65, 0, 65)
ToggleBtn.Position = UDim2.new(0, 15, 0.5, -32)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(80, 80, 255)
ToggleBtn.Text = "R"
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.TextSize = 28
ToggleBtn.Font = Enum.Font.GothamBold
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Active = true
ToggleBtn.Draggable = true
ToggleBtn.Parent = ScreenGui

local BtnCorner = Instance.new("UICorner")
BtnCorner.CornerRadius = UDim.new(1, 0)
BtnCorner.Parent = ToggleBtn

local BtnStroke = Instance.new("UIStroke")
BtnStroke.Color = Color3.fromRGB(255, 255, 255)
BtnStroke.Thickness = 3
BtnStroke.Parent = ToggleBtn

-- ==========================================
-- HAUPT GUI FRAME
-- ==========================================

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 700, 0, 500)
Main.Position = UDim2.new(0.5, -350, 0.5, -250)
Main.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 80, 80)
MainStroke.Thickness = 2
MainStroke.Parent = Main

-- ==========================================
-- TITLE BAR
-- ==========================================

local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = Main

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 12)
TitleFix.Position = UDim2.new(0, 0, 1, -12)
TitleFix.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔧 ROX ADMIN V3.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

-- Drag functionality
local dragging, dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 22
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- ==========================================
-- TAB SYSTEM
-- ==========================================

local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, 0, 0, 45)
TabContainer.Position = UDim2.new(0, 0, 0, 50)
TabContainer.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabContainer.BorderSizePixel = 0
TabContainer.Parent = Main

local TabList = Instance.new("UIListLayout")
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.SortOrder = Enum.SortOrder.LayoutOrder
TabList.Padding = UDim.new(0, 2)
TabList.Parent = TabContainer

local function createTab(name, icon, order)
    local Tab = Instance.new("TextButton")
    Tab.Size = UDim2.new(0, 138, 1, 0)
    Tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Tab.Text = icon .. " " .. name
    Tab.TextColor3 = Color3.fromRGB(200, 200, 200)
    Tab.TextSize = 15
    Tab.Font = Enum.Font.GothamBold
    Tab.BorderSizePixel = 0
    Tab.LayoutOrder = order
    Tab.Parent = TabContainer
    return Tab
end

local PlayerTab = createTab("Player", "👤", 1)
local VisualTab = createTab("Visual", "👁️", 2)
local TeleportTab = createTab("Teleport", "📍", 3)
local MiscTab = createTab("Misc", "⚙️", 4)
local ScriptsTab = createTab("Scripts", "📜", 5)

-- ==========================================
-- PAGE CONTAINER
-- ==========================================

local PageContainer = Instance.new("Frame")
PageContainer.Size = UDim2.new(1, 0, 1, -95)
PageContainer.Position = UDim2.new(0, 0, 0, 95)
PageContainer.BackgroundTransparency = 1
PageContainer.Parent = Main

local function createPage()
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 6
    Page.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 80)
    Page.Visible = false
    Page.Parent = PageContainer
    
    local Grid = Instance.new("UIGridLayout")
    Grid.CellSize = UDim2.new(0, 160, 0, 45)
    Grid.CellPadding = UDim2.new(0, 8, 0, 8)
    Grid.SortOrder = Enum.SortOrder.LayoutOrder
    Grid.Parent = Page
    
    local Padding = Instance.new("UIPadding")
    Padding.PaddingTop = UDim.new(0, 10)
    Padding.PaddingLeft = UDim.new(0, 10)
    Padding.PaddingRight = UDim.new(0, 10)
    Padding.PaddingBottom = UDim.new(0, 10)
    Padding.Parent = Page
    
    return Page
end

local PlayerPage = createPage()
local VisualPage = createPage()
local TeleportPage = createPage()
local MiscPage = createPage()
local ScriptsPage = createPage()

PlayerPage.Visible = true

-- ==========================================
-- BUTTON CREATOR
-- ==========================================

local function createButton(parent, text, color)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 1, 0)
    Btn.BackgroundColor3 = color or Color3.fromRGB(50, 50, 50)
    Btn.Text = text
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.TextSize = 14
    Btn.Font = Enum.Font.GothamSemibold
    Btn.BorderSizePixel = 0
    Btn.Parent = parent
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Btn
    
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color3.fromRGB(100, 100, 100)
    Stroke.Thickness = 1.5
    Stroke.Transparency = 0.7
    Stroke.Parent = Btn
    
    return Btn
end

-- ==========================================
-- GLOBAL VARIABLES
-- ==========================================

local Loops = {
    fly = nil,
    noclip = nil,
    esp = nil,
    speed = nil,
    jump = nil,
    infJump = nil,
    autoFarm = nil
}

local Settings = {
    flySpeed = 50,
    walkSpeed = 16,
    jumpPower = 50,
    espEnabled = false,
    noclipEnabled = false
}

local ESPObjects = {}

-- ==========================================
-- UTILITY FUNCTIONS
-- ==========================================

local function notify(title, text)
    game.StarterGui:SetCore("SendNotification", {
        Title = title;
        Text = text;
        Duration = 3;
    })
end

local function getRoot()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function getHumanoid()
    return LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
end

-- ==========================================
-- PLAYER COMMANDS
-- ==========================================

-- WalkSpeed
local speedBtn = createButton(PlayerPage, "🏃 Speed Boost", Color3.fromRGB(60, 120, 220))
speedBtn.MouseButton1Click:Connect(function()
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = 100
        notify("Speed", "WalkSpeed = 100")
    end
end)

-- Reset Speed
local resetSpeedBtn = createButton(PlayerPage, "↩️ Reset Speed", Color3.fromRGB(80, 80, 80))
resetSpeedBtn.MouseButton1Click:Connect(function()
    local hum = getHumanoid()
    if hum then
        hum.WalkSpeed = 16
        notify("Speed", "WalkSpeed zurückgesetzt")
    end
end)

-- Jump Power
local jumpBtn = createButton(PlayerPage, "⬆️ Super Jump", Color3.fromRGB(60, 120, 220))
jumpBtn.MouseButton1Click:Connect(function()
    local hum = getHumanoid()
    if hum then
        hum.JumpPower = 120
        notify("Jump", "JumpPower = 120")
    end
end)

-- Infinite Jump
local infJumpActive = false
local infJumpBtn = createButton(PlayerPage, "♾️ Infinite Jump", Color3.fromRGB(100, 60, 220))
infJumpBtn.MouseButton1Click:Connect(function()
    infJumpActive = not infJumpActive
    
    if infJumpActive then
        infJumpBtn.BackgroundColor3 = Color3.fromRGB(60, 220, 100)
        notify("Infinite Jump", "Aktiviert")
        
        Loops.infJump = UserInputService.JumpRequest:Connect(function()
            if infJumpActive and getHumanoid() then
                getHumanoid():ChangeState(Enum.HumanoidStateType.Jumping)
            end
        end)
    else
        infJumpBtn.BackgroundColor3 = Color3.fromRGB(100, 60, 220)
        notify("Infinite Jump", "Deaktiviert")
        if Loops.infJump then
            Loops.infJump:Disconnect()
        end
    end
end)

-- God Mode
local godBtn = createButton(PlayerPage, "🛡️ God Mode", Color3.fromRGB(220, 180, 60))
godBtn.MouseButton1Click:Connect(function()
    local hum = getHumanoid()
    if hum then
        hum.MaxHealth = math.huge
        hum.Health = math.huge
        notify("God Mode", "Aktiviert")
    end
end)

-- Fly
local flyActive = false
local flyBtn = createButton(PlayerPage, "✈️ Fly", Color3.fromRGB(60, 180, 220))
flyBtn.MouseButton1Click:Connect(function()
    flyActive = not flyActive
    
    if flyActive then
        flyBtn.BackgroundColor3 = Color3.fromRGB(60, 220, 100)
        notify("Fly", "Aktiviert (WASD + Space/Shift)")
        
        local root = getRoot()
        if not root then return end
        
        local bg = Instance.new("BodyGyro", root)
        bg.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bg.P = 9e4
        
        local bv = Instance.new("BodyVelocity", root)
        bv.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bv.Velocity = Vector3.new(0, 0, 0)
        
        Loops.fly = RunService.Heartbeat:Connect(function()
            if not flyActive then return end
            
            local root = getRoot()
            if not root then return end
            
            local cam = workspace.CurrentCamera
            local speed = 50
            
            bg.CFrame = cam.CFrame
            
            local velocity = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode
