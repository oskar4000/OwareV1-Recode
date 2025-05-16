return function(Rayfield, Window, MainTab)
    -- Section setup
    local ESPSection = MainTab:CreateSection("ESP", "Player visualization system")

    -- ESP State
    local ESP = {
        Enabled = false,
        TeamESP = false,
        Color = Color3.fromRGB(170, 0, 255),
        TeamColor = Color3.fromRGB(0, 170, 255),
        Highlights = {},
        TeamHighlights = {}
    }

    -- Highlight management
    local function UpdateHighlights()
        -- Cleanup existing highlights
        for _, highlight in pairs(ESP.Highlights) do
            pcall(function() highlight:Destroy() end)
        end
        for _, highlight in pairs(ESP.TeamHighlights) do
            pcall(function() highlight:Destroy() end)
        end
        ESP.Highlights = {}
        ESP.TeamHighlights = {}

        -- Don't create new highlights if ESP is disabled
        if not ESP.Enabled and not ESP.TeamESP then return end

        -- Create new highlights
        local players = game:GetService("Players"):GetPlayers()
        local localPlayer = game:GetService("Players").LocalPlayer

        for _, player in ipairs(players) do
            if player ~= localPlayer and player.Character then
                local highlight = Instance.new("Highlight")
                highlight.Name = player.Name .. "_Highlight"
                
                if ESP.TeamESP and player.Team == localPlayer.Team then
                    highlight.FillColor = ESP.TeamColor
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = player.Character
                    ESP.TeamHighlights[player] = highlight
                elseif ESP.Enabled then
                    highlight.FillColor = ESP.Color
                    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                    highlight.Parent = player.Character
                    ESP.Highlights[player] = highlight
                end
            end
        end
    end

    -- UI Elements
    ESPSection:CreateToggle({
        Name = "ESP",
        CurrentValue = ESP.Enabled,
        Callback = function(Value)
            ESP.Enabled = Value
            UpdateHighlights()
        end
    })

    ESPSection:CreateToggle({
        Name = "Team ESP",
        CurrentValue = ESP.TeamESP,
        Callback = function(Value)
            ESP.TeamESP = Value
            UpdateHighlights()
        end
    })

    ESPSection:CreateColorPicker({
        Name = "ESP Color",
        Color = ESP.Color,
        Callback = function(Value)
            ESP.Color = Value
            for _, highlight in pairs(ESP.Highlights) do
                pcall(function() highlight.FillColor = Value end)
            end
        end
    })

    ESPSection:CreateColorPicker({
        Name = "Team Color",
        Color = ESP.TeamColor,
        Callback = function(Value)
            ESP.TeamColor = Value
            for _, highlight in pairs(ESP.TeamHighlights) do
                pcall(function() highlight.FillColor = Value end)
            end
        end
    })

    -- Player tracking
    table.insert(ESP.Connections, game:GetService("Players").PlayerAdded:Connect(function(player)
        player.CharacterAdded:Connect(function(character)
            if ESP.Enabled or ESP.TeamESP then
                task.wait(1) -- Wait for character to fully load
                UpdateHighlights()
            end
        end)
    end))

    -- Initial setup
    for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
        if player.Character then
            player.CharacterAdded:Connect(function(character)
                if ESP.Enabled or ESP.TeamESP then
                    task.wait(1)
                    UpdateHighlights()
                end
            end)
        end
    end

    -- Cleanup
    table.insert(ESP.Connections, Window:AddUnloadCallback(function()
        UpdateHighlights() -- This will clear all highlights
    end))

    print("[ESP] Module initialized")
end
