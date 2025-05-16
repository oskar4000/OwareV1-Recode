----------------
-- ESP SECTION --
----------------
local ESPSection = MainTab:CreateSection("ESP")

-- ESP Variables
local espEnabled = false
local teamEspEnabled = false -- Added team ESP variable
local highlights = {}
local teamHighlights = {} -- Added team highlights table
local espColor = Color3.fromRGB(170, 0, 255) -- Default purple color
local teamEspColor = Color3.fromRGB(0, 170, 255) -- Default blue color for team ESP

local function highlightPlayer(player)
    if not espEnabled or player == game.Players.LocalPlayer then return end
    
    -- Skip if team ESP is enabled and player is on our team
    if teamEspEnabled and player.Team == game.Players.LocalPlayer.Team then
        return
    end
    
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

local function highlightTeamPlayer(player)
    if not teamEspEnabled or player == game.Players.LocalPlayer then return end
    
    -- Only highlight if on our team
    if player.Team ~= game.Players.LocalPlayer.Team then
        return
    end
    
    local character = player.Character
    if not character then
        player.CharacterAdded:Connect(function(char)
            highlightTeamPlayer(player)
        end)
        return
    end
    
    if teamHighlights[player] then teamHighlights[player]:Destroy() end
    
    local highlight = Instance.new("Highlight")
    highlight.Name = "TeamPlayerHighlight"
    highlight.FillColor = teamEspColor
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.FillTransparency = 0.5
    highlight.Parent = character
    teamHighlights[player] = highlight
    
    player.CharacterAdded:Connect(function(newChar)
        if teamEspEnabled then
            task.wait(1)
            highlightTeamPlayer(player)
        end
    end)
end

local function removeHighlights()
    for player, highlight in pairs(highlights) do
        if highlight then highlight:Destroy() end
    end
    highlights = {}
    
    for player, highlight in pairs(teamHighlights) do
        if highlight then highlight:Destroy() end
    end
    teamHighlights = {}
end

local function updateHighlightColors()
    for player, highlight in pairs(highlights) do
        if highlight and highlight:IsA("Highlight") then
            highlight.FillColor = espColor
        end
    end
    
    for player, highlight in pairs(teamHighlights) do
        if highlight and highlight:IsA("Highlight") then
            highlight.FillColor = teamEspColor
        end
    end
end

-- ESP Toggle Button
local EspButton = MainTab:CreateButton({
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

-- Team ESP Toggle Button
local TeamEspButton = MainTab:CreateButton({
   Name = "Team ESP Toggle",
   Callback = function()
      teamEspEnabled = not teamEspEnabled
      
      if teamEspEnabled then
         for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            highlightTeamPlayer(player)
         end
         game:GetService("Players").PlayerAdded:Connect(highlightTeamPlayer)
         Rayfield:Notify({
            Title = "Team ESP Enabled",
            Content = "Teammates are now highlighted",
            Duration = 3,
            Image = nil
         })
      else
         for player, highlight in pairs(teamHighlights) do
            if highlight then highlight:Destroy() end
         end
         teamHighlights = {}
         Rayfield:Notify({
            Title = "Team ESP Disabled",
            Content = "Teammate highlights removed",
            Duration = 3,
            Image = nil
         })
      end
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
