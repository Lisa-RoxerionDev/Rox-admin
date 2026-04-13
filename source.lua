-- ROX ADMIN v2.0
print("Loading Rox Admin...")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

wait(0.5)

game.StarterGui:SetCore("SendNotification", {
    Title = "Rox Admin";
    Text = "Willkommen " .. LocalPlayer.Name;
    Duration = 3;
})

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RoxAdmin"
ScreenGui.ResetOnSpawn = false

pcall(function()
    ScreenGui.Parent = game.CoreGui
end)

if ScreenGui.Parent ~= game.CoreGui then
    ScreenGui.Parent = LocalPlayer.PlayerGui
end

-- RUNDER BUTTON
local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 70, 0, 70)
ToggleButton.Position = UDim2.new(0, 10, 0.5, -35)
ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 220)
ToggleButton.Text = "ROX"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.TextSize = 18
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.BorderSizePixel = 0
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = ToggleButton

local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
ButtonStroke.Thickness = 3
ButtonStroke.Parent = ToggleButton

-- MAIN FRAME
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 450)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 10)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(80, 80, 80)
MainStroke.Thickness = 2
MainStroke.Parent = MainFrame

-- TITLE BAR
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 50)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 10)
TitleCorner.Parent = TitleBar

local TitleFix = Instance.new("Frame")
TitleFix.Size = UDim2.new(1, 0, 0, 10)
TitleFix.Position = UDim2.new(0, 0, 1, -10)
TitleFix.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleFix.BorderSizePixel = 0
TitleFix.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -60, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "🔧 ROX ADMIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 22
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -45, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 20
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- TABS
local TabBar = Instance.new("Frame")
TabBar.Size = UDim2.new(1, -20, 0, 40)
TabBar.Position = UDim2.new(0, 10, 0, 60)
TabBar.BackgroundTransparency = 1
TabBar.Parent = MainFrame

local HomeTab = Instance.new("TextButton")
HomeTab.Size = UDim2.new(0.48, 0, 1, 0)
HomeTab.Position = UDim2.new(0, 0, 0, 0)
HomeTab.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
HomeTab.Text = "🏠 Home"
HomeTab.TextColor3 = Color3.fromRGB(255, 255, 255)
HomeTab.TextSize = 16
HomeTab.Font = Enum.Font.GothamBold
HomeTab.BorderSizePixel = 0
HomeTab.Parent = TabBar

local HomeCorner = Instance.new("UICorner")
HomeCorner.CornerRadius = UDim.new(0, 8)
HomeCorner.Parent = HomeTab

local CmdTab = Instance.new("TextButton")
CmdTab.Size = UDim2.new(0.48, 0, 1, 0)
CmdTab.Position = UDim2.new(0.52, 0, 0, 0)
CmdTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
CmdTab.Text = "📋 Commands"
CmdTab.TextColor3 = Color3.fromRGB(200, 200, 200)
CmdTab.TextSize = 16
CmdTab.Font = Enum.Font.GothamBold
CmdTab.BorderSizePixel = 0
CmdTab.Parent = TabBar

local CmdCorner = Instance.new("UICorner")
CmdCorner.CornerRadius = UDim.new(0, 8)
CmdCorner.Parent = CmdTab

-- HOME PAGE
local HomePage = Instance.new("Frame")
HomePage.Size = UDim2.new(1, -20, 1, -150)
HomePage.Position = UDim2.new(0, 10, 0, 110)
HomePage.BackgroundTransparency = 1
HomePage.Visible = true
HomePage.Parent = MainFrame

local CmdInput = Instance.new("TextBox")
CmdInput.Size = UDim2.new(1, 0, 0, 45)
CmdInput.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
CmdInput.TextColor3 = Color3.fromRGB(255, 255, 255)
CmdInput.PlaceholderText = "Befehl eingeben (z.B. speed 100)"
CmdInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
CmdInput.Text = ""
CmdInput.TextSize = 16
CmdInput.Font = Enum.Font.Gotham
CmdInput.BorderSizePixel = 0
CmdInput.ClearTextOnFocus = false
CmdInput.Parent = HomePage

local InputCorner = Instance.new("UICorner")
InputCorner.CornerRadius = UDim.new(0, 8)
InputCorner.Parent = CmdInput

local LogScroll = Instance.new("ScrollingFrame")
LogScroll.Size = UDim2.new(1, 0, 1, -55)
LogScroll.Position = UDim2.new(0, 0, 0, 55)
LogScroll.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
LogScroll.BorderSizePixel = 0
LogScroll.ScrollBarThickness = 6
LogScroll.Parent = HomePage

local LogCorner = Instance.new("UICorner")
LogCorner.CornerRadius = UDim.new(0, 8)
LogCorner.Parent = LogScroll

local LogList = Instance.new("UIListLayout")
LogList.Padding = UDim.new(0, 5)
LogList.Parent = LogScroll

local LogPadding = Instance.new("UIPadding")
LogPadding.PaddingTop = UDim.new(0, 10)
LogPadding.PaddingLeft = UDim.new(0, 10)
LogPadding.PaddingRight = UDim.new(0, 10)
LogPadding.Parent = LogScroll

