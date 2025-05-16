return function(Rayfield, Window, MainTab, MoveTab)
    local MovementSection = MoveTab:CreateSection("Movement")

    -- WalkSpeed
    local walkSpeedEnabled = false
    local defaultWalkSpeed = 16
    local currentWalkSpeed = 50

    MovementSection:CreateToggle({
        Name = "WalkSpeed",
        CurrentValue = false,
        Flag = "WalkSpeedToggle",
        Callback = function(Value)
            walkSpeedEnabled = Value
            -- [WalkSpeed logic...]
        end,
    })

    -- JumpPower
    local jumpPowerEnabled = false
    local defaultJumpPower = 50
    local currentJumpPower = 100

    MovementSection:CreateToggle({
        Name = "JumpPower",
        CurrentValue = false,
        Flag = "JumpPowerToggle",
        Callback = function(Value)
            jumpPowerEnabled = Value
            -- [JumpPower logic...]
        end,
    })
end
