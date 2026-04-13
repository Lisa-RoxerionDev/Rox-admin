-- Universal Admin Script mit Rayfield UI
-- Für Roblox Executor

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Universal Admin ⚡",
   LoadingTitle = "Universal Admin wird geladen",
   LoadingSubtitle = "by Admin System",
   ConfigurationSaving = {
      Enabled = true,
      FolderName = "UniversalAdmin",
      FileName = "AdminConfig"
   },
   Discord = {
      Enabled = false,
      Invite = "noinvite",
      RememberJoins = true
   },
   KeySystem = false
})

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

-- Variablen
local FlyEnabled = false
local NoClipEnabled = false
local ESPEnabled = false
local InfiniteJumpEnabled = false
local WalkSpeed = 16
local JumpPower = 50

-- Tab: Charakter
local CharacterTab = Window:CreateTab("👤 Charakter", 4483362458)

local SpeedSlider = CharacterTab:CreateSlider({
   Name = "Laufgeschwindigkeit",
   Range = {16, 500},
   Increment = 1,
   Suffix = " Speed",
   CurrentValue = 16,
   Flag = "WalkSpeedSlider",
   Callback = function(Value)
      WalkSpeed = Value
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid.WalkSpeed = Value
      end
   end,
})

local JumpSlider = CharacterTab:CreateSlider({
   Name = "Sprunghöhe",
   Range = {50, 500},
   Increment = 1,
   Suffix = " Power",
   CurrentValue = 50,
   Flag = "JumpPowerSlider",
   Callback = function(Value)
      JumpPower = Value
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid.JumpPower = Value
         humanoid.UseJumpPower = true
      end
   end,
})

local FlyToggle = CharacterTab:CreateToggle({
   Name = "Fliegen (E = hoch, Q = runter)",
   CurrentValue = false,
   Flag = "FlyToggle",
   Callback = function(Value)
      FlyEnabled = Value
      if not Value then
         local character = LocalPlayer.Character
         if character then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
               if rootPart:FindFirstChild("FlyVelocity") then rootPart.FlyVelocity:Destroy() end
               if rootPart:FindFirstChild("FlyGyro") then rootPart.FlyGyro:Destroy() end
            end
         end
      end
   end,
})

local FlySpeedSlider = CharacterTab:CreateSlider({
   Name = "Flug-Geschwindigkeit",
   Range = {10, 300},
   Increment = 5,
   Suffix = " Speed",
   CurrentValue = 50,
   Flag = "FlySpeedSlider",
   Callback = function(Value)
   end,
})

local NoClipToggle = CharacterTab:CreateToggle({
   Name = "NoClip (durch Wände gehen)",
   CurrentValue = false,
   Flag = "NoClipToggle",
   Callback = function(Value)
      NoClipEnabled = Value
   end,
})

local InfiniteJumpToggle = CharacterTab:CreateToggle({
   Name = "Infinite Jump",
   CurrentValue = false,
   Flag = "InfiniteJumpToggle",
   Callback = function(Value)
      InfiniteJumpEnabled = Value
   end,
})

CharacterTab:CreateButton({
   Name = "God Mode (Unendlich HP)",
   Callback = function()
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      if humanoid then
         humanoid.MaxHealth = math.huge
         humanoid.Health = math.huge
         Rayfield:Notify({
            Title = "God Mode",
            Content = "Unendliche Gesundheit aktiviert!",
            Duration = 3,
            Image = 4483362458,
         })
      end
   end,
})

CharacterTab:CreateButton({
   Name = "Reset Charakter",
   Callback = function()
      local character = LocalPlayer.Character
      if character then
         character:BreakJoints()
      end
   end,
})

-- Tab: Teleport
local TeleportTab = Window:CreateTab("🌍 Teleport", 4483362458)

local PlayerDropdown = TeleportTab:CreateDropdown({
   Name = "Wähle Spieler",
   Options = {},
   CurrentOption = "",
   Flag = "PlayerDropdown",
   Callback = function(Option)
   end,
})

