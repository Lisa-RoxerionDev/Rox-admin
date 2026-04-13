-- ROX ADMIN v2.0
-- Runder Toggle-Button Style

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

-- Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Rox Admin";
    Text = "Geladen! Klicke den runden Button";
    Duration = 5;
})

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoxAdminGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = game.CoreGui

-- RUNDER TOGGLE BUTTON
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 60, 0, 60)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -30)
ToggleButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ToggleButton.BorderSizePixel = 0
ToggleButton.Image = ""
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = ToggleButton

local Gradient = Instance.new("UIGradient")
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 50, 200)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(50, 150, 255))
}
Gradient.Rotation = 45
Gradient.Parent = ToggleButton

local ButtonText = Instance.new("TextLabel")
ButtonText.Size = UDim2.new(1, 0, 1, 0)
ButtonText.BackgroundTransparency = 1
ButtonText.Text = "ROX"
ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonText.TextSize = 16
ButtonText.Font = Enum.Font.GothamBold
ButtonText.Parent = ToggleButton

local Stroke = Instance.new("UIStroke")
Stroke.Color = Color3.fromRGB(255, 255, 255)
Stroke.Thickness = 2
Stroke.Transparency = 0.5
Stroke.Parent = ToggleButton

-- HAUPT-GUI
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 550, 0, 400)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Active = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(70, 70, 70)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 45)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 12)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 12)
TitleFix.Position = UDim2.new(0, 0, 1, -12)
TitleFix.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -100, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔧 ROX ADMIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -40, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- TAB BUTTONS
local TabContainer = Instance.new("Frame")
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.Position = UDim2.new(0, 10, 0, 55)
TabContainer.BackgroundTransparency = 1
TabContainer.Parent = MainFrame

local function createTab(name, position)
    local Tab = Instance.new("TextButton")
    Tab.Size = UDim2.new(0.48, 0, 1, 0)
    Tab.Position = UDim2.new(position, 0, 0, 0)
    Tab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    Tab.Text = name
    Tab.TextColor3 = Color3.fromRGB(200, 200, 200)
    Tab.TextSize = 16
    Tab.Font = Enum.Font.GothamSemibold
    Tab.BorderSizePixel = 0
    Tab.Parent = TabContainer
    
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, 8)
    Corner.Parent = Tab
    
    return Tab
end

local HomeTab = createTab("🏠 Home", 0)
local CommandsTab = createTab("📋 Commands", 0.52)

-- HOME PAGE
local HomePage = Instance.new("Frame")
HomePage.Name = "HomePage"
HomePage.Size = UDim2.new(1, -20, 1, -140)
HomePage.Position = UDim2.new(0, 10, 0, 100)
HomePage.BackgroundTransparency = 1
HomePage.Visible = true
HomePage.Parent = MainFrame

local CommandBox = Instance.new("TextBox")
CommandBox.Size = UDim2.new(1, 0, 0, 40)
CommandBox.Position = UDim2.new(0, 0, 0, 0)
CommandBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
CommandBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CommandBox.PlaceholderText = "Befehl eingeben... (z.B. speed 100)"
CommandBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
CommandBox.Text = ""
CommandBox.TextSize = 15
CommandBox.Font = Enum.Font.Gotham
CommandBox.ClearTextOnFocus = false
CommandBox.BorderSizePixel = 0
CommandBox.Parent = HomePage

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = CommandBox

local LogFrame = Instance.new("ScrollingFrame")
LogFrame.Size = UDim2.new(1, 0, 1, -50)
LogFrame.Position = UDim2.new(0, 0, 0, 50)
LogFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LogFrame.BorderSizePixel = 0
LogFrame.ScrollBarThickness = 5
LogFrame.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
LogFrame.Parent = HomePage

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 8)
LogCorner.Parent = LogFrame

local LogList = Instance.new("UIListLayout")
LogList.Padding = UDim.new(0, 5)
LogList.SortOrder = Enum.SortOrder.LayoutOrder
LogList.Parent = LogFrame

local LogPadding = Instance.new("UIPadding")
LogPadding.PaddingTop = UDim.new(0, 8)
LogPadding.PaddingLeft = UDim.new(0, 8)
LogPadding.PaddingRight = UDim.new(0, 8)
LogPadding.Parent = LogFrame

-- COMMANDS PAGE
local CommandsPage = Instance.new("ScrollingFrame")
CommandsPage.Name = "CommandsPage"
CommandsPage.Size = UDim2.new(1, -20, 1, -140)
CommandsPage.Position = UDim2.new(0, 10, 0, 100)
CommandsPage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CommandsPage.BorderSizePixel = 0
CommandsPage.ScrollBarThickness = 5
CommandsPage.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
CommandsPage.Visible = false
CommandsPage.Parent = MainFrame

