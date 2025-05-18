local Movement = {}

function Movement.Init(tab)
    -- WalkSpeed Variables
    local walkSpeedEnabled = false
    local defaultWalkSpeed = 16
    local currentWalkSpeed = 50
    local walkSpeedConnection = nil

    -- WalkSpeed Toggle
    local WalkSpeedToggle = tab:CreateToggle({
        Name = "WalkSpeed Modifier",
        CurrentValue = false,
        Flag = "WalkSpeedToggle",
        Callback = function(Value)
            walkSpeedEnabled = Value
            local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            if walkSpeedEnabled then
                if humanoid then
                    humanoid.WalkSpeed = currentWalkSpeed
                end
                walkSpeedConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
                    task.wait(0.5) -- Wait for character to fully load
                    humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.WalkSpeed = currentWalkSpeed
                    end
                end)
                Rayfield:Notify({
                    Title = "WalkSpeed Enabled",
                    Content = "Your WalkSpeed has been modified to " .. currentWalkSpeed,
                    Duration = 3,
                    Image = nil
                })
            else
                if walkSpeedConnection then
                    walkSpeedConnection:Disconnect()
                end
                if humanoid then
                    humanoid.WalkSpeed = defaultWalkSpeed
                end
                Rayfield:Notify({
                    Title = "WalkSpeed Disabled",
                    Content = "Your WalkSpeed has been reset to default",
                    Duration = 3,
                    Image = nil
                })
            end
        end,
    })

    -- WalkSpeed Slider
    local WalkSpeedSlider = tab:CreateSlider({
        Name = "WalkSpeed Value",
        Range = {16, 200},
        Increment = 1,
        Suffix = "studs",
        CurrentValue = currentWalkSpeed,
        Flag = "WalkSpeedSlider",
        Callback = function(Value)
            currentWalkSpeed = Value
            if walkSpeedEnabled then
                local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = currentWalkSpeed
                end
            end
        end,
    })

    -- JumpPower Variables
    local jumpPowerEnabled = false
    local defaultJumpPower = 50
    local currentJumpPower = 100
    local jumpPowerConnection = nil

    -- JumpPower Toggle
    local JumpPowerToggle = tab:CreateToggle({
        Name = "JumpPower Modifier",
        CurrentValue = false,
        Flag = "JumpPowerToggle",
        Callback = function(Value)
            jumpPowerEnabled = Value
            local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            
            if jumpPowerEnabled then
                if humanoid then
                    humanoid.JumpPower = currentJumpPower
                end
                jumpPowerConnection = game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
                    task.wait(0.5) -- Wait for character to fully load
                    humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid.JumpPower = currentJumpPower
                    end
                end)
                Rayfield:Notify({
                    Title = "JumpPower Enabled",
                    Content = "Your JumpPower has been modified to " .. currentJumpPower,
                    Duration = 3,
                    Image = nil
                })
            else
                if jumpPowerConnection then
                    jumpPowerConnection:Disconnect()
                end
                if humanoid then
                    humanoid.JumpPower = defaultJumpPower
                end
                Rayfield:Notify({
                    Title = "JumpPower Disabled",
                    Content = "Your JumpPower has been reset to default",
                    Duration = 3,
                    Image = nil
                })
            end
        end,
    })

    -- JumpPower Slider
    local JumpPowerSlider = tab:CreateSlider({
        Name = "JumpPower Value",
        Range = {50, 200},
        Increment = 5,
        Suffix = "power",
        CurrentValue = currentJumpPower,
        Flag = "JumpPowerSlider",
        Callback = function(Value)
            currentJumpPower = Value
            if jumpPowerEnabled then
                local humanoid = game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid.JumpPower = currentJumpPower
                end
            end
        end,
    })

    -- Infinite Jump Variables
    local infiniteJumpEnabled = false
    local infiniteJumpConnection = nil

    -- Infinite Jump Toggle
    local InfiniteJumpToggle = tab:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Flag = "InfiniteJumpToggle",
        Callback = function(Value)
            infiniteJumpEnabled = Value
            
            if infiniteJumpEnabled then
                Rayfield:Notify({
                    Title = "Infinite Jump Enabled",
                    Content = "You can now jump infinitely!",
                    Duration = 3,
                    Image = nil
                })
                
                -- Disconnect previous connection if it exists
                if infiniteJumpConnection then
                    infiniteJumpConnection:Disconnect()
                end
                
                -- Connect to UserInputService
                infiniteJumpConnection = game:GetService("UserInputService").JumpRequest:Connect(function()
                    if infiniteJumpEnabled then
                        local character = game:GetService("Players").LocalPlayer.Character
                        if character then
                            local humanoid = character:FindFirstChildOfClass("Humanoid")
                            if humanoid then
                                humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                            end
                        end
                    end
                end)
            else
                if infiniteJumpConnection then
                    infiniteJumpConnection:Disconnect()
                end
                Rayfield:Notify({
                    Title = "Infinite Jump Disabled",
                    Content = "Normal jumping restored",
                    Duration = 3,
                    Image = nil
                })
            end
        end,
    })
end

return Movement
