-- // Mitamers Software - Visible Fly
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

-- Network Ownership (daha görünür olması için)
root:SetNetworkOwner(nil)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player.PlayerGui

local Watermark = Instance.new("TextLabel")
Watermark.Position = UDim2.new(0, 10, 0, 10)
Watermark.Size = UDim2.new(0, 250, 0, 30)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Mitamers Software"
Watermark.TextColor3 = Color3.fromRGB(0, 255, 150)
Watermark.TextScaled = true
Watermark.Font = Enum.Font.GothamBold
Watermark.Parent = ScreenGui

local flying = false
local flySpeed = 70

local function toggleFly()
    flying = not flying
    if flying then
        humanoid.PlatformStand = true
        spawn(function()
            while flying and character and character.Parent do
                local cam = workspace.CurrentCamera
                local dir = Vector3.new()
                
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
                if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Vector3.new(0,1,0) end
                
                root.Velocity = dir.Unit * flySpeed
                RunService.Heartbeat:Wait()
            end
        end)
    else
        humanoid.PlatformStand = false
        root.Velocity = Vector3.new(0,0,0)
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

print("Mitamers Software - Visible Fly Aktif | F = Fly | Insert = Menü")
