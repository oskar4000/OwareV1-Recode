--[[
    OwareV1 Ultimate Loader
    With multiple UI library fallbacks and complete error handling
--]]

local function SafeDestroyUI()
    pcall(function()
        if game:GetService("CoreGui"):FindFirstChild("Rayfield") then
            game:GetService("CoreGui").Rayfield:Destroy()
        end
        if game:GetService("CoreGui"):FindFirstChild("Sirius") then
            game:GetService("CoreGui").Sirius:Destroy()
        end
    end)
    task.wait(0.5)
end

local function ShowErrorNotification(message)
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "OwareV1 Error",
            Text = message,
            Duration = 5
        })
    end)
    warn("[OwareV1 Error]", message)
end

-- Attempt to load UI library with multiple fallbacks
local Rayfield
local UI_LIBRARIES = {
    "https://sirius.menu/rayfield",
    "https://raw.githubusercontent.com/shlexware/Rayfield/release/source.lua",
    "https://raw.githubusercontent.com/sirius-uwu/sirius-uwu/main/sirius.lua"
}

for _, url in ipairs(UI_LIBRARIES) do
    local success, result = pcall(function()
        SafeDestroyUI()
        local response = game:HttpGet(url, true)
        if not response then error("Empty response") end
        return loadstring(response)()
    end)
    
    if success and result then
        Rayfield = result
        break
    else
        warn("[OwareV1] Failed to load from", url, ":", result)
    end
end

if not Rayfield then
    ShowErrorNotification("All UI libraries failed to load")
    return
end

-- Create main window with protected calls
local Window
local success, err = pcall(function()
    Window = Rayfield:CreateWindow({
        Name = "👽 OwareV1 👽",
        LoadingTitle = "Loading Cheat Suite",
        LoadingSubtitle = "Initializing modules...",
        ConfigurationSaving = {
            Enabled = false, -- Disabled for stability
        },
        KeySystem = false, -- Disabled for reliability
        MainColor = Color3.fromRGB(170, 0, 255),
        BackgroundColor = Color3.fromRGB(25, 25, 25),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(600, 400)
    })
end)

if not success or not Window then
    ShowErrorNotification("Failed to create window: "..tostring(err))
    return
end

-- Create status display
local StatusTab = Window:CreateTab("Status")
local StatusSection = StatusTab:CreateSection("System Status")
local StatusLabel = StatusSection:CreateLabel("Initializing...")

local function UpdateStatus(text)
    pcall(function()
        StatusLabel:Set(text)
        print("[Status]", text)
    end)
    task.wait()
end

-- Enhanced module loader
local function LoadModule(name, url)
    UpdateStatus("Downloading "..name.."...")
    
    local success, err = pcall(function()
        -- Download with timeout
        local code
        for _ = 1, 3 do -- Retry up to 3 times
            local downloadSuccess, downloadErr = pcall(function()
                code = game:HttpGet(url, true)
                if not code then error("Empty response") end
            end)
            if downloadSuccess then break end
            warn("Download attempt failed:", downloadErr)
            task.wait(1)
        end
        
        if not code then error("Failed after 3 attempts") end
        
        -- Compile
        local fn, compileErr = loadstring(code)
        if not fn then error(compileErr) end
        
        -- Execute
        UpdateStatus("Initializing "..name.."...")
        return fn(Rayfield, Window)
    end)
    
    if not success then
        UpdateStatus(name.." failed!")
        warn(name.." error:", err)
        pcall(function()
            Window:Notify({
                Title = name.." Error",
                Content = string.sub(tostring(err), 1, 100),
                Duration = 6
            })
        end)
        return false
    end
    
    UpdateStatus(name.." loaded successfully")
    return true
end

-- Module loading sequence
task.spawn(function()
    local MODULES = {
        {name = "Aimbot", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Aimbot.lua"},
        {name = "ESP", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/ESP.lua"},
        {name = "Misc", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Misc.lua"},
        {name = "Movement", url = "https://raw.githubusercontent.com/oskar4000/OwareV1-Recode/main/Movement.lua"}
    }
    
    for _, module in ipairs(MODULES) do
        LoadModule(module.name, module.url)
        task.wait(1) -- Rate limiting
    end
    
    UpdateStatus("All modules loaded!")
    pcall(function()
        Window:Notify({
            Title = "OwareV1 Ready",
            Content = "Cheat suite initialized",
            Duration = 5
        })
    end)
end)

-- Final activation
pcall(function()
    Window:BringToFront()
    Window:Show()
end)

print("[OwareV1] Loader initialized successfully")
