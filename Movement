return function(Rayfield, Window)
    local MoveTab = Window:CreateTab("🏃‍♀️‍➡️Movement🏃‍♀️‍➡️", nil)
    local MovementSection = MoveTab:CreateSection("Movement Modifiers")

    -- WalkSpeed Variables
    local walkSpeedEnabled = false
    local defaultWalkSpeed = 16
    local currentWalkSpeed = 50
    local walkSpeedConnection = nil

    -- WalkSpeed Toggle
    local WalkSpeedToggle = MoveTab:CreateToggle({
        Name = "WalkSpeed Modifier",
        CurrentValue = false,
        Flag = "WalkSpeedToggle",
        Callback = function(Value)
            -- ... (keep all the same callback code)
        end,
    })

    -- WalkSpeed Slider
    local WalkSpeedSlider = MoveTab:CreateSlider({
        Name = "WalkSpeed Value",
        Range = {16, 200},
        Increment = 1,
        Suffix = "studs",
        CurrentValue = currentWalkSpeed,
        Flag = "WalkSpeedSlider",
        Callback = function(Value)
            -- ... (keep all the same callback code)
        end,
    })

    -- JumpPower Variables
    local jumpPowerEnabled = false
    local defaultJumpPower = 50
    local currentJumpPower = 100
    local jumpPowerConnection = nil

    -- JumpPower Toggle
    local JumpPowerToggle = MoveTab:CreateToggle({
        Name = "JumpPower Modifier",
        CurrentValue = false,
        Flag = "JumpPowerToggle",
        Callback = function(Value)
            -- ... (keep all the same callback code)
        end,
    })

    -- JumpPower Slider
    local JumpPowerSlider = MoveTab:CreateSlider({
        Name = "JumpPower Value",
        Range = {50, 200},
        Increment = 5,
        Suffix = "power",
        CurrentValue = currentJumpPower,
        Flag = "JumpPowerSlider",
        Callback = function(Value)
            -- ... (keep all the same callback code)
        end,
    })

    -- Infinite Jump Variables
    local infiniteJumpEnabled = false
    local infiniteJumpConnection = nil

    -- Infinite Jump Toggle
    local InfiniteJumpToggle = MoveTab:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = false,
        Flag = "InfiniteJumpToggle",
        Callback = function(Value)
            -- ... (keep all the same callback code)
        end,
    })

    -- Handle character respawns
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
        -- ... (keep all the same character handling code)
    end)
end
