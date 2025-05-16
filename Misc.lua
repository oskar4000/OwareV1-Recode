return function(Rayfield, Window, MainTab)
    local MiscSection = MainTab:CreateSection("Misc")

    -- Spin Bot
    local spinBotEnabled = false
    local spinBotSpeed = 10
    local spinBotConnection = nil

    MiscSection:CreateToggle({
        Name = "Spin Bot",
        CurrentValue = false,
        Flag = "Toggle5",
        Callback = function(Value)
            spinBotEnabled = Value
            -- [Spin bot logic...]
        end,
    })

    -- FOV Changer
    local fovChangerEnabled = false
    local defaultFOV = 70
    local currentFOV = 70

    MiscSection:CreateToggle({
        Name = "FOV Changer",
        CurrentValue = false,
        Flag = "Toggle4",
        Callback = function(Value)
            fovChangerEnabled = Value
            -- [FOV changer logic...]
        end,
    })
end
