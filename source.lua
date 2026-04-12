-- Mein erstes Admin Script
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Einfache Notification
game.StarterGui:SetCore("SendNotification", {
    Title = "Admin geladen!";
    Text = "Willkommen " .. LocalPlayer.Name;
    Duration = 5;
})

-- Speed Command
LocalPlayer.Chatted:Connect(function(message)
    if message:lower():sub(1, 7) == "/speed " then
        local speed = tonumber(message:sub(8))
        if speed and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = speed
        end
    end
    
    if message:lower() == "/jump" then
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = 100
        end
    end
end)

print("Admin Script geladen - Nutze /speed 100 oder /jump")
