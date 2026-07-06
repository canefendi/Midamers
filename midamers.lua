-- // Mitamers Software - Stabil Fly
print("Mitamers Software Yükleniyor...")

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
Watermark.Size = UDim2.new(0, 280, 0, 35)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Mitamers Software"
Watermark.TextColor3 = Color3.fromRGB(0, 255, 100)
Watermark.TextScaled = true
Watermark.Font = Enum.Font.GothamBold
Watermark.Parent = ScreenGui

local flying = false
local flySpeed = 60
local bv, bg

local function toggleFly()
    flying = not flying
    if flying then
        humanoid.PlatformStand = true
        
        bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Parent = root
        
        bg = Instance.new("BodyGyro")
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bg.P = 12500
        bg.Parent = root
        
        spawn(function()
            while flying and root and root.Parent do
                local cam = workspace.CurrentCamera
                local dir = Vector3.new(0,0,0)
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
                
                bv.Velocity = dir * flySpeed
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

UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.Insert then
        ScreenGui.Enabled = not ScreenGui.Enabled
    end
end)

print("✅ Mitamers Software Yüklendi!")
game.StarterGui:SetCore("SendNotification", {
    Title = "Mitamers Software";
    Text = "F = Fly | Insert = Menü";
    Duration = 8;
})
