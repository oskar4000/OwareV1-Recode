return function(Rayfield, Window)
    local MainTab = Window:CreateTab("💢Main💢", nil)
    
    -----------------
    -- MISC SECTION --
    -----------------
    local MiscSection = MainTab:CreateSection("Misc")

    -- Spin Bot Variables
    local spinBotEnabled = false
    local spinBotSpeed = 10
    local spinBotConnection = nil

    -- Spin Bot Toggle
    local SpinBotToggle = MainTab:CreateToggle({
       Name = "Spin Bot",
       CurrentValue = false,
       Flag = "Toggle5",
       Callback = function(Value)
           -- ... (keep all the same callback code)
       end,
    })

    -- Spin Bot Speed Slider
    local SpinBotSpeedSlider = MainTab:CreateSlider({
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
    local FOVChangerToggle = MainTab:CreateToggle({
       Name = "FOV Changer",
       CurrentValue = false,
       Flag = "Toggle4",
       Callback = function(Value)
           -- ... (keep all the same callback code)
       end,
    })

    -- FOV Value Slider
    local FOVSlider = MainTab:CreateSlider({
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