-- COMMANDS PAGE
local CommandsPage = Instance.new("ScrollingFrame")
CommandsPage.Size = UDim2.new(1, -20, 1, -150)
CommandsPage.Position = UDim2.new(0, 10, 0, 110)
CommandsPage.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
CommandsPage.BorderSizePixel = 0
CommandsPage.ScrollBarThickness = 6
CommandsPage.Visible = false
CommandsPage.Parent = MainFrame

local CmdPageCorner = Instance.new("UICorner")
CmdPageCorner.CornerRadius = UDim.new(0, 8)
CmdPageCorner.Parent = CommandsPage

local CmdPageList = Instance.new("UIListLayout")
CmdPageList.Padding = UDim.new(0, 10)
CmdPageList.Parent = CommandsPage

local CmdPagePadding = Instance.new("UIPadding")
CmdPagePadding.PaddingTop = UDim.new(0, 10)
CmdPagePadding.PaddingLeft = UDim.new(0, 10)
CmdPagePadding.PaddingRight = UDim.new(0, 10)
CmdPagePadding.PaddingBottom = UDim.new(0, 10)
CmdPagePadding.Parent = CommandsPage

-- FUNCTIONS
local function addLog(msg, color)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = "• " .. msg
    Label.TextColor3 = color or Color3.fromRGB(220, 220, 220)
    Label.TextSize = 15
    Label.Font = Enum.Font.Gotham
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.TextWrapped = true
    Label.Parent = LogScroll
    
    LogScroll.CanvasSize = UDim2.new(0, 0, 0, LogList.AbsoluteContentSize.Y + 20)
end

local function createCmdBox(name, desc, usage)
    local Box = Instance.new("Frame")
    Box.Size = UDim2.new(1, -10, 0, 80)
    Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Box.BorderSizePixel = 0
    Box.Parent = CommandsPage
    
    local BoxCorner = Instance.new("UICorner")
    BoxCorner.CornerRadius = UDim.new(0, 8)
    BoxCorner.Parent = Box
    
    local NameLbl = Instance.new("TextLabel")
    NameLbl.Size = UDim2.new(1, -20, 0, 22)
    NameLbl.Position = UDim2.new(0, 10, 0, 8)
    NameLbl.BackgroundTransparency = 1
    NameLbl.Text = "📌 " .. name
    NameLbl.TextColor3 = Color3.fromRGB(100, 200, 255)
    NameLbl.TextSize = 17
    NameLbl.Font = Enum.Font.GothamBold
    NameLbl.TextXAlignment = Enum.TextXAlignment.Left
    NameLbl.Parent = Box
    
    local DescLbl = Instance.new("TextLabel")
    DescLbl.Size = UDim2.new(1, -20, 0, 20)
    DescLbl.Position = UDim2.new(0, 10, 0, 32)
    DescLbl.BackgroundTransparency = 1
    DescLbl.Text = desc
    DescLbl.TextColor3 = Color3.fromRGB(190, 190, 190)
    DescLbl.TextSize = 14
    DescLbl.Font = Enum.Font.Gotham
    DescLbl.TextXAlignment = Enum.TextXAlignment.Left
    DescLbl.Parent = Box
    
    local UsageLbl = Instance.new("TextLabel")
    UsageLbl.Size = UDim2.new(1, -20, 0, 20)
    UsageLbl.Position = UDim2.new(0, 10, 0, 54)
    UsageLbl.BackgroundTransparency = 1
    UsageLbl.Text = "💻 Nutzung: " .. usage
    UsageLbl.TextColor3 = Color3.fromRGB(130, 130, 130)
    UsageLbl.TextSize = 13
    UsageLbl.Font = Enum.Font.Gotham
    UsageLbl.TextXAlignment = Enum.TextXAlignment.Left
    UsageLbl.Parent = Box
    
    CommandsPage.CanvasSize = UDim2.new(0, 0, 0, CmdPageList.AbsoluteContentSize.Y + 20)
end

-- TOGGLE BUTTON
local isOpen = false

ToggleButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    MainFrame.Visible = isOpen
    
    if isOpen then
        ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 220, 100)
    else
        ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 220)
    end
end)

-- CLOSE BUTTON
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    isOpen = false
    ToggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 220)
end)

-- TAB SWITCHING
HomeTab.MouseButton1Click:Connect(function()
    HomePage.Visible = true
    CommandsPage.Visible = false
    HomeTab.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
    HomeTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    CmdTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    CmdTab.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

CmdTab.MouseButton1Click:Connect(function()
    HomePage.Visible = false
    CommandsPage.Visible = true
    CmdTab.BackgroundColor3 = Color3.fromRGB(60, 120, 220)
    CmdTab.TextColor3 = Color3.fromRGB(255, 255, 255)
    HomeTab.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    HomeTab.TextColor3 = Color3.fromRGB(200, 200, 200)
end)

-- COMMANDS
local Commands = {}
local
