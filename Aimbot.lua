-- Aimbot module using compatibility layer
return function()
    local AimbotSection = CreateUIElement(MainTab, "Section", "Aimbot Settings")
    
    -- Aimbot state
    local aimbot = {
        Enabled = false,
        TeamCheck = false,
        FOV = {
            Show = false,
            Radius = 100,
            Circle = nil
        }
    }

    -- Create UI elements
    CreateUIElement(AimbotSection, "Toggle", {
        Name = "Team Check",
        CurrentValue = aimbot.TeamCheck,
        Callback = function(val) aimbot.TeamCheck = val end
    })

    CreateUIElement(AimbotSection, "Toggle", {
        Name = "Show FOV",
        CurrentValue = aimbot.FOV.Show,
        Callback = function(val)
            aimbot.FOV.Show = val
            -- FOV circle logic here
        end
    })

    CreateUIElement(AimbotSection, "Slider", {
        Name = "FOV Radius",
        Range = {50, 300},
        Increment = 5,
        CurrentValue = aimbot.FOV.Radius,
        Callback = function(val)
            aimbot.FOV.Radius = val
            -- Update FOV circle
        end
    })

    CreateUIElement(AimbotSection, "Button", {
        Name = "Toggle Aimbot",
        Callback = function()
            aimbot.Enabled = not aimbot.Enabled
            -- Aimbot logic here
        end
    })
end
