Here is a code that you need to activate to change your skybox
code:
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local function ApplyVisuals()
    local Character = Player.Character
    if not Character or not Character:FindFirstChild("HumanoidRootPart") then return end

    
    for _, v in pairs(Lighting:GetChildren()) do
        if (v:IsA("Sky") and v.Name ~= "CustomSky") or v:IsA("Atmosphere") then
            v:Destroy()
        end
    end

    -- 2. Настройка цвета и неба
    Lighting.ClockTime = 3
    Lighting.Brightness = 2
    Lighting.Ambient = Color3.fromRGB(75, 0, 130) 
    Lighting.OutdoorAmbient = Color3.fromRGB(45, 0, 80)

    if not Lighting:FindFirstChild("CustomSky") then
        local sky = Instance.new("Sky", Lighting)
        sky.Name = "CustomSky"
        sky.SkyboxBk = "rbxassetid://130093177270069"
        sky.SkyboxDn = "rbxassetid://130093177270170"
        sky.SkyboxFt = "rbxassetid://130093177270280"
        sky.SkyboxLf = "rbxassetid://130093177270390"
        sky.SkyboxRt = "rbxassetid://130093177270400"
        sky.SkyboxUp = "rbxassetid://130093177270410"
        sky.SunAngularSize = 0
    end

    
    if not Character:FindFirstChild("SnowEmitterPart") then
        local snowPart = Instance.new("Part")
        snowPart.Name = "SnowEmitterPart"
        snowPart.Transparency = 1
        snowPart.CanCollide = false
        snowPart.CanTouch = false
        snowPart.Massless = true 
        snowPart.Size = Vector3.new(1, 1, 1)
        snowPart.Parent = Character

        local attachment = Instance.new("Attachment", snowPart)
        attachment.Position = Vector3.new(0, 25, 0)
        
        local emitter = Instance.new("ParticleEmitter", attachment)
        emitter.Texture = "rbxassetid://242252431"
        emitter.Color = ColorSequence.new(Color3.fromRGB(180, 100, 255))
        emitter.LightEmission = 1
        emitter.Size = NumberSequence.new(0.4, 1.2)
        emitter.Lifetime = NumberRange.new(3, 7)
        emitter.Rate = 120
        emitter.Speed = NumberRange.new(10, 20)
        
        local weld = Instance.new("Weld", snowPart)
        weld.Part0 = Character.HumanoidRootPart
        weld.Part1 = snowPart
    end
end

-- Моментальное обновление при ресете
Player.CharacterAdded:Connect(function()
    task.wait(1)
    ApplyVisuals()
end)

-- Цикл проверки для Rivals
task.spawn(function()
    while task.wait(2) do
        pcall(ApplyVisuals)
    end
end)


game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Made By @IvanKievskii",
    Text = "Hello! If you like my script, please subscribe to my Channel. Thank you!",
    Duration = 5
})
