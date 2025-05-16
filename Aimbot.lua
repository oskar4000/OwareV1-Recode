return function(Rayfield, Window, MainTab)
    local AimbotSection = MainTab:CreateSection("Aimbot")

    -- Aimbot Variables
    local aimbotEnabled = false
    local lockedPart = nil
    local connection = nil
    local mouseButton2DownConnection = nil
    local mouseButton2UpConnection = nil
    local teamCheckEnabled = false

    -- FOV Circle
    local fovCircleEnabled = false
    local fovCircleRadius = 100
    local fovCircle
    local fovCircleVisible = false

    local function createFOVCircle()
        if fovCircle then fovCircle:Remove() end
        
        local camera = workspace.CurrentCamera
        fovCircle = Drawing.new("Circle")
        fovCircle.Visible = fovCircleVisible
        fovCircle.Thickness = 2
        fovCircle.Color = Color3.fromRGB(170, 0, 255)
        fovCircle.Transparency = 1
        fovCircle.Filled = false
        fovCircle.Radius = fovCircleRadius
        fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
        
        game:GetService("RunService").RenderStepped:Connect(function()
            if fovCircle then
                fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                fovCircle.Radius = fovCircleRadius
            end
        end)
    end

    -- Team Check Toggle
    local TeamCheckToggle = AimbotSection:CreateToggle({
        Name = "Team Check",
        CurrentValue = false,
        Flag = "TeamCheckToggle",
        Callback = function(Value)
            teamCheckEnabled = Value
        end,
    })

    -- FOV Circle Toggle
    local FOVCircleToggle = AimbotSection:CreateToggle({
        Name = "FOV Circle",
        CurrentValue = false,
        Flag = "Toggle1",
        Callback = function(Value)
            fovCircleEnabled = Value
            fovCircleVisible = Value
            if Value then
                createFOVCircle()
            else
                if fovCircle then
                    fovCircle:Remove()
                    fovCircle = nil
                end
            end
        end,
    })

    -- FOV Radius Slider
    local FOVRadiusSlider = AimbotSection:CreateSlider({
        Name = "FOV Circle Radius",
        Range = {50, 300},
        Increment = 10,
        Suffix = "px",
        CurrentValue = 100,
        Flag = "Slider1",
        Callback = function(Value)
            fovCircleRadius = Value
            if fovCircle then
                fovCircle.Radius = Value
            end
        end,
    })

    -- Aimbot Toggle
    AimbotSection:CreateButton({
        Name = "Aimbot Toggle",
        Callback = function()
            aimbotEnabled = not aimbotEnabled
            -- [Rest of your aimbot code...]
        end
    })
end
