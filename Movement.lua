return function(Rayfield, Window, MainTab, MovementTab)
    -- Section setup
    local MovementSection = MovementTab:CreateSection("Movement", "Enhanced mobility options")

    -- Movement State
    local Movement = {
        WalkSpeed = {
            Enabled = false,
            Value = 50,
            Default = 16
        },
        JumpPower = {
            Enabled = false,
            Value = 100,
            Default = 50
        },
        InfiniteJump = {
            Enabled = false
        },
        Connections = {}
    }

    -- Apply movement modifications
    local function UpdateMovement()
        local character = game:GetService("Players").LocalPlayer.Character
        if not character then return end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then return end

        if Movement.WalkSpeed.Enabled then
            humanoid.WalkSpeed = Movement.WalkSpeed.Value
        else
            humanoid.WalkSpeed = Movement.WalkSpeed.Default
        end

        if Movement.JumpPower.Enabled then
            humanoid.JumpPower = Movement.JumpPower.Value
        else
            humanoid.JumpPower = Movement.JumpPower.Default
        end
    end

    -- Infinite jump handler
    local function UpdateInfiniteJump()
        for _, conn in pairs(Movement.Connections) do
            pcall(function() conn:Disconnect() end)
        end
        Movement.Connections = {}

        if Movement.InfiniteJump.Enabled then
            table.insert(Movement.Connections, game:GetService("UserInputService").JumpRequest:Connect(function()
                local character = game:GetService("Players").LocalPlayer.Character
                if character then
                    local humanoid = character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end))
        end
    end

    -- UI Elements
    MovementSection:CreateToggle({
        Name = "WalkSpeed",
        CurrentValue = Movement.WalkSpeed.Enabled,
        Callback = function(Value)
            Movement.WalkSpeed.Enabled = Value
            UpdateMovement()
        end
    })

    MovementSection:CreateSlider({
        Name = "WalkSpeed Value",
        Range = {16, 200},
        Increment = 1,
        Suffix = "studs/s",
        CurrentValue = Movement.WalkSpeed.Value,
        Callback = function(Value)
            Movement.WalkSpeed.Value = Value
            if Movement.WalkSpeed.Enabled then
                UpdateMovement()
            end
        end
    })

    MovementSection:CreateToggle({
        Name = "JumpPower",
        CurrentValue = Movement.JumpPower.Enabled,
        Callback = function(Value)
            Movement.JumpPower.Enabled = Value
            UpdateMovement()
        end
    })

    MovementSection:CreateSlider({
        Name = "JumpPower Value",
        Range = {50, 200},
        Increment = 5,
        Suffix = "power",
        CurrentValue = Movement.JumpPower.Value,
        Callback = function(Value)
            Movement.JumpPower.Value = Value
            if Movement.JumpPower.Enabled then
                UpdateMovement()
            end
        end
    })

    MovementSection:CreateToggle({
        Name = "Infinite Jump",
        CurrentValue = Movement.InfiniteJump.Enabled,
        Callback = function(Value)
            Movement.InfiniteJump.Enabled = Value
            UpdateInfiniteJump()
        end
    })

    -- Character tracking
    table.insert(Movement.Connections, game:GetService("Players").LocalPlayer.CharacterAdded:Connect(function(character)
        task.wait(0.5) -- Wait for character to fully load
        Update
