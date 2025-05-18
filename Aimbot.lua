local Aimbot = {}

function Aimbot.Init(tab)
    -- Aimbot Variables
    local aimbotEnabled = false
    local lockedPart = nil
    local connection = nil
    local mouseButton2DownConnection = nil
    local mouseButton2UpConnection = nil

    -- FOV Circle Variables
    local fovCircleEnabled = false
    local fovCircleRadius = 100
    local fovCircle
    local fovCircleVisible = false

    -- Create the FOV circle function
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

    -- FOV Circle Toggle
    local FOVCircleToggle = tab:CreateToggle({
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
    local FOVRadiusSlider = tab:CreateSlider({
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

    -- Aimbot Button
    local AimbotButton = tab:CreateButton({
       Name = "Aimbot Toggle",
       Callback = function()
          aimbotEnabled = not aimbotEnabled
          
          if aimbotEnabled then
             Rayfield:Notify({
                Title = "Aimbot Enabled",
                Content = "Hold MB2 to lock onto heads",
                Duration = 3,
                Image = nil
             })
             
             local player = game:GetService("Players").LocalPlayer
             local mouse = player:GetMouse()
             local camera = workspace.CurrentCamera
             
             -- Disconnect previous connections if they exist
             if mouseButton2DownConnection then mouseButton2DownConnection:Disconnect() end
             if mouseButton2UpConnection then mouseButton2UpConnection:Disconnect() end
             if connection then connection:Disconnect() end
             
             mouseButton2DownConnection = mouse.Button2Down:Connect(function()
                local closestDistance = math.huge
                local closestHead = nil
                local playerPosition = camera.CFrame.Position
                
                for _, otherPlayer in ipairs(game:GetService("Players"):GetPlayers()) do
                   if otherPlayer ~= player and otherPlayer.Character and otherPlayer.Character:FindFirstChild("Humanoid") and otherPlayer.Character.Humanoid.Health > 0 then
                      local head = otherPlayer.Character:FindFirstChild("Head")
                      if head then
                         local screenPoint, onScreen = camera:WorldToViewportPoint(head.Position)
                         local distance = (head.Position - playerPosition).Magnitude
                         
                         -- Check if within FOV circle if enabled
                         if fovCircleEnabled then
                            local screenPoint = camera:WorldToViewportPoint(head.Position)
                            if screenPoint.Z > 0 then -- Only if in front of camera
                                local screenPos = Vector2.new(screenPoint.X, screenPoint.Y)
                                local circleCenter = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
                                local distanceFromCenter = (screenPos - circleCenter).Magnitude
                                if distanceFromCenter > fovCircleRadius then
                                   continue -- Skip if outside FOV circle
                                end
                            else
                                continue -- Skip if behind camera
                            end
                         end
                         
                         if onScreen and distance < closestDistance then
                            closestDistance = distance
                            closestHead = head
                         end
                      end
                   end
                end
                
                if closestHead then
                   lockedPart = closestHead
                   connection = game:GetService("RunService").RenderStepped:Connect(function()
                      if lockedPart and lockedPart.Parent and lockedPart.Parent:FindFirstChild("Humanoid") and lockedPart.Parent.Humanoid.Health > 0 then
                         -- Smooth aiming
                         local currentCFrame = camera.CFrame
                         local targetPosition = lockedPart.Position
                         local newCFrame = CFrame.new(currentCFrame.Position, targetPosition)
                         camera.CFrame = newCFrame:Lerp(newCFrame, 0.7) -- Adjust the lerp value for smoother/stiffer aiming
                      else
                         if connection then connection:Disconnect() end
                         lockedPart = nil
                      end
                   end)
                end
             end)
             
             mouseButton2UpConnection = mouse.Button2Up:Connect(function()
                if connection then connection:Disconnect() end
                lockedPart = nil
             end)
          else
             -- Clean up when disabling
             if connection then connection:Disconnect() end
             if mouseButton2DownConnection then mouseButton2DownConnection:Disconnect() end
             if mouseButton2UpConnection then mouseButton2UpConnection:Disconnect() end
             lockedPart = nil
             Rayfield:Notify({
                Title = "Aimbot Disabled",
                Content = "Aimbot is now off",
                Duration = 3,
                Image = nil
             })
          end
       end
    })
end

return Aimbot
