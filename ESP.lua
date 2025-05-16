return function(Rayfield, Window, MainTab)
    local ESPSection = MainTab:CreateSection("ESP")

    -- ESP Variables
    local espEnabled = false
    local teamEspEnabled = false
    local highlights = {}
    local teamHighlights = {}
    local espColor = Color3.fromRGB(170, 0, 255)
    local teamEspColor = Color3.fromRGB(0, 170, 255)

    -- [Include all your ESP functions here...]
    
    -- ESP Toggle
    ESPSection:CreateButton({
        Name = "ESP Toggle",
        Callback = function()
            espEnabled = not espEnabled
            -- [Your ESP toggle logic...]
        end
    })

    -- ESP Color Picker
    ESPSection:CreateColorPicker({
        Name = "ESP Color",
        Color = espColor,
        Callback = function(Value)
            espColor = Value
            -- [Update highlights...]
        end
    })
end