-- Aktualisiere Spieler-Liste
local function updatePlayerList()
   local playerNames = {}
   for _, player in pairs(Players:GetPlayers()) do
      if player ~= LocalPlayer then
         table.insert(playerNames, player.Name)
      end
   end
   PlayerDropdown:Refresh(playerNames)
end

updatePlayerList()
Players.PlayerAdded:Connect(updatePlayerList)
Players.PlayerRemoving:Connect(updatePlayerList)

TeleportTab:CreateButton({
   Name = "Teleport zu Spieler",
   Callback = function()
      local selectedPlayer = PlayerDropdown.CurrentOption
      if selectedPlayer and selectedPlayer ~= "" then
         local target = Players:FindFirstChild(selectedPlayer)
         if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local character = LocalPlayer.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
               character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
               Rayfield:Notify({
                  Title = "Teleport",
                  Content = "Teleportiert zu " .. selectedPlayer,
                  Duration = 3,
                  Image = 4483362458,
               })
            end
         end
      end
   end,
})

local WaypointName = ""
local Waypoints = {}

local WaypointInput = TeleportTab:CreateInput({
   Name = "Waypoint Name",
   PlaceholderText = "z.B. Spawn",
   RemoveTextAfterFocusLost = false,
   Callback = function(Text)
      WaypointName = Text
   end,
})

TeleportTab:CreateButton({
   Name = "Waypoint setzen",
   Callback = function()
      if WaypointName and WaypointName ~= "" then
         local character = LocalPlayer.Character
         if character and character:FindFirstChild("HumanoidRootPart") then
            Waypoints[WaypointName] = character.HumanoidRootPart.CFrame
            Rayfield:Notify({
               Title = "Waypoint",
               Content = "Waypoint '" .. WaypointName .. "' gespeichert!",
               Duration = 3,
               Image = 4483362458,
            })
         end
      end
   end,
})

TeleportTab:CreateButton({
   Name = "Zu Waypoint teleportieren",
   Callback = function()
      if WaypointName and Waypoints[WaypointName] then
         local character = LocalPlayer.Character
         if character and character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = Waypoints[WaypointName]
            Rayfield:Notify({
               Title = "Waypoint",
               Content = "Teleportiert zu '" .. WaypointName .. "'",
               Duration = 3,
               Image = 4483362458,
            })
         end
      end
   end,
})

-- Tab: Visuell
local VisualTab = Window:CreateTab("👁️ Visuell", 4483362458)

local ESPToggle = VisualTab:CreateToggle({
   Name = "ESP (Spieler durch Wände sehen)",
   CurrentValue = false,
   Flag = "ESPToggle",
   Callback = function(Value)
      ESPEnabled = Value
      if Value then
         for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
               addESP(player.Character)
            end
         end
      else
         removeAllESP()
      end
   end,
})

local FullbrightToggle = VisualTab:CreateToggle({
   Name = "Fullbright (Alles hell)",
   CurrentValue = false,
   Flag = "FullbrightToggle",
   Callback = function(Value)
      if Value then
         game:GetService("Lighting").Ambient = Color3.new(1, 1, 1)
         game:GetService("Lighting").Brightness = 2
         game:GetService("Lighting").FogEnd = 100000
         game:GetService("Lighting").GlobalShadows = false
         game:GetService("Lighting").OutdoorAmbient = Color3.new(1, 1, 1)
      else
         game:GetService("Lighting").Ambient = Color3.new(0.5, 0.5, 0.5)
         game:GetService("Lighting").Brightness = 1
         game:GetService("Lighting").FogEnd = 100000
         game:GetService("Lighting").GlobalShadows = true
         game:GetService("Lighting").OutdoorAmbient = Color3.new(0.5, 0.5, 0.5)
      end
   end,
})

-- Tab: Sonstiges
local MiscTab = Window:CreateTab("⚙️ Sonstiges", 4483362458)

