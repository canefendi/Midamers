-- Mitamers General Fly
print("Mitamers General Fly Yükleniyor...")

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

root:SetNetworkOwner(nil)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Watermark = Instance.new("TextLabel")
Watermark.Position = UDim2.new(0, 10, 0, 10)
Watermark.Size = UDim2.new(0, 300, 0, 40)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Mitamers Software"
Watermark.TextColor3 = Color3.fromRGB(0, 255, 150)
Watermark.TextScaled = true
Watermark.Font = Enum.Font.GothamBold
Watermark.Parent = ScreenGui

local flying = false
local flySpeed = 60

local bv = nil
local bg = nil

local function toggleFly()
    flying = not flying
    if flying then
        humanoid.PlatformStand = true
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = root
        
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 10000
        bg.Parent = root
        
        spawn(function()
            while flying and root.Parent do
                local cam = workspace.CurrentCamera
                local move = Vector3.new()
                
                if UserInputService:IsKeyDown("W") then move = move + cam.CFrame.LookVector end
                if UserInputService:IsKeyDown("S") then move = move - cam.CFrame.LookVector end
                if UserInputService:IsKeyDown("A") then move = move - cam.CFrame.RightVector end
                if UserInputService:IsKeyDown("D") then move = move + cam.CFrame.RightVector end
                if UserInputService:IsKeyDown("Space") then move = move + Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown("LeftControl") then move = move - Vector3.new(0,1,0) end
                
                bv.Velocity = move.Unit * flySpeed
                bg.CFrame = cam.CFrame
                RunService.Heartbeat:Wait()
            end
        end)
    else
        humanoid.PlatformStand = false
        if bv then bv:Destroy() end
        if bg then bg:Destroy() end
    end
end

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end
end)

print("✅ Mitamers General Fly Yüklendi | F tuşu ile uç")
game.StarterGui:SetCore("SendNotification", {
    Title = "Mitamers Software";
    Text = "F = Fly Aç/Kapat";
    Duration = 8;
})
