-- Clear previous UI if exists
if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
    game:GetService("CoreGui").Rayfield:Destroy()
    task.wait(0.5)
end

-- Load Rayfield with fallback
local Rayfield
local success, err = pcall(function()
    Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
    if not Rayfield then
        Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/release/source.lua'))()
    end
end)

if not success or not Rayfield then
    warn("Failed to load Rayfield:", err)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "OwareV1 Error",
        Text = "Failed to load UI library",
        Duration = 5
    })
    return
end

-- Create main window
local Window = Rayfield:CreateWindow({
    Name = "👽 OwareV1 👽",
    LoadingTitle = "Loading OwareV1",
    LoadingSubtitle = "by 0skar12345_86784",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "OwareConfig",
        FileName = "OwareSettings"
    },
    KeySystem = false, -- Disabled for testing
    MainColor = Color3.fromRGB(170, 0, 255),
    Position = UDim2.fromScale(0.5, 0.5)
})

-- Create main tab
local MainTab = Window:CreateTab("Main")
local MoveTab = Window:CreateTab("Movement")

-- Load modules with error handling
local function LoadModule(name, url)
    local success, err = pcall(function()
        local code = game:HttpGet(url, true)
        if not code then error("Empty response") end
        
        local fn = loadstring(code)
        if not fn then error("Compilation failed") end
        
        return fn(Rayfield, Window, MainTab, MoveTab)
    end)
    
    if not success then
        warn("Failed to load", name, ":", err)
        Rayfield:Notify({
            Title = name.." Error",
            Content = tostring(err),
            Duration = 6
        })
    end
end

-- Load all modules
task.spawn(function()
    LoadModule("Aimbot", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Aimbot.lua")
    task.wait(1)
    LoadModule("ESP", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/ESP.lua")
    task.wait(1)
    LoadModule("Misc", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Misc.lua")
    task.wait(1)
    LoadModule("Movement", "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Movement.lua")
end)

Window:Notify({
    Title = "OwareV1 Loaded",
    Content = "All features initialized",
    Duration = 5
})
