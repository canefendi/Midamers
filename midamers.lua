-- Mitamers Fly Test
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")

game.StarterGui:SetCore("SendNotification", {
    Title = "Mitamers";
    Text = "Fly Test";
    Duration = 5;
})

root.Velocity = Vector3.new(0, 100, 0)

print("Fly Test Çalıştı")