local CmdCorner = Instance.new("UICorner")
CmdCorner.CornerRadius = UDim.new(0, 8)
CmdCorner.Parent = CommandsPage

local CmdList = Instance.new("UIListLayout")
CmdList.Padding = UDim.new(0, 8)
CmdList.SortOrder = Enum.SortOrder.LayoutOrder
CmdList.Parent = CommandsPage

local CmdPadding = Instance.new("UIPadding")
CmdPadding.PaddingTop = UDim.new(0, 10)
CmdPadding.PaddingLeft = UDim.new(0, 10)
CmdPadding.PaddingRight = UDim.new(0, 10)
CmdPadding.PaddingBottom = UDim.new(0, 10)
CmdPadding.Parent = CommandsPage

-- FUNCTIONS
local function addLog(text, color)
    local LogLabel = Instance.new("TextLabel")
    LogLabel.Size = UDim2.new(1, -10, 0, 25)
    LogLabel.BackgroundTransparency = 1
    LogLabel.Text = "• " .. text
    LogLabel.TextColor3 = color or Color3.fromRGB(200, 200, 200)
    LogLabel.TextSize = 14
    LogLabel.Font = Enum.Font.Gotham
    LogLabel.TextXAlignment = Enum.TextXAlignment.Left
    LogLabel.TextWrapped = true
    LogLabel.Parent = LogFrame
    
    LogFrame.CanvasSize = UDim2.new(0, 0, 0, LogList.AbsoluteContentSize.Y + 10)
    LogFrame.CanvasPosition = Vector2.new(0, LogFrame.CanvasSize.Y.Offset)
end

local function createCommandButton(cmdName, cmdDesc, cmdUsage)
    local CmdButton = Instance.new("Frame")
    CmdButton.Size = UDim2.new(1, -10, 0, 70)
    CmdButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    CmdButton.BorderSizePixel = 0
    CmdButton.Parent = CommandsPage
    
    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = CmdButton
    
    local NameLabel = Instance.new("TextLabel")
    NameLabel.Size = UDim2.new(1, -15, 0, 20)
    NameLabel.Position = UDim2.new(0, 10, 0, 5)
    NameLabel.BackgroundTransparency = 1
    NameLabel.Text = "📌 " .. cmdName
    NameLabel.TextColor3 = Color3.fromRGB(100, 200, 255)
    NameLabel.TextSize = 16
    NameLabel.Font = Enum.Font.GothamBold
    NameLabel.TextXAlignment = Enum.TextXAlignment.Left
    NameLabel.Parent = CmdButton
    
    local DescLabel = Instance.new("TextLabel")
    DescLabel.Size = UDim2.new(1, -15, 0, 18)
    DescLabel.Position = UDim2.new(0, 10, 0, 27)
    DescLabel.BackgroundTransparency = 1
    DescLabel.Text = cmdDesc
    DescLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    DescLabel.TextSize = 13
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left
    DescLabel.Parent = CmdButton
    
    local UsageLabel = Instance.new("TextLabel")
    UsageLabel.Size = UDim2.new(1, -15, 0, 18)
    UsageLabel.Position = UDim2.new(0, 10, 0, 47)
    UsageLabel.BackgroundTransparency = 1
    UsageLabel.Text = "💻 " .. cmdUsage
    UsageLabel.TextColor3 = Color3.fromRGB(120, 120, 120)
    UsageLabel.TextSize = 12
    UsageLabel.Font = Enum.Font.GothamMedium
    UsageLabel.TextXAlignment = Enum.TextXAlignment.Left
    UsageLabel.Parent = CmdButton
    
    CommandsPage.CanvasSize = UDim2.new(0, 0, 0, CmdList.AbsoluteContentSize.Y + 20)
end

-- TAB SWITCHING
local currentTab = "Home"

local function switchTab(tabName)
    if tabName == "Home" then
        HomePage.Visible = true
        CommandsPage.Visible = false
        HomeTab.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        HomeTab.TextColor3 = Color3.fromRGB(255, 255, 255)
        CommandsTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        CommandsTab.TextColor3 = Color3.fromRGB(200, 200, 200)
    elseif tabName == "Commands" then
        HomePage.Visible = false
        CommandsPage.Visible = true
        CommandsTab.BackgroundColor3 = Color3.fromRGB(60, 120, 200)
        CommandsTab.TextColor3 = Color3.fromRGB(255, 255, 255)
        HomeTab.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        HomeTab.TextColor3 = Color3.fromRGB(200, 200, 200)
    end
    currentTab = tabName
end

HomeTab.MouseButton1Click:Connect(function()
