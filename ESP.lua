local ESP = {}

function ESP.Init(tab)
    -- ESP Variables
    local espEnabled = false
    local highlights = {}
    local espColor = Color3.fromRGB(170, 0, 255) -- Default purple color

    local function highlightPlayer(player)
        if not espEnabled or player == game.Players.LocalPlayer then return end
        
        local character = player.Character
        if not character then
            player.CharacterAdded:Connect(function(char)
                highlightPlayer(player)
            end)
            return
        end
        
        if highlights[player] then highlights[player]:Destroy() end
        
        local highlight = Instance.new("Highlight")
        highlight.Name = "PlayerHighlight"
        highlight.FillColor = espColor
        highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.FillTransparency = 0.5
        highlight.Parent = character
        highlights[player] = highlight
        
        player.CharacterAdded:Connect(function(newChar)
            if espEnabled then
                task.wait(1)
                highlightPlayer(player)
            end
        end)
    end

    local function removeHighlights()
        for player, highlight in pairs(highlights) do
            if highlight then highlight:Destroy() end
        end
        highlights = {}
    end

    local function updateHighlightColors()
        for player, highlight in pairs(highlights) do
            if highlight and highlight:IsA("Highlight") then
                highlight.FillColor = espColor
            end
        end
    end

    -- ESP Toggle Button
    local EspButton = tab:CreateButton({
       Name = "ESP Toggle",
       Callback = function()
          espEnabled = not espEnabled
          
          if espEnabled then
             for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
                highlightPlayer(player)
             end
             game:GetService("Players").PlayerAdded:Connect(highlightPlayer)
             Rayfield:Notify({
                Title = "ESP Enabled",
                Content = "Players are now highlighted",
                Duration = 3,
                Image = nil
             })
          else
             removeHighlights()
             Rayfield:Notify({
                Title = "ESP Disabled",
                Content = "Player highlights removed",
                Duration = 3,
                Image = nil
             })
          end
       end
    })

    -- ESP Color Picker
    local EspColorPicker = tab:CreateColorPicker({
        Name = "ESP Color",
        Color = espColor,
        Flag = "ESPColorPicker",
        Callback = function(Value)
            espColor = Value
            updateHighlightColors()
        end
    })
end

return ESP
