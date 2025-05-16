return function(Rayfield, Window, MainTab)
    -- Section setup
    local AimbotSection = MainTab:CreateSection("Aimbot", "Advanced targeting system")

    -- State management
    local Aimbot = {
        Enabled = false,
        TeamCheck = false,
        FOV = {
            Enabled = false,
            Radius = 100,
            Circle = nil,
            Visible = false
        },
        Connections = {}
    }

    -- FOV Circle rendering
    local function UpdateFOV()
        if Aimbot.FOV.Circle then
            Aimbot.FOV.Circle:Remove()
        end

        if not Aimbot.FOV.Enabled then return end

        local camera = workspace.CurrentCamera
        Aimbot.FOV.Circle = Drawing.new("Circle")
        Aimbot.FOV.Circle.Visible = Aimbot.FOV.Visible
        Aimbot.FOV.Circle.Thickness = 2
        Aimbot.FOV.Circle.Color = Color3.fromRGB(170, 0, 255)
        Aimbot.FOV.Circle.Transparency = 1
        Aimbot.FOV.Circle.Filled = false
        Aimbot.FOV.Circle.Radius = Aimbot.FOV.Radius
        Aimbot.FOV.Circle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)

        table.insert(Aimbot.Connections, game:GetService("RunService").RenderStepped:Connect(function()
            if Aimbot.FOV.Circle and camera then
                Aimbot.FOV.Circle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
            end
        end))
    end

    -- UI Elements
    AimbotSection:CreateToggle({
        Name = "Team Check",
        CurrentValue = Aimbot.TeamCheck,
        Callback = function(Value)
            Aimbot.TeamCheck = Value
        end
    })

    AimbotSection:CreateToggle({
        Name = "FOV Circle",
        CurrentValue = Aimbot.FOV.Enabled,
        Callback = function(Value)
            Aimbot.FOV.Enabled = Value
            Aimbot.FOV.Visible = Value
            UpdateFOV()
        end
    })

    AimbotSection:CreateSlider({
        Name = "FOV Radius",
        Range = {50, 300},
        Increment = 5,
        Suffix = "px",
        CurrentValue = Aimbot.FOV.Radius,
        Callback = function(Value)
            Aimbot.FOV.Radius = Value
            if Aimbot.FOV.Circle then
                Aimbot.FOV.Circle.Radius = Value
            end
        end
    })

    -- Main toggle button
    AimbotSection:CreateButton({
        Name = "Toggle Aimbot",
        Callback = function()
            Aimbot.Enabled = not Aimbot.Enabled
            
            if Aimbot.Enabled then
                -- Activate aimbot logic
                Window:Notify({
                    Title = "Aimbot Enabled",
                    Content = "Right-click to lock onto targets",
                    Duration = 3
                })
                
                -- [Actual aimbot implementation would go here]
            else
                -- Cleanup
                for _, conn in pairs(Aimbot.Connections) do
                    pcall(function() conn:Disconnect() end)
                end
                Aimbot.Connections = {}
                
                if Aimbot.FOV.Circle then
                    Aimbot.FOV.Circle:Remove()
                    Aimbot.FOV.Circle = nil
                end
                
                Window:Notify({
                    Title = "Aimbot Disabled",
                    Content = "Targeting system off",
                    Duration = 3
                })
            end
        end
    })

    -- Cleanup on script termination
    table.insert(Aimbot.Connections, Window:AddUnloadCallback(function()
        if Aimbot.FOV.Circle then
            Aimbot.FOV.Circle:Remove()
        end
        for _, conn in pairs(Aimbot.Connections) do
            pcall(function() conn:Disconnect() end)
        end
    end))

    print("[Aimbot] Module initialized")
end
