return function(Rayfield, Window)
    local MainTab = Window:CreateTab("💢Main💢", nil)
    
    ----------------
    -- ESP SECTION --
    ----------------
    local ESPSection = MainTab:CreateSection("ESP")

    -- ESP Variables
    local espEnabled = false
    local teamEspEnabled = false
    local highlights = {}
    local teamHighlights = {}
    local espColor = Color3.fromRGB(170, 0, 255)
    local teamEspColor = Color3.fromRGB(0, 170, 255)

    -- ... [keep all your existing ESP functions here] ...

    -- ESP Toggle Button
    local EspButton = MainTab:CreateButton({
       Name = "ESP Toggle",
       Callback = function()
          -- ... [keep your existing callback] ...
       end
    })

    -- Team ESP Toggle Button
    local TeamEspButton = MainTab:CreateButton({
       Name = "Team ESP Toggle",
       Callback = function()
          -- ... [keep your existing callback] ...
       end
    })

    -- ESP Color Picker
    local EspColorPicker = MainTab:CreateColorPicker({
        Name = "ESP Color",
        Color = espColor,
        Flag = "ESPColorPicker",
        Callback = function(Value)
            espColor = Value
            updateHighlightColors()
        end
    })

    -- Team ESP Color Picker
    local TeamEspColorPicker = MainTab:CreateColorPicker({
        Name = "Team ESP Color",
        Color = teamEspColor,
        Flag = "TeamESPColorPicker",
        Callback = function(Value)
            teamEspColor = Value
            updateHighlightColors()
        end
    })
end
