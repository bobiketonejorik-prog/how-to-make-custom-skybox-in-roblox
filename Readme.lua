local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Camera = workspace.CurrentCamera

local Player = Players.LocalPlayer

local function ApplyVisuals()
    for _, v in pairs(Lighting:GetChildren()) do
        if (v:IsA("Sky") and v.Name ~= "CustomSky") or v:IsA("Atmosphere") or v:IsA("Clouds") then
            v:Destroy()
        end
    end

    Lighting.ClockTime = 3
    Lighting.Brightness = 2
    Lighting.ExposureCompensation = 0.5
    Lighting.FogEnd = 100000
    Lighting.Ambient = Color3.fromRGB(75, 0, 130)
    Lighting.OutdoorAmbient = Color3.fromRGB(45, 0, 80)

    if not Lighting:FindFirstChild("CustomSky") then
        local sky = Instance.new("Sky")
        sky.Name = "CustomSky"
        sky.SkyboxBk = "rbxassetid://130093177270069"
        sky.SkyboxDn = "rbxassetid://130093177270170"
        sky.SkyboxFt = "rbxassetid://130093177270280"
        sky.SkyboxLf = "rbxassetid://130093177270390"
        sky.SkyboxRt = "rbxassetid://130093177270400"
        sky.SkyboxUp = "rbxassetid://130093177270410"
        sky.SunAngularSize = 0
        sky.Parent = Lighting
    end

    if not Lighting:FindFirstChild("CustomBloom") then
        local bloom = Instance.new("BloomEffect", Lighting)
        bloom.Name = "CustomBloom"
        bloom.Intensity = 1.5
        bloom.Size = 24
        bloom.Threshold = 0.4
    end

    if not Lighting:FindFirstChild("CustomCC") then
        local color = Instance.new("ColorCorrectionEffect", Lighting)
        color.Name = "CustomCC"
        color.Contrast = 0.3
        color.Saturation = 0.5
        color.TintColor = Color3.fromRGB(255, 230, 255)
    end

    if not Camera:FindFirstChild("Madium_Snow_Cam") then
        local snowPart = Instance.new("Part")
        snowPart.Name = "Madium_Snow_Cam"
        snowPart.Transparency = 1
        snowPart.CanCollide = false
        snowPart.CanTouch = false
        snowPart.Massless = true
        snowPart.Size = Vector3.new(1, 1, 1)
        snowPart.Parent = Camera

        local attachment = Instance.new("Attachment", snowPart)
        attachment.Position = Vector3.new(0, 10, -15)

        local emitter = Instance.new("ParticleEmitter", attachment)
        emitter.Texture = "rbxassetid://242252431"
        emitter.Color = ColorSequence.new(Color3.fromRGB(255, 0, 255))
        emitter.LightEmission = 3
        emitter.Size = NumberSequence.new(1, 0.5)
        emitter.Lifetime = NumberRange.new(2, 5)
        emitter.Rate = 250
        emitter.Speed = NumberRange.new(5, 15)
        emitter.SpreadAngle = Vector2.new(360, 360)

        RunService.RenderStepped:Connect(function()
            if snowPart and snowPart.Parent then
                snowPart.CFrame = Camera.CFrame
            end
        end)
    end
end

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Madium Visuals",
    Text = "Made By @IvanKievskii | Camera Snow Active",
    Duration = 5
})

task.spawn(function()
    while task.wait(2) do
        pcall(ApplyVisuals)
    end
end)
