print("Mitamers Basit Fly")

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local flying = false

game.StarterGui:SetCore("SendNotification", {
    Title = "Mitamers";
    Text = "F tuşu ile uç";
    Duration = 5;
})

mouse.KeyDown:Connect(function(key)
    if key == "f" then
        flying = not flying
        if flying then
            humanoid.PlatformStand = true
            root.Velocity = Vector3.new(0, 50, 0)
            print("Fly Açık")
        else
            humanoid.PlatformStand = false
            root.Velocity = Vector3.new(0,0,0)
            print("Fly Kapalı")
        end
    end
end)

print("Basit Fly Yüklendi")
