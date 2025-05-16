return function(Rayfield, Window, MainTab)
    local MiscSection = MainTab:CreateSection("Miscellaneous")

    -- Spin Bot
    local spinBot = {
        Enabled = false,
        Speed = 10,
        Connection = nil
    }

    local function updateSpinBot()
        if spinBot.Connection then
            spinBot.Connection:Disconnect()
            spinBot.Connection = nil
        end

        if spinBot.Enabled then
            spinBot.Connection = game:GetService("RunService").RenderStepped:Connect(function(delta)
                local character = game.Players.LocalPlayer.Character
                if character then
                    local root = character:FindFirstChild("HumanoidRootPart")
                    if root then
                        root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(spinBot.Speed * 360 * delta), 0)
                    end
                end
            end)
        end
    end

    MiscSection:CreateToggle({
        Name = "Spin Bot",
        CurrentValue = spinBot.Enabled,
        Callback = function(Value)
            spinBot.Enabled = Value
            updateSpinBot()
            Rayfield:Notify({
                Title = "Spin Bot "..(Value and "Enabled" or "Disabled"),
                Content = Value and "Your character is now spinning" or "Spin bot deactivated",
                Duration = 3
            })
        end
    })

    MiscSection:CreateSlider({
        Name = "Spin Speed",
        Range = {1, 30},
        Increment = 1,
        Suffix = "rotations/sec",
        CurrentValue = spinBot.Speed,
        Callback = function(Value)
            spinBot.Speed = Value
            if spinBot.Enabled then
                updateSpinBot()
            end
        end
    })

    -- FOV Changer
    local fovChanger = {
        Enabled = false,
        Value = 70,
        Default = 70,
        Changed = false
    }

    local function updateFOV()
        local camera = workspace.CurrentCamera
        if camera then
            camera.FieldOfView = fovChanger.Enabled and fovChanger.Value or fovChanger.Default
            fovChanger.Changed = fovChanger.Enabled
        end
    end

    MiscSection:CreateToggle({
        Name = "FOV Changer",
        CurrentValue = fovChanger.Enabled,
        Callback = function(Value)
            fovChanger.Enabled = Value
            updateFOV()
            Rayfield:Notify({
                Title = "FOV Changer "..(Value and "Enabled" or "Disabled"),
                Content = Value and string.format("FOV set to %d", fovChanger.Value) or "FOV reset to default",
                Duration = 3
            })
        end
    })

    MiscSection:CreateSlider({
        Name = "FOV Value",
        Range = {50, 120},
        Increment = 5,
        Suffix = "°",
        CurrentValue = fovChanger.Value,
        Callback = function(Value)
            fovChanger.Value = Value
            if fovChanger.Enabled then
                updateFOV()
            end
        end
    })

    -- Character added event
    game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
        if not fovChanger.Changed then
            task.wait(0.5)
            local camera = workspace.CurrentCamera
            if camera then
                camera.FieldOfView = fovChanger.Default
            end
        end
    end)

    -- Cleanup
    Window:AddUnloadCallback(function()
        if spinBot.Connection then
            spinBot.Connection:Disconnect()
        end
        
        local camera = workspace.CurrentCamera
        if camera then
            camera.FieldOfView = fovChanger.Default
        end
    end)
end