MiscTab:CreateButton({
   Name = "Anti-AFK",
   Callback = function()
      local VirtualUser = game:GetService("VirtualUser")
      game:GetService("Players").LocalPlayer.Idled:Connect(function()
         VirtualUser:CaptureController()
         VirtualUser:ClickButton2(Vector2.new())
      end)
      Rayfield:Notify({
         Title = "Anti-AFK",
         Content = "Anti-AFK aktiviert!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

MiscTab:CreateButton({
   Name = "Rejoin Server",
   Callback = function()
      game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
   end,
})

MiscTab:CreateButton({
   Name = "Server Hop (neuer Server)",
   Callback = function()
      local servers = {}
      local req = game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
      local body = game:GetService("HttpService"):JSONDecode(req)
      
      if body and body.data then
         for _, server in pairs(body.data) do
            if server.playing < server.maxPlayers and server.id ~= game.JobId then
               game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
               return
            end
         end
      end
   end,
})

MiscTab:CreateButton({
   Name = "UI Kopieren (Clipboard)",
   Callback = function()
      setclipboard("loadstring(game:HttpGet('https://raw.githubusercontent.com/DEINNAME/DEINREPO/main/source.lua'))()")
      Rayfield:Notify({
         Title = "Clipboard",
         Content = "Loadstring in Zwischenablage kopiert!",
         Duration = 3,
         Image = 4483362458,
      })
   end,
})

-- ESP Funktionen
function addESP(character)
   if not character or character:FindFirstChild("ESPBox") then return end
   
   local rootPart = character:FindFirstChild("HumanoidRootPart")
   if not rootPart then return end
   
   local box = Instance.new("BoxHandleAdornment")
   box.Name = "ESPBox"
   box.Size = Vector3.new(4, 5, 1)
   box.Color3 = Color3.fromRGB(255, 0, 0)
   box.Transparency = 0.7
   box.AlwaysOnTop = true
   box.ZIndex = 5
   box.Adornee = rootPart
   box.Parent = character
   
   local humanoid = character:FindFirstChildOfClass("Humanoid")
   if humanoid then
      local billboard = Instance.new("BillboardGui")
      billboard.Name = "ESPName"
      billboard.Adornee = rootPart
      billboard.Size = UDim2.new(0, 100, 0, 50)
      billboard.StudsOffset = Vector3.new(0, 3, 0)
      billboard.AlwaysOnTop = true
      billboard.Parent = character
      
      local textLabel = Instance.new("TextLabel")
      textLabel.Size = UDim2.new(1, 0, 1, 0)
      textLabel.BackgroundTransparency = 1
      textLabel.Text = character.Name
      textLabel.TextColor3 = Color3.new(1, 1, 1)
      textLabel.TextStrokeTransparency = 0
      textLabel.TextSize = 16
      textLabel.Font = Enum.Font.GothamBold
      textLabel.Parent = billboard
   end
end

function removeAllESP()
   for _, player in pairs(Players:GetPlayers()) do
      if player.Character then
         if player.Character:FindFirstChild("ESPBox") then
            player.Character.ESPBox:Destroy()
         end
         if player.Character:FindFirstChild("ESPName") then
            player.Character.ESPName:Destroy()
         end
      end
   end
end

-- Charakter Update Loop
LocalPlayer.CharacterAdded:Connect(function(character)
   character:WaitForChild("Humanoid").WalkSpeed = WalkSpeed
   character:WaitForChild("Humanoid").JumpPower = JumpPower
   character:WaitForChild("Humanoid").UseJumpPower = true
end)

-- Fly System
RunService.RenderStepped:Connect(function()
   if FlyEnabled then
      local character = LocalPlayer.Character
      local humanoid = character and character:FindFirstChildOfClass("Humanoid")
      local rootPart = humanoid and humanoid.RootPart
      
      if rootPart then
         local camera = workspace.CurrentCamera
         local speed = Rayfield.Flags["FlySpeedSlider"].CurrentValue or 50
         
         if not rootPart:FindFirstChild("FlyVelocity") then
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
         end
         
         local BV = rootPart:FindFirstChild("FlyVelocity")
         local BG = rootPart:FindFirstChild("FlyGyro")
         
         if BV and BG then
            local velocity = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
               velocity = velocity + (camera.CFrame.LookVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
               velocity = velocity - (camera.CFrame.LookVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
               velocity = velocity - (camera.CFrame.RightVector * speed)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
