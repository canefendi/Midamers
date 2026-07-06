-- // Mitamers Software
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local root = character:WaitForChild("HumanoidRootPart")
local humanoid = character:WaitForChild("Humanoid")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MitamersSoftware"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 280)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundTransparency = 1
Title.Text = "Mitamers Software"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBold
Title.Parent = MainFrame

local Watermark = Instance.new("TextLabel")
Watermark.Position = UDim2.new(0, 15, 0, 10)
Watermark.Size = UDim2.new(0, 250, 0, 30)
Watermark.BackgroundTransparency = 1
Watermark.Text = "Mitamers Software"
Watermark.TextColor3 = Color3.fromRGB(0, 255, 150)
Watermark.TextScaled = true
Watermark.Font = Enum.Font.GothamBold
Watermark.TextXAlignment = Enum.TextXAlignment.Left
Watermark.Parent = ScreenGui

-- Fly
local flying = false
local flySpeed = 60

local function toggleFly()
    flying = not flying
    if flying then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "FlyBV"
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = root
        
        local bg = Instance.new("BodyGyro")
        bg.Name = "FlyBG"
        bg.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
        bg.P = 12500
        bg.Parent = root
        
        humanoid.PlatformStand = true
        
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
                
                if dir.Magnitude > 0 then
                    bv.Velocity = dir.Unit * flySpeed
                else
                    bv.Velocity = Vector3.new(0,0,0)
                end
                bg.CFrame = cam.CFrame
                RunService.Heartbeat:Wait()
            end
        end)
    else
        if root:FindFirstChild("FlyBV") then root.FlyBV:Destroy() end
        if root:FindFirstChild("FlyBG") then root.FlyBG:Destroy() end
        humanoid.PlatformStand = false
    end
end

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        toggleFly()
    end
end)

print("✅ Mitamers Software Yüklendi! | Fly için F tuşuna bas")
