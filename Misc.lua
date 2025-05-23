local Misc = {}

function Misc.Init(tab)
    -- Spin Bot Variables
    local spinBotEnabled = false
    local spinBotSpeed = 10 -- rotations per second
    local spinBotConnection = nil

    -- Spin Bot Toggle
    local SpinBotToggle = tab:CreateToggle({
       Name = "Spin Bot",
       CurrentValue = false,
       Flag = "Toggle5",
       Callback = function(Value)
           spinBotEnabled = Value
           if spinBotEnabled then
               -- Start spinning
               if spinBotConnection then spinBotConnection:Disconnect() end
               
               spinBotConnection = game:GetService("RunService").RenderStepped:Connect(function(delta)
                   if spinBotEnabled then
                       local character = game.Players.LocalPlayer.Character
                       if character then
                           local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                           if humanoidRootPart then
                               -- Rotate the character without affecting the camera
                               humanoidRootPart.CFrame = humanoidRootPart.CFrame * CFrame.Angles(0, math.rad(spinBotSpeed * 360 * delta), 0)
                           end
                       end
                   end
               end)
               
               Rayfield:Notify({
                   Title = "Spin Bot Enabled",
                   Content = "Your character is now spinning",
                   Duration = 3,
                   Image = nil
               })
           else
               -- Stop spinning
               if spinBotConnection then
                   spinBotConnection:Disconnect()
                   spinBotConnection = nil
               end
               Rayfield:Notify({
                   Title = "Spin Bot Disabled",
                   Content = "Spin bot is now off",
                   Duration = 3,
                   Image = nil
               })
           end
       end,
    })

    -- Spin Bot Speed Slider
    local SpinBotSpeedSlider = tab:CreateSlider({
       Name = "Spin Bot Speed",
       Range = {1, 30},
       Increment = 1,
       Suffix = "rotations/sec",
       CurrentValue = 10,
       Flag = "Slider3",
       Callback = function(Value)
           spinBotSpeed = Value
       end,
    })

    -- FOV Changer Variables
    local fovChangerEnabled = false
    local defaultFOV = 70
    local currentFOV = 70
    local fovChanged = false

    -- FOV Changer Toggle
    local FOVChangerToggle = tab:CreateToggle({
       Name = "FOV Changer",
       CurrentValue = false,
       Flag = "Toggle4",
       Callback = function(Value)
           fovChangerEnabled = Value
           if fovChangerEnabled then
               game:GetService("Workspace").CurrentCamera.FieldOfView = currentFOV
               fovChanged = true
               Rayfield:Notify({
                   Title = "FOV Changer Enabled",
                   Content = "Field of View has been modified",
                   Duration = 3,
                   Image = nil
               })
           else
               game:GetService("Workspace").CurrentCamera.FieldOfView = defaultFOV
               fovChanged = false
               Rayfield:Notify({
                   Title = "FOV Changer Disabled",
                   Content = "Field of View reset to default",
                   Duration = 3,
                   Image = nil
               })
           end
       end,
    })

    -- FOV Value Slider
    local FOVSlider = tab:CreateSlider({
       Name = "FOV Value",
       Range = {50, 120},
       Increment = 5,
       Suffix = "°",
       CurrentValue = defaultFOV,
       Flag = "Slider2",
       Callback = function(Value)
           currentFOV = Value
           if fovChangerEnabled and fovChanged then
               game:GetService("Workspace").CurrentCamera.FieldOfView = currentFOV
           end
       end,
    })
end

return Misc
